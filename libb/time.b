time(tv) {
    extrn syscall;
    auto t;
    t = syscall(13, 0);
    tv[0] = t & 65535;
    tv[1] = (t >> 16) & 65535;
}
