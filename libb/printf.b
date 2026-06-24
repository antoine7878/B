printf(fmt, x1, x2, x3, x4, x5, x6, x7, x8, x9) {
    extrn printn, char, putchar, printh, printfl, printb, isdigit;
    auto adx, x, c, i, j;

    i = 0;
    adx = &x1;
loop:
    while ((c = char(fmt, i++)) != '%') {
        if (c == 0) {
            return;
        }
        putchar(c);
    }

    x = *adx;
    adx =+ 4;
    c = char(fmt, i++);

    if (c == 'd' | c == 'o') {
        if (x < 0) {
            x = -x;
            putchar('-');
        }
        printn(x, c == 'o' ? 8 : 10);
        goto loop;
    }
    if (c == 'b') {
        printb(x);
        goto loop;
    }
    if (isdigit(c)) {
        printfl(x, c - '0');
        goto loop;
    }
    if (c == 'h') {
        if (x < 0) {
            x = -x;
            putchar('-');
        }
        printh(x);
        goto loop;
    }
    if (c == 'c') {
        putchar(x);
        goto loop;
    }
    if (c == 's') {
        j = 0;
        while ((c = char(x, j++)) != 0) {
            putchar(c);
        }
        goto loop;
    }
    putchar('%');
    i--;
    adx =- 4;
    goto loop;
}
