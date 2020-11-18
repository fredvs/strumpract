unit config;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,uos_flat, msegraphics, msegraphutils, mseevent, mseclasses, msewidgets,
 mseforms,mseact, msedataedits, mseedit, mseificomp, mseificompglob,mseifiglob,
 msestatfile,msestream, msestrings, SysUtils, msesimplewidgets,msegraphedits,
 msescrollbar, msedragglob, msegrids, msegridsglob, msedispwidgets,
 mserichstring, msedropdownlist;

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
    procedure changelatplay(const Sender: TObject);
    procedure changelatdrums(const Sender: TObject);
    procedure changelatrec(const Sender: TObject);
  
   procedure oncheckdevices(const sender: TObject);
  end;

var
  configfo: tconfigfo;
  devin, devout : integer;

implementation

uses
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


end.
