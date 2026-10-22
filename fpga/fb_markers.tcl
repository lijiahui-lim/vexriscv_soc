# fb_markers.tcl: plant colored marker pixels at known fb positions via JTAG.
# fb is DDR-relative 0x18000000 -> jtag_avl byte addr 0x58000000+off.
# Colors are x8r8g8b8 words (0x00RRGGBB); red should land top-left etc.
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { set mp [lindex $mps 0] }
puts "using $mp"
open_service master $mp

set FB 0x58000000
# marker pixels: {pixel_index color}
# 0 = (0,0) top-left | 639 = top-center | 1279 = top-right
# 460800 = (0,360) mid-left | 921599 = bottom-right
foreach {idx col} {0 0x00FF0000  639 0x0000FF00  1279 0x000000FF \
                   460800 0x00FFFFFF  921599 0x00FFFF00} {
    set addr [expr {$FB + $idx * 4}]
    master_write_32 $mp $addr [list $col]
    puts [format "wrote pixel %6d (x=%d,y=%d) = %s @0x%08x" \
          $idx [expr {$idx % 1280}] [expr {$idx / 1280}] $col $addr]
}
# one full horizontal line of green at y=200 (1280 words, single call)
set row {}
for {set i 0} {$i < 1280} {incr i} { lappend row 0x0000FF00 }
master_write_32 $mp [expr {$FB + 200 * 1280 * 4}] $row
puts "wrote green line at y=200"
close_service master $mp
