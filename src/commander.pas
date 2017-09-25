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
   tgroupboxplayers: tgroupbox;
   btnStop: tbutton;
   btnPause: tbutton;
   btnResume: tbutton;
   btnStart: tbutton;
   btnStop2: tbutton;
   btnPause2: tbutton;
   btnResume2: tbutton;
   btnStart2: tbutton;
   volumeleft1: tslider;
   tfacecomp7: tfacecomp;
   tfacecomp2: tfacecomp;
   volumeright1: tslider;
   linkvol: tbooleanedit;
   tframecomp1: tframecomp;
   timagelist2: timagelist;
   timemix: trealspinedit;
   timagelist3: timagelist;
   tframecomp2: tframecomp;
   tbutton2: tbutton;
   tbutton3: tbutton;
   linkvol2: tbooleanedit;
   tgroupboxdrums: tgroupbox;
   loop_start: tbutton;
   loop_stop: tbutton;
   loop_resume: tbutton;
   tslider2: tslider;
   tlabel1: tlabel;
   tlabel2: tlabel;
   tgroupboxinput: tgroupbox;
   tslider3: tslider;
   tbutton7: tbutton;
   vuRight: tgroupbox;
   vuLeft: tgroupbox;
   vuin: tbooleanedit;
   vuRight2: tgroupbox;
   volumeright2: tslider;
   volumeleft2: tslider;
   vuLeft2: tgroupbox;
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
   procedure onsetinput(const sender: TObject);
   procedure onchangevolinput(const sender: TObject);
   procedure doplaydrums(const sender: TObject);
   procedure dopausedrums(const sender: TObject);
   procedure doresumedrums(const sender: TObject);
   procedure onchangevoldrums(const sender: TObject);
 end;
var
 commanderfo: tcommanderfo;
 totmixinterval, incmixinterval, InputIndex4, OutputIndex4 : integer;
 initvolleft1, initvolright1, initvolleft2, initvolright2 : double;
 maxvolleft1, maxvolright1, maxvolleft2, maxvolright2 : double;
 thetypemix : integer = 0;
 theinput : integer = 26;
 
 
implementation
uses
songplayer, songplayer2, drums, uos_flat,
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

if hasinit = 1 then begin 
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
end;

procedure tcommanderfo.ondest(const sender: TObject);
begin
Timermix.free;
end;

procedure tcommanderfo.onsetinput(const sender: TObject);
begin

if hasinit = 1 then begin 
if tbutton(sender).tag = 0 then
begin

tbutton(sender).face.template := mainfo.tfacered;

  tslider3.enabled := true;
  uos_Stop(theinput) ; 
 
    if uos_CreatePlayer(theinput) then
   begin
  // writeln('ok create');
  tbutton(sender).tag := 1 ;
  
  OutputIndex4 :=  uos_AddIntoDevOut(theinput); 

// writeln('OutputIndex4 = ' + inttostr(OutputIndex4));
 // uos_outputsetenable(theinput,OutputIndex4,true); 
   
   InputIndex4 := uos_AddFromDevIn(theinput);
   
  //  writeln('InputIndex4 = ' + inttostr(InputIndex4));
     
    uos_InputAddDSP1ChanTo2Chan(theinput, InputIndex4);
 
    uos_InputSetLevelEnable(theinput, InputIndex4, 2) ;
 
    uos_InputAddDSPVolume(theinput, InputIndex4, 1, 1);
    
  //   uos_LoopProcIn(theinput, InputIndex4, @LoopProcPlayer1);

  uos_InputSetDSPVolume(theinput, InputIndex4, tslider3.value, tslider3.value, True);
  
   /////// procedure to execute when stream is terminated
  //   uos_EndProc(therecplayer, @ClosePlayer1);
  
    uos_Play(theinput);  /////// everything is ready to play...
   
 //   bsavetofile.Enabled := false;
      
   end;
end
else
begin
// writeln('uos_Stop = ' + inttostr(theinput));
 tbutton(sender).tag := 0 ;
 tbutton(sender).face.template := mainfo.tfacecomp6;
 uos_Stop(theinput) ;
end;
end;
end;

procedure tcommanderfo.onchangevolinput(const sender: TObject);
begin
if hasinit = 1 then begin 
  uos_InputSetDSPVolume(theinput, Inputindex4,
   tslider3.value, tslider3.value, True);
end;
end;

procedure tcommanderfo.doplaydrums(const sender: TObject);
begin
drumsfo.dostart(sender);
end;

procedure tcommanderfo.dopausedrums(const sender: TObject);
begin
drumsfo.dostop(sender);
end;

procedure tcommanderfo.doresumedrums(const sender: TObject);
begin
drumsfo.doresume(sender);
end;

procedure tcommanderfo.onchangevoldrums(const sender: TObject);
begin
if hasinit = 1 then drumsfo.volumedrums.value  := trunc(tslider2.value* 100);
end;



end.
