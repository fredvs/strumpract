{ MSEgui Copyright (c) 2010-2013 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

// Link to Portaudio and LibSnfile by FredvS

unit uos_msesigaudio;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6018 off}
 {$endif}
{$endif}
uses
  ctypes,
  uos_mpg123,
  uos_mseaudio,
  uos_portaudio,
  msesignal,
  uos_libsndfile,
  Classes,
  mclasses,
  msethread,
  msetypes,
  msestrings;

const
  defaultblocksize = 1000;


type
  tsigoutaudio = class;

  tsigaudioout = class(tcustomaudioout)
  private
  protected
    fsigout: tsigoutaudio;
    fblocksize: integer;
    fbuffer: bytearty;
    fbuffer2: array of single;
    function threadproc(Sender: tmsethread): integer; override;
    procedure run; override;
    procedure stop; override;
    procedure initnames; override;
  public
    constructor Create(const aowner: tsigoutaudio); reintroduce;
  published
    property blocksize: integer read fblocksize write fblocksize default defaultblocksize;
    property active;
    property server;
    property dev;
    property appname;
    property streamname;
    property format;
    property rate;
    property latency;
    property stacksizekb;

  end;

  tsigoutaudio = class(tsigmultiinp)
  private
    faudio: tsigaudioout;
    fbuffer: doublearty;
    fbufpo: pdouble;
    procedure setaudio(const avalue: tsigaudioout);
  protected
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
  published
    property audio: tsigaudioout read faudio write setaudio;
  end;

var
  fbuffer3: array of single;

implementation

uses
  msesysintf,
  SysUtils{$ifndef FPC},classes_del{$endif};

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6018 off}
 {$endif}
{$endif}

{ tsigaudioout }

constructor tsigaudioout.Create(const aowner: tsigoutaudio);
begin
  fblocksize := defaultblocksize;
  fsigout    := aowner;
  inherited Create(aowner);
  setsubcomponent(True);
end;

type
  convertinfoty = record
    Source: pdouble;
    dest: Pointer;
    valuehigh: integer;
  end;
  convertprocty = procedure(var info: convertinfoty);

procedure convert8(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pbyte(dest)^ := $80 + round(do1 * $7f);
      Inc(Source);
      Inc(pbyte(dest));
    end;
end;

procedure convert16(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      psmallint(dest)^ := round(do1 * $7fff);
      psmallint(dest)^ := round(do1);
      Inc(Source);
      Inc(psmallint(dest));
    end;
end;

procedure convert24(var info: convertinfoty);
var
  int1: integer;
  do1: double;
  int2: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      int2 := round(do1 * $7fffff);
  {$ifdef FPC}
      pbyte(dest)[0] := pbyte(@int2)[0];
      pbyte(dest)[1] := pbyte(@int2)[1];
      pbyte(dest)[2] := pbyte(@int2)[2];
  {$else}
   pchar(dest)[0]:= pchar(@int2)[0];
   pchar(dest)[1]:= pchar(@int2)[1];
   pchar(dest)[2]:= pchar(@int2)[2];
  {$endif}
      Inc(Source);
      Inc(pbyte(dest), 3);
    end;
end;

procedure convert32(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      Objpas.pinteger(dest)^ := round(do1 * $7fffffff);
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert32f(var info: convertinfoty);
var
  int1: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      psingle(dest)^ := Source^;
      Inc(Source);
      Inc(psingle(dest));
    end;
end;

procedure convert2432(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      Objpas.pinteger(dest)^ := round(do1 * $7fffff);
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert16swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      psmallint(dest)^ := swapendian(smallint(round(do1 * $7fff)));
      Inc(Source);
      Inc(psmallint(dest));
    end;
end;

procedure convert24swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
  int2: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      int2 := round(do1 * $7fffff);
  {$ifdef FPC}
      pbyte(dest)[0] := pbyte(@int2)[2];
      pbyte(dest)[1] := pbyte(@int2)[1];
      pbyte(dest)[2] := pbyte(@int2)[0];
  {$else}
   pchar(dest)[0]:= pchar(@int2)[2];
   pchar(dest)[1]:= pchar(@int2)[1];
   pchar(dest)[2]:= pchar(@int2)[0];
  {$endif}
      Inc(Source);
      Inc(pbyte(dest), 3);
    end;
end;

procedure convert32swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      Objpas.pinteger(dest)^ := swapendian(integer(round(do1 * $7fffffff)));
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert32fswap(var info: convertinfoty);
var
  int1: integer;
  si1: single;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
 {$ifdef FPC}
      si1 := single(Source^);
 {$else}
   si1:= source^;
 {$endif}
      plongword(dest)^ := swapendian(longword(plongword(@si1)^));
      Inc(Source);
      Inc(psingle(dest));
    end;
end;

procedure convert2432swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      Objpas.pinteger(dest)^ := swapendian(integer(round(do1 * $7fffff)));
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

function tsigaudioout.threadproc(Sender: tmsethread): integer;
var
  int1, i, encoding, mpchan: integer;
  datasize1, blocksize1, bufferlength1, valuehigh1: integer;
  controller1: tsigcontroller;
  mpsamplefrequ: longword;
  convert: convertprocty;
  info: convertinfoty;
  sfInfo: TSF_INFO;
  mpinfo: Tmpg123_frameinfo;
  PAParamIn, PAParamOut: PaStreamParameters;
  err: integer;
  sfnumframes: integer = 10;
  sfnumframes2: size_t = 10;
begin
  Result      := 0;
  controller1 := fsigout.controller;
  HandleSF    := nil;
  HandleMP    := nil;

  if controller1 <> nil then
  begin
    factive := True;

    if controller1.inputtype = 1 then // from file
    begin
      HandleSF := sf_open(controller1.SoundFilename, SFM_READ, sfInfo);
      if Assigned(HandleSF) then
      begin
        controller1.samplefrequ := SFinfo.samplerate;
        controller1.channels    := SFinfo.channels;
      end
      else
      begin
        HandleMP := mpg123_new(nil, Err);
        //writeln('err mp3 ' + IntToStr(err));
        if Err = 0 then
        begin
          mpg123_format_none(HandleMP);
          mpg123_format(HandleMP, 44100, 2, MPG123_ENC_FLOAT_32);
          mpg123_open(HandleMP, PChar(controller1.SoundFilename));
          //mpg123_getformat(HandleMP, mpsamplefrequ, mpchan, encoding);

          controller1.channels    := 2;
          controller1.samplefrequ := 44100;
        end;
      end;

    end;

    if controller1.inputtype = 2 then // input of sound card
    begin
      PAParamIn.HostApiSpecificStreamInfo := nil;
      PAParamIn.device           := Pa_GetDefaultInputDevice();
      PAParamIn.SuggestedLatency := 0.0;

      latency := PAParamIn.SuggestedLatency;

      if fformat = sfm_s16 then
        PAParamIn.SampleFormat := paInt16
      else if fformat = sfm_s32 then
        PAParamIn.SampleFormat := paInt32
      else if fformat = sfm_f32 then
        PAParamIn.SampleFormat := paFloat32
      else
        PAParamIn.SampleFormat := paFloat32;

      if ((Pa_GetDeviceInfo(PAParamIn.device)^.maxInputChannels)) > 1 then
        PAParamIn.channelCount := 2
      else
        PAParamIn.channelCount := 1;

      controller1.channels := PAParamIn.channelCount;

      err := Pa_OpenStream(@HandlePAIn, @PAParamIn, nil, controller1.samplefrequ,
        512, paClipOff, nil, nil);

      if (HandlePAIn <> nil) then
        Pa_StartStream(HandlePAIn)
      else
        raiseerror(err);
    end;

    if controller1.inputtype = 3 then // WaveForm
    begin
      controller1.SetWaveTable(0, 1, 0, 0);
      controller1.SetWaveTable(0, 2, 0, 0);
      controller1.channels := 2;
      controller1.WaveFillBuffer(FBuffer2);
    end;

    // output
    PAParamOut.hostApiSpecificStreamInfo := nil;
    PAParamOut.device := Pa_GetDefaultOutputDevice();

    {$if defined(cpuarm) or defined(cpuaarch64)}
      PAParamOut.SuggestedLatency := 0.3;
     {$else}
    PAParamOut.SuggestedLatency :=
      ((Pa_GetDeviceInfo(PAParamOut.device)^.defaultHighOutputLatency)) * 1;
    {$endif}

    latency := PAParamIn.SuggestedLatency;

    if controller1.inputtype = 0 then
      controller1.channels  := 2;
    // PAParamOut.channelCount := 1 else
    PAParamOut.channelCount := controller1.channels;

    if fformat = sfm_s16 then
      PAParamOut.SampleFormat := paInt16
    else if fformat = sfm_s32 then
      PAParamOut.SampleFormat := paInt32
    else if fformat = sfm_f32 then
      PAParamOut.SampleFormat := paFloat32
    else
      PAParamOut.SampleFormat := paFloat32;

    //    PAParamOut.SampleFormat := paFloat32;

    err := Pa_OpenStream(@HandlePAOut, nil, @PAParamOut,
      controller1.samplefrequ, 512, paClipOff, nil, nil);

    if HandlePAOut <> nil then
      Pa_StartStream(HandlePAOut)
    else
      raiseerror(err);

    //datasize1:= samplebuffersizematrix[fformat];
    if fformat = sfm_s16 then
      datasize1 := 2
    else if fformat = sfm_s32 then
      datasize1 := 4
    else if fformat = sfm_f32 then
      datasize1 := 4
    else
      datasize1 := 4;

    blocksize1     := fblocksize;
    valuehigh1     := fsigout.inputs.Count * blocksize1;
    bufferlength1  := datasize1 * valuehigh1;
    Dec(valuehigh1);
    info.valuehigh := valuehigh1;
    setlength(fbuffer, bufferlength1);
    setlength(fbuffer2, blocksize1 * controller1.channels);
    setlength(fbuffer3, length(fbuffer2));

    case fformat of
      sfm_u8, sfm_8alaw, sfm_8ulaw: convert := @convert8;
      sfm_s16
{$ifdef endian_little},sfm_s16le{$else}
        , sfm_s16be
{$endif}
        : convert          := @convert16;
      sfm_s24
{$ifdef endian_little},sfm_s24le{$else}
        , sfm_s24be
{$endif}
        : convert          := @convert24;
      sfm_s32
{$ifdef endian_little},sfm_s32le{$else}
        , sfm_s32be
{$endif}
        : convert          := @convert32;
      sfm_f32
{$ifdef endian_little},sfm_f32le{$else}
        , sfm_f32be
{$endif}
        : convert          := @convert32f;
      smf_s2432
{$ifdef endian_little},smf_s2432le{$else}
        , smf_s2432be
{$endif}
        : convert          := @convert2432;
 {$ifdef endian_little}
   sfm_s16be: begin
    convert:= @convert16swap;
   end;
   sfm_s24be: begin
    convert:= @convert24swap;
   end;
   sfm_s32be: begin
    convert:= @convert32swap;
   end;
   sfm_f32be: begin
    convert:= @convert32fswap;
   end;
   smf_s2432be: begin
    convert:= @convert2432swap;
   end;
 {$else}
      sfm_s16le: convert   := @convert16swap;
      sfm_s24le: convert   := @convert24swap;
      sfm_s32le: convert   := @convert32swap;
      sfm_f32le: convert   := @convert32fswap;
      smf_s2432le: convert := @convert2432swap;
 {$endif}
      else Exit;
    end;

    sfnumframes         := 100;
    controller1.initbuf := 0;

    while (not Sender.terminated) and (sfnumframes > 10) do
    begin

      controller1.lock;
      try

        //  if controller1.intodd = 1 then
        //   controller1.intodd := -1 else controller1.intodd := 1;

        if (controller1.inputtype = 1) and (HandleSF <> nil) then
        begin
          //writeln('sndfile');
          //  for i := 0 to length(fbuffer2) - 1 do fbuffer2[i] := 0.0;// clear input
          if fformat = sfm_s16 then
            sfnumframes := sf_read_short(HandleSF, @fbuffer2[0], length(fbuffer2))
          else if fformat = sfm_s32 then
            sfnumframes := sf_read_int(HandleSF, @fbuffer2[0], length(fbuffer2))
          else if fformat = sfm_f32 then
            sfnumframes := sf_read_float(HandleSF, @fbuffer2[0], length(fbuffer2))
          else
            sfnumframes := sf_read_float(HandleSF, @fbuffer2[0], length(fbuffer2));

          controller1.FillBufferVolume(fbuffer2);
          fbuffer3 := fbuffer2;
        end;

        if (controller1.inputtype = 1) and (HandleMP <> nil) then
        begin

          mpg123_read(HandleMP, @fBuffer2[0], length(fbuffer2) * datasize1, sfnumframes2);
          controller1.FillBufferVolume(fbuffer2);

          if controller1.initbuf > 1 then
            sfnumframes := integer(sfnumframes2);
          // writeln('sfnumframes2 ' + inttostr(sfnumframes2));
          fbuffer3      := fbuffer2;

        end;

        if (controller1.inputtype = 2) and (HandlePAin <> nil) then
        begin
          // writeln('mic');
          // for i := 0 to length(fbuffer2) - 1 do fbuffer2[i] := 0.0;// clear input
          Pa_ReadStream(HandlePAin, @fbuffer2[0], length(fbuffer2) div controller1.channels);
          controller1.FillBufferVolume(fbuffer2);
          fbuffer3 := fbuffer2;
        end;

        if (controller1.inputtype = 3) then
        begin
          //writeln('wavebuffer');
          // for i := 0 to length(fbuffer2) - 1 do fbuffer2[i] := 0.0;// clear input
          controller1.WaveFillBuffer(FBuffer2);
          fbuffer3 := fbuffer2;
        end;

        fsigout.fbufpo := Pointer(fsigout.fbuffer);
        controller1.step(blocksize1);
        info.Source    := Pointer(fsigout.fbuffer);
        info.dest      := Pointer(fbuffer);
        convert(info);

    // {
        if controller1.initbuf < 2 then
          if (controller1.inputtype = 0) then
            for i := 0 to length(fbuffer) - 1 do
              fbuffer[i]  := 0
          else
            for i         := 0 to length(fbuffer2) - 1 do
              fbuffer2[i] := 0.0;
      //  }

        if controller1.initbuf < 2 then
          Inc(controller1.initbuf);

      finally
        controller1.unlock;
      end;
      if Assigned(HandlePAOut) then
      begin
        if controller1.inputtype = 0 then
          Pa_WriteStream(HandlePAOut, @fBuffer[0], length(fbuffer) div datasize1 div fchannels);

        if (controller1.inputtype = 1) or (controller1.inputtype = 2) or (controller1.inputtype = 3) then
          Pa_WriteStream(HandlePAOut, @fbuffer2[0],
            length(fbuffer2) div controller1.channels);
      end
      else
        break;

    end;
  end;
end;

procedure tsigaudioout.run;
var
  int1: integer;
begin
  int1     := fsigout.inputs.Count;
  channels := int1;
  setlength(fsigout.fbuffer, int1 * fblocksize);
  setlength(fbuffer2, int1 * fblocksize);
  inherited;
end;

procedure tsigaudioout.stop;
begin
  inherited;
  fsigout.fbufpo := nil;
end;

procedure tsigaudioout.initnames;
begin
  inherited;
  if fstreamname = '' then
    fstreamname := msestring(fsigout.Name);
end;

{ tsigoutaudio }

constructor tsigoutaudio.Create(aowner: TComponent);
begin
  faudio := tsigaudioout.Create(self);
  inherited;
end;

destructor tsigoutaudio.Destroy;
begin
  faudio.Free;
  inherited;
end;

procedure tsigoutaudio.setaudio(const avalue: tsigaudioout);
begin
  faudio.Assign(avalue);
end;

function tsigoutaudio.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigoutaudio.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
begin
  if fbufpo <> nil then
    for int1 := 0 to finphigh do
    begin
      fbufpo^ := finps[int1]^.Value;
      Inc(fbufpo);
    end;
end;

end.

