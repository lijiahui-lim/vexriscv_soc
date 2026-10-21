# read-only probe: mailbox w0/w1 + avlbr dbg (w2..w7), no DDR traffic
set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] >= 0} { set mp $p }
}
if {$mp == ""} { puts "no phy_2 master"; exit }
puts "mailbox master: $mp"
open_service master $mp
set w  [master_read_32 $mp 0 32]
set hb1 [lindex $w 1]
after 400
set w  [master_read_32 $mp 0 32]
set hb2 [lindex $w 1]
close_service master $mp

set f [lindex $w 0]
puts [format "w0 flags   = 0x%08x  (underrun=%d pll=%d init=%d cals=%d calf=%d)" \
    [expr {$f & 0xFFFFFFFF}] [expr {$f & 1}] [expr {($f>>1)&1}] \
    [expr {($f>>2)&1}] [expr {($f>>3)&1}] [expr {($f>>4)&1}]]
puts [format "w1 heartbt = 0x%08x -> 0x%08x  (%s)" [expr {$hb1 & 0xFFFFFFFF}] \
    [expr {$hb2 & 0xFFFFFFFF}] [expr {$hb2 != $hb1 ? "TICKING" : "STUCK"}]]

set d2 [lindex $w 2]; set d3 [lindex $w 3]; set d4 [lindex $w 4]
set d5 [lindex $w 5]; set d6 [lindex $w 6]; set d7 [lindex $w 7]
set d2 [expr {$d2 & 0xFFFFFFFF}]; set d3 [expr {$d3 & 0xFFFFFFFF}]
set d4 [expr {$d4 & 0xFFFFFFFF}]; set d5 [expr {$d5 & 0xFFFFFFFF}]
set d6 [expr {$d6 & 0xFFFFFFFF}]; set d7 [expr {$d7 & 0xFFFFFFFF}]

# dbg = { iss_cnt[191:176], rdv_cnt[175:160], pop_cnt[159:152], miss_cnt[151:144],
#         wr_cnt[143:139], s0_read[138], s0_write[137], s0_wrq[136], rd_need[135],
#         head_match[134], wq_pop[133], miss_req[132], rd_wait[131], wq_full[130],
#         can_iss[129], iss_acc[128], 0[127:118], ret_word[117:93],
#         spec_word[92:68], cur_word[67:43], beats[42:36], cur_lane[35:33],
#         draining[32], spec_en[31], miss_v[30], mavl_wait_n[29], mavl_rv[28],
#         mavl_rd[27], mavl_wr[26], owed[25:20], wq_n[19:14], wq_rp[13:9],
#         wq_wp[8:4], state[3:0] }
# w2=dbg[31:0] w3=[63:32] w4=[95:64] w5=[127:96] w6=[159:128] w7=[191:160]
puts [format "avlbr cnts: iss=%d rdv=%d pop=%d miss=%d wr=%d" \
    [expr {($d7>>16)&0xFFFF}] [expr {$d7&0xFFFF}] \
    [expr {($d6>>24)&0xFF}]  [expr {($d6>>16)&0xFF}] [expr {($d6>>11)&0x1F}]]
puts [format "avlbr s0: rd=%d wr=%d wrq=%d | rd_need=%d head_m=%d pop=%d miss_req=%d rd_wait=%d wq_full=%d can_iss=%d iss_acc=%d" \
    [expr {($d6>>10)&1}] [expr {($d6>>9)&1}] [expr {($d6>>8)&1}] \
    [expr {($d6>>7)&1}] [expr {($d6>>6)&1}] [expr {($d6>>5)&1}] \
    [expr {($d6>>4)&1}] [expr {($d6>>3)&1}] [expr {($d6>>2)&1}] \
    [expr {($d6>>1)&1}] [expr {$d6&1}]]
set ret_word  [expr {(($d5 & 0x3FFFFF) << 3) | (($d4 >> 29) & 7)}]
set spec_word [expr {($d4 >> 4) & 0x1FFFFFF}]
set cur_word  [expr {(($d4 & 0xF) << 21) | (($d3 >> 11) & 0x1FFFFF)}]
puts [format "avlbr words: cur=0x%x spec=0x%x ret=0x%x beats=%d lane=%d" \
    $cur_word $spec_word $ret_word [expr {($d3>>4)&0x7F}] [expr {($d3>>1)&7}]]
puts [format "avlbr st=%d drain=%d spec_en=%d miss_v=%d | mavl_wait_n=%d mavl_rv=%d mavl_rd=%d mavl_wr=%d | owed=%d wq_n=%d rp=%d wp=%d" \
    [expr {$d2&0xF}] [expr {$d3&1}] [expr {($d2>>31)&1}] [expr {($d2>>30)&1}] \
    [expr {($d2>>29)&1}] [expr {($d2>>28)&1}] [expr {($d2>>27)&1}] \
    [expr {($d2>>26)&1}] [expr {($d2>>20)&0x3F}] [expr {($d2>>14)&0x3F}] \
    [expr {($d2>>9)&0x1F}] [expr {($d2>>4)&0x1F}]]
