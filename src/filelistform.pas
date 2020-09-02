
unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 math,msetypes, mseglob, mseguiglob, mseguiintf, msetimer, mseapplication,
  msestat,msemenus, msefileutils, msegui, msegraphics, msegraphutils, mseevent,
 msedatalist, mseclasses, msegridsglob, mseforms, msedock, msedragglob,
 msesimplewidgets, msewidgets, mseact, msebitmap, msedataedits, msedatanodes,
 mseedit, msefiledialogx, msegrids, mseificomp, mseificompglob, mseifiglob,
 mselistbrowser, msestatfile, msestream, msestrings, msesys, SysUtils,
 msegraphedits, msescrollbar, msedispwidgets, mserichstring, msedropdownlist;

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
    tbutton3: tbutton;
    tbutton4: tbutton;
    tbutton5: tbutton;
    tstatfile1: tstatfile;
    tfiledialog1: tfiledialog;
   tbutton6: tbutton;
    procedure formcreated(Const Sender: TObject);
    procedure visiblechangeev(Const Sender: TObject);
    procedure onsent(Const Sender: TObject);
    procedure ontimersent(Const Sender: TObject);
    procedure ontimercount(Const Sender: TObject);
    procedure whosent(Const Sender: tfiledialogcontroller; Var dialogkind: filedialogkindty; Var
                      aresult: modalresultty);
    procedure onchangpath(Const Sender: TObject);
    procedure onafterdialog(Const Sender: tfiledialogcontroller; Var aresult: modalresultty);
    procedure befdrag(Const asender: TObject; Const apos: pointty; Var adragobject: tdragobject; Var
                      processed: boolean);
    procedure ondoc(Const Sender: TObject);
    procedure onfloat(Const Sender: TObject);
    procedure afterdrag(Const asender: TObject; Const apos: pointty; Var adragobject: tdragobject;
                        Var accept: boolean; Var processed: boolean);
    procedure oncellev(Const Sender: TObject; Var info: celleventinfoty);
    procedure onbefdrop(Const Sender: TObject);
    procedure onaftdrop(Const Sender: TObject);
    procedure onchangecount(Const Sender: TObject);
    procedure ondestr(Const Sender: TObject);
    procedure ondock(Const Sender: TObject);
    procedure loadlist(Const sender: TObject);
    procedure savelist(Const sender: TObject);
    procedure addfile(Const sender: TObject);
    procedure oncreate(Const sender: TObject);
    procedure ondrawcell(Const sender: tcol; Const canvas: tcanvas;
                         Var cellinfo: cellinfoty);
   procedure afterdragend(const asender: TObject; const apos: pointty;
                   var adragobject: tdragobject; const accepted: Boolean;
                   var processed: Boolean);
   procedure opendir(const sender: TObject);
  end;

var 
  filelistfo: tfilelistfo;
  thefocusedcell: gridcoordty;
  sortord : integer = 0;

implementation

uses 
songplayer, commander, dockpanel1, status, 
main, filelistform_mfm;

procedure tfilelistfo.formcreated(Const Sender: TObject);
var 
  x : integer;

begin
  Timersent := ttimer.Create(Nil);
  Timersent.interval := 2500000;
  Timersent.Enabled := False;
  Timersent.options := [to_single];
  Timersent.ontimer := @ontimersent;

  Timercount := ttimer.Create(Nil);
  Timercount.interval := 2500000;
  Timercount.Enabled := False;
  Timercount.options := [to_single];
  Timercount.ontimer := @ontimercount;


  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if fileexists(ordir+  'ini'  + directoryseparator +  'list.ini') then
    filelistfo.tstatfile1.readstat(utf8decode(ordir+  'ini'  + directoryseparator +  'list.ini'))
  else
    if trim(historyfn.Value) = '' then
      begin
        hasinit := 1;
        historyfn.Value := utf8decode(ordir + 'sound' + directoryseparator + 'song' +
                           directoryseparator ) ;
        onchangpath(Sender);
      end;

  list_files.fixcols[-1].captions.count := list_files.rowCount;

  for x := 0 to list_files.rowCount - 1 do
    list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));
end;

procedure tfilelistfo.ontimersent(Const Sender: TObject);
begin
  hintpanel.Visible := False;
end;

procedure tfilelistfo.ontimercount(Const Sender: TObject);
var 
  x: integer;
begin
  list_files.fixcols[-1].captions.count := list_files.rowCount;

  for x := 0 to list_files.rowCount - 1 do
    list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));

end;

procedure tfilelistfo.onsent(Const Sender: TObject);
var 
  theplaysender, thecaution: integer;
  mustmix: boolean = False;
begin

  if directoryexists(historyfn.Value) then
    begin
      thefocusedcell := list_files.focusedcell;

      if (filelistfo.list_files.rowcount < 1) or (trim(list_files[0][thefocusedcell.row]) = '') then
        begin
          if filelistfo.list_files.rowcount < 1 then
            begin

              hintlabel.Caption := 
                               'No song in file list. Please select a audio directory with songs...'
              ;
              hintpanel.Visible := True;
              if timersent.Enabled then
                timersent.restart // to reset
              else timersent.Enabled := True;
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
                  if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized)
                     and
                     (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
                    commanderfo.tbutton2.SetFocus;

                  if songplayerfo.timersent.Enabled then
                    songplayerfo.timersent.restart // to reset
                  else songplayerfo.timersent.Enabled := True;

                end
              else
                begin

                  hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) +
                                       ' does not exist or not mounted...';
                  hintpanel.Visible := True;

                  if timersent.Enabled then
                    timersent.restart // to reset
                  else timersent.Enabled := True;
                end;

            end;

          if theplaysender = 1 then
            begin
              if fileexists((list_files[4][thefocusedcell.row])) then
                begin

                  songplayer2fo.historyfn.Value := tosysfilepath(list_files[4][thefocusedcell.row]);

                  songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
                  if (commanderfo.Visible = True) and (commanderfo.window.windowpos <> wp_minimized)
                     and
                     (mainfo.basedock.dragdock.currentsplitdir <> sd_tabed) then
                    commanderfo.tbutton3.SetFocus;
                  if songplayer2fo.timersent.Enabled then
                    songplayer2fo.timersent.restart // to reset
                  else songplayer2fo.timersent.Enabled := True;
                end
              else
                begin
                  hintlabel.Caption := tosysfilepath(list_files[4][thefocusedcell.row]) +
                                       ' does not exist or not mounted...';
                  hintpanel.Visible := True;
                  if timersent.Enabled then
                    timersent.restart // to reset
                  else timersent.Enabled := True;
                end;
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
      else timersent.Enabled := True;
    end;
end;

procedure tfilelistfo.whosent(Const Sender: tfiledialogcontroller; Var dialogkind: filedialogkindty;
                              Var aresult: modalresultty);
begin
  thesender := 5;
end;

procedure tfilelistfo.onchangpath(Const Sender: TObject);
var 
  x, y, y2, z: integer;
  datalist_files: tfiledatalist;
  cellpos: gridcoordty;
  thestrnum, thestrx, thestrext, thestrfract : string;
begin
  if hasinit = 1 then
    begin

      if directoryexists(tosysfilepath(historyfn.Value)) then
        begin
          list_files.tag := 0;

          historyfn.hint := ' Selected: ' + historyfn.Value + ' ';

          datalist_files := tfiledatalist.Create();

          datalist_files.adddirectory(historyfn.Value, fil_ext1,
                                 '"*.mp3" "*.MP3" "*.wav" "*.WAV" "*.ogg" "*.OGG" "*.flac" "*.FLAC"'
          );

          datalist_files.options := [flo_sortname, flo_sorttype];

          caption := tosysfilepath(historyfn.Value);

          list_files.rowcount := datalist_files.Count;

          for x := 0 to datalist_files.Count - 1 do
            begin
              list_files[0][x] := utf8decode(filenamebase(datalist_files.items[x].Name));
              list_files[1][x] := utf8decode(fileext(datalist_files.items[x].Name));
         
           //
                 if not datalist_files.isdir(x) then
      begin

        if datalist_files.items[x].extinfo1.size div 1000000000 > 0 then
        begin
          y2        := Trunc(Frac(datalist_files.items[x].extinfo1.size / 1000000000) * Power(10, 1));
          y         := datalist_files.items[x].extinfo1.size div 1000000000;
          thestrx   := '~';
          thestrext := ' GB';
        end
        else if datalist_files.items[x].extinfo1.size div 1000000 > 0 then
        begin
          y2        := Trunc(Frac(datalist_files.items[x].extinfo1.size / 1000000) * Power(10, 1));
          y         := datalist_files.items[x].extinfo1.size div 1000000;
          thestrx   := '_';
          thestrext := ' MB';
        end
        else if datalist_files.items[x].extinfo1.size div 1000 > 0 then
        begin
          y2        := Trunc(Frac(datalist_files.items[x].extinfo1.size / 1000) * Power(10, 1));
          y         := datalist_files.items[x].extinfo1.size div 1000;
          thestrx   := '^';
          thestrext := ' KB';
        end
        else
        begin
          y2        := 0;
          y         := datalist_files.items[x].extinfo1.size;
          thestrx   := ' ';
          thestrext := ' B';
        end;


        thestrnum := IntToStr(y);

        z := Length(thestrnum);

        if z < 15 then
          for y := 0 to 14 - z do
            thestrnum := ' ' + thestrnum;

        if y2 > 0 then
          thestrfract := '.' + IntToStr(y2)
        else
          thestrfract := '';


        list_files[2][x] := thestrx + thestrnum + thestrfract + thestrext;
      end;
           
      list_files[3][x] := utf8decode(IntToStr(1));
      list_files[4][x] := utf8decode(historyfn.Value + datalist_files.items[x].Name);
           
       end;

          cellpos.row := 0;
          cellpos.col := 0;

          list_files.selectcell(cellpos, csm_select, False);

          edfilescount.Value := list_files.rowcount;

          list_files.fixcols[-1].captions.count := list_files.rowCount;

          for x := 0 to list_files.rowCount - 1 do
            list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));
          edfilescount.Value := list_files.rowcount;
          filescount.Value := utf8decode(IntToStr(edfilescount.Value) + ' files');

          // list_files.focusedindex := 0;
          datalist_files.Free();
          onfloat(Nil);
        end;
    end;
end;

procedure tfilelistfo.onafterdialog(Const Sender: tfiledialogcontroller; Var aresult: modalresultty)
;
begin
  //list_files.path := dir.value;
end;

procedure tfilelistfo.befdrag(Const asender: TObject; Const apos: pointty; Var adragobject:
                              tdragobject; Var processed: boolean);
begin
  // if parentwidget = nil then sizebefdock := size;
end;

procedure tfilelistfo.ondoc(Const Sender: TObject);
begin
  //sizebefdock := size;
end;

procedure tfilelistfo.onfloat(Const Sender: TObject);
var 
  rect1: rectty;

begin
  //sizebefdock.cx := 500;
  //sizebefdock.cy := 500;
  //size := sizebefdock;
  if parentwidget = nil then
    begin
      rect1 := application.screenrect(window);

      //  bounds_cy := ((list_files.rowcount + 1) * (list_files.datarowheight + 1)) + 37;
      bounds_cxmax := fowidth;
    //  bounds_cymax := rect1.cy - 60;
      bounds_cymax := 0;
    end;
end;

procedure tfilelistfo.afterdrag(Const asender: TObject; Const apos: pointty; Var adragobject:
                                tdragobject;
                                Var accept: boolean; Var processed: boolean);
begin
  if parentwidget <> nil then
    begin
      //size := sizebefdock;
    end;
end;

procedure tfilelistfo.visiblechangeev(Const Sender: TObject);
begin
  if (assigned(mainfo)) and (assigned(dockpanel1fo)) and (assigned(dockpanel2fo)) and (assigned(
     dockpanel3fo))
     and (assigned(dockpanel4fo)) and (assigned(dockpanel5fo)) then
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

          if dockpanel4fo.Visible then
            dockpanel4fo.updatelayout();

          if dockpanel5fo.Visible then
            dockpanel5fo.updatelayout();
        end;
    end;
end;

procedure tfilelistfo.oncellev(Const Sender: TObject; Var info: celleventinfoty);
var 
  cellpos: gridcoordty;
  x: integer;

begin
  cellpos := info.cell;


  if (info.eventkind = cek_buttonrelease) or (info.eventkind = cek_focusedcellchanged) then
    begin
      // writeln('button release 1');

      if (cellpos.row = -1) and (cellpos.col = 3) then
        begin
          // writeln(inttostr(cellpos.col) + ' ' + inttostr(cellpos.row));
          if list_files.tag = 0 then
            begin
              list_files.tag := 1;
              for x := 0 to list_files.rowCount - 1 do
                begin
                  list_files[3][x] := utf8decode(IntToStr(0));
                end;
            end
          else
            begin
              list_files.tag := 0;
              for x := 0 to list_files.rowCount - 1 do
                begin
                  list_files[3][x] := utf8decode(IntToStr(1));
                end;
            end;
        end
      else
        begin
          if (cellpos.row > -1) then
            begin
              cellpos.col := 0;
              list_files.selectcell(cellpos, csm_select, False);
            end;
        end;
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
//      filescount.Value := utf8decode(IntToStr(edfilescount.Value) + ' files');

      //   if filelistfo.tbutton1.face.template = mainfo.tfaceorange then
      //   onsent(tbutton1) else
      //   if filelistfo.tbutton2.face.template = mainfo.tfaceorange then  onsent(tbutton2)  ;

      // {      
      if (cellpos.row > -1) and (ss_double in info.mouseeventinfopo^.shiftstate) then
        begin

          if filelistfo.tbutton1.face.template = mainfo.tfaceorange then
            onsent(tbutton1)
          else
            if filelistfo.tbutton2.face.template = mainfo.tfaceorange then  onsent(tbutton2)  ;


          //  writeln('button 2x click');   
          if commanderfo.tbutton2.face.template = mainfo.tfaceorange then

            begin
              //   writeln('onstartstop(tbutton2)');  
              commanderfo.onstartstop(commanderfo.tbutton2)
            end
          else

            if commanderfo.tbutton3.face.template = mainfo.tfaceorange then

              begin
                //  writeln('onstartstop(tbutton3)');  
                commanderfo.onstartstop(commanderfo.tbutton3)  ;
              end;

        end;
      // }

      if timercount.Enabled then
        timercount.restart // to reset
      else timercount.Enabled := True;

    end;
end;

procedure tfilelistfo.onbefdrop(Const Sender: TObject);

begin
  historyfn.Width := 402;
end;

procedure tfilelistfo.onaftdrop(Const Sender: TObject);
begin
  historyfn.Width := 128 ;
end;

procedure tfilelistfo.onchangecount(Const Sender: TObject);
begin
  filescount.Value := utf8decode(IntToStr(edfilescount.Value) + ' files');
end;

procedure tfilelistfo.ondestr(Const Sender: TObject);
begin
  timersent.Free;
  timercount.free;
end;

procedure tfilelistfo.ondock(Const Sender: TObject);
begin
  bounds_cy := 128;
end;

procedure tfilelistfo.loadlist(const Sender: TObject);
var
x : integer;ordir : string;
cellpos: gridcoordty;

begin
  ordir := ExtractFilePath(ParamStr(0)) + 'list' + directoryseparator;
  tfiledialog1.controller.captionopen := 'Open List File';
    
  tfiledialog1.controller.filter := '"*.lis"';
  tfiledialog1.controller.filename := ordir;
  
  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialog1.controller.filename) then
  begin  
    
 filelistfo.tstatfile1.readstat(utf8decode(tfiledialog1.controller.filename));
  cellpos.row := 0;
      cellpos.col := 0;

      filelistfo.list_files.selectcell(cellpos, csm_select, False);

      filelistfo.edfilescount.Value := filelistfo.list_files.rowcount;

filelistfo.caption := removefileext(tfiledialog1.controller.filename);

 filelistfo.list_files.fixcols[-1].captions.count:= filelistfo.list_files.rowCount;
 
  for x := 0 to filelistfo.list_files.rowCount - 1 do 
        filelistfo.list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));
    
    filelistfo.filescount.Value := utf8decode(IntToStr(filelistfo.edfilescount.Value) + ' files');
end;
end;

procedure tfilelistfo.savelist(Const sender: TObject);
begin
  typstat := 2;
  statusfo.caption := 'Save Cue List as';
  statusfo.color := $A7C9B9;
  statusfo.layoutname.value := 'mycuelist';
  //statusfo.layoutname.frame.caption := 'Choose a cue-list name';
  statusfo.layoutname.visible := true;
  statusfo.activate;
end;

procedure tfilelistfo.addfile(Const sender: TObject);
var 
  x, siz, y, z: integer;
  str1: filenamety;
  info: fileinfoty;
  res : modalresultty;
  thestrnum : string;
begin

  tfiledialog1.controller.captionopen := 'Open Audio File';
  
  tfiledialog1.controller.filter := 
                                 '"*.mp3" "*.MP3" "*.wav" "*.WAV" "*.ogg" "*.OGG" "*.flac" "*.FLAC"'  ;

  if tfiledialog1.controller.Execute(fdk_open) = mr_ok then
    begin

      if fileexists(str1) then
        begin
          getfileinfo(str1, info);

          siz := info.extinfo1.size;

          list_files.rowcount := list_files.rowcount + 1;
          x := list_files.rowcount-1;


          //    if x > 0 then  list_files[-1][x] := inttostr(x+1);
          list_files[0][x] := utf8decode(filenamebase(str1));
          list_files[1][x] := utf8decode(fileext(str1));
          
            if siz > 0 then
                begin
                  if siz Div 1024 > 0 then y := 
                  siz Div 1024
                  else siz := 1;
                end
              else siz := 0;
              
              thestrnum := IntToStr(siz);
              
               z := Length(thestrnum) ; 
               
               if z < 7 then 
                for y := 0 to 6 - z do
                  thestrnum := ' ' + thestrnum;
                           
              list_files[2][x] := utf8decode(thestrnum + ' Kb');
          
          
       //   list_files[2][x] := utf8decode(IntToStr(siz Div 1000) + ' Kb');
          // list_files[3][x] := formatdatetime('YYYY',datalist_files.items[x].extinfo1.ctime);
          list_files[3][x] := utf8decode(IntToStr(1));
          list_files[4][x] := str1;
          edfilescount.Value := list_files.rowcount;
          filescount.Value := utf8decode(IntToStr(edfilescount.Value) + ' files');

          list_files.fixcols[-1].captions.count := list_files.rowCount;

          for x := 0 to list_files.rowCount - 1 do
            list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));
          edfilescount.Value := list_files.rowcount;
          filescount.Value := utf8decode(IntToStr(edfilescount.Value) + ' files');

        end;
    end;
end;

procedure tfilelistfo.oncreate(Const sender: TObject);
begin
  tstatfile1.filename := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +  'ini'
                         +
                         directoryseparator +  'list.ini');
end;



procedure tfilelistfo.ondrawcell(Const sender: tcol; Const canvas: tcanvas;
                                 Var cellinfo: cellinfoty);

begin
  //pieceslist.paint(canvas,2,nullpoint,cl_default,cl_default,cl_default,0);
end;

procedure tfilelistfo.afterdragend(const asender: TObject; const apos: pointty;
               var adragobject: tdragobject; const accepted: Boolean;
               var processed: Boolean);
begin
 if parentwidget = nil then
    begin
      //rect1 := application.screenrect(window);

      //  bounds_cy := ((list_files.rowcount + 1) * (list_files.datarowheight + 1)) + 37;
      bounds_cxmax := fowidth;
      //bounds_cymax := rect1.cy - 60;
      bounds_cymax := 0;
      bounds_cy := fowidth;
    end;
end;

procedure tfilelistfo.opendir(const sender: TObject);
begin
  tfiledialog1.controller.captiondir  := 'Open Audio Directory';
  tfiledialog1.controller.filter  := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
  
 if tfiledialog1.controller.Execute(fdk_dir) = mr_ok then
    begin
    historyfn.Value :=tfiledialog1.controller.filename;
    
    onchangpath(Sender);
       
     end;

end;

end.
