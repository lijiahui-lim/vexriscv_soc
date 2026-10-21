# verify test1 DDR pattern at DDR+0x10000 (pattern = 0xA5A50000 ^ i)
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { set mp [lindex $mps 0] }
puts "using $mp"
open_service master $mp
# try word-address 0x4000 (byte 0x10000 in 32b-word units)
set v [master_read_32 $mp 16384 12]
puts "words @0x4000:"
foreach x $v { puts [format "  0x%08x" [expr {$x & 0xFFFFFFFF}]] }
# byte-enable result word: d[64] -> word offset 64
set w64 [master_read_32 $mp 16448 1]
puts [format "d64=0x%08x (expect 0x00007700)" [expr {[lindex $w64 0] & 0xFFFFFFFF}]]
close_service master $mp
