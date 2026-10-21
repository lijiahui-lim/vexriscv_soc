#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
: "${QUARTUS_ROOTDIR:?Set QUARTUS_ROOTDIR to the Quartus 18.1 directory}"

export PATH="$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/sopc_builder/bin:$PATH"
cd "$ROOT"

# pull in the handwritten RTL + generated CPU + boot image (when the
# full vexriscv_soc tree is present; on the VM rtl/ is pushed directly)
if [ -d "$ROOT"/../rtl ]; then
    mkdir -p "$ROOT/rtl"
    cp -f "$ROOT"/../rtl/*.v "$ROOT/rtl/"
fi
[ -d "$ROOT" ] || true
cp -f "$ROOT"/../sw/boot.hex "$ROOT"/../sw/boot.hex.b* "$ROOT/" 2>/dev/null || true

qsys-script --script="$ROOT/make_pll.tcl"
qsys-script --script="$ROOT/make_emif.tcl"

mkdir -p "$ROOT/ip/synth"
qsys-generate "$ROOT/ip/vidpll.qsys" \
    --output-directory="$ROOT/ip/synth" --synthesis=VERILOG
qsys-generate "$ROOT/ip/emifsys.qsys" \
    --output-directory="$ROOT/ip/synth" --synthesis=VERILOG

# UniPHY generates required GLOBAL_SIGNAL and compensation assignments here.
# The tcl builds a post-map timing netlist, so map must run first.
# Omitting this step can cause far-global PLL feedback routing failures.
quartus_map vex_soc
PIN_TCL="$ROOT/ip/synth/synthesis/submodules/emifsys_emif_0_p0_pin_assignments.tcl"
quartus_sta -t "$PIN_TCL" vex_soc

quartus_sh --flow compile vex_soc

VIOLATIONS="$(grep -c 'VIOLATED' output_files/vex_soc.sta.rpt || true)"
WORST="$(grep -m1 'Worst-case Slack' output_files/vex_soc.sta.rpt \
    | sed 's/;/ /g' | xargs)"
echo "STA: $WORST"
echo "STA VIOLATED markers: $VIOLATIONS"
echo "SOF: $ROOT/output_files/vex_soc.sof"
