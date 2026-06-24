set -e
for i in $(seq 1 $#); do
    eval S$i=$(mktemp)
    eval O$i=$(mktemp)
    echo compiling: $(eval echo \$$i)
    ./B <"$(eval echo \$$i)" >$(eval echo \$S$i)
    gcc -c -m32 -x assembler "$(eval echo \$S$i)" -o $(eval echo \$O$i)
    rm "$(eval echo \$S$i)"
done
echo linking...
ld -m elf_i386 $(eval echo $(seq -f '$O%.0f' -s ' ' 1 $#)) brt0.o ./libb/libb.a -o b.out
rm $(eval echo $(seq -f '$O%.0f' -s ' ' 1 $#))
