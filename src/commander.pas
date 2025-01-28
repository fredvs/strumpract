unit commander;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

{$if defined(netbsd) or defined(darwin)}
 {$define nofade}
 {$endif}

interface

uses
 {$if (defined(linux)) and (not defined(cpuaarch64)) and (not defined(cpuarm))}alsa_mixer,
 {$endif}{$if defined(windows)}win_mixer,{$ENDIF}msetypes,
  Math,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  mseforms,
  msedock,
  msedragglob,
  msesimplewidgets,
  msewidgets,
  mseact,
  msebitmap,
  msedataedits,
  msedatanodes,
  mseedit,
  msefiledialogx,
  msegrids,
  mseificomp,
  mseificompglob,
  msefileutils,
  mseifiglob,
  mselistbrowser,
  msestatfile,
  msestream,
  msestrings,
  msesys,
  SysUtils,
  msegraphedits,
  msescrollbar,
  msedispwidgets,
  mserichstring,
  msetimer,
  mseimage;

type
  tcommanderfo = class(tdockform)
    timermix: ttimer;
    Timersent: Ttimer;
    tgroupboxplayers: tgroupbox;
    btnStop: TButton;
    btnResume: TButton;
    btnStart: TButton;
    volumeleft1: tslider;
    volumeright1: tslider;
    timemix: trealspinedit;
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
    tfacebutton: tfacecomp;
    btncue: TButton;
    btnStart2: TButton;
    btncue2: TButton;
    btnStop2: TButton;
    btnPause2: TButton;
    btnResume2: TButton;
    namedrums: tstringdisp;
    tfacegriptab: tfacecomp;
    vuright: tprogressbar;
    vuright2: tprogressbar;
    vuLeft2: tprogressbar;
    tgroupall: tgroupbox;
    genvolright: tslider;
    nameinput: tstringdisp;
    butinput: tbooleanedit;
    genleftvolvalue: TButton;
    genrightvolvalue: TButton;
    volumeleft1val: TButton;
    volumeright1val: TButton;
    volumeright2val: TButton;
    volumeleft2val: TButton;
    tslider2val: TButton;
    tslider3val: TButton;
    vuLeft: tprogressbar;
    tfacecomp3: tfacecomp;
    tbutton4: TButton;
    tbutton5: TButton;
    tbutton6: TButton;
    tstringdisp1: tstringdisp;
    directmix: tbooleanedit;
    vuin: tbooleanedit;
    automix: tbooleanedit;
    speccalc: tbooleanedit;
    guimix: tbooleanedit;
    linkvol2: tbooleanedit;
    linkvol: tbooleanedit;
    linkvolb: TButton;
    linkvol2b: TButton;
    speccalcb: TButton;
    guimixb: TButton;
    vuinb: TButton;
    automixb: TButton;
    directmixb: TButton;
    linkvolgen: tbooleanedit;
    linkvolgenb: TButton;
    tfacebutgray: tfacecomp;
    tfacegreen: tfacecomp;
    ttimer1: ttimer;
    nameplayers: tstringdisp;
    nameplayers2: tstringdisp;
    namegen: tstringdisp;
    tfaceorange: tfacecomp;
    sysvol: tslider;
    sysvolbut: TButton;
    timercallback: ttimer;
    Brandommix: TButton;
    randommix: tbooleanedit;
    tframecomp2: tframecomp;
    timagelist3: timagelist;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    hintlabel2: tlabel;
    genvolleft: tslider;
    sliderimage: tbitmapcomp;
    sliderimage2: tbitmapcomp;
    sliderimage3: tbitmapcomp;
    timagelist1: timagelist;
    tframecompnul: tframecomp;

    btnPause: TButton;
    sliderimage4: tbitmapcomp;
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
    procedure oncre(const Sender: TObject);
    procedure onchangevuset(const Sender: TObject);
    procedure onpausemix(const Sender: TObject);
    procedure onresumemix(const Sender: TObject);
    procedure onchangedirectmix(const Sender: TObject);
    procedure onexecbutlght(const Sender: TObject);
    procedure ontimerinit(const Sender: TObject);
    procedure onsetsysvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure dotimercallback(const Sender: TObject);
    procedure onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure resizeco(fontheight: integer);
    procedure resetsysvol(const Sender: TObject);
  end;

var
  commanderfo: tcommanderfo;
  totmixinterval, incmixinterval, InputIndex4, OutputIndex4: integer;
  initvolleft1, initvolright1, initvolleft2, initvolright2: double;
  maxvolleft1, maxvolright1, maxvolleft2, maxvolright2: double;
  thetypemix: integer = 0;
  docallback: Boolean = False;
  theinput: integer = 30;
  lastrowplayed: integer = -1;
  vuinvar: Boolean = True;

implementation

uses
  captionstrumpract,
  songplayer,
  drums,
  filelistform,
  uos_flat,
  config,
  recorder,
  dockpanel1,
  main,
  ctypes,
  commander_mfm;

var
  boundchildco: array of boundchild;

  {$if defined(linux) or defined(windows)}
procedure mixelemcallback;
begin
  if docallback then
    if commanderfo.timercallback.Enabled then
      commanderfo.timercallback.restart // to reset
    else
      commanderfo.timercallback.Enabled := True;
end;

{$ENDIF}

procedure tcommanderfo.resizeco(fontheight: integer);
var
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := roundmath(442 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := roundmath(128 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fontheight;

  tgroupall.font.Height := fontheight;
  frame.grip_size       := roundmath(8 * ratio);

  for i1 := 0 to childrencount - 1 do
    for i2 := 0 to length(boundchildco) - 1 do
      if children[i1].Name = boundchildco[i2].Name then
      begin
        children[i1].left   := roundmath(boundchildco[i2].left * ratio);
        children[i1].top    := roundmath(boundchildco[i2].top * ratio);
        children[i1].Width  := roundmath(boundchildco[i2].Width * ratio);
        children[i1].Height := roundmath(boundchildco[i2].Height * ratio);
      end;

  linkvolgenb.font.Height := roundmath(10 * ratio);
  linkvol2b.font.Height   := linkvolgenb.font.Height;
  linkvolb.font.Height    := linkvolgenb.font.Height;
  linkvol2b.font.Height   := linkvolgenb.font.Height;
  vuinb.font.Height       := linkvolgenb.font.Height;
  speccalcb.font.Height   := linkvolgenb.font.Height;
  automixb.font.Height    := linkvolgenb.font.Height;
  Brandommix.font.Height  := linkvolgenb.font.Height;
  directmixb.font.Height  := linkvolgenb.font.Height;

  with tgroupall do
  begin
    font.Height := fontheight;
    for i1      := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildco) - 1 do
        if tgroupall.children[i1].Name = boundchildco[i2].Name then
        begin
          tgroupall.children[i1].left   := roundmath(boundchildco[i2].left * ratio);
          tgroupall.children[i1].top    := roundmath(boundchildco[i2].top * ratio);
          tgroupall.children[i1].Width  := roundmath(boundchildco[i2].Width * ratio);
          tgroupall.children[i1].Height := roundmath(boundchildco[i2].Height * ratio);
        end;
  end;

  tgroupboxplayers.font.Height := fontheight;

  with tgroupboxplayers do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildco) - 1 do
        if children[i1].Name = boundchildco[i2].Name then
        begin
          children[i1].left   := roundmath(boundchildco[i2].left * ratio);
          children[i1].top    := roundmath(boundchildco[i2].top * ratio);
          children[i1].Width  := roundmath(boundchildco[i2].Width * ratio);
          children[i1].Height := roundmath(boundchildco[i2].Height * ratio);
        end;

  tgroupboxdrums.font.Height := fontheight;

  with tgroupboxdrums do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildco) - 1 do
        if children[i1].Name = boundchildco[i2].Name then
        begin
          children[i1].left   := roundmath(boundchildco[i2].left * ratio);
          children[i1].top    := roundmath(boundchildco[i2].top * ratio);
          children[i1].Width  := roundmath(boundchildco[i2].Width * ratio);
          children[i1].Height := roundmath(boundchildco[i2].Height * ratio);
        end;

  tgroupboxinput.font.Height := fontheight;

  with tgroupboxinput do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildco) - 1 do
        if children[i1].Name = boundchildco[i2].Name then
        begin
          children[i1].left   := roundmath(boundchildco[i2].left * ratio);
          children[i1].top    := roundmath(boundchildco[i2].top * ratio);
          children[i1].Width  := roundmath(boundchildco[i2].Width * ratio);
          children[i1].Height := roundmath(boundchildco[i2].Height * ratio);
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

  ttimer1.Enabled := True;

 {$if (defined(linux)) and (not defined(cpuaarch64)) and (not defined(cpuarm))}
  sysvol.Value      := ALSAmixerGetVolume(0) / 100;
  sysvolbut.Caption := msestring(IntToStr(roundmath(sysvol.Value * 10)));
  ALSAmixerSetCallBack(@mixelemcallback);
  docallback        := True;
   {$ENDIF}

   {$if defined(windows)}
    sysvol.value := WinmixerGetVolume(0)/100;
    sysvolbut.caption := msestring(inttostr(roundmath(sysvol.value*10)));
     WinMixerSetCallBack(@mixelemcallback); // gives memory leak
     docallback := true;
   {$ENDIF}
end;

procedure tcommanderfo.ontimersent(const Sender: TObject);
begin
  // timersent.Enabled := False;
  hintpanel.Visible := False;
end;

procedure tcommanderfo.onstartstop(const Sender: TObject);
var
  fromplay, x: integer;
  fileex: msestring;
  resu: shortint = -1;
begin

  if filelistfo.list_files.rowcount > 0 then
  begin

    fileex := fileext(PChar(ansistring(songplayerfo.historyfn.Value)));
    if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
      (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') or
      (lowercase(fileex) = 'mod') or (lowercase(fileex) = 'it') or
      (lowercase(fileex) = 's3m') or (lowercase(fileex) = 'xm') then
      resu := 0
    else
      ShowMessage(songplayerfo.historyfn.Value + ' is not a audio file...');

    if resu = 0 then
      if not fileexists(songplayerfo.historyfn.Value) then
      begin
        resu := -1;
        ShowMessage(songplayerfo.historyfn.Value + ' does not exist...');
      end;

    if resu = 0 then
    begin
      fileex := fileext(PChar(ansistring(songplayer2fo.historyfn.Value)));
      if (lowercase(fileex) = 'wav') or (lowercase(fileex) = 'ogg') or
        (lowercase(fileex) = 'flac') or (lowercase(fileex) = 'mp3') or
        (lowercase(fileex) = 'mod') or (lowercase(fileex) = 'it') or
        (lowercase(fileex) = 's3m') or (lowercase(fileex) = 'xm') then
      else
      begin
        resu := -1;
        ShowMessage(songplayer2fo.historyfn.Value + ' is not a audio file...');
      end;

    end;

    if resu = 0 then
      if not fileexists(songplayer2fo.historyfn.Value) then
      begin
        resu := -1;
        ShowMessage(songplayer2fo.historyfn.Value + ' does not exist...');
      end;

    if resu = 0 then
    begin
      if directmix.Value then
        totmixinterval := 1
      else
        totmixinterval := roundmath(timemix.Value / 10);

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

      if lastrowplayed <> -1 then
        if mainfo.typecolor.Value = 2 then
        begin
          for x := 0 to filelistfo.list_files.rowcount - 1 do
            filelistfo.list_files.rowfontstate[x] := 1;

          filelistfo.list_files.rowcolorstate[lastrowplayed] := 2;
          filelistfo.list_files.rowfontstate[lastrowplayed]  := 1;
        end
        else
        begin
          for x := 0 to filelistfo.list_files.rowcount - 1 do
            filelistfo.list_files.rowfontstate[x] := 0;
          filelistfo.list_files.rowcolorstate[lastrowplayed] := 0;
          filelistfo.list_files.rowfontstate[lastrowplayed] := 0;
        end;

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
        tbutton2.face.template := mainfo.tfaceplayerlight;
        tbutton3.face.template := mainfo.tfaceorange;

        filelistfo.tbutton2.face.template := mainfo.tfaceorange;
        filelistfo.tbutton1.face.template := mainfo.tfaceplayerlight;

        thetypemix         := 0;
        volumeleft1.Value  := 0;
        volumeright1.Value := 0;

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

        hasmixed2 := True;

        timermix.Enabled := True;

      end
      else
      begin

        thetypemix         := 1;
        volumeleft2.Value  := 0;
        volumeright2.Value := 0;
        tbutton3.face.template := mainfo.tfaceplayerlight;
        tbutton2.face.template := mainfo.tfaceorange;
        filelistfo.tbutton1.face.template := mainfo.tfaceorange;
        filelistfo.tbutton2.face.template := mainfo.tfaceplayerlight;
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
      end;
      tbutton4.Visible := True;
      tbutton5.Visible := False;
      tbutton6.Visible := False;
      application.ProcessMessages;
    end;
  end
  else
    ShowMessage('There is no audio file in the list...');
end;


procedure tcommanderfo.ontimermix(const Sender: TObject);
var
  muststop: integer = 0;
begin
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
        volumeleft1.Value  := maxvolleft1;
      end;

      if muststop = 1 then
      begin
        timermix.Enabled := False;
        tbutton4.Visible := False;
        tbutton4.imagenr := 1;
        incmixinterval   := 0;
      end;
    end
    else
    begin
      volumeright2.Value := 0;
      songplayer2fo.doplayerstop(Sender);
      volumeleft1.Value  := maxvolleft1;
      timermix.Enabled   := False;
      tbutton4.Visible   := False;
      tbutton5.Visible   := False;
      tbutton6.Visible   := False;
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
      volumeleft2.Value := maxvolleft2;

      songplayerfo.doplayerstop(Sender);
      muststop := 1;
    end;

    if ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1 > 0 then
      volumeright1.Value := ((totmixinterval - incmixinterval) / totmixinterval) - initvolright1
    else
    begin
      volumeright1.Value := 0;
      songplayerfo.doplayerstop(Sender);
      volumeleft2.Value  := maxvolleft2;
      muststop           := 1;
    end;

    if muststop = 1 then
    begin
      timermix.Enabled := False;
      tbutton4.Visible := False;
      tbutton5.Visible := False;
      tbutton6.Visible := False;
      incmixinterval   := 0;
    end;

  end
  else
  begin
    volumeright1.Value := 0;
    songplayerfo.doplayerstop(Sender);
    volumeleft2.Value  := maxvolleft2;
    timermix.Enabled   := False;
    tbutton4.Visible   := False;
    tbutton5.Visible   := False;
    tbutton6.Visible   := False;
  end;
end;


procedure tcommanderfo.visiblechangeev(const Sender: TObject);
begin
  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and
    (Assigned(dockpanel2fo)) and (Assigned(dockpanel3fo)) and
    (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showcommander']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': ' +
        lang_commanderfo[Ord(co_commanderfo)]
    else
      mainfo.tmainmenu1.menu.itembynames(['show', 'showcommander']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
        lang_commanderfo[Ord(co_commanderfo)];

    if (norefresh = False) and (parentwidget <> nil) then
    begin

      if (parentwidget = mainfo.basedock) or
        (mainfo.basedock.dragdock.currentsplitdir = sd_tabed) then
        mainfo.updatelayoutstrum();

      if (parentwidget = dockpanel1fo.basedock) or
        (dockpanel1fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel1fo.Visible then
          dockpanel1fo.updatelayoutpan();

      if (parentwidget = dockpanel2fo.basedock) or
        (dockpanel2fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel2fo.Visible then
          dockpanel2fo.updatelayoutpan();

      if (parentwidget = dockpanel3fo.basedock) or
        (dockpanel3fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel3fo.Visible then
          dockpanel3fo.updatelayoutpan();

      if (parentwidget = dockpanel4fo.basedock) or
        (dockpanel4fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel4fo.Visible then
          dockpanel4fo.updatelayoutpan();

      if (parentwidget = dockpanel5fo.basedock) or
        (dockpanel5fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel5fo.Visible then
          dockpanel5fo.updatelayoutpan();
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
  docallback        := False;
  Timermix.Enabled  := False;
  timersent.Enabled := False;

  Timermix.Free;
  timersent.Free;
end;

procedure tcommanderfo.onsetinput(const Sender: TObject);
begin

  if (hasinit = 1) and (devin > -1) then
    if butinput.Value = True then
    begin

      nameinput.face.template := mainfo.tfacered;

      tslider3.Enabled := True;
      uos_Stop(theinput);

      uos_CreatePlayer(theinput);
      // writeln('ok create');

      OutputIndex4 := uos_AddIntoDevOut(theinput, configfo.devoutcfg.Value, configfo.latrec.Value, -1, -1, -1, -1, -1);

      // writeln('OutputIndex4 = ' + inttostr(OutputIndex4));
      // uos_outputsetenable(theinput,OutputIndex4,true);

      // InputIndex4 := uos_AddFromDevIn(theinput);

      InputIndex4 := uos_AddFromDevIn(theinput, configfo.devincfg.Value, -1, -1, -1, -1, -1, -1);

      //  writeln('InputIndex4 = ' + inttostr(InputIndex4));

      uos_InputAddDSP1ChanTo2Chan(theinput, InputIndex4);

      uos_InputSetLevelEnable(theinput, InputIndex4, 2);

      uos_InputAddDSPVolume(theinput, InputIndex4, 1, 1);

      //   uos_LoopProcIn(theinput, InputIndex4, @LoopProcPlayer1);

      uos_InputSetDSPVolume(theinput, InputIndex4, tslider3.Value, tslider3.Value, True);

      /////// procedure to execute when stream is terminated
      //   uos_EndProc(therecplayer, @ClosePlayer1);

      uos_Play(theinput);  /////// everything is ready to play...

    end
    else
    begin
      uos_Stop(theinput);
      nameinput.face.template := mainfo.tfaceplayerlight;
    end;  
 

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
    genleftvolvalue.Caption := utf8decode(IntToStr(roundmath(genvolleft.Value * 15)));
    genrightvolvalue.Caption := utf8decode(IntToStr(roundmath(genvolright.Value * 15)));
  end
  else if (tslider(Sender).tag = 0) then
    genleftvolvalue.Caption  := utf8decode(IntToStr(roundmath(genvolleft.Value * 15)))
  else
    genrightvolvalue.Caption := utf8decode(IntToStr(roundmath(genvolright.Value * 15)));

  if hasinit = 1 then
  begin
    songplayerfo.changevolume(Sender);
    songplayer2fo.changevolume(Sender);
  end;
end;

procedure tcommanderfo.onresetgenvol(const Sender: TObject);
begin
  if linkvolgen.Value = True then
  begin
    genvolright.Value := 0.666666;
    genvolleft.Value  := 0.666666;
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

procedure tcommanderfo.oncre(const Sender: TObject);
var
  i1, childn: integer;
begin
 {$if defined(netbsd) or defined(darwin)}
  timagelist1.options := [bmo_masked]; 
  timagelist3.options := [bmo_masked]; 
  windowopacity := 1;
 {$else}
  windowopacity := 0;
 {$endif}

 {$if defined(nofade)}
  tframecomp2.template := tframecompnul.template;
 {$endif}

  setlength(boundchildco, childrencount);

  childn := childrencount;

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildco[i1].left   := children[i1].left;
    boundchildco[i1].top    := children[i1].top;
    boundchildco[i1].Width  := children[i1].Width;
    boundchildco[i1].Height := children[i1].Height;
    boundchildco[i1].Name   := children[i1].Name;
  end;

  with tgroupall do
  begin
    setlength(boundchildco, length(boundchildco) + tgroupall.childrencount);

    for i1 := 0 to tgroupall.childrencount - 1 do
    begin
      boundchildco[i1 + childn].left   := children[i1].left;
      boundchildco[i1 + childn].top    := children[i1].top;
      boundchildco[i1 + childn].Width  := children[i1].Width;
      boundchildco[i1 + childn].Height := children[i1].Height;
      boundchildco[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildco);
  end;

  with tgroupboxplayers do
  begin
    setlength(boundchildco, length(boundchildco) + tgroupboxplayers.childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildco[i1 + childn].left   := children[i1].left;
      boundchildco[i1 + childn].top    := children[i1].top;
      boundchildco[i1 + childn].Width  := children[i1].Width;
      boundchildco[i1 + childn].Height := children[i1].Height;
      boundchildco[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildco);
  end;

  with tgroupboxdrums do
  begin
    setlength(boundchildco, length(boundchildco) + childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildco[i1 + childn].left   := children[i1].left;
      boundchildco[i1 + childn].top    := children[i1].top;
      boundchildco[i1 + childn].Width  := children[i1].Width;
      boundchildco[i1 + childn].Height := children[i1].Height;
      boundchildco[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildco);
  end;

  with tgroupboxinput do
  begin
    setlength(boundchildco, length(boundchildco) + childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildco[i1 + childn].left   := children[i1].left;
      boundchildco[i1 + childn].top    := children[i1].top;
      boundchildco[i1 + childn].Width  := children[i1].Width;
      boundchildco[i1 + childn].Height := children[i1].Height;
      boundchildco[i1 + childn].Name   := children[i1].Name;
    end;
  end;

end;

procedure tcommanderfo.onchangevuset(const Sender: TObject);
begin
  vuinvar := vuin.Value;
  if vuinvar = False then
  begin
    vuLeft.Visible   := False;
    vuRight.Visible  := False;
    vuLeft2.Visible  := False;
    vuRight2.Visible := False;
    with songplayerfo do
    begin
      vuLeft.Visible  := False;
      vuRight.Visible := False;
    end;
    with songplayer2fo do
    begin
      vuLeft.Visible  := False;
      vuRight.Visible := False;
    end;
  end
  else
  begin

    if uos_GetStatus(theplayer) = 1 then
    begin
      vuLeft.Visible  := True;
      vuRight.Visible := True;
      with songplayerfo do
      begin
        vuLeft.Visible  := True;
        vuRight.Visible := True;
      end;
    end;

    if uos_GetStatus(theplayer2) = 1 then
    begin
      vuLeft2.Visible  := True;
      vuRight2.Visible := True;
      with songplayer2fo do
      begin
        vuLeft.Visible  := True;
        vuRight.Visible := True;
      end;
    end;
  end;
end;

procedure tcommanderfo.onpausemix(const Sender: TObject);
begin
  timermix.Enabled := False;
  tbutton4.Visible := False;
  tbutton5.Visible := True;
  tbutton6.Visible := True;
end;

procedure tcommanderfo.onresumemix(const Sender: TObject);
begin
  if thetypemix <> TButton(Sender).tag then
  begin

    incmixinterval := totmixinterval - incmixinterval;
    if TButton(Sender).tag = 0 then
    begin
      tbutton2.face.template := mainfo.tfacebutgray;
      tbutton3.face.template := mainfo.tfaceorange;
      filelistfo.tbutton2.face.template := mainfo.tfaceorange;
      filelistfo.tbutton1.face.template := mainfo.tfaceplayer;
    end
    else
    begin
      tbutton2.face.template := mainfo.tfaceorange;
      tbutton3.face.template := mainfo.tfacebutgray;
      filelistfo.tbutton2.face.template := mainfo.tfaceplayerlight;
      filelistfo.tbutton1.face.template := mainfo.tfaceorange;
    end;
  end;

  thetypemix       := TButton(Sender).tag;
  timermix.Enabled := True;
  tbutton4.Visible := True;
  tbutton5.Visible := False;
  tbutton6.Visible := False;
end;

procedure tcommanderfo.onchangedirectmix(const Sender: TObject);
begin
  if directmix.Value then
    totmixinterval := 1
  else
    totmixinterval := roundmath(timemix.Value / 10);
end;

procedure tcommanderfo.onexecbutlght(const Sender: TObject);
begin

  if TButton(Sender).Name = 'Brandommix' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        Brandommix.font.color := cl_black;
      randommix.Value         := True;
      TButton(Sender).tag     := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        Brandommix.font.color := cl_white;
      randommix.Value         := False;
      TButton(Sender).tag     := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'linkvolgenb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        linkvolgenb.font.color := cl_black;
      linkvolgen.Value         := True;
      TButton(Sender).tag      := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        linkvolgenb.font.color := cl_white;
      linkvolgen.Value         := False;
      TButton(Sender).tag      := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'linkvolb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        linkvolb.font.color := cl_black;
      linkvol.Value         := True;
      TButton(Sender).tag   := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        linkvolb.font.color := cl_white;
      linkvol.Value         := False;
      TButton(Sender).tag   := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'guimixb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        guimixb.font.color := cl_black;
      guimix.Value         := True;
      TButton(Sender).tag  := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        guimixb.font.color := cl_white;
      guimix.Value         := False;
      TButton(Sender).tag  := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'speccalcb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        speccalcb.font.color := cl_black;
      speccalc.Value         := True;
      TButton(Sender).tag    := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        speccalcb.font.color := cl_white;
      speccalc.Value         := False;
      TButton(Sender).tag    := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'linkvol2b' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        linkvol2b.font.color := cl_black;
      linkvol2.Value         := True;
      TButton(Sender).tag    := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        linkvol2b.font.color := cl_white;
      linkvol2.Value         := False;
      TButton(Sender).tag    := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'automixb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        automixb.font.color := cl_black;
      automix.Value         := True;
      TButton(Sender).tag   := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        automixb.font.color := cl_white;
      automix.Value         := False;
      TButton(Sender).tag   := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'vuinb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        vuinb.font.color  := cl_black;
      vuin.Value          := True;
      TButton(Sender).tag := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        vuinb.font.color  := cl_white;
      vuin.Value          := False;
      TButton(Sender).tag := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;

  if TButton(Sender).Name = 'directmixb' then
    if TButton(Sender).tag = 0 then
    begin
      if mainfo.typecolor.Value = 2 then
        directmixb.font.color := cl_black;
      directmix.Value         := True;
      TButton(Sender).tag     := 1;
      TButton(Sender).face.template := mainfo.tfacegreen;
    end
    else
    begin
      if mainfo.typecolor.Value = 2 then
        directmixb.font.color := cl_white;
      directmix.Value         := False;
      TButton(Sender).tag     := 0;
      TButton(Sender).face.template := mainfo.tfaceplayerlight;
    end;
end;


procedure tcommanderfo.ontimerinit(const Sender: TObject);
begin

  if linkvolgen.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      linkvolgenb.font.color  := cl_black;
    linkvolgenb.tag           := 1;
    linkvolgenb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      linkvolgenb.font.color  := cl_white;
    linkvolgenb.tag           := 0;
    linkvolgenb.face.template := mainfo.tfaceplayerlight;
  end;

  if linkvol.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      linkvolb.font.color  := cl_black;
    linkvolb.tag           := 1;
    linkvolb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      linkvolb.font.color  := cl_white;
    linkvolb.tag           := 0;
    linkvolb.face.template := mainfo.tfaceplayerlight;
  end;

  if guimix.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      guimixb.font.color  := cl_black;
    guimixb.tag           := 1;
    guimixb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      guimixb.font.color  := cl_white;
    guimixb.tag           := 0;
    guimixb.face.template := mainfo.tfaceplayerlight;
  end;

  if speccalc.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      speccalcb.font.color  := cl_black;
    speccalcb.tag           := 1;
    speccalcb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      speccalcb.font.color  := cl_white;
    speccalcb.tag           := 0;
    speccalcb.face.template := mainfo.tfaceplayerlight;
  end;

  if linkvol2.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      linkvol2b.font.color  := cl_black;
    linkvol2b.tag           := 1;
    linkvol2b.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      linkvol2b.font.color  := cl_white;
    linkvol2b.tag           := 0;
    linkvol2b.face.template := mainfo.tfaceplayerlight;
  end;

  if automix.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      automixb.font.color  := cl_black;
    automixb.tag           := 1;
    automixb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      automixb.font.color  := cl_white;
    automixb.tag           := 0;
    automixb.face.template := mainfo.tfaceplayerlight;
  end;

  if vuin.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      vuinb.font.color  := cl_black;
    vuinb.tag           := 1;
    vuinb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      vuinb.font.color  := cl_white;
    vuinb.tag           := 0;
    vuinb.face.template := mainfo.tfaceplayerlight;
  end;

  if directmix.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      directmixb.font.color  := cl_black;
    directmixb.tag           := 1;
    directmixb.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      directmixb.font.color  := cl_white;
    directmixb.tag           := 0;
    directmixb.face.template := mainfo.tfaceplayerlight;
  end;

  if randommix.Value then
  begin
    if mainfo.typecolor.Value = 2 then
      Brandommix.font.color  := cl_black;
    Brandommix.tag           := 1;
    Brandommix.face.template := mainfo.tfacegreen;
  end
  else
  begin
    if mainfo.typecolor.Value = 2 then
      Brandommix.font.color  := cl_white;
    Brandommix.tag           := 0;
    Brandommix.face.template := mainfo.tfaceplayerlight;
  end;

end;

procedure tcommanderfo.onsetsysvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  sysvolbut.Caption := msestring(IntToStr(roundmath(avalue * 10)));
{$if (defined(linux)) and (not defined(cpuaarch64)) and (not defined(cpuarm))}
  docallback        := False;
  ALSAmixerSetVolume(0, roundmath(avalue * 100));
  ALSAmixerSetVolume(1, roundmath(avalue * 100));
  docallback        := True;
  {$ENDIF}

  {$if defined(windows)}
    docallback := false;
    WINmixerSetVolume(0, roundmath(avalue * 100));
    WINmixerSetVolume(1, roundmath(avalue * 100));
    docallback := true;
  {$ENDIF}
end;

procedure tcommanderfo.dotimercallback(const Sender: TObject);
begin
{$if (defined(linux)) and (not defined(cpuaarch64)) and (not defined(cpuarm))}
  if docallback then
  begin
    commanderfo.sysvol.Value      := ALSAmixerGetVolume(0) / 100;
    commanderfo.sysvolbut.Caption := msestring(IntToStr(roundmath(commanderfo.sysvol.Value * 10)));
  end;
{$ENDIF}

{$if defined(windows)}
 if docallback then
  begin
    commanderfo.sysvol.value := wm_MasterVolLeft / 100;
    commanderfo.sysvolbut.caption := inttostr(roundmath(commanderfo.sysvol.value*10));
  end;
 {$ENDIF}
end;

procedure tcommanderfo.onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if mainfo.ttimer2.Enabled then
    mainfo.ttimer2.restart // to reset
  else
    mainfo.ttimer2.Enabled := True;
end;

procedure tcommanderfo.resetsysvol(const Sender: TObject);
begin
  sysvol.Value := 0.666666;
end;

end.

