unit errorform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
 msesimplewidgets;
type
 terrorfo = class(tmseform)
   tlabel1: tlabel;
   tlabel2: tlabel;
 end;
var
 errorfo: terrorfo;
implementation
uses
 errorform_mfm;
end.
