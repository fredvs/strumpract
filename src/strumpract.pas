program strumpract;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}

 {$PACKRECORDS C}

uses
 {$ifdef FPC} {$ifdef unix} cthreads, BaseUnix,   {$endif} {$endif}

  Classes,
  Math,
  SysUtils,
  filelistform,
  msegui,
  main,
  aboutform,
  synthe,
  mseact,
  drums,
  songplayer,
  commander,
  config,
  guitars,
  recorder,
  imagedancer,
  infosd,
  status,
  piano,
  conflang,
  spectrum1,
  waveform,
  randomnote,
  equalizer,
  findmessage,
  dialogfiles,
  dockpanel1;

{$ifdef unix}
var
fs: TFileStream;
ordir: string;
{$endif}

begin
{$ifdef unix}  
  ordir := ExtractFilePath(ParamStr(0)) + 
      directoryseparator + 'ini' 
    + directoryseparator + 'log.txt' ;
    
  fs := TFileStream.Create(ordir, fmOpenReadWrite or fmCreate);
  FpDup2(fs.Handle, StdErrorHandle);
   
{$endif}

  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  application.createform(tconfigfo, configfo);

  application.createform(tdrumsfo, drumsfo);

  drumsfo.dragdock.Caption := 'Dru';
  application.createform(tsongplayerfo, songplayerfo);

  application.createform(tsongplayerfo, songplayer2fo);

  songplayerfo.tag  := 0;
  songplayer2fo.tag := 1;

  songplayerfo.dragdock.Caption  := 'Pl1';
  songplayer2fo.dragdock.Caption := 'Pl2';

  application.createform(tspectrum1fo, spectrum1fo);
  application.createform(tspectrum1fo, spectrum2fo);
  application.createform(tspectrum1fo, spectrumrecfo);

  spectrum1fo.tag := 0;
  spectrum2fo.tag := 1;

  spectrum1fo.dragdock.Caption := 'Sp1';
  spectrum2fo.dragdock.Caption := 'Sp2';

  spectrumrecfo.dragdock.Caption := 'SpR';

  spectrumrecfo.tag := 2;

  application.createform(tequalizerfo, equalizerfo1);
  application.createform(tequalizerfo, equalizerfo2);
  application.createform(tequalizerfo, equalizerforec);

  equalizerfo1.dragdock.Caption   := 'Eq1';
  equalizerfo2.dragdock.Caption   := 'Eq2';
  equalizerforec.dragdock.Caption := 'EqR';

  equalizerfo1.tag   := 0;
  equalizerfo2.tag   := 1;
  equalizerforec.tag := 2;

  application.createform(tfilelistfo, filelistfo);

  filelistfo.dragdock.Caption := 'Fil';

  application.createform(twavefo, wavefo);
  wavefo.tag := 0;
  wavefo.dragdock.Caption := 'Wa1';

  application.createform(twavefo, wavefo2);
  wavefo2.tag := 1;
  wavefo2.dragdock.Caption := 'Wa2';

  application.createform(twavefo, waveforec);
  waveforec.tag := 2;
  waveforec.dragdock.Caption := 'WaR';

  with  waveforec do
  begin
    tmainmenu1.menu[1].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[2].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[3].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[4].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[5].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[6].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[7].state := [as_invisible, as_localinvisible];
    tmainmenu1.menu[8].state := [as_invisible, as_localinvisible];
  end;

  application.createform(tcommanderfo, commanderfo);
  commanderfo.dragdock.Caption := 'Com';

  application.createform(trecorderfo, recorderfo);
  recorderfo.dragdock.Caption := 'Rec';
  recorderfo.tag := 2;

  application.createform(tguitarsfo, guitarsfo);

  guitarsfo.dragdock.Caption := 'Gui';

  application.createform(taboutfo, aboutfo);
  application.createform(tinfosdfo, infosdfo);
  application.createform(tinfosdfo, infosdfo2);

  infosdfo.dragdock.Caption := 'In1';
  infosdfo.tag := 0;

  infosdfo2.dragdock.Caption := 'In2';
  infosdfo2.tag := 1;

  application.createform(tstatusfo, statusfo);

  application.createform(tdockpanel1fo, dockpanel1fo);
  application.createform(tdockpanel1fo, dockpanel2fo);
  application.createform(tdockpanel1fo, dockpanel3fo);
  application.createform(tdockpanel1fo, dockpanel4fo);
  application.createform(tdockpanel1fo, dockpanel5fo);

  dockpanel1fo.tag := 0;
  dockpanel2fo.tag := 1;
  dockpanel3fo.tag := 2;
  dockpanel4fo.tag := 3;
  dockpanel5fo.tag := 4;

  application.createform(trandomnotefo, randomnotefo);
  application.createform(timagedancerfo, imagedancerfo);

  imagedancerfo.dragdock.Caption := 'Dan';

  application.createform(tfindmessagefo, findmessagefo);
  application.createform(tdialogfilesfo, dialogfilesfo);

  application.createform(tconflangfo, conflangfo);

  dialogfilesfo.icon := equalizerfo1.icon;

  application.createform(tsynthefo, synthefo);
  application.createform(tpianofo, pianofo);
  pianofo.icon := synthefo.icon;
  pianofo.dragdock.Caption := 'Pia';
  synthefo.dragdock.Caption := 'Noi';

  application.createform(tmainfo, mainfo);
  conflangfo.icon := mainfo.icon;
  statusfo.icon   := mainfo.icon;

  application.run;

{$ifdef unix}
  fs.Free;
  //  if fileexists(ordir) then deletefile(ordir);
{$endif}

end.

