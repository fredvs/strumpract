unit waveform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 mseact,msegui,SysUtils, msegraphics, msegraphutils, mseevent, mseclasses,
 mseforms,msedock,msegraphedits, mseificomp, mseificompglob, mseifiglob,
 msescrollbar,msebitmap,msetimer, msesimplewidgets, msewidgets, msegrids,
 msedataedits,msedropdownlist,mseedit,msestatfile,msestream;

type
  twavefo = class(tdockform)
    sliderimage: tbitmapcomp;
    ttimer1: ttimer;
    echelle: tstringgrid;
    trackbar1: tslider;
    tfacebuttonslider: tfacecomp;
   tmainmenu1: tmainmenu;
    procedure onresiz(const Sender: TObject);
    procedure ontimer(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onvisiblech(const Sender: TObject);
    procedure faceafterpaintbut(const Sender: tcustomface; const canvas: tcanvas;
      const arect: rectty);

    procedure doechelle(const Sender: TObject);
   procedure onzoom(const sender: TObject);
   procedure pageup(const sender: TObject);
   procedure pagedown(const sender: TObject);
  
  end;

var
  wavefo: twavefo;
  wavefo2: twavefo;
 
implementation

uses
  songplayer, main, dockpanel1, waveform_mfm;

procedure twavefo.faceafterpaintbut(const Sender: tcustomface;
  const canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin
  // point1.x := arect.x + (arect.cx div 2);
  point1.x := 2;
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  canvas.drawline(point1, point2, cl_red);

end;


procedure twavefo.onresiz(const Sender: TObject);
begin

 trackbar1.width := width -15;
 
 trackbar1.height := height -echelle.height ;
  
  doechelle(nil);

  ttimer1.Enabled := False;

  ttimer1.Enabled := True;

end;

procedure twavefo.doechelle(const Sender: TObject);
var
  i, x, y, z, totsec: integer;
  echsec: float;
begin
  totsec := 0;

  if (Caption = 'Wave Player 1') then
    if (assigned(songplayerfo)) then
      if (hascue = True) and (totsec1 > 0) then
        totsec := totsec1;

  if (Caption = 'Wave Player 2') then
    if (assigned(songplayer2fo)) then
      if (hascue2 = True) and (totsec2 > 0) then
        totsec := totsec2;

  echelle.Height := 16;
  echelle.width :=  trackbar1.width ;
  trackbar1.Height := Height - echelle.Height - 20;

  echelle.datacols.Width := 24;
  echelle.datarowheight := echelle.Height;
  echelle.datacols.Count := (echelle.Width div 24);

  echsec := totsec / ((echelle.Width / 24) - 1);

  i := 0;
  x := 0;
  y := 0;

  // if assigned(mainfo) then mainfo.caption := inttostr(totsec) ;

  while i < echelle.datacols.Count do
  begin
   
    echelle[i][0] := IntToStr(trunc(echsec * (i + 1) / 60)) + '.' +
      IntToStr((trunc(echsec * (i + 1)) mod 60));

   //  if assigned(mainfo) then mainfo.caption := inttostr((trunc(echsec) mod 60)) ;

    echelle.datacols[i].color := cl_gray;
    Inc(i);
  end;
end;


procedure twavefo.ontimer(const Sender: TObject);
begin
  if (Caption = 'Wave Player 1') and (hascue = True) and (totsec1 > 0) and
    (assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (Caption = 'Wave Player 2') and (hascue2 = True) and (totsec2 > 0) and
    (assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);

  ttimer1.Enabled := False;
end;

procedure twavefo.onfloat(const Sender: TObject);
begin
  bounds_cxmax := 0;
  bounds_cymax := 0;
end;

procedure twavefo.ondock(const Sender: TObject);
begin
  bounds_cymax := 128;
end;

procedure twavefo.onvisiblech(const Sender: TObject);
begin
 
if (assigned(mainfo)) and (assigned(dockpanel1fo)) and 
(assigned(dockpanel2fo)) and (assigned(dockpanel3fo)) then begin
  if (Caption = 'Wave Player 1') then
    if Visible then
      mainfo.tmainmenu1.menu[3].submenu[11].Caption := ' Hide WaveForm 1 '
    else
      mainfo.tmainmenu1.menu[3].submenu[11].Caption := ' Show WaveForm 1 ';

  if (Caption = 'Wave Player 2') then
    if Visible then
      mainfo.tmainmenu1.menu[3].submenu[12].Caption := ' Hide WaveForm 2 '
    else
      mainfo.tmainmenu1.menu[3].submenu[12].Caption := ' Show WaveForm 2 ';

  mainfo.updatelayout();


  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayout();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayout();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayout();
    
 end; 
    
end;

procedure twavefo.onzoom(const sender: TObject);
var
rect1: rectty;
begin

 if as_checked in tmainmenu1.menu[0].state then begin
 
  rect1:= application.screenrect(window);

if tmenuitem(sender).tag = 0 then
trackbar1.width := width - 10;

 if (Caption = 'Wave Player 1') and (tmenuitem(sender).tag = 1) 
 and (trackbar1.width * 2 < Inputlength1 div 32) 
and (trackbar1.width div rect1.cx < 8) then
begin
trackbar1.width := trackbar1.width * 2;
end;

 if (Caption = 'Wave Player 2') and (tmenuitem(sender).tag = 1)
 and (trackbar1.width * 2 < Inputlength2 div 4) 
 and (trackbar1.width div rect1.cx < 8) then
begin
trackbar1.width := trackbar1.width * 2;
end;

if (Caption = 'Wave Player 1') and (tmenuitem(sender).tag = 2) 
and (trackbar1.width div 2 >  width -30) then
begin
trackbar1.width := trackbar1.width div 2 ;
end;

if (Caption = 'Wave Player 2') and (tmenuitem(sender).tag = 2) 
and (trackbar1.width div 2 >  width -30) then
begin
trackbar1.width := trackbar1.width div 2 ;
end;
end;


if (trackbar1.width div width) +1 = 31 then
tmainmenu1.menu[2].caption := ' Now=X' + 
     IntToStr((trackbar1.width div width)+2) else
tmainmenu1.menu[2].caption := ' Now=X' + 
     IntToStr((trackbar1.width div width)+1) ;     
     
 doechelle(sender);

  if (Caption = 'Wave Player 1') and (hascue = True) and (totsec1 > 0) and
    (assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (Caption = 'Wave Player 2') and (hascue2 = True) and (totsec2 > 0) and
    (assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);
    
end;

procedure twavefo.pageup(const sender: TObject);
begin
container.frame.sbhorz.pageup ; 
//container.frame.scrollpos_x := 300;
end;

procedure twavefo.pagedown(const sender: TObject);
begin
container.frame.sbhorz.pagedown ;
end;


end.
