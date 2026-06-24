
#include <search.h>
#include <stdlib.h>
#include <string.h>

#include "b.h"

static int symcmp(const void *t1, const void *t2)
{
	return strcmp(((t_symbol *)t1)->name, ((t_symbol *)t2)->name);
}

static t_symbol_stack *new_auto_sym(char *name, void **syms, int pos)
{
	t_symbol_stack *sym;
	sym = calloc(1, sizeof(t_symbol_stack));
	if (!sym)
		error("auto symbol '%s' calloc failed", name);
	sym->type = STACK_S;
	sym->stack_offset = pos;
	sym->name = name;
	if (tfind(sym, syms, symcmp) != NULL)
		error("auto redefinition of '%s'", sym->name);
	tsearch(sym, syms, symcmp);
	return sym;
}

static t_symbol_global *new_extrn_sym(char *name, void **syms)
{
	t_symbol_global *sym;
	sym = calloc(1, sizeof(t_symbol_global));
	if (!sym)
		error("extrn symbol '%s' calloc failed", name);
	sym->type = EXTRN_S;
	sym->name = name;
	if (tfind(sym, syms, symcmp) != NULL)
		error("extrn redefinition of '%s'", sym->name);
	tsearch(sym, syms, symcmp);
	return sym;
}

char *add_extrn_symbol(char *name)
{
	t_context *ctx = get_top_context();
	return new_extrn_sym(name, &ctx->symbols)->name;
}

char *add_arg_symbol(char *name, int pos)
{
	t_context *ctx = get_fn_context();
	return new_auto_sym(name, &ctx->symbols, pos)->name;
}

char *add_auto_symbol(char *name)
{
	t_context *ctx = get_top_context();
	return new_auto_sym(name, &ctx->symbols, ++(get_fn_context()->frame_size) * 4)->name;
}

static t_symbol *get_symbol_in(char *name, void **(*key)(t_context *))
{
	t_symbol **ret_sym;
	t_symbol sym = {.name = name};

	for (int i = get_context_len() - 1; i >= 0; --i)
	{
		ret_sym = (t_symbol **)tfind(&sym, key(get_context(i)), symcmp);
		if (ret_sym)
			return *ret_sym;
	}
	return NULL;
}

void **symbols(t_context *ctx) { return &ctx->symbols; }

t_symbol *get_symbol(char *name)
{
	t_symbol *sym;

	if ((sym = get_symbol_in(name, symbols)) != NULL)
		return sym;
	return NULL;
}
