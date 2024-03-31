unit aboutform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseedit,
 msestatfile,msestream,msestrings,sysutils,msesimplewidgets,mseact,msedataedits,
 mseificomp,mseificompglob,mseifiglob;
type
 taboutfo = class(tmseform)
   about_text: tmemoedit;
   procedure resizeab(fonth: integer);
 end;
var
 aboutfo: taboutfo;
implementation
uses
 aboutform_mfm;
 
procedure taboutfo.resizeab(fonth: integer);
var
  ratio: double;
begin
  ratio        := fonth / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := round(372 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := round(320 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fonth;

  about_text.font.color  := font.color;
  about_text.font.Height := font.Height;
  about_text.left        := round(8 * ratio);
  about_text.Width       := round(357 * ratio);
  about_text.Height      := round(298 * ratio);
  about_text.top         := round(9 * ratio);
end;

end.
