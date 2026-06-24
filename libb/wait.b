wait() {
    extrn syscall;
    auto status;
    return (syscall(7, -1, &status, 0));
}
