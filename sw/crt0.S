    .section .text.init
    .globl _start
_start:
    lui  sp, 0x8          # sp = 0x8000 (top of 32KB boot_ram)
    call main
1:  wfi
    j 1b
