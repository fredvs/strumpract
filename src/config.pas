unit config;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,uos_flat, msegraphics, msegraphutils, mseevent, mseclasses, msewidgets,
 mseforms,mseact, msedataedits, mseedit, mseificomp, mseificompglob,mseifiglob,
 msestatfile,msestream, msestrings, SysUtils, msesimplewidgets,msegraphedits,
 msescrollbar, msedragglob, msegrids, msegridsglob, msedispwidgets,
 mserichstring, msedropdownlist, msecolordialog;

type
  tconfigfo = class(tmseform)
    tgroupbox1: tgroupbox;
    latrec: trealspinedit;
    latplay: trealspinedit;
    latdrums: trealspinedit;
    tbutton1: TButton;
    lsuglat: tlabel;
   defdevin: tlabel;
   defdevout: tlabel;
   tbutton2: tbutton;
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
    procedure changelatplay(const Sender: TObject);
    procedure changelatdrums(const Sender: TObject);
    procedure changelatrec(const Sender: TObject);
    procedure onsetcolor();
  
   procedure oncheckdevices(const sender: TObject);
   procedure onsetcolor1(const sender: TObject; var avalue: colorty;
                   var accept: Boolean);
   procedure onsetback(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onchangeback(const sender: TObject);
  end;

var
  configfo: tconfigfo;
  devin, devout : integer;

implementation

uses
spectrum1, waveform, commander, songplayer, config_mfm;

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

procedure tconfigfo.oncheckdevices(const sender: TObject);
var
x : integer;
begin
UOS_GetInfoDevice();
infos_grid.rowcount := UOSDeviceCount;
  x := 0;

  while x < UOSDeviceCount do
    begin
       infos_grid[0][x] := IntToStr(UOSDeviceInfos[x].DeviceNum);
         infos_grid[1][x] := UOSDeviceInfos[x].DeviceName;
      if UOSDeviceInfos[x].DefaultDevIn = True then
        infos_grid[2][x] := 'Yes'
      else
        infos_grid[2][x] := 'No';

      if UOSDeviceInfos[x].DefaultDevOut = True then
        infos_grid[3][x] := 'Yes'
      else
        infos_grid[3][x] := 'No';

      infos_grid[4][x] := IntToStr(UOSDeviceInfos[x].ChannelsIn);
      infos_grid[5][x] := IntToStr(UOSDeviceInfos[x].ChannelsOut);
      infos_grid[6][x] := floattostrf(UOSDeviceInfos[x].SampleRate, ffFixed, 15, 0);
      infos_grid[7][x] := floattostrf(UOSDeviceInfos[x].LatencyHighIn, ffFixed, 15, 8);
      infos_grid[8][x] := floattostrf(UOSDeviceInfos[x].LatencyHighOut, ffFixed, 15, 8);
      infos_grid[9][x] := floattostrf(UOSDeviceInfos[x].LatencyLowIn, ffFixed, 15, 8);
      infos_grid[10][x] := floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8);
      infos_grid[11][x] := UOSDeviceInfos[x].HostAPIName;
      infos_grid[12][x] := UOSDeviceInfos[x].DeviceType;
      Inc(x);
    end; 
end;

procedure tconfigfo.onsetcolor();
begin
spectrum1fo.tchartleft.traces[0].color := tcoloredit1.value;
spectrum1fo.tchartright.traces[0].color := tcoloredit2.value;
spectrum2fo.tchartleft.traces[0].color := tcoloredit12.value;
spectrum2fo.tchartright.traces[0].color := tcoloredit22.value;
commanderfo.vuleft.bar_face.fade_color.items[0]    := configfo.tcoloredit1.value;
commanderfo.vuleft2.bar_face.fade_color.items[0]   := configfo.tcoloredit12.value;
commanderfo.vuright.bar_face.fade_color.items[0]   := configfo.tcoloredit2.value;
commanderfo.vuright2.bar_face.fade_color.items[0]  := configfo.tcoloredit22.value;
songplayerfo.vuleft.bar_face.fade_color.items[0]   := configfo.tcoloredit1.value;
songplayer2fo.vuleft.bar_face.fade_color.items[0]  := configfo.tcoloredit12.value;
songplayerfo.vuright.bar_face.fade_color.items[0]  := configfo.tcoloredit2.value;
songplayer2fo.vuright.bar_face.fade_color.items[0] := configfo.tcoloredit22.value;

if dbkl1.value then
wavefo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreendark
else wavefo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreen;

if dbkl2.value then
wavefo2.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreendark
else wavefo2.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreen;

if dbkl1.value then
songplayerfo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreendark
else songplayerfo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreen;

if dbkl2.value then
songplayer2fo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreendark
else songplayer2fo.trackbar1.scrollbar.face1.template := songplayerfo.tfacegreen;
end;

procedure tconfigfo.onsetcolor1(const sender: TObject; var avalue: colorty;
               var accept: Boolean);
begin
//onsetcolor;
end;

procedure tconfigfo.onsetback(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
//onsetcolor;
end;

procedure tconfigfo.onchangeback(const sender: TObject);
begin
onsetcolor;
end;


end.
