unit conflang;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  msesimplewidgets,
  msegraphedits,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msestatfile,
  mseact,
  msedataedits,
  msedragglob,
  msedropdownlist,
  mseedit,
  msegrids,
  msegridsglob,
  msestream,
  msewidgetgrid,
  SysUtils,
  msedispwidgets,
  mserichstring;

type
  tconflangfo = class(tmseform)
    ok: TButton;
    setasdefault: tbooleanedit;
    gridlang: twidgetgrid;
    gridlangtext: tstringedit;
    gridlangbool: tbooleaneditradio;
    gridlangcode: tstringedit;
    bpotools: TButton;
    lsetasdefault: tlabel;
    procedure oncok(const Sender: TObject);
    procedure oncreat(const Sender: TObject);
    procedure oncellev(const Sender: TObject; var info: celleventinfoty);
    procedure ontools(const Sender: TObject);
    procedure resizecl(fonth: integer);
  end;

var
  conflangloaded: shortint = 0;
  conflangfo: tconflangfo;

implementation

uses
  main,
  msestockobjects,
  potools,
  conflang_mfm,
  captionstrumpract;

procedure tconflangfo.resizecl(fonth: integer);
var
  ratio: double;
begin
  ratio        := fonth / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := round(331 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := round(222 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fonth;

  // gridlangbool.frame.font.color := font.color;
  //gridlangbool.frame.font.Height := font.Height;
  gridlangbool.left := round(225 * ratio);
  gridlangbool.top  := 0;

  gridlang.font.color  := font.color;
  gridlang.font.Height := font.Height;
  gridlang.left        := round(21 * ratio);
  gridlang.Width       := round(290 * ratio);
  gridlang.Height      := round(163 * ratio);
  gridlang.top         := round(48 * ratio);

  gridlang.datacols[0].Width := round(224 * ratio);
  gridlang.datacols[1].Width := round(44 * ratio);

  // setasdefault.frame.font.color := font.color;
  // setasdefault.frame.font.Height := font.Height;
  setasdefault.left := round(36 * ratio);
  setasdefault.top  := round(11 * ratio);

  ok.font.color  := font.color;
  ok.font.Height := font.Height;
  ok.left        := round(246 * ratio);
  ok.Width       := round(77 * ratio);
  ok.Height      := round(26 * ratio);
  ok.top         := round(7 * ratio);

  lsetasdefault.font.color  := font.color;
  lsetasdefault.font.Height := font.Height;
  lsetasdefault.left        := round(58 * ratio);
  lsetasdefault.Width       := round(192 * ratio);
  lsetasdefault.Height      := round(42 * ratio);
  lsetasdefault.top         := 0;

  bpotools.left   := round(219 * ratio);
  bpotools.Width  := round(22 * ratio);
  bpotools.Height := round(26 * ratio);
  bpotools.top    := round(7 * ratio);
end;

procedure tconflangfo.oncok(const Sender: TObject);
begin
  Close;
end;

procedure tconflangfo.oncreat(const Sender: TObject);
begin
  Visible := False;
end;

procedure tconflangfo.oncellev(const Sender: TObject; var info: celleventinfoty);
var
  x: integer;
begin
  // if conflangloaded > 0 then
  if info.eventkind = cek_buttonrelease then
  begin
    MSEFallbackLang := '';
    for x           := 0 to gridlang.rowcount - 1 do
      if x = info.cell.row then
      begin
        gridlangbool[x] := True;
        MSEFallbackLang := gridlangcode[x];
        mainfo.setlangstrumpract(MSEFallbackLang);

      end
      else
        gridlangbool[x] := False;
  end;
end;

procedure tconflangfo.ontools(const Sender: TObject);
begin
  application.createform(theaderfo, headerfo);
  headerfo.icon := icon;
  headerfo.Show(True);
end;

end.

