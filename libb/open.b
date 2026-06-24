open(path, mode) {
    extrn syscall;
    return (syscall(5, path, mode));
}
