unit filelistform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msegui,
  msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock, msedragglob,
  msesimplewidgets, msewidgets, mseact, msebitmap, msedataedits, msedatanodes, mseedit,
  msefiledialog, msegrids, mseificomp, mseificompglob, mseifiglob, mselistbrowser,
  msestatfile, msestream, msestrings, msesys, SysUtils, msegraphedits, msescrollbar;

type
  tfilelistfo = class(tdockform)
    tbutton1: TButton;
    tbutton2: TButton;
    songdir: tfilenameedit;
    historyfn: thistoryedit;
    tfacecomp2: tfacecomp;
    list_files: tfilelistview;
    procedure formcreated(const Sender: TObject);
    procedure visiblechangeev(const Sender: TObject);
    procedure selctchanged(const Sender: tcustomlistview);
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
  sizebefdock: sizety;

implementation

uses
  songplayer, songplayer2,
  main, filelistform_mfm;

procedure tfilelistfo.formcreated(const Sender: TObject);
begin
  sizebefdock := size;
end;

procedure tfilelistfo.selctchanged(const Sender: tcustomlistview);
var
  ar1: msestringarty;
begin
  if assigned(list_files.selectednames) then
  begin
    ar1 := nil; //compiler warning
    ar1 := list_files.selectednames;
    if length(ar1) > 0 then
    begin
      if length(ar1) > 1 then
      begin
        //   filename.value:= quotefilename(ar1);
      end
      else
      begin
        //   filename.value:= ar1[0];
      end;
    end
    else
    begin
      //   filename.value:= ''; //dir chanaged
    end;
  end;
end;

procedure tfilelistfo.onsent(const Sender: TObject);
begin
  if assigned(list_files.selectednames) then
  begin
    if TButton(Sender).tag = 0 then
    begin
      // songplayerfo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
      songplayerfo.historyfn.Value := list_files.directory + list_files.selectednames[0];
      songplayerfo.historyfn.face.template := mainfo.tfaceorange;
      songplayerfo.timersent.Enabled := True;
    end;

    if TButton(Sender).tag = 1 then
    begin
      //songplayer2fo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
      songplayer2fo.historyfn.Value := list_files.directory + list_files.selectednames[0];
      songplayer2fo.historyfn.face.template := mainfo.tfaceorange;
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
  list_files.mask := '*.mp3';
  list_files.path := historyfn.Value;
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
