unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msefileutils,msegui,msegraphics, msegraphutils, mseevent, mseclasses,
 msegridsglob,mseforms, msedock,msedragglob,msesimplewidgets, msewidgets,mseact,
  msebitmap,msedataedits,msedatanodes, mseedit,msefiledialog, msegrids,
 mseificomp,mseificompglob,mseifiglob, mselistbrowser,msestatfile, msestream,
 msestrings,msesys,SysUtils,msegraphedits, msescrollbar,msedispwidgets,
 mserichstring;

type
  tfilelistfo = class(tdockform)
   tfacecomp1: tfacecomp;
   tgroupbox1: tgroupbox;
   songdir: tfilenameedit;
   historyfn: thistoryedit;
   tbutton1: tbutton;
   tbutton2: tbutton;
   list_files: tstringgrid;
   filescount: tstringdisp;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure onsent(const Sender: TObject);
    procedure whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty;
      var aresult: modalresultty);
    procedure onchangpath(const Sender: TObject);
    procedure onafterdialog(const Sender: tfiledialogcontroller; var aresult: modalresultty);
    procedure befdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject; var processed: boolean);
    procedure ondoc(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure afterdrag(const asender: TObject; const apos: pointty; var adragobject: tdragobject;
      var accept: boolean; var processed: boolean);
   procedure oncellev(const sender: TObject; var info: celleventinfoty);
  end;

var
  filelistfo: tfilelistfo;
 
implementation

uses
  songplayer, songplayer2, commander,
  main, filelistform_mfm;

procedure tfilelistfo.formcreated(const Sender: TObject);
begin
 
end;


procedure tfilelistfo.onsent(const Sender: TObject);
var
theplaysender : integer;
thefocusedcell : gridcoordty;
begin
if directoryexists(historyfn.Value) then begin
thefocusedcell := list_files.focusedcell;
 
if (filelistfo.list_files.rowcount < 1) or (trim(list_files[0][thefocusedcell.row]) = '')
then begin
 if filelistfo.list_files.rowcount < 1 then
ShowMessage('No song in file list. Please select a audio directory with songs...') 
else
begin
thefocusedcell.row := 0; 
thefocusedcell.col := 0; 
list_files.firstrow;
list_files.selectcell(thefocusedcell,csm_select,false);
end ;
end else
begin

if sender <> nil then
begin
if TButton(Sender).tag = 0 then theplaysender := 0 else theplaysender := 1;
end else
begin
if hasfocused1 = true then theplaysender := 0 else theplaysender := 1;
end;

// if list_files.focusedindex < 0 then list_files.focusedindex := 0;

   if sender = nil then
     begin
       if thefocusedcell.row +1 < list_files.rowcount then
        begin 
        thefocusedcell.row := thefocusedcell.row +1;
        list_files.rowdown;
         end else
         begin
         thefocusedcell.row := 0; 
         list_files.firstrow;
         end;
      end; 
 
      if theplaysender = 0 then
    begin
      songplayerfo.historyfn.Value := tosysfilepath(historyfn.value +
          list_files[0][thefocusedcell.row] + '.' + list_files[1][thefocusedcell.row]);
   
      songplayerfo.historyfn.face.template := mainfo.tfaceorange;
     if commanderfo.visible = true then commanderfo.tbutton2.setfocus;
      songplayerfo.timersent.Enabled := false;
      songplayerfo.timersent.Enabled := True;
    end;

    if theplaysender = 1 then
    begin
      //songplayer2fo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
     songplayer2fo.historyfn.Value := tosysfilepath(historyfn.value +
     list_files[0][thefocusedcell.row] + '.' + list_files[1][thefocusedcell.row]);
       songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
      if commanderfo.visible = true then commanderfo.tbutton3.setfocus;
      songplayer2fo.timersent.Enabled := false;
      songplayer2fo.timersent.Enabled := True;
    end;
     list_files.selectcell(thefocusedcell,csm_select,false);
 end;
 end;
 end;

procedure tfilelistfo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 5;
end;

procedure tfilelistfo.onchangpath(const Sender: TObject);
var
x : integer;
datalist_files : tfiledatalist;
cellpos : gridcoordty;
begin
if directoryexists(historyfn.Value) then begin
datalist_files := tfiledatalist.create();

datalist_files.adddirectory(historyfn.Value,fil_ext1,'"*.mp3" "*.wav" "*.ogg" "*.flac"'); 

datalist_files.options := [flo_sortname,flo_sorttype];

list_files.rowcount := datalist_files.count;

for x := 0 to datalist_files.count -1 do
begin
list_files[0][x] := filenamebase(datalist_files.items[x].name);
list_files[1][x] := fileext(datalist_files.items[x].name);
list_files[2][x] := inttostr(datalist_files.items[x].extinfo1.size div 1000) + ' Kb';
list_files[3][x] := formatdatetime('YYYY',datalist_files.items[x].extinfo1.ctime);
end;

cellpos.row:= 0;
cellpos.col:= 0;

list_files.selectcell(cellpos,csm_select,false);

filescount.value := inttostr(list_files.rowcount) + ' files';

// list_files.focusedindex := 0;
datalist_files.free();
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
begin
  //sizebefdock.cx := 500;
  //sizebefdock.cy := 500;
  //size := sizebefdock;
  bounds_cxmax := fowidth;
  bounds_cymax := 600;
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
    mainfo.tmainmenu1.menu[3].submenu[3].caption := ' Hide File List ' ;
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[3].caption := ' Show File List ' ; 
  end;

  mainfo.updatelayout();
end;

procedure tfilelistfo.oncellev(const sender: TObject; var info: celleventinfoty);
var
cellpos : gridcoordty;
begin

cellpos := info.cell;

cellpos.col := 0;

if (info.eventkind = cek_buttonrelease) or (info.eventkind =  cek_focusedcellchanged) then
begin
 list_files.selectcell(cellpos,csm_select,false);
end;

end;

end.
