unit filelistform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,msedragglob,
 msesimplewidgets,msewidgets,mseact,msebitmap,msedataedits,msedatanodes,mseedit,
 msefiledialog,msegrids,mseificomp,mseificompglob,mseifiglob,mselistbrowser,
 msestatfile,msestream,msestrings,msesys,sysutils,msegraphedits,msescrollbar;

type
 tfilelistfo = class(tdockform)
   tbutton1: tbutton;
   tbutton2: tbutton;
   songdir: tfilenameedit;
   historyfn: thistoryedit;
   tfacecomp2: tfacecomp;
   list_files: tfilelistview;
   procedure formcreated(const sender: TObject);
   procedure visiblechangeev(const sender: TObject);
   procedure selctchanged(const sender: tcustomlistview);
   procedure onsent(const sender: TObject);
   procedure whosent(const sender: tfiledialogcontroller;
                   var dialogkind: filedialogkindty;
                   var aresult: modalresultty);
   procedure onchangpath(const sender: TObject);
   procedure onafterdialog(const sender: tfiledialogcontroller;
                   var aresult: modalresultty);
   procedure befdrag(const asender: TObject; const apos: pointty;
                   var adragobject: tdragobject; var processed: Boolean);
   procedure ondoc(const sender: TObject);
   procedure onfloat(const sender: TObject);
   procedure afterdrag(const asender: TObject; const apos: pointty;
                   var adragobject: tdragobject; var accept: Boolean;
                   var processed: Boolean);
 end;
var
 filelistfo: tfilelistfo;
 sizebefdock: sizety;
 
implementation
uses
songplayer, songplayer2,
main, filelistform_mfm;

procedure tfilelistfo.formcreated(const sender: TObject);
begin
sizebefdock := size;
end;

procedure tfilelistfo.visiblechangeev(const sender: TObject);
begin
mainfo.updatelayout();
end;

procedure tfilelistfo.selctchanged(const sender: tcustomlistview);
var
 ar1: msestringarty;
begin
if assigned(list_files.selectednames) then
begin
 ar1:= nil; //compiler warning
  ar1:= list_files.selectednames;
  if length(ar1) > 0 then begin
   if length(ar1) > 1 then begin
 //   filename.value:= quotefilename(ar1);
   end
   else begin
 //   filename.value:= ar1[0];
   end;
  end
  else begin
//   filename.value:= ''; //dir chanaged
  end;
end;
end;

procedure tfilelistfo.onsent(const sender: TObject);
begin
if assigned(list_files.selectednames) then begin
if tbutton(sender).tag = 0 then
begin
// songplayerfo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
songplayerfo.historyfn.value := list_files.directory + list_files.selectednames[0];
songplayerfo.historyfn.face.template := mainfo.tfaceorange; 
songplayerfo.timersent.enabled := true;
end;

if tbutton(sender).tag = 1 then
begin
//songplayer2fo.historyfn.dropdown.valuelist.asarray:= filename.dropdown.valuelist.asarray;
songplayer2fo.historyfn.value := list_files.directory + list_files.selectednames[0];
songplayer2fo.historyfn.face.template := mainfo.tfaceorange; 
songplayer2fo.timersent.enabled := true;
end;
end;
end;

procedure tfilelistfo.whosent(const sender: tfiledialogcontroller;
               var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
thesender := 5;
end;

procedure tfilelistfo.onchangpath(const sender: TObject);
begin
list_files.mask:= '*.mp3';
list_files.path := historyfn.value;
end;

procedure tfilelistfo.onafterdialog(const sender: tfiledialogcontroller;
               var aresult: modalresultty);
begin
//list_files.path := dir.value;

end;

procedure tfilelistfo.befdrag(const asender: TObject; const apos: pointty;
               var adragobject: tdragobject; var processed: Boolean);
begin
// if parentwidget = nil then sizebefdock := size;
end;

procedure tfilelistfo.ondoc(const sender: TObject);
begin
//sizebefdock := size;
end;

procedure tfilelistfo.onfloat(const sender: TObject);
begin
//sizebefdock.cx := 500;
//sizebefdock.cy := 500;
//size := sizebefdock;
end;

procedure tfilelistfo.afterdrag(const asender: TObject; const apos: pointty;
               var adragobject: tdragobject; var accept: Boolean;
               var processed: Boolean);
begin
if parentwidget <> NIL THEN
begin
//size := sizebefdock;
end;
end;

end.
