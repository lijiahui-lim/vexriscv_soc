# fb_peek.tcl: sample framebuffer words at a few offsets
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { set mp [lindex $mps 0] }
open_service master $mp
set FB 0x58000000
foreach {name off} {top 0  line100 512000  mid 1843200  bot 3600000} {
    set v [master_read_32 $mp [expr {$FB + $off}] 8]
    puts "$name @+0x[format %x $off]:"
    foreach x $v { puts [format "  0x%08x" [expr {$x & 0xFFFFFFFF}]] }
}
close_service master $mp
