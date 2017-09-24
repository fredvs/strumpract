unit commander;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msetimer,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,
 msedragglob,msesimplewidgets,msewidgets,mseact,msebitmap,msedataedits,
 msedatanodes,mseedit,msefiledialog,msegrids,mseificomp,mseificompglob,
 mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,msesys,sysutils,
 msegraphedits,msescrollbar;

type
 tcommanderfo = class(tdockform)
   timermix : ttimer;
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
   tfacecomp2: tfacecomp;
   volumeleft2: tslider;
   volumeright1: tslider;
   volumeright2: tslider;
   linkvol: tbooleanedit;
   linkvol2: tbooleanedit;
   tframecomp1: tframecomp;
   timagelist2: timagelist;
   timemix: trealspinedit;
   timagelist3: timagelist;
   tframecomp2: tframecomp;
   tbutton2: tbutton;
   tbutton3: tbutton;
   procedure formcreated(const sender: TObject);
   procedure visiblechangeev(const sender: TObject);
   
   procedure onplay(const sender: TObject);
   procedure onstop(const sender: TObject);
   procedure dopause(const sender: TObject);
   procedure doresume(const sender: TObject);
   procedure changevol(const sender: TObject);
   procedure onstartstop(const sender: TObject);
   procedure ontimermix(const Sender: TObject);
   procedure ondest(const sender: TObject);
 end;
var
 commanderfo: tcommanderfo;
 totmixinterval, incmixinterval : integer;
 initvolleft1, initvolright1, initvolleft2, initvolright2 : double;
 maxvolleft1, maxvolright1, maxvolleft2, maxvolright2 : double;
 thetypemix : integer = 0;
implementation
uses
songplayer, songplayer2,
main, commander_mfm;

procedure tcommanderfo.formcreated(const sender: TObject);
begin
        Timermix := ttimer.Create(nil);
        Timermix.interval := 100000;
        Timermix.Enabled := False;
        Timermix.ontimer := @ontimermix;
end;

procedure tcommanderfo.onstartstop(const sender: TObject);
begin

totmixinterval := trunc(timemix.value / 10);

incmixinterval := 0;

maxvolleft1 := 1;
maxvolright1 := 1;

maxvolleft2 := 1;
maxvolright2 := 1;

initvolleft1 := 0;
initvolright1 := 0;

initvolleft2 := 0;
initvolright2 := 0;

if tbutton(sender).tag = 0 then
begin
thetypemix := 0;
volumeleft1.value := 0;
volumeright1.value := 0;
//volumeleft2.value := 1;
//volumeright2.value := 1;
songplayerfo.doplayerstart(sender) ;
timermix.enabled := true;
end else
begin
thetypemix := 1;
volumeleft2.value := 0;
volumeright2.value := 0;
//volumeleft2.value := 1;
//volumeright2.value := 1;
songplayer2fo.doplayerstart(sender) ;
timermix.enabled := true;
end;
end;


 procedure tcommanderfo.ontimermix(const Sender: TObject);
 var
 muststop : integer = 0;
begin 
timermix.enabled := false;
 //  application.lock();
  if thetypemix = 0 then begin
if incmixinterval < totmixinterval then
begin
inc(incmixinterval);

if (incmixinterval / totmixinterval) + initvolleft1 < maxvolleft1 then
volumeleft1.value := (incmixinterval / totmixinterval) + initvolleft1 else
volumeleft1.value := maxvolleft1  ;

if (incmixinterval / totmixinterval) + initvolright1  < maxvolright1 then
volumeright1.value := (incmixinterval / totmixinterval) + initvolright1  else
volumeright1.value := maxvolright1;

if ((totmixinterval-incmixinterval) / totmixinterval) - initvolleft2 > 0 then
volumeleft2.value := ((totmixinterval-incmixinterval) / totmixinterval) - initvolleft2 else
begin
volumeleft2.value := 0  ;
songplayer2fo.doplayerstop(sender) ;
muststop := 1;
end;

if ((totmixinterval-incmixinterval) / totmixinterval) - initvolright2 > 0 then
volumeright2.value := ((totmixinterval-incmixinterval) / totmixinterval) - initvolright2 
else
begin
volumeright2.value := 0  ;
songplayer2fo.doplayerstop(sender) ;
muststop := 1;
end;

if muststop = 0 then
timermix.enabled := true;
end else 
begin
volumeright2.value := 0  ;
songplayer2fo.doplayerstop(sender) ;
end;
 end else  /// player 2 --> 1
begin

if incmixinterval < totmixinterval  then
begin
inc(incmixinterval);

if (incmixinterval / totmixinterval) + initvolleft2 < maxvolleft2 then
volumeleft2.value := (incmixinterval / totmixinterval) + initvolleft2 else
volumeleft2.value := maxvolleft2  ;

if (incmixinterval / totmixinterval) + initvolright2  < maxvolright2 then
volumeright2.value := (incmixinterval / totmixinterval) + initvolright2  else
volumeright2.value := maxvolright2;

if ((totmixinterval-incmixinterval) / totmixinterval) - initvolleft1 > 0 then
volumeleft1.value := ((totmixinterval-incmixinterval) / totmixinterval) - initvolleft1 else
begin
volumeleft1.value := 0  ;
songplayerfo.doplayerstop(sender) ;
muststop := 1;
end;

if ((totmixinterval-incmixinterval) / totmixinterval) - initvolright1 > 0 then
volumeright1.value := ((totmixinterval-incmixinterval) / totmixinterval) - initvolright1 
else
begin
volumeright1.value := 0  ;
songplayerfo.doplayerstop(sender) ;
muststop := 1;
end;

if muststop = 0 then
timermix.enabled := true;
end else 
begin
volumeright1.value := 0  ;
songplayerfo.doplayerstop(sender) ;
end;
end;
     
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

procedure tcommanderfo.ondest(const sender: TObject);
begin
Timermix.free;
end;

end.
