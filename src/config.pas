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
    procedure oncrea(const Sender: TObject);
    procedure resizecs(fonth: integer);
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

var
  boundchildscs: array of boundchild;
  gridwidth: array of integer;

procedure tconfigfo.resizecs(fonth: integer);
var
  i1, i2, x: integer;
  ratio: double;
begin
  ratio        := fonth / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := roundmath(1000 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := roundmath(586 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fonth;

  tbutton1.font.color  := font.color;
  tbutton1.font.Height := font.Height;
  tbutton1.left        := roundmath(907 * ratio);
  tbutton1.Width       := roundmath(40 * ratio);
  tbutton1.Height      := roundmath(34 * ratio);
  tbutton1.top         := roundmath(24 * ratio);

  tbutton2.font.color  := font.color;
  tbutton2.font.Height := font.Height;
  tbutton2.left        := roundmath(51 * ratio);
  tbutton2.Width       := roundmath(150 * ratio);
  tbutton2.Height      := roundmath(30 * ratio);
  tbutton2.top         := roundmath(69 * ratio);

  tbutton3.font.color  := font.color;
  tbutton3.font.Height := font.Height;
  tbutton3.left        := roundmath(41 * ratio);
  tbutton3.Width       := roundmath(150 * ratio);
  tbutton3.Height      := roundmath(21 * ratio);
  tbutton3.top         := roundmath(6 * ratio);

  tstringdisp1.font.color  := font.color;
  tstringdisp1.font.Height := font.Height;
  tstringdisp1.left        := roundmath(201 * ratio);
  tstringdisp1.Width       := roundmath(292 * ratio);
  tstringdisp1.Height      := roundmath(34 * ratio);
  tstringdisp1.top         := roundmath(65 * ratio);

  infos_grid.font.color  := font.color;
  infos_grid.font.Height := font.Height;
  infos_grid.Width       := roundmath(1000 * ratio);
  infos_grid.Height      := roundmath(480 * ratio);
  infos_grid.top         := roundmath(104 * ratio);

  for x := 0 to 12 do
    infos_grid[x].Width := roundmath(gridwidth[x] * ratio);

  syslib.frame.font.color := font.color;
  syslib.frame.font.Height := font.Height;
  syslib.left := roundmath(262 * ratio);
  syslib.top  := roundmath(74 * ratio);

  tgroupbox1.font.color := font.color;
  tgroupbox1.left       := roundmath(491 * ratio);
  tgroupbox1.Width      := roundmath(350 * ratio);
  tgroupbox1.Height     := roundmath(90 * ratio);
  tgroupbox1.top        := 0;

  with tgroupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscs) - 1 do
        if tgroupbox1.children[i1].Name = boundchildscs[i2].Name then
        begin
          tgroupbox1.children[i1].left   := roundmath(boundchildscs[i2].left * ratio);
          tgroupbox1.children[i1].top    := roundmath(boundchildscs[i2].top * ratio);
          tgroupbox1.children[i1].Width  := roundmath(boundchildscs[i2].Width * ratio);
          tgroupbox1.children[i1].Height := roundmath(boundchildscs[i2].Height * ratio);
        end;

  tgroupbox5.font.color := font.color;
  tgroupbox5.left       := roundmath(43 * ratio);
  tgroupbox5.Width      := roundmath(381 * ratio);
  tgroupbox5.Height     := roundmath(64 * ratio);
  tgroupbox5.top        := 0;

  with tgroupbox5 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscs) - 1 do
        if tgroupbox5.children[i1].Name = boundchildscs[i2].Name then
        begin
          tgroupbox5.children[i1].left   := roundmath(boundchildscs[i2].left * ratio);
          tgroupbox5.children[i1].top    := roundmath(boundchildscs[i2].top * ratio);
          tgroupbox5.children[i1].Width  := roundmath(boundchildscs[i2].Width * ratio);
          tgroupbox5.children[i1].Height := roundmath(boundchildscs[i2].Height * ratio);
        end;

end;


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

procedure tconfigfo.oncrea(const Sender: TObject);
var
  x, i1, childn: integer;
begin

  setlength(gridwidth, 13);

  for x := 0 to 12 do
    gridwidth[x] := infos_grid[x].Width;

  childn := 0;

  setlength(boundchildscs, childrencount);
  childn := childrencount;

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildscs[i1].left   := children[i1].left;
    boundchildscs[i1].top    := children[i1].top;
    boundchildscs[i1].Width  := children[i1].Width;
    boundchildscs[i1].Height := children[i1].Height;
    boundchildscs[i1].Name   := children[i1].Name;
  end;

  setlength(boundchildscs, tgroupbox1.childrencount + childn);

  with tgroupbox1 do
    for i1 := 0 to tgroupbox1.childrencount - 1 do
    begin
      boundchildscs[i1 + childn].left   := children[i1].left;
      boundchildscs[i1 + childn].top    := children[i1].top;
      boundchildscs[i1 + childn].Width  := children[i1].Width;
      boundchildscs[i1 + childn].Height := children[i1].Height;
      boundchildscs[i1 + childn].Name   := children[i1].Name;
    end;


  childn := length(boundchildscs);
  setlength(boundchildscs, length(boundchildscs) + tgroupbox5.childrencount);

  with tgroupbox5 do
    for i1 := 0 to tgroupbox5.childrencount - 1 do
    begin
      boundchildscs[i1 + childn].left   := children[i1].left;
      boundchildscs[i1 + childn].top    := children[i1].top;
      boundchildscs[i1 + childn].Width  := children[i1].Width;
      boundchildscs[i1 + childn].Height := children[i1].Height;
      boundchildscs[i1 + childn].Name   := children[i1].Name;
    end;

end;

end.

