tbuf[100];
tbuf2[100];
tfd0;
tfd1;
ttv[2];
ttv2[2];
rdbuf[4];

testCtim() {
    extrn test, time, ctime, char, strcmp, printf;
    printf("Ctime\n");

    time(ttv);
    ttv[0] = 0;
    ttv[1] = 0;
    ctime(ttv, tbuf);
    test(char(tbuf, 0) != 0, "ctime 0");
    test(strcmp(tbuf, "01/01/1970 00:00:00") == 0, "ctime 1");

    time(ttv);
    ctime(ttv, tbuf);
    test(char(tbuf, 0) != 0, "ctime 2");
}

testFork() {
    extrn test, printf, fork, wait, exit;
    printf("Fork\n");

    auto pid, wret;

    pid = fork();
    test(pid >= 0, "fork 0");
    if (pid == 0) {
        exit();
    }
    wret = wait();
    test(wret > 0, "fork 1");
}

testIcha() {
    extrn test, printf, ichar, char;
    printf("Ichar\n");

    ichar(tbuf, 0, 'X');
    test(char(tbuf, 0) == 'X', "ichar 0");
    ichar(tbuf, 1, 'Y');
    ichar(tbuf, 2, 'Z');
    test(char(tbuf, 0) == 'X', "ichar 1");
    test(char(tbuf, 1) == 'Y', "ichar 2");
    test(char(tbuf, 2) == 'Z', "ichar 3");
    ichar(tbuf, 0, 'A');
    ichar(tbuf, 1, 'B');
    ichar(tbuf, 2, 'C');
    ichar(tbuf, 3, 0);
    test(char(tbuf, 0) == 'A', "ichar 4");
    test(char(tbuf, 3) == 0, "ichar 5");
}

testRead() {
    extrn test, printf, open, read, close;
    auto fd, n;
    printf("Read\n");

    fd = open("/etc/hostname", 0);
    if (fd >= 0) {
        n = read(fd, rdbuf, 4);
        test(n > 0, "read 0");
        close(fd);
    }
}

testTime() {
    extrn test, printf, time;
    printf("Time\n");

    auto t;
    time(ttv);
    t = ttv[0] | (ttv[1] << 16);
    test(t > 1700000000, "time 0");
}

testWrit() {
    extrn test, printf, write, creat, close, unlink;
    printf("Write\n");

    auto fd, n;
    fd = creat("__b_twrite", 511);
    if (fd >= 0) {
        n = write(fd, "hello", 5);
        test(n == 5, "write 0");
        close(fd);
        unlink("__b_twrite");
    }
}

testGch() {
    extrn test, printf, getchar;
    printf("Getchar\n");

    auto c;
    c = getchar();
    test(c == 'A', "getchar 0");
}

testUid() {
    extrn test, printf, getuid;
    printf("Getuid\n");

    auto uid;
    uid = getuid();
    test(uid >= 0, "getuid 0");
}
