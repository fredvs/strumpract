unit songplayer2;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 ctypes, uos_flat, infos, msetimer,msetypes,mseglob,mseguiglob,mseguiintf,
 mseapplication,msestat,msemenus,msegui,msegraphics,msegraphutils,mseevent,
 mseclasses,mseforms,msedock,msesimplewidgets,msewidgets,msedataedits,
 msefiledialog,msegrids,mselistbrowser,msesys,sysutils,msegraphedits,
 msedragglob,mseact,mseedit,mseificomp,mseificompglob,mseifiglob,msestatfile,
 msestream,msestrings,msescrollbar,msebitmap,msedatanodes;

type
 tsongplayer2fo = class(tdockform)
   Timerwait: Ttimer;
   
   tfaceplayer: tfacecomp;
   tgroupbox1: tgroupbox;
   tfacecomp2: tfacecomp;
   vuRight: tdockpanel;
   vuLeft: tdockpanel;
   edvol: trealspinedit;
   edtempo: trealspinedit;
   button1: tbutton;
   cbloop: tbooleanedit;
   label6: tlabel;
   cbtempo: tbooleanedit;
   btnStop: tbutton;
   btnStart: tbutton;
   btnResume: tbutton;
   btnPause: tbutton;
   tlabel27: tlabel;
   tlabel28: tlabel;
   llength: tlabel;
   lposition: tlabel;
   trackbar1: tslider;
   historyfn: thistoryedit;
   songdir: tfilenameedit;
   btinfos: tbutton;
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
   procedure whosent(const sender: tfiledialogcontroller;
                   var dialogkind: filedialogkindty;
                   var aresult: modalresultty);
 end;
var
 songplayer2fo: tsongplayer2fo;
 thedialogform : tfiledialogfo;
 initplay : integer = 1;
  theplayer : integer = 20;
 theplayerinfo : integer = 21;
 plugindex1, PluginIndex2: integer; InputIndex1, OutputIndex1, Inputlength: integer; 
 
 
implementation
uses
main,
 songplayer2_mfm;
 
 procedure tsongplayer2fo.ontimerwait(const Sender: TObject);
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
 
 procedure tsongplayer2fo.ChangePlugSetSoundTouch(const Sender: TObject);
   begin
         if (trim(Pchar(AnsiString(songplayer2fo.historyfn.value))) <> '') 
         and fileexists(AnsiString(songplayer2fo.historyfn.value)) then
  begin
 
         uos_SetPluginSoundTouch(theplayer, PluginIndex2, edtempo.value, 1, cbtempo.value);
 
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
    cbloop.enabled := true;
    trackbar1.value := 0;
    trackbar1.enabled := false;
    lposition.caption := '00:00:00.000';
     end;
     
  procedure tsongplayer2fo.ShowLevel;
  begin
      vuLeft.Visible := True;
    vuRight.Visible := True;
    if trunc(uos_InputGetLevelLeft(theplayer, InputIndex1) * 44) >= 0 then
      vuLeft.Height := trunc(uos_InputGetLevelLeft(theplayer, InputIndex1) * 44);
    if trunc(uos_InputGetLevelRight(theplayer, InputIndex1) * 44) >= 0 then
      vuRight.Height := trunc(uos_InputGetLevelRight(theplayer, InputIndex1) * 44);
    vuLeft.top := 75 - vuLeft.Height;
    vuRight.top := 75 - vuRight.Height;
   end;  
 
 procedure tsongplayer2fo.ShowPosition;
  var
    temptime: ttime;
    ho, mi, se, ms: word;
  begin
 
     if (TrackBar1.Tag = 0) then
    begin
      if uos_InputPosition(theplayer, InputIndex1) > 0 then
      begin
        TrackBar1.value := uos_InputPosition(theplayer, InputIndex1) / inputlength;
        temptime := uos_InputPositionTime(theplayer, InputIndex1);
        ////// Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      end;
    end;
   
    end; 
  
 procedure tsongplayer2fo.LoopProcPlayer1;
begin
 ShowPosition;
 ShowLevel ;
end;

procedure tsongplayer2fo.doplayerstart(const sender: TObject);
var
    samformat: shortint;
       ho, mi, se, ms: word;
  begin
  
     samformat := 0;
     
   //  songdir.hint := songdir.value;
     
    
    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...
    
     uos_Stop(theplayer) ; // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(theplayer) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
      
     InputIndex1 := uos_AddFromFile(theplayer, pchar(AnsiString(historyfn.value)), -1, samformat, 1024);
     
    //// add input from audio file with custom parameters
    ////////// FileName : filename of audio file
    //////////// PlayerIndex : Index of a existing Player
    ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
    //////////// FramesCount : default : -1 (65536 div channels)
    //  result : -1 nothing created, otherwise Input Index in array

    if InputIndex1 > -1 then
     begin
      // OutputIndex1 := uos_AddIntoDevOut(PlayerIndex1) ;
    //// add a Output into device with default parameters
    OutputIndex1 := uos_AddIntoDevOut(theplayer, -1, -1, uos_InputGetSampleRate(theplayer, InputIndex1),
     uos_InputGetChannels(theplayer, InputIndex1), samformat, 1024);
    //// add a Output into device with custom parameters
    //////////// PlayerIndex : Index of a existing Player
    //////////// Device ( -1 is default Output device )
    //////////// Latency  ( -1 is latency suggested ) )
    //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
    //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
    //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
    //////////// FramesCount : default : -1 (65536)
    //  result : -1 nothing created, otherwise Output Index in array
  
   uos_InputSetLevelEnable(theplayer, InputIndex1, 2) ;
     ///// set calculation of level/volume (usefull for showvolume procedure)
                       ///////// set level calculation (default is 0)
                          // 0 => no calcul
                          // 1 => calcul before all DSP procedures.
                          // 2 => calcul after all DSP procedures.
                          // 3 => calcul before and after all DSP procedures.

   uos_InputSetPositionEnable(theplayer, InputIndex1, 1) ;
     ///// set calculation of position (usefull for positions procedure)
                       ///////// set position calculation (default is 0)
                          // 0 => no calcul
                          // 1 => calcul position.

   uos_LoopProcIn(theplayer, InputIndex1, @LoopProcPlayer1);
 
    ///// Assign the procedure of object to execute inside the loop
    //////////// PlayerIndex : Index of a existing Player
    //////////// InputIndex1 : Index of a existing Input
    //////////// LoopProcPlayer1 : procedure of object to execute inside the loop
   
   uos_InputAddDSPVolume(theplayer, InputIndex1, 1, 1);
    ///// DSP Volume changer
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1 : Index of a existing input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume

    uos_InputSetDSPVolume(theplayer, InputIndex1, edvol.value/100, edvol.value/100, True);
     /// Set volume
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1 : InputIndex of a existing Input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume
    ////////// Enable : Enabled
    
     {
   DSPIndex1 := uos_InputAddDSP(PlayerIndex1, InputIndex1, @DSPReverseBefore,   @DSPReverseAfter, nil, nil);
      ///// add a custom DSP procedure for input
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1: InputIndex of existing input
    ////////// BeforeFunc : function to do before the buffer is filled
    ////////// AfterFunc : function to do after the buffer is filled
    ////////// EndedFunc : function to do at end of thread
    ////////// LoopProc : external procedure to do after the buffer is filled
   
   //// set the parameters of custom DSP
   uos_InputSetDSP(PlayerIndex1, InputIndex1, DSPIndex1, checkbox1.value);
    
   // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)  
   DSPIndex2 := uos_InputAddDSP(PlayerIndex1, InputIndex1, nil, @DSPStereo2Mono, nil, nil);
    uos_InputSetDSP(PlayerIndex1, InputIndex1, DSPIndex2, chkstereo2mono.value); 
   
   ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
  if plugbs2b = true then
  begin
   PlugInIndex1 := uos_AddPlugin(PlayerIndex1, 'bs2b',
   uos_InputGetSampleRate(PlayerIndex1, InputIndex1) , -1);
   uos_SetPluginbs2b(PlayerIndex1, PluginIndex1, -1 , -1, -1, chkst2b.value);
  end; 
  
  
  }
  /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
  /// SoundTouch plugin should be the last added.
    if plugsoundtouch = true then
  begin
    PlugInIndex2 := uos_AddPlugin(theplayer, 'soundtouch', 
    uos_InputGetSampleRate(theplayer, InputIndex1) , -1);
    ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
   end;    
        
   inputlength := uos_InputLength(theplayer, InputIndex1);
    ////// Length of Input in samples

   tottime := uos_InputLengthTime(theplayer, InputIndex1);
    ////// Length of input in time

   DecodeTime(tottime, ho, mi, se, ms);
    
   llength.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
   
   uos_EndProc(theplayer, @ClosePlayer1);
 
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
    uos_Play(theplayer,-1) ;
    btnpause.Enabled := false;
    end
     else
     begin
     uos_Play(theplayer) ;  /////// everything is ready, here we are, lets play it...
     btnpause.Enabled := true;
    end;
    cbloop.enabled := false; 
    songdir.value := historyfn.value;
    historyfn.hint := historyfn.value;
    Timerwait.Enabled := true;
    end else 
    begin
     showmessage( historyfn.value + ' does not exist...');
    end;
end;

procedure tsongplayer2fo.doplayeresume(const sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;
  uos_RePlay(theplayer);
end;

procedure tsongplayer2fo.doplayerpause(const sender: TObject);
begin
    vuLeft.Visible := False;
    vuRight.Visible := False;
    vuright.Height := 0;
    vuleft.Height := 0;
    btnStop.Enabled := True;
    btnPause.Enabled := False;
    btnresume.Enabled := True;
    uos_Pause(theplayer);
end;

procedure tsongplayer2fo.doplayerstop(const sender: TObject);
begin
 uos_Stop(theplayer);
end;

procedure tsongplayer2fo.changepos(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 if TrackBar1.Tag = 0 then
   uos_InputSeek(theplayer, InputIndex1, trunc(avalue * inputlength));
 //  TrackBar1.Tag := 0;

end;

procedure tsongplayer2fo.changevolume(const sender: TObject);
begin
   uos_InputSetDSPVolume(theplayer, InputIndex1,
   edvol.value/100, edvol.value/100, True);

end;

procedure tsongplayer2fo.doentertrackbar(const sender: TObject);
begin
songplayer2fo.trackbar1.tag := 1;
end;

procedure tsongplayer2fo.onreset(const sender: TObject);
begin
songplayer2fo.edtempo.value := 1;
end;

procedure tsongplayer2fo.onfinfos(const sender: TObject);
var
maxwidth : integer;
temptimeinfo : ttime;
 ho, mi, se, ms: word;
begin
  uos_Stop(theplayerinfo) ;

 if uos_CreatePlayer(theplayerinfo) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
      
  if uos_AddFromFile(theplayerinfo, pchar(AnsiString(historyfn.value)), -1, 0, -1) > -1 then
  begin
  
 inputlength := uos_InputLength(theplayer, InputIndex1);
    ////// Length of Input in samples

   temptimeinfo := uos_InputLengthTime(theplayerinfo, 0);
    ////// Length of input in time

   DecodeTime(temptimeinfo, ho, mi, se, ms);
    
infosfo.infofile.caption := 'File: ' + extractfilename(historyfn.value);
infosfo.infoname.caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(theplayerinfo, 0)));
infosfo.infoartist.caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(theplayerinfo, 0)));
infosfo.infoalbum.caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(theplayerinfo, 0)));
infosfo.infoyear.caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(theplayerinfo, 0)));
infosfo.infocom.caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(theplayerinfo, 0)));
infosfo.infotag.caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(theplayerinfo, 0)));
infosfo.infolength.caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]) ;

uos_play(theplayerinfo) ;
uos_Stop(theplayerinfo) ;

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


procedure tsongplayer2fo.onmouseslider(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
if ainfo.eventkind = ek_buttonpress then trackbar1.tag := 1 else
if ainfo.eventkind =  ek_buttonrelease then trackbar1.tag := 0 ;
end;


procedure tsongplayer2fo.onsliderkeydown(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
trackbar1.tag := 1 ;
end;

procedure tsongplayer2fo.onsliderkeyup(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
trackbar1.tag := 0 ;
end;

procedure tsongplayer2fo.onsliderchange(const sender: TObject);
 var
    temptime: ttime;
    ho, mi, se, ms: word;
begin
if (trackbar1.tag = 1) and (inputlength > 0) then
begin
        temptime := tottime *  TrackBar1.value;
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
       
 end;

end;

procedure tsongplayer2fo.onfloatplay(const sender: TObject);
begin
{
height := 114;
mainfo.height := mainfo.height - 114;
if mainfo.height < 40 then mainfo.height := 40;
}
end;

procedure tsongplayer2fo.ondockplay(const sender: TObject);
begin
// if initplay = 0 then mainfo.procshowpllayer(sender);

if hasinit = 0 then begin
height := 114;
mainfo.height := mainfo.height + 114;
end;
end;

procedure tsongplayer2fo.visiblechangeev(const sender: TObject);
begin
{
 if visible then begin
  mainfo.tmainmenu1.menu[1].hint := ' Hide Player 1 ' ;
 end
 else begin
  mainfo.tmainmenu1.menu[1].hint := ' Show Player 1 ' ;
 end;
}
 mainfo.updatelayout();
end;

procedure tsongplayer2fo.onplayercreate(const sender: TObject);
var
ordir : string;
begin

caption := 'Song Player 2';
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
 songdir.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.ogg';
 
// if historyfn.value = '' then
// historyfn.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';
 
 songplayer2fo.historyfn.value := songplayer2fo.songdir.value ;         
        
end;

procedure tsongplayer2fo.onmousewindow(const sender: twidget;
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

procedure tsongplayer2fo.whosent(const sender: tfiledialogcontroller;
               var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
thesender := 1;
end;


end.
