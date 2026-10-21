// test1: UART hello + LED + DDR write/read + CLINT mtime sanity.
// Prints DONE when finished, FAIL:<code> on error.
#include <stdint.h>

#define APB_BASE   0xF1000000u
#define UART       (APB_BASE + 0x4000)
#define GPIO_LED   (APB_BASE + 0x0000)
#define SYSID      (APB_BASE + 0x6000)
#define CLINT      0xF0000000u
#define DDR        0x40000000u

#define REG32(a)   (*(volatile uint32_t *)(a))

static void uart_init(void)
{
    /* clock divider: clk cycles per bit. Use small value for sim speed. */
    REG32(UART + 0x08) = 135;  /* bit=(div+1)*8clk: 125e6/(136*8)=114890bd ~115200 */
    /* frame config: dataLength=7 (8 bits), parity=none, stop=1 */
    REG32(UART + 0x0C) = 0x7;
}

static void uart_putc(char c)
{
    /* status[20:16] = tx fifo availability (free slots); wait for space */
    while (((REG32(UART + 0x04) >> 16) & 0x1F) == 0)
        ;
    REG32(UART + 0x00) = (uint32_t)c;
}

static void uart_puts(const char *s)
{
    while (*s) uart_putc(*s++);
}

static void uart_hex(uint32_t v)
{
    static const char h[] = "0123456789abcdef";
    int i;
    uart_puts("0x");
    for (i = 7; i >= 0; i--) uart_putc(h[(v >> (i * 4)) & 0xF]);
}

int main(void)
{
    volatile uint32_t *d = (volatile uint32_t *)(DDR + 0x10000);
    uint32_t i, v, errs = 0;
    uint32_t t0;

    uart_init();
    REG32(GPIO_LED) = 0x15;
    uart_puts("HELLO vexriscv_soc\n");
    uart_puts("sysid=");
    uart_hex(REG32(SYSID + 0x00));
    uart_puts(" freq=");
    uart_hex(REG32(SYSID + 0x08));
    uart_putc('\n');

    /* ---- DDR write/readback over the full chain ---- */
    for (i = 0; i < 4096; i++) d[i] = 0xA5A50000u ^ i;
    for (i = 0; i < 4096; i++) {
        v = d[i];
        if (v != (0xA5A50000u ^ i)) errs++;
    }
    uart_puts("ddr wr/rd errs="); uart_hex(errs); uart_putc('\n');

    /* byte enables */
    d[64] = 0;
    ((volatile uint8_t *)d)[256 + 1] = 0x77;
    v = d[64];
    uart_puts("ddr be="); uart_hex(v); uart_putc('\n');
    if (v != 0x00007700) errs++;

    /* ---- clint mtime sanity ---- */
    t0 = REG32(CLINT + 0xBFF8);           /* mtime lo */
    for (i = 0; i < 100000; i++) ;
    if (REG32(CLINT + 0xBFF8) == t0) {
        uart_puts("clint mtime STUCK\n");
        errs++;
    } else {
        uart_puts("clint mtime ok\n");
    }

    if (errs) {
        uart_puts("FAIL errors="); uart_hex(errs); uart_putc('\n');
    } else {
        uart_puts("DONE all-pass\n");
    }
    return 0;
}
