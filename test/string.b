testStr() {
	extrn test, printf, char;

	printf("String\n");

    auto s;
    s = "abc";

	test(char(s, 0) == 'a', "str 0");
	test(char(s, 1) == 'b', "str 1");
	test(char(s, 2) == 'c', "str 2");
	test(char(s, 3) == 0, "str 3");

	test(char("abc", 0) == 'a', "str lit 0");
	test(char("abc", 1) == 'b', "str lit 1");
	test(char("abc", 2) == 'c', "str lit 2");
	test(char("abc", 3) ==  0 , "str lit 2");
}
