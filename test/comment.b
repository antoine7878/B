testComm() {
	extrn test, printf;
	printf("Comment\n");

	test(1 /* inline comment */ == 1, "comm 0");

	/*
	 * multi
	 * line
	 */
	test(1 == 1, "comm 1");
}
