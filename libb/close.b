close(fd) {
    extrn syscall;
    return (syscall(6, fd));
}
