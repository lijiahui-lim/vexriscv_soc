# fb_fill.tcl — fill the whole framebuffer with one solid color via JTAG.
# Usage: echo 'set fill 0x0000FF00; source fpga/fb_fill.tcl' | system-console --cli
if {![info exists fill]} { set fill 0x0000FF00 }
puts "fill color = $fill"

set paths [get_service_paths master]
set p ""
foreach c $paths {
    if {[string first "phy_1" $c] >= 0 && [string first "jtagm" $c] < 0} { set p $c }
}
if {$p == ""} {
    foreach c $paths { if {[string first "phy_1" $c] >= 0} { set p $c } }
}
if {$p == ""} { set p [lindex $paths 0] }
puts "using master: $p"
open_service master $p

# fb CPU addr 0x58000000 -> DDR window offset 0x18000000 ; 1280*720*4 bytes
set base  0x18000000
set bytes 3686400

# little-endian byte order of the 32-bit pixel word
set b0 [expr {$fill & 0xFF}]
set b1 [expr {($fill >> 8) & 0xFF}]
set b2 [expr {($fill >> 16) & 0xFF}]
set b3 [expr {($fill >> 24) & 0xFF}]

set chunk 8192
set blk {}
for {set i 0} {$i < $chunk} {incr i 4} {
    lappend blk $b0 $b1 $b2 $b3
}

for {set off 0} {$off < $bytes} {incr off $chunk} {
    master_write_memory $p [expr {$base + $off}] $blk
    if {($off % 524288) == 0} { puts "  $off / $bytes" }
}
puts "done"
close_service master $p
