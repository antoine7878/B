i;

fn() {
    i++;
}

gi 42;
gs "hello";

testGlob() {
    extrn test, printf, fn, char;
    printf("Global\n");

    test(i == 0, "global 0");
    fn();
    test(i == 1, "global 1");
    fn();
    test(i == 2, "global 2");

	test(gi == 42, "ginit 0");

	test(char(gs, 0) == 'h', "ginit 1");
	test(char(gs, 1) == 'e', "ginit 2");
	test(char(gs, 2) == 'l', "ginit 3");
	test(char(gs, 3) == 'l', "ginit 4");
	test(char(gs, 4) == 'o', "ginit 5");
	test(char(gs, 5) == 0, "ginit 6");
}
