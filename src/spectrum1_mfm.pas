unit spectrum1_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,spectrum1;

const
 objdata: record size: integer; data: array[0..5966] of byte end =
      (size: 5967; data: (
  84,80,70,48,12,116,115,112,101,99,116,114,117,109,49,102,111,11,115,112,
  101,99,116,114,117,109,49,102,111,15,102,114,97,109,101,46,102,111,110,116,
  46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,21,102,
  114,97,109,101,46,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,
  11,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,15,102,114,97,109,101,46,103,114,105,112,95,115,105,122,101,2,8,15,
  102,114,97,109,101,46,103,114,105,112,95,103,114,105,112,7,9,115,116,98,
  95,100,101,110,115,48,26,102,114,97,109,101,46,103,114,105,112,95,102,97,
  99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,24,102,114,97,109,
  101,46,103,114,105,112,95,102,97,99,101,46,116,101,109,112,108,97,116,101,
  7,19,109,97,105,110,102,111,46,116,102,97,99,101,98,117,116,103,114,97,
  121,32,102,114,97,109,101,46,103,114,105,112,95,102,97,99,101,97,99,116,
  105,118,101,46,108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,
  109,101,46,103,114,105,112,95,102,97,99,101,97,99,116,105,118,101,46,116,
  101,109,112,108,97,116,101,7,17,109,97,105,110,102,111,46,116,102,97,99,
  101,103,114,101,101,110,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,95,1,8,98,111,117,110,100,115,95,121,3,240,0,9,
  98,111,117,110,100,115,95,99,120,3,186,1,9,98,111,117,110,100,115,95,
  99,121,3,128,0,12,98,111,117,110,100,115,95,99,120,109,105,110,3,186,
  1,12,98,111,117,110,100,115,95,99,121,109,105,110,3,128,0,12,98,111,
  117,110,100,115,95,99,120,109,97,120,3,186,1,12,98,111,117,110,100,115,
  95,99,121,109,97,120,3,128,0,26,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,27,99,
  111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,46,98,
  111,117,110,100,115,1,2,0,2,0,3,178,1,3,128,0,0,22,100,114,
  97,103,100,111,99,107,46,115,112,108,105,116,116,101,114,95,103,114,105,112,
  7,11,115,116,98,95,100,101,102,97,117,108,116,16,100,114,97,103,100,111,
  99,107,46,102,97,99,101,116,97,98,7,19,109,97,105,110,102,111,46,116,
  102,97,99,101,98,117,116,103,114,97,121,22,100,114,97,103,100,111,99,107,
  46,102,97,99,101,97,99,116,105,118,101,116,97,98,7,23,109,97,105,110,
  102,111,46,116,102,97,99,101,112,108,97,121,101,114,108,105,103,104,116,16,
  100,114,97,103,100,111,99,107,46,99,97,112,116,105,111,110,6,7,32,83,
  112,101,99,116,32,20,100,114,97,103,100,111,99,107,46,111,112,116,105,111,
  110,115,100,111,99,107,11,10,111,100,95,115,97,118,101,112,111,115,13,111,
  100,95,115,97,118,101,122,111,114,100,101,114,10,111,100,95,99,97,110,109,
  111,118,101,11,111,100,95,99,97,110,102,108,111,97,116,10,111,100,95,99,
  97,110,100,111,99,107,10,111,100,95,102,105,120,115,105,122,101,14,111,100,
  95,99,97,112,116,105,111,110,104,105,110,116,0,16,100,114,97,103,100,111,
  99,107,46,98,97,110,100,103,97,112,2,1,9,102,111,110,116,46,110,97,
  109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,15,102,111,110,116,
  46,108,111,99,97,108,112,114,111,112,115,11,0,8,115,116,97,116,102,105,
  108,101,7,17,109,97,105,110,102,111,46,116,115,116,97,116,102,105,108,101,
  49,7,99,97,112,116,105,111,110,6,8,83,112,101,99,116,114,117,109,12,
  105,99,111,110,46,111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,
  115,107,101,100,0,15,105,99,111,110,46,111,114,105,103,102,111,114,109,97,
  116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,101,10,68,3,
  0,0,0,0,0,0,2,0,0,0,24,0,0,0,24,0,0,0,176,2,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,108,202,198,
  206,1,239,173,201,4,221,187,203,1,0,0,0,18,212,193,205,1,255,158,
  198,4,234,177,201,1,0,0,0,18,212,193,205,1,255,158,198,4,234,177,
  201,1,0,0,0,18,212,193,205,1,255,158,198,4,234,177,201,1,0,0,
  0,12,192,204,207,1,220,188,204,4,206,196,205,1,212,193,205,1,255,158,
  198,4,234,177,201,1,0,0,0,12,212,193,205,1,255,158,198,4,234,177,
  201,1,212,193,205,1,255,158,198,4,234,177,201,1,0,0,0,12,212,193,
  205,1,255,158,198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,
  201,1,192,204,207,1,220,188,204,4,206,196,205,1,0,0,0,6,212,193,
  205,1,255,158,198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,
  201,2,255,158,198,4,212,193,205,1,192,204,207,1,220,188,204,4,206,196,
  205,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,205,1,255,158,
  198,4,234,177,201,2,255,158,198,4,212,193,205,1,211,193,205,1,255,158,
  198,4,234,177,202,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,2,255,158,
  198,4,234,177,201,1,212,193,205,1,255,158,198,4,234,177,201,1,212,193,
  205,1,255,158,198,4,234,177,201,2,255,158,198,4,212,193,205,1,211,197,
  206,1,242,175,201,4,227,187,203,1,211,197,206,1,242,175,201,4,227,187,
  203,1,211,197,206,1,242,175,201,4,227,187,203,2,242,175,201,4,211,197,
  206,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,
  3,0,0,240,3,0,0,240,3,0,0,240,3,0,192,255,3,0,192,255,
  3,0,192,255,255,0,192,255,255,0,255,255,255,0,255,255,255,0,255,255,
  255,0,255,255,255,0,255,255,255,0,255,255,255,0,255,255,255,0,255,255,
  255,0,255,255,255,0,255,255,255,0,255,255,255,0,255,255,255,0,8,111,
  110,99,114,101,97,116,101,7,4,99,114,101,97,9,111,110,99,114,101,97,
  116,101,100,7,13,111,110,102,111,114,109,99,114,101,97,116,101,100,6,111,
  110,115,104,111,119,7,15,111,110,118,105,115,105,98,108,101,99,104,97,110,
  103,101,6,111,110,104,105,100,101,7,15,111,110,118,105,115,105,98,108,101,
  99,104,97,110,103,101,15,109,111,100,117,108,101,99,108,97,115,115,110,97,
  109,101,6,9,116,100,111,99,107,102,111,114,109,0,9,116,103,114,111,117,
  112,98,111,120,4,102,111,110,100,8,98,111,117,110,100,115,95,120,2,0,
  8,98,111,117,110,100,115,95,121,2,0,9,98,111,117,110,100,115,95,99,
  120,3,176,1,9,98,111,117,110,100,115,95,99,121,2,126,0,9,116,103,
  114,111,117,112,98,111,120,9,103,114,111,117,112,98,111,120,50,5,99,111,
  108,111,114,4,3,0,0,128,12,102,114,97,109,101,46,108,101,118,101,108,
  111,2,1,12,102,114,97,109,101,46,108,101,118,101,108,105,2,0,20,102,
  114,97,109,101,46,99,111,108,111,114,104,105,103,104,108,105,103,104,116,4,
  3,0,0,160,17,102,114,97,109,101,46,104,105,100,100,101,110,101,100,103,
  101,115,11,10,101,100,103,95,98,111,116,116,111,109,0,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,5,114,105,103,104,116,22,102,114,97,
  109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,108,97,103,115,11,
  12,116,102,95,120,99,101,110,116,101,114,101,100,9,116,102,95,98,111,116,
  116,111,109,0,16,102,114,97,109,101,46,99,97,112,116,105,111,110,112,111,
  115,7,11,99,112,95,116,111,112,114,105,103,104,116,19,102,114,97,109,101,
  46,99,97,112,116,105,111,110,111,102,102,115,101,116,2,206,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,10,102,114,108,95,108,
  101,118,101,108,111,10,102,114,108,95,108,101,118,101,108,105,14,102,114,108,
  95,99,111,108,111,114,102,114,97,109,101,17,102,114,108,95,99,111,108,111,
  114,100,107,115,104,97,100,111,119,14,102,114,108,95,99,111,108,111,114,108,
  105,103,104,116,18,102,114,108,95,99,111,108,111,114,104,105,103,104,108,105,
  103,104,116,15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,18,
  102,114,108,49,95,99,97,112,116,105,111,110,111,102,102,115,101,116,22,102,
  114,108,49,95,99,111,108,111,114,102,114,97,109,101,100,101,102,97,117,108,
  116,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,8,2,0,2,0,0,8,98,111,117,110,100,115,95,120,3,216,
  0,8,98,111,117,110,100,115,95,121,2,0,9,98,111,117,110,100,115,95,
  99,120,3,216,0,9,98,111,117,110,100,115,95,99,121,2,127,0,6,116,
  108,97,98,101,108,10,108,97,98,101,108,114,105,103,104,116,5,99,111,108,
  111,114,4,3,0,0,128,8,98,111,117,110,100,115,95,120,2,3,8,98,
  111,117,110,100,115,95,121,2,15,9,98,111,117,110,100,115,95,99,120,3,
  205,0,9,98,111,117,110,100,115,95,99,121,2,12,7,99,97,112,116,105,
  111,110,6,46,32,51,49,32,32,32,54,50,32,32,49,50,53,32,50,53,
  48,32,53,48,48,32,32,49,107,32,32,32,32,50,107,32,32,32,52,107,
  32,32,32,56,107,32,32,49,54,107,11,102,111,110,116,46,104,101,105,103,
  104,116,2,9,9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,
  100,101,102,97,117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,
  111,112,115,11,10,102,108,112,95,104,101,105,103,104,116,0,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,12,0,0,6,116,99,104,97,114,
  116,11,116,99,104,97,114,116,114,105,103,104,116,5,99,111,108,111,114,4,
  5,0,0,144,18,102,114,97,109,101,46,99,111,108,111,114,100,107,119,105,
  100,116,104,2,0,18,102,114,97,109,101,46,99,111,108,111,114,104,108,119,
  105,100,116,104,2,0,17,102,114,97,109,101,46,99,111,108,111,114,99,108,
  105,101,110,116,4,3,0,0,128,17,102,114,97,109,101,46,111,112,116,105,
  111,110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,16,102,114,108,
  95,99,111,108,111,114,100,107,119,105,100,116,104,16,102,114,108,95,99,111,
  108,111,114,104,108,119,105,100,116,104,15,102,114,108,95,111,112,116,105,111,
  110,115,115,107,105,110,15,102,114,108,95,99,111,108,111,114,99,108,105,101,
  110,116,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  49,11,0,8,116,97,98,111,114,100,101,114,2,1,4,104,105,110,116,6,
  26,32,82,105,103,104,116,32,70,114,101,113,117,101,110,99,121,32,115,112,
  101,99,116,114,117,109,32,8,98,111,117,110,100,115,95,120,2,0,8,98,
  111,117,110,100,115,95,121,2,26,9,98,111,117,110,100,115,95,99,120,3,
  212,0,9,98,111,117,110,100,115,95,99,121,2,101,12,116,114,97,99,101,
  115,46,99,111,117,110,116,2,1,16,116,114,97,99,101,115,46,99,104,97,
  114,116,107,105,110,100,7,7,116,99,107,95,98,97,114,14,116,114,97,99,
  101,115,46,111,112,116,105,111,110,115,11,10,99,116,111,95,115,109,111,111,
  116,104,0,16,116,114,97,99,101,115,46,120,115,101,114,115,116,97,114,116,
  5,10,215,163,112,61,10,215,163,249,63,13,116,114,97,99,101,115,46,120,
  114,97,110,103,101,2,1,16,116,114,97,99,101,115,46,120,115,101,114,114,
  97,110,103,101,5,102,102,102,102,102,102,102,230,254,63,13,116,114,97,99,
  101,115,46,121,114,97,110,103,101,2,1,16,116,114,97,99,101,115,46,98,
  97,114,95,119,105,100,116,104,2,18,12,116,114,97,99,101,115,46,105,116,
  101,109,115,14,1,5,99,111,108,111,114,4,1,0,0,128,7,119,105,100,
  116,104,109,109,5,154,153,153,153,153,153,153,153,253,63,9,120,115,101,114,
  114,97,110,103,101,5,102,102,102,102,102,102,102,230,254,63,9,120,115,101,
  114,115,116,97,114,116,5,10,215,163,112,61,10,215,163,249,63,6,120,114,
  97,110,103,101,2,1,6,121,114,97,110,103,101,2,1,9,99,104,97,114,
  116,107,105,110,100,7,7,116,99,107,95,98,97,114,7,111,112,116,105,111,
  110,115,11,10,99,116,111,95,115,109,111,111,116,104,0,9,98,97,114,95,
  119,105,100,116,104,2,18,23,98,97,114,95,102,97,99,101,46,102,97,100,
  101,95,112,111,115,46,99,111,117,110,116,2,2,23,98,97,114,95,102,97,
  99,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,1,2,0,
  2,1,0,25,98,97,114,95,102,97,99,101,46,102,97,100,101,95,99,111,
  108,111,114,46,99,111,117,110,116,2,2,25,98,97,114,95,102,97,99,101,
  46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,178,
  178,178,0,4,5,0,0,160,0,19,98,97,114,95,102,97,99,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,0,0,10,99,111,108,111,114,99,
  104,97,114,116,4,5,0,0,144,21,102,114,97,109,101,99,104,97,114,116,
  46,108,111,99,97,108,112,114,111,112,115,11,0,22,102,114,97,109,101,99,
  104,97,114,116,46,108,111,99,97,108,112,114,111,112,115,49,11,0,6,120,
  114,97,110,103,101,2,1,6,121,114,97,110,103,101,2,1,12,120,100,105,
  97,108,115,46,114,97,110,103,101,2,1,12,121,100,105,97,108,115,46,114,
  97,110,103,101,2,1,0,0,0,9,116,103,114,111,117,112,98,111,120,9,
  103,114,111,117,112,98,111,120,49,5,99,111,108,111,114,4,3,0,0,128,
  12,102,114,97,109,101,46,108,101,118,101,108,111,2,1,12,102,114,97,109,
  101,46,108,101,118,101,108,105,2,0,20,102,114,97,109,101,46,99,111,108,
  111,114,104,105,103,104,108,105,103,104,116,4,3,0,0,160,17,102,114,97,
  109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,95,
  98,111,116,116,111,109,0,13,102,114,97,109,101,46,99,97,112,116,105,111,
  110,6,4,108,101,102,116,22,102,114,97,109,101,46,99,97,112,116,105,111,
  110,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,99,101,110,116,
  101,114,101,100,9,116,102,95,98,111,116,116,111,109,0,19,102,114,97,109,
  101,46,99,97,112,116,105,111,110,111,102,102,115,101,116,2,50,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,10,102,114,108,95,
  108,101,118,101,108,111,10,102,114,108,95,108,101,118,101,108,105,14,102,114,
  108,95,99,111,108,111,114,102,114,97,109,101,17,102,114,108,95,99,111,108,
  111,114,100,107,115,104,97,100,111,119,14,102,114,108,95,99,111,108,111,114,
  108,105,103,104,116,18,102,114,108,95,99,111,108,111,114,104,105,103,104,108,
  105,103,104,116,15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  18,102,114,108,49,95,99,97,112,116,105,111,110,111,102,102,115,101,116,22,
  102,114,108,49,95,99,111,108,111,114,102,114,97,109,101,100,101,102,97,117,
  108,116,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,
  1,2,0,2,8,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,
  1,8,98,111,117,110,100,115,95,120,2,1,8,98,111,117,110,100,115,95,
  121,2,0,9,98,111,117,110,100,115,95,99,120,3,216,0,9,98,111,117,
  110,100,115,95,99,121,2,127,0,6,116,99,104,97,114,116,10,116,99,104,
  97,114,116,108,101,102,116,5,99,111,108,111,114,4,5,0,0,144,18,102,
  114,97,109,101,46,99,111,108,111,114,100,107,119,105,100,116,104,2,0,18,
  102,114,97,109,101,46,99,111,108,111,114,104,108,119,105,100,116,104,2,0,
  17,102,114,97,109,101,46,99,111,108,111,114,99,108,105,101,110,116,4,3,
  0,0,128,17,102,114,97,109,101,46,111,112,116,105,111,110,115,115,107,105,
  110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,16,102,114,108,95,99,111,108,111,114,
  100,107,119,105,100,116,104,16,102,114,108,95,99,111,108,111,114,104,108,119,
  105,100,116,104,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,
  15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,4,104,105,
  110,116,6,25,32,76,101,102,116,32,70,114,101,113,117,101,110,99,121,32,
  115,112,101,99,116,114,117,109,32,8,98,111,117,110,100,115,95,120,2,0,
  8,98,111,117,110,100,115,95,121,2,26,9,98,111,117,110,100,115,95,99,
  120,3,212,0,9,98,111,117,110,100,115,95,99,121,2,101,12,116,114,97,
  99,101,115,46,99,111,117,110,116,2,1,16,116,114,97,99,101,115,46,99,
  104,97,114,116,107,105,110,100,7,7,116,99,107,95,98,97,114,14,116,114,
  97,99,101,115,46,111,112,116,105,111,110,115,11,10,99,116,111,95,115,109,
  111,111,116,104,0,16,116,114,97,99,101,115,46,120,115,101,114,115,116,97,
  114,116,5,10,215,163,112,61,10,215,163,249,63,13,116,114,97,99,101,115,
  46,120,114,97,110,103,101,2,1,16,116,114,97,99,101,115,46,120,115,101,
  114,114,97,110,103,101,5,102,102,102,102,102,102,102,230,254,63,13,116,114,
  97,99,101,115,46,121,114,97,110,103,101,2,1,16,116,114,97,99,101,115,
  46,98,97,114,95,119,105,100,116,104,2,18,12,116,114,97,99,101,115,46,
  105,116,101,109,115,14,1,5,99,111,108,111,114,4,1,0,0,128,7,119,
  105,100,116,104,109,109,5,154,153,153,153,153,153,153,153,253,63,9,120,115,
  101,114,114,97,110,103,101,5,102,102,102,102,102,102,102,230,254,63,9,120,
  115,101,114,115,116,97,114,116,5,10,215,163,112,61,10,215,163,249,63,6,
  120,114,97,110,103,101,2,1,6,121,114,97,110,103,101,2,1,9,99,104,
  97,114,116,107,105,110,100,7,7,116,99,107,95,98,97,114,7,111,112,116,
  105,111,110,115,11,10,99,116,111,95,115,109,111,111,116,104,0,9,98,97,
  114,95,119,105,100,116,104,2,18,23,98,97,114,95,102,97,99,101,46,102,
  97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,98,97,114,95,
  102,97,99,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,1,
  2,0,2,1,0,25,98,97,114,95,102,97,99,101,46,102,97,100,101,95,
  99,111,108,111,114,46,99,111,117,110,116,2,2,25,98,97,114,95,102,97,
  99,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,
  4,178,178,178,0,4,5,0,0,160,0,19,98,97,114,95,102,97,99,101,
  46,108,111,99,97,108,112,114,111,112,115,11,0,0,0,10,99,111,108,111,
  114,99,104,97,114,116,4,5,0,0,144,6,120,114,97,110,103,101,2,1,
  6,121,114,97,110,103,101,2,1,12,120,100,105,97,108,115,46,114,97,110,
  103,101,2,1,12,121,100,105,97,108,115,46,114,97,110,103,101,2,1,0,
  0,6,116,108,97,98,101,108,9,108,97,98,101,108,108,101,102,116,5,99,
  111,108,111,114,4,3,0,0,128,8,116,97,98,111,114,100,101,114,2,1,
  8,98,111,117,110,100,115,95,120,2,3,8,98,111,117,110,100,115,95,121,
  2,15,9,98,111,117,110,100,115,95,99,120,3,205,0,9,98,111,117,110,
  100,115,95,99,121,2,12,7,99,97,112,116,105,111,110,6,46,32,51,49,
  32,32,32,54,50,32,32,49,50,53,32,50,53,48,32,53,48,48,32,32,
  49,107,32,32,32,32,50,107,32,32,32,52,107,32,32,32,56,107,32,32,
  49,54,107,11,102,111,110,116,46,104,101,105,103,104,116,2,9,9,102,111,
  110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,
  15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,10,102,108,
  112,95,104,101,105,103,104,116,0,13,114,101,102,102,111,110,116,104,101,105,
  103,104,116,2,12,0,0,0,11,116,115,116,114,105,110,103,100,105,115,112,
  12,116,115,116,114,105,110,103,100,105,115,112,50,5,99,111,108,111,114,4,
  3,0,0,128,12,102,114,97,109,101,46,108,101,118,101,108,111,2,1,20,
  102,114,97,109,101,46,99,111,108,111,114,104,105,103,104,108,105,103,104,116,
  4,3,0,0,160,17,102,114,97,109,101,46,111,112,116,105,111,110,115,115,
  107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,10,102,114,108,95,108,101,118,
  101,108,111,18,102,114,108,95,99,111,108,111,114,104,105,103,104,108,105,103,
  104,116,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,15,
  102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,
  99,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,
  116,102,97,99,101,112,108,97,121,101,114,8,116,97,98,111,114,100,101,114,
  2,2,4,104,105,110,116,6,15,69,110,97,98,108,101,32,83,112,101,99,
  116,114,117,109,8,98,111,117,110,100,115,95,120,3,158,0,8,98,111,117,
  110,100,115,95,121,2,0,9,98,111,117,110,100,115,95,99,120,2,116,9,
  98,111,117,110,100,115,95,99,121,2,16,9,116,101,120,116,102,108,97,103,
  115,11,12,116,102,95,120,99,101,110,116,101,114,101,100,12,116,102,95,121,
  99,101,110,116,101,114,101,100,0,13,114,101,102,102,111,110,116,104,101,105,
  103,104,116,2,15,0,12,116,98,111,111,108,101,97,110,101,100,105,116,6,
  83,112,101,99,116,49,5,99,111,108,111,114,4,3,0,0,128,17,102,114,
  97,109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,9,101,100,103,
  95,114,105,103,104,116,7,101,100,103,95,116,111,112,8,101,100,103,95,108,
  101,102,116,10,101,100,103,95,98,111,116,116,111,109,0,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,15,83,112,101,99,116,114,117,109,32,
  80,108,97,121,101,114,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,15,102,114,108,95,104,105,100,100,101,110,101,100,103,101,115,
  15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,16,102,114,108,
  49,95,99,97,112,116,105,111,110,100,105,115,116,0,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,1,2,103,2,1,
  0,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,
  102,97,99,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,
  111,46,116,102,97,99,101,112,108,97,121,101,114,4,104,105,110,116,6,25,
  69,110,97,98,108,101,32,83,112,101,99,116,114,117,109,32,114,101,110,100,
  101,114,105,110,103,8,98,111,117,110,100,115,95,120,2,0,8,98,111,117,
  110,100,115,95,121,2,255,9,98,111,117,110,100,115,95,99,120,2,116,9,
  98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,
  7,17,109,97,105,110,102,111,46,116,115,116,97,116,102,105,108,101,49,10,
  99,111,108,111,114,103,108,121,112,104,4,8,0,0,160,5,118,97,108,117,
  101,9,0,0,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tspectrum1fo,'');
end.
