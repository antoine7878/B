chown(path, owner) {
    extrn syscall;
    return (syscall(182, path, owner, -1));
}
