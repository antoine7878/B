rmdir(path) {
    extrn syscall;
    return (syscall(40, path));
}
