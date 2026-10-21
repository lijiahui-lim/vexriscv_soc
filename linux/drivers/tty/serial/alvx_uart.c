// SPDX-License-Identifier: GPL-2.0
/*
 * Serial driver for the SpinalHDL Apb3UartCtrl (ALVX SoC).
 *
 * Register map (32-bit):
 *   0x00 DATA   W: push tx byte;  R: bit16=valid, [7:0]=rx data (read pops)
 *   0x04 STATUS R/W: bit0 tx-empty-irq-en, bit1 rx-irq-en;
 *              R: bit8 tx-int pending, bit9 rx-int pending, bit15 tx fifo busy,
 *                 [23:16] tx free entries, [31:24] rx occupancy
 *   0x08 CLOCK_DIVIDER  (uartclk / baud)
 *   0x0C FRAME_CONFIG   [2:0] dataLength-1, [9:8] parity (0=none,1=even,2=odd),
 *                       [16] stop (0=one,1=two)
 *   0x10 MISC     bit0 read err (W1C), bit1 rx overflow (W1C),
 *                 bit8 break level, bit9 break detected (RO)
 */

#include <linux/clk.h>
#include <linux/console.h>
#include <linux/init.h>
#include <linux/io.h>
#include <linux/kfifo.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/serial_core.h>
#include <linux/serial_reg.h>
#include <linux/tty_flip.h>

#define OFF_DATA	0x00
#define OFF_STATUS	0x04
#define OFF_DIV		0x08
#define OFF_FRAME	0x0c
#define OFF_MISC	0x10

#define ST_TXIEN	BIT(0)
#define ST_RXIEN	BIT(1)
#define ST_TXINT	BIT(8)
#define ST_RXINT	BIT(9)
#define ST_TXBUSY	BIT(15)
#define ST_TXFREE(x)	(((x) >> 16) & 0xff)
#define ST_RXOCC(x)	(((x) >> 24) & 0xff)

#define DATA_RXVALID	BIT(16)

#define DRIVER_NAME	"alvx-uart"
#define DEVICE_NAME	"ttyALV"
#define ALVX_UART_NR	1

static struct uart_port alvx_port;
static struct uart_port *alvx_console_port;

static u32 alvx_read(struct uart_port *p, u32 off)
{
	return readl(p->membase + off);
}

static void alvx_write(struct uart_port *p, u32 off, u32 v)
{
	writel(v, p->membase + off);
}

static bool alvx_rx(struct uart_port *p)
{
	struct tty_port *tport = &p->state->port;
	u32 d;
	bool work = false;
	int max = ST_RXOCC(alvx_read(p, OFF_STATUS)) + 8;

	while (max--) {
		d = alvx_read(p, OFF_DATA);
		if (!(d & DATA_RXVALID))
			break;
		work = true;
		p->icount.rx++;
		tty_insert_flip_char(tport, d & 0xff, TTY_NORMAL);
	}
	return work;
}

static bool alvx_tx(struct uart_port *p)
{
	struct tty_port *tport = &p->state->port;
	u8 ch;
	bool work = false;

	while (ST_TXFREE(alvx_read(p, OFF_STATUS)) != 0) {
		if (uart_tx_stopped(p))
			break;
		if (p->x_char) {
			alvx_write(p, OFF_DATA, p->x_char);
			p->x_char = 0;
			p->icount.tx++;
			work = true;
			continue;
		}
		if (!uart_fifo_get(p, &ch))
			break;
		alvx_write(p, OFF_DATA, ch);
		work = true;
	}
	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
		uart_write_wakeup(p);
	return work;
}

static irqreturn_t alvx_irq(int irq, void *dev_id)
{
	struct uart_port *p = dev_id;
	unsigned long flags;
	u32 st;
	bool work = false;

	uart_port_lock_irqsave(p, &flags);
	st = alvx_read(p, OFF_STATUS);
	if (st & ST_RXINT)
		work |= alvx_rx(p);
	if (st & ST_TXINT)
		work |= alvx_tx(p);
	uart_port_unlock_irqrestore(p, flags);

	if (work) {
		tty_flip_buffer_push(&p->state->port);
		return IRQ_HANDLED;
	}
	return IRQ_NONE;
}

static unsigned int alvx_tx_empty(struct uart_port *p)
{
	return (alvx_read(p, OFF_STATUS) & ST_TXBUSY) ? 0 : TIOCSER_TEMT;
}

static void alvx_set_mctrl(struct uart_port *p, unsigned int mctrl) { }

static unsigned int alvx_get_mctrl(struct uart_port *p)
{
	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
}

static void alvx_stop_tx(struct uart_port *p)
{
	alvx_write(p, OFF_STATUS, alvx_read(p, OFF_STATUS) & ~ST_TXIEN);
}

static void alvx_start_tx(struct uart_port *p)
{
	alvx_write(p, OFF_STATUS, alvx_read(p, OFF_STATUS) | ST_TXIEN);
	/* kick the fifo in case the irq is level-triggered empty */
	alvx_tx(p);
}

static void alvx_stop_rx(struct uart_port *p)
{
	alvx_write(p, OFF_STATUS, alvx_read(p, OFF_STATUS) & ~ST_RXIEN);
}

static void alvx_enable_ms(struct uart_port *p) { }

static void alvx_break_ctl(struct uart_port *p, int ctl) { }

static int alvx_startup(struct uart_port *p)
{
	int ret;

	ret = request_irq(p->irq, alvx_irq, 0, DRIVER_NAME, p);
	if (ret)
		return ret;

	alvx_write(p, OFF_MISC, 3);	/* clear latched errors */
	alvx_write(p, OFF_STATUS, ST_RXIEN);
	return 0;
}

static void alvx_shutdown(struct uart_port *p)
{
	alvx_write(p, OFF_STATUS, 0);
	free_irq(p->irq, p);
}

static void alvx_set_termios(struct uart_port *p, struct ktermios *termios,
			     const struct ktermios *old)
{
	unsigned int baud;
	u32 frame;

	termios->c_cflag &= ~(CSIZE | CSTOPB);
	termios->c_cflag |= CS8;

	frame = 7;				/* 8 data bits */
	if (termios->c_cflag & PARENB)
		frame |= ((termios->c_cflag & PARODD) ? 2 : 1) << 8;

	baud = uart_get_baud_rate(p, termios, old, 0,
				  p->uartclk ? p->uartclk / 16 : 9600);
	alvx_write(p, OFF_FRAME, frame);
	if (baud && p->uartclk)
		alvx_write(p, OFF_DIV,
			   DIV_ROUND_CLOSEST(p->uartclk, baud));
	uart_update_timeout(p, termios->c_cflag, baud);
}

static const char *alvx_type(struct uart_port *p)
{
	return DRIVER_NAME;
}

static void alvx_release_port(struct uart_port *p) { }

static int alvx_request_port(struct uart_port *p)
{
	return 0;				/* membase mapped in probe */
}

static void alvx_config_port(struct uart_port *p, int flags) { }

static int alvx_verify_port(struct uart_port *p, struct serial_struct *s)
{
	return 0;
}

static const struct uart_ops alvx_ops = {
	.tx_empty	= alvx_tx_empty,
	.set_mctrl	= alvx_set_mctrl,
	.get_mctrl	= alvx_get_mctrl,
	.stop_tx	= alvx_stop_tx,
	.start_tx	= alvx_start_tx,
	.stop_rx	= alvx_stop_rx,
	.enable_ms	= alvx_enable_ms,
	.break_ctl	= alvx_break_ctl,
	.startup	= alvx_startup,
	.shutdown	= alvx_shutdown,
	.set_termios	= alvx_set_termios,
	.type		= alvx_type,
	.release_port	= alvx_release_port,
	.request_port	= alvx_request_port,
	.config_port	= alvx_config_port,
	.verify_port	= alvx_verify_port,
};

static struct uart_driver alvx_uart_driver;

#ifdef CONFIG_SERIAL_ALVX_CONSOLE
static void alvx_console_putc(struct uart_port *p, unsigned char ch)
{
	while (ST_TXFREE(alvx_read(p, OFF_STATUS)) == 0)
		cpu_relax();
	alvx_write(p, OFF_DATA, ch);
}

static void alvx_console_write(struct console *co, const char *s,
			       unsigned int count)
{
	struct uart_port *p = alvx_console_port;
	unsigned long flags;
	u32 ie;
	int locked = 1;

	if (!p)
		return;

	if (oops_in_progress) {
		locked = uart_port_trylock_irqsave(p, &flags);
	} else
		uart_port_lock_irqsave(p, &flags);

	ie = alvx_read(p, OFF_STATUS) & 3;
	alvx_write(p, OFF_STATUS, ie & ~3);

	uart_console_write(p, s, count, alvx_console_putc);

	while (alvx_read(p, OFF_STATUS) & ST_TXBUSY)
		cpu_relax();

	alvx_write(p, OFF_STATUS, ie);

	if (locked)
		uart_port_unlock_irqrestore(p, flags);
}

static int __init alvx_console_setup(struct console *co, char *opt)
{
	struct uart_port *p = &alvx_port;
	int baud = 115200, bits = 8, parity = 'n', flow = 'n';

	if (co->index < 0 || co->index >= ALVX_UART_NR)
		co->index = 0;
	if (!p->mapbase)
		return -ENODEV;
	if (!p->membase) {
		p->membase = ioremap(p->mapbase, 256);
		if (!p->membase)
			return -ENODEV;
	}
	alvx_console_port = p;

	if (opt)
		uart_parse_options(opt, &baud, &parity, &bits, &flow);
	return uart_set_options(p, co, baud, parity, bits, flow);
}

static struct console alvx_console = {
	.name	= DEVICE_NAME,
	.write	= alvx_console_write,
	.device	= uart_console_device,
	.setup	= alvx_console_setup,
	.flags	= CON_PRINTBUFFER,
	.index	= -1,
	.data	= &alvx_uart_driver,
};
#define ALVX_CONSOLE	(&alvx_console)

static void alvx_early_putc(struct uart_port *p, unsigned char ch)
{
	while (ST_TXFREE(readl(p->membase + OFF_STATUS)) == 0)
		cpu_relax();
	writel(ch, p->membase + OFF_DATA);
}

static void alvx_early_write(struct console *con, const char *s,
			     unsigned int n)
{
	struct earlycon_device *dev = con->data;

	uart_console_write(&dev->port, s, n, alvx_early_putc);
}

static int __init alvx_early_setup(struct earlycon_device *dev,
				   const char *opt)
{
	if (!dev->port.membase)
		return -ENODEV;
	dev->con->write = alvx_early_write;
	return 0;
}
EARLYCON_DECLARE(alvx, alvx_early_setup);
OF_EARLYCON_DECLARE(alvx, "alvx,apb3-uart", alvx_early_setup);
#else
#define ALVX_CONSOLE	NULL
#endif

static struct uart_driver alvx_uart_driver = {
	.owner		= THIS_MODULE,
	.driver_name	= DRIVER_NAME,
	.dev_name	= DEVICE_NAME,
	.major		= 0,
	.minor		= 0,
	.nr		= ALVX_UART_NR,
	.cons		= ALVX_CONSOLE,
};

static int alvx_probe(struct platform_device *pdev)
{
	struct uart_port *p = &alvx_port;
	struct resource *res;
	struct clk *clk;
	int irq, ret;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res)
		return -ENODEV;
	p->mapbase = res->start;
	p->membase = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(p->membase))
		return PTR_ERR(p->membase);

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return irq;

	clk = devm_clk_get(&pdev->dev, NULL);
	p->uartclk = IS_ERR(clk) ? 125000000 : clk_get_rate(clk);

	p->dev = &pdev->dev;
	p->iotype = UPIO_MEM32;
	p->flags = UPF_BOOT_AUTOCONF;
	p->regshift = 2;
	p->ops = &alvx_ops;
	p->line = 0;
	p->fifosize = 16;
	p->irq = irq;
	spin_lock_init(&p->lock);

	ret = uart_add_one_port(&alvx_uart_driver, p);
	if (!ret)
		platform_set_drvdata(pdev, p);
	return ret;
}

static void alvx_remove(struct platform_device *pdev)
{
	struct uart_port *p = platform_get_drvdata(pdev);

	if (p)
		uart_remove_one_port(&alvx_uart_driver, p);
}

static const struct of_device_id alvx_of_match[] = {
	{ .compatible = "alvx,apb3-uart" },
	{ }
};
MODULE_DEVICE_TABLE(of, alvx_of_match);

static struct platform_driver alvx_platform_driver = {
	.probe	= alvx_probe,
	.remove_new = alvx_remove,
	.driver	= {
		.name = DRIVER_NAME,
		.of_match_table = alvx_of_match,
	},
};

static int __init alvx_init(void)
{
	int ret;

	ret = uart_register_driver(&alvx_uart_driver);
	if (ret)
		return ret;
	return platform_driver_register(&alvx_platform_driver);
}

static void __exit alvx_exit(void)
{
	platform_driver_unregister(&alvx_platform_driver);
	uart_unregister_driver(&alvx_uart_driver);
}

module_init(alvx_init);
module_exit(alvx_exit);

MODULE_DESCRIPTION("ALVX Apb3UartCtrl serial driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:" DRIVER_NAME);
