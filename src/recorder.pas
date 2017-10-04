unit recorder;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes, uos_flat, infos, msetimer, msetypes, mseglob, mseguiglob, mseguiintf,
 mseapplication, msestat, msemenus, msegui, msegraphics, msegraphutils,mseevent,
 mseclasses, mseforms, msedock, msesimplewidgets, msewidgets,msedataedits,
 msefiledialog, msegrids, mselistbrowser, msesys, SysUtils,msegraphedits,
 mseificomp,mseificompglob, mseifiglob, msescrollbar,msedragglob, mseact,
 mseedit, msestatfile,msestream, msestrings, msebitmap,msedatanodes,
 msedispwidgets, mserichstring;

type
  trecorderfo = class(tdockform)
    Timerwait: Ttimer;

    tfacereclight: tfacecomp;
    tfacerecrev: tfacecomp;
    tgroupbox1: tgroupbox;
    tfacerecorder: tfacecomp;
    tlabel2: tlabel;
    tlabel28: tlabel;
    tbutton3: TButton;
    tbutton2: TButton;
    blistenin: tbooleanedit;
    bsavetofile: tbooleanedit;
    btinfos: TButton;
    edvol: trealspinedit;
    edtempo: trealspinedit;
    button1: TButton;
    cbloop: tbooleanedit;
    label6: tlabel;
    cbtempo: tbooleanedit;
    trackbar1: tslider;
    btnStop: TButton;
    btnStart: TButton;
    btnResume: TButton;
    btnPause: TButton;
    tlabel27: tlabel;
    historyfn: thistoryedit;
    songdir: tfilenameedit;
    llength: tstringdisp;
    lposition: tstringdisp;
   tstringdisp2: tstringdisp;
   vuRight: tprogressbar;
   vuLeft: tprogressbar;
   recpan: tgroupbox;
   tfacecomp2: tfacecomp;
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

    procedure doentertrackbar(const Sender: TObject);
    procedure ChangePlugSetSoundTouch(const Sender: TObject);
    procedure onmouseslider(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onsliderkeydown(const Sender: twidget; var ainfo: keyeventinfoty);
    procedure onsliderkeyup(const Sender: twidget; var ainfo: keyeventinfoty);
    procedure onsliderchange(const Sender: TObject);
    procedure ontimerwait(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplayercreate(const Sender: TObject);
    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure dorecorderstart(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty;
      var aresult: modalresultty);
    procedure onlistenin(const Sender: TObject);
    procedure ondest(const Sender: TObject);
   procedure afterev(const sender: tcustomscrollbar; const akind: scrolleventty;
                   const avalue: Real);
  end;

var
  recorderfo: trecorderfo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  isrecording : boolean = false;
  therecplayer: integer = 24;
  therecplayerinfo: integer = 25;
  plugIndex3, PluginIndex3: integer;
  InputIndex3, OutputIndex3, Inputlength: integer;


implementation

uses
  main,
  recorder_mfm;

procedure trecorderfo.ontimerwait(const Sender: TObject);
begin
  timerwait.Enabled := False;
  btnStart.Enabled := True;
  btnStop.Enabled := True;
  if cbloop.Value = False then
    btnPause.Enabled := True
  else
    btnPause.Enabled := False;
  btnresume.Enabled := False;
  cbloop.Enabled := False;
  trackbar1.Enabled := True;

end;

procedure trecorderfo.ChangePlugSetSoundTouch(const Sender: TObject);
begin
  if (trim(PChar(ansistring(recorderfo.historyfn.Value))) <> '') and fileexists(ansistring(recorderfo.historyfn.Value)) then
  begin

    uos_SetPluginSoundTouch(therecplayer, PluginIndex3, edtempo.Value, 1, cbtempo.Value);

  end;
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

  vuright.value := 0;
  vuleft.value := 0;
  vuLeft.Visible := False;
  vuRight.Visible := False;
  btnStart.Enabled := True;
  btnStop.Enabled := False;
  btnPause.Enabled := False;
  btnresume.Enabled := False;
  cbloop.Enabled := True;
  trackbar1.Value := 0;
  trackbar1.Enabled := False;
  bsavetofile.Enabled := True;
  lposition.Value := '00:00:00.000';
  lposition.face.template := tfacereclight;
   historyfn.face.template := tfacereclight;
      
  recpan.visible := false;

end;

procedure trecorderfo.ShowLevel;
var
  leftlev, rightlev: double;
begin
  vuLeft.Visible := True;
  vuRight.Visible := True;

  leftlev := uos_InputGetLevelLeft(therecplayer, Inputindex3);
  rightlev := uos_InputGetLevelRight(therecplayer, Inputindex3);


if (leftlev >= 0) and (leftlev < 1) then
  begin

  if leftlev < 0.80 then
    vuLeft.bar_face.template := mainfo.tfacegreen
  else
  if leftlev < 0.90 then
    vuLeft.bar_face.template := mainfo.tfaceorange
  else
    vuLeft.bar_face.template := mainfo.tfacered;
    vuLeft.value := leftlev; 
 end;   

if (rightlev >= 0) and (rightlev < 1) then
  begin
  if rightlev < 0.80 then
    vuRight.bar_face.template := mainfo.tfacegreen
  else
  if rightlev < 0.90 then
    vuRight.bar_face.template := mainfo.tfaceorange
  else
    vuRight.bar_face.template := mainfo.tfacered;
    vuRight.value := rightlev; 
  end;
  end;

procedure trecorderfo.ShowPosition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin

  if (TrackBar1.Tag = 0) then
  begin
    if uos_InputPosition(therecplayer, InputIndex3) > 0 then
    begin
      TrackBar1.Value := uos_InputPosition(therecplayer, InputIndex3) / inputlength;
      temptime := uos_InputPositionTime(therecplayer, InputIndex3);
      ////// Length of input in time
      DecodeTime(temptime, ho, mi, se, ms);
      lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
    end;
  end;

end;

procedure trecorderfo.LoopProcPlayer1;
begin
 if isrecording = false then  ShowPosition;
 ShowLevel;
end;

procedure trecorderfo.doplayerstart(const Sender: TObject);
var
  samformat: shortint;
  ho, mi, se, ms: word;
begin
  if fileexists(PChar(ansistring(historyfn.Value))) then
  begin
    samformat := 0;

    //  songdir.hint := songdir.value;


    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...

    uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(therecplayer) then
      //// Create the player.
      //// PlayerIndex : from 0 to what your computer can do !
      //// If PlayerIndex exists already, it will be overwriten...
      tbutton3.Enabled := False;

    InputIndex3 := uos_AddFromFile(therecplayer, PChar(ansistring(historyfn.Value)), -1, samformat, 1024);

    //// add input from audio file with custom parameters
    ////////// FileName : filename of audio file
    //////////// PlayerIndex : Index of a existing Player
    ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
    //////////// FramesCount : default : -1 (65536 div channels)
    //  result : -1 nothing created, otherwise Input Index in array

    if InputIndex3 > -1 then
    begin
    isrecording := false;
      // OutputIndex3 := uos_AddIntoDevOut(PlayerIndex3) ;
      //// add a Output into device with default parameters
  
    
  {$if defined(cpuarm)}
          OutputIndex3 := uos_AddIntoDevOut(therecplayer, -1, 0.3, uos_InputGetSampleRate(therecplayer, InputIndex3),
        uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024);
 
       {$else}
      OutputIndex3 := uos_AddIntoDevOut(therecplayer, -1, -1, uos_InputGetSampleRate(therecplayer, InputIndex3),
        uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024);
 
       {$endif}
   
  
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

      uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.Value / 100, edvol.Value / 100, True);
      /// Set volume
      ////////// PlayerIndex3 : Index of a existing Player
      ////////// InputIndex3 : InputIndex of a existing Input
      ////////// VolLeft : Left volume
      ////////// VolRight : Right volume
      ////////// Enable : Enabled

     {
   DSPIndex3 := uos_InputAddDSP(PlayerIndex3, InputIndex3, @DSPReverseBefore,   @DSPReverseAfter, nil, nil);
      ///// add a custom DSP procedure for input
    ////////// PlayerIndex3 : Index of a existing Player
    ////////// InputIndex3: InputIndex of existing input
    ////////// BeforeFunc : function to do before the buffer is filled
    ////////// AfterFunc : function to do after the buffer is filled
    ////////// EndedFunc : function to do at end of thread
    ////////// LoopProc : external procedure to do after the buffer is filled

   //// set the parameters of custom DSP
   uos_InputSetDSP(PlayerIndex3, InputIndex3, DSPIndex3, checkbox1.value);

   // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)
   DSPIndex2 := uos_InputAddDSP(PlayerIndex3, InputIndex3, nil, @DSPStereo2Mono, nil, nil);
    uos_InputSetDSP(PlayerIndex3, InputIndex3, DSPIndex2, chkstereo2mono.value);

   ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
  if plugbs2b = true then
  begin
   PlugInIndex3 := uos_AddPlugin(PlayerIndex3, 'bs2b',
   uos_InputGetSampleRate(PlayerIndex3, InputIndex3) , -1);
   uos_SetPluginbs2b(PlayerIndex3, PluginIndex3, -1 , -1, -1, chkst2b.value);
  end;


  }
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

      llength.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

      uos_EndProc(therecplayer, @ClosePlayer1);

      /////// procedure to execute when stream is terminated
      ///// Assign the procedure of object to execute at end
      //////////// PlayerIndex : Index of a existing Player
      //////////// ClosePlayer1 : procedure of object to execute inside the general loop

      btinfos.Enabled := True;

      trackbar1.Value := 0;
      trackbar1.Enabled := True;
      btnStop.Enabled := True;
      btnresume.Enabled := False;
      if cbloop.Value = True then
      begin
        uos_Play(therecplayer, -1);
        btnpause.Enabled := False;
      end
      else
      begin
        uos_Play(therecplayer);  /////// everything is ready, here we are, lets play it...
        btnpause.Enabled := True;
      end;
      lposition.face.template := tfacereclight;
      cbloop.Enabled := False;
      songdir.Value := historyfn.Value;
      historyfn.hint := historyfn.Value;
      Timerwait.Enabled := True;
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
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;
  uos_RePlay(therecplayer);
end;

procedure trecorderfo.doplayerpause(const Sender: TObject);
begin
  vuLeft.Visible := False;
  vuRight.Visible := False;
  btnStop.Enabled := True;
  btnPause.Enabled := False;
  btnresume.Enabled := True;
  uos_Pause(therecplayer);
end;

procedure trecorderfo.doplayerstop(const Sender: TObject);
begin
  uos_Stop(therecplayer);
end;

procedure trecorderfo.changevolume(const Sender: TObject);
begin
  uos_InputSetDSPVolume(therecplayer, InputIndex3,
    edvol.Value / 100, edvol.Value / 100, True);

end;

procedure trecorderfo.doentertrackbar(const Sender: TObject);
begin
  recorderfo.trackbar1.tag := 1;
end;

procedure trecorderfo.onreset(const Sender: TObject);
begin
  recorderfo.edtempo.Value := 1;
end;

procedure trecorderfo.onfinfos(const Sender: TObject);
var
  maxwidth: integer;
  temptimeinfo: ttime;
  ho, mi, se, ms: word;
begin
  uos_Stop(therecplayerinfo);

  if uos_CreatePlayer(therecplayerinfo) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...

    if uos_AddFromFile(therecplayerinfo, PChar(ansistring(historyfn.Value)), -1, 0, -1) > -1 then
    begin

      inputlength := uos_InputLength(therecplayer, InputIndex3);
      ////// Length of Input in samples

      temptimeinfo := uos_InputLengthTime(therecplayerinfo, 0);
      ////// Length of input in time

      DecodeTime(temptimeinfo, ho, mi, se, ms);

      infosfo.infofile.Caption := 'File: ' + extractfilename(historyfn.Value);
      infosfo.infoname.Caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(therecplayerinfo, 0)));
      infosfo.infoartist.Caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(therecplayerinfo, 0)));
      infosfo.infoalbum.Caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(therecplayerinfo, 0)));
      infosfo.infoyear.Caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(therecplayerinfo, 0)));
      infosfo.infocom.Caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(therecplayerinfo, 0)));
      infosfo.infotag.Caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(therecplayerinfo, 0)));
      infosfo.infolength.Caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

      uos_play(therecplayerinfo);
      uos_Stop(therecplayerinfo);

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
end;


procedure trecorderfo.onmouseslider(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if ainfo.eventkind = ek_buttonpress then
    trackbar1.tag := 1
  else
  if ainfo.eventkind = ek_buttonrelease then
    trackbar1.tag := 0;
end;


procedure trecorderfo.onsliderkeydown(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 1;
end;

procedure trecorderfo.onsliderkeyup(const Sender: twidget; var ainfo: keyeventinfoty);
begin
  trackbar1.tag := 0;
end;

procedure trecorderfo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if (trackbar1.tag = 1) and (inputlength > 0) then
  begin
    temptime := tottime * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

  end;

end;


procedure trecorderfo.visiblechangeev(const Sender: TObject);
begin

  if Visible then
  begin
    mainfo.tmainmenu1.menu[3].submenu[7].caption := ' Hide Recorder ' ;
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[7].caption := ' Show Recorder ' ;
    uos_Stop(therecplayer);
  end;

  mainfo.updatelayout();
end;

procedure trecorderfo.onplayercreate(const Sender: TObject);
var
  ordir: string;
begin

  Caption := 'Recorder';
  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 100000;
  Timerwait.Enabled := False;
  Timerwait.ontimer := @ontimerwait;

  if plugsoundtouch = False then
  begin
    edtempo.Enabled := False;
    cbtempo.Enabled := False;
    Button1.Enabled := False;
    label6.Enabled := False;
  end;

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if songdir.Value = '' then
    songdir.Value := ordir + 'sound' + directoryseparator + 'record' + directoryseparator + 'record.wav';

  recorderfo.historyfn.Value := recorderfo.songdir.Value;

end;

procedure trecorderfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
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

procedure trecorderfo.dorecorderstart(const Sender: TObject);
begin
  // if (bsavetofile.value = True) or (blistenin.value = True) then begin

  uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

  if uos_CreatePlayer(therecplayer) then
  begin
    isrecording := true;
    tbutton2.Enabled := True;
    tbutton3.Enabled := False;
    btnStart.Enabled := False;
    
     historyfn.face.template := mainfo.tfacered;
      
      recpan.visible := true;

    if bsavetofile.Value then
      uos_AddIntoFile(therecplayer, PChar(ansistring(historyfn.Value)));

    {$if defined(cpuarm)}
       OutputIndex3 := uos_AddIntoDevOut(therecplayer,-1, 0.3, -1, -1, -1, -1) ;
       {$else}
       OutputIndex3 := uos_AddIntoDevOut(therecplayer);
       {$endif}
 
    
    uos_outputsetenable(therecplayer, OutputIndex3, blistenin.Value);

    InputIndex3 := uos_AddFromDevIn(therecplayer);
    /// add Input from mic/aux into IN device with default parameters

    //    In1Index := uos_AddFromDevIn(0, -1, -1, -1, -1, 1, -1);
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

    uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.Value / 100, edvol.Value / 100, True);

    /////// procedure to execute when stream is terminated
    uos_EndProc(therecplayer, @ClosePlayer1);
    ///// Assign the procedure of object to execute at end
    //////////// PlayerIndex : Index of a existing Player
    //////////// ClosePlayer1 : procedure of object to execute inside the loop

    uos_Play(therecplayer);  /////// everything is ready to play...

    bsavetofile.Enabled := False;

    //   end;

  end;
end;

procedure trecorderfo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
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
end;

procedure trecorderfo.afterev(const sender: tcustomscrollbar;
               const akind: scrolleventty; const avalue: Real);
begin
if akind = sbe_thumbposition then 
   uos_InputSeek(therecplayer, InputIndex3, trunc(avalue * inputlength))
   else onsliderchange(Sender);
end;


end.
