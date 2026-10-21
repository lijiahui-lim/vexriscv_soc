#!/bin/bash
# build.sh — build the full Linux boot blob for the ALVX SoC:
#   busybox (static musl rv32ima) -> initramfs spec -> kernel Image
#   -> dtb -> opensbi fw_payload -> sdcard.img
# output: linux/out/fw_payload.bin, linux/out/sdcard.img, linux/out/alvx.dtb
set -e
cd "$(dirname "$0")"
L=$PWD
SRC=$L/src
OUT=$L/out
KDIR=$SRC/linux-6.12.57
ODIR=$SRC/opensbi-1.7
BB=$SRC/busybox-1.36.1
TC32=/opt/riscv-toolchains/Xuantie-900-gcc-linux-6.6.0-musl32-x86_64-V3.2.0/bin/riscv32-unknown-linux-musl-
TC_USR=$L/toolchain-rv32ima/bin/riscv32-linux-musl-
CROSS_KERNEL=$TC32        # freestanding: no libc needed
mkdir -p "$OUT"

KARCH="ARCH=riscv CROSS_COMPILE=$CROSS_KERNEL"

step() { echo "======== $* ========"; }

# ---------------- busybox + rootfs + initramfs spec ----
step busybox
[ -d "$BB" ] || tar -xjf "$SRC/busybox-1.36.1.tar.bz2" -C "$SRC"
if [ ! -f "$BB/busybox" ]; then
    [ -x "${TC_USR}gcc" ] || { echo "rv32ima toolchain missing: build musl-cross-make first"; exit 1; }
    make -C "$BB" ARCH=riscv CROSS_COMPILE=$TC_USR defconfig
    sed -i 's/^# CONFIG_STATIC is not set/CONFIG_STATIC=y/;
            s/^CONFIG_NANDWRITE=y/# CONFIG_NANDWRITE is not set/;
            s/^CONFIG_NANDDUMP=y/# CONFIG_NANDDUMP is not set/;
            s/^CONFIG_HWCLOCK=y/# CONFIG_HWCLOCK is not set/;
            s/^CONFIG_UBI[A-Z]*=y/# &/' "$BB/.config"
    make -C "$BB" ARCH=riscv CROSS_COMPILE=$TC_USR oldconfig </dev/null
    make -C "$BB" ARCH=riscv CROSS_COMPILE=$TC_USR -j"$(nproc)"
fi
rm -rf "$L/rootfs"
make -C "$BB" ARCH=riscv CROSS_COMPILE=$TC_USR \
    CONFIG_PREFIX="$L/rootfs" install >/dev/null
rm -f "$L/rootfs/linuxrc"
mkdir -p "$L/rootfs"/{dev,proc,sys,tmp,root,etc/init.d,mnt/sd}
cat > "$L/rootfs/init" <<'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev 2>/dev/null || { mknod /dev/console c 5 1; mknod /dev/null c 1 3; }
mount -t tmpfs none /tmp
echo "=========================================="
echo " ALVX VexRiscv RV32IMA+Sv32 Linux"
echo "=========================================="
[ -b /dev/mmcblk0p1 ] && mount -t vfat /dev/mmcblk0p1 /mnt/sd 2>/dev/null && echo "SD mounted at /mnt/sd"
export HOME=/root PATH=/bin:/sbin:/usr/bin:/usr/sbin
exec /bin/sh
EOF
chmod +x "$L/rootfs/init"
"$L/gen_initramfs_spec.sh" > "$OUT/initramfs.spec"

# ---------------- kernel -------------------------------
step kernel
[ -d "$KDIR" ] || tar -xJf "$SRC/linux-6.12.57.tar.xz" -C "$SRC"
bash "$L/install_drivers.sh" "$KDIR"

if [ ! -f "$KDIR/.config" ]; then
    make -C "$KDIR" $KARCH defconfig
    "$KDIR/scripts/kconfig/merge_config.sh" -m -O "$KDIR" \
        "$KDIR/.config" \
        "$KDIR/arch/riscv/configs/32-bit.config" \
        "$L/alvx_fragment.config"
fi
# initramfs spec + EFI/ISA-C must be right even on rebuilds
"$KDIR/scripts/config" --file "$KDIR/.config" \
    --set-str INITRAMFS_SOURCE "$OUT/initramfs.spec" \
    --disable EFI --disable RISCV_ISA_C --enable SERIAL_ALVX \
    --enable SERIAL_ALVX_CONSOLE --enable SPI_ALVX
make -C "$KDIR" $KARCH olddefconfig
make -C "$KDIR" $KARCH -j"$(nproc)" Image
make -C "$KDIR" $KARCH -j"$(nproc)" scripts_dtc || true

# ---------------- dtb ----------------------------------
DTC="$KDIR/scripts/dtc/dtc"
[ -x "$DTC" ] || DTC=dtc
"$DTC" -I dts -O dtb -o "$OUT/alvx.dtb" "$L/dts/alvx.dts"

# ---------------- opensbi fw_payload --------------------
step opensbi
cp "$L/opensbi/serial/alvx-uart.c"      "$ODIR/lib/utils/serial/"
cp "$L/opensbi/serial/fdt_serial_alvx.c" "$ODIR/lib/utils/serial/"
cp "$L/opensbi/include/alvx-uart.h"     "$ODIR/include/sbi_utils/serial/"

# one-time registration (idempotent guards)
grep -q 'FDT_SERIAL_ALVX' "$ODIR/lib/utils/serial/Kconfig" || \
sed -i '/^config FDT_SERIAL_LITEX/i config FDT_SERIAL_ALVX\n\tbool "ALVX Apb3UartCtrl FDT driver"\n\tselect SERIAL_ALVX\n\tdefault n\n' \
    "$ODIR/lib/utils/serial/Kconfig"
grep -q 'config SERIAL_ALVX' "$ODIR/lib/utils/serial/Kconfig" || \
sed -i '/^config SERIAL_LITEX/i config SERIAL_ALVX\n\tbool "ALVX Apb3UartCtrl support"\n\tdefault n\n' \
    "$ODIR/lib/utils/serial/Kconfig"
grep -q 'fdt_serial_alvx' "$ODIR/lib/utils/serial/objects.mk" || \
sed -i 's|^libsbiutils-objs-$(CONFIG_FDT_SERIAL_LITEX) += serial/fdt_serial_litex.o|&\n\ncarray-fdt_serial_drivers-$(CONFIG_FDT_SERIAL_ALVX) += fdt_serial_alvx\nlibsbiutils-objs-$(CONFIG_FDT_SERIAL_ALVX) += serial/fdt_serial_alvx.o|' \
    "$ODIR/lib/utils/serial/objects.mk"
grep -q 'serial/alvx-uart' "$ODIR/lib/utils/serial/objects.mk" || \
sed -i 's|^libsbiutils-objs-$(CONFIG_SERIAL_LITEX) += serial/litex-uart.o|&\nlibsbiutils-objs-$(CONFIG_SERIAL_ALVX) += serial/alvx-uart.o|' \
    "$ODIR/lib/utils/serial/objects.mk"
grep -q 'FDT_SERIAL_ALVX' "$ODIR/platform/generic/configs/defconfig" || \
    echo "CONFIG_FDT_SERIAL_ALVX=y" >> "$ODIR/platform/generic/configs/defconfig"

make -C "$ODIR" PLATFORM=generic \
    PLATFORM_RISCV_XLEN=32 PLATFORM_RISCV_ABI=ilp32 \
    PLATFORM_RISCV_ISA=rv32ima_zicsr_zifencei \
    CROSS_COMPILE=$CROSS_KERNEL \
    FW_TEXT_START=0x40000000 FW_PAYLOAD=y \
    FW_PAYLOAD_PATH="$KDIR/arch/riscv/boot/Image" \
    FW_FDT_PATH="$OUT/alvx.dtb" \
    -j"$(nproc)"

cp "$ODIR/build/platform/generic/firmware/fw_payload.bin" "$OUT/fw_payload.bin"

# ---------------- sd image -----------------------------
bash "$L/mksdimg.sh"
ls -la "$OUT/fw_payload.bin" "$OUT/sdcard.img"
echo "==== blob ready: $OUT/fw_payload.bin ===="
