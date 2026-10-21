#!/bin/bash
# gen_initramfs_spec.sh — emit a gen_init_cpio spec for linux/rootfs.
# usage: ./gen_initramfs_spec.sh > out/initramfs.spec
set -e
cd "$(dirname "$0")/rootfs"
echo "dir /dev 755 0 0"
echo "nod /dev/console 644 0 0 c 5 1"
echo "nod /dev/null 644 0 0 c 1 3"
find . -mindepth 1 ! -path './dev*' | while read -r f; do
	p="/${f#./}"
	if [ -L "$f" ]; then echo "slink $p $(readlink "$f") 777 0 0"
	elif [ -d "$f" ]; then echo "dir $p 755 0 0"
	elif [ -x "$f" ]; then echo "file $p $PWD/${f#./} 755 0 0"
	else echo "file $p $PWD/${f#./} 644 0 0"; fi
done
