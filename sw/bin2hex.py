#!/usr/bin/env python3
# bin -> $readmemh word file (one 32-bit little-endian word per line)
# also emits <out>.b0..b3 (byte lanes) for Quartus-friendly 4x8bit RAM init
import sys
data = open(sys.argv[1], "rb").read()
data += b"\x00" * ((-len(data)) % 4)
with open(sys.argv[2], "w") as f:
    for i in range(0, len(data), 4):
        w = int.from_bytes(data[i:i+4], "little")
        f.write(f"{w:08x}\n")
lanes = [open(f"{sys.argv[2]}.b{b}", "w") for b in range(4)]
for i in range(0, len(data), 4):
    for b in range(4):
        lanes[b].write(f"{data[i+b]:02x}\n")
for f in lanes:
    f.close()
