voidFn() {
	return;
}

testRetV() {
	extrn test, printf, voidFn;
	printf("Return Void\n");

	voidFn();
	test(1, "retv 0");
}
