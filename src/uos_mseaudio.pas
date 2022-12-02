{ MSEgui Copyright (c) 2010-2014 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

// Link to Portaudio and LibSnfile by FredvS

unit uos_mseaudio;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  Classes,
  mclasses,
  mseclasses,
  msethread,
  msetypes,
  uos_portaudio,
  uos_libsndfile,
  uos_mpg123,
  msesys,
  msestrings;

type

  pa_sample_spec = record
    format: shortint;          //**< The sample format */
    rate: integer;             //**< The sample rate. (e.g. 44100) */
    channels: shortint;          //**< Audio channels. (1 for mono, 2 for stereo, ...) */
  end;
  ppa_sample_spec = ^pa_sample_spec;


  sampleformatty = (sfm_u8, sfm_8alaw, sfm_8ulaw,
    sfm_s16, sfm_s24, sfm_s32, sfm_f32, smf_s2432,
    sfm_s16le, sfm_s24le, sfm_s32le, sfm_f32le, smf_s2432le,
    sfm_s16be, sfm_s24be, sfm_s32be, sfm_f32be, smf_s2432be);

const
  defaultsampleformat   = sfm_f32;
  defaultsamplechannels = 2;
  defaultsamplerate     = 44100;
  defaultlatency        = 0.1;

type

  toutstreamthread = class(tmsethread)
  end;

  sendeventty = procedure(var Data: Pointer) of object;
  //data =
  //bytearty       (sfm_u8,sfm_8alaw,sfm_8ulaw,
  //                sfm_s24,sfm_s24le,sfm_s24be)
  //smallintarty   (sfm_s16,sfm_s16le,sfm_s16be)
  //integerarty    (sfm_s32,smf_s2432,sfm_s32le,smf_s2432le,
  //                sfm_s32be,smf_s2432be)
  //or singlearty  (sfm_f32,sfm_f32le,sfm_f32be)

  erroreventty = procedure(const Sender: TObject; const errorcode: integer; const errortext: msestring) of object;

  tcustomaudioout = class(tmsecomponent)
  private
    fthread: toutstreamthread;
    fstacksizekb: integer;
    fonsend: sendeventty;
    fonerror: erroreventty;
    fserver: msestring;
    fdev: msestring;
    frate: integer;
    flatency: real;
    procedure setactive(const avalue: Boolean);
  protected
    factive: Boolean;
    fformat: sampleformatty;
    fappname: msestring;
    fstreamname: msestring;
    HandlePAIn: Pointer;
    HandlePAOut: Pointer;
    HandleSF: Pointer;
    HandleMP: Pointer;
    procedure initnames; virtual;
    procedure loaded; override;
    procedure run; virtual;
    procedure stop; virtual;
    function threadproc(Sender: tmsethread): integer; virtual;
    procedure raiseerror(const aerror: integer);
    procedure doerror(const aerror: integer);
  public
    fchannels: integer;
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure flush();
    procedure drain();

    property active: Boolean read factive write setactive default False;
    property server: msestring read fserver write fserver;
    property dev: msestring read fdev write fdev;
    property appname: msestring read fappname write fappname;
    property streamname: msestring read fstreamname write fstreamname;
    property channels: integer read fchannels write fchannels default defaultsamplechannels;
    property format: sampleformatty read fformat write fformat default defaultsampleformat;
    property rate: integer read frate write frate default defaultsamplerate;
    property stacksizekb: integer read fstacksizekb write fstacksizekb default 0;
    property latency: real read flatency write flatency;
    //seconds, 0 -> server default
    property onsend: sendeventty read fonsend write fonsend;
    property onerror: erroreventty read fonerror write fonerror;
  end;

  taudioout = class(tcustomaudioout)
  published
    property active;
    property server;
    property dev;
    property appname;
    property streamname;
    property channels;
    property format;
    property rate;
    property latency;
    property stacksizekb;
    property onsend;
    property onerror;
  end;

function uos_mseLoadLib(PA_FileName, SF_FileName, MP_FileName: string): integer;
function uos_mseUnLoadLib(): integer;

implementation

uses
  SysUtils,
  msesysintf,
  mseapplication;

function uos_mseLoadLib(PA_FileName, SF_FileName, MP_FileName: string): integer;
begin
  if Pa_Load(PChar(PA_FileName)) then  Pa_Initialize();
   Sf_Load(SF_FileName);
   mp_Load(Mp_FileName);
   mpg123_init();
end;

function uos_mseUnLoadLib(): integer;
begin
  sf_Unload();
  pa_unload();
  mp_unload();
end;

{ tcustomaudioout }

constructor tcustomaudioout.Create(aowner: TComponent);
begin
  fchannels := defaultsamplechannels;
  fformat   := defaultsampleformat;
  frate     := defaultsamplerate;
  flatency  := defaultlatency;
  inherited;
end;

destructor tcustomaudioout.Destroy;
begin
  active := False;
  inherited;
end;

procedure tcustomaudioout.flush();
begin

end;

procedure tcustomaudioout.drain();
begin

end;

procedure tcustomaudioout.setactive(const avalue: Boolean);
begin
  if factive <> avalue then
    if componentstate * [csloading, csdesigning] = [] then
    begin
      if not avalue then
        stop
      else
      begin
        run;
      end;
    end
    else
      factive := avalue;
end;

procedure tcustomaudioout.stop;
begin
  if fthread <> nil then
  begin
    fthread.terminate;
    application.waitforthread(fthread);
    FreeAndNil(fthread);
    sleep(20);
    if Assigned(HandlePAIn) then
    begin
      Pa_StopStream(HandlePAIn);
      Pa_CloseStream(HandlePAIn);
    end;
      if Assigned(HandlePAOut) then
    begin
    Pa_StopStream(HandlePAOut);
    Pa_CloseStream(HandlePAOut);
    end;
    if Assigned(HandleSF) then
    sf_close(HandleSF);
    
    if Assigned(HandleMP) then
    begin
    mpg123_close(HandleMP);
    mpg123_delete(HandleMP);
    end;
  end;
  factive := False;
end;

procedure tcustomaudioout.run;
begin
  fthread := toutstreamthread.Create(
{$ifdef FPC}
    @
{$endif}
    threadproc, False, fstacksizekb);
    sleep(20);
  factive := True;
end;

procedure tcustomaudioout.initnames;
begin

end;

procedure tcustomaudioout.loaded;
begin
  inherited;
  if not (csdesigning in componentstate) then
  begin
    initnames;
    if factive and (fthread = nil) then
      run;
  end;
end;

function tcustomaudioout.threadproc(Sender: tmsethread): integer;
var
  Data: Pointer;
  datasize: integer;
begin
  Result := 0;
  if canevent(tmethod(fonsend)) then
  begin
    factive  := True;
    datasize := 4; // (float 32 bit)

    while not Sender.terminated do
    begin
      Data := nil;
      fonsend(Data);

      if Data <> nil then
        if Assigned(HandlePAOut) then
          Pa_WriteStream(HandlePAOut, @Data, length(bytearty(Data)) * datasize);
    end;
  end;
end;

procedure tcustomaudioout.raiseerror(const aerror: integer);
begin
  raise Exception.Create('Error');
end;

procedure tcustomaudioout.doerror(const aerror: integer);
begin
  application.lock;
  try
    if canevent(tmethod(fonerror)) then // fonerror(self,aerror,pa_strerror(aerror));
    ;
  finally
    application.unlock;
  end;
end;

end.

