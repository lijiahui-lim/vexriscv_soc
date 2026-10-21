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

# ---- verilator sim -------------------------------------------------------
obj_dir/Vsim_top: sim/sim_top.v sim/sim_main.cpp $(RTL) sim/sim_emif.v
	$(VERILATOR) --cc --exe --build -O2 -Wno-fatal --trace --top-module sim_top \
	    -GBOOT_HEX='"$(BOOT_HEX)"' \
	    -o Vsim_top \
	    $(RTL) sim/sim_emif.v sim/sim_top.v sim/sim_main.cpp

BOOT_HEX ?= sw/boot.hex

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

clean:
	rm -rf obj_dir sw/*.elf sw/*.bin sw/boot.hex

.PHONY: all sim clean
