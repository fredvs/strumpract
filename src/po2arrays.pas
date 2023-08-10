unit po2arrays;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  msesys,
  mseguiintf,
  SysUtils,
  msefileutils,
  msegraphics,
  mseglob,
  msestream,
  msegui,
  msegraphutils,
  mseclasses,
  mclasses,
  msestrings,
  msedatamodules,
  mseguiglob;

procedure createnewlang(alang: msestring);
procedure dosearch(thearray: array of msestring; theindex: integer);
procedure listpofiles();

implementation

uses
  msestockobjects,
  mseconsts,
  captionstrumpract;

var
  constvaluearray: array of msestring;
  astro, astrt, acomp: utf8String;
  hasfound: Boolean = False;
  empty: Boolean = False;

procedure listpofiles();
var
  ListOfFiles: array of string;
  SearchResult: TSearchRec;
  file1: ttextdatastream;
  Attribute: word;
  i: integer = 0;
  x: integer;
  str1, str2, pat: string;
begin
  Attribute := faReadOnly or faArchive;

  SetLength(ListOfFiles, 0);

  str1 := ExtractFilePath(ParamStr(0)) + 'lang' + directoryseparator;

  // writeln(str1);

  // List the files
  FindFirst(str1 + '*.po', Attribute, SearchResult);
  while (i = 0) do
  begin
    SetLength(ListOfFiles, Length(ListOfFiles) + 1);
    // Increase the list
    ListOfFiles[High(ListOfFiles)] := SearchResult.Name;
    // Add it at the of the list
    i := FindNext(SearchResult);
  end;
  FindClose(SearchResult);

  setlength(lang_langnames, 1);
  lang_langnames[0] := 'English [en]';

  pat := ExtractFilePath(ParamStr(0)) + 'lang' + directoryseparator;

  for i := Low(ListOfFiles) to High(ListOfFiles) do
    if system.pos('empty', ListOfFiles[i]) = 0 then
    begin
      setlength(lang_langnames, length(lang_langnames) + 1);
      str1 := ListOfFiles[i];

      file1 := ttextdatastream.Create(pat + str1, fm_read);
      file1.encoding := ce_utf8;
      x := 0;
      while (not file1.EOF) and (x = 0) do
      begin
        str1 := '';
        file1.readln(str1);
        if system.pos('msgid "English [en]"', str1) > 0 then
        begin
          file1.readln(str1);
          if system.pos('msgstr', str1) > 0 then
          begin
            x    := 1;
            str1 := StringReplace(str1, 'msgstr', '', [rfReplaceAll]);
            str1 := StringReplace(str1, '"', '', [rfReplaceAll]);
            lang_langnames[length(lang_langnames) - 1] := trim(str1);
          end;
          // writeln(lang_langnames[length(lang_langnames) - 1]);
        end;
      end;
      file1.Free;
    end;
end;

///////////////

procedure dosearch(thearray: array of msestring; theindex: integer);
var
  str2: utf8String;
  y: integer;
begin
  y        := 0;
  hasfound := False;

  while (y < length(constvaluearray)) and (hasfound = False) do
  begin
    str2  := (constvaluearray[y]);
    acomp := Copy(str2, 1, system.pos(';', str2) - 1);
    // writeln('---acomp:' + acomp);
    str2  := (Copy(str2, system.pos(';', str2) + 1, length(str2) - system.pos(';', str2) + 1));
    astro := (Copy(str2, 1, system.pos(';', str2) - 1));
    astro := StringReplace(astro, '\"', '"', [rfReplaceAll]);
    //  writeln('---astro:' + astro);
    str2  := (Copy(str2, system.pos(';', str2) + 1, length(str2) - system.pos(';', str2) + 1));
    astrt := Copy(str2, 1, length(str2));
    astrt := StringReplace(astrt, '\"', '"', [rfReplaceAll]);

    if thearray[theindex] = astro then
      hasfound := True;
    // writeln('---astrt:' + astrt);

    Inc(y);
  end;
end;

procedure createnewlang(alang: msestring);
var
  x, x2, x3: integer;
  file1: ttextdatastream;
  str1: msestring;
  str2, str3, str4, strtemp: utf8String;
  isstring: Boolean = False;
  isid: Boolean = False;
  iscontext: Boolean = False;
  ispocontext: Boolean = False;
  imodalresultty: modalresultty;
  iextendedty: extendedty;
  istockcaptionty: stockcaptionty;
  imainfoty: mainfoty;
  icommanderfoty: commanderfoty;
  iinfosfoty: infosfoty;
  ifilelistfoty: filelistfoty;
  iequalizerfoty: equalizerfoty;
  ispectrum1foty: spectrum1foty;
  isongplayerfoty: songplayerfoty;
  idrumsfoty: drumsfoty;
  irandomnotefoty: randomnotefoty;
  default_randomnotefotext, default_drumsfotext, default_spectrum1fotext, default_equalizerfotext, default_songplayerfotext, default_infosfotext, default_filelistfotext, default_commanderfotext,
  default_modalresulttext, default_modalresulttextnoshortcut, default_mainfotext, default_stockcaption, default_extendedtext: array of msestring;
begin

  str1 := ExtractFilePath(ParamStr(0)) + 'lang' + directoryseparator + 'strumpract_' + alang + '.po';

  // writeln(str1);

  if (not fileexists(str1)) or (lowercase(alang) = 'en') or (trim(alang) = '') then
  begin
    setlength(lang_modalresult, length(en_modalresulttext));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      lang_modalresult[Ord(imodalresultty)] := en_modalresulttext[Ord(imodalresultty)];

    setlength(lang_modalresultnoshortcut, length(en_modalresulttextnoshortcut));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      lang_modalresultnoshortcut[Ord(imodalresultty)] :=
        en_modalresulttextnoshortcut[Ord(imodalresultty)];

    setlength(lang_stockcaption, length(en_stockcaption));
    for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
      lang_stockcaption[Ord(istockcaptionty)] :=
        en_stockcaption[Ord(istockcaptionty)];

    setlength(lang_extended, length(en_extendedtext));
    for iextendedty := Low(extendedty) to High(extendedty) do
      lang_extended[Ord(iextendedty)] :=
        en_extendedtext[Ord(iextendedty)];

    setlength(lang_mainfo, length(en_mainfotext));
    for imainfoty := Low(mainfoty) to High(mainfoty) do
      lang_mainfo[Ord(imainfoty)] :=
        en_mainfotext[(imainfoty)];

    setlength(lang_commanderfo, length(en_commanderfotext));
    for icommanderfoty := Low(commanderfoty) to High(commanderfoty) do
      lang_commanderfo[Ord(icommanderfoty)] :=
        en_commanderfotext[(icommanderfoty)];

    setlength(lang_infosfo, length(en_infosfotext));
    for iinfosfoty := Low(infosfoty) to High(infosfoty) do
      lang_infosfo[Ord(iinfosfoty)] :=
        en_infosfotext[(iinfosfoty)];

    setlength(lang_filelistfo, length(en_filelistfotext));
    for ifilelistfoty := Low(filelistfoty) to High(filelistfoty) do
      lang_filelistfo[Ord(ifilelistfoty)] :=
        en_filelistfotext[(ifilelistfoty)];

    setlength(lang_songplayerfo, length(en_songplayerfotext));
    for isongplayerfoty := Low(songplayerfoty) to High(songplayerfoty) do
      lang_songplayerfo[Ord(isongplayerfoty)] :=
        en_songplayerfotext[(isongplayerfoty)];

    setlength(lang_equalizerfo, length(en_equalizerfotext));
    for iequalizerfoty := Low(equalizerfoty) to High(equalizerfoty) do
      lang_equalizerfo[Ord(iequalizerfoty)] :=
        en_equalizerfotext[(iequalizerfoty)];

    setlength(lang_spectrum1fo, length(en_spectrum1fotext));
    for ispectrum1foty := Low(spectrum1foty) to High(spectrum1foty) do
      lang_spectrum1fo[Ord(ispectrum1foty)] :=
        en_spectrum1fotext[(ispectrum1foty)];

    setlength(lang_drumsfo, length(en_drumsfotext));
    for idrumsfoty := Low(drumsfoty) to High(drumsfoty) do
      lang_drumsfo[Ord(idrumsfoty)] :=
        en_drumsfotext[(idrumsfoty)];

    setlength(lang_randomnotefo, length(en_randomnotefotext));
    for irandomnotefoty := Low(randomnotefoty) to High(randomnotefoty) do
      lang_randomnotefo[Ord(irandomnotefoty)] :=
        en_randomnotefotext[(irandomnotefoty)];

  end
  else if fileexists(str1) then
  begin

    file1 := ttextdatastream.Create(str1, fm_read);

    file1.encoding := ce_utf8;

    setlength(constvaluearray, 0);

    file1.readln(str1);

    str3 := '';
    str2 := '';
    str4 := '';

    while not file1.EOF do
    begin
      str1    := '';
      file1.readln(str1);
      strtemp := '';

      if (trim(str1) <> '') and (Copy(str1, 1, 1) <> '#') then
        if (Copy(str1, 1, 7) = 'msgctxt') then
        begin
          ispocontext := True;

          setlength(constvaluearray, length(constvaluearray) + 1);
          str2      := str4 + utf8String(';') + str2 + utf8String(';') + str3;
          str2      := StringReplace(str2, '\n', '', [rfReplaceAll]);
          str2      := StringReplace(str2, '\', '', [rfReplaceAll]);
          constvaluearray[length(constvaluearray) - 1] := str2;
          str3      := '';
          str4      := '';
          str4      := (Copy(str1, 10, length(str1) - 10));
          iscontext := True;
          isid      := False;
          isstring  := False;
        end
        else if (copy(str1, 1, 5) = 'msgid') then
        begin
          if ispocontext = False then
          begin
            setlength(constvaluearray, length(constvaluearray) + 1);
            str2 := str4 + utf8String(';') + str2 + utf8String(';') + str3;
            str2 := StringReplace(str2, '\n', '', [rfReplaceAll]);
            str2 := StringReplace(str2, '\', '', [rfReplaceAll]);
            constvaluearray[length(constvaluearray) - 1] := str2;
            str3 := '';
            str4 := '';
          end;
          str2 := Copy(str1, 8, length(str1) - 8);
          iscontext := False;
          isid      := True;
          isstring  := False;
        end
        else if (Copy(str1, 1, 6) = 'msgstr') then
        begin
          str3      := (Copy(str1, 9, length(str1) - 9));
          str3      := StringReplace(str3, '\n', '', [rfReplaceAll]);
          iscontext := False;
          isid      := False;
          isstring  := True;
        end
        else if iscontext then
        begin
          strtemp := Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str4    := str4 + strtemp + utf8String(sLineBreak);
          end
          else
            str4    := str4 + strtemp;
        end
        else if isid then
        begin
          strtemp := Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str2    := str2 + strtemp + utf8String(sLineBreak);
          end
          else
            str2    := str2 + strtemp;
        end
        else if isstring then
        begin
          strtemp := Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str3    := (str3 + strtemp + utf8String(sLineBreak));
          end
          else
            str3    := str3 + strtemp;
        end;
    end;
    setlength(constvaluearray, length(constvaluearray) + 1);
    str2 := str4 + utf8String(';') + str2 + utf8String(';') + str3;
    str2 := StringReplace(str2, '\n', '', [rfReplaceAll]);
    str2 := StringReplace(str2, '\', '', [rfReplaceAll]);
    constvaluearray[length(constvaluearray) - 1] := str2;

    file1.Free;

    setlength(default_modalresulttext, length(en_modalresulttext));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      default_modalresulttext[Ord(imodalresultty)] := en_modalresulttext[Ord(imodalresultty)];

    setlength(default_modalresulttextnoshortcut, length(en_modalresulttextnoshortcut));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      default_modalresulttextnoshortcut[Ord(imodalresultty)] :=
        en_modalresulttextnoshortcut[Ord(imodalresultty)];

    setlength(default_stockcaption, length(en_stockcaption));
    for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
      default_stockcaption[Ord(istockcaptionty)] :=
        en_stockcaption[Ord(istockcaptionty)];

    setlength(default_extendedtext, length(en_extendedtext));
    for iextendedty := Low(extendedty) to High(extendedty) do
      default_extendedtext[Ord(iextendedty)] :=
        en_extendedtext[Ord(iextendedty)];

    setlength(default_mainfotext, length(en_mainfotext));
    for imainfoty := Low(mainfoty) to High(mainfoty) do
      default_mainfotext[Ord(imainfoty)] :=
        en_mainfotext[(imainfoty)];

    setlength(default_commanderfotext, length(en_commanderfotext));
    for icommanderfoty := Low(commanderfoty) to High(commanderfoty) do
      default_commanderfotext[Ord(icommanderfoty)] :=
        en_commanderfotext[(icommanderfoty)];

    setlength(default_filelistfotext, length(en_filelistfotext));
    for ifilelistfoty := Low(filelistfoty) to High(filelistfoty) do
      default_filelistfotext[Ord(ifilelistfoty)] :=
        en_filelistfotext[(ifilelistfoty)];

    setlength(default_infosfotext, length(en_infosfotext));
    for iinfosfoty := Low(infosfoty) to High(infosfoty) do
      default_infosfotext[Ord(iinfosfoty)] :=
        en_infosfotext[(iinfosfoty)];

    setlength(default_songplayerfotext, length(en_songplayerfotext));
    for isongplayerfoty := Low(songplayerfoty) to High(songplayerfoty) do
      default_songplayerfotext[Ord(isongplayerfoty)] :=
        en_songplayerfotext[(isongplayerfoty)];

    setlength(default_equalizerfotext, length(en_equalizerfotext));
    for iequalizerfoty := Low(equalizerfoty) to High(equalizerfoty) do
      default_equalizerfotext[Ord(iequalizerfoty)] :=
        en_equalizerfotext[(iequalizerfoty)];

    setlength(default_spectrum1fotext, length(en_spectrum1fotext));
    for ispectrum1foty := Low(spectrum1foty) to High(spectrum1foty) do
      default_spectrum1fotext[Ord(ispectrum1foty)] :=
        en_spectrum1fotext[(ispectrum1foty)];

    setlength(default_drumsfotext, length(en_drumsfotext));
    for idrumsfoty := Low(drumsfoty) to High(drumsfoty) do
      default_drumsfotext[Ord(idrumsfoty)] :=
        en_drumsfotext[(idrumsfoty)];

    setlength(default_randomnotefotext, length(en_randomnotefotext));
    for irandomnotefoty := Low(randomnotefoty) to High(randomnotefoty) do
      default_randomnotefotext[Ord(irandomnotefoty)] :=
        en_randomnotefotext[(irandomnotefoty)];

    setlength(lang_modalresult, length(default_modalresulttext));

    for x := 0 to length(default_modalresulttext) - 1 do
    begin

      dosearch(default_modalresulttext, x);
      if hasfound then
      else
        astrt := default_modalresulttext[x];
      if trim(astrt) = '' then
        astrt := default_modalresulttext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_modalresult[x] := astrt;

    end;

    setlength(lang_modalresultnoshortcut, length(default_modalresulttextnoshortcut));

    for x := 0 to length(default_modalresulttextnoshortcut) - 1 do
    begin
      dosearch(default_modalresulttextnoshortcut, x);

      if hasfound then
      else
        astrt := default_modalresulttextnoshortcut[x];
      if trim(astrt) = '' then
        astrt := default_modalresulttextnoshortcut[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_modalresultnoshortcut[x] := astrt;
    end;


    setlength(lang_stockcaption, length(default_stockcaption));

    for x := 0 to length(default_stockcaption) - 1 do
    begin
      dosearch(default_stockcaption, x);

      if hasfound then
      else
        astrt := default_stockcaption[x];
      if trim(astrt) = '' then
        astrt := default_stockcaption[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_stockcaption[x] := astrt;

    end;

    setlength(lang_extended, length(default_extendedtext));

    for x := 0 to length(default_extendedtext) - 1 do
    begin
      dosearch(default_extendedtext, x);

      if hasfound then
      else
        astrt := default_extendedtext[x];
      if trim(astrt) = '' then
        astrt := default_extendedtext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_extended[x] := astrt;

    end;

    setlength(lang_mainfo, length(default_mainfotext));

    for x := 0 to length(default_mainfotext) - 1 do
    begin
      dosearch(default_mainfotext, x);

      if hasfound then
      else
        astrt := default_mainfotext[x];
      if trim(astrt) = '' then
        astrt := default_mainfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_mainfo[x] := astrt;

    end;

    setlength(lang_commanderfo, length(default_commanderfotext));

    for x := 0 to length(default_commanderfotext) - 1 do
    begin
      dosearch(default_commanderfotext, x);

      if hasfound then
      else
        astrt := default_commanderfotext[x];
      if trim(astrt) = '' then
        astrt := default_commanderfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_commanderfo[x] := astrt;
    end;

    setlength(lang_filelistfo, length(default_filelistfotext));

    for x := 0 to length(default_filelistfotext) - 1 do
    begin
      dosearch(default_filelistfotext, x);

      if hasfound then
      else
        astrt := default_filelistfotext[x];
      if trim(astrt) = '' then
        astrt := default_filelistfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_filelistfo[x] := astrt;
    end;

    setlength(lang_infosfo, length(default_infosfotext));

    for x := 0 to length(default_infosfotext) - 1 do
    begin
      dosearch(default_infosfotext, x);

      if hasfound then
      else
        astrt := default_infosfotext[x];
      if trim(astrt) = '' then
        astrt := default_infosfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_infosfo[x] := astrt;
    end;

    setlength(lang_songplayerfo, length(default_songplayerfotext));

    for x := 0 to length(default_songplayerfotext) - 1 do
    begin
      dosearch(default_songplayerfotext, x);

      if hasfound then
      else
        astrt := default_songplayerfotext[x];
      if trim(astrt) = '' then
        astrt := default_songplayerfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_songplayerfo[x] := astrt;
    end;

    setlength(lang_equalizerfo, length(default_equalizerfotext));

    for x := 0 to length(default_equalizerfotext) - 1 do
    begin
      dosearch(default_equalizerfotext, x);

      if hasfound then
      else
        astrt := default_equalizerfotext[x];
      if trim(astrt) = '' then
        astrt := default_equalizerfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_equalizerfo[x] := astrt;
    end;

    setlength(lang_spectrum1fo, length(default_spectrum1fotext));

    for x := 0 to length(default_spectrum1fotext) - 1 do
    begin
      dosearch(default_spectrum1fotext, x);

      if hasfound then
      else
        astrt := default_spectrum1fotext[x];
      if trim(astrt) = '' then
        astrt := default_spectrum1fotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_spectrum1fo[x] := astrt;
    end;

    setlength(lang_drumsfo, length(default_drumsfotext));

    for x := 0 to length(default_drumsfotext) - 1 do
    begin
      dosearch(default_drumsfotext, x);

      if hasfound then
      else
        astrt := default_drumsfotext[x];
      if trim(astrt) = '' then
        astrt := default_drumsfotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_drumsfo[x] := astrt;
    end;

    setlength(lang_randomnotefo, length(default_randomnotefotext));

    for x := 0 to length(default_randomnotefotext) - 1 do
    begin
      dosearch(default_randomnotefotext, x);

      if hasfound then
      else
        astrt := default_randomnotefotext[x];
      if trim(astrt) = '' then
        astrt := default_randomnotefotext[x];

      astrt := StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      lang_randomnotefo[x] := astrt;
    end;
  end;
  listpofiles();
end;

end.

