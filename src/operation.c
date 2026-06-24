#include "b.h"

void op(const char *instruction) {
	emit("mov ebx, eax");
	emit("pop eax");
	emit("%s eax, ebx", instruction);
}

void op_mul() {
	emit("mov ebx, eax");
	emit("pop eax");
	emit("imul ebx");
}

void op_div() {
	emit("mov ebx, eax");
	emit("pop eax");
	emit("cdq");
	emit("idiv ebx");
}

void op_mod() {
	op_div();
	emit("mov eax, edx");
}

void shift(const char *instruction) {
	emit("mov ecx, eax");
	emit("pop eax");
	emit("%s eax, cl", instruction);
}
