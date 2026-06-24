testFlot() {
    extrn printf, test, printfl;
    printf("Float\n");
    auto i 3, f1 3.1415;

    test(f1 == 0x40490e56, "flaot 0");

    test(3 != 3., "float 1");

    test(#3 == 3., "float 2");
    test(3. == #3, "float 3");

    test(##3. == 3, "float 4");
    test(3 == ##3., "float 5");
    test(3. == ##(#3.), "float 6");
    test(3. == #(##3.), "float 7");

    test(1.3 #+ 1.2 == 2.5, "float 8");
    test(1.325 #- 1.2 == 0.125, "float 9");
    test(1.125 #* 1.5 == 1.6875, "float 10");
    test(3.3 #/ 1.1 == 3., "float 11");

    test(#-12 != #-12., "float 12");
    test(#-12 != -#12, "float 13");
    test(#-12 != -#12., "float 14");
}
