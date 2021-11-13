unit status;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  Classes,
  msegridsglob,
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
  mseact,
  msefileutils,
  msedataedits,
  msedropdownlist,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestatfile,
  msestream,
  SysUtils,
  msesimplewidgets,
  msebitmap,
  msedatanodes,
  msefiledialogx,
  msegrids,
  mselistbrowser,
  msesys,
  msedispwidgets,
  mserichstring;

type
  tstatusfo = class(tmseform)
    layoutname: tstringedit;
    ok: TButton;
    cancel: TButton;
    procedure onok(const Sender: TObject);
    procedure oncancel(const Sender: TObject);

  end;

var
  statusfo: tstatusfo;
  typstat: shortint = 0;

implementation

uses
  status_mfm,
  main,
  filelistform,
  equalizer;

procedure tstatusfo.oncancel(const Sender: TObject);
begin
  Close;
end;

procedure tstatusfo.onok(const Sender: TObject);
var
  ordir, dataeq: string;
  x: integer;
  asliders: tasliders;
  ds: char;
begin

  if typstat = 0 then
  begin
    ordir := msestring(ExtractFilePath((ParamStr(0))) + 'layout' + directoryseparator);
    if layoutname.Value <> '' then
    begin
      ordir := ordir + utf8decode(RawByteString(statusfo.layoutname.Value) + '.lay');
      mainfo.tstatfile1.writestat(utf8decode(RawByteString(ordir)));
    end;
  end;

  if typstat = 2 then
  begin
    ordir := msestring(ExtractFilePath(ParamStr(0)) + 'list' + directoryseparator);
    if layoutname.Value <> '' then
    begin
      ordir := msestring(ordir + statusfo.layoutname.Value + '.lis');
      filelistfo.tstatfile1.writestat((ordir));
      filelistfo.Caption := statusfo.layoutname.Value;
    end;
  end;

  if (typstat = 3) then
    with equalizerfo1 do
    begin
      asliders[1]  := tslider1;
      asliders[2]  := tslider2;
      asliders[3]  := tslider3;
      asliders[4]  := tslider4;
      asliders[5]  := tslider5;
      asliders[6]  := tslider6;
      asliders[7]  := tslider7;
      asliders[8]  := tslider8;
      asliders[9]  := tslider9;
      asliders[10] := tslider10;
      asliders[11] := tslider11;
      asliders[12] := tslider12;
      asliders[13] := tslider13;
      asliders[14] := tslider14;
      asliders[15] := tslider15;
      asliders[16] := tslider16;
      asliders[17] := tslider17;
      asliders[18] := tslider18;
      asliders[19] := tslider19;
      asliders[20] := tslider20;
    end;

  if (typstat = 4) then
    with equalizerfo2 do
    begin
      asliders[1]  := tslider1;
      asliders[2]  := tslider2;
      asliders[3]  := tslider3;
      asliders[4]  := tslider4;
      asliders[5]  := tslider5;
      asliders[6]  := tslider6;
      asliders[7]  := tslider7;
      asliders[8]  := tslider8;
      asliders[9]  := tslider9;
      asliders[10] := tslider10;
      asliders[11] := tslider11;
      asliders[12] := tslider12;
      asliders[13] := tslider13;
      asliders[14] := tslider14;
      asliders[15] := tslider15;
      asliders[16] := tslider16;
      asliders[17] := tslider17;
      asliders[18] := tslider18;
      asliders[19] := tslider19;
      asliders[20] := tslider20;
    end;

  if (typstat = 5) then
    with equalizerforec do
    begin
      asliders[1]  := tslider1;
      asliders[2]  := tslider2;
      asliders[3]  := tslider3;
      asliders[4]  := tslider4;
      asliders[5]  := tslider5;
      asliders[6]  := tslider6;
      asliders[7]  := tslider7;
      asliders[8]  := tslider8;
      asliders[9]  := tslider9;
      asliders[10] := tslider10;
      asliders[11] := tslider11;
      asliders[12] := tslider12;
      asliders[13] := tslider13;
      asliders[14] := tslider14;
      asliders[15] := tslider15;
      asliders[16] := tslider16;
      asliders[17] := tslider17;
      asliders[18] := tslider18;
      asliders[19] := tslider19;
      asliders[20] := tslider20;
    end;

  if (typstat = 3) or (typstat = 4) or (typstat = 5) then
  begin

    dataeq := '';

    ds := decimalseparator;

    decimalseparator := '.';

    for x := 1 to 20 do
      dataeq         := dataeq + floattostrf(asliders[x].Value, ffFixed, 8, 4) + '|';
    decimalseparator := ds;

    ordir := msestring(ExtractFilePath(ParamStr(0)) + 'equ' + directoryseparator);
    if statusfo.layoutname.Value <> '' then
    begin
      ordir := msestring(ordir + statusfo.layoutname.Value + '.equ');

      with TStringList.Create do
        try
          Add(dataeq);
          SaveToFile(ordir);
        finally
          Free;
        end;
    end;
  end;

  Close;
end;

end.

