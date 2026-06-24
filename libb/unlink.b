unlink(path) {
    extrn syscall;
    return (syscall(10, path));
}
