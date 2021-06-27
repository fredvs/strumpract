unit songplayer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  ctypes,
  uos_flat,
  infos,
  msetimer,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  msefileutils,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  Math,
  msegraphutils,
  mseevent,
  mseclasses,
  mseforms,
  msedock,
  msesimplewidgets,
  msewidgets,
  msedataedits,
  msefiledialogx,
  msegrids,
  mselistbrowser,
  msesys,
  SysUtils,
  msegraphedits,
  msedragglob,
  mseact,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestatfile,
  msestream,
  msestrings,
  msescrollbar,
  msebitmap,
  msedatanodes,
  msedispwidgets,
  mserichstring,
  msedropdownlist,
  mse_ovobasetag,
  mse_ovoaudiotag,
  mse_ovofile_mp3,
  msegridsglob;

type
  tsongplayerfo = class(tdockform)
    Timerwait: Ttimer;
    Timersent: Ttimer;
    tgroupbox1: tgroupbox;
    edvolleft: trealspinedit;
    edtempo: trealspinedit;
    button1: TButton;
    trackbar1: tslider;
    historyfn: thistoryedit;
    llength: tstringdisp;
    lposition: tstringdisp;
    tstringdisp1: tstringdisp;
    edvolright: trealspinedit;
    tfaceslider: tfacecomp;
    btinfos: TButton;
    tfacebuttonslider: tfacecomp;
    tstringdisp2: tstringdisp;
    sliderimage: tbitmapcomp;
    vuRight: tprogressbar;
    vuLeft: tprogressbar;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    button2: TButton;
    btnStop: TButton;
    btnPause: TButton;
    btnResume: TButton;
    btnStart: TButton;
    BtnCue: TButton;
    ttimer1: ttimer;
    tbutton6: TButton;
    tfiledialog1: tfiledialogx;
    cbloopb: TButton;
    tstringdisp3: tstringdisp;
    setmono: tbooleanedit;
    waveformcheck: tbooleanedit;
    playreverse: tbooleanedit;
    cbloop: tbooleanedit;
    playreverseb: TButton;
    waveformcheckb: TButton;
    setmonob: TButton;
    cbtempo: tbooleanedit;
    cbtempob: TButton;
    ttimer2: ttimer;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1();
    procedure showposition(const Sender: TObject);
    procedure showlevel(const Sender: TObject; const l1, r1, l2, r2: double);
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
    procedure whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure ondestr(const Sender: TObject);
    procedure changevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure oncreated(const Sender: TObject);
    procedure faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
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
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
    procedure ongetbpm(const Sender: TObject);
    procedure ontimerwaveform(const Sender: TObject);
    procedure opendir(const Sender: TObject);
    procedure changefrequency(asender, aindex: integer; gainl, gainr: double);
    procedure setequalizerenable(asender: integer; avalue: Boolean);
    procedure onexecbutlght(const Sender: TObject);
    procedure ontimercheck(const Sender: TObject);
    function ReadTag(filename: string): integer;

  protected
    procedure paintsliderimage(const Canvas: tcanvas; const arect: rectty);
    procedure paintsliderimageform(const Canvas: tcanvas; const arect: rectty);
  end;

  equalizer_band_type = record
    theindex: integer;
    lo_freq, hi_freq: cfloat;
    Text: string[10];
  end;

var
  theinc: integer = 0;
  Equalizer_Bands: array[1..10] of equalizer_band_type;
  thearray: array of cfloat;
  thearray2: array of cfloat;
  arl, arr, arl2, arr2: flo64arty;
  songplayerfo: tsongplayerfo;
  songplayer2fo: tsongplayerfo;
  thedialogform: tfiledialogxfo;
  initplay: integer = 1;
  theplayer: integer = 20;
  theplayerinfo: integer = 21;
  theplaying1: msestring = '';
  theplayer2: integer = 22;
  theplayerinfo2: integer = 23;
  theplayerinfoform: integer = 26;
  theplayerinfoform2: integer = 27;
  theplaying2: msestring = '';
  iscue1: Boolean = False;
  hasmixed1: Boolean = False;
  hasfocused1: Boolean = False;
  iswav: Boolean = False;
  plugindex1, PluginIndex2: integer;
  Inputindex1, DSPIndex1, DSPIndex11, Outputindex1, Inputlength1: integer;
  poswav1, chan1: integer;
  waveformdata1: array of cfloat;
  waveformdata2: array of cfloat;
  waveformdataform1: array of cfloat;
  waveformdataform2: array of cfloat;
  buzywaveform1: Boolean = False;
  buzywaveform2: Boolean = False;
  initwaveform1: Boolean = False;
  initwaveform2: Boolean = False;
  hascue: Boolean = False;
  hascue2: Boolean = False;
  totsec1: integer = 0;
  totsec2: integer = 0;
  tottime1: ttime;
  tottime2: ttime;
  DrawWaveFormbusy1: Boolean = False;
  DrawWaveFormbusy2: Boolean = False;
  FormDrawWaveFormbusy1: Boolean = False;
  FormDrawWaveFormbusy2: Boolean = False;
  iscue2: Boolean = False;
  iswav2: Boolean = False;
  hasmixed2: Boolean = False;
  hasfocused2: Boolean = False;
  plugindex2, PluginIndex3: integer;
  Inputindex2, DSPIndex2, DSPIndex22, Outputindex2, Inputlength2: integer;
  poswav2, chan2: integer;
  TagReader: TTagReader;

implementation

uses
  main,
  imagedancer,
  commander,
  config,
  waveform,
  filelistform,
  equalizer,
  drums,
  spectrum1,
  dockpanel1,
  mseformatbmpicoread,
  mseformatjpgread,
  mseformatpngread,
  //strutils,
  msegraphicstream,
  songplayer_mfm;

function DSPStereo2Mono(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
var
  x: integer = 0;
  pf: PDArFloat;     // if input is Float32 format
  samplef: cFloat;
begin
  if (Data.channels = 2) then
  begin

    pf := @Data.Buffer;
    while x < Data.OutFrames - 1 do
    begin
      samplef    := (pf^[x] + pf^[x + 1]) / 2;
      pf^[x]     := samplef;
      pf^[x + 1] := samplef;
      x          := x + 2;
    end;

    Result := Data.Buffer;
  end
  else
    Result := Data.Buffer;
end;

function tsongplayerfo.ReadTag(filename: string): integer;
var
  tagClass: TTagReaderClass;
begin
  Result := -1;
  if Assigned(TagReader) then
    TagReader.Free;

  tagClass  := IdentifyKind(FileName);
  TagReader := tagClass.Create;

  TagReader.LoadFromFile(FileName);

  if TagReader.Tags.ImageCount > 0 then
  begin
    Result := 0;
    TagReader.Tags.Images[0].Image.Position := 0;
  end;

end;

 {
procedure timageviewerfo.doLoadImage(const sender: TObject);
begin

  if imageFileName.value <> '' then
  begin
  ReadTag(imageFileName.value);
    end;
 
end;
}

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
  Result := nil;
  if (Data.position > Data.OutFrames div Data.channels) then
    uos_InputSeek(theplayer, InputIndex1, Data.position -
      (Data.OutFrames div Data.ratio));
  // writeln('position: ' + inttostr(Data.position));
end;

function DSPReverseBefore2(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
begin
  Result := nil;
  if (Data.position > Data.OutFrames div Data.channels) then
    uos_InputSeek(theplayer2, InputIndex2, Data.position -
      (Data.OutFrames div Data.ratio));
end;

function DSPReverseAfter(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
var
  x: integer = 0;
  lengthbuf: integer;
  arfl: TDArFloat;
begin
  lengthbuf := length(Data.Buffer) div 2;

  if (Data.position > lengthbuf div Data.channels) then
  begin
    SetLength(arfl, lengthbuf);
    x := 0;
   { 
    writeln('length buff: ' + inttostr(lengthbuf));
    writeln('length OutFrames: ' + inttostr(Data.OutFrames));
    writeln('length ratio: ' + inttostr(Data.ratio));
    }
    while x < lengthbuf do
    begin
      arfl[x]     := Data.Buffer[lengthbuf - x - 2];
      arfl[x + 1] := Data.Buffer[lengthbuf - x - 1];
      Inc(x, 2);
    end;
    Result := arfl;
  end
  else
    Result := Data.Buffer;
end;


procedure tsongplayerfo.ontimersent(const Sender: TObject);
begin
  // timersent.Enabled := False;
  hintpanel.Visible        := False;
  historyfn.face.template  := mainfo.tfaceplayerlight;
  edvolleft.face.template  := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template    := mainfo.tfaceplayer;
  button1.face.template    := mainfo.tfaceplayer;
  button2.face.template    := mainfo.tfaceplayer;
end;

procedure tsongplayerfo.ontimerwait(const Sender: TObject);
begin

  if Caption = 'Player 1' then
  begin
    //  timerwait.Enabled := False;
    btnStart.Enabled := True;
    btnStop.Enabled  := True;
    btncue.Enabled   := False;

    with commanderfo do
    begin
      btncue.Enabled   := False;
      btnStart.Enabled := True;
      btnStop.Enabled  := True;
      if (cbloop.Value = False) and (iscue1 = False) then
        btnPause.Enabled := True
      else
        btnPause.Enabled := False;

      if iscue1 then
      begin
        btnPause.Visible  := False;
        btnresume.Enabled := True;
        btnresume.Visible := True;
      end
      else
      begin
        btnPause.Visible  := True;
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
      btnPause.Visible  := False;
      btnresume.Enabled := True;
      btnresume.Visible := True;
    end
    else
    begin
      btnPause.Visible  := True;
      btnresume.Visible := False;
      btnresume.Enabled := False;
    end;

    cbloop.Enabled           := False;
    cbloopb.Enabled          := False;
    cbloop.Visible           := False;
    trackbar1.Enabled        := True;
    wavefo.trackbar1.Enabled := True;
  end;

  if Caption = 'Player 2' then
  begin
    // timerwait.Enabled := False;
    btnStart.Enabled := True;
    btnStop.Enabled  := True;
    btncue.Enabled   := False;

    with commanderfo do
    begin
      btncue2.Enabled   := False;
      btnStart2.Enabled := True;
      btnStop2.Enabled  := True;
      if (cbloop.Value = False) and (iscue2 = False) then
        btnPause2.Enabled := True
      else
        btnPause2.Enabled := False;
      if iscue2 then
      begin
        btnPause2.Visible  := False;
        btnresume2.Enabled := True;
        btnresume2.Visible := True;
      end
      else
      begin
        btnPause2.Visible  := True;
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
      btnPause.Visible  := False;
      btnresume.Enabled := True;
      btnresume.Visible := True;
    end
    else
    begin
      btnPause.Visible  := True;
      btnresume.Visible := False;
      btnresume.Enabled := False;
    end;
    cbloop.Visible := False;
    cbloopb.Enabled   := False;
    cbloop.Enabled    := False;
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
          else
            timersent.Enabled := True;

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
          else
            timersent.Enabled := True;
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

    spectrum1fo.tchartleft.traces[0].ydata  := arl;
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

    spectrum2fo.tchartleft.traces[0].ydata  := arl2;
    spectrum2fo.tchartright.traces[0].ydata := arr2;
  end;

end;

procedure tsongplayerfo.ClosePlayer1();
begin

  if Caption = 'Player 1' then
    if (commanderfo.automix.Value = True) and (hasmixed1 = False) then
    begin
      hasmixed1   := True;
      commanderfo.onstartstop(nil);
      hasfocused1 := True;
      filelistfo.onsent(nil);
      hasfocused1 := False;
      hasmixed1   := False;
    end;

  if Caption = 'Player 2' then
    if (commanderfo.automix.Value = True) and (hasmixed2 = False) then
    begin
      hasmixed2   := True;
      commanderfo.onstartstop(nil);
      hasfocused2 := True;
      filelistfo.onsent(nil);
      hasfocused2 := False;
      hasmixed2   := False;
    end;

  //vuright.Value   := 0;
  vuRight.Visible := False;

  //vuleft.Value   := 0;
  vuleft.Visible := False;

  button2.Caption := 'BPM';

  btnStart.Enabled  := True;
  btnStop.Enabled   := False;
  btnPause.Enabled  := False;
  btnresume.Enabled := False;

  btnPause.Visible  := True;
  btnresume.Visible := False;

  if cbloop.Value then
    btncue.Enabled := False
  else
    btncue.Enabled := True;

  if Caption = 'Player 1' then
  begin
    theplaying1    := '';
    wavefo.Caption := 'Wave Player 1';

    iswav  := False;
    iscue1 := False;

    if uos_GetStatus(theplayer) <> 1 then
    begin
      tstringdisp1.Value         := '';
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

      btnPause.Visible  := True;
      btnresume.Visible := False;
      //vuright.value    := 0;
      //vuleft.value     := 0;
      //vuright.Height    := 0;
      //vuleft.Height     := 0;
      vuLeft.Visible    := False;
      vuRight.Visible   := False;
    end;
    wavefo.trackbar1.Value := 0;
    wavefo.container.frame.scrollpos_x := 0;
    wavefo.trackbar1.Enabled := False;
    hasmixed1 := False;
  end;

  if Caption = 'Player 2' then
  begin
    theplaying2     := '';
    wavefo2.Caption := 'Wave Player 2';
    iswav2          := False;
    iscue2          := False;

    if uos_GetStatus(theplayer2) <> 1 then
    begin
      tstringdisp1.Value         := '';
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
      vuLeft2.Visible    := False;
      vuRight2.Visible   := False;
    end;
    hasmixed2 := False;
    wavefo2.trackbar1.Value   := 0;
    wavefo2.container.frame.scrollpos_x := 0;
    wavefo2.trackbar1.Enabled := False;
  end;
  cbloop.Visible := True;
  cbloopb.Enabled   := True;
  cbloop.Enabled    := True;
  trackbar1.Value   := 0;
  trackbar1.Enabled := False;

  lposition.Value         := '00:00:00.000';
  lposition.face.template := mainfo.tfaceplayerrev;

  DrawWaveForm();

  formDrawWaveForm();

  resetspectrum();

end;

procedure tsongplayerfo.ShowSpectrum(const Sender: TObject);
var
  i, x: integer;
begin
  if Caption = 'Player 1' then
    if uos_getstatus(theplayer) > 0 then
    begin
      thearray := uos_InputFiltersGetLevelArray(theplayer, InputIndex1);
      x        := 0;
      i        := 0;
      while x < length(thearray) - 1 do
      begin
        arl[i] := thearray[x];
        arr[i] := thearray[x + 1];
        x      := x + 2;
        Inc(i);
      end;

      spectrum1fo.tchartleft.traces[0].ydata  := arl;
      spectrum1fo.tchartright.traces[0].ydata := arr;
    end;

  if Caption = 'Player 2' then
    if uos_getstatus(theplayer2) > 0 then
    begin
      i         := 1;
      thearray2 := uos_InputFiltersGetLevelArray(theplayer2, InputIndex2);
      x         := 0;
      i         := 0;
      while x < length(thearray2) - 1 do
      begin
        arl2[i] := thearray2[x];
        arr2[i] := thearray2[x + 1];
        x       := x + 2;
        Inc(i);
      end;

      spectrum2fo.tchartleft.traces[0].ydata  := arl2;
      spectrum2fo.tchartright.traces[0].ydata := arr2;
    end;

end;

procedure tsongplayerfo.showlevel(const Sender: TObject; const l1, r1, l2, r2: double);
begin

  if (Caption = 'Player 1') then
  begin
    if (l1 >= 0) and (l1 <= 1) then
    begin
      vuLeft.Value := l1;
      if (commanderfo.Visible) and (vuinvar = True) then
        commanderfo.vuLeft.Value := l1;
    end;

    if (r1 >= 0) and (r1 <= 1) then
    begin
      vuright.Value := r1;
      if (commanderfo.Visible) and (vuinvar = True) then
        commanderfo.vuright.Value := r1;
    end;

  end;

  if Caption = 'Player 2' then
  begin
    if (l2 >= 0) and (l2 <= 1) then
    begin
      vuLeft.Value := l2;
      if (commanderfo.Visible) and (vuinvar = True) then
        commanderfo.vuLeft2.Value := l2;
    end;

    if (r2 >= 0) and (r2 <= 1) then
    begin
      vuright.Value := l2;
      if (commanderfo.Visible) and (vuinvar = True) then
        commanderfo.vuright2.Value := r2;
    end;

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
    if (Caption = 'Player 1') and (not wavefo.TrackBar1.clicked) then
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

        temptime        := uos_InputPositionTime(theplayer, Inputindex1);
        // Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
        mixtime         := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;
        if Inputlength1 < mixtime + 50000 then
          mixtime := Inputlength1 - 50000;

        if (commanderfo.automix.Value = True) and (hasmixed1 = False) and (uos_InputPosition(theplayer, Inputindex1) > Inputlength1 - mixtime) then
        begin
          hasmixed1   := True;
          commanderfo.onstartstop(nil);
          hasfocused1 := True;
          filelistfo.onsent(nil);
          hasfocused1 := False;
        end;
      end;

    if (Caption = 'Player 2') and (not wavefo2.TrackBar1.clicked) then
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

        temptime        := uos_InputPositionTime(theplayer2, Inputindex2);
        // Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
        mixtime         := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;
        if Inputlength2 < mixtime + 50000 then
          mixtime := Inputlength2 - 50000;
        if (commanderfo.automix.Value = True) and (hasmixed2 = False) and (uos_InputPosition(theplayer2, Inputindex2) >
          Inputlength2 - mixtime) then
        begin
          hasmixed2   := True;
          commanderfo.tbutton2.Visible := True;
          commanderfo.tbutton3.Visible := True;
          commanderfo.onstartstop(nil);
          hasfocused2 := True;
          filelistfo.onsent(nil);
          hasfocused2 := False;
        end;
      end;

  end;

end;

procedure tsongplayerfo.LoopProcPlayer1();
var
  ll1, ll2, lr1, lr2: double;
begin

  if (commanderfo.timermix.Enabled = False) or
    ((commanderfo.timermix.Enabled = True) and (commanderfo.guimix.Value = True)) then
  begin

    if (Visible = True) then
      ShowPosition(nil);

    if ((vuinvar = True) and (Visible = True)) or
      ((imagedancerfo.Visible = True)) then
    begin
      ll1 := uos_InputGetLevelLeft(theplayer, Inputindex1);
      lr1 := uos_InputGetLevelright(theplayer, Inputindex1);
      ll2 := uos_InputGetLevelLeft(theplayer2, Inputindex2);
      lr2 := uos_InputGetLevelright(theplayer2, Inputindex2);

      multiplier := ((ll1 + lr1) / 2) + ((ll2 + lr2) / 2);

      if multiplier > 1 then
        multiplier := 1;
      if multiplier < 0 then
        multiplier := 0;

      if (vuinvar = True) and (Visible = True) then
        ShowLevel(nil, ll1, lr1, ll2, lr2);

      if (imagedancerfo.Visible = True) and (isbuzy = False) and
        (imagedancerfo.openglwidget.Visible = False) then
      begin
        //  multiplier := ((ll1 + lr1) / 2) + ((ll2 + lr2) / 2);
        if dancernum = 4 then
        begin
          Inc(TimerTicinterval);
          if TimerTicinterval = 3 then
          begin
            Inc(TimerTic);
            TimerTicinterval := 0;
          end;
        end;

        if (dancernum = 5) or (dancernum = 6) or (dancernum = 7) then
          Inc(TimerTic);

        RTLeventSetEvent(evPauseimage); // to resume 

      end;
    end;

    if Caption = 'Player 1' then
      if (spectrum1fo.spect1.Value = True) and (spectrum1fo.Visible = True) and
        (commanderfo.speccalc.Value = True) then
        ShowSpectrum(nil);

    if Caption = 'Player 2' then
      if (spectrum2fo.spect1.Value = True) and (spectrum2fo.Visible = True) and
        (commanderfo.speccalc.Value = True) then
        ShowSpectrum(nil);
  end;
end;

procedure tsongplayerfo.doplayerstart(const Sender: TObject);
var
  samformat, hassent: shortint;
  ho, mi, se, ms: word;
  fileex: msestring;
  i: integer;
begin
  if Caption = 'Player 1' then
  begin
    fileex := fileext(PChar(ansistring(historyfn.Value)));

    if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
      (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') then
    begin

      if fileexists(historyfn.Value) then
      begin
        samformat := 0;

        //  oninfowav(Sender);


        // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
        // If PlayerIndex exists already, it will be overwritten...

        uos_Stop(theplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

        if uos_CreatePlayer(theplayer) then
          // Create the player.
          // PlayerIndex : from 0 to what your computer can do !
          // If PlayerIndex exists already, it will be overwriten...

          Inputindex1 := uos_AddFromFile(theplayer, PChar(ansistring(historyfn.Value)), -1,
            samformat, 1024 * 8);

        // add input from audio file with custom parameters
        // FileName : filename of audio file
        // PlayerIndex : Index of a existing Player
        // OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
        // SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
        // FramesCount : default : -1 (65536 div channels)
        //  result : -1 nothing created, otherwise Input Index in array

        if Inputindex1 > -1 then
        begin
          // Outputindex1 := uos_AddIntoDevOut(Playerindex1) ;
          // add a Output into device with default parameters

          if configfo.latplay.Value < 0 then
            configfo.latplay.Value := -1;

          Outputindex1 := uos_AddIntoDevOut(theplayer, configfo.devoutcfg.Value, configfo.latplay.Value, uos_InputGetSampleRate(theplayer, Inputindex1),
            //     uos_InputGetChannels(theplayer, Inputindex1), samformat,-1, -1);
            uos_InputGetChannels(theplayer, Inputindex1), samformat, 1024 * 8, -1);


          // Add a Output into Device Output
          // Device ( -1 is default device )
          // Latency  ( -1 is latency suggested )
          // SampleRate : delault : -1 (44100)
          // Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
          // SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
          // FramesCount : default : -1 (= 65536)
          // ChunkCount : default : -1 (= 512)
          //  result :  Output Index in array  -1 = error

          uos_InputSetLevelEnable(theplayer, Inputindex1, 2);
          // set calculation of level/volume (usefull for showvolume procedure)
          // set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.
          // 3 => calcul before and after all DSP procedures.

          uos_InputSetPositionEnable(theplayer, Inputindex1, 1);
          // set calculation of position (usefull for positions procedure)
          // set position calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul position.

          uos_LoopProcIn(theplayer, Inputindex1, @LoopProcPlayer1);
          // Assign the procedure of object to execute inside the loop
          // PlayerIndex : Index of a existing Player
          // Inputindex1 : Index of a existing Input
          // LoopProcPlayer1 : procedure of object to execute inside the loop

          uos_InputAddDSPVolume(theplayer, Inputindex1, 1, 1);
          // DSP Volume changer
          // Playerindex1 : Index of a existing Player
          // Inputindex1 : Index of a existing input
          // VolLeft : Left volume
          // VolRight : Right volume

          uos_InputSetDSPVolume(theplayer, Inputindex1,
            (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);
          /// Set volume
          // Playerindex1 : Index of a existing Player
          // Inputindex1 : InputIndex of a existing Input
          // VolLeft : Left volume
          // VolRight : Right volume
          // Enable : Enabled

          // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
          DSPindex11 := uos_InputAddDSP(theplayer, Inputindex1, nil, @DSPStereo2Mono, nil, nil);
          uos_InputSetDSP(theplayer, Inputindex1, DSPindex11, setmono.Value);

          for i := 1 to 10 do // equalizer
            Equalizer_Bands[i].theindex :=
              uos_InputAddFilter(theplayer, InputIndex1,
              1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
              1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, True, nil);

          equalizerfo1.onchangeall();

          if commanderfo.speccalc.Value = True then
            for i := 1 to 10 do // spectrum BandPass
              uos_InputAddFilter(theplayer, InputIndex1,
                3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
                3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, False, nil);


            { // add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
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
            ChangePlugSetSoundTouch(self); // custom procedure to Change plugin settings
          end;

          Inputlength1 := uos_Inputlength(theplayer, Inputindex1);
          // Length of Input in samples

          tottime1 := uos_InputlengthTime(theplayer, Inputindex1);
          // Length of input in time

          DecodeTime(tottime1, ho, mi, se, ms);

          totsec1 := (ho * 3600) + (mi * 60) + se;

          llength.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));

          DSPindex1 := uos_InputAddDSP(theplayer, Inputindex1, @DSPReverseBefore1, @DSPReverseAfter, nil, nil);
          // add a custom DSP procedure for input
          // Playerindex1 : Index of a existing Player
          // Inputindex1: InputIndex of existing input
          // BeforeFunc : function to do before the buffer is filled
          // AfterFunc : function to do after the buffer is filled
          // EndedFunc : function to do at end of thread
          // LoopProc : external procedure to do after the buffer is filled

          // set the parameters of custom DSP
          //  playreverse.value := false;

          uos_InputSetDSP(theplayer, Inputindex1, DSPindex1, playreverse.Value);

          uos_EndProc(theplayer, @ClosePlayer1);
          /// procedure to execute when stream is terminated
          // Assign the procedure of object to execute at end
          // PlayerIndex : Index of a existing Player
          // ClosePlayer1 : procedure of object to execute inside the general loop

          btinfos.Enabled := True;

          hasmixed1 := False;

          trackbar1.Value   := 0;
          trackbar1.Enabled := True;

          wavefo.trackbar1.Value   := 0;
          wavefo.container.frame.scrollpos_x := 0;
          wavefo.trackbar1.Enabled := True;
          wavefo.Caption           := 'Wave1 of ' + historyfn.Value;

          theplaying1 := historyfn.Value;

          if vuinvar then
          begin
            vuLeft.Visible  := True;
            vuRight.Visible := True;
            commanderfo.vuLeft.Visible := True;
            commanderfo.vuRight.Visible := True;
          end;

          with commanderfo do
          begin
            btnStop.Enabled   := True;
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
              uos_Play(theplayer);  /// everything is ready, here we are, lets play it...
              btnpause.Enabled := True;
              btnpause.Visible := True;
            end;
            tstringdisp1.face.template := mainfo.tfacegreen;
            tstringdisp1.Value := msestring('Playing ' + theplaying1);
          end;

          if hassent = 1 then  /// cue
          begin
            iscue1           := True;
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
              uos_Play(theplayer);  /// everything is ready, here we are, lets play it...
              btnpause.Enabled := False;
            end;
            uos_Pause(theplayer);
            tstringdisp1.face.template := mainfo.tfaceorange2;
            tstringdisp1.Value         := msestring('Loaded ' + theplaying1);
          end;

          cbloop.Visible := False;
          cbloop.Enabled := False;
          //songdir.Value := historyfn.Value;
          historyfn.hint := historyfn.Value;
          if timerwait.Enabled then
            timerwait.restart // to reset
          else
            timerwait.Enabled := True;


          lposition.face.template := mainfo.tfaceplayerlight;

          hascue := True;

          //  application.processmessages;

          //  oninfowav(Sender);

          oninfowav(Sender);


          if as_checked in wavefo.tmainmenu1.menu[0].state then
          begin
            // oninfowav(Sender);

            //   wavefo.doechelle(Sender);

            //   onwavform(Sender);
            ttimer1.Enabled := False;
            ttimer1.Enabled := True;

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

    if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
      (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') then
    begin

      // writeln('avant tout');
      if fileexists(historyfn.Value) then
      begin
        samformat := 0;

        //  oninfowav(Sender);

        //  songdir.hint := songdir.value;


        // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
        // If PlayerIndex exists already, it will be overwritten...
        uos_Stop(theplayer2); // done by  uos_CreatePlayer() but faster if already done before (no check)

        if uos_CreatePlayer(theplayer2) then
          // Create the player.
          // PlayerIndex : from 0 to what your computer can do !
          // If PlayerIndex exists already, it will be overwriten...

          Inputindex2 := uos_AddFromFile(theplayer2, PChar(ansistring(historyfn.Value)), -1, samformat, 1024 * 8);

        // add input from audio file with custom parameters
        // FileName : filename of audio file
        // PlayerIndex : Index of a existing Player
        // OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
        // SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
        // FramesCount : default : -1 (65536 div channels)
        //  result : -1 nothing created, otherwise Input Index in array

        if Inputindex2 > -1 then
        begin

          //   writeln('ok index');
          // Outputindex2 := uos_AddIntoDevOut(Playerindex2) ;
          // add a Output into device with default parameters

          if configfo.latplay.Value < 0 then
            configfo.latplay.Value := -1;

          Outputindex2 := uos_AddIntoDevOut(theplayer2, configfo.devoutcfg.Value, configfo.latplay.Value, uos_InputGetSampleRate(theplayer2, Inputindex2),
            uos_InputGetChannels(theplayer2, Inputindex2), samformat, 1024 * 8, -1);
          //uos_InputGetChannels(theplayer2, Inputindex2), samformat, -1, -1);

          // Add a Output into Device Output
          // Device ( -1 is default device )
          // Latency  ( -1 is latency suggested )
          // SampleRate : delault : -1 (44100)
          // Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
          // SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
          // FramesCount : default : -1 (= 65536)
          // ChunkCount : default : -1 (= 512)

          uos_InputSetLevelEnable(theplayer2, Inputindex2, 2);
          // set calculation of level/volume (usefull for showvolume procedure)
          // set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.
          // 3 => calcul before and after all DSP procedures.

          uos_InputSetPositionEnable(theplayer2, Inputindex2, 1);
          // set calculation of position (usefull for positions procedure)
          // set position calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul position.

          uos_LoopProcIn(theplayer2, Inputindex2, @LoopProcPlayer1);

          // Assign the procedure of object to execute inside the loop
          // PlayerIndex : Index of a existing Player
          // Inputindex2 : Index of a existing Input
          // LoopProcPlayer1 : procedure of object to execute inside the loop

          uos_InputAddDSPVolume(theplayer2, Inputindex2, 1, 1);
          // DSP Volume changer
          // Playerindex2 : Index of a existing Player
          // Inputindex2 : Index of a existing input
          // VolLeft : Left volume
          // VolRight : Right volume

          uos_InputSetDSPVolume(theplayer2, Inputindex2,
            (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);
          /// Set volume
          // Playerindex2 : Index of a existing Player
          // Inputindex2 : InputIndex of a existing Input
          // VolLeft : Left volume
          // VolRight : Right volume
          // Enable : Enabled

          // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
          DSPindex22 := uos_InputAddDSP(theplayer2, Inputindex2, nil, @DSPStereo2Mono, nil, nil);
          uos_InputSetDSP(theplayer2, Inputindex2, DSPindex22, setmono.Value);

          for i := 1 to 10 do // equalizer
            Equalizer_Bands[i].theindex :=
              uos_InputAddFilter(theplayer2, InputIndex2,
              1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
              1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, True, nil);

          equalizerfo2.onchangeall();

          if commanderfo.speccalc.Value = True then
            for i := 1 to 10 do
              uos_InputAddFilter(theplayer2, Inputindex2,
                3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
                3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, False, nil);
{
   // add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
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
            PluginIndex3 := uos_AddPlugin(theplayer2, 'soundtouch',
              uos_InputGetSampleRate(theplayer2, Inputindex2), -1);
            ChangePlugSetSoundTouch(self); // custom procedure to Change plugin settings
          end;

          Inputlength2 := uos_Inputlength(theplayer2, Inputindex2);
          // Length of Input in samples

          tottime2 := uos_InputlengthTime(theplayer2, Inputindex2);
          // Length of input in time

          DecodeTime(tottime2, ho, mi, se, ms);

          totsec2 := (ho * 3600) + (mi * 60) + se;

          llength.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));

          DSPindex2 := uos_InputAddDSP(theplayer2, Inputindex2, @DSPReverseBefore2, @DSPReverseAfter, nil, nil);
          // add a custom DSP procedure for input
          // Playerindex2 : Index of a existing Player
          // Inputindex2: InputIndex of existing input
          // BeforeFunc : function to do before the buffer is filled
          // AfterFunc : function to do after the buffer is filled
          // EndedFunc : function to do at end of thread
          // LoopProc : external procedure to do after the buffer is filled

          // set the parameters of custom DSP
          uos_InputSetDSP(theplayer2, Inputindex2, DSPindex2, playreverse.Value);


          uos_EndProc(theplayer2, @ClosePlayer1);

          /// procedure to execute when stream is terminated
          // Assign the procedure of object to execute at end
          // PlayerIndex : Index of a existing Player
          // ClosePlayer1 : procedure of object to execute inside the general loop

          btinfos.Enabled := True;

          trackbar1.Value   := 0;
          trackbar1.Enabled := True;

          wavefo2.trackbar1.Value   := 0;
          wavefo2.container.frame.scrollpos_x := 0;
          wavefo2.trackbar1.Enabled := True;

          theplaying2     := historyfn.Value;
          wavefo2.Caption := 'Wave2 of ' + historyfn.Value;

          if vuinvar then
          begin
            vuLeft.Visible  := True;
            vuRight.Visible := True;
            commanderfo.vuLeft2.Visible := True;
            commanderfo.vuRight2.Visible := True;
          end;

          with commanderfo do
          begin
            btnStop2.Enabled   := True;
            btnresume2.Enabled := False;
            btnresume2.Visible := False;
            btnPause2.Enabled  := True;
            if cbloop.Value = True then
              btnPause2.Enabled := False
            else
              btnPause2.Enabled := True;

          end;

          btnStop.Enabled := True;

          hasmixed2 := False;

          if Sender <> nil then
          begin
            if (TButton(Sender).tag = 0) or (TButton(Sender).tag = 2) or
              (TButton(Sender).tag = 4) then
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
              uos_Play(theplayer2);  /// everything is ready, here we are, lets play it...
              btnpause.Enabled := True;
              btnpause.Visible := True;
            end;
            tstringdisp1.face.template := mainfo.tfacegreen;
            tstringdisp1.Value := msestring('Playing ' + theplaying2);
          end;

          if hassent = 1 then  /// cue
          begin
            // writeln('tbutton(sender).tag = 1');
            iscue2           := True;
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
              uos_Play(theplayer2);  /// everything is ready, here we are, lets play it...
              btnpause.Enabled := False;
            end;
            uos_Pause(theplayer2);
            tstringdisp1.face.template := mainfo.tfaceorange2;
            tstringdisp1.Value         := msestring('Loaded ' + theplaying2);
          end;

          cbloop.Enabled  := False;
          cbloopb.Enabled := False;
          cbloop.Visible  := False;
          //songdir.Value := historyfn.Value;
          historyfn.hint  := historyfn.Value;
          if timerwait.Enabled then
            timerwait.restart // to reset
          else
            timerwait.Enabled := True;

          lposition.face.template := mainfo.tfaceplayerlight;

          hascue2 := True;
          // application.processmessages; 

          oninfowav(Sender);

          if as_checked in wavefo2.tmainmenu1.menu[0].state then
          begin

            //  wavefo2.doechelle(nil);
            ttimer1.Enabled := False;
            ttimer1.Enabled := True;
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
  btnStop.Enabled   := True;
  btnPause.Enabled  := True;
  btnresume.Enabled := False;
  btnPause.Visible  := True;
  btnresume.Visible := False;

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template    := mainfo.tfaceplayerrev;

  if Caption = 'Player 1' then
  begin

    if vuinvar then
    begin
      vuLeft.Visible  := True;
      vuRight.Visible := True;
      commanderfo.vuLeft.Visible := True;
      commanderfo.vuRight.Visible := True;
    end;

    with commanderfo do
    begin
      btnStop.Enabled   := True;
      btnPause.Enabled  := True;
      btnresume.Enabled := False;

      btnPause.Visible  := True;
      btnresume.Visible := False;
    end;

    uos_RePlay(theplayer);

    iscue1 := False;

    tstringdisp1.Value := msestring('Playing ' + theplaying1);
  end;

  if Caption = 'Player 2' then
  begin
    if vuinvar then
    begin
      vuLeft.Visible  := True;
      vuRight.Visible := True;
      commanderfo.vuLeft2.Visible := True;
      commanderfo.vuRight2.Visible := True;
    end;

    with commanderfo do
    begin
      btnStop2.Enabled   := True;
      btnPause2.Enabled  := True;
      btnresume2.Enabled := False;
      btnPause2.Visible  := True;
      btnresume2.Visible := False;
    end;

    uos_RePlay(theplayer2);
    iscue2 := False;
    tstringdisp1.Value := msestring('Playing ' + theplaying2);
  end;

end;

procedure tsongplayerfo.doplayerpause(const Sender: TObject);
begin
  vuLeft.Visible  := False;
  vuRight.Visible := False;
  //vuright.value    := 0;
  //vuleft.value     := 0;
  //vuright.Height    := 0;
  //vuleft.Height     := 0;

  btnStop.Enabled   := True;
  btnPause.Enabled  := False;
  btnresume.Enabled := True;

  btnPause.Visible  := False;
  btnresume.Visible := True;

  tstringdisp1.face.template := mainfo.tfacered;
  lposition.face.template    := mainfo.tfaceplayerrev;

  if Caption = 'Player 1' then
  begin
    with commanderfo do
    begin
      vuLeft.Visible    := False;
      vuRight.Visible   := False;
      // vuright.value    := 0;
      // vuleft.value     := 0;
      // vuright.Height    := 0;
      // vuleft.Height     := 0;
      btnStop.Enabled   := True;
      btnPause.Enabled  := False;
      btnresume.Enabled := True;
      btnPause.Visible  := False;
      btnresume.Visible := True;
    end;

    uos_Pause(theplayer);

    tstringdisp1.Value := msestring('Paused ' + theplaying1);
  end;

  if Caption = 'Player 2' then
  begin
    with commanderfo do
    begin
      vuLeft2.Visible    := False;
      vuRight2.Visible   := False;
      //vuright2.value    := 0;
      //vuleft2.value     := 0;
      //vuright2.Height    := 0;
      //vuleft2.Height     := 0;
      btnStop2.Enabled   := True;
      btnPause2.Enabled  := False;
      btnresume2.Enabled := True;
      btnPause2.Visible  := False;
      btnresume2.Visible := True;
    end;

    uos_Pause(theplayer2);
    tstringdisp1.Value := msestring('Paused ' + theplaying2);
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

procedure tsongplayerfo.setequalizerenable(asender: integer; avalue: Boolean);
var
  aplayer: integer;
  x: integer;
  avalset: Boolean;
begin
  if asender = 1 then
    aplayer := theplayer
  else if asender = 2 then
    aplayer := theplayer2;

  if avalue then
    avalset := False
  else
    avalset := True;

  for x := 1 to 10 do
    uos_InputSetFilter(aplayer, Inputindex1, Equalizer_Bands[x].theindex, -1, -1, -1, -1, -1, -1, -1, -1, True, nil, avalset);

end;

procedure tsongplayerfo.changefrequency(asender, aindex: integer; gainl, gainr: double);
var
  aplayer: integer;
  isenable: Boolean = False;
begin
  if asender = 1 then
    isenable := equalizerfo1.EQEN.Value;
  if asender = 2 then
    isenable := equalizerfo2.EQEN.Value;

  //if isenable then isenable := false else isenable := true;

  if asender = 1 then
    aplayer := theplayer
  else if asender = 2 then
    aplayer := theplayer2;
  begin

    //  if (btnStart.Enabled = true) then
    uos_InputSetFilter(aplayer, Inputindex1, Equalizer_Bands[aindex].theindex, -1, -1, -1, Gainl, -1, -1, -1, Gainr,
      True, nil, isenable);
  end;
  // end;  

end;

procedure tsongplayerfo.changevolume(const Sender: TObject);
begin

  if hasinit = 1 then
  begin
    if (trealspinedit(Sender).tag = 0) then
      edvolleft.face.template  := mainfo.tfaceorange
    else
      edvolright.face.template := mainfo.tfaceorange;

    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;

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
  edtempo.Value         := 1;
  edtempo.face.template := mainfo.tfaceorange;
  button1.face.template := mainfo.tfaceorange;
  if timersent.Enabled then
    timersent.restart // to reset
  else
    timersent.Enabled := True;
end;

procedure tsongplayerfo.paintsliderimage(const Canvas: tcanvas; const arect: rectty);
var
  poswav, poswav2, poswav3: pointty;
  poswavx: integer;
begin

  if (arect.cy > 0) and (arect.cx > 0) then
  begin

    if Caption = 'Player 1' then
      if (iswav = True) and (waveformcheck.Value = True) then
      begin

        poswav.x := 6;
        poswav.y := (trackbar1.Height div 2) - 2;

        poswav2.x := 6;
        //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdata1[poswav.x * 2]) * ((trackbar1.Height div 2) - 3));

        while poswav.x < (length(waveformdata1) div chan1) - 1 do
        begin
          if chan1 = 2 then
          begin
            poswav.y  := (trackbar1.Height div 2) - 2;
            poswav2.x := poswav.x;
            poswavx   := poswav.x - 6;
            poswav2.y := ((arect.cy div 2) - 1) - round((waveformdata1[poswavx * 2]) * ((arect.cy div 2) - 3));

            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;

            Canvas.drawline(poswav, poswav2, configfo.tcoloredit1.Value);

            //      if mainfo.typecolor.Value <> 2 then
            //    canvas.drawline(poswav2, poswav3,cl_black) else
            Canvas.drawline(poswav2, poswav3, $F0F0F0); // frame of wave

            poswav.y := (trackbar1.Height div 2);

            poswav2.y := poswav.y + (round((waveformdata1[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

            //  if mainfo.typecolor.Value = 0 then
            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            // if mainfo.typecolor.Value = 0 then
            Canvas.drawline(poswav, poswav2, configfo.tcoloredit2.Value);
            //     if mainfo.typecolor.Value <> 2 then
            //   canvas.drawline(poswav2, poswav3,cl_black) else
            Canvas.drawline(poswav2, poswav3, $F0F0F0);

          end;
          if chan1 = 1 then
            // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
            // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
          ;
          Inc(poswav.x, 1);
        end;
      end;

    if Caption = 'Player 2' then
      if (iswav2 = True) and (waveformcheck.Value = True) then
      begin

        poswav.x := 6;
        poswav.y := (trackbar1.Height div 2) - 2;

        poswav2.x := 6;
        //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdata2[poswav.x * 2]) * ((trackbar1.Height div 2) - 3));

        while poswav.x < length(waveformdata2) div chan2 do
        begin
          if chan2 = 2 then
          begin
            poswav.y  := (trackbar1.Height div 2) - 2;
            poswav2.x := poswav.x;
            poswavx   := poswav.x - 6;
            poswav2.y := ((arect.cy div 2) - 1) - round((waveformdata2[poswavx * 2]) * ((arect.cy div 2) - 3));
            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            // if mainfo.typecolor.Value = 0 then
            Canvas.drawline(poswav, poswav2, configfo.tcoloredit12.Value);
            //     if mainfo.typecolor.Value <> 2 then
            //   canvas.drawline(poswav2, poswav3,cl_black) else
            Canvas.drawline(poswav2, poswav3, $F0F0F0);

            poswav.y := (trackbar1.Height div 2);

            poswav2.y := poswav.y + (round((waveformdata2[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            // if mainfo.typecolor.Value = 0 then
            Canvas.drawline(poswav, poswav2, configfo.tcoloredit22.Value);
            //    if mainfo.typecolor.Value <> 2 then
            //  canvas.drawline(poswav2, poswav3,cl_black) else
            Canvas.drawline(poswav2, poswav3, $F0F0F0);
            // else
            //   canvas.drawline(poswav, poswav2, $8A8A8A);

          end;
          if chan2 = 1 then
            // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
            // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
          ;
          Inc(poswav.x, 1);
        end;
      end;
  end;
end;


procedure tsongplayerfo.paintsliderimageform(const Canvas: tcanvas; const arect: rectty);
var
  poswav, poswav2, poswav3: pointty;
  poswavx: integer;
begin

  if Caption = 'Player 1' then
    if (iswav = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo.trackbar1.Height div 2) - 2;

      poswav2.x := 6;

      //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform1[poswav.x * 2]) * ((wavefo.trackbar1.Height div 2) - 3));

      while (poswav.x < (length(waveformdataform1) div chan1) - 1) and (poswav.x < wavefo.trackbar1.Width) do
      begin
        if chan1 = 2 then
        begin
          poswav.y  := (wavefo.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx   := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdataform1[poswavx * 2]) * ((arect.cy div 2) - 3));
          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          // if mainfo.typecolor.Value = 0 then
          Canvas.drawline(poswav, poswav2, configfo.tcoloredit1.Value);

          //  if mainfo.typecolor.Value <> 2 then
          //   canvas.drawline(poswav2, poswav3,cl_black) else
          Canvas.drawline(poswav2, poswav3, $F0F0F0);

          poswav.y := (wavefo.trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdataform1[(poswavx * 2) + 1]) * ((wavefo.trackbar1.Height div 2) - 3)));

          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          // if mainfo.typecolor.Value = 0 then
          Canvas.drawline(poswav, poswav2, configfo.tcoloredit2.Value);
          //   if mainfo.typecolor.Value <> 2 then
          //  canvas.drawline(poswav2, poswav3,cl_black) else
          Canvas.drawline(poswav2, poswav3, $F0F0F0);
        end;
        if chan1 = 1 then
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        ;
        Inc(poswav.x, 1);
      end;
    end;

  if Caption = 'Player 2' then
    if (iswav2 = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo2.trackbar1.Height div 2) - 2;

      poswav2.x := 6;
      //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform2[poswav.x * 2]) * ((wavefo2.trackbar1.Height div 2) - 3));

      while (poswav.x < length(waveformdataform2) div chan2) and (poswav.x < wavefo2.trackbar1.Width) do
      begin
        if chan2 = 2 then
        begin
          poswav.y  := (wavefo2.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx   := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - round((waveformdataform2[poswavx * 2]) * ((arect.cy div 2) - 3));

          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          // if mainfo.typecolor.Value = 0 then
          Canvas.drawline(poswav, poswav2, configfo.tcoloredit12.Value);
          //  if mainfo.typecolor.Value <> 2 then
          // canvas.drawline(poswav2, poswav3,cl_black) else
          Canvas.drawline(poswav2, poswav3, $F0F0F0);

          poswav.y := (wavefo2.trackbar1.Height div 2);

          poswav2.y := poswav.y + (round((waveformdataform2[(poswavx * 2) + 1]) * ((wavefo2.trackbar1.Height div 2) - 3)));
          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          // if mainfo.typecolor.Value = 0 then
          Canvas.drawline(poswav, poswav2, configfo.tcoloredit22.Value);
          //    if mainfo.typecolor.Value <> 2 then
          // canvas.drawline(poswav2, poswav3,cl_black) else
          Canvas.drawline(poswav2, poswav3, $F0F0F0);

        end;
        if chan2 = 1 then
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        ;
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
      iswav         := True;
      application.ProcessMessages;
      DrawWaveForm();
    end;

  if Caption = 'Player 2' then
    if (waveformcheck.Value = True) then
    begin
      waveformdata2 := uos_InputGetLevelArray(theplayerinfo2, 0);
      iswav2        := True;
      application.ProcessMessages;
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
      application.ProcessMessages;
      formDrawWaveForm();
    end;

  if Caption = 'Player 2' then

    if as_checked in wavefo2.tmainmenu1.menu[0].state then

      //   if (wavefo2.waveon.Value = True) then
    begin
      waveformdataform2 := uos_InputGetLevelArray(theplayerinfoform2, 0);
      application.ProcessMessages;
      formDrawWaveForm();
    end;

end;


procedure tsongplayerfo.DrawWaveForm();
const
  transpcolor = cl_magenta;
var
  rect1: rectty;
begin

  if ((Caption = 'Player 1') and (DrawWaveFormbusy1 = False)) or
    ((Caption = 'Player 2') and (DrawWaveFormbusy2 = False)) then
  begin

    if Caption = 'Player 1' then
      DrawWaveFormbusy1 := True;
    if Caption = 'Player 2' then
      DrawWaveFormbusy2 := True;

    // if (waveformcheck.value = true) then begin
    trackbar1.invalidate();

    //  writeln(inttostr(length(waveformdata1)));
    rect1.pos  := nullpoint;
    rect1.size := trackbar1.paintsize;

    with sliderimage.bitmap do
    begin
      size   := rect1.size;
      masked := False;
      init(transpcolor);
      paintsliderimage(Canvas, rect1);
      transparentcolor := transpcolor;
      masked := True;
    end;
    if Caption = 'Player 1' then
      DrawWaveFormbusy1 := False;
    if Caption = 'Player 2' then
      DrawWaveFormbusy2 := False;
  end;
end;

procedure tsongplayerfo.FormDrawWaveForm();
const
  transpcolor = cl_gray;
var
  rect1form: rectty;
begin

  if (Caption = 'Player 1') and
    (FormDrawWaveFormbusy1 = False) and
    (as_checked in wavefo.tmainmenu1.menu[0].state) then
  begin
    FormDrawWaveFormbusy1 := True;
    wavefo.trackbar1.invalidate();

    rect1form.pos  := nullpoint;
    rect1form.size := wavefo.trackbar1.paintsize;

    with wavefo.sliderimage.bitmap do
    begin
      size   := rect1form.size;
      masked := False;
      init(transpcolor);
      paintsliderimageform(Canvas, rect1form);
      transparentcolor := transpcolor;
      masked := True;
    end;
    buzywaveform1 := False;
    FormDrawWaveFormbusy1 := False;
  end;

  if (Caption = 'Player 2') and (FormDrawWaveFormbusy2 = False) and (as_checked in wavefo2.tmainmenu1.menu[0].state) then
  begin
    FormDrawWaveFormbusy2 := True;
    wavefo2.trackbar1.invalidate();

    rect1form.pos  := nullpoint;
    rect1form.size := wavefo2.trackbar1.paintsize;

    with wavefo2.sliderimage.bitmap do
    begin
      size   := rect1form.size;
      masked := False;
      init(transpcolor);
      paintsliderimageform(Canvas, rect1form);
      transparentcolor := transpcolor;
      masked := True;
    end;
    buzywaveform2 := False;
    FormDrawWaveFormbusy2 := False;
  end;

end;

procedure tsongplayerfo.onwavform(const Sender: TObject);
var
  framewanted: integer;
begin

  if (Caption = 'Player 1') and (as_checked in wavefo.tmainmenu1.menu[0].state) and (buzywaveform1 = False) then
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      uos_Stop(theplayerinfoform);
      uos_CreatePlayer(theplayerinfoform);

      application.ProcessMessages;
      // Create the player.
      // PlayerIndex : from 0 to what your computer can do !
      // If PlayerIndex exists already, it will be overwriten...

      if uos_AddFromFile(theplayerinfoform, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
      begin

        buzywaveform1 := True;

        uos_InputSetLevelArrayEnable(theplayerinfoform, 0, 2);
        // set level calculation (default is 0)
        // 0 => no calcul
        // 1 => calcul before all DSP procedures.
        // 2 => calcul after all DSP procedures.

        // determine how much frame will be designed
        if (wavefo.trackbar1.Width < Inputlength1 div 64) then
        else
        begin
          wavefo.trackbar1.Width := wavefo.Width - 10;
          wavefo.doechelle(nil);
          wavefo.tmainmenu1.menu[2].Caption := ' Now=X1 ';
        end;

        framewanted := Inputlength1 div (wavefo.trackbar1.Width - 7);

        uos_InputSetFrameCount(theplayerinfoform, 0, framewanted);

        // Assign the procedure of object to execute at end of stream
        uos_EndProc(theplayerinfoform, @GetWaveDataform);

        //   application.ProcessMessages;

        uos_Play(theplayerinfoform);  /// everything is ready, here we are, lets do it...

      end;
    end;

  if (Caption = 'Player 2') and (as_checked in wavefo2.tmainmenu1.menu[0].state) and (buzywaveform2 = False) then
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      uos_Stop(theplayerinfoform2);

      initwaveform2 := True;

      uos_CreatePlayer(theplayerinfoform2);
      // Create the player.
      // PlayerIndex : from 0 to what your computer can do !
      // If PlayerIndex exists already, it will be overwriten...

      application.ProcessMessages;

      if uos_AddFromFile(theplayerinfoform2, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
      begin
        buzywaveform2 := True;

        uos_InputSetLevelArrayEnable(theplayerinfoform2, 0, 2);
        // set level calculation (default is 0)
        // 0 => no calcul
        // 1 => calcul before all DSP procedures.
        // 2 => calcul after all DSP procedures.

        // determine how much frame will be designed
        if (wavefo2.trackbar1.Width < Inputlength2 div 64) then
        else
        begin
          wavefo2.trackbar1.Width := wavefo.Width - 10;
          wavefo2.doechelle(nil);
          wavefo2.tmainmenu1.menu[2].Caption := ' Now=X1 ';
        end;

        framewanted := Inputlength2 div (wavefo2.trackbar1.Width - 7);

        uos_InputSetFrameCount(theplayerinfoform2, 0, framewanted);

        // Assign the procedure of object to execute at end of stream
        uos_EndProc(theplayerinfoform2, @GetWaveDataform);

        //application.ProcessMessages;

        uos_Play(theplayerinfoform2);  /// everything is ready, here we are, lets do it...

      end;
    end;
end;

procedure tsongplayerfo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  hassent: shortint;
  ho, mi, se, ms: word;
  framewanted: integer;
  fileex: msestring;
  thebuffer: TDArFloat;
  thebufferinfos: TuosF_BufferInfos;
  CommonTags: TCommonTags;
begin
  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
    (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') then
  begin

    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      if Sender <> nil then
      begin
        if TButton(Sender).tag = 9 then
          hassent := 1
        else
          hassent := 0;
      end
      else
        hassent := 0;

      if Caption = 'Player 1' then
      begin
        if (hassent = 1) or (hassent = 0) then
        begin

          if readtag(ansistring(historyfn.Value)) = 0 then
          begin
            infosfo.imgPreview.bitmap.LoadFromStream(TagReader.Tags.Images[0].Image);
            infosfo.imgPreview.Visible := True;
          end
          else
            infosfo.imgPreview.Visible := False;

          CommonTags := TagReader.GetCommonTags;

          infosfo.infofile.Caption   := trim(extractfilename(historyfn.Value));
          infosfo.infoname.Caption   := trim(CommonTags.Title);
          infosfo.infoartist.Caption := trim(CommonTags.Artist);
          infosfo.infoalbum.Caption  := trim(CommonTags.Album);
          infosfo.infoyear.Caption   := trim(CommonTags.Year);
          infosfo.infocom.Caption    := trim(CommonTags.Comment);
          infosfo.infotag.Caption    := trim(CommonTags.Genre);
          infosfo.infolength.Caption := trim(utf8decode(TimeToStr(CommonTags.Duration / MSecsPerDay)));
          infosfo.inforate.Caption   := trim(IntToStr(TagReader.MediaProperty.Sampling));
          // format('%d Hz', [TagReader.MediaProperty.Sampling]);
      
            if trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'joint stereo' then
          infosfo.infochan.Caption   := 'Stereo' else          
          infosfo.infochan.Caption   := trim(TagReader.MediaProperty.ChannelMode);


          // BPM

          infosfo.infobpm.Caption := '';

          if plugsoundtouch = True then
          begin
            thebuffer := uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024 * 2);
            //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));
            infosfo.infobpm.Caption := trim(utf8decode(
              IntToStr(round(uos_GetBPM(thebuffer, thebufferinfos.channels,
              thebufferinfos.samplerate)))));
          end;
       {
               maxwidth := 200;
          
              if maxwidth < infosfo.infofile.Width then
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
           if maxwidth < infosfo.inforate.Width then
            maxwidth := infosfo.inforate.Width;  
     
         if infosfo.imgPreview.Visible then     
          infosfo.Width := 442 else
          begin
           if maxwidth > 200 then  infosfo.Width := maxwidth + 10 else 
          infosfo.Width := 200;
          end;         
        }
          //  infosfo.Width := 442;
          //  infosfo.height := 238 ;

          if (hassent = 1) then
          begin
            infosfo.Visible := True;
            infosfo.bringtofront;
          end;
        end;
        if (hassent = 0) and (waveformcheck.Value = True) and (iswav = False) then
        begin

          uos_Stop(theplayerinfo);

          uos_CreatePlayer(theplayerinfo);

          application.ProcessMessages;

          uos_AddFromFile(theplayerinfo, PChar(ansistring(historyfn.Value)), -1, 2, -1);

          Inputlength1 := uos_Inputlength(theplayerinfo, 0);

          chan1 := uos_InputGetChannels(theplayerinfo, 0);

          // set calculation of level/volume into array (usefull for wave form procedure)
          uos_InputSetLevelArrayEnable(theplayerinfo, 0, 2);
          // set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.

          // determine how much frame will be designed
          framewanted := Inputlength1 div (trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfo, 0, framewanted);

          // Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfo, @GetWaveData);
          //  application.processmessages;

          uos_Play(theplayerinfo);  /// everything is ready, here we are, lets do it...
          //application.processmessages;

        end;

      end;

      if Caption = 'Player 2' then
      begin
        if (hassent = 1) or (hassent = 0) then
        begin

          if readtag(ansistring(historyfn.Value)) = 0 then
          begin
            infosfo2.imgPreview.bitmap.LoadFromStream(TagReader.Tags.Images[0].Image);
            infosfo2.imgPreview.Visible := True;
          end
          else
            infosfo2.imgPreview.Visible := False;

          CommonTags := TagReader.GetCommonTags;

          infosfo2.infofile.Caption   := trim(extractfilename(historyfn.Value));
          infosfo2.infoname.Caption   := trim(CommonTags.Title);
          infosfo2.infoartist.Caption := trim(CommonTags.Artist);
          infosfo2.infoalbum.Caption  := trim(CommonTags.Album);
          infosfo2.infoyear.Caption   := trim(CommonTags.Year);
          infosfo2.infocom.Caption    := trim(CommonTags.Comment);
          infosfo2.infotag.Caption    := trim(CommonTags.Genre);
          infosfo2.infolength.Caption := trim(utf8decode(TimeToStr(CommonTags.Duration / MSecsPerDay)));
          infosfo2.inforate.Caption   := trim(IntToStr(TagReader.MediaProperty.Sampling));
          // format('%d Hz', [TagReader.MediaProperty.Sampling]);
          if trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'joint stereo' then
          infosfo2.infochan.Caption   := 'Stereo' else          
          infosfo2.infochan.Caption   := trim(TagReader.MediaProperty.ChannelMode);

          // BPM

          infosfo2.infobpm.Caption := '';

          if plugsoundtouch = True then
          begin

            thebuffer := uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024 * 2);
            infosfo2.infobpm.Caption :=
              trim(utf8decode(IntToStr(round(uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate)))));

          end;
       {
          maxwidth := 200;
          
              if maxwidth < infosfo2.infofile.Width then
              maxwidth := infosfo2.infofile.Width;
      
          if maxwidth < infosfo2.infoname.Width then
            maxwidth := infosfo2.infoname.Width;
          if maxwidth < infosfo2.infoartist.Width then
            maxwidth := infosfo2.infoartist.Width;
          if maxwidth < infosfo2.infoalbum.Width then
            maxwidth := infosfo2.infoalbum.Width;
          if maxwidth < infosfo2.infoyear.Width then
            maxwidth := infosfo2.infoyear.Width;
          if maxwidth < infosfo2.infocom.Width then
            maxwidth := infosfo2.infocom.Width;
          if maxwidth < infosfo2.infotag.Width then
            maxwidth := infosfo2.infotag.Width;
          if maxwidth < infosfo2.infolength.Width then
            maxwidth := infosfo2.infolength.Width;
          if maxwidth < infosfo2.infobpm.Width then
            maxwidth := infosfo2.infobpm.Width;

       
           if infosfo2.imgPreview.Visible then     
          infosfo2.Width := 442 else
          begin
          if maxwidth > 200 then  infosfo2.Width := maxwidth + 10 else 
           infosfo2.Width := 200;
          end;         
        }
          //  infosfo2.Width := 442;  
          //  infosfo2.height := 238 ;

          if (hassent = 1) then
          begin
            infosfo2.Visible := True;
            infosfo2.bringtofront;
          end;
        end;
        if (hassent = 0) and (waveformcheck.Value = True) and (iswav2 = False) then
        begin

          uos_Stop(theplayerinfo2);

          uos_CreatePlayer(theplayerinfo2);

          application.ProcessMessages;

          uos_AddFromFile(theplayerinfo2, PChar(ansistring(historyfn.Value)), -1, 2, -1);

          Inputlength2 := uos_Inputlength(theplayerinfo2, 0);

          chan2 := uos_InputGetChannels(theplayerinfo2, 0);

          // set calculation of level/volume into array (usefull for wave form procedure)
          uos_InputSetLevelArrayEnable(theplayerinfo2, 0, 2);
          // set level calculation (default is 0)
          // 0 => no calcul
          // 1 => calcul before all DSP procedures.
          // 2 => calcul after all DSP procedures.

          // determine how much frame will be designed
          framewanted := Inputlength2 div (trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfo2, 0, framewanted);

          // Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfo2, @GetWaveData);

          uos_Play(theplayerinfo2);  /// everything is ready, here we are, lets do it...
          // application.processmessages;

        end;
      end;
    end
    else
      ShowMessage(historyfn.Value + ' does not exist or not mounted...');
  end
  else
    ShowMessage(historyfn.Value + ' is not a audio file...');
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
      temptime        := tottime1 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

    if Caption = 'Player 2' then
    begin
      temptime        := tottime2 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

  end;

end;

procedure tsongplayerfo.visiblechangeev(const Sender: TObject);
begin
  if (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin
    if Caption = 'Player 1' then
      if Visible then
        mainfo.tmainmenu1.menu[4].submenu[4].Caption := ' Hide Player 1 '
      else
      begin
        uos_Stop(theplayer);
        mainfo.tmainmenu1.menu[4].submenu[4].Caption := ' Show Player 1 ';
      end;

    if Caption = 'Player 2' then
      if Visible then
        mainfo.tmainmenu1.menu[4].submenu[5].Caption := ' Hide Player 2 '
      else
      begin
        uos_Stop(theplayer2);
        mainfo.tmainmenu1.menu[4].submenu[5].Caption := ' Show Player 2 ';
      end;
    if norefresh = False then
    begin
      mainfo.updatelayoutstrum();
      if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();
      if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();
      if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();
      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();
      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayoutpan();
    end;
  end;
end;

procedure tsongplayerfo.onplayercreate(const Sender: TObject);
var
  ordir: msestring;
begin
  windowopacity := 0;

  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  Timerwait          := ttimer.Create(nil);
  Timerwait.interval := 250000;
  Timerwait.Enabled  := False;
  Timerwait.ontimer  := @ontimerwait;
  Timerwait.options  := [to_single];

  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.ontimer  := @ontimersent;
  Timersent.options  := [to_single];

  if plugsoundtouch = False then
  begin
    edtempo.Visible   := False;
    cbtempo.Visible   := False;
    Button1.Visible   := False;
    Button2.Visible   := False;
    tstringdisp2.left := 377;
    tstringdisp2.top  := 64;
  end;

  ordir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));

  if historyfn.Value = '' then
    historyfn.Value := ordir + 'sound' + directoryseparator + 'song' + directoryseparator + 'test.ogg';

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

procedure tsongplayerfo.whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  if Caption = 'Player 1' then
    thesender := 0;
  if Caption = 'Player 2' then
    thesender := 1;
end;

procedure tsongplayerfo.ondestr(const Sender: TObject);
begin
  uos_Stop(theplayer);
  uos_Stop(theplayer2);
  statusanim        := 0;
  Timerwait.Enabled := False;
  Timerwait.Enabled := False;
  Timerwait.Free;
  timersent.Free;
end;

procedure tsongplayerfo.changevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  changevolume(Sender);
end;

procedure tsongplayerfo.oncreated(const Sender: TObject);
begin

  Equalizer_Bands[1].lo_freq  := 18;
  Equalizer_Bands[1].hi_freq  := 46;
  Equalizer_Bands[1].Text     := '31';
  Equalizer_Bands[2].lo_freq  := 47;
  Equalizer_Bands[2].hi_freq  := 94;
  Equalizer_Bands[2].Text     := '62';
  Equalizer_Bands[3].lo_freq  := 95;
  Equalizer_Bands[3].hi_freq  := 188;
  Equalizer_Bands[3].Text     := '125';
  Equalizer_Bands[4].lo_freq  := 189;
  Equalizer_Bands[4].hi_freq  := 375;
  Equalizer_Bands[4].Text     := '250';
  Equalizer_Bands[5].lo_freq  := 376;
  Equalizer_Bands[5].hi_freq  := 750;
  Equalizer_Bands[5].Text     := '500';
  Equalizer_Bands[6].lo_freq  := 751;
  Equalizer_Bands[6].hi_freq  := 1500;
  Equalizer_Bands[6].Text     := '1K';
  Equalizer_Bands[7].lo_freq  := 1501;
  Equalizer_Bands[7].hi_freq  := 3000;
  Equalizer_Bands[7].Text     := '2K';
  Equalizer_Bands[8].lo_freq  := 3001;
  Equalizer_Bands[8].hi_freq  := 4000;
  Equalizer_Bands[8].Text     := '4K';
  Equalizer_Bands[9].lo_freq  := 4001;
  Equalizer_Bands[9].hi_freq  := 6000;
  Equalizer_Bands[9].Text     := '6K';
  Equalizer_Bands[10].lo_freq := 6001;
  Equalizer_Bands[10].hi_freq := 16000;
  Equalizer_Bands[10].Text    := '16K';

  setlength(arl, 10);
  setlength(arr, 10);

  setlength(arl2, 10);
  setlength(arr2, 10);

  ttimer2.Enabled := True;
end;

procedure tsongplayerfo.faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  Canvas.drawline(point1, point2, cl_red);

end;

procedure tsongplayerfo.onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
var
  mixtime: integer;
  dopos: Boolean = False;
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
      if akind = sbe_thumbposition then
        uos_InputSeek(theplayer, Inputindex1, trunc(avalue * Inputlength1));
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
      if akind = sbe_thumbposition then
        uos_InputSeek(theplayer2, Inputindex2, trunc(avalue * Inputlength2));
  end;

end;

procedure tsongplayerfo.changeloop(const Sender: TObject);
begin
  if Caption = 'Player 1' then
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

  if Caption = 'Player 2' then
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

procedure tsongplayerfo.onchachewav(const Sender: TObject);
begin
  DrawWaveForm();
  //  application.processmessages;
  //  formDrawWaveForm();
end;

procedure tsongplayerfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  if (trealspinedit(Sender).tag = 9) then
  begin
    if avalue > 2 then
    begin
      hintlabel.Caption := utf8decode('"' + IntToStr(trunc(avalue)) + '" is > 2.  Reset to 2.');
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
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
      else
        timersent.Enabled := True;
      avalue := 0.4;
    end;
  end
  else
  begin

    if avalue > 100 then
    begin
      hintlabel.Caption := utf8decode('"' + IntToStr(trunc(avalue)) + '" is > 100.  Reset to 100.');
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      if timersent.Enabled then
        timersent.restart // to reset
      else
        timersent.Enabled := True;
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
      else
        timersent.Enabled := True;
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

          button2.Caption         := utf8decode(IntToStr(round(thebpm)));
          drumsfo.edittempo.Value := round(thebpm);
          button2.face.template   := mainfo.tfaceorange;
          if timersent.Enabled then
            timersent.restart // to reset
          else
            timersent.Enabled := True;
        end;
      end;
    end;

  if Caption = 'Player 2' then
    if plugsoundtouch = True then
    begin
      if btncue.Enabled = True then
        btncue.onexecute(Sender);

      if fileexists(theplaying2) then
      begin

        thebuffer := uos_File2Buffer(PChar(ansistring(theplaying2)), 0, thebufferinfos, uos_InputPosition(theplayer2, Inputindex2), 1024);
        //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer)));
        thebpm    := uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate);
        if thebpm = 0 then
          button2.Caption := 'BPM'
        else
        begin
          button2.Caption         := utf8decode(IntToStr(round(thebpm)));
          drumsfo.edittempo.Value := round(thebpm);
          button2.face.template   := mainfo.tfaceorange;

          if timersent.Enabled then
            timersent.restart // to reset
          else
            timersent.Enabled := True;
        end;
      end;
    end;
end;

procedure tsongplayerfo.ontimerwaveform(const Sender: TObject);
begin
  onwavform(Sender);
end;

procedure tsongplayerfo.opendir(const Sender: TObject);
begin
  tfiledialog1.controller.captionopen := 'Open Audio File';
  tfiledialog1.controller.filter      := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
  tfiledialog1.controller.fontcolor   := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
  begin
    historyfn.Value := tfiledialog1.controller.filename;
    historyfn.dropdown.history :=
      tfiledialog1.controller.history;
  end;
end;

procedure tsongplayerfo.onexecbutlght(const Sender: TObject);
begin
  if TButton(Sender).Name = 'cbloopb' then
    if TButton(Sender).tag = 0 then
    begin
      cbloop.Value        := True;
      TButton(Sender).tag := 1;
      TButton(Sender).face.template := commanderfo.tfacegreen;
    end
    else
    begin
      cbloop.Value        := False;
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := commanderfo.tfacebutgray;
    end;

  if TButton(Sender).Name = 'playreverseb' then
    if TButton(Sender).tag = 0 then
    begin
      playreverse.Value   := True;
      TButton(Sender).tag := 1;
      TButton(Sender).face.template := commanderfo.tfacegreen;
    end
    else
    begin
      playreverse.Value   := False;
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := commanderfo.tfacebutgray;
    end;

  if TButton(Sender).Name = 'waveformcheckb' then
    if TButton(Sender).tag = 0 then
    begin
      waveformcheck.Value           := True;
      TButton(Sender).tag           := 1;
      TButton(Sender).face.template := commanderfo.tfacegreen;
    end
    else
    begin
      waveformcheck.Value           := False;
      TButton(Sender).tag           := 0;
      TButton(Sender).face.template := commanderfo.tfacebutgray;
    end;

  if TButton(Sender).Name = 'setmonob' then
    if TButton(Sender).tag = 0 then
    begin
      setmono.Value       := True;
      TButton(Sender).tag := 1;
      TButton(Sender).face.template := commanderfo.tfacegreen;
    end
    else
    begin
      setmono.Value       := False;
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := commanderfo.tfacebutgray;
    end;

  if TButton(Sender).Name = 'cbtempob' then
    if TButton(Sender).tag = 0 then
    begin
      cbtempo.Value       := True;
      TButton(Sender).tag := 1;
      TButton(Sender).face.template := commanderfo.tfacegreen;
    end
    else
    begin
      cbtempo.Value       := False;
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := commanderfo.tfacebutgray;
    end;

end;

procedure tsongplayerfo.ontimercheck(const Sender: TObject);
begin

  if cbloop.Value then
  begin
    cbloopb.tag           := 1;
    cbloopb.face.template := commanderfo.tfacegreen;
  end
  else
  begin
    cbloopb.tag           := 0;
    cbloopb.face.template := commanderfo.tfacebutgray;
  end;

  if playreverse.Value then
  begin
    playreverseb.tag           := 1;
    playreverseb.face.template := commanderfo.tfacegreen;
  end
  else
  begin
    playreverseb.tag           := 0;
    playreverseb.face.template := commanderfo.tfacebutgray;
  end;

  if waveformcheck.Value then
  begin
    waveformcheckb.tag           := 1;
    waveformcheckb.face.template := commanderfo.tfacegreen;
  end
  else
  begin
    waveformcheckb.tag           := 0;
    waveformcheckb.face.template := commanderfo.tfacebutgray;
  end;

  if setmono.Value then
  begin
    setmonob.tag           := 1;
    setmonob.face.template := commanderfo.tfacegreen;
  end
  else
  begin
    setmonob.tag           := 0;
    setmonob.face.template := commanderfo.tfacebutgray;
  end;

  if cbtempo.Value then
  begin
    cbtempob.tag           := 1;
    cbtempob.face.template := commanderfo.tfacegreen;
  end
  else
  begin
    cbtempob.tag           := 0;
    cbtempob.face.template := commanderfo.tfacebutgray;
  end;

end;

end.

