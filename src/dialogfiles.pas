unit dialogfiles;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 Classes,msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,
 msegui,msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 mseact,msebitmap,msedataedits,msedatanodes,mseedit,msegrids,mseificomp,
 mseificompglob,mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,
 msesys,SysUtils,msesimplewidgets,msedispwidgets,mserichstring,msefiledialog,
  msedragglob, msedropdownlist, msegridsglob;

type
  tdialogfilesfo = class(tmseform)
    tbutton1: TButton;
    selected_file: tedit;
    tstringdisp1: tstringdisp;
   list_files: tfilelistview;
    procedure loaddef(const Sender: tcustomlistview);
    procedure butok(const Sender: TObject);
    procedure oncloseev(const Sender: TObject);
  end;

var
  dialogfilesfo: tdialogfilesfo;
  dialogfilesformcreated: Boolean = True;
  layoutbusy: Boolean = False;

procedure dodialogfiles;

implementation

uses
  dialogfiles_mfm,
  equalizer;

procedure dodialogfiles;
begin
  try
    application.createform(tdialogfilesfo, dialogfilesfo);
    dialogfilesfo.Show;
    dialogfilesfo.bringtofront;
    dialogfilesformcreated := True;
  finally
  end;
end;

procedure tdialogfilesfo.loaddef(const Sender: tcustomlistview);
var
  str, str2: msestring;
  asliders: tasliders;
  x: integer = 1;
  ds: char;
begin
  layoutbusy := True;
  if Assigned(list_files.selectednames) then
  begin
    selected_file.Text := list_files.selectednames[0];

    if fileexists(list_files.directory + directoryseparator + selected_file.Text) then
    begin   
      if (tag = 0) then
      begin
        with equalizerfo1 do
        begin
          EQEN.Value   := True;
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
        end;
        
     if (tag = 1) then
      begin
        with equalizerfo2 do
        begin
          EQEN.Value   := True;
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
        end;
        
      if (tag = 2) then
      begin
        with equalizerforec do
        begin
          EQEN.Value   := True;
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
        end;

        with TStringList.Create do
          try
            Loadfromfile(list_files.directory + directoryseparator + selected_file.Text);
            str := Text;
          finally
            Free;
          end;

        str2 := copy(str, 1, system.pos('|', str) - 1);

        ds := decimalseparator;
        decimalseparator := '.';

        asliders[1].Value := strtofloat(str2);

        while (system.pos('|', str) > 0) and (x < 20) do
        begin
          Inc(x);
          str2 := system.copy(str, system.pos('|', str) + 1, 6);
          str  := stringreplace(str, '|', ' ',
            [rfIgnoreCase]);

          if trim(str2) <> '' then
            asliders[x].Value := strtofloat(str2);

        end;
        decimalseparator := ds;
      end;
      end;
  layoutbusy := False;
end;

procedure tdialogfilesfo.butok(const Sender: TObject);
begin
  layoutbusy := False;
  Close;
end;

procedure tdialogfilesfo.oncloseev(const Sender: TObject);
begin
  //dialogfilesformcreated:= false;
end;

end.

