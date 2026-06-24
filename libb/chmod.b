chmod(path, mode) {
    extrn syscall;
    return (syscall(15, path, mode));
}
