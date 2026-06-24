execv(path, argv, cnt) {
    extrn syscall;

    argv[cnt] = 0;
    return (syscall(11, path, argv));
}
