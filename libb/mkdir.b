mkdir(path, mode) {
    extrn syscall;
    return (syscall(39, path, mode));
}
