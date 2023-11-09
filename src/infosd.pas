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
  fptimer,
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
    imgPreview: timage;
    PimgPreview: tpaintbox;

    procedure onshow(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure onevstart(const Sender: TObject);
    procedure resizein(fontheight: integer);
    procedure oncre(const Sender: TObject);
    procedure onpaintimg(const Sender: twidget; const acanvas: tcanvas);
    procedure loadimagetag(aitag: Tstream);
    procedure ondest(const Sender: TObject);

  protected
    thethread: tmsethread;
    function Execute(thread: tmsethread): integer;
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
  countframe: integer = 0;

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

procedure tinfosdfo.loadimagetag(aitag: Tstream);
begin
  //  if Assigned(aimage) then aimage.Free;
  aimage := TBGRAAnimatedGif.Create(aitag);
  
  aimage.BackgroundMode := gbmEraseBackground;
  aimage.EraseColor     := PimgPreview.Color; // assign the actual color of the form

  countframe := aimage.Count;

  imgPreview.Visible  := False;
  PimgPreview.Visible := True;
  
  if Assigned(thethread) then
  begin
    thethread.terminate;
    sleep(10);
  end;

  thethread := tmsethread.Create(@Execute);
  thethread.freeonterminate := True;
end;

procedure tinfosdfo.onpaintimg(const Sender: twidget; const acanvas: tcanvas);
var
  theMemBitmap: TBGRABitmap;
begin
  theMemBitmap := TBGRABitmap.Create(PimgPreview.Width,PimgPreview.Height,BGRA(255, 192, 0)); 
  theMemBitmap := aimage.MemBitmap.Resample(PimgPreview.Width, PimgPreview.Height,rmFineResample) as TBGRABitmap;
  theMemBitmap.Rectangle(0,0,PimgPreview.Width,PimgPreview.Height,BGRA(255, 192, 0),BGRA(150,150,150,255),dmDrawWithTransparency,8192);
  theMemBitmap.draw(acanvas, 0, 0, True);
  theMemBitmap.free;
end;

function tinfosdfo.Execute(thread: tmsethread): integer;
begin
  Result := 0;
  application.queueasynccall(@PimgPreview.invalidate);

  if countframe > 1 then
  begin
    sleep(150);
    repeat
      application.queueasynccall(@PimgPreview.invalidate);
      sleep(150);
    until False;
  end;
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

procedure tinfosdfo.ondest(const Sender: TObject);
begin
 if Assigned(aimage) then
    aimage.Free;
  if Assigned(thethread) then
    thethread.terminate;
end;

end.

