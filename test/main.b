main(argc, argv, envp)
{
    extrn testAss, testCmp, testOp, testUna, testTern, testIfEl, testLoop, testFun, testGlob;
    extrn testChar, testCBit, testScop, testRetV, testStr, testComm, testEsc, testOct, testPtr;
    extrn testEmpt, testExt, testGArr, testRes, testArgv, testAuto, testCtim, testFork, testFsta;
    extrn testIcha, testRead, testTime, testWrit, testUid, testGch, testBin, testHex, printf, printh;
    extrn testSwth, testFlot, e2;

    testOp();
    testAss();
    testCmp();
    testUna();
    testTern();
    testIfEl();
    testLoop();
    testFun();
    testCBit();
    testScop();
    testRetV();
    testComm();
    testEsc();
    testOct();
    testPtr();
    testEmpt();
    testExt();
    testStr();
    testAuto();
    testGlob();
    testArgv(argc, argv, envp);
    testGArr();
    testChar();

    testFork();
    testRead();
    testTime();
    testWrit();
    testUid();
    testGch();
    testCtim();
    testIcha();

    testSwth();
    testFlot();
    testBin();
    testHex();

    /* e2(); */
    testRes();
}
