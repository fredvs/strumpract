unit config;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
  msegui,uos_flat, msegraphics, msegraphutils, mseevent, mseclasses, msewidgets,
  mseforms,mseact, msedataedits, mseedit, mseificomp, mseificompglob,
  mseifiglob, msestatfile,msestream, msestrings, SysUtils, msesimplewidgets,
 msegraphedits,msescrollbar;

type
  tconfigfo = class(tmseform)
    tgroupbox1: tgroupbox;
    latrec: trealspinedit;
    latplay: trealspinedit;
    latdrums: trealspinedit;
    tbutton1: TButton;
    lsuglat: tlabel;
   speccalc: tbooleanedit;
    procedure changelatplay(const Sender: TObject);
    procedure changelatdrums(const Sender: TObject);
    procedure changelatrec(const Sender: TObject);
  end;

var
  configfo: tconfigfo;

implementation

uses
  config_mfm;

procedure tconfigfo.changelatplay(const Sender: TObject);
begin
  //if latplay.value < 0 then latplay.value := -1;
end;

procedure tconfigfo.changelatdrums(const Sender: TObject);
begin
  //if latdrums.value < 0 then latdrums.value := -1;
end;

procedure tconfigfo.changelatrec(const Sender: TObject);
begin
  /// if latrec.value < 0 then latrec.value := -1;
end;

end.
