testOct() {
	extrn test, printf;
	printf("Octal\n");

	test(0 == 0, "oct 0");
	test(01 == 1, "oct 1");
	test(07 == 7, "oct 2");
	test(010 == 8, "oct 3");
	test(077 == 63, "oct 4");
	test(0100 == 64, "oct 5");
	test(0777 == 511, "oct 6");
}

testBin() {
	extrn test, printf;
	printf("Binary\n");

	test(0b00 == 0, "bin 0");
	test(0b01 == 1, "bin 1");
	test(0b10 == 2, "bin 2");
	test(0b11 == 3, "bin 3");
	test(0b101 == 5, "bin 4");
	test(0b1110011001011001 == 58969, "bin 5");
}

testHex() {
	extrn test, printf;
	printf("Hexadecimal\n");

	test(0xff == 255, "hex 0");
	test(0xFF == 255, "hex 1");
	test(0XFf == 255, "hex 2");
	test(0xa  ==  10, "hex 3");
	test(0xA  ==  10, "hex 4");
	test(0Xa  ==  10, "hex 5");
	test(0XA  ==  10, "hex 6");
	test(0XA  ==  10, "hex 7");
    test(0x4A9D3 == 305619, "hex 8");
}
