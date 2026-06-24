pcf() {
    return (42);
}

testPtr() {
	extrn test, printf, pcf;
	printf("Ptr Call\n");

	auto p;

	p = pcf;
	test(p() == 42, "ptr 0");
}
