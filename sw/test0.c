// test0: staged CPU-alive proof via DDR magic writes (no peripherals needed).
// stage marks land at DDR[0..3] so JTAG can see how far the CPU got.
#include <stdint.h>

#define DDR        0x40000000u
#define UART       0xF1004000u
#define REG32(a)   (*(volatile uint32_t *)(a))

int main(void)
{
    volatile uint32_t *d = (volatile uint32_t *)DDR;
    uint32_t n = 0;

    d[0] = 0xDEAD0001u;               /* stage1: reached main, before any APB  */
    d[1] = 0xDEAD0002u;

    REG32(UART + 0x08) = 8;           /* clockDivider                        */
    d[2] = 0xDEAD0003u;               /* stage2: first APB write survived    */
    REG32(UART + 0x0C) = 0x000F0103;
    REG32(UART + 0x04) = 0x00000000;
    d[3] = 0xDEAD0004u;               /* stage3: uart_init done              */

    while (((REG32(UART + 0x04) >> 16) & 0x1F) == 0) ;   /* wait tx space    */
    REG32(UART + 0x00) = 'H';
    d[4] = 0xDEAD0005u;               /* stage4: tx fifo pushed              */

    for (;;) {
        d[5] = n++;                   /* heartbeat                           */
    }
}
