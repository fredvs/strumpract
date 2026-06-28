unit waveform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,Math,
 mseact,msegui,SysUtils,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,
 msedock,msegraphedits,mseificomp,mseificompglob,mseifiglob,msescrollbar,
 msebitmap,msesimplewidgets,msewidgets,msegrids,msedataedits,msedropdownlist,
 mseedit,msestatfile,msetimer,msestream;

type
  twavefo = class(tdockform)
    sliderimage: tbitmapcomp;
    ttimer1: ttimer;
    echelle: tstringgrid;
    tmainmenu1: tmainmenu;
   trackbar1: tslider;
   tfacebuttonslider: tfacecomp;
   panelwave: tpaintbox;
    procedure onresiz(const Sender: TObject);
    procedure ontimer(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onvisiblech(const Sender: TObject);
    procedure faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
    procedure doechelle(fontsiz : integer);
    procedure onzoom(const Sender: TObject);
    procedure pageup(const Sender: TObject);
    procedure pagedown(const Sender: TObject);
    procedure onsliderchange(const Sender: TObject);
    procedure onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
    procedure oncreated(const Sender: TObject);
    procedure crea(const Sender: TObject);
    procedure onresiztimer(const Sender: TObject);
    procedure onresizfont(fontsiz : integer);
    procedure onmouseevw(const sender: twidget;
               var ainfo: mouseeventinfoty);


   procedure onaferexmenu(const sender: TObject);
  end;

var
  wavefo: twavefo;
  wavefo2: twavefo;
  waveforec: twavefo;
  zoomint1: integer = 1;
  zoomint2: integer = 1;
  zoomintrec: integer = 1;

implementation

uses
  captionstrumpract,
  songplayer,
  recorder,
  main,
  uos_flat,
  dockpanel1,
  waveform_mfm;
  
procedure twavefo.onresizfont(fontsiz : integer);
begin
font.height := fontsiz;
tmainmenu1.menu.font.height := fontsiz;
tmainmenu1.menu.fontactive.height := fontsiz; 
trackbar1.height := height - round(17 * fontsiz / 12) ;
doechelle(fontsiz);
invalidate;
end;

procedure twavefo.faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin

  point1.x := arect.x  + (arect.cx div 2 );
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  Canvas.drawline(point1, point2, cl_red);

end;

procedure twavefo.onresiz(const Sender: TObject);
begin
  if ttimer1.Enabled then
    ttimer1.restart // to reset
  else
    ttimer1.Enabled := True;
end;

procedure twavefo.onresiztimer(const Sender: TObject);
var
ratioft : double;
begin

 ratioft := fontheightused/12;

  if tag <> 2 then
    trackbar1.Width := Width - 15;

  if ((tag = 0) and (Assigned(songplayerfo))) or ((tag = 1) and (Assigned(songplayer2fo))) or ((tag = 2) and (Assigned(recorderfo)) and (islive = False)) then
  begin
    doechelle(fontheightused);
    echelle.Visible  := True;
    trackbar1.Height := Height - echelle.Height;
    echelle.top := trackbar1.bottom -1;
  end
  else if ((tag = 2) and (Assigned(recorderfo)) and (islive = True)) then
  begin
    trackbar1.Width  := waveforec.Width - 11;
    trackbar1.Height := waveforec.Height - round(18 * ratioft);
    echelle.Visible  := False;
  end;

  onzoom(Sender);

end;

procedure twavefo.doechelle(fontsiz : integer);
var
  i, totsec: integer;
  milisec: string;
  echsec: float;
begin
  totsec := 0;

  if (tag = 0) and (Assigned(songplayerfo)) and
    (hascue = True) and (totsec1 > 0) then
    totsec := totsec1;

  if (tag = 1) and (Assigned(songplayer2fo)) and
    (hascue2 = True) and (totsec2 > 0) then
    totsec := totsec2;

  echelle.height := round(17 * fontsiz / 12);
  echelle.Width    := trackbar1.Width;
  trackbar1.Height := Height - echelle.Height - round(18 * fontsiz / 12) ;
  echelle.top := trackbar1.bottom -1;
  echelle.datacols.Width := 24;
  echelle.datarowheight  := echelle.Height;
  echelle.datacols.Count := (echelle.Width div 24) + 1;
  echelle.font.height := round(9 * fontsiz / 12);
  
  echsec := totsec / ((echelle.Width / 25.15)); // yes, I know, it is strange...

  i := 0;

  while i < echelle.datacols.Count do
  begin
    echelle.datacols[i].font.height := round(9 * fontsiz / 12); 
    echelle.datacols[i].fontselect.height := round(9 * fontsiz / 12);
 
    if trunc(echsec * (i + 1)) mod 60 > 9 then

      milisec := IntToStr((trunc(echsec * (i + 1)) mod 60))
    else
      milisec := '0' + IntToStr((trunc(echsec * (i + 1)) mod 60));

    echelle[i][0] := utf8decode(IntToStr(trunc(echsec * (i + 1) / 60)) + '.' + milisec);

    //  echelle.datacols[i].color := cl_gray;

    Inc(i);
  end;
end;

procedure twavefo.ontimer(const Sender: TObject);
begin

  if (tag = 0) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (tag = 1) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);

end;

procedure twavefo.onfloat(const Sender: TObject);
begin
  bounds_cxmax := 0;
  bounds_cymax := 0;
end;

procedure twavefo.ondock(const Sender: TObject);
begin
  bounds_cymax := 128;
  bounds_cxmax := 442;
end;

procedure twavefo.onvisiblech(const Sender: TObject);
begin

  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and
    (Assigned(dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if tag = 0 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwave1']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwave1']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    if tag = 1 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwave2']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwave2']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    if tag = 2 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwaverec']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_mainfo[Ord(ma_recorder)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showwaverec']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_waveform)] + ' ' + lang_mainfo[Ord(ma_recorder)];

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

procedure twavefo.onzoom(const Sender: TObject);
var
  rect1: rectty;
  ratioft : double;
begin

  ratioft := fontheightused/12;

  if as_checked in tmainmenu1.menu[0].state then
  begin

    rect1 := application.screenrect(window);

    if tmenuitem(Sender).tag = 0 then
      trackbar1.Width := Width - 10;

    if (tag = 0) and (tmenuitem(Sender).tag = 1) and (trackbar1.Width * 2 < Inputlength1 div 64) and
      ((trackbar1.Width * 2) div rect1.cx < 16) then
      trackbar1.Width := trackbar1.Width * 2;

    if (tag = 1) and (tmenuitem(Sender).tag = 1) and (trackbar1.Width * 2 < Inputlength2 div 64) and
      ((trackbar1.Width * 2) div rect1.cx < 16) then
      trackbar1.Width := trackbar1.Width * 2;

    if (tag = 0) and (tmenuitem(Sender).tag = 2) and (trackbar1.Width div 2 > Width - 30) then
      trackbar1.Width := trackbar1.Width div 2;

    if (tag = 1) and (tmenuitem(Sender).tag = 2) and (trackbar1.Width div 2 > Width - 30) then
      trackbar1.Width := trackbar1.Width div 2;

  end;

  if (tag = 0) then
    if (trackbar1.Width div Width) + 1 = 31 then
    begin
      zoomint1 := (trackbar1.Width div Width) + 2;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint1));
    end
    else
    begin
      zoomint1 := (trackbar1.Width div Width) + 1;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint1));
    end;

  if (tag = 1) then
    if (trackbar1.Width div Width) + 1 = 31 then
    begin
      zoomint2 := (trackbar1.Width div Width) + 2;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint2));
    end
    else
    begin
      zoomint2 := (trackbar1.Width div Width) + 1;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint2));
    end;

  if (tag = 0) or (tag = 1) then
    doechelle(fontheightused);

  if (tag = 0) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (tag = 1) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);

          
  if trackbar1.width > width then
   trackbar1.height := height - echelle.height - round(30 * ratioft)
   else trackbar1.height := height - echelle.height - round(18 * ratioft);;
   
   echelle.top := trackbar1.bottom -1;

end;

procedure twavefo.pageup(const Sender: TObject);
begin
  container.frame.sbhorz.pageup;
end;

procedure twavefo.pagedown(const Sender: TObject);
begin
  container.frame.sbhorz.pagedown;
end;

procedure twavefo.onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
begin
  onsliderchange(Sender);

  if (tag = 0) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onafterev(Sender, akind, avalue);

  if (tag = 1) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onafterev(Sender, akind, avalue);
end;

procedure twavefo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if trackbar1.clicked then
  begin

    if (tag = 0) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    begin
      temptime := tottime1 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      songplayerfo.lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

    if (tag = 1) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    begin
      temptime := tottime2 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      songplayer2fo.lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

  end;
end;

procedure twavefo.oncreated(const Sender: TObject);
begin
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);
  if (parentwidget = nil) then
  begin
    bounds_cxmax := 0;
    bounds_cymax := 0;
  end
  else
  begin
    bounds_cxmax := fowidth;
    bounds_cymax := wavefoheight;
    bounds_cxmin := fowidth;
    bounds_cymin := wavefoheight;
    Width        := fowidth;
    Height       := wavefoheight;
  end;
end;

procedure twavefo.crea(const Sender: TObject);
begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;  
 {$endif}
end;

procedure twavefo.onmouseevw(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
  if ainfo.eventkind = ek_buttonrelease then
    begin
    if tag = 0 then
    begin
     uos_InputSeek(theplayer, Inputindex1, trunc(ainfo.pos.x / panelwave.width * Inputlength1));
      songplayerfo.InitDrawLive();
      songplayerfo.InitDrawLivewav();
    end;
    
    if tag = 1 then
    begin
     uos_InputSeek(theplayer2, Inputindex2, trunc(ainfo.pos.x / panelwave.width * Inputlength2));
      songplayer2fo.InitDrawLive();
      songplayer2fo.InitDrawLivewav();
    end;
    end;
end;

procedure twavefo.onaferexmenu(const sender: TObject);
begin
 if (as_checked in tmainmenu1.menu[0].state) then
 begin
trackbar1.visible := true;
echelle.visible := true; 
end else
begin
trackbar1.visible := false;
echelle.visible := false; 
end;

if (tag = 0) and (panelwave.visible = true) then songplayerfo.InitDrawLivewav();
if (tag = 1) and (panelwave.visible = true) then songplayer2fo.InitDrawLivewav();

end;


end.

