unit recorder;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 ctypes, uos_flat, infos, msetimer,msetypes,mseglob,mseguiglob,mseguiintf,
 mseapplication,msestat,msemenus,msegui,msegraphics,msegraphutils,mseevent,
 mseclasses,mseforms,msedock,msesimplewidgets,msewidgets,msedataedits,
 msefiledialog,msegrids,mselistbrowser,msesys,sysutils,msegraphedits,mseificomp,
 mseificompglob,mseifiglob,msescrollbar,msedragglob,mseact,mseedit,msestatfile,
 msestream,msestrings,msebitmap,msedatanodes,msedispwidgets,mserichstring;

type
 trecorderfo = class(tdockform)
   Timerwait: Ttimer;
   
   tfacecomp1: tfacecomp;
   tfacerecorder: tfacecomp;
   tgroupbox1: tgroupbox;
   tfacecomp2: tfacecomp;
   vuRight: tdockpanel;
   vuLeft: tdockpanel;
   tlabel2: tlabel;
   tlabel28: tlabel;
   tbutton3: tbutton;
   tbutton2: tbutton;
   blistenin: tbooleanedit;
   bsavetofile: tbooleanedit;
   btinfos: tbutton;
   edvol: trealspinedit;
   edtempo: trealspinedit;
   button1: tbutton;
   cbloop: tbooleanedit;
   label6: tlabel;
   cbtempo: tbooleanedit;
   trackbar1: tslider;
   btnStop: tbutton;
   btnStart: tbutton;
   btnResume: tbutton;
   btnPause: tbutton;
   tlabel27: tlabel;
   historyfn: thistoryedit;
   songdir: tfilenameedit;
   tfacecomp3: tfacecomp;
   llength: tstringdisp;
   lposition: tstringdisp;
   tfacecomp4: tfacecomp;
   procedure doplayerstart(const sender: TObject);
   procedure doplayeresume(const sender: TObject);
   procedure doplayerpause(const sender: TObject);
   procedure doplayerstop(const sender: TObject);
   procedure ClosePlayer1;
   procedure showposition;
   procedure showlevel;
   procedure LoopProcPlayer1;
    procedure onfinfos(const sender: TObject);
     procedure onreset(const sender: TObject);
   
   procedure changepos(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure changevolume(const sender: TObject);
  
   procedure doentertrackbar(const sender: TObject);
   procedure ChangePlugSetSoundTouch(const Sender: TObject);
    procedure onmouseslider(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure onsliderkeydown(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onsliderkeyup(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onsliderchange(const sender: TObject);
   procedure ontimerwait(const Sender: TObject);
 
   procedure onfloatplay(const sender: TObject);
   procedure ondockplay(const sender: TObject);
   procedure visiblechangeev(const sender: TObject);
   procedure onplayercreate(const sender: TObject);
   procedure onmousewindow(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure dorecorderstart(const sender: TObject);
   procedure whosent(const sender: tfiledialogcontroller;
                   var dialogkind: filedialogkindty;
                   var aresult: modalresultty);
   procedure onlistenin(const sender: TObject);
   procedure ondest(const sender: TObject);
 end;
var
 recorderfo: trecorderfo;
 thedialogform : tfiledialogfo;
 initplay : integer = 1;
 therecplayer : integer = 24;
 therecplayerinfo : integer = 25;
 plugIndex3, PluginIndex3: integer;
 InputIndex3, OutputIndex3, Inputlength: integer; 
 
 
implementation
uses
main,
 recorder_mfm;
 
 procedure trecorderfo.ontimerwait(const Sender: TObject);
begin 
timerwait.enabled := false;
 btnStart.Enabled := True;
    btnStop.Enabled := true;
 if  cbloop.value = false then
    btnPause.Enabled := true else
      btnPause.Enabled := false;
    btnresume.Enabled := False;
    cbloop.enabled := false;
    trackbar1.enabled := true;

end;
 
 procedure trecorderfo.ChangePlugSetSoundTouch(const Sender: TObject);
   begin
         if (trim(Pchar(AnsiString(recorderfo.historyfn.value))) <> '') 
         and fileexists(AnsiString(recorderfo.historyfn.value)) then
  begin
  
       uos_SetPluginSoundTouch(therecplayer, PluginIndex3, edtempo.value, 1, cbtempo.value);
 
    end;
  end;
 
  
procedure trecorderfo.ClosePlayer1;
  begin
  {
    radiobutton1.Enabled := True;
    radiobutton2.Enabled := True;
    radiobutton3.Enabled := True;
    } 
     tbutton2.enabled := false;
      tbutton3.enabled := true;
    
   vuright.Height := 0;
    vuleft.Height := 0;
    vuLeft.Visible := False;
     vuRight.Visible := False;
    btnStart.Enabled := True;
    btnStop.Enabled := False;
    btnPause.Enabled := False;
    btnresume.Enabled := False;
    cbloop.enabled := true;
    trackbar1.value := 0;
    trackbar1.enabled := false;
    bsavetofile.Enabled := true;
    lposition.value := '00:00:00.000';
    lposition.face.template := tfacecomp1;
    
     end;
     
  procedure trecorderfo.ShowLevel;
  begin
      vuLeft.Visible := True;
    vuRight.Visible := True;
    if trunc(uos_InputGetLevelLeft(therecplayer, InputIndex3) * 44) >= 0 then
      vuLeft.Height := trunc(uos_InputGetLevelLeft(therecplayer, InputIndex3) * 44);
    if trunc(uos_InputGetLevelRight(therecplayer, InputIndex3) * 44) >= 0 then
      vuRight.Height := trunc(uos_InputGetLevelRight(therecplayer, InputIndex3) * 44);
    vuLeft.top := 96 - vuLeft.Height;
    vuRight.top := 96 - vuRight.Height;
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
        TrackBar1.value := uos_InputPosition(therecplayer, InputIndex3) / inputlength;
        temptime := uos_InputPositionTime(therecplayer, InputIndex3);
        ////// Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      end;
    end;
   
    end; 
  
 procedure trecorderfo.LoopProcPlayer1;
begin
 ShowPosition;
 ShowLevel ;
end;

procedure trecorderfo.doplayerstart(const sender: TObject);
var
    samformat: shortint;
       ho, mi, se, ms: word;
  begin
  if fileexists(pchar(AnsiString(historyfn.value))) then
  begin
     samformat := 0;
     
   //  songdir.hint := songdir.value;
     
    
    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...
    
     uos_Stop(therecplayer) ; // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(therecplayer) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
     tbutton3.enabled := false; 
         
     InputIndex3 := uos_AddFromFile(therecplayer, pchar(AnsiString(historyfn.value)), -1, samformat, 1024);
     
    //// add input from audio file with custom parameters
    ////////// FileName : filename of audio file
    //////////// PlayerIndex : Index of a existing Player
    ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
    //////////// FramesCount : default : -1 (65536 div channels)
    //  result : -1 nothing created, otherwise Input Index in array

    if InputIndex3 > -1 then
     begin
      // OutputIndex3 := uos_AddIntoDevOut(PlayerIndex3) ;
    //// add a Output into device with default parameters
    OutputIndex3 := uos_AddIntoDevOut(therecplayer, -1, -1, uos_InputGetSampleRate(therecplayer, InputIndex3),
     uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024);
    //// add a Output into device with custom parameters
    //////////// PlayerIndex : Index of a existing Player
    //////////// Device ( -1 is default Output device )
    //////////// Latency  ( -1 is latency suggested ) )
    //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
    //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
    //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
    //////////// FramesCount : default : -1 (65536)
    //  result : -1 nothing created, otherwise Output Index in array
  
   uos_InputSetLevelEnable(therecplayer, InputIndex3, 2) ;
     ///// set calculation of level/volume (usefull for showvolume procedure)
                       ///////// set level calculation (default is 0)
                          // 0 => no calcul
                          // 1 => calcul before all DSP procedures.
                          // 2 => calcul after all DSP procedures.
                          // 3 => calcul before and after all DSP procedures.

   uos_InputSetPositionEnable(therecplayer, InputIndex3, 1) ;
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

    uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.value/100, edvol.value/100, True);
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
    if plugsoundtouch = true then
  begin
    PlugInIndex3 := uos_AddPlugin(therecplayer, 'soundtouch', 
    uos_InputGetSampleRate(therecplayer, InputIndex3) , -1);
    ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
   end;    
        
   inputlength := uos_InputLength(therecplayer, InputIndex3);
    ////// Length of Input in samples

   tottime := uos_InputLengthTime(therecplayer, InputIndex3);
    ////// Length of input in time

   DecodeTime(tottime, ho, mi, se, ms);
    
   llength.value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
   
   uos_EndProc(therecplayer, @ClosePlayer1);
 
    /////// procedure to execute when stream is terminated
     ///// Assign the procedure of object to execute at end
    //////////// PlayerIndex : Index of a existing Player
    //////////// ClosePlayer1 : procedure of object to execute inside the general loop
    
    btinfos.Enabled := True;
    
    trackbar1.value := 0;
    trackbar1.Enabled := True;
    btnStop.Enabled := True;
    btnresume.Enabled := False;
    if cbloop.value = true then
    begin
    uos_Play(therecplayer,-1) ;
    btnpause.Enabled := false;
    end
     else
     begin
     uos_Play(therecplayer) ;  /////// everything is ready, here we are, lets play it...
     btnpause.Enabled := true;
    end;
    lposition.face.template := tfacecomp4;
    cbloop.enabled := false; 
    songdir.value := historyfn.value;
    historyfn.hint := historyfn.value;
    Timerwait.Enabled := true;
    end else 
    begin
     showmessage( historyfn.value + ' does not exist...');
    end; end else showmessage( historyfn.value + ' does not exist...');
    
end;

procedure trecorderfo.doplayeresume(const sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;
  uos_RePlay(therecplayer);
end;

procedure trecorderfo.doplayerpause(const sender: TObject);
begin
    vuLeft.Visible := False;
    vuRight.Visible := False;
    vuright.Height := 0;
    vuleft.Height := 0;
    btnStop.Enabled := True;
    btnPause.Enabled := False;
    btnresume.Enabled := True;
    uos_Pause(therecplayer);
end;

procedure trecorderfo.doplayerstop(const sender: TObject);
begin
 uos_Stop(therecplayer);
end;

procedure trecorderfo.changepos(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 if TrackBar1.Tag = 0 then
   uos_InputSeek(therecplayer, InputIndex3, trunc(avalue * inputlength));
 //  TrackBar1.Tag := 0;

end;

procedure trecorderfo.changevolume(const sender: TObject);
begin
   uos_InputSetDSPVolume(therecplayer, InputIndex3,
   edvol.value/100, edvol.value/100, True);

end;

procedure trecorderfo.doentertrackbar(const sender: TObject);
begin
recorderfo.trackbar1.tag := 1;
end;

procedure trecorderfo.onreset(const sender: TObject);
begin
recorderfo.edtempo.value := 1;
end;

procedure trecorderfo.onfinfos(const sender: TObject);
var
maxwidth : integer;
temptimeinfo : ttime;
 ho, mi, se, ms: word;
begin
  uos_Stop(therecplayerinfo) ;

 if uos_CreatePlayer(therecplayerinfo) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
      
  if uos_AddFromFile(therecplayerinfo, pchar(AnsiString(historyfn.value)), -1, 0, -1) > -1 then
  begin
  
 inputlength := uos_InputLength(therecplayer, InputIndex3);
    ////// Length of Input in samples

   temptimeinfo := uos_InputLengthTime(therecplayerinfo, 0);
    ////// Length of input in time

   DecodeTime(temptimeinfo, ho, mi, se, ms);
    
infosfo.infofile.caption := 'File: ' + extractfilename(historyfn.value);
infosfo.infoname.caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(therecplayerinfo, 0)));
infosfo.infoartist.caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(therecplayerinfo, 0)));
infosfo.infoalbum.caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(therecplayerinfo, 0)));
infosfo.infoyear.caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(therecplayerinfo, 0)));
infosfo.infocom.caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(therecplayerinfo, 0)));
infosfo.infotag.caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(therecplayerinfo, 0)));
infosfo.infolength.caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]) ;

uos_play(therecplayerinfo) ;
uos_Stop(therecplayerinfo) ;

maxwidth := infosfo.infofile.width ;

if maxwidth < infosfo.infoname.width then maxwidth := infosfo.infoname.width;
if maxwidth < infosfo.infoartist.width then maxwidth := infosfo.infoartist.width;
if maxwidth < infosfo.infoalbum.width then maxwidth := infosfo.infoalbum.width;
if maxwidth < infosfo.infoyear.width then maxwidth := infosfo.infoyear.width;
if maxwidth < infosfo.infocom.width then maxwidth := infosfo.infocom.width;
if maxwidth < infosfo.infotag.width then maxwidth := infosfo.infotag.width;
if maxwidth < infosfo.infolength.width then maxwidth := infosfo.infolength.width;

infosfo.width := maxwidth + 42 ; 
// infosfo.button1.left := (infosfo.width - infosfo.button1.width)  div 2 ;
infosfo.show(true);
end;
end;


procedure trecorderfo.onmouseslider(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
if ainfo.eventkind = ek_buttonpress then trackbar1.tag := 1 else
if ainfo.eventkind =  ek_buttonrelease then trackbar1.tag := 0 ;
end;


procedure trecorderfo.onsliderkeydown(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
trackbar1.tag := 1 ;
end;

procedure trecorderfo.onsliderkeyup(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
trackbar1.tag := 0 ;
end;

procedure trecorderfo.onsliderchange(const sender: TObject);
 var
    temptime: ttime;
    ho, mi, se, ms: word;
begin
if (trackbar1.tag = 1) and (inputlength > 0) then
begin
        temptime := tottime *  TrackBar1.value;
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
       
 end;

end;

procedure trecorderfo.onfloatplay(const sender: TObject);
begin
{
height := 114;
mainfo.height := mainfo.height - 114;
if mainfo.height < 40 then mainfo.height := 40;
}
end;

procedure trecorderfo.ondockplay(const sender: TObject);
begin
// if initplay = 0 then mainfo.procshowpllayer(sender);

if hasinit = 0 then begin
height := 158;
mainfo.height := mainfo.height + 158;
end;
end;

procedure trecorderfo.visiblechangeev(const sender: TObject);
begin

if visible then begin
 // mainfo.tmainmenu1.menu[4].hint := ' Hide Recorder ' ;
 end
 else begin
 // mainfo.tmainmenu1.menu[4].hint := ' Show Recorder ' ;
  uos_Stop(therecplayer);
 end;

 mainfo.updatelayout();
end;

procedure trecorderfo.onplayercreate(const sender: TObject);
var
ordir : string;
begin

caption := 'Recorder';
      Timerwait := ttimer.Create(nil);
        Timerwait.interval := 100000;
        Timerwait.Enabled := False;
       Timerwait.ontimer := @ontimerwait;
     
       if plugsoundtouch = false then
        begin
       edtempo.enabled := false;
       cbtempo.enabled := false;
       Button1.enabled := false;
       label6.enabled := false;
       end;
       
   ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
     
 if songdir.value = '' then
 songdir.value :=  ordir + 'sound' + directoryseparator +  'record' + directoryseparator + 'record.wav';
 
 recorderfo.historyfn.value := recorderfo.songdir.value ;         
        
end;

procedure trecorderfo.onmousewindow(const sender: twidget;
               var ainfo: mouseeventinfoty);
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

procedure trecorderfo.dorecorderstart(const sender: TObject);
  begin
// if (bsavetofile.value = True) or (blistenin.value = True) then begin
   
   uos_Stop(therecplayer) ; // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(therecplayer) then
   begin
   tbutton2.enabled := true;
    tbutton3.enabled := false;
     btnStart.Enabled := false;
   
   uos_AddIntoFile(therecplayer, pchar(AnsiString(historyfn.value)));
   //  if checkbox1.Checked then
     OutputIndex3 := uos_AddIntoDevOut(therecplayer);
     uos_outputsetenable(therecplayer,OutputIndex3,blistenin.value);
   
   
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
    uos_InputSetLevelEnable(therecplayer, InputIndex3, 2) ;
 
    uos_InputAddDSPVolume(therecplayer, InputIndex3, 1, 1);
    ///// DSP Volume changer
    //////////// PlayerIndex : Index of a existing Player
    ////////// In1Index : InputIndex of a existing input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume
    
     uos_LoopProcIn(therecplayer, InputIndex3, @LoopProcPlayer1);

    uos_InputSetDSPVolume(therecplayer, InputIndex3, edvol.value/100, edvol.value/100, True);
  
   /////// procedure to execute when stream is terminated
     uos_EndProc(therecplayer, @ClosePlayer1);
   ///// Assign the procedure of object to execute at end
   //////////// PlayerIndex : Index of a existing Player
   //////////// ClosePlayer1 : procedure of object to execute inside the loop

    uos_Play(therecplayer);  /////// everything is ready to play...
   
    bsavetofile.Enabled := false;
      
   //   end;

  end;
end;

procedure trecorderfo.whosent(const sender: tfiledialogcontroller;
               var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
thesender := 2;
end;

procedure trecorderfo.onlistenin(const sender: TObject);
begin
 uos_outputsetenable(therecplayer,OutputIndex3,blistenin.value);
end;

procedure trecorderfo.ondest(const sender: TObject);
begin
Timerwait.free;
end;


end.
