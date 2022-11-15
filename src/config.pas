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
    tgroupbox4: tgroupbox;
    bit16: tbooleaneditradio;
    bit32: tbooleaneditradio;
    tgroupbox5: tgroupbox;
    defdevout: tlabel;
    devoutcfg: tintegeredit;
    defdevin: tlabel;
    devincfg: tintegeredit;
    tbutton2: TButton;
    bnohint: tbooleanedit;
    syslib: tbooleanedit;
    tstringdisp1: tstringdisp;
    tbutton3: TButton;
    tlabel1: tlabel;
    procedure changelatplay(const Sender: TObject);
    procedure changelatdrums(const Sender: TObject);
    procedure changelatrec(const Sender: TObject);
    procedure onsetcolor();

    procedure oncheckdevices(const Sender: TObject);
    procedure onsetcolor1(const Sender: TObject; var avalue: colorty; var accept: Boolean);
    procedure onsetback(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onchangeback(const Sender: TObject);
    procedure onchangehint(const Sender: TObject);
    procedure onchangelib(const Sender: TObject);
    procedure onexecmessage(const Sender: TObject);
  end;

var
  configfo: tconfigfo;
  devin, devout: integer;
  canchange: Boolean = True;

implementation

uses
  spectrum1,
  waveform,
  commander,
  songplayer,
  guitars,
  randomnote,
  filelistform,
  drums,
  equalizer,
  recorder,
  main,
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

procedure tconfigfo.onchangehint(const Sender: TObject);
begin
  if (isactivated = True) then
    if bnohint.Value = True then
    begin
      mainfo.optionswidget           :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];
      mainfo.tmainmenu1.menu.options := [mao_shortcutcaption, mao_noshowhint];

      commanderfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      songplayerfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      songplayer2fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      recorderfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      filelistfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      spectrum1fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      spectrum2fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      spectrumrecfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      equalizerfo1.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      equalizerfo2.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      equalizerforec.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      wavefo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      wavefo2.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      waveforec.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      drumsfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      guitarsfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      randomnotefo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

    end
    else
    begin
      mainfo.optionswidget           :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];
      mainfo.tmainmenu1.menu.options := [mao_shortcutcaption, mao_showhint];

      commanderfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      songplayerfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      songplayer2fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      recorderfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      filelistfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      spectrum1fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      spectrum2fo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      spectrumrecfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      equalizerfo1.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      equalizerfo2.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      equalizerforec.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      wavefo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      wavefo2.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      waveforec.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      drumsfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hinton];

      guitarsfo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

      randomnotefo.optionswidget :=
        [ow_mousefocus, ow_tabfocus, ow_arrowfocus,
        ow_subfocus, ow_mousewheel, ow_destroywidgets, ow_hintoff];

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

