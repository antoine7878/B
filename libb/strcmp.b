strcmp(s1, s2) {
    extrn char;
    auto i;
    auto c1, c2;

    while ((c1 = char(s1, i)) == (c2 = char(s2, i)) & c1 != '\0') {
        if (c1 != c2)
            goto ret;
        i++;
    }
ret:
    return (c1 - c2);
}
