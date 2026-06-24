#include "b.h"

void op_assign(const char *instruction) {
	emit("mov ebx, eax");
	emit("pop eax");
	emit("%s [eax], ebx", instruction);
	emit("mov eax, [eax]");
}

void compare_assign(const char *set) {
	emit("pop ebx");
	emit("cmp [ebx], eax");
	emit("%s al", set);
	emit("movzx eax, al");
	emit("mov [ebx], eax");
}

void shift_assign(const char *instruction) {
	emit("mov ecx, eax");
	emit("pop eax");
	emit("%s DWORD PTR [eax], cl", instruction);
	emit("mov eax, [eax]");
}

void mod_assign() {
	emit("mov ebx, eax");
	emit("pop ecx");
	emit("mov eax, [ecx]");
	emit("cdq");
	emit("idiv ebx");
	emit("mov [ecx], edx");
	emit("mov eax, edx");
}

void div_assign() {
	emit("mov ebx, eax");
	emit("pop ecx");
	emit("mov eax, [ecx]");
	emit("cdq");
	emit("idiv ebx");
	emit("mov [ecx], eax");
}

void mul_assign() {
	emit("mov ebx, eax");
	emit("pop ecx");
	emit("mov eax, [ecx]");
	emit("imul ebx");
	emit("mov [ecx], eax");
}
