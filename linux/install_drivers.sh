#!/bin/bash
# install_alvx.sh <kernel-tree> — install ALVX drivers + dts into a kernel tree.
# Idempotent: skips lines already present.
set -e
K="$1"
L="$(cd "$(dirname "$0")" && pwd)"

cp "$L/drivers/spi/spi-alvx.c"        "$K/drivers/spi/"
cp "$L/drivers/tty/serial/alvx_uart.c" "$K/drivers/tty/serial/"

# ---- Kconfig entries -------------------------------------------------
grep -q 'config SERIAL_ALVX$' "$K/drivers/tty/serial/Kconfig" || \
sed -i 's/^endmenu$/config SERIAL_ALVX\n\ttristate "ALVX Apb3UartCtrl serial support"\n\tdepends on OF\n\tselect SERIAL_CORE\n\thelp\n\t  Driver for the SpinalHDL Apb3UartCtrl UART.\n\nconfig SERIAL_ALVX_CONSOLE\n\tbool "ALVX serial console"\n\tdepends on SERIAL_ALVX\n\tselect SERIAL_CORE_CONSOLE\n\tselect SERIAL_EARLYCON\n\nendmenu/' \
    "$K/drivers/tty/serial/Kconfig"

grep -q 'config SPI_ALVX$' "$K/drivers/spi/Kconfig" || \
sed -i 's/^endif # SPI$/config SPI_ALVX\n\ttristate "ALVX Apb3SpiMasterCtrl SPI"\n\tdepends on OF\n\thelp\n\t  SPI master driver for the SpinalHDL Apb3SpiMasterCtrl.\n\nendif # SPI/' \
    "$K/drivers/spi/Kconfig"

# ---- Makefile lines --------------------------------------------------
grep -q 'spi-alvx' "$K/drivers/spi/Makefile" || \
    echo 'obj-$(CONFIG_SPI_ALVX) += spi-alvx.o' >> "$K/drivers/spi/Makefile"
grep -q 'alvx_uart' "$K/drivers/tty/serial/Makefile" || \
    echo 'obj-$(CONFIG_SERIAL_ALVX) += alvx_uart.o' >> "$K/drivers/tty/serial/Makefile"

echo "alvx drivers installed into $K"
