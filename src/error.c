#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "b.h"

extern int yylineno;

void error(const char *fmt, ...) {
	va_list ap;
	va_start(ap, fmt);
	fflush(stderr);
	fflush(stdout);
	fprintf(stderr, "line: %d: ", yylineno);
	vfprintf(stderr, fmt, ap);
	fprintf(stderr, "\n");
	va_end(ap);
	exit(4);
}
