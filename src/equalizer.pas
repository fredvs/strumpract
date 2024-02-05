unit equalizer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 Classes,ctypes,SysUtils,msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,
 msestat,msemenus,msegui,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,
 msedock,msegraphedits,mseificomp,mseificompglob,mseifiglob,msescrollbar,
 msesimplewidgets,msewidgets,msechart,msedispwidgets,mserichstring,
 msefiledialogx,msestatfile,msebitmap,mseimage;

type
  tasliders = array[1..20] of tslider;
  tabuttons = array[1..20] of TButton;

type
  tequalizerfo = class(tdockform)
    groupbox1: tgroupbox;
    tstringdisp2: tstringdisp;
    tslider2: tslider;
    tbutton2: TButton;
    tstringdisp3: tstringdisp;
    tslider3: tslider;
    tbutton3: TButton;
    tstringdisp4: tstringdisp;
    tslider4: tslider;
    tbutton4: TButton;
    tstringdisp5: tstringdisp;
    tslider5: tslider;
    tbutton5: TButton;
    tstringdisp6: tstringdisp;
    tslider6: tslider;
    tbutton6: TButton;
    tstringdisp7: tstringdisp;
    tslider7: tslider;
    tbutton7: TButton;
    tstringdisp8: tstringdisp;
    tslider8: tslider;
    tbutton8: TButton;
    tstringdisp9: tstringdisp;
    tslider9: tslider;
    tbutton9: TButton;
    tstringdisp10: tstringdisp;
    tslider10: tslider;
    tbutton10: TButton;
    groupbox2: tgroupbox;
    tstringdisp11: tstringdisp;
    tslider11: tslider;
    tbutton11: TButton;
    tstringdisp12: tstringdisp;
    tslider12: tslider;
    tbutton12: TButton;
    tstringdisp13: tstringdisp;
    tslider13: tslider;
    tbutton13: TButton;
    tstringdisp14: tstringdisp;
    tslider14: tslider;
    tbutton14: TButton;
    tstringdisp15: tstringdisp;
    tslider15: tslider;
    tbutton15: TButton;
    tstringdisp16: tstringdisp;
    tslider16: tslider;
    tbutton16: TButton;
    tstringdisp17: tstringdisp;
    tslider17: tslider;
    tbutton17: TButton;
    tstringdisp18: tstringdisp;
    tslider18: tslider;
    tbutton18: TButton;
    tstringdisp19: tstringdisp;
    tslider19: tslider;
    tbutton19: TButton;
    tstringdisp20: tstringdisp;
    tslider20: tslider;
    tbutton20: TButton;
    fond: tstringdisp;
    loadset: TButton;
    saveset: TButton;
    tstringdisp22: tstringdisp;
    tslider1: tslider;
    tbutton1: TButton;
    EQEN: tbooleanedit;
   tfacebuttonslider: tfacecomp;
    procedure oncrea(const Sender: TObject);
    procedure onchangeslider(const Sender: TObject);
    procedure onchangeall();
    procedure created(const Sender: TObject);
    procedure onexecbut(const Sender: TObject);
    procedure changenab(const Sender: TObject);
    procedure onvisiblechange(const Sender: TObject);
    procedure loadlist(const Sender: TObject);
    procedure savelist(const Sender: TObject);
    procedure resizeeq(fontheight: integer);
    procedure faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);

  end;

var
  equalizerfo1: tequalizerfo;
  equalizerfo2: tequalizerfo;
  equalizerforec: tequalizerfo;
  iscreated: Boolean = False;

implementation

uses
  captionstrumpract,
  commander,
  songplayer,
  recorder,
  main,
  dockpanel1,
  status,
  dialogfiles,
  equalizer_mfm;

var
  boundchildeq: array of boundchild;
  
procedure tequalizerfo.faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
 
begin

  point1.x := arect.x + 1;
  point1.y := arect.y ;
  point2.x := arect.x + arect.cx - 2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $aDaDaD) else
  Canvas.drawline(point1, point2, cl_white);
  
  point1.x := arect.x + 1 ;
  point1.y := arect.y + 1;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A8A8A8);
  
  point1.x := arect.x + 1 ;
  point1.y := arect.y + 2;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A8A8A8);
    
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 3;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A8A8A8);
    
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 4;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A8A8A8);
    
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 5;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $929292) else
  Canvas.drawline(point1, point2, $CFCFCF);
    
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 6;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $929292) else
  Canvas.drawline(point1, point2, $CFCFCF);
    
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 7;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, cl_black) else
  Canvas.drawline(point1, point2, $747474);
  
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 8;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $FF8C00) else // orange
  Canvas.drawline(point1, point2, $F7BB71);
  
  point1.x := arect.x  + 1;
  point1.y := arect.y + 9;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, cl_black) else
  Canvas.drawline(point1, point2, $747474);
  
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 10;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $A3A3A3) else
  Canvas.drawline(point1, point2, $D2D2D2);
  
  point1.x := arect.x  + 1 ;
  point1.y := arect.y + 11;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $A3A3A3) else
  Canvas.drawline(point1, point2, $D2D2D2);
  
  point1.x := arect.x  + 1;
  point1.y := arect.y + 12;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A7A7A7);
   
  point1.x := arect.x  + 1;
  point1.y := arect.y + 13;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A7A7A7);
  
  point1.x := arect.x  + 1;
  point1.y := arect.y + 14;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A7A7A7);
 
  point1.x := arect.x  + 1;
  point1.y := arect.y + 15;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $6E6E6E) else
  Canvas.drawline(point1, point2, $A7A7A7);
  
  point1.x := arect.x  + 1;
  point1.y := arect.y + arect.cy -1;
  point2.x := arect.x + arect.cx -2 ;
  point2.y := point1.y;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $606060) else
  Canvas.drawline(point1, point2, $808080);
   
  // vertical
  
  point1.x := arect.x + 1;
  point1.y := arect.y ;
  point2.x := point1.x;
  point2.y := point1.y + arect.cy -2;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $aDaDaD) else
  Canvas.drawline(point1, point2, cl_white);
  
  point1.x := arect.x + arect.cx -2 ;
  point1.y := arect.y +1 ;
  point2.x := point1.x;
  point2.y := point1.y + arect.cy;;
  if mainfo.typecolor.Value = 2 then
  Canvas.drawline(point1, point2, $606060) else
  Canvas.drawline(point1, point2, $808080);
end;  

procedure tequalizerfo.resizeeq(fontheight: integer);
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
  eqen.frame.font.Height := fontheight;
  eqen.frame.font.color := font.color;
  eqen.frame.font.Height := fontheight;
  eqen.top        := round(2 * ratio);
  saveset.font.Height := fontheight;
  saveset.font.color := font.color;
  saveset.Width   := round(62 * ratio);
  saveset.Height  := round(17 * ratio);
  saveset.left    := round(264 * ratio);
  loadset.font.Height := fontheight;
  loadset.font.color := font.color;
  loadset.Width   := round(62 * ratio);
  loadset.Height  := round(17 * ratio);
  loadset.left    := round(330 * ratio);

  groupbox1.font.color  := font.color;
  groupbox2.font.color  := font.color;
  groupbox1.font.Height := round(8 * ratio);
  groupbox2.font.Height := groupbox1.font.Height;

  groupbox1.left  := round(2 * ratio);
  groupbox1.Width := round(216 * ratio);
  groupbox2.left  := round(214 * ratio);
  groupbox2.Width := round(218 * ratio);

  with groupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildeq) - 1 do
        if groupbox1.children[i1].Name = boundchildeq[i2].Name then
        begin
          groupbox1.children[i1].left   := round(boundchildeq[i2].left * ratio);
          groupbox1.children[i1].top    := round(boundchildeq[i2].top * ratio);
          groupbox1.children[i1].Width  := round(boundchildeq[i2].Width * ratio);
          groupbox1.children[i1].Height := round(boundchildeq[i2].Height * ratio);
        end;

  with groupbox2 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildeq) - 1 do
        if groupbox2.children[i1].Name = boundchildeq[i2].Name then
        begin
          groupbox2.children[i1].left   := round(boundchildeq[i2].left * ratio);
          groupbox2.children[i1].top    := round(boundchildeq[i2].top * ratio);
          groupbox2.children[i1].Width  := round(boundchildeq[i2].Width * ratio);
          groupbox2.children[i1].Height := round(boundchildeq[i2].Height * ratio);
        end;
end;

procedure tequalizerfo.oncrea(const Sender: TObject);
var
  x, i1, childn: integer;
  asliders: tasliders;
  abuttons: tabuttons;
begin
  windowopacity := 0;
  asliders[1]   := tslider1;
  asliders[2]   := tslider2;
  asliders[3]   := tslider3;
  asliders[4]   := tslider4;
  asliders[5]   := tslider5;
  asliders[6]   := tslider6;
  asliders[7]   := tslider7;
  asliders[8]   := tslider8;
  asliders[9]   := tslider9;
  asliders[10]  := tslider10;
  asliders[11]  := tslider11;
  asliders[12]  := tslider12;
  asliders[13]  := tslider13;
  asliders[14]  := tslider14;
  asliders[15]  := tslider15;
  asliders[16]  := tslider16;
  asliders[17]  := tslider17;
  asliders[18]  := tslider18;
  asliders[19]  := tslider19;
  asliders[20]  := tslider20;


  abuttons[1]  := tbutton1;
  abuttons[2]  := tbutton2;
  abuttons[3]  := tbutton3;
  abuttons[4]  := tbutton4;
  abuttons[5]  := tbutton5;
  abuttons[6]  := tbutton6;
  abuttons[7]  := tbutton7;
  abuttons[8]  := tbutton8;
  abuttons[9]  := tbutton9;
  abuttons[10] := tbutton10;
  abuttons[11] := tbutton11;
  abuttons[12] := tbutton12;
  abuttons[13] := tbutton13;
  abuttons[14] := tbutton14;
  abuttons[15] := tbutton15;
  abuttons[16] := tbutton16;
  abuttons[17] := tbutton17;
  abuttons[18] := tbutton18;
  abuttons[19] := tbutton19;
  abuttons[20] := tbutton20;

  for x := 1 to 20 do
  begin
    asliders[x].tag       := x;
    asliders[x].onchange  := @onchangeslider;
    abuttons[x].tag       := x;
    abuttons[x].onexecute := @onexecbut;
    abuttons[x].hint      := ' Reset to 0 ';
  end;

  childn := 0;

  setlength(boundchildeq, childrencount);
  childn := childrencount;


  for i1 := 0 to childrencount - 1 do
  begin
    boundchildeq[i1].left   := children[i1].left;
    boundchildeq[i1].top    := children[i1].top;
    boundchildeq[i1].Width  := children[i1].Width;
    boundchildeq[i1].Height := children[i1].Height;
    boundchildeq[i1].Name   := children[i1].Name;
  end;


  setlength(boundchildeq, groupbox1.childrencount + childn);


  with groupbox1 do
    for i1 := 0 to groupbox1.childrencount - 1 do
    begin
      boundchildeq[i1 + childn].left   := children[i1].left;
      boundchildeq[i1 + childn].top    := children[i1].top;
      boundchildeq[i1 + childn].Width  := children[i1].Width;
      boundchildeq[i1 + childn].Height := children[i1].Height;
      boundchildeq[i1 + childn].Name   := children[i1].Name;
    end;

  childn := length(boundchildeq);
  setlength(boundchildeq, length(boundchildeq) + groupbox2.childrencount);

  with groupbox2 do
    for i1 := 0 to groupbox2.childrencount - 1 do
    begin
      boundchildeq[i1 + childn].left   := children[i1].left;
      boundchildeq[i1 + childn].top    := children[i1].top;
      boundchildeq[i1 + childn].Width  := children[i1].Width;
      boundchildeq[i1 + childn].Height := children[i1].Height;
      boundchildeq[i1 + childn].Name   := children[i1].Name;
    end;

end;

procedure tequalizerfo.onchangeall();
var
  x: integer;
  asliders: tasliders;
begin
  asliders[1]  := tslider1;
  asliders[2]  := tslider2;
  asliders[3]  := tslider3;
  asliders[4]  := tslider4;
  asliders[5]  := tslider5;
  asliders[6]  := tslider6;
  asliders[7]  := tslider7;
  asliders[8]  := tslider8;
  asliders[9]  := tslider9;
  asliders[10] := tslider10;
  asliders[11] := tslider11;
  asliders[12] := tslider12;
  asliders[13] := tslider13;
  asliders[14] := tslider14;
  asliders[15] := tslider15;
  asliders[16] := tslider16;
  asliders[17] := tslider17;
  asliders[18] := tslider18;
  asliders[19] := tslider19;
  asliders[20] := tslider20;

  for x := 1 to 20 do
    onchangeslider(asliders[x]);

end;

procedure tequalizerfo.onchangeslider(const Sender: TObject);
var
  avalue, again: cfloat;
  tagsender: integer;
  abutton: TButton;
  astring: msestring;
begin
  if iscreated then
  begin

    tagsender := tslider(Sender).tag;
    avalue    := tslider(Sender).Value;

    if (avalue < 0.52) and (avalue > 0.48) then
    begin
      again   := 1;
      astring := '0';
    end
    else if avalue >= 0.52 then
    begin
      again   := 1 + ((avalue - 0.52) * 4);
      astring := msestring(IntToStr(round(again * 3.5)));
    end
    else
    begin
      again   := (0.48 - avalue);
      if again < 0.2 then
        again := 0;
      astring := msestring('-' + IntToStr(round(again * 20)));
    end;

    case tagsender of
      1: abutton  := tbutton1;
      2: abutton  := tbutton2;
      3: abutton  := tbutton3;
      4: abutton  := tbutton4;
      5: abutton  := tbutton5;
      6: abutton  := tbutton6;
      7: abutton  := tbutton7;
      8: abutton  := tbutton8;
      9: abutton  := tbutton9;
      10: abutton := tbutton10;
      11: abutton := tbutton11;
      12: abutton := tbutton12;
      13: abutton := tbutton13;
      14: abutton := tbutton14;
      15: abutton := tbutton15;
      16: abutton := tbutton16;
      17: abutton := tbutton17;
      18: abutton := tbutton18;
      19: abutton := tbutton19;
      20: abutton := tbutton20;
    end;

    abutton.Caption := astring;

    if tag = 0 then
      if tagsender < 11 then
        songplayerfo.changefrequency(1, tagsender, again, -1)
      else
        songplayerfo.changefrequency(1, tagsender - 10, -1, again);

    if tag = 1 then
      if tagsender < 11 then
        songplayer2fo.changefrequency(2, tagsender, again, -1)
      else
        songplayer2fo.changefrequency(2, tagsender - 10, -1, again);

    if tag = 2 then
      if tagsender < 11 then
        recorderfo.changefrequency(2, tagsender, again, -1)
      else
        recorderfo.changefrequency(2, tagsender - 10, -1, again);

  end;
end;

procedure tequalizerfo.created(const Sender: TObject);
begin
  iscreated := True;
end;

procedure tequalizerfo.onexecbut(const Sender: TObject);
var
  tagsender: integer;
  aslider: tslider;
begin
  if iscreated then
  begin
    tagsender := TButton(Sender).tag;

    case tagsender of
      1: aslider  := tslider1;
      2: aslider  := tslider2;
      3: aslider  := tslider3;
      4: aslider  := tslider4;
      5: aslider  := tslider5;
      6: aslider  := tslider6;
      7: aslider  := tslider7;
      8: aslider  := tslider8;
      9: aslider  := tslider9;
      10: aslider := tslider10;
      11: aslider := tslider11;
      12: aslider := tslider12;
      13: aslider := tslider13;
      14: aslider := tslider14;
      15: aslider := tslider15;
      16: aslider := tslider16;
      17: aslider := tslider17;
      18: aslider := tslider18;
      19: aslider := tslider19;
      20: aslider := tslider20;
    end;

    aslider.Value           := 0.5;
    TButton(Sender).Caption := '0';
  end;
end;

procedure tequalizerfo.changenab(const Sender: TObject);
begin
  onchangeall();
end;

procedure tequalizerfo.onvisiblechange(const Sender: TObject);
begin
  if (isactivated = True) then
  begin

    if tag = 0 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequ1']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequ1']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    if tag = 1 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequ2']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequ2']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    if tag = 2 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequrec']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_mainfo[Ord(ma_recorder)]
      else
        mainfo.tmainmenu1.menu.itembynames(['show', 'showequrec']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_mainfo[Ord(ma_recorder)];

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

procedure tequalizerfo.loadlist(const Sender: TObject);
var
  ordir: msestring;
begin
  ordir := msestring(ExtractFilePath(msestring(ParamStr(0))) + 'equ' + directoryseparator);
  dialogfilesfo.tag := tag;
  dialogfilesfo.Caption := 'Load a Equalizer Settings File';
  dialogfilesfo.list_files.mask := '*.equ';
  dialogfilesfo.list_files.path := ordir;
  dialogfilesfo.selected_file.Text := '';

  if tag < 2 then
    dialogfilesfo.setother.Visible := True
  else
    dialogfilesfo.setother.Visible := False;

  if (mainfo.typecolor.Value = 0) then
  begin
    if tag = 2 then
      dialogfilesfo.list_files.frame.colorclient := cl_ltgray
    else
      dialogfilesfo.list_files.frame.colorclient := $F9FFC2;
  end
  else if (mainfo.typecolor.Value = 1) then
    dialogfilesfo.list_files.frame.colorclient := cl_ltgray
  else
    dialogfilesfo.list_files.frame.colorclient := cl_gray;

  application.ProcessMessages;
  dialogfilesfo.Show;
end;

procedure tequalizerfo.savelist(const Sender: TObject);
begin

  if tag = 0 then
    typstat := 3
  else if tag = 1 then
    typstat := 4
  else
    typstat := 5;

  statusfo.Caption := 'Save Equalizer Settings as';
  statusfo.color   := $A7C9B9;
  statusfo.layoutname.Value := 'MyEqualizerSettings';
  statusfo.layoutname.Visible := True;
  statusfo.activate;
end;

end.

