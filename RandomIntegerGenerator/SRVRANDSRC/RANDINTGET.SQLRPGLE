**FREE
//=====================================================================*
//  Empty Unit Test Case. Prints a protocol of the execution flow.     *
//=====================================================================*
//  Command to create the service program:                             *
//  RUCRTTST TSTPGM(RPGUNIT/TEMPLATE) SRCFILE(RPGUNIT/RPGUNIT1)        *
//=====================================================================*
//  Tools/400 STRPREPRC instructions:                                  *
//   >>PRE-COMPILER<<                                                  *
//     >>CRTCMD<<  RUCRTTST    TSTPGM(&LI/&OB) +                       *
//                             SRCFILE(&SL/&SF);                       *
//     >>COMPILE<<                                                     *
//       >>PARM<< COPTION(*SRCSTMT *EVENTF);                           *
//       >>PARM<< DBGVIEW(*ALL);                                       *
//     >>END-COMPILE<<                                                 *
//     >>EXECUTE<<                                                     *
//   >>END-PRE-COMPILER<<                                              *
//=====================================================================*
ctl-opt nomain option(*srcstmt) Bnddir('RANDOMSRV');
dcl-f QSYSPRT printer(80) usropn oflind(*in70);

//iRPGUnit Test Suite
/copy QINCLUDE,TESTCASE

/Copy Srvrandsrc,Rndgensrvp

// ============================================================
//  Opens the printer.
// ============================================================
dcl-proc openPrinter export;
  dcl-pi *n end-pi;

  open QSYSPRT;

end-proc;

// ============================================================
//  Prints a message.
// ============================================================
dcl-proc print export;
  dcl-pi *n;
    text varchar(128) value  options(*nopass);
  end-pi;

  dcl-ds lineOutput len(80) inz end-ds;

  if (%parms() >= 1);
    lineOutput = text;
  else;
    lineOutput = '';
  endif;
  write QSYSPRT lineOutput;

end-proc;

// ============================================================
//  Closes the printer.
// ============================================================
dcl-proc closePrinter export;
  dcl-pi *n end-pi;

  if (%open(QSYSPRT));
    close QSYSPRT;
  endif;

end-proc;

// ============================================================
//  Set up test suite. Executed once per RUCALLTST.
// ============================================================
dcl-proc setUpSuite export;
  dcl-pi *n end-pi;

  dcl-s rc char(1);

  runCmd('OVRPRTF FILE(QSYSPRT) TOFILE(*FILE) +
          SPLFNAME(PROC_FLOW) OVRSCOPE(*JOB)');
  monitor;
    openPrinter();
    print('Executing:   setUpSuite()');
  on-error;
  // ignore errors ...
  endmon;

  // ... but try to remove the override.
  monitor;
    runCmd('DLTOVR FILE(QSYSPRT) LVL(*JOB)');
  on-error;
    dsply '*** Failed to delete QSYSPRT override! ***' rc;
  endmon;

end-proc;

// ============================================================
//  Tear down test suite.
// ============================================================
dcl-proc tearDownSuite export;
  dcl-pi *n end-pi;

  print('Executing:   tearDownSuite()');
  closePrinter();

end-proc;

// ============================================================
//  Set up test case.
// ============================================================
dcl-proc setUp export;
  dcl-pi *n end-pi;

  print('Executing:   - setUp()');

end-proc;

// ============================================================
//  Tear down test case.
// ============================================================
dcl-proc tearDown export;
  dcl-pi *n end-pi;

  print('Executing:   - tearDown()');

end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testRandomNormalintegergeneration_1 export;
  dcl-pi *n end-pi;

  Dcl-s iniLimit Int(20) Inz(112);

  Dcl-s VrfGeneratedRandomInteger Int(20) Inz(112);
  Dcl-s refLimitInf Int(20) Inz(0);
  Dcl-s refLimitSup Int(20) Inz(112);

  print('Executing:       * testRandomNormalintegergeneration_1()');

  VrfGeneratedRandomInteger=IntegerRandomGenerator(iniLimit);

// Place your assertions here.
  assert(VrfRandomIntegerGenerated>refLimitInf:'Generated integer '
                                       + %Char(VrfRandomIntegerGenerated) +
                                                        ' is smaller than Inferior limit ' + %Char(refLimitInf));

  assert(VrfRandomIntegerGenerated<refLimitSup:'Generated integer '
                                         + %Char(VrfRandomIntegerGenerated) +
                                               ' smaller than bigger than superior limit ' + %Char(refLimitSup));
end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testWhatever_2 export;
  dcl-pi *n end-pi;

  print('Executing:       * testWhatever_2()');

// Place your assertions here.

end-proc;
