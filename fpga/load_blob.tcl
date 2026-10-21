# load_blob.tcl — upload linux/out/fw_payload.bin into DDR @0x40000000 via
# the jtagm (non-mailbox) master, then write the release magic word.
# The boot_linux bootloader polls the magic and jumps to 0x40000000.
# Streams the file in 256KB chunks (no giant word list — lrange on a
# multi-million-element list is O(n^2) and effectively hangs).
# usage: echo "source load_blob.tcl" | system-console --cli
set blobfile [lindex $argv 0]
if {$blobfile == ""} { set blobfile "fw_payload.bin" }

set f [open $blobfile rb]
fconfigure $f -translation binary
set size [file size $blobfile]
puts "blob: $size bytes"

set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { puts "no jtagm master found"; exit }
puts "using $mp"
open_service master $mp

fconfigure stdout -buffering line
set addr 0
set done 0
while {![eof $f]} {
    set cdata [read $f 262144]
    set n [string length $cdata]
    if {$n == 0} break
    while {[expr {$n % 4}] != 0} { append cdata "\x00"; incr n }
    binary scan $cdata iu* words
    master_write_32 $mp $addr $words
    incr addr $n
    incr done $n
    puts [format "  %d/%d bytes" $done $size]
}
close $f

# verify first word
set v [lindex [master_read_32 $mp 0 1] 0]
puts [format "first word = 0x%08x" [expr {$v & 0xFFFFFFFF}]]

# release the bootloader (magic @ DDR+0x6000000, above the blob footprint)
master_write_32 $mp [expr {0x6000000}] [list 0xC0DE0007]
puts "magic written -> CPU should jump to 0x40000000"
close_service master $mp
