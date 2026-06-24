testEsc() {
	extrn test, printf;
	printf("Escape\n");

	test('\n' == 10, "esc 0");
	test('\t' == 9, "esc 1");
	test('\0' == 0, "esc 2");
	test('\"' == '"', "esc 3");
}
