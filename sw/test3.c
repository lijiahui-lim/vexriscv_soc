// test3: SD card (SPI mode) init + read MBR, and HDMI framebuffer color bars.
// Results are mirrored to DDR scratch @0x300000 for JTAG verification:
//   [0] stage/result codes, [1..8] R1/OCR/flags, [16..] first 16 MBR bytes.
#include <stdint.h>

#define APB_BASE   0xF1000000u
#define UART       (APB_BASE + 0x4000)
#define SPI        (APB_BASE + 0x5000)
#define GPIO_LED   (APB_BASE + 0x0000)
#define VID        (APB_BASE + 0x7000)     /* generated VideoDma CSRs   */
#define DDR        0x40000000u
#define FB         (DDR + 0x18000000)      /* framebuffer, X8R8G8B8    */
#define SCRATCH    (DDR + 0x00300000)      /* jtag-visible results    */

#define REG32(a)   (*(volatile uint32_t *)(a))

#ifndef FB_ROWS
#define FB_ROWS 720                      /* sim build uses a small value */
#endif

static void uart_init(void)
{
    REG32(UART + 0x08) = 8;
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

/* -------- SPI helpers --------------------------------------------------- */
/* cmd push @+0x00: bit28 mode(1=SS), bit24 read, [7:0] data; SS: bit0 level
   rsp read @+0x00: bit31 valid, [21:16] occupancy, [7:0] data
   sts read @+0x04: [21:16] cmd fifo availability                        */

#define SPI_DATA(rd, b)   ((rd) ? (0x01000000u | (b)) : (uint32_t)(b))
#define SPI_SS(v)         (0x10000000u | (v))

static int spi_cmd_avail(void)
{
    return (REG32(SPI + 0x04) >> 16) & 0x3F;
}
static void spi_push(uint32_t c)
{
    while (spi_cmd_avail() == 0) ;
    REG32(SPI + 0x00) = c;
}
static int spi_pop(uint32_t *b)
{
    uint32_t v = REG32(SPI + 0x00);   /* read pops rsp fifo if bit31 set */
    if (v & 0x80000000u) { *b = v & 0xFF; return 1; }
    return 0;
}
static void spi_ss(int sel) { spi_push(SPI_SS(sel)); }

/* send one byte, return received byte (waits for the response) */
static uint32_t spi_xfer(uint32_t b)
{
    uint32_t r;
    spi_push(SPI_DATA(1, b));
    do {} while (!spi_pop(&r));
    return r;
}
/* send a byte without waiting for a response (response is still queued
   when read=0? no - read=0 produces no rsp entry)                    */
static void spi_send(uint32_t b) { spi_push(SPI_DATA(0, b)); }

/* SD command: 6 bytes on the wire, then poll rx until !0xFF -> R1 */
static uint32_t sd_cmd(uint32_t c, uint32_t arg, uint32_t crc, uint32_t *resp, int nr)
{
    int i;
    uint32_t r = 0xFF;
    spi_send(0x40 | c);
    spi_send((arg >> 24) & 0xFF);
    spi_send((arg >> 16) & 0xFF);
    spi_send((arg >>  8) & 0xFF);
    spi_send(arg & 0xFF);
    spi_send(crc | 1);
    for (i = 0; i < 64 && r == 0xFF; i++) r = spi_xfer(0xFF);
    for (i = 0; i < nr; i++) resp[i] = spi_xfer(0xFF);
    return r;
}

int main(void)
{
    volatile uint32_t *sc = (volatile uint32_t *)SCRATCH;
    volatile uint32_t *fb = (volatile uint32_t *)FB;
    uint32_t resp[4], r1, i, errs = 0;
    int x, y;

    uart_init();
    REG32(GPIO_LED) = 0x2A;
    uart_puts("test3 sd+hdmi\n");
    sc[0] = 0x30000001;

    /* -------- framebuffer: 8 vertical color bars -------------- */
    for (y = 0; y < FB_ROWS; y++) {
        for (x = 0; x < 1280; x++) {
            uint32_t c;
            switch ((x * 8) / 1280) {
            case 0: c = 0xFFFFFF; break;  case 1: c = 0xFFFF00; break;
            case 2: c = 0x00FFFF; break;  case 3: c = 0x00FF00; break;
            case 4: c = 0xFF00FF; break;  case 5: c = 0xFF0000; break;
            case 6: c = 0x0000FF; break;  default: c = 0x000000; break;
            }
            fb[y * 1280 + x] = c;
        }
    }
    sc[0] = 0x30000002;
    uart_puts("fb filled\n");

    /* program + enable the generated VideoDma path (apb 0x7000):
       +0 base = window-relative addr in 32B units, +4 size = bursts-1,
       +8 ctrl bit0 = enable, +0C status {busy<<1, underrun} (W1C).    */
    REG32(VID + 0x00) = (FB - DDR) / 32;
    REG32(VID + 0x04) = (FB_ROWS * 1280) / 8 - 1;
    REG32(VID + 0x08) = 1;
    { volatile int d; for (d = 0; d < 40000; d++) ; }
    sc[1] = REG32(VID + 0x0C);
    uart_puts("fb on, status="); uart_hex(sc[1]); uart_putc('\n');

    /* -------- SD card init (SPI, mode 0) ---------------------- */
    REG32(SPI + 0x08) = 0x10;              /* mode0; ss0 pin = !enable (nCS) */
    REG32(SPI + 0x0C) = 155;               /* 125MHz/(2*156) ~ 400 kHz     */
    REG32(SPI + 0x10) = 200;               /* ss_setup  */
    REG32(SPI + 0x14) = 200;               /* ss_hold   */
    REG32(SPI + 0x18) = 200;               /* ss_disable*/

    /* >=74 clocks with CS high */
    spi_ss(0);
    for (i = 0; i < 10; i++) spi_send(0xFF);
    spi_ss(1);
    sc[0] = 0x30000003;

    r1 = sd_cmd(0, 0, 0x95, resp, 0);      /* CMD0 go idle      */
    sc[2] = r1;
    uart_puts("cmd0 r1="); uart_hex(r1); uart_putc('\n');
    if (r1 == 0xFF) {                      /* no card / no resp */
        uart_puts("sd: no response (NOCARD)\n");
        sc[0] = 0x300000EE;
        goto done;
    }

    r1 = sd_cmd(8, 0x1AA, 0x87, resp, 4);  /* CMD8 voltage check*/
    sc[3] = r1; sc[4] = (resp[0] << 24) | (resp[1] << 16) | (resp[2] << 8) | resp[3];
    uart_puts("cmd8 r1="); uart_hex(r1); uart_puts(" arg=");
    uart_hex(sc[4]); uart_putc('\n');

    /* ACMD41 init loop */
    for (i = 0; i < 2000; i++) {
        sd_cmd(55, 0, 0x65, resp, 0);      /* CMD55 app prefix  */
        r1 = sd_cmd(41, 0x40000000, 0x77, resp, 0);
        if (r1 == 0) break;
    }
    sc[5] = r1; sc[6] = i;
    uart_puts("acmd41 r1="); uart_hex(r1); uart_puts(" iter=");
    uart_hex(i); uart_putc('\n');

    r1 = sd_cmd(58, 0, 0xFD, resp, 4);     /* CMD58 read OCR    */
    sc[7] = (resp[0] << 24) | (resp[1] << 16) | (resp[2] << 8) | resp[3];
    uart_puts("cmd58 ocr="); uart_hex(sc[7]); uart_putc('\n');

    /* faster clock now that init is done */
    REG32(SPI + 0x0C) = 9;                 /* 125MHz/20 = 6.25 MHz */

    /* CMD17 read sector 0 -> capture first 16 bytes + tail magic */
    {
        uint32_t t, m0 = 0, m1 = 0;
        r1 = sd_cmd(17, 0, 0x01, resp, 0);
        sc[8] = r1;
        for (i = 0; i < 10000; i++) {      /* wait data token 0xFE */
            t = spi_xfer(0xFF);
            if (t == 0xFE) break;
        }
        sc[9] = t;
        for (i = 0; i < 16; i++) sc[16 + i] = spi_xfer(0xFF);
        for (i = 16; i < 510; i++) spi_xfer(0xFF);
        m0 = spi_xfer(0xFF); m1 = spi_xfer(0xFF);
        spi_xfer(0xFF); spi_xfer(0xFF);    /* crc */
        sc[10] = (m0 << 8) | m1;           /* expect 0x55AA      */
        uart_puts("cmd17 r1="); uart_hex(r1);
        uart_puts(" tok="); uart_hex(t);
        uart_puts(" mbr="); uart_hex(sc[10]); uart_putc('\n');
        if (t != 0xFE || sc[10] != 0x55AA) errs++;
    }
    spi_ss(0);
    spi_send(0xFF);
    sc[0] = errs ? 0x300000F1 : 0x300000AA;

done:
    uart_puts(errs ? "FAIL\n" : "DONE\n");
    for (;;) ;
}
