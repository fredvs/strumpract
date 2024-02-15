unit infosd;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  types,
  msethread,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  SysUtils,
  mseapplication,
  fptimer,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  Classes,
  mseclasses,
  mseforms,
  msedock,
  BGRABitmap,
  BGRAAnimatedGif,
  BGRABitmapTypes,
  captionstrumpract,
  mseimage,
  msesimplewidgets,
  msewidgets;

type
  tinfosdfo = class(tdockform)
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
    aimage: TBGRAAnimatedGif;
    PimgPreview: tpaintbox;
    ttimer1: tfptimer;

    tbutton1: TButton;
    procedure onshow(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure onevstart(const Sender: TObject);
    procedure resizein(fontheight: integer);
    procedure oncre(const Sender: TObject);
    procedure onpaintimg(const Sender: twidget; const acanvas: tcanvas);
    procedure loadimagetag(aitag: TStream);
    procedure ondest(const Sender: TObject);
    procedure ontime(Sender: TObject);
    procedure onexec(const Sender: TObject);
   procedure onresize(const sender: TObject);
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
  bounds_cxmin := round(442 * ratio);
  bounds_cymin := round(216 * ratio);

  if (parentwidget <> nil) then
  begin
    bounds_cxmax := bounds_cxmin;
    bounds_cymax := bounds_cymin;
  end
  else
  begin
    bounds_cxmax := 0;
    bounds_cymax := 0;
  end;

  font.Height := fontheight;

  infofile.frame.font.Height   := round(ratio * 10);
  infoname.frame.font.Height   := infofile.frame.font.Height;
  infoname.frame.font.Height   := infofile.frame.font.Height;
  infoartist.frame.font.Height := infofile.frame.font.Height;
  infoalbum.frame.font.Height  := infofile.frame.font.Height;
  infocom.frame.font.Height    := infofile.frame.font.Height;
  infoyear.frame.font.Height   := infofile.frame.font.Height;
  infotag.frame.font.Height    := infofile.frame.font.Height;
  tracktag.frame.font.Height   := infofile.frame.font.Height;
  inforate.frame.font.Height   := infofile.frame.font.Height;
  infochan.frame.font.Height   := infofile.frame.font.Height;
  infolength.frame.font.Height := infofile.frame.font.Height;
  infobpm.frame.font.Height    := infofile.frame.font.Height;

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

  PimgPreview.left   := round(217 * ratio);
  PimgPreview.Height := round(216 * ratio);
  PimgPreview.Width  := round(216 * ratio);

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
end;

procedure tinfosdfo.loadimagetag(aitag: TStream);
var
ordir : msestring;
begin
  ttimer1.Enabled  := False;
  tbutton1.Visible := False;
  if Assigned(aimage) then
    aimage.Free;
    
   if aitag = nil then
   begin 
   //tlabel2.visible := true;
   ordir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));
  if fileexists(ordir + directoryseparator +'images' + directoryseparator + 'noimagetag.png')
  then
  begin
  aimage := TBGRAAnimatedGif.Create(ordir + directoryseparator +'images' + directoryseparator + 'noimagetag.png');  
  PimgPreview.Visible := True;
  PimgPreview.invalidate;
   if aimage.Count > 1 then
  begin
    tbutton1.Caption := '||';
    tbutton1.Visible := True;
    ttimer1.Enabled  := True;
  end;
  end;
  end
  else
  begin
  //tlabel2.visible := false;
  aimage := TBGRAAnimatedGif.Create(aitag);
  PimgPreview.Visible := True;
  PimgPreview.invalidate;
  if aimage.Count > 1 then
  begin
    tbutton1.Caption := '||';
    tbutton1.Visible := True;
    ttimer1.Enabled  := True;
  end;
  
  end;

end;

procedure tinfosdfo.ontime(Sender: TObject);
var
interva : integer;
begin
  ttimer1.Enabled  := false;
  PimgPreview.invalidate;
  interva := aImage.TimeUntilNextImageMs; 
  if interva < 15 then interva := 15;
  ttimer1.interval := interva;
  if tbutton1.Caption = '||' then ttimer1.Enabled := True;
end;

procedure tinfosdfo.onpaintimg(const Sender: twidget; const acanvas: tcanvas);
var
  theMemBitmap: TBGRABitmap;
begin
  //theMemBitmap := TBGRABitmap.Create(PimgPreview.Width,PimgPreview.Height,BGRA(255, 192, 0)); 
  theMemBitmap := aimage.MemBitmap.Resample(PimgPreview.Width, PimgPreview.Height, rmFineResample) as TBGRABitmap;
  theMemBitmap.Rectangle(0, 0, PimgPreview.Width, PimgPreview.Height, BGRA(255, 192, 0), BGRA(180, 180, 180, 255), dmDrawWithTransparency, 8192);
  theMemBitmap.draw(acanvas, 0, 0, True);
  theMemBitmap.Free;
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

  ttimer1          := tfptimer.Create(nil);
  ttimer1.OnTimer  := @ontime;
  ttimer1.interval := 15;
  ttimer1.Enabled  := False;

end;

procedure tinfosdfo.ondest(const Sender: TObject);
begin
  if Assigned(aimage) then
    aimage.Free;
  ttimer1.Enabled := False;
  ttimer1.Free;
end;

procedure tinfosdfo.onexec(const Sender: TObject);
begin
  if tbutton1.Caption = '||' then
  begin
    tbutton1.Caption := '>';
    ttimer1.Enabled  := False;
  end
  else
  begin
    tbutton1.Caption := '||';
    ttimer1.Enabled  := True;
  end;

end;

procedure tinfosdfo.onresize(const sender: TObject);
begin
{
  PimgPreview.left   := (width div 2)-1;
  PimgPreview.Height := Height;
  PimgPreview.Width  := width div 2;
}
end;

end.

