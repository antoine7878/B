mons[] 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31;

ctime(tv, date) {
    extrn ichar, mons;
    auto t, i, m, d, y, h, mi, s, days, isleap;

    t = tv[0] | (tv[1] << 16);
    s = t % 60;
    t = t / 60;
    mi = t % 60;
    t = t / 60;
    h = t % 24;
    days = t / 24;
    y = 1970;

yearloop:
    isleap = 0;
    if (y % 4 == 0)
        isleap = 1;
    if (y % 100 == 0)
        isleap = 0;
    if (y % 400 == 0)
        isleap = 1;
    d = 365;
    if (isleap)
        d = 366;
    if (days < d)
        goto yeardone;
    days =- d;
    y++;
    goto yearloop;

yeardone:
    mons[1] = isleap ? 29 : 28;
    m = 0;

monloop:
    d = mons[m];
    if (days < d)
        goto mondone;
    days =- d;
    m++;
    goto monloop;

mondone:
    d = days + 1;
    ichar(date, 0, (d / 10) % 10 + '0');
    ichar(date, 1, d % 10 + '0');
    ichar(date, 2, '/');
    ichar(date, 3, (m + 1) / 10 + '0');
    ichar(date, 4, (m + 1) % 10 + '0');
    ichar(date, 5, '/');
    ichar(date, 6, (y / 1000) % 10 + '0');
    ichar(date, 7, (y / 100) % 10 + '0');
    ichar(date, 8, (y / 10) % 10 + '0');
    ichar(date, 9, y % 10 + '0');
    ichar(date, 10, ' ');
    ichar(date, 11, (h / 10) % 10 + '0');
    ichar(date, 12, h % 10 + '0');
    ichar(date, 13, ':');
    ichar(date, 14, (mi / 10) % 10 + '0');
    ichar(date, 15, mi % 10 + '0');
    ichar(date, 16, ':');
    ichar(date, 17, (s / 10) % 10 + '0');
    ichar(date, 18, s % 10 + '0');
    ichar(date, 19, 0);
}
