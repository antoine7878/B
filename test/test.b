success 0;
fails 0;

test(ass, name) {
    extrn printf;

    if(ass) {
        printf("\x1b[0;32mOK: %s\x1b[0m\n", name);
        ++success;
    } else {
        printf("\x1b[0;31mKO: %s\x1b[0m\n", name);
        ++fails;
    }
}

testRes() {
    extrn printf;

    printf("===================== TEST RESULTS =====================\n");
    if (fails == 0) {
        printf("\x1b[0;32m%d/%d OK\033[0m\n", success, success + fails);
        return;
    }
    printf("\x1b[0;31m%d/%d KO\033[0m\n", success, success + fails);
}
