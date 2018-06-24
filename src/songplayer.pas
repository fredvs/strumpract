unit songplayer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes, uos_flat, infos, msetimer, msetypes, mseglob, mseguiglob, mseguiintf,
 msefileutils, mseapplication, msestat, msemenus, msegui, msegraphics,
 msegraphutils, mseevent, mseclasses, mseforms, msedock, msesimplewidgets,
 msewidgets, msedataedits, msefiledialog, msegrids, mselistbrowser, msesys,
 SysUtils, msegraphedits, msedragglob, mseact, mseedit, mseificomp,
 mseificompglob, mseifiglob, msestatfile, msestream, msestrings, msescrollbar,
 msebitmap, msedatanodes, msedispwidgets, mserichstring;

type
  tsongplayerfo = class(tdockform)
    Timerwait: Ttimer;
    Timersent: Ttimer;

    tgroupbox1: tgroupbox;
    edvolleft: trealspinedit;
    edtempo: trealspinedit;
    button1: TButton;
    cbloop: tbooleanedit;
    cbtempo: tbooleanedit;
    trackbar1: tslider;
    historyfn: thistoryedit;
    songdir: tfilenameedit;
    llength: tstringdisp;
    lposition: tstringdisp;
    tstringdisp1: tstringdisp;
    edvolright: trealspinedit;
    tfaceslider: tfacecomp;
    btinfos: TButton;

    tfacebuttonslider: tfacecomp;
    tfacegreen: tfacecomp;
    waveformcheck: tbooleanedit;
    tstringdisp2: tstringdisp;
    sliderimage: tbitmapcomp;
    vuRight: tprogressbar;
    vuLeft: tprogressbar;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    button2: TButton;
    playreverse: tbooleanedit;
    btnStop: TButton;
    btnPause: TButton;
    btnResume: TButton;
    btnStart: TButton;
    BtnCue: TButton;
    setmono: tbooleanedit;
    ttimer1: ttimer;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1();
    procedure showposition(const Sender: TObject);
    procedure showlevel(const Sender: TObject);
    procedure LoopProcPlayer1();

    procedure oninfowav(const Sender: TObject);

    procedure onwavform(const Sender: TObject);
    procedure onreset(const Sender: TObject);
    procedure changevolume(const Sender: TObject);
    procedure ChangePlugSetSoundTouch(const Sender: TObject);
    procedure onsliderchange(const Sender: TObject);
    procedure ontimerwait(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplayercreate(const Sender: TObject);
    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure ondestr(const Sender: TObject);
    procedure changevol(const Sender: TObject; var avalue: realty; var accept: boolean);
    procedure oncreated(const Sender: TObject);
    procedure faceafterpaintbut(const Sender: tcustomface; const canvas: tcanvas; const arect: rectty);
    procedure onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
    procedure changeloop(const Sender: TObject);
    procedure GetWaveData();
    procedure GetWaveDataform();
    procedure DrawWaveForm();
    procedure FormDrawWaveForm();
    procedure changereverse(const Sender: TObject);

    procedure ChangeStereo2Mono(const Sender: TObject);
    procedure ShowSpectrum(const Sender: TObject);

    procedure resetspectrum();

    procedure onchachewav(const Sender: TObject);
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
    procedure ongetbpm(const Sender: TObject);

   procedure ontimerwaveform(const sender: TObject);
  protected
    procedure paintsliderimage(const canvas: tcanvas; const arect: rectty);
    procedure paintsliderimageform(const canvas: tcanvas; const arect: rectty);

  end;

  equalizer_band_type = record
    lo_freq, hi_freq: integer;
    Text: string[10];
  end;

var
  Equalizer_Bands: array[1..10] of equalizer_band_type;
  thearray: array of cfloat;
  thearray2: array of cfloat;

  arl, arr, arl2, arr2: flo64arty;
  songplayerfo: tsongplayerfo;
  songplayer2fo: tsongplayerfo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  theplayer: integer = 20;
  theplayerinfo: integer = 21;
  theplaying1: string = '';

  theplayer2: integer = 22;
  theplayerinfo2: integer = 23;

  theplayerinfoform: integer = 26;
  theplayerinfoform2: integer = 27;

  theplaying2: string;

  iscue1: boolean = False;
  hasmixed1: boolean = False;
  hasfocused1: boolean = False;
  iswav: boolean = False;
  plugindex1, PluginIndex2: integer;
  Inputindex1, DSPIndex1, DSPIndex11, Outputindex1, Inputlength1: integer;
  poswav1, chan1: integer;

  waveformdata1: array of cfloat;
  waveformdata2: array of cfloat;

  waveformdataform1: array of cfloat;
  waveformdataform2: array of cfloat;

  buzywaveform1: boolean = False;
  buzywaveform2: boolean = False;

  initwaveform1: boolean = False;
  initwaveform2: boolean = False;

  hascue: boolean = False;
  hascue2: boolean = False;

  totsec1: integer = 0;
  totsec2: integer = 0;
  
   tottime1: ttime;
   tottime2: ttime;
   
    DrawWaveFormbusy1 : boolean = False;
    DrawWaveFormbusy2 : boolean = False;
    
     FormDrawWaveFormbusy1 : boolean = False;
    FormDrawWaveFormbusy2 : boolean = False;

  iscue2: boolean = False;
  iswav2: boolean = False;
  hasmixed2: boolean = False;
  hasfocused2: boolean = False;
  plugindex2, PluginIndex3: integer;
  Inputindex2, DSPIndex2, DSPIndex22, Outputindex2, Inputlength2: integer;
  poswav2, chan2: integer;


implementation

uses
  main, commander, config, waveform, filelistform, drums, spectrum1, dockpanel1,
  songplayer_mfm;

function DSPStereo2Mono(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
var
  x: integer = 0;
  pf: PDArFloat;     //////// if input is Float32 format
  samplef: cFloat;

begin
  if (Data.channels = 2) then
  begin

    pf := @Data.Buffer;
    while x < Data.OutFrames - 1 do
    begin
      samplef := (pf^[x] + pf^[x + 1]) / 2;
      pf^[x] := samplef;
      pf^[x + 1] := samplef;
      x := x + 2;
    end;

    Result := Data.Buffer;
  end
  else
    Result := Data.Buffer;
end;

procedure tsongplayerfo.Changestereo2mono(const Sender: TObject);
begin
  if Caption = 'Player 1' then
   uos_InputSetDSP(theplayer, InputIndex1, DSPIndex11, setmono.Value);
  if Caption = 'Player 2' then 
   uos_InputSetDSP(theplayer2, InputIndex2, DSPIndex22, setmono.Value); 
end;

procedure tsongplayerfo.changereverse(const Sender: TObject);
begin
if Caption = 'Player 1' then
  uos_InputSetDSP(theplayer, InputIndex1, DSPIndex1, playreverse.Value);
if Caption = 'Player 2' then
  uos_InputSetDSP(theplayer2, InputIndex2, DSPIndex2, playreverse.Value);  
end;

function DSPReverseBefore1(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
begin
  if (Data.position > Data.OutFrames div Data.channels) then
    uos_InputSeek(theplayer, InputIndex1, Data.position - (Data.OutFrames div Data.ratio));
end;

function DSPReverseBefore2(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
begin
  if (Data.position > Data.OutFrames div Data.channels) then
    uos_InputSeek(theplayer2, InputIndex2, Data.position - (Data.OutFrames div Data.ratio));    
end;

function DSPReverseAfter(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
var
  x: integer = 0;
  arfl: TDArFloat;

begin
  if (Data.position > Data.OutFrames div Data.channels) then
  begin
    SetLength(arfl, Data.outframes);
     {
       while x < Data.outframes do
     begin
     arfl[x] := 0.0;
     x := x +1;
     end;
     }

    x := 0;

    while x < Data.outframes - 1 do
    begin
      arfl[x] := (Data.Buffer[Data.outframes - x - 2]);
      arfl[x + 1] := (Data.Buffer[Data.outframes - x - 1]);
      x := x + 2;
    end;
    Result := arfl;
  end
  else
    Result := Data.Buffer;
end;



procedure tsongplayerfo.ontimersent(const Sender: TObject);
begin
 // timersent.Enabled := False;
  hintpanel.Visible := False;
  historyfn.face.template := mainfo.tfaceplayerlight;
  edvolleft.face.template := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template := mainfo.tfaceplayer;
  button1.face.template := mainfo.tfaceplayer;
  button2.face.template := mainfo.tfaceplayer;
end;

procedure tsongplayerfo.ontimerwait(const Sender: TObject);
begin

  if Caption = 'Player 1' then
  begin
  //  timerwait.Enabled := False;
    btnStart.Enabled := True;
    btnStop.Enabled := True;
    btncue.Enabled := False;

    with commanderfo do
    begin
      btncue.Enabled := False;
      btnStart.Enabled := True;
      btnStop.Enabled := True;
      if (cbloop.Value = False) and (iscue1 = False) then
        btnPause.Enabled := True
      else
        btnPause.Enabled := False;

      if iscue1 then
      begin
        btnPause.Visible := False;
        btnresume.Enabled := True;
        btnresume.Visible := True;
      end
      else
      begin
        btnPause.Visible := True;
        btnresume.Visible := False;
        btnresume.Enabled := False;
      end;
    end;


    if (cbloop.Value = False) and (iscue1 = False) then
      btnPause.Enabled := True
    else
      btnPause.Enabled := False;

    if iscue1 then
    begin
      btnPause.Visible := False;
      btnresume.Enabled := True;
      btnresume.Visible := True;
    end
    else
    begin
      btnPause.Visible := True;
      btnresume.Visible := False;
      btnresume.Enabled := False;
    end;

    cbloop.Enabled := False;
    trackbar1.Enabled := True;
    wavefo.trackbar1.Enabled := True;
  end;


  if Caption = 'Player 2' then
  begin
    // timerwait.Enabled := False;
    btnStart.Enabled := True;
    btnStop.Enabled := True;
    btncue.Enabled := False;

    with commanderfo do
    begin
      btncue2.Enabled := False;
      btnStart2.Enabled := True;
      btnStop2.Enabled := True;
      if (cbloop.Value = False) and (iscue2 = False) then
        btnPause2.Enabled := True
      else
        btnPause2.Enabled := False;
      if iscue2 then
      begin
        btnPause2.Visible := False;
        btnresume2.Enabled := True;
        btnresume2.Visible := True;
      end
      else
      begin
        btnPause2.Visible := True;
        btnresume2.Visible := False;
        btnresume2.Enabled := False;
      end;
    end;


    if (cbloop.Value = False) and (iscue2 = False) then
      btnPause.Enabled := True
    else
      btnPause.Enabled := False;

    if iscue2 then
    begin
      btnPause.Visible := False;
      btnresume.Enabled := True;
      btnresume.Visible := True;
    end
    else
    begin
      btnPause.Visible := True;
      btnresume.Visible := False;
      btnresume.Enabled := False;
    end;

    cbloop.Enabled := False;
    trackbar1.Enabled := True;
    wavefo2.trackbar1.Enabled := True;
  end;

end;


procedure tsongplayerfo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if hasinit = 1 then
  begin

    if Caption = 'Player 1' then
      if (trim(PChar(ansistring(songplayerfo.historyfn.Value))) <> '') and fileexists(ansistring(songplayerfo.historyfn.Value)) then
      begin

        if cbtempo.Value = True then
        begin
          edtempo.face.template := mainfo.tfaceorange;
          
          if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
          
           end;

        uos_SetPluginSoundTouch(theplayer, PluginIndex2, edtempo.Value, 1, cbtempo.Value);

      end;

    if Caption = 'Player 2' then
      if (trim(PChar(ansistring(songplayer2fo.historyfn.Value))) <> '') and fileexists(ansistring(songplayer2fo.historyfn.Value)) then
      begin

        if cbtempo.Value = True then
        begin
          edtempo.face.template := mainfo.tfaceorange;
          
         if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
        end;

        uos_SetPluginSoundTouch(theplayer2, PluginIndex3, edtempo.Value, 1, cbtempo.Value);

      end;
  end;
end;

procedure tsongplayerfo.resetspectrum();
var
  i: integer = 0;
begin
  if Caption = 'Player 1' then
  begin
    while i < 10 do
    begin
      arl[i] := 0;
      arr[i] := 0;
      Inc(i);
    end;

    spectrum1fo.tchartleft.traces[0].ydata := arl;
    spectrum1fo.tchartright.traces[0].ydata := arr;
  end;

  if Caption = 'Player 2' then
  begin
    while i < 10 do
    begin
      arl2[i] := 0;
      arr2[i] := 0;
      Inc(i);
    end;

    spectrum2fo.tchartleft.traces[0].ydata := arl2;
    spectrum2fo.tchartright.traces[0].ydata := arr2;
  end;

end;

procedure tsongplayerfo.ClosePlayer1();
begin

  if Caption = 'Player 1' then
  begin
    if (commanderfo.automix.Value = True) and (hasmixed1 = False) then
    begin
      hasmixed1 := True;
      commanderfo.onstartstop(nil);
      hasfocused1 := True;
      filelistfo.onsent(nil);
      hasfocused1 := False;
      hasmixed1 := False;
    end;
  end;

  if Caption = 'Player 2' then
  begin
    if (commanderfo.automix.Value = True) and (hasmixed2 = False) then
    begin
      hasmixed2 := True;
      commanderfo.onstartstop(nil);
      hasfocused2 := True;
      filelistfo.onsent(nil);
      hasfocused2 := False;
      hasmixed2 := False;
    end;
  end;

  vuright.Value := 0;
  vuRight.Visible := False;

  vuleft.Value := 0;
  vuleft.Visible := False;

  button2.Caption := 'BPM';

  btnStart.Enabled := True;
  btnStop.Enabled := False;
  btnPause.Enabled := False;
  btnresume.Enabled := False;

  btnPause.Visible := True;
  btnresume.Visible := False;

  if cbloop.Value then
    btncue.Enabled := False
  else
    btncue.Enabled := True;

  if Caption = 'Player 1' then
  begin
    theplaying1 := '';

    iswav := False;
    iscue1 := False;

    if uos_GetStatus(theplayer) <> 1 then
    begin
      tstringdisp1.Value := '';
      tstringdisp1.face.template := mainfo.tfaceplayer;
    end;
    with commanderfo do
    begin
      if cbloop.Value then
        btncue.Enabled := False
      else
        btncue.Enabled := True;
      btnStart.Enabled := True;
      btnStop.Enabled := False;
      btnPause.Enabled := False;
      btnresume.Enabled := False;

      btnPause.Visible := True;
      btnresume.Visible := False;
      vuLeft.Visible := False;
      vuRight.Visible := False;
    end;
    wavefo.trackbar1.Value := 0;
    wavefo.container.frame.scrollpos_x := 0;
    wavefo.trackbar1.Enabled := False;
    hasmixed1 := False;
  end;

  if Caption = 'Player 2' then
  begin
    theplaying2 := '';
    iswav2 := False;
    iscue2 := False;

    if uos_GetStatus(theplayer2) <> 1 then
    begin
      tstringdisp1.Value := '';
      tstringdisp1.face.template := mainfo.tfaceplayer;
    end;
    with commanderfo do
    begin
      if cbloop.Value then
        btncue2.Enabled := False
      else
        btncue2.Enabled := True;
      btnStart2.Enabled := True;
      btnStop2.Enabled := False;
      btnPause2.Enabled := False;
      btnresume2.Enabled := False;
      vuLeft2.Visible := False;
      vuRight2.Visible := False;
    end;
    hasmixed2 := False;
    wavefo2.trackbar1.Value := 0;
    wavefo2.container.frame.scrollpos_x := 0;
    wavefo2.trackbar1.Enabled := False;
  end;

  cbloop.Enabled := True;
  trackbar1.Value := 0;
  trackbar1.Enabled := False;

  lposition.Value := '00:00:00.000';
  lposition.face.template := mainfo.tfaceplayer;

   DrawWaveForm();

   formDrawWaveForm();

  resetspectrum();

end;

procedure tsongplayerfo.ShowSpectrum(const Sender: TObject);

var
  i, x: integer;

begin
  if Caption = 'Player 1' then
  begin
    if uos_getstatus(theplayer) > 0 then
    begin
      thearray := uos_InputFiltersGetLevelArray(theplayer, InputIndex1);
      x := 0;
      i := 0;
      while x < length(thearray) - 1 do
      begin
        arl[i] := thearray[x];
        arr[i] := thearray[x + 1];
        x := x + 2;
        Inc(i);
      end;

      spectrum1fo.tchartleft.traces[0].ydata := arl;
      spectrum1fo.tchartright.traces[0].ydata := arr;
    end;
  end;

  if Caption = 'Player 2' then
  begin
    if uos_getstatus(theplayer2) > 0 then
    begin
      i := 1;
      thearray2 := uos_InputFiltersGetLevelArray(theplayer2, InputIndex2);
      x := 0;
      i := 0;
      while x < length(thearray2) - 1 do
      begin
        arl2[i] := thearray2[x];
        arr2[i] := thearray2[x + 1];
        x := x + 2;
        Inc(i);
      end;

      spectrum2fo.tchartleft.traces[0].ydata := arl2;
      spectrum2fo.tchartright.traces[0].ydata := arr2;
    end;
  end;

end;

procedure tsongplayerfo.ShowLevel(const Sender: TObject);

var
  leftlev, rightlev: double;
begin

  vuLeft.Visible := True;
  vuRight.Visible := True;

  if Caption = 'Player 1' then
  begin
    if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
    begin
      commanderfo.vuLeft.Visible := True;
      commanderfo.vuRight.Visible := True;
    end
    else
    begin
      commanderfo.vuLeft.Visible := False;
      commanderfo.vuRight.Visible := False;
    end;

    leftlev := uos_InputGetLevelLeft(theplayer, Inputindex1);
    rightlev := uos_InputGetLevelRight(theplayer, Inputindex1);
  end;

  if Caption = 'Player 2' then
  begin
    if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
    begin
      commanderfo.vuLeft2.Visible := True;
      commanderfo.vuRight2.Visible := True;
    end
    else
    begin
      commanderfo.vuLeft2.Visible := False;
      commanderfo.vuRight2.Visible := False;
    end;

    leftlev := uos_InputGetLevelLeft(theplayer2, Inputindex2);
    rightlev := uos_InputGetLevelRight(theplayer2, Inputindex2);
  end;



  if (leftlev >= 0) and (leftlev < 1) then
  begin
    vuLeft.Value := leftlev;
    if Caption = 'Player 1' then
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuLeft.Value := leftlev;

    if Caption = 'Player 2' then
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuLeft2.Value := leftlev;
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin
    vuright.Value := rightlev;
    if Caption = 'Player 1' then
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuright.Value := rightlev;

    if Caption = 'Player 2' then
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuright2.Value := rightlev;
  end;

end;

procedure tsongplayerfo.ShowPosition(const Sender: TObject);

var
  temptime: ttime;
  ho, mi, se, ms: word;
  mixtime, rat: integer;

begin

  if (not TrackBar1.clicked) then
  begin
    if (Caption = 'Player 1')  and (not wavefo.TrackBar1.clicked) then
      if uos_InputPosition(theplayer, Inputindex1) > 0 then
      begin
        TrackBar1.Value := uos_InputPosition(theplayer, Inputindex1) / Inputlength1;

        if (wavefo.Visible = True) and (as_checked in wavefo.tmainmenu1.menu[0].state) then
        begin

          wavefo.TrackBar1.Value := TrackBar1.Value;

          if ((wavefo.TrackBar1.Value * wavefo.TrackBar1.Width) > (wavefo.Width - 10)) and (as_checked in wavefo.tmainmenu1.menu[8].state) then
          begin

            rat := trunc((wavefo.TrackBar1.Value * wavefo.TrackBar1.Width) / (wavefo.Width - 10));
            if (((wavefo.Width - 10) * rat) * -1) <> wavefo.container.frame.scrollpos_x then
              wavefo.container.frame.scrollpos_x := (((wavefo.Width - 10) * rat) * -1);

          end;
        end;

        temptime := uos_InputPositionTime(theplayer, Inputindex1);
        ////// Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
        mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;
        if Inputlength1 < mixtime + 50000 then
          mixtime := Inputlength1 - 50000;

        if (commanderfo.automix.Value = True) and (hasmixed1 = False) and (uos_InputPosition(theplayer, Inputindex1) > Inputlength1 - mixtime) then
        begin
          hasmixed1 := True;
          commanderfo.onstartstop(nil);
          hasfocused1 := True;
          filelistfo.onsent(nil);
          hasfocused1 := False;
        end;
      end;

    if (Caption = 'Player 2')  and (not wavefo2.TrackBar1.clicked) then
      if uos_InputPosition(theplayer2, Inputindex2) > 0 then
      begin
        TrackBar1.Value := uos_InputPosition(theplayer2, Inputindex2) / Inputlength2;

        if (wavefo2.Visible = True) and (as_checked in wavefo2.tmainmenu1.menu[0].state) then
        begin

          wavefo2.TrackBar1.Value := TrackBar1.Value;

          if ((wavefo2.TrackBar1.Value * wavefo2.TrackBar1.Width) > (wavefo2.Width - 10)) and (as_checked in wavefo2.tmainmenu1.menu[8].state) then
          begin

            rat := trunc((wavefo2.TrackBar1.Value * wavefo2.TrackBar1.Width) / (wavefo2.Width - 10));
            if (((wavefo2.Width - 10) * rat) * -1) <> wavefo2.container.frame.scrollpos_x then
              wavefo2.container.frame.scrollpos_x := (((wavefo2.Width - 10) * rat) * -1);
          end;
        end;

        temptime := uos_InputPositionTime(theplayer2, Inputindex2);
        ////// Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
        mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;
        if Inputlength2 < mixtime + 50000 then
          mixtime := Inputlength2 - 50000;
        if (commanderfo.automix.Value = True) and (hasmixed2 = False) and (uos_InputPosition(theplayer2, Inputindex2) >
          Inputlength2 - mixtime) then
        begin
          hasmixed2 := True;
          commanderfo.onstartstop(nil);
          hasfocused2 := True;
          filelistfo.onsent(nil);
          hasfocused2 := False;
        end;
      end;

  end;

end;

procedure tsongplayerfo.LoopProcPlayer1();

begin
  if (Visible = True) then
    ShowPosition(nil);

  if (commanderfo.vuin.Value = True) and (Visible = True) then
    ShowLevel(nil);

  if Caption = 'Player 1' then
    if (spectrum1fo.spect1.Value = True) and (spectrum1fo.Visible = True) and (configfo.speccalc.Value = True) then
      ShowSpectrum(nil);

  if Caption = 'Player 2' then
    if (spectrum2fo.spect1.Value = True) and (spectrum2fo.Visible = True) and (configfo.speccalc.Value = True) then
      ShowSpectrum(nil);

end;

procedure tsongplayerfo.doplayerstart(const Sender: TObject);
var
  samformat, hassent: shortint;
  ho, mi, se, ms: word;
  fileex: string;
  i: integer;
begin
  if Caption = 'Player 1' then
  begin
    fileex := fileext(PChar(ansistring(historyfn.Value)));

    if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or
      (fileex = 'FLAC') or (fileex = 'mp3') or (fileex = 'MP3') then
    begin

      if fileexists(historyfn.Value) then
      begin
        samformat := 0;

        //  songdir.hint := songdir.value;


        // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
        // If PlayerIndex exists already, it will be overwritten...

        uos_Stop(theplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

        if uos_CreatePlayer(theplayer) then
          //// Create the player.
          //// PlayerIndex : from 0 to what your computer can do !
          //// If PlayerIndex exists already, it will be overwriten...

          Inputindex1 := uos_AddFromFile(theplayer, PChar(ansistring(historyfn.Value)), -1, samformat, 1024 * 8);

        //// add input from audio file with custom parameters
        ////////// FileName : filename of audio file
        //////////// PlayerIndex : Index of a existing Player
        ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
        ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
        //////////// FramesCount : default : -1 (65536 div channels)
        //  result : -1 nothing created, otherwise Input Index in array

        if Inputindex1 > -1 then
        begin
          // Outputindex1 := uos_AddIntoDevOut(Playerindex1) ;
          //// add a Output into device with default parameters

          if configfo.latplay.Value < 0 then
            configfo.latplay.Value := -1;

          Outputindex1 := uos_AddIntoDevOut(theplayer, -1, configfo.latplay.Value, uos_InputGetSampleRate(theplayer, Inputindex1),
            uos_InputGetChannels(theplayer, Inputindex1), samformat, 1024 * 8, -1);

          //// add a Output into device with custom parameters
          //////////// PlayerIndex : Index of a existing Player
          //////////// Device ( -1 is default Output device )
          //////////// Latency  ( -1 is latency suggested ) )
          //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
          //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
          //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
          //////////// FramesCount : default : -1 (65536)
          //  result : -1 nothing created, otherwise Output Index in array

          uos_InputSetLevelEnable(theplayer, Inputindex1, 2);
          ///// set calculation of level/volume (usefull for showvolume procedure)
          ///////// set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.
          // 3 => calcul before and after all DSP procedures.

          uos_InputSetPositionEnable(theplayer, Inputindex1, 1);
          ///// set calculation of position (usefull for positions procedure)
          ///////// set position calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul position.

          uos_LoopProcIn(theplayer, Inputindex1, @LoopProcPlayer1);
          ///// Assign the procedure of object to execute inside the loop
          //////////// PlayerIndex : Index of a existing Player
          //////////// Inputindex1 : Index of a existing Input
          //////////// LoopProcPlayer1 : procedure of object to execute inside the loop

          uos_InputAddDSPVolume(theplayer, Inputindex1, 1, 1);
          ///// DSP Volume changer
          ////////// Playerindex1 : Index of a existing Player
          ////////// Inputindex1 : Index of a existing input
          ////////// VolLeft : Left volume
          ////////// VolRight : Right volume

          uos_InputSetDSPVolume(theplayer, Inputindex1,
            (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);
          /// Set volume
          ////////// Playerindex1 : Index of a existing Player
          ////////// Inputindex1 : InputIndex of a existing Input
          ////////// VolLeft : Left volume
          ////////// VolRight : Right volume
          ////////// Enable : Enabled

          DSPindex1 := uos_InputAddDSP(theplayer, Inputindex1, @DSPReverseBefore1, @DSPReverseAfter, nil, nil);
          ///// add a custom DSP procedure for input
          ////////// Playerindex1 : Index of a existing Player
          ////////// Inputindex1: InputIndex of existing input
          ////////// BeforeFunc : function to do before the buffer is filled
          ////////// AfterFunc : function to do after the buffer is filled
          ////////// EndedFunc : function to do at end of thread
          ////////// LoopProc : external procedure to do after the buffer is filled

          //// set the parameters of custom DSP
          //  playreverse.value := false;

          uos_InputSetDSP(theplayer, Inputindex1, DSPindex1, playreverse.Value);


          // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
          DSPindex11 := uos_InputAddDSP(theplayer, Inputindex1, nil, @DSPStereo2Mono, nil, nil);
          uos_InputSetDSP(theplayer, Inputindex1, DSPindex11, setmono.Value);

          if configfo.speccalc.Value = True then
            for i := 1 to 10 do
              uos_InputAddFilter(theplayer, InputIndex1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, 3, False, nil);


  { ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
  if plugbs2b = true then
  begin
   PlugInindex1 := uos_AddPlugin(Playerindex1, 'bs2b',
   uos_InputGetSampleRate(Playerindex1, Inputindex1) , -1);
   uos_SetPluginbs2b(Playerindex1, Pluginindex1, -1 , -1, -1, chkst2b.value);
  end;


  }
          /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
          /// SoundTouch plugin should be the last added.
          if plugsoundtouch = True then
          begin
            PluginIndex2 := uos_AddPlugin(theplayer, 'soundtouch', uos_InputGetSampleRate(theplayer, Inputindex1), -1);
            ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
          end;

          Inputlength1 := uos_Inputlength(theplayer, Inputindex1);
          ////// Length of Input in samples

          tottime1 := uos_InputlengthTime(theplayer, Inputindex1);
          ////// Length of input in time

          DecodeTime(tottime1, ho, mi, se, ms);

          totsec1 := (ho * 3600) + (mi * 60) + se;

          llength.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

          uos_EndProc(theplayer, @ClosePlayer1);

          /////// procedure to execute when stream is terminated
          ///// Assign the procedure of object to execute at end
          //////////// PlayerIndex : Index of a existing Player
          //////////// ClosePlayer1 : procedure of object to execute inside the general loop

          btinfos.Enabled := True;

          hasmixed1 := False;

          trackbar1.Value := 0;
          trackbar1.Enabled := True;

          wavefo.trackbar1.Value := 0;
          wavefo.container.frame.scrollpos_x := 0;
          wavefo.trackbar1.Enabled := True;

          theplaying1 := historyfn.Value;

          with commanderfo do
          begin
            btnStop.Enabled := True;
            btnresume.Enabled := False;
            btnresume.Visible := False;
            if cbloop.Value = True then
            begin
              btnPause.Enabled := False;
              btnPause.Visible := True;
            end
            else
            begin
              btnPause.Visible := True;
              btnPause.Enabled := True;
            end;

          end;

          btnStop.Enabled := True;

          if Sender <> nil then
          begin
            if (TButton(Sender).tag = 0) or (TButton(Sender).tag = 2) then
              hassent := 0;
            if (TButton(Sender).tag = 1) or (TButton(Sender).tag = 3) then
              hassent := 1;
          end
          else
          begin
            hassent := 0;
          end;

          if hassent = 0 then
          begin
            iscue1 := False;
            btnresume.Enabled := False;
            btnresume.Visible := False;
            if cbloop.Value = True then
            begin
              uos_Play(theplayer, -1);
              btnpause.Visible := True;
              btnpause.Enabled := False;
            end
            else
            begin
              uos_Play(theplayer);  /////// everything is ready, here we are, lets play it...
              btnpause.Enabled := True;
              btnpause.Visible := True;
            end;
            tstringdisp1.face.template := mainfo.tfacegreen;
            tstringdisp1.Value := 'Playing ' + theplaying1;
          end;

          if hassent = 1 then  /// cue
          begin
            iscue1 := True;
            btnresume.Enabled := True;
            btnresume.Visible := True;
            btnpause.Visible := False;

            if cbloop.Value = True then
            begin
              uos_Play(theplayer, -1);
              btnpause.Enabled := False;
            end
            else
            begin
              uos_Play(theplayer);  /////// everything is ready, here we are, lets play it...
              btnpause.Enabled := False;
            end;
            uos_Pause(theplayer);
            tstringdisp1.face.template := mainfo.tfaceorange;
            tstringdisp1.Value := 'Loaded ' + theplaying1;
          end;

          cbloop.Enabled := False;
          songdir.Value := historyfn.Value;
          historyfn.hint := historyfn.Value;
          if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
          lposition.face.template := mainfo.tfaceplayerrev;

             //  application.ProcessMessages;

          hascue := True;
          
             oninfowav(Sender); 

          if as_checked in wavefo.tmainmenu1.menu[0].state then
          begin

           wavefo.doechelle(Sender);
           
           //   onwavform(Sender);
           ttimer1.enabled := false;
           ttimer1.enabled := true;
           
          end;
                
        end
        else
          ShowMessage(historyfn.Value + ' cannot load...');

      end
      else;
      //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
    end
    else
      ShowMessage(historyfn.Value + ' is not a audio file...');
  end;

  if Caption = 'Player 2' then
  begin
    fileex := fileext(PChar(ansistring(historyfn.Value)));

    if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or
      (fileex = 'FLAC') or (fileex = 'mp3') or (fileex = 'MP3') then
    begin

      // writeln('avant tout');
      if fileexists(historyfn.Value) then
      begin
        samformat := 0;

        //  songdir.hint := songdir.value;


        // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
        // If PlayerIndex exists already, it will be overwritten...
        //  hasbegin := true;
        //  hasbegin := true;
        uos_Stop(theplayer2); // done by  uos_CreatePlayer() but faster if already done before (no check)

        if uos_CreatePlayer(theplayer2) then
          //// Create the player.
          //// PlayerIndex : from 0 to what your computer can do !
          //// If PlayerIndex exists already, it will be overwriten...

          Inputindex2 := uos_AddFromFile(theplayer2, PChar(ansistring(historyfn.Value)), -1, samformat, 1024 * 8);

        //// add input from audio file with custom parameters
        ////////// FileName : filename of audio file
        //////////// PlayerIndex : Index of a existing Player
        ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
        ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
        //////////// FramesCount : default : -1 (65536 div channels)
        //  result : -1 nothing created, otherwise Input Index in array

        if Inputindex2 > -1 then
        begin

          //   writeln('ok index');
          // Outputindex2 := uos_AddIntoDevOut(Playerindex2) ;
          //// add a Output into device with default parameters

          if configfo.latplay.Value < 0 then
            configfo.latplay.Value := -1;

          Outputindex2 := uos_AddIntoDevOut(theplayer2, -1, configfo.latplay.Value, uos_InputGetSampleRate(theplayer2, Inputindex2),
            uos_InputGetChannels(theplayer2, Inputindex2), samformat, 1024 * 16, -1);

          //// add a Output into device with custom parameters
          //////////// PlayerIndex : Index of a existing Player
          //////////// Device ( -1 is default Output device )
          //////////// Latency  ( -1 is latency suggested ) )
          //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
          //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
          //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
          //////////// FramesCount : default : -1 (65536)
          //  result : -1 nothing created, otherwise Output Index in array

          uos_InputSetLevelEnable(theplayer2, Inputindex2, 2);
          ///// set calculation of level/volume (usefull for showvolume procedure)
          ///////// set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.
          // 3 => calcul before and after all DSP procedures.

          uos_InputSetPositionEnable(theplayer2, Inputindex2, 1);
          ///// set calculation of position (usefull for positions procedure)
          ///////// set position calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul position.

          uos_LoopProcIn(theplayer2, Inputindex2, @LoopProcPlayer1);

          ///// Assign the procedure of object to execute inside the loop
          //////////// PlayerIndex : Index of a existing Player
          //////////// Inputindex2 : Index of a existing Input
          //////////// LoopProcPlayer1 : procedure of object to execute inside the loop

          uos_InputAddDSPVolume(theplayer2, Inputindex2, 1, 1);
          ///// DSP Volume changer
          ////////// Playerindex2 : Index of a existing Player
          ////////// Inputindex2 : Index of a existing input
          ////////// VolLeft : Left volume
          ////////// VolRight : Right volume


          uos_InputSetDSPVolume(theplayer2, Inputindex2,
            (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);


          /// Set volume
          ////////// Playerindex2 : Index of a existing Player
          ////////// Inputindex2 : InputIndex of a existing Input
          ////////// VolLeft : Left volume
          ////////// VolRight : Right volume
          ////////// Enable : Enabled


          DSPindex2 := uos_InputAddDSP(theplayer2, Inputindex2, @DSPReverseBefore2, @DSPReverseAfter, nil, nil);
          ///// add a custom DSP procedure for input
          ////////// Playerindex2 : Index of a existing Player
          ////////// Inputindex2: InputIndex of existing input
          ////////// BeforeFunc : function to do before the buffer is filled
          ////////// AfterFunc : function to do after the buffer is filled
          ////////// EndedFunc : function to do at end of thread
          ////////// LoopProc : external procedure to do after the buffer is filled

          //// set the parameters of custom DSP
          uos_InputSetDSP(theplayer2, Inputindex2, DSPindex2, playreverse.Value);


          // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
          DSPindex22 := uos_InputAddDSP(theplayer2, Inputindex2, nil, @DSPStereo2Mono, nil, nil);
          uos_InputSetDSP(theplayer2, Inputindex2, DSPindex22, setmono.Value);


          if configfo.speccalc.Value = True then
            for i := 1 to 10 do
              uos_InputAddFilter(theplayer2, Inputindex2, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, 3, False, nil);


{
   ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
  if plugbs2b = true then
  begin
   PlugInindex2 := uos_AddPlugin(Playerindex2, 'bs2b',
   uos_InputGetSampleRate(Playerindex2, Inputindex2) , -1);
   uos_SetPluginbs2b(Playerindex2, Pluginindex2, -1 , -1, -1, chkst2b.value);
  end;


  }
          /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
          /// SoundTouch plugin should be the last added.
          if plugsoundtouch = True then
          begin
            PluginIndex3 := uos_AddPlugin(theplayer2, 'soundtouch', uos_InputGetSampleRate(theplayer2, Inputindex2), -1);
            ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
          end;

          Inputlength2 := uos_Inputlength(theplayer2, Inputindex2);
          ////// Length of Input in samples

          tottime2 := uos_InputlengthTime(theplayer2, Inputindex2);
          ////// Length of input in time

          DecodeTime(tottime2, ho, mi, se, ms);

          totsec2 := (ho * 3600) + (mi * 60) + se;

          llength.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

          uos_EndProc(theplayer2, @ClosePlayer1);

          /////// procedure to execute when stream is terminated
          ///// Assign the procedure of object to execute at end
          //////////// PlayerIndex : Index of a existing Player
          //////////// ClosePlayer1 : procedure of object to execute inside the general loop

          btinfos.Enabled := True;

          trackbar1.Value := 0;
          trackbar1.Enabled := True;

          wavefo2.trackbar1.Value := 0;
          wavefo2.container.frame.scrollpos_x := 0;
          wavefo2.trackbar1.Enabled := True;

          theplaying2 := historyfn.Value;

          with commanderfo do
          begin
            btnStop2.Enabled := True;
            btnresume2.Enabled := False;
            btnresume2.Visible := False;
            btnPause2.Enabled := True;
            if cbloop.Value = True then
            begin
              btnPause2.Enabled := False;
            end
            else
            begin
              btnPause2.Enabled := True;
            end;

          end;

          btnStop.Enabled := True;

          hasmixed2 := False;

          if Sender <> nil then
          begin
            if (TButton(Sender).tag = 0) or (TButton(Sender).tag = 2) or (TButton(Sender).tag = 4) then
              hassent := 0;
            if (TButton(Sender).tag = 1) or (TButton(Sender).tag = 5) then
              hassent := 1;
          end
          else
          begin
            hassent := 0;
          end;

          if hassent = 0 then
          begin
            //   writeln('tbutton(sender).tag = 0');
            iscue2 := False;
            btnresume.Enabled := False;
            btnresume.Visible := False;

            if cbloop.Value = True then
            begin
              uos_Play(theplayer2, -1);
              btnpause.Enabled := False;
              btnpause.Visible := True;
            end
            else
            begin
              uos_Play(theplayer2);  /////// everything is ready, here we are, lets play it...
              btnpause.Enabled := True;
              btnpause.Visible := True;
            end;
            tstringdisp1.face.template := mainfo.tfacegreen;
            tstringdisp1.Value := 'Playing ' + theplaying2;
          end;

          if hassent = 1 then  /// cue
          begin
            // writeln('tbutton(sender).tag = 1');
            iscue2 := True;
            btnresume.Enabled := True;
            btnpause.Visible := False;
            btnresume.Visible := True;

            if cbloop.Value = True then
            begin
              uos_Play(theplayer2, -1);
              btnpause.Enabled := False;
            end
            else
            begin
              uos_Play(theplayer2);  /////// everything is ready, here we are, lets play it...
              btnpause.Enabled := False;
            end;
            uos_Pause(theplayer2);
            tstringdisp1.face.template := mainfo.tfaceorange;
            tstringdisp1.Value := 'Loaded ' + theplaying2;
          end;

          cbloop.Enabled := False;
          songdir.Value := historyfn.Value;
          historyfn.hint := historyfn.Value;
          if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
          lposition.face.template := mainfo.tfaceplayerrev;

          hascue2 := True;
          oninfowav(Sender);
          //  application.ProcessMessages;

          if as_checked in wavefo2.tmainmenu1.menu[0].state then
          begin

            wavefo2.doechelle(nil);
            ttimer1.enabled := false;
            ttimer1.enabled := true;
             //  onwavform(Sender);
           end;

        end
        else
          ShowMessage(historyfn.Value + ' cannot load...');

      end
      else;
      //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
    end
    else
      ShowMessage(historyfn.Value + ' is not a audio file...');
  end;

end;

procedure tsongplayerfo.doplayeresume(const Sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;
  btnPause.Visible := True;
  btnresume.Visible := False;

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template := mainfo.tfaceplayerrev;

  if Caption = 'Player 1' then
  begin

    with commanderfo do
    begin
      btnStop.Enabled := True;
      btnPause.Enabled := True;
      btnresume.Enabled := False;

      btnPause.Visible := True;
      btnresume.Visible := False;
    end;

    uos_RePlay(theplayer);

    iscue1 := False;

    tstringdisp1.Value := 'Playing ' + theplaying1;
  end;

  if Caption = 'Player 2' then
  begin
    with commanderfo do
    begin
      btnStop2.Enabled := True;
      btnPause2.Enabled := True;
      btnresume2.Enabled := False;
      btnPause2.Visible := True;
      btnresume2.Visible := False;
    end;

    uos_RePlay(theplayer2);
    iscue2 := False;
    tstringdisp1.Value := 'Playing ' + theplaying2;
  end;

end;

procedure tsongplayerfo.doplayerpause(const Sender: TObject);
begin
  vuLeft.Visible := False;
  vuRight.Visible := False;
  vuright.Height := 0;
  vuleft.Height := 0;

  btnStop.Enabled := True;
  btnPause.Enabled := False;
  btnresume.Enabled := True;

  btnPause.Visible := False;
  btnresume.Visible := True;

  tstringdisp1.face.template := mainfo.tfacered;
  lposition.face.template := mainfo.tfaceplayer;

  if Caption = 'Player 1' then
  begin
    with commanderfo do
    begin
      vuLeft.Visible := False;
      vuRight.Visible := False;
      vuright.Height := 0;
      vuleft.Height := 0;
      btnStop.Enabled := True;
      btnPause.Enabled := False;
      btnresume.Enabled := True;
      btnPause.Visible := False;
      btnresume.Visible := True;
    end;

    uos_Pause(theplayer);

    tstringdisp1.Value := 'Paused ' + theplaying1;
  end;

  if Caption = 'Player 2' then
  begin
    with commanderfo do
    begin
      vuLeft2.Visible := False;
      vuRight2.Visible := False;
      vuright2.Height := 0;
      vuleft2.Height := 0;
      btnStop2.Enabled := True;
      btnPause2.Enabled := False;
      btnresume2.Enabled := True;
      btnPause2.Visible := False;
      btnresume2.Visible := True;
    end;

    uos_Pause(theplayer2);
    tstringdisp1.Value := 'Paused ' + theplaying2;
  end;

  resetspectrum();
end;

procedure tsongplayerfo.doplayerstop(const Sender: TObject);
begin
  if Caption = 'Player 1' then
  begin
    hasmixed1 := True;
    uos_Stop(theplayer);
  end;

  if Caption = 'Player 2' then
  begin
    hasmixed2 := True;
    uos_Stop(theplayer2);
  end;
end;

procedure tsongplayerfo.changevolume(const Sender: TObject);
begin

  //if edvolleft.Value := '' then edvolleft.Value := 0;
  //if edvolright.Value := '' then edvolright.Value := 0;

  // if edvolleft.value > 100 then edvolleft.value := 100;

  if hasinit = 1 then
  begin
    if (trealspinedit(Sender).tag = 0) then
      edvolleft.face.template := mainfo.tfaceorange
    else
      edvolright.face.template := mainfo.tfaceorange;

    if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;

{
if  (linkvol.value = true) then
begin
if (trealspinedit(sender).tag = 0)
then edvolright.value := edvolleft.value else
edvolleft.value := edvolright.value
end;
}

    if Caption = 'Player 1' then
      uos_InputSetDSPVolume(theplayer, Inputindex1,
        (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

    if Caption = 'Player 2' then
      uos_InputSetDSPVolume(theplayer2, Inputindex2,
        (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

  end;
end;

procedure tsongplayerfo.onreset(const Sender: TObject);
begin
  edtempo.Value := 1;
  edtempo.face.template := mainfo.tfaceorange;
  button1.face.template := mainfo.tfaceorange;
 if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
end;

procedure tsongplayerfo.paintsliderimage(const canvas: tcanvas; const arect: rectty);
var

  poswav, poswav2: pointty;
  poswavx: integer;
begin

  if Caption = 'Player 1' then
    if (iswav = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (trackbar1.Height div 2) - 2;


      poswav2.x := 6;
      poswav2.y := ((arect.cy div 2) - 2) - round((waveformdata1[poswav.x * 2]) * ((trackbar1.Height div 2) - 3));

      while poswav.x < (length(waveformdata1) div chan1) - 1 do
      begin
        if chan1 = 2 then
        begin
          poswav.y := (trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdata1[poswavx * 2]) * ((arect.cy div 2) - 3));

          //  if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6);
          // else
          //  canvas.drawline(poswav, poswav2, $6A6A6A);

          poswav.y := (trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdata1[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

          //  if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6);
          //  else
          //    canvas.drawline(poswav, poswav2, $8A8A8A);

        end;
        if chan1 = 1 then
        begin
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
        Inc(poswav.x, 1);
      end;
    end;

  if Caption = 'Player 2' then
    if (iswav2 = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (trackbar1.Height div 2) - 2;

      poswav2.x := 6;
      poswav2.y := ((arect.cy div 2) - 2) - round((waveformdata2[poswav.x * 2]) * ((trackbar1.Height div 2) - 3));

      while poswav.x < length(waveformdata2) div chan2 do
      begin
        if chan2 = 2 then
        begin
          poswav.y := (trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdata2[poswavx * 2]) * ((arect.cy div 2) - 3));

          //   if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6);
          // else
          //   canvas.drawline(poswav, poswav2, $6A6A6A);

          poswav.y := (trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdata2[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

          //if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6);
          // else
          //   canvas.drawline(poswav, poswav2, $8A8A8A);

        end;
        if chan2 = 1 then
        begin
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
        Inc(poswav.x, 1);
      end;

    end;

end;


procedure tsongplayerfo.paintsliderimageform(const canvas: tcanvas; const arect: rectty);
var
  poswav, poswav2: pointty;
  poswavx: integer;
begin

  if Caption = 'Player 1' then
    if (iswav = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo.trackbar1.Height div 2) - 2;


      poswav2.x := 6;
      poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform1[poswav.x * 2]) * ((wavefo.trackbar1.Height div 2) - 3));

      while (poswav.x < (length(waveformdataform1) div chan1) - 1) and (poswav.x < wavefo.trackbar1.width) do
      begin
        if chan1 = 2 then
        begin
          poswav.y := (wavefo.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdataform1[poswavx * 2]) * ((arect.cy div 2) - 3));

          // if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6);
          //  else
          //    canvas.drawline(poswav, poswav2, $6A6A6A);

          poswav.y := (wavefo.trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdataform1[(poswavx * 2) + 1]) * ((wavefo.trackbar1.Height div 2) - 3)));

          //  if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6);
          //  else
          //    canvas.drawline(poswav, poswav2, $8A8A8A);

        end;
        if chan1 = 1 then
        begin
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
        Inc(poswav.x, 1);
      end;
    end;

  if Caption = 'Player 2' then
    if (iswav2 = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo2.trackbar1.Height div 2) - 2;


      poswav2.x := 6;
      poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform2[poswav.x * 2]) * ((wavefo2.trackbar1.Height div 2) - 3));

      while (poswav.x < length(waveformdataform2) div chan2) and  (poswav.x < wavefo2.trackbar1.width) do
      begin
        if chan2 = 2 then
        begin
          poswav.y := (wavefo2.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdataform2[poswavx * 2]) * ((arect.cy div 2) - 3));

          // if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6);
          // else
          //  canvas.drawline(poswav, poswav2, $6A6A6A);

          poswav.y := (wavefo2.trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdataform2[(poswavx * 2) + 1]) * ((wavefo2.trackbar1.Height div 2) - 3)));

          // if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6);
          // else
          //  canvas.drawline(poswav, poswav2, $8A8A8A);

        end;
        if chan2 = 1 then
        begin
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
        Inc(poswav.x, 1);
      end;
    end;

end;

procedure tsongplayerfo.GetWaveData();
begin

  if Caption = 'Player 1' then
    if (waveformcheck.Value = True) then
    begin
      waveformdata1 := uos_InputGetLevelArray(theplayerinfo, 0);
      iswav := True;
      DrawWaveForm();
    end;

  if Caption = 'Player 2' then
    if (waveformcheck.Value = True) then
    begin
      waveformdata2 := uos_InputGetLevelArray(theplayerinfo2, 0);
      iswav2 := True;
      DrawWaveForm();
    end;
end;

procedure tsongplayerfo.GetWaveDataform();
begin

  if Caption = 'Player 1' then

    if as_checked in wavefo.tmainmenu1.menu[0].state then

      // if (wavefo.waveon.Value = True) then

    begin
      waveformdataform1 := uos_InputGetLevelArray(theplayerinfoform, 0);
      formDrawWaveForm();
    end;

  if Caption = 'Player 2' then

    if as_checked in wavefo2.tmainmenu1.menu[0].state then

      //   if (wavefo2.waveon.Value = True) then

    begin
      waveformdataform2 := uos_InputGetLevelArray(theplayerinfoform2, 0);
      formDrawWaveForm();
    end;

end;


procedure tsongplayerfo.DrawWaveForm();
const
  transpcolor = cl_magenta;
var
  rect1: rectty;
begin

 if ((Caption = 'Player 1') and (DrawWaveFormbusy1 = false)) or
 ((Caption = 'Player 2') and (DrawWaveFormbusy2 = false)) then
 begin
 
  if Caption = 'Player 1' then DrawWaveFormbusy1 := true;
  if Caption = 'Player 2' then DrawWaveFormbusy2 := true;
 
  // if (waveformcheck.value = true) then begin
  trackbar1.invalidate();

  //  writeln(inttostr(length(waveformdata1)));
  rect1.pos := nullpoint;
  rect1.size := trackbar1.paintsize;


  with sliderimage.bitmap do
  begin
    size := rect1.size;
    masked := False;
    init(transpcolor);
    paintsliderimage(canvas, rect1);
    transparentcolor := transpcolor;
    masked := True;
  end;
   if Caption = 'Player 1' then DrawWaveFormbusy1 := false;
   if Caption = 'Player 2' then DrawWaveFormbusy2 := false;
   end;
end;

procedure tsongplayerfo.FormDrawWaveForm();
const
  transpcolor = cl_gray;
var
  rect1form: rectty;
begin

  if (Caption = 'Player 1')  and 
  (FormDrawWaveFormbusy1 = false) and
   (as_checked in wavefo.tmainmenu1.menu[0].state) then
  begin
   FormDrawWaveFormbusy1 := true;
  wavefo.trackbar1.invalidate();

    rect1form.pos := nullpoint;
    rect1form.size := wavefo.trackbar1.paintsize;

    with wavefo.sliderimage.bitmap do
    begin
      size := rect1form.size;
      masked := False;
      init(transpcolor);
      paintsliderimageform(canvas, rect1form);
      transparentcolor := transpcolor;
      masked := True;
    end;
    buzywaveform1 := False;
   FormDrawWaveFormbusy1 := false; 
  end;

  if (Caption = 'Player 2')
    and (FormDrawWaveFormbusy2 = false) 
   and (as_checked in wavefo2.tmainmenu1.menu[0].state) then
  begin
  FormDrawWaveFormbusy2 := true; 
    wavefo2.trackbar1.invalidate();

    rect1form.pos := nullpoint;
    rect1form.size := wavefo2.trackbar1.paintsize;

    with wavefo2.sliderimage.bitmap do
    begin
      size := rect1form.size;
      masked := False;
      init(transpcolor);
      paintsliderimageform(canvas, rect1form);
      transparentcolor := transpcolor;
      masked := True;
    end;
    buzywaveform2 := False;
     FormDrawWaveFormbusy2 := false; 
  end;

end;

procedure tsongplayerfo.onwavform(const Sender: TObject);
var
  framewanted: integer;

begin

  if (Caption = 'Player 1') and (as_checked in wavefo.tmainmenu1.menu[0].state) 
 and (buzywaveform1 = False)
  then
  begin
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      //   if initwaveform1 = False then
      //   thebuffer := uos_File2Buffer(pchar(historyfn.Value), 0, thebufferinfos, -1, -1);

      // initwaveform1 := true;

      //  ttimer1.enabled := true;

      //{
      
       uos_Stop(theplayerinfoform);
      if uos_CreatePlayer(theplayerinfoform) then
        //// Create the player.
        //// PlayerIndex : from 0 to what your computer can do !
        //// If PlayerIndex exists already, it will be overwriten...

        //  if uos_AddFromMemoryBuffer(theplayerinfoform,thebuffer,thebufferinfos, -1, 1024)> -1 then


        if uos_AddFromFile(theplayerinfoform, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
        begin

          buzywaveform1 := True;

          uos_InputSetLevelArrayEnable(theplayerinfoform, 0, 2);
          ///////// set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.

          //// determine how much frame will be designed
        if  (wavefo.trackbar1.Width < Inputlength1 div 64) then
        else
        begin
         wavefo.trackbar1.Width := wavefo.width -10;
          wavefo.doechelle(nil);
          wavefo.tmainmenu1.menu[2].Caption := ' Now=X1 ' 
        end;
           
          framewanted := Inputlength1 div (wavefo.trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfoform, 0, framewanted);

          ///// Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfoform, @GetWaveDataform);

          uos_Play(theplayerinfoform);  /////// everything is ready, here we are, lets do it...

        end;

      //   }
    end;
  end;

  if (Caption = 'Player 2') and (as_checked in wavefo2.tmainmenu1.menu[0].state) and (buzywaveform2 = False) then
  begin
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      uos_Stop(theplayerinfoform2);

      //  if initwaveform2 = False then

      //  thebuffer2 := uos_File2Buffer(pchar(historyfn.Value), 0, thebufferinfos2, -1, -1);

      initwaveform2 := True;


      if uos_CreatePlayer(theplayerinfoform2) then
        //// Create the player.
        //// PlayerIndex : from 0 to what your computer can do !
        //// If PlayerIndex exists already, it will be overwriten...

        //  if uos_AddFromMemoryBuffer(theplayerinfoform2,thebuffer2,thebufferinfos2, -1, 1024)> -1 then

        if uos_AddFromFile(theplayerinfoform2, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
        begin
          buzywaveform2 := True;

          uos_InputSetLevelArrayEnable(theplayerinfoform2, 0, 2);
          ///////// set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.

          //// determine how much frame will be designed
           if  (wavefo2.trackbar1.Width < Inputlength2 div 64) then
        else 
        begin
        wavefo2.trackbar1.Width := wavefo.width -10;
        wavefo2.doechelle(nil);
        wavefo2.tmainmenu1.menu[2].Caption := ' Now=X1 ' 
        end;
               
          framewanted := Inputlength2 div (wavefo2.trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfoform2, 0, framewanted);

          ///// Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfoform2, @GetWaveDataform);

          uos_Play(theplayerinfoform2);  /////// everything is ready, here we are, lets do it...

        end;
    end;
  end;

end;


////////


procedure tsongplayerfo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  hassent: shortint;
  ho, mi, se, ms: word;
  framewanted: integer;
  fileex: string;
  thebuffer: TDArFloat;
  thebufferinfos: TuosF_BufferInfos;

begin

  if Caption = 'Player 1' then
  begin
    fileex := fileext(PChar(ansistring(historyfn.Value)));

    if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or
      (fileex = 'FLAC') or (fileex = 'mp3') or (fileex = 'MP3') then
    begin

      if fileexists(PChar(ansistring(historyfn.Value))) then
      begin
        uos_Stop(theplayerinfo);

        if uos_CreatePlayer(theplayerinfo) then
          //// Create the player.
          //// PlayerIndex : from 0 to what your computer can do !
          //// If PlayerIndex exists already, it will be overwriten...

          if uos_AddFromFile(theplayerinfo, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
          begin
            Inputlength1 := uos_Inputlength(theplayer, 0);
            ////// Length of Input in samples

            if Sender <> nil then
            begin
              if TButton(Sender).tag = 9 then
                hassent := 1
              else
                hassent := 0;
            end
            else
              hassent := 0;

            if hassent = 1 then
            begin

              temptimeinfo := uos_InputlengthTime(theplayerinfo, 0);
              ////// Length of input in time

              DecodeTime(temptimeinfo, ho, mi, se, ms);

              infosfo.infofile.Caption := 'File: ' + extractfilename(historyfn.Value);
              infosfo.infoname.Caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(theplayerinfo, 0)));
              infosfo.infoartist.Caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(theplayerinfo, 0)));
              infosfo.infoalbum.Caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(theplayerinfo, 0)));
              infosfo.infoyear.Caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(theplayerinfo, 0)));
              infosfo.infocom.Caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(theplayerinfo, 0)));
              infosfo.infotag.Caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(theplayerinfo, 0)));
              infosfo.infolength.Caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
              infosfo.inforate.Caption := 'Sample Rate: ' + msestring(IntToStr(uos_InputGetSampleRate(theplayerinfo, 0)));
              infosfo.infochan.Caption := 'Channels: ' + msestring(IntToStr(uos_InputGetChannels(theplayerinfo, 0)));

              uos_play(theplayerinfo);
              uos_Stop(theplayerinfo);

              // BPM

              infosfo.infobpm.Caption := '';

              //  {$if defined(linux)}
              if plugsoundtouch = True then
              begin

                thebuffer :=
                  uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024);

                //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));

                infosfo.infobpm.Caption := 'BPM: ' + floattostr((uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate)));
                ;

              end;
              //      {$ENDIF}

              maxwidth := infosfo.infofile.Width;

              if maxwidth < infosfo.infoname.Width then
                maxwidth := infosfo.infoname.Width;
              if maxwidth < infosfo.infoartist.Width then
                maxwidth := infosfo.infoartist.Width;
              if maxwidth < infosfo.infoalbum.Width then
                maxwidth := infosfo.infoalbum.Width;
              if maxwidth < infosfo.infoyear.Width then
                maxwidth := infosfo.infoyear.Width;
              if maxwidth < infosfo.infocom.Width then
                maxwidth := infosfo.infocom.Width;
              if maxwidth < infosfo.infotag.Width then
                maxwidth := infosfo.infotag.Width;
              if maxwidth < infosfo.infolength.Width then
                maxwidth := infosfo.infolength.Width;

              infosfo.Width := maxwidth + 42;
              // infosfo.button1.left := (infosfo.width - infosfo.button1.width)  div 2 ;
              infosfo.Show(True);
            end
            else


            if (waveformcheck.Value = True) and (iswav = False) then
            begin

              chan1 := uos_InputGetChannels(theplayerinfo, 0);

              // writeln('chan = ' + inttostr(chan1));
              //  writeln('Inputlength1 = ' + inttostr(Inputlength1));

              ///// set calculation of level/volume into array (usefull for wave form procedure)
              uos_InputSetLevelArrayEnable(theplayerinfo, 0, 2);
              ///////// set level calculation (default is 0)
              // 0 => no calcul
              // 1 => calcul before all DSP procedures.
              // 2 => calcul after all DSP procedures.

              //// determine how much frame will be designed
              framewanted := Inputlength1 div (trackbar1.Width - 7);

              uos_InputSetFrameCount(theplayerinfo, 0, framewanted);

              ///// Assign the procedure of object to execute at end of stream
              uos_EndProc(theplayerinfo, @GetWaveData);

              uos_Play(theplayerinfo);  /////// everything is ready, here we are, lets do it...

            end;

          end
          else
            ShowMessage(historyfn.Value + ' cannot load...');
      end
      else;
      //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
    end
    else
      ShowMessage(historyfn.Value + ' is not a audio file...');
  end;

  if Caption = 'Player 2' then
  begin
    fileex := fileext(PChar(ansistring(historyfn.Value)));

    if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or
      (fileex = 'FLAC') or (fileex = 'mp3') or (fileex = 'MP3') then
    begin

      if fileexists(PChar(ansistring(historyfn.Value))) then
      begin
        uos_Stop(theplayerinfo2);

        if Sender <> nil then
        begin
          if TButton(Sender).tag = 9 then
            hassent := 1
          else
            hassent := 0;
        end
        else
          hassent := 0;

        if uos_CreatePlayer(theplayerinfo2) then
          //// Create the player.
          //// PlayerIndex : from 0 to what your computer can do !
          //// If PlayerIndex exists already, it will be overwriten...

          if uos_AddFromFile(theplayerinfo2, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
          begin
            Inputlength2 := uos_Inputlength(theplayer2, 0);
            ////// Length of Input in samples

            if hassent = 1 then
            begin

              temptimeinfo := uos_InputlengthTime(theplayerinfo2, 0);
              ////// Length of input in time

              DecodeTime(temptimeinfo, ho, mi, se, ms);

              infosfo.infofile.Caption := 'File: ' + extractfilename(historyfn.Value);
              infosfo.infoname.Caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(theplayerinfo2, 0)));
              infosfo.infoartist.Caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(theplayerinfo2, 0)));
              infosfo.infoalbum.Caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(theplayerinfo2, 0)));
              infosfo.infoyear.Caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(theplayerinfo2, 0)));
              infosfo.infocom.Caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(theplayerinfo2, 0)));
              infosfo.infotag.Caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(theplayerinfo2, 0)));
              infosfo.infolength.Caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
              infosfo.inforate.Caption := 'Sample Rate: ' + msestring(IntToStr(uos_InputGetSampleRate(theplayerinfo2, 0)));
              infosfo.infochan.Caption := 'Channels: ' + msestring(IntToStr(uos_InputGetChannels(theplayerinfo2, 0)));


              uos_play(theplayerinfo2);
              uos_Stop(theplayerinfo2);

              // BPM

              infosfo.infobpm.Caption := '';

              //   {$if defined(linux)}
              if plugsoundtouch = True then
              begin

                thebuffer := uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024 * 2);

                //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));

                infosfo.infobpm.Caption := 'BPM: ' + floattostr((uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate)));
                ;

              end;
              //   {$ENDIF}

              maxwidth := infosfo.infofile.Width;

              if maxwidth < infosfo.infoname.Width then
                maxwidth := infosfo.infoname.Width;
              if maxwidth < infosfo.infoartist.Width then
                maxwidth := infosfo.infoartist.Width;
              if maxwidth < infosfo.infoalbum.Width then
                maxwidth := infosfo.infoalbum.Width;
              if maxwidth < infosfo.infoyear.Width then
                maxwidth := infosfo.infoyear.Width;
              if maxwidth < infosfo.infocom.Width then
                maxwidth := infosfo.infocom.Width;
              if maxwidth < infosfo.infotag.Width then
                maxwidth := infosfo.infotag.Width;
              if maxwidth < infosfo.infolength.Width then
                maxwidth := infosfo.infolength.Width;
              if maxwidth < infosfo.infobpm.Width then
                maxwidth := infosfo.infobpm.Width;

              infosfo.Width := maxwidth + 42;
              // infosfo.button1.left := (infosfo.width - infosfo.button1.width)  div 2 ;
              infosfo.Show(True);
            end
            else


            if (waveformcheck.Value = True) and (iswav2 = False) then
            begin

              chan2 := uos_InputGetChannels(theplayerinfo2, 0);

              // writeln('chan = ' + inttostr(chan1));
              //  writeln('Inputlength1 = ' + inttostr(Inputlength1));

              ///// set calculation of level/volume into array (usefull for wave form procedure)
              uos_InputSetLevelArrayEnable(theplayerinfo2, 0, 2);
              ///////// set level calculation (default is 0)
              // 0 => no calcul
              // 1 => calcul before all DSP procedures.
              // 2 => calcul after all DSP procedures.

              //// determine how much frame will be designed
              framewanted := Inputlength2 div (trackbar1.Width - 7);

              uos_InputSetFrameCount(theplayerinfo2, 0, framewanted);

              ///// Assign the procedure of object to execute at end of stream
              uos_EndProc(theplayerinfo2, @GetWaveData);

              uos_Play(theplayerinfo2);  /////// everything is ready, here we are, lets do it...

            end;

          end
          else
            ShowMessage(historyfn.Value + ' cannot load...');
      end
      else;
      //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
    end
    else
      ShowMessage(historyfn.Value + ' is not a audio file...');
  end;

end;

procedure tsongplayerfo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if trackbar1.clicked then
  begin
   if Caption = 'Player 1' then
  begin
    temptime := tottime1 * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
  end;
  
  if Caption = 'Player 2' then
  begin
    temptime := tottime2 * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
  end;
   
 end;  

end;

procedure tsongplayerfo.visiblechangeev(const Sender: TObject);
begin
  if Caption = 'Player 1' then
  begin
    if Visible then
    begin
      mainfo.tmainmenu1.menu[3].submenu[4].Caption := ' Hide Player 1 ';
    end
    else
    begin
      uos_Stop(theplayer);
      mainfo.tmainmenu1.menu[3].submenu[4].Caption := ' Show Player 1 ';
    end;
  end;

  if Caption = 'Player 2' then
  begin
    if Visible then
    begin
      mainfo.tmainmenu1.menu[3].submenu[5].Caption := ' Hide Player 2 ';
    end
    else
    begin
      uos_Stop(theplayer2);
      mainfo.tmainmenu1.menu[3].submenu[5].Caption := ' Show Player 2 ';
    end;
  end;
if norefresh = false then
begin
  mainfo.updatelayout();
  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayout();
  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayout();
  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayout();
    end;
end;

procedure tsongplayerfo.onplayercreate(const Sender: TObject);
var
  ordir: string;
begin

  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 250000;
  Timerwait.Enabled := False;
  Timerwait.ontimer := @ontimerwait;
  Timerwait.options := [to_single];

  Timersent := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.ontimer := @ontimersent;
  Timersent.options := [to_single];

  if plugsoundtouch = False then
  begin
    edtempo.Visible := False;
    cbtempo.Visible := False;
    Button1.Visible := False;
    Button2.Visible := False;
    tstringdisp2.left := 377;
    tstringdisp2.top := 64;
  end;

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if songdir.Value = '' then
    songdir.Value := ordir + 'sound' + directoryseparator + 'song' + directoryseparator + 'test.ogg';

  // if historyfn.value = '' then
  // historyfn.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';

  historyfn.Value := songdir.Value;

end;

procedure tsongplayerfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
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

procedure tsongplayerfo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  if Caption = 'Player 1' then
    thesender := 0;
  if Caption = 'Player 2' then
    thesender := 1;
end;

procedure tsongplayerfo.ondestr(const Sender: TObject);
begin
  Timerwait.Free;
  timersent.Free;
end;

procedure tsongplayerfo.changevol(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  changevolume(Sender);
end;

procedure tsongplayerfo.oncreated(const Sender: TObject);
begin

  Equalizer_Bands[1].lo_freq := 18;
  Equalizer_Bands[1].hi_freq := 46;
  Equalizer_Bands[1].Text := '31';
  Equalizer_Bands[2].lo_freq := 47;
  Equalizer_Bands[2].hi_freq := 94;
  Equalizer_Bands[2].Text := '62';
  Equalizer_Bands[3].lo_freq := 95;
  Equalizer_Bands[3].hi_freq := 188;
  Equalizer_Bands[3].Text := '125';
  Equalizer_Bands[4].lo_freq := 189;
  Equalizer_Bands[4].hi_freq := 375;
  Equalizer_Bands[4].Text := '250';
  Equalizer_Bands[5].lo_freq := 376;
  Equalizer_Bands[5].hi_freq := 750;
  Equalizer_Bands[5].Text := '500';
  Equalizer_Bands[6].lo_freq := 751;
  Equalizer_Bands[6].hi_freq := 1500;
  Equalizer_Bands[6].Text := '1K';
  Equalizer_Bands[7].lo_freq := 1501;
  Equalizer_Bands[7].hi_freq := 3000;
  Equalizer_Bands[7].Text := '2K';
  Equalizer_Bands[8].lo_freq := 3001;
  Equalizer_Bands[8].hi_freq := 6000;
  Equalizer_Bands[8].Text := '4K';
  Equalizer_Bands[9].lo_freq := 6001;
  Equalizer_Bands[9].hi_freq := 12000;
  Equalizer_Bands[9].Text := '8K';
  Equalizer_Bands[10].lo_freq := 12001;
  Equalizer_Bands[10].hi_freq := 20000;
  Equalizer_Bands[10].Text := '16K';

  setlength(arl, 10);
  setlength(arr, 10);

  setlength(arl2, 10);
  setlength(arr2, 10);
end;

procedure tsongplayerfo.faceafterpaintbut(const Sender: tcustomface; const canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  canvas.drawline(point1, point2, cl_red);

end;

procedure tsongplayerfo.onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
var
  mixtime: integer;
  dopos: boolean = False;
begin

  onsliderchange(Sender);

  if Caption = 'Player 1' then
  begin
    if (commanderfo.automix.Value = True) then
    begin
      mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
      if (trunc(avalue * Inputlength1) < Inputlength1 - mixtime + 1000) then
        dopos := True;
    end
    else
      dopos := True;

    if dopos = True then
    begin
      if akind = sbe_thumbposition then
        uos_InputSeek(theplayer, Inputindex1, trunc(avalue * Inputlength1));

    end;
  end;

  if Caption = 'Player 2' then
  begin
    if (commanderfo.automix.Value = True) then
    begin
      mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
      if (trunc(avalue * Inputlength2) < Inputlength2 - mixtime + 1000) then
        dopos := True;
    end
    else
      dopos := True;

    if dopos = True then
    begin
      if akind = sbe_thumbposition then
        uos_InputSeek(theplayer2, Inputindex2, trunc(avalue * Inputlength2));
    end;
  end;

end;

procedure tsongplayerfo.changeloop(const Sender: TObject);
begin
  if Caption = 'Player 1' then
  begin
    if cbloop.Value then
    begin
      commanderfo.btncue.Enabled := False;
      btncue.Enabled := False;
    end
    else
    begin
      commanderfo.btncue.Enabled := True;
      btncue.Enabled := True;
    end;
  end;

  if Caption = 'Player 2' then
  begin
    if cbloop.Value then
    begin
      commanderfo.btncue2.Enabled := False;
      btncue.Enabled := False;
    end
    else
    begin
      commanderfo.btncue2.Enabled := True;
      btncue.Enabled := True;
    end;
  end;

end;

procedure tsongplayerfo.onchachewav(const Sender: TObject);
begin
  DrawWaveForm();
  //  application.processmessages;
  //  formDrawWaveForm();
end;

procedure tsongplayerfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  if (trealspinedit(Sender).tag = 9) then
  begin
    if avalue > 2 then
    begin
      hintlabel.Caption := '"' + IntToStr(trunc(avalue)) + '" is > 2.  Reset to 2.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
     if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
      avalue := 2;
    end;

    if avalue < 0.4 then
    begin
      hintlabel.Caption := '" " is invalid value.  Reset to 0.4';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
     if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
      avalue := 0.4;
    end;
  end
  else
  begin

    if avalue > 100 then
    begin
      hintlabel.Caption := '"' + IntToStr(trunc(avalue)) + '" is > 100.  Reset to 100.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
     if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
      avalue := 100;
    end;

    if avalue < 0 then
    begin
      hintlabel.Caption := '" " is invalid value.  Reset to 0.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
     if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
      avalue := 0;
    end;
  end;
end;

procedure tsongplayerfo.ontextedit(const Sender: tcustomedit; var atext: msestring);
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
    timersent.Enabled := True;
    atext := '100';
  end;
end;

procedure tsongplayerfo.ongetbpm(const Sender: TObject);
var
  thebuffer: TDArFloat;
  thebufferinfos: TuosF_BufferInfos;
  thebpm: float;
begin

  // {$if defined(linux)}

  if Caption = 'Player 1' then
  begin
    if plugsoundtouch = True then
    begin

      if btncue.Enabled = True then
        btncue.onexecute(Sender);

      if fileexists(theplaying1) then
      begin

        //writeln('pos= ' + inttostr( uos_InputPosition(theplayer, Inputindex1)));

        thebuffer := uos_File2Buffer(PChar(ansistring(theplaying1)), 0, thebufferinfos, uos_InputPosition(theplayer, Inputindex1), 1024);

        //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));
        thebpm := uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate);
        if thebpm = 0 then
          button2.Caption := 'BPM'
        else
        begin

          button2.Caption := IntToStr(round(thebpm));
          drumsfo.edittempo.Value := round(thebpm);
          button2.face.template := mainfo.tfaceorange;
         if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
        end;
      end;
    end;
  end;

  if Caption = 'Player 2' then
  begin
    if plugsoundtouch = True then
    begin
      if btncue.Enabled = True then
        btncue.onexecute(Sender);

      if fileexists(theplaying2) then
      begin

        thebuffer := uos_File2Buffer(PChar(ansistring(theplaying2)), 0, thebufferinfos, uos_InputPosition(theplayer2, Inputindex2), 1024);
        //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));
        thebpm := uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate);
        if thebpm = 0 then
          button2.Caption := 'BPM'
        else
        begin
          button2.Caption := IntToStr(round(thebpm));
          drumsfo.edittempo.Value := round(thebpm);
          button2.face.template := mainfo.tfaceorange;

        if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
        end;
      end;
    end;
  end;

end;

procedure tsongplayerfo.ontimerwaveform(const sender: TObject);
begin
onwavform(sender);
end;

end.
