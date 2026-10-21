# Read the cycle-accurate ring-buffer trace captured in dbg_ram w64..w255.
# entry = {state[3:0], spec[4:0], ret[4:0], owed[4:0],
#          s0rd, s0wr, s0wrq, miss_req, wq_pop, rd_need, can_iss,
#          iss_acc, draining, spec_en, wrq_n(dbg29), rdv(dbg28), mwrite(dbg26)}
# NOTE: dbg[29]=mavl_waitrequest_n (EMIF ready), dbg[28]=readdatavalid,
#       dbg[27]=mavl_read (not traced), dbg[26]=mavl_write
# w8 = {23'b0, tr_frozen, trig_pos[7:0]} ; ring[trig_pos] = trigger sample.
# Freeze writes ~100 post-trigger entries at trig_pos+1..trig_pos+100, so
# the oldest sample is ring[(trig_pos+101)%192].
set mp ""
foreach p [get_service_paths master] {
    open_service master $p
    if {[catch {master_read_32 $p 124 1} r] == 0 && [lindex $r 0] == 0xc0de0005} {
        if {$mp eq ""} {set mp $p; puts "MP=$p"} else {close_service master $p}
    } else { close_service master $p }
}
if {$mp eq ""} { puts "no mailbox"; return }
set names {IDLE DIVA DIVB DIVC WBEAT WFLUSH RD_HEAD RD_MISS RD_SERV}
set meta [lindex [master_read_32 $mp 32 1] 0]
set tpos [expr {$meta & 0xFF}]
set froz [expr {($meta >> 8) & 1}]
puts "trig_pos=$tpos frozen=$froz"
set tr [master_read_32 $mp 256 192]
for {set i 0} {$i < 192} {incr i} {
    set pos [expr {($tpos + 101 + $i) % 192}]
    set e [lindex $tr $pos]
    set rel [expr {$i - 91}]
    set stv [expr {($e >> 28) & 0xF}]
    set st  [lindex $names $stv]
    if {$st eq ""} {set st "?$stv"}
    set mark [expr {$i == 91 ? " <TRIG" : ""}]
    puts [format "c%-4d pos=%-3d st=%-7s spec=%2d ret=%2d owed=%2d s0rd=%d s0wr=%d s0wrq=%d miss=%d pop=%d need=%d can=%d acc=%d dr=%d se=%d wrq_n=%d rdv=%d mw=%d%s" \
        $rel $pos $st \
        [expr {($e >> 23) & 0x1F}] [expr {($e >> 18) & 0x1F}] [expr {($e >> 13) & 0x1F}] \
        [expr {($e >> 12) & 1}] [expr {($e >> 11) & 1}] [expr {($e >> 10) & 1}] \
        [expr {($e >> 9) & 1}] [expr {($e >> 8) & 1}] [expr {($e >> 7) & 1}] \
        [expr {($e >> 6) & 1}] [expr {($e >> 5) & 1}] [expr {($e >> 4) & 1}] \
        [expr {($e >> 3) & 1}] [expr {($e >> 2) & 1}] [expr {($e >> 1) & 1}] \
        [expr {$e & 1}] $mark]
}
close_service master $mp
