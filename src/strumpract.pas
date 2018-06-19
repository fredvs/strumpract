program strumpract;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}
uses
 {$ifdef FPC} {$ifdef unix} cthreads, {$endif} {$endif}
  filelistform,
  msegui,
  main,
  aboutform,
  drums,
  songplayer,
  commander,
  config,
  guitars,
  recorder,
  infos,
  spectrum1,
  waveform,
  dockpanel1;

begin
  application.createform(tconfigfo, configfo);

  application.createform(tspectrum1fo, spectrum1fo);
  application.createform(tspectrum1fo, spectrum2fo);

  spectrum1fo.Caption := 'Spectrum Player 1';
  spectrum2fo.Caption := 'Spectrum Player 2';

  spectrum1fo.dragdock.Caption := 'Spe1';
  spectrum2fo.dragdock.Caption := 'Spe2';

  spectrum1fo.groupbox1.frame.Caption := 'Player 1 Left';
  spectrum1fo.groupbox2.frame.Caption := 'Player 1 Right';
  spectrum2fo.groupbox1.frame.Caption := 'Player 2 Left';
  spectrum2fo.groupbox2.frame.Caption := 'Player 2 Right';

  application.createform(tfilelistfo, filelistfo);

  filelistfo.dragdock.Caption := 'File';
  application.createform(tdrumsfo, drumsfo);

  drumsfo.dragdock.Caption := 'Drums';
  application.createform(tsongplayerfo, songplayerfo);

  application.createform(tsongplayerfo, songplayer2fo);

  songplayerfo.Caption := 'Player 1';
  songplayer2fo.Caption := 'Player 2';

  songplayerfo.tstringdisp2.Value := 'Player 1';
  songplayer2fo.tstringdisp2.Value := 'Player 2';

  songplayerfo.dragdock.Caption := 'Pla1';
  songplayer2fo.dragdock.Caption := 'Pla2';

  songplayerfo.tgroupbox1.hint := ' Player 1 ';
  songplayer2fo.tgroupbox1.hint := ' Player 2 ';

  application.createform(twavefo, wavefo);
  wavefo.Caption := 'Wave Player 1';
  wavefo.dragdock.Caption := 'Wav1';
  //wavefo.waveon.frame.Caption := 'Enable Wave 1';

  application.createform(twavefo, wavefo2);
  wavefo2.Caption := 'Wave Player 2';
  wavefo2.dragdock.Caption := 'Wav2';
  //wavefo2.waveon.frame.Caption := 'Enable Wave 2';

  application.createform(tcommanderfo, commanderfo);
  commanderfo.dragdock.Caption := 'Com';

  application.createform(trecorderfo, recorderfo);
  recorderfo.dragdock.Caption := 'Rec';

  application.createform(tguitarsfo, guitarsfo);

  guitarsfo.dragdock.Caption := 'Guit';

  application.createform(taboutfo, aboutfo);
  application.createform(tinfosfo, infosfo);

  application.createform(tdockpanel1fo, dockpanel1fo);
  application.createform(tdockpanel1fo, dockpanel2fo);
  application.createform(tdockpanel1fo, dockpanel3fo);

  dockpanel1fo.Caption := 'Dock Panel 1';
  dockpanel2fo.Caption := 'Dock Panel 2';
  dockpanel3fo.Caption := 'Dock Panel 3';

  application.createform(tmainfo, mainfo);

  application.run;
end.
