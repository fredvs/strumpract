unit recorder;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes,uos_flat,infosd,msetypes,msefileutils,mseglob,mseguiglob,mseguiintf,mseapplication,
 msestat,msemenus,msegui,msegraphics,msegraphutils,Math,mseevent,mseclasses,
 mseforms,msedock,msesimplewidgets,msewidgets,msedataedits,msefiledialogx,
 msegrids,mselistbrowser,msesys,SysUtils,msegraphedits,mseificomp,
 mseificompglob,mseifiglob,msescrollbar,msedragglob,mseact,mseedit,msestatfile,
 msestream,msestrings,msebitmap,msedatanodes,msedispwidgets,mserichstring,
 msedropdownlist,msetimer,msegridsglob;

type
  trecorderfo = class(tdockform)
    Timerwait: Ttimer;
    Timerrec: Ttimer;
    Timersent: Ttimer;
    tgroupbox1: tgroupbox;
    tbutton3: TButton;
    tbutton2: TButton;
    blistenin: tbooleanedit;
    btinfos: TButton;
    trackbar1: tslider;
    historyfn: thistoryedit;
    llength: tstringdisp;
    lposition: tstringdisp;
    tstringdisp2: tstringdisp;
    vuRight: tprogressbar;
    vuLeft: tprogressbar;
    recpan: tgroupbox;
    tbutton6: TButton;
    tfiledialog1: tfiledialogx;
    tgroupbox2: tgroupbox;
    bwav: tbooleaneditradio;
    bogg: tbooleaneditradio;
    bsavetofile: tbooleanedit;
    tgroupbox3: tgroupbox;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    btnStop: TButton;
    btnPause: TButton;
    btnResume: TButton;
    btnStart: TButton;
    button1: TButton;
    edtempo: trealspinedit;
    sentcue1: tbooleanedit;
    cbtempo: tbooleanedit;
    cbloop: tbooleanedit;
   edvol: trealspinedit;
   edvolr: trealspinedit;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1;
    procedure showposition;
    procedure showlevel;
    procedure LoopProcPlayer1;
    procedure onreset(const Sender: TObject);
    procedure changevolume(const Sender: TObject);
    procedure ChangePlugSetSoundTouch(const Sender: TObject);
    procedure onsliderchange(const Sender: TObject);
    procedure ontimerwait(const Sender: TObject);
    procedure ontimerrec(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplayercreate(const Sender: TObject);
    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure dorecorderstart(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure onlistenin(const Sender: TObject);
    procedure ondest(const Sender: TObject);
    procedure ShowSpectrum(const Sender: TObject);
    procedure changefrequency(asender, aindex: integer; gainl, gainr: double);
    procedure setequalizerenable(asender: integer; avalue: Boolean);
    procedure resetspectrum();
    procedure InitDrawLive();
    procedure DrawLive(lv, rv: double);
    procedure afterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
    procedure oncreated(const Sender: TObject);
    procedure onex(const Sender: TObject);
    procedure onchangesave(const Sender: TObject);
    procedure oneventloop(const Sender: TObject);
    procedure resizere(fontheight: integer);

  end;

  equalizer_band_type = record
    theindex: integer;
    lo_freq, hi_freq: cfloat;
    Text: string[10];
  end;

var
  timenow: ttime;
  arrecl, arrecr: flo64arty;
  rectrecform: rectty;
  xreclive: integer;
  islive: Boolean = True;
  Equalizer_Bands: array[1..10] of equalizer_band_type;
  thearrayrec: array of cfloat;
  tottimerec: ttime;
  recorderfo: trecorderfo;
  thedialogform: tfiledialogxfo;
  initplay: integer = 1;
  isrecording: Boolean = False;
  therecplayer: integer = 24;
  therecplayerinfo: integer = 25;
  plugIndex3, PluginIndex3: integer;
  InputIndex3, OutputIndex3, Inputlength: integer;


implementation

uses
  captionstrumpract,
  main,
  config,
  dockpanel1,
  commander,
  spectrum1,
  waveform,
  songplayer,
  equalizer,
 //   {$if not defined(darwin)}
  imagedancer,
   // {$endif}
  recorder_mfm;

var
  boundchildre: array of boundchild;

procedure trecorderfo.resizere(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := round(442 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := round(128 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fontheight;

  tgroupbox1.font.Height := fontheight;
  frame.grip_size        := round(8 * ratio);

  edtempo.frame.buttonsize := round(22 * ratio);
  edvol.frame.buttonsize   := round(22 * ratio);
  edvolr.frame.buttonsize  := round(22 * ratio);

  with tgroupbox1 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildre) - 1 do
        if children[i1].Name = boundchildre[i2].Name then
        begin
          children[i1].left   := round(boundchildre[i2].left * ratio);
          children[i1].top    := round(boundchildre[i2].top * ratio);
          children[i1].Width  := round(boundchildre[i2].Width * ratio);
          children[i1].Height := round(boundchildre[i2].Height * ratio);
        end;

  with tgroupbox2 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildre) - 1 do
        if children[i1].Name = boundchildre[i2].Name then
        begin
          children[i1].left   := round(boundchildre[i2].left * ratio);
          children[i1].top    := round(boundchildre[i2].top * ratio);
          children[i1].Width  := round(boundchildre[i2].Width * ratio);
          children[i1].Height := round(boundchildre[i2].Height * ratio);
        end;

  with tgroupbox3 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildre) - 1 do
        if children[i1].Name = boundchildre[i2].Name then
        begin
          children[i1].left   := round(boundchildre[i2].left * ratio);
          children[i1].top    := round(boundchildre[i2].top * ratio);
          children[i1].Width  := round(boundchildre[i2].Width * ratio);
          children[i1].Height := round(boundchildre[i2].Height * ratio);
        end;

end;

procedure trecorderfo.InitDrawLive();
const
  transpcolor = $FFF0F0;
begin

  if (as_checked in waveforec.tmainmenu1.menu[0].state) then
  begin
    waveforec.trackbar1.Width  := waveforec.Width - 12;
    waveforec.trackbar1.Height := waveforec.Height - 18;
    waveforec.trackbar1.invalidate();

    rectrecform.pos  := nullpoint;
    rectrecform.size := waveforec.trackbar1.paintsize;

    xreclive := 1;

    waveforec.TrackBar1.Value := 0;

    with waveforec.sliderimage.bitmap do
    begin
      size   := rectrecform.size;
      init(transpcolor);
      masked := True;
      transparentcolor := transpcolor;
    end;

  end;

end;

procedure trecorderfo.DrawLive(lv, rv: double);
var
  poswavrec, poswavrec2: pointty;
begin

  waveforec.sliderimage.bitmap.masked := False;

  poswavrec.x  := xreclive;
  poswavrec2.x := poswavrec.x;
  poswavrec.y  := (waveforec.trackbar1.Height div 2) - 2;
  poswavrec2.y := ((rectrecform.cy div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));
  waveforec.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);

  poswavrec.y := (waveforec.trackbar1.Height div 2);

  poswavrec2.y := poswavrec.y + (round((rv) * ((waveforec.trackbar1.Height div 2) - 3)));
  waveforec.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);

  xreclive := xreclive + 1;

end;


procedure trecorderfo.ontimersent(const Sender: TObject);
begin
  hintpanel.Visible := False;
end;

procedure trecorderfo.ontimerrec(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  timerrec.Enabled := False;
  if isrecording then
  begin
    temptime         := now - timenow;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value  := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    timerrec.Enabled := True;
  end
  else
    lposition.Value  := '00:00:00.000';
end;

procedure trecorderfo.ontimerwait(const Sender: TObject);
begin
  //  timerwait.Enabled := False;
  btnStart.Enabled := True;
  btnStop.Enabled  := True;
  if cbloop.Value = False then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;
  btnresume.Enabled  := False;
  cbloop.Enabled     := False;
  trackbar1.Enabled  := True;

end;

procedure trecorderfo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if (trim(PChar(ansistring(recorderfo.historyfn.Value))) <> '') and fileexists(ansistring(recorderfo.historyfn.Value)) then
    uos_SetPluginSoundTouch(therecplayer, PluginIndex3, edtempo.Value, 1, cbtempo.Value);
end;


procedure trecorderfo.ClosePlayer1;
begin

  tbutton2.Enabled := False;
  tbutton3.Enabled := True;

  vuright.Value       := 0;
  vuleft.Value        := 0;
  vuright.Height      := 0;
  vuleft.Height       := 0;
  btnStart.Enabled    := True;
  btnStop.Enabled     := False;
  btnPause.Enabled    := False;
  btnresume.Enabled   := False;
  cbloop.Enabled      := True;
  trackbar1.Value     := 0;
  trackbar1.Enabled   := False;
  bsavetofile.Enabled := True;
  lposition.Value     := '00:00:00.000';
 // lposition.face.template := tfacereclight;
 // historyfn.face.template := tfacereclight;

  isrecording := False;

  timerrec.Enabled := False;

  recpan.Visible := False;

  llength.Value           := '00:00:00.000';
 // lposition.face.template := tfacereclight;
 // historyfn.face.template := tfacereclight;

  tbutton3.Visible := True;
  tbutton2.Visible := False;

  resetspectrum();
  InitDrawLive();

end;

procedure trecorderfo.ShowLevel;
var
  leftlev, rightlev: double;
begin
  vuLeft.Visible  := True;
  vuRight.Visible := True;

  leftlev  := uos_InputGetLevelLeft(therecplayer, Inputindex3);
  rightlev := uos_InputGetLevelRight(therecplayer, Inputindex3);

//  {$if not defined(darwin)}  
  multiplier   := ((leftlev + rightlev) / 2);
  if multiplier > 1 then
    multiplier := 1;

  if (imagedancerfo.Visible = True) and (isbuzy = False) and
    (imagedancerfo.openglwidget.Visible = False) then
  begin
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
  // {$endif}
  if waveforec.Visible = True then
    if (as_checked in waveforec.tmainmenu1.menu[0].state) then
    begin
      if (xreclive) > (waveforec.Width - 10) then
        InitDrawLive();

      waveforec.TrackBar1.Value := xreclive / (waveforec.TrackBar1.Width);
      DrawLive(leftlev, rightlev);
    end;

  if (leftlev >= 0) and (leftlev <= 1) then
    vuLeft.Value := leftlev;

  if (rightlev >= 0) and (rightlev <= 1) then
    vuRight.Value := rightlev;
end;

procedure trecorderfo.ShowPosition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin

  if (TrackBar1.Tag = 0) then
    if uos_InputPosition(therecplayer, InputIndex3) > 0 then
    begin

      TrackBar1.Value := uos_InputPosition(therecplayer, InputIndex3) / inputlength;
      temptime        := uos_InputPositionTime(therecplayer, InputIndex3);
      ////// Length of input in time
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));

    end;

end;

procedure trecorderfo.LoopProcPlayer1;
begin
  ShowLevel;

  if isrecording = False then
    ShowPosition;

  if (spectrumrecfo.spect1.Value = True) and (spectrumrecfo.Visible = True) and
    (commanderfo.speccalc.Value = True) then
    ShowSpectrum(nil);
end;

procedure trecorderfo.doplayerstart(const Sender: TObject);
var
  samformat, i: shortint;
  ho, mi, se, ms: word;
  tottime: ttime;
begin
  if fileexists(PChar(ansistring(historyfn.Value))) then
  begin
    samformat := 0;

    if sentcue1.Value = True then
      songplayerfo.historyfn.Value := historyfn.Value;

    //  songdir.hint := songdir.value;


    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...

    uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(therecplayer) then
      //// Create the player.
      //// PlayerIndex : from 0 to what your computer can do !
      //// If PlayerIndex exists already, it will be overwriten...
      tbutton3.Enabled := False;

    application.ProcessMessages;

    InputIndex3 := uos_AddFromFile(therecplayer, PChar(ansistring(historyfn.Value)), -1, samformat, 1024 * 4);

    //// add input from audio file with custom parameters
    ////////// FileName : filename of audio file
    //////////// PlayerIndex : Index of a existing Player
    ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
    //////////// FramesCount : default : -1 (65536 div channels)
    //  result : -1 nothing created, otherwise Input Index in array

    if InputIndex3 > -1 then
    begin
      isrecording := False;
      // OutputIndex3 := uos_AddIntoDevOut(PlayerIndex3) ;
      //// add a Output into device with default parameters

      OutputIndex3 := uos_AddIntoDevOut(therecplayer, configfo.devoutcfg.Value, configfo.latplay.Value, uos_InputGetSampleRate(therecplayer, InputIndex3),
        uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024 * 4, -1);

      //// add a Output into device with custom parameters
      //////////// PlayerIndex : Index of a existing Player
      //////////// Device ( -1 is default Output device )
      //////////// Latency  ( -1 is latency suggested ) )
      //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
      //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
      //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
      //////////// FramesCount : default : -1 (65536)
      //  result : -1 nothing created, otherwise Output Index in array

      uos_InputSetLevelEnable(therecplayer, InputIndex3, 2);
      ///// set calculation of level/volume (usefull for showvolume procedure)
      ///////// set level calculation (default is 0)
      // 0 => no calcul
      // 1 => calcul before all DSP procedures.
      // 2 => calcul after all DSP procedures.
      // 3 => calcul before and after all DSP procedures.

      uos_InputSetPositionEnable(therecplayer, InputIndex3, 1);
      ///// set calculation of position (usefull for positions procedure)
      ///////// set position calculation (default is 0)
      // 0 => no calcul
      // 1 => calcul position.

      uos_LoopProcIn(therecplayer, InputIndex3, @LoopProcPlayer1);

      ///// Assign the procedure of object to execute inside the loop
      //////////// PlayerIndex : Index of a existing Player
      //////////// InputIndex3 : Index of a existing Input
      //////////// LoopProcPlayer1 : procedure of object to execute inside the loop

      uos_InputAddDSPVolume(therecplayer, InputIndex3, 1, 1);
      ///// DSP Volume changer
      ////////// PlayerIndex3 : Index of a existing Player
      ////////// InputIndex3 : Index of a existing input
      ////////// VolLeft : Left volume
      ////////// VolRight : Right volume

      uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.Value / 100, edvolr.Value / 100, True);
      /// Set volume
      ////////// PlayerIndex3 : Index of a existing Player
      ////////// InputIndex3 : InputIndex of a existing Input
      ////////// VolLeft : Left volume
      ////////// VolRight : Right volume
      ////////// Enable : Enabled

      for i := 1 to 10 do // equalizer
        Equalizer_Bands[i].theindex :=
          uos_InputAddFilter(therecplayer, InputIndex3,
          1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
          1, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, True, nil);

      equalizerforec.onchangeall();

      if commanderfo.speccalc.Value = True then // spectrum
        for i := 1 to 10 do
          uos_InputAddFilter(therecplayer, InputIndex3,
            3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
            3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, False, nil);

      /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
      /// SoundTouch plugin should be the last added.

      if plugsoundtouch = True then
      begin
        PlugInIndex3 := uos_AddPlugin(therecplayer, 'soundtouch', uos_InputGetSampleRate(therecplayer, InputIndex3), -1);
        ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
      end;

      inputlength := uos_InputLength(therecplayer, InputIndex3);
      ////// Length of Input in samples

      tottime := uos_InputLengthTime(therecplayer, InputIndex3);
      ////// Length of input in time

      DecodeTime(tottime, ho, mi, se, ms);

      llength.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));

      uos_EndProc(therecplayer, @ClosePlayer1);

      /////// procedure to execute when stream is terminated
      ///// Assign the procedure of object to execute at end
      //////////// PlayerIndex : Index of a existing Player
      //////////// ClosePlayer1 : procedure of object to execute inside the general loop

      btinfos.Enabled := True;

      trackbar1.Value   := 0;
      trackbar1.Enabled := True;
      btnStop.Enabled   := True;
      btnresume.Enabled := False;
      InitDrawLive();
      application.ProcessMessages;
      if cbloop.Value = True then
      begin
        uos_Play(therecplayer, -1);
        btnpause.Enabled := False;
      end
      else
      begin
        uos_Play(therecplayer);  /////// everything is ready, here we are, lets play it...
        btnpause.Enabled      := True;
      end;
    //  lposition.face.template := tfacereclight;
      cbloop.Enabled          := False;
      historyfn.hint          := historyfn.Value;
      if timerwait.Enabled then
        timerwait.restart // to reset
      else
        timerwait.Enabled := True;
    end
    else
    begin
      ShowMessage(historyfn.Value + ' does not exist...');
    end;
  end
  else
    ShowMessage(historyfn.Value + ' does not exist...');

end;

procedure trecorderfo.doplayeresume(const Sender: TObject);
begin
  btnStop.Enabled   := True;
  btnPause.Enabled  := True;
  btnresume.Enabled := False;
  uos_RePlay(therecplayer);
end;

procedure trecorderfo.doplayerpause(const Sender: TObject);
begin
  vuright.Value     := 0;
  vuleft.Value      := 0;
  btnStop.Enabled   := True;
  btnPause.Enabled  := False;
  btnresume.Enabled := True;
  uos_Pause(therecplayer);
end;

procedure trecorderfo.doplayerstop(const Sender: TObject);
begin
  cbloop.Enabled := True;
  uos_Stop(therecplayer);
  application.ProcessMessages;
end;

procedure trecorderfo.changevolume(const Sender: TObject);
begin
  uos_InputSetDSPVolume(therecplayer, InputIndex3,
    edvol.Value / 100, edvolr.Value / 100, True);
end;

procedure trecorderfo.onreset(const Sender: TObject);
begin
  edtempo.Value := 1;
end;

procedure trecorderfo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if (trackbar1.tag = 1) and (inputlength > 0) then
  begin
    temptime        := tottimerec * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));

  end;

end;


procedure trecorderfo.visiblechangeev(const Sender: TObject);
begin

  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and
    (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showrecorder']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': ' +
        lang_mainfo[Ord(ma_recorder)]
    else
    begin
      mainfo.tmainmenu1.menu.itembynames(['show', 'showrecorder']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
        lang_mainfo[Ord(ma_recorder)];
      uos_Stop(therecplayer);
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

procedure trecorderfo.resetspectrum();
var
  i: integer = 0;
begin

  while i < 10 do
  begin
    arrecl[i] := 0;
    arrecr[i] := 0;
    Inc(i);
  end;

  spectrumrecfo.tchartleft.traces[0].ydata  := arrecl;
  spectrumrecfo.tchartright.traces[0].ydata := arrecr;

end;

procedure trecorderfo.ShowSpectrum(const Sender: TObject);
var
  i, x: integer;
begin
  if uos_getstatus(therecplayer) > 0 then
  begin
    thearrayrec := uos_InputFiltersGetLevelArray(therecplayer, InputIndex3);
    x           := 0;
    i           := 0;
    while x < length(thearrayrec) - 1 do
    begin
      arrecl[i] := thearrayrec[x];
      arrecr[i] := thearrayrec[x + 1];
      x         := x + 2;
      Inc(i);
    end;

    spectrumrecfo.tchartleft.traces[0].ydata  := arrecl;
    spectrumrecfo.tchartright.traces[0].ydata := arrecr;
  end;
end;

procedure trecorderfo.onplayercreate(const Sender: TObject);
var
  i1, childn: integer;
begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;  
 {$endif}


  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  setlength(boundchildre, childrencount);

  childn := childrencount;

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildre[i1].left   := children[i1].left;
    boundchildre[i1].top    := children[i1].top;
    boundchildre[i1].Width  := children[i1].Width;
    boundchildre[i1].Height := children[i1].Height;
    boundchildre[i1].Name   := children[i1].Name;
  end;

  with tgroupbox1 do
  begin
    setlength(boundchildre, length(boundchildre) + tgroupbox1.childrencount);

    for i1 := 0 to tgroupbox1.childrencount - 1 do
    begin
      boundchildre[i1 + childn].left   := children[i1].left;
      boundchildre[i1 + childn].top    := children[i1].top;
      boundchildre[i1 + childn].Width  := children[i1].Width;
      boundchildre[i1 + childn].Height := children[i1].Height;
      boundchildre[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildre);
  end;

  with tgroupbox2 do
  begin
    setlength(boundchildre, length(boundchildre) + tgroupbox2.childrencount);

    for i1 := 0 to tgroupbox2.childrencount - 1 do
    begin
      boundchildre[i1 + childn].left   := children[i1].left;
      boundchildre[i1 + childn].top    := children[i1].top;
      boundchildre[i1 + childn].Width  := children[i1].Width;
      boundchildre[i1 + childn].Height := children[i1].Height;
      boundchildre[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildre);
  end;

  with tgroupbox3 do
  begin
    setlength(boundchildre, length(boundchildre) + tgroupbox3.childrencount);

    for i1 := 0 to tgroupbox3.childrencount - 1 do
    begin
      boundchildre[i1 + childn].left   := children[i1].left;
      boundchildre[i1 + childn].top    := children[i1].top;
      boundchildre[i1 + childn].Width  := children[i1].Width;
      boundchildre[i1 + childn].Height := children[i1].Height;
      boundchildre[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildre);
  end;

  setlength(arrecl, 10);
  setlength(arrecr, 10);

  Caption           := 'Recorder';
  Timerwait         := ttimer.Create(nil);
  Timerwait.interval := 100000;
  Timerwait.Enabled := False;
  Timerwait.options := [to_single];
  Timerwait.ontimer := @ontimerwait;

  Timerrec          := ttimer.Create(nil);
  Timerrec.interval := 100000;
  Timerrec.Enabled  := False;
  Timerrec.ontimer  := @ontimerrec;

  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.ontimer  := @ontimersent;
  Timersent.options  := [to_single];

end;

procedure trecorderfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if mainfo.ttimer2.Enabled then
    mainfo.ttimer2.restart // to reset
  else
    mainfo.ttimer2.Enabled := True;
end;

procedure trecorderfo.dorecorderstart(const Sender: TObject);
var
  i, outformat: integer;
  outformatst: msestring;
   history: msestringarty;
begin

  uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

  if uos_CreatePlayer(therecplayer) then
  begin
    application.ProcessMessages;
    cbloop.Enabled   := False;
    isrecording      := True;
    tbutton2.Enabled := True;
    tbutton3.Enabled := False;
    btnStart.Enabled := False;

   // historyfn.face.template := tfacereclight;

    lposition.face.template := mainfo.tfaceorange;
    recpan.Visible          := True;

    recpan.font.color := cl_black;

    if bsavetofile.Value then
    begin

      if bwav.Value then
      begin
        outformatst := 'wav';
        outformat   := 0;
      end
      else
      begin
        outformatst := 'ogg';
        outformat   := 3;
      end;
     
     historyfn.Value :=  tfiledialog1.controller.filename  + 'rec_' +
        msestring(formatdatetime('YY_MM_DD_HH_mm_ss', now)) + '.' + outformatst;
        
    history := historyfn.dropdown.history;
    setlength(history, length(history) + 1);
    
    history[length(history)-1] := historyfn.Value;
   
    historyfn.dropdown.history  := history;   
  
      uos_AddIntoFile(therecplayer, PChar(ansistring(historyfn.Value)), -1, -1, -1, 4096, outformat);
      if sentcue1.Value = True then
        songplayerfo.historyfn.Value := historyfn.Value;
    end;


    OutputIndex3 := uos_AddIntoDevOut(therecplayer, configfo.devoutcfg.Value, configfo.latrec.Value, -1, -1, -1, -1, -1);

    uos_outputsetenable(therecplayer, OutputIndex3, blistenin.Value);

    InputIndex3 := uos_AddFromDevIn(therecplayer, configfo.devincfg.Value, -1, -1, -1, -1, -1, -1);
    /// add Input from mic/aux into IN device with default parameters

    //    In1Index := uos_AddFromDevIn(therecplayer, configfo.devincfg.value, -1, -1, -1, 1, -1);
    /// add Input from mic/aux into IN device with custom parameters
    //////////// PlayerIndex : Index of a existing Player
    //////////// Device ( -1 is default Input device )
    //////////// Latency  ( -1 is latency suggested ) )
    //////////// SampleRate : delault : -1 (44100)
    //////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
    //////////// FramesCount : -1 default : 4096   ( > = safer, < =  better latency )

    uos_InputAddDSP1ChanTo2Chan(therecplayer, InputIndex3);
    /////  Convert mono one channel channel to stereo two channels.
    //// If the input is stereo, original buffer is keeped.
    ////////// InputIndex : InputIndex of a existing Input
    //  result :  index of DSPIn in array
    ////////// example  DSPIndex3 := uos_InputAddDSP1ChanTo2Chan(PlayerIndex3, InputIndex3);
    uos_InputSetLevelEnable(therecplayer, InputIndex3, 2);

    uos_InputAddDSPVolume(therecplayer, InputIndex3, 1, 1);
    ///// DSP Volume changer
    //////////// PlayerIndex : Index of a existing Player
    ////////// In1Index : InputIndex of a existing input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume

    uos_LoopProcIn(therecplayer, InputIndex3, @LoopProcPlayer1);

    uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.Value / 100, edvolr.Value / 100, True);

    if commanderfo.speccalc.Value = True then
      for i := 1 to 10 do
        uos_InputAddFilter(therecplayer, InputIndex3,
          3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1,
          3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, False, nil);


    if plugsoundtouch = True then
    begin
      PlugInIndex3 := uos_AddPlugin(therecplayer, 'soundtouch', uos_InputGetSampleRate(therecplayer, InputIndex3), -1);
      ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
    end;

    /////// procedure to execute when stream is terminated
    uos_EndProc(therecplayer, @ClosePlayer1);
    ///// Assign the procedure of object to execute at end
    //////////// PlayerIndex : Index of a existing Player
    //////////// ClosePlayer1 : procedure of object to execute inside the loop

    llength.Value := '00:00:00.000';

    InitDrawLive();

    application.ProcessMessages;

    uos_Play(therecplayer);  /////// everything is ready to play...

    bsavetofile.Enabled := False;

    tbutton2.Visible := True;
    tbutton3.Visible := False;
    timenow          := now;
    timerrec.Enabled := True;
  end;
end;

procedure trecorderfo.whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 2;
end;

procedure trecorderfo.onlistenin(const Sender: TObject);
begin
  uos_outputsetenable(therecplayer, OutputIndex3, blistenin.Value);
end;

procedure trecorderfo.ondest(const Sender: TObject);
begin
  Timerwait.Free;
  timerrec.Free;
  Timersent.Free;
end;

procedure trecorderfo.afterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
begin
  if akind = sbe_thumbposition then
    uos_InputSeek(therecplayer, InputIndex3, trunc(avalue * inputlength))
  else
    onsliderchange(Sender);
end;

procedure trecorderfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
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

procedure trecorderfo.ontextedit(const Sender: tcustomedit; var atext: msestring);
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

procedure trecorderfo.oncreated(const Sender: TObject);
begin

  if devin < 0 then
  begin
    tbutton3.Enabled := False;
    btnStart.Enabled := False;
    btinfos.Enabled  := False;
  end;

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

end;

procedure trecorderfo.onex(const Sender: TObject);
begin
if tfiledialog1.controller.basedir = '' then

  tfiledialog1.controller.basedir := GetUserDir ;
 
 if tfiledialog1.controller.filename = '' then
  tfiledialog1.controller.filename := GetUserDir ;

 // tfiledialog1.controller.captionopen := 'Open Audio File';
  tfiledialog1.controller.fontcolor   := cl_black;
  tfiledialog1.controller.filter      := '"*.wav" "*.ogg"';

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
  begin
    historyfn.Value := tfiledialog1.controller.filename;
  end;

end;

procedure trecorderfo.changefrequency(asender, aindex: integer; gainl, gainr: double);
var
  aplayer: integer;
  isenable: Boolean = False;
begin
  isenable := equalizerforec.EQEN.Value;

  aplayer := therecplayer;
  uos_InputSetFilter(aplayer, InputIndex3, Equalizer_Bands[aindex].theindex, -1, -1, -1, Gainl, -1, -1, -1, Gainr,
    True, nil, isenable);
end;


procedure trecorderfo.setequalizerenable(asender: integer; avalue: Boolean);
var
  aplayer: integer;
  x: integer;
  avalset: Boolean;
begin

  aplayer := therecplayer;

  if avalue then
    avalset := False
  else
    avalset := True;

  for x := 1 to 10 do
    uos_InputSetFilter(aplayer, InputIndex3, Equalizer_Bands[x].theindex, -1, -1, -1, -1, -1, -1, -1, -1, True, nil, avalset);
end;

procedure trecorderfo.onchangesave(const Sender: TObject);
begin
  if bsavetofile.Value then
  begin
    bwav.Enabled := True;
    bogg.Enabled := True;
  end
  else
  begin
    bwav.Enabled := False;
    bogg.Enabled := False;
  end;
end;

procedure trecorderfo.oneventloop(const Sender: TObject);
begin
 
  if plugsoundtouch = False then
  begin
    edtempo.Enabled := False;
    cbtempo.Enabled := False;
    Button1.Enabled := False;
  end
  else
  begin
    edtempo.Enabled := True;
    cbtempo.Enabled := True;
    Button1.Enabled := True;
  end;

end;


end.

