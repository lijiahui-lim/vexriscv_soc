    .section .text.init
    .globl _start
_start:
    lui  sp, 0x8          # sp = 0x8000 (top of 32KB boot_ram)
    la   t0, _bss_start
    la   t1, _end
1:  bgeu t0, t1, 2f       # zero .bss
    sw   zero, 0(t0)
    addi t0, t0, 4
    j    1b
2:  call main
3:  wfi
    j 3b
