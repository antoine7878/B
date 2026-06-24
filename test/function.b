f1() {
    return (1);
}

f2() {
    return (2);
}

fibo(n) {
    extrn printf;
    if (n < 2)
        return (n);
    return (fibo(n - 1) + fibo(n - 2));
}

testFun() {
    extrn test, printf, f1, f2;
    printf("Function\n");

    auto a, b, c;

    test(f1() == 1, "fun 0");
    test(f2() == 2, "fun 1");

    test(fibo(0) == 0, "fibo 0");
    test(fibo(1) == 1, "fibo 1");
    test(fibo(2) == 1, "fibo 2");
    test(fibo(3) == 2, "fibo 3");
    test(fibo(4) == 3, "fibo 4");
    test(fibo(5) == 5, "fibo 5");
    test(fibo(6) == 8, "fibo 6");
    test(fibo(7) == 13,"fibo 7");
}
