testUna() {
    extrn test, printf;
    printf("Unary\n");

    auto a, b, c;

    a = 1;
    b = 2;
    c = 3;
    test(((&a - 4) == &b), "& 0");
    test(((&a - 8) == &c), "& 1");
    test(*(&a - 4) == b, "[] 0");
    test(*(&a - 8) == c, "[] 0");
    test((&a)[-1] == b, "[] 0");
    test((&a)[-2] == c, "[] 0");

    a = 1;
    b = 0;
    test(a, "! 0");
    test(!b, "! 1");
    test(!!a, "! 2");
    test(!!!!!b, "! 3");
    test(!0, "! 4");
    test(!!!0, "! 5");
    test(!!!!!0, "! 6");
    test(1, "! 7");
    test(!!1, "! 8");
    test(!!!!1, "! 9");

    test(-1 == -1, "= 0");
    test(-2 == -1 - 1, "= 1");
    test(-a == -1, "= 2");
    test(-a * 2 == -2, "= 3");
    test(-1 == -a, "= 4");
}
