printfl(f, nd) {
    extrn putchar, printn, printf;
    auto sign, expo, mantissa, value, integer, frac, i, digit;
	sign = f >> 31;
	expo = ((f & 0x7F800000) >> 23) - 127;
	mantissa = (f & 0x7FFFFF);

	value = 1.0 #+ #mantissa #/ #(1 << 23);

	if (expo >= 0)
		value = value #* #(1 << expo);
	else
		value = value #/ #(1 << -expo);


	if (sign)
		value = -value;

	integer = ##value;
	frac = value #- #integer;

	if (frac < 0)
		frac = -frac;

    printn(integer, 10);
    putchar('.');

    while (i < nd) {
		frac = frac #* 10.0;
		digit = ##frac;
		putchar(digit + '0');
		frac = frac #- #digit;
        i++;
    }
}
