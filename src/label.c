#include "b.h"

int get_constant_label() {
	static int counter = 0;
	return counter++;
}

int get_jump_label() {
	static int counter = 1;
	return counter++;
}
