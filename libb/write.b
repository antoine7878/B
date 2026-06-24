write(fd, buf, cnt) {
    extrn syscall;
    return (syscall(4, fd, buf, cnt));
}
