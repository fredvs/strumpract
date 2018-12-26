unit config_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,config;

const
 objdata: record size: integer; data: array[0..7704] of byte end =
      (size: 7705; data: (
  84,80,70,48,9,116,99,111,110,102,105,103,102,111,8,99,111,110,102,105,
  103,102,111,7,118,105,115,105,98,108,101,8,8,98,111,117,110,100,115,95,
  120,3,146,1,8,98,111,117,110,100,115,95,121,3,207,0,9,98,111,117,
  110,100,115,95,99,120,3,102,1,9,98,111,117,110,100,115,95,99,121,3,
  200,0,12,98,111,117,110,100,115,95,99,120,109,105,110,3,102,1,12,98,
  111,117,110,100,115,95,99,121,109,105,110,3,200,0,12,98,111,117,110,100,
  115,95,99,120,109,97,120,3,102,1,12,98,111,117,110,100,115,95,99,121,
  109,97,120,3,200,0,26,99,111,110,116,97,105,110,101,114,46,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,
  97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,
  100,115,1,2,0,2,0,3,102,1,3,200,0,0,13,111,112,116,105,111,
  110,115,119,105,110,100,111,119,11,9,119,111,95,100,105,97,108,111,103,0,
  9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,
  117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,
  0,7,99,97,112,116,105,111,110,6,19,65,117,100,105,111,32,67,111,110,
  102,105,103,117,114,97,116,105,111,110,12,105,99,111,110,46,111,112,116,105,
  111,110,115,11,10,98,109,111,95,109,97,115,107,101,100,12,98,109,111,95,
  103,114,97,121,109,97,115,107,0,15,105,99,111,110,46,111,114,105,103,102,
  111,114,109,97,116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,
  101,10,88,7,0,0,0,0,0,0,18,0,0,0,24,0,0,0,24,0,
  0,0,224,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,
  255,29,64,155,212,1,74,157,210,2,67,156,213,1,255,255,255,11,43,89,
  125,1,255,255,255,6,43,143,213,1,255,255,255,1,59,148,211,1,87,162,
  209,1,248,248,248,1,203,203,203,1,61,154,213,1,255,255,255,9,40,112,
  158,1,38,110,160,1,38,111,162,1,255,255,255,4,64,155,212,2,52,147,
  214,1,255,255,255,1,66,155,212,1,233,235,234,1,254,254,254,1,102,167,
  208,1,54,158,218,1,255,255,255,7,40,112,158,1,46,145,214,1,250,250,
  250,1,36,120,178,1,43,92,127,1,255,255,255,3,81,159,209,1,212,214,
  213,1,74,157,210,1,255,255,255,1,59,150,213,1,201,205,205,1,254,254,
  254,1,242,242,242,1,63,155,213,1,255,255,255,6,39,101,149,1,37,141,
  213,1,250,250,250,1,90,159,208,1,38,111,162,1,255,255,255,4,80,158,
  208,1,241,241,241,1,205,209,207,1,71,157,211,1,116,175,208,1,250,250,
  250,1,253,253,253,1,255,255,255,1,73,156,209,1,255,255,255,5,41,105,
  145,1,33,130,191,1,207,211,210,1,78,158,208,1,38,111,162,1,255,255,
  255,5,68,156,212,1,203,207,205,1,245,245,245,1,248,248,248,1,251,251,
  251,1,246,246,246,1,253,253,253,1,255,255,255,1,76,157,208,1,255,255,
  255,4,41,105,145,1,33,130,191,1,158,193,208,1,35,144,213,1,40,107,
  154,1,255,255,255,6,54,158,218,1,81,159,209,1,220,224,222,1,218,220,
  219,1,226,228,227,1,243,243,243,1,246,246,246,2,120,176,208,1,59,150,
  213,1,255,255,255,2,41,105,145,1,33,130,191,1,158,193,208,1,34,143,
  212,1,42,106,146,1,255,255,255,8,61,154,213,1,139,184,207,1,231,233,
  232,1,240,240,240,1,224,226,226,1,209,213,211,1,216,218,217,1,246,246,
  246,1,122,175,208,1,58,153,214,1,41,105,145,1,33,130,191,1,158,193,
  208,1,34,143,212,1,42,106,146,1,255,255,255,10,62,150,212,1,82,159,
  208,1,76,157,208,1,64,151,212,1,93,164,209,1,214,218,216,1,223,225,
  225,1,247,247,247,1,53,147,213,1,33,126,191,1,158,193,208,1,34,143,
  212,1,42,106,146,1,255,255,255,15,61,154,213,1,94,164,208,1,220,222,
  221,1,134,178,206,1,33,137,209,1,158,193,208,1,34,143,212,1,42,106,
  146,1,255,255,255,17,57,152,213,1,37,140,213,1,30,135,208,1,158,193,
  208,1,40,148,216,1,34,128,188,1,34,127,192,1,255,255,255,17,41,105,
  145,1,33,126,191,1,158,193,208,1,38,147,216,1,65,151,211,1,203,203,
  203,1,92,163,208,1,61,154,213,1,255,255,255,14,70,117,53,1,66,117,
  59,1,38,136,164,1,158,193,208,1,34,143,212,1,37,120,173,1,179,195,
  205,1,219,219,219,1,248,248,248,1,129,179,207,1,64,151,212,1,77,158,
  209,1,91,163,209,1,62,150,212,1,255,255,255,9,77,119,51,1,87,124,
  66,1,238,228,220,1,94,134,129,1,37,140,169,1,42,106,146,1,32,129,
  196,1,53,147,213,1,231,233,232,1,220,224,223,1,247,247,247,1,246,246,
  246,1,253,253,253,1,251,251,251,1,183,200,205,1,61,154,213,1,255,255,
  255,6,255,1,1,1,73,119,53,1,91,125,71,1,214,190,191,1,192,144,
  182,1,183,151,193,1,46,94,47,1,62,77,39,1,255,255,255,1,38,142,
  214,1,78,158,208,1,240,240,240,1,252,252,252,1,244,246,245,1,224,228,
  226,1,217,223,220,1,247,249,248,1,91,163,209,1,56,165,216,1,255,255,
  255,4,68,114,56,1,84,122,58,1,154,134,178,1,221,193,191,1,177,133,
  159,1,146,132,162,1,45,103,55,1,52,89,39,1,255,255,255,3,39,143,
  215,1,255,255,255,1,242,244,243,1,231,235,233,1,229,233,232,1,223,227,
  225,1,240,242,241,1,230,232,231,1,46,150,216,1,255,255,255,3,255,1,
  1,1,79,119,57,1,203,171,194,1,209,165,188,1,157,128,109,1,144,128,
  130,1,46,96,47,1,55,85,39,1,255,255,255,4,31,140,209,1,252,252,
  252,1,233,237,234,1,224,228,227,1,56,153,214,1,32,141,210,1,151,188,
  207,1,250,250,250,1,40,148,216,1,255,255,255,3,73,119,53,1,139,131,
  149,1,204,158,187,1,156,127,106,1,146,130,90,1,52,108,52,1,54,87,
  39,1,255,255,255,5,34,122,184,1,209,211,210,1,235,237,236,1,114,171,
  208,1,36,129,182,1,255,255,255,1,32,130,198,1,213,217,214,1,36,145,
  214,1,255,255,255,3,80,120,60,1,194,154,192,1,154,127,108,1,144,135,
  76,1,64,116,56,1,54,84,36,1,44,29,14,1,0,0,0,5,50,66,
  78,1,33,125,189,1,222,226,225,1,177,199,207,1,37,115,169,1,255,255,
  255,1,38,122,170,1,36,117,174,1,36,123,178,1,255,255,255,3,61,110,
  50,1,61,115,63,1,93,127,63,1,43,101,46,1,58,81,37,1,55,35,
  15,1,0,0,0,7,46,88,114,1,78,158,208,1,214,218,217,1,36,118,
  176,1,51,58,63,1,0,0,0,1,46,84,110,1,255,255,255,3,0,0,
  0,1,10,10,0,1,59,79,33,1,50,90,40,1,66,63,28,1,4,4,
  0,1,0,0,0,9,51,65,73,1,42,97,136,1,42,98,138,1,39,39,
  39,1,0,0,0,3,255,255,255,3,0,0,0,7,255,255,255,6,0,0,
  0,7,255,255,255,26,64,2,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49,
  242,235,118,0,0,0,0,0,0,0,0,0,0,0,35,0,0,0,0,0,
  0,10,0,32,248,255,251,99,0,0,0,0,0,0,0,0,0,114,244,148,
  0,0,0,0,96,252,43,0,135,253,255,243,16,0,0,0,0,0,0,0,
  114,238,255,243,51,0,0,0,236,255,200,0,48,251,255,253,148,0,0,0,
  0,0,0,114,238,255,240,148,0,0,0,0,223,255,251,190,247,255,255,255,
  239,0,0,0,0,0,114,238,255,240,148,0,0,0,0,0,147,252,255,255,
  255,255,255,255,237,0,0,0,0,114,238,255,240,148,0,0,0,0,0,0,
  16,242,255,255,255,255,255,255,247,78,0,0,114,238,255,240,148,0,0,0,
  0,0,0,0,0,97,249,255,255,254,255,255,255,247,79,114,238,255,240,148,
  0,0,0,0,0,0,0,0,0,0,89,237,221,169,245,255,255,255,251,243,
  255,240,148,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,245,
  255,255,255,255,245,148,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,83,249,255,255,255,252,93,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,114,243,255,255,255,255,248,84,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,98,241,243,255,245,252,255,255,255,247,169,
  222,238,89,0,0,0,0,0,0,0,0,0,24,242,255,255,245,148,89,247,
  255,255,255,255,255,255,251,97,0,0,0,0,0,0,1,104,243,253,255,255,
  251,11,0,78,246,255,255,255,255,255,255,243,16,0,0,0,0,21,212,248,
  255,255,254,246,155,0,0,0,237,255,255,255,255,255,255,253,147,0,0,0,
  1,193,253,255,255,255,245,54,0,0,0,0,239,255,255,254,246,190,249,255,
  224,0,0,0,119,247,255,255,255,246,143,0,0,0,0,0,148,252,255,249,
  48,0,200,255,236,0,0,0,222,255,255,255,252,231,18,10,11,11,11,10,
  24,242,255,251,136,0,43,252,96,0,0,0,108,245,255,244,214,55,18,18,
  20,22,21,19,16,109,249,255,250,52,13,13,0,0,0,6,28,131,229,164,
  66,50,34,17,10,10,10,10,15,31,119,237,233,92,44,27,8,0,0,0,
  4,13,23,28,24,15,5,0,0,0,0,0,0,4,13,23,28,24,15,5,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,13,119,105,110,100,111,119,111,112,97,99,105,116,121,
  5,0,0,0,0,0,0,0,128,255,255,9,111,110,99,114,101,97,116,101,
  100,7,11,99,111,110,102,99,114,101,97,116,101,100,15,109,111,100,117,108,
  101,99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,
  0,9,116,103,114,111,117,112,98,111,120,10,116,103,114,111,117,112,98,111,
  120,49,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,44,76,97,
  116,101,110,99,121,32,40,32,45,49,32,111,114,32,60,32,48,32,45,45,
  45,62,32,115,117,103,103,101,115,116,101,100,32,108,97,116,101,110,99,121,
  32,41,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,
  102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,17,102,114,
  97,109,101,46,99,97,112,116,105,111,110,100,105,115,116,2,10,19,102,114,
  97,109,101,46,99,97,112,116,105,111,110,111,102,102,115,101,116,2,8,16,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,16,102,114,
  108,49,95,99,97,112,116,105,111,110,100,105,115,116,18,102,114,108,49,95,
  99,97,112,116,105,111,110,111,102,102,115,101,116,0,14,102,114,97,109,101,
  46,116,101,109,112,108,97,116,101,7,23,99,111,109,109,97,110,100,101,114,
  102,111,46,116,102,114,97,109,101,99,111,109,112,50,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,
  0,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,
  116,2,2,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,105,116,
  101,109,115,1,2,0,2,1,0,21,102,97,99,101,46,102,97,100,101,95,
  99,111,108,111,114,46,99,111,117,110,116,2,2,21,102,97,99,101,46,102,
  97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,247,247,247,
  0,4,209,209,209,0,0,19,102,97,99,101,46,102,97,100,101,95,100,105,
  114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,15,102,97,99,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,8,116,97,98,111,114,
  100,101,114,2,1,8,98,111,117,110,100,115,95,120,2,10,8,98,111,117,
  110,100,115,95,121,2,1,9,98,111,117,110,100,115,95,99,120,3,81,1,
  9,98,111,117,110,100,115,95,99,121,2,87,0,13,116,114,101,97,108,115,
  112,105,110,101,100,105,116,6,108,97,116,114,101,99,5,99,111,108,111,114,
  4,3,0,0,128,17,102,114,97,109,101,46,104,105,100,100,101,110,101,100,
  103,101,115,11,9,101,100,103,95,114,105,103,104,116,7,101,100,103,95,116,
  111,112,8,101,100,103,95,108,101,102,116,10,101,100,103,95,98,111,116,116,
  111,109,0,17,102,114,97,109,101,46,99,111,108,111,114,99,108,105,101,110,
  116,4,224,255,251,0,13,102,114,97,109,101,46,99,97,112,116,105,111,110,
  6,8,82,101,99,111,114,100,101,114,16,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,15,102,114,108,95,104,105,100,100,101,110,101,
  100,103,101,115,15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,23,99,111,
  109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,101,99,111,109,112,
  50,31,102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,
  97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,31,102,114,97,109,
  101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,112,111,
  115,46,105,116,101,109,115,1,2,0,2,1,0,33,102,114,97,109,101,46,
  98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,99,111,108,111,
  114,46,99,111,117,110,116,2,2,33,102,114,97,109,101,46,98,117,116,116,
  111,110,102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,
  101,109,115,1,4,227,227,255,0,4,157,157,218,0,0,31,102,114,97,109,
  101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,100,105,
  114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,27,102,114,97,
  109,101,46,98,117,116,116,111,110,102,97,99,101,46,108,111,99,97,108,112,
  114,111,112,115,11,15,102,97,108,95,102,97,100,105,114,101,99,116,105,111,
  110,0,28,102,114,97,109,101,46,98,117,116,116,111,110,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,0,29,102,114,97,109,101,46,
  98,117,116,116,111,110,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,26,102,114,97,109,101,46,98,117,116,116,111,110,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,23,99,111,109,109,97,110,
  100,101,114,102,111,46,116,102,114,97,109,101,99,111,109,112,50,16,102,114,
  97,109,101,46,98,117,116,116,111,110,115,105,122,101,2,40,16,102,114,97,
  109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,17,2,0,
  2,0,0,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,111,
  117,110,116,2,2,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,
  105,116,101,109,115,1,2,0,2,1,0,21,102,97,99,101,46,102,97,100,
  101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,21,102,97,99,101,
  46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,227,
  227,255,0,4,157,157,218,0,0,19,102,97,99,101,46,102,97,100,101,95,
  100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,15,102,
  97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,4,104,105,110,
  116,6,74,32,67,104,97,110,103,101,32,108,97,116,101,110,99,121,32,111,
  102,32,82,101,99,111,114,100,101,114,47,68,105,114,101,99,116,32,73,110,
  112,117,116,46,32,32,45,45,45,45,62,32,32,45,49,32,61,32,76,97,
  116,101,110,99,121,32,115,117,103,103,101,115,116,101,100,46,32,8,98,111,
  117,110,100,115,95,120,3,228,0,8,98,111,117,110,100,115,95,121,2,31,
  9,98,111,117,110,100,115,95,99,121,2,48,8,115,116,97,116,102,105,108,
  101,7,17,109,97,105,110,102,111,46,116,115,116,97,116,102,105,108,101,49,
  9,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,99,101,110,116,
  101,114,101,100,8,116,102,95,114,105,103,104,116,12,116,102,95,121,99,101,
  110,116,101,114,101,100,11,116,102,95,110,111,115,101,108,101,99,116,0,8,
  111,110,99,104,97,110,103,101,7,12,99,104,97,110,103,101,108,97,116,114,
  101,99,5,118,97,108,117,101,2,255,12,118,97,108,117,101,100,101,102,97,
  117,108,116,2,255,10,118,97,108,117,101,114,97,110,103,101,2,1,10,118,
  97,108,117,101,115,116,97,114,116,2,0,8,118,97,108,117,101,109,105,110,
  2,255,8,118,97,108,117,101,109,97,120,2,10,4,115,116,101,112,5,59,
  223,79,141,151,110,18,131,245,63,12,115,116,101,112,99,116,114,108,102,97,
  99,116,2,0,13,115,116,101,112,115,104,105,102,116,102,97,99,116,2,0,
  16,119,104,101,101,108,115,101,110,115,105,116,105,118,105,116,121,2,1,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,0,13,116,114,
  101,97,108,115,112,105,110,101,100,105,116,7,108,97,116,112,108,97,121,5,
  99,111,108,111,114,4,3,0,0,128,17,102,114,97,109,101,46,104,105,100,
  100,101,110,101,100,103,101,115,11,9,101,100,103,95,114,105,103,104,116,7,
  101,100,103,95,116,111,112,8,101,100,103,95,108,101,102,116,10,101,100,103,
  95,98,111,116,116,111,109,0,17,102,114,97,109,101,46,99,111,108,111,114,
  99,108,105,101,110,116,4,224,255,251,0,13,102,114,97,109,101,46,99,97,
  112,116,105,111,110,6,7,80,108,97,121,101,114,115,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,104,105,100,
  100,101,110,101,100,103,101,115,15,102,114,108,95,99,111,108,111,114,99,108,
  105,101,110,116,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,23,99,111,109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,101,
  99,111,109,112,50,31,102,114,97,109,101,46,98,117,116,116,111,110,102,97,
  99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,31,
  102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,
  101,95,112,111,115,46,105,116,101,109,115,1,2,0,2,1,0,33,102,114,
  97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,
  99,111,108,111,114,46,99,111,117,110,116,2,2,33,102,114,97,109,101,46,
  98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,99,111,108,111,
  114,46,105,116,101,109,115,1,4,176,232,226,0,4,134,176,172,0,0,31,
  102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,
  101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,
  27,102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,108,111,
  99,97,108,112,114,111,112,115,11,15,102,97,108,95,102,97,100,105,114,101,
  99,116,105,111,110,0,28,102,114,97,109,101,46,98,117,116,116,111,110,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,29,102,114,
  97,109,101,46,98,117,116,116,111,110,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,26,102,114,97,109,101,46,98,117,116,116,
  111,110,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,23,99,111,
  109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,101,99,111,109,112,
  50,16,102,114,97,109,101,46,98,117,116,116,111,110,115,105,122,101,2,40,
  16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,
  2,17,2,0,2,0,0,19,102,97,99,101,46,102,97,100,101,95,112,111,
  115,46,99,111,117,110,116,2,2,19,102,97,99,101,46,102,97,100,101,95,
  112,111,115,46,105,116,101,109,115,1,2,0,2,1,0,21,102,97,99,101,
  46,102,97,100,101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,21,
  102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,
  115,1,4,153,201,196,0,4,190,250,243,0,0,19,102,97,99,101,46,102,
  97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,
  119,110,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  8,116,97,98,111,114,100,101,114,2,1,4,104,105,110,116,6,60,32,67,
  104,97,110,103,101,32,108,97,116,101,110,99,121,32,111,102,32,80,108,97,
  121,101,114,115,46,32,32,45,45,45,45,62,32,32,45,49,32,61,32,76,
  97,116,101,110,99,121,32,115,117,103,103,101,115,116,101,100,46,32,8,98,
  111,117,110,100,115,95,120,2,119,8,98,111,117,110,100,115,95,121,2,31,
  9,98,111,117,110,100,115,95,99,121,2,48,8,115,116,97,116,102,105,108,
  101,7,17,109,97,105,110,102,111,46,116,115,116,97,116,102,105,108,101,49,
  9,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,99,101,110,116,
  101,114,101,100,8,116,102,95,114,105,103,104,116,12,116,102,95,121,99,101,
  110,116,101,114,101,100,11,116,102,95,110,111,115,101,108,101,99,116,0,8,
  111,110,99,104,97,110,103,101,7,13,99,104,97,110,103,101,108,97,116,112,
  108,97,121,5,118,97,108,117,101,2,255,12,118,97,108,117,101,100,101,102,
  97,117,108,116,2,255,10,118,97,108,117,101,114,97,110,103,101,2,1,10,
  118,97,108,117,101,115,116,97,114,116,2,0,8,118,97,108,117,101,109,105,
  110,2,255,8,118,97,108,117,101,109,97,120,2,10,4,115,116,101,112,5,
  59,223,79,141,151,110,18,131,245,63,12,115,116,101,112,99,116,114,108,102,
  97,99,116,2,0,13,115,116,101,112,115,104,105,102,116,102,97,99,116,2,
  0,16,119,104,101,101,108,115,101,110,115,105,116,105,118,105,116,121,2,1,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,0,13,116,
  114,101,97,108,115,112,105,110,101,100,105,116,8,108,97,116,100,114,117,109,
  115,5,99,111,108,111,114,4,3,0,0,128,17,102,114,97,109,101,46,104,
  105,100,100,101,110,101,100,103,101,115,11,9,101,100,103,95,114,105,103,104,
  116,7,101,100,103,95,116,111,112,8,101,100,103,95,108,101,102,116,10,101,
  100,103,95,98,111,116,116,111,109,0,17,102,114,97,109,101,46,99,111,108,
  111,114,99,108,105,101,110,116,4,224,255,251,0,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,5,68,114,117,109,115,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,104,105,100,
  100,101,110,101,100,103,101,115,15,102,114,108,95,99,111,108,111,114,99,108,
  105,101,110,116,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,23,99,111,109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,101,
  99,111,109,112,50,31,102,114,97,109,101,46,98,117,116,116,111,110,102,97,
  99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,31,
  102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,
  101,95,112,111,115,46,105,116,101,109,115,1,2,0,2,1,0,33,102,114,
  97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,
  99,111,108,111,114,46,99,111,117,110,116,2,2,33,102,114,97,109,101,46,
  98,117,116,116,111,110,102,97,99,101,46,102,97,100,101,95,99,111,108,111,
  114,46,105,116,101,109,115,1,4,151,173,154,0,4,209,240,214,0,0,31,
  102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,102,97,100,
  101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,
  27,102,114,97,109,101,46,98,117,116,116,111,110,102,97,99,101,46,108,111,
  99,97,108,112,114,111,112,115,11,15,102,97,108,95,102,97,100,105,114,101,
  99,116,105,111,110,0,28,102,114,97,109,101,46,98,117,116,116,111,110,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,29,102,114,
  97,109,101,46,98,117,116,116,111,110,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,26,102,114,97,109,101,46,98,117,116,116,
  111,110,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,23,99,111,
  109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,101,99,111,109,112,
  50,16,102,114,97,109,101,46,98,117,116,116,111,110,115,105,122,101,2,40,
  16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,
  2,17,2,0,2,0,0,19,102,97,99,101,46,102,97,100,101,95,112,111,
  115,46,99,111,117,110,116,2,2,19,102,97,99,101,46,102,97,100,101,95,
  112,111,115,46,105,116,101,109,115,1,2,0,2,1,0,21,102,97,99,101,
  46,102,97,100,101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,21,
  102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,
  115,1,4,151,173,154,0,4,209,240,214,0,0,19,102,97,99,101,46,102,
  97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,
  119,110,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  8,116,97,98,111,114,100,101,114,2,2,4,104,105,110,116,6,110,32,67,
  104,97,110,103,101,32,108,97,116,101,110,99,121,32,111,102,32,68,114,117,
  109,115,46,32,32,45,45,45,45,62,32,32,45,49,32,61,32,76,97,116,
  101,110,99,121,32,115,117,103,103,101,115,116,101,100,46,32,78,101,101,100,
  32,116,111,32,99,108,111,115,101,45,114,101,108,111,97,100,32,83,116,114,
  117,109,112,114,97,99,116,32,116,111,32,102,101,101,108,32,116,104,101,32,
  99,104,97,110,103,101,46,32,8,98,111,117,110,100,115,95,120,2,10,8,
  98,111,117,110,100,115,95,121,2,31,9,98,111,117,110,100,115,95,99,121,
  2,48,8,115,116,97,116,102,105,108,101,7,17,109,97,105,110,102,111,46,
  116,115,116,97,116,102,105,108,101,49,9,116,101,120,116,102,108,97,103,115,
  11,12,116,102,95,120,99,101,110,116,101,114,101,100,8,116,102,95,114,105,
  103,104,116,12,116,102,95,121,99,101,110,116,101,114,101,100,11,116,102,95,
  110,111,115,101,108,101,99,116,0,8,111,110,99,104,97,110,103,101,7,14,
  99,104,97,110,103,101,108,97,116,100,114,117,109,115,5,118,97,108,117,101,
  2,255,12,118,97,108,117,101,100,101,102,97,117,108,116,2,255,10,118,97,
  108,117,101,114,97,110,103,101,2,1,10,118,97,108,117,101,115,116,97,114,
  116,2,0,8,118,97,108,117,101,109,105,110,2,255,8,118,97,108,117,101,
  109,97,120,2,10,4,115,116,101,112,5,59,223,79,141,151,110,18,131,245,
  63,12,115,116,101,112,99,116,114,108,102,97,99,116,2,0,13,115,116,101,
  112,115,104,105,102,116,102,97,99,116,2,0,16,119,104,101,101,108,115,101,
  110,115,105,116,105,118,105,116,121,2,1,13,114,101,102,102,111,110,116,104,
  101,105,103,104,116,2,14,0,0,0,7,116,98,117,116,116,111,110,8,116,
  98,117,116,116,111,110,49,16,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,
  101,7,23,99,111,109,109,97,110,100,101,114,102,111,46,116,102,114,97,109,
  101,99,111,109,112,50,8,98,111,117,110,100,115,95,120,3,147,0,8,98,
  111,117,110,100,115,95,121,3,175,0,9,98,111,117,110,100,115,95,99,120,
  2,70,9,98,111,117,110,100,115,95,99,121,2,21,5,115,116,97,116,101,
  11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,7,99,
  97,112,116,105,111,110,6,2,79,75,11,109,111,100,97,108,114,101,115,117,
  108,116,7,15,109,114,95,119,105,110,100,111,119,99,108,111,115,101,100,0,
  0,6,116,108,97,98,101,108,7,108,115,117,103,108,97,116,8,116,97,98,
  111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,8,8,98,
  111,117,110,100,115,95,121,2,95,9,98,111,117,110,100,115,95,99,120,2,
  121,9,98,111,117,110,100,115,95,99,121,2,14,7,99,97,112,116,105,111,
  110,6,19,83,117,103,103,101,115,116,101,100,32,108,97,116,101,110,99,121,
  58,32,9,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,99,101,
  110,116,101,114,101,100,12,116,102,95,121,99,101,110,116,101,114,101,100,0,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,0,12,116,
  98,111,111,108,101,97,110,101,100,105,116,8,115,112,101,99,99,97,108,99,
  17,102,114,97,109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,9,
  101,100,103,95,114,105,103,104,116,7,101,100,103,95,116,111,112,8,101,100,
  103,95,108,101,102,116,10,101,100,103,95,98,111,116,116,111,109,0,17,102,
  114,97,109,101,46,99,111,108,111,114,99,108,105,101,110,116,4,237,237,237,
  0,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,27,69,110,97,
  98,108,101,32,83,112,101,99,116,114,117,109,32,67,97,108,99,117,108,97,
  116,105,111,110,16,102,114,97,109,101,46,102,111,110,116,46,99,111,108,111,
  114,4,31,31,31,0,17,102,114,97,109,101,46,102,111,110,116,46,104,101,
  105,103,104,116,2,12,15,102,114,97,109,101,46,102,111,110,116,46,110,97,
  109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,21,102,114,97,109,
  101,46,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,9,102,
  108,112,95,99,111,108,111,114,10,102,108,112,95,104,101,105,103,104,116,0,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,
  114,108,95,104,105,100,100,101,110,101,100,103,101,115,15,102,114,108,95,99,
  111,108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,16,102,114,108,49,95,99,97,112,116,
  105,111,110,100,105,115,116,0,14,102,114,97,109,101,46,116,101,109,112,108,
  97,116,101,7,23,99,111,109,109,97,110,100,101,114,102,111,46,116,102,114,
  97,109,101,99,111,109,112,50,16,102,114,97,109,101,46,111,117,116,101,114,
  102,114,97,109,101,1,2,0,2,0,3,178,0,2,0,0,15,102,97,99,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,
  116,101,109,112,108,97,116,101,7,17,109,97,105,110,102,111,46,116,102,97,
  99,101,99,111,109,112,53,8,116,97,98,111,114,100,101,114,2,3,4,104,
  105,110,116,6,27,69,110,97,98,108,101,32,83,112,101,99,116,114,117,109,
  32,99,97,108,99,117,108,97,116,105,111,110,8,98,111,117,110,100,115,95,
  120,2,88,8,98,111,117,110,100,115,95,121,3,145,0,9,98,111,117,110,
  100,115,95,99,120,3,191,0,9,98,111,117,110,100,115,95,99,121,2,24,
  8,115,116,97,116,102,105,108,101,7,17,109,97,105,110,102,111,46,116,115,
  116,97,116,102,105,108,101,49,10,99,111,108,111,114,103,108,121,112,104,4,
  69,69,69,0,5,118,97,108,117,101,9,0,0,6,116,108,97,98,101,108,
  8,100,101,102,100,101,118,105,110,8,116,97,98,111,114,100,101,114,2,4,
  8,98,111,117,110,100,115,95,120,2,11,8,98,111,117,110,100,115,95,121,
  2,120,9,98,111,117,110,100,115,95,99,120,3,134,0,9,98,111,117,110,
  100,115,95,99,121,2,14,7,99,97,112,116,105,111,110,6,22,68,101,102,
  97,117,108,116,32,68,101,118,105,99,101,32,73,78,32,61,32,45,49,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,0,6,116,108,
  97,98,101,108,9,100,101,102,100,101,118,111,117,116,8,116,97,98,111,114,
  100,101,114,2,5,8,98,111,117,110,100,115,95,120,3,194,0,8,98,111,
  117,110,100,115,95,121,2,120,9,98,111,117,110,100,115,95,99,120,3,146,
  0,9,98,111,117,110,100,115,95,99,121,2,14,7,99,97,112,116,105,111,
  110,6,23,68,101,102,97,117,108,116,32,68,101,118,105,99,101,32,79,85,
  84,32,61,32,45,49,13,114,101,102,102,111,110,116,104,101,105,103,104,116,
  2,14,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tconfigfo,'');
end.
