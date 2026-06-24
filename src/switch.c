#include "b.h"

static int switch_depth;
static int last_case;

int get_switch_counter() {
	static int count = 3;
	return count++;
}

void switch_start() {
	push_context();
	switch_depth++;
	get_top_context()->end_label = get_switch_counter();
	emit("push eax\n");
}

void case_start(int cst) {
	int switch_label = (get_top_context() - 1)->end_label;
	int case_label = (get_top_context())->start_label;
	if (switch_depth == 0)
		error("case outside of switch");
	emit("case_%d_if_%d:", switch_label, case_label);
	emit("pop eax");
	emit("cmp eax, %d", cst);
	emit("push eax");
	emit("jne case_%d_if_%d", switch_label, case_label + 1);
	emit("case_%d_%d:", switch_label, case_label);
}

void case_end() {
	int switch_label = (get_top_context() - 1)->end_label;
	get_top_context()->start_label++;
	emit("jmp case_%d_%d", switch_label, get_top_context()->start_label);
	last_case = get_top_context()->start_label;
}

void switch_end() {
	int switch_label = get_top_context()->end_label;

	emit("case_%d_if_%d:", switch_label, last_case);
	emit("case_%d_%d:", switch_label, last_case);
	switch_depth--;
	pop_context();
}
