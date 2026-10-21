# Fingerprint every master service, then drive the risky DDR op from a
# different phy than the mailbox reader.
# dbg[191:0] (LSB->MSB):
#  [3:0]state [8:4]wq_wp [13:9]wq_rp [19:14]wq_n [25:20]owed
#  [27:26]{mr,mw} [29:28]{wrq_n,rdv} [32:30]{drain,spec_en,miss_v}
#  [35:33]lane [42:36]beats [67:43]cur_word [92:68]spec [117:93]ret
#  [128]iss_acc [129]can_iss [130]wq_full [131]rd_wait [132]miss_req
#  [133]wq_pop [134]head_match [135]rd_need [136]s0_wrq [137]s0_wr [138]s0_rd
#  [143:139]wr_cnt [151:144]miss_cnt [159:152]pop_cnt [175:160]rdv_cnt [191:176]iss_cnt

proc snap {mp tag} {
    set w [master_read_32 $mp 0 32]
    set d0 [lindex $w 2]; set d1 [lindex $w 3]
    set d2 [lindex $w 4]; set d3 [lindex $w 5]
    set d4 [lindex $w 6]; set d5 [lindex $w 7]
    set state    [expr {$d0 & 0xF}]
    set wq_n     [expr {($d0 >> 14) & 0x3F}]
    set owed     [expr {($d0 >> 20) & 0x3F}]
    set mr       [expr {($d0 >> 26) & 1}]
    set mw       [expr {($d0 >> 27) & 1}]
    set wrqn     [expr {($d0 >> 28) & 1}]
    set rdv      [expr {($d0 >> 29) & 1}]
    set missv    [expr {($d0 >> 30) & 1}]
    set specen   [expr {($d0 >> 31) & 1}]
    set drain    [expr {$d1 & 1}]
    set lane     [expr {($d1 >> 1) & 7}]
    set beats    [expr {($d1 >> 4) & 0x7F}]
    set curword  [expr {(($d1 >> 11) & 0x1FFFFF) | (($d2 & 0xF) << 21)}]
    set specword [expr {($d2 >> 4) & 0x1FFFFFF}]
    set retword  [expr {(($d2 >> 29) & 0x7) | (($d3 & 0x3FFFFF) << 3)}]
    set iss_acc  [expr {$d4 & 1}]
    set can_iss  [expr {($d4 >> 1) & 1}]
    set wq_full  [expr {($d4 >> 2) & 1}]
    set rd_wait  [expr {($d4 >> 3) & 1}]
    set miss_req [expr {($d4 >> 4) & 1}]
    set wq_pop   [expr {($d4 >> 5) & 1}]
    set headm    [expr {($d4 >> 6) & 1}]
    set rd_need  [expr {($d4 >> 7) & 1}]
    set s0wrq    [expr {($d4 >> 8) & 1}]
    set s0wr     [expr {($d4 >> 9) & 1}]
    set s0rd     [expr {($d4 >> 10) & 1}]
    set wr_cnt   [expr {($d4 >> 11) & 0x1F}]
    set misscnt  [expr {($d4 >> 16) & 0xFF}]
    set popcnt   [expr {($d4 >> 24) & 0xFF}]
    set rdvcnt   [expr {$d5 & 0xFFFF}]
    set isscnt   [expr {($d5 >> 16) & 0xFFFF}]
    set names {IDLE DIVA DIVB DIVC WBEAT WFLUSH RD_HEAD RD_MISS RD_SERV}
    set sname [lindex $names $state]
    if {$sname eq ""} {set sname "?$state"}
    puts [format "%s: st=%-7s wq_n=%2d owed=%2d mr=%d mw=%d wrq_n=%d rdv=%d dr=%d se=%d mv=%d lane=%d bt=%d cur=%#07x spec=%#07x ret=%#07x" \
        $tag $sname $wq_n $owed $mr $mw $wrqn $rdv $drain $specen $missv $lane $beats $curword $specword $retword]
    puts [format "     can_iss=%d iss_acc=%d wq_full=%d rd_need=%d rd_wait=%d miss_req=%d wq_pop=%d headm=%d s0rd=%d s0wr=%d s0wrq=%d | iss=%d rdv=%d pop=%d miss=%d wr=%d" \
        $can_iss $iss_acc $wq_full $rd_need $rd_wait $miss_req $wq_pop $headm $s0rd $s0wr $s0wrq $isscnt $rdvcnt $popcnt $misscnt $wr_cnt]
}

# ---- fingerprint all masters ----
set mpaths {}
foreach p [get_service_paths master] {
    open_service master $p
    set ok 0
    if {[catch {master_read_32 $p 124 1} r] == 0} {
        if {[lindex $r 0] == 0xc0de0005} {set ok 1}
    }
    puts "[expr {$ok ? "MBX" : "???"}] $p"
    if {$ok} {
        lappend mpaths $p
    } else {
        close_service master $p
    }
}
puts "mailbox-capable masters: [llength $mpaths]"
if {[llength $mpaths] < 1} { puts "ERROR: no mailbox master"; return }
set mp_dbg [lindex $mpaths 0]

snap $mp_dbg "pre"

# Find a *different* phy that reaches avlbr: write DDR, watch wr_cnt.
set mp_ddr ""
foreach p [get_service_paths master] {
    if {$p eq $mp_dbg} continue
    open_service master $p
    if {[catch {master_write_32 $p 0x40000000 {0xA5A5A5A5}} e]} {
        puts "write via [file tail $p]: FAILED"
        close_service master $p
        continue
    }
    after 100
    set w [master_read_32 $mp_dbg 0 32]
    set wrnow [expr {([lindex $w 6] >> 11) & 0x1F}]
    puts "write via [file tail $p] ok, wr_cnt=$wrnow"
    if {$wrnow > 0} {
        set mp_ddr $p
        break
    }
    close_service master $p
}
if {$mp_ddr eq ""} {
    puts "WARN: no second avlbr-capable phy; using mp_dbg for the read test"
    set mp_ddr $mp_dbg
}

snap $mp_dbg "post-wr"

puts "-- DDR read 1 word via tester (may hang 60s) --"
if {[catch {master_read_32 $mp_ddr 0x40000000 1} r]} {
    puts "read error: [lindex [split $r \n] 0]"
} else {
    puts [format "read = %s" $r]
}
after 50
snap $mp_dbg "post-rd"
after 50
snap $mp_dbg "post-rd2"
