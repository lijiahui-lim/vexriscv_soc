#!/bin/bash
# mksdimg.sh — build the raw SD image: LBA1 header + payload at LBA64.
#   dd if=linux/out/sdcard.img of=/dev/sdX
set -e
cd "$(dirname "$0")"
OUT=$PWD/out
PAY=$OUT/fw_payload.bin
IMG=$OUT/sdcard.img
HDR_LBA=1
PAY_LBA=64

size=$(stat -c %s "$PAY")
python3 - "$IMG" $size $HDR_LBA $PAY_LBA <<EOF
import struct, sys
img, size, hlba, plba = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4])
hdr = struct.pack('<III', 0x4C565841, size, plba) + b'\0' * (512 - 12)
pad = b'\0' * 512
open(img, 'wb').write(
    pad * hlba + hdr +                       # sector hlba = header
    pad * (plba - hlba - 1))                 # pad to payload lba
EOF
cat "$PAY" >> "$IMG"
echo "sdcard.img: payload $size bytes at LBA$PAY_LBA"
echo "write:  sudo dd if=$IMG of=/dev/sdX bs=1M status=progress"
