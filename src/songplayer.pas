unit songplayer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  ctypes, 
  uos_flat,
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
  msegridsglob,
  msetimer,
  mseimage;

type
  tsongplayerfo = class(tdockform)
    Timerwait: Ttimer;
    Timersent: Ttimer;
    tgroupbox1: tgroupbox;
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
    tfiledialog1: tfiledialogx;
    ttimerwavdata: ttimer;
    edvolleft: trealspinedit;
    edpitch: trealspinedit;
    panelwave: tpaintbox;
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
    procedure checksoundtouch(const Sender: TObject);
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
    procedure resizesp(fontheight: integer);
    procedure ontimerwavdata(const Sender: TObject);
    procedure InitDrawLive();
    procedure InitDrawLivewav();
    procedure DrawLive(lv, rv: double);
    
   procedure onmouseev(const sender: twidget; var ainfo: mouseeventinfoty);
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
  xreclive1, xreclive2, xreclivewav1, xreclivewav2: integer;
  rectrecform: rectty;
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
  tickcount: integer = 0;

implementation

uses
  mse_ovofile_mp3,
  infosd,
  captionstrumpract,
  main,
  //  {$if not defined(darwin)}
  imagedancer,
  //  {$endif}
  commander,
  config,
  configlayout,
  waveform,
  filelistform,
  equalizer,
  drums,
  spectrum1,
  dockpanel1,
  mseformatbmpicoread,
  mseformatjpgread,
  mseformatpngread,
  msegraphicstream,
  songplayer_mfm;

var
  boundchildsp: array of boundchild;


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

procedure tsongplayerfo.resizesp(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := roundmath(442 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := roundmath(128 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fontheight;

  tgroupbox1.font.Height := fontheight;
  frame.grip_size        := roundmath(8 * ratio);

  edtempo.frame.buttonsize := roundmath(22 * ratio);
  edpitch.frame.buttonsize := roundmath(22 * ratio);

  edvolleft.frame.buttonsize  := roundmath(22 * ratio);
  edvolright.frame.buttonsize := roundmath(22 * ratio);

  tstringdisp1.font.Height := fontheight;
  tstringdisp1.font.color  := font.color;

  historyfn.font.Height := fontheight;
  historyfn.font.color  := font.color;

  cbloopb.font.Height        := roundmath(14 * ratio);
  waveformcheckb.font.Height := cbloopb.font.Height;

  playreverseb.font.Height := roundmath(10 * ratio);
  setmonob.font.Height     := playreverseb.font.Height;
  cbtempob.font.Height     := playreverseb.font.Height;
  button2.font.Height      := playreverseb.font.Height;
  
  edvolleft.font.Height := fontheight;
  edvolleft.font.color  := font.color;
  
  edvolright.font.Height := fontheight;
  edvolright.font.color  := font.color;
  
  trackbar1.height := roundmath(30 * ratio); 
  
  with tgroupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildsp) - 1 do
        if children[i1].Name = boundchildsp[i2].Name then
        begin
          children[i1].left   := roundmath(boundchildsp[i2].left * ratio);
          children[i1].top    := roundmath(boundchildsp[i2].top * ratio);
          children[i1].Width  := roundmath(boundchildsp[i2].Width * ratio);
          children[i1].Height := roundmath(boundchildsp[i2].Height * ratio);
        end;
end;

procedure tsongplayerfo.Changestereo2mono(const Sender: TObject);
begin
  if tag = 0 then
    uos_InputSetDSP(theplayer, InputIndex1, DSPIndex11, setmono.Value);
  if tag = 1 then
    uos_InputSetDSP(theplayer2, InputIndex2, DSPIndex22, setmono.Value);
end;

procedure tsongplayerfo.changereverse(const Sender: TObject);
begin
  if tag = 0 then
    uos_InputSetDSP(theplayer, InputIndex1, DSPIndex1, playreverse.Value);
  if tag = 1 then
    uos_InputSetDSP(theplayer2, InputIndex2, DSPIndex2, playreverse.Value);
end;

function DSPReverseBefore1(var Data: TuosF_Data; var fft: TuosF_FFT): TDArFloat;
begin
  Result := nil;
  if (Data.position > Data.OutFrames div Data.channels) then
    uos_InputSeek(theplayer, InputIndex1, Data.position -
      (Data.OutFrames div Data.ratio));
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
  hintpanel.Visible := False;

  if mainfo.typecolor.Value = 2 then
  begin
    historyfn.font.color  := cl_white;
    edvolleft.font.color  := cl_white;
    edvolright.font.color := cl_white;
    button1.font.color    := cl_white;
    button2.font.color    := cl_white;
    edtempo.font.color    := cl_white;
    edpitch.font.color    := cl_white;
  end
  else
  begin
    historyfn.font.color  := cl_black;
    edvolleft.font.color  := cl_black;
    edvolright.font.color := cl_black;
    button1.font.color    := cl_black;
    button2.font.color    := cl_black;
    edtempo.font.color    := cl_black;
    edpitch.font.color    := cl_black;

  end;

  historyfn.face.template  := mainfo.tfaceplayer;
  edvolleft.face.template  := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template    := mainfo.tfaceplayer;
  edpitch.face.template    := mainfo.tfaceplayer;
  button1.face.template    := mainfo.tfaceplayer;
  button2.face.template    := mainfo.tfaceplayer;
end;

procedure tsongplayerfo.ontimerwait(const Sender: TObject);
begin

  if tag = 0 then
  begin
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

    btnStart.Enabled := True;
    btnStop.Enabled  := True;

    btncue.Enabled := False;

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

  if tag = 1 then
  begin

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

    btncue.Enabled := False;

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

    if (cbloop.Value = False) and (iscue2 = False) then
      btnPause.Enabled := True
    else
      btnPause.Enabled := False;

    cbloop.Visible    := False;
    cbloopb.Enabled   := False;
    trackbar1.Enabled := True;
    wavefo2.trackbar1.Enabled := True;
  end;
end;

procedure tsongplayerfo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if hasinit = 1 then
  begin

    if tag = 0 then
      if (trim(PChar(ansistring(songplayerfo.historyfn.Value))) <> '') and fileexists(ansistring(songplayerfo.historyfn.Value)) then
      begin

        if cbtempo.Value = True then
          if timersent.Enabled then
            timersent.restart        // to reset
          else
            timersent.Enabled := True// edtempo.face.template := mainfo.tfaceorange;
        ;

        uos_SetPluginSoundTouch(theplayer, PluginIndex2, edtempo.Value, edpitch.Value, cbtempo.Value);

      end;

    if tag = 1 then
      if (trim(PChar(ansistring(songplayer2fo.historyfn.Value))) <> '') and fileexists(ansistring(songplayer2fo.historyfn.Value)) then
      begin

        if cbtempo.Value = True then
          if timersent.Enabled then
            timersent.restart        // to reset
          else
            timersent.Enabled := True// edtempo.face.template := mainfo.tfaceorange;
        ;

        uos_SetPluginSoundTouch(theplayer2, PluginIndex3, edtempo.Value, edpitch.Value, cbtempo.Value);

      end;
  end;
end;

procedure tsongplayerfo.resetspectrum();
var
  i: integer = 0;
begin
  if tag = 0 then
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

  if tag = 1 then
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

  if tag = 0 then
    if (commanderfo.automix.Value = True) and (hasmixed1 = False) then
    begin
      hasmixed1   := True;
      commanderfo.onstartstop(nil);
      hasfocused1 := True;
      filelistfo.onsent(nil);
      hasfocused1 := False;
      hasmixed1   := False;
    end;

  if tag = 1 then
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

  if tag = 0 then
  begin
    theplaying1 := '';
    iswav       := False;
    iscue1      := False;

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
      vuLeft.Visible    := False;
      vuRight.Visible   := False;
    end;
    wavefo.trackbar1.Value := 0;
    wavefo.container.frame.scrollpos_x := 0;
    wavefo.trackbar1.Enabled := False;
    wavefo.panelwave.visible := true;
    hasmixed1 := False;
  end;

  if tag = 1 then
  begin
    theplaying2 := '';
    iswav2      := False;
    iscue2      := False;

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
    wavefo2.panelwave.visible := true;
   end;
  cbloop.Visible := True;
  cbloopb.Enabled   := True;
  cbloop.Enabled    := True;
  trackbar1.Value   := 0;
  trackbar1.Enabled := False;

  lposition.Value         := '00:00:00.000';
  lposition.face.template := mainfo.tfaceplayerlight;

  DrawWaveForm();

  formDrawWaveForm();

  resetspectrum();
  
  panelwave.visible := true;
  
  end;

procedure tsongplayerfo.ShowSpectrum(const Sender: TObject);
var
  i, x: integer;
begin
  if tag = 0 then
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

      if drumsfo.songtimer.Value then
        if tickcount = 0 then
          if (arl[1] + arr[1]) / 2 > (1 - (drumsfo.sensib.Value / 100)) then
            drumsfo.ontimertick(Sender);

      Inc(tickcount);
      if tickcount > drumsfo.tickcount.Value then
        tickcount := 0;

    end;

  if tag = 1 then
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

      if drumsfo.songtimer.Value then
        if tickcount = 0 then
          if (arl2[1] + arr2[1]) / 2 > (1 - (drumsfo.sensib.Value / 100)) then
            drumsfo.ontimertick(Sender);

      Inc(tickcount);
      if tickcount > drumsfo.tickcount.Value then
        tickcount := 0;

    end;

end;

procedure tsongplayerfo.showlevel(const Sender: TObject; const l1, r1, l2, r2: double);
begin

  if tag = 0 then
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

  if tag = 1 then
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
    if (tag = 0) and (not wavefo.TrackBar1.clicked) then

      if uos_InputPosition(theplayer, Inputindex1) > 0 then
      begin
        if Inputlength1 <> 0 then
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
        end;

        temptime        := uos_InputPositionTime(theplayer, Inputindex1);
        // Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
        mixtime         := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;
        if Inputlength1 <> 0 then
          if Inputlength1 < mixtime + 50000 then
            mixtime := Inputlength1 - 50000;
        if Inputlength1 <> 0 then
          if (commanderfo.automix.Value = True) and (hasmixed1 = False) and (uos_InputPosition(theplayer, Inputindex1) > Inputlength1 - mixtime) then
          begin
            hasmixed1   := True;
            commanderfo.onstartstop(nil);
            hasfocused1 := True;
            filelistfo.onsent(nil);
            hasfocused1 := False;
          end;
      end;

    if (tag = 1) and (not wavefo2.TrackBar1.clicked) then
      if uos_InputPosition(theplayer2, Inputindex2) > 0 then
      begin
        if Inputlength2 <> 0 then
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
        end;

        temptime        := uos_InputPositionTime(theplayer2, Inputindex2);
        // Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
        mixtime         := trunc(commanderfo.timemix.Value * 1000) + 100000;
        if mixtime < 150000 then
          mixtime := 150000;

        if Inputlength2 <> 0 then
          if Inputlength2 < mixtime + 50000 then
            mixtime := Inputlength2 - 50000;

        if Inputlength2 <> 0 then
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

procedure tsongplayerfo.InitDrawLive();
var
  transpcolor: integer;
begin

  if mainfo.typecolor.Value = 2 then
    transpcolor := $444444;

  if mainfo.typecolor.Value = 0 then
    transpcolor := $C9CF9E;

  if mainfo.typecolor.Value = 1 then
    transpcolor := $BABABA;

  if mainfo.typecolor.Value = 3 then
    transpcolor := $FF87E3;

  //  transpcolor := $d6d6d6;

  rectrecform.pos  := nullpoint;
  rectrecform.size := panelwave.size;

  if tag = 0 then
    xreclive1 := 1
  else
    xreclive2 := 1;

  with sliderimage.bitmap do
  begin
    size   := rectrecform.size;
    init(transpcolor);
    masked := True;
    transparentcolor := transpcolor;
  end;

  panelwave.invalidate();

end;

procedure tsongplayerfo.InitDrawLivewav();
var
  transpcolor: integer;
begin

  if mainfo.typecolor.Value = 2 then
    transpcolor := $444444;

  if mainfo.typecolor.Value = 0 then
    transpcolor := $C9CF9E;

  if mainfo.typecolor.Value = 1 then
    transpcolor := $BABABA;

  if mainfo.typecolor.Value = 3 then
    transpcolor := $FF87E3;

  if tag = 0 then
  begin
    xreclivewav1     := 1;
    rectrecform.pos  := nullpoint;
    rectrecform.size := wavefo.panelwave.size;

    with wavefo.sliderimage.bitmap do
    begin
      size   := rectrecform.size;
      init(transpcolor);
      masked := True;
      transparentcolor := transpcolor;
    end;

    wavefo.panelwave.invalidate();

  end;

  if tag = 1 then
  begin
    xreclivewav2     := 1;
    rectrecform.pos  := nullpoint;
    rectrecform.size := wavefo2.panelwave.size;

    with wavefo2.sliderimage.bitmap do
    begin
      size   := rectrecform.size;
      init(transpcolor);
      masked := True;
      transparentcolor := transpcolor;
    end;

    wavefo2.panelwave.invalidate();

  end;

end;

procedure tsongplayerfo.DrawLive(lv, rv: double);
var
  poswavrec, poswavrec2: pointty;
begin
  if tag = 0 then
  begin
    if (waveformcheck.Value = true) then
    begin
    rectrecform.pos  := nullpoint;
    rectrecform.size := panelwave.size;
    sliderimage.bitmap.masked := False;
    poswavrec.x  := xreclive1;
    poswavrec2.x := poswavrec.x;
    poswavrec.y  := (panelwave.Height div 2) - 2;
    poswavrec2.y := ((panelwave.Height div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));
    sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);
    poswavrec.y  := (panelwave.Height div 2);
    poswavrec2.y := poswavrec.y + (round((rv) * ((panelwave.Height div 2) - 3)));
    sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);
    panelwave.invalidate();
    xreclive1    := xreclive1 + 1;
    end;
    
    if (as_checked in wavefo.tmainmenu1.menu[0].state) then
    begin
    rectrecform.pos  := nullpoint;
    rectrecform.size := wavefo.panelwave.size;

    wavefo.sliderimage.bitmap.masked := False;
    poswavrec.x  := xreclivewav1;
    poswavrec2.x := poswavrec.x;
    poswavrec.y  := (wavefo.panelwave.Height div 2) - 2;
    poswavrec2.y := ((wavefo.panelwave.Height div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));
    wavefo.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);
    poswavrec.y  := (wavefo.panelwave.Height div 2);
    poswavrec2.y := poswavrec.y + (round((rv) * ((wavefo.panelwave.Height div 2) - 3)));
    wavefo.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);
    wavefo.panelwave.invalidate();
    xreclivewav1 := xreclivewav1 + 1;
    end;
  end;

  if tag = 1 then
  begin
  if (waveformcheck.Value = true) then
    begin
    rectrecform.pos := nullpoint;
    rectrecform.size := panelwave.size;
    sliderimage.bitmap.masked := False;
    poswavrec.x  := xreclive2;
    poswavrec2.x := poswavrec.x;
    poswavrec.y  := (panelwave.Height div 2) - 2;
    poswavrec2.y := ((panelwave.Height div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));
    sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);
    poswavrec.y  := (panelwave.Height div 2);
    poswavrec2.y := poswavrec.y + (round((rv) * ((panelwave.Height div 2) - 3)));
    sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);
    panelwave.invalidate();
    xreclive2    := xreclive2 + 1;
    end;
    
    if (as_checked in wavefo2.tmainmenu1.menu[0].state) then
    begin
    rectrecform.pos  := nullpoint;
    rectrecform.size := wavefo2.panelwave.size;

    wavefo2.sliderimage.bitmap.masked := False;
    poswavrec.x  := xreclivewav2;
    poswavrec2.x := poswavrec.x;
    poswavrec.y  := (wavefo2.panelwave.Height div 2) - 2;
    poswavrec2.y := ((wavefo2.panelwave.Height div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));
    wavefo2.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);
    poswavrec.y  := (wavefo2.panelwave.Height div 2);
    poswavrec2.y := poswavrec.y + (round((rv) * ((wavefo2.panelwave.Height div 2) - 3)));
    wavefo2.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);
    wavefo2.panelwave.invalidate();
    xreclivewav2 := xreclivewav2 + 1;
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

      // if (tag = 0) and (Inputlength1 > 0) and (Visible = True) then
    ShowPosition(nil);
      // if (tag = 1) and (Inputlength2 > 0) and (Visible = True) then
      //   ShowPosition(nil);

    if (Visible = True)
      //  {$if not defined(darwin)}
      or
      ((imagedancerfo.Visible = True))
      //     {$endif}
    then
    begin
      ll1 := uos_InputGetLevelLeft(theplayer, Inputindex1);
      lr1 := uos_InputGetLevelright(theplayer, Inputindex1);
      ll2 := uos_InputGetLevelLeft(theplayer2, Inputindex2);
      lr2 := uos_InputGetLevelright(theplayer2, Inputindex2);

      if (tag = 0) and (wavefo.panelwave.Visible = True) then
        if (xreclivewav1) > (wavefo.panelwave.Width) then
          InitDrawLivewav();

      if (tag = 1) and (wavefo2.panelwave.Visible = True) then
        if (xreclivewav2) > (wavefo2.panelwave.Width) then
          InitDrawLivewav();

      if (tag = 0) and (panelwave.Visible = True) then
      begin
        if (xreclive1) > (panelwave.Width) then InitDrawLive();
        DrawLive(ll1, lr1);
      end;

      if (tag = 1) and (panelwave.Visible = True) then
      begin
        if (xreclive2) > (panelwave.Width) then  InitDrawLive();
        DrawLive(ll2, lr2);
      end;

      //    {$if not defined(darwin)}
      multiplier := ((ll1 + lr1) / 2) + ((ll2 + lr2) / 2);

      if multiplier > 1 then
        multiplier := 1;
      if multiplier < 0 then
        multiplier := 0;
      //     {$endif} 

      if (vuinvar = True) and (Visible = True) then
        ShowLevel(nil, ll1, lr1, ll2, lr2);

      //   {$if not defined(darwin)}
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
      //  {$endif} 
    end;

    if tag = 0 then
      if (spectrum1fo.spect1.Value = True) and (spectrum1fo.Visible = True) and
        (commanderfo.speccalc.Value = True) then
        ShowSpectrum(nil);

    if tag = 1 then
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
  temphistory: msestringarty;
begin
  if filelistfo.list_files.rowcount > 0 then
  begin
    if tag = 0 then
    begin
      fileex := fileext(PChar(ansistring(historyfn.Value)));

      if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
        (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') or
        (lowercase(fileex) = 'mod') or (lowercase(fileex) = 'it') or
        (lowercase(fileex) = 's3m') or (lowercase(fileex) = 'xm') then
      begin

        if fileexists(historyfn.Value) then
        begin

          samformat := 0;

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

            Inputlength1 := uos_Inputlength(theplayer, Inputindex1);

            uos_InputSetLevelEnable(theplayer, Inputindex1, 2);
            // set calculation of level/volume (usefull for showvolume procedure)
            // set level calculation (default is 0)
            // 0 => no calcul
            // 1 => calcul before all DSP procedures.
            // 2 => calcul after all DSP procedures.
            // 3 => calcul before and after all DSP procedures.

            //  if Inputlength1 > 0 then
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


            /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
            /// SoundTouch plugin should be the last added.
            if plugsoundtouch = True then
            begin
              PluginIndex2 := uos_AddPlugin(theplayer, 'soundtouch', uos_InputGetSampleRate(theplayer, Inputindex1), -1);
              ChangePlugSetSoundTouch(self); // custom procedure to Change plugin settings
            end;

            if uos_InputGetLibUsed(theplayer, Inputindex1) = 5 then
            begin
              panelwave.Visible        := True;
              wavefo.panelwave.Visible := True;
              InitDrawLive();
              InitDrawLivewav();
            end
            else
            begin
              panelwave.Visible        := False;
              wavefo.panelwave.Visible := False;
            end;
            
            // Length of Input in samples
            if Inputlength1 > 0 then
            begin
              tottime1 := uos_InputlengthTime(theplayer, Inputindex1);
              // Length of input in time

              DecodeTime(tottime1, ho, mi, se, ms);

              totsec1 := (ho * 3600) + (mi * 60) + se;

              llength.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
            end
            else
              llength.Value := '??:??:??.???';

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

            if Inputlength1 > 0 then
            begin
              trackbar1.Value   := 0;
              trackbar1.Enabled := True;

              wavefo.trackbar1.Value   := 0;
              wavefo.container.frame.scrollpos_x := 0;
              wavefo.trackbar1.Enabled := True;
            end;

            wavefo.Caption := 'Wave1 of ' + historyfn.Value;

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

                temphistory := historyfn.dropdown.history;
                setlength(temphistory, length(temphistory) + 1);
                temphistory[length(temphistory) - 1] := historyfn.Value;
                historyfn.dropdown.history := temphistory;

                btnpause.Enabled := True;
                btnpause.Visible := True;
              end;
              tstringdisp1.face.template := mainfo.tfacegreen;
              tstringdisp1.Value := msestring('Playing ' + theplaying1);

              if configlayoutfo.focusplay.Value then

                if ((parentwidget = dockpanel1fo.basedock) and (dockpanel1fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel2fo.basedock) and (dockpanel2fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel3fo.basedock) and (dockpanel3fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel4fo.basedock) and (dockpanel4fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = nil) and (Visible = True)) then
                  btnpause.SetFocus;

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
              tstringdisp1.face.template := mainfo.tfaceorange;
              tstringdisp1.Value         := msestring('Loaded ' + theplaying1);
            end;

            cbloop.Visible := False;
            cbloop.Enabled := False;
            historyfn.hint := historyfn.Value;

            if timerwait.Enabled then
              timerwait.restart // to reset
            else
              timerwait.Enabled := True;

            //  lposition.face.template := mainfo.tfaceplayerlight;

            hascue := True;

            oninfowav(Sender);

            infosdfo.infolength.Caption := copy(llength.Value, 1, 8);


            if uos_InputGetLibUsed(theplayer, Inputindex1) <> 5 then
            begin           
            if as_checked in wavefo.tmainmenu1.menu[0].state then
              if ttimer1.Enabled then
                ttimer1.restart // to reset
              else
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

    if tag = 1 then
    begin
      fileex := fileext(PChar(ansistring(historyfn.Value)));

      if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
        (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') or
        (lowercase(fileex) = 'mod') or (lowercase(fileex) = 'it') or
        (lowercase(fileex) = 's3m') or (lowercase(fileex) = 'xm') then
      begin

        if fileexists(historyfn.Value) then
        begin
          samformat := 0;

          // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
          // If PlayerIndex exists already, it will be overwritten...
          uos_Stop(theplayer2); // done by  uos_CreatePlayer() but faster if already done before (no check)

          if uos_CreatePlayer(theplayer2) then
            // Create the player.
            // PlayerIndex : from 0 to what your computer can do !
            // If PlayerIndex exists already, it will be overwriten...

            Inputindex2 := uos_AddFromFile(theplayer2, PChar(ansistring(historyfn.Value)), -1,
              samformat, 1024 * 8);

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

            Inputlength2 := uos_Inputlength(theplayer2, Inputindex2);
            // Length of Input in samples

            uos_InputSetLevelEnable(theplayer2, Inputindex2, 2);
            // set calculation of level/volume (usefull for showvolume procedure)
            // set level calculation (default is 0)
            // 0 => no calcul
            // 1 => calcul before all DSP procedures.
            // 2 => calcul after all DSP procedures.
            // 3 => calcul before and after all DSP procedures.

            //if Inputlength2 > 0 then
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

            /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
            /// SoundTouch plugin should be the last added.
            if plugsoundtouch = True then
            begin
              PluginIndex3 := uos_AddPlugin(theplayer2, 'soundtouch',
                uos_InputGetSampleRate(theplayer2, Inputindex2), -1);
              ChangePlugSetSoundTouch(self); // custom procedure to Change plugin settings
            end;

           if uos_InputGetLibUsed(theplayer2, Inputindex2) = 5 then
            begin
              panelwave.Visible         := True;
              wavefo2.panelwave.Visible := True;
              InitDrawLive();
              InitDrawLivewav();
            end
            else
            begin
              panelwave.Visible         := False;
              wavefo2.panelwave.Visible := False;
            end;

            if Inputlength2 > 0 then
            begin
              tottime2 := uos_InputlengthTime(theplayer2, Inputindex2);
              // Length of input in time

              DecodeTime(tottime2, ho, mi, se, ms);

              totsec2 := (ho * 3600) + (mi * 60) + se;

              llength.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
            end
            else
              llength.Value := '??:??:??.???';

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

            if Inputlength2 > 0 then
            begin
              trackbar1.Value   := 0;
              trackbar1.Enabled := True;

              wavefo2.trackbar1.Value   := 0;
              wavefo2.container.frame.scrollpos_x := 0;
              wavefo2.trackbar1.Enabled := True;
            end;

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

                temphistory := historyfn.dropdown.history;
                setlength(temphistory, length(temphistory) + 1);
                temphistory[length(temphistory) - 1] := historyfn.Value;
                historyfn.dropdown.history := temphistory;

              end;
              tstringdisp1.face.template := mainfo.tfacegreen;
              tstringdisp1.Value         := msestring('Playing ' + theplaying2);

              if configlayoutfo.focusplay.Value then

                if ((parentwidget = dockpanel1fo.basedock) and (dockpanel1fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel2fo.basedock) and (dockpanel2fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel3fo.basedock) and (dockpanel3fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = dockpanel4fo.basedock) and (dockpanel4fo.Visible = True) and (Visible = True)) or
                  ((parentwidget = nil) and (Visible = True)) then
                  btnpause.SetFocus;

            end;

            if hassent = 1 then  /// cue
            begin
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
              tstringdisp1.face.template := mainfo.tfaceorange;
              tstringdisp1.Value         := msestring('Loaded ' + theplaying2);
            end;

            cbloop.Enabled  := False;
            cbloopb.Enabled := False;
            cbloop.Visible  := False;
            historyfn.hint  := historyfn.Value;
        
            if timerwait.Enabled then
              timerwait.restart // to reset
            else
              timerwait.Enabled := True;

            //  lposition.face.template := mainfo.tfaceplayerlight;

            hascue2 := True;
            oninfowav(Sender);

            infosdfo2.infolength.Caption := copy(llength.Value, 1, 8);

            if uos_InputGetLibUsed(theplayer2, Inputindex2) <> 5 then
            begin
            if as_checked in wavefo2.tmainmenu1.menu[0].state then
              if ttimer1.Enabled then
                ttimer1.restart // to reset
              else
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
  end
  else
    ShowMessage('There is no audio file in the list...');
end;

procedure tsongplayerfo.doplayeresume(const Sender: TObject);
begin
  btnStop.Enabled   := True;
  btnPause.Enabled  := True;
  btnresume.Enabled := False;
  btnPause.Visible  := True;
  btnresume.Visible := False;

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template    := mainfo.tfaceplayerlight;

  if tag = 0 then
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

    if configlayoutfo.focusplay.Value then

      if ((parentwidget = dockpanel1fo.basedock) and (dockpanel1fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel2fo.basedock) and (dockpanel2fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel3fo.basedock) and (dockpanel3fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel4fo.basedock) and (dockpanel4fo.Visible = True) and (Visible = True)) or
        ((parentwidget = nil) and (Visible = True)) then
        btnpause.SetFocus;

  end;

  if tag = 1 then
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

    if configlayoutfo.focusplay.Value then

      if ((parentwidget = dockpanel1fo.basedock) and (dockpanel1fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel2fo.basedock) and (dockpanel2fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel3fo.basedock) and (dockpanel3fo.Visible = True) and (Visible = True)) or
        ((parentwidget = dockpanel4fo.basedock) and (dockpanel4fo.Visible = True) and (Visible = True)) or
        ((parentwidget = nil) and (Visible = True)) then
        btnpause.SetFocus;

  end;

end;

procedure tsongplayerfo.doplayerpause(const Sender: TObject);
begin
  vuLeft.Visible  := False;
  vuRight.Visible := False;

  btnStop.Enabled   := True;
  btnPause.Enabled  := False;
  btnresume.Enabled := True;

  btnPause.Visible  := False;
  btnresume.Visible := True;

  tstringdisp1.face.template := mainfo.tfacered;
  lposition.face.template    := mainfo.tfaceplayerlight;

  if tag = 0 then
  begin
    with commanderfo do
    begin
      vuLeft.Visible    := False;
      vuRight.Visible   := False;
      btnStop.Enabled   := True;
      btnPause.Enabled  := False;
      btnresume.Enabled := True;
      btnPause.Visible  := False;
      btnresume.Visible := True;
    end;

    uos_Pause(theplayer);


    tstringdisp1.Value := msestring('Paused ' + theplaying1);

  end;

  if tag = 1 then
  begin
    with commanderfo do
    begin
      vuLeft2.Visible    := False;
      vuRight2.Visible   := False;
      btnStop2.Enabled   := True;
      btnPause2.Enabled  := False;
      btnresume2.Enabled := True;
      btnPause2.Visible  := False;
      btnresume2.Visible := True;
    end;

    uos_Pause(theplayer2);
    tstringdisp1.Value := msestring('Paused ' + theplaying2);

  end;
  //  {$if not defined(darwin)} 
  multiplier := 0;
  //  {$endif}
  resetspectrum();

  if configlayoutfo.focusplay.Value then

    if ((parentwidget = dockpanel1fo.basedock) and (dockpanel1fo.Visible = True) and (Visible = True)) or
      ((parentwidget = dockpanel2fo.basedock) and (dockpanel2fo.Visible = True) and (Visible = True)) or
      ((parentwidget = dockpanel3fo.basedock) and (dockpanel3fo.Visible = True) and (Visible = True)) or
      ((parentwidget = dockpanel4fo.basedock) and (dockpanel4fo.Visible = True) and (Visible = True)) or
      ((parentwidget = nil) and (Visible = True)) then
      btnresume.SetFocus;
end;

procedure tsongplayerfo.doplayerstop(const Sender: TObject);
begin
  if tag = 0 then
  begin
    hasmixed1 := True;
    uos_Stop(theplayer);
    infosdfo.ttimer1.Enabled := False;
    infosdfo.tbutton1.Caption := '>';
  end;

  if tag = 1 then
  begin
    hasmixed2 := True;
    uos_Stop(theplayer2);
    infosdfo2.ttimer1.Enabled := False;
    infosdfo2.tbutton1.Caption := '>';
  end;
  //  {$if not defined(darwin)} 
  multiplier := 0;
  //  {$endif}
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

  if asender = 1 then
    aplayer := theplayer
  else if asender = 2 then
    aplayer := theplayer2;
  begin

    //  if (btnStart.Enabled = true) then
    uos_InputSetFilter(aplayer, Inputindex1, Equalizer_Bands[aindex].theindex, -1, -1, -1, Gainl, -1, -1, -1, Gainr,
      True, nil, isenable);
  end;

end;

procedure tsongplayerfo.changevolume(const Sender: TObject);
begin

  if hasinit = 1 then
  begin
    if (trealspinedit(Sender).tag = 0) then
    begin
      edvolleft.face.template := mainfo.tfaceorange;
      edvolleft.font.color    := cl_black;
    end
    else
    begin
      edvolright.face.template := mainfo.tfaceorange;
      edvolright.font.color    := cl_black;
    end;

    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;

    if tag = 0 then
      uos_InputSetDSPVolume(theplayer, Inputindex1,
        (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

    if tag = 1 then
      uos_InputSetDSPVolume(theplayer2, Inputindex2,
        (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

  end;
end;

procedure tsongplayerfo.onreset(const Sender: TObject);
begin
  edtempo.Value         := 1;
  edpitch.Value         := 1;
  // edtempo.face.template := mainfo.tfaceorange;
  button1.face.template := mainfo.tfaceorange;
  button1.font.color    := cl_black;
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

    if tag = 0 then
      if (iswav = True) and (waveformcheck.Value = True) then
      begin

        poswav.x := 6;
        poswav.y := (trackbar1.Height div 2) - 2;

        poswav2.x := 6;

        while poswav.x < (length(waveformdata1) div chan1) - 1 do
        begin
          if chan1 = 2 then
          begin
            poswav.y  := (trackbar1.Height div 2) - 2;
            poswav2.x := poswav.x;
            poswavx   := poswav.x - 6;
            poswav2.y := ((arect.cy div 2) - 1) - roundmath((waveformdata1[poswavx * 2]) * ((arect.cy div 2) - 3));

            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;

            Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit1.Value);

            Canvas.drawline(poswav2, poswav3, $F0F0F0); // frame of wave

            poswav.y := (trackbar1.Height div 2);

            poswav2.y := poswav.y + (roundmath((waveformdata1[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit2.Value);
            Canvas.drawline(poswav2, poswav3, $F0F0F0);

          end;
          if chan1 = 1 then
            // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
            // - roundmath((waveformdata[poswav]) * (Custom1.Height) - 1));
          ;
          Inc(poswav.x, 1);
        end;
      end;

    if tag = 1 then
      if (iswav2 = True) and (waveformcheck.Value = True) then
      begin

        poswav.x := 6;
        poswav.y := (trackbar1.Height div 2) - 2;

        poswav2.x := 6;

        while poswav.x < length(waveformdata2) div chan2 do
        begin
          if chan2 = 2 then
          begin
            poswav.y  := (trackbar1.Height div 2) - 2;
            poswav2.x := poswav.x;
            poswavx   := poswav.x - 6;
            poswav2.y := ((arect.cy div 2) - 1) - roundmath((waveformdata2[poswavx * 2]) * ((arect.cy div 2) - 3));
            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit12.Value);
            Canvas.drawline(poswav2, poswav3, $F0F0F0);

            poswav.y := (trackbar1.Height div 2);

            poswav2.y := poswav.y + (roundmath((waveformdata2[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

            poswav2.y := poswav2.y - 1;
            poswav3.x := poswav2.x;
            poswav3.y := poswav2.y + 1;
            Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit22.Value);
            Canvas.drawline(poswav2, poswav3, $F0F0F0);

          end;
          if chan2 = 1 then
            // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
            // - roundmath((waveformdata[poswav]) * (Custom1.Height) - 1));
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

  if tag = 0 then
    if (iswav = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo.trackbar1.Height div 2) - 2;

      poswav2.x := 6;

      while (poswav.x < (length(waveformdataform1) div chan1) - 1) and (poswav.x < wavefo.trackbar1.Width) do
      begin
        if chan1 = 2 then
        begin
          poswav.y  := (wavefo.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx   := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - roundmath((waveformdataform1[poswavx * 2]) * ((arect.cy div 2) - 3));
          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit1.Value);

          Canvas.drawline(poswav2, poswav3, $F0F0F0);

          poswav.y := (wavefo.trackbar1.Height div 2);

          poswav2.y := poswav.y + (roundmath((waveformdataform1[(poswavx * 2) + 1]) * ((wavefo.trackbar1.Height div 2) - 3)));

          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit2.Value);
          Canvas.drawline(poswav2, poswav3, $F0F0F0);
        end;
        if chan1 = 1 then
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - roundmath((waveformdata[poswav]) * (Custom1.Height) - 1));
        ;
        Inc(poswav.x, 1);
      end;
    end;

  if tag = 1 then
    if (iswav2 = True) and (waveformcheck.Value = True) then
    begin

      poswav.x := 6;
      poswav.y := (wavefo2.trackbar1.Height div 2) - 2;

      poswav2.x := 6;

      while (poswav.x < length(waveformdataform2) div chan2) and (poswav.x < wavefo2.trackbar1.Width) do
      begin
        if chan2 = 2 then
        begin
          poswav.y  := (wavefo2.trackbar1.Height div 2) - 2;
          poswav2.x := poswav.x;
          poswavx   := poswav.x - 6;
          poswav2.y := ((arect.cy div 2) - 1) - roundmath((waveformdataform2[poswavx * 2]) * ((arect.cy div 2) - 3));

          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit12.Value);
          Canvas.drawline(poswav2, poswav3, $F0F0F0);

          poswav.y := (wavefo2.trackbar1.Height div 2);

          poswav2.y := poswav.y + (roundmath((waveformdataform2[(poswavx * 2) + 1]) * ((wavefo2.trackbar1.Height div 2) - 3)));
          poswav2.y := poswav2.y - 1;
          poswav3.x := poswav2.x;
          poswav3.y := poswav2.y + 1;
          Canvas.drawline(poswav, poswav2, configlayoutfo.tcoloredit22.Value);
          Canvas.drawline(poswav2, poswav3, $F0F0F0);

        end;
        if chan2 = 1 then
          // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1)
          // - roundmath((waveformdata[poswav]) * (Custom1.Height) - 1));
        ;
        Inc(poswav.x, 1);
      end;
    end;

end;

procedure tsongplayerfo.GetWaveData();
begin

  if tag = 0 then
    if (waveformcheck.Value = True) then
    begin
      waveformdata1 := uos_InputGetLevelArray(theplayerinfo, 0);
      iswav         := True;
      application.ProcessMessages;
      DrawWaveForm();
    end;

  if tag = 1 then
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
  if tag = 0 then

    if as_checked in wavefo.tmainmenu1.menu[0].state then
    begin
      waveformdataform1 := uos_InputGetLevelArray(theplayerinfoform, 0);
      application.ProcessMessages;
      formDrawWaveForm();
    end;

  if tag = 1 then

    if as_checked in wavefo2.tmainmenu1.menu[0].state then
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

  if ((tag = 0) and (DrawWaveFormbusy1 = False)) or
    ((tag = 1) and (DrawWaveFormbusy2 = False)) then
  begin

    if tag = 0 then
      DrawWaveFormbusy1 := True;
    if tag = 1 then
      DrawWaveFormbusy2 := True;

    trackbar1.invalidate();
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
    if tag = 0 then
      DrawWaveFormbusy1 := False;
    if tag = 1 then
      DrawWaveFormbusy2 := False;
  end;
  trackbar1.invalidatewidget;
  application.processmessages;
end;

procedure tsongplayerfo.FormDrawWaveForm();
const
  transpcolor = cl_gray;
var
  rect1form: rectty;
begin

  if (tag = 0) and
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
    wavefo.trackbar1.invalidate();
  end;

  if (tag = 1) and (FormDrawWaveFormbusy2 = False) and (as_checked in wavefo2.tmainmenu1.menu[0].state) then
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
    wavefo2.trackbar1.invalidate();
  end;
 application.processmessages;
end;

procedure tsongplayerfo.onwavform(const Sender: TObject);
var
  framewanted: integer;
begin

  if (tag = 0) and (as_checked in wavefo.tmainmenu1.menu[0].state) and (buzywaveform1 = False) then
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      uos_Stop(theplayerinfoform);
      uos_CreatePlayer(theplayerinfoform);

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
        if Inputlength1 <> 0 then
        begin
          if (wavefo.trackbar1.Width < Inputlength1 div 64) then
          else
          begin
            wavefo.trackbar1.Width := wavefo.Width - 10;
            wavefo.tmainmenu1.menu[2].Caption := ' Now=X1 ';
          end;
          wavefo.doechelle(fontheightused);

          framewanted := Inputlength1 div (wavefo.trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfoform, 0, framewanted);

          // Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfoform, @GetWaveDataform);
        end;

        uos_Play(theplayerinfoform);  /// everything is ready, here we are, lets do it...

      end;
    end;

  if (tag = 1) and (as_checked in wavefo2.tmainmenu1.menu[0].state) and (buzywaveform2 = False) then
    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      uos_Stop(theplayerinfoform2);

      initwaveform2 := True;

      uos_CreatePlayer(theplayerinfoform2);
      // Create the player.
      // PlayerIndex : from 0 to what your computer can do !
      // If PlayerIndex exists already, it will be overwriten...

      if uos_AddFromFile(theplayerinfoform2, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
      begin
        buzywaveform2 := True;

        uos_InputSetLevelArrayEnable(theplayerinfoform2, 0, 2);
        // set level calculation (default is 0)
        // 0 => no calcul
        // 1 => calcul before all DSP procedures.
        // 2 => calcul after all DSP procedures.

        // determine how much frame will be designed
        if Inputlength2 <> 0 then
        begin
          if (wavefo2.trackbar1.Width < Inputlength2 div 64) then
          else
          begin
            wavefo2.trackbar1.Width := wavefo.Width - 10;
            wavefo2.tmainmenu1.menu[2].Caption := ' Now=X1 ';
          end;
          wavefo2.doechelle(fontheightused);
          framewanted := Inputlength2 div (wavefo2.trackbar1.Width - 7);

          uos_InputSetFrameCount(theplayerinfoform2, 0, framewanted);

          // Assign the procedure of object to execute at end of stream
          uos_EndProc(theplayerinfoform2, @GetWaveDataform);
        end;

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
  TagReader: TTagReader;
  CommonTags: TCommonTags;
  tagClass: TTagReaderClass;

  function ReadTag(filename: string): integer;
  begin
    Result := -1;

    tagClass  := IdentifyKind(FileName);
    TagReader := tagClass.Create;

    TagReader.LoadFromFile(FileName);

    if TagReader.Tags.ImageCount > 0 then
    begin
      Result := 0;
      TagReader.Tags.Images[0].Image.Position := 0;
    end;

  end;

begin
  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
    (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') or
    (lowercase(fileex) = 'mod') or (lowercase(fileex) = 'it') or
    (lowercase(fileex) = 's3m') or (lowercase(fileex) = 'xm') then
  begin

    if fileexists(PChar(ansistring(historyfn.Value))) then
    begin

      if Sender <> nil then
      begin
        if TButton(Sender).tag = 15 then
          hassent := 1
        else
          hassent := 0;
      end
      else
        hassent := 0;

      if tag = 0 then
      begin
        if (hassent = 1) or (hassent = 0) then
        begin
          infosdfo.infofile.Caption := copy(trim(extractfilename(historyfn.Value)), 1, 60);
          infosdfo.infofile.hint    := ' ' + trim(extractfilename(historyfn.Value)) + ' ';

          if (lowercase(fileex) <> 'mp3') then
          begin
            infosdfo.loadimagetag(nil);

            infosdfo.infoname.Caption   :=
              uos_InputGetTagTitle(theplayer, Inputindex1);
            infosdfo.infoartist.Caption :=
              uos_InputGetTagArtist(theplayer, Inputindex1);
            infosdfo.infoalbum.Caption  :=
              uos_InputGetTagAlbum(theplayer, Inputindex1);
            infosdfo.infoyear.Caption   :=
              uos_InputGetTagDate(theplayer, Inputindex1);
            infosdfo.infocom.Caption    :=
              uos_InputGetTagComment(theplayer, Inputindex1);
            infosdfo.infotag.Caption    :=
              uos_InputGetTagTag(theplayer, Inputindex1);
            infosdfo.tracktag.Caption   :=
              uos_InputGetTagTrack(theplayer, Inputindex1);
            infosdfo.infochan.Caption   :=
              uos_InputGetTagGenre(theplayer, Inputindex1);

          end
          else
          begin
            if readtag(ansistring(historyfn.Value)) = 0 then
              infosdfo.loadimagetag(TagReader.Tags.Images[0].Image)
            else
              infosdfo.loadimagetag(nil);

            CommonTags := TagReader.GetCommonTags;

            infosdfo.infoname.Caption := copy(trim(CommonTags.Title), 1, 60) + ' ';

            infosdfo.infoartist.Caption := copy(trim(CommonTags.Artist), 1, 60) + ' ';
            infosdfo.infoalbum.Caption  := copy(trim(CommonTags.Album), 1, 60) + ' ';

            infosdfo.infoname.hint   := ' ' + trim(CommonTags.Title) + ' ';
            infosdfo.infoartist.hint := ' ' + trim(CommonTags.Artist) + ' ';
            infosdfo.infoalbum.hint  := ' ' + trim(CommonTags.Album) + ' ';
            infosdfo.infocom.hint    := ' ' + trim(CommonTags.Comment) + ' ';

            infosdfo.infoyear.Caption   := trim(CommonTags.Year) + ' ';
            infosdfo.infocom.Caption    := copy(trim(CommonTags.Comment), 1, 60) + ' ';
            infosdfo.infotag.Caption    := trim(CommonTags.Genre) + ' ';
            infosdfo.tracktag.Caption   := IntToStr(CommonTags.track) + '  ';
            infosdfo.infolength.Caption := trim(utf8decode(FormatDateTime('hh:nn:ss',
              (CommonTags.Duration / MSecsPerDay)))) + ' ';
            infosdfo.inforate.Caption   := trim(IntToStr(TagReader.MediaProperty.Sampling)) + ' ';
            // format('%d Hz', [TagReader.MediaProperty.Sampling]);

            if (trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'joint stereo') or
              (trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'dual channel') then
              infosdfo.infochan.Caption := 'Stereo '
            else
              infosdfo.infochan.Caption := trim(TagReader.MediaProperty.ChannelMode) + ' ';

          end;
          // BPM

          infosdfo.infobpm.Caption := '';

          if plugsoundtouch = True then
          begin
            thebuffer := uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024 * 2);
            infosdfo.infobpm.Caption := trim(utf8decode(
              IntToStr(roundmath(uos_GetBPM(thebuffer, thebufferinfos.channels,
              thebufferinfos.samplerate))))) + ' ';
          end;

          if (hassent = 1) then
          begin
            infosdfo.Visible := True;
            infosdfo.bringtofront;
          end;
        end;
        
        if uos_InputGetLibUsed(theplayer, Inputindex1) <> 5 then
        begin
        if (hassent = 0) and (waveformcheck.Value = True) and (iswav = False) then
          if ttimerwavdata.Enabled then
            ttimerwavdata.restart // to reset
          else
            ttimerwavdata.Enabled := True;
        end;
      end;

      if tag = 1 then
      begin
        if (hassent = 1) or (hassent = 0) then
        begin

          infosdfo2.infofile.Caption := copy(trim(extractfilename(historyfn.Value)), 1, 60);

          if (lowercase(fileex) <> 'mp3') then
          begin
            infosdfo2.loadimagetag(nil);
            infosdfo2.infoname.Caption   :=
              uos_InputGetTagTitle(theplayer2, Inputindex1);
            infosdfo2.infoartist.Caption :=
              uos_InputGetTagArtist(theplayer2, Inputindex1);
            infosdfo2.infoalbum.Caption  :=
              uos_InputGetTagAlbum(theplayer2, Inputindex1);
            infosdfo2.infoyear.Caption   :=
              uos_InputGetTagDate(theplayer2, Inputindex1);
            infosdfo2.infocom.Caption    :=
              uos_InputGetTagComment(theplayer2, Inputindex1);
            infosdfo2.infotag.Caption    :=
              uos_InputGetTagTag(theplayer2, Inputindex1);
            infosdfo2.tracktag.Caption   :=
              uos_InputGetTagTrack(theplayer2, Inputindex1);
            infosdfo2.infochan.Caption   :=
              uos_InputGetTagGenre(theplayer2, Inputindex1);

          end
          else
          begin

            if readtag(ansistring(historyfn.Value)) = 0 then
              infosdfo2.loadimagetag(TagReader.Tags.Images[0].Image)
            else
              infosdfo2.loadimagetag(nil);

            CommonTags := TagReader.GetCommonTags;

            infosdfo2.infoname.Caption   := copy(trim(CommonTags.Title), 1, 60) + ' ';
            infosdfo2.infoartist.Caption := copy(trim(CommonTags.Artist), 1, 60) + ' ';
            infosdfo2.infoalbum.Caption  := copy(trim(CommonTags.Album), 1, 60) + ' ';
            infosdfo2.infoyear.Caption   := trim(CommonTags.Year) + ' ';
            infosdfo2.infocom.Caption    := copy(trim(CommonTags.Comment), 1, 60) + ' ';

            infosdfo2.infofile.hint      := ' ' + trim(extractfilename(historyfn.Value)) + ' ';
            infosdfo2.infoname.hint      := ' ' + trim(CommonTags.Title) + ' ';
            infosdfo2.infoartist.hint    := ' ' + trim(CommonTags.Artist) + ' ';
            infosdfo2.infoalbum.hint     := ' ' + trim(CommonTags.Album) + ' ';
            infosdfo2.infocom.hint       := ' ' + trim(CommonTags.Comment) + ' ';
            infosdfo2.tracktag.Caption   := IntToStr(CommonTags.track) + '  ';
            infosdfo2.infotag.Caption    := trim(CommonTags.Genre) + ' ';
            infosdfo2.infolength.Caption := trim(utf8decode(FormatDateTime('hh:nn:ss',
              (CommonTags.Duration / MSecsPerDay)))) + ' ';
            infosdfo2.inforate.Caption   := trim(IntToStr(TagReader.MediaProperty.Sampling)) + ' ';
            // format('%d Hz', [TagReader.MediaProperty.Sampling]);
            if (trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'joint stereo') or
              (trim(lowercase(TagReader.MediaProperty.ChannelMode)) = 'dual channel') then

              infosdfo2.infochan.Caption := 'Stereo '
            else
              infosdfo2.infochan.Caption := trim(TagReader.MediaProperty.ChannelMode) + ' ';

          end;
          // BPM

          infosdfo2.infobpm.Caption := '';

          if plugsoundtouch = True then
          begin
            thebuffer := uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024 * 2);
            infosdfo2.infobpm.Caption :=
              trim(utf8decode(IntToStr(roundmath(uos_GetBPM(thebuffer, thebufferinfos.channels,
              thebufferinfos.samplerate))))) + ' ';
          end;

          if (hassent = 1) then
          begin
            infosdfo2.Visible := True;
            infosdfo2.bringtofront;
          end;
        end;
         if uos_InputGetLibUsed(theplayer2, Inputindex2) <> 5 then
        begin
       
        if (hassent = 0) and (waveformcheck.Value = True) and (iswav2 = False) then
          if ttimerwavdata.Enabled then
            ttimerwavdata.restart // to reset
          else
            ttimerwavdata.Enabled := True;
         end;   
      end;
      if (lowercase(fileex) = 'mp3') then
        TagReader.Free;
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
    if tag = 0 then
    begin
      temptime        := tottime1 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

    if tag = 1 then
    begin
      temptime        := tottime2 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

  end;

end;

procedure tsongplayerfo.visiblechangeev(const Sender: TObject);
begin
  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if tag = 0 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showplay1']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_commanderfo[Ord(co_nameplayers_hint)]
      else
      begin
        mainfo.tmainmenu1.menu.itembynames(['show', 'showplay1']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_commanderfo[Ord(co_nameplayers_hint)];
        uos_Stop(theplayer);
      end;

    if tag = 1 then
      if Visible then
        mainfo.tmainmenu1.menu.itembynames(['show', 'showplay2']).Caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_commanderfo[Ord(co_nameplayers2_hint)]
      else
      begin
        mainfo.tmainmenu1.menu.itembynames(['show', 'showplay2']).Caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
          lang_commanderfo[Ord(co_nameplayers2_hint)];
        uos_Stop(theplayer2);
      end;

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

procedure tsongplayerfo.onplayercreate(const Sender: TObject);
var
  ordir: msestring;
  i1: integer;
  {$if defined(darwin) and defined(macapp)}
  binPath: string;
  {$ENDIF}
begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;
 {$endif}

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

  {$if defined(darwin) and defined(macapp)}
  binPath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
  ordir := copy(binPath, 1, length(binPath) -6) + 'Resources/';
  {$else}
  ordir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));
  {$ENDIF}

  if historyfn.Value = '' then
    historyfn.Value := ordir + 'sound' + directoryseparator + 'song' + directoryseparator + 'test.mp3';

  with tgroupbox1 do
  begin
    setlength(boundchildsp, childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildsp[i1].left   := children[i1].left;
      boundchildsp[i1].top    := children[i1].top;
      boundchildsp[i1].Width  := children[i1].Width;
      boundchildsp[i1].Height := children[i1].Height;
      boundchildsp[i1].Name   := children[i1].Name;
    end;
  end;

end;

procedure tsongplayerfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if mainfo.ttimer2.Enabled then
    mainfo.ttimer2.restart // to reset
  else
    mainfo.ttimer2.Enabled := True;
end;

procedure tsongplayerfo.whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  if tag = 0 then
    thesender := 0;
  if tag = 1 then
    thesender := 1;
end;

procedure tsongplayerfo.ondestr(const Sender: TObject);
begin
  uos_Stop(theplayer);
  uos_Stop(theplayer2);
  //  {$if not defined(darwin)}  
  statusanim        := 0;
  //  {$endif}
  Timerwait.Enabled := False;
  Timersent.Enabled := False;
  Timerwait.Free;
  timersent.Free;
end;

procedure tsongplayerfo.changevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  changevolume(Sender);
end;

procedure tsongplayerfo.checksoundtouch(const Sender: TObject);
begin
  if plugsoundtouch = False then
  begin
    edtempo.Visible  := False;
    edpitch.Visible  := False;
    cbtempo.Visible  := False;
    Button1.Visible  := False;
    Button2.Visible  := False;
    cbtempob.Visible := False;
  end
  else
  begin
    edtempo.Visible  := True;
    edpitch.Visible  := True;
    cbtempo.Visible  := True;
    Button1.Visible  := True;
    Button2.Visible  := True;
    cbtempob.Visible := True;
  end;
end;

procedure tsongplayerfo.oncreated(const Sender: TObject);
begin

  checksoundtouch(Sender);

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

  if (tag = 0) and (Inputlength1 <> 0) then
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

  if (tag = 1) and (Inputlength2 <> 0) then
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
  if tag = 0 then
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

  if tag = 1 then
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

  if tag = 0 then
    if plugsoundtouch = True then
    begin

      if btncue.Enabled = True then
        btncue.onexecute(Sender);

      if fileexists(theplaying1) then
      begin
        thebuffer := uos_File2Buffer(PChar(ansistring(theplaying1)), 0, thebufferinfos, uos_InputPosition(theplayer, Inputindex1), 1024);
        thebpm    := uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate);
        if thebpm = 0 then
          button2.Caption := 'BPM'
        else
        begin

          button2.Caption          := utf8decode(IntToStr(roundmath(thebpm)));
          infosdfo.infobpm.Caption := button2.Caption;
          drumsfo.edittempo.Value  := roundmath(thebpm);
          button2.face.template    := mainfo.tfaceorange;
          button2.font.color       := cl_black;

          if timersent.Enabled then
            timersent.restart // to reset
          else
            timersent.Enabled := True;
        end;
      end;
    end;

  if tag = 1 then
    if plugsoundtouch = True then
    begin
      if btncue.Enabled = True then
        btncue.onexecute(Sender);

      if fileexists(theplaying2) then
      begin

        thebuffer := uos_File2Buffer(PChar(ansistring(theplaying2)), 0, thebufferinfos, uos_InputPosition(theplayer2, Inputindex2), 1024);
        thebpm    := uos_GetBPM(thebuffer, thebufferinfos.channels, thebufferinfos.samplerate);
        if thebpm = 0 then
          button2.Caption := 'BPM'
        else
        begin
          button2.Caption           := utf8decode(IntToStr(roundmath(thebpm)));
          drumsfo.edittempo.Value   := roundmath(thebpm);
          infosdfo2.infobpm.Caption := button2.Caption;

          button2.face.template := mainfo.tfaceorange;
          button2.font.color    := cl_black;

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
var
  ara, arb: msestringarty;
begin
  setlength(ara, 10);
  setlength(arb, 10);

  ara[0] := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showall)];  {'Show All'}
  ara[1] := 'Mp3"';
  ara[2] := 'Wav';
  ara[3] := 'Ogg';
  ara[4] := 'Flac';
  ara[5] := 'Mod"';
  ara[6] := 'It';
  ara[7] := 'Xm';
  ara[8] := 'S3m';
  ara[9] := 'All';

  arb[0] := '"*.mp3" "*.wav" "*.ogg" "*.flac" "*.mod" "*.it" "*.xm" "*.s3m"';
  arb[1] := '"*.mp3"';
  arb[2] := '"*.wav"';
  arb[3] := '"*.ogg"';
  arb[4] := '"*.flac"';
  arb[5] := '"*.mod"';
  arb[6] := '"*.it"';
  arb[7] := '"*.xm"';
  arb[8] := '"*.s3m"';
  arb[9] := '"*.*"';

  tfiledialog1.controller.filterlist.asarraya := ara;
  tfiledialog1.controller.filterlist.asarrayb := arb;

  tfiledialog1.controller.captionopen := lang_filelistfo[Ord(fi_filelistfo)];
  tfiledialog1.controller.filter      := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
  tfiledialog1.controller.fontcolor   := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;

  tfiledialog1.controller.fontheight := fontheightused;
  
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
      if mainfo.typecolor.Value = 2 then
        cbloopb.font.color := cl_black;
      cbloop.Value         := True;
      TButton(Sender).tag  := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        cbloopb.font.color := cl_white;
      cbloop.Value         := False;
      TButton(Sender).tag  := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'playreverseb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        playreverseb.font.color := cl_black;
      playreverse.Value         := True;
      TButton(Sender).tag       := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        playreverseb.font.color := cl_white;
      playreverse.Value         := False;
      TButton(Sender).tag       := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'waveformcheckb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        waveformcheckb.font.color   := cl_black;
      waveformcheck.Value           := True;
      TButton(Sender).tag           := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
      
      if (panelwave.Visible = True) then
      begin
      initDrawLive();
      end;
      
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        waveformcheckb.font.color   := cl_white;
      waveformcheck.Value           := False;
      TButton(Sender).tag           := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    
      if (panelwave.Visible = True) then
      begin
      initDrawLive();
      end;
    end;

  if TButton(Sender).Name = 'setmonob' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        setmonob.font.color := cl_black;
      setmono.Value         := True;
      TButton(Sender).tag   := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        setmonob.font.color := cl_white;
      setmono.Value         := False;
      TButton(Sender).tag   := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'cbtempob' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        cbtempob.font.color := cl_black;
      cbtempo.Value         := True;
      TButton(Sender).tag   := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        cbtempob.font.color := cl_white;
      cbtempo.Value         := False;
      TButton(Sender).tag   := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

end;

procedure tsongplayerfo.ontimercheck(const Sender: TObject);
begin

  if cbloop.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      cbloopb.font.color  := cl_black;
    cbloopb.tag           := 1;
    cbloopb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      cbloopb.font.color  := cl_white;
    cbloopb.tag           := 0;
    cbloopb.face.template := mainfo.tfaceplayerlight;
  end;

  if playreverse.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      playreverseb.font.color  := cl_black;
    playreverseb.tag           := 1;
    playreverseb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      playreverseb.font.color  := cl_white;
    playreverseb.tag           := 0;
    playreverseb.face.template := mainfo.tfaceplayerlight;
  end;

  if waveformcheck.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      waveformcheckb.font.color  := cl_black;
    waveformcheckb.tag           := 1;
    waveformcheckb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      waveformcheckb.font.color  := cl_white;
    waveformcheckb.tag           := 0;
    waveformcheckb.face.template := mainfo.tfaceplayerlight;
  end;

  if setmono.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      setmonob.font.color  := cl_black;
    setmonob.tag           := 1;
    setmonob.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      setmonob.font.color  := cl_white;
    setmonob.tag           := 0;
    setmonob.face.template := mainfo.tfaceplayerlight;
  end;

  if cbtempo.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      cbtempob.font.color  := cl_black;
    cbtempob.tag           := 1;
    cbtempob.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      cbtempob.font.color  := cl_white;
    cbtempob.tag           := 0;
    cbtempob.face.template := mainfo.tfaceplayerlight;
  end;

end;

procedure tsongplayerfo.ontimerwavdata(const Sender: TObject);
var
  framewanted: integer;
begin
  if tag = 0 then
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
    if (Inputlength1 <> 0) then
    begin
      framewanted := Inputlength1 div (trackbar1.Width - 7);

      uos_InputSetFrameCount(theplayerinfo, 0, framewanted);

      // Assign the procedure of object to execute at end of stream
      uos_EndProc(theplayerinfo, @GetWaveData);
      //  application.processmessages;
    end;

    uos_Play(theplayerinfo);  /// everything is ready, here we are, lets do it...

    //application.processmessages;
  end;

  if tag = 1 then
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
    if Inputlength2 <> 0 then
    begin
      framewanted := Inputlength2 div (trackbar1.Width - 7);

      uos_InputSetFrameCount(theplayerinfo2, 0, framewanted);

      // Assign the procedure of object to execute at end of stream
      uos_EndProc(theplayerinfo2, @GetWaveData);
    end;

    uos_Play(theplayerinfo2);  /// everything is ready, here we are, lets do it...

  end;

end;

procedure tsongplayerfo.onmouseev(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
  if ainfo.eventkind = ek_buttonrelease then
    begin
    if tag = 0 then
    begin
     uos_InputSeek(theplayer, Inputindex1, trunc(ainfo.pos.x / panelwave.width * Inputlength1));
      InitDrawLive();
      InitDrawLivewav();
    end;
    
    if tag = 1 then
    begin
     uos_InputSeek(theplayer2, Inputindex2, trunc(ainfo.pos.x / panelwave.width * Inputlength2));
      InitDrawLive();
      InitDrawLivewav();
    end;
    end;
end;


end.

