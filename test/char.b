testChar() {
	extrn test, printf;
	printf("Char\n");

	test('a' == 97, "char 0");
	test('z' == 122, "char 1");
	test('A' == 65, "char 2");
	test('Z' == 90, "char 3");
	test('0' == 48, "char 4");
	test('9' == 57, "char 5");
	test(' ' == 32, "char 6");
	test('!' == 33, "char 7");

    test('ab' != (('a' << 8) | 'b' + 1), "wchar 0");
    test('ab' == (('a' << 8) | 'b'), "wchar 1");
}
