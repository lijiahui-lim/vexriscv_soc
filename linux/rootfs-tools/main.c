/* lvgl_demo — LVGL widgets demo on ALVX /dev/fb0.
 * Console is the default screen owner; this app saves the fb content,
 * switches VT to graphics mode, runs LVGL, then restores the console.
 * Usage: lvgl_demo [seconds]   (default 30, 0 = until SIGINT)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <linux/kd.h>
#include <linux/vt.h>
#include "lvgl.h"
#include "demos/lv_demos.h"

static volatile int quit_flag;
static void on_sig(int s){ (void)s; quit_flag = 1; }

static int fbfd = -1, vtfd = -1;
static void *fbmap = MAP_FAILED, *savebuf;
static size_t fblen;
static int old_kd = -1;

static void restore(void)
{
    if (old_kd >= 0) ioctl(vtfd, KDSETMODE, old_kd);     /* fbcon redraws text */
    if (fbmap != MAP_FAILED && savebuf) {               /* belt & suspenders */
        memcpy(fbmap, savebuf, fblen);
        struct fb_var_screeninfo v;
        if (ioctl(fbfd, FBIOGET_VSCREENINFO, &v) == 0)
            ioctl(fbfd, FBIOPAN_DISPLAY, &v);           /* reset viewport */
    }
}

int main(int argc, char **argv)
{
    int secs = argc > 1 ? atoi(argv[1]) : 30;
    signal(SIGINT, on_sig); signal(SIGTERM, on_sig);
    atexit(restore);

    /* open fb + save screen */
    fbfd = open("/dev/fb0", O_RDWR);
    if (fbfd < 0) { perror("/dev/fb0"); return 1; }
    struct fb_fix_screeninfo fi; struct fb_var_screeninfo vi;
    ioctl(fbfd, FBIOGET_FSCREENINFO, &fi);
    ioctl(fbfd, FBIOGET_VSCREENINFO, &vi);
    fblen = (size_t)fi.smem_len;
    fbmap = mmap(NULL, fblen, PROT_READ|PROT_WRITE, MAP_SHARED, fbfd, 0);
    if (fbmap == MAP_FAILED) { perror("mmap fb"); return 1; }
    savebuf = malloc(fblen);
    if (savebuf) memcpy(savebuf, fbmap, fblen);
    printf("fb: %dx%d %dbpp len=%zu\n", vi.xres, vi.yres, vi.bits_per_pixel, fblen);

    /* stop fbcon output while we draw */
    vtfd = open("/dev/tty0", O_RDWR);
    if (vtfd < 0) vtfd = open("/dev/console", O_RDWR);
    if (vtfd >= 0 && ioctl(vtfd, KDGETMODE, &old_kd) == 0)
        ioctl(vtfd, KDSETMODE, KD_GRAPHICS);
    else old_kd = -1;

    lv_init();
    lv_display_t *disp = lv_linux_fbdev_create();
    if (!disp) { fprintf(stderr, "fbdev create failed\n"); return 1; }
    /* LVGL takes over the same /dev/fb0 we mapped — set the fd via file */
    if (fbmap != MAP_FAILED) { munmap(fbmap, fblen); fbmap = MAP_FAILED; }
    close(fbfd); fbfd = -1;                     /* let LVGL own the fd */
    lv_linux_fbdev_set_file(disp, "/dev/fb0");
    /* re-map for restore path */
    fbfd = open("/dev/fb0", O_RDWR);
    if (fbfd >= 0) fbmap = mmap(NULL, fblen, PROT_READ|PROT_WRITE, MAP_SHARED, fbfd, 0);

    int demo = argc > 2 ? atoi(argv[2]) : 0;
    if (demo == 1) lv_demo_benchmark(); else lv_demo_widgets();

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    while (!quit_flag) {
        lv_tick_inc(5);
        lv_timer_handler();
        usleep(5000);
        if (secs > 0) {
            clock_gettime(CLOCK_MONOTONIC, &t1);
            if (t1.tv_sec - t0.tv_sec >= secs) break;
        }
    }
    printf("exit, restoring console\n");
    return 0;
}
