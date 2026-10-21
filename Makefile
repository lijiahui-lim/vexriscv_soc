# vexriscv_soc build: bare-metal sw -> boot.hex -> verilator sim
CROSS  = /opt/riscv-toolchains/Xuantie-900-gcc-elf-newlib-x86_64-V3.2.0/bin/riscv64-unknown-elf-
CC     = $(CROSS)gcc
OBJCOPY= $(CROSS)objcopy
CFLAGS = -march=rv32ima_zicsr -mabi=ilp32 -Os -nostdlib -nostartfiles -ffreestanding
VERILATOR = /opt/oss-cad-suite/bin/verilator

RTL = rtl/AlvxChip.v rtl/soc.v rtl/avl_demux.v rtl/avl_mux.v rtl/avl_cdc.v \
      rtl/avl2axil.v rtl/avl2apb.v rtl/boot_ram.v rtl/ddr_avl_bridge.v

all: sim

# ---- bare-metal software ------------------------------------------------
sw/test1.elf: sw/crt0.S sw/test1.c sw/link.ld
	$(CC) $(CFLAGS) -T sw/link.ld sw/crt0.S sw/test1.c -o $@

sw/test2.elf: sw/crt0.S sw/trap.S sw/test2.c sw/link.ld
	$(CC) $(CFLAGS) -T sw/link.ld sw/crt0.S sw/trap.S sw/test2.c -o $@

sw/boot.hex: sw/test1.elf
	$(OBJCOPY) -O binary $< sw/test1.bin
	python3 sw/bin2hex.py sw/test1.bin $@

sw/test3.elf: sw/crt0.S sw/test3.c sw/link.ld
	$(CC) $(CFLAGS) -T sw/link.ld sw/crt0.S sw/test3.c -o $@

sw/boot2.hex: sw/test2.elf
	$(OBJCOPY) -O binary $< sw/test2.bin
	python3 sw/bin2hex.py sw/test2.bin $@

sw/boot3.hex: sw/test3.elf
	$(OBJCOPY) -O binary $< sw/test3.bin
	python3 sw/bin2hex.py sw/test3.bin $@

sw/test3s.elf: sw/crt0.S sw/test3.c sw/link.ld
	$(CC) $(CFLAGS) -DFB_ROWS=16 -T sw/link.ld sw/crt0.S sw/test3.c -o $@

sw/boot3s.hex: sw/test3s.elf
	$(OBJCOPY) -O binary $< sw/test3s.bin
	python3 sw/bin2hex.py sw/test3s.bin $@

sw/boot_linux.elf: sw/crt0.S sw/boot_linux.c sw/link.ld
	$(CC) $(CFLAGS) -march=rv32ima_zicsr_zifencei -T sw/link.ld sw/crt0.S sw/boot_linux.c -o $@

sw/bootl.hex: sw/boot_linux.elf
	$(OBJCOPY) -O binary $< sw/boot_linux.bin
	python3 sw/bin2hex.py sw/boot_linux.bin $@

sw/bootl_sim.elf: sw/crt0.S sw/boot_linux.c sw/link.ld
	$(CC) $(CFLAGS) -DBOOT_SIM -march=rv32ima_zicsr_zifencei -T sw/link.ld sw/crt0.S sw/boot_linux.c -o $@

sw/bootls.hex: sw/bootl_sim.elf
	$(OBJCOPY) -O binary $< sw/bootl_sim.bin
	python3 sw/bin2hex.py sw/bootl_sim.bin $@

# ---- verilator sim -------------------------------------------------------
obj_dir/Vsim_top: sim/sim_top.v sim/sim_main.cpp $(RTL) sim/sim_emif.v
	$(VERILATOR) --cc --exe --build -O2 -Wno-fatal --trace --top-module sim_top \
	    -GBOOT_HEX='"$(BOOT_HEX)"' \
	    -GDDR_WORDS=$(DDR_WORDS) \
	    -GDDR_HEX='"$(DDR_HEX)"' \
	    -o Vsim_top \
	    $(RTL) sim/sim_emif.v sim/sim_top.v sim/sim_main.cpp

BOOT_HEX ?= sw/boot.hex
DDR_WORDS ?= 65536
DDR_HEX ?=

# full-window linux boot sim: 768MB DDR model + preloaded fw_payload.
# BOOT_SIM bootloader skips SD/JTAG and jumps straight to 0x40000000.
linux/out/fw_payload.hex: linux/out/fw_payload.bin
	python3 -c "import struct; d=open('$<','rb').read(); f=open('$@','w'); [f.write('%08x\n' % struct.unpack_from('<I',d,i)[0]) for i in range(0,len(d),4)]"

simlinux: sw/bootls.hex linux/out/fw_payload.hex
	rm -rf obj_dir
	$(MAKE) obj_dir/Vsim_top BOOT_HEX=sw/bootls.hex \
	    DDR_WORDS=33554432 DDR_HEX=$(CURDIR)/linux/out/fw_payload.hex
	SIM_STALL=4000000 SIM_TICKS=2000000000 obj_dir/Vsim_top

sim: sw/boot.hex obj_dir/Vsim_top
	SIM_STOP=DONE obj_dir/Vsim_top

sim2: sw/boot2.hex
	rm -rf obj_dir
	$(MAKE) obj_dir/Vsim_top BOOT_HEX=sw/boot2.hex
	SIM_STOP=DONE obj_dir/Vsim_top

sim3: sw/boot3s.hex
	rm -rf obj_dir
	$(MAKE) obj_dir/Vsim_top BOOT_HEX=sw/boot3s.hex
	SIM_STOP=DONE obj_dir/Vsim_top

siml: sw/bootls.hex
	rm -rf obj_dir
	$(MAKE) obj_dir/Vsim_top BOOT_HEX=sw/bootls.hex
	SIM_STOP="jtag magic" obj_dir/Vsim_top

clean:
	rm -rf obj_dir sw/*.elf sw/*.bin sw/boot.hex

.PHONY: all sim clean
