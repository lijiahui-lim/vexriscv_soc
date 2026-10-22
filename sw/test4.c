// test4: UART RX echo test — poll DATA bit16 (rx valid), echo each byte
// back over TX. Receives a marker string; prints RXOK when it sees 'X'.

#include <stdint.h>

#define APB_BASE   0xF1000000u
#define UART       (APB_BASE + 0x4000)
#define REG32(a)   (*(volatile uint32_t *)(a))

static void uart_init(void)
{
    REG32(UART + 0x04) = 0;     /* irqs off */
    REG32(UART + 0x08) = 135;   /* 125e6/(136*8)=114890bd ~115200 */
    REG32(UART + 0x0C) = 0x7;   /* 8 data bits, no parity, 1 stop */
}

static void uart_putc(char c)
{
    while (((REG32(UART + 0x04) >> 16) & 0x1F) == 0)
        ;
    REG32(UART + 0x00) = (uint32_t)c;
}

static void uart_puts(const char *s)
{
    while (*s) uart_putc(*s++);
}

void main(void)
{
    uart_init();
    uart_puts("RXTEST\r\n");
    for (;;) {
        uint32_t d = REG32(UART + 0x00);
        if (d & (1u << 16)) {
            char c = d & 0xff;
            uart_putc(c);               /* echo */
            if (c == 'X')
                uart_puts("\r\nRXOK\r\n");
            if (c == 'Z')
                uart_puts("\r\nDONE\r\n");
        }
    }
}
