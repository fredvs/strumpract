
unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  {$ifdef unix}baseunix,{$endif}
  Math,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  msetimer,
  mseapplication,
  msestat,
  msemenus,
  msefileutils,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  msedatalist,
  mseclasses,
  msegridsglob,
  mseforms,
  msedock,
  msedragglob,
  msesimplewidgets,
  mclasses,
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
  msedropdownlist;

type
  tfilelistfo = class(tdockform)
    Timersent: Ttimer;
    Timercount: Ttimer;
    tfacecomp1: tfacecomp;
    tgroupbox1: tgroupbox;
    historyfn: thistoryedit;
    tbutton1: TButton;
    tbutton2: TButton;
    list_files: tstringgrid;
    filescount: tstringdisp;
    edfilescount: tintegeredit;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    tbutton3: TButton;
    tbutton4: TButton;
    tbutton5: TButton;
    tstatfile1: tstatfile;
    tbutton6: TButton;
    tfiledialog1: tfiledialogx;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onsent(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure ontimercount(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogxcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure onchangpathfromhist(const Sender: TObject);
    procedure onchangpath(const Sender: TObject; findex: integer);
    procedure onafterdialog(const Sender: tfiledialogxcontroller; var aresult: modalresultty);
    procedure befdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var processed: Boolean);
    procedure ondoc(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var accept: Boolean; var processed: Boolean);
    procedure oncellev(const Sender: TObject; var info: celleventinfoty);
    procedure onbefdrop(const Sender: TObject);
    procedure onaftdrop(const Sender: TObject);
    procedure onchangecount(const Sender: TObject);
    procedure ondestr(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure loadlist(const Sender: TObject);
    procedure savelist(const Sender: TObject);
    procedure addfile(const Sender: TObject);
    procedure oncreate(const Sender: TObject);
    procedure ondrawcell(const Sender: tcol; const Canvas: tcanvas; var cellinfo: cellinfoty);
    procedure afterdragend(const asender: TObject; const apos: pointty; var adragobject: tdragobject; const accepted: Boolean; var processed: Boolean);
    procedure opendir(const Sender: TObject);
  end;

var
  filelistfo: tfilelistfo;
  thefocusedcell: gridcoordty;
  sortord: integer = 0;

implementation

uses
  songplayer,
  commander,
  dockpanel1,
  status,
  main,
  filelistform_mfm;

procedure tfilelistfo.formcreated(const Sender: TObject);
var
  x: integer;
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

  list_files.hint := ' To move a row: click+hold into the fixed column ' + lineend +
    ' and drag the row where you want. ';


  ordir := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));

  if fileexists(ordir + 'ini' + directoryseparator + 'list.ini') then
    filelistfo.tstatfile1.readstat(msestring(ordir + 'ini' + directoryseparator + 'list.ini'))
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
  theplaysender, thecaution: integer;
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
            ;
          end;
        end;
      end;

      if theplaysender = 0 then
        if fileexists((list_files[4][thefocusedcell.row])) then
        begin
          songplayerfo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);

          songplayerfo.historyfn.face.template := mainfo.tfaceorange;
          if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized) and
            (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
            commanderfo.tbutton2.SetFocus;

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

          songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
          if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized) and
            (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
            commanderfo.tbutton3.SetFocus;
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
        filescount.Value   := msestring(IntToStr(edfilescount.Value) + ' files');

        // list_files.focusedindex := 0;

        //datalist_files.Free();

      finally
        datalist_files.Free;
      end;

      onfloat(nil);
      list_files.defocuscell;
      list_files.datacols.clearselection;

    end;
end;

procedure tfilelistfo.onafterdialog(const Sender: tfiledialogxcontroller; var aresult: modalresultty);
begin
  //list_files.path := dir.value;
end;

procedure tfilelistfo.befdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var processed: Boolean);
begin
  // if parentwidget = nil then sizebefdock := size;
end;

procedure tfilelistfo.ondoc(const Sender: TObject);
begin
  //sizebefdock := size;
end;

procedure tfilelistfo.onfloat(const Sender: TObject);
begin
  //sizebefdock.cx := 500;
  //sizebefdock.cy := 500;
  //size := sizebefdock;
  if parentwidget = nil then
  begin
  
    //  bounds_cy := ((list_files.rowcount + 1) * (list_files.datarowheight + 1)) + 37;
    bounds_cxmax := fowidth;
    //  bounds_cymax := rect1.cy - 60;
    bounds_cymax := 0;
  end;
end;

procedure tfilelistfo.afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var accept: Boolean; var processed: Boolean);
begin
  if parentwidget <> nil then
    //size := sizebefdock;
  ;
end;

procedure tfilelistfo.visiblechangeev(const Sender: TObject);
begin
  if (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and (Assigned(
    dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin
    if Visible then
      mainfo.tmainmenu1.menu[4].submenu[3].Caption := ' Hide File List '
    else
      mainfo.tmainmenu1.menu[4].submenu[3].Caption := ' Show File List ';
    if norefresh = False then
    begin
      mainfo.updatelayoutstrum();
      if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();
      if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();

      if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();

      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();

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
  else
  if (info.eventkind = cek_buttonrelease) or (info.eventkind = cek_focusedcellchanged) then

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

{
      if  (cellpos.row = -1) and  (cellpos.col < 3)

        then
        begin
          if sortord = 1 then
            begin
              list_files.datacols.options := list_files.datacols.options + [co_sortdescend];
              sortord := 0;
            end
          else
            begin
              list_files.datacols.options := list_files.datacols.options - [co_sortdescend];
              sortord := 1;
            end;
          list_files.datacols.sortcol := info.cell.col ;
        end;

}
    //      edfilescount.Value := list_files.rowcount;
    //      filescount.Value := msestring(IntToStr(edfilescount.Value) + ' files');

    //   if filelistfo.tbutton1.face.template = mainfo.tfaceorange then
    //   onsent(tbutton1) else
    //   if filelistfo.tbutton2.face.template = mainfo.tfaceorange then  onsent(tbutton2)  ;

    // {      
    if (cellpos.row > -1) and (ss_double in info.mouseeventinfopo^.shiftstate) then
    begin

      if filelistfo.tbutton1.face.template = mainfo.tfaceorange then
        onsent(tbutton1)
      else if filelistfo.tbutton2.face.template = mainfo.tfaceorange then
        onsent(tbutton2);


      //  writeln('button 2x click');   
      if commanderfo.tbutton2.face.template = mainfo.tfaceorange2 then

        commanderfo.onstartstop(commanderfo.tbutton2)//   writeln('onstartstop(tbutton2)');  

      else if commanderfo.tbutton3.face.template = mainfo.tfaceorange2 then

        commanderfo.onstartstop(commanderfo.tbutton3)//  writeln('onstartstop(tbutton3)');  
      ;

    end;
    // }

    if timercount.Enabled then
      timercount.restart // to reset
    else
      timercount.Enabled := True;

  end;
end;

procedure tfilelistfo.onbefdrop(const Sender: TObject);
begin
  historyfn.Width := 402;
end;

procedure tfilelistfo.onaftdrop(const Sender: TObject);
begin
  historyfn.Width := 128;
  historyfn.Value := tosysfilepath(extractfilepath(historyfn.Value));
end;

procedure tfilelistfo.onchangecount(const Sender: TObject);
begin
  filescount.Value := msestring(IntToStr(edfilescount.Value) + ' files');
end;

procedure tfilelistfo.ondestr(const Sender: TObject);
begin
  timersent.Free;
  timercount.Free;
end;

procedure tfilelistfo.ondock(const Sender: TObject);
begin
  bounds_cy := 128;
end;

procedure tfilelistfo.loadlist(const Sender: TObject);
var
  x: integer;
  ordir: msestring;
  cellpos: gridcoordty;
begin
  ordir := msestring(ExtractFilePath(msestring(ParamStr(0))) + 'list' + directoryseparator);
  tfiledialog1.controller.captionopen := 'Open List File';
  tfiledialog1.controller.options := [fdo_savelastdir, fdo_sysfilename];
  
  tfiledialog1.controller.fontcolor := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;


  tfiledialog1.controller.filter   := '"*.lis"';
  tfiledialog1.controller.filename := ordir;

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialog1.controller.filename) then
    begin

      tstatfile1.readstat(msestring(tfiledialog1.controller.filename));
      cellpos.row := 0;
      cellpos.col := 0;

      list_files.selectcell(cellpos, csm_select, False);

      edfilescount.Value := filelistfo.list_files.rowcount;

      Caption := removefileext(tfiledialog1.controller.filename);

      list_files.fixcols[-1].captions.Count := filelistfo.list_files.rowCount;

      filescount.Value := msestring(IntToStr(filelistfo.edfilescount.Value) + ' files');
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
  typstat          := 2;
  statusfo.Caption := 'Save Cue List as';
  statusfo.color   := $A7C9B9;
  statusfo.layoutname.Value := 'mycuelist';
  //statusfo.layoutname.frame.caption := 'Choose a cue-list name';
  statusfo.layoutname.Visible := True;
  statusfo.activate;
end;

procedure tfilelistfo.addfile(const Sender: TObject);
var
  x, siz, y, y2, z: integer;
  info: fileinfoty;
  thestrnum, thestrx, thestrext, thestrfract: msestring;
begin

  tfiledialog1.controller.captionopen := 'Open Audio File';

  tfiledialog1.controller.fontcolor   := cl_black;
  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;
    
    tfiledialog1.controller.options := [fdo_sysfilename,fdo_savelastdir];
 
  tfiledialog1.controller.filter :=
    '"*.mp3" "*.MP3" "*.wav" "*.WAV" "*.ogg" "*.OGG" "*.flac" "*.FLAC"';

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialog1.controller.filename) then
    begin
      getfileinfo(tfiledialog1.controller.filename, info);

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
      list_files[0][x] := msestring(filenamebase(tfiledialog1.controller.filename));
      list_files[1][x] := msestring(fileext(tfiledialog1.controller.filename));

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

      //   list_files[2][x] := msestring(IntToStr(siz Div 1000) + ' Kb');
      // list_files[3][x] := formatdatetime('YYYY',datalist_files.items[x].extinfo1.ctime);
      list_files[3][x]   := msestring(IntToStr(1));
      list_files[4][x]   := tfiledialog1.controller.filename;
      edfilescount.Value := list_files.rowcount;
      filescount.Value   := msestring(IntToStr(edfilescount.Value) + ' files');

      list_files.fixcols[-1].captions.Count := list_files.rowCount;

      edfilescount.Value := list_files.rowcount;
      filescount.Value   := msestring(IntToStr(edfilescount.Value) + ' files');

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
begin
  windowopacity       := 0;
  tstatfile1.filename := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'ini' +
    directoryseparator + 'list.ini');
end;


procedure tfilelistfo.ondrawcell(const Sender: tcol; const Canvas: tcanvas; var cellinfo: cellinfoty);
begin
  //pieceslist.paint(canvas,2,nullpoint,cl_default,cl_default,cl_default,0);
end;

procedure tfilelistfo.afterdragend(const asender: TObject; const apos: pointty; var adragobject: tdragobject; const accepted: Boolean; var processed: Boolean);
begin
  if parentwidget = nil then
  begin
    //rect1 := application.screenrect(window);

    //  bounds_cy := ((list_files.rowcount + 1) * (list_files.datarowheight + 1)) + 37;
    bounds_cxmax := fowidth;
    //bounds_cymax := rect1.cy - 60;
    bounds_cymax := 0;
    bounds_cy    := fowidth;
  end;
end;

procedure tfilelistfo.opendir(const Sender: TObject);
var
  x: integer;
  ara, arb: msestringarty;
begin
  tfiledialog1.controller.captiondir := 'Open Audio Directory';

  if mainfo.typecolor.Value = 2 then
    tfiledialog1.controller.backcolor := $A6A6A6
  else
    tfiledialog1.controller.backcolor := cl_default;

  setlength(ara, 6);
  setlength(arb, 6);

  ara[0] := 'All Audio';
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
  
  tfiledialog1.controller.options := [fdo_sysfilename,fdo_savelastdir,fdo_directory];
 
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

end.

