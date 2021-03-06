program strumpract;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}

uses
  // cmem,
 {$ifdef FPC} {$ifdef unix} cthreads, {$endif} {$endif}
  Math, 
  filelistform,
  msegui,
  main,
  aboutform,
  mseact,
  drums,
  songplayer,
  commander,
  config,
  guitars,
  recorder,
  imagedancer,
  infos,
  status,
  spectrum1,
  waveform,
  randomnote,
  equalizer,
  dockpanel1;

begin
    SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
  [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);
  
  application.createform(tconfigfo, configfo);

  application.createform(tspectrum1fo, spectrum1fo);
  application.createform(tspectrum1fo, spectrum2fo);
  application.createform(tspectrum1fo, spectrumrecfo);
    
  spectrum1fo.Caption := 'Spectrum Player 1';
  spectrum2fo.Caption := 'Spectrum Player 2';
  
  spectrum1fo.Spect1.frame.caption := 'Spectrum Player 1';
  spectrum2fo.Spect1.frame.caption := 'Spectrum Player 2';
  spectrumrecfo.Spect1.frame.caption := 'Spectrum Recorder';
 
  spectrum1fo.dragdock.Caption := 'Sp1';
  spectrum2fo.dragdock.Caption := 'Sp2';
  
  spectrumrecfo.Caption := 'Spectrum Recorder';
   spectrumrecfo.dragdock.Caption := 'SpR';
 
  application.createform(tequalizerfo, equalizerfo1);
  application.createform(tequalizerfo, equalizerfo2);
  application.createform(tequalizerfo, equalizerforec);
    
  equalizerfo1.dragdock.Caption := 'Eq1';
  equalizerfo2.dragdock.Caption := 'Eq2';
  equalizerforec.dragdock.Caption := 'EqR';
  
  equalizerfo1.Caption := 'Equalizer Player 1';
  equalizerfo2.Caption := 'Equalizer Player 2';
  equalizerforec.Caption := 'Equalizer Recorder';
 
  equalizerfo1.eqen.frame.caption := 'Equalizer Player 1';
  equalizerfo2.eqen.frame.caption := 'Equalizer Player 2';
  equalizerforec.eqen.frame.caption := 'Equalizer Recorder';
  
  application.createform(tfilelistfo, filelistfo);

  filelistfo.dragdock.Caption := 'Fil';
  application.createform(tdrumsfo, drumsfo);

  drumsfo.dragdock.Caption := 'Dru';
  
  drumsfo.lesson1.hint := 'First lesson.' + #10 +
  'Count slowly 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, ...,' + #10 +
 'With the stick, hit the closed hat on each count.'  + #10 +
  'Count loud with your voice too.' + #10 +
  'Dont stop this for 1 minut.' ;
  
  drumsfo.lesson2.hint := 'Second lesson.' + #10 +
  'Do the same as first lesson and on count "1"' + #10 +
  'add a "boom" with your right foot on the Bass Drum.'  + #10 +
  'Still count loud with your voice.' + #10 +
  'Dont stop this for 1 minut.' ;
 
    drumsfo.lesson3.hint := '3th lesson.' + #10 +
   'Do the same as second lesson and on count "3"' + #10 +
   'add a "clack" on the Snare Drum with the other stick.'  + #10 +
   'This is the most difficult.' + #10 +
   'Still count loud with your voice.' + #10 +
   'Dont stop this for 1 minut.' ;
  
  drumsfo.lesson4.hint := 'Last lesson.' + #10 +
  'Do the same as 3th lesson but increasing the tempo.' + #10 +
  'On count "2" you may add a "boom" on the Bass Drum.'  + #10 +
  'Congratulation, you are a drummer now. ;-)'  ;
  
   application.createform(tsongplayerfo, songplayerfo);

  application.createform(tsongplayerfo, songplayer2fo);

  songplayerfo.Caption := 'Player 1';
  songplayer2fo.Caption := 'Player 2';

  songplayerfo.tstringdisp2.Value := 'Player 1';
  songplayer2fo.tstringdisp2.Value := 'Player 2';

  songplayerfo.dragdock.Caption := 'Pl1';
  songplayer2fo.dragdock.Caption := 'Pl2';

  songplayerfo.tgroupbox1.hint := ' Player 1 ';
  songplayer2fo.tgroupbox1.hint := ' Player 2 ';

  application.createform(twavefo, wavefo);
  wavefo.Caption := 'Wave Player 1';
   wavefo.tag := 1;
  wavefo.dragdock.Caption := 'Wa1';
  //wavefo.waveon.frame.Caption := 'Enable Wave 1';

  application.createform(twavefo, wavefo2);
  wavefo2.Caption := 'Wave Player 2';
   wavefo2.tag := 2;
  wavefo2.dragdock.Caption := 'Wa2';
  //wavefo2.waveon.frame.Caption := 'Enable Wave 2';
  
   application.createform(twavefo, waveforec);
  waveforec.Caption := 'Wave Recorder';
  waveforec.dragdock.Caption := 'WaR';
  
  with  waveforec do begin
 tmainmenu1.menu[1].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[2].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[3].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[4].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[5].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[6].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[7].state := [as_invisible,as_localinvisible];
tmainmenu1.menu[8].state := [as_invisible,as_localinvisible];
end;
    
    application.createform(tcommanderfo, commanderfo);
  commanderfo.dragdock.Caption := 'Com';

  application.createform(trecorderfo, recorderfo);
  recorderfo.dragdock.Caption := 'Rec';

  application.createform(tguitarsfo, guitarsfo);

  guitarsfo.dragdock.Caption := 'Gui';

  application.createform(taboutfo, aboutfo);
  application.createform(tinfosfo, infosfo);
  application.createform(tstatusfo, statusfo);

  application.createform(tdockpanel1fo, dockpanel1fo);
  application.createform(tdockpanel1fo, dockpanel2fo);
  application.createform(tdockpanel1fo, dockpanel3fo);
  application.createform(tdockpanel1fo, dockpanel4fo);
  application.createform(tdockpanel1fo, dockpanel5fo);
  
  dockpanel1fo.Caption := 'Dock Panel 1';
  dockpanel2fo.Caption := 'Dock Panel 2';
  dockpanel3fo.Caption := 'Dock Panel 3';
  dockpanel4fo.Caption := 'Dock Panel 4';
  dockpanel5fo.Caption := 'Dock Panel 5';
  
  application.createform(trandomnotefo, randomnotefo);
  application.createform(timagedancerfo, imagedancerfo);

  application.createform(tmainfo, mainfo);

  application.run;
end.
