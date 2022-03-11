
unit potools;

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
  mseact,
  mclasses,
  msedataedits,
  msedropdownlist,
  mseedit,
  mseificomp,
  mseificompglob,
  msestockobjects,
  mseifiglob,
  msememodialog,
  msestatfile,
  msestream,
  SysUtils,
  msesimplewidgets,
  mseconsts,
  msefileutils,
  msebitmap,
  msedatanodes,
  msedragglob,
  msegrids,
  msegridsglob,
  LazUTF8,
  mselistbrowser,
  msesys,
  msegraphedits,
  msescrollbar,
  msetimer,
  msedispwidgets,
  mserichstring,
  msestringcontainer,
  captionstrumpract,
  msefiledialogx;

type
  theaderfo = class(tmseform)
    memopoheader: tmemodialogedit;
    tbutton2: TButton;
    alldir: tbooleanedit;
    ttimer1: ttimer;
    paneldone: tgroupbox;
    labdone: tlabel;
    sc: tstringcontainer;
    tbutton4: TButton;
    outputdir: tfilenameeditx;
    impexpfiledialog: tfiledialogx;
    tlabel1: tlabel;
    tbutton3: TButton;
    tbutton5: TButton;
    tmemoedit1: tmemoedit;
    tbutton1: TButton;
    tbutton6: TButton;
    tbutton7: TButton;
    tbutton8: TButton;
    procedure createnew(const Sender: TObject);
    procedure createnewconst(const Sender: TObject; fn: msestring);
    procedure extractcaption(const Sender: TObject; fn: msestring);
    procedure createnewpo(const Sender: TObject; fn: msestring);
    procedure oncreateform(const Sender: TObject);
    procedure ontime(const Sender: TObject);
    procedure oncreated(const Sender: TObject);
    procedure onclose(const Sender: TObject);
    procedure onactiv(const Sender: TObject);
  end;

var
  headerfo: theaderfo;
  forgoogle: Boolean;
  buttag: integer = 0;
  astro, astrt, acomp: utf8String;
  defaultresult, constvaluearray: array of msestring;

implementation

uses
  conflang,
  potools_mfm;

procedure theaderfo.extractcaption(const Sender: TObject; fn: msestring);
var
  file1: ttextdatastream;
  str1, prestr, prearray, endstr, strlast: msestring;
  strobject, strcaption, strcaptmp, strcaptmp2, strobjtmp, strcaptionmenu,
  strmenu, strmenusub1, strmenusub2, strmenusub3: mseString;
  isfirst: Boolean = True;
  ismenu: Boolean = False;
  issubmenubegin: Boolean = False;
  issubmenuend: Boolean = False;
begin
  str1 := fn;

  if fileexists(str1) then
  begin

    file1          := ttextdatastream.Create(str1, fm_read);
    file1.encoding := ce_utf8;
    tmemoedit1.Visible := True;
    tbutton1.Visible := True;
    tmemoedit1.Value := '';

    file1.readln(str1);
    str1      := trim(StringReplace(str1, 'object', '', [rfReplaceAll]));
    str1      := trim(copy(str1, 1, system.pos(':', str1) - 1));
    strobject := trim(str1);

    if (TButton(Sender).tag = 3) or (TButton(Sender).tag = 6) then
    begin
      if (TButton(Sender).tag = 6) then
        tmemoedit1.Value := 'var' + lineend + '  lang_' + strobject + ': array of msestring;' + lineend + lineend;
      tmemoedit1.Value := tmemoedit1.Value + 'with ' + trim(str1) + ' do' + lineend + '  begin';
      prestr   := system.copy(strobject, 1, 2) + '_';
      prearray := 'lang_' + strobject + '[Ord(';
    end;

    if (TButton(Sender).tag = 4) then
    begin
      prestr           := system.copy(strobject, 1, 2) + '_';
      tmemoedit1.Value := 'type' + lineend + '  ' + trim(str1) + 'ty = (' + lineend;
    end;

    if (TButton(Sender).tag = 5) then
    begin
      prestr           := system.copy(strobject, 1, 2) + '_';
      tmemoedit1.Value := 'const' + lineend + '  ' + 'en_' + trim(str1) + 'text: ' +
        trim(str1) + 'ty = (' + lineend + lineend;
    end;

    isfirst := True;

    strmenusub2 := '';
    strmenusub3 := '';
    strmenusub1 := '';

    while not file1.EOF do
    begin
      str1 := '';
      file1.readln(str1);
      if trim(str1) <> '' then
      begin
      if (system.pos('object', str1) > 0) then
      begin
        if (system.pos('tmainmenu', str1) > 0) then
          ismenu         := True
        else
        begin
          ismenu         := False;
          issubmenubegin := False;
          issubmenuend   := False;
        end;
        if trim(strcaption) <> '' then
        begin
          // strcaption := StringReplace(strcaption, 'strmenusub1', 'parent_item', [rfReplaceAll]);
          //  strcaption := StringReplace(strcaption, 'strmenusub2', strmenusub2, [rfReplaceAll]);
          //  strcaption := StringReplace(strcaption, 'strmenusub3', strmenusub3, [rfReplaceAll]);

          strmenusub1 := '';
          strmenusub2 := '';
          strmenusub3 := '';

          tmemoedit1.Value := tmemoedit1.Value + strcaption + lineend;
        end;
        isfirst    := False;
        strobject  := trim(str1);
        strobject  := StringReplace(strobject, 'object', '', [rfReplaceAll]);
        strobject  := trim(copy(strobject, 1, system.pos(':', strobject) - 1));
        strobjtmp  := strobject;
        strcaption := '';
      end;

      if (ismenu = True) and ('submenu.items = <' = trim(str1)) then
        issubmenubegin := True;

      if ismenu = True then
        if (system.pos('name =', str1) > 0) then
        begin
          strmenu        := trim(copy(str1, system.pos('name =', str1) + 7, length(str1)));
          if (buttag <> 4) and (buttag <> 6) then
          begin
          strcaptionmenu := StringReplace(strcaptionmenu, 'menuxyz', strmenu, [rfReplaceAll]);
          end else
          begin
           strmenu        := trim(copy(strmenu, 2, length(strmenu) -2));
           strcaptionmenu := StringReplace(strcaptionmenu, 'menuxyz', strmenu , [rfReplaceAll]);
          end;

          //  if issubmenubegin then strcaptionmenu := StringReplace(strcaptionmenu, 'parentmenu', strmenusub, [rfReplaceAll]);
          strcaption     := strcaption + lineend + strcaptionmenu;
          strcaptionmenu := '';
          if issubmenubegin = False then
            strmenusub1 := strmenu;
        end;

      if (ismenu = True) and ('end>' = trim(str1)) then
      begin
      {
        if strmenusub1 = '' then
        strmenusub1   := strmenu else
        if strmenusub2 = '' then
        strmenusub2   := strmenu else
        if strmenusub3 = '' then
        strmenusub3   := strmenu;
      }
        issubmenubegin := False;
        issubmenuend   := True;
      end;

      if (system.pos('optionsdock = [', str1) = 0) and
        (system.pos('object', str1) = 0) and
        (system.pos('captionpos', str1) = 0) and
        (system.pos('captiondist', str1) = 0) and
        (system.pos('state = [', str1) = 0) and (system.pos('options = [', str1) = 0) and
        ((system.pos('caption', str1) > 0) or (system.pos('hint', str1) > 0)) then
      begin

        if (TButton(Sender).tag = 3) then
        begin
          str1 := trim(StringReplace(str1, ' = ', ' := ', [rfReplaceAll]));

          if isfirst = False then
          begin
            if ismenu = False then
              strcaption := strcaption + '      ' + trim(strobject) + '.' + trim(str1) + ';' + lineend//if trim(strobjtmp) <> trim(strobject) then strcaption := strcaption + lineend;

            else
            begin
              if issubmenubegin = False then
              begin
                strcaptionmenu := strcaptionmenu + lineend + '      ' +
                  trim(strobject) + '.menu.itembynames([menuxyz]).' + trim(str1) + ';' + lineend;
                strmenusub1    := '';
                strmenusub2    := '';
                strmenusub3    := '';
              end
              else
                strcaptionmenu := strcaptionmenu + lineend + '      ' +
                  trim(strobject) + '.menu.itembynames([''parentitem'',menuxyz]).' + trim(str1) + ';' + lineend;

             { if strmenusub1 = '' then
             else if (strmenusub1 <> '') and (strmenusub2 = '') and (strmenusub3 = '')then
               strcaptionmenu := strcaptionmenu + lineend + '      ' +
                strobject + '.menu.itembynames([strmenusub2,strmenusub1,menuxyz]).' + trim(str1) + ';';

                 strcaptionmenu := strcaptionmenu + lineend + '      ' +
               //   strobject + '.menu.itembynames([strmenusub,menuxyz]).' + trim(str1) + ';'
               }
            end;

          end
          else
            strcaption := strcaption + lineend + '      ' + trim(str1) + ';' + lineend;
          strlast      := lineend + strcaption;
        end;

        ////////////////

        if (TButton(Sender).tag = 6) then
        begin
          strcaptmp  := trim(system.copy(str1, 1, system.pos('=', str1) - 1));
          strcaptmp2 := trim(system.copy(str1, system.pos('=', str1) + 1, length(str1)));
          endstr     := '';
          if (system.pos('hint = ', str1) > 0) then
            endstr := '_hint';

          if isfirst = False then
          begin
            if ismenu = False then
              strcaption := strcaption + '      ' + trim(strobject) + '.' +
                trim(strcaptmp) + ' := ' + prearray + prestr + trim(strobject) + endstr + ')];  {' + strcaptmp2 + '}'
            else
            begin
              if issubmenubegin = False then
              begin
                strcaptionmenu := strcaptionmenu + '      ' + trim(strobject) +
                '.menu.itembynames([menuxyz]).'  +
                trim(strcaptmp) + ' := ' + prearray + prestr + trim(strobject) + '_menuxyz' + endstr + ')];  {' + strcaptmp2 + '}';



                strmenusub1    := '';
                strmenusub2    := '';
                strmenusub3    := '';
              end
              else
               begin
                 strcaptionmenu := strcaptionmenu + '      ' + trim(strobject) +
                '.menu.itembynames([''parentitem'',menuxyz]).'  +
                trim(strcaptmp) + ' := ' + prearray + prestr + trim(strobject)+ '_parentitem_menuxyz' + endstr + ')];  {' + strcaptmp2 + '}';
               end;
              end;

          end
          else
            strcaption := strcaption + lineend + '      ' + trim(strobject) + '.' +
              trim(strcaptmp) + ' := ' + prearray + prestr + trim(strobject) +
              endstr + ')];  {' + strcaptmp2 + '}' ;
          strlast      := lineend + strcaption;
        end;

          ////////////////////////

        if (TButton(Sender).tag = 4) then
        begin
          //str1 := trim(StringReplace(str1, '=', '//', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, '.caption = ', ' {', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, '.hint = ', '_hint {', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, 'caption = ', ', {', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, 'hint = ', '_hint {', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, '.caption', '', [rfReplaceAll]));
          str1 := trim(StringReplace(str1, '.hint', '_hint', [rfReplaceAll]));

          if isfirst = False then
          begin
            if ismenu = False then
              strcaption := strcaption + '      ' + prestr + trim(strobject) + (str1) + '}'
            else
            begin
              if issubmenubegin = False then
                //strcaptionmenu := strcaptionmenu + '      ' + prestr + 'menu_' + trim(strobject) + (str1) + '}';

                 strcaptionmenu := strcaptionmenu + lineend + '      ' +  prestr + trim(strobject) +
                '_menuxyz' + (str1) + '}'
                else     strcaptionmenu := strcaptionmenu + lineend + '      ' +  prestr + trim(strobject) +
                '_parentitem_menuxyz' + (str1) + '}';

                      strlast      := lineend + '      ' +  prestr + trim(strobject) +
                '_menu' + (str1) + '}'


              { if strmenusub1 = '' then
             else if (strmenusub1 <> '') and (strmenusub2 = '') and (strmenusub3 = '')then
               strcaptionmenu := strcaptionmenu + lineend + '      ' +
                strobject + '.menu.itembynames([strmenusub2,strmenusub1,menuxyz]).' + trim(str1) + ';';

                 strcaptionmenu := strcaptionmenu + lineend + '      ' +
               //   strobject + '.menu.itembynames([strmenusub,menuxyz]).' + trim(str1) + ';'
               }
           end;
          end
          else
          begin
            strcaption := strcaption + '      ' + prestr + trim(strobject) + trim(str1) + '}';
            strlast      := lineend + '      ' + prestr + trim(strobject) + trim(str1) + '}';
          end;

        end;
        ///////

        if (TButton(Sender).tag = 5) then
        begin
          endstr   := '';
          // if (system.pos('.hint = ', str1) > 0) or
          if (system.pos('hint = ', str1) > 0) then
            endstr := '_hint';


          strcaptmp := trim(system.copy(str1, system.pos('=', str1) + 1, length(str1)));

          if isfirst = False then
          begin
            if ismenu = False then
              strcaption := strcaption + '      ' + strcaptmp + ', {' + prestr + trim(strobject) + endstr + '}'
            else
            begin
              if issubmenubegin = False then
                strcaptionmenu := strcaptionmenu + '      ' + strcaptmp + ', {' + prestr  +
                  trim(strobject) + '_menuxyz' + endstr +  '}' else
                strcaptionmenu := strcaptionmenu + '      ' + strcaptmp + ', {' + prestr  +
                  trim(strobject) + '_parentitem_menuxyz' + endstr +  '}' ;


             { if strmenusub1 = '' then
             else if (strmenusub1 <> '') and (strmenusub2 = '') and (strmenusub3 = '')then
               strcaptionmenu := strcaptionmenu + lineend + '      ' +
                strobject + '.menu.itembynames([strmenusub2,strmenusub1,menuxyz]).' + trim(str1) + ';';

                 strcaptionmenu := strcaptionmenu + lineend + '      ' +
               //   strobject + '.menu.itembynames([strmenusub,menuxyz]).' + trim(str1) + ';'
               }
            end;

          end
          else
            strcaption := strcaption + '      ' + strcaptmp +
              ', {' + prestr + trim(strobject) + endstr + '}';

          strlast := lineend + strcaption;
        end;
       end;
      end;
   end;

    /////////////////////////

    if (TButton(Sender).tag = 3) or (TButton(Sender).tag = 6) then
    begin
      //tmemoedit1.Value := (StringReplace(tmemoedit1.Value, strlast, '', [rfReplaceAll]));
     // strlast          := trim(StringReplace(strlast, lineend, '', [rfReplaceAll]));
      tmemoedit1.Value := tmemoedit1.Value + lineend + '  end;';
    // if (TButton(Sender).tag = 6) then
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, '}', '}' + lineend , [rfReplaceAll]));
     if (TButton(Sender).tag = 3) then
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ';', ';' + lineend , [rfReplaceAll]));
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, lineend + lineend + lineend, lineend + lineend, [rfReplaceAll]));
    if (TButton(Sender).tag = 6) then
     begin
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ']).caption', ''']).caption' , [rfReplaceAll]));
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ']).hint', ''']).hint' , [rfReplaceAll]));
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, 'itembynames([', 'itembynames([''' , [rfReplaceAll]));
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, '[''''parentitem', '[''parentitem' , [rfReplaceAll]));
     tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ''',', ''',''' , [rfReplaceAll]));
     end;
    end;

    if (TButton(Sender).tag = 4) or (TButton(Sender).tag = 5) then
    begin
      // tmemoedit1.Value := (StringReplace(tmemoedit1.Value, strlast, '', [rfReplaceAll]));
      // if ismenu = False then strlast := trim(StringReplace(strlast, ',', '', [rfReplaceAll]));
      tmemoedit1.Value := (StringReplace(tmemoedit1.Value, '}', '}' + lineend , [rfReplaceAll]));
      tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ' {', ', {' , [rfReplaceAll]));
      tmemoedit1.Value := (StringReplace(tmemoedit1.Value, ',,', ',' , [rfReplaceAll]));
      
      
      tmemoedit1.Value := tmemoedit1.Value + '      ' +  lineend + '   );';
      tmemoedit1.Value := (StringReplace(tmemoedit1.Value, lineend + lineend , lineend , [rfReplaceAll]));
     // tmemoedit1.Value := tmemoedit1.Value + strlast;
    end;
    file1.Free;
  end;
end;

///////////////////////

procedure theaderfo.createnewpo(const Sender: TObject; fn: msestring);
var
  x, y, int1: integer;
  str1, str2: msestring;
  file1: ttextdatastream;
  imodalresultty: modalresultty;
  iextendedty: extendedty;
  istockcaptionty: stockcaptionty;
  imainfoty: mainfoty;
  icommanderfoty: commanderfoty;
  ifilelistfoty: filelistfoty;
  iinfosfoty: infosfoty;
  isongplayerfoty: songplayerfoty;
  iequalizerfoty: equalizerfoty;
  ispectrum1foty: spectrum1foty;
  idrumsfoty: drumsfoty;
  irandomnotefoty: randomnotefoty;
 
begin

  setlength(defaultresult, length(en_modalresulttext));
  for imodalresultty := Low(modalresultty) to High(modalresultty) do
    defaultresult[Ord(imodalresultty)] := en_modalresulttext[(imodalresultty)];

  y := length(defaultresult);
  setlength(defaultresult, length(en_modalresulttextnoshortcut) + y);
  for imodalresultty := Low(modalresultty) to High(modalresultty) do
    defaultresult[y + Ord(imodalresultty)] := en_modalresulttextnoshortcut[(imodalresultty)];

  y := length(defaultresult);
  setlength(defaultresult, length(en_stockcaption) + y);
  for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
    defaultresult[y + Ord(istockcaptionty)] := en_stockcaption[(istockcaptionty)];

  y := length(defaultresult);
  setlength(defaultresult, length(en_extendedtext) + y);
  for iextendedty := Low(extendedty) to High(extendedty) do
    defaultresult[y + Ord(iextendedty)] := en_extendedtext[(iextendedty)];

  y := length(defaultresult);
  setlength(defaultresult, length(en_mainfotext) + y);
  for imainfoty := Low(mainfoty) to High(mainfoty) do
    defaultresult[y + Ord(imainfoty)] := en_mainfotext[(imainfoty)];
  
   y := length(defaultresult);
  setlength(defaultresult, length(en_commanderfotext) + y);
  for icommanderfoty := Low(commanderfoty) to High(commanderfoty) do
    defaultresult[y + Ord(icommanderfoty)] := en_commanderfotext[(icommanderfoty)];
   
    y := length(defaultresult);
  setlength(defaultresult, length(en_filelistfotext) + y);
  for ifilelistfoty := Low(filelistfoty) to High(filelistfoty) do
    defaultresult[y + Ord(ifilelistfoty)] := en_filelistfotext[(ifilelistfoty)];
    
     y := length(defaultresult);
  setlength(defaultresult, length(en_infosfotext) + y);
  for iinfosfoty := Low(infosfoty) to High(infosfoty) do
    defaultresult[y + Ord(iinfosfoty)] := en_infosfotext[(iinfosfoty)];
     
     y := length(defaultresult);
  setlength(defaultresult, length(en_songplayerfotext) + y);
  for isongplayerfoty := Low(songplayerfoty) to High(songplayerfoty) do
    defaultresult[y + Ord(isongplayerfoty)] := en_songplayerfotext[(isongplayerfoty)];

    y := length(defaultresult);
  setlength(defaultresult, length(en_equalizerfotext) + y);
  for iequalizerfoty := Low(equalizerfoty) to High(equalizerfoty) do
    defaultresult[y + Ord(iequalizerfoty)] := en_equalizerfotext[(iequalizerfoty)];

    y := length(defaultresult);
  setlength(defaultresult, length(en_spectrum1fotext) + y);
  for ispectrum1foty := Low(spectrum1foty) to High(spectrum1foty) do
    defaultresult[y + Ord(ispectrum1foty)] := en_spectrum1fotext[(ispectrum1foty)];
    
     y := length(defaultresult);
  setlength(defaultresult, length(en_drumsfotext) + y);
  for idrumsfoty := Low(drumsfoty) to High(drumsfoty) do
    defaultresult[y + Ord(idrumsfoty)] := en_drumsfotext[(idrumsfoty)];
 
    
     y := length(defaultresult);
  setlength(defaultresult, length(en_randomnotefotext) + y);
  for irandomnotefoty := Low(randomnotefoty) to High(randomnotefoty) do
    defaultresult[y + Ord(irandomnotefoty)] := en_randomnotefotext[(irandomnotefoty)];
 
   // check if double "msgid"
  str1 := '';
  str2 := '';
  int1 := 0;
  for x := 0 to length(defaultresult) - 1 do
  begin
    if int1 > 1 then
      str2 := str2 +
        'Similar msgid = ' + str1 + ' = ' + IntToStr(int1) + lineend;
    int1   := 0;
    str1   := defaultresult[x];
    if trim(str1) <> '' then
      for y := 0 to length(defaultresult) - y do
        if defaultresult[y] = str1 then
          Inc(int1);
  end;

  if trim(str2) = '' then
    ShowMessage('   Good: No double similar "msgid" found!   ',
      'Result of double "msegid"')
  else
    ShowMessage('Those double similar "msgid" were found:' + lineend + str2,
      'Result of check for double "msegid"');

  if forgoogle = False then
    file1 := ttextdatastream.Create(outputdir.Value +
      'strumpract_empty.po', fm_create)
  else
    file1 := ttextdatastream.Create(outputdir.Value +
      'strumpract_empty.txt', fm_create);

  file1.encoding := ce_utf8;

  if forgoogle = False then
    file1.writeln(memopoheader.Value)
  else
    file1.writeln();

  file1.writeln();

  for x := 0 to length(defaultresult) - 1 do
    if trim(defaultresult[x]) <> '' then
    begin
      if forgoogle = False then
      begin
        file1.writeln('msgid "' + defaultresult[x] + '"');
        file1.writeln('msgstr ""');
      end
      else
        file1.writeln('msgstr "' + defaultresult[x] + '"');
      file1.writeln('');
    end;
  file1.Free;
end;

procedure theaderfo.createnew(const Sender: TObject);
var
  filterlista, filterlistb: msestringarty;
  str1: msestring;
begin

  if (TButton(Sender).tag = 0) or (TButton(Sender).tag = 3) or (TButton(Sender).tag = 4) or (TButton(Sender).tag = 5) or (TButton(Sender).tag = 6) then
  begin
    setlength(filterlista, 1);
    setlength(filterlistb, 1);
    if (TButton(Sender).tag = 0) then
    begin
      filterlista[0] := 'strumpract_xz.txt to joint';
      filterlistb[0] := '*.txt';
      impexpfiledialog.controller.filter := '*.txt';
    end;
    if (TButton(Sender).tag = 3) or (TButton(Sender).tag = 4) or (TButton(Sender).tag = 5) or (TButton(Sender).tag = 6) then
    begin
      filterlista[0] := '.mfm to extract captions ';
      filterlistb[0] := '*.mfm';
      impexpfiledialog.controller.filter := '*.mfm';
    end;
    impexpfiledialog.controller.options := [fdo_savelastdir];

    with impexpfiledialog.controller.filterlist do
    begin
      asarraya := filterlista;
      asarrayb := filterlistb;
    end;

    impexpfiledialog.controller.filterindex := 0;
    application.ProcessMessages;

    if impexpfiledialog.Execute(fdk_open) = mr_ok then
    begin
      paneldone.frame.colorclient := $FFD1A1;
      labdone.Caption := sc[0];
      paneldone.Visible := True;
      application.ProcessMessages;
      str1 := impexpfiledialog.controller.filename;
      if (TButton(Sender).tag = 0) then
        createnewconst(Sender, str1);

      buttag := TButton(Sender).tag;

      if (TButton(Sender).tag = 3) or (TButton(Sender).tag = 4) or
         (TButton(Sender).tag = 5) or (TButton(Sender).tag = 6) then
        extractcaption(Sender, str1);
      paneldone.frame.colorclient := cl_ltgreen;
      labdone.Caption   := sc[1];
      paneldone.Visible := True;
      ttimer1.Enabled   := True;
    end;
  end;

  if (TButton(Sender).tag = 1) or (TButton(Sender).tag = 2) then
  begin
    if (TButton(Sender).tag = 1) then
      forgoogle := False
    else
      forgoogle := True;
    createnewpo(Sender, '');
    paneldone.frame.colorclient := cl_ltgreen;
    labdone.Caption := sc[1];
    paneldone.Visible := True;
    ttimer1.Enabled   := True;
  end;

end;

procedure theaderfo.createnewconst(const Sender: TObject; fn: msestring);
var
  x: integer;
  file1: ttextdatastream;
  str1, strlang, filename1: msestring;
  str2: utf8String;
begin
  str1    := fn;
  strlang := '';

  if fileexists(str1) then
  begin

    file1 := ttextdatastream.Create(str1, fm_read);

    filename1 := copy(filename(str1), 1, length(filename(str1)) - 4);
    strlang   := trim(copy(filename1, system.pos('_', filename1) + 1, length(filename1)));

    strlang := utf8StringReplace(strlang, '@', '_', [rfReplaceAll]);

    file1.encoding := ce_utf8;

    setlength(constvaluearray, 0);

    //  file1.readln(str1);

    while not file1.EOF do
    begin
      str1 := '';
      file1.readln(str1);
      str2 := '';
      if (trim(str1) <> '') and (UTF8Copy(str1, 1, 1) <> '#') then
        if (UTF8Copy(str1, 1, 6) = 'msgstr') then
        begin
          str2 := UTF8Copy(str1, 7, length(str1));
          str2 := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
          str2 := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
          str2 := utf8StringReplace(str2, '"', '', [rfReplaceAll]);
          if str2 <> '' then
          begin
            setlength(constvaluearray, length(constvaluearray) + 1);
            constvaluearray[length(constvaluearray) - 1] := trim(str2);
          end;
        end;
    end;

    file1.Free;

    str1 := ExtractFilePath(ParamStr(0)) + directoryseparator + 'lang' + directoryseparator +
      'strumpract_empty.po';

    if fileexists(str1) then
    begin

      file1          := ttextdatastream.Create(str1, fm_read);
      file1.encoding := ce_utf8;

      setlength(defaultresult, 0);

      file1.readln(str1);

      while not file1.EOF do
      begin
        str1 := '';
        file1.readln(str1);
        str2 := '';
        if (trim(str1) <> '') and (UTF8Copy(str1, 1, 1) <> '#') then
          if (UTF8Copy(str1, 1, 5) = 'msgid') then
          begin
            str2 := UTF8Copy(str1, 7, length(str1));
            str2 := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
            str2 := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
            str2 := utf8StringReplace(str2, '"', '', [rfReplaceAll]);
            if trim(str2) <> '' then
            begin
              setlength(defaultresult, length(defaultresult) + 1);
              defaultresult[length(defaultresult) - 1] := trim(str2);
            end;
          end;
      end;

      file1.Free;
    end;

    file1          := ttextdatastream.Create(outputdir.Value + 'strumpract_' + strlang + '.po',
      fm_create);
    file1.encoding := ce_utf8;

    file1.writeln(memopoheader.Value);
    file1.writeln();

    // writeln('length(defaultresult) ' + inttostr(length(defaultresult)));
    // writeln('length(constvaluearray) ' + inttostr(length(constvaluearray)));
    str2 := '';

    for x := 0 to length(defaultresult) - 1 do
    begin
      file1.writeln('msgid "' + defaultresult[x] + '"');

      if x < length(constvaluearray) then
      begin
        if trim(constvaluearray[x]) <> '' then
          file1.writeln('msgstr "' + constvaluearray[x] + '"')
        else
          file1.writeln('msgstr "' + defaultresult[x] + '"');
      end
      else
        file1.writeln('msgstr "' + defaultresult[x] + '"');

      file1.writeln('');
    end;

    file1.Free;

  end;
end;

procedure theaderfo.oncreateform(const Sender: TObject);
begin
  outputdir.Value := ExtractFilePath(ParamStr(0)) + 'output' + directoryseparator;
end;

procedure theaderfo.ontime(const Sender: TObject);
begin
  paneldone.Visible := False;
end;

procedure theaderfo.oncreated(const Sender: TObject);
begin
  //headerfo.visible := false;
end;

procedure theaderfo.onclose(const Sender: TObject);
begin
  tbutton1.Visible   := False;
  tmemoedit1.Visible := False;
end;

procedure theaderfo.onactiv(const Sender: TObject);
begin
  //visible := false;
end;

end.

