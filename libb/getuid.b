getuid() {
    extrn syscall;
    return (syscall(24));
}
