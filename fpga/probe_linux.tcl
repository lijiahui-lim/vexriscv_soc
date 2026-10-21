# probe_linux.tcl — check whether CPU left boot_ram and is running
# the payload in DDR (pc >= 0x40000000) after the JTAG magic release.
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] >= 0} { set mp $p }
}
if {$mp == ""} { puts "no phy_2"; exit }
open_service master $mp
set w [master_read_32 $mp 0 32]
close_service master $mp
proc g {w i} { return [expr {[lindex $w $i] & 0xFFFFFFFF}] }
puts [format "w8  fab_hb  = 0x%08x" [g $w 8]]
puts [format "w11 last ibus = 0x%08x" [g $w 11]]
set l [g $w 12]
puts [format "w12 chip: haltIt=%d booted=%d pc=0x%04x" \
    [expr {($l>>30)&1}] [expr {($l>>27)&1}] [expr {$l&0xFFFF}]]
# scratch marker (jtagm master sees DDR window-relative)
set mp2 ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp2 $p }
}
open_service master $mp2
set sc [master_read_32 $mp2 [expr {0x6000100}] 4]
puts [format "scratch: 0x%08x 0x%08x" [expr {[lindex $sc 0]&0xFFFFFFFF}] [expr {[lindex $sc 1]&0xFFFFFFFF}]]
# blob first word sanity
set fw [master_read_32 $mp2 0 4]
puts [format "blob[0..3]:"]
foreach v $fw { puts [format "  0x%08x" [expr {$v & 0xFFFFFFFF}]] }
close_service master $mp2
