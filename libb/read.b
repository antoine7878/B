read(fd, buf, cnt) {
    extrn syscall;
    return (syscall(3, fd, buf, cnt));
}
