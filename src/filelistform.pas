unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msefileutils,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock,
 msedragglob,msesimplewidgets, msewidgets, mseact, msebitmap, msedataedits,
 msedatanodes, mseedit,msefiledialog, msegrids, mseificomp, mseificompglob,
 mseifiglob, mselistbrowser,msestatfile, msestream, msestrings, msesys,SysUtils,
 msegraphedits, msescrollbar;

type
  tfilelistfo = class(tdockform)
   tfacecomp1: tfacecomp;
   tgroupbox1: tgroupbox;
   songdir: tfilenameedit;
   historyfn: thistoryedit;
   list_files: tfilelistview;
   tbutton1: tbutton;
   tbutton2: tbutton;
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
  end;

var
  filelistfo: tfilelistfo;
 
implementation

uses
  songplayer, songplayer2, commander,
  main, filelistform_mfm;

procedure tfilelistfo.formcreated(const Sender: TObject);
begin
   list_files.mask := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
   //  list_files.focusedindex := 0;
   list_files.directory:= './';
    filelistfo.list_files.readlist(); 
 end;


procedure tfilelistfo.onsent(const Sender: TObject);
var
theplaysender : integer;
begin

if not assigned(list_files.selectednames)
then ShowMessage('Nothing selected. Please select a song in the list...') else
begin

if sender <> nil then
begin
if TButton(Sender).tag = 0 then theplaysender := 0 else theplaysender := 1;
end else
begin
if hasfocused1 = true then theplaysender := 0 else theplaysender := 1;
end;

if list_files.focusedindex < 0 then list_files.focusedindex := 0;

   if sender = nil then
     begin
       if list_files.focusedindex +1 < list_files.filecount then
        begin   
         list_files.focusedindex := list_files.focusedindex +1;
         end else
         begin 
         list_files.focusedindex := 0;
         end;
      end; 
  
      if theplaysender = 0 then
    begin
      songplayerfo.historyfn.Value := tosysfilepath(list_files.directory + list_files.selectednames[0]);
      songplayerfo.historyfn.face.template := mainfo.tfaceorange;
     if commanderfo.visible = true then commanderfo.tbutton2.setfocus;
      songplayerfo.timersent.Enabled := false;
      songplayerfo.timersent.Enabled := True;
    end;

    if theplaysender = 1 then
    begin
      //songplayer2fo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
      songplayer2fo.historyfn.Value := tosysfilepath(list_files.directory + list_files.selectednames[0]);
      songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
      if commanderfo.visible = true then commanderfo.tbutton3.setfocus;
      songplayer2fo.timersent.Enabled := false;
      songplayer2fo.timersent.Enabled := True;
    end;
 end;
 end;

procedure tfilelistfo.whosent(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  thesender := 5;
end;

procedure tfilelistfo.onchangpath(const Sender: TObject);
begin
   list_files.path := historyfn.Value;
 //  list_files.path := './*.mp3'; 
   list_files.mask := '"*.mp3" "*.wav" "*.ogg" "*.flac"';
   list_files.focusedindex := 0;
  // list_files.directory:= './';
   list_files.readlist(); 
 
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
  bounds_cxmax := 1024;
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

end.
