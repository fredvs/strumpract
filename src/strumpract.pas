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
filelistform, msegui, main, aboutform, drums, songplayer, songplayer2, guitars, recorder,infos;
begin

  application.createform(tfilelistfo,filelistfo);
  application.createform(tdrumsfo,drumsfo);
  application.createform(tsongplayerfo,songplayerfo);
  application.createform(tsongplayer2fo,songplayer2fo);
  application.createform(trecorderfo,recorderfo);
  application.createform(tguitarsfo,guitarsfo);
  application.createform(taboutfo,aboutfo);
  application.createform(tinfosfo,infosfo);
  application.createform(tmainfo,mainfo);
  
 application.run;
end.
