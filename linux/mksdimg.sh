#!/bin/bash
# mksdimg.sh — build the raw SD image:
#   LBA0  MBR: p1 = ext4 rootfs @LBA131072 (64 MiB, after payload)
#   LBA1  boot header {magic, payload size, payload lba}
#   LBA64 boot payload (fw_payload.bin: opensbi+kernel+initramfs)
#   LBA131072  rootfs.ext4 (if img/rootfs.ext4 exists)
#   dd if=linux/out/sdcard.img of=/dev/sdX
set -e
cd "$(dirname "$0")"
OUT=$PWD/out
PAY=$OUT/fw_payload.bin
IMG=$OUT/sdcard.img
RFS=/home/li/work/altera/rootfs/img/rootfs.ext4
HDR_LBA=1
PAY_LBA=64
RFS_LBA=131072        # 64 MiB — payload ~30 MB fits below

size=$(stat -c %s "$PAY")
have_rfs=0; rfs_sec=0
[ -f "$RFS" ] && have_rfs=1 && rfs_sec=$(( $(stat -c %s "$RFS") / 512 ))

python3 - "$IMG" $size $HDR_LBA $PAY_LBA $RFS_LBA $have_rfs $rfs_sec <<EOF
import struct, sys
img, size, hlba, plba, rlba, have, rsec = sys.argv[1:8]
size, hlba, plba, rlba, have, rsec = \
    int(size), int(hlba), int(plba), int(rlba), int(have), int(rsec)
hdr = struct.pack('<III', 0x4C565841, size, plba) + b'\0' * (512 - 12)

# MBR: one Linux partition covering the rootfs area
mbr = bytearray(512)
if have:
    pe = struct.pack('<B3sB3sII',
        0x00, b'\xfe\xff\xff', 0x83, b'\xfe\xff\xff', rlba, rsec)
    mbr[0x1BE:0x1BE+16] = pe
    mbr[510:512] = b'\x55\xaa'

pad = b'\0' * 512
open(img, 'wb').write(
    bytes(mbr) +                           # sector 0 = MBR w/ p1
    pad * (hlba - 1) + hdr +               # sector 1  = boot header
    pad * (plba - hlba - 1))               # pad to payload lba
EOF

cat "$PAY" >> "$IMG"
echo "sdcard.img: payload $size bytes at LBA$PAY_LBA"

if [ "$have_rfs" = 1 ]; then
    # append rootfs at LBA131072 (truncate img to that offset, then cat)
    python3 - "$IMG" $RFS_LBA <<'EOF'
import sys
img, rlba = sys.argv[1], int(sys.argv[2])
with open(img, 'ab') as f:
    f.truncate(rlba * 512)
EOF
    cat "$RFS" >> "$IMG"
    echo "sdcard.img: rootfs $((rfs_sec*512)) bytes at LBA$RFS_LBA (p1)"
fi
echo "write:  sudo dd if=$IMG of=/dev/sdX bs=1M status=progress"
