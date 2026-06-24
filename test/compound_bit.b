testCBit() {
	extrn test, printf;
	printf("Compound Bit\n");

	auto a;

	a = 5; a =| 2;
	test(a == 7, "=bit 0");

	a = 5; a =& 2;
	test(a == 0, "=bit 1");

	a = 6; a =| 3;
	test(a == 7, "=bit 2");

	a = 6; a =& 3;
	test(a == 2, "=bit 3");

	a = 1; a === 1;
	test(a == 1, "=== 0");

	a = 2; a === 1;
	test(a == 0, "=== 1");

	a = 2; a =!= 1;
	test(a == 1, "=!= 0");

	a = 1; a =!= 1;
	test(a == 0, "=!= 1");
}
