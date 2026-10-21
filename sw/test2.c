// test2: Sv32 MMU smoke test.
//   M-mode: build a level-1 page table in DDR, enable satp, mret to S-mode.
//   S-mode: verify VA 0x70000000 aliases PA 0x40000000 (DDR), then touch an
//   unmapped VA and check the M-mode trap handler sees a load page fault.
//   Also exercises a CLINT timer interrupt (M-mode, mtvec handler).
#include <stdint.h>

#define APB_BASE   0xF1000000u
#define UART       (APB_BASE + 0x4000)
#define CLINT      0xF0000000u
#define DDR        0x40000000u

#define PT         (DDR + 0x180000)   /* 4KB-aligned page table */
#define ALIAS      0x70000000u        /* -> DDR */
#define REG32(a)   (*(volatile uint32_t *)(a))

#define csrw(r,v)  __asm__ volatile ("csrw " r ", %0" :: "r"(v))
#define csrr(r,v)  __asm__ volatile ("csrr %0, " r : "=r"(v))
#define sfence()   __asm__ volatile ("sfence.vma")

static void uart_putc(char c)
{
    while (((REG32(UART + 0x04) >> 16) & 0x1F) == 0) ;
    REG32(UART + 0x00) = (uint32_t)c;
}
static void uart_puts(const char *s) { while (*s) uart_putc(*s++); }
static void uart_hex(uint32_t v)
{
    static const char h[] = "0123456789abcdef";
    int i; uart_puts("0x");
    for (i = 7; i >= 0; i--) uart_putc(h[(v >> (i * 4)) & 0xF]);
}

/* ---- trap state ---- */
volatile uint32_t g_mcause = 0, g_mtval = 0, g_mtip = 0;

extern void trap_vec(void);           /* in trap.S */
extern void smode_entry(void);
void smode_main(void);

#define PTE_V 0x01
#define PTE_R 0x02
#define PTE_W 0x04
#define PTE_X 0x08
#define PTE_A 0x40
#define PTE_D 0x80

/* megapage PTE: PA = va-aligned physical base */
static uint32_t mp_pte(uint32_t pa)
{
    return ((pa >> 12) << 10) | PTE_A | PTE_D | PTE_X | PTE_W | PTE_R | PTE_V;
}

void main(void)
{
    volatile uint32_t *pt = (volatile uint32_t *)PT;
    uint32_t i;

    REG32(UART + 0x08) = 135;  /* bit=(div+1)*8clk: 125e6/(136*8)=114890bd ~115200 */
    REG32(UART + 0x0C) = 0x7;
    uart_puts("test2 sv32\n");

    for (i = 0; i < 1024; i++) pt[i] = 0;
    pt[0x000] = mp_pte(0x00000000);   /* VA 0x0  -> code/ram identity */
    pt[0x100] = mp_pte(0x40000000);   /* VA 0x4_ -> DDR identity   */
    pt[0x1C0] = mp_pte(0x40000000);   /* VA 0x7_ -> DDR alias      */
    for (i = 0x3C0; i < 0x400; i++)   /* VA 0xF* -> MMIO identity  */
        pt[i] = mp_pte(i << 22);

    /* mtvec before enabling satp: M-mode handler for faults + timer */
    csrw("mtvec", (uint32_t)trap_vec);

    /* satp = MODE(1) | PPN(pt) */
    csrw("satp", 0x80000000u | ((uint32_t)PT >> 12));
    sfence();

    /* timer irq in ~1M cycles, enable M-timer interrupt */
    REG32(CLINT + 0x4000) = REG32(CLINT + 0xBFF8) + 100000;
    REG32(CLINT + 0x4004) = 0;
    csrw("mie", 1u << 7);             /* MTIE */
    csrw("mstatus", (1u << 3));       /* MIE */

    /* drop to S-mode at smode_entry */
    {
        uint32_t mstatus;
        csrr("mstatus", mstatus);
        mstatus = (mstatus & ~0x1800u) | 0x0800u;  /* MPP = S */
        csrw("mstatus", mstatus);
        csrw("mepc", (uint32_t)smode_entry);
        __asm__ volatile ("mret");
    }
}

/* runs in S-mode after mret */
void smode_main(void)
{
    volatile uint32_t *ali = (volatile uint32_t *)(ALIAS + 0x200000);
    volatile uint32_t *dir = (volatile uint32_t *)(DDR   + 0x200000);
    uint32_t v;
    int errs = 0;

    uart_puts("S-mode ok\n");

    ali[0] = 0xC0FFEE11;
    v = dir[0];
    if (v != 0xC0FFEE11) errs++;
    uart_puts("alias rd="); uart_hex(v); uart_putc('\n');

    dir[1] = 0x55AA33CC;
    v = ali[1];
    if (v != 0x55AA33CC) errs++;
    uart_puts("alias rd2="); uart_hex(v); uart_putc('\n');

    /* unmapped VA -> load page fault -> trap_vec records cause,
       skips the faulting instruction and returns */
    g_mcause = 0;
    v = *(volatile uint32_t *)0x20000000u;
    (void)v;
    uart_puts("fault cause="); uart_hex(g_mcause);
    uart_puts(" tval="); uart_hex(g_mtval); uart_putc('\n');
    if (g_mcause != 13 || g_mtval != 0x20000000u) errs++;

    if (errs) uart_puts("MMU FAIL\n");
    else      uart_puts("MMU PASS\n");

    /* wait for the timer irq (fires ~1M cycles after arm) */
    while (!g_mtip) ;
    uart_puts("mtip ok\n");
    uart_puts("DONE\n");
    for (;;) ;
}
