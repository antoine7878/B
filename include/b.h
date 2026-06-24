#pragma once

#include <stdbool.h>
#include <sys/types.h>

#define MAX_CONTEXT_LEN 256
#define MAX_CALL_STACK_SIZE 256

typedef enum
{
	STACK_S,
	EXTRN_S
} sym_type;

typedef struct
{
	sym_type type;
	char *name;
} t_symbol;

typedef struct
{
	sym_type type;
	char *name;
} t_symbol_global;

typedef struct
{
	sym_type type;
	char *name;
	int stack_offset;
} t_symbol_stack;

typedef struct
{
	void *symbols;
	char *name;
	int frame_size;
	int start_label;
	int end_label;
} t_context;

typedef union {
	float f;
	int u;
} float_conv;

// ----- emit --------------------

void emit(const char *fmt, ...);
void emit_raw(const char *fmt, ...);

// ----- error --------------------

void error(const char *fmt, ...);

// ----- context --------------------

char *add_extrn_symbol(char *name);
char *add_arg_symbol(char *name, int pos);
char *add_auto_symbol(char *name);
t_symbol *get_symbol(char *name);
t_context *get_top_context();
t_context *get_fn_context();

size_t get_context_len();
t_context *get_context(size_t i);
char *get_fn_name();
void push_context();
void pop_context();

// ----- label --------------------

int get_jump_label();
int get_constant_label();
void reverse_stack(int len);

// ----- call --------------------

void push_call();
void add_arg();
int get_arg_count();
void pop_call();

// ----- rvalue --------------------

void post(const char *instruction);
void pre(const char *instruction);

void compare(const char *set);
void op(const char *instruction);
void shift(const char *instruction);
void op_mod();
void op_div();
void op_mul();

void compare_assign(const char *set);
void op_assign(const char *instruction);
void shift_assign(const char *instruction);
void mul_assign();
void mod_assign();
void div_assign();

// ----- definition --------------------

void fn_decl_enter(char *fn_name);
void argument(char *name);

void global_int(char *name, int value);
void global_string(char *name, const char *value);
void global_vector(char *name);
void global_vector_extra(int count, int start);

// ----- switch --------------------

void switch_start();
void switch_end();
void case_start(int cst);
void case_end();

// ----- float --------------------

void to_float();
void to_int();
void opf(const char *op);
