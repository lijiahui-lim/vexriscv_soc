# vexriscv_soc — VexRiscv SoC for AL156A (Arria V)

Single-core RV32IMA + Sv32 (MMU) SoC. Replaces the buggy Nios II reference
(`~/work/Altera/nios2_soc`) — same board, same proven EMIF/DDR3/HDMI plumbing,
new handwritten CPU fabric.

## Layout

- `gen/` — vendored VexRiscv sources (self-contained; the standalone
  `../VexRiscv` clone is NOT needed). `gen/src/main/scala/vexriscv/demo/
  AlvxGen.scala` = CPU+CLINT+PLIC+APB generator (`AlvxChip`);
  `AlvxApb.scala` = APB block incl. video. Regenerate:
  `cd gen && ./regen.sh` (sbt runMain + copy + cpu_dbg probe patch).
- `rtl/` — handwritten fabric + generated chip:
  - `AlvxChip.v` (generated: cpu 4KB/1-way i+d cache, MMU, CLINT, PLIC,
    APB block = Apb3UartCtrl/Apb3SpiMasterCtrl/Apb3Gpio×4/sysid/
    **video = VideoDma+VgaCtrl+TmdsEncoder×3**, JTAG)
  - `soc.v` fabric: avl_demux×2 (iBus/dBus) + avl_mux (DDR, 3 masters:
    iBus/dBus/vidMemAvalon)
  - `avl_cdc` fab→afi async bridge, `avl2axil` (CLINT/PLIC), `avl2apb`
  - `boot_ram` (1W2R M10K, $readmemh init), `ddr_avl_bridge`
- `sw/` — bare-metal tests: `test1` (smoke: UART/sysid/DDR r+w/BE/CLINT),
  `test2` (Sv32: satp, S-mode, VA alias, page fault, timer irq),
  `test3` (SD SPI init+MBR + video fb color bars; `test3s` =
  FB_ROWS=16 for sim). `make sim`/`sim2`/`sim3` under Verilator.
- `sim/` — `sim_top.v` (soc→cdc→avlbr→sim_emif), `sim_emif.v` (192-bit UniPHY
  model), `sim_main.cpp` (clock gen + UART decode at 1152 ticks/bit, writes
  `uart.log`; `SIM_STOP=DONE` halts on string, `UART_HEX=1` dumps bytes).
- `fpga/` — Quartus project: `top.v`, `make_emif.tcl` (emifsys.qsys =
  EMIF+rst_soft+jtagm+jtagm2+dbg_ram only, MEM_CLK **300** MHz → afi_clk
  150 MHz), `make_pll.tcl` (vidpll = 75/375/125 MHz), `vex_soc.qsf`/`sdc`,
  `build_hw.sh`, System Console probe scripts.

## Address map (soc.v)

| range                    | target                        |
|--------------------------|-------------------------------|
| 0x0000_0000-0x0000_7fff  | boot_ram 32KB (i+d)           |
| 0x4000_0000-0x7fff_ffff  | DDR window -> avlbr (i+d+fb)  |
| 0xf000_0000-0xf000_ffff  | CLINT (axil)                  |
| 0xf100_0000-0xf10f_ffff  | APB periph (uart@+0x4000 ...) |
| 0xf100_7000            | video regs (generated)        |
| 0xfc00_0000-0xfc3f_ffff  | PLIC (axil)                   |

Video path (all generated in AlvxApb, fab↔pix CDC inside VideoDma's
StreamFifoCC): APB `0x7000` regs — `+0` fb base in **32B units**,
`+4` burst count **−1**, `+8` bit0 enable (rising edge kicks first
frame, then re-armed at every vsync), `+0C` status `{busy<<1, underRun}`
(W1C clear). `vidMemAvalon` = 30-bit window-relative byte-addressed
read-only master (8-word bursts) → DDR arbiter slot 2. `tmds0/1/2` =
10-bit codes on `pix_clk` (b+g+r); `vid_status[3:0]` = {busy, underRun,
enable} exported for the JTAG mailbox. Board side only needs the
`serializer_10_to_1`+`ddio_out` primitives + `vidpll` (75/375/125 MHz).

## Simulation (local, /opt/oss-cad-suite Verilator 5.049)

- `make sim` — test1; `make sim2` — MMU test. Both print `DONE` on pass.
- UART: 8N1, divider 8 → bit period = (8+1)*8clk = 1152 sim ticks
  (UART_BIT_TICKS env).
- UART status [20:16] = TX FIFO *free slots* — poll `while ==0`.
- Do NOT use the VM for sim (no ModelSim installed); VM is build-only.

## Quartus build (VM master@192.168.2.160, Prime Std 18.1)

```bash
scp fpga/* master@192.168.2.160:~/vex_soc/   # + rtl/*.v -> ~/vex_soc/rtl/
ssh master@192.168.2.160 'cd ~/vex_soc &&
  export QUARTUS_ROOTDIR=/export/SoftWare/Altera/QuartusPrimeStd_2018/quartus
  export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/sopc_builder/bin:$PATH
  export LM_LICENSE_FILE=/export/SoftWare/Altera/QuartusPrimeStd_2018/licenses/license.dat
  ./build_hw.sh'
```
- `qsys-script` lives in `sopc_builder/bin`, not `quartus/bin`.
- Order matters: `quartus_map` FIRST, then `quartus_sta -t emifsys_emif_0_p0_
  pin_assignments.tcl` (needs post-map netlist), then full flow compile.
- Quartus needs explicit `generate/endgenerate` around module-scope for-loops
  (Verilator/Icarus accept bare ones — don't remove them).
- qsf sets `VERILOG_MACRO SYNTHESIS` — required, else Spinal's `$urandom`
  sim-init code breaks elaboration.
- Quartus 18.1 will NOT infer RAM from `mem[addr][7:0] <=` byte-select writes
  (falls back to ~262K FFs). `boot_ram` splits storage into four byte-wide
  arrays; init via `boot.hex.b0..b3` (bin2hex.py emits them); one always
  block per port → 8× M10K (2R needs RAM replication).
- Async-FIFO mem arrays read combinationally in rclk domain MUST be
  false-pathed in the sdc (`*avl_afifo*|mem~*`), else Quartus reports bogus
  ~1 ns wclk→rclk paths. The afifo also has a prefetch (FWFT) output reg so
  `rptr→mem→consumer` is a same-clock path — do not remove it (200 MHz).
- `ddr_avl_bridge` compare chain: `cur_word+1 vs counters` was too deep for
  afi_clk — head_match/miss compare against `wq_head_m1`/`ret_m1` shadow regs
  and the speculation arm is deferred one cycle (arm_r). Keep the shadows in
  sync or reads corrupt.
- MEM_CLK_FREQ is 300 (afi_clk 150 MHz). 333/400 fit intermittently but
  UniPHY-internal read_fifo→sequencer paths flip ±0.5 ns with seed; 300
  closes at 0 violations on every seed tried so far. Keep it unless a new
  build is re-validated; `grep -c VIOLATED output_files/vex_soc.sta.rpt`
  must be 0.
- EMIF assignments in qsf carry `-tag __emifsys_emif_0_p0`; regenerate via the
  pin tcl if the EMIF hierarchy changes (instance must stay `u_soc|emif_0`).

## Gotchas carried over from the reference

- `ddr_avl_bridge` MEM_WORDS must be `26'h2000000` (25-bit literal truncates
  to 0 → every read hangs, Quartus folds mavl_read to GND).
- `MEM_BL=OTF`, `BYTE_ENABLE=1`, `mavl_byteenable` must be driven.
- `mavl_beginbursttransfer` = 1-cycle pulse per new command.
- CPU `waitRequestn` and UniPHY `mavl_waitrequest_n` are ACTIVE-LOW.
- Avalon read burst = ONE accepted command, N readdatavalid beats; write
  burst = N accepted beats.
- Programming only via Windows jtagserver (`li@192.168.2.209`):
  `quartus_pgm -m jtag -o "p;output_files/vex_soc.sof"
   --cable="USB-BlasterII on 192.168.2.209"` (works from the VM).
- Mailbox (dbg_ram, read via jtagm2/System Console): w0={D3B8,flags}, w1=hb,
  w2..7=avlbr_dbg, w8=fab_hb, w9=ibus{rdv,acc}, w10=dbus{rdv,acc},
  w11=last dBus addr, w12=cpu_dbg (haltIt/fHalt/booted/pc[15:0]...),
  w13={cpu_rst_req,fab_rst_n,afi_rst_n,pll,glb_rst_n}, w14=vid_status,
  w31=0xC0DE0005.
  `open_service master $p` first; use the `phy_2` path only — `phy_1`
  reaches avlbr.s0 and every probe read adds DDR traffic.
- jtagm/jtagm2 master_read_32 addresses are BYTE offsets into the target
  window (DDR byte 0x10000 -> master addr 65536, not word 16384).
- **CPU bring-up**: DebugPlugin regs live in the `debugReset` domain.
  Tying `jtag_trst_n` high leaves them on Quartus-chosen power-up values —
  `DebugPlugin_haltIt` powered up 1 and the CPU never fetched (iBus/dBus
  counters all 0, booted=1, haltIt=1). soc.v now drives
  `debugReset = reset | ~jtag_trst_n`; keep that OR term or the CPU halts
  again on hardware (Verilator powers regs at 0 — sim will NOT catch this).
- **Boot image update**: `quartus_cdb --update_mif` reports "Processed"
  but does NOT rewrite `db/*.hdl.mif`, and overwriting the .hdl.mif by
  hand does not affect the SOF either (init lives in the fit database).
  To change boot software: update `boot.hex.b0..b3` and rerun
  `quartus_map` (+fit/asm). There is no working mif-only shortcut.
- On hardware, `master_read_32` on `phy_1` at addr 0 reads DDR byte 0;
  test1's pattern lives at byte 0x10000 (`0xA5A50000^i`), test2's alias
  result at byte 0x200000 (`0xC0FFEE11`/`0x55AA33CC`).

## Linux bring-up (linux/)
- `linux/build.sh` builds the whole boot blob:
  busybox (rv32ima musl, `linux/toolchain-rv32ima/` from musl-cross-make)
  -> initramfs dir -> kernel Image (rv32, `linux/src/linux-6.12.57`,
  `riscv32-unknown-linux-musl-` gcc — freestanding, no libc multilib needed)
  -> opensbi 1.7 generic `fw_payload` (XLEN=32, ISA=rv32ima_zicsr_zifencei,
  FW_TEXT_START=0x40000000, kernel at FW_PAYLOAD_OFFSET=0x400000, dtb embedded)
  -> `linux/out/fw_payload.bin`.
- Custom drivers live in `linux/drivers/{tty/serial/alvx_uart.c,
  spi/spi-alvx.c}` and are injected by `linux/install_drivers.sh`
  (Kconfig + Makefile). OpenSBI serial driver in `linux/opensbi/`.
- DTS `linux/dts/alvx.dts`: CLINT f0000000 (timebase 125MHz), PLIC fc000000
  (ctx0=M, ctx1=S), uart f1004000 irq1, spi f1005000 irq2 + mmc-spi-slot,
  fb simple-framebuffer @0x58000000 (reserved-memory).
- Boot flow: `sw/boot_linux.c` in boot_ram — enables video, tries SD
  (header @LBA1 {magic,size,lba}, payload @LBA64 via `linux/mksdimg.sh`),
  falls back to JTAG magic word @DDR+0x06000000 (`fpga/load_blob.tcl`
  uploads fw_payload.bin then writes magic). Jumps to 0x40000000 with
  a0=hartid(0), a1=0. Magic/scratch MUST sit above the ~38 MiB blob
  footprint (they are at 0x46000000/0x46000100, below the fb carve
  0x58000000); writing inside the blob corrupts the kernel image.
- Hardware PLIC note: `plicInterrupts[i]` IS source ID i (io_sources =
  plicInterrupts>>1); bit0 must be 0 — soc.v packs {key=3,spi=2,uart=1}.
- No misaligned access in HW: kernel uses RISCV_EMULATED_UNALIGNED_ACCESS.
- Kernel MUST be rv32ima with no C extension: riscv defconfig selects
  EFI which selects RISCV_ISA_C — the fragment disables BOTH
  (`# CONFIG_EFI is not set`, `# CONFIG_RISCV_ISA_C is not set`);
  disabling ISA_C alone loses to the EFI select. Verify with
  `readelf -h vmlinux` -> Flags 0x0 (no RVC).
- Userspace needs the local toolchain: `linux/toolchain-rv32ima/`
  (musl-cross-make, --with-arch=rv32ima --disable-multilib). The
  Xuantie linux-musl gcc only has rv32imac/rv32imafdc multilibs —
  fine for kernel/opensbi (-nostdlib), unusable for libc apps.
  musl-cross-make's linux-headers install leaves broken symlinks in
  the sysroot include (linux/, asm-generic/, mtd/, ...); fix by
  copying the real dirs from
  `linux/src/musl-cross-make/linux-headers-4.19.88-2/{generic,riscv32}/include/`.
  busybox applets needing headers the kit lacks (mtd-user.h, kd.h users):
  NANDWRITE, NANDDUMP, UBI*, HWCLOCK are disabled in build.sh.
- SPI chip-select: Apb3SpiMasterCtrl does `pin = ss ^ activeHigh`, so
  MODE reg (+0x08) bit4 must be 1 for active-low SD nCS. Divisor +0x0C
  gives f = fab/(2*div): 155 -> ~400 kHz (init), 4 -> 12.5 MHz (data).
