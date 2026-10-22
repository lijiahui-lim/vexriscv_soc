#!/bin/bash
# mklvgl.sh — cross-build LVGL v9 + fbdev demo into the rootfs.
# Produces: /usr/lib/liblvgl.a, /usr/include/lvgl/, /usr/bin/lvgl_demo
set -u
A=${ALVX_ROOTFS:-/home/li/work/altera/rootfs}
LV=$A/lvgl/lvgl-9.2.2
STAGE=$A/lvgl-stage
ROOTFS=$A/rootfs
TC=/home/li/work/altera/vexriscv_soc/linux/toolchain-rv32ima/bin
export PATH="$TC:$PATH"
T=riscv32-linux-musl
CC="$T-gcc -O2 -DLV_CONF_INCLUDE_SIMPLE -I$A/lvgl -I$LV"
NJ=$(nproc)
OBJ=$A/lvgl/obj
LOG=$A/lvgl-build.log
mkdir -p "$OBJ" "$STAGE/usr/lib" "$STAGE/usr/bin" "$STAGE/usr/include"
: > "$LOG"

[ -d "$LV" ] || { echo "lvgl source missing"; exit 1; }

# compile all of src/ + demos/ in parallel
find "$LV/src" "$LV/demos" -name '*.c' -print0 |
  xargs -0 -P "$NJ" -n1 "$A/lvgl/cc1.sh"

grep -c OBJFAIL "$LOG" | xargs echo "failed objects:"
riscv32-linux-musl-ar rcs "$STAGE/usr/lib/liblvgl.a" "$OBJ"/*.o
cp -a "$LV/lvgl.h" "$LV/lv_conf_template.h" "$STAGE/usr/include/" 2>/dev/null
cp -a "$LV/src" "$STAGE/usr/include/lvgl_src" 2>/dev/null
mkdir -p "$STAGE/usr/include/lvgl"
cp -a "$LV"/*.h "$STAGE/usr/include/lvgl/" 2>/dev/null
cp -a "$LV/src" "$LV/demos" "$LV/examples" "$STAGE/usr/include/lvgl/" 2>/dev/null

# demo app
$CC "$A/lvgl/main.c" "$STAGE/usr/lib/liblvgl.a" -o "$STAGE/usr/bin/lvgl_demo" -lm >>"$LOG" 2>&1 \
    && riscv32-linux-musl-strip "$STAGE/usr/bin/lvgl_demo" \
    && echo "PASS lvgl_demo" || echo "FAIL lvgl_demo"

# merge into rootfs
cp -a "$STAGE/usr/." "$ROOTFS/usr/" && echo "merged lvgl into rootfs"
ls -la "$ROOTFS/usr/bin/lvgl_demo"
