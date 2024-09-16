{This unit is part of United Openlibraries of Sound (uos)}

{  License : modified LGPL.
  Fred van Stappen fiens@hotmail.com }

// This is the "Flat Layer" of uos => for universal methods.

unit uos_flat;

{$mode objfpc}{$H+}{$inline on}
{$PACKRECORDS C}

// For custom configuration of directive to compiler --->  uos_define.inc
{$I uos_define.inc}

interface

uses

  {$IF DEFINED(Java)}
  uos_jni,
  {$endif}

  {$IF (FPC_FULLVERSION < 20701) and DEFINED(fpgui)}
  fpg_base,
  {$ENDIF}

  ctypes, classes, math, SysUtils, uos;
 
  {$IF DEFINED(bs2b)}
  const
  BS2B_HIGH_CLEVEL = (CInt32(700)) or ((CInt32(30)) shl 16);
  BS2B_MIDDLE_CLEVEL = (CInt32(500)) or ((CInt32(45)) shl 16);
  BS2B_LOW_CLEVEL = (CInt32(360)) or ((CInt32(60)) shl 16);
  { Easy crossfeed levels (Obsolete)  }
  BS2B_HIGH_ECLEVEL = (CInt32(700)) or ((CInt32(60)) shl 16);
  BS2B_MIDDLE_ECLEVEL = (CInt32(500)) or ((CInt32(72)) shl 16);
  BS2B_LOW_ECLEVEL = (CInt32(360)) or ((CInt32(84)) shl 16);
  BS2B_DEFAULT_CLEVEL = (CInt32(700)) or ((CInt32(45)) shl 16);
  BS2B_CMOY_CLEVEL =(CInt32(700)) or ((CInt32(60)) shl 16);
  BS2B_JMEIER_CLEVEL = (CInt32(650)) or ((CInt32(95)) shl 16);
  {$endif}
  
{$IF DEFINED(synthesizer)}
const
// musical note ==> frequency in hertz
// Latin: Do, Ré, Mi, Fa, Sol, La, Si 
// Dièse = _d example la0_d 
la0  = 55.0; 
la0_d = 58.3;
si0 = 61.7;
do0 =  65.4;
do0_d = 69.3;
re0 = 73.4;
re0_d =77.8;
mi0  =82.4;
fa0  = 87.3; 
fa0_d = 92.5;
sol0 = 98.0;
sol0_d = 103.8;
la1  = 110.0; 
la1_d = 116.5;
si1 = 123.5;
do1 =  130.8;
do1_d = 138.6;
re1 = 146.8;
re1_d =155.6;
mi1  =164.8;
fa1  = 174.6; 
fa1_d = 185.0;
sol1 = 196.0;
sol1_d = 207.7;
la2 = 220.0; 
la2_d = 233.1;
si2 = 2246.9;
do2 =  261.6;
do2_d = 277.2;
re2 = 293.7;
re2_d =311.1;
mi2  =329.6;
fa2  = 349.2; 
fa2_d = 370.0;
sol2 = 392.0;
sol2_d = 415.3;
la3  = 440.0;
la3_d = 466.2;
si3 = 493.9;
do3 =  523.3;
do3_d = 554.4;
re3 = 587.3;
re3_d = 622.3;
mi3 = 659.3;
fa3  = 698.5;
fa3_d = 740.0;
sol3 = 784.0;
sol3_d = 830.6;
la4 = 880.0;
la4_d = 932.4;
si4 = 987.8;
do4 =  1046.6;
do4_d = 1108.8;
re4 = 1174.6;
re4_d = 1244.6;
mi4 = 1318.6;
fa4  = 1397.0;
fa4_d = 1480.0;
sol4 = 1568.0;
sol4_d = 1661.2;
la5 = 1760.0;

// English musique note
// A, B, C, D, E, F, G
a0  = 55.0; 
a0_s = 58.3;
b0 = 61.7;
c0 =  65.4;
c0_s = 69.3;
d0 = 73.4;
d0_s =77.8;
e0  =82.4;
f0  = 87.3; 
f0_s = 92.5;
g0 = 98.0;
g0_s = 103.8;
a1  = 110.0; 
a1_s = 116.5;
b1 = 123.5;
c1 =  130.8;
c1_s = 138.6;
d1 = 146.8;
d1_s =155.6;
e1  =164.8;
f1  = 174.6; 
f1_s = 185.0;
g1 = 196.0;
g1_s = 207.7;
a2 = 220.0; 
a2_s = 233.1;
b2 = 2246.9;
c2 =  261.6;
c2_s = 277.2;
d2 = 293.7;
d2_s =311.1;
e2  =329.6;
f2  = 349.2; 
f2_s = 370.0;
g2 = 392.0;
g2_s = 415.3;
a3  = 440.0;
a3_s = 466.2;
b3 = 493.9;
c3 =  523.3;
c3_s = 554.4;
d3 = 587.3;
d3_s = 622.3;
e3 = 659.3;
f3  = 698.5;
f3_s = 740.0;
g3 = 784.0;
g3_s = 830.6;
a4 = 880.0;
a4_s = 932.4;
b4 = 987.8;
c4 =  1046.6;
c4_s = 1108.8;
d4 = 1174.6;
d4_s = 1244.6;
e4 = 1318.6;
f4  = 1397.0;
f4_s = 1480.0;
g4 = 1568.0;
g4_s = 1661.2;
a5 = 1760.0;
{$endif}

  type
  TDArFloat = array of cfloat;

  TDArShort = array of cInt16;
  TDArLong = array of cInt32;

  TDArPARFloat = array of TDArFloat;
  TDArIARFloat = array of TDArPARFloat;

  PDArFloat = ^TDArFloat;
  PDArShort = ^TDArShort;
  PDArLong = ^TDArLong;

 type

  {$if DEFINED(java)}
 TProc = JMethodID ;
  {$else}
 TProc = procedure of object;
  {$endif}

 type
  {$if not defined(fs32bit)}
  Tcount_t  = cint64;  { used for file sizes  }
  {$else}
  Tcount_t  = cint;
  {$endif}
  PMemoryStream = ^TmemoryStream;
   
  type
  TuosF_Data = Tuos_Data;
  TuosF_FFT = Tuos_FFT ;
  TuosF_BufferInfos = Tuos_BufferInfos;

{$IF (FPC_FULLVERSION < 20701) and DEFINED(fpgui)}
  const
  MSG_CUSTOM1 = FPGM_USER + 1;
  {$ENDIF}

// General public procedure/function (accessible for library uos too)

function uos_GetInfoLibraries() : PChar ;

function uos_Int16ToFloat32(Inbuf: TDArFloat): TDArFloat;
// convert buffer int16 into float32.

{$IF DEFINED(portaudio)}
procedure uos_GetInfoDevice();

procedure uos_UpdateDevice();

function uos_GetInfoDeviceStr() : PChar ;
{$endif}

function uos_LoadLib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName, opusfileFileName: PChar) : cint32;
// load libraries... if libraryfilename = nil =>  do not load it...  You may load what and when you want...  
// PortAudio => needed for dealing with audio-device input/output
// SndFile => needed for dealing with ogg, vorbis, flac and wav audio-files
// Mpg123 => needed for dealing with mp* audio-files
// Mp4ff and Faad => needed for dealing with acc, m4a audio-files
// opusfile => needed for dealing with opus audio-files

// If you want to load libraries from system, replace it by "'system'"
// If some libraries are not needed, replace it by "nil", 
 
// for example : uos_loadlib('system', SndFileFileName, 'system', nil, nil, nil, OpusFileFileName)

function uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName
                     , opusfileFileName, XMPFileName : PChar) : cint32;
// The same but with libxmp added.                                          

procedure uos_unloadlib();
// Unload all libraries...
procedure uos_free();  
// Free uos;
// To use when program terminate. Do not forget to call it before close application...

procedure uos_unloadlibCust(PortAudio, SndFile, Mpg123, AAC, opus, xmp: boolean);
// Custom Unload libraries... if true, then unload the library. You may unload what and when you want...

function uos_loadPlugin(PluginName, PluginFilename: PChar) : cint32;
// load plugin...

{$IF DEFINED(shout)}
function uos_LoadServerLib(ShoutFileName, OpusFileName : PChar) : cint32; 
// Shout => needed for dealing with IceCast server
// Opus => needed for dealing with encoding opus stream
  
procedure uos_unloadServerLib();
// Unload server libraries... Do not forget to call it before close application...
{$endif}  
  
procedure uos_UnloadPlugin(PluginName: PChar);

// PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, soundcard, ...)
// If PlayerIndex already exists, it will be overwriten...
{$IF (FPC_FULLVERSION < 20701) and DEFINED(fpgui)}
function uos_CreatePlayer(PlayerIndex: cint32; AParent: TObject) : boolean;
{$else}
function uos_CreatePlayer(PlayerIndex: cint32): boolean;
{$endif}

{$IF DEFINED(portaudio)}
function uos_AddIntoDevOut(PlayerIndex: cint32): cint32;

// Add a Output into Device Output with custom parameters
 function uos_AddIntoDevOut(PlayerIndex: cint32; Device: cint32; Latency: CDouble;
  SampleRate: CDouble; Channels: cint32; SampleFormat: cint32 ;
   FramesCount: cint32 ; ChunkCount: cint32): cint32;
// Add a Output into Device Output
// Device ( -1 is default device )
// Latency  ( -1 is latency suggested )
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (= 65536)
// ChunkCount : default : -1 (= 512)
//  result :  Output Index in array  -1 = error
// example : OutputIndex1 := AddIntoDevOut(-1,-1,-1,-1,0,-1,-1);
 {$endif}
 
function uos_AddFromFile(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a input from audio file with default parameters

function uos_AddFromFile(PlayerIndex: cint32; Filename: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32): cint32;
// Add a input from audio file with custom parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of audio file
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
//  result : Input Index in array  -1 = error
// example : InputIndex1 := uos_AddFromFile(0, edit5.Text,-1,0);

function uos_AddIntoMemoryBuffer(PlayerIndex: cint32; outmemory: PDArFloat) : cint32;
// Add a Output into memory buffer
// outmemory : pointer of buffer to use to store memory.
// example : OutputIndex1 := uos_AddIntoMemoryBuffer(0, pointer(bufmemory));

function  uos_AddIntoMemoryBuffer(PlayerIndex: cint32; outmemory: PDArFloat; SampleRate: CDouble;  SampleFormat: LongInt;
      Channels: LongInt; FramesCount: LongInt): LongInt;  
// Add a Output into memory buffer with custom parameters
// outmemory : pointer of buffer to use to store memory.
// SampleRate : delault : -1 (44100)
// SampleFormat : default : -1 (0:float32) ( 1:Int32, 2:Int16)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// FramesCount : default : -1 (= 1024 * 2)

function uos_AddIntoMemoryStream(PlayerIndex: cint32; var MemoryStream: TMemoryStream;
 SampleRate: CDouble; SampleFormat: LongInt ; Channels: LongInt; FramesCount: LongInt; Audioformat: cint32): LongInt;  
// Add a Output into TMemoryStream
// MemoryStream : the TMemoryStream to use to store memory.
// SampleRate : delault : -1 (44100)
// SampleFormat : default : -1 (2:Int16) ( 1:Int32, 2:Int16)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// FramesCount : default : -1 (= 4096)
// AudioFormat : default : -1 (wav) (0:wav, 1:ogg);

function uos_AddFromMemoryBuffer(PlayerIndex: cint32; MemoryBuffer: TDArFloat; Bufferinfos: Tuos_bufferinfos;
 OutputIndex: cint32; FramesCount: cint32): cint32;
// Add a input from memory buffer with custom parameters
// MemoryBuffer : the buffer
// Bufferinfos : infos of the buffer
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)// SampleRate : delault : -1 (44100)// FramesCount : default : -1 (4096)
// FramesCount : default : -1 (65536 div Channels)
//  result :  Input Index in array  -1 = error
// example : InputIndex1 := AddFromMemoryBuffer(mybuffer, buffinfos,-1,1024); 

function uos_AddFromMemoryStream(PlayerIndex: cint32; var MemoryStream: TMemoryStream; 
         TypeAudio: cint32; OutputIndex: cint32; SampleFormat: cint32 ; FramesCount: cint32): cint32;
// MemoryStream : Memory stream of encoded audio.
// TypeAudio : default : -1 --> 0 (0: flac, ogg, wav; 1: mp3; 2:opus)
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (4096)
//  result :  Input Index in array  -1 = error
// example : InputIndex1 := AddFromMemoryStream(0, mymemorystream,-1,-1,0,1024);

function uos_AddFromMemoryStreamDec(PlayerIndex: cint32; var MemoryStream: TMemoryStream; var Bufferinfos: Tuos_bufferinfos;
 OutputIndex: cint32; FramesCount: cint32): cint32;
// MemoryStream : Memory-stream of decoded audio (like created by AddIntoMemoryStream)
// Bufferinfos : infos of the Memory-stream
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// FramesCount : default : -1 (4096)
//  result :  Input Index in array  -1 = error

function uos_AddFromFileIntoMemory(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a input from audio file with default parameters
  
function uos_AddFromFileIntoMemory(PlayerIndex: cint32; Filename: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32 ; numbuf : cint): cint32;
// Add a input from audio file and store it into memory with custom parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of audio file
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
// numbuf : number of buffer to add to outmemory (default : -1 = all, otherwise number max of buffers) 
//  result : Input Index in array  -1 = error
// example : InputIndex1 := uos_AddFromFile(0, edit5.Text,-1,0,-1);  

 {$IF DEFINED(shout)}
function uos_AddIntoIceServer(PlayerIndex: cint32; SampleRate : CDouble; Channels: cint; SampleFormat: cint;
 EncodeType: cint; Port: cint; Host: pchar; User: pchar; Password: pchar; MountFile :pchar): cint32;
// Add a Output into a IceCast server for audio-web-streaming
// SampleRate : delault : -1 (48100)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// EncodeType : default : -1 (0:Music) (0: Music, 1:Voice)
// SampleFormat : -1 default : float32 : (0:float32, 1:Int16)
// Port : default : -1 (= 8000)
// Host : default : 'def' (= '127.0.0.1')
// User : default : 'def' (= 'source')
// Password : default : 'def' (= 'hackme')
// MountFile : default : 'def' (= '/example.opus')
//  result :  Output Index in array  -1 = error
  {$endif}

{$IF DEFINED(webstream)}
function uos_AddFromURL(PlayerIndex: cint32; URL: PChar): cint32;
// Add a Input from Audio URL with default parameters

function uos_AddFromURL(PlayerIndex: cint32; URL: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32; AudioFormat: cint32 ; ICYon : boolean): cint32;
// Add a Input from Audio URL with custom parameters
// URL : URL of audio file 
// OutputIndex : OutputIndex of existing Output// -1: all output, -2: no output, other cint32 : existing Output
// SampleFormat : -1 default : Int16 (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (4096)
// AudioFormat : default : -1 (mp3) (0: mp3, 1: opus)
// example : InputIndex := AddFromURL(0,'http://someserver/somesound.mp3',-1,-1,-1,-1);
{$ENDIF}

function uos_AddIntoFile(PlayerIndex: cint32; Filename: PChar; SampleRate: CDouble;
  Channels: cint32; SampleFormat: cint32 ; FramesCount: cint32 ; FileFormat: cint32): cint32;
// Add a Output into audio wav file with custom parameters from TFileStream
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
// SampleFormat : default : -1 (2:Int16) (1:Int32, 2:Int16)
// FramesCount : default : -1 (= 65536)
// FileFormat : default : -1 (wav) (0:wav, 1:pcm, 2:custom, 3:ogg);
//  result :Output Index in array  -1 = error
// example : OutputIndex1 := uos_AddIntoFile(0,edit5.Text,-1,-1, 0, 1);

function uos_AddIntoFile(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a Output into audio wav file with Default parameters from TFileStream
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file

function uos_AddIntoFileFromMem(PlayerIndex: cint32; Filename: PChar; SampleRate: CDouble;  
      Channels: LongInt; SampleFormat: LongInt ; FramesCount: LongInt; FileFormat: cint32): LongInt;  
  // Add a Output into audio wav file with Custom parameters from TMemoryStream
// FileName : filename of saved audio wav file
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
//  SampleFormat : -1 default : Int16 : (1:Int32, 2:Int16)
// FramesCount : -1 default : 65536 div channels
// FileFormat : default : -1 (wav) (0:wav, 1:pcm, 2:custom);
//  result :  Output Index in array    -1 = error
// example : OutputIndex1 := AddIntoFileFromMem(0, edit5.Text,-1,-1,0, -1);

function uos_AddIntoFileFromMem(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a Output into audio wav file with Default parameters from TMemoryStream
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file

{$IF DEFINED(portaudio)}
function uos_AddFromDevIn(PlayerIndex: cint32; Device: cint32; Latency: CDouble;
  SampleRate: CDouble; OutputIndex: cint32;
  SampleFormat: cint32; FramesCount : cint32; ChunkCount: cint32): cint32;
// Add a Input from Device Input with custom parameters
// PlayerIndex : Index of a existing Player
// Device ( -1 is default Input device )
// Latency  ( -1 is latency suggested ) 
// SampleRate : delault : -1 (44100)
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (4096)
// ChunkCount : default : -1 (= 512)
//  result :  Output Index in array
// example : OutputIndex1 := uos_AddFromDevIn(0,-1,-1,-1,-1,-1,-1);

function uos_AddFromDevIn(PlayerIndex: cint32): cint32;
// Add a Input from Device Input with default parameters
// PlayerIndex : Index of a existing Player
{$endif}

function uos_AddFromEndlessMuted(PlayerIndex: cint32; Channels : cint32; FramesCount: cint32): cint32;
// Add a input from Endless Muted dummy sine wav
// FramesCount = FramesCount of input-to-follow 
// Channels = Channels of input-to-follow.
 
{$IF DEFINED(synthesizer)}
function uos_AddFromSynth(PlayerIndex: cint32; Channels: integer; WaveTypeL, WaveTypeR: shortint;
 FrequencyL, FrequencyR: float; VolumeL, VolumeR: float;
 duration : cint32; NbHarmonics: cint32; EvenHarmonics: cint32;
 OutputIndex: cint32;  SampleFormat: cint32 ; SampleRate: CDouble ; FramesCount : cint32): cint32;
// Add a input from Synthesizer with custom parameters
// Channels: default: -1 (2) (1 = mono, 2 = stereo)
// WaveTypeL: default: -1 (0) (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for mono and stereo) 
// WaveTypeR: default: -1 (0) (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for stereo, ignored for mono) 
// FrequencyL: default: -1 (440 htz) (Left frequency, used for mono)
// FrequencyR: default: -1 (440 htz) (Right frequency, used for stereo, ignored for mono)
// VolumeL: default: -1 (= 1) (from 0 to 1) => volume left
// VolumeR: default: -1 (= 1) (from 0 to 1) => volume rigth (ignored for mono)
// Duration: default:  -1 (= 1000)  => duration in msec (0 = endless)
// NbHarmonics: default:  -1 (= 0) Number of Harmonics
// EvenHarmonics: default: -1 (= 0) (0 = all harmonics, 1 = Only even harmonics)
// OutputIndex: Output index of used output
            // -1: all output, -2: no output, other cint32 refer to 
            // a existing OutputIndex 
            // (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat: default : -1 (0: Float32) (0: Float32, 1:Int32, 2:Int16)
// SampleRate: delault : -1 (44100)
// FramesCount: -1 default : 1024
//  result:  Input Index in array  -1 = error

procedure uos_InputSetSynth(PlayerIndex: cint32; InputIndex: cint32; WaveTypeL, WaveTypeR: shortint;
 FrequencyL, FrequencyR: float; VolumeL, VolumeR: float; duration: cint32; 
  NbHarmonic: cint32; EvenHarmonics: cint32; Enable: boolean);
// InputIndex: one existing input index   
// WaveTypeL: default: -1 (0) (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for mono and stereo) 
// WaveTypeR: default: -1 (0) (00 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for stereo, ignored for mono) 
// FrequencyL: do not change: -1 (Left frequency, used for mono)
// FrequencyR: do not change: -1 (440 htz) (Right frequency, used for stereo, ignored for mono)
// VolumeL: do not change: -1 (= 1) (from 0 to 1) => volume left
// VolumeR: do not change: -1 (from 0 to 1) => volume rigth (ignored for mono)
// Duration: in msec (-1 = do not change)
// NbHarmonic: Number of Harmonics (-1 not change)
// EvenHarmonics: default: -1 (= 0) (0 = all harmonics, 1 = Only even harmonics)
// Enable: true or false ;
{$endif}
  
procedure uos_BeginProc(PlayerIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute  at begining, before loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_EndProc(PlayerIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute  at end, after loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_EndProcOnly(PlayerIndex: cint32; Proc: TProconly);
// Assign the procedure  (not of object) to execute  at end, after loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_LoopBeginProc(PlayerIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute  at begin of loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_LoopEndProc(PlayerIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute  at end of loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_LoopProcIn(PlayerIndex: cint32; InIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute inside the loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input

procedure uos_LoopProcOut(PlayerIndex: cint32; OutIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute inside the loop
// PlayerIndex : Index of a existing Player
// OutIndex : Index of a existing Output

{$IF DEFINED(noiseremoval)}
procedure uos_InputAddDSPNoiseRemoval(PlayerIndex: cint32; InputIndex: cint32);
  
procedure uos_InputSetDSPNoiseRemoval(PlayerIndex: cint32; InputIndex: cint32; Enable: boolean);

procedure uos_OutputAddDSPNoiseRemoval(PlayerIndex: cint32; OutputIndex: cint32);
  
procedure uos_OutputSetDSPNoiseRemoval(PlayerIndex: cint32; OutputIndex: cint32; Enable: boolean);
{$endif} 

function uos_InputAddDSP1ChanTo2Chan(PlayerIndex: cint32; InputIndex: cint32): cint32;
//  Convert mono 1 channel input to stereo 2 channels input.
// Works only if the input is mono 1 channel othewise stereo 2 chan is keeped.
// InputIndex : InputIndex of a existing Input
//  result :  index of DSPIn in array
// example  DSPIndex1 := InputAddDSP1ChanTo2Chan(InputIndex1);
  
function uos_InputAddDSPVolume(PlayerIndex: cint32; InputIndex: cint32; VolLeft: double;
  VolRight: double) : cint32 ;
// DSP Volume changer
// PlayerIndex : Index of a existing Player
// InputIndex : InputIndex of a existing Input
// VolLeft : Left volume
// VolRight : Right volume
 //  result :  index of DSPIn in array
// example  uos_InputAddDSPVolume(0,InputIndex1,1,1);

procedure uos_OutputAddDSPVolume(PlayerIndex: cint32; OutputIndex: cint32; VolLeft: double;
  VolRight: double) ;
// DSP Volume changer
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// VolLeft : Left volume
// VolRight : Right volume
//  result : -1 nothing created, otherwise index of DSPIn in array
// example  DSPIndex1 := uos_OutputAddDSPVolume(0,oututIndex1,1,1);

procedure uos_InputSetDSPVolume(PlayerIndex: cint32; InputIndex: cint32;
  VolLeft: double; VolRight: double; Enable: boolean);
// InputIndex : InputIndex of a existing Input
// PlayerIndex : Index of a existing Player
// VolLeft : Left volume
// VolRight : Right volume
// Enable : Enabled
// example  uos_InputSetDSPVolume(0,InputIndex1,DSPIndex1,1,0.8,True);
  
procedure uos_OutputSetDSPVolume(PlayerIndex: cint32; OutputIndex: cint32;
  VolLeft: double; VolRight: double; Enable: boolean);
// OutputIndex : OutputIndex of a existing Output
// PlayerIndex : Index of a existing Player
// VolLeft : Left volume
// VolRight : Right volume
// Enable : Enabled
// example  uos_OutputSetDSPVolume(0,outputIndex1,DSPIndex1,1,0.8,True);
  
function uos_InputAddDSP(PlayerIndex: cint32; InputIndex: cint32; BeforeFunc: TFunc;
  AfterFunc: TFunc; EndedFunc: TFunc; Proc: TProc): cint32;
// add a DSP procedure for input
// PlayerIndex : Index of a existing Player
// InputIndex : Input Index of a existing input
// BeforeFunc : Function to do before the buffer is filled
// AfterFunc : Function to do after the buffer is filled
// EndedFunc : Function to do at end of thread
// LoopProc : external procedure of object to synchronize after DSP done
//  result : -1 nothing created, otherwise index of DSPin in array  (DSPinIndex)
// example : DSPinIndex1 := uos_InputAddDSP(0,InputIndex1,@beforereverse,@afterreverse,nil);

procedure uos_InputSetDSP(PlayerIndex: cint32; InputIndex: cint32; DSPinIndex: cint32; Enable: boolean);
// PlayerIndex : Index of a existing Player
// InputIndex : Input Index of a existing input
// DSPIndexIn : DSP Index of a existing DSP In
// Enable :  DSP enabled
// example : uos_InputSetDSP(0,InputIndex1,DSPinIndex1,True);

function uos_OutputAddDSP(PlayerIndex: cint32; OutputIndex: cint32; BeforeFunc: TFunc;
  AfterFunc: TFunc; EndedFunc: TFunc; Proc: TProc): cint32;  
// usefull if multi output
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// BeforeFunc : Function to do before the buffer is filled
// AfterFunc : Function to do after the buffer is filled just before to give to output
// EndedFunc : Function to do at end of thread
// LoopProc : external procedure of object to synchronize after DSP done
//  result : index of DSPout in array
// example :DSPoutIndex1 := uos_OutputAddDSP(0,OutputIndex1,nil,@volumeproc,nil,nil);

procedure uos_OutputSetDSP(PlayerIndex: cint32; OutputIndex: cint32; DSPoutIndex: cint32; Enable: boolean);
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// DSPoutIndex : DSPoutIndex of existing DSPout
// Enable :  DSP enabled
// example : uos_OutputSetDSP(0,OutputIndex1,DSPoutIndex1,True);

function uos_InputAddFilter(PlayerIndex: cint32; InputIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc): cint32;
// InputIndex : InputIndex of a existing Input
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
//  result :  index of DSPIn in array

function uos_InputGetBuffer(PlayerIndex: cint32; InputIndex: cint32): TDArFloat;
// Get current buffer

procedure uos_InputSetFilter(PlayerIndex: cint32; InputIndex: cint32; FilterIndex: cint32;  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc; Enable: boolean);
// InputIndex : InputIndex of a existing Input
// DSPInIndex : DSPInIndex of existing DSPIn
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
// Enable :  Filter enabled

function uos_OutputAddFilter(PlayerIndex: cint32; OutputIndex: cint32; 
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc): cint32;
// Output : InputIndex of a existing Output
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
//  result :  index of DSPIn in array

procedure uos_OutputSetFilter(PlayerIndex: cint32; OutputIndex: cint32; FilterIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc; Enable: boolean);
// OuputIndex : InputIndex of a existing Output
// DSPInIndex : DSPInIndex of existing DSPIn
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
// Enable :  Filter enabled

function uos_AddPlugin(PlayerIndex: cint32; PlugName: PChar; SampleRate: CDouble;
  Channels: cint32): cint32 ;
// Add a plugin , result is PluginIndex
// PlayerIndex : Index of a existing Player
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
// 'soundtouch' and 'bs2b' PlugName is registred.

{$IF DEFINED(soundtouch)}
procedure uos_SetPluginSoundTouch(PlayerIndex: cint32; PluginIndex: cint32; Tempo: cfloat;
  Pitch: cfloat; Enable: boolean);
// PluginIndex : PluginIndex Index of a existing Plugin.
// PlayerIndex : Index of a existing Player
  
procedure uos_SetPluginGetBPM(PlayerIndex: cint32; PluginIndex: cint32; numofframes: integer; loop : boolean;
   Enable: boolean);
// PluginIndex : PluginIndex Index of a existing Plugin.  
// numofframes: number of frames to analyse (-1 = 512 x frames)
// loop: do new detection after previous.  
{$endif}

{$IF DEFINED(bs2b)}
procedure uos_SetPluginBs2b(PlayerIndex: cint32; PluginIndex: cint32;
 level: CInt32; fcut: CInt32; feed: CInt32; Enable: boolean);
// PluginIndex : PluginIndex Index of a existing Plugin.
{$endif}

function uos_GetStatus(PlayerIndex: cint32) : cint32 ;
// Get the status of the player : -1 => error,  0 => has stopped, 1 => is running, 2 => is paused.

procedure uos_InputSeek(PlayerIndex: cint32; InputIndex: cint32; pos: Tcount_t);
// change position in sample

procedure uos_InputSeekSeconds(PlayerIndex: cint32; InputIndex: cint32; pos: cfloat);
// change position in seconds

procedure uos_InputSeekTime(PlayerIndex: cint32; InputIndex: cint32; pos: TTime);
// change position in time format

procedure uos_InputSetEnable(PlayerIndex: cint32; InputIndex: cint32; enabled: boolean);
// set enable true or false (usefull for multi input)

procedure uos_OutputSetEnable(PlayerIndex: cint32; OutputIndex: cint32; enabled: boolean);
// set enable true or false (usefull for multi outputput)

function uos_InputLength(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
//  result : Length of Input in samples

function uos_InputLengthSeconds(PlayerIndex: cint32; InputIndex: cint32): cfloat;
// InputIndex : InputIndex of existing input
//  result : Length of Input in seconds

function uos_InputLengthTime(PlayerIndex: cint32; InputIndex: cint32): TTime;
// InputIndex : InputIndex of existing input
//  result : Length of Input in time format

function uos_InputPosition(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
// result : current postion in sample

procedure uos_InputSetFrameCount(PlayerIndex: cint32; InputIndex: cint32 ; framecount : cint32);
// set number of frames to be done. (usefull for recording and level precision)

procedure uos_InputSetLevelEnable(PlayerIndex: cint32; InputIndex: cint32 ; enable : cint32);
// set level calculation (default is 0)
// InputIndex : InputIndex of existing input
// 0 => no calcul
// 1 => calcul before all DSP procedures.
// 2 => calcul after all DSP procedures.
// 3 => calcul before and after all DSP procedures.

procedure uos_InputSetPositionEnable(PlayerIndex: cint32; InputIndex: cint32 ; enable : cint32);
// set position calculation (default is 1)
// InputIndex : InputIndex of existing input
// 0 => no calcul
// 1 => calcul position.

procedure uos_InputSetLevelArrayEnable(PlayerIndex: cint32; InputIndex: cint32 ; levelcalc : cint32);
// set add level calculation in level-array (default is 0)
// 0 => no calcul
// 1 => calcul before all DSP procedures.
// 2 => calcul after all DSP procedures.

function uos_InputGetLevelArray(PlayerIndex: cint32; InputIndex: cint32) : TDArFloat;

function uos_InputGetLevelLeft(PlayerIndex: cint32; InputIndex: cint32): double;
// InputIndex : InputIndex of existing input
// result : left level(volume) from 0 to 1

function uos_InputGetLevelRight(PlayerIndex: cint32; InputIndex: cint32): double;
// InputIndex : InputIndex of existing input
// result : right level(volume) from 0 to 1

function uos_InputFiltersGetLevelString(PlayerIndex: cint32; InputIndex: cint32): string;
// InputIndex : InputIndex of existing input
// result : list of left|right levels separed by $ character

function uos_InputFiltersGetLevelArray(PlayerIndex: cint32; InputIndex: cint32): TDArFloat;
// InputIndex : InputIndex of existing input
// result : array of float of each filter. 
         //in format levelfilter0left,levelfilter0right,levelfilter1left,levelfilter2right,...
  
{$IF DEFINED(soundtouch)}
function uos_InputGetBPM(PlayerIndex: cint32; InputIndex: cint32): CDouble;
// InputIndex : InputIndex of existing input
// result : Beats per minuts
{$endif}     

function uos_InputPositionSeconds(PlayerIndex: cint32; InputIndex: cint32): float;
// InputIndex : InputIndex of existing input
//  result : current postion of Input in seconds

function uos_InputPositionTime(PlayerIndex: cint32; InputIndex: cint32): TTime;
// InputIndex : InputIndex of existing input
//  result : current postion of Input in time format

function uos_InputUpdateTag(PlayerIndex: cint32;InputIndex: cint32): boolean;
// for mp3 and opus files only

{$IF DEFINED(webstream) and DEFINED(mpg123)}
function uos_InputUpdateICY(PlayerIndex: cint32; InputIndex: cint32; var icy_data : pchar): integer;
// for mp3 only
{$endif}

function uos_InputGetTagTitle(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagArtist(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagAlbum(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagDate(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagComment(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagTag(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagTrack(PlayerIndex: cint32; InputIndex: cint32): pchar;
function uos_InputGetTagGenre(PlayerIndex: cint32; InputIndex: cint32): pchar;
// Tag infos

function uos_InputGetSampleRate(PlayerIndex: cint32; InputIndex: cint32): CDouble;
// InputIndex : InputIndex of existing input
// result : default sample rate

function uos_InputGetChannels(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
// result : default channels

procedure uos_PlayEx(PlayerIndex: cint32; no_free: Boolean; nloop: Integer; paused: boolean= false); 
// Start playing with free at end as parameter and assign loop

procedure uos_Play(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing

Procedure uos_PlayPaused(PlayerIndex: cint32; nloop: Integer = 0) ;// Start play paused with loop

Procedure uos_PlayNoFree(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing but do not free the player after stop

Procedure uos_PlayNoFreePaused(PlayerIndex: cint32; nloop: Integer = 0) ;// Start play paused with loop but not free player at end
  
Procedure uos_FreePlayer(PlayerIndex: cint32) ;// Works only when PlayNoFree() was used: free the player

procedure uos_RePlay(PlayerIndex: cint32);// Resume playing after pause

procedure uos_Stop(PlayerIndex: cint32);// Stop playing and free thread

procedure uos_Pause(PlayerIndex: cint32);// Pause playing

function uos_GetVersion() : cint32 ;// version of uos

function uos_SetGlobalEvent(PlayerIndex: cint32; isenabled : boolean) : boolean;
// Set the RTL Events Global (will pause/start/replay all the players synchro with same rtl event)) 
// result : true if set ok.
 
 {$IF DEFINED(soundtouch)}
function uos_GetBPM(TheBuffer: TDArFloat;  Channels: cint32; SampleRate: CDouble) : CDouble;
// From SoundTouch plugin  
{$endif}

function uos_File2Buffer(Filename: Pchar; SampleFormat: cint32 ; var bufferinfos: Tuos_BufferInfos ; frompos : cint; numbuf : cint ): TDArFloat;
// Create a memory buffer of a audio file.
// FileName : filename of audio file  
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// bufferinfos : the infos of the buffer.
// frompos : from position (default : -1 = from begining, otherwise position in song) 
// numbuf : number of frames to add to outmemory (default : -1 = all, otherwise number max of frames) 
//  result :  The memory buffer
// example : buffmem := uos_File2buffer(edit5.Text,0,buffmem, buffinfos, -1, -1);
  
function uos_Stream2Buffer(AudioFile: TMemoryStream; SampleFormat: int32 ; var outmemory: TDArFloat; var bufferinfos: Tuos_BufferInfos ; frompos : cint; numbuf : cint): TDArFloat;
// Create a memory buffer of a audio file.
// FileName : filename of audio file
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// Outmemory : the buffer to store data.
// bufferinfos : the infos of the buffer.
// frompos : from position (default : -1 = from begining, otherwise position in song) 
// numbuf : number of frames to add to outmemory (default : -1 = all, otherwise number max frames of buffers)
//  result :  The memory buffer
// example : buffmem := uos_Stream2Buffer(edit5.Text,0,buffmem, buffinfos, -1, -1);

procedure uos_File2File(FilenameIN: Pchar; FilenameOUT: Pchar; SampleFormat: cint32 ; typeout: cint32 );
// Create a audio file from a audio file.
// FileNameIN : filename of audio file IN (ogg, flac, wav, mp3, opus, aac,...)
// FileNameOUT : filename of audio file OUT (wav, pcm, custom)
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// typeout : Type of out file (-1:default=wav, 0:wav, 1:pcm, 2:custom)  
// example : InputIndex1 := uos_File2File(edit5.Text,0,buffmem); 

procedure uos_MemStream2Wavfile(FileName: UTF8String; Data: TMemoryStream; BitsPerSample, chan : integer;
 samplerate: CDouble);
// Create a audio wav file from a TMemoryStream.
// FileName : filename of wav saved file
// data : the memorystream
// BitsPerSample : 16 or 32 (bit)
// chan : number of channels
// samplerate : sample rate

procedure uos_CustBufferInfos(var bufferinfos: Tuos_BufferInfos; SampleRate: CDouble; SampleFormat : cint32; Channels: cint32 ; Length: cint32);
// to initialize a custom bufferinfos: needed for AddFromMemoryBuffer() if no bufferinfos was created.
// all infos refer to the buffer used ---> length = length of the buffer div channels.

var
  uosDeviceInfos: array of Tuos_DeviceInfos;
  uosLoadResult: Tuos_LoadResult;
  uosDeviceCount: cint32;
  uosDefaultDeviceIn: cint32;
  uosDefaultDeviceOut: cint32;
  //firstload : boolean = true;
 
implementation

function PlayersNotFree: Boolean; 
Var 
 i: Integer; 
begin 
 if uosPlayersStat <> nil then 
  for i:= 0 to Length(uosPlayersStat)-1 do 
   if uosPlayersStat[i] <> -1 then 
   begin 
    Result:= True; 
    Exit; 
   end; 
 Result:= False; 
end; 

function PlayerNotFree(indexplayer : integer): Boolean; 
begin 
 if uosPlayersStat <> nil then
  if uosPlayersStat[indexplayer] <> -1 then 
  begin
   Result:= True;
   Exit;
  end;
 Result:= False; 
end; 

{$IF DEFINED(noiseremoval)}
procedure uos_InputAddDSPNoiseRemoval(PlayerIndex: cint32; InputIndex: cint32);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].StreamIn[InputIndex].data.DSPNoiseIndex :=
  uosPlayers[PlayerIndex].InputAddDSPNoiseRemoval(InputIndex);
end;
  
procedure uos_InputSetDSPNoiseRemoval(PlayerIndex: cint32; InputIndex: cint32; Enable: boolean);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].InputSetDSPNoiseRemoval(InputIndex, Enable);
end;

procedure uos_OutputAddDSPNoiseRemoval(PlayerIndex: cint32; OutputIndex: cint32);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].StreamOut[OutputIndex].data.DSPNoiseIndex :=
  uosPlayers[PlayerIndex].OutputAddDSPNoiseRemoval(OutputIndex);
end;
  
procedure uos_OutputSetDSPNoiseRemoval(PlayerIndex: cint32; OutputIndex: cint32; Enable: boolean);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].OutputSetDSPNoiseRemoval(OutputIndex, Enable);
end;
{$endif} 

function uos_SetGlobalEvent(PlayerIndex: cint32; isenabled : boolean) : boolean;
// Set the RTL Events Global (will pause/start/replay all the players synchro with same rtl event)) 
// result : true if set ok.
begin
result := false;
if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].SetGlobalEvent(isenabled);
end;

function uos_InputAddDSPVolume(PlayerIndex: cint32; InputIndex: cint32; VolLeft: double;
  VolRight: double) : cint32; 
begin
result:= -1;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  begin
  uosPlayers[PlayerIndex].StreamIn[InputIndex].Data.DSPVolumeIndex := uosPlayers[PlayerIndex].InputAddDSPVolume(InputIndex, VolLeft, VolRight);
  result := uosPlayers[PlayerIndex].StreamIn[InputIndex].Data.DSPVolumeIndex;
  end;
end;
// DSP Volume changer
// PlayerIndex : Index of a existing Player
// InputIndex : InputIndex of a existing Input
// VolLeft : Left volume
// VolRight : Right volume
//  result : -1 nothing created, otherwise index of DSPIn in array
// example  DSPIndex1 := uos_InputAddDSPVolume(0,InputIndex1,1,1);

procedure uos_OutputAddDSPVolume(PlayerIndex: cint32; OutputIndex: cint32; VolLeft: double;
  VolRight: double);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].StreamOut[OutputIndex].Data.DSPVolumeIndex := uosPlayers[PlayerIndex].OutputAddDSPVolume(OutputIndex, VolLeft, VolRight);
end;
// DSP Volume changer
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// VolLeft : Left volume
// VolRight : Right volume
//  result : -1 nothing created, otherwise index of DSPIn in array
// example  DSPIndex1 := uos_OutputAddDSPVolume(0,InputIndex1,1,1);

procedure uos_InputSetDSPVolume(PlayerIndex: cint32; InputIndex: cint32;
  VolLeft: double; VolRight: double; Enable: boolean);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].InputSetDSPVolume(InputIndex,  uosPlayers[PlayerIndex].StreamIn[InputIndex].Data.DSPVolumeIndex, VolLeft, VolRight, Enable);
end;
// InputIndex : InputIndex of a existing Input
// PlayerIndex : Index of a existing Player
// VolLeft : Left volume
// VolRight : Right volume
// Enable : Enabled
// example  uos_InputSetDSPVolume(0,InputIndex1,1,0.8,True);

procedure uos_OutputSetDSPVolume(PlayerIndex: cint32; OutputIndex: cint32;
  VolLeft: double; VolRight: double; Enable: boolean);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].OutputSetDSPVolume(OutputIndex, uosPlayers[PlayerIndex].StreamOut[OutputIndex].Data.DSPVolumeIndex, VolLeft, VolRight, Enable);
end;
// OutputIndex : OutputIndex of a existing Output
// PlayerIndex : Index of a existing Player
// VolLeft : Left volume
// VolRight : Right volume
// Enable : Enabled
// example  uos_OutputSetDSPVolume(0,InputIndex1,1,0.8,True);

{$IF DEFINED(webstream) and DEFINED(mpg123)} 
function uos_InputUpdateICY(PlayerIndex: cint32; InputIndex: cint32; var icy_data : pchar): integer;
// for mp3 only
begin
 Result := -1;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputUpdateICY(InputIndex, icy_data) ;
 end; 
{$endif} 

function uos_InputUpdateTag(PlayerIndex: cint32;InputIndex: cint32): boolean;
// for mp3 and opus files only
 begin
 Result := false;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputUpdateTag(InputIndex) ;
 end;
  
function uos_InputGetTagTitle(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagTitle(InputIndex) ;
 end;

function uos_InputGetTagArtist(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result :=nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagArtist(InputIndex) ;
 end;

function uos_InputGetTagAlbum(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagAlbum(InputIndex) ;
 end;

function uos_InputGetTagComment(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagComment(InputIndex) ;
 end;

function uos_InputGetTagTag(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagTag(InputIndex) ;
 end;
 
function uos_InputGetTagTrack(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagTrack(InputIndex) ;
 end;
 
function uos_InputGetTagGenre(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagGenre(InputIndex) ;
 end;  
 
function uos_InputGetTagDate(PlayerIndex: cint32; InputIndex: cint32): pchar;
 begin
 Result := nil;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputGetTagDate(InputIndex) ;
 end;

function uos_InputAddDSP(PlayerIndex: cint32; InputIndex: cint32; BeforeFunc : TFunc;
  AfterFunc: TFunc; EndedFunc: TFunc; Proc: TProc): cint32;
// add a DSP procedure for input
// PlayerIndex : Index of a existing Player
// InputIndex : Input Index of a existing input
// BeforeFunc : Function to do before the buffer is filled
// AfterFunc : Function to do after the buffer is filled
// EndedFunc : Function to do at end of thread
// LoopProc : external procedure to do after the buffer is filled
//  result : index of DSPin in array  (DSPinIndex)
// example : DSPinIndex1 := uos_InputAddDSP(0,InputIndex1,@beforereverse,@afterreverse,nil);
begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputAddDSP(InputIndex, BeforeFunc, AfterFunc, EndedFunc, Proc) ;
end;

procedure uos_InputSetDSP(PlayerIndex: cint32; InputIndex: cint32; DSPinIndex: cint32; Enable: boolean);
// PlayerIndex : Index of a existing Player
// InputIndex : Input Index of a existing input
// DSPIndexIn : DSP Index of a existing DSP In
// Enable :  DSP enabled
// example : uos_InputSetDSP(0,InputIndex1,DSPinIndex1,True);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].InputSetDSP(InputIndex, DSPinIndex, Enable) ;
end;

function uos_OutputAddDSP(PlayerIndex: cint32; OutputIndex: cint32; BeforeFunc: TFunc;
  AfterFunc: TFunc; EndedFunc : TFunc; Proc: TProc): cint32;// usefull if multi output
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// BeforeFunc : Function to do before the buffer is filled
// AfterFunc : Function to do after the buffer is filled just before to give to output
// EndedFunc : Function to do at end of thread
// LoopProc : external procedure to do after the buffer is filled
//  result :index of DSPout in array
// example :DSPoutIndex1 := uos_OutputAddDSP(0,OutputIndex1,@volumeproc,nil,nil);
begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].OutputAddDSP(OutputIndex, BeforeFunc, AfterFunc, EndedFunc, Proc) ;
end;

procedure uos_OutputSetDSP(PlayerIndex: cint32; OutputIndex: cint32; DSPoutIndex: cint32; Enable: boolean);
// PlayerIndex : Index of a existing Player
// OutputIndex : OutputIndex of a existing Output
// DSPoutIndex : DSPoutIndex of existing DSPout
// Enable :  DSP enabled
// example : uos_OutputSetDSP(0,OutputIndex1,DSPoutIndex1,True);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].OutputSetDSP(OutputIndex, DSPoutIndex, Enable) ;
end;

function uos_InputAddFilter(PlayerIndex: cint32; InputIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc): cint32;
// InputIndex : InputIndex of a existing Input
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
//  result :  index of DSPIn in array
begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
result := uosPlayers[PlayerIndex].InputAddFilter(InputIndex, 
          TypeFilterL, LowFrequencyL, HighFrequencyL, GainL,
          TypeFilterR, LowFrequencyR, HighFrequencyR, GainR, AlsoBuf, LoopProc) ;
end;

procedure uos_InputSetFilter(PlayerIndex: cint32; InputIndex: cint32; FilterIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc; Enable: boolean);
// InputIndex : InputIndex of a existing Input
// DSPInIndex : DSPInIndex of existing DSPIn
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
// Enable :  Filter enabled

begin
if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetFilter(InputIndex, FilterIndex, 
  TypeFilterL, LowFrequencyL, HighFrequencyL, GainL,
  TypeFilterR, LowFrequencyR, HighFrequencyR, GainR,
  AlsoBuf, LoopProc, Enable);
end;

function uos_OutputAddFilter(PlayerIndex: cint32; OutputIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc): cint32;
// Output : InputIndex of a existing Output
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
//  result :  index of DSPIn in array
begin
 result := -1 ;
if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  
result := uosPlayers[PlayerIndex].OutputAddFilter(OutputIndex, 
          TypeFilterL, LowFrequencyL, HighFrequencyL, GainL,
          TypeFilterR, LowFrequencyR, HighFrequencyR, GainR, AlsoBuf, LoopProc) ;
  
end;

procedure uos_OutputSetFilter(PlayerIndex: cint32; OutputIndex: cint32; FilterIndex: cint32;
  TypeFilterL: shortint; LowFrequencyL, HighFrequencyL, GainL: cfloat;
  TypeFilterR: shortint; LowFrequencyR, HighFrequencyR, GainR: cfloat;
     AlsoBuf: boolean; LoopProc: TProc; Enable: boolean);
// OuputIndex : InputIndex of a existing Output
// DSPInIndex : DSPInIndex of existing DSPIn
// TypeFilterL: Type of filter left: 
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
          // fBandPass = 3, fLowPass = 4, fHighPass = 5)
// LowFrequencyL : Lowest frequency left( -1 : current LowFrequency )
// HighFrequencyL : Highest frequency left( -1 : current HighFrequency )
// GainL : gain left to apply to filter
// TypeFilterR: Type of filter right (ignored if mono):
          // ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
// LowFrequencyR : Lowest frequency Right (ignored if mono) ( -1 : current LowFrequency )
// HighFrequencyR : Highest frequency left( -1 : current HighFrequency )
// GainR : gain right (ignored if mono) to apply to filter ( 0 to what reasonable )
// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
// LoopProc : external procedure of object to synchronize after DSP done
// Enable :  Filter enabled
begin
if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].OutputSetFilter(OutputIndex, FilterIndex, 
  TypeFilterL, LowFrequencyL, HighFrequencyL, GainL,
  TypeFilterR, LowFrequencyR, HighFrequencyR, GainR,
  AlsoBuf, LoopProc, Enable);
end;

{$IF DEFINED(portaudio)}
function uos_AddFromDevIn(PlayerIndex: cint32; Device: cint32; Latency: CDouble;
  SampleRate: CDouble; OutputIndex: cint32;
  SampleFormat: cint32; FramesCount : cint32; ChunkCount: cint32): cint32;
// Add a Input from Device Input with custom parameters
// PlayerIndex : Index of a existing Player
// Device ( -1 is default Input device )
// Latency  ( -1 is latency suggested ) )
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
// ChunkCount : default : -1 (= 512)
//  result : Output Index in array , -1 is error
// example : OutputIndex1 := uos_AddFromDevIn(0,-1,-1,-1,-1,-1,-1);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddFromDevIn(Device, Latency, SampleRate, OutputIndex,
  SampleFormat, FramesCount, ChunkCount) ;
end;

function uos_AddFromDevIn(PlayerIndex: cint32): cint32;
// Add a Input from Device Input with custom parameters
// PlayerIndex : Index of a existing Player
begin
result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddFromDevIn(-1, -1, -1, -1, -1, -1, -1) ;
end;
{$endif}

function uos_AddFromEndlessMuted(PlayerIndex: cint32; Channels : cint32; FramesCount: cint32): cint32;
// Add a input from Endless Muted dummy sine wav
// FramesCount = FramesCount of input-to-follow 
// Channels = Channels of input-to-follow.
  begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddFromEndlessMuted(Channels, FramesCount) ;
end; 

{$IF DEFINED(synthesizer)}
function uos_AddFromSynth(PlayerIndex: cint32; Channels: integer; WaveTypeL, WaveTypeR: shortint;
 FrequencyL, FrequencyR: float; VolumeL, VolumeR: float;
 duration : cint32; NbHarmonics: cint32; EvenHarmonics: cint32;
 OutputIndex: cint32;  SampleFormat: cint32 ; SampleRate: CDouble ; FramesCount : cint32): cint32;
// Add a input from Synthesizer with custom parameters
// Channels: default: -1 (2) (1 = mono, 2 = stereo)
// WaveTypeL: default: -1 (0) (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for mono and stereo) 
// WaveTypeR: default: -1 (0) (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for stereo, ignored for mono) 
// FrequencyL: default: -1 (440 htz) (Left frequency, used for mono)
// FrequencyR: default: -1 (440 htz) (Right frequency, used for stereo, ignored for mono)
// VolumeL: default: -1 (= 1) (from 0 to 1) => volume left
// VolumeR: default: -1 (= 1) (from 0 to 1) => volume rigth (ignored for mono)
// Duration: default:  -1 (= 1000)  => duration in msec (0 = endless)
// NbHarmonics: default:  -1 (= 0) Number of Harmonics
// EvenHarmonics: default: -1 (= 0) (0 = all harmonics, 1 = Only even harmonics)
// OutputIndex: Output index of used output
            // -1: all output, -2: no output, other cint32 refer to 
            // a existing OutputIndex 
            // (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat: default : -1 (0: Float32) (0: Float32, 1:Int32, 2:Int16)
// SampleRate: delault : -1 (44100)
// FramesCount: -1 default : 1024
//  result:  Input Index in array  -1 = error
 begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddFromSynth(Channels,WaveTypeL, WaveTypeR, FrequencyL,
   FrequencyR, VolumeL, VolumeR, Duration, NbHarmonics, EvenHarmonics, OutputIndex,
  SampleFormat, SampleRate,  FramesCount) ;
end;

procedure uos_InputSetSynth(PlayerIndex: cint32; InputIndex: cint32; WaveTypeL, WaveTypeR: shortint;
 FrequencyL, FrequencyR: float; VolumeL, VolumeR: float; duration: cint32; 
  NbHarmonic: cint32; EvenHarmonics: cint32; Enable: boolean);
// InputIndex: one existing input index   
// WaveTypeL: do not change: -1 (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for mono and stereo) 
// WaveTypeR: do not change: -1 (0 = sine-wave 1 = square-wave, 2= triangle, 3=sawtooth used for stereo, ignored for mono) 
// FrequencyL: do not change: -1 (Left frequency, used for mono)
// FrequencyR: do not change: -1 (440 htz) (Right frequency, used for stereo, ignored for mono)
// VolumeL: do not change: -1 (= 1) (from 0 to 1) => volume left
// VolumeR: do not change: -1 (from 0 to 1) => volume rigth (ignored for mono)
// Duration: in msec (-1 = do not change)
// NbHarmonic: Number of Harmonics (-1 not change)
// EvenHarmonics: default: -1 (= 0) (0 = all harmonics, 1 = Only even harmonics)
// Enable: true or false;

  begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetSynth(InputIndex, WaveTypeL, WaveTypeR ,
   FrequencyL, FrequencyR, VolumeL, VolumeR, Duration, NbHarmonic, EvenHarmonics, Enable) ;
end;
{$endif}

function uos_AddIntoFile(PlayerIndex: cint32; Filename: PChar; SampleRate: CDouble;
  Channels: cint32; SampleFormat: cint32 ; FramesCount: cint32 ; FileFormat: cint32): cint32;
// Add a Output into audio wav file with custom parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
// SampleFormat : default : -1 (2:Int16) (1:Int32, 2:Int16)
// FramesCount : default : -1 (= 65536)
// FileFormat : default : -1 (wav) (0:wav, 1:pcm, 2:custom, 3:ogg);
//  result :Output Index in array  -1 = error
// example : OutputIndex1 := uos_AddIntoFile(0,edit5.Text,-1,-1, 0, 1);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 Result :=  uosPlayers[PlayerIndex].AddIntoFile(Filename, SampleRate, Channels, SampleFormat, FramesCount, FileFormat);
end;

function uos_AddIntoFile(PlayerIndex: cint32;  Filename: PChar): cint32;
// Add a Output into audio wav file with Default parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file
 begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 Result :=  uosPlayers[PlayerIndex].AddIntoFile(Filename, -1, -1, -1, -1, -1);
end;

function uos_AddIntoFileFromMem(PlayerIndex: cint32; Filename: PChar; SampleRate: CDouble;  
      Channels: LongInt; SampleFormat: LongInt ; FramesCount: LongInt; FileFormat: cint32): LongInt;  
// Add a Output into audio wav file with Custom parameters
// FileName : filename of saved audio wav file
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
//  SampleFormat : -1 default : Int16 : (1:Int32, 2:Int16)
// FramesCount : -1 default : 65536 div channels
// FileFormat : default : -1 (wav) (0:wav, 1:pcm, 2:custom);
//  result :  Output Index in array    -1 = error
// example : OutputIndex1 := AddIntoFileFromMem(edit5.Text,-1,-1,0, -1,-1);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 Result :=  uosPlayers[PlayerIndex].AddIntoFileFromMem(Filename, SampleRate, Channels, SampleFormat, FramesCount, FileFormat);
end;

function uos_AddIntoFileFromMem(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a Output into audio wav file with Default parameters from TMemoryStream
// PlayerIndex : Index of a existing Player
// FileName : filename of saved audio wav file
 begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 Result :=  uosPlayers[PlayerIndex].AddIntoFileFromMem(Filename, -1, -1, -1, -1, -1);
end;

 {$IF DEFINED(shout)}
function uos_AddIntoIceServer(PlayerIndex: cint32; SampleRate : CDouble; Channels: cint; SampleFormat: cint;
 EncodeType: cint; Port: cint; Host: pchar; User: pchar; Password: pchar; MountFile :pchar): cint32;
// Add a Output into a IceCast server for audio-web-streaming// SampleRate : delault : -1 (48100)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// EncodeType : default : -1 (0:Music) (0: Music, 1:Voice)
// SampleFormat : -1 default : float32 : (0:float32, 1:Int16)
// Port : default : -1 (= 8000)
// Host : default : 'def' (= '127.0.0.1')
// User : default : 'def' (= 'source')
// Password : default : 'def' (= 'hackme')
// MountFile : default : 'def' (= '/example.opus')
//  result :  Output Index in array  -1 = error
 begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 Result :=  uosPlayers[PlayerIndex].AddIntoIceServer(SampleRate, Channels, SampleFormat, EncodeType, Port, 
 Host, User, Password, MountFile  );
end;
  {$endif}

{$IF DEFINED(portaudio)}
 function uos_AddIntoDevOut(PlayerIndex: cint32; Device: cint32; Latency: CDouble;
  SampleRate: CDouble; Channels: cint32; SampleFormat: cint32 ;
   FramesCount: cint32 ; ChunkCount: cint32): cint32;
// Add a Output into Device Output with custom parameters
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddIntoDevOut(Device, Latency, SampleRate, Channels, SampleFormat , FramesCount, ChunkCount);
end;

function uos_AddIntoDevOut(PlayerIndex: cint32): cint32;
// Add a Output into Device Output with default parameters
begin
  Result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddIntoDevOut(-1, -1, -1, -1, -1 ,-1, -1);
end;
{$endif}

function uos_AddFromFile(PlayerIndex: cint32; Filename: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32): cint32;
// Add a input from audio file with custom parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of audio file
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
//  result : Input Index in array  -1 = error
// example : InputIndex1 := AddFromFile(0, edit5.Text,-1,-1);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromFile(Filename, OutputIndex, SampleFormat, FramesCount);
end;

function uos_AddFromFile(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a input from audio file with default parameters
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromFile(Filename, -1, -1, -1);
end;

function uos_AddIntoMemoryBuffer(PlayerIndex: cint32; outmemory: PDArFloat) : cint32;
// Add a Output into memory buffer
// outmemory : pointer of buffer to use to store memory.
// example : OutputIndex1 := uos_AddIntoMemoryBuffer(0, pointer(bufmemory));  
 begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddIntoMemoryBuffer(outmemory);
end;

function  uos_AddIntoMemoryBuffer(PlayerIndex: cint32; outmemory: PDArFloat; SampleRate: CDouble;  SampleFormat: LongInt;
      Channels: LongInt; FramesCount: LongInt): LongInt;  
// Add a Output into memory buffer
// outmemory : pointer of buffer to use to store memory.
// SampleRate : delault : -1 (44100)
// SampleFormat : default : -1 (0:float32) ( 1:Int32, 2:Int16)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// FramesCount : default : -1 (= 1024 * 2)
 begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddIntoMemoryBuffer(outmemory, SampleRate,SampleFormat,Channels,FramesCount);
end;

function uos_AddIntoMemoryStream(PlayerIndex: cint32; var MemoryStream: TMemoryStream; 
SampleRate: CDouble; SampleFormat: LongInt ; Channels: LongInt; FramesCount: LongInt; Audioformat: cint32): LongInt;  
// Add a Output into TMemoryStream
// MemoryStream : the TMemoryStream to use to store memory.
// SampleRate : delault : -1 (44100)
// SampleFormat : default : -1 (2:Int16) ( 1:Int32, 2:Int16)
// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
// FramesCount : default : -1 (= 4096)
// AudioFormat : default : -1 (wav) (0:wav, 1:ogg);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result :=  uosPlayers[PlayerIndex].AddIntoMemoryStream(MemoryStream, 
     SampleRate,SampleFormat,Channels,FramesCount, AudioFormat);
end;

function uos_AddFromMemoryBuffer(PlayerIndex: cint32; MemoryBuffer: TDArFloat; Bufferinfos: Tuos_bufferinfos;
 OutputIndex: cint32; FramesCount: cint32): cint32;
// Add a input from memory buffer with custom parameters
// MemoryBuffer : the buffer
// Bufferinfos : infos of the buffer
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)// SampleRate : delault : -1 (44100)// FramesCount : default : -1 (4096)
// FramesCount : default : -1 (65536 div Channels)
//  result :  Input Index in array  -1 = error
// example : InputIndex1 := AddFromMemoryBuffer(mybuffer, buffinfos,-1,1024);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromMemoryBuffer(MemoryBuffer, Bufferinfos, OutputIndex, FramesCount);
end;

function uos_AddFromMemoryStream(PlayerIndex: cint32; var MemoryStream: TMemoryStream; 
         TypeAudio: cint32; OutputIndex: cint32; SampleFormat: cint32 ; FramesCount: cint32): cint32;
// MemoryStream : Memory stream of encoded audio.
// TypeAudio : default : -1 --> 0 (0: flac, ogg, wav; 1: mp3; 2:opus)
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (4096)
//  result :  Input Index in array  -1 = error
// example : InputIndex1 := AddFromMemoryStream(0, mymemorystream,-1,-1,0,1024);
begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromMemoryStream(MemoryStream, TypeAudio, OutputIndex, SampleFormat, FramesCount);
end;

function uos_AddFromMemoryStreamDec(PlayerIndex: cint32; var MemoryStream: TMemoryStream; var Bufferinfos: Tuos_bufferinfos;
 OutputIndex: cint32; FramesCount: cint32): cint32;
// MemoryStream : Memory-stream of decoded audio (like created by AddIntoMemoryStream)
// Bufferinfos : infos of the Memory-stream
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// FramesCount : default : -1 (4096)
//  result :  Input Index in array  -1 = error
begin
 result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromMemoryStreamDec(MemoryStream, Bufferinfos, OutputIndex, FramesCount);
end;

function uos_AddFromFileIntoMemory(PlayerIndex: cint32; Filename: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32 ; numbuf : cint): cint32;
// Add a input from audio file and store it into memory with custom parameters
// PlayerIndex : Index of a existing Player
// FileName : filename of audio file
// OutputIndex : Output index of used output// -1: all output, -2: no output, other cint32 refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
//  result : Input Index in array  -1 = error
// example : InputIndex1 := uos_AddFromFileIntoMemory(0, edit5.Text, -1, 0, -1);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromFileIntoMemory(Filename, OutputIndex, SampleFormat, FramesCount, numbuf);
end;

function uos_AddFromFileIntoMemory(PlayerIndex: cint32; Filename: PChar): cint32;
// Add a input from audio file and store it into memory with default parameters
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromFileIntoMemory(Filename, -1, -1, -1, -1);
end;

{$IF DEFINED(webstream)}
function uos_AddFromURL(PlayerIndex: cint32; URL: PChar; OutputIndex: cint32;
  SampleFormat: cint32 ; FramesCount: cint32; AudioFormat: cint32 ; ICYon : boolean): cint32;
// Add a Input from Audio URL
// URL : URL of audio file
// OutputIndex : OutputIndex of existing Output// -1: all output, -2: no output, other cint32 : existing Output
// SampleFormat : -1 default : Int16 (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (4096)
// AudioFormat : default : -1 (mp3) (0: mp3, 1: opus)
// ICYon : ICY data on/off  
// Add a Input from Audio URL
// URL : URL of audio file (like  'http://someserver/somesound.mp3')
// OutputIndex : OutputIndex of existing Output// -1: all output, -2: no output, other cint32 : existing Output
// SampleFormat : -1 default : Int16 (0: Float32, 1:Int32, 2:Int16)
// FramesCount : default : -1 (65536)
// AudioFormat : default : -1 (mp3) (0: mp3, 1: opus)
// example : InputIndex := uos_AddFromURL('http://someserver/somesound.mp3',-1,-1,-1,-1, false);
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromURL(URL, OutputIndex, SampleFormat, FramesCount, AudioFormat , ICYon);
end;

function uos_AddFromURL(PlayerIndex: cint32; URL: PChar): cint32;
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddFromURL(URL, -1, -1, -1, -1, false);
end;
{$ENDIF}

function uos_AddPlugin(PlayerIndex: cint32; PlugName: PChar; SampleRate: CDouble;
  Channels: cint32): cint32;
// Add a plugin , result is PluginIndex
// PlayerIndex : Index of a existing Player
// SampleRate : delault : -1 (44100)
// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
// 'soundtouch' and 'bs2b' PlugName are registred.
begin
  result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  Result := uosPlayers[PlayerIndex].AddPlugin(PlugName, SampleRate, Channels);
end;

{$IF DEFINED(soundtouch)}
procedure uos_SetPluginSoundTouch(PlayerIndex: cint32; PluginIndex: cint32; Tempo: cfloat;
  Pitch: cfloat; Enable: boolean);
// PluginIndex : PluginIndex Index of a existing Plugin.
// PlayerIndex : Index of a existing Player
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
   uosPlayers[PlayerIndex].SetPluginSoundTouch(PluginIndex, Tempo, Pitch, Enable);
end;

procedure uos_SetPluginGetBPM(PlayerIndex: cint32; PluginIndex: cint32; numofframes: integer; loop : boolean;
   Enable: boolean);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
   uosPlayers[PlayerIndex].SetPluginGetBPM(PluginIndex, numofframes, loop, Enable);
end;

{$endif}

{$IF DEFINED(bs2b)}
  procedure uos_SetPluginBs2b(PlayerIndex: cint32; PluginIndex: cint32; level: CInt32; fcut: CInt32; 
  feed: CInt32; Enable: boolean);
// PluginIndex : PluginIndex Index of a existing Plugin.
// PlayerIndex : Index of a existing Player
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 uosPlayers[PlayerIndex].SetPluginBs2b(PluginIndex, level, fcut, feed, Enable);
end;
{$endif}

procedure uos_InputSeek(PlayerIndex: cint32; InputIndex: cint32; pos: Tcount_t);
// change position in sample
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSeek(InputIndex, pos);
end;

function uos_GetStatus(PlayerIndex: cint32) : cint32 ;
// Get the status of the player : -1 => error, 0 => has stopped, 1 => is running, 2 => is paused.
begin
result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if assigned(uosPlayers[PlayerIndex]) then
   begin
 if  uosPlayersStat[PlayerIndex] = 1 then
 result :=  uosPlayers[PlayerIndex].Status else result := -1 ;
 end else  result := -1 ;
end;

procedure uos_InputSeekSeconds(PlayerIndex: cint32; InputIndex: cint32; pos: cfloat);
// change position in seconds
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSeekSeconds(InputIndex, pos);
end;

procedure uos_InputSeekTime(PlayerIndex: cint32; InputIndex: cint32; pos: TTime);
// change position in time format
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSeekTime(InputIndex, pos);
end;

function uos_InputGetBuffer(PlayerIndex: cint32; InputIndex: cint32): TDArFloat;
// Get current buffer
begin
//{
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputGetBuffer(InputIndex) ;
// }
end;

function uos_InputLength(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
//  result : Length of Input in samples
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputLength(InputIndex) ;
end;

function uos_InputLengthSeconds(PlayerIndex: cint32; InputIndex: cint32): cfloat;
// InputIndex : InputIndex of existing input
//  result : Length of Input in seconds
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputLengthSeconds(InputIndex) ;
end;

function uos_InputLengthTime(PlayerIndex: cint32; InputIndex: cint32): TTime;
// InputIndex : InputIndex of existing input
//  result : Length of Input in time format
begin
Result := sysutils.EncodeTime(0, 0, 0, 0);
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputLengthTime(InputIndex) ;
end;

function uos_InputPosition(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
// result : current postion in sample
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputPosition(InputIndex) ;
end;

procedure uos_InputSetFrameCount(PlayerIndex: cint32; InputIndex: cint32 ; framecount : cint32);
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetFrameCount(InputIndex, framecount) ;
end;

procedure uos_InputSetLevelEnable(PlayerIndex: cint32; InputIndex: cint32 ; enable : cint32);
// set level calculation (default is 0)
// 0 => no calcul
// 1 => calcul before all DSP procedures.
// 2 => calcul after all DSP procedures.
// 3 => calcul before and after all DSP procedures.

begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetLevelEnable(InputIndex, enable) ;
end;

procedure uos_InputSetEnable(PlayerIndex: cint32; InputIndex: cint32; enabled: boolean);
// set enable true or false
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetEnable(InputIndex, enabled) ;
end;

procedure uos_OutputSetEnable(PlayerIndex: cint32; OutputIndex: cint32; enabled: boolean);
// set enable true or false (usefull for multi outputput)
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].OutputSetEnable(OutputIndex, enabled) ;
end;

procedure uos_InputSetPositionEnable(PlayerIndex: cint32; InputIndex: cint32 ; enable : cint32);
// set position calculation (default is 0)
// 0 => no calcul
// 1 => calcul position.
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetPositionEnable(InputIndex, enable) ;
end;

procedure uos_InputSetLevelArrayEnable(PlayerIndex: cint32; InputIndex: cint32 ; levelcalc : cint32);
// set add level calculation in level-array (default is 0)
// 0 => no calcul
// 1 => calcul before all DSP procedures.
// 2 => calcul after all DSP procedures.
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].InputSetLevelArrayEnable(InputIndex, levelcalc) ;
end;

function uos_InputGetLevelArray(PlayerIndex: cint32; InputIndex: cint32) : TDArFloat;
begin
  result :=  uosLevelArray[PlayerIndex][InputIndex] ;
end;

function uos_InputGetLevelLeft(PlayerIndex: cint32; InputIndex: cint32): double;
// InputIndex : InputIndex of existing input
// result : left level(volume) from 0 to 1
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputGetLevelLeft(InputIndex) ;
end;

function uos_InputFiltersGetLevelString(PlayerIndex: cint32 ; InputIndex: cint32): string;
// InputIndex : InputIndex of existing input
// filterIndex : Filterindex of existing filter
// result : list of left|right levels separed by $ character
begin
  result := '';
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputFiltersGetLevelString(InputIndex) ;
end;

function uos_InputFiltersGetLevelArray(PlayerIndex: cint32; InputIndex: cint32): TDArFloat;
// InputIndex : InputIndex of existing input
// result : array of float of each filter. 
         //in format levelfilter0left,levelfilter0right,levelfilter1left,levelfilter2right,..
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputFiltersGetLevelArray(InputIndex) ;
end;         

function uos_InputGetSampleRate(PlayerIndex: cint32; InputIndex: cint32): CDouble;
// InputIndex : InputIndex of existing input
// result : default sample rate
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) and
  (length(uosPlayers[PlayerIndex].StreamIn) > 0) and (InputIndex +1 <= length(uosPlayers[PlayerIndex].StreamIn))
  then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].StreamIn[InputIndex].Data.SamplerateRoot;
end;

function uos_InputGetChannels(PlayerIndex: cint32; InputIndex: cint32): cint32;
// InputIndex : InputIndex of existing input
// result : default channels
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) and
  (length(uosPlayers[PlayerIndex].StreamIn) > 0) and (InputIndex +1 <= length(uosPlayers[PlayerIndex].StreamIn))
  then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].StreamIn[InputIndex].Data.Channels;
end;

function uos_InputGetLevelRight(PlayerIndex: cint32; InputIndex: cint32): double;
// InputIndex : InputIndex of existing input
// result : right level(volume) from 0 to 1
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputGetLevelRight(InputIndex) ;
end;

{$IF DEFINED(soundtouch)}
function uos_InputGetBPM(PlayerIndex: cint32; InputIndex: cint32): CDouble;
// InputIndex : InputIndex of existing input
// result : Beats per minuts
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputGetBPM(InputIndex) ;
end;  
{$endif}

function uos_InputPositionSeconds(PlayerIndex: cint32; InputIndex: cint32): float;
// InputIndex : InputIndex of existing input
//  result : current postion of Input in seconds
begin
  result := 0;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputPositionSeconds(InputIndex) ;
end;

function uos_InputPositionTime(PlayerIndex: cint32; InputIndex: cint32): TTime;
// InputIndex : InputIndex of existing input
//  result : current postion of Input in time format
begin
Result := sysutils.EncodeTime(0, 0, 0, 0);
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputPositionTime(InputIndex) ;
end;

function uos_InputAddDSP1ChanTo2Chan(PlayerIndex: cint32; InputIndex: cint32): cint32;
//  Convert mono 1 channel input to stereo 2 channels input.
// Works only if the input is mono 1 channel othewise stereo 2 chan is keeped.
// InputIndex : InputIndex of a existing Input
//  result :  index of DSPIn in array
// example  DSPIndex1 := InputAddDSP1ChanTo2Chan(InputIndex1);
begin
Result := -1 ;
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 result := uosPlayers[PlayerIndex].InputAddDSP1ChanTo2Chan(InputIndex) ;
end;

Procedure uos_PlayEx(PlayerIndex: cint32;
 no_free: Boolean; nloop: Integer; paused: boolean= false);// Start playing with free at end as parameter and assign loop

begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].PlayEx(no_free,nloop, paused ) ;
end;

Procedure uos_Play(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing
begin
 if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uos_PlayEx(PlayerIndex, False,nloop);
end;

Procedure uos_PlayPaused(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing paused
begin
 if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
  uos_PlayEx(PlayerIndex, False,nloop,true);
end;

Procedure uos_PlayNoFree(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing but do not free the player after stop
begin
 if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 uos_PlayEx(PlayerIndex, True,nloop);
end;

Procedure uos_PlayNoFreePaused(PlayerIndex: cint32; nloop: Integer = 0) ;// Start playing paused but do not free the player after stop
begin
 if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
 uos_PlayEx(PlayerIndex, True,nloop, true);
end;

Procedure uos_FreePlayer(PlayerIndex: cint32) ;  
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
  if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].FreePlayer() ;
end;

procedure uos_RePlay(PlayerIndex: cint32);// Resume playing after pause
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].RePlay() ;
end;

procedure uos_Stop(PlayerIndex: cint32);// Stop playing and if uos_Play() was used: free the player
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
   begin
uosPlayers[PlayerIndex].Stop();
{$IF DEFINED(mse)}
  freeandnil(uosPlayers[PlayerIndex]);
  uosPlayersStat[PlayerIndex] := -1 ;
{$endif}
end;
end;

procedure uos_Pause(PlayerIndex: cint32);// Pause playing
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
uosPlayers[PlayerIndex].Pause() ;
end;

procedure uos_BeginProc(PlayerIndex: cint32; Proc: TProc );
// Assign the procedure of object to execute at begin, before loop
// PlayerIndex : Index of a existing Player
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].BeginProc := Proc;
end;

procedure uos_EndProc(PlayerIndex: cint32; Proc: TProc );
// Assign the procedure of object to execute at end, after loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
 uosPlayers[PlayerIndex].EndProc := Proc;
end;

procedure uos_EndProcOnly(PlayerIndex: cint32; Proc: TProconly  );
// Assign the procedure (not of object) to execute at end, after loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
 uosPlayers[PlayerIndex].EndProcOnly := Proc;
end;

procedure uos_LoopBeginProc(PlayerIndex: cint32; Proc: TProc );
// Assign the procedure of object to execute at begin, before loop
// PlayerIndex : Index of a existing Player
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].LoopBeginProc := Proc;
end;

procedure uos_LoopEndProc(PlayerIndex: cint32; Proc: TProc );
// Assign the procedure of object to execute at end, after loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
 uosPlayers[PlayerIndex].LoopEndProc := Proc;
end;

procedure uos_LoopProcIn(PlayerIndex: cint32; InIndex: cint32; Proc: TProc );
// Assign the procedure of object to execute inside the loop
// PlayerIndex : Index of a existing Player
// InIndex : Index of a existing Input
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
  uosPlayers[PlayerIndex].StreamIn[InIndex].LoopProc := Proc;
end;

procedure uos_LoopProcOut(PlayerIndex: cint32; OutIndex: cint32; Proc: TProc);
// Assign the procedure of object to execute inside the loop
// PlayerIndex : Index of a existing Player
// OutIndex : Index of a existing Output
begin
  if (length(uosPlayers) > 0) and (PlayerIndex +1 <= length(uosPlayers)) then
  if  uosPlayersStat[PlayerIndex] = 1 then
   if assigned(uosPlayers[PlayerIndex]) then
 uosPlayers[PlayerIndex].StreamOut[OutIndex].LoopProc := Proc;
end;

function uos_File2Buffer(Filename: Pchar; SampleFormat: cint32 ; var bufferinfos: Tuos_BufferInfos ; frompos : cint; numbuf : cint ): TDArFloat;
// Create a memory buffer of a audio file.
// FileName : filename of audio file  
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// bufferinfos : the infos of the buffer.
// frompos : from position (default : -1 = from begining, otherwise position in song) 
// numbuf : number of frames to add to outmemory (default : -1 = all, otherwise number max of frames) 
//  result :  The memory buffer
// example : buffmem := uos_File2buffer(edit5.Text,0,buffmem, buffinfos, -1, -1);
 begin
result := uos.uos_File2Buffer(Filename, SampleFormat, bufferinfos, frompos, numbuf )  ;
  end;
  
function uos_Stream2Buffer(AudioFile: TMemoryStream; SampleFormat: int32 ; var outmemory: TDArFloat; var bufferinfos: Tuos_BufferInfos ; frompos : cint; numbuf : cint): TDArFloat;
// Create a memory buffer of a audio file.
// FileName : filename of audio file
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// Outmemory : the buffer to store data.
// bufferinfos : the infos of the buffer.
// frompos : from position (default : -1 = from begining, otherwise position in song) 
// numbuf : number of frames to add to outmemory (default : -1 = all, otherwise number max frames of buffers)
//  result :  The memory buffer
// example : buffmem := uos_Stream2Buffer(edit5.Text,0,buffmem, buffinfos, -1, -1);
 begin
result := uos.uos_Stream2Buffer(AudioFile, SampleFormat, outmemory, bufferinfos, frompos, numbuf )  ;
  end; 
  
{$IF DEFINED(soundtouch)}
function uos_GetBPM(TheBuffer: TDArFloat;  Channels: cint32; SampleRate: CDouble) : CDouble;
// From SoundTouch plugin  
begin
  result := uos.uos_GetBPM(TheBuffer, Channels, SampleRate);
  end; 
{$endif}  

procedure uos_CustBufferInfos(var bufferinfos: Tuos_BufferInfos; SampleRate: CDouble; SampleFormat : cint32; Channels: cint32 ; Length: cint32);
// to initialize a custom bufferinfos: needed for AddFromMemoryBuffer() if no bufferinfos was created.
// all infos refer to the buffer used ---> length = length of the buffer div channels.
begin
  uos.uos_CustBufferInfos(bufferinfos, SampleRate, SampleFormat, Channels, Length);
  end;
  
procedure uos_File2File(FilenameIN: Pchar; FilenameOUT: Pchar; SampleFormat: cint32 ; typeout: cint32 );
// Create a audio file from a audio file.
// FileNameIN : filename of audio file IN (ogg, flac, wav, mp3, opus, aac,...)
// FileNameOUT : filename of audio file OUT (wav, pcm, custom)
// SampleFormat : default : -1 (2:Int16) (0: Float32, 1:Int32, 2:Int16)
// typeout : Type of out file (-1:default=wav, 0:wav, 1:pcm, 2:custom)// example : InputIndex1 := uos_File2File(edit5.Text,0,buffmem);   
 begin
  uos.uos_File2File(FilenameIN, FilenameOUT, SampleFormat, typeout);
  end;
  
procedure uos_MemStream2Wavfile(FileName: UTF8String; Data: TMemoryStream; BitsPerSample,
 chan: integer; samplerate : CDouble);
// Create a audio wav file from a TMemoryStream.
// FileName : filename of wav saved file
// data : the memorystream
// BitsPerSample : 16 or 32 (bit)
// chan : number of channels
// samplerate : sample rate 
  begin
  uos.uos_MemStream2Wavfile(FileName,Data,BitsPerSample, chan, samplerate);
  end; 
  
function uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName, opusfileFileName: PChar) : cint32;
  begin
result := uos.uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName, opusfileFileName)  ;
  end; 
  
function uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName
                     , opusfileFileName, XMPFileName : PChar) : cint32;
  begin
result := uos.uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName, opusfileFileName, XMPFileName)  ;
  end;                     
   
  
function uos_loadPlugin(PluginName, PluginFilename: PChar) : cint32;
// load plugin...
begin
result := uos.uos_loadPlugin(PluginName, PluginFilename)  ;
end;

function uos_Int16ToFloat32(Inbuf: TDArFloat): TDArFloat;
// convert buffer int16 into float32.
begin
result := uos.CvInt16ToFloat32(Inbuf);
end;

{$IF DEFINED(shout)}
function uos_LoadServerLib(ShoutFileName, OpusFileName : PChar) : cint32; 
// Shout => needed for dealing with IceCast server
// Opus => needed for dealing with encoding opus stream
begin
result := uos.uos_LoadServerLib(ShoutFileName, OpusFileName)  ;
 end;
  
procedure uos_unloadServerLib();
// Unload server libraries... Do not forget to call it before close application...
 begin
 uos.uos_unloadServerLib()  ;
 end;  
{$endif}

function uos_GetVersion() : cint32 ;
begin
result := uos.uos_GetVersion() ;
end;

procedure uos_unloadlib() ;
  var
  x: cint32;
  nt : integer = 300;
  begin
  if assigned(uosPlayers) then
  begin
  if (length(uosPlayers) > 0) then
  for x := 0 to high(uosPlayers) do
  if  uosPlayersStat[x] = 1 then
  begin
  if  uosPlayers[x].Status > 0 then
  begin
  uosPlayers[x].nofree := false;
  uosPlayers[x].Stop();
  end;
  end;
  
  while (PlayersNotFree = true) and (nt > 0) do 
  begin 
  Sleep(10); 
  Dec(nt); 
  end; 

  setlength(uosPlayers, 0) ;
  setlength(uosPlayersStat, 0) ;
  end;

 uos.uos_unloadlib() ;
end;

procedure uos_unloadlibCust(PortAudio, SndFile, Mpg123, AAC, opus, xmp : boolean);
// Custom Unload libraries... if true, then delete the library. You may unload what and when you want...
begin
uos.uos_unloadlibcust(PortAudio, SndFile, Mpg123, AAC, opus, xmp) ;
uosLoadResult:= uos.uosLoadResult;
end;

procedure uos_UnloadPlugin(PluginName: PChar);
begin
uos.uos_UnloadPlugin(PluginName) ;
uosLoadResult:= uos.uosLoadResult;
end;

function uos_GetInfoLibraries() : PChar ;
begin
result := uos.uos_GetInfoLibraries();
end;

{$IF DEFINED(portaudio)}
procedure uos_GetInfoDevice();
begin
uos.uos_GetInfoDevice();
setlength(uosDeviceInfos,length(uos.uosDeviceInfos));

uosDeviceInfos := uos.uosDeviceInfos;

uosDeviceCount:= uos.uosDeviceCount;
uosDefaultDeviceIn:= uos.uosDefaultDeviceIn;
uosDefaultDeviceOut:= uos.uosDefaultDeviceOut;
end;

procedure uos_UpdateDevice();
begin
uos.uos_UpdateDevice();
uosDeviceCount:= uos.uosDeviceCount;
uosDefaultDeviceIn:= uos.uosDefaultDeviceIn;
uosDefaultDeviceOut:= uos.uosDefaultDeviceOut;
end;

function uos_GetInfoDeviceStr() : PChar ;
begin
result := uos.uos_GetInfoDeviceStr();
uosDeviceCount:= uos.uosDeviceCount;
uosDefaultDeviceIn:= uos.uosDefaultDeviceIn;
uosDefaultDeviceOut:= uos.uosDefaultDeviceOut;
end;
{$endif}

function uos_CreatePlayer(PlayerIndex : cint32): boolean;
// Create the player , PlayerIndex1 : from 0 to what your computer can do !
// If PlayerIndex exists already, it will be overwriten...
 var
x : cint32;
nt : integer = 200;
begin
result := false;

uos_stop(PlayerIndex); // cannot hurt !

if PlayerIndex >= 0 then 
begin
if PlayerIndex + 1 > length(uosPlayers) then
begin
 setlength(uosPlayers,PlayerIndex + 1) ;
 uosPlayers[PlayerIndex] := nil;
 setlength(uosPlayersStat,PlayerIndex + 1) ;
 setlength(uosLevelArray,PlayerIndex + 1) ;
end;

 {$IF DEFINED(uos_debug) and DEFINED(unix)}
 writeln('before uosPlayers[PlayerIndex] <> nil ');
 {$endif}  
  
  if (uosPlayers[PlayerIndex] <> nil) then
  begin
   uosPlayers[PlayerIndex].FreePlayer;
   Sleep(20); 
  while (PlayerNotFree(PlayerIndex) = true) and (nt > 0) do 
  begin 
  Sleep(10); 
  Dec(nt); 
  end;
  
  end;

{$IF DEFINED(uos_debug) and DEFINED(unix)}
 writeln('after uosPlayers[PlayerIndex] <> nil ');
{$endif}  

   uosPlayers[PlayerIndex] := Tuos_Player.Create();
  
  result:= True;

  uosPlayers[PlayerIndex].Index := PlayerIndex;
//notice player is created
  uosPlayersStat[PlayerIndex] := 1 ;
 
  for x := 0 to length(uosPlayersStat) -1 do
  if uosPlayersStat[x] <> 1 then
   begin
   uosPlayersStat[x] := -1 ;
   uosPlayers[x] := nil ;
   end;

   end;
end;

procedure uos_Free();
var
x : integer;
nt : shortint = 100;
begin

// needed for MSE and if some players are still playing
if length(uosPlayers) > 0 then
 for x := 0 to length(uosPlayers) -1 do
  if assigned(uosPlayers[x]) then
  begin
  uosPlayers[x].nofree := false;
  uos_playpaused(x);
  uos_stop(x);
  end;

while (PlayersNotFree = true) and (nt > 0) do 
 begin 
  Sleep(10); 
  Dec(nt); 
 end; 
 sleep(100);
 uos.uos_free();
end;

end.
