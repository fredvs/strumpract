unit configlayout;

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
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  msesimplewidgets,
  mseact,
  msecolordialog,
  msedataedits,
  msedropdownlist,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestatfile,
  msestream,
  SysUtils,
  msegraphedits,
  msescrollbar;

type
  tconfiglayoutfo = class(tmseform)
    tgroupbox2: tgroupbox;
    tcoloredit1: tcoloredit;
    tcoloredit2: tcoloredit;
    tgroupbox3: tgroupbox;
    tcoloredit12: tcoloredit;
    tcoloredit22: tcoloredit;
    tgroupbox7: tgroupbox;
    fontheight: trealspinedit;
    tbutton4: TButton;
    tgroupbox4: tgroupbox;
    focusplay: tbooleanedit;
    bnohint: tbooleanedit;
    bosleep: tbooleanedit;
    tbutton1: TButton;
    tgroupbox5: tgroupbox;
    bgold: tbooleaneditradio;
    bsilver: tbooleaneditradio;
    bcarbon: tbooleaneditradio;
    tbutton3: TButton;
    bbarbie: tbooleaneditradio;
    autoheight: tbooleanedit;
    inifile: tbooleanedit;
    procedure onfontheight(const Sender: TObject);
    procedure onchangehint(const Sender: TObject);
    procedure onsetcolor(const Sender: TObject);
    procedure onsetfontres(const Sender: TObject);
    procedure onchangestyle(const Sender: TObject);
    procedure onbutsetfont(const Sender: TObject);
    procedure resizecl(fonth: integer);
    procedure oncrea(const Sender: TObject);
    procedure onchangeini(const Sender: TObject);
  end;

var
  configlayoutfo: tconfiglayoutfo;

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
  configlayout_mfm;

var
  boundchildscl: array of boundchild;

procedure tconfiglayoutfo.resizecl(fonth: integer);
var
  childrensp: widgetarty;
  heights: integerarty;
  widths: integerarty;
  tops: integerarty;
  lefts: integerarty;
  i1, i2: integer;
  spcx, spcy, posx, posy, ax: integer;
  ratio: double;
begin
  ratio        := fonth / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := roundmath(584 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := roundmath(288 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fonth;

  tbutton1.font.color  := font.color;
  tbutton1.font.Height := font.Height;
  tbutton1.left        := roundmath(524 * ratio);
  tbutton1.Width       := roundmath(40 * ratio);
  tbutton1.Height      := roundmath(27 * ratio);
  tbutton1.top         := roundmath(4 * ratio);

  autoheight.frame.font.color := font.color;
  autoheight.frame.font.Height := font.Height;
  autoheight.left := roundmath(280 * ratio);
  //tbutton1.Width      := roundmath(40 * ratio);
  //tbutton1.height      := roundmath(34 * ratio);
  autoheight.top  := roundmath(257 * ratio);


  tgroupbox2.font.color := font.color;
  tgroupbox2.left       := roundmath(22 * ratio);
  tgroupbox2.Width      := roundmath(194 * ratio);
  tgroupbox2.Height     := roundmath(155 * ratio);
  tgroupbox2.top        := roundmath(9 * ratio);

  with tgroupbox2 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscl) - 1 do
        if tgroupbox2.children[i1].Name = boundchildscl[i2].Name then
        begin
          tgroupbox2.children[i1].left   := roundmath(boundchildscl[i2].left * ratio);
          tgroupbox2.children[i1].top    := roundmath(boundchildscl[i2].top * ratio);
          tgroupbox2.children[i1].Width  := roundmath(boundchildscl[i2].Width * ratio);
          tgroupbox2.children[i1].Height := roundmath(boundchildscl[i2].Height * ratio);
        end;

  tgroupbox3.font.color := font.color;
  tgroupbox3.left       := roundmath(234 * ratio);
  tgroupbox3.Width      := roundmath(194 * ratio);
  tgroupbox3.Height     := roundmath(155 * ratio);
  tgroupbox3.top        := roundmath(9 * ratio);

  with tgroupbox3 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscl) - 1 do
        if tgroupbox3.children[i1].Name = boundchildscl[i2].Name then
        begin
          tgroupbox3.children[i1].left   := roundmath(boundchildscl[i2].left * ratio);
          tgroupbox3.children[i1].top    := roundmath(boundchildscl[i2].top * ratio);
          tgroupbox3.children[i1].Width  := roundmath(boundchildscl[i2].Width * ratio);
          tgroupbox3.children[i1].Height := roundmath(boundchildscl[i2].Height * ratio);
        end;

  tgroupbox4.font.color := font.color;
  tgroupbox4.left       := roundmath(440 * ratio);
  tgroupbox4.Width      := roundmath(125 * ratio);
  {$ifdef mswindows}
  tgroupbox4.Height     := roundmath(105 * ratio);
  tgroupbox4.top        := roundmath(46 * ratio);
  {$else}
  tgroupbox4.Height     := roundmath(128 * ratio);
  tgroupbox4.top        := roundmath(36 * ratio);
  {$endif}
  
  with tgroupbox4 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscl) - 1 do
        if tgroupbox4.children[i1].Name = boundchildscl[i2].Name then
        begin
          tgroupbox4.children[i1].left   := roundmath(boundchildscl[i2].left * ratio);
          tgroupbox4.children[i1].top    := roundmath(boundchildscl[i2].top * ratio);
          tgroupbox4.children[i1].Width  := roundmath(boundchildscl[i2].Width * ratio);
          tgroupbox4.children[i1].Height := roundmath(boundchildscl[i2].Height * ratio);
        end;

  tgroupbox5.font.color := font.color;
  tgroupbox5.left       := roundmath(22 * ratio);
  tgroupbox5.Width      := roundmath(229 * ratio);
  tgroupbox5.Height     := roundmath(105 * ratio);
  tgroupbox5.top        := roundmath(170 * ratio);

  with tgroupbox5 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscl) - 1 do
        if tgroupbox5.children[i1].Name = boundchildscl[i2].Name then
        begin
          tgroupbox5.children[i1].left   := roundmath(boundchildscl[i2].left * ratio);
          tgroupbox5.children[i1].top    := roundmath(boundchildscl[i2].top * ratio);
          tgroupbox5.children[i1].Width  := roundmath(boundchildscl[i2].Width * ratio);
          tgroupbox5.children[i1].Height := roundmath(boundchildscl[i2].Height * ratio);
        end;

  tgroupbox7.font.color := font.color;
  tgroupbox7.left       := roundmath(263 * ratio);
  tgroupbox7.Width      := roundmath(300 * ratio);
  tgroupbox7.Height     := roundmath(75 * ratio);
  tgroupbox7.top        := roundmath(170 * ratio);

  with tgroupbox7 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildscl) - 1 do
        if tgroupbox7.children[i1].Name = boundchildscl[i2].Name then
        begin
          tgroupbox7.children[i1].left   := roundmath(boundchildscl[i2].left * ratio);
          tgroupbox7.children[i1].top    := roundmath(boundchildscl[i2].top * ratio);
          tgroupbox7.children[i1].Width  := roundmath(boundchildscl[i2].Width * ratio);
          tgroupbox7.children[i1].Height := roundmath(boundchildscl[i2].Height * ratio);
        end;

end;

procedure tconfiglayoutfo.onfontheight(const Sender: TObject);
begin
  mainfo.applyfont(roundmath(fontheight.Value));
end;

procedure tconfiglayoutfo.onsetfontres(const Sender: TObject);
var
  rect1: rectty;
begin
  rect1 := application.screenrect(window);
  tbutton3.Caption := 'Resolution: ' + IntToStr(rect1.cx) + 'x' +
    IntToStr(rect1.cy) + lineend + 'Font height suggested: ' +
  {$ifdef mswindows}
    IntToStr(roundmath(rect1.cx / 1340 * 12));
  {$else}
   IntToStr(roundmath(rect1.cx / 1368 * 12));
  {$endif}
end;

procedure tconfiglayoutfo.onchangehint(const Sender: TObject);
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

procedure tconfiglayoutfo.onsetcolor(const Sender: TObject);
begin
  if (isactivated = True) then
  begin
    spectrum1fo.tchartleft.traces[0].color           := tcoloredit1.Value;
    spectrum1fo.tchartright.traces[0].color          := tcoloredit2.Value;
    spectrum2fo.tchartleft.traces[0].color           := tcoloredit12.Value;
    spectrum2fo.tchartright.traces[0].color          := tcoloredit22.Value;
    commanderfo.vuleft.bar_face.fade_color.items[0]  := tcoloredit1.Value;
    commanderfo.vuleft2.bar_face.fade_color.items[0] := tcoloredit12.Value;
    commanderfo.vuright.bar_face.fade_color.items[0] := tcoloredit2.Value;
    commanderfo.vuright2.bar_face.fade_color.items[0] := tcoloredit22.Value;
    songplayerfo.vuleft.bar_face.fade_color.items[0] := tcoloredit1.Value;
    songplayer2fo.vuleft.bar_face.fade_color.items[0] := tcoloredit12.Value;
    songplayerfo.vuright.bar_face.fade_color.items[0] := tcoloredit2.Value;
    songplayer2fo.vuright.bar_face.fade_color.items[0] := tcoloredit22.Value;

 {
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
   }

  end;
end;

procedure tconfiglayoutfo.onchangestyle(const Sender: TObject);
begin
  if (isactivated = True) then
    if bgold.Value then
      mainfo.typecolor.Value := 0
    else if bsilver.Value then
      mainfo.typecolor.Value := 1
    else if bcarbon.Value then
      mainfo.typecolor.Value := 2
    else
      mainfo.typecolor.Value := 3;
end;

procedure tconfiglayoutfo.onbutsetfont(const Sender: TObject);
var
  rect1: rectty;
begin
  rect1 := application.screenrect(window);
   {$ifdef mswindows}
  fontheight.Value := roundmath(rect1.cx / 1340 * 12);
   {$else}
   fontheight.Value := roundmath(rect1.cx / 1368 * 12);
   {$endif}
end;

procedure tconfiglayoutfo.oncrea(const Sender: TObject);
var
  x, i1, childn: integer;
begin
  childn := 0;
  
  {$ifdef mswindows}
  inifile.visible := false;
  {$endif}

  setlength(boundchildscl, childrencount);
  childn := childrencount;

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildscl[i1].left   := children[i1].left;
    boundchildscl[i1].top    := children[i1].top;
    boundchildscl[i1].Width  := children[i1].Width;
    boundchildscl[i1].Height := children[i1].Height;
    boundchildscl[i1].Name   := children[i1].Name;
  end;

  setlength(boundchildscl, tgroupbox2.childrencount + childn);

  with tgroupbox2 do
    for i1 := 0 to tgroupbox2.childrencount - 1 do
    begin
      boundchildscl[i1 + childn].left   := children[i1].left;
      boundchildscl[i1 + childn].top    := children[i1].top;
      boundchildscl[i1 + childn].Width  := children[i1].Width;
      boundchildscl[i1 + childn].Height := children[i1].Height;
      boundchildscl[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildscl);
  setlength(boundchildscl, length(boundchildscl) + tgroupbox3.childrencount);

  with tgroupbox3 do
    for i1 := 0 to tgroupbox3.childrencount - 1 do
    begin
      boundchildscl[i1 + childn].left   := children[i1].left;
      boundchildscl[i1 + childn].top    := children[i1].top;
      boundchildscl[i1 + childn].Width  := children[i1].Width;
      boundchildscl[i1 + childn].Height := children[i1].Height;
      boundchildscl[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildscl);
  setlength(boundchildscl, length(boundchildscl) + tgroupbox4.childrencount);

  with tgroupbox4 do
    for i1 := 0 to tgroupbox4.childrencount - 1 do
    begin
      boundchildscl[i1 + childn].left   := children[i1].left;
      boundchildscl[i1 + childn].top    := children[i1].top;
      boundchildscl[i1 + childn].Width  := children[i1].Width;
      boundchildscl[i1 + childn].Height := children[i1].Height;
      boundchildscl[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildscl);
  setlength(boundchildscl, length(boundchildscl) + tgroupbox5.childrencount);

  with tgroupbox5 do
    for i1 := 0 to tgroupbox5.childrencount - 1 do
    begin
      boundchildscl[i1 + childn].left   := children[i1].left;
      boundchildscl[i1 + childn].top    := children[i1].top;
      boundchildscl[i1 + childn].Width  := children[i1].Width;
      boundchildscl[i1 + childn].Height := children[i1].Height;
      boundchildscl[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildscl);
  setlength(boundchildscl, length(boundchildscl) + tgroupbox7.childrencount);

  with tgroupbox7 do
    for i1 := 0 to tgroupbox7.childrencount - 1 do
    begin
      boundchildscl[i1 + childn].left   := children[i1].left;
      boundchildscl[i1 + childn].top    := children[i1].top;
      boundchildscl[i1 + childn].Width  := children[i1].Width;
      boundchildscl[i1 + childn].Height := children[i1].Height;
      boundchildscl[i1 + childn].Name   := children[i1].Name;
    end;

end;

procedure tconfiglayoutfo.onchangeini(const Sender: TObject);
var
  thedir: msestring;
begin
  if isactivated then
  begin
    thedir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'ini/sys');
    if inifile.Value then
    begin
      if FileExists(thedir) = False then
        FileClose(FileCreate(thedir));
    end
    else if FileExists(thedir) then DeleteFile(thedir);
  end;
end;

end.

