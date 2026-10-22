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
set v [g $w 14]
puts [format "w14 vid_status: busy=%d underRun=%d enable=%d" \
    [expr {($v>>2)&1}] [expr {($v>>1)&1}] [expr {$v&1}]]
set x [g $w 18]
puts [format "w15 db_pend_addr = 0x%08x   w16 ib_pend_addr = 0x%08x" [g $w 15] [g $w 16]]
puts [format "w17 stalls: ib=%d db=%d    w18 live: ib_pend=%d db_pend=%d ib_rd=%d ib_wrn=%d db_rd=%d db_wr=%d db_wrn=%d any_rdv=%d" \
    [expr {([g $w 17]>>16)&0xFFFF}] [expr {[g $w 17]&0xFFFF}] \
    [expr {($x>>7)&1}] [expr {($x>>6)&1}] [expr {($x>>5)&1}] \
    [expr {($x>>4)&1}] [expr {($x>>3)&1}] [expr {($x>>2)&1}] \
    [expr {($x>>1)&1}] [expr {$x&1}]]
set h [g $w 20]
puts [format "w19 execute_INSTRUCTION = 0x%08x" [g $w 19]]
puts [format "w20 fetchPc_hi=0x%04x haltSelf=%d l395=%d l411refill=%d dcHaltIt=%d flushStall=%d wfi_ex=%d !wfiWake=%d wfiWake=%d csrBlk=%d dbCmdV=%d dbCmdR=%d dbRspV=%d inWfi=%d env=%d" \
    [expr {($h>>16)&0xFFFF}] [expr {($h>>15)&1}] [expr {($h>>14)&1}] \
    [expr {($h>>13)&1}] [expr {($h>>12)&1}] [expr {($h>>11)&1}] \
    [expr {($h>>10)&1}] [expr {($h>>9)&1}]  [expr {($h>>8)&1}] \
    [expr {($h>>7)&1}]  [expr {($h>>6)&1}]  [expr {($h>>5)&1}] \
    [expr {($h>>4)&1}]  [expr {($h>>3)&1}]  [expr {$h&7}]]

# avlbr_dbg (w2..w7 = 192b): decode ddr_avl_bridge FSM live state.
# bit i of dbg = bit (i%32) of mailbox word (2 + i/32).
proc bg {w hi lo} {
    # extract dbg[hi:lo] spanning 32-bit mailbox words w2..w7
    set v 0
    for {set i $hi} {$i >= $lo} {incr i -1} {
        set bit [expr {[g $w [expr {2 + $i/32}]] >> ($i % 32)} & 1]
        set v [expr {($v << 1) | $bit}]
    }
    return $v
}
set sn {IDLE DIVA DIVB DIVC WBEAT WFLUSH RD_HEAD RD_MISS RD_SERV}
puts [format "avlbr: state=%s iss_cnt=%d rdv_cnt=%d pop=%d miss=%d wrcnt=%d" \
    [lindex $sn [bg $w 3 0]] [bg $w 191 176] [bg $w 175 160] \
    [bg $w 159 152] [bg $w 151 144] [bg $w 143 139]]
puts [format "avlbr: s0_rd=%d s0_wr=%d s0_wrq=%d rd_need=%d head=%d wq_pop=%d miss_req=%d rd_wait=%d wq_full=%d can_iss=%d iss_acc=%d" \
    [bg $w 138 138] [bg $w 137 137] [bg $w 136 136] [bg $w 135 135] \
    [bg $w 134 134] [bg $w 133 133] [bg $w 132 132] [bg $w 131 131] \
    [bg $w 130 130] [bg $w 129 129] [bg $w 128 128]]
puts [format "avlbr: ret_word=0x%x spec_word=0x%x cur_word=0x%x beats=%d lane=%d drain=%d spec_en=%d miss_v=%d mavl_wrn=%d mavl_rv=%d mavl_rd=%d mavl_wr=%d owed=%d wq_n=%d" \
    [bg $w 117 93] [bg $w 92 68] [bg $w 67 43] [bg $w 42 36] \
    [bg $w 35 33] [bg $w 32 32] [bg $w 31 31] [bg $w 30 30] \
    [bg $w 29 29] [bg $w 28 28] [bg $w 27 27] [bg $w 26 26] \
    [bg $w 25 20] [bg $w 19 14]]
