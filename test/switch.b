countSw(a) {
    auto ret;

    switch (a) {
        case 1:
            ret++;
        case 2:
            ret++;
        case 3:
            ret++;
    }
    return (ret);
}

sw_in_sw(a, b) {
    extrn countSw;
    auto ret;

    switch (a) {
        case 1:
            ret++;
        case 2:
            switch (b) {
                case 1:
                    ret++;
                case 2:
                    ret++;
                case 3:
                    ret++;
            }
        case 3:
            ret++;
    }
    return (ret);
}

testSwth() {
    extrn printf, test, countSw, sw_in_sw;

    test(countSw(1) == 3, "switch 0");
    test(countSw(2) == 2, "switch 1");
    test(countSw(3) == 1, "switch 2");
    test(countSw(4) == 0, "switch 3");

    test(sw_in_sw(1, 1) == 5, "s in s 0");
    test(sw_in_sw(2, 1) == 4, "s in s 1");
    test(sw_in_sw(3, 1) == 1, "s in s 2");
    test(sw_in_sw(4, 1) == 0, "s in s 3");

    test(sw_in_sw(1, 2) == 4, "s in s 4");
    test(sw_in_sw(2, 2) == 3, "s in s 5");
    test(sw_in_sw(3, 2) == 1, "s in s 6");
    test(sw_in_sw(4, 2) == 0, "s in s 7");

    test(sw_in_sw(1, 3) == 3, "s in s 8");
    test(sw_in_sw(2, 3) == 2, "s in s 9");
    test(sw_in_sw(3, 3) == 1, "s in s 10");
    test(sw_in_sw(4, 3) == 0, "s in s 11");

    test(sw_in_sw(1, 4) == 2, "s in s 12");
    test(sw_in_sw(2, 4) == 1, "s in s 13");
    test(sw_in_sw(3, 4) == 1, "s in s 14");
    test(sw_in_sw(4, 4) == 0, "s in s 15");
}
