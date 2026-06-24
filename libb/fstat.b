fstat(fd, status) {
    extrn syscall;
    return (syscall(108, fd, status));
}
