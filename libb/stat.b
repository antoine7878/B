stat(path, status) {
    extrn syscall;
    return (syscall(106, path, status));
}
