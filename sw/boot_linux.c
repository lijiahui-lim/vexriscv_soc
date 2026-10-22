// boot_linux: load the OpenSBI fw_payload blob (opensbi + kernel + dtb +
// initramfs) into DDR @0x40000000 and jump to it in M-mode.
//
//   SD path : header sector @LBA1 = {magic 0x4C565841, size_bytes, pay_lba},
//             payload at pay_lba (default 64).  Written by linux/mksdimg.sh.
//   JTAG    : no card -> poll DDR magic word @0x46000000; the system-console
//             script uploads the blob to 0x40000000 then writes the magic.
//
// The video pipeline is enabled before the jump so the kernel
// simple-framebuffer console has somewhere to draw.
#include <stdint.h>

#define APB_BASE   0xF1000000u
#define UART       (APB_BASE + 0x4000)
#define SPI        (APB_BASE + 0x5000)
#define GPIO_LED   (APB_BASE + 0x0000)
#define VID        (APB_BASE + 0x7000)
#define DDR        0x40000000u
#define FB         (DDR + 0x18000000)
#define LOAD_ADDR  DDR
#define MAGIC_ADDR (DDR + 0x06000000)      /* 96 MiB in, above payload, below fb carve */
#define MAGIC_WORD 0xC0DE0007u
#define HDR_MAGIC  0x4C565841u            /* "ALVL" */
#define SCRATCH    (DDR + 0x06000100)

#define REG32(a)   (*(volatile uint32_t *)(a))

static void uart_init(void)
{
#ifdef BOOT_SIM
    /* sim only: bit=(8+1)*8clk=72clk — 15x faster decode; opensbi leaves
     * the divider alone, the kernel console driver reprograms 135 later. */
    REG32(UART + 0x08) = 8;
#else
    REG32(UART + 0x08) = 135;  /* bit=(div+1)*8clk: 125e6/(136*8)=114890bd ~115200 */
#endif
    REG32(UART + 0x0C) = 0x7;
}
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
static void uart_dec(uint32_t v)
{
    char b[12]; int i = 0;
    if (!v) { uart_putc('0'); return; }
    while (v) { b[i++] = '0' + (v % 10); v /= 10; }
    while (i) uart_putc(b[--i]);
}

/* -------- SPI / SD ---------------------------------------------------- */
#define SPI_DATA(rd, b)   ((rd) ? (0x01000000u | (b)) : (uint32_t)(b))
#define SPI_SS(en)        (0x10000000u | (en))

static void spi_push(uint32_t c)
{
    while (((REG32(SPI + 0x04) >> 16) & 0x3F) == 0) ;
    REG32(SPI + 0x00) = c;
}
static int spi_pop(uint32_t *b)
{
    uint32_t v = REG32(SPI + 0x00);
    if (v & 0x80000000u) { *b = v & 0xFF; return 1; }
    return 0;
}
static void spi_ss(int en) { spi_push(SPI_SS(en)); }
static uint32_t spi_xfer(uint32_t b)
{
    uint32_t r;
    spi_push(SPI_DATA(1, b));
    do {} while (!spi_pop(&r));
    return r;
}
static void spi_send(uint32_t b) { spi_push(SPI_DATA(0, b)); }

static uint32_t sd_cmd(uint32_t c, uint32_t arg, uint32_t crc,
                       uint32_t *resp, int nr)
{
    int i;
    uint32_t r = 0xFF;
    spi_send(0x40 | c);
    spi_send((arg >> 24) & 0xFF);
    spi_send((arg >> 16) & 0xFF);
    spi_send((arg >>  8) & 0xFF);
    spi_send(arg & 0xFF);
    spi_send(crc | 1);
    for (i = 0; i < 200 && r == 0xFF; i++) r = spi_xfer(0xFF);
    for (i = 0; i < nr; i++) resp[i] = spi_xfer(0xFF);
    return r;
}

static int sd_block;             /* 1 = SDHC block addressing */
static uint32_t sd_baddr(uint32_t lba) { return sd_block ? lba : lba * 512u; }

/* read one 512B sector into buf; returns 0 on ok */
static int sd_read_sect(uint32_t lba, uint8_t *buf)
{
    uint32_t r1, t;
    int i;
    r1 = sd_cmd(17, sd_baddr(lba), 0x01, 0, 0);
    if (r1 != 0x00) return -1;
    for (i = 0; i < 20000; i++) {
        t = spi_xfer(0xFF);
        if (t == 0xFE) break;
        if (t != 0xFF && !(t & 0x80)) return -2;   /* error token */
    }
    if (t != 0xFE) return -3;
    for (i = 0; i < 512; i++) buf[i] = spi_xfer(0xFF);
    spi_xfer(0xFF); spi_xfer(0xFF);               /* crc */
    return 0;
}

static int sd_init(void)
{
    uint32_t resp[4], r1;
    int i;

    /* mode0, ss pin = active-low nCS; ~400kHz */
    REG32(SPI + 0x08) = 0x10;
    REG32(SPI + 0x0C) = 155;
    REG32(SPI + 0x10) = 200;
    REG32(SPI + 0x14) = 200;
    REG32(SPI + 0x18) = 200;

    spi_ss(0);
    for (i = 0; i < 10; i++) spi_send(0xFF);     /* >=74 clk, CS high */
    spi_ss(1);                                  /* select card       */

    r1 = sd_cmd(0, 0, 0x95, resp, 0);
    if (r1 == 0xFF) { spi_ss(0); return -1; }    /* no card           */

    sd_cmd(8, 0x1AA, 0x87, resp, 4);
    for (i = 0; i < 4000; i++) {
        sd_cmd(55, 0, 0x65, resp, 0);
        r1 = sd_cmd(41, 0x40000000, 0x77, resp, 0);
        if (r1 == 0) break;
    }
    if (r1 != 0) { spi_ss(0); return -2; }

    sd_cmd(58, 0, 0xFD, resp, 4);                /* OCR -> CCS */
    sd_block = (resp[0] & 0x40) ? 1 : 0;

    REG32(SPI + 0x0C) = 4;                       /* 125MHz/10 = 12.5MHz */
    return 0;
}

static void jump_to_ddr(void)
{
    uart_puts("jump -> 0x40000000\n");
    /* a0=hartid, a1=fdt (opensbi reads them before it can set up) */
    __asm__ volatile ("fence; fence.i; li a0,0; li a1,0; jr %0"
                     :: "r"(LOAD_ADDR) : "a0", "a1", "memory");
    for (;;) ;
}

int main(void)
{
    volatile uint32_t *sc = (volatile uint32_t *)SCRATCH;
    volatile uint32_t *magic = (volatile uint32_t *)MAGIC_ADDR;
    uint32_t i;

    uart_init();
    REG32(GPIO_LED) = 0x15;
    uart_puts("\nboot_linux\n");
    sc[0] = 0xB0070001;

    /* black framebuffer + start the generated video pipeline.
     * Full 3.5 MiB clear is fine on HW (~ms); in sim it would blow the
     * tick budget, so only paint a few lines there. */
    uint32_t fbw = 640u * 480;
#ifdef BOOT_SIM
    fbw = 640u * 8;
#endif
    for (i = 0; i < fbw; i++)
        ((volatile uint32_t *)FB)[i] = 0;
    REG32(VID + 0x00) = (FB - DDR) / 32;
    REG32(VID + 0x04) = (480u * 640) / 8 - 1;
    REG32(VID + 0x08) = 1;
    sc[1] = REG32(VID + 0x0C);
    uart_puts("video on\n");

#ifdef BOOT_SIM
    /* sim: DDR is preloaded by the testbench — skip SD + JTAG wait. */
    uart_puts("sim: jump to preloaded payload\n");
    sc[0] = 0xB0070003;
    jump_to_ddr();
#endif
    /* --- try SD ------------------------------------------------------ */
    if (sd_init() == 0) {
        uint8_t hdr[512];
        uint32_t size, lba, nsect, dst;
        uart_puts("sd ok, blockaddr="); uart_dec(sd_block); uart_putc('\n');
        sc[0] = 0xB0070002;
        if (sd_read_sect(1, hdr) == 0 &&
            ((uint32_t *)hdr)[0] == HDR_MAGIC) {
            size  = ((uint32_t *)hdr)[1];
            lba   = ((uint32_t *)hdr)[2];
            if (!lba) lba = 64;
            nsect = (size + 511) / 512;
            uart_puts("payload "); uart_dec(size);
            uart_puts("B @lba"); uart_dec(lba); uart_putc('\n');
            for (i = 0, dst = LOAD_ADDR; i < nsect; i++, dst += 512) {
                if (sd_read_sect(lba + i, (uint8_t *)dst)) {
                    uart_puts("rd fail @"); uart_dec(i); uart_putc('\n');
                    sc[0] = 0xB00700F0 | i;
                    goto wait_jtag;
                }
                if ((i & 0x3F) == 0x3F) uart_putc('.');
            }
            uart_putc('\n');
            spi_ss(0);
            sc[0] = 0xB0070003;
            jump_to_ddr();
        }
        uart_puts("no valid header\n");
        sc[0] = 0xB00700E1;
    } else {
        uart_puts("no sd card\n");
        sc[0] = 0xB00700E0;
    }

wait_jtag:
    /* JTAG path: host loads blob to 0x40000000, then writes magic. */
    uart_puts("waiting for jtag magic @0x46000000 ...\n");
    REG32(GPIO_LED) = 0x3F;
    *magic = 0;
    sc[0] = 0xB0070004;
    while (*magic != MAGIC_WORD)
        ;
    jump_to_ddr();
    return 0;
}
