unit commander;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,Math,
 msegui,msetimer,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,
 msedragglob,msesimplewidgets,msewidgets,mseact,msebitmap,msedataedits,
 msedatanodes,mseedit,msefiledialogx,msegrids,mseificomp,mseificompglob,
 mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,msesys,SysUtils,
 msegraphedits,msescrollbar,msedispwidgets,mserichstring,mseimage;

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
    genleftvolvalue: TButton;
    genrightvolvalue: TButton;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    volumeleft1val: TButton;
    volumeright1val: TButton;
    volumeright2val: TButton;
    volumeleft2val: TButton;
    tslider2val: TButton;
    tslider3val: TButton;
    vuLeft: tprogressbar;
    timage2: timage;
   tfacecomp3: tfacecomp;
   nameplayers2: tstringdisp;
   guimix: tbooleanedit;
   speccalc: tbooleanedit;
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
    procedure onchangegenvol(const Sender: TObject);
    procedure onresetgenvol(const Sender: TObject);
    procedure onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure ontextedit(const Sender: tcustomedit; var atext: msestring);
    procedure resetvolume(const Sender: TObject);
    procedure onsetvu(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
   procedure oncre(const sender: TObject);
   procedure onchangevuset(const sender: TObject);
  end;

var
  commanderfo: tcommanderfo;
  totmixinterval, incmixinterval, InputIndex4, OutputIndex4: integer;
  initvolleft1, initvolright1, initvolleft2, initvolright2: double;
  maxvolleft1, maxvolright1, maxvolleft2, maxvolright2: double;
  thetypemix: integer = 0;
  theinput: integer = 30;
  lastrowplayed: integer = -1;
  vuinvar: boolean = false;

implementation

uses
  songplayer,
  drums,
  filelistform,
  uos_flat,
  config,
  recorder,
  dockpanel1,
  main,
  commander_mfm;

procedure tcommanderfo.onsetvu(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue = False then
  begin
    with commanderfo do
    begin
      vuLeft.Visible   := False;
      vuRight.Visible  := False;
      vuLeft.Value     := 0;
      vuRight.Value    := 0;
      vuLeft2.Visible  := False;
      vuRight2.Visible := False;
      vuLeft2.Value    := 0;
      vuRight2.Value   := 0;
    end;
    with songplayerfo do
    begin
      vuLeft.Visible  := False;
      vuRight.Visible := False;
      vuLeft.Value    := 0;
      vuRight.Value   := 0;
    end;
    with songplayer2fo do
    begin
      vuLeft.Visible  := False;
      vuRight.Visible := False;
      vuLeft.Value    := 0;
      vuRight.Value   := 0;
    end;
  end
  else
  begin
    with commanderfo do
    begin
      vuLeft.Visible   := True;
      vuRight.Visible  := True;
      vuLeft2.Visible  := True;
      vuRight2.Visible := True;
    end;
    with songplayerfo do
    begin
      vuLeft.Visible  := True;
      vuRight.Visible := True;
    end;
    with songplayer2fo do
    begin
      vuLeft.Visible  := True;
      vuRight.Visible := True;
    end;
  end;

end;

procedure tcommanderfo.formcreated(const Sender: TObject);
begin
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);


  Timermix           := ttimer.Create(nil);
  Timermix.interval  := 100000;
  //Timermix.options := [to_single];
  Timermix.options   := [to_leak];
  Timermix.Enabled   := False;
  Timermix.ontimer   := @ontimermix;
  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.options  := [to_single];
  Timersent.ontimer  := @ontimersent;

  if devin < 0 then
  begin
    butinput.Enabled    := False;
    tslider3.Enabled    := False;
    tslider3val.Enabled := False;
  end;

end;

procedure tcommanderfo.ontimersent(const Sender: TObject);
begin
  // timersent.Enabled := False;
  hintpanel.Visible := False;
end;

procedure tcommanderfo.onstartstop(const Sender: TObject);
var
  fromplay: integer;
begin
  totmixinterval := round(timemix.Value / 10);

  incmixinterval := 0;

  if lastrowplayed >= filelistfo.list_files.rowcount then
    lastrowplayed := 0;

  if lastrowplayed = -1 then
  begin
    filelistfo.onsent(filelistfo.tbutton1);
    lastrowplayed := filelistfo.list_files.focusedcell.row;
  end;

  filelistfo.list_files.rowcolorstate[lastrowplayed] := -1;

  lastrowplayed := filelistfo.list_files.focusedcell.row;
  if mainfo.typecolor.Value = 2 then
    filelistfo.list_files.rowcolorstate[lastrowplayed] := 2
  else
    filelistfo.list_files.rowcolorstate[lastrowplayed] := 0;

  maxvolleft1  := 1;
  maxvolright1 := 1;

  maxvolleft2  := 1;
  maxvolright2 := 1;

  initvolleft1  := 0;
  initvolright1 := 0;

  initvolleft2  := 0;
  initvolright2 := 0;


  if Sender <> nil then
  begin
    if (TButton(Sender).tag = 0) then
      fromplay := 0
    else
      fromplay := 1;
  end
  else if hasmixed1 = True then
    fromplay := 1
  else
    fromplay := 0;

  if fromplay = 0 then
  begin
    tbutton2.face.template := mainfo.tfacebutgray;
    tbutton3.face.template := mainfo.tfaceorange;

    filelistfo.tbutton2.face.template := mainfo.tfaceorange;
    filelistfo.tbutton1.face.template := mainfo.tfaceplayer;

    //tbutton3.focused := true;

    thetypemix         := 0;
    volumeleft1.Value  := 0;
    volumeright1.Value := 0;
    //volumeleft2.value := 1;
    //volumeright2.value := 1;

    if (Sender <> nil) and (commanderfo.automix.Value = True) and (filelistfo.list_files.rowcount > 0) then
    begin
      hasfocused2 := True;
      filelistfo.onsent(nil);
      hasfocused2 := False;
    end;

    if uos_GetStatus(theplayer) <> 1 then
      if (iscue1 = True) or (uos_GetStatus(theplayer) = 2) then
        songplayerfo.doplayeresume(Sender)
      else
        songplayerfo.doplayerstart(Sender);

    hasmixed2        := True;
    timermix.Enabled := True;
  end
  else
  begin

    thetypemix         := 1;
    volumeleft2.Value  := 0;
    volumeright2.Value := 0;
    tbutton3.face.template := mainfo.tfacebutgray;
    tbutton2.face.template := mainfo.tfaceorange;
    filelistfo.tbutton1.face.template := mainfo.tfaceorange;
    filelistfo.tbutton2.face.template := mainfo.tfaceplayer;
    //volumeleft2.value := 1;
    //volumeright2.value := 1;

    if (Sender <> nil) and (automix.Value = True) and (filelistfo.list_files.rowcount > 0) then
    begin
      hasfocused1 := True;
      filelistfo.onsent(nil);
      hasfocused1 := False;
    end;

    if uos_GetStatus(theplayer2) <> 1 then
      if (iscue2 = True) or (uos_GetStatus(theplayer2) = 2) then
        songplayer2fo.doplayeresume(Sender)
      else
        songplayer2fo.doplayerstart(Sender);

    hasmixed1        := True;
    timermix.Enabled := True;
    //  filelistfo.list_files.rowcolorstate[4]:= 0;

  end;

end;


procedure tcommanderfo.ontimermix(const Sender: TObject);
var
  muststop: integer = 0;
begin
  // timermix.Enabled := False;
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
        muststop          := 1;
      end;

      if ((totmixinterval - incmixinterval) / totmixinterval) - initvolright2 > 0 then
        volumeright2.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolright2
      else
      begin
        volumeright2.Value := 0;
        songplayer2fo.doplayerstop(Sender);
        muststop           := 1;
      end;

      if muststop = 1 then
        timermix.Enabled := False;
    end
    else
    begin
      volumeright2.Value := 0;
      songplayer2fo.doplayerstop(Sender);
      timermix.Enabled   := False;
    end;
  end
  else  /// player 2 --> 1
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
      muststop          := 1;
    end;

    if ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1 > 0 then
      volumeright1.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1
    else
    begin
      volumeright1.Value := 0;
      songplayerfo.doplayerstop(Sender);
      muststop           := 1;
    end;

    if muststop = 1 then
      timermix.Enabled := False;
  end
  else
  begin
    volumeright1.Value := 0;
    songplayerfo.doplayerstop(Sender);
    timermix.Enabled   := False;
  end;
  //filelistfo.list_files.rowcolorstate[4]:= 0;
end;


procedure tcommanderfo.visiblechangeev(const Sender: TObject);
begin
  if (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and 
  (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) and 
  (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin
    if Visible then
      mainfo.tmainmenu1.menu[4].submenu[6].Caption := ' Hide Commander '
    else
      mainfo.tmainmenu1.menu[4].submenu[6].Caption := ' Show Commander ';
    if norefresh = False then
    begin
      mainfo.updatelayout();

      if dockpanel1fo.Visible then
        dockpanel1fo.updatelayout();
      if dockpanel2fo.Visible then
        dockpanel2fo.updatelayout();
      if dockpanel3fo.Visible then
        dockpanel3fo.updatelayout();
      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayout();
      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayout();
    end;
  end;
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
    if (tslider(Sender).tag = 0) or (tslider(Sender).tag = 1) then
    begin
      if linkvol.Value = True then
      begin
        if (tslider(Sender).tag = 0) then
          volumeright1.Value := volumeleft1.Value
        else
          volumeleft1.Value  := volumeright1.Value;

        songplayerfo.edvolleft.Value  := trunc(volumeleft1.Value * 100);
        songplayerfo.edvolright.Value := trunc(volumeright1.Value * 100);

      end
      else if (tslider(Sender).tag = 0) then
        songplayerfo.edvolleft.Value  := trunc(volumeleft1.Value * 100)
      else
        songplayerfo.edvolright.Value := trunc(volumeright1.Value * 100);
      //songplayerfo.changevolume(sender)
      volumeleft1val.Caption := utf8decode(IntToStr(trunc(songplayerfo.edvolleft.Value)));
      volumeright1val.Caption := utf8decode(IntToStr(trunc(songplayerfo.edvolright.Value)));
    end
    else
    begin
      if linkvol2.Value = True then
      begin
        if (tslider(Sender).tag = 2) then
          volumeright2.Value := volumeleft2.Value
        else
          volumeleft2.Value  := volumeright2.Value;
        songplayer2fo.edvolleft.Value := trunc(volumeleft2.Value * 100);
        songplayer2fo.edvolright.Value := trunc(volumeright2.Value * 100);
      end
      else if (tslider(Sender).tag = 2) then
        songplayer2fo.edvolleft.Value  := trunc(volumeleft2.Value * 100)
      else
        songplayer2fo.edvolright.Value := trunc(volumeright2.Value * 100);
      volumeleft2val.Caption := utf8decode(IntToStr(trunc(songplayer2fo.edvolleft.Value)));
      volumeright2val.Caption := utf8decode(IntToStr(trunc(songplayer2fo.edvolright.Value)));
    end;
end;

procedure tcommanderfo.ondest(const Sender: TObject);
begin
  Timermix.Free;
  timersent.Free;
end;

procedure tcommanderfo.onsetinput(const Sender: TObject);
begin

  if (hasinit = 1) and (devin > -1) then
    if butinput.Value = True then
    begin

      nameinput.face.template := mainfo.tfacered;
      //  tslider3val.face.template :=  mainfo.tfacered;

      tslider3.Enabled := True;
      uos_Stop(theinput);

      uos_CreatePlayer(theinput);
      // writeln('ok create');

      OutputIndex4 := uos_AddIntoDevOut(theinput, configfo.devoutcfg.value, configfo.latrec.Value, -1, -1, -1, -1, -1);

      // writeln('OutputIndex4 = ' + inttostr(OutputIndex4));
      // uos_outputsetenable(theinput,OutputIndex4,true);

     // InputIndex4 := uos_AddFromDevIn(theinput);
      
      InputIndex4 :=  uos_AddFromDevIn(theinput, configfo.devincfg.value, -1, -1, -1, -1, -1, -1);
 
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

    end
    else
    begin
      // writeln('uos_Stop = ' + inttostr(theinput));
      nameinput.face.template := recorderfo.tfacereclight;
      //    tslider3val.face.template :=  mainfo.tfacebutltgray;
      uos_Stop(theinput);
    end;
  // else butinput.Value := false;
end;

procedure tcommanderfo.onchangevolinput(const Sender: TObject);
begin
  tslider3val.Caption := utf8decode(IntToStr(trunc(tslider3.Value * 100)));
  if (hasinit = 1) and (butinput.Value = True) then
    uos_InputSetDSPVolume(theinput, Inputindex4,
      tslider3.Value, tslider3.Value, True);
end;

procedure tcommanderfo.doplaydrums(const Sender: TObject);
begin
  drumsfo.activate;
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
  tslider2val.Caption := utf8decode(IntToStr(trunc(tslider2.Value * 100)));

  if hasinit = 1 then

    drumsfo.volumedrums.Value := trunc(tslider2.Value * 100);
end;

procedure tcommanderfo.onchangegenvol(const Sender: TObject);
begin

  if linkvolgen.Value = True then
  begin
    if (tslider(Sender).tag = 0) then
      genvolright.Value := genvolleft.Value
    else
      genvolleft.Value  := genvolright.Value;
    genleftvolvalue.Caption := utf8decode(IntToStr(round(genvolleft.Value * 150)));
    genrightvolvalue.Caption := utf8decode(IntToStr(round(genvolright.Value * 150)));
  end
  else
  if (tslider(Sender).tag = 0) then
    genleftvolvalue.Caption  := utf8decode(IntToStr(round(genvolleft.Value * 150)))
  else
    genrightvolvalue.Caption := utf8decode(IntToStr(round(genvolright.Value * 150)));
  //songplayerfo.changevolume(sender)
  if hasinit = 1 then
  begin
    songplayerfo.changevolume(Sender);
    songplayer2fo.changevolume(Sender);
    drumsfo.onchangevol(Sender);
  end;
end;

procedure tcommanderfo.onresetgenvol(const Sender: TObject);
begin
  if linkvolgen.Value = True then
  begin
    genvolright.Value := 0.666666;
    genvolleft.Value  := 0.666666;
    // genrightvolvalue.Value := 100;
    //genrightvolvalue.Value := 100;
  end
  else if (TButton(Sender).tag = 0) then
    genvolleft.Value  := 0.666666
  else
    genvolright.Value := 0.666666;
end;

procedure tcommanderfo.onsetvalvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  if avalue > 10000 then
  begin
    hintlabel.Caption := utf8decode('"' + IntToStr(trunc(avalue)) + '" is > 10000.  Reset to 10000.');
    if hintlabel.Width > hintlabel2.Width then
      hintpanel.Width := hintlabel.Width + 10
    else
      hintpanel.Width := hintlabel2.Width + 10;
    hintpanel.Visible := True;
    timersent.Enabled := True;
    avalue := 10000;
  end;

  if avalue < 10 then
  begin
    hintlabel.Caption := '" " is invalid value.  Reset to 10 (Min Value).';
    if hintlabel.Width > hintlabel2.Width then
      hintpanel.Width := hintlabel.Width + 10
    else
      hintpanel.Width := hintlabel2.Width + 10;
    hintpanel.Visible := True;
    timersent.Enabled := True;
    avalue := 10;
  end;
end;

procedure tcommanderfo.ontextedit(const Sender: tcustomedit; var atext: msestring);
begin
  if (isnumber(atext)) or (atext = '') or (atext = '-') then
  else
  begin
    hintlabel.Caption := '"' + atext + '" is invalid value.  Reset to 300.';
    if hintlabel.Width > hintlabel2.Width then
      hintpanel.Width := hintlabel.Width + 10
    else
      hintpanel.Width := hintlabel2.Width + 10;
    hintpanel.Visible := True;
    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;
    atext := '300';
  end;
end;

procedure tcommanderfo.resetvolume(const Sender: TObject);
begin
  if (TButton(Sender).Name = 'volumeleft1val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      if linkvol.Value = True then
      begin
        volumeleft1.Value  := 0;
        volumeright1.Value := 0;
      end
      else
        volumeleft1.Value  := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      if linkvol.Value = True then
      begin
        volumeleft1.Value  := 1;
        volumeright1.Value := 1;
      end
      else
        volumeleft1.Value  := 1;
    end;

  if (TButton(Sender).Name = 'volumeright1val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      if linkvol.Value = True then
      begin
        volumeleft1.Value  := 0;
        volumeright1.Value := 0;
      end
      else
        volumeright1.Value := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      if linkvol.Value = True then
      begin
        volumeleft1.Value  := 1;
        volumeright1.Value := 1;
      end
      else
        volumeright1.Value := 1;
    end;

  if (TButton(Sender).Name = 'volumeleft2val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      if linkvol2.Value = True then
      begin
        volumeleft2.Value  := 0;
        volumeright2.Value := 0;
      end
      else
        volumeleft2.Value  := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      if linkvol2.Value = True then
      begin
        volumeleft2.Value  := 1;
        volumeright2.Value := 1;
      end
      else
        volumeleft2.Value  := 1;
    end;

  if (TButton(Sender).Name = 'volumeright2val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      if linkvol2.Value = True then
      begin
        volumeleft2.Value  := 0;
        volumeright2.Value := 0;
      end
      else
        volumeright2.Value := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      if linkvol2.Value = True then
      begin
        volumeleft2.Value  := 1;
        volumeright2.Value := 1;
      end
      else
        volumeright2.Value := 1;
    end;

  if (TButton(Sender).Name = 'tslider2val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      tslider2.Value      := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      tslider2.Value      := 1;
    end;

  if (TButton(Sender).Name = 'tslider3val') then
    if TButton(Sender).tag = 0 then
    begin
      TButton(Sender).tag := 1;
      tslider3.Value      := 0;
    end
    else
    begin
      TButton(Sender).tag := 0;
      tslider3.Value      := 1;
    end;

end;

procedure tcommanderfo.oncre(const sender: TObject);
begin
windowopacity := 0;
end;

procedure tcommanderfo.onchangevuset(const sender: TObject);
begin
vuinvar := vuin.value;
end;


end.

