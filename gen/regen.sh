#!/bin/sh
# Regenerate rtl/AlvxChip.v from the vendored VexRiscv/SpinalHDL sources.
# Requires sbt (>/home/li/tools/sbt) + the coursier-cached spinalhdl jars.
set -e
cd "$(dirname "$0")"

/home/li/tools/sbt/bin/sbt "runMain vexriscv.demo.AlvxGen" "$@"

# AlvxChip.v lands in CWD; re-apply the cpu_dbg probe patch then install.
cp AlvxChip.v ../rtl/AlvxChip.v
python3 <<'EOF'
p = '../rtl/AlvxChip.v'
s = open(p).read()
old_port = "  input  wire          debugReset\n);"
assert s.count(old_port) >= 1, "debugReset port anchor not found"
s = s.replace(old_port,
              "  input  wire          debugReset,\n"
              "  output wire [31:0]   cpu_dbg\n);", 1)
anchor = "  assign execute_BranchPlugin_eq"
assert s.count(anchor) == 1, "cpu_dbg anchor not found"
dbg = '''  assign cpu_dbg = {
    /* [31]    */ DebugPlugin_resetIt_regNext,
    /* [30]    */ DebugPlugin_haltIt,
    /* [29]    */ DebugPlugin_stepIt,
    /* [28]    */ IBusCachedPlugin_fetcherHalt,
    /* [27]    */ IBusCachedPlugin_fetchPc_booted,
    /* [26]    */ IBusCachedPlugin_fetchPc_output_valid,
    /* [25]    */ IBusCachedPlugin_fetchPc_output_ready,
    /* [24]    */ iBus_cmd_valid,
    /* [23]    */ iBus_cmd_ready,
    /* [22]    */ iBusAvalon_waitRequestn,
    /* [21]    */ iBusAvalon_read,
    /* [20]    */ iBus_rsp_valid,
    /* [19]    */ IBusCachedPlugin_incomingInstruction,
    /* [18]    */ execute_arbitration_isValid,
    /* [17]    */ memory_arbitration_isValid,
    /* [16]    */ writeBack_arbitration_isValid,
    /* [15:0]  */ IBusCachedPlugin_fetchPc_pc[15:0]
  };
'''
s = s.replace(anchor, dbg + anchor)
open(p,'w').write(s)
print("rtl/AlvxChip.v installed (+cpu_dbg)")
EOF
