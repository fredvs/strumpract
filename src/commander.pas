unit commander;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui, msetimer, msegraphics, msegraphutils, mseevent, mseclasses, mseforms,
 msedock, msedragglob, msesimplewidgets, msewidgets, mseact, msebitmap,
 msedataedits, msedatanodes, mseedit, msefiledialog, msegrids, mseificomp,
 mseificompglob, mseifiglob, mselistbrowser, msestatfile, msestream, msestrings,
 msesys, SysUtils, msegraphedits, msescrollbar, msedispwidgets, mserichstring;

type
  tcommanderfo = class(tdockform)
    timermix: ttimer;
    Timersent: Ttimer;
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
    volumeright2: tslider;
    volumeleft2: tslider;
    tfaceslider: tfacecomp;
    tfacebutton: tfacecomp;
    btncue: TButton;
    btnStart2: TButton;
    btncue2: TButton;
    btnStop2: TButton;
    btnPause2: TButton;
    btnResume2: TButton;
    nameplayers: tstringdisp;
    namedrums: tstringdisp;
    tfacegriptab: tfacecomp;
    tfacesliderdark: tfacecomp;
    vuLeft: tprogressbar;
    vuright: tprogressbar;
    vuright2: tprogressbar;
    vuLeft2: tprogressbar;
   tgroupall: tgroupbox;
   genvolright: tslider;
   genvolleft: tslider;
   namegen: tstringdisp;
   linkvol: tbooleanedit;
   linkvolgen: tbooleanedit;
   linkvol2: tbooleanedit;
   vuin: tbooleanedit;
   automix: tbooleanedit;
   nameinput: tstringdisp;
   butinput: tbooleanedit;
   genleftvolvalue: tbutton;
   genrightvolvalue: tbutton;
   hintpanel: tgroupbox;
   hintlabel: tlabel;
   hintlabel2: tlabel;
   volumeleft1val: tbutton;
   volumeright1val: tbutton;
   volumeright2val: tbutton;
   volumeleft2val: tbutton;
   tslider2val: tbutton;
   tslider3val: tbutton;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onplay(const Sender: TObject);
    procedure onstop(const Sender: TObject);
    procedure doplayerpause(const Sender: TObject);
    procedure doresume(const Sender: TObject);
    procedure setvolume(const Sender: TObject);
    procedure onstartstop(const Sender: TObject);
    procedure ontimermix(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure ondest(const Sender: TObject);
    procedure onsetinput(const Sender: TObject);
    procedure onchangevolinput(const Sender: TObject);
    procedure doplaydrums(const Sender: TObject);
    procedure dopausedrums(const Sender: TObject);
    procedure doresumedrums(const Sender: TObject);
    procedure onchangevoldrums(const Sender: TObject);
    procedure onchangegenvol(const sender: TObject);
    procedure onresetgenvol(const sender: TObject);
    procedure onsetvalvol(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure ontextedit(const sender: tcustomedit; var atext: msestring);
   procedure resetvolume(const sender: TObject);
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
  songplayer, songplayer2, drums, filelistform, uos_flat, config, recorder,
  main, commander_mfm;

procedure tcommanderfo.formcreated(const Sender: TObject);
begin
  Timermix := ttimer.Create(nil);
  Timermix.interval := 100000;
  Timermix.Enabled := False;
  Timermix.ontimer := @ontimermix;
  Timersent := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.ontimer := @ontimersent;
end;

procedure tcommanderfo.ontimersent(const Sender: TObject);
begin
  timersent.Enabled := False;
  hintpanel.visible := false;
end;

procedure tcommanderfo.onstartstop(const Sender: TObject);
var
  fromplay: integer;
begin

  totmixinterval := round(timemix.Value / 10);

  incmixinterval := 0;

  maxvolleft1 := 1;
  maxvolright1 := 1;

  maxvolleft2 := 1;
  maxvolright2 := 1;

  initvolleft1 := 0;
  initvolright1 := 0;

  initvolleft2 := 0;
  initvolright2 := 0;

  if Sender <> nil then
  begin
    if (TButton(Sender).tag = 0) then
      fromplay := 0
    else
      fromplay := 1;
  end
  else
  begin
    if hasmixed1 = True then
      fromplay := 1
    else
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

    if (Sender <> nil) and (commanderfo.automix.Value = true) and (filelistfo.list_files.rowcount > 0) then
    begin
      hasfocused2 := True;
      filelistfo.onsent(nil);
      hasfocused2 := False;
    end;

    if uos_GetStatus(theplayer) <> 1 then
    begin
      if (iscue1 = True) or (uos_GetStatus(theplayer) = 2) then
        songplayerfo.doplayeresume(Sender)
      else
        songplayerfo.doplayerstart(Sender);
    end;

    hasmixed2 := True;
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

    if (Sender <> nil) and (commanderfo.automix.Value = true) and (filelistfo.list_files.rowcount > 0) then
    begin
      hasfocused1 := True;
      filelistfo.onsent(nil);
      hasfocused1 := False;
    end;

    if uos_GetStatus(theplayer2) <> 1 then
    begin
      if (iscue2 = True) or (uos_GetStatus(theplayer2) = 2) then
        songplayer2fo.doplayeresume(Sender)
      else
        songplayer2fo.doplayerstart(Sender);
    end;

    hasmixed1 := True;
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
    mainfo.tmainmenu1.menu[3].submenu[6].Caption := ' Hide Commander ';
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[6].Caption := ' Show Commander ';
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
      if linkvol.value = true then
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
       volumeleft1val.caption := inttostr(trunc(songplayerfo.edvolleft.Value));
        volumeright1val.caption :=  inttostr(trunc(songplayerfo.edvolright.Value));
    end
    else
    begin
      if linkvol2.value = true then
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
        volumeleft2val.caption := inttostr(trunc(songplayer2fo.edvolleft.Value));
        volumeright2val.caption :=  inttostr(trunc(songplayer2fo.edvolright.Value));
    end;
  end;
end;

procedure tcommanderfo.ondest(const Sender: TObject);
begin
  Timermix.Free;
  timersent.Free;
end;

procedure tcommanderfo.onsetinput(const Sender: TObject);
begin

  if hasinit = 1 then
  begin
    if butinput.value = true then
    begin
    
   nameinput.face.template := mainfo.tfacered;
  //  tslider3val.face.template :=  mainfo.tfacered;
      
      tslider3.Enabled := True;
      uos_Stop(theinput);

      if uos_CreatePlayer(theinput) then
      begin
        // writeln('ok create');
      
        OutputIndex4 := uos_AddIntoDevOut(theinput, -1, configfo.latrec.Value, -1, -1, -1, -1, -1);

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
        nameinput.face.template := recorderfo.tfacereclight;
    //    tslider3val.face.template :=  mainfo.tfacebutltgray;    
     uos_Stop(theinput);
    end;
  end;
end;

procedure tcommanderfo.onchangevolinput(const Sender: TObject);
begin
tslider3val.caption := inttostr(trunc(tslider3.Value * 100));
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
tslider2val.caption := inttostr(trunc(tslider2.Value * 100));

  if hasinit = 1 then
  
    drumsfo.volumedrums.Value := trunc(tslider2.Value * 100);
end;

procedure tcommanderfo.onchangegenvol(const sender: TObject);
begin

     if linkvolgen.value = true then
      begin
        if (tslider(Sender).tag = 0) then
          genvolright.Value := genvolleft.Value
        else
          genvolleft.Value := genvolright.Value;
        genleftvolvalue.caption := inttostr(round(genvolleft.Value * 150));
        genrightvolvalue.caption := inttostr(round(genvolright.Value * 150));
      end
      else
      
       if (tslider(Sender).tag = 0) then
       genleftvolvalue.caption := inttostr(round(genvolleft.Value * 150))
      else
       genrightvolvalue.caption := inttostr(round(genvolright.Value * 150));
      //songplayerfo.changevolume(sender)
    if hasinit = 1 then
  begin
    songplayerfo.changevolume(sender);
    songplayer2fo.changevolume(sender);
    drumsfo.onchangevol(sender);
  end;
end;

procedure tcommanderfo.onresetgenvol(const sender: TObject);
begin
if linkvolgen.value = true then 
begin
genvolright.Value := 0.666666;  
genvolleft.Value := 0.666666;  
// genrightvolvalue.Value := 100;
//genrightvolvalue.Value := 100;   
 end else
begin

 if (tbutton(Sender).tag = 0) then
 genvolleft.Value := 0.666666 else
  genvolright.Value := 0.666666
  
  
 end; 
end;

procedure tcommanderfo.onsetvalvol(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
if avalue > 10000 then
begin
hintlabel.caption := '"' +inttostr(trunc(avalue)) + '" is > 10000.  Reset to 10000.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
 avalue := 10000;
end; 
 
if avalue < 10 then begin
hintlabel.caption := '" " is invalid value.  Reset to 10 (Min Value).';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
avalue := 10;
end; 
end;

procedure tcommanderfo.ontextedit(const sender: tcustomedit;
               var atext: msestring);
begin
if (isnumber(atext)) or (atext = '') or (atext = '-') then else
begin
hintlabel.caption := '"' + atext + '" is invalid value.  Reset to 300.';
if hintlabel.width > hintlabel2.width then
hintpanel.width := hintlabel.width + 10 else
hintpanel.width := hintlabel2.width + 10;
hintpanel.visible := true;
timersent.Enabled := true;
 atext := '300';
 end;
end;

procedure tcommanderfo.resetvolume(const sender: TObject);
begin
if (tbutton(Sender).name = 'volumeleft1val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
if linkvol.value = true then 
begin
volumeleft1.Value := 0;  
volumeright1.Value := 0;  
end else
volumeleft1.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
if linkvol.value = true then 
begin
volumeleft1.Value := 1;  
volumeright1.Value := 1;  
end else
volumeleft1.Value := 1;  
end;
end;

if (tbutton(Sender).name = 'volumeright1val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
if linkvol.value = true then 
begin
volumeleft1.Value := 0;  
volumeright1.Value := 0;  
end else
volumeright1.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
if linkvol.value = true then 
begin
volumeleft1.Value := 1;  
volumeright1.Value := 1;  
end else
volumeright1.Value := 1;  
end;
end;

if (tbutton(Sender).name = 'volumeleft2val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
if linkvol2.value = true then 
begin
volumeleft2.Value := 0;  
volumeright2.Value := 0;  
end else
volumeleft2.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
if linkvol2.value = true then 
begin
volumeleft2.Value := 1;  
volumeright2.Value := 1;  
end else
volumeleft2.Value := 1;  
end;
end;

if (tbutton(Sender).name = 'volumeright2val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
if linkvol2.value = true then 
begin
volumeleft2.Value := 0;  
volumeright2.Value := 0;  
end else
volumeright2.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
if linkvol2.value = true then 
begin
volumeleft2.Value := 1;  
volumeright2.Value := 1;  
end else
volumeright2.Value := 1;  
end;
end;

if (tbutton(Sender).name = 'tslider2val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
tslider2.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
tslider2.Value := 1;    
end;
end;

if (tbutton(Sender).name = 'tslider3val') then
begin
if tbutton(Sender).tag = 0 then
begin
tbutton(Sender).tag := 1;
tslider3.Value := 0;  
end
else 
begin
tbutton(Sender).tag := 0;
tslider3.Value := 1;    
end;
end;

end;

end.
