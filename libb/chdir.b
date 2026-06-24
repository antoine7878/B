chdir(path) {
    extrn syscall;
    return (syscall(12, path));
}
