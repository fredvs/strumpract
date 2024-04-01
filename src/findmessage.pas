unit findmessage;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,msegrids,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,
 msemenus,msegui,msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,
 mseforms,msesimplewidgets,mseact,msedataedits,msedropdownlist,mseedit,
 mseificomp,mseificompglob,mseifiglob,msestatfile,msestream,SysUtils,
 msegraphedits,msescrollbar;

type
  tfindmessagefo = class(tmseform)
    tbutton3: TButton;
    tbutton2: TButton;
    findtext: thistoryedit;
    casesensitive: tbooleanedit;
    tbutton4: TButton;
    tbutton5: TButton;
    procedure onfindnext(const Sender: TObject);
    procedure onclose(const Sender: TObject);
    procedure onreset(const Sender: TObject);
    procedure onfindall(const Sender: TObject);
   procedure onclosefind(const sender: TObject);
   procedure onchangefind(const sender: TObject);
   procedure resizefm(fonth: integer);
  end;

var
  findmessagefo: tfindmessagefo;
  imessages: integer = 0;

implementation

uses
   filelistform,
   findmessage_mfm;
   
procedure tfindmessagefo.resizefm(fonth: integer);
var
  ratio: double;
begin
  ratio        := fonth / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := round(352 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := round(58 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fonth;

  casesensitive.frame.font.color  := font.color;
  casesensitive.frame.font.Height := font.Height;
  casesensitive.left        := round(207 * ratio);
 // casesensitive.Width       := round(104 * ratio);
 // casesensitive.Height      := round(298 * ratio);
  casesensitive.top         := round(34 * ratio);
  
  findtext.font.color  := font.color;
  findtext.font.Height := font.Height;
  findtext.left        := round(6 * ratio);
  findtext.Width       := round(190 * ratio);
  findtext.Height      := round(22 * ratio);
  findtext.top         := round(32 * ratio);

  tbutton2.font.color  := font.color;
  tbutton2.font.Height := font.Height;
  tbutton2.left        := round(6 * ratio);
  tbutton2.Width       := round(94 * ratio);
  tbutton2.Height      := round(24 * ratio);
  tbutton2.top         := round(2 * ratio);
  
  tbutton3.font.color  := font.color;
  tbutton3.font.Height := font.Height;
  tbutton3.left        := round(281 * ratio);
  tbutton3.Width       := round(66 * ratio);
  tbutton3.Height      := round(24 * ratio);
  tbutton3.top         := round(2 * ratio);
  
  tbutton4.font.color  := font.color;
  tbutton4.font.Height := font.Height;
  tbutton4.left        := round(206 * ratio);
  tbutton4.Width       := round(68 * ratio);
  tbutton4.Height      := round(24 * ratio);
  tbutton4.top         := round(2 * ratio);
  
  tbutton5.font.color  := font.color;
  tbutton5.font.Height := font.Height;
  tbutton5.left        := round(106 * ratio);
  tbutton5.Width       := round(94 * ratio);
  tbutton5.Height      := round(24 * ratio);
  tbutton5.top         := round(2 * ratio);
end;   

procedure tfindmessagefo.onfindnext(const Sender: TObject);
var
  found: Boolean = False;
  gridcoo: gridcoordty;
 begin

  gridcoo.col := 0;
  gridcoo.row := 0;

  if findtext.Value <> '' then
  begin
    while (imessages < filelistfo.list_files.rowcount) and (found = False) do
    begin
      if not casesensitive.Value then
      begin
        if system.pos(lowercase(findtext.Value), lowercase(filelistfo.list_files[0][imessages])) > 0 then
        begin
          found       := True;
          gridcoo.row := imessages;
        end;
      end
      else if system.pos(findtext.Value,filelistfo.list_files[0][imessages]) > 0 then
      begin
        found       := True;
        gridcoo.row := imessages;
      end;

      Inc(imessages);
    end;

    if found then
    begin
       filelistfo.list_files.selectcell(gridcoo, csm_select, False);
       filelistfo.list_files.focuscell(gridcoo);
     
     end
    else
      showerror('        ' + findtext.Value + ' not found.' + '        ', 'Warning');
  end;
  //close;
end;

procedure tfindmessagefo.onclose(const Sender: TObject);
begin
  Close;
end;

procedure tfindmessagefo.onreset(const Sender: TObject);
begin
  imessages := 0;
  filelistfo.list_files.defocuscell;
  filelistfo.list_files.datacols.clearselection;
end;

procedure tfindmessagefo.onfindall(const Sender: TObject);
var
  found: Boolean = False;
  incfind : integer = 0;
  gridcoo: gridcoordty;
begin

  onreset(Sender);
  gridcoo.col := 0;
  gridcoo.row := 0;

  if findtext.Value <> '' then
  begin
    while (imessages < filelistfo.list_files.rowcount) do
    begin
      if not casesensitive.Value then
      begin
        if system.pos(lowercase(findtext.Value), lowercase(filelistfo.list_files[0][imessages])) > 0 then
        begin
          found       := True;
          inc(incfind);
          gridcoo.row := imessages;
          filelistfo.list_files.selectcell(gridcoo, csm_select, False);
        end;
      end
      else if system.pos(findtext.Value, filelistfo.list_files[0][imessages]) > 0 then
      begin
        found       := True;
        inc(incfind);
        gridcoo.row := imessages;
        filelistfo.list_files.selectcell(gridcoo, csm_select, False);
      end;

      Inc(imessages);
    end;

    if not found then
      showerror('        ' + findtext.Value + ' not found.' + '        ', 'Warning')
   else if incfind = 1 then filelistfo.list_files.focuscell(gridcoo) ;
      
  end;

end;

procedure tfindmessagefo.onclosefind(const sender: TObject);
begin
 imessages := 0;
 
end;

procedure tfindmessagefo.onchangefind(const sender: TObject);
begin
 imessages := 0;
end;

end.

