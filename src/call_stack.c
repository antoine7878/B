#include "b.h"

void reverse_stack(int len) {
	for (int i = 0; i < len / 2; i++) {
		emit("mov ebx, [esp+%d]", i * 4);
		emit("mov ecx, [esp+%d]", (len - i - 1) * 4);
		emit("mov [esp+%d], ebx", (len - i - 1) * 4);
		emit("mov [esp+%d], ecx", i * 4);
	}
}

static int call_stack[MAX_CALL_STACK_SIZE] = {0};
static int call_stack_len = 0;

void push_call() {
	if (call_stack_len >= MAX_CALL_STACK_SIZE)
		error("call stack overflow");
	call_stack[call_stack_len] = 0;
	++call_stack_len;

	emit("push eax");
}

void add_arg() {
	emit("push eax");
	call_stack[call_stack_len - 1]++;
}

int get_arg_count() {
	return call_stack[call_stack_len - 1];
}

void pop_call() {
	int arg_count;

	if (call_stack_len == 0)
		error("call stack underflow");

	arg_count = get_arg_count();
	if (arg_count > 0)
		reverse_stack(arg_count + 1);
	emit("pop eax");
	emit("call eax");
	if (arg_count > 0)
		emit("add esp, %d", arg_count * 4);
	--call_stack_len;
}
