NAME = B
CC = gcc
CDIR = src
HDIR = include
ODIR = obj
TESTER = test/tester
LIBB = libb/libb.a
LEX_FILE = $(CDIR)/b.l
SRC_LEX = $(CDIR)/lex.yy.c
YACC_FILE = $(CDIR)/b.y
SRC_YACC = $(CDIR)/b.tab.c
SRC = \
		$(CDIR)/call_stack.c \
		$(CDIR)/operation.c \
		$(CDIR)/definition.c \
		$(CDIR)/context.c \
		$(CDIR)/compare.c \
		$(CDIR)/assign.c \
		$(CDIR)/switch.c \
		$(CDIR)/error.c \
		$(CDIR)/label.c \
		$(CDIR)/unary.c \
		$(CDIR)/float.c \
		$(CDIR)/emit.c \
		$(CDIR)/sym.c \
		$(SRC_YACC) \
		$(SRC_LEX)

OBJ = $(patsubst $(CDIR)/%.c, $(ODIR)/%.o, $(SRC))

CFLAGS = -I $(HDIR) -Wall -Werror -Wextra
# CFLAGS += -fsanitize=address,leak -g

# ----- COMPILE --------------------

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

$(ODIR)/%.o: $(CDIR)/%.c | $(ODIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(SRC_LEX): $(LEX_FILE)
	flex -o $@ $^

$(SRC_YACC): $(YACC_FILE)
	bison -o $@ -d -H$(HDIR)/b.tab.h $^

# ----- LIBB --------------------

$(LIBB): $(NAME) $(shell find libb -type f ! -name libb.a)
	make -C libb

# ----- TEST --------------------

$(TESTER): $(LIBB) $(shell find test -type f ! -name tester)
	make -C test

t:test

test: $(TESTER)
	echo "A" | TEST_ENV=coucou ./test/tester salut

# ----- SETUP --------------------

$(ODIR):
	mkdir -p $@

# ----- CLEAN --------------------
clean:
	rm -f $(OBJ) $(SRC_YACC) $(SRC_LEX) $(CDIR)/y.tab.c $(HDIR)/b.tab.h

fclean: clean
	rm -f $(NAME) b.out a.out $(LIBB)
	make -C libb fclean
	make -C test fclean

re: fclean
	make $(NAME)
	make $(LIBB)

compile_command.json:
	bear -- make re

.PHONY: clean fclean all re test
