#include "b.h"
#include <string.h>

static int arg_counter;

void fn_decl_enter(char *fn_name)
{
	arg_counter = 2;
	get_fn_context()->name = strdup(fn_name);
	add_extrn_symbol(fn_name);
	push_context();
	emit(".text");
	emit(".globl %s", fn_name);
	emit("%s:", fn_name);
	emit(".long \"%s\" + 4", fn_name);
	emit("enter 0, 0");
}

void argument(char *name)
{
	add_arg_symbol(name, -arg_counter * 4);
	++arg_counter;
}

void global_int(char *name, int value)
{
	add_extrn_symbol(name);
	emit(".section .data");
	emit(".globl %s", name);
	emit("%s: .long %d", name, value);
}

void global_string(char *name, const char *value)
{
	add_extrn_symbol(name);
	emit(".section .rodata");
	emit(".globl %s", name);
	emit("%s: .long %s_str", name, name);
	emit("%s_str: .string %s", name, value);
}

void global_vector(char *name)
{
	add_extrn_symbol(name);
	emit(".section .data");
	emit(".globl %s", name);
	emit("%s: .long %s_vec", name, name);
	emit_raw("%s_vec: .long ", name);
}

void global_vector_extra(int count, int start)
{
	if (count <= 0)
		return;
	if (start)
	{
		emit_raw("0");
		count--;
	}
	while (count-- > 0)
		emit_raw(", 0");
}
