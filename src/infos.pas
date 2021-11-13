unit infos;

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
  mseimage;

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
    imgPreview: timage;
    tlabel2: tlabel;
  end;

var
  infosfo, infosfo2: tinfosfo;

implementation

uses
  infos_mfm;

{
procedure tinfosfo.onactiv(const sender: TObject);
begin

if Caption = 'Infos Recorder' then
begin

      infoartist.visible := false ;
      infoname.visible := false ;
      infoalbum.visible := false ;
      infoyear.visible := false ;
      infocom.visible := false ;
      infotag.visible := false ;
      infobpm.visible := false ;
      imgPreview.Visible := False;
      tlabel2.Visible := False;
end;
end;
}

end.

