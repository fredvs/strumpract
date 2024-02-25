unit guitars;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  math,
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
  msesimplewidgets,
  msewidgets,
  msegraphedits,
  SysUtils,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msetypes,
  msedispwidgets,
  mserichstring,
  msestrings;

type
  tguitarsfo = class(tdockform)
    tgroupbox1: tgroupbox;
    tgroupbox2: tgroupbox;
    tbutton16: TButton;
    tbutton15: TButton;
    tbutton14: TButton;
    tbutton13: TButton;
    loopbass: tbooleanedit;
    tbutton9: TButton;
    tbutton8: TButton;
    tbutton7: TButton;
    tbutton6: TButton;
    tbutton5: TButton;
    tbutton3: TButton;
    loopguit: tbooleanedit;
    tstringdisp2: tstringdisp;
    tstringdisp3: tstringdisp;
    procedure doguitarstring(const Sender: TObject);
    procedure onvisiblechangeev(const Sender: TObject);
    procedure oncreateguit(const Sender: TObject);
    procedure resizegu(fontheight: integer);
  end;

var
  guitarsfo: tguitarsfo;
  aguitar: array[0..9] of string;
  aguitarisplaying: array[0..9] of Boolean;
  initguit: integer = 1;

implementation

uses
  captionstrumpract,
  uos_flat,
  main,
  dockpanel1,
  config,
  guitars_mfm;

var
  boundchildgu: array of boundchild;

procedure tguitarsfo.resizegu(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := floor(442 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := floor(64 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fontheight;

  frame.grip_size := floor(8 * ratio);

  tgroupbox1.font.Height := fontheight;
  tgroupbox1.font.color  := font.color;
  tgroupbox2.font.Height := fontheight;
  tgroupbox2.font.color  := font.color;
  
  with tgroupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildgu) - 1 do
        if children[i1].Name = boundchildgu[i2].Name then
        begin
          children[i1].left   := floor(boundchildgu[i2].left * ratio);
          children[i1].top    := floor(boundchildgu[i2].top * ratio);
          children[i1].Width  := floor(boundchildgu[i2].Width * ratio);
          children[i1].Height := floor(boundchildgu[i2].Height * ratio);
        end;

  with tgroupbox2 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildgu) - 1 do
        if children[i1].Name = boundchildgu[i2].Name then
        begin
          children[i1].left   := floor(boundchildgu[i2].left * ratio);
          children[i1].top    := floor(boundchildgu[i2].top * ratio);
          children[i1].Width  := floor(boundchildgu[i2].Width * ratio);
          children[i1].Height := floor(boundchildgu[i2].Height * ratio);
        end;
end;

procedure tguitarsfo.doguitarstring(const Sender: TObject);
begin
  //uos_Stop(TButton(Sender).tag + 9);
  if ((loopguit.Value = False) and (TButton(Sender).tag < 7)) or ((loopbass.Value = False) and (TButton(Sender).tag > 6)) then
  begin
    // writeln('Guit no loop init');
    if uos_CreatePlayer(TButton(Sender).tag + 9) then
    begin
      // writeln('OK uos_CreatePlayer ' + inttostr(TButton(Sender).tag + 9));
      if uos_AddFromFile(TButton(Sender).tag + 9, (PChar(aguitar[TButton(Sender).tag - 1])), -1, -1, 1024 * 8) > -1 then
      begin
         // writeln('OK uos_AddFromFile ' + inttostr(TButton(Sender).tag + 9) + ' ' + PChar(aguitar[TButton(Sender).tag - 1]));
          {$if defined(cpuarm)}
        if uos_AddIntoDevOut(TButton(Sender).tag + 9, configfo.devoutcfg.value, 0.3, -1, -1, -1, 1024 * 8, -1) > -1 then
         {$else}
        if uos_AddIntoDevOut(TButton(Sender).tag + 9, configfo.devoutcfg.Value, 0.3, -1, -1, -1, 1024 *8, -1) > -1 then
         {$endif}
          begin
          // writeln('OK uos_AddIntoDevOut ' + inttostr(TButton(Sender).tag + 9));
           sleep(10);
          uos_Play(TButton(Sender).tag + 9);
          // writeln('OK uos_Play ' + inttostr(TButton(Sender).tag + 9));
          end;
      end;
     end; 
  end
  else if (aguitarisplaying[TButton(Sender).tag - 1] = False) then
  begin
    TButton(Sender).face.fade_direction      := gd_up;
    TButton(Sender).face.fade_color.items[1] := cl_ltgreen;

    if uos_CreatePlayer(TButton(Sender).tag + 9) then

       if uos_AddFromFile(TButton(Sender).tag + 9, (PChar(aguitar[TButton(Sender).tag - 1])), -1, -1, 1024 * 8) > -1 then
  
        {$if defined(cpuarm)}
          if uos_AddIntoDevOut(TButton(Sender).tag + 9, configfo.devoutcfg.value, 0.3, -1, -1, -1, 1024 * 8,-1) > -1 then
         {$else}
          if uos_AddIntoDevOut(TButton(Sender).tag + 9, configfo.devoutcfg.value, 0.3, -1, -1, -1, 1024 * 8,-1) > -1 then
          {$endif}
        begin
          application.processmessages;
          uos_Play(TButton(Sender).tag + 9, -1);
          aguitarisplaying[TButton(Sender).tag - 1] := True;
        end;
  end
  else
  begin
    TButton(Sender).face.fade_direction       := gd_down;
    TButton(Sender).face.fade_color.items[1]  := $B0A590;
    aguitarisplaying[TButton(Sender).tag - 1] := False;
  end;
end;

procedure tguitarsfo.onvisiblechangeev(const Sender: TObject);
begin
  if (isactivated = True) then
    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showguitar']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': ' +
        lang_randomnotefo[Ord(ra_tbutton5)]
    else
      mainfo.tmainmenu1.menu.itembynames(['show', 'showguitar']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
        lang_randomnotefo[Ord(ra_tbutton5)];
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

procedure tguitarsfo.oncreateguit(const Sender: TObject);
var
  ordir: string;
  i: integer;
  i1, childn: integer;
begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;  
 {$endif}

  with tgroupbox1 do
  begin
    setlength(boundchildgu, tgroupbox1.childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildgu[i1].left   := children[i1].left;
      boundchildgu[i1].top    := children[i1].top;
      boundchildgu[i1].Width  := children[i1].Width;
      boundchildgu[i1].Height := children[i1].Height;
      boundchildgu[i1].Name   := children[i1].Name;
    end;
    childn := length(boundchildgu);
  end;

  with tgroupbox2 do
  begin
    setlength(boundchildgu, length(boundchildgu) + tgroupbox2.childrencount);
    for i1 := 0 to childrencount - 1 do
    begin
      boundchildgu[i1 + childn].left   := children[i1].left;
      boundchildgu[i1 + childn].top    := children[i1].top;
      boundchildgu[i1 + childn].Width  := children[i1].Width;
      boundchildgu[i1 + childn].Height := children[i1].Height;
      boundchildgu[i1 + childn].Name   := children[i1].Name;
    end;
  end;

  Caption := 'Guitar and Bass tuned strings';

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  aguitar[0] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '1_MI_E.mp3';
  aguitar[1] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '2_SI_B.mp3';
  aguitar[2] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '3_SOL_G.mp3';
  aguitar[3] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '4_RE_D.mp3';
  aguitar[4] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '5_LA_A.mp3';
  aguitar[5] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '6_MI_E.mp3';

  aguitar[6] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba1_SOL_G.mp3';
  aguitar[7] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba2_RE_D.mp3';
  aguitar[8] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba3_LA_A.mp3';
  aguitar[9] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba4_MI_E.mp3';

  for i := 0 to 9 do
    aguitarisplaying[i] := False;

end;

end.

