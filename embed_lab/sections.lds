
MEMORY {
    pram : ORIGIN = 0x0000, LENGTH = 0x4000
    dram : ORIGIN = 0x4000, LENGTH = 0x2000
}

_stack_size = 0x400;

SECTIONS {
    .text : {
          . = 0x00000000;
          _text_start = .;
          *(.text.entrypoint);
          *(.text*);
          *(.rodata*);
          . = ALIGN(4);
          _text_end = .;
    } > pram
    .data : {
          _data_start = .;
          *(.*data*);
          . = ALIGN(4);
          _data_end = .;
    } > dram
    .bss : {
          _bss_start = .;
          *(.*bss*);
          . = ALIGN(4);
          _bss_end = .;
    } > dram
    .stack : {
          . = ALIGN(16);
          _stack_start = .;
          . = . + _stack_size + 16;
          . = ALIGN(16);
          _stack_end = .;
          _stack_addr = . - 16;
    } > dram
}
