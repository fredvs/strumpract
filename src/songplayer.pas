unit songplayer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes, uos_flat, infos, msetimer, msetypes, mseglob, mseguiglob, mseguiintf,
 mseapplication, msestat, msemenus, msegui, msegraphics, msegraphutils,mseevent,
 mseclasses, mseforms, msedock, msesimplewidgets, msewidgets,msedataedits,
 msefiledialog, msegrids, mselistbrowser, msesys, SysUtils,msegraphedits,
 msedragglob, mseact, mseedit, mseificomp, mseificompglob,mseifiglob,
 msestatfile,msestream, msestrings, msescrollbar, msebitmap,msedatanodes,
 msedispwidgets,mserichstring;

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
    vuLeft: tgroupbox;
    vuRight: tgroupbox;
   tfaceslider: tfacecomp;
   btinfos: tbutton;
   BtnCue: tbutton;
   
   tfacebuttonslider: tfacecomp;
   tfacegreen: tfacecomp;
   waveformcheck: tbooleanedit;
   tstringdisp2: tstringdisp;
    procedure doplayerstart(const Sender: TObject);
    procedure doplayeresume(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doplayerstop(const Sender: TObject);
    procedure ClosePlayer1;
    procedure showposition;
    procedure showlevel;
    procedure LoopProcPlayer1;
    procedure oninfowav(const Sender: TObject);
    procedure onreset(const Sender: TObject);

    procedure changepos(const Sender: TObject; var avalue: realty; var accept: boolean);
    procedure changevolume(const Sender: TObject);

    procedure doentertrackbar(const Sender: TObject);
    procedure ChangePlugSetSoundTouch(const Sender: TObject);
    procedure onmouseslider(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onsliderkeydown(const Sender: twidget; var ainfo: keyeventinfoty);
    procedure onsliderkeyup(const Sender: twidget; var ainfo: keyeventinfoty);
    procedure onsliderchange(const Sender: TObject);
    procedure ontimerwait(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplayercreate(const Sender: TObject);
    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty;
      var aresult: modalresultty);
    procedure ondestr(const Sender: TObject);
    procedure changevol(const Sender: TObject; var avalue: realty; var accept: boolean);
    procedure oncreated(const Sender: TObject);
   procedure faceafterpaintbut(const sender: tcustomface; const canvas: tcanvas;
                   const arect: rectty);
   procedure faceafterpaint(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
   procedure faceafterpaintgreen(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
   procedure onafterev(const sender: tcustomscrollbar;
                   const akind: scrolleventty; const avalue: Real);
   procedure changeloop(const sender: TObject);
   procedure DrawWaveForm();
  end;

var
  songplayerfo: tsongplayerfo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  theplayer: integer = 20;
  theplayerinfo: integer = 21;
  theplaying1: string;
  iscue1 : boolean = false;
  iswav : boolean = false;
  plugindex1, PluginIndex2: integer;
  Inputindex1, Outputindex1, Inputlength1: integer;
  poswav1, chan1, framewanted1: integer;
  waveformdata1: array of cfloat;



implementation

uses
  main, commander,
  songplayer_mfm;

procedure tsongplayerfo.ontimersent(const Sender: TObject);
begin
  timersent.Enabled := False;
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
  btncue.Enabled := false;

  with commanderfo do
  begin
     btncue.Enabled := false;
    btnStart.Enabled := True;
    btnStop.Enabled := True;
    if (cbloop.Value = False) and (iscue1 = false) then
      btnPause.Enabled := True
    else
      btnPause.Enabled := False;
    if iscue1 then btnresume.Enabled := true else btnresume.Enabled := False;
  end;

   if (cbloop.Value = False) and (iscue1 = false) then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;
    
    if iscue1 then begin
  btnresume.Enabled := true;
  
  end else
  begin
  btnresume.Enabled := false;
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


procedure tsongplayerfo.ClosePlayer1;
begin
  {
    radiobutton1.Enabled := True;
    radiobutton2.Enabled := True;
    radiobutton3.Enabled := True;
    }


  vuright.Height := 0;
  vuleft.Height := 0;
  vuLeft.Visible := False;
  vuRight.Visible := False;

  btnStart.Enabled := True;
  btnStop.Enabled := False;
  btnPause.Enabled := False;
  btnresume.Enabled := False;
  if cbloop.value then
  btncue.Enabled := false else btncue.Enabled := true;

  with commanderfo do
  begin
  if cbloop.value then
  btncue.Enabled := false else btncue.Enabled := true;
    btncue.Enabled := True;
    btnStart.Enabled := True;
    btnStop.Enabled := False;
    btnPause.Enabled := False;
    btnresume.Enabled := False;
    vuright.Height := 0;
    vuleft.Height := 0;
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

iswav := false;
  
  trackbar1.visible := false;
  trackbar1.visible := true;

end;

procedure tsongplayerfo.ShowLevel;
var
  leftlev, rightlev: double;
begin

  vuLeft.Visible := True;
  vuRight.Visible := True;

  if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
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
      vuLeft.face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuLeft.face.template := mainfo.tfacegreen;
    end
    else
    if leftlev < 0.90 then
    begin
      vuLeft.face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuLeft.face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuLeft.face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuLeft.face.template := mainfo.tfacered;
    end;
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin

    if rightlev < 0.80 then
    begin
      vuRight.face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuRight.face.template := mainfo.tfacegreen;
    end
    else
    if rightlev < 0.90 then
    begin
      vuRight.face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuRight.face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuRight.face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
        commanderfo.vuRight.face.template := mainfo.tfacered;
    end;
  end;

  //}
  if (leftlev >= 0) and (leftlev < 1) then
  begin
    vuLeft.Height := trunc(leftlev * 30);
    if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
      commanderfo.vuLeft.Height := trunc(leftlev * 120);
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin
    vuRight.Height := trunc(rightlev * 30);
    if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
      commanderfo.vuRight.Height := trunc(rightlev * 120);
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin
    vuRight.top := 78 - vuRight.Height;
  end;

  if (leftlev >= 0) and (leftlev < 1) then
  begin
    vuLeft.top := 78 - vuLeft.Height;
  end;

  if (commanderfo.Visible) and (commanderfo.vuin.tag = 0) then
  begin
    if (rightlev >= 0) and (rightlev < 1) then
      commanderfo.vuRight.top := 124 - commanderfo.vuRight.Height;
    if (leftlev >= 0) and (leftlev < 1) then
      commanderfo.vuLeft.top := 124 - commanderfo.vuLeft.Height;
  end;

end;

procedure tsongplayerfo.ShowPosition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
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
    end;
  end;

end;

procedure tsongplayerfo.LoopProcPlayer1;
begin
  ShowPosition;
  ShowLevel;
end;

procedure tsongplayerfo.doplayerstart(const Sender: TObject);
var
  samformat: shortint;
  ho, mi, se, ms: word;
begin

  if fileexists(historyfn.Value) then
  begin
    samformat := 0;

    //  songdir.hint := songdir.value;


    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...
    //  hasbegin := true;
    //  hasbegin := true;
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
      Outputindex1 := uos_AddIntoDevOut(theplayer, -1, -1, uos_InputGetSampleRate(theplayer, Inputindex1),
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

      uos_InputSetDSPVolume(theplayer, Inputindex1, edvolleft.Value / 100, edvolright.Value / 100, True);
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
         
     if (tbutton(sender).tag = 0) or (tbutton(sender).tag = 2)
      then
     begin
     iscue1 := false;
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
      
       if (tbutton(sender).tag = 1) or (tbutton(sender).tag = 3) then  /// cue
     begin
     iscue1 := true;
       btnresume.Enabled := true;
      
      if cbloop.Value = True then
      begin
        uos_Play(theplayer, -1);
        btnpause.Enabled := False;
      end
      else
      begin
        uos_Play(theplayer);  /////// everything is ready, here we are, lets play it...
        btnpause.Enabled := false;
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

      oninfowav(sender);

    end
    else
      ShowMessage(historyfn.Value + ' cannot load...');

  end
  else
    ShowMessage(historyfn.Value + ' does not exist...');
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
  uos_Stop(theplayer);

end;

procedure tsongplayerfo.changepos(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  if accept then
    uos_InputSeek(theplayer, Inputindex1, trunc(avalue * Inputlength1));
  //  TrackBar1.Tag := 0;

end;

procedure tsongplayerfo.changevolume(const Sender: TObject);
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

    uos_InputSetDSPVolume(theplayer, Inputindex1,
      edvolleft.Value / 100, edvolright.Value / 100, True);

  end;
end;

procedure tsongplayerfo.doentertrackbar(const Sender: TObject);
begin
  songplayerfo.trackbar1.tag := 1;
end;

procedure tsongplayerfo.onreset(const Sender: TObject);
begin
  songplayerfo.edtempo.Value := 1;
end;

procedure tsongplayerfo.DrawWaveForm();
  begin
     waveformdata1 := uos_InputGetArrayLevel(theplayerinfo, 0);
    iswav := true;
    trackbar1.hide;
    trackbar1.show;
 //  writeln(inttostr(length(waveformdata1)));
  end;

procedure tsongplayerfo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  ho, mi, se, ms: word;
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
       
        if tbutton(sender).tag = 9 then
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
        end else
        
        
        if (waveformcheck.value = true) then  
           begin
        
        iswav := false;
        
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
    uos_EndProc(theplayerinfo, @DrawWaveForm);

    uos_Play(theplayerinfo);  /////// everything is ready, here we are, lets do it...

        end;
        
      end
      else
        ShowMessage(historyfn.Value + ' cannot load...');
  end
  else
    ShowMessage(historyfn.Value + ' does not exist...');
end;


procedure tsongplayerfo.onmouseslider(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if ainfo.eventkind = ek_buttonpress then
    trackbar1.tag := 1
  else
  if ainfo.eventkind = ek_buttonrelease then
    trackbar1.tag := 0;
end;


procedure tsongplayerfo.onsliderkeydown(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 1;
end;

procedure tsongplayerfo.onsliderkeyup(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 0;
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
     mainfo.tmainmenu1.menu[3].submenu[4].caption := ' Hide Player 1 ' ;
  end
  else
  begin
    uos_Stop(theplayer);
     mainfo.tmainmenu1.menu[3].submenu[4].caption := ' Show Player 1 ' ;
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
  Timersent.interval := 1500000;
  Timersent.Enabled := False;
  Timersent.ontimer := @ontimersent;

  if plugsoundtouch = False then
  begin
    edtempo.Enabled := False;
    cbtempo.Enabled := False;
    Button1.Enabled := False;
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
  // tstringdisp1.left := 3 ; // if not left := 0 ?
end;

procedure tsongplayerfo.faceafterpaintbut(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
 var
 point1, point2 : pointty;              
begin
point1.x := arect.x + (arect.cx div 2) ;
point1.y := 0;
point2.x := point1.x;
point2.y := arect.cy;
                         
canvas.drawline(point1,point2,cl_red);                        
                  
end;

procedure tsongplayerfo.faceafterpaint(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
 var
 poswav, poswav2 : pointty;              
begin
if (hasinit= 1) and (iswav = true) and (waveformcheck.value = true) then begin

poswav.x :=0 ;
poswav.y := (trackbar1.height div 2) -2;

poswav2.x :=0 ;
poswav2.y := ((arect.cy div 2) -2) - round(
            (waveformdata1[poswav.x*2 ]) * ((trackbar1.height div 2) -3)) ;

      while poswav.x < (length(waveformdata1) div chan1 )  do
      begin
        if chan1 = 2 then
        begin
       poswav.y := (trackbar1.height div 2) -2 ;  
      poswav2.x :=poswav.x ;
      poswav2.y := ((arect.cy div 2) -1) - round(
            (waveformdata1[poswav.x *2]) * ((arect.cy div 2) -3)) ;
        
    //  canvas.drawline(poswav,poswav2,$AC94D6); 
      
      canvas.drawline(poswav,poswav2,cl_red);
      
      poswav.y := (trackbar1.height div 2) ;
       
      poswav2.y := poswav.y  + ( round(
            (waveformdata1[(poswav.x *2)+1]) * ((trackbar1.height div 2) -3))) ;
      
      canvas.drawline(poswav,poswav2,$AC25D6); 

       end;
        if chan1 = 1 then
        begin
         // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1) - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
       Inc(poswav.x,1) ;
      end;
      
 end;                     
end;


procedure tsongplayerfo.faceafterpaintgreen(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
 var
 
 poswav, poswav2 : pointty;  
 poswavx : integer;            
begin
if (iswav = true) and (waveformcheck.value = true) then begin

poswav.x :=6 ;
poswav.y := (trackbar1.height div 2) -2;


poswav2.x :=6 ;
poswav2.y := ((arect.cy div 2) -2) - round(
            (waveformdata1[poswav.x*2 ]) * ((trackbar1.height div 2) -3)) ;

      while poswav.x < length(waveformdata1) div chan1 do
      begin
        if chan1 = 2 then
        begin
       poswav.y := (trackbar1.height div 2) -2 ;  
      poswav2.x :=poswav.x ;
      poswavx := poswav.x -6;
      poswav2.y := ((arect.cy div 2) -1) - round(
            (waveformdata1[poswavx *2]) * ((arect.cy div 2) -3)) ;
              canvas.drawline(poswav,poswav2,$AC99D6); 
      
      poswav.y := (trackbar1.height div 2) ;
       
      poswav2.y := poswav.y  + ( round(
            (waveformdata1[(poswavx *2)+1]) * ((trackbar1.height div 2) -3))) ;
      
      canvas.drawline(poswav,poswav2,$AC79D6); 
       
       end;
        if chan1 = 1 then
        begin
         // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1) 
         // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
       Inc(poswav.x,1) ;
      end;
         
 end;                     
end;

procedure tsongplayerfo.onafterev(const sender: tcustomscrollbar;
               const akind: scrolleventty; const avalue: Real);
begin
if TrackBar1.clicked then
    uos_InputSeek(theplayer, Inputindex1, trunc(avalue * Inputlength1));
end;

procedure tsongplayerfo.changeloop(const sender: TObject);
begin
if cbloop.value then
begin
 commanderfo.btncue.Enabled := false;
 btncue.enabled := false end else 
 begin  
 commanderfo.btncue.Enabled := True;
 btncue.enabled := true;
 end;
end;


end.
