unit commander;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msetimer, msegraphics, msegraphutils, mseevent, mseclasses, mseforms,
 msedock,msedragglob, msesimplewidgets, msewidgets, mseact, msebitmap,
 msedataedits,msedatanodes, mseedit, msefiledialog, msegrids, mseificomp,
 mseificompglob,mseifiglob, mselistbrowser, msestatfile, msestream, msestrings,
 msesys, SysUtils,msegraphedits, msescrollbar,msedispwidgets,mserichstring;

type
  tcommanderfo = class(tdockform)
    timermix: ttimer;
    tgroupboxplayers: tgroupbox;
    btnStop: TButton;
    btnPause: TButton;
    btnResume: TButton;
    btnStart: TButton;
    volumeleft1: tslider;
    tfacecomp7: tfacecomp;
    tfacecomp2: tfacecomp;
    volumeright1: tslider;
    tframecomp1: tframecomp;
    timagelist2: timagelist;
    timemix: trealspinedit;
    timagelist3: timagelist;
    tframecomp2: tframecomp;
    tbutton2: TButton;
    tbutton3: TButton;
    tgroupboxdrums: tgroupbox;
    loop_start: TButton;
    loop_stop: TButton;
    loop_resume: TButton;
    tslider2: tslider;
    tgroupboxinput: tgroupbox;
    tslider3: tslider;
    butinput: TButton;
    volumeright2: tslider;
    volumeleft2: tslider;
   tfaceslider: tfacecomp;
   tfacebutton: tfacecomp;
   btncue: tbutton;
   btnStart2: tbutton;
   btncue2: tbutton;
   btnStop2: tbutton;
   btnPause2: tbutton;
   btnResume2: tbutton;
   linkvol: tbutton;
   linkvol2: tbutton;
   vuin: tbutton;
   nameplayers: tstringdisp;
   namedrums: tstringdisp;
   tfacegriptab: tfacecomp;
   tfacesliderdark: tfacecomp;
   vuLeft: tprogressbar;
   vuright: tprogressbar;
   vuright2: tprogressbar;
   vuLeft2: tprogressbar;
   automix: tbutton;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplay(const Sender: TObject);
    procedure onstop(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doresume(const Sender: TObject);
    procedure setvolume(const Sender: TObject);
    procedure onstartstop(const Sender: TObject);
    procedure ontimermix(const Sender: TObject);
    procedure ondest(const Sender: TObject);
    procedure onsetinput(const Sender: TObject);
    procedure onchangevolinput(const Sender: TObject);
    procedure doplaydrums(const Sender: TObject);
    procedure dopausedrums(const Sender: TObject);
    procedure doresumedrums(const Sender: TObject);
    procedure onchangevoldrums(const Sender: TObject);
   procedure setlr1(const sender: TObject);
   procedure setlr2(const sender: TObject);
   procedure setvu(const sender: TObject);
   procedure setautomix(const sender: TObject);
  end;

var
  commanderfo: tcommanderfo;
  totmixinterval, incmixinterval, InputIndex4, OutputIndex4: integer;
  initvolleft1, initvolright1, initvolleft2, initvolright2: double;
  maxvolleft1, maxvolright1, maxvolleft2, maxvolright2: double;
  thetypemix: integer = 0;
  theinput: integer = 26;


implementation

uses
  songplayer, songplayer2, drums, filelistform, uos_flat, config,
  main, commander_mfm;

procedure tcommanderfo.formcreated(const Sender: TObject);
begin
  Timermix := ttimer.Create(nil);
  Timermix.interval := 100000;
  Timermix.Enabled := False;
  Timermix.ontimer := @ontimermix;
end;

procedure tcommanderfo.onstartstop(const Sender: TObject);
var
fromplay : integer;
begin

  totmixinterval := trunc(timemix.Value / 10);

  incmixinterval := 0;

  maxvolleft1 := 1;
  maxvolright1 := 1;

  maxvolleft2 := 1;
  maxvolright2 := 1;

  initvolleft1 := 0;
  initvolright1 := 0;

  initvolleft2 := 0;
  initvolright2 := 0;
  
   if sender <> nil then
  begin
  if (TButton(Sender).tag = 0) then
  fromplay := 0 else fromplay := 1;
  end else
  begin
  if hasmixed1 = true then 
   fromplay := 1 else
    fromplay := 0;
  end;
 
 
 if fromplay = 0 then 
  begin
   tbutton2.face.template := mainfo.tfacebutgray;
    tbutton3.face.template := mainfo.tfaceorange;
  
  filelistfo.tbutton2.face.template := mainfo.tfaceorange;
   filelistfo.tbutton1.face.template := mainfo.tfaceplayer;
  
      //tbutton3.focused := true;
 
    thetypemix := 0;
    volumeleft1.Value := 0;
    volumeright1.Value := 0;
    //volumeleft2.value := 1;
    //volumeright2.value := 1;
    
       if  (iscue1 = true) or (uos_GetStatus(theplayer) = 2 ) then
        songplayerfo.doplayeresume(Sender) else
    songplayerfo.doplayerstart(Sender);
   
   timermix.Enabled := True;
  end
  else
   begin
  
    thetypemix := 1;
    volumeleft2.Value := 0;
    volumeright2.Value := 0;
   tbutton3.face.template := mainfo.tfacebutgray;
    tbutton2.face.template := mainfo.tfaceorange; 
     filelistfo.tbutton1.face.template := mainfo.tfaceorange;
   filelistfo.tbutton2.face.template := mainfo.tfaceplayer;
    //volumeleft2.value := 1;
    //volumeright2.value := 1;

    if  (iscue2 = true) or (uos_GetStatus(theplayer2) = 2 ) then
 songplayer2fo.doplayeresume(Sender) else
  songplayer2fo.doplayerstart(Sender);
    timermix.Enabled := True;
  
  end;
end;


procedure tcommanderfo.ontimermix(const Sender: TObject);
var
  muststop: integer = 0;
begin
  timermix.Enabled := False;
  //  application.lock();
  if thetypemix = 0 then
  begin
    if incmixinterval < totmixinterval then
    begin
      Inc(incmixinterval);

      if (incmixinterval / totmixinterval) + initvolleft1 < maxvolleft1 then
        volumeleft1.Value := (incmixinterval / totmixinterval) + initvolleft1
      else
        volumeleft1.Value := maxvolleft1;

      if (incmixinterval / totmixinterval) + initvolright1 < maxvolright1 then
        volumeright1.Value := (incmixinterval / totmixinterval) + initvolright1
      else
        volumeright1.Value := maxvolright1;

      if ((totmixinterval - incmixinterval) / totmixinterval) - initvolleft2 > 0 then
        volumeleft2.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolleft2
      else
      begin
        volumeleft2.Value := 0;
        songplayer2fo.doplayerstop(Sender);
        muststop := 1;
      end;

      if ((totmixinterval - incmixinterval) / totmixinterval) - initvolright2 > 0 then
        volumeright2.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolright2
      else
      begin
        volumeright2.Value := 0;
        songplayer2fo.doplayerstop(Sender);
        muststop := 1;
      end;

      if muststop = 0 then
        timermix.Enabled := True;
    end
    else
    begin
      volumeright2.Value := 0;
      songplayer2fo.doplayerstop(Sender);
    end;
  end
  else  /// player 2 --> 1
  begin

    if incmixinterval < totmixinterval then
    begin
      Inc(incmixinterval);

      if (incmixinterval / totmixinterval) + initvolleft2 < maxvolleft2 then
        volumeleft2.Value := (incmixinterval / totmixinterval) + initvolleft2
      else
        volumeleft2.Value := maxvolleft2;

      if (incmixinterval / totmixinterval) + initvolright2 < maxvolright2 then
        volumeright2.Value := (incmixinterval / totmixinterval) + initvolright2
      else
        volumeright2.Value := maxvolright2;

      if ((totmixinterval - incmixinterval) / totmixinterval) - initvolleft1 > 0 then
        volumeleft1.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolleft1
      else
      begin
        volumeleft1.Value := 0;
        songplayerfo.doplayerstop(Sender);
        muststop := 1;
      end;

      if ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1 > 0 then
        volumeright1.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1
      else
      begin
        volumeright1.Value := 0;
        songplayerfo.doplayerstop(Sender);
        muststop := 1;
      end;

      if muststop = 0 then
        timermix.Enabled := True;
    end
    else
    begin
      volumeright1.Value := 0;
      songplayerfo.doplayerstop(Sender);
    end;
  end;

end;


procedure tcommanderfo.visiblechangeev(const Sender: TObject);
begin
  if Visible then
  begin
    mainfo.tmainmenu1.menu[3].submenu[6].caption := ' Hide Commander ' ;
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[6].caption := ' Show Commander ' ;
   end;

  mainfo.updatelayout();
end;

procedure tcommanderfo.onplay(const Sender: TObject);
begin
  if (TButton(Sender).tag = 0) or (TButton(Sender).tag = 2) or (TButton(Sender).tag = 3) then
    songplayerfo.doplayerstart(Sender)
  else
    songplayer2fo.doplayerstart(Sender);
end;

procedure tcommanderfo.onstop(const Sender: TObject);
begin
  if TButton(Sender).tag = 0 then
    songplayerfo.doplayerstop(Sender)
  else
    songplayer2fo.doplayerstop(Sender);
end;

procedure tcommanderfo.doplayerpause(const Sender: TObject);
begin
  if TButton(Sender).tag = 0 then
    songplayerfo.doplayerpause(Sender)
  else
    songplayer2fo.doplayerpause(Sender);
end;

procedure tcommanderfo.doresume(const Sender: TObject);
begin
  if TButton(Sender).tag = 0 then
    songplayerfo.doplayeresume(Sender)
  else
    songplayer2fo.doplayeresume(Sender);
end;

procedure tcommanderfo.setvolume(const Sender: TObject);
begin

  if hasinit = 1 then
  begin
    if (tslider(Sender).tag = 0) or (tslider(Sender).tag = 1) then
    begin
      if linkvol.tag = 0 then
      begin
        if (tslider(Sender).tag = 0) then
          volumeright1.Value := volumeleft1.Value
        else
          volumeleft1.Value := volumeright1.Value;
        songplayerfo.edvolleft.Value := trunc(volumeleft1.Value * 100);
        songplayerfo.edvolright.Value := trunc(volumeright1.Value * 100);
      end
      else
      if (tslider(Sender).tag = 0) then
        songplayerfo.edvolleft.Value := trunc(volumeleft1.Value * 100)
      else
        songplayerfo.edvolright.Value := trunc(volumeright1.Value * 100);
      //songplayerfo.changevolume(sender)

    end
    else
    begin
      if linkvol2.tag = 0 then
      begin
        if (tslider(Sender).tag = 2) then
          volumeright2.Value := volumeleft2.Value
        else
          volumeleft2.Value := volumeright2.Value;
        songplayer2fo.edvolleft.Value := trunc(volumeleft2.Value * 100);
        songplayer2fo.edvolright.Value := trunc(volumeright2.Value * 100);
      end
      else
      if (tslider(Sender).tag = 2) then
        songplayer2fo.edvolleft.Value := trunc(volumeleft2.Value * 100)
      else
        songplayer2fo.edvolright.Value := trunc(volumeright2.Value * 100);
      //songplayerfo.changevolume(sender)
    end;
  end;
end;

procedure tcommanderfo.ondest(const Sender: TObject);
begin
  Timermix.Free;
end;

procedure tcommanderfo.onsetinput(const Sender: TObject);
begin

  if hasinit = 1 then
  begin
    if TButton(Sender).tag = 0 then
    begin

      TButton(Sender).face.template := mainfo.tfacered;

      tslider3.Enabled := True;
      uos_Stop(theinput);

      if uos_CreatePlayer(theinput) then
      begin
        // writeln('ok create');
        TButton(Sender).tag := 1;
        
        OutputIndex4 := uos_AddIntoDevOut(theinput, -1, configfo.latrec.value, -1,
        -1, -1, -1);      
                 
        // writeln('OutputIndex4 = ' + inttostr(OutputIndex4));
        // uos_outputsetenable(theinput,OutputIndex4,true);

        InputIndex4 := uos_AddFromDevIn(theinput);

        //  writeln('InputIndex4 = ' + inttostr(InputIndex4));

        uos_InputAddDSP1ChanTo2Chan(theinput, InputIndex4);

        uos_InputSetLevelEnable(theinput, InputIndex4, 2);

        uos_InputAddDSPVolume(theinput, InputIndex4, 1, 1);

        //   uos_LoopProcIn(theinput, InputIndex4, @LoopProcPlayer1);

        uos_InputSetDSPVolume(theinput, InputIndex4, tslider3.Value, tslider3.Value, True);

        /////// procedure to execute when stream is terminated
        //   uos_EndProc(therecplayer, @ClosePlayer1);

        uos_Play(theinput);  /////// everything is ready to play...

        //   bsavetofile.Enabled := false;

      end;
    end
    else
    begin
      // writeln('uos_Stop = ' + inttostr(theinput));
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := mainfo.tfacebutgray;
      uos_Stop(theinput);
    end;
  end;
end;

procedure tcommanderfo.onchangevolinput(const Sender: TObject);
begin
  if hasinit = 1 then
  begin
    uos_InputSetDSPVolume(theinput, Inputindex4,
      tslider3.Value, tslider3.Value, True);
  end;
end;

procedure tcommanderfo.doplaydrums(const Sender: TObject);
begin
  drumsfo.dostart(Sender);
end;

procedure tcommanderfo.dopausedrums(const Sender: TObject);
begin
  drumsfo.dostop(Sender);
end;

procedure tcommanderfo.doresumedrums(const Sender: TObject);
begin
  drumsfo.doresume(Sender);
end;

procedure tcommanderfo.onchangevoldrums(const Sender: TObject);
begin
  if hasinit = 1 then
    drumsfo.volumedrums.Value := trunc(tslider2.Value * 100);
end;

procedure tcommanderfo.setlr1(const sender: TObject);
begin
if linkvol.tag = 0 then
begin
linkvol.tag := 1;
linkvol.face.template:= mainfo.tfacebutgray;
end else
if linkvol.tag = 1 then
begin
linkvol.tag := 0;
linkvol.face.template:= mainfo.tfacegreen;
end;
end;

procedure tcommanderfo.setlr2(const sender: TObject);
begin
if linkvol2.tag = 0 then
begin
linkvol2.tag := 1;
linkvol2.face.template:= mainfo.tfacebutgray;
end else
if linkvol2.tag = 1 then
begin
linkvol2.tag := 0;
linkvol2.face.template:= mainfo.tfacegreen;
end;
end;

procedure tcommanderfo.setvu(const sender: TObject);
begin
if vuin.tag = 0 then
begin
vuin.tag := 1;
vuin.face.template:= mainfo.tfacebutgray;
end else
if vuin.tag = 1 then
begin
vuin.tag := 0;
vuin.face.template:= mainfo.tfacegreen;
end;

end;

procedure tcommanderfo.setautomix(const sender: TObject);
begin
if automix.tag = 0 then
begin
automix.tag := 1;
automix.face.template:= mainfo.tfacegreen;
end else
if automix.tag = 1 then
begin
automix.tag := 0;
automix.face.template:= mainfo.tfacebutgray;
end;
end;

end.
