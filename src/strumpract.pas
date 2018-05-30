program strumpract;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}
uses
 {$ifdef FPC}{$ifdef unix} cthreads,{$endif}{$endif} 
filelistform, msegui, main, aboutform, drums, songplayer, songplayer2, commander, config,
guitars, recorder,infos, spectrum1, dockpanel1;
begin
   application.createform(tconfigfo,configfo);
  
   application.createform(tspectrum1fo, spectrum1fo);
   application.createform(tspectrum1fo, spectrum2fo);
   
   spectrum1fo.caption := 'Spectrum Player 1';
    spectrum2fo.caption := 'Spectrum Player 2';
    
    spectrum1fo.dragdock.caption := ' Spec1 ';
    spectrum2fo.dragdock.caption := ' Spec2 ';
    
    spectrum1fo.groupbox1.frame.caption := 'Player 1 Left';
spectrum1fo.groupbox2.frame.caption := 'Player 1 Right';
spectrum2fo.groupbox1.frame.caption := 'Player 2 Left';
spectrum2fo.groupbox2.frame.caption := 'Player 2 Right';
  
  application.createform(tfilelistfo,filelistfo);
   application.createform(tdrumsfo,drumsfo);
  application.createform(tsongplayerfo,songplayerfo);
  application.createform(tsongplayer2fo,songplayer2fo);
  application.createform(tcommanderfo,commanderfo);
  application.createform(trecorderfo,recorderfo);
  application.createform(tguitarsfo,guitarsfo);
  application.createform(taboutfo,aboutfo);
  application.createform(tinfosfo,infosfo);
    application.createform(tdockpanel1fo,dockpanel1fo);
    application.createform(tdockpanel1fo,dockpanel2fo);
    application.createform(tdockpanel1fo,dockpanel3fo);
    
    application.createform(tmainfo,mainfo);
  
  
 application.run;
end.
