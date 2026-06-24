#include "b.h"

void compare(const char *set) {
	emit("pop ebx");
	emit("cmp ebx, eax");
	emit("%s al", set);
	emit("movzx eax, al");
}
