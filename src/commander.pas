unit commander;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,msedragglob,
 msesimplewidgets,msewidgets,mseact,msebitmap,msedataedits,msedatanodes,mseedit,
 msefiledialog,msegrids,mseificomp,mseificompglob,mseifiglob,mselistbrowser,
 msestatfile,msestream,msestrings,msesys,sysutils,msegraphedits,msescrollbar;

type
 tcommanderfo = class(tdockform)
   tgroupbox1: tgroupbox;
   btnStop: tbutton;
   btnPause: tbutton;
   btnResume: tbutton;
   tlabel28: tlabel;
   btnStart: tbutton;
   btnStop2: tbutton;
   btnPause2: tbutton;
   btnResume2: tbutton;
   btnStart2: tbutton;
   tlabel2: tlabel;
   volumeleft1: tslider;
   tfacecomp7: tfacecomp;
   tbutton2: tbutton;
   tfacecomp2: tfacecomp;
   volumeleft2: tslider;
   volumeright1: tslider;
   volumeright2: tslider;
   linkvol: tbooleanedit;
   linkvol2: tbooleanedit;
   tframecomp1: tframecomp;
   timagelist2: timagelist;
   tbutton3: tbutton;
   procedure formcreated(const sender: TObject);
   procedure visiblechangeev(const sender: TObject);
   
   procedure onplay(const sender: TObject);
   procedure onstop(const sender: TObject);
   procedure dopause(const sender: TObject);
   procedure doresume(const sender: TObject);
   procedure changevol(const sender: TObject);
   procedure onstartstop(const sender: TObject);
 end;
var
 commanderfo: tcommanderfo;
implementation
uses
songplayer, songplayer2,
main, commander_mfm;

procedure tcommanderfo.formcreated(const sender: TObject);
begin

end;

procedure tcommanderfo.visiblechangeev(const sender: TObject);
begin
mainfo.updatelayout();
end;

procedure tcommanderfo.onplay(const sender: TObject);
begin
if Tbutton(sender).tag = 0 then
songplayerfo.doplayerstart(sender) else
songplayer2fo.doplayerstart(sender);
end;

procedure tcommanderfo.onstop(const sender: TObject);
begin
if Tbutton(sender).tag = 0 then
songplayerfo.doplayerstop(sender) else
songplayer2fo.doplayerstop(sender);
end;

procedure tcommanderfo.dopause(const sender: TObject);
begin
if Tbutton(sender).tag = 0 then
songplayerfo.doplayerpause(sender) else
songplayer2fo.doplayerpause(sender);
end;

procedure tcommanderfo.doresume(const sender: TObject);
begin
if Tbutton(sender).tag = 0 then
songplayerfo.doplayeresume(sender) else
songplayer2fo.doplayeresume(sender);
end;

procedure tcommanderfo.changevol(const sender: TObject);
begin
if (tslider(sender).tag = 0) or (tslider(sender).tag = 1) then
begin
if linkvol.value = true then
begin
if (tslider(sender).tag = 0) 
then volumeright1.value := volumeleft1.value else
volumeleft1.value := volumeright1.value;
songplayerfo.edvolleft.value  := trunc(volumeleft1.value* 100);
songplayerfo.edvolright.value  := trunc(volumeright1.value* 100);
end else
if (tslider(sender).tag = 0) then
songplayerfo.edvolleft.value  := trunc(volumeleft1.value* 100) else
songplayerfo.edvolright.value  := trunc(volumeright1.value* 100);
//songplayerfo.changevolume(sender)

end else
begin
if linkvol2.value = true then
begin
if (tslider(sender).tag = 2) 
then volumeright2.value := volumeleft2.value else
volumeleft2.value := volumeright2.value;
songplayer2fo.edvolleft.value  := trunc(volumeleft2.value* 100);
songplayer2fo.edvolright.value  := trunc(volumeright2.value* 100);
end else
if (tslider(sender).tag = 2) then
songplayer2fo.edvolleft.value  := trunc(volumeleft2.value* 100) else
songplayer2fo.edvolright.value  := trunc(volumeright2.value* 100);
//songplayerfo.changevolume(sender)
end;
end;

procedure tcommanderfo.onstartstop(const sender: TObject);
begin
if tbutton(sender).tag = 0 then
begin
songplayer2fo.doplayerstop(sender) ;
songplayerfo.doplayerstart(sender) ;
end else
begin
songplayerfo.doplayerstop(sender) ;
songplayer2fo.doplayerstart(sender) ;
end;
end;


end.
