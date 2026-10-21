/*
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * ALVX Apb3UartCtrl (SpinalHDL) serial console for OpenSBI.
 */

#include <sbi/riscv_io.h>
#include <sbi/sbi_console.h>
#include <sbi_utils/serial/alvx-uart.h>

#define ALVX_REG_DATA	0x00	/* w: tx push; r: bit16 valid, [7:0] data */
#define ALVX_REG_STATUS	0x04	/* [23:16] tx free, bit15 tx busy */
#define ALVX_REG_MISC	0x10	/* bit0/1 err clear */

static volatile u32 *alvx_uart_base;

static void alvx_uart_putc(char ch)
{
	while (((readl(alvx_uart_base + ALVX_REG_STATUS / 4) >> 16) & 0xff) == 0)
		;
	writel(ch, alvx_uart_base + ALVX_REG_DATA / 4);
}

static int alvx_uart_getc(void)
{
	u32 v = readl(alvx_uart_base + ALVX_REG_DATA / 4);

	if (!(v & (1 << 16)))
		return -1;
	return v & 0xff;
}

static struct sbi_console_device alvx_console = {
	.name = "alvx_uart",
	.console_putc = alvx_uart_putc,
	.console_getc = alvx_uart_getc
};

int alvx_uart_init(unsigned long base)
{
	alvx_uart_base = (volatile u32 *)base;
	writel(3, alvx_uart_base + ALVX_REG_MISC / 4);
	writel(0, alvx_uart_base + ALVX_REG_STATUS / 4);
	sbi_console_set_device(&alvx_console);
	return 0;
}
