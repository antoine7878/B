ichar(s, i, c) {
    auto a, off, w, sh;

    s =+ i;
    *s =& 0xFFFFFF00;
    *s =| (c & 0xFF);
}
