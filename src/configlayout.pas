unit configlayout;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,mseact,msecolordialog,msedataedits,msedropdownlist,mseedit,
 mseificomp,mseificompglob,mseifiglob,msestatfile,msestream,SysUtils,
 msegraphedits,msescrollbar;

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
   autoheight: tbooleanedit;
   bbarbie: tbooleaneditradio;
    procedure onfontheight(const Sender: TObject);
    procedure onchangehint(const Sender: TObject);
    procedure onsetcolor(const Sender: TObject);
    procedure onsetfontres(const Sender: TObject);
    procedure onchangestyle(const Sender: TObject);
    procedure onbutsetfont(const Sender: TObject);
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

procedure tconfiglayoutfo.onfontheight(const Sender: TObject);
begin
  mainfo.applyfont(round(fontheight.Value));
end;

procedure tconfiglayoutfo.onsetfontres(const Sender: TObject);
var
  rect1: rectty;
begin
  rect1 := application.screenrect(window);
  tbutton3.Caption := 'Resolution: ' + IntToStr(rect1.cx) + 'x' +
    IntToStr(rect1.cy) + lineend + 'Font height suggested: ' +
  {$ifdef mswindows}
   IntToStr(round(rect1.cx / 1280 * 12));
  {$else}
   IntToStr(round(rect1.cx / 1368 * 12));
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
    else mainfo.typecolor.Value := 3;
end;

procedure tconfiglayoutfo.onbutsetfont(const Sender: TObject);
var
  rect1: rectty;
begin
  rect1 := application.screenrect(window);
   {$ifdef mswindows}
    fontheight.Value := round(rect1.cx / 1280 * 12);
   {$else}
   fontheight.Value := round(rect1.cx / 1368 * 12);
   {$endif}
end;

end.

