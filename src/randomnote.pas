
unit randomnote;

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
  mseforms,
  msedock,
  msesimplewidgets,
  msewidgets,
  mseedit,
  msestatfile,
  msestream,
  SysUtils,
  mseact,
  msedataedits,
  msedropdownlist,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msedispwidgets,
  mserichstring,
  msegraphedits,
  msescrollbar,
  msechartedit,
  msesiggui,
  msesignal,
  mseimage;

type
  trandomnotefo = class(tdockform)
    guitar2: tstringdisp;
    guitar3: tstringdisp;
    piano1: tstringdisp;
    guitar1: tstringdisp;
    keyb1: timage;
    elipse1_1: timage;
    elipse1_2: timage;
    elipse1_3: timage;
    piano2: tstringdisp;
    keyb2: timage;
    elipse2_1: timage;
    elipse2_2: timage;
    elipse2_3: timage;
    piano3: tstringdisp;
    keyb3: timage;
    elipse3_1: timage;
    elipse3_2: timage;
    elipse3_3: timage;
    timage1: timage;
    gelipse1_3: timage;
    gelipse1_2: timage;
    gelipse1_1: timage;
    gelipse2_3: timage;
    gelipse2_1: timage;
    gelipse2_2: timage;
    timage8: timage;
    gelipse3_3: timage;
    gelipse3_2: timage;
    gelipse3_1: timage;
    timage12: timage;
    chord1: TButton;
    chord2: TButton;
    chord3: TButton;
    tbutton4: TButton;
    bass1: tstringdisp;
    timage2: timage;
    belipse1_3: timage;
    belipse1_1: timage;
    belipse1_2: timage;
    bass2: tstringdisp;
    timage6: timage;
    belipse2_3: timage;
    belipse2_1: timage;
    belipse2_2: timage;
    bass3: tstringdisp;
    timage11: timage;
    belipse3_3: timage;
    belipse3_1: timage;
    belipse3_2: timage;
    tstringdisp1: tstringdisp;
    chord1drop: tdropdownlistedit;
    chord2drop: tdropdownlistedit;
    chord3drop: tdropdownlistedit;
    bnbchords: TButton;
    btnfixed: TButton;
    tbutton5: TButton;
    chord4: TButton;
    chord4drop: tdropdownlistedit;
    piano4: tstringdisp;
    keyb4: timage;
    elipse4_1: timage;
    elipse4_2: timage;
    elipse4_3: timage;
    guitar4: tstringdisp;
    timage9: timage;
    gelipse4_3: timage;
    gelipse4_2: timage;
    gelipse4_1: timage;
    bass4: tstringdisp;
    timage15: timage;
    belipse4_3: timage;
    belipse4_1: timage;
    belipse4_2: timage;
    chord5: TButton;
    chord5drop: tdropdownlistedit;
    piano5: tstringdisp;
    keyb5: timage;
    elipse5_1: timage;
    elipse5_2: timage;
    elipse5_3: timage;
    guitar5: tstringdisp;
    timage23: timage;
    gelipse5_3: timage;
    gelipse5_2: timage;
    gelipse5_1: timage;
    bass5: tstringdisp;
    timage27: timage;
    belipse5_3: timage;
    belipse5_1: timage;
    belipse5_2: timage;
    bchord1: TButton;
    bchord5: TButton;
    bchord4: TButton;
    bchord3: TButton;
    bchord2: TButton;
    tbutton2: TButton;
    tbutton3: TButton;
    tgroupbox1: tgroupbox;
    bool7th: tbooleanedit;
    boolminor: tbooleanedit;
    boolmajor: tbooleanedit;
    bool9th: tbooleanedit;
    tgroupbox2: tgroupbox;
    numchord: tintegerdisp;
    maxnote: tdropdownlistedit;
    withrandom: tbooleanedit;
    tgroupbox3: tgroupbox;
    bpm: tintegerdisp;
    nodrums: tbooleanedit;
    withsharp: tbooleanedit;
    bosound: tbooleanedit;
    bconfig: TButton;
    tstringdisp2: tstringdisp;
    timage3: timage;
    timage4: timage;
    timage5: timage;
    timage7: timage;
    pconfigtext: tstringdisp;
    tmemoedit1: tmemoedit;
    tbutton6: TButton;
    procedure onmousevdrop(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure dorandomchordbut(const Sender: TObject);
    procedure dorandomchord(const Sender: TObject);
    procedure oncreatedev(const Sender: TObject);
    procedure randomnum(const Sender: TObject);
    procedure onclosev(const Sender: TObject);
    procedure doclear(const Sender: TObject);
    procedure onshowdrums(const Sender: TObject);
    procedure doquit(const Sender: TObject);
    procedure pianochord(num, ranchord, ismin, isseven: integer);
    procedure guitarchord(num, ranchord, ismin, isseven: integer);
    procedure basschord(num, ranchord, ismin, isseven: integer);
    procedure showguit(const Sender: TObject);
    procedure onmouseguit(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onmousepiano(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure refreshform(const Sender: TObject);
    procedure onmousev(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure ontextmax(const Sender: tcustomdataedit; var atext: msestring; var accept: Boolean);
    procedure playrandomchords(thenum: integer);

    procedure ondropchord(const Sender: twidget; const dropdown: tdropdownlist);
    procedure onchangechorddrop(const Sender: TObject);
    procedure dofixed(const Sender: TObject);
    procedure doinit(const Sender: TObject);
    procedure doconfig(const Sender: TObject);
    procedure onconfigtext(const Sender: TObject);

    procedure onhide(const Sender: TObject);
    procedure onshowrand(const Sender: TObject);
    procedure crea(const Sender: TObject);
  end;

var
  randomnotefo: trandomnotefo;
  chordran: integer;
  chorddrop: integer = 0;
  chordmem1, chordmem2, chordmem3, chordmem4, chordmem5: msestring;
  blocked: integer = 0;

implementation

uses
  captionstrumpract,
  randomnote_mfm,
  main,
  config,
  uos_flat,
  guitars,
  drums;

procedure trandomnotefo.guitarchord(num, ranchord, ismin, isseven: integer);
var
  ratioheight: double;
begin
  ratioheight := (bchord1.Height / 158);

  if num = 1 then
  begin
    gelipse1_1.Visible := True;
    gelipse1_2.Visible := True;
    gelipse1_3.Visible := True;
  end
  else if num = 2 then
  begin
    gelipse2_1.Visible := True;
    gelipse2_2.Visible := True;
    gelipse2_3.Visible := True;
  end
  else if num = 3 then
  begin
    gelipse3_1.Visible := True;
    gelipse3_2.Visible := True;
    gelipse3_3.Visible := True;
  end
  else if num = 4 then
  begin
    gelipse4_1.Visible := True;
    gelipse4_2.Visible := True;
    gelipse4_3.Visible := True;
  end
  else if num = 5 then
  begin
    gelipse5_1.Visible := True;
    gelipse5_2.Visible := True;
    gelipse5_3.Visible := True;
  end;

  if (ranchord = 1) and (ismin = 1) then
    // La maj     
  begin
    if num = 1 then
    begin
      // 4-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 48;

      // 3-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 68;

      // 2-2
      gelipse1_3.top  := round(74 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := ' X 0       0' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 48;

      // 3-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 68;

      // 2-2
      gelipse2_3.top  := round(74 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := ' X 0       0' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 4-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 48;

      // 3-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 68;

      // 2-2
      gelipse3_3.top  := round(74 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := ' X 0       0' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 4-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 48;

      // 3-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 68;

      // 2-2
      gelipse4_3.top  := round(74 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := ' X 0       0' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 4-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 48;

      // 3-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 68;

      // 2-2
      gelipse5_3.top  := round(74 * ratioheight);
      gelipse5_3.left := 88;

      guitar5.Text := ' X 0       0' + lineend + ' ══════════  0';
    end;

  end
  else if (ranchord = 1) and (ismin <> 1) then
    // La min   
  begin
    if num = 1 then
    begin
      // 4-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 48;

      // 3-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 68;

      // 2-1
      gelipse1_3.top  := round(32 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := ' X 0       0' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 48;

      // 3-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 68;

      // 2-1
      gelipse2_3.top  := round(32 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := ' X 0       0' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 4-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 48;

      // 3-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 68;

      // 2-1
      gelipse3_3.top  := round(32 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := ' X 0       0' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 4-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 48;

      // 3-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 68;

      // 2-1
      gelipse4_3.top  := round(32 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := ' X 0       0' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 4-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 48;

      // 3-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 68;

      // 2-1
      gelipse5_3.top  := round(32 * ratioheight);
      gelipse5_3.left := 88;

      guitar5.Text := ' X 0       0' + lineend + ' ══════════  0';
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin = 1)) then
  begin
      // Si Maj
    if num = 1 then
    begin
      // 4-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 48;

      // 3-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 68;

      // 2-2
      gelipse1_3.top  := round(74 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 48;

      // 3-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 68;

      // 2-2
      gelipse2_3.top  := round(74 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';

    end
    else if num = 3 then
    begin
      // 4-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 48;

      // 3-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 68;

      // 2-2
      gelipse3_3.top  := round(74 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';
    end
    else if num = 4 then
    begin
      // 4-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 48;

      // 3-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 68;

      // 2-2
      gelipse4_3.top  := round(74 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';
    end
    else if num = 5 then
    begin
      // 4-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 48;

      // 3-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 68;

      // 2-2
      gelipse5_3.top  := round(74 * ratioheight);
      gelipse5_3.left := 88;

      guitar5.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin <> 1)) then
  begin
      // Si min 
    if num = 1 then
    begin
      // 4-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 48;

      // 3-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 68;

      // 2-1
      gelipse1_3.top  := round(32 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 48;

      // 3-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 68;

      // 2-1
      gelipse2_3.top  := round(32 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';

    end
    else if num = 3 then
    begin
      // 4-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 48;

      // 3-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 68;

      // 2-1
      gelipse3_3.top  := round(32 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';
    end
    else if num = 4 then
    begin
      // 4-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 48;

      // 3-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 68;

      // 2-1
      gelipse4_3.top  := round(32 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := '═X═0═══════0═ ' + lineend +
        ' ══════════  2';
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin = 1)) then
  begin
      // Do Maj
    if num = 1 then
    begin
      // 5-3
      gelipse1_1.top  := round(114 * ratioheight);
      gelipse1_1.left := 28;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      // 2-1
      gelipse1_3.top  := round(32 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := ' X         0' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(114 * ratioheight);
      gelipse2_1.left := 28;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      // 2-1
      gelipse2_3.top  := round(32 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := ' X         0' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin

      gelipse3_1.top  := round(114 * ratioheight);
      gelipse3_1.left := 28;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      // 2-1
      gelipse3_3.top  := round(32 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := ' X         0' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin

      gelipse4_1.top  := round(114 * ratioheight);
      gelipse4_1.left := 28;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      // 2-1
      gelipse4_3.top  := round(32 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := ' X         0' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin

      gelipse5_1.top  := round(114 * ratioheight);
      gelipse5_1.left := 28;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      // 2-1
      gelipse5_3.top  := round(32 * ratioheight);
      gelipse5_3.left := 88;

      guitar5.Text := ' X         0' + lineend + ' ══════════  0';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin <> 1)) then
  begin
      // Do min 
    if num = 1 then
    begin
      // 4-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 48;

      // 3-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 68;

      // 2-1
      gelipse1_3.top  := round(32 * ratioheight);
      gelipse1_3.left := 88;

      guitar1.Text := '═X═0═══════0═' + lineend +
        ' ══════════  3';

    end
    else if num = 2 then
    begin
      // 4-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 48;

      // 3-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 68;

      // 2-1
      gelipse2_3.top  := round(32 * ratioheight);
      gelipse2_3.left := 88;

      guitar2.Text := '═X═0═══════0═' + lineend +
        ' ══════════  3';

    end
    else if num = 3 then
    begin
      // 4-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 48;

      // 3-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 68;

      // 2-1
      gelipse3_3.top  := round(32 * ratioheight);
      gelipse3_3.left := 88;

      guitar3.Text := '═X═0═══════0═' + lineend +
        ' ══════════  3';
    end
    else if num = 4 then
    begin
      // 4-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 48;

      // 3-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 68;

      // 2-1
      gelipse4_3.top  := round(32 * ratioheight);
      gelipse4_3.left := 88;

      guitar4.Text := '═X═0═══════0═' + lineend +
        ' ══════════  3';
    end
    else if num = 5 then
    begin
      // 4-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 48;

      // 3-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 68;

      // 2-1
      gelipse5_3.top  := round(32 * ratioheight);
      gelipse5_3.left := 88;

      guitar5.Text := '═X═0═══════0═' + lineend +
        ' ══════════  3';
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin = 1)) then
  begin
      // Ré Maj
    if num = 1 then
    begin
      // 3-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 68;

      // 2-3
      gelipse1_2.top  := round(116 * ratioheight);
      gelipse1_2.left := 90;

      // 2-1
      gelipse1_3.top  := round(74 * ratioheight);
      gelipse1_3.left := 108;

      guitar1.Text := ' X X 0      ' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 3-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 68;

      // 2-3
      gelipse2_2.top  := round(116 * ratioheight);
      gelipse2_2.left := 90;

      // 2-1
      gelipse2_3.top  := round(74 * ratioheight);
      gelipse2_3.left := 108;

      guitar2.Text := ' X X 0      ' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 3-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 68;

      // 2-3
      gelipse3_2.top  := round(116 * ratioheight);
      gelipse3_2.left := 90;

      // 2-1
      gelipse3_3.top  := round(74 * ratioheight);
      gelipse3_3.left := 108;

      guitar3.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 3-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 68;

      // 2-3
      gelipse4_2.top  := round(116 * ratioheight);
      gelipse4_2.left := 90;

      // 2-1
      gelipse4_3.top  := round(74 * ratioheight);
      gelipse4_3.left := 108;

      guitar4.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 3-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 68;

      // 2-3
      gelipse5_2.top  := round(116 * ratioheight);
      gelipse5_2.left := 90;

      // 2-1
      gelipse5_3.top  := round(74 * ratioheight);
      gelipse5_3.left := 108;

      guitar5.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin <> 1)) then
  begin
      // Ré min 
    if num = 1 then
    begin
      // 3-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 68;

      // 2-3
      gelipse1_2.top  := round(116 * ratioheight);
      gelipse1_2.left := 90;

      // 2-1
      gelipse1_3.top  := round(32 * ratioheight);
      gelipse1_3.left := 108;

      guitar1.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end
    else if num = 2 then
    begin
      // 3-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 68;

      // 2-3
      gelipse2_2.top  := round(116 * ratioheight);
      gelipse2_2.left := 90;

      // 2-1
      gelipse2_3.top  := round(32 * ratioheight);
      gelipse2_3.left := 108;

      guitar2.Text := ' X X 0      ' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 3-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 68;

      // 2-3
      gelipse3_2.top  := round(116 * ratioheight);
      gelipse3_2.left := 90;

      // 2-1
      gelipse3_3.top  := round(32 * ratioheight);
      gelipse3_3.left := 108;

      guitar3.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 3-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 68;

      // 2-3
      gelipse4_2.top  := round(116 * ratioheight);
      gelipse4_2.left := 90;

      // 2-1
      gelipse4_3.top  := round(32 * ratioheight);
      gelipse4_3.left := 108;

      guitar4.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 3-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 68;

      // 2-3
      gelipse5_2.top  := round(116 * ratioheight);
      gelipse5_2.left := 90;

      // 2-1
      gelipse5_3.top  := round(32 * ratioheight);
      gelipse5_3.left := 108;

      guitar5.Text := ' X X 0      ' + lineend + ' ══════════  0';
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin = 1)) then
  begin
      // Mi Maj
    if num = 1 then
    begin
      // 5-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 26;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      // 3-1
      gelipse1_3.top  := round(30 * ratioheight);
      gelipse1_3.left := 70;

      guitar1.Text := ' 0       0 0' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 5-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 26;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      // 3-1
      gelipse2_3.top  := round(30 * ratioheight);
      gelipse2_3.left := 70;
      ;

      guitar2.Text := ' 0       0 0' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 5-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 26;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      // 3-1
      gelipse3_3.top  := round(30 * ratioheight);
      gelipse3_3.left := 70;

      guitar3.Text := ' 0       0 0' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 5-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 26;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      // 3-1
      gelipse4_3.top  := round(30 * ratioheight);
      gelipse4_3.left := 70;

      guitar4.Text := ' 0       0 0' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 5-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 26;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      // 3-1
      gelipse5_3.top  := round(30 * ratioheight);
      gelipse5_3.left := 70;

      guitar5.Text := ' 0       0 0' + lineend + ' ══════════  0';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin <> 1)) then
  begin
      // mi min 
    if num = 1 then
    begin
      // 5-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 26;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      gelipse1_3.Visible := False;

      guitar1.Text := ' 0     0 0 0' + lineend + ' ══════════  0';
    end
    else if num = 2 then
    begin
      // 5-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 26;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      gelipse2_3.Visible := False;

      guitar2.Text := ' 0     0 0 0' + lineend + ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 5-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 26;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      gelipse3_3.Visible := False;

      guitar3.Text := ' 0     0 0 0' + lineend + ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 5-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 26;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      gelipse4_3.Visible := False;

      guitar4.Text := ' 0     0 0 0' + lineend + ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 5-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 26;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      gelipse5_3.Visible := False;

      guitar5.Text := ' 0     0 0 0' + lineend + ' ══════════  0';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin = 1)) then
  begin
      // Fa Maj
    if num = 1 then
    begin
      // 5-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 26;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      // 3-1
      gelipse1_3.top  := round(30 * ratioheight);
      gelipse1_3.left := 70;

      guitar1.Text := '═0═══════0═0═' + lineend +
        ' ══════════  1';

    end
    else if num = 2 then
    begin
      // 5-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 26;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      // 3-1
      gelipse2_3.top  := round(30 * ratioheight);
      gelipse2_3.left := 70;
      ;

      guitar2.Text := '═0═══════0═0═' + lineend +
        ' ══════════  1';

    end
    else if num = 3 then
    begin
      // 5-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 26;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      // 3-1
      gelipse3_3.top  := round(30 * ratioheight);
      gelipse3_3.left := 70;

      guitar3.Text := '═0═══════0═0═' + lineend +
        ' ══════════  1';
    end
    else if num = 4 then
    begin
      // 5-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 26;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      // 3-1
      gelipse4_3.top  := round(30 * ratioheight);
      gelipse4_3.left := 70;

      guitar4.Text := '═0═══════0═0═' + lineend +
        ' ══════════  1';
    end
    else if num = 5 then
    begin
      // 5-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 26;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      // 3-1
      gelipse5_3.top  := round(30 * ratioheight);
      gelipse5_3.left := 70;

      guitar5.Text := '═0═══════0═0═' + lineend +
        ' ══════════  1';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin <> 1)) then
  begin
      // Fa min 
    if num = 1 then
    begin
      // 5-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 26;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      gelipse1_3.Visible := False;

      guitar1.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  1';
    end
    else if num = 2 then
    begin
      // 5-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 26;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      gelipse2_3.Visible := False;

      guitar2.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  1';

    end
    else if num = 3 then
    begin
      // 5-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 26;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      gelipse3_3.Visible := False;

      guitar3.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  1';
    end
    else if num = 4 then
    begin
      // 5-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 26;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      gelipse4_3.Visible := False;

      guitar3.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  1';
    end
    else if num = 5 then
    begin
      // 5-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 26;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      gelipse5_3.Visible := False;

      guitar5.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  1';
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin = 1)) then
  begin
      // Sol Maj
    if num = 1 then
    begin
      // 6-3
      gelipse1_1.top  := round(114 * ratioheight);
      gelipse1_1.left := 6;

      // 5-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 26;

      // 1-3
      gelipse1_3.top  := round(114 * ratioheight);
      gelipse1_3.left := 110;

      guitar1.Text := '     0 0 0   ' + lineend + ' ══════════  0';

    end
    else if num = 2 then
    begin
      // 6-3
      gelipse2_1.top  := round(114 * ratioheight);
      gelipse2_1.left := 6;

      // 5-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 26;

      // 1-3
      gelipse2_3.top  := round(114 * ratioheight);
      gelipse2_3.left := 110;
      guitar2.Text    := '     0 0 0   ' + lineend +
        ' ══════════  0';

    end
    else if num = 3 then
    begin
      // 6-3
      gelipse3_1.top  := round(114 * ratioheight);
      gelipse3_1.left := 6;

      // 5-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 26;

      // 1-3
      gelipse3_3.top  := round(114 * ratioheight);
      gelipse3_3.left := 110;
      guitar3.Text    := '     0 0 0   ' + lineend +
        ' ══════════  0';
    end
    else if num = 4 then
    begin
      // 6-3
      gelipse4_1.top  := round(114 * ratioheight);
      gelipse4_1.left := 6;

      // 5-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 26;

      // 1-3
      gelipse4_3.top  := round(114 * ratioheight);
      gelipse4_3.left := 110;
      guitar4.Text    := '     0 0 0   ' + lineend +
        ' ══════════  0';
    end
    else if num = 5 then
    begin
      // 6-3
      gelipse5_1.top  := round(114 * ratioheight);
      gelipse5_1.left := 6;

      // 5-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 26;

      // 1-3
      gelipse5_3.top  := round(114 * ratioheight);
      gelipse5_3.left := 110;
      guitar5.Text    := '     0 0 0   ' + lineend +
        ' ══════════  0';
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin <> 1)) then
  begin
      // Sol min 
    if num = 1 then
    begin
      // 5-2
      gelipse1_1.top  := round(74 * ratioheight);
      gelipse1_1.left := 26;

      // 4-2
      gelipse1_2.top  := round(74 * ratioheight);
      gelipse1_2.left := 48;

      gelipse1_3.Visible := False;

      guitar1.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  3';
    end
    else if num = 2 then
    begin
      // 5-2
      gelipse2_1.top  := round(74 * ratioheight);
      gelipse2_1.left := 26;

      // 4-2
      gelipse2_2.top  := round(74 * ratioheight);
      gelipse2_2.left := 48;

      gelipse2_3.Visible := False;

      guitar2.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  3';

    end
    else if num = 3 then
    begin
      // 5-2
      gelipse3_1.top  := round(74 * ratioheight);
      gelipse3_1.left := 26;

      // 4-2
      gelipse3_2.top  := round(74 * ratioheight);
      gelipse3_2.left := 48;

      gelipse3_3.Visible := False;

      guitar3.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  3';
    end
    else if num = 4 then
    begin
      // 5-2
      gelipse4_1.top  := round(74 * ratioheight);
      gelipse4_1.left := 26;

      // 4-2
      gelipse4_2.top  := round(74 * ratioheight);
      gelipse4_2.left := 48;

      gelipse4_3.Visible := False;

      guitar4.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  3';
    end
    else if num = 5 then
    begin
      // 5-2
      gelipse5_1.top  := round(74 * ratioheight);
      gelipse5_1.left := 26;

      // 4-2
      gelipse5_2.top  := round(74 * ratioheight);
      gelipse5_2.left := 48;

      gelipse5_3.Visible := False;

      guitar5.Text := '═0═════0═0═0═' + lineend +
        ' ══════════  3';
    end;

  end
  else if num = 1 then
  begin
    guitar1.Text       := '';
    gelipse1_1.Visible := False;
    gelipse1_2.Visible := False;
    gelipse1_3.Visible := False;
  end
  else if num = 2 then
  begin
    guitar2.Text       := '';
    gelipse2_1.Visible := False;
    gelipse2_2.Visible := False;
    gelipse2_3.Visible := False;
  end
  else if num = 3 then
  begin
    guitar3.Text       := '';
    gelipse3_1.Visible := False;
    gelipse3_2.Visible := False;
    gelipse3_3.Visible := False;
  end
  else if num = 4 then
  begin
    guitar4.Text       := '';
    gelipse4_1.Visible := False;
    gelipse4_2.Visible := False;
    gelipse4_3.Visible := False;
  end
  else if num = 5 then
  begin
    guitar5.Text       := '';
    gelipse5_1.Visible := False;
    gelipse5_2.Visible := False;
    gelipse5_3.Visible := False;
  end;

end;


procedure trandomnotefo.pianochord(num, ranchord, ismin, isseven: integer);
var
  ratioheight: double;
begin
  ratioheight := (bchord1.Height / 158);
  if num = 1 then
  begin
    elipse1_1.Visible := True;
    elipse1_2.Visible := True;
    elipse1_3.Visible := True;
  end
  else if num = 2 then
  begin
    elipse2_1.Visible := True;
    elipse2_2.Visible := True;
    elipse2_3.Visible := True;
  end
  else if num = 3 then
  begin
    elipse3_1.Visible := True;
    elipse3_2.Visible := True;
    elipse3_3.Visible := True;
  end
  else if num = 4 then
  begin
    elipse4_1.Visible := True;
    elipse4_2.Visible := True;
    elipse4_3.Visible := True;
  end
  else if num = 5 then
  begin
    elipse5_1.Visible := True;
    elipse5_2.Visible := True;
    elipse5_3.Visible := True;
  end;


  if (ranchord = 1) and (ismin = 1) then
    // La maj     
  begin
    if num = 1 then
    begin
      // la
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 136;

      // do# 2
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 201;

      // mi 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 240;
    end
    else if num = 2 then
    begin
      // la
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 136;

      // do# 2
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 201;

      // mi 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 240;
    end
    else if num = 3 then
    begin
      // la
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 136;

      // do# 2
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 201;

      // mi 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 240;
    end
    else if num = 4 then
    begin
      // la
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 136;

      // do# 2
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 201;

      // mi 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 240;
    end
    else if num = 5 then
    begin
      // la
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 136;

      // do# 2
      elipse5_2.top  := round(24 * ratioheight);
      elipse5_2.left := 201;

      // mi 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 240;
    end;

  end
  else if (ranchord = 1) and (ismin <> 1) then
    // La min   
  begin
    if num = 1 then
    begin
      // la
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 136;

      // do 2
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 188;

      // mi 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 240;
    end
    else if num = 2 then
    begin
      // la
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 136;

      // do 2
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 188;

      // mi 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 240;
    end
    else if num = 3 then
    begin
      // la
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 136;

      // do 2
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 188;

      // mi 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 240;
    end
    else if num = 4 then
    begin
      // la
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 136;

      // do 2
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 188;

      // mi 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 240;
    end
    else if num = 5 then
    begin
      // la
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 136;

      // do 2
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 188;

      // mi 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 240;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin = 1)) then
  begin
      // Si Maj
    if num = 1 then
    begin
      // fa#
      elipse1_1.top  := round(24 * ratioheight);
      elipse1_1.left := 92;

      // si
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 160;

      // ré# 2
      elipse1_3.top  := round(24 * ratioheight);
      elipse1_3.left := 228;
    end
    else if num = 2 then
    begin
      // fa#
      elipse2_1.top  := round(24 * ratioheight);
      elipse2_1.left := 92;

      // si
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 160;

      // ré# 2
      elipse2_3.top  := round(24 * ratioheight);
      elipse2_3.left := 228;
    end
    else if num = 3 then
    begin
      // fa#
      elipse3_1.top  := round(24 * ratioheight);
      elipse3_1.left := 92;

      // si
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 160;

      // ré# 2
      elipse3_3.top  := round(24 * ratioheight);
      elipse3_3.left := 228;
    end
    else if num = 4 then
    begin
      // fa#
      elipse4_1.top  := round(24 * ratioheight);
      elipse4_1.left := 92;

      // si
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 160;

      // ré# 2
      elipse4_3.top  := round(24 * ratioheight);
      elipse4_3.left := 228;
    end
    else if num = 5 then
    begin
      // fa#
      elipse5_1.top  := round(24 * ratioheight);
      elipse5_1.left := 92;

      // si
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 160;

      // ré# 2
      elipse5_3.top  := round(24 * ratioheight);
      elipse5_3.left := 228;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin <> 1)) then
  begin
      // Si min    
    if num = 1 then
    begin
      // fa#
      elipse1_1.top  := round(24 * ratioheight);
      elipse1_1.left := 92;

      // si
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 160;

      // ré 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 214;
    end
    else if num = 2 then
    begin
      // fa#
      elipse2_1.top  := round(24 * ratioheight);
      elipse2_1.left := 92;

      // si
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 160;

      // ré 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 214;
    end
    else if num = 3 then
    begin
      // fa#
      elipse3_1.top  := round(24 * ratioheight);
      elipse3_1.left := 92;

      // si
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 160;

      // ré 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 214;
    end
    else if num = 4 then
    begin
      // fa#
      elipse4_1.top  := round(24 * ratioheight);
      elipse4_1.left := 92;

      // si
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 160;

      // ré 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 214;
    end
    else if num = 5 then
    begin
      // fa#
      elipse5_1.top  := round(24 * ratioheight);
      elipse5_1.left := 92;

      // si
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 160;

      // ré 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 214;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin = 1)) then
  begin
    // do Maj

    if num = 1 then
    begin
      // do
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 0;

      // mi
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 54;

      // sol
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 108;
    end
    else if num = 2 then
    begin
      // do
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 0;

      // mi
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 54;

      // sol
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 108;
    end
    else if num = 3 then
    begin
      // do
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 0;

      // mi
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 54;

      // sol
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 108;
    end
    else if num = 4 then
    begin
      // do
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 0;

      // mi
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 54;

      // sol
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 108;
    end
    else if num = 5 then
    begin
      // do
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 0;

      // mi
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 54;

      // sol
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 108;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin <> 1)) then
  begin
      // do min
    if num = 1 then
    begin
      // do
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 0;

      // ré #
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 40;

      // sol
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 108;
    end
    else if num = 2 then
    begin
      // do
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 0;

      // ré #
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 40;

      // sol
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 108;
    end
    else if num = 3 then
    begin
      // do
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 0;

      // ré #
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 40;

      // sol
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 108;
    end
    else if num = 4 then
    begin
      // do
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 0;

      // ré #
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 40;

      // sol
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 108;
    end
    else if num = 5 then
    begin
      // do
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 0;

      // ré #
      elipse5_2.top  := round(24 * ratioheight);
      elipse5_2.left := 40;

      // sol
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 108;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin = 1)) then
  begin
    // ré Maj
    // ré
    if num = 1 then
    begin
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 28;

      // fa #
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 94;

      // la
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 134;
    end
    else if num = 2 then
    begin
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 28;

      // fa #
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 94;

      // la
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 134;
    end
    else if num = 3 then
    begin
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 28;

      // fa #
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 94;

      // la
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 134;
    end
    else if num = 4 then
    begin
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 28;

      // fa #
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 94;

      // la
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 134;
    end
    else if num = 5 then
    begin
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 28;

      // fa #
      elipse5_2.top  := round(26 * ratioheight);
      elipse5_2.left := 94;

      // la
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 134;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin <> 1)) then
  begin
      // ré min
    if num = 1 then
    begin
      // ré
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 28;

      // fa
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 80;

      // la
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 134;
    end
    else if num = 2 then
    begin
      // ré
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 28;

      // fa
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 80;

      // la
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 134;
    end
    else if num = 3 then
    begin
      // ré
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 28;

      // fa
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 80;

      // la
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 134;
    end
    else if num = 4 then
    begin
      // ré
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 28;

      // fa
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 80;

      // la
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 134;
    end
    else if num = 5 then
    begin
      // ré
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 28;

      // fa
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 80;

      // la
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 134;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin = 1)) then
  begin
      // mi Maj
    if num = 1 then
    begin
      // mi
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 54;

      // sol #
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 122;

      // si
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 162;
    end
    else if num = 2 then
    begin
      // mi
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 54;

      // sol #
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 122;

      // si
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 162;
    end
    else if num = 3 then
    begin
      // mi
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 54;

      // sol #
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 122;

      // si
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 162;
    end
    else if num = 4 then
    begin
      // mi
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 54;

      // sol #
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 122;

      // si
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 162;
    end
    else if num = 5 then
    begin
      // mi
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 54;

      // sol #
      elipse5_2.top  := round(24 * ratioheight);
      elipse5_2.left := 122;

      // si
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 162;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin <> 1)) then
  begin
    // mi min
    // mi
    if num = 1 then
    begin
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 54;

      // sol
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 108;

      // si
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 162;
    end
    else if num = 2 then
    begin
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 54;

      // sol
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 108;

      // si
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 162;
    end
    else if num = 3 then
    begin
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 54;

      // sol
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 108;

      // si
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 162;
    end
    else if num = 4 then
    begin
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 54;

      // sol
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 108;

      // si
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 162;
    end
    else if num = 5 then
    begin
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 54;

      // sol
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 108;

      // si
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 162;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin = 1)) then
  begin
      // fa Maj
    if num = 1 then
    begin
      // fa
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 80;

      // la
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 134;

      // do 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 190;
    end
    else if num = 2 then
    begin
      // fa
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 80;

      // la
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 134;

      // do 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 190;
    end
    else if num = 3 then
    begin
      // fa
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 80;

      // la
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 134;

      // do 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 190;
    end
    else if num = 4 then
    begin
      // fa
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 80;

      // la
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 134;

      // do 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 190;
    end
    else if num = 5 then
    begin
      // fa
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 80;

      // la
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 134;

      // do 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 190;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin <> 1)) then
  begin
      // fa min
    if num = 1 then
    begin
      // fa
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 80;

      // la
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 120;

      // do 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 190;
    end
    else if num = 2 then
    begin
      // fa
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 80;

      // la
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 120;

      // do 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 190;
    end
    else if num = 3 then
    begin
      // fa
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 80;

      // la
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 120;

      // do 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 190;
    end
    else if num = 4 then
    begin
      // fa
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 80;

      // la
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 120;

      // do 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 190;
    end
    else if num = 5 then
    begin
      // fa
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 80;

      // la
      elipse5_2.top  := round(24 * ratioheight);
      elipse5_2.left := 120;

      // do 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 190;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin = 1)) then
  begin
    // sol Maj
    // sol
    if num = 1 then
    begin
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 108;

      // si
      elipse1_2.top  := round(96 * ratioheight);
      elipse1_2.left := 160;

      // ré 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 218;
    end
    else if num = 2 then
    begin
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 108;

      // si
      elipse2_2.top  := round(96 * ratioheight);
      elipse2_2.left := 160;

      // ré 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 218;
    end
    else if num = 3 then
    begin
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 108;

      // si
      elipse3_2.top  := round(96 * ratioheight);
      elipse3_2.left := 160;

      // ré 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 218;
    end
    else if num = 4 then
    begin
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 108;

      // si
      elipse4_2.top  := round(96 * ratioheight);
      elipse4_2.left := 160;

      // ré 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 218;
    end
    else if num = 5 then
    begin
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 108;

      // si
      elipse5_2.top  := round(96 * ratioheight);
      elipse5_2.left := 160;

      // ré 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 218;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin <> 1)) then
  begin
      // sol min
    if num = 1 then
    begin
      // sol
      elipse1_1.top  := round(96 * ratioheight);
      elipse1_1.left := 108;

      // la#
      elipse1_2.top  := round(24 * ratioheight);
      elipse1_2.left := 148;

      // ré 2
      elipse1_3.top  := round(96 * ratioheight);
      elipse1_3.left := 218;
    end
    else if num = 2 then
    begin
      // sol
      elipse2_1.top  := round(96 * ratioheight);
      elipse2_1.left := 108;

      // la#
      elipse2_2.top  := round(24 * ratioheight);
      elipse2_2.left := 148;

      // ré 2
      elipse2_3.top  := round(96 * ratioheight);
      elipse2_3.left := 218;
    end
    else if num = 3 then
    begin
      // sol
      elipse3_1.top  := round(96 * ratioheight);
      elipse3_1.left := 108;

      // la#
      elipse3_2.top  := round(24 * ratioheight);
      elipse3_2.left := 148;

      // ré 2
      elipse3_3.top  := round(96 * ratioheight);
      elipse3_3.left := 218;
    end
    else if num = 4 then
    begin
      // sol
      elipse4_1.top  := round(96 * ratioheight);
      elipse4_1.left := 108;

      // la#
      elipse4_2.top  := round(24 * ratioheight);
      elipse4_2.left := 148;

      // ré 2
      elipse4_3.top  := round(96 * ratioheight);
      elipse4_3.left := 218;
    end
    else if num = 5 then
    begin
      // sol
      elipse5_1.top  := round(96 * ratioheight);
      elipse5_1.left := 108;

      // la#
      elipse5_2.top  := round(24 * ratioheight);
      elipse5_2.left := 148;

      // ré 2
      elipse5_3.top  := round(96 * ratioheight);
      elipse5_3.left := 218;
    end;
  end
  else if num = 1 then
  begin
    elipse1_1.Visible := False;
    elipse1_2.Visible := False;
    elipse1_3.Visible := False;
  end
  else if num = 2 then
  begin
    elipse2_1.Visible := False;
    elipse2_2.Visible := False;
    elipse2_3.Visible := False;
  end
  else if num = 3 then
  begin
    elipse3_1.Visible := False;
    elipse3_2.Visible := False;
    elipse3_3.Visible := False;
  end
  else if num = 4 then
  begin
    elipse4_1.Visible := False;
    elipse4_2.Visible := False;
    elipse4_3.Visible := False;
  end
  else if num = 5 then
  begin
    elipse5_1.Visible := False;
    elipse5_2.Visible := False;
    elipse5_3.Visible := False;
  end;

end;

procedure trandomnotefo.basschord(num, ranchord, ismin, isseven: integer);
var
  ratioheight: double;
begin
  ratioheight := (bchord1.Height / 158);

  if num = 1 then
    belipse1_1.Visible := True// belipse1_2.visible := true;
  // belipse1_3.visible := true;  
  else if num = 2 then
    belipse2_1.Visible := True// belipse2_2.visible := true;
  // belipse2_3.visible := true;  
  else if num = 3 then
    belipse3_1.Visible := True// belipse3_2.visible := true;
  // belipse3_3.visible := true; 
  else if num = 4 then
    belipse4_1.Visible := True
  else if num = 5 then
    belipse5_1.Visible := True;

  if (ranchord = 1) and (ismin = 1) then
    // La maj     
  begin
    if num = 1 then
    begin
      // la
      belipse1_1.top  := round(130 * ratioheight);
      belipse1_1.left := 10;

      // do# 2
      belipse1_2.top  := 24;
      belipse1_2.left := 201;

      // mi 2
      belipse1_3.top  := 96;
      belipse1_3.left := 240;
    end
    else if num = 2 then
    begin
      // la
      belipse2_1.top  := round(130 * ratioheight);
      belipse2_1.left := 10;

      // do# 2
      belipse2_2.top  := 24;
      belipse2_2.left := 201;

      // mi 2
      belipse2_3.top  := 96;
      belipse2_3.left := 240;
    end
    else if num = 3 then
    begin
      // la
      belipse3_1.top  := round(130 * ratioheight);
      belipse3_1.left := 10;

      // do# 2
      belipse3_2.top  := 24;
      belipse3_2.left := 201;

      // mi 2
      belipse3_3.top  := 96;
      belipse3_3.left := 240;
    end
    else if num = 4 then
    begin
      // la
      belipse4_1.top  := round(130 * ratioheight);
      belipse4_1.left := 10;

      // do# 2
      belipse4_2.top  := 24;
      belipse4_2.left := 201;

      // mi 2
      belipse4_3.top  := 96;
      belipse4_3.left := 240;
    end
    else if num = 5 then
    begin
      // la
      belipse5_1.top  := round(130 * ratioheight);
      belipse5_1.left := 10;

      // do# 2
      belipse5_2.top  := 24;
      belipse5_2.left := 201;

      // mi 2
      belipse5_3.top  := 96;
      belipse5_3.left := 240;
    end;

  end
  else if (ranchord = 1) and (ismin <> 1) then
    // La min   
  begin
    if num = 1 then
    begin
      // la
      belipse1_1.top  := round(130 * ratioheight);
      belipse1_1.left := 10;

      // do 2
      belipse1_2.top  := 96;
      belipse1_2.left := 188;

      // mi 2
      belipse1_3.top  := 96;
      belipse1_3.left := 240;
    end
    else if num = 2 then
    begin
      // la
      belipse2_1.top  := round(130 * ratioheight);
      belipse2_1.left := 10;

      // do 2
      belipse2_2.top  := 96;
      belipse2_2.left := 188;

      // mi 2
      belipse2_3.top  := 96;
      belipse2_3.left := 240;
    end
    else if num = 3 then
    begin
      // la
      belipse3_1.top  := round(130 * ratioheight);
      belipse3_1.left := 10;

      // do 2
      belipse3_2.top  := 96;
      belipse3_2.left := 188;

      // mi 2
      belipse3_3.top  := 96;
      belipse3_3.left := 240;
    end
    else if num = 4 then
    begin
      // la
      belipse4_1.top  := round(130 * ratioheight);
      belipse4_1.left := 10;

      // do 2
      belipse4_2.top  := 96;
      belipse4_2.left := 188;

      // mi 2
      belipse4_3.top  := 96;
      belipse4_3.left := 240;
    end
    else if num = 5 then
    begin
      // la
      belipse5_1.top  := round(130 * ratioheight);
      belipse5_1.left := 10;

      // do 2
      belipse5_2.top  := 96;
      belipse5_2.left := 188;

      // mi 2
      belipse5_3.top  := 96;
      belipse5_3.left := 240;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin = 1)) then
  begin
      // Si Maj
    if num = 1 then
    begin
      // fa#
      belipse1_1.top  := round(42 * ratioheight);
      belipse1_1.left := 38;

      // si
      belipse1_2.top  := 96;
      belipse1_2.left := 160;

      // ré# 2
      belipse1_3.top  := 24;
      belipse1_3.left := 228;
    end
    else if num = 2 then
    begin
      // fa#
      belipse2_1.top  := round(42 * ratioheight);
      belipse2_1.left := 38;

      // si
      belipse2_2.top  := 96;
      belipse2_2.left := 160;

      // ré# 2
      belipse2_3.top  := 24;
      belipse2_3.left := 228;
    end
    else if num = 3 then
    begin
      // fa#
      belipse3_1.top  := round(42 * ratioheight);
      belipse3_1.left := 38;

      // si
      belipse3_2.top  := 96;
      belipse3_2.left := 160;

      // ré# 2
      belipse3_3.top  := 24;
      belipse3_3.left := 228;
    end
    else if num = 4 then
    begin
      // fa#
      belipse4_1.top  := round(42 * ratioheight);
      belipse4_1.left := 38;

      // si
      belipse4_2.top  := 96;
      belipse4_2.left := 160;

      // ré# 2
      belipse4_3.top  := 24;
      belipse4_3.left := 228;
    end
    else if num = 5 then
    begin
      // fa#
      belipse5_1.top  := round(42 * ratioheight);
      belipse5_1.left := 38;

      // si
      belipse5_2.top  := 96;
      belipse5_2.left := 160;

      // ré# 2
      belipse5_3.top  := 24;
      belipse5_3.left := 228;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 2) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 3) and (ismin <> 1)) then
  begin
      // Si min    
    if num = 1 then
    begin
      // fa#
      belipse1_1.top  := round(42 * ratioheight);
      belipse1_1.left := 38;

      // si
      belipse1_2.top  := 96;
      belipse1_2.left := 160;

      // ré 2
      belipse1_3.top  := 96;
      belipse1_3.left := 214;
    end
    else if num = 2 then
    begin
      // fa#
      belipse2_1.top  := round(42 * ratioheight);
      belipse2_1.left := 38;

      // si
      belipse2_2.top  := 96;
      belipse2_2.left := 160;

      // ré 2
      belipse2_3.top  := 96;
      belipse2_3.left := 214;
    end
    else if num = 3 then
    begin
      // fa#
      belipse3_1.top  := round(42 * ratioheight);
      belipse3_1.left := 38;

      // si
      belipse3_2.top  := 96;
      belipse3_2.left := 160;

      // ré 2
      belipse3_3.top  := 96;
      belipse3_3.left := 214;
    end
    else if num = 4 then
    begin
      // fa#
      belipse4_1.top  := round(42 * ratioheight);
      belipse4_1.left := 38;

      // si
      belipse4_2.top  := 96;
      belipse4_2.left := 160;

      // ré 2
      belipse4_3.top  := 96;
      belipse4_3.left := 214;
    end
    else if num = 5 then
    begin
      // fa#
      belipse5_1.top  := round(42 * ratioheight);
      belipse5_1.left := 38;

      // si
      belipse5_2.top  := 96;
      belipse5_2.left := 160;

      // ré 2
      belipse5_3.top  := 96;
      belipse5_3.left := 214;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin = 1)) then
  begin
    // do Maj

    if num = 1 then
    begin
      // do
      belipse1_1.top  := round(74 * ratioheight);
      belipse1_1.left := 38;

      // mi
      belipse1_2.top  := 96;
      belipse1_2.left := 54;

      // sol
      belipse1_3.top  := 96;
      belipse1_3.left := 108;
    end
    else if num = 2 then
    begin
      // do
      belipse2_1.top  := round(74 * ratioheight);
      belipse2_1.left := 38;

      // mi
      belipse2_2.top  := 96;
      belipse2_2.left := 54;

      // sol
      belipse2_3.top  := 96;
      belipse2_3.left := 108;
    end
    else if num = 3 then
    begin
      // do
      belipse3_1.top  := round(74 * ratioheight);
      belipse3_1.left := 38;

      // mi
      belipse3_2.top  := 96;
      belipse3_2.left := 54;

      // sol
      belipse3_3.top  := 96;
      belipse3_3.left := 108;
    end
    else if num = 4 then
    begin
      // do
      belipse4_1.top  := round(74 * ratioheight);
      belipse4_1.left := 38;

      // mi
      belipse4_2.top  := 96;
      belipse4_2.left := 54;

      // sol
      belipse4_3.top  := 96;
      belipse4_3.left := 108;
    end
    else if num = 5 then
    begin
      // do
      belipse5_1.top  := round(74 * ratioheight);
      belipse5_1.left := 38;

      // mi
      belipse5_2.top  := 96;
      belipse5_2.left := 54;

      // sol
      belipse5_3.top  := 96;
      belipse5_3.left := 108;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 3) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 4) and (ismin <> 1)) then
  begin
      // do min
    if num = 1 then
    begin
      // do
      belipse1_1.top  := round(74 * ratioheight);
      belipse1_1.left := 38;

      // ré #
      belipse1_2.top  := 24;
      belipse1_2.left := 40;

      // sol
      belipse1_3.top  := 96;
      belipse1_3.left := 108;
    end
    else if num = 2 then
    begin
      // do
      belipse2_1.top  := round(74 * ratioheight);
      belipse2_1.left := 38;

      // ré #
      belipse2_2.top  := 24;
      belipse2_2.left := 40;

      // sol
      belipse2_3.top  := 96;
      belipse2_3.left := 108;
    end
    else if num = 3 then
    begin
      // do
      belipse3_1.top  := round(74 * ratioheight);
      belipse3_1.left := 38;

      // ré #
      belipse3_2.top  := 24;
      belipse3_2.left := 40;

      // sol
      belipse3_3.top  := 96;
      belipse3_3.left := 108;
    end
    else if num = 4 then
    begin
      // do
      belipse4_1.top  := round(74 * ratioheight);
      belipse4_1.left := 38;

      // ré #
      belipse4_2.top  := 24;
      belipse4_2.left := 40;

      // sol
      belipse4_3.top  := 96;
      belipse4_3.left := 108;
    end
    else if num = 5 then
    begin
      // do
      belipse5_1.top  := round(74 * ratioheight);
      belipse5_1.left := 38;

      // ré #
      belipse5_2.top  := 24;
      belipse5_2.left := 40;

      // sol
      belipse5_3.top  := 96;
      belipse5_3.left := 108;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin = 1)) then
  begin
    // ré Maj
    // ré
    if num = 1 then
    begin
      belipse1_1.top  := round(128 * ratioheight);
      belipse1_1.left := 36;

      // fa #
      belipse1_2.top  := 26;
      belipse1_2.left := 94;

      // la
      belipse1_3.top  := 96;
      belipse1_3.left := 134;
    end
    else if num = 2 then
    begin
      belipse2_1.top  := round(128 * ratioheight);
      belipse2_1.left := 36;

      // fa #
      belipse2_2.top  := 26;
      belipse2_2.left := 94;

      // la
      belipse2_3.top  := 96;
      belipse2_3.left := 134;
    end
    else if num = 3 then
    begin
      belipse3_1.top  := round(128 * ratioheight);
      belipse3_1.left := 36;

      // fa #
      belipse3_2.top  := 26;
      belipse3_2.left := 94;

      // la
      belipse3_3.top  := 96;
      belipse3_3.left := 134;
    end
    else if num = 4 then
    begin
      belipse4_1.top  := round(128 * ratioheight);
      belipse4_1.left := 36;

      // fa #
      belipse4_2.top  := 26;
      belipse4_2.left := 94;

      // la
      belipse4_3.top  := 96;
      belipse4_3.left := 134;
    end
    else if num = 5 then
    begin
      belipse5_1.top  := round(128 * ratioheight);
      belipse5_1.left := 36;

      // fa #
      belipse5_2.top  := 26;
      belipse5_2.left := 94;

      // la
      belipse5_3.top  := 96;
      belipse5_3.left := 134;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 4) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 6) and (ismin <> 1)) then
  begin
      // ré min
    if num = 1 then
    begin
      // ré
      belipse1_1.top  := round(128 * ratioheight);
      belipse1_1.left := 36;

      // fa
      belipse1_2.top  := 96;
      belipse1_2.left := 80;

      // la
      belipse1_3.top  := 96;
      belipse1_3.left := 134;
    end
    else if num = 2 then
    begin
      // ré
      belipse2_1.top  := round(128 * ratioheight);
      belipse2_1.left := 36;

      // fa
      belipse2_2.top  := 96;
      belipse2_2.left := 80;

      // la
      belipse2_3.top  := 96;
      belipse2_3.left := 134;
    end
    else if num = 3 then
    begin
      // ré
      belipse3_1.top  := round(128 * ratioheight);
      belipse3_1.left := 36;

      // fa
      belipse3_2.top  := 96;
      belipse3_2.left := 80;

      // la
      belipse3_3.top  := 96;
      belipse3_3.left := 134;
    end
    else if num = 4 then
    begin
      // ré
      belipse4_1.top  := round(128 * ratioheight);
      belipse4_1.left := 36;

      // fa
      belipse4_2.top  := 96;
      belipse4_2.left := 80;

      // la
      belipse4_3.top  := 96;
      belipse4_3.left := 134;
    end
    else if num = 5 then
    begin
      // ré
      belipse5_1.top  := round(128 * ratioheight);
      belipse5_1.left := 36;

      // fa
      belipse5_2.top  := 96;
      belipse5_2.left := 80;

      // la
      belipse5_3.top  := 96;
      belipse5_3.left := 134;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin = 1)) then
  begin
      // mi Maj
    if num = 1 then
    begin
      // mi
      belipse1_1.top  := round(42 * ratioheight);
      belipse1_1.left := 68;

      // sol #
      belipse1_2.top  := 24;
      belipse1_2.left := 122;

      // si
      belipse1_3.top  := 96;
      belipse1_3.left := 162;
    end
    else if num = 2 then
    begin
      // mi
      belipse2_1.top  := round(42 * ratioheight);
      belipse2_1.left := 68;

      // sol #
      belipse2_2.top  := 24;
      belipse2_2.left := 122;

      // si
      belipse2_3.top  := 96;
      belipse2_3.left := 162;
    end
    else if num = 3 then
    begin
      // mi
      belipse3_1.top  := round(42 * ratioheight);
      belipse3_1.left := 68;

      // sol #
      belipse3_2.top  := 24;
      belipse3_2.left := 122;

      // si
      belipse3_3.top  := 96;
      belipse3_3.left := 162;
    end
    else if num = 4 then
    begin
      // mi
      belipse4_1.top  := round(42 * ratioheight);
      belipse4_1.left := 68;

      // sol #
      belipse4_2.top  := 24;
      belipse4_2.left := 122;

      // si
      belipse4_3.top  := 96;
      belipse4_3.left := 162;
    end
    else if num = 5 then
    begin
      // mi
      belipse5_1.top  := round(42 * ratioheight);
      belipse5_1.left := 68;

      // sol #
      belipse5_2.top  := 24;
      belipse5_2.left := 122;

      // si
      belipse5_3.top  := 96;
      belipse5_3.left := 162;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 5) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 8) and (ismin <> 1)) then
  begin
    // mi min
    // mi
    if num = 1 then
    begin
      belipse1_1.top  := round(42 * ratioheight);
      belipse1_1.left := 68;

      // sol
      belipse1_2.top  := 96;
      belipse1_2.left := 108;

      // si
      belipse1_3.top  := 96;
      belipse1_3.left := 162;
    end
    else if num = 2 then
    begin
      belipse2_1.top  := round(42 * ratioheight);
      belipse2_1.left := 68;

      // sol
      belipse2_2.top  := 96;
      belipse2_2.left := 108;

      // si
      belipse2_3.top  := 96;
      belipse2_3.left := 162;
    end
    else if num = 3 then
    begin
      belipse3_1.top  := round(42 * ratioheight);
      belipse3_1.left := 68;

      // sol
      belipse3_2.top  := 96;
      belipse3_2.left := 108;

      // si
      belipse3_3.top  := 96;
      belipse3_3.left := 162;
    end
    else if num = 4 then
    begin
      belipse4_1.top  := round(42 * ratioheight);
      belipse4_1.left := 68;

      // sol
      belipse4_2.top  := 96;
      belipse4_2.left := 108;

      // si
      belipse4_3.top  := 96;
      belipse4_3.left := 162;
    end
    else if num = 5 then
    begin
      belipse5_1.top  := round(42 * ratioheight);
      belipse5_1.left := 68;

      // sol
      belipse5_2.top  := 96;
      belipse5_2.left := 108;

      // si
      belipse5_3.top  := 96;
      belipse5_3.left := 162;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin = 1)) then
  begin
      // fa Maj
    if num = 1 then
    begin
      // fa
      belipse1_1.top  := round(8 * ratioheight);
      belipse1_1.left := 12;

      // la
      belipse1_2.top  := 96;
      belipse1_2.left := 134;

      // do 2
      belipse1_3.top  := 96;
      belipse1_3.left := 190;
    end
    else if num = 2 then
    begin
      // fa
      belipse2_1.top  := round(8 * ratioheight);
      belipse2_1.left := 12;

      // la
      belipse2_2.top  := 96;
      belipse2_2.left := 134;

      // do 2
      belipse2_3.top  := 96;
      belipse2_3.left := 190;
    end
    else if num = 3 then
    begin
      // fa
      belipse3_1.top  := round(8 * ratioheight);
      belipse3_1.left := 12;

      // la
      belipse3_2.top  := 96;
      belipse3_2.left := 134;

      // do 2
      belipse3_3.top  := 96;
      belipse3_3.left := 190;
    end
    else if num = 4 then
    begin
      // fa
      belipse4_1.top  := round(8 * ratioheight);
      belipse4_1.left := 12;

      // la
      belipse4_2.top  := 96;
      belipse4_2.left := 134;

      // do 2
      belipse4_3.top  := 96;
      belipse4_3.left := 190;
    end
    else if num = 5 then
    begin
      // fa
      belipse5_1.top  := round(8 * ratioheight);
      belipse5_1.left := 12;

      // la
      belipse5_2.top  := 96;
      belipse5_2.left := 134;

      // do 2
      belipse5_3.top  := 96;
      belipse5_3.left := 190;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 6) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 9) and (ismin <> 1)) then
  begin
      // fa min
    if num = 1 then
    begin
      // fa
      belipse1_1.top  := round(8 * ratioheight);
      belipse1_1.left := 12;

      // la
      belipse1_2.top  := 24;
      belipse1_2.left := 120;

      // do 2
      belipse1_3.top  := 96;
      belipse1_3.left := 190;
    end
    else if num = 2 then
    begin
      // fa
      belipse2_1.top  := round(8 * ratioheight);
      belipse2_1.left := 12;

      // la
      belipse2_2.top  := 24;
      belipse2_2.left := 120;

      // do 2
      belipse2_3.top  := 96;
      belipse2_3.left := 190;
    end
    else if num = 3 then
    begin
      // fa
      belipse3_1.top  := round(8 * ratioheight);
      belipse3_1.left := 12;

      // la
      belipse3_2.top  := 24;
      belipse3_2.left := 120;

      // do 2
      belipse3_3.top  := 96;
      belipse3_3.left := 190;
    end
    else if num = 4 then
    begin
      // fa
      belipse4_1.top  := round(8 * ratioheight);
      belipse4_1.left := 12;

      // la
      belipse4_2.top  := 24;
      belipse4_2.left := 120;

      // do 2
      belipse4_3.top  := 96;
      belipse4_3.left := 190;
    end
    else if num = 5 then
    begin
      // fa
      belipse5_1.top  := round(8 * ratioheight);
      belipse5_1.left := 12;

      // la
      belipse5_2.top  := 24;
      belipse5_2.left := 120;

      // do 2
      belipse5_3.top  := 96;
      belipse5_3.left := 190;
    end;
  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin = 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin = 1)) then
  begin
    // sol Maj
    // sol
    if num = 1 then
    begin
      belipse1_1.top  := round(74 * ratioheight);
      belipse1_1.left := 10;

      // si
      belipse1_2.top  := 96;
      belipse1_2.left := 160;

      // ré 2
      belipse1_3.top  := 96;
      belipse1_3.left := 218;
    end
    else if num = 2 then
    begin
      belipse2_1.top  := round(74 * ratioheight);
      belipse2_1.left := 10;

      // si
      belipse2_2.top  := 96;
      belipse2_2.left := 160;

      // ré 2
      belipse2_3.top  := 96;
      belipse2_3.left := 218;
    end
    else if num = 3 then
    begin
      belipse3_1.top  := round(74 * ratioheight);
      belipse3_1.left := 10;

      // si
      belipse3_2.top  := 96;
      belipse3_2.left := 160;

      // ré 2
      belipse3_3.top  := 96;
      belipse3_3.left := 218;
    end
    else if num = 4 then
    begin
      belipse4_1.top  := round(74 * ratioheight);
      belipse4_1.left := 10;

      // si
      belipse4_2.top  := 96;
      belipse4_2.left := 160;

      // ré 2
      belipse4_3.top  := 96;
      belipse4_3.left := 218;
    end
    else if num = 5 then
    begin
      belipse5_1.top  := round(74 * ratioheight);
      belipse5_1.left := 10;

      // si
      belipse5_2.top  := 96;
      belipse5_2.left := 160;

      // ré 2
      belipse5_3.top  := 96;
      belipse5_3.left := 218;
    end;

  end
  else if ((withsharp.Value = False) and (ranchord = 7) and (ismin <> 1)) or
    ((withsharp.Value = True) and (ranchord = 11) and (ismin <> 1)) then
  begin
      // sol min
    if num = 1 then
    begin
      // sol
      belipse1_1.top  := round(74 * ratioheight);
      belipse1_1.left := 10;

      // la#
      belipse1_2.top  := 24;
      belipse1_2.left := 148;

      // ré 2
      belipse1_3.top  := 96;
      belipse1_3.left := 218;
    end
    else if num = 2 then
    begin
      // sol
      belipse2_1.top  := round(74 * ratioheight);
      belipse2_1.left := 10;

      // la#
      belipse2_2.top  := 24;
      belipse2_2.left := 148;

      // ré 2
      belipse2_3.top  := 96;
      belipse2_3.left := 218;
    end
    else if num = 3 then
    begin
      // sol
      belipse3_1.top  := round(74 * ratioheight);
      belipse3_1.left := 10;

      // la#
      belipse3_2.top  := 24;
      belipse3_2.left := 148;

      // ré 2
      belipse3_3.top  := 96;
      belipse3_3.left := 218;
    end
    else if num = 4 then
    begin
      // sol
      belipse4_1.top  := round(74 * ratioheight);
      belipse4_1.left := 10;

      // la#
      belipse4_2.top  := 24;
      belipse4_2.left := 148;

      // ré 2
      belipse4_3.top  := 96;
      belipse4_3.left := 218;
    end
    else if num = 5 then
    begin
      // sol
      belipse5_1.top  := round(74 * ratioheight);
      belipse5_1.left := 10;

      // la#
      belipse5_2.top  := 24;
      belipse5_2.left := 148;

      // ré 2
      belipse5_3.top  := 96;
      belipse5_3.left := 218;
    end;
  end
  else if num = 1 then
  begin
    belipse1_1.Visible := False;
    belipse1_2.Visible := False;
    belipse1_3.Visible := False;
  end
  else if num = 2 then
  begin
    belipse2_1.Visible := False;
    belipse2_2.Visible := False;
    belipse2_3.Visible := False;
  end
  else if num = 3 then
  begin
    belipse3_1.Visible := False;
    belipse3_2.Visible := False;
    belipse3_3.Visible := False;
  end
  else if num = 4 then
  begin
    belipse4_1.Visible := False;
    belipse4_2.Visible := False;
    belipse4_3.Visible := False;
  end
  else if num = 5 then
  begin
    belipse5_1.Visible := False;
    belipse5_2.Visible := False;
    belipse5_3.Visible := False;
  end;
end;

procedure trandomnotefo.dorandomchordbut(const Sender: TObject);
begin
  if blocked = 0 then
  begin
    blocked := 1;
    dorandomchord(Sender);

    if bosound.Value then
      playrandomchords(TButton(Sender).tag - 1);
    application.ProcessMessages;
    blocked := 0;
  end;
end;

procedure trandomnotefo.dorandomchord(const Sender: TObject);
var
  str2, str3: msestring;
  ismin, isseven, x, ranchord: integer;
  isminstr, issevenstr: msestring;
begin
  refreshform(Sender);
  x := 0;

  if Sender is TButton then
  begin
    while x < 50 do
    begin

      if (boolmajor.Value) and (boolminor.Value) then

        ismin := Random(2)
      else
      if (boolmajor.Value) and (boolminor.Value = False) then
        ismin := 1
      else
      if (boolmajor.Value = False) and (boolminor.Value) then
        ismin := 0
      else
        ismin := 1;

      if ismin = 1 then
      begin
        isminstr := '';
        str3     := 'Major';
      end
      else
      begin
        isminstr := 'm';
        str3     := 'minor';
      end;

      if (bool7th.Value) then

        isseven := Random(2)
      else
        isseven := 0;

      // isseven := 0 ;

      if isseven = 1 then
        issevenstr := '7'
      else
        issevenstr := '';


      str3 := lineend + str3 + ' ' + issevenstr;

      if withsharp.Value = False then
      begin
        ranchord := Random(7) + 1;
        if ranchord = 1 then
          str2   := 'A / La' + str3
        else if ranchord = 2 then
          str2   := 'B / Si' + str3
        else if ranchord = 3 then
          str2   := 'C / Do' + str3
        else if ranchord = 4 then
          str2   := 'D / Ré' + str3
        else if ranchord = 5 then
          str2   := 'E / Mi' + str3
        else if ranchord = 6 then
          str2   := 'F / Fa' + str3
        else if ranchord = 7 then
          str2   := 'G / Sol' + str3;

      end
      else
      begin
        ranchord := Random(12) + 1;
        if ranchord = 1 then
          str2   := 'A / La' + str3
        else if ranchord = 2 then
          str2   := 'A# / La#' + str3
        else if ranchord = 3 then
          str2   := 'B / Si' + str3
        else if ranchord = 4 then
          str2   := 'C / Do' + str3
        else if ranchord = 5 then
          str2   := 'C# / Do#' + str3
        else if ranchord = 6 then
          str2   := 'D / Ré' + str3
        else if ranchord = 7 then
          str2   := 'D# / Ré#' + str3
        else if ranchord = 8 then
          str2   := 'E / Mi' + str3
        else if ranchord = 9 then
          str2   := 'F / Fa' + str3
        else if ranchord = 10 then
          str2   := 'F# / Fa#' + str3
        else if ranchord = 11 then
          str2   := 'G / Sol' + str3
        else if ranchord = 12 then
          str2   := 'G# / Sol#' + str3;
      end;

      if ((Sender is TButton) and (TButton(Sender).tag = 0)) then
      begin
        if chordran = 1 then
        begin
          chord1.Caption   := str2;
          chord1drop.Value := str2;
          chordmem1        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if chordran = 2 then
        begin
          chord2.Caption   := str2;
          chord2drop.Value := str2;
          chordmem2        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if chordran = 3 then
        begin
          chord3.Caption   := str2;
          chord3drop.Value := str2;
          chordmem3        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if chordran = 4 then
        begin
          chord4.Caption   := str2;
          chord4drop.Value := str2;
          chordmem4        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if chordran = 5 then
        begin
          chord5.Caption   := str2;
          chord5drop.Value := str2;
          chordmem5        := copy(str2, 1, 1) + isminstr + issevenstr;
        end;

        if (x = 49) then
        begin
          pianochord(chordran, ranchord, ismin, isseven);
          guitarchord(chordran, ranchord, ismin, isseven);
          basschord(chordran, ranchord, ismin, isseven);
          refreshform(Sender);
        end;
      end
      else
      begin
        if (TButton(Sender).tag = 1) then
        begin
          chord1.Caption   := str2;
          chord1drop.Value := str2;
          chordmem1        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if (TButton(Sender).tag = 2) then
        begin
          chord2.Caption   := str2;
          chord2drop.Value := str2;
          chordmem2        := copy(str2, 1, 1) + isminstr + issevenstr;
        end
        else if (TButton(Sender).tag = 3) then
        begin
          chordmem3        := copy(str2, 1, 1) + isminstr + issevenstr;
          chord3.Caption   := str2;
          chord3drop.Value := str2;
        end
        else if TButton(Sender).tag = 4 then
        begin
          chordmem4        := copy(str2, 1, 1) + isminstr + issevenstr;
          chord4.Caption   := str2;
          chord4drop.Value := str2;
        end
        else if TButton(Sender).tag = 5 then
        begin
          chordmem5        := copy(str2, 1, 1) + isminstr + issevenstr;
          chord5.Caption   := str2;
          chord5drop.Value := str2;
        end;

        if (x = 49) then
        begin
          pianochord(TButton(Sender).tag, ranchord, ismin, isseven);
          guitarchord(TButton(Sender).tag, ranchord, ismin, isseven);
          basschord(TButton(Sender).tag, ranchord, ismin, isseven);
          refreshform(Sender);
        end;
      end;

      Inc(x);
      application.ProcessMessages;
      sleep(20);
    end;

  end
  else // drop box

  if (Sender is tdropdownlistedit) then
  begin
    if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'A' then
      ranchord := 1
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'B' then
      ranchord := 2
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'C' then
      ranchord := 3
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'D' then
      ranchord := 4
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'E' then
      ranchord := 5
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'F' then
      ranchord := 6
    else if copy(tdropdownlistedit(Sender).Value, 1, 1) = 'G' then
      ranchord := 7;

    if System.Pos('Major', tdropdownlistedit(Sender).Value) > 0 then
    begin
      isminstr := '';
      ismin    := 1;
    end
    else
    begin
      isminstr := 'm';
      ismin    := 0;
    end;

    if (tdropdownlistedit(Sender).tag = 1) then
      chordmem1 := copy(tdropdownlistedit(Sender).Value, 1, 1) + isminstr
    else if (tdropdownlistedit(Sender).tag = 2) then
      chordmem2 := copy(tdropdownlistedit(Sender).Value, 1, 1) + isminstr
    else if (tdropdownlistedit(Sender).tag = 3) then
      chordmem3 := copy(tdropdownlistedit(Sender).Value, 1, 1) + isminstr
    else if (tdropdownlistedit(Sender).tag = 4) then
      chordmem4 := copy(tdropdownlistedit(Sender).Value, 1, 1) + isminstr
    else if (tdropdownlistedit(Sender).tag = 5) then
      chordmem5 := copy(tdropdownlistedit(Sender).Value, 1, 1) + isminstr;


    application.ProcessMessages;
    pianochord(tdropdownlistedit(Sender).tag, ranchord, ismin, 0);
    guitarchord(tdropdownlistedit(Sender).tag, ranchord, ismin, 0);
    basschord(tdropdownlistedit(Sender).tag, ranchord, ismin, 0);
    refreshform(Sender);
  end;

end;

procedure trandomnotefo.oncreatedev(const Sender: TObject);
begin
  randomize;


  //tstringdisp1.text := 'Los acordes de la suerte'  + 

  //lineend + lineend +    '_____________________' + lineending + lineending +  lineending + 'The chords of chance';
  // Visible := False;
  keyb2.bitmap    := keyb1.bitmap;
  keyb3.bitmap    := keyb1.bitmap;
  keyb4.bitmap    := keyb1.bitmap;
  keyb5.bitmap    := keyb1.bitmap;
  timage8.bitmap  := timage1.bitmap;
  timage12.bitmap := timage1.bitmap;
  timage9.bitmap  := timage1.bitmap;
  timage23.bitmap := timage1.bitmap;
  timage6.bitmap  := timage2.bitmap;
  timage11.bitmap := timage2.bitmap;

  timage15.bitmap := timage2.bitmap;
  timage27.bitmap := timage2.bitmap;

  elipse1_2.bitmap := elipse1_1.bitmap;
  elipse1_3.bitmap := elipse1_1.bitmap;
  elipse2_1.bitmap := elipse1_1.bitmap;
  elipse2_2.bitmap := elipse1_1.bitmap;
  elipse2_3.bitmap := elipse1_1.bitmap;
  elipse3_1.bitmap := elipse1_1.bitmap;
  elipse3_2.bitmap := elipse1_1.bitmap;
  elipse3_3.bitmap := elipse1_1.bitmap;
  elipse4_1.bitmap := elipse1_1.bitmap;
  elipse4_2.bitmap := elipse1_1.bitmap;
  elipse4_3.bitmap := elipse1_1.bitmap;
  elipse5_1.bitmap := elipse1_1.bitmap;
  elipse5_2.bitmap := elipse1_1.bitmap;
  elipse5_3.bitmap := elipse1_1.bitmap;

  gelipse1_2.bitmap := gelipse1_1.bitmap;
  gelipse1_3.bitmap := gelipse1_1.bitmap;
  gelipse2_1.bitmap := gelipse1_1.bitmap;
  gelipse2_2.bitmap := gelipse1_1.bitmap;
  gelipse2_3.bitmap := gelipse1_1.bitmap;
  gelipse3_1.bitmap := gelipse1_1.bitmap;
  gelipse3_2.bitmap := gelipse1_1.bitmap;
  gelipse3_3.bitmap := gelipse1_1.bitmap;
  gelipse4_1.bitmap := gelipse1_1.bitmap;
  gelipse4_2.bitmap := gelipse1_1.bitmap;
  gelipse4_3.bitmap := gelipse1_1.bitmap;
  gelipse5_1.bitmap := gelipse1_1.bitmap;
  gelipse5_2.bitmap := gelipse1_1.bitmap;
  gelipse5_3.bitmap := gelipse1_1.bitmap;


  belipse1_1.bitmap := gelipse1_1.bitmap;
  // belipse1_2.bitmap :=  gelipse1_1.bitmap;
  // belipse1_3.bitmap :=  gelipse1_1.bitmap;
  belipse2_1.bitmap := gelipse1_1.bitmap;
  // belipse2_2.bitmap :=  gelipse1_1.bitmap;
  // belipse2_3.bitmap :=  gelipse1_1.bitmap;
  belipse3_1.bitmap := gelipse1_1.bitmap;
  // belipse3_2.bitmap :=  gelipse1_1.bitmap;
  // belipse3_3.bitmap :=  gelipse1_1.bitmap;
  belipse4_1.bitmap := gelipse1_1.bitmap;
  belipse5_1.bitmap := gelipse1_1.bitmap;

  doinit(Sender);

end;


procedure trandomnotefo.randomnum(const Sender: TObject);
var
  x, ax: integer;
begin
  if blocked = 0 then
  begin
    blocked          := 1;
    doclear(Sender);
    numchord.Visible := True;

    tbutton5.Visible := False;

    bnbchords.Visible := False;
    btnfixed.Visible  := False;

    bnbchords.left   := 130;
    bnbchords.top    := tbutton2.top;
    bnbchords.Width  := 202;
    bnbchords.Height := tbutton2.Height;

    btnfixed.left   := 338;
    btnfixed.Width  := 144;
    btnfixed.Height := tbutton2.Height;
    ;
    btnfixed.top    := bnbchords.top;

    bnbchords.font.Height := 30;
    btnfixed.font.Height  := 30;

    //  bnbchords.left := 64;
    //  bnbchords.top := 184;

    //  bnbchords.width := 400;
    // bnbchords.height := 120;
    tstringdisp1.Visible := False;

    if withrandom.Value = False then
      numchord.Value := StrToInt(ansistring(maxnote.Value))
    else
    begin

      x := 0;
      while x < 50 do
      begin

        numchord.Value := Random(StrToInt(ansistring(maxnote.Value))) + 1;
        Inc(x);
        application.ProcessMessages;
        sleep(20);
      end;
    end;


    bchord1.Height := (Height div numchord.Value) - 10;

    if numchord.Value > 0 then
    begin

      bchord1.top := 2;

      chord1.Height  := bchord1.Height;
      piano1.Height  := bchord1.Height;
      bass1.Height   := bchord1.Height;
      chord1.top     := bchord1.top;
      piano1.top     := bchord1.top;
      bass1.top      := bchord1.top;
      guitar1.Height := bchord1.Height;
      guitar1.top    := bchord1.top;

      bchord1.Visible := True;
      chord1.Visible  := True;

      chordran := 1;
      dorandomchord(Sender);

      piano1.Visible  := True;
      guitar1.Visible := True;
      bass1.Visible   := True;


      chord1drop.Value   := chord1.Caption;
      chord1drop.Visible := True;


      application.ProcessMessages;
      if bosound.Value then
      begin
        playrandomchords(0);

        application.ProcessMessages;
      end;
    end;

    if numchord.Value > 1 then
    begin

      chord2.Caption := chord1.Caption;
      x := 0;

      bchord2.Height := bchord1.Height;
      chord2.Height  := bchord1.Height;
      piano2.Height  := bchord1.Height;
      bass2.Height   := bchord1.Height;

      bchord2.top := bchord1.bottom + 10;
      chord2.top  := bchord2.top;
      piano2.top  := bchord2.top;
      bass2.top   := bchord2.top;

      guitar2.Height := bchord1.Height;
      guitar2.top    := bchord2.top;


      bchord2.Visible := True;
      chord2.Visible  := True;
      chordran        := 2;

      while (x < 10) and (chord2.Caption = chord1.Caption) do
      begin
        dorandomchord(Sender);
        Inc(x);
      end;

      piano2.Visible  := True;
      guitar2.Visible := True;
      bass2.Visible   := True;

      chord2drop.Value   := chord2.Caption;
      chord2drop.Visible := True;


      application.ProcessMessages;

      if bosound.Value then
      begin
        playrandomchords(1);

        application.ProcessMessages;
      end;

    end;

    if numchord.Value > 2 then
    begin
      chord3.Caption := chord2.Caption;
      bchord3.Visible := True;
      chord3.Visible := True;
      x := 0;

      bchord3.Height := bchord1.Height;
      chord3.Height  := bchord1.Height;
      piano3.Height  := bchord1.Height;
      bass3.Height   := bchord1.Height;

      bchord3.top := bchord2.bottom + 10;
      chord3.top  := bchord3.top;
      piano3.top  := bchord3.top;
      bass3.top   := bchord3.top;

      guitar3.Height := bchord1.Height;
      guitar3.top    := bchord3.top;

      chordran := 3;

      while (x < 10) and ((chord2.Caption = chord3.Caption) or (chord1.Caption = chord3.Caption)
        ) do
      begin
        dorandomchord(Sender);
        Inc(x);
      end;
      piano3.Visible  := True;
      guitar3.Visible := True;
      bass3.Visible   := True;

      chord3drop.Value   := chord3.Caption;
      chord3drop.Visible := True;

      application.ProcessMessages;

      if bosound.Value then
      begin
        playrandomchords(2);

        application.ProcessMessages;
      end;

    end;

    if numchord.Value > 3 then
    begin

      chord4.Caption := chord3.Caption;
      bchord4.Visible := True;
      chord4.Visible := True;
      x := 0;

      bchord4.Height := bchord1.Height;
      chord4.Height  := bchord1.Height;
      piano4.Height  := bchord1.Height;
      bass4.Height   := bchord1.Height;

      bchord4.top := bchord3.bottom + 10;
      chord4.top  := bchord4.top;
      piano4.top  := bchord4.top;
      bass4.top   := bchord4.top;

      guitar4.Height := bchord1.Height;
      guitar4.top    := bchord4.top;

      chordran := 4;

      while (x < 10) and ((chord3.Caption = chord4.Caption) or (chord1.Caption = chord4.Caption)
        ) do
      begin
        dorandomchord(Sender);
        Inc(x);
      end;

      piano4.Visible  := True;
      guitar4.Visible := True;
      bass4.Visible   := True;

      chord4drop.Value   := chord4.Caption;
      chord4drop.Visible := True;

      application.ProcessMessages;

      if bosound.Value then
      begin
        playrandomchords(3);

        application.ProcessMessages;
      end;

    end;

    if numchord.Value > 4 then
    begin
      bchord5.Visible := True;
      chord5.Visible  := True;
      chord5.Caption  := chord4.Caption;

      x := 0;

      bchord5.Height := bchord1.Height;
      chord5.Height  := bchord1.Height;
      piano5.Height  := bchord1.Height;
      bass5.Height   := bchord1.Height;

      bchord5.top := bchord4.bottom + 10;
      chord5.top  := bchord5.top;
      piano5.top  := bchord5.top;
      bass5.top   := bchord5.top;

      guitar5.Height := bchord1.Height;
      guitar5.top    := bchord5.top;

      chordran := 5;

      while (x < 10) and ((chord5.Caption = chord4.Caption) or (chord1.Caption = chord5.Caption)
        ) do
      begin
        dorandomchord(Sender);
        Inc(x);
      end;

      piano5.Visible  := True;
      guitar5.Visible := True;
      bass5.Visible   := True;

      chord5drop.Value := chord5.Caption;

      chord5drop.Width := chord5.Width;

      chord5drop.Visible := True;


      application.ProcessMessages;

      if bosound.Value then
      begin
        playrandomchords(4);

        application.ProcessMessages;
      end;

    end;

    if nodrums.Value = True then
    begin
      tbutton3.Visible      := True;
      drum_beats[0]         := 'x000x000x000x000';
      // closed hat
      drum_beats[1]         := '0000000000000000';
      // opened hat
      drum_beats[2]         := '0000000000000000';
      // snare
      drum_beats[3]         := 'x000000000000000';
      // kick
      drumsfo.novoice.Value := True;
      for ax := 0 to 15 do
      begin
        if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
          ach[ax].Value := True
        else
          ach[ax].Value := False;

        if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
          aoh[ax].Value := True
        else
          aoh[ax].Value := False;

        if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
          asd[ax].Value := True
        else
          asd[ax].Value := False;

        if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
          abd[ax].Value := True
        else
          abd[ax].Value := False;
      end;

      drumsfo.dragdock.float();
      drumsfo.Visible := True;

      refreshform(Sender);

      bpm.Visible := True;
      bpm.Value   := (80 + random(80));
      drumsfo.edittempo.Value := bpm.Value * 2;
      drumsfo.dostart(Sender);
      //bnbchords.visible := true;
    end;
    tbutton2.Visible  := True;
    tbutton3.Visible  := True;
    tbutton5.Visible  := True;
    bnbchords.Visible := True;
    btnfixed.Visible  := True;
    blocked           := 0;

  end;

end;

procedure trandomnotefo.onclosev(const Sender: TObject);
begin
  doinit(Sender);
end;

procedure trandomnotefo.doclear(const Sender: TObject);
begin
  bchord1.Visible  := False;
  numchord.Visible := False;
  drumsfo.Visible  := False;
  //guitarsfo.visible := false;
  chord1.Visible   := False;

  chord1drop.Visible := False;
  chord2drop.Visible := False;
  chord3drop.Visible := False;
  chord4drop.Visible := False;
  chord5drop.Visible := False;
  bchord2.Visible    := False;
  chord2.Visible     := False;
  bchord3.Visible    := False;
  chord3.Visible     := False;
  bchord4.Visible    := False;
  chord4.Visible     := False;
  bchord5.Visible    := False;
  chord5.Visible     := False;
  guitar1.Visible    := False;
  guitar2.Visible    := False;
  guitar3.Visible    := False;
  guitar4.Visible    := False;
  guitar5.Visible    := False;
  piano1.Visible     := False;
  piano2.Visible     := False;
  piano3.Visible     := False;
  piano4.Visible     := False;
  piano5.Visible     := False;
  bass1.Visible      := False;
  bass2.Visible      := False;
  bass3.Visible      := False;
  bass4.Visible      := False;
  bass5.Visible      := False;
  bpm.Visible        := False;
  drumsfo.Visible    := False;
  tbutton3.Visible   := False;
  tbutton2.Visible   := False;
  drumsfo.dostop(Sender);
  //bnbchords.width := 1310;
  //bnbchords.Height     := 92;
  //bnbchords.left       := 16;
  //bnbchords.top        := 326;
  // refreshform(sender);
end;

procedure trandomnotefo.refreshform(const Sender: TObject);
begin

  if guitarsfo.Visible then
  begin
    guitarsfo.top     := top + tbutton5.top + 18;
    guitarsfo.left    := left + 40;
    guitarsfo.Visible := True;
    guitarsfo.bringtofront;
  end;

  if drumsfo.Visible then
  begin
    drumsfo.top     := top + 254;
    drumsfo.left    := left + 40;
    drumsfo.Visible := True;
    drumsfo.bringtofront;
  end;

end;

procedure trandomnotefo.onshowdrums(const Sender: TObject);
begin
  drumsfo.dragdock.float();
  drumsfo.Visible := True;
  bpm.Visible     := True;
  bpm.Value       := round(drumsfo.edittempo.Value / 2);
  refreshform(Sender);
end;

procedure trandomnotefo.doquit(const Sender: TObject);
begin
  if drumsfo.Visible then
    drumsfo.Visible := False;
  //if guitarsfo.visible then guitarsfo.visible := false;
  mainfo.onexit(Sender);
end;

procedure trandomnotefo.showguit(const Sender: TObject);
begin
  guitarsfo.dragdock.float();
  guitarsfo.Visible := True;
  refreshform(Sender);
end;

procedure trandomnotefo.playrandomchords(thenum: integer);
var 
  thedir, afile: string;
begin

  if thenum = 0 then
    afile := chordmem1 + '_PIANO'
  else if thenum = 1 then
         afile := chordmem2 + '_PIANO'
  else if thenum = 2 then
         afile := chordmem3 + '_PIANO'
  else if thenum = 3 then
         afile := chordmem4 + '_PIANO'
  else if thenum = 4 then
         afile := chordmem5 + '_PIANO'
  else
    afile := '';

  thedir := IncludeTrailingBackslash(ExtractFilePath(msestring(ParamStr(0)))) +
            'sound' + directoryseparator + 'piano' + directoryseparator + afile + '.ogg';
 
   if fileexists(thedir) then
    begin

      if uos_CreatePlayer(20) then
      begin
      application.processmessages;

        if uos_AddFromFile(20, PChar(thedir)) > -1 then
        begin


   {$if defined(cpuarm)}
          if uos_AddIntoDevOut(20, configfo.devoutcfg.value, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
            if uos_AddIntoDevOut(20, configfo.devoutcfg.value, -1, -1, -1, -1, -1, -1) > -1 then
 
    {$endif}
    begin
              uos_Play(20);

      sleep(4500);
     end;

end;
    end;
end;
  if thenum = 0 then
    afile := chordmem1 + '_GUIT'
  else if thenum = 1 then
         afile := chordmem2 + '_GUIT'
  else if thenum = 2 then
         afile := chordmem3 + '_GUIT'
  else if thenum = 3 then
         afile := chordmem4 + '_GUIT'
  else if thenum = 4 then
         afile := chordmem5 + '_GUIT'
  else
    afile := '';

  thedir := IncludeTrailingBackslash(ExtractFilePath(msestring(ParamStr(0)))) +
            'sound' + directoryseparator + 'guitar' + directoryseparator + afile + '.ogg';

  if fileexists(thedir) then
    begin


      uos_Stop(21);

      if uos_CreatePlayer(21) then
      application.processmessages;

        if uos_AddFromFile(21, PChar(thedir)) > -1 then


   {$if defined(cpuarm)}
          if uos_AddIntoDevOut(21, configfo.devoutcfg.value, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
           if uos_AddIntoDevOut(21, configfo.devoutcfg.value, -1, -1, -1, -1, -1, -1) > -1 then
    {$endif}

              uos_Play(21);

      sleep(6000);

    end;

end;

procedure trandomnotefo.onmouseguit(const Sender: twidget; var ainfo: mouseeventinfoty);
var
  thedir, afile: msestring;
begin
  with ainfo do
    if eventkind in [ek_buttonpress] then
    begin

      if Timage(Sender).tag = 0 then
        afile := chordmem1 + '_GUIT'
      else if Timage(Sender).tag = 1 then
        afile := chordmem2 + '_GUIT'
      else if Timage(Sender).tag = 2 then
        afile := chordmem3 + '_GUIT'
      else if Timage(Sender).tag = 3 then
        afile := chordmem4 + '_GUIT'
      else if Timage(Sender).tag = 4 then
        afile := chordmem5 + '_GUIT'
      else
        afile := '';

      thedir := IncludeTrailingBackslash(ExtractFilePath(msestring(ParamStr(0)))) +
        'sound' + directoryseparator + 'guitar' + directoryseparator + afile + '.ogg';

      if fileexists(thedir) then
      begin

        uos_Stop(Timage(Sender).tag + 10);

        if uos_CreatePlayer(Timage(Sender).tag + 10) then
          application.ProcessMessages;

        if uos_AddFromFile(Timage(Sender).tag + 10, PChar(thedir)) > -1 then


   {$if defined(cpuarm)}
                if uos_AddIntoDevOut(Timage(Sender).tag + 10, -1, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
          if uos_AddIntoDevOut(Timage(Sender).tag + 10) > -1 then
    {$endif}

            uos_Play(Timage(Sender).tag + 10);

      end;
      refreshform(Sender);

    end;

end;

procedure trandomnotefo.onmousepiano(const Sender: twidget; var ainfo: mouseeventinfoty);
var
  thedir, afile: msestring;
begin
  with ainfo do
    if eventkind in [ek_buttonpress] then
    begin

      if Timage(Sender).tag = 0 then
        afile := chordmem1 + '_PIANO'
      else if Timage(Sender).tag = 1 then
        afile := chordmem2 + '_PIANO'
      else if Timage(Sender).tag = 2 then
        afile := chordmem3 + '_PIANO'
      else if Timage(Sender).tag = 3 then
        afile := chordmem4 + '_PIANO'
      else if Timage(Sender).tag = 4 then
        afile := chordmem5 + '_PIANO'
      else
        afile := '';

      thedir := IncludeTrailingBackslash(ExtractFilePath(msestring(ParamStr(0)))) +
        'sound' + directoryseparator + 'piano' + directoryseparator + afile + '.ogg';

      if fileexists(thedir) then
      begin

        uos_Stop(Timage(Sender).tag + 20);

        if uos_CreatePlayer(Timage(Sender).tag + 20) then
          application.ProcessMessages;

        if uos_AddFromFile(Timage(Sender).tag + 20, PChar(thedir)) > -1 then


   {$if defined(cpuarm)}
                if uos_AddIntoDevOut(Timage(Sender).tag + 20, configfo.devoutcfg.value, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
          if uos_AddIntoDevOut(Timage(Sender).tag + 20, configfo.devoutcfg.Value, -1, -1, -1, -1, -1, -1) > -1 then
   {$endif}

            uos_Play(Timage(Sender).tag + 20);

      end;
      refreshform(Sender);

    end;

end;

procedure trandomnotefo.onmousevdrop(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  with ainfo do
    if eventkind in [ek_buttonrelease] then
    begin
      // refreshform(Sender);
      chorddrop := 1 ;
      blocked := 0 ;
      if bosound.Value then onchangechorddrop(Sender);
      chorddrop := 0;
       refreshform(Sender);
       bosound.Value := true;
    end;
 end;

procedure trandomnotefo.onmousev(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  with ainfo do
    if eventkind in [ek_buttonpress] then
    begin
     refreshform(Sender);
    end;
end;

procedure trandomnotefo.ontextmax(const Sender: tcustomdataedit; var atext: msestring; var accept: Boolean);
begin
  refreshform(Sender);
end;

procedure trandomnotefo.ondropchord(const Sender: twidget; const dropdown: tdropdownlist);
begin
  chorddrop := 0;
  bosound.Value := false;
  //refreshform(sender);
end;

procedure trandomnotefo.onchangechorddrop(const Sender: TObject);
begin
  if chorddrop = 1 then
    if blocked = 0 then
    begin
      blocked := 1;
      
      dorandomchord(Sender);
      application.ProcessMessages;
      if bosound.Value then
        playrandomchords(tdropdownlistedit(Sender).tag - 1);
      application.ProcessMessages;
      refreshform(Sender);
      blocked := 0;
    end;
  chorddrop   := 0;
end;

procedure trandomnotefo.dofixed(const Sender: TObject);
var
  ax: integer;
begin
  if blocked = 0 then
  begin
    bnbchords.Visible := False;
    btnfixed.Visible := False;
    tstringdisp1.Visible := False;
    blocked          := 1;
    doclear(Sender);
    application.ProcessMessages;
    numchord.Visible := True;
    numchord.Value   := StrToInt(ansistring(maxnote.Value));

    bchord1.Height := (Height div numchord.Value) - 10;
    bchord1.top    := 2;
    chord1.Height  := bchord1.Height;
    piano1.Height  := bchord1.Height;
    bass1.Height   := bchord1.Height;
    chord1.top     := bchord1.top;
    piano1.top     := bchord1.top;
    bass1.top      := bchord1.top;
    guitar1.Height := bchord1.Height;
    guitar1.top    := bchord1.top;

    if numchord.Value > 0 then
    begin
      bchord1.Visible    := True;
      chord1.Visible     := True;
      chord1.Caption     := 'A / La' + lineend + 'Major';
      piano1.Visible     := True;
      guitar1.Visible    := True;
      bass1.Visible      := True;
      chord1drop.Visible := True;
      chord1drop.Value   := 'A / La Major';
      pianochord(1, 1, 1, 0);
      guitarchord(1, 1, 1, 0);
      basschord(1, 1, 1, 0);
      chordmem1 := 'A';
      application.ProcessMessages;
    end;

    if numchord.Value > 1 then
    begin
      bchord2.Height := bchord1.Height;
      chord2.Height  := bchord1.Height;
      piano2.Height  := bchord1.Height;
      bass2.Height   := bchord1.Height;

      bchord2.top := bchord1.bottom + 10;
      chord2.top  := bchord2.top;
      piano2.top  := bchord2.top;
      bass2.top   := bchord2.top;

      guitar2.Height     := bchord1.Height;
      guitar2.top        := bchord2.top;
      chord2.Caption     := 'A / La' + lineend + 'Major';
      chord2drop.Value   := chord1drop.Value;
      chord2drop.Visible := True;
      bchord2.Visible    := True;
      chord2.Visible     := True;
      piano2.Visible     := True;
      guitar2.Visible    := True;
      bass2.Visible      := True;

      chordmem2 := chordmem1;

      pianochord(2, 1, 1, 0);
      guitarchord(2, 1, 1, 0);
      basschord(2, 1, 1, 0);

      application.ProcessMessages;
    end;

    if numchord.Value > 2 then
    begin
      bchord3.Height := bchord1.Height;
      chord3.Height  := bchord1.Height;
      piano3.Height  := bchord1.Height;
      bass3.Height   := bchord1.Height;

      bchord3.top := bchord2.bottom + 10;
      chord3.top  := bchord3.top;
      piano3.top  := bchord3.top;
      bass3.top   := bchord3.top;

      guitar3.Height     := bchord1.Height;
      guitar3.top        := bchord3.top;
      chord3.Caption     := chord1.Caption;
      chord3drop.Value   := chord1drop.Value;
      chord3drop.Visible := True;
      bchord3.Visible    := True;
      chord3.Visible     := True;
      piano3.Visible     := True;
      guitar3.Visible    := True;
      bass3.Visible      := True;

      chordmem3 := chordmem1;

      pianochord(3, 1, 1, 0);
      guitarchord(3, 1, 1, 0);
      basschord(3, 1, 1, 0);

      application.ProcessMessages;
    end;

    if numchord.Value > 3 then
    begin
      bchord4.Height := bchord1.Height;
      chord4.Height  := bchord1.Height;
      piano4.Height  := bchord1.Height;
      bass4.Height   := bchord1.Height;

      bchord4.top := bchord3.bottom + 10;
      chord4.top  := bchord4.top;
      piano4.top  := bchord4.top;
      bass4.top   := bchord4.top;

      guitar4.Height     := bchord1.Height;
      guitar4.top        := bchord4.top;
      chord4.Caption     := chord1.Caption;
      chord4drop.Value   := chord1drop.Value;
      chord4drop.Visible := True;
      bchord4.Visible    := True;
      chord4.Visible     := True;
      piano4.Visible     := True;
      guitar4.Visible    := True;
      bass4.Visible      := True;

      application.ProcessMessages;

      chordmem4 := chordmem1;

      pianochord(4, 1, 1, 0);
      guitarchord(4, 1, 1, 0);
      basschord(4, 1, 1, 0);

      application.ProcessMessages;
    end;


    if numchord.Value > 4 then
    begin
      bchord5.Height := bchord1.Height;
      chord5.Height  := bchord1.Height;
      piano5.Height  := bchord1.Height;
      bass5.Height   := bchord1.Height;

      bchord5.top := bchord4.bottom + 10;
      chord5.top  := bchord5.top;
      piano5.top  := bchord5.top;
      bass5.top   := bchord5.top;

      guitar5.Height     := bchord1.Height;
      guitar5.top        := bchord5.top;
      chord5.Caption     := chord1.Caption;
      chord5drop.Value   := chord1drop.Value;
      chord5drop.Visible := True;
      bchord5.Visible    := True;
      chord5.Visible     := True;
      piano5.Visible     := True;
      guitar5.Visible    := True;
      bass5.Visible      := True;

      application.ProcessMessages;

      chordmem5 := chordmem1;

      pianochord(5, 1, 1, 0);
      guitarchord(5, 1, 1, 0);
      basschord(5, 1, 1, 0);

      application.ProcessMessages;
    end;

    tbutton5.Visible := False;

    bnbchords.left   := 130;
    bnbchords.top    := tbutton2.top;
    bnbchords.Width  := 202;
    bnbchords.Height := tbutton2.Height;

    btnfixed.left   := 338;
    btnfixed.Width  := 144;
    btnfixed.Height := tbutton2.Height;
    ;
    btnfixed.top    := bnbchords.top;

    bnbchords.font.Height := 30;
    btnfixed.font.Height  := 30;

  end;
  tbutton2.Visible := True;

  if nodrums.Value = True then
  begin
    tbutton3.Visible      := True;
    drum_beats[0]         := 'x000x000x000x000';
    // closed hat
    drum_beats[1]         := '0000000000000000';
    // opened hat
    drum_beats[2]         := '0000000000000000';
    // snare
    drum_beats[3]         := 'x000000000000000';
    // kick
    drumsfo.novoice.Value := True;
    for ax := 0 to 15 do
    begin
      if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
        ach[ax].Value := True
      else
        ach[ax].Value := False;

      if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
        aoh[ax].Value := True
      else
        aoh[ax].Value := False;

      if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
        asd[ax].Value := True
      else
        asd[ax].Value := False;

      if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
        abd[ax].Value := True
      else
        abd[ax].Value := False;
    end;

    drumsfo.dragdock.float();
    drumsfo.Visible := True;

    bpm.Visible := True;
    bpm.Value   := 100;
    drumsfo.edittempo.Value := bpm.Value * 2;
    //bnbchords.visible := true;

  end;
  tbutton3.Visible  := True;
  tbutton5.Visible  := True;
  bnbchords.Visible := True;
  btnfixed.Visible  := True;

  refreshform(Sender);
  blocked := 0;
end;

procedure trandomnotefo.doinit(const Sender: TObject);
begin
  doclear(Sender);
  bnbchords.left   := 20;
  bnbchords.top    := 272;
  bnbchords.Width  := 462;
  bnbchords.Height := 102;

  btnfixed.left   := 20;
  btnfixed.Width  := 462;
  btnfixed.Height := 102;
  btnfixed.top    := 382;

  bnbchords.font.Height := 60;
  btnfixed.font.Height  := 60;

  bnbchords.Visible    := True;
  btnfixed.Visible     := True;
  tstringdisp1.Visible := True;
end;

procedure trandomnotefo.doconfig(const Sender: TObject);
begin
  pconfigtext.Visible := True;
end;

procedure trandomnotefo.onconfigtext(const Sender: TObject);
begin
  tstringdisp1.Text   := tmemoedit1.Value;
  pconfigtext.Visible := False;
  application.ProcessMessages;
end;

procedure trandomnotefo.onhide(const Sender: TObject);
begin
if  (isactivated = true) then
      mainfo.tmainmenu1.menu.itembynames(['show','showchords']).caption := 
      lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' +
      lang_randomnotefo[Ord(ra_randomnotefo)] ;          
end;

procedure trandomnotefo.onshowrand(const Sender: TObject);
begin
if  (isactivated = true) then
   mainfo.tmainmenu1.menu.itembynames(['show','showchords']).caption := 
      lang_mainfo[Ord(ma_hide)]  + ': ' +
      lang_randomnotefo[Ord(ra_randomnotefo)] ;          

end;

procedure trandomnotefo.crea(const Sender: TObject);
begin
  windowopacity := 0;
end;

end.

