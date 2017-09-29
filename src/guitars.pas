unit guitars;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msegui,
 msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock,
 msesimplewidgets, msewidgets, msegraphedits, SysUtils, mseificomp,
 mseificompglob,mseifiglob, msescrollbar, msetypes,msedispwidgets,mserichstring,
 msestrings;

type
  tguitarsfo = class(tdockform)
    tfaceguitlight: tfacecomp;
    tgroupbox1: tgroupbox;
    tfaceguit: tfacecomp;
    tgroupbox2: tgroupbox;
    tbutton16: TButton;
    tbutton15: TButton;
    tbutton14: TButton;
    tbutton13: TButton;
    loopbass: tbooleanedit;
    tbutton9: TButton;
    tbutton8: TButton;
    tbutton7: TButton;
    tbutton6: TButton;
    tbutton5: TButton;
    tbutton3: TButton;
    loopguit: tbooleanedit;
   tstringdisp2: tstringdisp;
   tstringdisp3: tstringdisp;
    procedure doguitarstring(const Sender: TObject);
    procedure onvisiblechangeev(const Sender: TObject);
    procedure oncreateguit(const Sender: TObject);
    procedure onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
  end;

var
  guitarsfo: tguitarsfo;
  aguitar: array[0..9] of string;
  aguitarisplaying: array[0..9] of boolean;
  initguit: integer = 1;

implementation

uses
  uos_flat, main,
  guitars_mfm;

procedure tguitarsfo.doguitarstring(const Sender: TObject);
begin
  uos_Stop(TButton(Sender).tag + 9);
  if ((loopguit.Value = False) and (TButton(Sender).tag < 7)) or ((loopbass.Value = False) and (TButton(Sender).tag > 6)) then
  begin
    if uos_CreatePlayer(TButton(Sender).tag + 9) then
      if uos_AddFromFile(TButton(Sender).tag + 9, (PChar(aguitar[TButton(Sender).tag - 1]))) > -1 then
        if uos_AddIntoDevOut(TButton(Sender).tag + 9) > -1 then
          uos_Play(TButton(Sender).tag + 9);
  end
  else
  begin
    if (aguitarisplaying[TButton(Sender).tag - 1] = False) then
    begin
      TButton(Sender).face.fade_direction := gd_up;
      TButton(Sender).face.fade_color.items[1] := cl_ltgreen;
      if uos_CreatePlayer(TButton(Sender).tag + 9) then
        if uos_AddFromFile(TButton(Sender).tag + 9, (PChar(aguitar[TButton(Sender).tag - 1]))) > -1 then
          if uos_AddIntoDevOut(TButton(Sender).tag + 9) > -1 then
          begin
            uos_Play(TButton(Sender).tag + 9, -1);
            aguitarisplaying[TButton(Sender).tag - 1] := True;
          end;
    end
    else
    begin
      TButton(Sender).face.fade_direction := gd_down;
      TButton(Sender).face.fade_color.items[1] := $B0A590;
      aguitarisplaying[TButton(Sender).tag - 1] := False;
    end;

  end;
end;

procedure tguitarsfo.onvisiblechangeev(const Sender: TObject);
begin
if Visible then
  begin
    mainfo.tmainmenu1.menu[3].submenu[8].caption := ' Hide Guitars ' ;
  end
  else
  begin
    mainfo.tmainmenu1.menu[3].submenu[8].caption := ' Show Guitars ' ; 
  end;
  mainfo.updatelayout();
end;

procedure tguitarsfo.oncreateguit(const Sender: TObject);
var
  ordir: string;
  i: integer;
begin
  Caption := 'Guitar and Bass tuned strings';

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  aguitar[0] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '1_MI_E.ogg';
  aguitar[1] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '2_SI_B.ogg';
  aguitar[2] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '3_SOL_G.ogg';
  aguitar[3] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '4_RE_D.ogg';

  aguitar[4] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '5_LA_A.ogg';
  aguitar[5] := ordir + 'sound' + directoryseparator + 'guitar' + directoryseparator + '6_MI_E.ogg';

  aguitar[6] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba1_SOL_G.ogg';
  aguitar[7] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba2_RE_D.ogg';
  aguitar[8] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba3_LA_A.ogg';
  aguitar[9] := ordir + 'sound' + directoryseparator + 'bass' + directoryseparator + 'Ba4_MI_E.ogg';

  for i := 0 to 9 do
    aguitarisplaying[i] := False;

end;

procedure tguitarsfo.onmousewindow(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
{
with ainfo do
  if (eventkind = ek_buttonpress) then
  begin
if mainfo.issomeplaying = false then dragdock.optionsdock := [od_savepos,od_savezorder,od_canmove,od_canfloat,od_candock,od_proportional,od_fixsize,od_captionhint]
else
dragdock.optionsdock := [od_savepos,od_savezorder,od_proportional,od_fixsize,od_captionhint] ;
end;
}
end;

end.
