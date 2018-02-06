unit songplayer2;

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
  tsongplayer2fo = class(tdockform)
    Timerwait: Ttimer;
    Timersent: Ttimer;

    tgroupbox1: tgroupbox;
    edvolleft: trealspinedit;
    edtempo: trealspinedit;
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
   button2: tbutton;
   button1: tbutton;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1();
    procedure showposition();
    procedure showlevel();
    procedure LoopProcPlayer1();
    procedure oninfowav(const Sender: TObject);
    procedure onreset(const Sender: TObject);
    procedure ongetbpm(const Sender: TObject);
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
    procedure onchangwav(const Sender: TObject);
    procedure onsetvalvol(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure ontextedit(const sender: tcustomedit;
               var atext: msestring);
  protected
    procedure paintsliderimage(const canvas: tcanvas; const arect: rectty);
  end;

var
  songplayer2fo: tsongplayer2fo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  theplayer2: integer = 22;
  theplayerinfo2: integer = 23;
  theplaying2: string;
  iscue2: boolean = False;
  iswav2: boolean = False;
  hasmixed2: boolean = False;
  hasfocused2: boolean = False;
  plugindex2, PluginIndex3: integer;
  Inputindex2, Outputindex2, Inputlength2: integer;
  poswav2, chan2, framewanted2: integer;
  waveformdata2: array of cfloat;



implementation

uses
  main, commander, config, filelistform, drums,
  songplayer2_mfm;

procedure tsongplayer2fo.ontimersent(const Sender: TObject);
begin
  timersent.Enabled := False;
  hintpanel.visible := false;
  historyfn.face.template := mainfo.tfaceplayerlight;
  edvolleft.face.template := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template := mainfo.tfaceplayer;
  button1.face.template := mainfo.tfaceplayer;
  button2.face.template := mainfo.tfaceplayer;
end;

procedure tsongplayer2fo.ontimerwait(const Sender: TObject);
begin
  timerwait.Enabled := False;
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
      btnresume2.Enabled := True
    else
      btnresume2.Enabled := False;
  end;

  if (cbloop.Value = False) and (iscue2 = False) then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;

  if iscue2 then
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

procedure tsongplayer2fo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if hasinit = 1 then
  begin

    if (trim(PChar(ansistring(songplayer2fo.historyfn.Value))) <> '') and fileexists(ansistring(songplayer2fo.historyfn.Value)) then
    begin

      if cbtempo.Value = True then
      begin
        edtempo.face.template := mainfo.tfaceorange;
        timersent.Enabled := False;
        timersent.Enabled := True;
      end;

      uos_SetPluginSoundTouch(theplayer2, PluginIndex3, edtempo.Value, 1, cbtempo.Value);

    end;
  end;
end;


procedure tsongplayer2fo.ClosePlayer1();
begin

  if (commanderfo.automix.Value = true) and (hasmixed2 = False) then
  begin
    hasmixed2 := True;
    commanderfo.onstartstop(nil);
    hasfocused2 := True;
    filelistfo.onsent(nil);
    hasfocused2 := False;
    hasmixed2 := False;
  end;

  vuright.Value := 0;
  vuleft.Value := 0;
  vuLeft.Visible := False;
  vuRight.Visible := False;
  
  button2.Caption := 'BPM';
  
  theplaying2 := '';

  btnStart.Enabled := True;
  btnStop.Enabled := False;
  btnPause.Enabled := False;
  btnresume.Enabled := False;

  hasmixed2 := False;

  if cbloop.Value then
    btncue.Enabled := False
  else
    btncue.Enabled := True;

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

  cbloop.Enabled := True;
  trackbar1.Value := 0;
  trackbar1.Enabled := False;
  lposition.Value := '00:00:00.000';
  lposition.face.template := mainfo.tfaceplayer;

  if uos_GetStatus(theplayer2) <> 1 then
  begin
    tstringdisp1.Value := '';
    tstringdisp1.face.template := mainfo.tfaceplayer;
  end;

  iswav2 := False;
  iscue2 := False;

  trackbar1.Visible := False;
  trackbar1.Visible := True;
  DrawWaveForm();
end;


procedure tsongplayer2fo.ShowLevel();
var
  leftlev, rightlev: double;
begin

  vuLeft.Visible := True;
  vuRight.Visible := True;

  if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
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
  //{

  if (leftlev >= 0) and (leftlev < 1) then
  begin
    if leftlev < 0.80 then
    begin
      vuLeft.bar_face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft2.bar_face.template := mainfo.tfacegreen;
    end
    else
    if leftlev < 0.90 then
    begin
      vuLeft.bar_face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft2.bar_face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuLeft.bar_face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuLeft2.bar_face.template := mainfo.tfacered;
    end;
    vuLeft.Value := leftlev;
    if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
      commanderfo.vuLeft2.Value := leftlev;
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin

    if rightlev < 0.80 then
    begin
      vuRight.bar_face.template := mainfo.tfacegreen;

      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight2.bar_face.template := mainfo.tfacegreen;
    end
    else
    if rightlev < 0.90 then
    begin
      vuRight.bar_face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight2.bar_face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuRight.bar_face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
        commanderfo.vuRight2.bar_face.template := mainfo.tfacered;
    end;
    vuright.Value := rightlev;
    if (commanderfo.Visible) and (commanderfo.vuin.value = true) then
      commanderfo.vuright2.Value := rightlev;
  end;

end;

procedure tsongplayer2fo.ShowPosition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
  mixtime: integer;
begin

  if not TrackBar1.clicked then
  begin
    if uos_InputPosition(theplayer2, Inputindex2) > 0 then
    begin
      TrackBar1.Value := uos_InputPosition(theplayer2, Inputindex2) / Inputlength2;
      temptime := uos_InputPositionTime(theplayer2, Inputindex2);
      ////// Length of input in time
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      mixtime := trunc(commanderfo.timemix.Value * 1000) + 100000;
      if mixtime < 150000 then
        mixtime := 150000;
      if Inputlength2 < mixtime + 50000 then
        mixtime := Inputlength2 - 50000;
      if (commanderfo.automix.Value = true) and (hasmixed2 = False) and (uos_InputPosition(theplayer2, Inputindex2) >
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

procedure tsongplayer2fo.LoopProcPlayer1();
begin
  ShowPosition();
  ShowLevel();
end;



procedure tsongplayer2fo.doplayerstart(const Sender: TObject);
var
  samformat, hassent: shortint;
  ho, mi, se, ms: word;
  fileex: string;

begin

  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or (fileex = 'FLAC') or
    (fileex = 'mp3') or (fileex = 'MP3') then
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

        Inputindex2 := uos_AddFromFile(theplayer2, PChar(ansistring(historyfn.Value)), -1, samformat, 1024);

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
          uos_InputGetChannels(theplayer2, Inputindex2), samformat, 1024, -1);

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

     {
   DSPindex2 := uos_InputAddDSP(Playerindex2, Inputindex2, @DSPReverseBefore,   @DSPReverseAfter, nil, nil);
      ///// add a custom DSP procedure for input
    ////////// Playerindex2 : Index of a existing Player
    ////////// Inputindex2: InputIndex of existing input
    ////////// BeforeFunc : function to do before the buffer is filled
    ////////// AfterFunc : function to do after the buffer is filled
    ////////// EndedFunc : function to do at end of thread
    ////////// LoopProc : external procedure to do after the buffer is filled

   //// set the parameters of custom DSP
   uos_InputSetDSP(Playerindex2, Inputindex2, DSPindex2, checkbox1.value);

   // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
   DSPindex2 := uos_InputAddDSP(Playerindex2, Inputindex2, nil, @DSPStereo2Mono, nil, nil);
    uos_InputSetDSP(Playerindex2, Inputindex2, DSPindex2, chkstereo2mono.value);

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

        tottime := uos_InputlengthTime(theplayer2, Inputindex2);
        ////// Length of input in time

        DecodeTime(tottime, ho, mi, se, ms);

        llength.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

        uos_EndProc(theplayer2, @ClosePlayer1);

        /////// procedure to execute when stream is terminated
        ///// Assign the procedure of object to execute at end
        //////////// PlayerIndex : Index of a existing Player
        //////////// ClosePlayer1 : procedure of object to execute inside the general loop

        btinfos.Enabled := True;

        trackbar1.Value := 0;
        trackbar1.Enabled := True;

        theplaying2 := historyfn.Value;

        with commanderfo do
        begin
          btnStop2.Enabled := True;
          btnresume2.Enabled := False;
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
          if cbloop.Value = True then
          begin
            uos_Play(theplayer2, -1);
            btnpause.Enabled := False;
          end
          else
          begin
            uos_Play(theplayer2);  /////// everything is ready, here we are, lets play it...
            btnpause.Enabled := True;
          end;
          tstringdisp1.face.template := mainfo.tfacegreen;
          tstringdisp1.Value := 'Playing ' + theplaying2;
        end;

        if hassent = 1 then  /// cue
        begin
          // writeln('tbutton(sender).tag = 1');
          iscue2 := True;
          btnresume.Enabled := True;

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

procedure tsongplayer2fo.doplayeresume(const Sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;

  with commanderfo do
  begin
    btnStop2.Enabled := True;
    btnPause2.Enabled := True;
    btnresume2.Enabled := False;
  end;

  uos_RePlay(theplayer2);
  iscue2 := False;

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template := mainfo.tfaceplayerrev;
  tstringdisp1.Value := 'Playing ' + theplaying2;
end;

procedure tsongplayer2fo.doplayerpause(const Sender: TObject);
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
    vuLeft2.Visible := False;
    vuRight2.Visible := False;
    vuright2.Height := 0;
    vuleft2.Height := 0;
    btnStop2.Enabled := True;
    btnPause2.Enabled := False;
    btnresume2.Enabled := True;
  end;

  uos_Pause(theplayer2);

  tstringdisp1.face.template := mainfo.tfacered;
  lposition.face.template := mainfo.tfaceplayer;
  tstringdisp1.Value := 'Paused ' + theplaying2;
end;

procedure tsongplayer2fo.doplayerstop(const Sender: TObject);
begin
  hasmixed2 := True;
  uos_Stop(theplayer2);
end;

procedure tsongplayer2fo.changevolume(const Sender: TObject);
begin
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

    uos_InputSetDSPVolume(theplayer2, Inputindex2,
  (edvolleft.Value / 100) * commanderfo.genvolleft.Value * 1.5, (edvolright.Value / 100) * commanderfo.genvolright.Value * 1.5, True);      

  end;
end;

procedure tsongplayer2fo.onreset(const Sender: TObject);
begin
 edtempo.Value := 1;
  button1.face.template := mainfo.tfaceorange;
 
  timersent.Enabled := False;
  timersent.Enabled := True
end; 

procedure tsongplayer2fo.ongetbpm(const Sender: TObject);
var
 thebuffer : TDArFloat;
 thebufferinfos : TuosF_BufferInfos;
 thebpm : float;
begin
//   {$if defined(linux)}
             if plugsoundtouch = true then
             begin
             if btncue.enabled = true then btncue.onexecute(sender);
             
             if fileexists(theplaying2) then 
             begin
                     
             thebuffer :=  uos_File2Buffer(PChar(ansistring(theplaying2)), 0,
              thebufferinfos, uos_InputPosition(theplayer2, Inputindex2), 1024);
        
            //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer))); 
             thebpm := uos_GetBPM(thebuffer,thebufferinfos.channels,thebufferinfos.samplerate);
             if thebpm = 0 then button2.Caption := 'BPM'
             else begin
             button2.Caption := inttostr(round(thebpm));
             drumsfo.edittempo.value := round(thebpm);
              button2.face.template := mainfo.tfaceorange;
 
             timersent.Enabled := False;
             timersent.Enabled := True
             end;
             end;
             end;  
//     {$ENDIF}
 
end;

procedure tsongplayer2fo.paintsliderimage(const canvas: tcanvas; const arect: rectty);
var

  poswav, poswav2: pointty;
  poswavx: integer;
begin
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

        if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC99D6)
        else
          canvas.drawline(poswav, poswav2, $6A6A6A);

        poswav.y := (trackbar1.Height div 2);

        poswav2.y := poswav.y + (round((waveformdata2[(poswavx * 2) + 1]) * ((trackbar1.Height div 2) - 3)));

        if mainfo.typecolor.Value = 0 then
          canvas.drawline(poswav, poswav2, $AC79D6)
        else
          canvas.drawline(poswav, poswav2, $8A8A8A);

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

procedure tsongplayer2fo.GetWaveData();
begin
  if (waveformcheck.Value = True) then
  begin
    waveformdata2 := uos_InputGetLevelArray(theplayerinfo2, 0);
    iswav2 := True;
    DrawWaveForm();
  end;
end;

procedure tsongplayer2fo.DrawWaveForm();
const
  transpcolor = cl_magenta;
var
  rect1: rectty;
begin
  // if (waveformcheck.value = true) then begin
  trackbar1.invalidate();
  //  writeln(inttostr(length(waveformdata2)));
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
    // end;
  end;
end;

procedure tsongplayer2fo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  hassent: shortint;
  temptimeinfo: ttime;
  ho, mi, se, ms: word;
  fileex: string;
  thebuffer : TDArFloat;
  thebufferinfos : TuosF_BufferInfos;

begin

  fileex := fileext(PChar(ansistring(historyfn.Value)));

  if (fileex = 'wav') or (fileex = 'WAV') or (fileex = 'ogg') or (fileex = 'OGG') or (fileex = 'flac') or (fileex = 'FLAC') or
    (fileex = 'mp3') or (fileex = 'MP3') then
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
            
            infosfo.infobpm.Caption :='';
            
          //   {$if defined(linux)}
             if plugsoundtouch = true then
             begin
                     
             thebuffer :=  uos_File2Buffer(PChar(ansistring(historyfn.Value)), 0, thebufferinfos, -1, 1024*2);
        
            //  writeln('length(thebuffer) = ' + inttostr(length(thebuffer))); 
    
             infosfo.infobpm.Caption :='BPM: ' + floattostr((uos_GetBPM(thebuffer,thebufferinfos.channels,thebufferinfos.samplerate)));;
             
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
            framewanted2 := Inputlength2 div (trackbar1.Width - 7);

            uos_InputSetFrameCount(theplayerinfo2, 0, framewanted2);

            ///// Assign the procedure of object to execute at end of stream
            uos_EndProc(theplayerinfo2, @GetWaveData);

            uos_Play(theplayerinfo2);  /////// everything is ready, here we are, lets do it...

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

procedure tsongplayer2fo.onsliderchange(const Sender: TObject);
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

procedure tsongplayer2fo.visiblechangeev(const Sender: TObject);
begin

  if Visible then
  begin
    mainfo.tmainmenu1.menu[1].submenu[5].Caption := ' Hide Player 2 ';
  end
  else
  begin
    uos_Stop(theplayer2);
    mainfo.tmainmenu1.menu[1].submenu[5].Caption := ' Show Player 2 ';
  end;
  mainfo.updatelayout();
end;

procedure tsongplayer2fo.onplayercreate(const Sender: TObject);
var
  ordir: string;
begin

  Caption := 'Song Player 2';
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
    Button2.Visible := False;
    tstringdisp2.left := 377;
    tstringdisp2.top := 64;
    waveformcheck.left := 325;
  end;

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if songdir.Value = '' then
    songdir.Value := ordir + 'sound' + directoryseparator + 'song' + directoryseparator + 'test.ogg';

  // if historyfn.value = '' then
  // historyfn.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';

  songplayer2fo.historyfn.Value := songplayer2fo.songdir.Value;

end;

procedure tsongplayer2fo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
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

procedure tsongplayer2fo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 1;
end;

procedure tsongplayer2fo.ondestr(const Sender: TObject);
begin
  Timerwait.Free;
  timersent.Free;
end;

procedure tsongplayer2fo.changevol(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  changevolume(Sender);
end;

procedure tsongplayer2fo.oncreated(const Sender: TObject);
begin
  // tstringdisp1.left := 3 ; // if not left := 0 ?
end;

procedure tsongplayer2fo.faceafterpaintbut(const Sender: tcustomface; const canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  canvas.drawline(point1, point2, cl_red);

end;

procedure tsongplayer2fo.onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
var
  mixtime: integer;
  dopos: boolean = False;
begin
  onsliderchange(Sender);

  if (commanderfo.automix.Value = true) then
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

procedure tsongplayer2fo.changeloop(const Sender: TObject);
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

procedure tsongplayer2fo.onchangwav(const Sender: TObject);
begin
  DrawWaveForm();
end;

procedure tsongplayer2fo.onsetvalvol(const sender: TObject; var avalue: realty;
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

procedure tsongplayer2fo.ontextedit(const sender: tcustomedit;
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
