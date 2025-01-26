unit waveform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,waveform;

const
 objdata: record size: integer; data: array[0..7841] of byte end =
      (size: 7842; data: (
  84,80,70,48,7,116,119,97,118,101,102,111,6,119,97,118,101,102,111,16,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,15,102,
  114,97,109,101,46,103,114,105,112,95,115,105,122,101,2,8,15,102,114,97,
  109,101,46,103,114,105,112,95,103,114,105,112,7,9,115,116,98,95,100,101,
  110,115,48,18,102,114,97,109,101,46,103,114,105,112,95,111,112,116,105,111,
  110,115,11,14,103,111,95,99,108,111,115,101,98,117,116,116,111,110,14,103,
  111,95,98,117,116,116,111,110,104,105,110,116,115,7,103,111,95,118,101,114,
  116,0,26,102,114,97,109,101,46,103,114,105,112,95,102,97,99,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,24,102,114,97,109,101,46,103,114,
  105,112,95,102,97,99,101,46,116,101,109,112,108,97,116,101,7,19,109,97,
  105,110,102,111,46,116,102,97,99,101,98,117,116,103,114,97,121,32,102,114,
  97,109,101,46,103,114,105,112,95,102,97,99,101,97,99,116,105,118,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,109,101,46,103,
  114,105,112,95,102,97,99,101,97,99,116,105,118,101,46,116,101,109,112,108,
  97,116,101,7,17,109,97,105,110,102,111,46,116,102,97,99,101,103,114,101,
  101,110,15,102,114,97,109,101,46,103,114,105,112,95,104,105,110,116,6,32,
  32,85,115,101,32,116,104,97,116,32,103,114,105,112,32,116,111,32,100,114,
  97,103,32,116,104,101,32,102,111,114,109,32,7,118,105,115,105,98,108,101,
  8,8,98,111,117,110,100,115,95,120,3,144,2,8,98,111,117,110,100,115,
  95,121,3,178,1,9,98,111,117,110,100,115,95,99,120,3,186,1,9,98,
  111,117,110,100,115,95,99,121,2,108,12,98,111,117,110,100,115,95,99,120,
  109,105,110,3,186,1,12,98,111,117,110,100,115,95,99,121,109,105,110,2,
  94,12,98,111,117,110,100,115,95,99,120,109,97,120,3,186,1,12,98,111,
  117,110,100,115,95,99,121,109,97,120,2,110,27,99,111,110,116,97,105,110,
  101,114,46,102,114,97,109,101,46,111,112,116,105,111,110,115,115,107,105,110,
  11,8,102,115,111,95,102,108,97,116,0,26,99,111,110,116,97,105,110,101,
  114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,
  102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,0,27,99,111,110,
  116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,49,11,0,30,99,111,110,116,97,105,110,101,114,46,102,114,97,
  109,101,46,115,98,104,111,114,122,46,111,112,116,105,111,110,115,11,14,115,
  98,111,95,116,104,117,109,98,116,114,97,99,107,16,115,98,111,95,99,108,
  105,99,107,116,111,118,97,108,117,101,12,115,98,111,95,109,111,118,101,97,
  117,116,111,12,115,98,111,95,115,104,111,119,97,117,116,111,0,28,99,111,
  110,116,97,105,110,101,114,46,102,114,97,109,101,46,115,98,104,111,114,122,
  46,119,105,100,116,104,2,10,38,99,111,110,116,97,105,110,101,114,46,102,
  114,97,109,101,46,115,98,104,111,114,122,46,102,97,99,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,36,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,115,98,104,111,114,122,46,102,97,99,101,46,116,101,
  109,112,108,97,116,101,7,19,109,97,105,110,102,111,46,116,102,97,99,101,
  98,117,116,103,114,97,121,44,99,111,110,116,97,105,110,101,114,46,102,114,
  97,109,101,46,115,98,104,111,114,122,46,102,97,99,101,98,117,116,116,111,
  110,46,108,111,99,97,108,112,114,111,112,115,11,0,42,99,111,110,116,97,
  105,110,101,114,46,102,114,97,109,101,46,115,98,104,111,114,122,46,102,97,
  99,101,98,117,116,116,111,110,46,116,101,109,112,108,97,116,101,7,19,109,
  97,105,110,102,111,46,116,102,97,99,101,98,117,116,103,114,97,121,28,99,
  111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,115,98,118,101,114,
  116,46,119,105,100,116,104,2,1,16,99,111,110,116,97,105,110,101,114,46,
  98,111,117,110,100,115,1,2,0,2,19,3,178,1,2,89,0,22,100,114,
  97,103,100,111,99,107,46,115,112,108,105,116,116,101,114,95,103,114,105,112,
  7,11,115,116,98,95,100,101,102,97,117,108,116,16,100,114,97,103,100,111,
  99,107,46,102,97,99,101,116,97,98,7,19,109,97,105,110,102,111,46,116,
  102,97,99,101,98,117,116,103,114,97,121,22,100,114,97,103,100,111,99,107,
  46,102,97,99,101,97,99,116,105,118,101,116,97,98,7,23,109,97,105,110,
  102,111,46,116,102,97,99,101,112,108,97,121,101,114,108,105,103,104,116,20,
  100,114,97,103,100,111,99,107,46,111,112,116,105,111,110,115,100,111,99,107,
  11,10,111,100,95,115,97,118,101,112,111,115,13,111,100,95,115,97,118,101,
  122,111,114,100,101,114,10,111,100,95,99,97,110,109,111,118,101,11,111,100,
  95,99,97,110,102,108,111,97,116,10,111,100,95,99,97,110,100,111,99,107,
  10,111,100,95,102,105,120,115,105,122,101,14,111,100,95,99,97,112,116,105,
  111,110,104,105,110,116,0,16,100,114,97,103,100,111,99,107,46,111,110,102,
  108,111,97,116,7,7,111,110,102,108,111,97,116,15,100,114,97,103,100,111,
  99,107,46,111,110,100,111,99,107,7,6,111,110,100,111,99,107,8,109,97,
  105,110,109,101,110,117,7,10,116,109,97,105,110,109,101,110,117,49,9,102,
  111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,
  116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,0,8,
  115,116,97,116,102,105,108,101,7,17,109,97,105,110,102,111,46,116,115,116,
  97,116,102,105,108,101,49,15,105,99,111,110,46,111,114,105,103,102,111,114,
  109,97,116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,101,10,
  88,8,0,0,0,0,0,0,0,0,0,0,32,0,0,0,32,0,0,0,
  36,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,252,246,28,
  191,253,247,1,195,239,236,1,196,231,230,1,191,255,248,1,190,250,244,27,
  190,251,245,1,192,241,237,1,200,210,214,1,204,195,203,1,197,222,223,1,
  189,249,243,24,190,247,241,1,194,230,229,1,189,250,244,1,188,252,245,1,
  197,220,222,1,216,146,167,1,214,152,171,1,207,180,192,1,188,247,241,3,
  188,248,242,1,190,242,237,1,195,221,222,1,187,250,243,1,188,247,241,3,
  187,251,244,1,198,209,214,1,196,220,221,1,187,250,243,1,188,247,241,3,
  188,249,243,1,188,248,241,1,188,247,241,3,191,233,231,1,190,238,235,1,
  188,246,240,1,204,190,199,1,187,252,245,1,187,250,243,1,196,219,221,1,
  216,146,167,1,214,153,172,1,214,152,171,1,187,246,240,4,189,237,234,1,
  199,206,211,1,186,249,242,1,187,247,240,1,186,248,241,1,187,245,239,1,
  185,252,245,1,203,190,199,1,200,200,206,1,187,247,240,1,186,248,241,1,
  191,232,230,1,187,245,239,1,195,217,219,1,188,243,237,1,187,246,240,2,
  187,245,239,1,201,197,204,1,216,147,167,1,211,162,178,1,211,164,180,1,
  185,252,244,1,186,248,242,1,195,218,219,1,216,146,167,1,214,153,172,2,
  186,244,238,3,186,243,237,1,188,236,232,1,198,205,210,1,184,250,242,1,
  194,218,219,1,202,191,200,1,184,249,242,1,192,223,222,1,210,166,181,1,
  207,175,188,1,190,232,229,1,191,228,227,1,200,199,206,1,187,242,236,1,
  212,158,176,1,189,235,231,1,186,244,238,2,186,243,238,1,215,149,169,1,
  214,153,172,1,214,152,171,1,210,166,181,1,185,247,240,2,194,217,218,1,
  216,146,167,1,214,153,172,2,185,243,237,2,186,241,235,1,198,200,206,1,
  192,220,221,1,200,196,203,1,193,217,218,1,194,216,217,1,211,161,178,1,
  190,226,224,1,198,203,208,1,216,146,167,1,206,177,189,1,188,233,230,1,
  194,214,215,1,206,177,189,1,187,237,233,1,211,162,178,1,194,215,217,1,
  185,242,237,1,185,244,238,1,185,243,237,1,215,151,170,1,214,153,172,2,
  212,159,176,1,195,210,213,1,183,249,241,1,194,216,218,1,216,146,167,1,
  214,153,172,2,183,241,235,1,184,240,234,1,198,201,206,1,203,185,195,1,
  200,195,203,1,206,177,189,1,207,174,187,1,199,197,204,1,216,147,168,1,
  198,200,206,1,197,203,208,1,216,147,168,1,213,157,175,1,191,221,221,1,
  193,215,217,1,213,155,173,1,187,231,228,1,210,163,179,1,202,190,199,1,
  188,228,226,1,197,204,209,1,183,241,235,1,215,151,170,1,214,153,172,2,
  212,159,176,1,194,210,214,1,181,248,240,1,193,215,216,1,216,147,167,1,
  214,153,172,2,183,240,234,1,183,238,232,1,200,191,199,1,213,155,173,1,
  199,193,200,1,216,148,168,1,210,164,180,1,204,181,192,1,217,146,167,1,
  198,197,203,1,195,204,208,1,216,148,168,2,196,203,208,1,195,205,209,1,
  213,154,173,1,186,229,226,1,210,163,179,1,202,186,195,1,198,196,202,2,
  183,239,233,1,215,151,170,1,214,153,172,2,213,154,173,1,207,171,185,1,
  194,210,213,1,191,217,218,1,216,147,168,1,214,153,172,2,181,238,233,1,
  182,236,232,1,200,191,198,1,214,153,172,1,208,169,184,1,214,152,171,1,
  214,153,172,1,214,152,171,1,214,152,172,1,211,161,178,1,210,162,179,1,
  214,152,171,1,215,150,170,1,202,185,194,1,209,166,181,1,217,145,167,1,
  185,229,226,1,209,165,181,1,215,150,170,1,208,169,184,1,198,195,201,1,
  183,233,229,1,215,151,171,1,214,153,172,3,215,151,171,1,205,176,189,1,
  188,219,219,1,216,147,168,1,214,153,172,2,180,237,231,2,207,172,186,1,
  215,152,171,1,214,153,172,9,213,156,174,1,214,154,173,1,216,148,169,1,
  190,212,214,1,210,163,179,1,214,152,172,1,214,153,172,1,213,156,174,1,
  214,154,173,1,214,153,172,4,214,152,171,1,209,166,181,1,200,188,196,1,
  215,150,170,1,214,153,172,2,179,235,229,1,198,189,198,1,215,150,170,1,
  214,153,172,13,212,158,175,1,214,154,173,1,214,153,172,8,214,152,172,1,
  211,161,178,1,204,176,188,1,215,151,171,1,214,153,172,2,178,233,228,1,
  197,191,198,1,215,151,171,1,214,153,172,25,215,152,171,1,214,153,172,3,
  177,231,227,1,196,190,197,1,215,151,171,1,214,153,172,29,175,231,225,1,
  196,189,197,1,215,151,171,1,214,153,172,29,174,229,223,1,188,204,206,1,
  200,182,190,1,199,183,191,29,174,227,222,1,196,168,194,1,216,113,169,1,
  215,116,170,29,172,225,221,1,194,170,194,1,215,119,171,1,214,121,172,29,
  171,224,219,1,195,169,194,1,215,119,171,1,214,121,172,29,170,223,217,1,
  194,168,193,1,215,119,171,1,214,121,172,24,214,120,172,1,215,120,171,1,
  214,121,172,3,169,221,216,1,190,175,196,1,216,116,170,1,214,121,172,13,
  215,119,171,1,214,121,172,9,214,120,172,1,210,131,176,1,202,148,184,1,
  215,118,171,1,214,121,172,2,168,220,215,1,168,219,215,1,193,167,192,1,
  215,118,171,1,214,121,172,9,213,124,173,1,213,122,173,1,216,117,170,1,
  191,171,194,1,210,129,176,1,214,121,172,2,212,125,174,2,214,121,172,4,
  215,120,171,1,207,136,179,1,195,163,190,1,216,117,170,1,214,121,172,2,
  166,219,213,1,167,217,212,1,193,164,190,1,214,121,172,1,205,140,180,1,
  215,120,171,1,214,121,172,2,215,119,171,1,204,142,181,1,202,145,183,1,
  215,119,171,1,216,118,171,1,197,157,187,1,207,135,178,1,218,112,168,1,
  171,208,209,1,207,135,178,1,215,118,171,1,205,140,180,1,191,169,193,1,
  168,215,211,1,215,119,171,1,214,121,172,3,215,119,171,1,201,147,183,1,
  177,197,204,1,218,114,169,1,214,121,172,2,165,217,212,1,166,215,211,1,
  193,164,190,1,206,138,179,1,193,164,190,1,217,115,169,1,214,120,172,1,
  215,118,171,1,216,117,170,1,190,169,192,1,186,177,195,1,217,115,170,1,
  217,115,169,1,182,183,198,1,184,181,197,1,214,122,172,1,171,206,207,1,
  208,133,177,1,196,157,187,1,190,170,192,1,191,168,192,1,166,217,212,1,
  215,119,171,1,214,121,172,2,213,122,173,1,203,143,181,1,178,192,202,1,
  178,192,201,1,218,114,169,1,214,121,172,2,164,216,211,1,165,214,210,1,
  182,182,196,1,189,169,191,1,189,168,191,1,193,162,188,1,202,143,181,1,
  188,171,192,1,217,115,169,1,187,172,193,1,186,175,194,1,217,114,169,1,
  212,125,174,1,176,193,202,1,179,188,199,1,213,123,173,1,170,204,206,1,
  208,132,177,1,193,162,188,1,180,185,197,1,190,167,190,1,164,215,211,1,
  215,119,171,1,214,121,172,2,211,128,175,1,181,183,197,1,160,223,214,1,
  179,187,199,1,218,114,169,1,214,121,172,2,163,214,209,2,165,210,207,1,
  185,175,194,1,165,211,208,1,191,165,190,1,178,187,198,1,179,185,197,1,
  209,130,176,1,173,197,202,1,185,173,193,1,217,115,169,1,201,146,182,1,
  169,204,205,1,178,187,198,1,200,147,182,1,166,208,206,1,209,130,175,1,
  179,186,198,1,163,214,209,1,174,194,201,1,163,214,209,1,215,118,171,1,
  214,121,172,2,211,127,175,1,182,180,196,1,159,220,211,1,178,186,198,1,
  218,114,169,1,214,121,172,2,162,213,207,3,162,214,207,1,167,205,204,1,
  184,174,192,1,159,218,209,1,167,204,204,1,185,172,191,1,177,187,197,1,
  172,196,201,1,206,136,178,1,202,143,181,1,170,199,202,1,159,218,209,1,
  184,174,192,1,164,210,206,1,211,126,174,1,167,204,204,1,162,213,207,3,
  192,161,188,1,215,119,171,1,214,120,172,1,209,130,176,1,171,197,201,1,
  159,218,209,1,178,185,197,1,218,114,169,1,214,121,172,2,160,211,206,3,
  160,212,207,1,165,203,203,1,184,171,191,1,158,215,208,1,160,212,207,1,
  159,213,207,3,196,152,184,1,187,166,189,1,159,213,207,1,160,212,207,1,
  164,206,204,1,160,212,207,1,177,183,195,1,162,208,205,1,160,211,206,3,
  190,162,187,1,219,113,169,1,216,117,171,1,207,133,177,1,156,219,209,1,
  159,214,207,1,176,184,196,1,218,114,169,1,214,121,172,2,160,210,205,4,
  161,207,204,1,167,199,200,1,159,211,205,1,160,210,205,3,158,212,206,1,
  176,184,195,1,171,191,198,1,159,211,205,1,160,210,205,3,159,211,205,1,
  160,210,205,4,168,197,199,1,156,215,207,1,179,179,193,1,191,159,186,1,
  157,214,206,1,158,212,206,1,176,183,195,1,218,115,170,1,214,121,172,2,
  159,208,203,24,162,203,201,1,182,172,190,1,157,211,204,1,157,210,204,1,
  175,182,194,1,218,114,170,1,214,121,172,2,157,207,201,27,156,208,202,1,
  165,195,197,1,200,143,180,1,216,118,171,1,215,120,172,1,156,205,200,27,
  156,206,201,1,158,202,199,1,177,175,190,1,203,137,177,1,187,161,185,1,
  13,119,105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,
  0,0,128,255,255,8,111,110,99,114,101,97,116,101,7,4,99,114,101,97,
  9,111,110,99,114,101,97,116,101,100,7,9,111,110,99,114,101,97,116,101,
  100,8,111,110,114,101,115,105,122,101,7,7,111,110,114,101,115,105,122,6,
  111,110,115,104,111,119,7,11,111,110,118,105,115,105,98,108,101,99,104,6,
  111,110,104,105,100,101,7,11,111,110,118,105,115,105,98,108,101,99,104,15,
  109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,9,116,100,111,
  99,107,102,111,114,109,0,7,116,115,108,105,100,101,114,9,116,114,97,99,
  107,98,97,114,49,14,111,112,116,105,111,110,115,119,105,100,103,101,116,49,
  11,13,111,119,49,95,97,117,116,111,115,99,97,108,101,17,111,119,49,95,
  110,111,99,108,97,109,112,105,110,118,105,101,119,0,19,102,97,99,101,46,
  102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,
  111,119,110,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,8,116,97,98,111,114,100,101,114,2,1,4,104,105,110,116,6,35,32,
  67,108,105,99,107,32,116,111,32,99,104,97,110,103,101,32,112,111,115,105,
  116,105,111,110,32,111,102,32,115,111,117,110,100,32,8,98,111,117,110,100,
  115,95,120,2,0,8,98,111,117,110,100,115,95,121,2,0,9,98,111,117,
  110,100,115,95,99,120,3,176,1,9,98,111,117,110,100,115,95,99,121,2,
  76,7,101,110,97,98,108,101,100,8,17,115,99,114,111,108,108,98,97,114,
  46,111,112,116,105,111,110,115,11,14,115,98,111,95,116,104,117,109,98,116,
  114,97,99,107,16,115,98,111,95,99,108,105,99,107,116,111,118,97,108,117,
  101,12,115,98,111,95,109,111,118,101,97,117,116,111,12,115,98,111,95,115,
  104,111,119,97,117,116,111,13,115,98,111,95,118,97,108,117,101,107,101,121,
  115,0,22,115,99,114,111,108,108,98,97,114,46,98,117,116,116,111,110,108,
  101,110,103,116,104,2,12,25,115,99,114,111,108,108,98,97,114,46,98,117,
  116,116,111,110,109,105,110,108,101,110,103,116,104,2,12,25,115,99,114,111,
  108,108,98,97,114,46,98,117,116,116,111,110,101,110,100,108,101,110,103,116,
  104,2,255,27,115,99,114,111,108,108,98,97,114,46,102,97,99,101,46,105,
  109,97,103,101,46,115,111,117,114,99,101,7,11,115,108,105,100,101,114,105,
  109,97,103,101,29,115,99,114,111,108,108,98,97,114,46,102,97,99,101,46,
  102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,
  111,119,110,25,115,99,114,111,108,108,98,97,114,46,102,97,99,101,46,108,
  111,99,97,108,112,114,111,112,115,11,15,102,97,108,95,102,97,100,105,114,
  101,99,116,105,111,110,9,102,97,108,95,105,109,97,103,101,0,26,115,99,
  114,111,108,108,98,97,114,46,102,97,99,101,49,46,108,111,99,97,108,112,
  114,111,112,115,11,0,26,115,99,114,111,108,108,98,97,114,46,102,97,99,
  101,50,46,108,111,99,97,108,112,114,111,112,115,11,0,31,115,99,114,111,
  108,108,98,97,114,46,102,97,99,101,98,117,116,116,111,110,46,108,111,99,
  97,108,112,114,111,112,115,11,0,29,115,99,114,111,108,108,98,97,114,46,
  102,97,99,101,98,117,116,116,111,110,46,116,101,109,112,108,97,116,101,7,
  17,116,102,97,99,101,98,117,116,116,111,110,115,108,105,100,101,114,34,115,
  99,114,111,108,108,98,97,114,46,102,97,99,101,101,110,100,98,117,116,116,
  111,110,46,108,111,99,97,108,112,114,111,112,115,11,0,32,115,99,114,111,
  108,108,98,97,114,46,102,97,99,101,101,110,100,98,117,116,116,111,110,46,
  116,101,109,112,108,97,116,101,7,17,116,102,97,99,101,98,117,116,116,111,
  110,115,108,105,100,101,114,33,115,99,114,111,108,108,98,97,114,46,102,114,
  97,109,101,98,117,116,116,111,110,46,99,111,108,111,114,99,108,105,101,110,
  116,4,3,0,0,128,32,115,99,114,111,108,108,98,97,114,46,102,114,97,
  109,101,98,117,116,116,111,110,46,108,111,99,97,108,112,114,111,112,115,11,
  14,102,114,108,95,99,111,108,111,114,102,114,97,109,101,15,102,114,108,95,
  104,105,100,100,101,110,101,100,103,101,115,15,102,114,108,95,111,112,116,105,
  111,110,115,115,107,105,110,0,33,115,99,114,111,108,108,98,97,114,46,102,
  114,97,109,101,98,117,116,116,111,110,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,15,115,99,114,111,108,108,98,97,114,46,99,111,108,111,114,
  4,3,0,0,128,22,115,99,114,111,108,108,98,97,114,46,111,110,97,102,
  116,101,114,101,118,101,110,116,7,9,111,110,97,102,116,101,114,101,118,0,
  0,11,116,115,116,114,105,110,103,103,114,105,100,7,101,99,104,101,108,108,
  101,5,99,111,108,111,114,4,211,211,211,0,12,102,114,97,109,101,46,108,
  101,118,101,108,111,2,0,16,102,114,97,109,101,46,99,111,108,111,114,102,
  114,97,109,101,4,38,38,38,0,16,102,114,97,109,101,46,99,111,108,111,
  114,108,105,103,104,116,4,38,38,38,0,18,102,114,97,109,101,46,99,111,
  108,111,114,100,107,119,105,100,116,104,2,1,18,102,114,97,109,101,46,99,
  111,108,111,114,104,108,119,105,100,116,104,2,1,17,102,114,97,109,101,46,
  102,114,97,109,101,105,95,108,101,102,116,2,1,16,102,114,97,109,101,46,
  102,114,97,109,101,105,95,116,111,112,2,1,18,102,114,97,109,101,46,102,
  114,97,109,101,105,95,114,105,103,104,116,2,1,19,102,114,97,109,101,46,
  102,114,97,109,101,105,95,98,111,116,116,111,109,2,1,18,102,114,97,109,
  101,46,115,98,118,101,114,116,46,119,105,100,116,104,2,0,18,102,114,97,
  109,101,46,115,98,104,111,114,122,46,119,105,100,116,104,2,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,10,102,114,108,95,
  108,101,118,101,108,111,14,102,114,108,95,99,111,108,111,114,102,114,97,109,
  101,14,102,114,108,95,99,111,108,111,114,108,105,103,104,116,16,102,114,108,
  95,99,111,108,111,114,100,107,119,105,100,116,104,16,102,114,108,95,99,111,
  108,111,114,104,108,119,105,100,116,104,10,102,114,108,95,102,105,108,101,102,
  116,9,102,114,108,95,102,105,116,111,112,11,102,114,108,95,102,105,114,105,
  103,104,116,12,102,114,108,95,102,105,98,111,116,116,111,109,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,7,101,110,
  97,98,108,101,100,8,8,98,111,117,110,100,115,95,120,2,0,8,98,111,
  117,110,100,115,95,121,2,73,9,98,111,117,110,100,115,95,99,120,3,176,
  1,9,98,111,117,110,100,115,95,99,121,2,16,7,97,110,99,104,111,114,
  115,11,7,97,110,95,108,101,102,116,9,97,110,95,98,111,116,116,111,109,
  0,9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,
  97,117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,
  11,0,18,100,97,116,97,99,111,108,115,46,108,105,110,101,99,111,108,111,
  114,4,25,0,0,144,14,100,97,116,97,99,111,108,115,46,119,105,100,116,
  104,2,21,29,100,97,116,97,99,111,108,115,46,102,111,110,116,46,99,111,
  108,111,114,98,97,99,107,103,114,111,117,110,100,4,4,0,0,160,20,100,
  97,116,97,99,111,108,115,46,102,111,110,116,46,104,101,105,103,104,116,2,
  10,18,100,97,116,97,99,111,108,115,46,102,111,110,116,46,110,97,109,101,
  6,11,115,116,102,95,100,101,102,97,117,108,116,24,100,97,116,97,99,111,
  108,115,46,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,9,
  102,108,112,95,99,111,108,111,114,19,102,108,112,95,99,111,108,111,114,98,
  97,99,107,103,114,111,117,110,100,10,102,108,112,95,104,101,105,103,104,116,
  0,24,100,97,116,97,99,111,108,115,46,102,111,110,116,115,101,108,101,99,
  116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,30,
  100,97,116,97,99,111,108,115,46,102,111,110,116,115,101,108,101,99,116,46,
  108,111,99,97,108,112,114,111,112,115,11,0,18,100,97,116,97,99,111,108,
  115,46,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,99,101,110,
  116,101,114,101,100,12,116,102,95,121,99,101,110,116,101,114,101,100,11,116,
  102,95,110,111,115,101,108,101,99,116,0,8,114,111,119,99,111,117,110,116,
  2,1,15,114,111,119,99,111,108,111,114,115,46,99,111,117,110,116,2,1,
  15,114,111,119,99,111,108,111,114,115,46,105,116,101,109,115,1,4,4,0,
  0,160,0,16,100,97,116,97,114,111,119,108,105,110,101,99,111,108,111,114,
  4,25,0,0,144,13,100,97,116,97,114,111,119,104,101,105,103,104,116,2,
  17,12,115,116,97,116,112,114,105,111,114,105,116,121,2,1,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,17,0,0,9,116,112,97,105,110,
  116,98,111,120,9,112,97,110,101,108,119,97,118,101,13,111,112,116,105,111,
  110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,111,
  99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,97,
  114,114,111,119,102,111,99,117,115,13,111,119,95,109,111,117,115,101,119,104,
  101,101,108,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,
  115,0,5,99,111,108,111,114,4,3,0,0,128,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,17,102,97,99,101,46,105,109,
  97,103,101,46,115,111,117,114,99,101,7,11,115,108,105,100,101,114,105,109,
  97,103,101,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,
  9,102,97,108,95,105,109,97,103,101,0,13,102,97,99,101,46,116,101,109,
  112,108,97,116,101,7,24,115,111,110,103,112,108,97,121,101,114,102,111,46,
  116,102,97,99,101,115,108,105,100,101,114,8,116,97,98,111,114,100,101,114,
  2,2,8,98,111,117,110,100,115,95,120,2,0,8,98,111,117,110,100,115,
  95,121,2,0,9,98,111,117,110,100,115,95,99,120,3,178,1,9,98,111,
  117,110,100,115,95,99,121,2,89,7,97,110,99,104,111,114,115,11,0,12,
  111,110,109,111,117,115,101,101,118,101,110,116,7,10,111,110,109,111,117,115,
  101,101,118,119,0,0,11,116,98,105,116,109,97,112,99,111,109,112,11,115,
  108,105,100,101,114,105,109,97,103,101,4,108,101,102,116,2,72,3,116,111,
  112,2,21,0,0,6,116,116,105,109,101,114,7,116,116,105,109,101,114,49,
  8,105,110,116,101,114,118,97,108,4,32,161,7,0,7,111,112,116,105,111,
  110,115,11,9,116,111,95,115,105,110,103,108,101,0,7,111,110,116,105,109,
  101,114,7,12,111,110,114,101,115,105,122,116,105,109,101,114,4,108,101,102,
  116,2,23,3,116,111,112,2,44,0,0,9,116,109,97,105,110,109,101,110,
  117,10,116,109,97,105,110,109,101,110,117,49,17,112,111,112,117,112,102,97,
  99,101,116,101,109,112,108,97,116,101,7,19,109,97,105,110,102,111,46,116,
  102,97,99,101,98,117,116,103,114,97,121,21,112,111,112,117,112,105,116,101,
  109,102,97,99,101,116,101,109,112,108,97,116,101,7,19,109,97,105,110,102,
  111,46,116,102,97,99,101,98,117,116,103,114,97,121,27,112,111,112,117,112,
  105,116,101,109,102,97,99,101,116,101,109,112,108,97,116,101,97,99,116,105,
  118,101,7,19,109,97,105,110,102,111,46,116,102,97,99,101,98,117,116,103,
  114,97,121,12,102,97,99,101,116,101,109,112,108,97,116,101,7,19,109,97,
  105,110,102,111,46,116,102,97,99,101,98,117,116,103,114,97,121,16,105,116,
  101,109,102,97,99,101,116,101,109,112,108,97,116,101,7,19,109,97,105,110,
  102,111,46,116,102,97,99,101,98,117,116,103,114,97,121,22,105,116,101,109,
  102,97,99,101,116,101,109,112,108,97,116,101,97,99,116,105,118,101,7,19,
  109,97,105,110,102,111,46,116,102,97,99,101,98,117,116,103,114,97,121,18,
  109,101,110,117,46,115,117,98,109,101,110,117,46,99,111,117,110,116,2,9,
  18,109,101,110,117,46,115,117,98,109,101,110,117,46,105,116,101,109,115,14,
  1,7,99,97,112,116,105,111,110,6,8,32,69,110,97,98,108,101,32,4,
  104,105,110,116,6,28,32,69,110,97,98,108,101,32,87,97,118,101,32,70,
  111,114,109,32,114,101,110,100,101,114,105,110,103,32,5,115,116,97,116,101,
  11,10,97,115,95,99,104,101,99,107,101,100,15,97,115,95,108,111,99,97,
  108,99,104,101,99,107,101,100,15,97,115,95,108,111,99,97,108,99,97,112,
  116,105,111,110,12,97,115,95,108,111,99,97,108,104,105,110,116,22,97,115,
  95,108,111,99,97,108,111,110,97,102,116,101,114,101,120,101,99,117,116,101,
  0,7,111,112,116,105,111,110,115,11,12,109,97,111,95,99,104,101,99,107,
  98,111,120,19,109,97,111,95,115,104,111,114,116,99,117,116,99,97,112,116,
  105,111,110,0,14,111,110,97,102,116,101,114,101,120,101,99,117,116,101,7,
  12,111,110,97,102,101,114,101,120,109,101,110,117,0,1,7,111,112,116,105,
  111,110,115,11,13,109,97,111,95,115,101,112,97,114,97,116,111,114,19,109,
  97,111,95,115,104,111,114,116,99,117,116,99,97,112,116,105,111,110,0,0,
  1,7,99,97,112,116,105,111,110,6,7,32,78,111,119,61,49,32,4,104,
  105,110,116,6,20,32,65,99,116,117,97,108,32,90,111,111,109,32,102,97,
  99,116,111,114,32,5,115,116,97,116,101,11,16,97,115,95,108,111,99,97,
  108,100,105,115,97,98,108,101,100,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,13,97,115,95,108,111,99,97,108,99,111,108,111,114,12,
  97,115,95,108,111,99,97,108,104,105,110,116,0,5,99,111,108,111,114,4,
  230,230,230,0,0,1,7,111,112,116,105,111,110,115,11,13,109,97,111,95,
  115,101,112,97,114,97,116,111,114,19,109,97,111,95,115,104,111,114,116,99,
  117,116,99,97,112,116,105,111,110,0,0,1,7,99,97,112,116,105,111,110,
  6,8,32,90,111,111,109,61,49,32,4,104,105,110,116,6,21,90,111,111,
  109,32,116,111,32,119,105,110,100,111,119,32,119,105,100,116,104,32,5,115,
  116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,
  110,12,97,115,95,108,111,99,97,108,104,105,110,116,11,97,115,95,108,111,
  99,97,108,116,97,103,17,97,115,95,108,111,99,97,108,111,110,101,120,101,
  99,117,116,101,0,9,111,110,101,120,101,99,117,116,101,7,6,111,110,122,
  111,111,109,0,1,7,99,97,112,116,105,111,110,6,8,32,90,111,111,109,
  88,50,32,4,104,105,110,116,6,12,32,90,111,111,109,32,116,119,105,99,
  101,32,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,12,97,115,95,108,111,99,97,108,104,105,110,116,11,97,
  115,95,108,111,99,97,108,116,97,103,17,97,115,95,108,111,99,97,108,111,
  110,101,120,101,99,117,116,101,0,3,116,97,103,2,1,9,111,110,101,120,
  101,99,117,116,101,7,6,111,110,122,111,111,109,0,1,7,99,97,112,116,
  105,111,110,6,8,32,90,111,111,109,47,50,32,4,104,105,110,116,6,11,
  32,90,111,111,109,32,104,97,108,102,32,5,115,116,97,116,101,11,15,97,
  115,95,108,111,99,97,108,99,97,112,116,105,111,110,12,97,115,95,108,111,
  99,97,108,104,105,110,116,11,97,115,95,108,111,99,97,108,116,97,103,17,
  97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,3,116,
  97,103,2,2,9,111,110,101,120,101,99,117,116,101,7,6,111,110,122,111,
  111,109,0,1,7,99,97,112,116,105,111,110,6,1,32,5,115,116,97,116,
  101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,7,
  111,112,116,105,111,110,115,11,13,109,97,111,95,115,101,112,97,114,97,116,
  111,114,19,109,97,111,95,115,104,111,114,116,99,117,116,99,97,112,116,105,
  111,110,0,0,1,7,99,97,112,116,105,111,110,6,12,32,65,117,116,111,
  115,99,114,111,108,108,32,4,104,105,110,116,6,48,32,84,104,101,32,115,
  99,114,111,108,108,98,97,114,32,119,105,108,108,32,102,111,108,111,119,32,
  116,104,101,32,112,111,115,105,116,105,111,110,32,111,102,32,115,111,117,110,
  100,32,5,115,116,97,116,101,11,10,97,115,95,99,104,101,99,107,101,100,
  17,97,115,95,108,111,99,97,108,105,110,118,105,115,105,98,108,101,15,97,
  115,95,108,111,99,97,108,99,104,101,99,107,101,100,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,12,97,115,95,108,111,99,97,108,104,
  105,110,116,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,
  101,0,7,111,112,116,105,111,110,115,11,12,109,97,111,95,99,104,101,99,
  107,98,111,120,19,109,97,111,95,115,104,111,114,116,99,117,116,99,97,112,
  116,105,111,110,0,0,0,10,109,101,110,117,46,115,116,97,116,101,11,18,
  97,115,95,108,111,99,97,108,99,111,108,111,114,103,108,121,112,104,0,14,
  109,101,110,117,46,102,111,110,116,46,110,97,109,101,6,8,115,116,102,95,
  109,101,110,117,20,109,101,110,117,46,102,111,110,116,46,108,111,99,97,108,
  112,114,111,112,115,11,0,20,109,101,110,117,46,102,111,110,116,97,99,116,
  105,118,101,46,110,97,109,101,6,8,115,116,102,95,109,101,110,117,26,109,
  101,110,117,46,102,111,110,116,97,99,116,105,118,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,4,108,101,102,116,3,43,1,3,116,111,112,2,
  44,0,0,9,116,102,97,99,101,99,111,109,112,17,116,102,97,99,101,98,
  117,116,116,111,110,115,108,105,100,101,114,23,116,101,109,112,108,97,116,101,
  46,102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,
  100,111,119,110,21,116,101,109,112,108,97,116,101,46,111,110,97,102,116,101,
  114,112,97,105,110,116,7,17,102,97,99,101,97,102,116,101,114,112,97,105,
  110,116,98,117,116,4,108,101,102,116,3,162,0,3,116,111,112,2,26,0,
  0,0)
 );

initialization
 registerobjectdata(@objdata,twavefo,'');
end.
