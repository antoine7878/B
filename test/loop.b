testLoop() {
    extrn test, printf;
    printf("Loop\n");

    auto a, b, c;

    a = 0;
    while (a < 10) {
            a++;
    }
    test(a == 10, "while 0");

    while (a > 0) {
            --a;
    }
    test(a == 0, "while 1");

    a = 0;
    while (a < 10)
            a++;
    test(a == 10, "while 2");

    while (a > 0)
            --a;
    test(a == 0, "while 3");

loop:
    ++a;
    if (a < 10)
        goto loop;
    test(a == 10, "goto 0");

do:
    a--;
    if (a <= 0)
        goto loopend;
    goto do;
loopend:
    test(a == 0, "goto 1");
}
