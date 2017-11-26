unit infos;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
  msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
 msesimplewidgets;

type
  tinfosfo = class(tmseform)
    infoname: tlabel;
    infoartist: tlabel;
    infoalbum: tlabel;
    infoyear: tlabel;
    infolength: tlabel;
    infotag: tlabel;
    infocom: tlabel;
    infofile: tlabel;
    inforate: tlabel;
    infochan: tlabel;
   infobpm: tlabel;
  end;

var
  infosfo: tinfosfo;

implementation

uses
  infos_mfm;

end.
