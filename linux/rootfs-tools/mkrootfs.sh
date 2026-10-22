#!/bin/bash
# mkrootfs.sh — assemble the ALVX ext4 rootfs for SD partition 1.
#   layout: busybox + musl + native gcc toolchain + make + /etc
#   output: $ROOTFS  (dir)  and  $IMG (ext4 image, ~1 GiB)
set -e
cd "$(dirname "$0")"
A=$PWD
SOC=/home/li/work/altera/vexriscv_soc
TC=$SOC/linux/toolchain-rv32ima          # cross toolchain (sysroot source)
BB=$SOC/linux/src/busybox-1.36.1
NATIVE=$A/native-toolchain               # mcm NATIVE=y output
ROOTFS=$A/rootfs
IMG=$A/img/rootfs.ext4
IMGSZ=1024M

step() { echo "== $*"; }

step "skeleton"
rm -rf "$ROOTFS"
mkdir -p "$ROOTFS"/{bin,sbin,etc,proc,sys,dev,tmp,mnt,root,usr/{bin,sbin,lib,include},opt,var,home}
chmod 1777 "$ROOTFS/tmp"

step "busybox"
[ -x "$BB/busybox" ] || { echo "busybox not built: run linux/build.sh first"; exit 1; }
make -C "$BB" ARCH=riscv \
    CROSS_COMPILE=$TC/bin/riscv32-linux-musl- \
    CONFIG_PREFIX="$ROOTFS" install >/dev/null
rm -f "$ROOTFS/linuxrc"

step "musl runtime libs (ld-musl + shared libs)"
mkdir -p "$ROOTFS/lib"
# prefer the NATIVE toolchain's sysroot (exact match for its gcc),
# fall back to the cross sysroot
LIBSRC="$TC/riscv32-linux-musl/lib"
[ -d "$NATIVE/riscv32-linux-musl/lib" ] && LIBSRC="$NATIVE/riscv32-linux-musl/lib"
cp -a "$LIBSRC/"*.so* "$ROOTFS/lib/" 2>/dev/null || true
cp -a "$TC/lib/gcc/riscv32-linux-musl/"*/libgcc*.so* "$ROOTFS/lib/" 2>/dev/null || true

step "/etc"
cat > "$ROOTFS/etc/passwd" <<'EOF'
root:x:0:0:root:/root:/bin/sh
EOF
cat > "$ROOTFS/etc/group" <<'EOF'
root:x:0:
EOF
cat > "$ROOTFS/etc/profile" <<'EOF'
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export HOME=/root
export PS1='\w # '
export CFLAGS="-O2"
EOF
cat > "$ROOTFS/etc/fstab" <<'EOF'
/dev/mmcblk0p1  /  ext4  rw,relatime  0 1
EOF
cat > "$ROOTFS/etc/motd" <<'EOF'
==========================================
 ALVX VexRiscv RV32IMA+Sv32 — ext4 rootfs
 gcc toolchain at /bin (gcc,g++,as,ld,make,strip,objdump,...)
==========================================
EOF

step "/init (switch_root target on real rootfs)"
cat > "$ROOTFS/init" <<'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev 2>/dev/null || { mknod /dev/console c 5 1; mknod /dev/null c 1 3; }
mount -t tmpfs none /tmp
mount -o remount,rw / 2>/dev/null
cat /etc/motd
export PATH=/bin:/sbin:/usr/bin:/usr/sbin HOME=/root PS1='\w # '
exec /bin/sh
EOF
chmod +x "$ROOTFS/init"

step "GNU make"
install -m755 "$A/src/make-4.4.1/make" "$ROOTFS/usr/bin/make" 2>/dev/null || \
    echo "  (make not built yet — will land on next run)"

step "native gcc toolchain (prefix=/, unpacked at root)"
if [ -d "$NATIVE/bin" ]; then
    STRIP=$TC/bin/riscv32-linux-musl-strip
    # mcm NATIVE=y configures --prefix= --with-sysroot=/ : the tree
    # maps straight onto the target root.
    for d in bin lib include libexec share riscv32-linux-musl; do
        [ -d "$NATIVE/$d" ] && cp -a "$NATIVE/$d" "$ROOTFS/"
    done
    # gcc's native header search hits /usr/include — land them there too
    cp -a "$NATIVE/include/." "$ROOTFS/usr/include/"
    # drop debug info — the board does not need 1 GiB of it
    find "$ROOTFS/bin" "$ROOTFS/libexec" "$ROOTFS/riscv32-linux-musl" \
         -type f -print0 2>/dev/null | xargs -0 "$STRIP" --strip-debug 2>/dev/null || true
    # convenience names in /usr/bin
    for b in gcc g++ cc c++ cpp make as ld ar nm objdump objcopy ranlib strip readelf size strings; do
        for c in "$ROOTFS/bin/$b" "$ROOTFS/bin/riscv32-linux-musl-$b"; do
            [ -x "$c" ] && ln -sf "${c#$ROOTFS}" "$ROOTFS/usr/bin/$b" && break
        done
    done
    du -sh "$ROOTFS"
else
    echo "  (native toolchain not ready — will land on next run)"
fi

step "common libs (mklibs.sh staging)"
if [ -d "$A/libs-stage/usr/lib" ]; then
    cp -a "$A/libs-stage/." "$ROOTFS/"
    ls "$ROOTFS/usr/lib/"*.so* | wc -l | xargs echo "  shared objects merged:"
else
    echo "  (libs-stage absent — run mklibs.sh first if libs wanted)"
fi

step "hello world sample"
cat > "$ROOTFS/root/hello.c" <<'EOF'
#include <stdio.h>
int main(void){ printf("hello from ALVX rv32ima!\n"); return 0; }
EOF

step "ext4 image ($IMGSZ)"
mkdir -p "$A/img"
rm -f "$IMG"
truncate -s "$IMGSZ" "$IMG"
# fakeroot -> files land root-owned in the image
fakeroot mkfs.ext4 -q -d "$ROOTFS" -L alvx-root "$IMG"
ls -la "$IMG"
echo "== done: $IMG"
