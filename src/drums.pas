
unit drums;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,fptimer,
 msegui,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,
 msesimplewidgets,msewidgets,msegraphedits,msedataedits,SysUtils,Classes,
 msedragglob,mseificomp,mseificompglob,mseifiglob,msescrollbar,msetypes,mseact,
 mseedit,msestatfile,msestream,msestrings,msedispwidgets,mserichstring,msetimer,
 msebitmap,msedropdownlist;

type
  talab  = array[0..15] of tlabel;
  talab2 = array[0..3] of tlabel;
  tcheck = array[0..15] of tbooleanedit;

type
  tdrumsfo = class(tdockform)
   // Timertick: Ttimer;
    Timertick: tfptimer;
    Timerpause: Ttimer;
    Timersent: Ttimer;
    tfacedrums: tfacecomp;
    tdockpanel1: tgroupbox;
    and4: tlabel;
    and3: tlabel;
    and2: tlabel;
    and1: tlabel;
    labd: tlabel;
    lasd: tlabel;
    laoh: tlabel;
    lach: tlabel;
    tlabel1: tlabel;
    tlabel2: tlabel;
    tlabel3: tlabel;
    tlabel4: tlabel;
    tlabel5: tlabel;
    tlabel6: tlabel;
    tlabel7: tlabel;
    tlabel8: tlabel;
    tlabel9: tlabel;
    tlabel10: tlabel;
    tlabel11: tlabel;
    tlabel12: tlabel;
    tlabel17: tlabel;
    tlabel18: tlabel;
    tlabel19: tlabel;
    tlabel20: tlabel;
    labpat: tlabel;
    tlabel13: tlabel;
    tlabel14: tlabel;
    tlabel15: tlabel;
    tlabel16: tlabel;
    tbooleanedit1: tbooleanedit;
    tbooleanedit2: tbooleanedit;
    tbooleanedit3: tbooleanedit;
    tbooleanedit4: tbooleanedit;
    tbooleanedit5: tbooleanedit;
    tbooleanedit6: tbooleanedit;
    tbooleanedit7: tbooleanedit;
    tbooleanedit8: tbooleanedit;
    tbooleanedit9: tbooleanedit;
    tbooleanedit10: tbooleanedit;
    tbooleanedit11: tbooleanedit;
    tbooleanedit12: tbooleanedit;
    tbooleanedit13: tbooleanedit;
    tbooleanedit14: tbooleanedit;
    tbooleanedit15: tbooleanedit;
    tbooleanedit16: tbooleanedit;
    tbooleanedit17: tbooleanedit;
    tbooleanedit18: tbooleanedit;
    tbooleanedit19: tbooleanedit;
    tbooleanedit20: tbooleanedit;
    tbooleanedit21: tbooleanedit;
    tbooleanedit22: tbooleanedit;
    tbooleanedit23: tbooleanedit;
    tbooleanedit24: tbooleanedit;
    tbooleanedit25: tbooleanedit;
    tbooleanedit26: tbooleanedit;
    tbooleanedit27: tbooleanedit;
    tbooleanedit28: tbooleanedit;
    tbooleanedit29: tbooleanedit;
    tbooleanedit30: tbooleanedit;
    tbooleanedit31: tbooleanedit;
    tbooleanedit32: tbooleanedit;
    tbooleanedit33: tbooleanedit;
    tbooleanedit34: tbooleanedit;
    tbooleanedit35: tbooleanedit;
    tbooleanedit36: tbooleanedit;
    tbooleanedit37: tbooleanedit;
    tbooleanedit38: tbooleanedit;
    tbooleanedit39: tbooleanedit;
    tbooleanedit40: tbooleanedit;
    tbooleanedit41: tbooleanedit;
    tbooleanedit42: tbooleanedit;
    tbooleanedit43: tbooleanedit;
    tbooleanedit44: tbooleanedit;
    tbooleanedit45: tbooleanedit;
    tbooleanedit46: tbooleanedit;
    tbooleanedit47: tbooleanedit;
    tbooleanedit48: tbooleanedit;
    tbooleanedit49: tbooleanedit;
    tbooleanedit50: tbooleanedit;
    tbooleanedit51: tbooleanedit;
    tbooleanedit52: tbooleanedit;
    tbooleanedit53: tbooleanedit;
    tbooleanedit54: tbooleanedit;
    tbooleanedit55: tbooleanedit;
    tbooleanedit56: tbooleanedit;
    tbooleanedit57: tbooleanedit;
    tbooleanedit58: tbooleanedit;
    tbooleanedit59: tbooleanedit;
    tbooleanedit60: tbooleanedit;
    tbooleanedit61: tbooleanedit;
    tbooleanedit62: tbooleanedit;
    tbooleanedit63: tbooleanedit;
    tbooleanedit64: tbooleanedit;
    panel1: tgroupbox;
    tbooleaneditradio8: tbooleaneditradio;
    tbooleaneditradio7: tbooleaneditradio;
    tbooleaneditradio6: tbooleaneditradio;
    tbooleaneditradio5: tbooleaneditradio;
    lesson4: tbooleaneditradio;
    lesson3: tbooleaneditradio;
    lesson2: tbooleaneditradio;
    lesson1: tbooleaneditradio;
    tlabel22: tlabel;
    tlabel21: tlabel;
    noanim: tbooleanedit;
    noand: tbooleanedit;
    novoice: tbooleanedit;
    nodrums: tbooleanedit;
    loop_stop: TButton;
    loop_resume: TButton;
    loop_start: TButton;
    edittempo: trealspinedit;
    tlabel25: tlabel;
    tlabel23: tlabel;
    volumedrums: trealspinedit;
    ltempo: tstringdisp;
    tstringdisp2: tstringdisp;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    multbpm: TButton;
    divbpm: TButton;
    langcount: tdropdownlistedit;
    songtimer: tbooleanedit;
    tickcount: tintegeredit;
   sensib: trealspinedit;
   tgroupbox1: tgroupbox;
   label3: tlabel;
   label4: tlabel;
   label2: tlabel;
   pnotloaded: tstringdisp;
   tlabel24: tlabel;
   tbutton1: tbutton;
    procedure ontimertick(Sender: TObject);
    procedure ontimerpause(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure dostart(const Sender: TObject);
    procedure dostop(const Sender: TObject);
    procedure doresume(const Sender: TObject);
    procedure onchangetempo(const Sender: TObject);
    procedure dopatern(const Sender: TObject);
    procedure createdrumsplayers;
    procedure createvoiceplayers;
    procedure stopvoiceplayers;
    procedure visiblechangeev(const Sender: TObject);
    procedure oncreatedrums(const Sender: TObject);
    procedure oncreateddrums(const Sender: TObject);

    procedure loadsoundlib(const Sender: TObject);

    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onsetnovoice(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure ondestroi(const Sender: TObject);
    procedure onchangenovoice(const Sender: TObject);
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
    procedure onmultdiv(const Sender: TObject);
    procedure onchangelang(const Sender: TObject);
    procedure onchangesongtimer(const Sender: TObject);
    procedure onchansens(const Sender: TObject);
    procedure resizedr(fontheight :  integer );
   procedure bnotload(const sender: TObject);
   procedure onclose(const sender: TObject);
  end;

var
  drumsfo: tdrumsfo;
  posi: integer = 1;
  initdrum: integer = 1;
  wascreated: Boolean = False;
  wascreatedok: Boolean = False;

  adrums: array[0..8] of string;
  drum_beats: array[0..3] of string;
  drum_input: array[0..3] of integer;
  alab: talab;
  alab2: talab2;
  alaband: talab2;
  ach, aoh, asd, abd: tcheck;
  resulib: integer;

implementation

uses
  main,
  captionstrumpract,
  uos_flat,
  commander,
  config,
  dockpanel1,
  drums_mfm,
  randomnote;
  
var
   boundchilddr: array of boundchild;   

procedure tdrumsfo.ontimersent(const Sender: TObject);
begin
  hintpanel.Visible         := False;
end;

procedure tdrumsfo.resizedr(fontheight : integer );
var
 childrensp: widgetarty;
 heights: integerarty;
 widths: integerarty;
 tops: integerarty;
 lefts: integerarty;
 i1, i2: integer;
 spcx, spcy, posx, posy, ax: integer;
 ratioft : double;
begin
    ratioft := fontheight/12 ;
    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;
    bounds_cxmax := roundmath(442 * ratioft);
    bounds_cxmin := bounds_cxmax;
    bounds_cymax := roundmath(274 * ratioft);
    bounds_cymin := bounds_cymax;
    font.height :=  fontheight;
    panel1.font.height :=  fontheight;
    tdockpanel1.font.height :=  fontheight;
    
    label2.font.height := roundmath(50 * ratioft);
    label3.font.height := roundmath(50 * ratioft);
    label4.font.height := roundmath(50 * ratioft);
    
    label2.width := roundmath(32 * ratioft);
    label3.width := roundmath(18 * ratioft);
    label4.width := roundmath(18 * ratioft);
    
    label2.height := roundmath(59 * ratioft);
    label3.height := roundmath(59 * ratioft);
    label4.height := roundmath(59 * ratioft);
         
    label4.left := roundmath(35 * ratioft);
    label2.left := roundmath(11 * ratioft);
    
    edittempo.frame.buttonsize := roundmath(20 * ratioft);   
    volumedrums.frame.buttonsize := roundmath(20 * ratioft);   
    sensib.frame.buttonsize := roundmath(20 * ratioft);   
     
    frame.grip_size := roundmath(8 * ratioft);
    
    tdockpanel1.height := roundmath(149 * ratioft);
    
    panel1.height := roundmath(125 * ratioft);
    panel1.top := roundmath(148 * ratioft);
  
  // grid
  
   labpat.top := roundmath(18 * ratioft);
   lach.top := roundmath(54 * ratioft);
   laoh.top := roundmath(78 * ratioft);
   lasd.top := roundmath(102 * ratioft);
   labd.top := roundmath(126 * ratioft);
   
   labpat.width := roundmath(52 * ratioft);
   lach.width := labpat.width;
   laoh.width := labpat.width;
   lasd.width := labpat.width;
   labd.width := labpat.width;
   
   labpat.height := roundmath(16 * ratioft);
   lach.height := labpat.height;
   laoh.height := labpat.height;
   lasd.height := labpat.height;
   labd.height := labpat.height;
  
  
   spcx := roundmath(24 * ratioft);
  spcy := roundmath(24 * ratioft);
  // posx := -26;
  posx := roundmath(-33 * ratioft);

  posy := roundmath(6 * ratioft);

 for ax := 0 to 3 do
    with alab2[ax] do
    begin
      Width   :=roundmath(16 * ratioft);
      Height  := roundmath(16 * ratioft);
      color   := $D5D5D5;
      Visible := True;
      // textflags := [xcentered,tf_ycentered];
      Caption := msestring(IntToStr(ax + 1));
      if ax = 0 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (1));
        top  := posy;
      end
      else if ax = 1 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (5));
        top  := posy;
      end
      else if ax = 2 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (9));
        top  := posy;
      end
      else
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (13));
        top  := posy;
      end;
      // color := TfpgColor($FFD3D3D3);

    end;
      // }

 for ax := 0 to 3 do
    with alaband[ax] do
    begin
      Width   := roundmath(16 * ratioft);;
      Height  := roundmath(16 * ratioft);;
      Visible := True;
      color   := $B5B5B5;
      // textflags := [xcentered,tf_ycentered];
      Caption := '&&';
      if ax = 0 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (3));
        top  := posy;
      end
      else if ax = 1 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (7));
        top  := posy;
      end
      else if ax = 2 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (11));
        top  := posy;
      end
      else
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (15));
        top  := posy;
      end;
      // color := TfpgColor($FFD3D3D3);

    end;

 for ax := 0 to 15 do
    with alab[ax] do
    begin
      optionswidget1 := [ow1_fontglyphheight];
      Width := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      color := $D5D5D5;
      Visible := True;
      // textflags := [xcentered,tf_ycentered];
      Caption := msestring(IntToStr(ax + 1));
      left := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top := posy + (spcy * 1);
    end;

  for ax := 0 to 15 do
  begin
    with ach[ax] do
    begin
      Name   := 'ch' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 2);
      Width  := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Closed Hat at position ' + msestring(IntToStr(ax + 1)) + ' ';
    end;
    if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
      ach[ax].Value := True
    else
      ach[ax].Value := False;
  end;

 for ax := 0 to 15 do
    with aoh[ax] do
    begin
      Name   := 'oh' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 3);
      Width  := roundmath(16 * ratioft);
      Height := roundmath(16 * ratioft);
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Open Hat at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;

  for ax := 0 to 15 do
    with asd[ax] do
    begin
      Name   := 'sd' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 4);
      Width  := roundmath(16 * ratioft);
      Height := roundmath(16 * ratioft);
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Snare Drum at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;

 for ax := 0 to 15 do
    with abd[ax] do
    begin
      Name   := 'bd' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 5);
      Width  := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Bass Drum at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;


// end grid


    with panel1 do
       for i1 := 0 to childrencount - 1 do
         for i2 := 0 to length(boundchilddr) - 1 do
        if children[i1].name = boundchilddr[i2].name then
        begin
          children[i1].left := roundmath(boundchilddr[i2].left * ratioft);  
          children[i1].top := roundmath(boundchilddr[i2].top * ratioft);  
          children[i1].width := roundmath(boundchilddr[i2].width * ratioft);   
          children[i1].height := roundmath(boundchilddr[i2].height * ratioft); 
         end; 
 end;

procedure tdrumsfo.ontimerpause(const Sender: TObject);
var
  i: integer;
begin
  if wascreated then
  begin

    label2.Caption := '0';
    label3.Visible := False;
    label4.Visible := False;

    for i := 0 to 8 do
    begin
      uos_play(i);
      uos_stop(i);
    end;

    novoice.Value := True;
    tag           := 0;
    loop_resume.Enabled := False;
    commanderfo.loop_resume.Enabled := False;
    wascreated    := False;

  end;
end;

procedure tdrumsfo.ontimertick(Sender: TObject);
var
  ax: integer;
begin
  
  if stopit = False then
  begin
    if novoice.Value = False then
      if (posi = 1) then
        uos_PlaynofreePaused(4)
      else if (posi = 3) and (noand.Value = False) then
        uos_PlaynofreePaused(8)
      else if (posi = 5) then
        uos_PlaynofreePaused(5)
      else if (posi = 7) and (noand.Value = False) then
        uos_PlaynofreePaused(8)
      else if (posi = 9) then
        uos_PlaynofreePaused(6)
      else if (posi = 11) and (noand.Value = False) then
        uos_PlaynofreePaused(8)
      else if (posi = 13) then
        uos_PlaynofreePaused(7)
      else if (posi = 15) and (noand.Value = False) then
        uos_PlaynofreePaused(8);

    if nodrums.Value = False then
    begin

      if ach[posi - 1].Value = True then
      begin
      if drum_input[0] > -1 then
        uos_InputSetDSPVolume(0, drum_input[0], (volumedrums.Value / 100) * commanderfo.
          genvolleft.Value * 1.5
          , (volumedrums.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

        uos_PlaynofreePaused(0);
      end;

      if aoh[posi - 1].Value then
      begin
       if drum_input[1] > -1 then
        uos_InputSetDSPVolume(1, drum_input[1], (volumedrums.Value / 100) * commanderfo.
          genvolleft.Value * 1.5
          , (volumedrums.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

        uos_PlaynofreePaused(1);
      end;

      if asd[posi - 1].Value then
      begin
         if drum_input[2] > -1 then
        uos_InputSetDSPVolume(2, drum_input[2], (volumedrums.Value / 100) * commanderfo.
          genvolleft.Value * 1.5
          , (volumedrums.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

        uos_PlaynofreePaused(2);
      end;

      if abd[posi - 1].Value then
      begin
         if drum_input[3] > -1 then
        uos_InputSetDSPVolume(3, drum_input[3], (volumedrums.Value / 100) * commanderfo.
          genvolleft.Value * 1.5
          , (volumedrums.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

        uos_PlaynofreePaused(3);
      end;


      // uos_SetGlobalEvent(true) was executed --> This set events (like pause/replay threads) to global.
      // One event (for example uos_replay) will have impact on all players.

      if (ach[posi - 1].Value = True) then
        uos_RePlay(0)  // A uos_replay() of each player will have impact on all players.
      else if (aoh[posi - 1].Value = True) then
        uos_RePlay(1) // A uos_replay() of each player will have impact on all players.
      else if (asd[posi - 1].Value = True) then
        uos_RePlay(2)  // A uos_replay() of each player will have impact on all players.
      else if (abd[posi - 1].Value = True) then
        uos_RePlay(3);
      // A uos_replay() of each player will have impact on all players.

    end;

    if noanim.Value = False then
    begin
      //  application.lock();
      if songtimer.Value then
        label2.Visible := False
      else
        label2.Visible := True;

      if (posi = 1) or (posi = 9) then
      begin
        label3.Visible := True;
        label4.Visible := False;
      end
      else if (posi = 5) or (posi = 13) then
      begin
        label3.Visible := False;
        label4.Visible := True;
      end;

      if (posi = 1) then
        label2.font.color := cl_red
      else
        label2.font.color := $40733D;

      alaband[0].color := cl_ltgray;
      alaband[1].color := cl_ltgray;
      alaband[2].color := cl_ltgray;
      alaband[3].color := cl_ltgray;

      if (posi = 1) then
      begin
        alab2[0].color := cl_ltred;
        alab2[1].color := cl_ltgray;
        alab2[2].color := cl_ltgray;
        alab2[3].color := cl_ltgray;
        if songtimer.Value = False then
          label2.Caption := '1';
      end
      else if (posi = 3) then
      begin
        alaband[0].color := $FFE8B8;
        alaband[1].color := cl_ltgray;
        alaband[2].color := cl_ltgray;
        alaband[3].color := cl_ltgray;
      end
      else if (posi = 5) then
      begin
        alab2[1].font.color := cl_white;

        alab2[0].font.color := cl_black;
        alab2[2].font.color := cl_black;
        alab2[3].font.color := cl_black;
        alab2[1].color      := cl_ltred;
        alab2[0].color      := cl_ltgray;
        alab2[2].color      := cl_ltgray;
        alab2[3].color      := cl_ltgray;
        if songtimer.Value = False then
          label2.Caption := '2';
      end
      else if (posi = 7) then
      begin
        alaband[1].color := $FFE8B8;
        alaband[0].color := cl_ltgray;
        alaband[2].color := cl_ltgray;
        alaband[3].color := cl_ltgray;
      end
      else if (posi = 9) then
      begin
        alab2[2].font.color := cl_white;
        alab2[1].font.color := cl_black;
        alab2[0].font.color := cl_black;
        alab2[3].font.color := cl_black;
        alab2[2].color      := cl_ltred;
        alab2[1].color      := cl_ltgray;
        alab2[0].color      := cl_ltgray;
        alab2[3].color      := cl_ltgray;
        if songtimer.Value = False then
          label2.Caption := '3';
      end
      else if (posi = 11) then
      begin
        alaband[2].color := $FFE8B8;
        alaband[1].color := cl_ltgray;
        alaband[0].color := cl_ltgray;
        alaband[3].color := cl_ltgray;
      end
      else if (posi = 13) then
      begin
        alab2[3].font.color := cl_white;
        alab2[1].font.color := cl_black;
        alab2[2].font.color := cl_black;
        alab2[0].font.color := cl_black;
        alab2[3].color      := cl_ltred;
        alab2[1].color      := cl_ltgray;
        alab2[2].color      := cl_ltgray;
        alab2[0].color      := cl_ltgray;
        if songtimer.Value = False then
          label2.Caption := '4';
      end
      else if (posi = 15) then
      begin
        alaband[3].color := $FFE8B8;
        alaband[1].color := cl_ltgray;
        alaband[2].color := cl_ltgray;
        alaband[0].color := cl_ltgray;
      end;

      // {
      for ax := 0 to 15 do
        if ax = posi - 1 then
        begin
          alab[ax].color := cl_yellow;

          if ach[ax].Value = True then
          begin
            ach[ax].frame.colorclient := cl_ltgreen;
            Lach.color := cl_ltgreen;
          end
          else
          begin
            ach[ax].frame.colorclient := cl_yellow;
            Lach.color := cl_ltgray;
          end;

          if aoh[ax].Value = True then
          begin
            aoh[ax].frame.colorclient := cl_ltgreen;
            Laoh.color := cl_ltgreen;
          end
          else
          begin
            aoh[ax].frame.colorclient := cl_yellow;
            Laoh.color := cl_ltgray;
          end;

          if asd[ax].Value = True then
          begin
            asd[ax].frame.colorclient := cl_ltgreen;
            Lasd.color := cl_ltgreen;
          end
          else
          begin
            asd[ax].frame.colorclient := cl_yellow;
            Lasd.color := cl_ltgray;
          end;

          if abd[ax].Value = True then
          begin
            abd[ax].frame.colorclient := cl_ltgreen;
            Labd.color := cl_ltgreen;
          end
          else
          begin
            abd[ax].frame.colorclient := cl_yellow;
            Labd.color := cl_ltgray;
          end;

          // }
        end
        else
        begin
          if (ax = 0) or (ax = 4) or (ax = 8) or (ax = 12) then
          begin
            ach[ax].frame.colorclient := $FFB8B8;
            aoh[ax].frame.colorclient := $FFB8B8;
            asd[ax].frame.colorclient := $FFB8B8;
            abd[ax].frame.colorclient := $FFB8B8;
          end
          else if (ax = 2) or (ax = 6) or (ax = 10) or (ax = 14) then
          begin
            ach[ax].frame.colorclient := $FFF8B8;
            aoh[ax].frame.colorclient := $FFF8B8;
            asd[ax].frame.colorclient := $FFF8B8;
            abd[ax].frame.colorclient := $FFF8B8;
          end
          else
          begin
            ach[ax].frame.colorclient := cl_white;
            aoh[ax].frame.colorclient := cl_white;
            asd[ax].frame.colorclient := cl_white;
            abd[ax].frame.colorclient := cl_white;
          end;
          alab[ax].color := cl_ltgray;

        end;

    end
    else
    begin

      for ax := 0 to 3 do
      begin
        alab2[ax].font.color := cl_black;
        alab2[ax].color      := cl_ltgray;
        alaband[ax].color    := cl_ltgray;
      end;

      for ax := 0 to 15 do
      begin
        if (ax = 0) or (ax = 4) or (ax = 8) or (ax = 12) then
        begin
          ach[ax].frame.colorclient := $FFB8B8;
          aoh[ax].frame.colorclient := $FFB8B8;
          asd[ax].frame.colorclient := $FFB8B8;
          abd[ax].frame.colorclient := $FFB8B8;
        end
        else
        begin
          ach[ax].frame.colorclient := cl_white;
          aoh[ax].frame.colorclient := cl_white;
          asd[ax].frame.colorclient := cl_white;
          abd[ax].frame.colorclient := cl_white;
        end;

        alab[ax].color := cl_ltgray;

      end;
      Lach.color := cl_ltgray;
      Laoh.color := cl_ltgray;
      Lasd.color := cl_ltgray;
      Labd.color := cl_ltgray;

      label3.Visible := False;
      label4.Visible := False;
      label2.Visible := False;

    end;

    posi := posi + 1;

    if (posi > 16) then
      posi := 1;

    if songtimer.Value = False then
      Timertick.Enabled := True;
    Timertick.tag       := 0;

    //  application.unlock();
  end
  else
  begin
    Timertick.Enabled := False;
    Timertick.tag     := 1;

  end;
end;

procedure tdrumsfo.dostart(const Sender: TObject);
begin
  if wascreated = False then
    createdrumsplayers;

if wascreatedok then
begin
  wascreated     := True;
  stopit         := False;
  label2.Enabled := True;
  Timerpause.Enabled := False;
  posi           := 1;
  loop_resume.Enabled := False;
  if songtimer.Value = False then
    TimerTick.Enabled := True
  else
    TimerTick.Enabled := False;
  loop_stop.Enabled   := True;

  commanderfo.loop_resume.Enabled := False;
  commanderfo.loop_stop.Enabled   := True;
end else pnotloaded.visible := true;

end;

procedure tdrumsfo.dostop(const Sender: TObject);
begin
if wascreatedok then
begin
  label2.Enabled := False;
  loop_stop.Enabled := False;
  loop_resume.Enabled := True;
  commanderfo.loop_resume.Enabled := True;
  commanderfo.loop_stop.Enabled := False;
  stopit := True;
  if timerpause.Enabled then
    timerpause.restart // to reset
  else
    timerpause.Enabled := True;
end;
end;

procedure tdrumsfo.doresume(const Sender: TObject);
begin
if wascreatedok then
begin
  label2.Enabled := False;
  stopit         := False;
  Timerpause.Enabled := False;
  loop_resume.Enabled := False;
  loop_stop.Enabled := True;
  if songtimer.Value = False then
    TimerTick.Enabled := True;

  commanderfo.loop_resume.Enabled := False;
  commanderfo.loop_stop.Enabled   := True;
end;
end;

procedure tdrumsfo.onchangetempo(const Sender: TObject);
begin
  if roundmath(60000 / 4 / edittempo.Value * 1000) > 0 then

    ltempo.Value    := utf8decode('BPM ' + IntToStr(roundmath(edittempo.Value)) + ' - ' + IntToStr(roundmath(
      600000 / 4 / edittempo.Value)) + ' ds')
  else
  begin
    edittempo.Value := 1;
    ltempo.Value    := utf8decode('BPM ' + IntToStr(roundmath(edittempo.Value)) + ' - ' + IntToStr(roundmath(
      600000 / 4 / edittempo.Value)) + ' ds');
  end;

  if hasinit = 1 then
  begin
   if wascreatedok then
begin
    if randomnotefo.Visible then
      randomnotefo.bpm.Value := roundmath(edittempo.Value / 2);

    //TimerTick.Interval := trunc(edittempo.Value * 1000);
    TimerTick.Interval := roundmath(60000 / 4 / edittempo.Value);

{
    edittempo.face.template := mainfo.tfaceorange;
    ltempo.face.template    := mainfo.tfaceorange;
    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;
} 
  end;
 end; 
 
end;


procedure tdrumsfo.dopatern(const Sender: TObject);
var
  ax: integer;
begin
  if tbooleaneditradio(Sender).Value = True then
    case tbooleaneditradio(Sender).tag of
      1:
      begin
        labpat.Caption  := 'Lesson 1';
        edittempo.Value := 100;
        onchangetempo(Sender);
        drum_beats[0]   := 'x000x000x000x000';
        // closed hat
        drum_beats[1]   := '0000000000000000';
        // opened hat
        drum_beats[2]   := '0000000000000000';
        // snare
        drum_beats[3]   := '0000000000000000';
        // kick
        novoice.Value   := False;
      end;
      2:
      begin
        labpat.Caption  := 'Lesson 2';
        edittempo.Value := 100;
        onchangetempo(Sender);
        drum_beats[0]   := 'x000x000x000x000';
        // closed hat
        drum_beats[1]   := '0000000000000000';
        // opened hat
        drum_beats[2]   := '0000000000000000';
        // snare
        drum_beats[3]   := 'x000000000000000';
        // kick
        novoice.Value   := False;
      end;
      3:
      begin
        labpat.Caption  := 'Lesson 3';
        edittempo.Value := 100;
        onchangetempo(Sender);
        drum_beats[0]   := 'x000x000x000x000';
        // closed hat
        drum_beats[1]   := '0000000000000000';
        // opened hat
        drum_beats[2]   := '00000000x0000000';
        // snare
        drum_beats[3]   := 'x000000000000000';
        // kick
        novoice.Value   := False;
      end;
      4:
      begin
        labpat.Caption  := 'Lesson 4';
        edittempo.Value := 200;
        onchangetempo(Sender);
        drum_beats[0]   := 'x000x000x000x000';
        // closed hat
        drum_beats[1]   := '0000000000000000';
        // opened hat
        drum_beats[2]   := '00000000x0000000';
        // snare
        drum_beats[3]   := 'x000x00000000000';
        // kick
        novoice.Value   := False;
      end;
      5:
      begin
        labpat.Caption := 'Patern 1';
        //edittempo.Value := 150;
        ///onchangetempo(Sender);
        drum_beats[0]  := 'x0x0x0x0x0x0x000';
        // closed hat
        drum_beats[1]  := '00000000000000x0';
        // opened hat
        drum_beats[2]  := '0000x0000000x000';
        // snare
        drum_beats[3]  := 'x0000000x0x00000';
        // kick
        novoice.Value  := True;
      end;
      6:
      begin
        labpat.Caption := 'Patern 2';
        //edittempo.Value := 150;
        //onchangetempo(Sender);
        drum_beats[0]  := 'x0x0x000x0x0x0x0';
        // closed hat
        drum_beats[1]  := '000000x000000000';
        // opened hat
        drum_beats[2]  := '00x0x0000000x000';
        // snare
        drum_beats[3]  := 'x0000000x0x00000';
        // kick
        novoice.Value  := True;
      end;
      7:
      begin
        labpat.Caption := 'Patern 3';
        //edittempo.Value := 150;
        //onchangetempo(Sender);
        drum_beats[0]  := 'x000x0x000x0x000';
        // closed hat
        drum_beats[1]  := '00x00000x00000x0';
        // opened hat
        drum_beats[2]  := '0000x0000000x000';
        // snare
        drum_beats[3]  := 'x00000x0x0x000x0';
        // kick
        novoice.Value  := True;
      end;
      8:
      begin
        labpat.Caption := 'Patern 4';
        //edittempo.Value := 150;
        //onchangetempo(Sender);
        drum_beats[0]  := 'x000x000x000x000';
        // closed hat
        drum_beats[1]  := '00x000x000x000x0';
        // opened hat
        drum_beats[2]  := '0000x0000000x000';
        // snare
        drum_beats[3]  := 'x0x00000x00000x0';
        // kick
        novoice.Value  := True;
      end;
    end;

  for ax := 0 to 15 do
  begin
    if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
      ach[ax].Value := True
    else
      ach[ax].Value := False;

    if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
      aoh[ax].Value := True
    else
      aoh[ax].Value := False;

    if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
      asd[ax].Value := True
    else
      asd[ax].Value := False;

    if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
      abd[ax].Value := True
    else
      abd[ax].Value := False;
  end;
end;

procedure tdrumsfo.visiblechangeev(const Sender: TObject);
begin
  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and (Assigned(
    dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showdrums']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': ' +
        lang_commanderfo[Ord(co_namedrums_hint)]//mainfo.drumsvisible.value := 1;

    else
      mainfo.tmainmenu1.menu.itembynames(['show', 'showdrums']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
        lang_commanderfo[Ord(co_namedrums_hint)] ;

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

procedure tdrumsfo.createdrumsplayers;
var
  i: integer;
begin

  wascreatedok := true;

  for i := 0 to 3 do
  begin
  //  uos_Stop(i);

    if uos_CreatePlayer(i) then

      if uos_SetGlobalEvent(i, True) then
        // This set events (like pause/replay thread) to global.
        //One event (for example replay) will have impact on all players.

        // using memorystream
      //  drum_input[i] := uos_AddFromMemoryStream(i, ams[i], 0, -1, 2, 512);
        
     drum_input[i] := uos_AddFromFile(i, PChar(adrums[i]) , -1, -1, 1024) ;
    
    if drum_input[i] < 0 then wascreatedok := false;

    if configfo.latdrums.Value < 0 then
      configfo.latdrums.Value := -1;

    if drum_input[i] > -1 then

    if uos_AddFromEndlessMuted(i, channels, 512) > -1 then

        // this for a dummy endless input, must be last input
        if uos_AddIntoDevOut(i, configfo.devoutcfg.Value, configfo.latdrums.Value, -1, -1, -1, 1024 , -1) > -1 then
        begin

          uos_InputAddDSPVolume(i, drum_input[i], 1, 1);
          ///// DSP Volume changer
          ////////// Playerindex1 : Index of a existing Player
          ////////// Inputindex1 : Index of a existing input
          ////////// VolLeft : Left volume
          ////////// VolRight : Right volume
          uos_InputSetDSPVolume(i, drum_input[i], (volumedrums.Value / 100) * commanderfo.
            genvolleft.Value * 1.5
            , (volumedrums.Value / 100) * commanderfo.genvolright.Value * 1.5, True);
            
          application.processmessages;  

        end;
  end;
end;

procedure tdrumsfo.stopvoiceplayers;
 //var
 //i : integer;
begin
{
for i := 4 to 8 do
 begin
 uos_Stop(i);
 end;
}
end;

procedure tdrumsfo.createvoiceplayers;
var
  i: integer;
  ordir: msestring;
  timerisenabled: Boolean = False;
  {$if defined(darwin) and defined(macapp)}
  binPath: string;
  {$ENDIF}  
begin

  if timertick.Enabled = True then
    timerisenabled  := True;
  timertick.Enabled := False;

  //  writeln(langcount.text);
  //langcount.value  := 'es';
  // writeln(langcount.text);
  {$if defined(darwin) and defined(macapp)}
  binPath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
  ordir := copy(binPath, 1, length(binPath) -6) + 'Resources/';
  {$else}
  ordir   := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))) ;
  {$ENDIF}  

  adrums[4] := rawbytestring(ordir + 'sound' + directoryseparator + 'voice' + directoryseparator +
    langcount.Value + directoryseparator + '1.mp3');
  adrums[5] := rawbytestring(ordir + 'sound' + directoryseparator + 'voice' + directoryseparator +
    langcount.Value + directoryseparator + '2.mp3');
  adrums[6] := rawbytestring(ordir + 'sound' + directoryseparator + 'voice' + directoryseparator +
    langcount.Value + directoryseparator + '3.mp3');
  adrums[7] := rawbytestring(ordir + 'sound' + directoryseparator + 'voice' + directoryseparator +
    langcount.Value + directoryseparator + '4.mp3');
  adrums[8] := rawbytestring(ordir + 'sound' + directoryseparator + 'voice' + directoryseparator +
    langcount.Value + directoryseparator + 'and.mp3');

  if tag = 0 then
    for i := 4 to 8 do
    begin
      uos_Stop(i);
 
      if uos_CreatePlayer(i) then

        if uos_SetGlobalEvent(i, True) then
          // This set events (like pause/replay thread) to global.
          //One event (for example replay) will have impact on all players.

          // using memorystream
          //  if uos_AddFromMemoryStream(i, ams[i], 0, -1, 2, 512) > -1 then
            
          // using memorybuffer
          // if uos_AddFromMemoryBuffer(i,thebuffer[i],thebufferinfos[i], -1, 1024) > -1 then

           if uos_AddFromFile(i, PChar(adrums[i]) , -1, -1, 1024) > -1 then
  
           if uos_AddFromEndlessMuted(i, channels, 512) > -1 then
            // this for a dummy endless input, must be last input

            uos_AddIntoDevOut(i, configfo.devoutcfg.Value, configfo.latdrums.Value, -1, -1, -1, 1024, -1) ;
    end;
  tag := 1;

  if timerisenabled = True then
    if songtimer.Value = False then
      timertick.Enabled := True;

end;

procedure tdrumsfo.loadsoundlib(const Sender: TObject);
var
  ordir: msestring;
  lib1, lib2, lib3, lib4: string;
  resu: integer = -1;
  {$if defined(darwin) and defined(macapp)}
  binPath: string;
{$ENDIF}  
  
begin
  allok   := False;
  resulib := -1;
  {$if defined(darwin) and defined(macapp)}
  binPath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
  ordir := copy(binPath, 1, length(binPath) -6) + 'Resources/';
  {$else}
  ordir   := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))) ;
  {$ENDIF}  

  {$IFDEF Windows}
         {$if defined(cpu64)}
  lib1 := AnsiString(ordir + 'lib\Windows\64bit\LibPortaudio-64.dll');
  lib2 := AnsiString(ordir + 'lib\Windows\64bit\LibSndFile-64.dll');
  lib3 := AnsiString(ordir + 'lib\Windows\64bit\LibMpg123-64.dll');
  lib4 := AnsiString(ordir + 'lib\Windows\64bit\LibSoundTouch-64.dll');

       {$else}
  lib1 := AnsiString(ordir + 'lib\Windows\32bit\LibPortaudio-32.dll');
  lib2 := AnsiString(ordir + 'lib\Windows\32bit\LibSndFile-32.dll');
  lib3 := AnsiString(ordir + 'lib\Windows\32bit\LibMpg123-32.dll');
  lib4 := AnsiString(ordir + 'lib\Windows\32bit\LibSoundTouch-32.dll');
         {$endif}
     {$ENDIF}

    {$if defined(CPUAMD64) and defined(linux) }
  lib1 := AnsiString(ordir + 'lib/Linux/64bit/LibPortaudio-64.so');
  lib2 := AnsiString(ordir + 'lib/Linux/64bit/LibSndFile-64.so');
  lib3 := AnsiString(ordir + 'lib/Linux/64bit/LibMpg123-64.so');
  lib4 := AnsiString(ordir + 'lib/Linux/64bit/LibSoundTouch-64.so');
     {$ENDIF}

  {$if defined(CPUAMD64) and defined(openbsd) }
  lib1 := AnsiString(ordir + 'lib/OpenBSD/64bit/LibPortaudio-64.so');
  lib2 := AnsiString(ordir + 'lib/OpenBSD/64bit/LibSndFile-64.so');
  lib3 := AnsiString(ordir + 'lib/OpenBSD/64bit/LibMpg123-64.so');
  lib4 := AnsiString(ordir + 'lib/OpenBSD/64bit/LibSoundTouch-64.so');
     {$ENDIF}
     
     {$if defined(cpu64) and defined(darwin) }
  lib1 := AnsiString(ordir + 'lib/Mac/64bit/LibPortaudio-64.dylib');
  lib2 := AnsiString(ordir + 'lib/Mac/64bit/LibSndFile-64.dylib');
  lib3 := AnsiString(ordir + 'lib/Mac/64bit/LibMpg123-64.dylib');
  lib4 := AnsiString(ordir + 'lib/Mac/64bit/libSoundTouchDLL.dylib');
     {$ENDIF}   
     
  {$if defined(cpu86) and defined(linux)}
  lib1 := AnsiString(ordir + 'lib/Linux/32bit/LibPortaudio-32.so');
  lib2 := AnsiString(ordir + 'lib/Linux/32bit/LibSndFile-32.so');
  lib3 := AnsiString(ordir + 'lib/Linux/32bit/LibMpg123-32.so');
  lib4 := AnsiString(ordir + 'lib/Linux/32bit/LibSoundTouch-32.so');
  {$ENDIF}
   {$if defined(linux) and defined(cpuarm)}
  lib1 := AnsiString(ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so');
  lib2 := AnsiString(ordir + 'lib/Linux/arm_raspberrypi/libsndfile-arm.so');
  lib3 := AnsiString(ordir + 'lib/Linux/arm_raspberrypi/libmpg123-arm.so');
  lib4 := AnsiString(ordir + 'lib/Linux/arm_raspberrypi/libsoundtouch-arm.so');
  {$ENDIF}
  {$if defined(linux) and defined(cpuaarch64)}
  lib1 := AnsiString(ordir + 'lib/Linux/aarch64_raspberrypi/libportaudio_aarch64.so');
  lib2 := AnsiString(ordir + 'lib/Linux/aarch64_raspberrypi/libsndfile_aarch64.so');
  lib3 := AnsiString(ordir + 'lib/Linux/aarch64_raspberrypi/libmpg123_aarch64.so');
  lib4 := AnsiString(ordir + 'lib/Linux/aarch64_raspberrypi/libsoundtouch_aarch64.so');
  {$ENDIF}

      {$IFDEF freebsd}
        {$if defined(cpu64)}
  lib1 := AnsiString(ordir + 'lib/FreeBSD/64bit/libportaudio-64.so');
  lib2 := AnsiString(ordir + 'lib/FreeBSD/64bit/libsndfile-64.so');
  lib3 := AnsiString(ordir + 'lib/FreeBSD/64bit/libmpg123-64.so');
  lib4 := AnsiString(ordir + 'lib/FreeBSD/64bit/libsoundtouch-64.so');
        {$else}
  lib1 := AnsiString(ordir + 'lib/FreeBSD/32bit/libportaudio-32.so');
  lib2 := AnsiString(ordir + 'lib/FreeBSD/32bit/libsndfile-32.so');
  lib3 := AnsiString(ordir + 'lib/FreeBSD/32bit/libmpg123-32.so');
  lib4 := '';
        {$endif}
      {$ENDIF}


  if configfo.syslib.Value = True then
  begin
    // writeln('Yes system');
    resu      := uos_LoadLib(PChar('system'), PChar('system'), PChar('system'), nil, nil, nil);
    if resu = 0 then
      resulib := 0
    else
    begin
      // writeln('Some libraries did not load...');
      resulib := -1;
      resu := uos_LoadLib(PChar(lib1), PChar(lib2), PChar(lib3), nil, nil, nil);
      configfo.syslib.Value := false;
    end;
  end
  else
  begin
    resu    := uos_LoadLib(PChar(lib1), PChar(lib2), PChar(lib3), nil, nil, nil);
    if resu <> 0 then 
    begin
     resu   := uos_LoadLib(PChar('system'), PChar('system'), PChar('system'), nil, nil, nil);
     configfo.syslib.Value := true;
    end;
  end;

  if resu = 0 then
  begin
     resulib := 0;
    if (uos_LoadPlugin('soundtouch', PChar(lib4)) = 0) then
      plugsoundtouch := True
    // writeln('Yes plugsoundtouch');

    else
      plugsoundtouch := False;
      // writeln('NO plugsoundtouch');
   
    allok := True;

    UOS_GetInfoDevice();
    devin  := UOSDefaultDeviceIN;
    devout := UOSDefaultDeviceOUT;

    // devin := -1;

    if devin > -1 then
      configfo.defdevin.Caption := 'Default Device IN = ' + msestring(IntToStr(devin))
    else
      configfo.defdevin.Caption := 'No Default Device IN';

    if devout > -1 then
      configfo.defdevout.Caption := 'Default Device OUT = ' + msestring(IntToStr(devout))
    else
      configfo.defdevout.Caption := 'No Default Device OUT';
  end;
end;

procedure tdrumsfo.oncreatedrums(const Sender: TObject);
var
  // ordir: msestring;
  spcx, spcy, posx, posy, ax: integer;
  //  lib1, lib2, lib3, lib4: string;
  i1: int32;
  //ratioft : double;
begin
  // visible := false;

  //ratioft := fontheightused/12;
  
    with panel1 do
   begin
      setlength(boundchilddr,childrencount);
 
       for i1 := 0 to childrencount - 1 do
         begin
          boundchilddr[i1].left := children[i1].left; 
          boundchilddr[i1].top := children[i1].top; 
          boundchilddr[i1].width := children[i1].width;  
          boundchilddr[i1].height := children[i1].height;
          boundchilddr[i1].name := children[i1].name;
         end;
    end;
 
  Timertick          := tfptimer.Create(nil);
  Timertick.OnTimer  := @ontimertick;
  Timertick.interval := 100;
  Timertick.Enabled  := False;
  Timertick.tag      := 0;

  Timerpause          := ttimer.Create(nil);
  Timerpause.interval := 10000000;
  Timerpause.Enabled  := False;
  Timerpause.ontimer  := @ontimerpause;
  Timerpause.options  := [to_single];

  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.ontimer  := @ontimersent;
  Timersent.options  := [to_single];

  drum_beats[0] := 'x0x0x0x0x0x0x000';
  // closed hat
  drum_beats[1] := '00000000000000x0';
  // opened hat
  drum_beats[2] := '0000x0000000x000';
  // snare
  drum_beats[3] := 'x0000000x0x00000';
  // kick
{
  spcx := roundmath(24 * ratioft);
  spcy := roundmath(24 * ratioft);
  // posx := -26;
  posx := roundmath(-33 * ratioft);

  posy := roundmath(6 * ratioft);
}
  alab2[0] := tlabel1;
  alab2[1] := tlabel2;
  alab2[2] := tlabel3;
  alab2[3] := tlabel4;

  for i1 := 0 to high(alab2) do
    alab2[i1].createfont();
{

  for ax := 0 to 3 do
    with alab2[ax] do
    begin
      Width   :=roundmath(16 * ratioft);
      Height  := roundmath(16 * ratioft);
      color   := $D5D5D5;
      Visible := True;
      // textflags := [xcentered,tf_ycentered];
      Caption := msestring(IntToStr(ax + 1));
      if ax = 0 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (1));
        top  := posy;
      end
      else if ax = 1 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (5));
        top  := posy;
      end
      else if ax = 2 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (9));
        top  := posy;
      end
      else
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (13));
        top  := posy;
      end;
      // color := TfpgColor($FFD3D3D3);

    end;
      // }

  alaband[0] := and1;
  alaband[1] := and2;
  alaband[2] := and3;
  alaband[3] := and4;

{
  for ax := 0 to 3 do
    with alaband[ax] do
    begin
      Width   := roundmath(16 * ratioft);;
      Height  := roundmath(16 * ratioft);;
      Visible := True;
      color   := $B5B5B5;
      // textflags := [xcentered,tf_ycentered];
      Caption := '&&';
      if ax = 0 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (3));
        top  := posy;
      end
      else if ax = 1 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (7));
        top  := posy;
      end
      else if ax = 2 then
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (11));
        top  := posy;
      end
      else
      begin
        left := posx + roundmath(65 * ratioft) + (spcx * (15));
        top  := posy;
      end;
      // color := TfpgColor($FFD3D3D3);

    end;
      // }
  alab[0]  := tlabel5;
  alab[1]  := tlabel6;
  alab[2]  := tlabel7;
  alab[3]  := tlabel8;
  alab[4]  := tlabel9;
  alab[5]  := tlabel10;
  alab[6]  := tlabel11;
  alab[7]  := tlabel12;
  alab[8]  := tlabel13;
  alab[9]  := tlabel14;
  alab[10] := tlabel15;
  alab[11] := tlabel16;
  alab[12] := tlabel17;
  alab[13] := tlabel18;
  alab[14] := tlabel19;
  alab[15] := tlabel20;

{
  for ax := 0 to 15 do
    with alab[ax] do
    begin
      optionswidget1 := [ow1_fontglyphheight];
      Width := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      color := $D5D5D5;
      Visible := True;
      // textflags := [xcentered,tf_ycentered];
      Caption := msestring(IntToStr(ax + 1));
      left := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top := posy + (spcy * 1);
    end;
}
  ach[0]  := tbooleanedit1;
  ach[1]  := tbooleanedit2;
  ach[2]  := tbooleanedit3;
  ach[3]  := tbooleanedit4;
  ach[4]  := tbooleanedit5;
  ach[5]  := tbooleanedit6;
  ach[6]  := tbooleanedit7;
  ach[7]  := tbooleanedit8;
  ach[8]  := tbooleanedit9;
  ach[9]  := tbooleanedit10;
  ach[10] := tbooleanedit11;
  ach[11] := tbooleanedit12;
  ach[12] := tbooleanedit13;
  ach[13] := tbooleanedit14;
  ach[14] := tbooleanedit15;
  ach[15] := tbooleanedit16;
{
  for ax := 0 to 15 do
  begin
    with ach[ax] do
    begin
      Name   := 'ch' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 2);
      Width  := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Closed Hat at position ' + msestring(IntToStr(ax + 1)) + ' ';
    end;
    if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
      ach[ax].Value := True
    else
      ach[ax].Value := False;
  end;
}

  aoh[0]  := tbooleanedit17;
  aoh[1]  := tbooleanedit18;
  aoh[2]  := tbooleanedit19;
  aoh[3]  := tbooleanedit20;
  aoh[4]  := tbooleanedit21;
  aoh[5]  := tbooleanedit22;
  aoh[6]  := tbooleanedit23;
  aoh[7]  := tbooleanedit24;
  aoh[8]  := tbooleanedit25;
  aoh[9]  := tbooleanedit26;
  aoh[10] := tbooleanedit27;
  aoh[11] := tbooleanedit28;
  aoh[12] := tbooleanedit29;
  aoh[13] := tbooleanedit30;
  aoh[14] := tbooleanedit31;
  aoh[15] := tbooleanedit32;
{
  for ax := 0 to 15 do
    with aoh[ax] do
    begin
      Name   := 'oh' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 3);
      Width  := roundmath(16 * ratioft);
      Height := roundmath(16 * ratioft);
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Open Hat at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;
}
  asd[0]  := tbooleanedit33;
  asd[1]  := tbooleanedit34;
  asd[2]  := tbooleanedit35;
  asd[3]  := tbooleanedit36;
  asd[4]  := tbooleanedit37;
  asd[5]  := tbooleanedit38;
  asd[6]  := tbooleanedit39;
  asd[7]  := tbooleanedit40;
  asd[8]  := tbooleanedit41;
  asd[9]  := tbooleanedit42;
  asd[10] := tbooleanedit43;
  asd[11] := tbooleanedit44;
  asd[12] := tbooleanedit45;
  asd[13] := tbooleanedit46;
  asd[14] := tbooleanedit47;
  asd[15] := tbooleanedit48;
{
  for ax := 0 to 15 do
    with asd[ax] do
    begin
      Name   := 'sd' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 4);
      Width  := roundmath(16 * ratioft);
      Height := roundmath(16 * ratioft);
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Snare Drum at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;
}
  abd[0]  := tbooleanedit49;
  abd[1]  := tbooleanedit50;
  abd[2]  := tbooleanedit51;
  abd[3]  := tbooleanedit52;
  abd[4]  := tbooleanedit53;
  abd[5]  := tbooleanedit54;
  abd[6]  := tbooleanedit55;
  abd[7]  := tbooleanedit56;
  abd[8]  := tbooleanedit57;
  abd[9]  := tbooleanedit58;
  abd[10] := tbooleanedit59;
  abd[11] := tbooleanedit60;
  abd[12] := tbooleanedit61;
  abd[13] := tbooleanedit62;
  abd[14] := tbooleanedit63;
  abd[15] := tbooleanedit64;

{
  for ax := 0 to 15 do
    with abd[ax] do
    begin
      Name   := 'bd' + IntToStr(ax + 1);
      left   := posx + roundmath(65 * ratioft) + (spcx * (ax + 1));
      top    := posy + (spcy * 5);
      Width  := roundmath(16 * ratioft);;
      Height := roundmath(16 * ratioft);;
      frame.hiddenedges := [edg_right, edg_top, edg_left, edg_bottom];
      hint   := ' Add/Remove a Bass Drum at position ' + msestring(IntToStr(ax + 1)) + ' ';

      if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
        Value := True
      else
        Value := False;
    end;
}
  for ax := 0 to 15 do
    if (ax = 0) or (ax = 4) or (ax = 8) or (ax = 12) then
    begin
      ach[ax].frame.colorclient := $FFB8B8;
      aoh[ax].frame.colorclient := $FFB8B8;
      asd[ax].frame.colorclient := $FFB8B8;
      abd[ax].frame.colorclient := $FFB8B8;
    end
    else if (ax = 2) or (ax = 6) or (ax = 10) or (ax = 14) then
    begin
      ach[ax].frame.colorclient := $FFF8B8;
      aoh[ax].frame.colorclient := $FFF8B8;
      asd[ax].frame.colorclient := $FFF8B8;
      abd[ax].frame.colorclient := $FFF8B8;
    end
    else
    begin
      ach[ax].frame.colorclient := cl_white;
      aoh[ax].frame.colorclient := cl_white;
      asd[ax].frame.colorclient := cl_white;
      abd[ax].frame.colorclient := cl_white;
    end;
  oncreateddrums(Sender);
end;

procedure tdrumsfo.oncreateddrums(const Sender: TObject);
var
  {$if defined(darwin) and defined(macapp)}
  binPath: string;
{$ENDIF}  
ordir : msestring;
begin
  //height := 274;
  //width := 442;
  Caption := 'Drums set';
 
  {$if defined(darwin) and defined(macapp)}
  binPath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
  ordir := copy(binPath, 1, length(binPath) -6) + 'Resources/';
  {$else}
  ordir   := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))) ;
  {$ENDIF}  

  adrums[0] := ansistring(ordir + 'sound' + directoryseparator + 'drums' + directoryseparator + 'HH.mp3');
  adrums[1] := ansistring(ordir + 'sound' + directoryseparator + 'drums' + directoryseparator + 'OH.mp3');
  adrums[2] := ansistring(ordir + 'sound' + directoryseparator + 'drums' + directoryseparator + 'SD.mp3');
  adrums[3] := ansistring(ordir + 'sound' + directoryseparator + 'drums' + directoryseparator + 'BD.mp3');

  posi := 1;    bounds_cxmax := 0;
  
     
end;

procedure tdrumsfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
begin

{
with ainfo do
  if (eventkind = ek_buttonpress) then
  begin
if mainfo.issomeplaying = false then dragdock.optionsdock := [od_savepos,od_savezorder,od_canmove,od_canfloat,od_candock,od_proportional,od_fixsize,od_captionhint]
else
dragdock.optionsdock := [od_savepos,od_savezorder,od_proportional,od_fixsize,od_captionhint] ;
end;
}
end;

procedure tdrumsfo.onsetnovoice(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin

  // else stopvoiceplayers;

end;

procedure tdrumsfo.ondestroi(const Sender: TObject);
begin
  Timerpause.Enabled := False;
  Timertick.Enabled  := False;
  timersent.Enabled  := False;
  Timerpause.Free;
  Timertick.Free;
  timersent.Free;
end;

procedure tdrumsfo.onchangenovoice(const Sender: TObject);
begin
  if (hasinit = 1) and (tag = 0) and (novoice.Value = False) and (allok = True) then
    createvoiceplayers;
end;

procedure tdrumsfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  if (trealspinedit(Sender).tag = 1) then
  begin
    if avalue > 200 then
    begin
      hintlabel.Caption := '"' + msestring(IntToStr(trunc(avalue))) + '" is > 200.  Reset to 200.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
      avalue := 200;
    end;

    if avalue < 1 then
    begin
      hintlabel.Caption := '" " is invalid value.  Reset to 0.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
      avalue := 0;
    end;
  end;

  if (trealspinedit(Sender).tag = 0) then
  begin
    if avalue > 500 then
    begin
      hintlabel.Caption := '"' + msestring(IntToStr(trunc(avalue))) + '" is > 500.  Reset to 500.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
      avalue := 500;
    end;

    if avalue < 1 then
    begin
      hintlabel.Caption := 'Value entered is < Minimum Value (1).  Reset to 1.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
      avalue := 1;
    end;
  end;
end;

procedure tdrumsfo.ontextedit(const Sender: tcustomedit; var atext: msestring);
begin
  if (isnumber(atext)) or (atext = '') or (atext = '-') then
  else
  begin
    hintlabel.Caption := '"' + atext + '" is invalid value.  Reset to 100.';
    if hintlabel.Width > hintlabel2.Width then
      hintpanel.Width := hintlabel.Width + 10
    else
      hintpanel.Width := hintlabel2.Width + 10;
    hintpanel.Visible := True;
    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;
    atext := '100';
  end;
end;

procedure tdrumsfo.onmultdiv(const Sender: TObject);
begin
  if (TButton(Sender).Name = 'multbpm') then
    edittempo.Value := roundmath(edittempo.Value * 2);

  if (TButton(Sender).Name = 'divbpm') then
    edittempo.Value := roundmath(edittempo.Value / 2);

end;

procedure tdrumsfo.onchangelang(const Sender: TObject);
var
  nov: Boolean = True;
begin
  nov := novoice.Value;

  dostop(Sender);
  ontimerpause(Sender);

  novoice.Value := nov;
end;

procedure tdrumsfo.onchangesongtimer(const Sender: TObject);
begin
  if songtimer.Value then
  begin
    label2.Visible    := False;
    edittempo.Enabled := False;
    divbpm.Enabled    := False;
    multbpm.Enabled   := False;
    ltempo.Enabled    := False;
    sensib.Enabled    := True;
    tickcount.Enabled := True;
    TimerTick.Enabled := False;
  end
  else
  begin
    label2.Visible    := True;
    edittempo.Enabled := True;
    divbpm.Enabled    := True;
    multbpm.Enabled   := True;
    ltempo.Enabled    := True;
    sensib.Enabled    := False;
    tickcount.Enabled := False;
    if commanderfo.loop_stop.Enabled = True then
      TimerTick.Enabled := True;
  end;

end;

procedure tdrumsfo.onchansens(const Sender: TObject);
begin
  if sensib.Value < 10 then
    sensib.Value := 10;
end;

procedure tdrumsfo.bnotload(const sender: TObject);
begin
pnotloaded.visible := false;
end;

procedure tdrumsfo.onclose(const sender: TObject);
begin
dostop(sender);
end;

end.

