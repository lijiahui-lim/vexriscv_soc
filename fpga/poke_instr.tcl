# write 'j .' (0x0000006f) at DDR word 5 (byte 0x14), then watch counters
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
open_service master $mp
master_write_32 $mp 20 [list 0x0000006f]
set v [lindex [master_read_32 $mp 20 1] 0]
puts [format "word5 now = 0x%08x" [expr {$v & 0xFFFFFFFF}]]
close_service master $mp
