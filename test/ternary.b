one() {
    return (1);
}

testTern() {
    extrn test, printf, exit, one;
    printf("Ternary\n");

    auto a;

    a = 4;
    a = 1 ? 1 : 2;
    test(a == 1, "ter 0");
    a = 4;
    a = 0 ? 1 : 2;
    test(a == 2, "ter 1");
    test(a != 1, "ter 2");

    a = 4;
    a = 1 ? (1 ? 1 : 2) : 3;
    test(a == 1, "ter 3");
    a = 4;
    a = 1 ? (0 ? 1 : 2) : 3;
    test(a == 2, "ter 4");
    a = 4;
    a = 0 ? (0 ? 1 : 2) : 3;
    test(a == 3, "ter 5");

    a = 4;
    a = 1 ? 1 ? 1 : 2 : 3;
    test(a == 1, "ter 6");
    a = 4;
    a = 1 ? 0 ? 1 : 2 : 3;
    test(a == 2, "ter 7");
    a = 4;
    a = 0 ? 0 ? 1 : 2 : 3;
    test(a == 3, "ter 8");

    a = 4;
    a = 1 ? one(): test(0);
    test(a == 1, "ter 9");

    a = 4;
    a = 0 ? test(0) : one() + 1;
    test(a == 2, "ter 10");

    a = 4;
    a = 0
        ? test(0)
        : one() + 1;
    test(a == 2, "ter 11");
}
