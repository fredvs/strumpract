unit songplayer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes, uos_flat, infos, msetimer, msetypes, mseglob, mseguiglob, mseguiintf,
 msefileutils,mseapplication, msestat, msemenus, msegui, msegraphics,
 msegraphutils, mseevent,mseclasses, mseforms, msedock, msesimplewidgets,
 msewidgets, msedataedits,msefiledialog, msegrids, mselistbrowser, msesys,
 SysUtils, msegraphedits,msedragglob, mseact, mseedit, mseificomp,
 mseificompglob, mseifiglob,msestatfile, msestream, msestrings, msescrollbar,
 msebitmap, msedatanodes,msedispwidgets, mserichstring;

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
    btnStop: TButton;
    btnResume: TButton;
    btnPause: TButton;
    trackbar1: tslider;
    historyfn: thistoryedit;
    songdir: tfilenameedit;
    llength: tstringdisp;
    lposition: tstringdisp;
    tstringdisp1: tstringdisp;
    edvolright: trealspinedit;
    btnStart: TButton;
    tfaceslider: tfacecomp;
    btinfos: TButton;
    BtnCue: TButton;

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
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1();
    procedure showposition(const Sender: TObject);
    procedure showlevel(const Sender: TObject);
    procedure LoopProcPlayer1();
    procedure oninfowav(const Sender: TObject);
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
    procedure DrawWaveForm();

    procedure onchachewav(const Sender: TObject);
    procedure onsetvalvol(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure ontextedit(const sender: tcustomedit; var atext: msestring);
  protected
    procedure paintsliderimage(const canvas: tcanvas; const arect: rectty);
  end;

var
  songplayerfo: tsongplayerfo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  theplayer: integer = 20;
  theplayerinfo: integer = 21;
  theplaying1: string;
  iscue1: boolean = False;
  hasmixed1: boolean = False;
  hasfocused1: boolean = False;
  iswav: boolean = False;
  plugindex1, PluginIndex2: integer;
  Inputindex1, Outputindex1, Inputlength1: integer;
  poswav1, chan1, framewanted1: integer;
  waveformdata1: array of cfloat;



implementation

uses
  main, commander, config, filelistform,
  songplayer_mfm;

procedure tsongplayerfo.ontimersent(const Sender: TObject);
begin
  timersent.Enabled := False;
  hintpanel.visible := false;
  historyfn.face.template := mainfo.tfaceplayerlight;
  edvolleft.face.template := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template := mainfo.tfaceplayer;
  end;

procedure tsongplayerfo.ontimerwait(const Sender: TObject);
begin
  timerwait.Enabled := False;
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
      btnresume.Enabled := True
    else
      btnresume.Enabled := False;
  end;

  if (cbloop.Value = False) and (iscue1 = False) then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;

  if iscue1 then
  begin
    btnresume.Enabled := True;

  end
  else
  begin
    btnresume.Enabled := False;
  end;


  cbloop.Enabled := False;
  trackbar1.Enabled := True;
end;

procedure tsongplayerfo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if hasinit = 1 then
  begin

    if (trim(PChar(ansistring(songplayerfo.historyfn.Value))) <> '') and fileexists(ansistring(songplayerfo.historyfn.Value)) then
    begin

      if cbtempo.Value = True then
      begin
        edtempo.face.template := mainfo.tfaceorange;
        timersent.Enabled := False;
        timersent.Enabled := True;
      end;

      uos_SetPluginSoundTouch(theplayer, PluginIndex2, edtempo.Value, 1, cbtempo.Value);

    end;
  end;
end;


procedure tsongplayerfo.ClosePlayer1();
begin
 
  if (commanderfo.automix.Value = true) and (hasmixed1 = False) then
  begin
    hasmixed1 := True;
    commanderfo.onstartstop(nil);
    hasfocused1 := True;
    filelistfo.onsent(nil);
    hasfocused1 := False;
    hasmixed1 := False;
  end;

  vuright.Value := 0;
  vuRight.Visible := False;

  vuleft.Value := 0;
  vuleft.Visible := False;

  btnStart.Enabled := True;
  btnStop.Enabled := False;
  btnPause.Enabled := False;
  btnresume.Enabled := False;
  if cbloop.Value then
    btncue.Enabled := False
  else
    btncue.Enabled := True;

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
    vuLeft.Visible := False;
    vuRight.Visible := False;
  end;

  cbloop.Enabled := True;
  trackbar1.Value := 0;
  trackbar1.Enabled := False;
  lposition.Value := '00:00:00.000';
  lposition.face.template := mainfo.tfaceplayer;

  if uos_GetStatus(theplayer) <> 1 then
  begin
    tstringdisp1.Value := '';
    tstringdisp1.face.template := mainfo.tfaceplayer;
  end;

  iswav := False;
  iscue1 := False;

  hasmixed1 := False;

  DrawWaveForm();

end;

procedure tsongplayerfo.ShowLevel(const Sender: TObject);

var
  leftlev, rightlev: double;
begin

  vuLeft.Visible := True;
  vuRight.Visible := True;

  if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
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
  //{

  if (leftlev >= 0) and (leftlev < 1) then
  begin
    if leftlev < 0.80 then
    begin
      vuLeft.bar_face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft.bar_face.template := mainfo.tfacegreen;
    end
    else
    if leftlev < 0.90 then
    begin
      vuLeft.bar_face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft.bar_face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuLeft.bar_face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft.bar_face.template := mainfo.tfacered;
    end;
    vuLeft.Value := leftlev;
    if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
      commanderfo.vuLeft.Value := leftlev;
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin

    if rightlev < 0.80 then
    begin
      vuRight.bar_face.template := mainfo.tfacegreen;

      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight.bar_face.template := mainfo.tfacegreen;
    end
    else
    if rightlev < 0.90 then
    begin
      vuRight.bar_face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight.bar_face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuRight.bar_face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight.bar_face.template := mainfo.tfacered;
    end;
    vuright.Value := rightlev;
    if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
      commanderfo.vuright.Value := rightlev;
  end;

end;

procedure tsongplayerfo.ShowPosition(const Sender: TObject);

var
  temptime: ttime;
  ho, mi, se, ms: word;
  mixtime: integer;
begin

  if not TrackBar1.clicked then
  begin
    if uos_InputPosition(theplayer, Inputindex1) > 0 then
    begin
      TrackBar1.Value := uos_InputPosition(theplayer, Inputindex1) / Inputlength1;
      temptime := uos_InputPositionTime(theplayer, Inputindex1);
      ////// Length of input in time
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
      if mixtime < 150000 then
        mixtime := 150000;
      if Inputlength1 < mixtime + 50000 then
        mixtime := Inputlength1 - 50000;

      if (commanderfo.automix.Value = true) and (hasmixed1 = False) and (uos_InputPosition(theplayer, Inputindex1) > Inputlength1 - mixtime) then
      begin
        hasmixed1 := True;
        commanderfo.onstartstop(nil);
        hasfocused1 := True;
        filelistfo.onsent(nil);
        hasfocused1 := False;
      end;

    end;
  end;

end;

procedure tsongplayerfo.LoopProcPlayer1();

begin
  ShowPosition(nil);
  ShowLevel(nil);
end;

procedure tsongplayerfo.doplayerstart(const Sender: TObject);
var
  samformat, hassent: shortint;
  ho, mi, se, ms: word;
  fileex: string;

begin

  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or (fileex = 'FLAC') or
    (fileex = 'mp3') or (fileex = 'MP3') then
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

        Inputindex1 := uos_AddFromFile(theplayer, PChar(ansistring(historyfn.Value)), -1, samformat, 1024);

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
          uos_InputGetChannels(theplayer, Inputindex1), samformat, 1024);

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
      (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5 , (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);
         /// Set volume
        ////////// Playerindex1 : Index of a existing Player
        ////////// Inputindex1 : InputIndex of a existing Input
        ////////// VolLeft : Left volume
        ////////// VolRight : Right volume
        ////////// Enable : Enabled

     {
   DSPindex1 := uos_InputAddDSP(Playerindex1, Inputindex1, @DSPReverseBefore,   @DSPReverseAfter, nil, nil);
      ///// add a custom DSP procedure for input
    ////////// Playerindex1 : Index of a existing Player
    ////////// Inputindex1: InputIndex of existing input
    ////////// BeforeFunc : function to do before the buffer is filled
    ////////// AfterFunc : function to do after the buffer is filled
    ////////// EndedFunc : function to do at end of thread
    ////////// LoopProc : external procedure to do after the buffer is filled

   //// set the parameters of custom DSP
   uos_InputSetDSP(Playerindex1, Inputindex1, DSPindex1, checkbox1.value);

   // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
   DSPindex1 := uos_InputAddDSP(Playerindex1, Inputindex1, nil, @DSPStereo2Mono, nil, nil);
    uos_InputSetDSP(Playerindex1, Inputindex1, DSPindex1, chkstereo2mono.value);

   ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
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

        tottime := uos_InputlengthTime(theplayer, Inputindex1);
        ////// Length of input in time

        DecodeTime(tottime, ho, mi, se, ms);

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

        theplaying1 := historyfn.Value;

        with commanderfo do
        begin
          btnStop.Enabled := True;
          btnresume.Enabled := False;
          if cbloop.Value = True then
          begin
            btnPause.Enabled := False;
          end
          else
          begin
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
          if cbloop.Value = True then
          begin
            uos_Play(theplayer, -1);
            btnpause.Enabled := False;
          end
          else
          begin
            uos_Play(theplayer);  /////// everything is ready, here we are, lets play it...
            btnpause.Enabled := True;
          end;
          tstringdisp1.face.template := mainfo.tfacegreen;
          tstringdisp1.Value := 'Playing ' + theplaying1;
        end;

        if hassent = 1 then  /// cue
        begin
          iscue1 := True;
          btnresume.Enabled := True;

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
        Timerwait.Enabled := False;
        Timerwait.Enabled := True;
        lposition.face.template := mainfo.tfaceplayerrev;

        oninfowav(Sender);

      end
      else
        ShowMessage(historyfn.Value + ' cannot load...');

    end
    else
   //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
  end
  else
    ShowMessage(historyfn.Value + ' is not a audio file...');
end;

procedure tsongplayerfo.doplayeresume(const Sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;

  with commanderfo do
  begin
    btnStop.Enabled := True;
    btnPause.Enabled := True;
    btnresume.Enabled := False;
  end;

  uos_RePlay(theplayer);

  iscue1 := False;

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template := mainfo.tfaceplayerrev;
  tstringdisp1.Value := 'Playing ' + theplaying1;
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
  with commanderfo do
  begin
    vuLeft.Visible := False;
    vuRight.Visible := False;
    vuright.Height := 0;
    vuleft.Height := 0;
    btnStop.Enabled := True;
    btnPause.Enabled := False;
    btnresume.Enabled := True;
  end;

  uos_Pause(theplayer);

  tstringdisp1.face.template := mainfo.tfacered;
  lposition.face.template := mainfo.tfaceplayer;
  tstringdisp1.Value := 'Paused ' + theplaying1;
end;

procedure tsongplayerfo.doplayerstop(const Sender: TObject);
begin
  hasmixed1 := True;
  uos_Stop(theplayer);
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

    timersent.Enabled := False;
    timersent.Enabled := True;

{
if  (linkvol.value = true) then
begin
if (trealspinedit(sender).tag = 0)
then edvolright.value := edvolleft.value else
edvolleft.value := edvolright.value
end;
}

    uos_InputSetDSPVolume(theplayer, Inputindex1,
      (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5 , (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);

  end;
end;

procedure tsongplayerfo.onreset(const Sender: TObject);
begin
  edtempo.Value := 1;
end;

procedure tsongplayerfo.paintsliderimage(const canvas: tcanvas; const arect: rectty);
var

  poswav, poswav2: pointty;
  poswavx: integer;
begin

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

        if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6)
        else
          canvas.drawline(poswav, poswav2, $6A6A6A);

        poswav.y := (trackbar1.Height div 2);

        poswav2.y := poswav.y + (round((waveformdata1[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

        if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6)
        else
          canvas.drawline(poswav, poswav2, $8A8A8A);

      end;
      if chan1 = 1 then
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
  if (waveformcheck.Value = True) then
  begin
    waveformdata1 := uos_InputGetArrayLevel(theplayerinfo, 0);
    iswav := True;
    DrawWaveForm();
  end;
end;

procedure tsongplayerfo.DrawWaveForm();
const
  transpcolor = cl_magenta;
var
  rect1: rectty;
begin
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
  //  end;
end;

procedure tsongplayerfo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  hassent: shortint;
  ho, mi, se, ms: word;
  fileex: string;

begin

  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or (fileex = 'FLAC') or
    (fileex = 'mp3') or (fileex = 'MP3') then
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
            uos_InputSetArrayLevelEnable(theplayerinfo, 0, 2);
            ///////// set level calculation (default is 0)
            // 0 => no calcul
            // 1 => calcul before all DSP procedures.
            // 2 => calcul after all DSP procedures.

            //// determine how much frame will be designed
            framewanted1 := Inputlength1 div (trackbar1.Width - 7);

            uos_InputSetFrameCount(theplayerinfo, 0, framewanted1);

            ///// Assign the procedure of object to execute at end of stream
            uos_EndProc(theplayerinfo, @GetWaveData);

            uos_Play(theplayerinfo);  /////// everything is ready, here we are, lets do it...

          end;

        end
        else
          ShowMessage(historyfn.Value + ' cannot load...');
    end
    else
   //   ShowMessage(historyfn.Value + ' does not exist or not mounted...');
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
    temptime := tottime * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
  end;

end;

procedure tsongplayerfo.visiblechangeev(const Sender: TObject);
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
  mainfo.updatelayout();
end;

procedure tsongplayerfo.onplayercreate(const Sender: TObject);
var
  ordir: string;
begin

  Caption := 'Song Player 1';
  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 250000;
  Timerwait.Enabled := False;
  Timerwait.ontimer := @ontimerwait;

  Timersent := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.ontimer := @ontimersent;

  if plugsoundtouch = False then
  begin
    edtempo.Visible := False;
    cbtempo.Visible := False;
    Button1.Visible := False;
    tstringdisp2.left := 377;
    tstringdisp2.top := 64;
    waveformcheck.left := 325;
  end;

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if songdir.Value = '' then
    songdir.Value := ordir + 'sound' + directoryseparator + 'song' + directoryseparator + 'test.ogg';

  // if historyfn.value = '' then
  // historyfn.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';

  songplayerfo.historyfn.Value := songplayerfo.songdir.Value;

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
  thesender := 0;
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

  if (commanderfo.automix.Value = true) then
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

procedure tsongplayerfo.changeloop(const Sender: TObject);
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

procedure tsongplayerfo.onchachewav(const Sender: TObject);
begin
  DrawWaveForm();
end;

procedure tsongplayerfo.onsetvalvol(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
if (trealspinedit(Sender).tag = 9) then
begin
if avalue > 2 then
begin
hintlabel.caption := '"' +inttostr(trunc(avalue)) + '" is > 2.  Reset to 2.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
 avalue := 2;
end; 
 
if avalue < 0.4 then begin
hintlabel.caption := '" " is invalid value.  Reset to 0.4';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
avalue := 0.4;
end; 
end
else
begin

if avalue > 100 then
begin
hintlabel.caption := '"' +inttostr(trunc(avalue)) + '" is > 100.  Reset to 100.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
 avalue := 100;
end; 
 
if avalue < 0 then begin
hintlabel.caption := '" " is invalid value.  Reset to 0.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
avalue := 0;
end; 
end;
end;

procedure tsongplayerfo.ontextedit(const sender: tcustomedit;
               var atext: msestring);
begin
if (isnumber(atext)) or (atext = '') or (atext = '-') then else
begin
 hintlabel.caption := '"' + atext + '" is invalid value.  Reset to 100.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
 atext := '100';
end;
end;

end.
