getchar() {
    extrn syscall;
    auto c 0;

    if (syscall(3, 0, &c, 1) == 1)
        return (c);
    return (-1);
}
