printb(n) {
    extrn putchar, abs;
    auto a, i;
    while (i < 32) {
        putchar(n & (1 << (31 - i)) ? '1' : '0');
        i++;
    }
}

printn(n, b) {
    extrn putchar, abs;
    auto a;
    if (a = n / b)
        printn(a, b);
    putchar(abs(n % b) + '0');
}

printh(n) {
    extrn putchar;
    auto a, b;
    if (a = n / 16)
        printh(a);
    b = n % 16;
    if (b <= 9)
        putchar(b + '0');
    else
        putchar(b - 10 + 'A');
}
