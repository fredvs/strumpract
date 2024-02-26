
unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 {$ifdef unix}baseunix,{$endif}Math,msetypes,mseglob,mseguiglob,mseguiintf,
 mseapplication,msestat,msemenus,msefileutils,msegui,msegraphics,msetimer,
 msegraphutils,mseevent,msedatalist,mseclasses,msegridsglob,mseforms,msedock,
 msedragglob,msesimplewidgets,mclasses,msewidgets,mseact,msebitmap,msedataedits,
 msedatanodes,mseedit,msefiledialogx,msegrids,mseificomp,mseificompglob,
 mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,msesys,SysUtils,
 msegraphedits,msescrollbar,msedispwidgets,mserichstring,msedropdownlist;

type
  tfilelistfo = class(tdockform)
    Timersent: Ttimer;
    Timercount: Ttimer;
    tgroupbox1: tgroupbox;
    historyfn: thistoryedit;
    tbutton1: TButton;
    tbutton2: TButton;
    list_files: tstringgrid;
    edfilescount: tintegeredit;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    tbutton3: TButton;
    tbutton4: TButton;
    tbutton5: TButton;
    tstatfile1: tstatfile;
    tbutton6: TButton;
    tfiledialog1: tfiledialogx;
    tbutton11: TButton;
    ttimer1: ttimer;
    tbutton7: tbutton;
    tfiledialogx2: tfiledialogx;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onsent(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure ontimercount(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure onchangpathfromhist(const Sender: TObject);
    procedure onchangpath(const Sender: TObject; findex: integer);
    procedure ondoc(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var accept: Boolean; var processed: Boolean);
    procedure oncellev(const Sender: TObject; var info: celleventinfoty);
    procedure onbefdrop(const Sender: TObject);
    procedure onaftdrop(const Sender: TObject);
    procedure ondestr(const Sender: TObject);
    procedure loadlist(const Sender: TObject);
    procedure savelist(const Sender: TObject);
    procedure addfile(const Sender: TObject);
    procedure oncreate(const Sender: TObject);
    procedure afterdragend(const asender: TObject; const apos: pointty; var adragobject: tdragobject; const accepted: Boolean; var processed: Boolean);
    procedure opendir(const Sender: TObject);
    procedure onexecfind(const Sender: TObject);

    procedure onactiv(const Sender: TObject);
    procedure onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure resizefi(fontheight: integer);
    procedure timrefresh(const sender: TObject);
    procedure onafterscroll(const sender: tcustomscrollbar;
                   const akind: scrolleventty; const avalue: Real);
   procedure onresized(const sender: TObject);
  end;

var
  filelistfo: tfilelistfo;
  thefocusedcell: gridcoordty;
  sortord: integer = 0;

implementation

uses
  captionstrumpract,
  findmessage,
  songplayer,
  commander,
  dockpanel1,
  main,
  filelistform_mfm;

var
  fowidthf: integer;

procedure tfilelistfo.resizefi(fontheight: integer);
var
  ratio: float;
begin
  ratio        := fontheight / 12;
  bounds_cxmin := floor(442 * ratio);
  bounds_cxmax := bounds_cxmin;
  bounds_cymin := floor(128 * ratio);
  if (parentwidget <> nil) then
   bounds_cymax := bounds_cymin
   else bounds_cymax := 0;
 //  bounds_cx    := bounds_cxmin;
 
  font.Height  := fontheight;
  historyfn.font.Height  := fontheight;
  historyfn.font.color  := font.color;

  list_files.font.Height        := fontheight;
  list_files.rowfonts[0].Height := fontheight;
  list_files.rowfonts[1].Height := fontheight;

  frame.grip_size := floor(8 * ratio);
  fowidthf        := floor(442 * ratio);
  list_files[0].Width :=
    floor(list_files.Width - frame.grip_size - list_files.fixcols[-1].Width - list_files[1].Width - list_files[2].Width -
    list_files[3].Width - list_files[4].Width);

  list_files.Height        := Height - historyfn.height - 4;
 
  tbutton6.top := historyfn.top;
  tbutton3.top := historyfn.top;
  tbutton4.top := historyfn.top;
  tbutton5.top := historyfn.top;
  tbutton11.top := historyfn.top;
  tbutton1.top := historyfn.top;
  tbutton2.top := historyfn.top;
  
  tbutton6.Height := historyfn.Height;
  tbutton3.Height := historyfn.Height;
  tbutton4.Height := historyfn.Height;
  tbutton5.Height := historyfn.Height;
  tbutton11.Height := historyfn.Height;
  tbutton1.Height := historyfn.Height;
  tbutton2.Height := historyfn.Height;
   
end;

procedure tfilelistfo.formcreated(const Sender: TObject);
var
  x: integer;
  ordir2 : msestring;
begin
  Timersent          := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled  := False;
  Timersent.options  := [to_single];
  Timersent.ontimer  := @ontimersent;

  Timercount          := ttimer.Create(nil);
  Timercount.interval := 2500000;
  Timercount.Enabled  := False;
  Timercount.options  := [to_single];
  Timercount.ontimer  := @ontimercount;

  randomize;

  list_files.hint := ' To move a row: click+hold into the fixed column ' + lineend +
    ' and drag the row where you want. ';


  ordir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));
  
  ordir2 := filepath(statdirname);

  if fileexists(ordir2 + directoryseparator + 'list.ini') then
    filelistfo.tstatfile1.readstat(msestring(ordir2 + directoryseparator + 'list.ini'))
  else if trim(historyfn.Value) = '' then
  begin
    hasinit         := 1;
    historyfn.Value := msestring(ordir + 'sound' + directoryseparator + 'song' +
      directoryseparator);
    onchangpath(Sender, 0);
  end;

  list_files.fixcols[-1].captions.Count := list_files.rowCount;

  for x := 0 to list_files.rowCount - 1 do
    list_files.fixcols[-1].captions[x] := msestring(IntToStr(x + 1));
    
 end;

procedure tfilelistfo.ontimersent(const Sender: TObject);
begin
  hintpanel.Visible := False;
end;

procedure tfilelistfo.ontimercount(const Sender: TObject);
var
  x: integer;
begin
  list_files.fixcols[-1].captions.Count := list_files.rowCount;

  for x := 0 to list_files.rowCount - 1 do
    list_files.fixcols[-1].captions[x] := msestring(IntToStr(x + 1));
end;

procedure tfilelistfo.onsent(const Sender: TObject);
var
  theplaysender, thecaution, therandom: integer;
  mustmix: Boolean = False;
begin

  if directoryexists(historyfn.Value) then
  begin
    thefocusedcell := list_files.focusedcell;
    if (filelistfo.list_files.rowcount < 1) or (trim(list_files[0][thefocusedcell.row]) = '') then
    begin
      if filelistfo.list_files.rowcount < 1 then
      begin

        hintlabel.Caption :=
          'No song in file list. Please select a audio directory with songs...';
        hintpanel.Visible := True;
        if timersent.Enabled then
          timersent.restart // to reset
        else
          timersent.Enabled := True;
      end
      else
      begin
        thefocusedcell.row := 0;
        thefocusedcell.col := 0;
        list_files.firstrow;
        list_files.selectcell(thefocusedcell, csm_select, False);
      end;
    end
    else
    begin

      if Sender <> nil then
      begin
        if TButton(Sender).tag = 0 then
          theplaysender := 0
        else
          theplaysender := 1;
      end
      else if hasfocused1 = True then
        theplaysender := 0
      else
        theplaysender := 1;

      if (commanderfo.automix.Value = True) and (Sender = nil) then
      begin
        thecaution := 0;

        while (mustmix = False) and (thecaution < 50) do
        begin

          Inc(thecaution);

          if commanderfo.Brandommix.tag = 0 then
            if (thefocusedcell.row + 1 < list_files.rowcount) then
            begin
              if (list_files[3][thefocusedcell.row + 1] = '1') then
                mustmix := True;

              thefocusedcell.row := thefocusedcell.row + 1;
              list_files.rowdown;
            end
            else
            begin
              if (list_files[3][0] = '1') then
                mustmix          := True;
              thefocusedcell.row := 0;
              list_files.firstrow;
            end;

          if commanderfo.Brandommix.tag = 1 then
          begin
            therandom := random(list_files.rowcount - 1);
            application.ProcessMessages;
            if (list_files[3][therandom] = '1') then
            begin
              mustmix := True;
              thefocusedcell.row := therandom;
              list_files.defocuscell;
              list_files.datacols.clearselection;
              list_files.selectcell(thefocusedcell, csm_select, False);
              list_files.focuscell(thefocusedcell);
            end;
          end;
        end;
      end;

      if theplaysender = 0 then
        if fileexists((list_files[4][thefocusedcell.row])) then
        begin
          songplayerfo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);
          
          songplayerfo.historyfn.font.color := cl_black;
          songplayerfo.edvolleft.font.color := cl_black;
          songplayerfo.edvolright.font.color := cl_black;

          songplayerfo.historyfn.face.template := mainfo.tfaceorange;

          if songplayerfo.timersent.Enabled then
            songplayerfo.timersent.restart // to reset
          else
            songplayerfo.timersent.Enabled := True;

        end
        else
        begin

          hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) +
            ' does not exist or not mounted...';
          hintpanel.Visible := True;

          if timersent.Enabled then
            timersent.restart // to reset
          else
            timersent.Enabled := True;
        end;

      if theplaysender = 1 then
        if fileexists((list_files[4][thefocusedcell.row])) then
        begin

          songplayer2fo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);
          
          songplayer2fo.historyfn.font.color := cl_black;
          
          songplayer2fo.edvolleft.font.color := cl_black;
          songplayer2fo.edvolright.font.color := cl_black;
         
          songplayer2fo.historyfn.face.template := mainfo.tfaceorange;

          if songplayer2fo.timersent.Enabled then
            songplayer2fo.timersent.restart // to reset
          else
            songplayer2fo.timersent.Enabled := True;
        end
        else
        begin
          hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) +
            ' does not exist or not mounted...';
          hintpanel.Visible := True;
          if timersent.Enabled then
            timersent.restart // to reset
          else
            timersent.Enabled := True;
        end;

      list_files.selectcell(thefocusedcell, csm_select, False);

    end;
  end
  else
  begin
    hintlabel.Caption := 'Directory ' + historyfn.Value + ' does not exist or not mounted...';
    hintpanel.Visible := True;
    if timersent.Enabled then
      timersent.restart // to reset
    else
      timersent.Enabled := True;
  end;
end;

procedure tfilelistfo.whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 5;
end;

procedure tfilelistfo.onchangpathfromhist(const Sender: TObject);
begin
  onchangpath(Sender, 0);
end;

procedure tfilelistfo.onchangpath(const Sender: TObject; findex: integer);
var
  x, y, y2, z, fsize: integer;
  // datalist_files: tfiledatalist;
  strfilter1, strfilter2, strfilter3, strfilter4: msestring;
  thestrnum, thestrx, thestrext, thestrfract: msestring;
  datalist_files: TStringList;
  SR: TSearchRec;
  {$ifdef unix}  
  info: Stat;
   {$else}
  info: fileinfoty;
  {$endif}
begin
  if hasinit = 1 then
    if directoryexists(tosysfilepath(historyfn.Value)) then
    begin
      list_files.tag := 0;

      if findex = 0 then
      begin
        strfilter1 := 'mp3';
        strfilter2 := 'wav';
        strfilter3 := 'ogg';
        strfilter4 := 'flac';
      end
      else if findex = 1 then
      begin
        strfilter1 := 'mp3';
        strfilter2 := 'mp3';
        strfilter3 := 'mp3';
        strfilter4 := 'mp3';
      end
      else if findex = 2 then
      begin
        strfilter1 := 'wav';
        strfilter2 := 'wav';
        strfilter3 := 'wav';
        strfilter4 := 'wav';
      end
      else if findex = 3 then
      begin
        strfilter1 := 'ogg';
        strfilter2 := 'ogg';
        strfilter3 := 'ogg';
        strfilter4 := 'ogg';
      end
      else if findex = 4 then
      begin
        strfilter1 := 'flac';
        strfilter2 := 'flac';
        strfilter3 := 'flac';
        strfilter4 := 'flac';
      end
      else
      begin
        strfilter1 := 'mp3';
        strfilter2 := 'wav';
        strfilter3 := 'ogg';
        strfilter4 := 'flac';
      end;

      historyfn.hint := ' Selected: ' + historyfn.Value + ' ';

      datalist_files := TStringList.Create;
      try
        if FindFirst(rawbytestring(historyfn.Value + '*.*'), faArchive, SR) = 0 then
        begin
          repeat
            if (lowercase(fileext(msestring(SR.Name))) = strfilter1) or
              (lowercase(fileext(msestring(SR.Name))) = strfilter2) or
              (lowercase(fileext(msestring(SR.Name))) = strfilter3) or
              (lowercase(fileext(msestring(SR.Name))) = strfilter4) then
              datalist_files.Add(SR.Name); //Fill the list
          until FindNext(SR) <> 0;
          FindClose(SR);
        end;

        Caption := tosysfilepath(historyfn.Value);

        list_files.rowcount := datalist_files.Count;


        for x := 0 to datalist_files.Count - 1 do
        begin
          list_files[0][x] := msestring(filenamebase(msestring(datalist_files[x])));
          list_files[1][x] := msestring(fileext(msestring(datalist_files[x])));

          // writeln(datalist_files[x]);

        {$ifdef unix}
        FpStat(rawbytestring(trim(historyfn.Value + directoryseparator + msestring(datalist_files[x]))), info); 
        {$else}
          getfileinfo(msestring(trim(historyfn.Value + directoryseparator + datalist_files[x])), info);
        {$endif}

        {$ifdef unix}  
        fsize := info.st_size;
        {$else}
          fsize := info.extinfo1.size;
        {$endif}

          if fsize div 1000000000 > 0 then
          begin
            y2        := Trunc(Frac(fsize / 1000000000) * Power(10, 1));
            y         := fsize div 1000000000;
            thestrx   := '~';
            thestrext := ' GB';
          end
          else if fsize div 1000000 > 0 then
          begin
            y2        := Trunc(Frac(fsize / 1000000) * Power(10, 1));
            y         := fsize div 1000000;
            thestrx   := '_';
            thestrext := ' MB';
          end
          else if fsize div 1000 > 0 then
          begin
            y2        := Trunc(Frac(fsize / 1000) * Power(10, 1));
            y         := fsize div 1000;
            thestrx   := '^';
            thestrext := ' KB';
          end
          else
          begin
            y2        := 0;
            y         := fsize;
            thestrx   := ' ';
            thestrext := ' B';
          end;


          thestrnum := msestring(IntToStr(y));

          z := Length(thestrnum);

          if z < 15 then
            for y := 0 to 14 - z do
              thestrnum := ' ' + thestrnum;

          if y2 > 0 then
            thestrfract := msestring('.' + IntToStr(y2))
          else
            thestrfract := '';

          list_files[2][x] := thestrx + thestrnum + thestrfract + thestrext;
          list_files[3][x] := msestring(IntToStr(1));
          list_files[4][x] := msestring(tosysfilepath(historyfn.Value + msestring(datalist_files[x])));

        end;

        edfilescount.Value := list_files.rowcount;

        list_files.fixcols[-1].captions.Count := list_files.rowCount;

        for x := 0 to list_files.rowCount - 1 do
        begin
          list_files.fixcols[-1].captions[x] := msestring(IntToStr(x + 1));
          list_files.rowcolorstate[x]        := -1;
        end;

        edfilescount.Value := list_files.rowcount;
        //filescount.Value   := msestring(IntToStr(edfilescount.Value));

      finally
        datalist_files.Free;
      end;

      onfloat(nil);
      list_files.defocuscell;
      list_files.datacols.clearselection;

    end;
end;

procedure tfilelistfo.ondoc(const Sender: TObject);
begin
 resizefi(fontheightused);
end;

procedure tfilelistfo.onfloat(const Sender: TObject);
begin
  resizefi(fontheightused);
  bounds_cxmax := fowidthf;
  bounds_cymax := 0;

end;

procedure tfilelistfo.afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var accept: Boolean; var processed: Boolean);
begin
  if parentwidget <> nil then
    //size := sizebefdock;
  ;
end;

procedure tfilelistfo.visiblechangeev(const Sender: TObject);
begin
  if (isactivated = True) and (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and (Assigned(
    dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin

    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showlist']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': ' +
        lang_mainfo[Ord(ma_fileslist)]
    else
      mainfo.tmainmenu1.menu.itembynames(['show', 'showlist']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
        lang_mainfo[Ord(ma_fileslist)];

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

procedure tfilelistfo.oncellev(const Sender: TObject; var info: celleventinfoty);
var
  cellpos: gridcoordty;
  x: integer;
begin
  cellpos := info.cell;


  if (info.eventkind = cek_buttonpress) and (cellpos.col = -1) then
  begin
    list_files.datacols[0].options := list_files.datacols[0].options +
      [co_nosort];
    list_files.datacols[1].options := list_files.datacols[1].options +
      [co_nosort];
    list_files.datacols[2].options := list_files.datacols[2].options +
      [co_nosort];
    list_files.datacols[3].options := list_files.datacols[3].options +
      [co_nosort];

  end
  else if (info.eventkind = cek_buttonrelease) or (info.eventkind = cek_focusedcellchanged) then

    if (cellpos.row = -1) and (cellpos.col = 3) then
    begin
      // writeln(inttostr(cellpos.col) + ' ' + inttostr(cellpos.row));
      if list_files.tag = 0 then
      begin
        list_files.tag := 1;
        for x          := 0 to list_files.rowCount - 1 do
          list_files[3][x] := msestring(IntToStr(0));
      end
      else
      begin
        list_files.tag := 0;
        for x          := 0 to list_files.rowCount - 1 do
          list_files[3][x] := msestring(IntToStr(1));
      end;
    end
    else if (cellpos.row > -1) then
    begin
      cellpos.col := 0;
      list_files.selectcell(cellpos, csm_select, False);
    end
    else
    begin
      list_files.datacols[0].options := list_files.datacols[0].options -
        [co_nosort];
      list_files.datacols[1].options := list_files.datacols[1].options -
        [co_nosort];
      list_files.datacols[2].options := list_files.datacols[2].options -
        [co_nosort];
      list_files.datacols[3].options := list_files.datacols[3].options -
        [co_nosort];
    end;

  if (info.eventkind = cek_buttonrelease) then
  begin
    if (cellpos.row > -1) and (ss_double in info.mouseeventinfopo^.shiftstate) then
    begin

      if filelistfo.tbutton1.face.template = mainfo.tfaceorange then
        onsent(tbutton1)
      else if filelistfo.tbutton2.face.template = mainfo.tfaceorange then
        onsent(tbutton2);

      //  writeln('button 2x click');   
      if commanderfo.tbutton2.face.template = mainfo.tfaceorange then

        commanderfo.onstartstop(commanderfo.tbutton2)//   writeln('onstartstop(tbutton2)');  

      else if commanderfo.tbutton3.face.template = mainfo.tfaceorange then

        commanderfo.onstartstop(commanderfo.tbutton3)//  writeln('onstartstop(tbutton3)');  
      ;

    end;

    if timercount.Enabled then
      timercount.restart // to reset
    else
      timercount.Enabled := True;

  end;
end;

procedure tfilelistfo.onbefdrop(const Sender: TObject);
begin
  historyfn.Width := width - 38;
end;

procedure tfilelistfo.onaftdrop(const Sender: TObject);
begin
  historyfn.Width := tbutton3.left - 29;
  historyfn.Value := tosysfilepath(extractfilepath(historyfn.Value));
end;

procedure tfilelistfo.ondestr(const Sender: TObject);
begin
  timersent.Free;
  timercount.Free;
end;

procedure tfilelistfo.loadlist(const Sender: TObject);
var
  x: integer;
  cellpos: gridcoordty;
begin
  
  tfiledialog1.controller.icon := icon;
  
  tfiledialogx2.controller.captionopen := 'Open List File';
  tfiledialogx2.controller.options := [fdo_savelastdir, fdo_sysfilename];
 
  tfiledialogx2.controller.fontcolor   := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialogx2.controller.backcolor := $A6A6A6
  else
    tfiledialogx2.controller.backcolor := cl_default;

  tfiledialogx2.controller.filter   := '"*.lis"';

  if tfiledialogx2.controller.filename = '' then
  tfiledialogx2.controller.filename := GetUserDir + directoryseparator;

  if tfiledialogx2.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialogx2.controller.filename) then
    begin

      tstatfile1.readstat(msestring(tfiledialogx2.controller.filename));
      cellpos.row := 0;
      cellpos.col := 0;

      list_files.selectcell(cellpos, csm_select, False);

      edfilescount.Value := filelistfo.list_files.rowcount;

      Caption := removefileext(tfiledialogx2.controller.filename);

      list_files.fixcols[-1].captions.Count := filelistfo.list_files.rowCount;
   
      list_files.defocuscell;
      list_files.datacols.clearselection;

      for x := 0 to list_files.rowCount - 1 do
      begin
        list_files.fixcols[-1].captions[x] := msestring(IntToStr(x + 1));
        list_files.rowcolorstate[x]        := -1;
      end;

    end;
end;

procedure tfilelistfo.savelist(const Sender: TObject);
begin

   if tfiledialogx2.controller.filename = '' then
   tfiledialogx2.controller.filename := GetUserDir + directoryseparator + 'mylist.lis' else
   tfiledialogx2.controller.filename :=   ExtractFilePath(tfiledialogx2.controller.filename) + 'mylist.lis' ;
   
  tfiledialogx2.controller.icon := icon;
 
  tfiledialogx2.controller.captionsave := 'Save List as (must have ".lis" as extension).';
  tfiledialogx2.controller.fontcolor := cl_black;

  tfiledialogx2.controller.filter   := '"*.lis"';
  
  tfiledialogx2.controller.options  := [fdo_sysfilename, fdo_savelastdir];

  if tfiledialogx2.controller.Execute(fdk_save) = mr_ok then
     tstatfile1.writestat(tfiledialogx2.controller.filename);

end;

procedure tfilelistfo.addfile(const Sender: TObject);
var
  x, siz, y, y2, z: integer;
  info: fileinfoty;
   thestrnum, thestrx, thestrext, thestrfract: msestring;
begin
  
  tfiledialogx2.controller.icon := icon;
  tfiledialogx2.controller.captionopen := '+ ' + lang_filelistfo[Ord(fi_filelistfo)];
  
  if tfiledialogx2.controller.filename = '' then
  tfiledialogx2.controller.filename := GetUserDir + directoryseparator;

  tfiledialogx2.controller.fontcolor   := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialogx2.controller.backcolor := $A6A6A6
  else
    tfiledialogx2.controller.backcolor := cl_default;

  tfiledialogx2.controller.options := [fdo_sysfilename, fdo_savelastdir];

  tfiledialogx2.controller.filter :=
    '"*.mp3" "*.MP3" "*.wav" "*.WAV" "*.ogg" "*.OGG" "*.flac" "*.FLAC"';

  if tfiledialogx2.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialogx2.controller.filename) then
    begin
      getfileinfo(tfiledialogx2.controller.filename, info);

      siz := info.extinfo1.size;

      list_files.datacols[0].options := list_files.datacols[0].options +
        [co_nosort];
      list_files.datacols[1].options := list_files.datacols[1].options +
        [co_nosort];
      list_files.datacols[2].options := list_files.datacols[2].options +
        [co_nosort];
      list_files.datacols[3].options := list_files.datacols[3].options +
        [co_nosort];

      list_files.rowcount := list_files.rowcount + 1;
      x := list_files.rowcount - 1;

      //    if x > 0 then  list_files[-1][x] := inttostr(x+1);
      list_files[0][x] := msestring(filenamebase(tfiledialogx2.controller.filename));
      list_files[1][x] := msestring(fileext(tfiledialogx2.controller.filename));

      if siz div 1000000000 > 0 then
      begin
        y2        := Trunc(Frac(siz / 1000000000) * Power(10, 1));
        y         := siz div 1000000000;
        thestrx   := '~';
        thestrext := ' GB';
      end
      else if siz div 1000000 > 0 then
      begin
        y2        := Trunc(Frac(siz / 1000000) * Power(10, 1));
        y         := siz div 1000000;
        thestrx   := '_';
        thestrext := ' MB';
      end
      else if siz div 1000 > 0 then
      begin
        y2        := Trunc(Frac(siz) * Power(10, 1));
        y         := siz div 1000;
        thestrx   := '^';
        thestrext := ' KB';
      end
      else
      begin
        y2        := 0;
        y         := siz;
        thestrx   := ' ';
        thestrext := ' B';
      end;

      thestrnum := msestring(IntToStr(y));

      z := Length(thestrnum);

      if z < 15 then
        for y := 0 to 14 - z do
          thestrnum := ' ' + thestrnum;

      if y2 > 0 then
        thestrfract := msestring('.' + msestring(IntToStr(y2)))
      else
        thestrfract := '';

      list_files[2][x] := thestrx + thestrnum + thestrfract + thestrext;

      list_files[3][x]   := msestring(IntToStr(1));
      list_files[4][x]   := tfiledialogx2.controller.filename;
      edfilescount.Value := list_files.rowcount;

      list_files.fixcols[-1].captions.Count := list_files.rowCount;

      list_files.defocuscell;
      list_files.datacols.clearselection;

      for x := 0 to list_files.rowCount - 1 do
      begin
        list_files.fixcols[-1].captions[x] := msestring(IntToStr(x + 1));
        list_files.rowcolorstate[x]        := -1;
      end;

    end;
end;

procedure tfilelistfo.oncreate(const Sender: TObject);
var
ordir : msestring;

begin
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;  
 {$endif}
  
 {$if defined(netbsd) or defined(darwin)}
//  tbutton6.face.image :=  tbutton7.face.image; 
//  tbutton6.caption := 'C';
  tbutton1.face.image := tbutton7.face.image; 
  tbutton1.caption := '>1';
  tbutton11.face.image := tbutton7.face.image; 
  tbutton11.caption := 'F';
  tbutton2.face.image := tbutton7.face.image;
  tbutton2.caption := '>2'; 
  tbutton3.face.image := tbutton7.face.image; 
  tbutton3.caption := 'L';
  tbutton4.face.image := tbutton7.face.image; 
  tbutton4.caption := 'S';
  tbutton5.face.image := tbutton7.face.image; 
  tbutton5.caption := '+'; 
  {$endif} 
  
  ordir := filepath(statdirname);

  tstatfile1.filename := msestring(ordir +  directoryseparator + 'list.ini');

end;

procedure tfilelistfo.afterdragend(const asender: TObject; const apos: pointty; var adragobject: tdragobject; const accepted: Boolean; var processed: Boolean);
begin
  resizefi(fontheightused);
end;

procedure tfilelistfo.opendir(const Sender: TObject);
var
  x: integer;
  ara, arb: msestringarty;
begin

  tfiledialog1.controller.icon := icon;
  tfiledialog1.controller.captiondir :=
    lang_filelistfo[Ord(fi_tbutton6_hint)];
  tfiledialog1.controller.nopanel    := False;
  tfiledialog1.controller.compact    := False;

  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;

  setlength(ara, 6);
  setlength(arb, 6);

  ara[0] := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showall)];  {'Show All'}
  ara[1] := 'Mp3"';
  ara[2] := 'Wav';
  ara[3] := 'Ogg';
  ara[4] := 'Flac';
  ara[5] := 'All';

  arb[0] := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
  arb[1] := '"*.mp3"';
  arb[2] := '"*.wav"';
  arb[3] := '"*.ogg"';
  arb[4] := '"*.flac"';
  arb[5] := '"*.*"';

  tfiledialog1.controller.filterlist.asarraya := ara;
  tfiledialog1.controller.filterlist.asarrayb := arb;

  tfiledialog1.controller.filter    := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
  tfiledialog1.controller.fontcolor := cl_black;

  tfiledialog1.controller.options := [fdo_sysfilename, fdo_savelastdir, fdo_directory];

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
  begin
    historyfn.Value := tosysfilepath(tfiledialog1.controller.filename);
    historyfn.dropdown.history :=
      tfiledialog1.controller.history;

    // writeln(inttostr(tfiledialog1.controller.filterindex));
    onchangpath(Sender, tfiledialog1.controller.filterindex);

    list_files.defocuscell;
    list_files.datacols.clearselection;

    for x := 0 to list_files.rowCount - 1 do
      list_files.rowcolorstate[x] := -1;
  end;

end;

procedure tfilelistfo.onexecfind(const Sender: TObject);
begin
  imessages := 0;
  findmessagefo.Show(True);
end;

procedure tfilelistfo.onactiv(const Sender: TObject);
begin
  if historyfn.Value <> '' then
    Caption := historyfn.Value;
end;

procedure tfilelistfo.onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if mainfo.ttimer2.Enabled then
    mainfo.ttimer2.restart // to reset
  else
    mainfo.ttimer2.Enabled := True;
end;

procedure tfilelistfo.timrefresh(const sender: TObject);
var
x : integer;
begin
// force refresh
 for x := 0 to list_files.rowcount - 1 do
  list_files.rowfontstate[x] := list_files.rowfontstate[x];
end;

procedure tfilelistfo.onafterscroll(const sender: tcustomscrollbar;
               const akind: scrolleventty; const avalue: Real);
begin
if fontheightused <> 12 then
begin
timrefresh(sender);

 if ttimer1.Enabled then
      ttimer1.restart // to reset
    else
      ttimer1.Enabled := True;
end;   
end;

procedure tfilelistfo.onresized(const sender: TObject);
begin

end;

end.

