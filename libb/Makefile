NAME = libb.a
CC = ../B

SRC = \
	getchar.b \
	putchar.b \
	printfl.b \
	isdigit.b \
	getuid.b \
	printn.b \
	setuid.b \
	unlink.b \
	strcmp.b \
	printf.b \
	ichar.b \
	mkdir.b \
	chdir.b \
	chmod.b \
	chown.b \
	close.b \
	creat.b \
	ctime.b \
	execl.b \
	execv.b \
	write.b \
	rmdir.b \
	fstat.b \
	fork.b \
	read.b \
	time.b \
	exit.b \
	wait.b \
	link.b \
	char.b \
	stat.b \
	open.b \
	seek.b \
	abs.b

ASM = $(SRC:.b=.s)
OBJ = $(ASM:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $@ $^

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
