unit status;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msegridsglob,msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,
 msemenus,msegui,msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,
 mseforms,mseact,msefileutils,msedataedits,msedropdownlist,mseedit,mseificomp,
 mseificompglob,mseifiglob,msestatfile,msestream,sysutils,msesimplewidgets,
 msebitmap,msedatanodes,msefiledialogx,msegrids,mselistbrowser,msesys,
 msedispwidgets, mserichstring;
type
 tstatusfo = class(tmseform)
   layoutname: tstringedit;
   ok: tbutton;
   cancel: tbutton;
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
//mainfo.tstatfile1.writestat(utf8decode(ordir));
end;
end;

if typstat = 2 then
begin
ordir := ExtractFilePath(ParamStr(0))
 + 'list' + directoryseparator;
if statusfo.layoutname.value <> '' then begin
 ordir := utf8decode(ordir + statusfo.layoutname.value + '.lis');
//filelistfo.tstatfile1.writestat(utf8decode(ordir)); 
filelistfo.caption := statusfo.layoutname.value;
end;
end;

close;
end;

end.
