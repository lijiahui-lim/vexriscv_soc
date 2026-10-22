# vexriscv_soc — Linux-capable VexRiscv SoC for AL156A (Arria V)

A complete, self-contained RISC-V SoC that boots Linux on the
**AL156A Arria V** FPGA board (`5AGXMA3D4F31I3`). Single-core
**RV32IMA + Sv32 MMU** VexRiscv with caches, CLINT, PLIC, DDR3L,
UART console, SD-over-SPI storage and HDMI video out — verified
end-to-end on real hardware: OpenSBI → Linux 6.12 → BusyBox
interactive shell at 115200 8N1.

```
OpenSBI v1.7  →  Linux 6.12.57 riscv32  →  mmc0: SDHC 16 GiB  →  / #
/ # uname -a
Linux (none) 6.12.57 #8 riscv32 GNU/Linux
/ # free
             total    used    free
Mem:        749224   11680  735620
```

## Features

| Block | Detail |
|---|---|
| CPU | VexRiscv single-core RV32IMA (no C), Sv32 MMU, 4 KiB I$ + 4 KiB D$ |
| DDR | DDR3L 768 MiB via Intel UniPHY EMIF (mem clk 300 MHz, afi_clk 150 MHz, fabric 125 MHz) |
| Interrupts | CLINT (timer/MSIP) + PLIC (uart=src1, spi=src2, key=src3) |
| UART | Apb3UartCtrl @ `0xf1004000`, 115200 8N1, console `ttyALV0` |
| Storage | Apb3SpiMasterCtrl @ `0xf1005000` → mmc_spi → SDHC card (`mmcblk0`) |
| Video | VideoDma + VgaCtrl + TMDS encoders → HDMI, framebuffer @ `0x58000000`, kernel `simplefb` |
| Debug | JTAG masters (DDR access + read-only status mailbox) via System Console |
| Software | OpenSBI 1.7 `fw_payload` + Linux 6.12.57 + BusyBox initramfs, all RV32IMA |

## Repository layout

- `gen/` — vendored VexRiscv + `AlvxGen.scala`/`AlvxApb.scala`
  generators (self-contained; `cd gen && ./regen.sh` regenerates
  `rtl/AlvxChip.v`)
- `rtl/` — handwritten fabric (`soc.v`: avl_demux ×2 + avl_mux for
  iBus/dBus/video into the DDR bridge, avl_cdc, avl2axil, avl2apb,
  boot_ram) + generated `AlvxChip.v`
- `sw/` — bare-metal tests: `test1` smoke, `test2` Sv32/MMU,
  `test3` SD+video, `test4` UART RX; `boot_linux.c` = SD/JTAG
  bootloader living in boot RAM
- `sim/` — Verilator top + UniPHY DDR model (`make sim`, `sim2`,
  `sim3`, `simlinux`)
- `fpga/` — Quartus project: `top.v`, EMIF/PLL tcl, `vex_soc.qsf/.sdc`,
  `build_hw.sh`, System Console probe scripts
- `linux/` — kernel build (`build.sh`), custom drivers
  (`drivers/tty/serial/alvx_uart.c`, `drivers/spi/spi-alvx.c`),
  `dts/alvx.dts`, OpenSBI platform glue, `mksdimg.sh`

## Address map

| range | target |
|---|---|
| `0x0000_0000–0x0000_7fff` | boot RAM, 32 KiB ($readmemh init) |
| `0x4000_0000–0x7fff_ffff` | DDR window (Linux payload @ base) |
| `0xf000_0000–0xf000_ffff` | CLINT |
| `0xf100_0000` | APB base (GPIO +0, UART +0x4000, SPI +0x5000, video +0x7000) |
| `0xfc00_0000–0xfc3f_ffff` | PLIC |

## Simulation (Verilator 5.049)

```bash
make sim    # test1 smoke: UART/sysid/DDR/CLINT          -> DONE
make sim2   # test2: Sv32 satp, VA alias, page fault, timer irq -> MMU PASS
make sim3   # test3s: framebuffer + SD cmd path           -> DONE
make simlinux   # full OpenSBI->Linux boot (slow; ~hours wall-clock)
```

Testbench features (all opt-in env vars): `SIM_STOP=<str>` halt on
UART string, `UART_INJECT="…"` bit-level RX stimulus,
`MMIO_TRACE`/`TXD_EDGES`/`UART_HEX`/`SIM_DUMP=<ticks>` diagnostics,
stall watchdog. `uart.log` captures decoded TX.

## FPGA build (Quartus Prime Std 18.1)

```bash
scp fpga/* <buildhost>:~/vex_soc/ && scp rtl/*.v <buildhost>:~/vex_soc/rtl/
ssh <buildhost> 'cd ~/vex_soc && ./build_hw.sh'   # qsys + map + fit + asm + sta
```

`build_hw.sh` regenerates the EMIF Qsys system, runs the full flow,
and reports `STA VIOLATED markers: 0` on success. Boot software lives
in `sw/bootl.hex.b0..b3` — change it and rerun `quartus_map`.

Program via a JTAG server cable:

```bash
quartus_pgm -m jtag -o "p;output_files/vex_soc.sof" \
    --cable="USB-BlasterII on <jtaghost>"
```

## Linux image & SD boot

```bash
cd linux && ./build.sh      # busybox -> initramfs -> kernel -> opensbi fw_payload
./mksdimg.sh                # out/sdcard.img = header + payload
sudo dd if=out/sdcard.img of=/dev/sdX bs=1M status=progress && sync
```

Boot flow: `boot_linux` (boot RAM) enables video, reads SD header
@LBA1 `{magic,size,lba}` + payload @LBA64 into `0x40000000`, jumps.
Fallback: JTAG magic word @ `0x46000000` (`fpga/load_blob.tcl`).

**Serial console**: 115200 8N1 on `ttyUSB*` — attach exactly **one**
consumer (`minicom`/`cat`), `stty -F /dev/ttyUSBx 115200 raw -echo`.
Multiple readers split the byte stream and look exactly like FPGA RX
corruption.

## Debug channel (dbg_ram mailbox, System Console via `phy_2`)

| word | content |
|---|---|
| w0/w1/w8 | magic `0xD3B8…`+flags / heartbeat / fabric heartbeat |
| w2–w7 | DDR bridge state |
| w9/w10 | iBus/dBus accepted+readdatavalid counters |
| w11/w12 | last dBus address / cpu_dbg (haltIt, booted, pc[15:0]…) |
| w13 | resets & PLL lock status |
| w15–w18 | pending i/d-bus command latches (addr + stall counters) |
| w19/w20 | execute-stage instruction / fetchPc[31:16]+halt reasons |
| w14/w31 | video status / `0xC0DE0005` sentinel |

`fpga/probe_soc.tcl` decodes the whole mailbox in one shot.

## Verified status

- Hardware: full boot to interactive BusyBox shell — `echo`, `uname`,
  `cat /proc/interrupts`, `free` all clean; PLIC irq1 counts, no
  `Disabling IRQ` storms; STA clean at 0 violated paths
- Simulation: test1/2/3s/4 all pass post-refactor
- Notable fixes along the way: `misa` 'S' bit for OpenSBI cold-boot
  lottery, `avl_mux` read-response routing race (deterministic
  deadlock under CPU-refill vs VideoDma contention), `config_port`
  `port->type` restore (console registration), TX-interrupt storm,
  `SPI_CS_HIGH` polarity

## License

GNU General Public License v3.0 — see [LICENSE](LICENSE).
Vendored components keep their own licenses (VexRiscv: MIT;
generated `AlvxChip.v` derives from VexRiscv).
