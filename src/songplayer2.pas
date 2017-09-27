unit songplayer2;

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
  tsongplayer2fo = class(tdockform)
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
  songplayer2fo: tsongplayer2fo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  theplayer2: integer = 22;
  theplayer2info: integer = 23;
  theplaying2: string;
  iscue2 : boolean = false;
  iswav2 : boolean = false;
  plugindex2, PluginIndex3: integer;
  Inputindex2, Outputindex2, Inputlength2: integer;
  poswav2, chan2, framewanted2: integer;
  waveformdata2: array of cfloat;



implementation

uses
  main, commander,
  songplayer2_mfm;

procedure tsongplayer2fo.ontimersent(const Sender: TObject);
begin
  timersent.Enabled := False;
  historyfn.face.template := mainfo.tfaceplayerlight;
  edvolleft.face.template := mainfo.tfaceplayer;
  edvolright.face.template := mainfo.tfaceplayer;
  edtempo.face.template := mainfo.tfaceplayer;
end;

procedure tsongplayer2fo.ontimerwait(const Sender: TObject);
begin
  timerwait.Enabled := False;
  btnStart.Enabled := True;
  btnStop.Enabled := True;
  btncue.Enabled := false;

  with commanderfo do
  begin
    btnStart2.Enabled := True;
    btnStop2.Enabled := True;
    if (cbloop.Value = False) and (iscue2 = false) then
      btnPause2.Enabled := True
    else
      btnPause.Enabled := False;
    if iscue2 then btnresume2.Enabled := true else btnresume2.Enabled := False;
  end;

   if (cbloop.Value = False) and (iscue2 = false) then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;
    
    if iscue2 then begin
  btnresume.Enabled := true;
  
  end else
  begin
  btnresume.Enabled := false;
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


procedure tsongplayer2fo.ClosePlayer1;
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
  btncue.Enabled := True;

  with commanderfo do
  begin
  
    btnStart2.Enabled := True;
    btnStop2.Enabled := False;
    btnPause2.Enabled := False;
    btnresume2.Enabled := False;
    vuright2.Height := 0;
    vuleft2.Height := 0;
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
  
  iswav2 := false;
  
  trackbar1.visible := false;
  trackbar1.visible := true;

end;

procedure tsongplayer2fo.ShowLevel;
var
  leftlev, rightlev: double;
begin

  vuLeft.Visible := True;
  vuRight.Visible := True;

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
  //{

  if (leftlev >= 0) and (leftlev < 1) then
  begin
    if leftlev < 0.80 then
    begin
      vuLeft.face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuLeft2.face.template := mainfo.tfacegreen;
    end
    else
    if leftlev < 0.90 then
    begin
      vuLeft.face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuLeft2.face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuLeft.face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuLeft2.face.template := mainfo.tfacered;
    end;
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin

    if rightlev < 0.80 then
    begin
      vuRight.face.template := mainfo.tfacegreen;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuRight2.face.template := mainfo.tfacegreen;
    end
    else
    if rightlev < 0.90 then
    begin
      vuRight.face.template := mainfo.tfaceorange;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuRight2.face.template := mainfo.tfaceorange;
    end
    else
    begin
      vuRight.face.template := mainfo.tfacered;
      if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
        commanderfo.vuRight2.face.template := mainfo.tfacered;
    end;
  end;

  //}
  if (leftlev >= 0) and (leftlev < 1) then
  begin
    vuLeft.Height := trunc(leftlev * 30);
    if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
      commanderfo.vuLeft2.Height := trunc(leftlev * 120);
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin
    vuRight.Height := trunc(rightlev * 30);
    if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
      commanderfo.vuRight2.Height := trunc(rightlev * 120);
  end;

  if (rightlev >= 0) and (rightlev < 1) then
  begin
    vuRight.top := 78 - vuRight.Height;
  end;

  if (leftlev >= 0) and (leftlev < 1) then
  begin
    vuLeft.top := 78 - vuLeft.Height;
  end;

  if (commanderfo.Visible) and (commanderfo.vuin.Value = True) then
  begin
    if (rightlev >= 0) and (rightlev < 1) then
      commanderfo.vuRight2.top := 124 - commanderfo.vuRight2.Height;
    if (leftlev >= 0) and (leftlev < 1) then
      commanderfo.vuLeft2.top := 124 - commanderfo.vuLeft2.Height;
  end;

end;

procedure tsongplayer2fo.ShowPosition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
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
    end;
  end;

end;

procedure tsongplayer2fo.LoopProcPlayer1;
begin
  ShowPosition;
  ShowLevel;
end;

procedure tsongplayer2fo.doplayerstart(const Sender: TObject);
var
  samformat: shortint;
  ho, mi, se, ms: word;
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
      Outputindex2 := uos_AddIntoDevOut(theplayer2, -1, -1, uos_InputGetSampleRate(theplayer2, Inputindex2),
        uos_InputGetChannels(theplayer2, Inputindex2), samformat, 1024);
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

      uos_InputSetDSPVolume(theplayer2, Inputindex2, edvolleft.Value / 100, edvolright.Value / 100, True);
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
         
     if (tbutton(sender).tag = 0) or (tbutton(sender).tag = 2) then
     begin
   //   writeln('tbutton(sender).tag = 0');
     iscue2 := false;
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
      end;
      
       if (tbutton(sender).tag = 1)  then  /// cue
     begin
     // writeln('tbutton(sender).tag = 1');
     iscue2 := true;
       btnresume.Enabled := true;
      
      if cbloop.Value = True then
      begin
        uos_Play(theplayer2, -1);
        btnpause.Enabled := False;
      end
      else
      begin
        uos_Play(theplayer2);  /////// everything is ready, here we are, lets play it...
        btnpause.Enabled := false;
      end;
      uos_Pause(theplayer2);
       tstringdisp1.face.template := mainfo.tfaceorange;
      end;
    
      cbloop.Enabled := False;
      songdir.Value := historyfn.Value;
      historyfn.hint := historyfn.Value;
      Timerwait.Enabled := False;
      Timerwait.Enabled := True;
      lposition.face.template := mainfo.tfaceplayerrev;

      theplaying2 := historyfn.Value;
      tstringdisp1.Value := 'Playing ' + theplaying2;
   
       oninfowav(sender);

    end
    else
      ShowMessage(historyfn.Value + ' cannot load...');

  end
  else
    ShowMessage(historyfn.Value + ' does not exist...');
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

  tstringdisp1.face.template := mainfo.tfacegreen;
  lposition.face.template := mainfo.tfaceplayerrev;
  tstringdisp1.Value := 'Replaying ' + theplaying2;
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
  uos_Stop(theplayer2);

end;

procedure tsongplayer2fo.changepos(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  if accept then
    uos_InputSeek(theplayer2, Inputindex2, trunc(avalue * Inputlength2));
  //  TrackBar1.Tag := 0;

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
      edvolleft.Value / 100, edvolright.Value / 100, True);

  end;
end;

procedure tsongplayer2fo.doentertrackbar(const Sender: TObject);
begin
  songplayer2fo.trackbar1.tag := 1;
end;

procedure tsongplayer2fo.onreset(const Sender: TObject);
begin
  songplayer2fo.edtempo.Value := 1;
end;

procedure tsongplayer2fo.DrawWaveForm();
  begin
     waveformdata2 := uos_InputGetArrayLevel(theplayer2info, 0);
    iswav2 := true;
    trackbar1.hide;
    trackbar1.show;
 //  writeln(inttostr(length(waveformdata2)));
  end;

procedure tsongplayer2fo.oninfowav(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  ho, mi, se, ms: word;
begin

  if fileexists(PChar(ansistring(historyfn.Value))) then
  begin
    uos_Stop(theplayer2info);

    if uos_CreatePlayer(theplayer2info) then
      //// Create the player.
      //// PlayerIndex : from 0 to what your computer can do !
      //// If PlayerIndex exists already, it will be overwriten...

      if uos_AddFromFile(theplayer2info, PChar(ansistring(historyfn.Value)), -1, 2, -1) > -1 then
      begin
          Inputlength2 := uos_Inputlength(theplayer2, 0);
         ////// Length of Input in samples
       
        if tbutton(sender).tag = 5 then
        begin
        
        temptimeinfo := uos_InputlengthTime(theplayer2info, 0);
        ////// Length of input in time

        DecodeTime(temptimeinfo, ho, mi, se, ms);

        infosfo.infofile.Caption := 'File: ' + extractfilename(historyfn.Value);
        infosfo.infoname.Caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(theplayer2info, 0)));
        infosfo.infoartist.Caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(theplayer2info, 0)));
        infosfo.infoalbum.Caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(theplayer2info, 0)));
        infosfo.infoyear.Caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(theplayer2info, 0)));
        infosfo.infocom.Caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(theplayer2info, 0)));
        infosfo.infotag.Caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(theplayer2info, 0)));
        infosfo.infolength.Caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

        uos_play(theplayer2info);
        uos_Stop(theplayer2info);

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
        end;
        
        
        if (tbutton(sender).tag <> 5) and (waveformcheck.value = true) then 
           begin
        
        iswav2 := false;
        
       chan2 := uos_InputGetChannels(theplayer2info, 0);
    
   // writeln('chan = ' + inttostr(chan2));
   //  writeln('Inputlength2 = ' + inttostr(Inputlength2));

    ///// set calculation of level/volume into array (usefull for wave form procedure)
    uos_InputSetArrayLevelEnable(theplayer2info, 0, 2);
    ///////// set level calculation (default is 0)
    // 0 => no calcul
    // 1 => calcul before all DSP procedures.
    // 2 => calcul after all DSP procedures.

    //// determine how much frame will be designed
    framewanted2 := Inputlength2 div trackbar1.Width;
       
    uos_InputSetFrameCount(theplayer2info, 0, framewanted2);

     ///// Assign the procedure of object to execute at end of stream
    uos_EndProc(theplayer2info, @DrawWaveForm);

    uos_Play(theplayer2info);  /////// everything is ready, here we are, lets do it...

        end;
        
      end
      else
        ShowMessage(historyfn.Value + ' cannot load...');
  end
  else
    ShowMessage(historyfn.Value + ' does not exist...');
end;


procedure tsongplayer2fo.onmouseslider(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if ainfo.eventkind = ek_buttonpress then
    trackbar1.tag := 1
  else
  if ainfo.eventkind = ek_buttonrelease then
    trackbar1.tag := 0;
end;


procedure tsongplayer2fo.onsliderkeydown(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 1;
end;

procedure tsongplayer2fo.onsliderkeyup(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 0;
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
     mainfo.tmainmenu1.menu[3].submenu[4].caption := ' Hide Player 1 ' ;
  end
  else
  begin
    uos_Stop(theplayer2);
     mainfo.tmainmenu1.menu[3].submenu[4].caption := ' Show Player 1 ' ;
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
  thesender := 0;
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

procedure tsongplayer2fo.faceafterpaintbut(const sender: tcustomface;
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

procedure tsongplayer2fo.faceafterpaint(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
 var
 poswav, poswav2 : pointty;              
begin
if (iswav2 = true) and (waveformcheck.value = true) then begin

poswav.x :=0 ;
poswav.y := (trackbar1.height div 2) -2;

poswav2.x :=0 ;
poswav2.y := ((arect.cy div 2) -2) - round(
            (waveformdata2[poswav.x*2 ]) * ((trackbar1.height div 2) -3)) ;

      while poswav.x < length(waveformdata2) div chan2  do
      begin
        if chan2 = 2 then
        begin
       poswav.y := (trackbar1.height div 2) -2 ;  
      poswav2.x :=poswav.x ;
      poswav2.y := ((arect.cy div 2) -1) - round(
            (waveformdata2[poswav.x *2]) * ((arect.cy div 2) -3)) ;
        
      canvas.drawline(poswav,poswav2,$AC94D6); 
      
      poswav.y := (trackbar1.height div 2) ;
       
      poswav2.y := poswav.y  + ( round(
            (waveformdata2[(poswav.x *2)+1]) * ((trackbar1.height div 2) -3))) ;
      
      canvas.drawline(poswav,poswav2,$AC95D6); 

       end;
        if chan2 = 1 then
        begin
         // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1) - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
       Inc(poswav.x,1) ;
      end;
      
 end;                     
end;


procedure tsongplayer2fo.faceafterpaintgreen(const sender: tcustomface;
               const canvas: tcanvas; const arect: rectty);
 var
 
 poswav, poswav2 : pointty;              
begin
if (iswav2 = true) and (waveformcheck.value = true) then begin

poswav.x :=0 ;
poswav.y := (trackbar1.height div 2) -2;

poswav2.x :=0 ;
poswav2.y := ((arect.cy div 2) -2) - round(
            (waveformdata2[poswav.x*2 ]) * ((trackbar1.height div 2) -3)) ;

      while poswav.x < length(waveformdata2) div chan2 do
      begin
        if chan2 = 2 then
        begin
       poswav.y := (trackbar1.height div 2) -2 ;  
      poswav2.x :=poswav.x ;
      poswav2.y := ((arect.cy div 2) -1) - round(
            (waveformdata2[poswav.x *2]) * ((arect.cy div 2) -3)) ;
              canvas.drawline(poswav,poswav2,$AC94D6); 
      
      poswav.y := (trackbar1.height div 2) ;
       
      poswav2.y := poswav.y  + ( round(
            (waveformdata2[(poswav.x *2)+1]) * ((trackbar1.height div 2) -3))) ;
      
      canvas.drawline(poswav,poswav2,$AC95D6); 
   
       end;
        if chan2 = 1 then
        begin
         // Custom1.Canvas.drawLine(poswav, 0, poswav, ((Custom1.Height) - 1) 
         // - round((waveformdata[poswav]) * (Custom1.Height) - 1));
        end;
       Inc(poswav.x,1) ;
      end;
         
 end;                     
end;

procedure tsongplayer2fo.onafterev(const sender: tcustomscrollbar;
               const akind: scrolleventty; const avalue: Real);
begin
if TrackBar1.clicked then
    uos_InputSeek(theplayer2, Inputindex2, trunc(avalue * Inputlength2));
end;

procedure tsongplayer2fo.changeloop(const sender: TObject);
begin
if cbloop.value then btncue.enabled := false else  btncue.enabled := true;
end;


end.
