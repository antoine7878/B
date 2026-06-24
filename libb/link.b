link(src, dst) {
    extrn syscall;
    return (syscall(9, src, dst));
}
