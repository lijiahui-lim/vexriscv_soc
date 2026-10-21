# dump_ddr.tcl — dump a DDR region via phy_1 (byte addresses)
# args baked in; output raw words to stdout
set base 0x41cb4000
set len  [expr {96*1024/4}]
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_1" $p] >= 0} { set mp $p }
}
if {$mp == ""} { puts "no phy_1"; exit }
open_service master $mp
puts "DUMP_START $base"
for {set i 0} {$i < $len} {incr i 256} {
    set a [expr {$base + $i*4}]
    set chunk [master_read_32 $mp $a 256]
    foreach w $chunk { puts [format "%08x" $w] }
}
close_service master $mp
puts "DUMP_END"
