# test_magic.tcl — does the JTAG magic-wake path actually work?
# Writes `j .` (0x0000006f) at DDR 0x40000000, then magic @0x46000000,
# then probes the mailbox to see if the CPU left the boot_ram poll loop.
set mps [get_service_paths master]
set mp ""; set mb ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p } else { set mb $p }
}
puts "ddr-master: $mp"
puts "mbox-master: $mb"
open_service master $mp

# 1) trampoline: infinite loop at 0x40000000
master_write_32 $mp 0 [list 0x0000006f]
puts "trampoline written, readback:"
set v [lindex [master_read_32 $mp 0 1] 0]
puts [format "  @0x40000000 = 0x%08x" [expr {$v & 0xFFFFFFFF}]]

# 2) release magic
master_write_32 $mp [expr {0x6000000}] [list 0xC0DE0007]
puts "magic written"
close_service master $mp

after 500

# 3) mailbox: w8..w12 (fab_hb, ibus, dbus, last_dbus, cpu_dbg)
open_service master $mb
set vals [master_read_32 $mb [expr {8*4}] 5]
puts "w8 fab_hb  w9 ibus w10 dbus w11 lastdb w12 cpu_dbg:"
foreach x $vals { puts [format "  0x%08x" [expr {$x & 0xFFFFFFFF}]] }
set vals2 [master_read_32 $mb [expr {8*4}] 5]
puts "again (500ms later):"
foreach x $vals2 { puts [format "  0x%08x" [expr {$x & 0xFFFFFFFF}]] }
close_service master $mb
puts "done"
