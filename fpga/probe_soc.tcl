# probe soc debug: w8=fab_hb w9={ib_rdv,ib_acc} w10={db_rdv,db_acc}
#                  w11=last ibus addr  w12=live levels  w13=reset flags
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

puts [format "w0  = 0x%08x  w1 hb = 0x%08x" [g $w 0] [g $w 1]]
puts [format "w8  fab_hb    = 0x%08x" [g $w 8]]
puts [format "w9  ibus: rdv=%d acc=%d" [expr {([g $w 9]>>16)&0xFFFF}] [expr {[g $w 9]&0xFFFF}]]
puts [format "w10 dbus: rdv=%d acc=%d" [expr {([g $w 10]>>16)&0xFFFF}] [expr {[g $w 10]&0xFFFF}]]
puts [format "w11 last ibus addr = 0x%08x" [g $w 11]]
set l [g $w 12]
puts [format "w12 chip: rstIt=%d haltIt=%d stepIt=%d fHalt=%d booted=%d fpv=%d fpr=%d cmdv=%d cmdr=%d wrn=%d ird=%d rv=%d incI=%d ex=%d mem=%d wb=%d pc=0x%04x" \
    [expr {($l>>31)&1}] [expr {($l>>30)&1}] [expr {($l>>29)&1}] \
    [expr {($l>>28)&1}] [expr {($l>>27)&1}] [expr {($l>>26)&1}] \
    [expr {($l>>25)&1}] [expr {($l>>24)&1}] [expr {($l>>23)&1}] \
    [expr {($l>>22)&1}] [expr {($l>>21)&1}] [expr {($l>>20)&1}] \
    [expr {($l>>19)&1}] [expr {($l>>18)&1}] [expr {($l>>17)&1}] \
    [expr {($l>>16)&1}] [expr {$l&0xFFFF}]]
set f [g $w 13]
puts [format "w13 resets: cpu_rst_req=%d fab_rst_n=%d afi_rst_n=%d pll=%d glb_rst_n=%d" \
    [expr {($f>>4)&1}] [expr {($f>>3)&1}] [expr {($f>>2)&1}] \
    [expr {($f>>1)&1}] [expr {$f&1}]]
