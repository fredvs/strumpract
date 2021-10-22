unit config;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 uos_flat,msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 mseact,msedataedits,mseedit,mseificomp,mseificompglob,mseifiglob,msestatfile,
 msestream,msestrings,SysUtils,msesimplewidgets,msegraphedits,msescrollbar,
 msedragglob,msegrids,msegridsglob,msedispwidgets,mserichstring,msedropdownlist,
 msecolordialog;

type
  tconfigfo = class(tmseform)
    tgroupbox1: tgroupbox;
    latrec: trealspinedit;
    latplay: trealspinedit;
    latdrums: trealspinedit;
    tbutton1: TButton;
    defdevin: tlabel;
    defdevout: tlabel;
    tbutton2: TButton;
    infos_grid: tstringgrid;
    devincfg: tintegeredit;
    devoutcfg: tintegeredit;
    tgroupbox2: tgroupbox;
    tcoloredit1: tcoloredit;
    tcoloredit2: tcoloredit;
    dbkl1: tbooleanedit;
    tgroupbox3: tgroupbox;
    dbkl2: tbooleanedit;
    tcoloredit12: tcoloredit;
    tcoloredit22: tcoloredit;
   bosleep: tbooleanedit;
   lsuglat: tlabel;
    procedure changelatplay(const Sender: TObject);
    procedure changelatdrums(const Sender: TObject);
    procedure changelatrec(const Sender: TObject);
    procedure onsetcolor();

    procedure oncheckdevices(const Sender: TObject);
    procedure onsetcolor1(const Sender: TObject; var avalue: colorty; var accept: Boolean);
    procedure onsetback(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onchangeback(const Sender: TObject);
  end;

var
  configfo: tconfigfo;
  devin, devout: integer;

implementation

uses
  spectrum1,
  waveform,
  commander,
  songplayer,
  config_mfm;

procedure tconfigfo.changelatplay(const Sender: TObject);
begin
  //if latplay.value < 0 then latplay.value := -1;
end;

procedure tconfigfo.changelatdrums(const Sender: TObject);
begin
  //if latdrums.value < 0 then latdrums.value := -1;
end;

procedure tconfigfo.changelatrec(const Sender: TObject);
begin
  /// if latrec.value < 0 then latrec.value := -1;
end;

procedure tconfigfo.oncheckdevices(const Sender: TObject);
var
  x: integer;
begin
  UOS_GetInfoDevice();
  infos_grid.rowcount := UOSDeviceCount;
  x := 0;

  while x < UOSDeviceCount do
  begin
    infos_grid[0][x] := msestring(IntToStr(UOSDeviceInfos[x].DeviceNum));
    infos_grid[1][x] :=  msestring(UOSDeviceInfos[x].DeviceName);
    if UOSDeviceInfos[x].DefaultDevIn = True then
      infos_grid[2][x] := 'Yes'
    else
      infos_grid[2][x] := 'No';

    if UOSDeviceInfos[x].DefaultDevOut = True then
      infos_grid[3][x] := 'Yes'
    else
      infos_grid[3][x] := 'No';

    infos_grid[4][x]  :=  msestring(IntToStr(UOSDeviceInfos[x].ChannelsIn));
    infos_grid[5][x]  :=  msestring(IntToStr(UOSDeviceInfos[x].ChannelsOut));
    infos_grid[6][x]  :=  msestring(floattostrf(UOSDeviceInfos[x].SampleRate, ffFixed, 15, 0));
    infos_grid[7][x]  :=  msestring(floattostrf(UOSDeviceInfos[x].LatencyHighIn, ffFixed, 15, 8));
    infos_grid[8][x]  :=  msestring(floattostrf(UOSDeviceInfos[x].LatencyHighOut, ffFixed, 15, 8));
    infos_grid[9][x]  :=  msestring(floattostrf(UOSDeviceInfos[x].LatencyLowIn, ffFixed, 15, 8));
    infos_grid[10][x] :=  msestring(floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8));
    infos_grid[11][x] :=  msestring(UOSDeviceInfos[x].HostAPIName);
    infos_grid[12][x] :=  msestring(UOSDeviceInfos[x].DeviceType);
    Inc(x);
  end;
end;

procedure tconfigfo.onsetcolor();
begin
  spectrum1fo.tchartleft.traces[0].color           := tcoloredit1.Value;
  spectrum1fo.tchartright.traces[0].color          := tcoloredit2.Value;
  spectrum2fo.tchartleft.traces[0].color           := tcoloredit12.Value;
  spectrum2fo.tchartright.traces[0].color          := tcoloredit22.Value;
  commanderfo.vuleft.bar_face.fade_color.items[0]  := configfo.tcoloredit1.Value;
  commanderfo.vuleft2.bar_face.fade_color.items[0] := configfo.tcoloredit12.Value;
  commanderfo.vuright.bar_face.fade_color.items[0] := configfo.tcoloredit2.Value;
  commanderfo.vuright2.bar_face.fade_color.items[0] := configfo.tcoloredit22.Value;
  songplayerfo.vuleft.bar_face.fade_color.items[0] := configfo.tcoloredit1.Value;
  songplayer2fo.vuleft.bar_face.fade_color.items[0] := configfo.tcoloredit12.Value;
  songplayerfo.vuright.bar_face.fade_color.items[0] := configfo.tcoloredit2.Value;
  songplayer2fo.vuright.bar_face.fade_color.items[0] := configfo.tcoloredit22.Value;

  if dbkl1.Value then
    wavefo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreendark
  else
    wavefo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreen;

  if dbkl2.Value then
    wavefo2.trackbar1.scrollbar.face1.template := commanderfo.tfacegreendark
  else
    wavefo2.trackbar1.scrollbar.face1.template := commanderfo.tfacegreen;

  if dbkl1.Value then
    songplayerfo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreendark
  else
    songplayerfo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreen;

  if dbkl2.Value then
    songplayer2fo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreendark
  else
    songplayer2fo.trackbar1.scrollbar.face1.template := commanderfo.tfacegreen;

end;

procedure tconfigfo.onsetcolor1(const Sender: TObject; var avalue: colorty; var accept: Boolean);
begin
  //onsetcolor;
end;

procedure tconfigfo.onsetback(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  //onsetcolor;
end;

procedure tconfigfo.onchangeback(const Sender: TObject);
begin
  onsetcolor;
end;

end.

