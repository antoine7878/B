testScop() {
	extrn test, printf;
	printf("Scope\n");

	auto a, b, c;

	a = 1;

	test(a == 1, "scope 0");

	{
		auto a 2;
		test(a == 2, "scope 1");
	}

	test(a == 1, "scope 2");

	{
		auto b 3;
		test(b == 3, "scope 3");
	}
}
