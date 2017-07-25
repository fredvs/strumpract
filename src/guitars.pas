unit guitars;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,msedragglob,
 msesimplewidgets,msewidgets,msegraphedits,mseificomp,mseificompglob,mseifiglob,
 msescrollbar, sysutils;

type
 tguitarsfo = class(tdockform)
   tdockpanel6: tdockpanel;
   tlabel24: tlabel;
   tbutton13: tbutton;
   tbutton14: tbutton;
   tbutton15: tbutton;
   tbutton16: tbutton;
   loopbass: tbooleanedit;
   tdockpanel5: tdockpanel;
   tlabel23: tlabel;
   tbutton3: tbutton;
   tbutton5: tbutton;
   tbutton6: tbutton;
   tbutton7: tbutton;
   tbutton8: tbutton;
   tbutton9: tbutton;
   loopguit: tbooleanedit;
   procedure doguitarstring(const sender: TObject);
   procedure onfloatguit(const sender: TObject);
   procedure ondockguit(const sender: TObject);
   procedure oncloseguit(const sender: TObject);
   procedure oncreateguit(const sender: TObject);
 end;
var
 guitarsfo: tguitarsfo;
 aguitar : array[0..9] of string;
 aguitarisplaying : array[0..9] of boolean;
 
implementation
uses
uos_flat, main,
 guitars_mfm;
 
 procedure tguitarsfo.doguitarstring(const sender: TObject);
begin
 uos_Stop(Tbutton(Sender).tag + 9); 
  if ((loopguit.value = false) and (Tbutton(Sender).tag < 7)) or
  ((loopbass.value = false) and (Tbutton(Sender).tag > 6))  then 
  begin
 if uos_CreatePlayer(Tbutton(Sender).tag + 9 ) then
 if uos_AddFromFile(Tbutton(Sender).tag + 9,(pchar(aguitar[Tbutton(Sender).tag-1]))) > -1 then
 if uos_AddIntoDevOut(Tbutton(Sender).tag + 9) > -1 then
 uos_Play(Tbutton(Sender).tag + 9);
    end else
 begin
 if (aguitarisplaying[Tbutton(Sender).tag -1 ]  = false) 
    then
 begin
  Tbutton(Sender).face.fade_direction := gd_up;
  Tbutton(Sender).face.fade_color.items[1] := cl_ltgreen;
  if uos_CreatePlayer(Tbutton(Sender).tag + 9 ) then
 if uos_AddFromFile(Tbutton(Sender).tag + 9,(pchar(aguitar[Tbutton(Sender).tag-1]))) > -1 then
 if uos_AddIntoDevOut(Tbutton(Sender).tag + 9) > -1 then
 begin
   uos_Play(Tbutton(Sender).tag + 9, -1);
   aguitarisplaying[Tbutton(Sender).tag -1 ]  := true;
 end;
 end else
 begin
  Tbutton(Sender).face.fade_direction := gd_down;
  Tbutton(Sender).face.fade_color.items[1] := $B0A590;
  aguitarisplaying[Tbutton(Sender).tag -1 ]  := false;
 end;
  
 end;   
 end;   

procedure tguitarsfo.onfloatguit(const sender: TObject);
begin
height := 74;
mainfo.height := mainfo.height - 74;
if mainfo.height < 40 then mainfo.height := 40;
end;

procedure tguitarsfo.ondockguit(const sender: TObject);
begin
height := 74;
mainfo.height := mainfo.height + 74;
end;

procedure tguitarsfo.oncloseguit(const sender: TObject);
begin
if parentwidget <> nil then begin
mainfo.height := mainfo.height - 74;
if mainfo.height < 40 then mainfo.height := 40;
mainfo.tmainmenu1.menu[2].caption := ' &Guitar-show ' ;
end;
end;

procedure tguitarsfo.oncreateguit(const sender: TObject);
var
ordir : string;
i : integer;
begin
caption := 'Guitar and Bass tuned strings';

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));  

aguitar[0] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '1_MI_E.ogg';
aguitar[1] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '2_SI_B.ogg'; 
aguitar[2] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '3_SOL_G.ogg';
aguitar[3] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '4_RE_D.ogg';

aguitar[4] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '5_LA_A.ogg';
aguitar[5] := ordir + 'sound' + directoryseparator +  'guitar' + directoryseparator + '6_MI_E.ogg'; 

aguitar[6] := ordir + 'sound' + directoryseparator +  'bass' + directoryseparator + 'Ba1_SOL_G.ogg';
aguitar[7] := ordir + 'sound' + directoryseparator +  'bass' + directoryseparator + 'Ba2_RE_D.ogg'; 
aguitar[8] := ordir + 'sound' + directoryseparator +  'bass' + directoryseparator + 'Ba3_LA_A.ogg';
aguitar[9] := ordir + 'sound' + directoryseparator +  'bass' + directoryseparator + 'Ba4_MI_E.ogg';

for i := 0 to 9 do  aguitarisplaying[i]  := false;

end;
   
end.
