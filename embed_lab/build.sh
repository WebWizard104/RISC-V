#!/bin/bash

# Compile simple code using gcc on Linux

gcc example_00.c


shopt -s expand_aliases
alias riscvgcc='/data/CATALOG_DIG_PG1_OA_DS/sync/python_env/hscpy/extra/riscv/bin/riscv64-unknown-elf-gcc'
alias riscvelfsize='/data/CATALOG_DIG_PG1_OA_DS/sync/python_env/hscpy/extra/riscv/bin/riscv64-unknown-elf-size'
alias riscvobjcopy='/data/CATALOG_DIG_PG1_OA_DS/sync/python_env/hscpy/extra/riscv/bin/riscv64-unknown-elf-objcopy'
alias riscvobjdump='/data/CATALOG_DIG_PG1_OA_DS/sync/python_env/hscpy/extra/riscv/bin/riscv64-unknown-elf-objdump'
alias riscvgccnm='/data/CATALOG_DIG_PG1_OA_DS/sync/python_env/hscpy/extra/riscv/bin/riscv64-unknown-elf-nm'



# Compile simple code using riscv tool-chain
# riscvgcc example_00.c


# Compile stripped down using riscv tool-chain
# riscvgcc example_01.c

# Compile stripped down using riscv tool-chain - two step process
# -march=<> - CPU architecture option - determines ISA
# -mabi=<> - determines ABI spec
# compiler stage: source code --> object files
rm -rf ./build/*.o
riscvgcc -c -DEMBEDDED -march=rv32i -mabi=ilp32 example_01.c -o ./build/example_01.o
riscvgcc -c -DEMBEDDED -march=rv32i -mabi=ilp32 print.c      -o ./build/print.o
riscvgcc -c -DEMBEDDED -march=rv32i -mabi=ilp32 start.S      -o ./build/start.o

# linker stage: object files --> ELF executable, also generate address map
# -nostdlib - tells linker not to use standard system startup files or libraries
# sections.lds - linker script that specifies what part of object code goes where
# -Wl : linker pass through options
# -Bstatic: specifies static linking
# -T: option to specify linker script
# -Map: option to specify generation of map file
riscvgcc -march=rv32i -mabi=ilp32 -nostartfiles -lgcc -Wl,-Bstatic,-T,sections.lds,-Map,./build/example_01.map -o ./build/example_01.elf ./build/*.o

# inspect section-wise size of binary code
riscvelfsize ./build/example_01.elf
riscvobjcopy -O binary ./build/example_01.elf ./build/example_01.bin
riscvobjdump -D ./build/example_01.elf > ./build/example_01.asm
riscvgccnm -nS ./build/example_01.elf > ./build/example_01.sym.map




riscvgcc -c -g -DEMBEDDED -march=rv32i  -mabi=ilp32 example_01.c -o example_01.o
riscvgcc -c -g -DEMBEDDED -march=rv32i  -mabi=ilp32 print.c      -o print.o
riscvgcc -c -g -DEMBEDDED -march=rv32i  -mabi=ilp32 start.S      -o start.o
riscvgcc -march=rv32i -mabi=ilp32 -nostartfiles -lgcc -Wl,-Bstatic,-T,sections.lds,-Map,./example_01.map -o ./example_01.elf ./start.o ./print.o ./example_01.o
riscvelfsize ./example_01.elf
riscvobjcopy -O binary ./example_01.elf ./example_01.bin
riscvobjdump -D ./example_01.elf > ./example_01.asm
riscvgccnm -nS ./example_01.elf > ./example_01.sym.map

rm -rf ./build/*.o
riscvgcc -c -g -DEMBEDDED -march=rv32i -mabi=ilp32 example_02.c -o ./build/example_02.o
riscvgcc -c -g -DEMBEDDED -march=rv32i -mabi=ilp32 print.c      -o ./build/print.o
riscvgcc -c -g -DEMBEDDED -march=rv32i -mabi=ilp32 start.S      -o ./build/start.o
riscvgcc    -march=rv32i -mabi=ilp32 -nostartfiles -lgcc -Wl,-Bstatic,-T,sections.lds,-Map,./build/example_02.map -o ./build/example_02.elf ./build/*.o
riscvelfsize ./build/example_02.elf
riscvobjcopy -O binary ./build/example_02.elf ./build/example_02.bin
riscvobjdump -D -S ./build/example_02.elf > ./build/example_02.asm
riscvgccnm -nS ./build/example_02.elf > ./build/example_02.sym.map


