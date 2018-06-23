unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes, mseglob, mseguiglob, mseguiintf, msetimer, mseapplication, msestat,
  msemenus, msefileutils, msegui, msegraphics, msegraphutils, mseevent,
  mseclasses, msegridsglob, mseforms, msedock, msedragglob, msesimplewidgets,
  msewidgets, mseact, msebitmap, msedataedits, msedatanodes, mseedit,
  msefiledialog, msegrids, mseificomp, mseificompglob, mseifiglob, mselistbrowser,
  msestatfile, msestream, msestrings, msesys, SysUtils, msegraphedits,
  msescrollbar, msedispwidgets, mserichstring;

type
  tfilelistfo = class(tdockform)
    Timersent: Ttimer;
    tfacecomp1: tfacecomp;
    tgroupbox1: tgroupbox;
    songdir: tfilenameedit;
    historyfn: thistoryedit;
    tbutton1: TButton;
    tbutton2: TButton;
    list_files: tstringgrid;
    filescount: tstringdisp;
    edfilescount: tintegeredit;
    hintpanel: tgroupbox;
    hintlabel: tlabel;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onsent(const Sender: TObject);
    procedure ontimersent(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure onchangpath(const Sender: TObject);
    procedure onafterdialog(const Sender: tfiledialogcontroller; var aresult: modalresultty);
    procedure befdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var processed: boolean);
    procedure ondoc(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var accept: boolean; var processed: boolean);
    procedure oncellev(const Sender: TObject; var info: celleventinfoty);
    procedure onbefdrop(const Sender: TObject);
    procedure onaftdrop(const Sender: TObject);
    procedure onchangecount(const Sender: TObject);
    procedure ondestr(const Sender: TObject);
    procedure ondock(const Sender: TObject);
  end;

var
  filelistfo: tfilelistfo;

implementation

uses
  songplayer, commander, dockpanel1,
  main, filelistform_mfm;

procedure tfilelistfo.formcreated(const Sender: TObject);
begin
  Timersent := ttimer.Create(nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.options := [to_single];
  Timersent.ontimer := @ontimersent;
end;

procedure tfilelistfo.ontimersent(const Sender: TObject);
begin
 // timersent.Enabled := False;
  hintpanel.Visible := False;
end;

procedure tfilelistfo.onsent(const Sender: TObject);
var
  theplaysender, thecaution: integer;
  thefocusedcell: gridcoordty;
  mustmix: boolean = False;
begin

  if directoryexists(historyfn.Value) then
  begin
    thefocusedcell := list_files.focusedcell;

    if (filelistfo.list_files.rowcount < 1) or (trim(list_files[0][thefocusedcell.row]) = '') then
    begin
      if filelistfo.list_files.rowcount < 1 then
      begin
        timersent.Enabled := False;
        hintlabel.Caption := 'No song in file list. Please select a audio directory with songs...';
        hintpanel.Visible := True;
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
      else
      begin
        if hasfocused1 = True then
          theplaysender := 0
        else
          theplaysender := 1;
      end;

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
              mustmix := True;
            thefocusedcell.row := 0;
            list_files.firstrow;
            ;
          end;
        end;
      end;

      if theplaysender = 0 then
      begin
        if fileexists((list_files[4][thefocusedcell.row])) then
        begin
          songplayerfo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);

          songplayerfo.historyfn.face.template := mainfo.tfaceorange;
          if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized) and
            (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
            commanderfo.tbutton2.SetFocus;
          songplayerfo.timersent.Enabled := False;
          songplayerfo.timersent.Enabled := True;
        end
        else
        begin
          timersent.Enabled := False;
          hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) + ' does not exist or not mounted...';
          hintpanel.Visible := True;
          timersent.Enabled := True;
        end;

      end;

      if theplaysender = 1 then
      begin
        if fileexists((list_files[4][thefocusedcell.row])) then
        begin

          songplayer2fo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);

          songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
          if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized) and
            (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
            commanderfo.tbutton3.SetFocus;
          songplayer2fo.timersent.Enabled := False;
          songplayer2fo.timersent.Enabled := True;
        end
        else
        begin
          timersent.Enabled := False;
          hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) + ' does not exist or not mounted...';
          hintpanel.Visible := True;
          timersent.Enabled := True;
        end;
      end;

      list_files.selectcell(thefocusedcell, csm_select, False);

    end;
  end
  else
  begin
    timersent.Enabled := False;
    hintlabel.Caption := 'Directory ' + historyfn.Value + ' does not exist or not mounted...';
    hintpanel.Visible := True;
    timersent.Enabled := True;
  end;
end;

procedure tfilelistfo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 5;
end;

procedure tfilelistfo.onchangpath(const Sender: TObject);
var
  x: integer;
  datalist_files: tfiledatalist;
  cellpos: gridcoordty;
begin
  if hasinit = 1 then
  begin

    if directoryexists(historyfn.Value) then
    begin
      list_files.tag := 0;

      historyfn.hint := ' Selected: ' + historyfn.Value + ' ';

      datalist_files := tfiledatalist.Create();

      datalist_files.adddirectory(historyfn.Value, fil_ext1, '"*.mp3" "*.wav" "*.ogg" "*.flac"');

      datalist_files.options := [flo_sortname, flo_sorttype];

      list_files.rowcount := datalist_files.Count;

      for x := 0 to datalist_files.Count - 1 do
      begin
        list_files[0][x] := filenamebase(datalist_files.items[x].Name);
        list_files[1][x] := fileext(datalist_files.items[x].Name);
        list_files[2][x] := IntToStr(datalist_files.items[x].extinfo1.size div 1000) + ' Kb';
        // list_files[3][x] := formatdatetime('YYYY',datalist_files.items[x].extinfo1.ctime);
        list_files[3][x] := IntToStr(1);
        list_files[4][x] := historyfn.Value + datalist_files.items[x].Name;
      end;

      cellpos.row := 0;
      cellpos.col := 0;

      list_files.selectcell(cellpos, csm_select, False);

      edfilescount.Value := list_files.rowcount;

      // list_files.focusedindex := 0;
      datalist_files.Free();
      onfloat(nil);
    end;
  end;
end;

procedure tfilelistfo.onafterdialog(const Sender: tfiledialogcontroller; var aresult: modalresultty);
begin
  //list_files.path := dir.value;

end;

procedure tfilelistfo.befdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var processed: boolean);
begin
  // if parentwidget = nil then sizebefdock := size;
end;

procedure tfilelistfo.ondoc(const Sender: TObject);
begin
  //sizebefdock := size;
end;

procedure tfilelistfo.onfloat(const Sender: TObject);
var  rect1: rectty;

begin
  //sizebefdock.cx := 500;
  //sizebefdock.cy := 500;
  //size := sizebefdock;
  if parentwidget = nil then
  begin
  rect1 := application.screenrect(window);
  
  //  bounds_cy := ((list_files.rowcount + 1) * (list_files.datarowheight + 1)) + 37;
    bounds_cxmax := fowidth;
    bounds_cymax := rect1.cy - 60;
  end;
end;

procedure tfilelistfo.afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject;
  var accept: boolean; var processed: boolean);
begin
  if parentwidget <> nil then
  begin
    //size := sizebefdock;
  end;
end;

procedure tfilelistfo.visiblechangeev(const Sender: TObject);
begin
  if Visible then
  begin
    mainfo.tmainmenu1.menu[3].submenu[3].Caption := ' Hide File List ';
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[3].Caption := ' Show File List ';
  end;
if norefresh = false then
begin
  mainfo.updatelayout();
  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayout();
  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayout();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayout();
 end;   
end;

procedure tfilelistfo.oncellev(const Sender: TObject; var info: celleventinfoty);
var
  cellpos: gridcoordty;
  x: integer;
begin

  cellpos := info.cell;

  if (info.eventkind = cek_buttonrelease) or (info.eventkind = cek_focusedcellchanged) then
  begin
    if (cellpos.row = -1) and (cellpos.col = 3) then
    begin
      // writeln(inttostr(cellpos.col) + ' ' + inttostr(cellpos.row));
      if list_files.tag = 0 then
      begin
        list_files.tag := 1;
        for x := 0 to list_files.rowCount - 1 do
        begin
          list_files[3][x] := IntToStr(0);
        end;
      end
      else
      begin
        list_files.tag := 0;
        for x := 0 to list_files.rowCount - 1 do
        begin
          list_files[3][x] := IntToStr(1);
        end;
      end;
    end;
    cellpos.col := 0;
    list_files.selectcell(cellpos, csm_select, False);
  end;

end;

procedure tfilelistfo.onbefdrop(const Sender: TObject);
begin
  historyfn.Width := 402;
end;

procedure tfilelistfo.onaftdrop(const Sender: TObject);
begin
  historyfn.Width := 164;
end;

procedure tfilelistfo.onchangecount(const Sender: TObject);
begin
  filescount.Value := IntToStr(edfilescount.Value) + ' files';
end;

procedure tfilelistfo.ondestr(const Sender: TObject);
begin
  timersent.Free;
end;

procedure tfilelistfo.ondock(const Sender: TObject);
begin
  bounds_cy := 128;
end;

end.
