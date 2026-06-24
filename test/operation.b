testOp() {
    extrn test, printf;
    printf("Operations\n");

    test(1 + 1 == 2, "add 0");
    test(2 + 1 == 3, "add 1");
    test(1 + 2 == 3, "add 2");
    test(5 + 12 == 17, "add 3");
    test(5 + 13 != 17, "add 4");

    test(1 - 1 == 0, "sub 0");
    test(2 - 1 == 1, "sub 1");
    test(1 - 2 == -1, "sub 2");
    test(5 - 12 == -7, "sub 3");
    test((5 - (-13)) == 18, "sub 4");
    test(5 - 13 != -7, "sub 5");

    test(1 * 1 == 1, "mul 0");
    test(2 * 1 == 2, "mul 1");
    test(1 * 2 == 2, "mul 2");
    test(5 * 12 == 60, "mul 3");
    test(5 * 13 != 60, "mul 4");
    test(5 * -12 == -60, "mul 5");
    test(-5 * 12 == -60, "mul 6");
    test(-5 * -12 == 60, "mul 7");

    test(1 / 3 == 0, "div 0");
    test(2 / 3 == 0, "div 1");
    test(3 / 3 == 1, "div 2");
    test(4 / 3 == 1, "div 3");
    test(5 / 3 == 1, "div 4");
    test(6 / 3 == 2, "div 5");
    test(7 / 3 == 2, "div 6");
    test(8 / 3 == 2, "div 7");
    test(9 / 3 == 3, "div 8");
    test(1 / 4 == 0, "div 9");
    test(2 / 4 == 0, "div 10");
    test(3 / 4 == 0, "div 11");
    test(4 / 4 == 1, "div 13");
    test(5 / 4 == 1, "div 14");
    test(6 / 4 == 1, "div 15");
    test(7 / 4 == 1, "div 16");
    test(8 / 4 == 2, "div 17");
    test(9 / 4 == 2, "div 18");

    test(9 / -4 == -2, "div 19");
    test(-9 / 4 == -2, "div 20");
    test(-9 / -4 == 2, "div 21");

    test(1 % 3 == 1, "mod 0");
    test(2 % 3 == 2, "mod 1");
    test(3 % 3 == 0, "mod 2");
    test(4 % 3 == 1, "mod 3");
    test(5 % 3 == 2, "mod 4");
    test(6 % 3 == 0, "mod 5");
    test(7 % 3 == 1, "mod 6");
    test(8 % 3 == 2, "mod 7");
    test(9 % 3 == 0, "mod 8");
    test(1 % 4 == 1, "mod 9");
    test(2 % 4 == 2, "mod 10");
    test(3 % 4 == 3, "mod 11");
    test(4 % 4 == 0, "mod 12");
    test(5 % 4 == 1, "mod 13");
    test(6 % 4 == 2, "mod 14");
    test(7 % 4 == 3, "mod 15");
    test(8 % 4 == 0, "mod 16");
    test(9 % 4 == 1, "mod 17");

    test(1 << 0 == 1, "lhs 0");
    test(1 << 1 == 2, "lhs 1");
    test(1 << 2 == 4, "lhs 2");
    test(1 << 3 == 8, "lhs 3");
    test(1 << 4 == 16, "lhs 4");
    test(1 << 4 != 17, "lhs 5");

    test(1 >> 0 == 1, "rhs 0");
    test(2 >> 1 == 1, "rhs 1");
    test(4 >> 2 == 1, "rhs 2");
    test(8 >> 3 == 1, "rhs 3");
    test(16 >> 4 == 1, "rhs 4");
    test(16 >> 4 != 2, "rhs 5");

    test((1 & 1) == 1, "and 0");
    test((2 & 1) == 0, "and 1");
    test((1 & 2) == 0, "and 2");
    test((5 & 12) == 4, "and 3");
    test((5 & 13) != 4, "and 4");

    test((1 | 1) == 1, "or 0");
    test((2 | 1) == 3, "or 1");
    test((1 | 2) == 3, "or 2");
    test((5 | 12) == 13, "or 3");
    test((6 | 13) != 13, "or 4");

    test(2147483648 == -2147483648, "overflow 0");
    test(2147483647 == -2147483649, "overflow 1");
}
