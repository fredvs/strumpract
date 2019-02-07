unit recorder;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ctypes, uos_flat, infos, msetimer, msetypes, mseglob, mseguiglob, mseguiintf,
 mseapplication, msestat, msemenus, msegui, msegraphics, msegraphutils, math,
  mseevent,mseclasses, mseforms, msedock, msesimplewidgets, msewidgets,
  msedataedits,msefiledialog, msegrids, mselistbrowser, msesys, SysUtils,
  msegraphedits,mseificomp, mseificompglob, mseifiglob, msescrollbar,
  msedragglob, mseact,mseedit, msestatfile, msestream, msestrings, msebitmap,
  msedatanodes,msedispwidgets, mserichstring;

type
  trecorderfo = class(tdockform)
    Timerwait: Ttimer;
    Timerrec: Ttimer;
    Timersent: Ttimer;

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
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
   sentcue1: tbooleanedit;
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
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure onlistenin(const Sender: TObject);
    procedure ondest(const Sender: TObject);
    procedure ShowSpectrum(const Sender: TObject);
    procedure resetspectrum();
    procedure InitDrawLive();
    procedure DrawLive(lv,rv : double);
    procedure afterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
   procedure oncreated(const sender: TObject);
  end;

 equalizer_band_type = record
    lo_freq, hi_freq: integer;
    Text: string[10];
  end;
  
var
  timenow: ttime;
   arrecl, arrecr : flo64arty;
   rectrecform: rectty;
   xreclive : integer;
   islive : boolean = true;
   Equalizer_Bands: array[1..10] of equalizer_band_type;
    thearrayrec: array of cfloat;
   tottimerec: ttime;
   recorderfo: trecorderfo;
  thedialogform: tfiledialogfo;
  initplay: integer = 1;
  isrecording: boolean = False;
  therecplayer: integer = 24;
  therecplayerinfo: integer = 25;
  plugIndex3, PluginIndex3: integer;
  InputIndex3, OutputIndex3, Inputlength: integer;


implementation

uses
  main, config, dockpanel1, spectrum1, waveform, songplayer,
  recorder_mfm;
  
procedure trecorderfo.InitDrawLive();
const
  transpcolor = cl_gray;
begin

  if  (as_checked in waveforec.tmainmenu1.menu[0].state) then
  begin
    waveforec.trackbar1.Width := waveforec.width -10;
    waveforec.trackbar1.height := waveforec.height - 18;
    waveforec.trackbar1.invalidate();
    
    rectrecform.pos := nullpoint;
    rectrecform.size := waveforec.trackbar1.paintsize;
    
    xreclive := 1 ;
    
     waveforec.TrackBar1.Value := 0;

    with waveforec.sliderimage.bitmap do
    begin
      size := rectrecform.size;
      init(transpcolor);
       masked := true;
       transparentcolor := transpcolor;
    end;
  
  end;

end;  

procedure trecorderfo.DrawLive(lv,rv : double);
var
  poswavrec, poswavrec2: pointty;
begin
      
    waveforec.sliderimage.bitmap.masked := false; 
    
      poswavrec.x := xreclive;
      poswavrec2.x := poswavrec.x;

        
 //  poswav2.y := ((arect.cy div 2) - 2) - round((waveformdataform1[poswav.x * 2]) * ((wavefo.trackbar1.Height div 2) - 3));

          poswavrec.y := (waveforec.trackbar1.Height div 2) - 2;
          poswavrec2.y := ((rectrecform.cy div 2) - 1) - round((lv) * ((rectrecform.cy div 2) - 3));

          // if mainfo.typecolor.Value = 0 then
          waveforec.sliderimage.bitmap.canvas.drawline(poswavrec, poswavrec2, $AC99D6);
          //  else
          //    canvas.drawline(poswav, poswav2, $6A6A6A);

          poswavrec.y := (waveforec.trackbar1.Height div 2);

          poswavrec2.y := poswavrec.y + (round((rv) * ((waveforec.trackbar1.Height div 2) - 3)));

          //  if mainfo.typecolor.Value = 0 then
          waveforec.sliderimage.bitmap.canvas.drawline(poswavrec, poswavrec2, $AC79D6);
          //  else
          //    canvas.drawline(poswav, poswav2, $8A8A8A);

      
    xreclive := xreclive +1;
 
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
    temptime := now - timenow;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
    timerrec.Enabled := True;
  end
  else
    lposition.Value := '00:00:00.000';
end;

procedure trecorderfo.ontimerwait(const Sender: TObject);
begin
//  timerwait.Enabled := False;
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

  vuright.Value := 0;
  vuleft.Value := 0;
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

  isrecording := False;

  timerrec.Enabled := False;

  recpan.Visible := False;

  llength.Value := '00:00:00.000';
  lposition.face.template := tfacereclight;
  historyfn.face.template := tfacereclight;
  
    tbutton3.visible := true;
    tbutton2.visible := false;
    
     resetspectrum();
     InitDrawLive();

end;

procedure trecorderfo.ShowLevel;
var
  leftlev, rightlev: double;
   rat: integer;
begin
  vuLeft.Visible := True;
  vuRight.Visible := True;
  
 
  leftlev := uos_InputGetLevelLeft(therecplayer, Inputindex3);
  rightlev := uos_InputGetLevelRight(therecplayer, Inputindex3);
 
if waveforec.visible = true then begin
  
   if  (as_checked in waveforec.tmainmenu1.menu[0].state) then
   begin
            if (xreclive ) > (waveforec.Width - 10) then
          begin
            InitDrawLive();       
           end;
         
      waveforec.TrackBar1.Value := xreclive / (waveforec.TrackBar1.Width );  
     DrawLive(leftlev,rightlev);   
    end;
    
end;   

  if (leftlev >= 0) and (leftlev <= 1) then
  begin
{
    if leftlev < 0.80 then
      vuLeft.bar_face.template := mainfo.tfacegreen
    else
    if leftlev < 0.90 then
      vuLeft.bar_face.template := mainfo.tfaceorange
    else
      vuLeft.bar_face.template := mainfo.tfacered;
 }

    vuLeft.Value := leftlev;
  end;

  if (rightlev >= 0) and (rightlev <= 1) then
  begin
  {
    if rightlev < 0.80 then
      vuRight.bar_face.template := mainfo.tfacegreen
    else
    if rightlev < 0.90 then
      vuRight.bar_face.template := mainfo.tfaceorange
    else
      vuRight.bar_face.template := mainfo.tfacered;
      }
    vuRight.Value := rightlev;
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
  ShowLevel;

  if isrecording = False then
     ShowPosition;
  
   if (spectrumrecfo.spect1.Value = True) and (spectrumrecfo.Visible = True) and 
   (configfo.speccalc.Value = True) then
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
    
    if sentcue1.value = true then songplayerfo.historyfn.Value := historyfn.Value;
 
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
      isrecording := False;
      // OutputIndex3 := uos_AddIntoDevOut(PlayerIndex3) ;
      //// add a Output into device with default parameters



      OutputIndex3 := uos_AddIntoDevOut(therecplayer, -1, configfo.latplay.Value, uos_InputGetSampleRate(therecplayer, InputIndex3),
        uos_InputGetChannels(therecplayer, InputIndex3), samformat, 1024, -1);

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
      if configfo.speccalc.Value = True then
            for i := 1 to 10 do
     uos_InputAddFilter(therecplayer, InputIndex3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, 3, False, nil);
      
      
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
      InitDrawLive();
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
      if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
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
      infosfo.inforate.Caption := 'Sample Rate: ' + msestring(IntToStr(uos_InputGetSampleRate(therecplayerinfo, 0)));
      infosfo.infochan.Caption := 'Channels: ' + msestring(IntToStr(uos_InputGetChannels(therecplayerinfo, 0)));
      infosfo.infobpm.Caption := '';

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

procedure trecorderfo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if (trackbar1.tag = 1) and (inputlength > 0) then
  begin
    temptime := tottimerec * TrackBar1.Value;
    DecodeTime(temptime, ho, mi, se, ms);
    lposition.Value := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);

  end;

end;


procedure trecorderfo.visiblechangeev(const Sender: TObject);
begin

  if (assigned(mainfo)) and (assigned(dockpanel1fo)) and (assigned(dockpanel2fo)) and (assigned(dockpanel3fo))
 and (assigned(dockpanel4fo)) and (assigned(dockpanel5fo)) then
  begin
  if Visible then
  begin
    mainfo.tmainmenu1.menu[3].submenu[7].Caption := ' Hide Recorder ';
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[7].Caption := ' Show Recorder ';
    uos_Stop(therecplayer);
  end;
if norefresh = false then
begin
  mainfo.updatelayout();
  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayout();
  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayout();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayout();
    
 if dockpanel4fo.Visible then
    dockpanel4fo.updatelayout();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayout();   
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

    spectrumrecfo.tchartleft.traces[0].ydata := arrecl;
    spectrumrecfo.tchartright.traces[0].ydata := arrecr;
 
 end;
 
procedure trecorderfo.ShowSpectrum(const Sender: TObject);

var
  i, x: integer;

begin
    if uos_getstatus(therecplayer) > 0 then
    begin
      thearrayrec := uos_InputFiltersGetLevelArray(therecplayer, InputIndex3);
      x := 0;
      i := 0;
      while x < length(thearrayrec) - 1 do
      begin
        arrecl[i] := thearrayrec[x];
        arrecr[i] := thearrayrec[x + 1];
        x := x + 2;
        Inc(i);
      end;

      spectrumrecfo.tchartleft.traces[0].ydata := arrecl;
      spectrumrecfo.tchartright.traces[0].ydata := arrecr;
    end;
  end;

procedure trecorderfo.onplayercreate(const Sender: TObject);
var
  ordir: string;
begin

   SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
  [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

 Equalizer_Bands[1].lo_freq := 18;
  Equalizer_Bands[1].hi_freq := 46;
  Equalizer_Bands[1].Text := '31';
  Equalizer_Bands[2].lo_freq := 47;
  Equalizer_Bands[2].hi_freq := 94;
  Equalizer_Bands[2].Text := '62';
  Equalizer_Bands[3].lo_freq := 95;
  Equalizer_Bands[3].hi_freq := 188;
  Equalizer_Bands[3].Text := '125';
  Equalizer_Bands[4].lo_freq := 189;
  Equalizer_Bands[4].hi_freq := 375;
  Equalizer_Bands[4].Text := '250';
  Equalizer_Bands[5].lo_freq := 376;
  Equalizer_Bands[5].hi_freq := 750;
  Equalizer_Bands[5].Text := '500';
  Equalizer_Bands[6].lo_freq := 751;
  Equalizer_Bands[6].hi_freq := 1500;
  Equalizer_Bands[6].Text := '1K';
  Equalizer_Bands[7].lo_freq := 1501;
  Equalizer_Bands[7].hi_freq := 3000;
  Equalizer_Bands[7].Text := '2K';
  Equalizer_Bands[8].lo_freq := 3001;
  Equalizer_Bands[8].hi_freq := 6000;
  Equalizer_Bands[8].Text := '4K';
  Equalizer_Bands[9].lo_freq := 6001;
  Equalizer_Bands[9].hi_freq := 12000;
  Equalizer_Bands[9].Text := '8K';
  Equalizer_Bands[10].lo_freq := 12001;
  Equalizer_Bands[10].hi_freq := 20000;
  Equalizer_Bands[10].Text := '16K';

  setlength(arrecl, 10);
  setlength(arrecr, 10);


  Caption := 'Recorder';
  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 100000;
  Timerwait.Enabled := False;
  Timerwait.options := [to_single];
  Timerwait.ontimer := @ontimerwait;

  Timerrec := ttimer.Create(nil);
  Timerrec.interval := 100000;
  Timerrec.Enabled := False;
  //Timerrec.options := [to_single];
  Timerrec.ontimer := @ontimerrec;

  Timersent := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.ontimer := @ontimersent;
  Timersent.options := [to_single];

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
var
i : integer;
begin
  // if (bsavetofile.value = True) or (blistenin.value = True) then begin

  uos_Stop(therecplayer); // done by  uos_CreatePlayer() but faster if already done before (no check)

  if uos_CreatePlayer(therecplayer) then
  begin
    isrecording := True;
    tbutton2.Enabled := True;
    tbutton3.Enabled := False;
    btnStart.Enabled := False;

    historyfn.face.template := tfacereclight;

    lposition.face.template := mainfo.tfaceorange;

    //historyfn.font.color := cl_black;
 if sentcue1.value = true then songplayerfo.historyfn.Value := historyfn.Value;
   
    recpan.Visible := True;

    recpan.font.color := cl_black;
    
    if sentcue1.value = true then songplayerfo.historyfn.Value := historyfn.Value;
    
    if bsavetofile.Value then
      uos_AddIntoFile(therecplayer, PChar(ansistring(historyfn.Value)));

    OutputIndex3 := uos_AddIntoDevOut(therecplayer, -1, configfo.latrec.Value, -1, -1, -1, -1, -1);

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
    
     if configfo.speccalc.Value = True then
            for i := 1 to 10 do
     uos_InputAddFilter(therecplayer, InputIndex3, Equalizer_Bands[i].lo_freq, Equalizer_Bands[i].hi_freq, 1, 3, False, nil);


    /////// procedure to execute when stream is terminated
    uos_EndProc(therecplayer, @ClosePlayer1);
    ///// Assign the procedure of object to execute at end
    //////////// PlayerIndex : Index of a existing Player
    //////////// ClosePlayer1 : procedure of object to execute inside the loop
    
    llength.Value := '00:00:00.000';
    
    InitDrawLive();

    uos_Play(therecplayer);  /////// everything is ready to play...

    bsavetofile.Enabled := False;
    
    tbutton2.visible := true;
    tbutton3.visible := false;

    timenow := now;
    timerrec.Enabled := True;
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

procedure trecorderfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: boolean);
begin
  if (trealspinedit(Sender).tag = 9) then
  begin
    if avalue > 2 then
    begin
      hintlabel.Caption := '"' + IntToStr(trunc(avalue)) + '" is > 2.  Reset to 2.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
      if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
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
 else timersent.Enabled := True;
      avalue := 0.4;
    end;
  end
  else
  begin

    if avalue > 100 then
    begin
      hintlabel.Caption := '"' + IntToStr(trunc(avalue)) + '" is > 100.  Reset to 100.';
      if hintlabel.Width > hintlabel2.Width then
        hintpanel.Width := hintlabel.Width + 10
      else
        hintpanel.Width := hintlabel2.Width + 10;
      hintpanel.Visible := True;
       if timersent.Enabled then
  timersent.restart // to reset
 else timersent.Enabled := True;
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
 else timersent.Enabled := True;
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
 else timersent.Enabled := True;
    atext := '100';
  end;
end;

procedure trecorderfo.oncreated(const sender: TObject);
begin
if devin < 0 then
  begin
  tbutton3.enabled := false;
  btnStart.enabled := false;
  btinfos.enabled := false;
  end;
end;


end.
