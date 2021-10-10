unit recorder;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes,uos_flat,infos,msetimer,msetypes,mseglob,mseguiglob,mseguiintf,
 mseapplication,msestat,msemenus,msegui,msegraphics,msegraphutils,Math,mseevent,
 mseclasses,mseforms,msedock,msesimplewidgets,msewidgets,msedataedits,
 msefiledialogx,msegrids,mselistbrowser,msesys,SysUtils,msegraphedits,
 mseificomp,mseificompglob,mseifiglob,msescrollbar,msedragglob,mseact,mseedit,
 msestatfile,msestream,msestrings,msebitmap,msedatanodes,msedispwidgets,
 mserichstring,msedropdownlist,msegridsglob;

type
  trecorderfo = class(tdockform)
    Timerwait: Ttimer;
    Timerrec: Ttimer;
    Timersent: Ttimer;
    tfacereclight: tfacecomp;
    tfacerecrev: tfacecomp;
    tgroupbox1: tgroupbox;
    tfacerecorder: tfacecomp;
    tbutton3: TButton;
    tbutton2: TButton;
    blistenin: tbooleanedit;
    btinfos: TButton;
    edvol: trealspinedit;
    edtempo: trealspinedit;
    button1: TButton;
    cbloop: tbooleanedit;
    cbtempo: tbooleanedit;
    trackbar1: tslider;
    btnStop: TButton;
    btnStart: TButton;
    btnResume: TButton;
    btnPause: TButton;
    historyfn: thistoryedit;
    llength: tstringdisp;
    lposition: tstringdisp;
    tstringdisp2: tstringdisp;
    vuRight: tprogressbar;
    vuLeft: tprogressbar;
    recpan: tgroupbox;
    tfacecomp2: tfacecomp;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    sentcue1: tbooleanedit;
    tbutton6: TButton;
    edvolr: trealspinedit;
    tfiledialog1: tfiledialogx;
   tgroupbox2: tgroupbox;
   bwav: tbooleaneditradio;
   bogg: tbooleaneditradio;
   bsavetofile: tbooleanedit;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1;
    procedure showposition;
    procedure showlevel;
    procedure LoopProcPlayer1;
    procedure onfinfos(const Sender: TObject);
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
   procedure onchangesave(const sender: TObject);
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
  main,
  config,
  dockpanel1,
  commander,
  spectrum1,
  waveform,
  songplayer,
  equalizer,
  imagedancer,
  recorder_mfm;

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


  //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform1[poswav.x * 2]) * ((wavefo.trackbar1.Height div 2) - 3));

  poswavrec.y  := (waveforec.trackbar1.Height div 2) - 2;
  poswavrec2.y := ((rectrecform.cy div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));

  // if mainfo.typecolor.Value = 0 then
  waveforec.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC99D6);
  //  else
  //    canvas.drawline(poswav, poswav2, $6A6A6A);

  poswavrec.y := (waveforec.trackbar1.Height div 2);

  poswavrec2.y := poswavrec.y + (round((rv) * ((waveforec.trackbar1.Height div 2) - 3)));

  //  if mainfo.typecolor.Value = 0 then
  waveforec.sliderimage.bitmap.Canvas.drawline(poswavrec, poswavrec2, $AC79D6);
  //  else
  //    canvas.drawline(poswav, poswav2, $8A8A8A);


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
  {
    radiobutton1.Enabled := True;
    radiobutton2.Enabled := True;
    radiobutton3.Enabled := True;
    }
  tbutton2.Enabled := False;
  tbutton3.Enabled := True;

  vuright.value    := 0;
  vuleft.value     := 0;
  vuright.Height    := 0;
  vuleft.Height     := 0;
  //vuLeft.Visible      := False;
  //vuRight.Visible     := False;
  btnStart.Enabled    := True;
  btnStop.Enabled     := False;
  btnPause.Enabled    := False;
  btnresume.Enabled   := False;
  cbloop.Enabled      := True;
  trackbar1.Value     := 0;
  trackbar1.Enabled   := False;
  bsavetofile.Enabled := True;
  lposition.Value     := '00:00:00.000';
  lposition.face.template := tfacereclight;
  historyfn.face.template := tfacereclight;

  isrecording := False;

  timerrec.Enabled := False;

  recpan.Visible := False;

  llength.Value           := '00:00:00.000';
  lposition.face.template := tfacereclight;
  historyfn.face.template := tfacereclight;

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
  
  multiplier := ((leftlev + rightlev) / 2);
  if multiplier > 1 then multiplier := 1;
 
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

  if waveforec.Visible = True then
    if (as_checked in waveforec.tmainmenu1.menu[0].state) then
    begin
      if (xreclive) > (waveforec.Width - 10) then
        InitDrawLive();

      waveforec.TrackBar1.Value := xreclive / (waveforec.TrackBar1.Width);
      DrawLive(leftlev, rightlev);
    end;

  if (leftlev >= 0) and (leftlev <= 1) then
    vuLeft.Value := leftlev{
    if leftlev < 0.80 then
      vuLeft.bar_face.template := mainfo.tfacegreen
    else
    if leftlev < 0.90 then
      vuLeft.bar_face.template := mainfo.tfaceorange
    else
      vuLeft.bar_face.template := mainfo.tfacered;
 };

  if (rightlev >= 0) and (rightlev <= 1) then
    vuRight.Value := rightlev{
    if rightlev < 0.80 then
      vuRight.bar_face.template := mainfo.tfacegreen
    else
    if rightlev < 0.90 then
      vuRight.bar_face.template := mainfo.tfaceorange
    else
      vuRight.bar_face.template := mainfo.tfacered;
      };
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
      
      application.processmessages;

    InputIndex3 := uos_AddFromFile(therecplayer, PChar(ansistring(historyfn.Value)), -1, samformat, 1024*4);

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

      OutputIndex3 := uos_AddIntoDevOut(therecplayer,configfo.devoutcfg.value, configfo.latplay.Value, uos_InputGetSampleRate(therecplayer, InputIndex3),
        uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024*4, -1);

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
      application.processmessages;
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
      lposition.face.template := tfacereclight;
      cbloop.Enabled          := False;
      //songdir.Value := historyfn.Value;
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
  //vuLeft.Visible    := False;
  //vuRight.Visible   := False;
  vuright.Value       := 0;
  vuleft.Value        := 0;
  btnStop.Enabled   := True;
  btnPause.Enabled  := False;
  btnresume.Enabled := True;
  uos_Pause(therecplayer);
end;

procedure trecorderfo.doplayerstop(const Sender: TObject);
begin
  cbloop.Enabled := True;
  uos_Stop(therecplayer);
  application.processmessages;
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

procedure trecorderfo.onfinfos(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  ho, mi, se, ms: word;
begin
{
  uos_Stop(therecplayerinfo);

 uos_CreatePlayer(therecplayerinfo);
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
    
   application.processmessages; 

    if uos_AddFromFile(therecplayerinfo, PChar(ansistring(historyfn.Value)), -1, 0, -1) > -1 then
    begin

      inputlength := uos_InputLength(therecplayer, InputIndex3);
      ////// Length of Input in samples

      temptimeinfo := uos_InputLengthTime(therecplayerinfo, 0);
      ////// Length of input in time

      DecodeTime(temptimeinfo, ho, mi, se, ms);

      infosforec.infofile.Caption   :=  extractfilename(historyfn.Value);
      //infosforec.infolength.top := infosforec.infofile.bottom + 10;
      infosforec.infoartist.visible := false ;
      infosforec.infoname.visible := false ;
      infosforec.infoalbum.visible := false ;
      infosforec.infoyear.visible := false ;
      infosforec.infocom.visible := false ;
      infosforec.infotag.visible := false ;
      infosforec.infolength.Caption := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
      infosforec.inforate.Caption   :=  msestring(IntToStr(uos_InputGetSampleRate(therecplayerinfo, 0)));
      infosforec.infochan.Caption   :=  msestring(IntToStr(uos_InputGetChannels(therecplayerinfo, 0)));
      infosforec.infobpm.visible := false ;
      infosforec.imgPreview.Visible := False;
      infosforec.tlabel2.Visible := False;
      
      application.processmessages;
      uos_play(therecplayerinfo);
      uos_Stop(therecplayerinfo);

       // infosfo.button1.left := (infosfo.width - infosfo.button1.width)  div 2 ;
      infosforec.Show(true);
    end;
    }
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

  if (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and
   (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) 
   and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin
    if Visible then
      mainfo.tmainmenu1.menu[4].submenu[7].Caption := ' Hide Recorder '
    else
    begin
      mainfo.tmainmenu1.menu[4].submenu[7].Caption := ' Show Recorder ';
      uos_Stop(therecplayer);
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
begin
  windowopacity := 0;
  
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

 
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
  //Timerrec.options := [to_single];
  Timerrec.ontimer  := @ontimerrec;

  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.ontimer  := @ontimersent;
  Timersent.options  := [to_single];

  if plugsoundtouch = False then
  begin
    edtempo.Enabled := False;
    cbtempo.Enabled := False;
    Button1.Enabled := False;
  end;
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
  outformatst :  msestring;
begin
  // if (bsavetofile.value = True) or (blistenin.value = True) then begin

  uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

  if uos_CreatePlayer(therecplayer) then
  begin
    application.processmessages;
    cbloop.Enabled   := False;
    isrecording      := True;
    tbutton2.Enabled := True;
    tbutton3.Enabled := False;
    btnStart.Enabled := False;

    historyfn.face.template := tfacereclight;

    lposition.face.template := mainfo.tfaceorange;

    //historyfn.font.color := cl_black;
    recpan.Visible := True;

    recpan.font.color := cl_black;

    if bsavetofile.Value then
    begin
    
    if bwav.value then 
     begin
    outformatst := 'wav';
    outformat := 0; 
    end else
    begin
    outformatst := 'ogg';
    outformat := 3;
    end; 

      historyfn.Value := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))) + 
      'sound' + directoryseparator + 'record' + directoryseparator + 'rec_' +
       msestring(formatdatetime('YY_MM_DD_HH_mm_ss', now)) + '.' + outformatst ;


      uos_AddIntoFile(therecplayer, PChar(ansistring(historyfn.Value)), 
       -1, -1, -1, 4096, outformat);
      if sentcue1.Value = True then
        songplayerfo.historyfn.Value := historyfn.Value;
    end;


    OutputIndex3 := uos_AddIntoDevOut(therecplayer, configfo.devoutcfg.value, configfo.latrec.Value, -1, -1, -1, -1, -1);

    uos_outputsetenable(therecplayer, OutputIndex3, blistenin.Value);

    InputIndex3 :=  uos_AddFromDevIn(therecplayer, configfo.devincfg.value, -1, -1, -1, -1, -1, -1);
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
    
    application.processmessages;

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
  tfiledialog1.controller.basedir :=
    utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'sound' + directoryseparator + 'record' + directoryseparator);

  tfiledialog1.controller.filename :=
    utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'sound' + directoryseparator + 'record' + directoryseparator);

  tfiledialog1.controller.captionopen := 'Open Audio File';
  tfiledialog1.controller.fontcolor   := cl_black;
  tfiledialog1.controller.filter      := '"*.mp3" "*.wav" "*.ogg" "*.flac"';

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
  begin
    historyfn.Value := tfiledialog1.controller.filename;
    historyfn.dropdown.history :=
      tfiledialog1.controller.history;
  end;

end;

procedure trecorderfo.changefrequency(asender, aindex: integer; gainl, gainr: double);
var
  aplayer: integer;
  isenable: Boolean = False;
begin
    isenable := equalizerforec.EQEN.Value;
   //if isenable then isenable := false else isenable := true;

    aplayer := therecplayer;
   
    //  if (btnStart.Enabled = true) then
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

procedure trecorderfo.onchangesave(const sender: TObject);
begin
if bsavetofile.value then
 begin
  bwav.enabled := true;
  bogg.enabled := true;
 end else
 begin
  bwav.enabled := false;
  bogg.enabled := false;
 end; 
end;



end.

