#define _GNU_SOURCE

#include <search.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "b.h"

static t_context context_stack[MAX_CONTEXT_LEN] = {0};
static size_t stack_len = 1;

t_context *get_fn_context() { return context_stack + 1; }

char *get_fn_name() { return context_stack[1].name; }

t_context *get_top_context() { return context_stack + stack_len - 1; }

size_t get_context_len() { return stack_len; }

t_context *get_context(size_t i) { return context_stack + i; }

void push_context()
{
	if (stack_len >= MAX_CONTEXT_LEN)
		error("context stack overflow");
	memset(context_stack + stack_len, 0, sizeof(t_context));
	++stack_len;
}

static void free_sym(void *p)
{
	t_symbol *sym = p;
	free((void *)sym->name);
	free(sym);
}

void pop_context()
{
	if (stack_len <= 0)
		error("context stack underflow");
	--stack_len;
	free(context_stack[stack_len].name);
	tdestroy(context_stack[stack_len].symbols, free_sym);
	context_stack[stack_len].symbols = NULL;
}
