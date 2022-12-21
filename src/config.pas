unit config;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  uos_flat,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  mseact,
  msedataedits,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestatfile,
  msestream,
  msestrings,
  SysUtils,
  msesimplewidgets,
  msegraphedits,
  msescrollbar,
  msedragglob,
  msegrids,
  msegridsglob,
  msedispwidgets,
  mserichstring,
  msedropdownlist,
  msecolordialog;

type
  tconfigfo = class(tmseform)
    tgroupbox1: tgroupbox;
    latrec: trealspinedit;
    latplay: trealspinedit;
    latdrums: trealspinedit;
    tbutton1: TButton;
    infos_grid: tstringgrid;
    lsuglat: tlabel;
    tgroupbox5: tgroupbox;
    defdevout: tlabel;
    devoutcfg: tintegeredit;
    defdevin: tlabel;
    devincfg: tintegeredit;
    tstringdisp1: tstringdisp;
    tbutton3: TButton;
    tlabel1: tlabel;
    syslib: tbooleanedit;
    tbutton2: TButton;
    procedure oncheckdevices(const Sender: TObject);
    procedure onchangelib(const Sender: TObject);
    procedure onexecmessage(const Sender: TObject);
  end;

var
  configfo: tconfigfo;
  devin, devout: integer;
  canchange: Boolean = True;

implementation

uses
  main,
  drums,
  songplayer,
  recorder,
  config_mfm;

procedure tconfigfo.oncheckdevices(const Sender: TObject);
var
  x: integer = 0;
begin
  application.ProcessMessages;
  UOS_GetInfoDevice();
  application.ProcessMessages;
  infos_grid.rowcount := UOSDeviceCount;

  while x < UOSDeviceCount do
  begin
    infos_grid[0][x] := msestring(IntToStr(UOSDeviceInfos[x].DeviceNum));
    infos_grid[1][x] := msestring(UOSDeviceInfos[x].DeviceName);
    if UOSDeviceInfos[x].DefaultDevIn = True then
      infos_grid[2][x] := 'Yes'
    else
      infos_grid[2][x] := 'No';

    if UOSDeviceInfos[x].DefaultDevOut = True then
      infos_grid[3][x] := 'Yes'
    else
      infos_grid[3][x] := 'No';

    infos_grid[4][x]  := msestring(IntToStr(UOSDeviceInfos[x].ChannelsIn));
    infos_grid[5][x]  := msestring(IntToStr(UOSDeviceInfos[x].ChannelsOut));
    infos_grid[6][x]  := msestring(floattostrf(UOSDeviceInfos[x].SampleRate, ffFixed, 15, 0));
    infos_grid[7][x]  := msestring(floattostrf(UOSDeviceInfos[x].LatencyHighIn, ffFixed, 15, 8));
    infos_grid[8][x]  := msestring(floattostrf(UOSDeviceInfos[x].LatencyHighOut, ffFixed, 15, 8));
    infos_grid[9][x]  := msestring(floattostrf(UOSDeviceInfos[x].LatencyLowIn, ffFixed, 15, 8));
    infos_grid[10][x] := msestring(floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8));
    infos_grid[11][x] := msestring(UOSDeviceInfos[x].HostAPIName);
    infos_grid[12][x] := msestring(UOSDeviceInfos[x].DeviceType);
    Inc(x);
  end;
end;

procedure tconfigfo.onchangelib(const Sender: TObject);
begin
  if (isactivated = True) and (canchange = True) then
  begin
    drumsfo.dostop(Sender);
    uos_Stop(theplayer);
    uos_Stop(theplayer2);
    uos_Stop(therecplayer);
    uos_free();
    drumsfo.loadsoundlib(Sender);
    songplayerfo.checksoundtouch(Sender);
    songplayer2fo.checksoundtouch(Sender);
    recorderfo.oneventloop(Sender);

    if resulib = -1 then
    begin
      tlabel1.Caption := 'Libraries from system did not load.' + lineend +
        'Libraries from StrumPract are loaded instead.';
      canchange       := False;
      configfo.syslib.Value := False;
      canchange       := True;
    end
    else if allok then
    begin
      if syslib.Value then
        tlabel1.Caption := 'Libraries from system are loaded.'
      else
        tlabel1.Caption := 'Libraries from StrumPract are loaded.';
    end
    else
      tlabel1.Caption := 'Something went wrong when loading libraries.';

    tstringdisp1.Height  := tlabel1.Height + 20;
    tstringdisp1.Width   := tlabel1.right + tbutton3.Width + (tlabel1.left * 2);
    tbutton3.Height      := tstringdisp1.Height - 12;
    tbutton3.left        := tlabel1.right + tlabel1.left;
    tstringdisp1.Visible := True;
  end;
end;

procedure tconfigfo.onexecmessage(const Sender: TObject);
begin
  tstringdisp1.Visible := False;
end;

end.

