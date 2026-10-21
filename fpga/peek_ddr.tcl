# peek DDR low words via jtagm (the non-mailbox phy) - reads only
set mps [get_service_paths master]
puts "masters:"
set i 0
foreach p $mps { puts "  $i: $p"; incr i }
# pick a master that is NOT phy_2 (mailbox) -> the jtagm on avlbr.s0
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { set mp [lindex $mps 0] }
puts "using $mp"
open_service master $mp
# jtag_avl byte address 0x4000_0000 + off -> avlbr word off[29:2]
# read words 0..15 (bytes 0..0x3f)
set v [master_read_32 $mp 0 16]
puts "ddr words 0..15:"
foreach x $v { puts [format "  0x%08x" [expr {$x & 0xFFFFFFFF}]] }
close_service master $mp
