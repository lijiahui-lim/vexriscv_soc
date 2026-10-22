# fb_bars.tcl: write solid horizontal color lines into the DDR framebuffer
# via JTAG (bypasses CPU/software). Each line = 1280 words.
# Expect crisp lines at known y positions with correct colors (x8r8g8b8).
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { set mp [lindex $mps 0] }
puts "using $mp"
open_service master $mp

set FB 0x58000000
proc fill_line {y color} {
    global FB mp
    set row {}
    for {set i 0} {$i < 1280} {incr i} { lappend row $color }
    master_write_32 $mp [expr {$FB + $y * 1280 * 4}] $row
    puts [format "y=%d color=%s done" $y $color]
}
fill_line 100 0x00FF0000   ;# red
fill_line 150 0x0000FF00   ;# green
fill_line 200 0x000000FF   ;# blue
fill_line 250 0x00FFFFFF   ;# white
fill_line 300 0x00000000   ;# black
# checkerboard line at y=350: alternating red/blue every pixel
set chk {}
for {set i 0} {$i < 1280} {incr i} {
    lappend chk [expr {($i % 2) ? 0x000000FF : 0x00FF0000}]
}
master_write_32 $mp [expr {$FB + 350 * 1280 * 4}] $chk
puts "checkerboard y=350 done"
close_service master $mp
