#!/bin/sh
# compile one lvgl source file -> flattened object name in obj dir
f="$1"
A=/home/li/work/altera/rootfs
LV=$A/lvgl/lvgl-9.2.2
OBJ=$A/lvgl/obj
TC=/home/li/work/altera/vexriscv_soc/linux/toolchain-rv32ima/bin
o=$OBJ/$(echo "$f" | sed "s|.*/lvgl-9.2.2/||; s|/|_|g; s|\.c$|.o|")
[ -f "$o" ] && exit 0
$TC/riscv32-linux-musl-gcc -O2 -DLV_CONF_INCLUDE_SIMPLE -I$A/lvgl -I$LV \
    -c "$f" -o "$o" >>$A/lvgl-build.log 2>&1 || echo "OBJFAIL $f" >>$A/lvgl-build.log
