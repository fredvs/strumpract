unit infosd;

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
  captionstrumpract,
  mseimage,
  msesimplewidgets,
  msewidgets;

type
  tinfosdfo = class(tdockform)
    imgPreview: timage;
    infolength: tlabel;
    infobpm: tlabel;
    tracktag: tlabel;
    infochan: tlabel;
    inforate: tlabel;
    infotag: tlabel;
    infoyear: tlabel;
    infocom: tlabel;
    infoalbum: tlabel;
    infoartist: tlabel;
    infoname: tlabel;
    infofile: tlabel;
    tlabel2: tlabel;
    procedure onshow(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure onevstart(const Sender: TObject);
    procedure resizein(fontheight: integer);
    procedure oncre(const Sender: TObject);
  end;

var
  infosdfo, infosdfo2: tinfosdfo;

implementation

uses
  main,
  dockpanel1,
  infosd_mfm;

var
  boundchildin: array of boundchild;

procedure tinfosdfo.resizein(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cx    := round(442 * ratio);
  bounds_cxmin := bounds_cx;
  bounds_cy    := round(216 * ratio);
  bounds_cymin := bounds_cy;
  font.Height  := fontheight;

  frame.grip_size := round(8 * ratio);

  for i1 := 0 to childrencount - 1 do
    for i2 := 0 to length(boundchildin) - 1 do
      if children[i1].Name = boundchildin[i2].Name then
      begin
        if children[i1] is tlabel then
          tlabel(children[i1]).font.Height := fontheightused;
        children[i1].left   := round(boundchildin[i2].left * ratio);
        children[i1].top    := round(boundchildin[i2].top * ratio);
        children[i1].Width  := round(boundchildin[i2].Width * ratio);
        children[i1].Height := round(boundchildin[i2].Height * ratio);
      end;

end;

procedure tinfosdfo.onshow(const Sender: TObject);
begin
  if (isactivated = True) and (Assigned(mainfo)) then
  begin

    if tag = 0 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showinfos1']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_infosfo[Ord(in_infosfo)] + ' 1'
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showinfos1']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_infosfo[Ord(in_infosfo)] + ' 1';

    if tag = 1 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showinfos2']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_infosfo[Ord(in_infosfo)] + ' 2'
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showinfos2']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_infosfo[Ord(in_infosfo)] + ' 2';


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

procedure tinfosdfo.ondock(const Sender: TObject);
var
  ratio: double;
begin
  ratio        := fontheightused / 12;
  bounds_cxmax := round(442 * ratio);
  bounds_cxmin := round(442 * ratio);
  bounds_cymax := round(216 * ratio);
  bounds_cymin := round(216 * ratio);
  bounds_cx    := round(442 * ratio);
  bounds_cy    := round(216 * ratio);
end;

procedure tinfosdfo.onfloat(const Sender: TObject);
var
  ratio: double;
begin
  ratio        := fontheightused / 12;
  bounds_cxmax := 0;
  bounds_cxmin := round(442 * ratio);
  bounds_cymax := 0;
  bounds_cymin := round(216 * ratio);
  bounds_cx    := round(442 * ratio);
  bounds_cy    := round(216 * ratio);
end;

procedure tinfosdfo.onevstart(const Sender: TObject);
begin
  if parentwidget = nil then
    onfloat(Sender)
  else
    ondock(Sender);
  resizein(fontheightused);
end;

procedure tinfosdfo.oncre(const Sender: TObject);
var
  i1: integer;
begin
  setlength(boundchildin, childrencount);

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildin[i1].left   := children[i1].left;
    boundchildin[i1].top    := children[i1].top;
    boundchildin[i1].Width  := children[i1].Width;
    boundchildin[i1].Height := children[i1].Height;
    boundchildin[i1].Name   := children[i1].Name;
  end;

end;

end.

