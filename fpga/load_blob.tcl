# load_blob.tcl — upload linux/out/fw_payload.bin into DDR @0x40000000 via
# the jtagm (non-mailbox) master, then write the release magic word.
# The boot_linux bootloader polls the magic and jumps to 0x40000000.
# usage: echo "source load_blob.tcl" | system-console --cli   (run on the VM)
set blobfile [lindex $argv 0]
if {$blobfile == ""} { set blobfile "fw_payload.bin" }

set f [open $blobfile rb]
fconfigure $f -translation binary
set data [read $f]
close $f
set n [string length $data]
# pad to a 4-byte boundary
while {[expr {$n % 4}] != 0} { append data "\x00"; incr n }
binary scan $data iu* words
puts [format "blob: %d bytes, %d words" $n [llength $words]]

set mps [get_service_paths master]
set mp ""
foreach p $mps {
    if {[string first "phy_2" $p] < 0} { set mp $p }
}
if {$mp == ""} { puts "no jtagm master found"; exit }
puts "using $mp"
open_service master $mp

set chunk 256
set addr 0
set i 0
set total [llength $words]
while {$i < $total} {
    set end [expr {$i + $chunk - 1}]
    if {$end >= $total} { set end [expr {$total - 1}] }
    master_write_32 $mp $addr [lrange $words $i $end]
    incr i $chunk
    incr addr [expr {$chunk * 4}]
    if {[expr {$i % 16384}] == 0} {
        puts [format "  %d/%d words" $i $total]
    }
}
# verify first word
set v [lindex [master_read_32 $mp 0 1] 0]
puts [format "first word = 0x%08x" [expr {$v & 0xFFFFFFFF}]]

# release the bootloader (magic @ DDR+0x6000000, above the blob footprint)
master_write_32 $mp [expr {0x6000000}] [list 0xC0DE0007]
puts "magic written -> CPU should jump to 0x40000000"
close_service master $mp
