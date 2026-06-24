seek(fd, off, ptr) {
    extrn syscall;
    return (syscall(19, fd, off, ptr));
}
