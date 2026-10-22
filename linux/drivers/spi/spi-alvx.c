// SPDX-License-Identifier: GPL-2.0
/*
 * SPI controller driver for the SpinalHDL Apb3SpiMasterCtrl (ALVX SoC).
 *
 * Register map (32-bit):
 *   0x00 CMD   W: DATA cmd = {mode[29:28]=0, read<<24, data[7:0]}
 *                   SS   cmd = {mode[29:28]=1, enable<<24, index[7:0]}
 *        RSP   R: bit31=valid, [23:16]=rsp occupancy, [7:0]=data (read pops)
 *   0x04 STATUS R/W: bit0 cmd-int-en, bit1 rsp-int-en;
 *              R: bit8 cmd-int, bit9 rsp-int, [21:16] cmd fifo availability
 *   0x08 MODE   bit0=cpol, bit1=cpha, bit4+=ss activeHigh mask
 *   0x0C SCLK_TOGGLE   spi freq = fclk / (2 * div)
 *   0x10 SS_SETUP  0x14 SS_HOLD  0x18 SS_DISABLE  0x1C SAMPLE_POS
 *
 * Transfers are polled; cmd/rsp fifos are 32 entries deep.
 */

#include <linux/bitops.h>
#include <linux/clk.h>
#include <linux/io.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>

#define OFF_CMD		0x00
#define OFF_STATUS	0x04
#define OFF_MODE	0x08
#define OFF_DIV		0x0c
#define OFF_SS_SETUP	0x10
#define OFF_SS_HOLD	0x14
#define OFF_SS_DISABLE	0x18

#define CMD_DATA_RD	BIT(24)
#define CMD_MODE_SS	BIT(28)
#define SS_EN		BIT(24)
#define MODE_SS0_NCS	BIT(4)	/* ss0 pin = !enable -> active-low nCS */

#define STS_CMD_FREE(x)	(((x) >> 16) & 0x3f)
#define RSP_VALID	BIT(31)

#define DRV_NAME	"alvx-spi"

struct alvx_spi {
	void __iomem		*base;
	struct clk		*clk;
};

static void spi_push(struct alvx_spi *s, u32 c)
{
	while (STS_CMD_FREE(readl(s->base + OFF_STATUS)) == 0)
		cpu_relax();
	writel(c, s->base + OFF_CMD);
}

static u8 spi_pop(struct alvx_spi *s)
{
	u32 v;

	do {
		v = readl(s->base + OFF_CMD);
	} while (!(v & RSP_VALID));
	return v & 0xff;
}

static void alvx_set_cs(struct spi_device *spi, bool enable)
{
	struct alvx_spi *s = spi_controller_get_devdata(spi->controller);

	spi_push(s, CMD_MODE_SS | (enable ? SS_EN : 0));
}

static int alvx_transfer_one(struct spi_controller *ctlr,
			     struct spi_device *spi, struct spi_transfer *t)
{
	struct alvx_spi *s = spi_controller_get_devdata(ctlr);
	const u8 *tx = t->tx_buf;
	u8 *rx = t->rx_buf;
	unsigned int i;
	u32 div, mode;

	div = DIV_ROUND_UP(clk_get_rate(s->clk), 2 * t->speed_hz);
	if (div)
		writel(div, s->base + OFF_DIV);
	mode = (spi->mode & SPI_CPOL ? 1 : 0) | (spi->mode & SPI_CPHA ? 2 : 0);
	if (!(spi->mode & SPI_CS_HIGH))
		mode |= MODE_SS0_NCS;	/* pin = ss ^ 1 -> active-low */
	writel(mode, s->base + OFF_MODE);

	for (i = 0; i < t->len; i++) {
		spi_push(s, CMD_DATA_RD | (tx ? tx[i] : 0xff));
		if (rx)
			rx[i] = spi_pop(s);
		else
			spi_pop(s);
	}
	return 0;
}

static int alvx_setup(struct spi_device *spi)
{
	struct alvx_spi *s = spi_controller_get_devdata(spi->controller);

	writel(200, s->base + OFF_SS_SETUP);
	writel(200, s->base + OFF_SS_HOLD);
	writel(200, s->base + OFF_SS_DISABLE);
	return 0;
}

static int alvx_probe(struct platform_device *pdev)
{
	struct spi_controller *ctlr;
	struct alvx_spi *s;
	int ret;

	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*s));
	if (!ctlr)
		return -ENOMEM;

	s = spi_controller_get_devdata(ctlr);
	s->base = devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(s->base))
		return PTR_ERR(s->base);

	s->clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(s->clk))
		return PTR_ERR(s->clk);
	ret = clk_prepare_enable(s->clk);
	if (ret)
		return ret;

	ctlr->dev.of_node = pdev->dev.of_node;
	ctlr->num_chipselect = 1;
	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
	ctlr->setup = alvx_setup;
	ctlr->set_cs = alvx_set_cs;
	ctlr->transfer_one = alvx_transfer_one;
	ctlr->use_gpio_descriptors = false;

	ret = devm_spi_register_controller(&pdev->dev, ctlr);
	if (ret)
		clk_disable_unprepare(s->clk);
	return ret;
}

static const struct of_device_id alvx_spi_match[] = {
	{ .compatible = "alvx,apb3-spi" },
	{ }
};
MODULE_DEVICE_TABLE(of, alvx_spi_match);

static struct platform_driver alvx_spi_driver = {
	.probe	= alvx_probe,
	.driver	= {
		.name = DRV_NAME,
		.of_match_table = alvx_spi_match,
	},
};
module_platform_driver(alvx_spi_driver);

MODULE_DESCRIPTION("ALVX Apb3SpiMasterCtrl driver");
MODULE_LICENSE("GPL");
