testArgv(argc, argv, envp) {
    extrn printf, test, strcmp;
    printf("Program args\n");

    test(argc == 2, "argc 0");
    test(strcmp(*argv, "./test/tester") == 0, "argv 0");
    test(strcmp(argv[1], "salut") == 0, "argv 1");
    test(strcmp(envp[0], "TEST_ENV=coucou") == 0, "envp 0"); }
