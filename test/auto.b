testAuto() {
    extrn test, printf, strcmp;
    printf("Auto\n");

    auto a;
    test(a == 0, "auto 0");

    auto b 1;
    test(b == 1, "auto 1");

    auto c "abc";
    test(strcmp(c, "abc") == 0, "auto 2");
}
