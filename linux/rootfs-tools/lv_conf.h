/* lv_conf.h for ALVX rv32ima — 1280x720 XRGB8888 fbdev */
#ifndef LV_CONF_H
#define LV_CONF_H

#define LV_COLOR_DEPTH 32
#define LV_USE_STDLIB_MALLOC    LV_STDLIB_BUILTIN
#define LV_USE_STDLIB_STRING    LV_STDLIB_BUILTIN
#define LV_USE_STDLIB_SPRINTF   LV_STDLIB_BUILTIN
#define LV_MEM_SIZE (64U * 1024U)
#define LV_USE_OS 0

#define LV_USE_LOG 1
#define LV_LOG_LEVEL LV_LOG_LEVEL_WARN
#define LV_LOG_PRINTF 1

/* display driver: Linux framebuffer */
#define LV_USE_LINUX_FBDEV 1

/* fonts */
#define LV_FONT_MONTSERRAT_14 1
#define LV_FONT_MONTSERRAT_16 1
#define LV_FONT_MONTSERRAT_18 1
#define LV_FONT_MONTSERRAT_22 1
#define LV_FONT_MONTSERRAT_24 1
#define LV_FONT_MONTSERRAT_28 1
#define LV_FONT_MONTSERRAT_32 1

/* widgets + demo */
#define LV_USE_BUTTON 1
#define LV_USE_LABEL 1
#define LV_USE_IMAGE 1
#define LV_USE_SLIDER 1
#define LV_USE_BAR 1
#define LV_USE_CHART 1
#define LV_USE_ARC 1
#define LV_USE_SWITCH 1
#define LV_USE_CHECKBOX 1
#define LV_USE_DROPDOWN 1
#define LV_USE_ROLLER 1
#define LV_USE_TEXTAREA 1
#define LV_USE_TABLE 1
#define LV_USE_TABVIEW 1
#define LV_USE_CALENDAR 1
#define LV_USE_SPINNER 1
#define LV_USE_MSGBOX 1
#define LV_USE_SPINBOX 1
#define LV_USE_TILEVIEW 1
#define LV_USE_KEYBOARD 1
#define LV_USE_LIST 1
#define LV_USE_MENU 1
#define LV_USE_SCALE 1

#define LV_BUILD_EXAMPLES 0
#define LV_USE_DEMO_WIDGETS 1
#define LV_USE_DEMO_BENCHMARK 1

#define LV_USE_FLOAT 0   /* rv32ima has no FPU — keep soft-float only ints */
#define LV_USE_MATRIX 0

#endif
