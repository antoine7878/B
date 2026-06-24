#include "b.h"

void post(const char *instruction) {
	emit("mov ebx, [eax]");
	emit("mov ecx, ebx");
	emit("%s ebx", instruction);
	emit("mov [eax], ebx");
	emit("mov eax, ecx");
}

void pre(const char *instruction) {
	emit("%s DWORD PTR [eax]", instruction);
	emit("mov eax, [eax]");
}
