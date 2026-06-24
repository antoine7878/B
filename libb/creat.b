creat(path, mode) {
    extrn syscall;
    return (syscall(8, path, mode));
}
