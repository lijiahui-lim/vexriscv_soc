/*
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include <sbi/sbi_error.h>
#include <sbi_utils/fdt/fdt_helper.h>
#include <sbi_utils/serial/fdt_serial.h>
#include <sbi_utils/serial/alvx-uart.h>

static int serial_alvx_init(const void *fdt, int nodeoff,
			    const struct fdt_match *match)
{
	uint64_t reg_addr, reg_size;
	int rc;

	if (nodeoff < 0 || !fdt)
		return SBI_ENODEV;

	rc = fdt_get_node_addr_size(fdt, nodeoff, 0, &reg_addr, &reg_size);
	if (rc < 0 || !reg_addr || !reg_size)
		return SBI_ENODEV;

	return alvx_uart_init(reg_addr);
}

static const struct fdt_match serial_alvx_match[] = {
	{ .compatible = "alvx,apb3-uart" },
	{ },
};

const struct fdt_driver fdt_serial_alvx = {
	.match_table = serial_alvx_match,
	.init = serial_alvx_init
};
