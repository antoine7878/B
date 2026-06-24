#include "b.h"

void to_float() {
	emit("cvtsi2ss xmm0, eax");
	emit("movd eax, xmm0");
}

void to_int() {
	emit("movd xmm0, eax");
	emit("cvttss2si eax, xmm0");
}

void opf(const char *op) {
	emit("movd xmm1, eax");
	emit("pop eax");
	emit("movd xmm0, eax");
	emit("%s xmm0, xmm1", op);
	emit("movd eax, xmm0");
}
