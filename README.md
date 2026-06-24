# B

A B programming language syntax directed compiler implemented in C with Flex and Bison

# Features

- Direct translation to GNU ASM in intel syntax for i386
- Symbol table internal state
- libb implements the B standard library
- Entry point and syscall function provided in brt0.o

# Usage

## Compile, Assemble, Link

```bash
./B < src.b > src.s
gcc -c -m32 -x assembler src.s -o src.o
ld -m elf_i386 src.o brt0.o -o b.out

```
