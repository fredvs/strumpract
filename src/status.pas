unit status;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseact, msefileutils,
 msedataedits,msedropdownlist,mseedit,mseificomp,mseificompglob,mseifiglob,
 msestatfile,msestream,sysutils,msesimplewidgets,msebitmap,msedatanodes,
 msefiledialog,msegrids,mselistbrowser,msesys;
type
 tstatusfo = class(tmseform)
   layoutname: tstringedit;
   tbutton1: tbutton;
   tbutton2: tbutton;
   list_files: tfilelistview;
   procedure oncreated(const sender: TObject);
   procedure onok(const sender: TObject);
   procedure oncancel(const sender: TObject);
 end;
var
 statusfo: tstatusfo;
 typstat : shortint = 0;
implementation
uses
 status_mfm, main, filelistform;
 
procedure tstatusfo.oncreated(const sender: TObject);
var
ordir : msestring;
begin
 
end;

procedure tstatusfo.oncancel(const sender: TObject);
begin
close;
end;

procedure tstatusfo.onok(const sender: TObject);
var
x : integer;
ordir : string;
 cellpos: gridcoordty;
begin


if typstat = 0 then
begin
ordir := ExtractFilePath(ParamStr(0))
 + 'layout' + directoryseparator;
if statusfo.layoutname.value <> '' then begin
 ordir := ordir + utf8decode(statusfo.layoutname.value + '.lay');
mainfo.tstatfile1.writestat(utf8decode(ordir));
end;
end;

if typstat = 1 then
begin
ordir := ExtractFilePath(ParamStr(0))
 + 'layout' + directoryseparator;
if assigned(list_files.selectednames) then if list_files.selectednames[0] <> '' then begin
ordir := ordir + utf8decode(list_files.selectednames[0]) ;
mainfo.tstatfile1.readstat(utf8decode(ordir));
end;
end;

if typstat = 2 then
begin
ordir := ExtractFilePath(ParamStr(0))
 + 'list' + directoryseparator;
if statusfo.layoutname.value <> '' then begin
//filelistfo.statfile := mainfo.tstatfile1;
//filelistfo.tstatfile1.writestat(ExtractFilePath(ParamStr(0))+ 'list.ini');
 ordir := utf8decode(ordir + statusfo.layoutname.value + '.lis');
filelistfo.tstatfile1.writestat(utf8decode(ordir)); 
filelistfo.caption := statusfo.layoutname.value;

//filelistfo.statfile := mainfo.tstatfile1;
end;
end;

if typstat = 3 then
begin
ordir := ExtractFilePath(ParamStr(0))
 + 'list' + directoryseparator;
 
if assigned(list_files.selectednames) then if list_files.selectednames[0] <> '' then begin
//filelistfo.statfile := filelistfo.tstatfile1;
ordir := utf8decode(ordir + list_files.selectednames[0]) ;
filelistfo.tstatfile1.readstat(utf8decode(ordir));

    cellpos.row := 0;
      cellpos.col := 0;

      filelistfo.list_files.selectcell(cellpos, csm_select, False);

      filelistfo.edfilescount.Value := filelistfo.list_files.rowcount;

filelistfo.caption := removefileext(list_files.selectednames[0]);

 filelistfo.list_files.fixcols[-1].captions.count:= filelistfo.list_files.rowCount;
 
  for x := 0 to filelistfo.list_files.rowCount - 1 do 
        filelistfo.list_files.fixcols[-1].captions[x] := utf8decode(inttostr(x+1));
    
    filelistfo.filescount.Value := utf8decode(IntToStr(filelistfo.edfilescount.Value) + ' files');

//filelistfo.statfile := mainfo.tstatfile1;
end;
end;



close;
end;

end.
