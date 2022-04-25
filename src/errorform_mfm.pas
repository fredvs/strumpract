unit errorform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,errorform;

const
 objdata: record size: integer; data: array[0..957] of byte end =
      (size: 958; data: (
  84,80,70,48,8,116,101,114,114,111,114,102,111,7,101,114,114,111,114,102,
  111,8,98,111,117,110,100,115,95,120,3,226,1,8,98,111,117,110,100,115,
  95,121,3,26,1,9,98,111,117,110,100,115,95,99,120,3,134,1,9,98,
  111,117,110,100,115,95,99,121,2,104,12,98,111,117,110,100,115,95,99,120,
  109,105,110,3,134,1,12,98,111,117,110,100,115,95,99,121,109,105,110,2,
  104,12,98,111,117,110,100,115,95,99,120,109,97,120,3,134,1,12,98,111,
  117,110,100,115,95,99,121,109,97,120,2,104,26,99,111,110,116,97,105,110,
  101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,
  114,46,98,111,117,110,100,115,1,2,0,2,0,3,134,1,2,104,0,13,
  111,112,116,105,111,110,115,119,105,110,100,111,119,11,12,119,111,95,110,111,
  116,97,115,107,98,97,114,10,119,111,95,114,111,117,110,100,101,100,0,13,
  119,105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,0,
  0,128,255,255,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,
  6,8,116,109,115,101,102,111,114,109,0,6,116,108,97,98,101,108,7,116,
  108,97,98,101,108,49,8,98,111,117,110,100,115,95,120,2,89,8,98,111,
  117,110,100,115,95,121,2,49,9,98,111,117,110,100,115,95,99,120,3,229,
  0,9,98,111,117,110,100,115,95,99,121,2,19,7,99,97,112,116,105,111,
  110,6,30,83,111,109,101,32,108,105,98,114,97,114,105,101,115,32,100,105,
  100,32,110,111,116,32,108,111,97,100,46,46,46,11,102,111,110,116,46,104,
  101,105,103,104,116,2,16,9,102,111,110,116,46,110,97,109,101,6,11,115,
  116,102,95,100,101,102,97,117,108,116,15,102,111,110,116,46,108,111,99,97,
  108,112,114,111,112,115,11,10,102,108,112,95,104,101,105,103,104,116,0,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,19,0,0,6,116,108,
  97,98,101,108,7,116,108,97,98,101,108,50,8,116,97,98,111,114,100,101,
  114,2,1,8,98,111,117,110,100,115,95,120,2,80,8,98,111,117,110,100,
  115,95,121,2,74,9,98,111,117,110,100,115,95,99,120,3,241,0,9,98,
  111,117,110,100,115,95,99,121,2,19,7,99,97,112,116,105,111,110,6,31,
  84,104,101,32,97,112,112,108,105,99,97,116,105,111,110,32,119,105,108,108,
  32,116,101,114,109,105,110,97,116,101,46,11,102,111,110,116,46,104,101,105,
  103,104,116,2,16,9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,
  95,100,101,102,97,117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,
  114,111,112,115,11,9,102,108,112,95,99,111,108,111,114,10,102,108,112,95,
  104,101,105,103,104,116,0,13,114,101,102,102,111,110,116,104,101,105,103,104,
  116,2,19,0,0,6,116,108,97,98,101,108,7,116,108,97,98,101,108,51,
  8,116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,
  2,62,8,98,111,117,110,100,115,95,121,2,14,9,98,111,117,110,100,115,
  95,99,120,3,246,0,9,98,111,117,110,100,115,95,99,121,2,22,7,99,
  97,112,116,105,111,110,6,26,42,42,42,32,83,116,114,117,109,80,114,97,
  99,116,32,87,97,114,110,105,110,103,32,42,42,42,10,102,111,110,116,46,
  99,111,108,111,114,4,7,0,0,160,11,102,111,110,116,46,104,101,105,103,
  104,116,2,18,10,102,111,110,116,46,115,116,121,108,101,11,9,102,115,95,
  105,116,97,108,105,99,0,9,102,111,110,116,46,110,97,109,101,6,11,115,
  116,102,95,100,101,102,97,117,108,116,15,102,111,110,116,46,108,111,99,97,
  108,112,114,111,112,115,11,9,102,108,112,95,99,111,108,111,114,9,102,108,
  112,95,115,116,121,108,101,10,102,108,112,95,104,101,105,103,104,116,0,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,22,0,0,0)
 );

initialization
 registerobjectdata(@objdata,terrorfo,'');
end.
