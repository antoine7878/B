execl(path, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15) {
    extrn execv, printf;
    auto i, adx;
    adx = &a0;
    i = 0;
    while (adx[i]) {
        i++;
    }
    return (execv(path, &a0, i));
}
