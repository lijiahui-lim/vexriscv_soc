    .section .text
    .globl trap_vec
    .globl smode_entry

/* M-mode trap vector: record mcause/mtval for page faults, mark mtip
   for timer interrupts, skip the faulting insn (mepc += 4), mret. */
trap_vec:
    addi sp, sp, -32
    sw   t0, 0(sp)
    sw   t1, 4(sp)
    csrr t0, mcause
    sw   t0, g_mcause, t1
    csrr t0, mtval
    sw   t0, g_mtval, t1
    csrr t0, mcause
    bltz t0, 1f                      # interrupt (MSB=1)
    # exception: skip faulting instruction
    csrr t0, mepc
    addi t0, t0, 4
    csrw mepc, t0
    j    2f
1:  # interrupt: cause 7 = MTIP -> flag and disarm via mtimecmp=far
    li   t0, 0x80000007
    csrr t1, mcause
    bne  t1, t0, 2f
    li   t0, 1
    sw   t0, g_mtip, t1
    lui  t0, %hi(0xF0004000)
    li   t1, -1
    sw   t1, %lo(0xF0004000)(t0)
    sw   t1, %lo(0xF0004004)(t0)
2:  lw   t0, 0(sp)
    lw   t1, 4(sp)
    addi sp, sp, 32
    mret

smode_entry:
    lui  sp, 0x8
    call smode_main
1:  wfi
    j 1b
