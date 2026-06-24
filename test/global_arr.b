fna() {
    return (54);
}

garr [5] 24, 666, 12, 4;
garr2 [] 24, 666, 12, 4;
garr3[12];
gf[] fna;

testGArr() {
	extrn test, printf;
    printf("Global array\n");

	test(garr[0] == 24, "garr 0");
	test(garr[1] == 666, "garr 1");
	test(garr[2] == 12, "garr 2");
	test(garr[3] == 4, "garr 3");
	test(garr[4] == 0, "garr 4");

	garr[0] = 42;
	garr[1] = 13;
	garr[4] = 7;
	test(garr[0] == 42, "garr 5");
	test(garr[1] == 13, "garr 6");
	test(garr[4] == 7, "garr 7");

	test(garr2[0] == 24, "garr2 0");
	test(garr2[1] == 666, "garr2 1");
	test(garr2[2] == 12, "garr2 2");
	test(garr2[3] == 4, "garr2 3");

    garr3[5] = 42;
	test(garr3[5] == 42, "garr3 0");

	test(((**gf)()) == 54, "garrfn 0");
}
