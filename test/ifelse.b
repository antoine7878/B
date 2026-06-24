testIfEl() {
    extrn test, printf;
    printf("If Else\n");

    auto a;

    if (1) {
        test(1, "if 0");
    }

    if (0) {
        test(0, "if 1");
    }

    if (1) {
        test(1, "if 2");
    } else {
        test(0, "if 2");
    }

    if (0) {
        test(0, "if 3");
    } else {
        test(1, "if 3");
    }

    if (1) {
        test(1, "if 4");
    } else if(0) {
        test(0, "if 4");
    } else {
        test(0, "if 4"); }

    if (0) {
        test(0, "if 5");
    } else if(1) {
        test(1, "if 5");
    } else {
        test(0, "if 5");
    }

    if (0) {
        test(0, "if 6");
    } else if(0) {
        test(0, "if 6");
    } else {
        test(1, "if 6");
    }



    if (1)
        test(1, "if 7");

    if (0)
        test(0, "if 8");

    if (1)
        test(1, "if 9");
    else
        test(0, "if 9");

    if (0)
        test(0, "if 10");
    else
        test(1, "if 10");

    if (1)
        test(1, "if 11");
    else if(0)
        test(0, "if 11");
    else
        test(0, "if 11");

    if (0)
        test(0, "if 12");
    else if(1)
        test(1, "if 12");
    else
        test(0, "if 12");

    if (0)
        test(0, "if 13");
    else if(0)
        test(0, "if 13");
    else
        test(1, "if 13");
}
