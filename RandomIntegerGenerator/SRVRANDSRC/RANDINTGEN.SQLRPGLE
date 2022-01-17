**FREE
// >>PRE-COMPILER<<                                              */
//   >>CRTCMD<<  CRTSQLRPGI SRCFILE(&SL/&SF) SRCMBR(&SM);        */
//   >>IMPORTANT<<                                               */
//     >>PARM<<  OBJ(&LI/&OB);                                   */
//     >>PARM<<  OBJTYPE(*MODULE);                               */
//     >>PARM<<  OPTION(*EVENTF);                                */
//     >>PARM<<  RPGPPOPT(*LVL2);                                */
//     >>PARM<<  CLOSQLCSR(*ENDACTGRP);                          */
//     >>PARM<<  DATFMT(*ISO);                                   */
//     >>PARM<<  TIMFMT(*ISO);                                   */
//   >>END-IMPORTANT<<                                           */
//   >>EXECUTE<<                                                 */
// >>END-PRE-COMPILER<<                                          */
ctl-opt nomain;

// Subprocedure prototypes of Random Generator services
/Include SrvRandSrc,RndGenSrvp

Dcl-proc IntegerRandomGenerator export;
  Dcl-pi IntegerRandomGenerator Int(20);
    pMultiplier Int(20) const;
  End-Pi;

  Dcl-pr CalculateUniformRandomNumbers Extproc('CEERAN0');
    pSeed int(10);
    pRandomNo  float(8);
    fc char(12) options(*omit);
  end-pr;

  Dcl-s lSeed int(10) inz(0);
  Dcl-s lRandomNo Float(8);
  Dcl-s lResult Int(20);

  Monitor;
    CalculateUniformRandomNumbers( lSeed : lRandomNo : *omit );
    lResult = %inth(lRandomNo * pMultiplier);
  On-error;
  Endmon;

  // "result" now contains a integer between 1 and mult.
  return lResult;
End-proc;
