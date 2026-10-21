/* boot_ram: 32KB at 0x00000000; stack grows down from 0x8000 */
OUTPUT_ARCH(riscv)
ENTRY(_start)
SECTIONS
{
    . = 0x00000000;
    .text : { *(.text.init) *(.text) *(.text.*) }
    .rodata : { *(.rodata) *(.rodata.*) *(.srodata) *(.srodata.*) }
    .data : { *(.data) *(.data.*) *(.sdata) *(.sdata.*) }
    . = ALIGN(8);
    _bss_start = .;
    .bss : { *(.bss) *(.bss.*) *(.sbss) *(.sbss.*) *(COMMON) }
    . = ALIGN(8);
    _end = .;
}
