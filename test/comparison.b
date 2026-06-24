testCmp() {
	extrn test, printf;
    printf("Comparision\n");

    auto a;

    test(1 <  3, "<  0");
    test(1 <= 3, "<= 0");
    test(2 <  3, "<  1");
    test(2 <= 3, "<= 1");
    test(3 >= 3, ">= 0");
    test(3 <= 3, "<= 2");
    test(4 >  3, ">  0");
    test(4 >= 3, ">= 1");
    test(5 >  3, ">  1");
    test(5 >= 3, ">= 2");

    a = 1;
    test((a =<  3), "<  0");
    a = 1;
    test((a =<= 2), "<= 0");
    a = 2;
    test((a =<  3), "<  1");
    a = 2;
    test((a =<= 3), "<= 1");
    a = 3;
    test((a =<= 3), ">= 0");
    a = 3;
    test((a =<= 3), "<= 2");
    a = 4;
    test((a =>  3), ">  0");
    a = 4;
    test((a =>= 3), ">= 1");
    a = 5;
    test((a =>  3), ">  1");

    test(2 < 1 << 3, "prec 0");
    test(4 == 8 >> 1, "prec 1");
}
