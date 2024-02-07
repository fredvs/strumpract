unit spectrum1;

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
  mseforms,
  msedock,
  msegraphedits,
  SysUtils,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msesimplewidgets,
  msewidgets,
  msechart,
  msedispwidgets,
  mserichstring;

type
  tspectrum1fo = class(tdockform)
    fond: tgroupbox;
    groupbox1: tgroupbox;
    tchartleft: tchart;
    groupbox2: tgroupbox;
    tchartright: tchart;
    Spect1: tbooleanedit;
    procedure onvisiblechange(const Sender: TObject);
    procedure onformcreated(const Sender: TObject);
    procedure onshowspec(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure crea(const Sender: TObject);
    procedure changecolors(const Sender: TObject);
    procedure changesilver(const Sender: TObject);
    procedure resizespc(fontheight: integer);
  end;

var
  spectrum1fo: tspectrum1fo;
  spectrum2fo: tspectrum1fo;
  spectrumrecfo: tspectrum1fo;

implementation

uses
  captionstrumpract,
  main,
  dockpanel1,
  songplayer,
  recorder,
  spectrum1_mfm;

var
  boundchildspc: array of boundchild;

procedure tspectrum1fo.resizespc(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio           := fontheight / 12;
  bounds_cxmax    := 0;
  bounds_cxmin    := 0;
  bounds_cymax    := 0;
  bounds_cymin    := 0;
  bounds_cxmax    := round(442 * ratio);
  bounds_cxmin    := bounds_cxmax;
  bounds_cymax    := round(128 * ratio);
  bounds_cymin    := bounds_cymax;
  font.Height     := fontheight;
  frame.grip_size := round(8 * ratio);

  tchartleft.traces[0].bar_width  := round(18 * ratio);
  tchartright.traces[0].bar_width := round(18 * ratio);


  Spect1.frame.font.Height := fontheight;
  Spect1.frame.font.color := font.color;
  Spect1.left := round(150 * ratio);
  Spect1.top  := round(2 * ratio);

  groupbox1.font.color := font.color;
  groupbox1.left       := round(1 * ratio);
  groupbox1.Width      := round(216 * ratio);
  groupbox2.left       := round(214 * ratio);
  groupbox2.Width      := round(218 * ratio);

  with groupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildspc) - 1 do
        if groupbox1.children[i1].Name = boundchildspc[i2].Name then
        begin
          groupbox1.children[i1].left   := round(boundchildspc[i2].left * ratio);
          groupbox1.children[i1].top    := round(boundchildspc[i2].top * ratio);
          groupbox1.children[i1].Width  := round(boundchildspc[i2].Width * ratio);
          groupbox1.children[i1].Height := round(boundchildspc[i2].Height * ratio);
        end;

  with groupbox2 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildspc) - 1 do
        if groupbox2.children[i1].Name = boundchildspc[i2].Name then
        begin
          groupbox2.children[i1].left   := round(boundchildspc[i2].left * ratio);
          groupbox2.children[i1].top    := round(boundchildspc[i2].top * ratio);
          groupbox2.children[i1].Width  := round(boundchildspc[i2].Width * ratio);
          groupbox2.children[i1].Height := round(boundchildspc[i2].Height * ratio);
        end;
end;

procedure tspectrum1fo.onvisiblechange(const Sender: TObject);
begin
  if (isactivated = True) then
  begin
    if tag = 0 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrum1']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrum1']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    if tag = 1 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrum2']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrum2']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    if tag = 2 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrumrec']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showspectrumrec']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)];


    if (norefresh = False) and (parentwidget <> nil) then
    begin

      if (parentwidget = mainfo.basedock) or
        (mainfo.basedock.dragdock.currentsplitdir = sd_tabed) then
        mainfo.updatelayoutstrum();

      if (parentwidget = dockpanel1fo.basedock) or
        (dockpanel1fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel1fo.Visible then
          dockpanel1fo.updatelayoutpan();

      if (parentwidget = dockpanel2fo.basedock) or
        (dockpanel2fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel2fo.Visible then
          dockpanel2fo.updatelayoutpan();

      if (parentwidget = dockpanel3fo.basedock) or
        (dockpanel3fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel3fo.Visible then
          dockpanel3fo.updatelayoutpan();

      if (parentwidget = dockpanel4fo.basedock) or
        (dockpanel4fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel4fo.Visible then
          dockpanel4fo.updatelayoutpan();

      if (parentwidget = dockpanel5fo.basedock) or
        (dockpanel5fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel5fo.Visible then
          dockpanel5fo.updatelayoutpan();
    end;
  end;
end;

procedure tspectrum1fo.onformcreated(const Sender: TObject);
begin
  tchartleft.traces[0].chartkind  := tck_bar;
  tchartright.traces[0].chartkind := tck_bar;
end;

procedure tspectrum1fo.onshowspec(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue = False then
    if tag = 0 then
      songplayerfo.resetspectrum()
    else if tag = 1 then
      songplayer2fo.resetspectrum()
    else if tag = 2 then
      recorderfo.resetspectrum();
end;

procedure tspectrum1fo.crea(const Sender: TObject);
var
  x, i1, childn: integer;
begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;  
 {$endif}

  childn        := 0;

  setlength(boundchildspc, childrencount);
  childn := childrencount;


  for i1 := 0 to childrencount - 1 do
  begin
    boundchildspc[i1].left   := children[i1].left;
    boundchildspc[i1].top    := children[i1].top;
    boundchildspc[i1].Width  := children[i1].Width;
    boundchildspc[i1].Height := children[i1].Height;
    boundchildspc[i1].Name   := children[i1].Name;
  end;


  setlength(boundchildspc, groupbox1.childrencount + childn);


  with groupbox1 do
    for i1 := 0 to groupbox1.childrencount - 1 do
    begin
      boundchildspc[i1 + childn].left   := children[i1].left;
      boundchildspc[i1 + childn].top    := children[i1].top;
      boundchildspc[i1 + childn].Width  := children[i1].Width;
      boundchildspc[i1 + childn].Height := children[i1].Height;
      boundchildspc[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildspc);
  setlength(boundchildspc, length(boundchildspc) + groupbox2.childrencount);

  with groupbox2 do
    for i1 := 0 to groupbox2.childrencount - 1 do
    begin
      boundchildspc[i1 + childn].left   := children[i1].left;
      boundchildspc[i1 + childn].top    := children[i1].top;
      boundchildspc[i1 + childn].Width  := children[i1].Width;
      boundchildspc[i1 + childn].Height := children[i1].Height;
      boundchildspc[i1 + childn].Name   := children[i1].Name;
    end;
end;

procedure tspectrum1fo.changecolors(const Sender: TObject);
begin
end;

procedure tspectrum1fo.changesilver(const Sender: TObject);
begin
end;

end.

