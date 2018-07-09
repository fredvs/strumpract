unit status;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseact,
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
 status_mfm, main;
 
procedure tstatusfo.oncreated(const sender: TObject);
var
ordir : string;
begin
 
end;

procedure tstatusfo.oncancel(const sender: TObject);
begin
close;
end;

procedure tstatusfo.onok(const sender: TObject);
var
ordir : string;
begin

ordir := ExtractFilePath(ParamStr(0))
 + 'layout' + directoryseparator;
 
if typstat = 0 then
begin
 ordir := ordir + statusfo.layoutname.value + '.lay';
mainfo.tstatfile1.writestat(ordir);
end;

if typstat = 1 then
begin
ordir := ordir + list_files.selectednames[0] ;
mainfo.tstatfile1.readstat(ordir);
end;
close;
end;

end.
