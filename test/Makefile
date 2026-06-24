NAME = tester
CC = ../B

SRC = \
	compound_bit.b \
	test_stdlib.b \
	assignation.b \
	comparison.b \
	extrn_test.b \
	global_arr.b \
	operation.b \
	function.b \
	ptr_call.b \
	comment.b \
	ternary.b \
	return.b \
	switch.b \
	escape.b \
	ifelse.b \
	string.b \
	global.b \
	float.b \
	octal.b \
	scope.b \
	empty.b \
	unary.b \
	auto.b \
	argv.b \
	char.b \
	test.b \
	loop.b \
	e.b \
	main.b


ASM = $(SRC:.b=.s)
OBJ = $(ASM:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	ld -m elf_i386 $^ ../brt0.o ../libb/libb.a -o $@

%.s: %.b
	./../B < $< > $@

%.o: %.s
	gcc -c -m32 -x assembler $< -o $@

clean:
	rm -f $(OBJ) $(ASM)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: clean fclean all re test
