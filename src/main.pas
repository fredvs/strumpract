unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msegui,msetimer,
 ctypes,msegraphics,msegraphutils,mseclasses,msewidgets,mseforms,msedock,
 msesimplewidgets,msedataedits,mseedit,msestatfile,msestrings,SysUtils,Classes,
 msegraphedits, uos_flat, aboutform, infos, msebitmap,mseimage,msefiledialog,
 msesys,mseificomp,mseificompglob,mseifiglob,msemenus,msescrollbar,mseact,
 mseevent,msestream,msedragglob,msedatanodes,msegrids,mselistbrowser;
 
type
 talab =  array[0..15] of tlabel;
 talab2 =  array[0..3] of tlabel;
 tcheck = array[0..15] of tbooleanedit;

type
 tmainfo = class(tmainform)
   tdockpanel1: tdockpanel;
   tlabel20: tlabel;
   tlabel19: tlabel;
   tlabel18: tlabel;
   tlabel17: tlabel;
   tlabel16: tlabel;
   tlabel15: tlabel;
   tlabel14: tlabel;
   tlabel13: tlabel;
   tlabel12: tlabel;
   tlabel11: tlabel;
   tlabel10: tlabel;
   tlabel9: tlabel;
   tlabel8: tlabel;
   tlabel7: tlabel;
   tlabel6: tlabel;
   tlabel5: tlabel;
   tbooleanedit64: tbooleanedit;
   tbooleanedit63: tbooleanedit;
   tbooleanedit62: tbooleanedit;
   tbooleanedit61: tbooleanedit;
   tbooleanedit60: tbooleanedit;
   tbooleanedit59: tbooleanedit;
   tbooleanedit58: tbooleanedit;
   tbooleanedit57: tbooleanedit;
   tbooleanedit56: tbooleanedit;
   tbooleanedit55: tbooleanedit;
   tbooleanedit54: tbooleanedit;
   tbooleanedit53: tbooleanedit;
   tbooleanedit52: tbooleanedit;
   tbooleanedit51: tbooleanedit;
   tbooleanedit50: tbooleanedit;
   tbooleanedit49: tbooleanedit;
   tbooleanedit48: tbooleanedit;
   tbooleanedit47: tbooleanedit;
   tbooleanedit46: tbooleanedit;
   tbooleanedit45: tbooleanedit;
   tbooleanedit44: tbooleanedit;
   tbooleanedit43: tbooleanedit;
   tbooleanedit42: tbooleanedit;
   tbooleanedit41: tbooleanedit;
   tbooleanedit40: tbooleanedit;
   tbooleanedit39: tbooleanedit;
   tbooleanedit38: tbooleanedit;
   tbooleanedit37: tbooleanedit;
   tbooleanedit36: tbooleanedit;
   tbooleanedit35: tbooleanedit;
   tbooleanedit34: tbooleanedit;
   tbooleanedit33: tbooleanedit;
   tbooleanedit32: tbooleanedit;
   tbooleanedit31: tbooleanedit;
   tbooleanedit30: tbooleanedit;
   tbooleanedit29: tbooleanedit;
   tbooleanedit28: tbooleanedit;
   tbooleanedit27: tbooleanedit;
   tbooleanedit26: tbooleanedit;
   tbooleanedit25: tbooleanedit;
   tbooleanedit24: tbooleanedit;
   tbooleanedit23: tbooleanedit;
   tbooleanedit22: tbooleanedit;
   tbooleanedit21: tbooleanedit;
   tbooleanedit20: tbooleanedit;
   tbooleanedit19: tbooleanedit;
   tbooleanedit18: tbooleanedit;
   tbooleanedit17: tbooleanedit;
   tlabel4: tlabel;
   tlabel3: tlabel;
   tlabel2: tlabel;
   tlabel1: tlabel;
   tbooleanedit16: tbooleanedit;
   tbooleanedit15: tbooleanedit;
   tbooleanedit14: tbooleanedit;
   tbooleanedit13: tbooleanedit;
   tbooleanedit12: tbooleanedit;
   tbooleanedit11: tbooleanedit;
   tbooleanedit10: tbooleanedit;
   tbooleanedit9: tbooleanedit;
   tbooleanedit8: tbooleanedit;
   tbooleanedit7: tbooleanedit;
   tbooleanedit6: tbooleanedit;
   tbooleanedit5: tbooleanedit;
   tbooleanedit4: tbooleanedit;
   tbooleanedit3: tbooleanedit;
   tbooleanedit2: tbooleanedit;
   tbooleanedit1: tbooleanedit;
   lach: tlabel;
   laoh: tlabel;
   lasd: tlabel;
   labd: tlabel;
   buttonicons: timagelist;
   labpat: tlabel;
   and1: tlabel;
   and2: tlabel;
   and3: tlabel;
   and4: tlabel;
   tdockpanel5: tdockpanel;
   tlabel23: tlabel;
   tbutton3: tbutton;
   tbutton5: tbutton;
   tbutton6: tbutton;
   tbutton7: tbutton;
   tbutton8: tbutton;
   tbutton9: tbutton;
   tdockpanel6: tdockpanel;
   tlabel24: tlabel;
   tbutton13: tbutton;
   tbutton14: tbutton;
   tbutton15: tbutton;
   tbutton16: tbutton;
   tdockpanel7: tdockpanel;
   tbutton2: tbutton;
   tstatfile1: tstatfile;
   tdockpanel8: tdockpanel;
   btnPause: tbutton;
   btnResume: tbutton;
   btnStart: tbutton;
   songdir: tfilenameedit;
   btnStop: tbutton;
   llength: tlabel;
   lposition: tlabel;
   tlabel28: tlabel;
   trackbar1: tslider;
   tbutton17: tbutton;
   cbtempo: tbooleanedit;
   label6: tlabel;
   tlabel27: tlabel;
   cbloop: tbooleanedit;
   button1: tbutton;
   tdockpanel4: tdockpanel;
   timage1: timage;
   tbooleaneditradio8: tbooleaneditradio;
   tbooleaneditradio7: tbooleaneditradio;
   tbooleaneditradio6: tbooleaneditradio;
   tbooleaneditradio5: tbooleaneditradio;
   tbooleaneditradio2: tbooleaneditradio;
   tbooleaneditradio4: tbooleaneditradio;
   tbooleaneditradio3: tbooleaneditradio;
   tbooleaneditradio1: tbooleaneditradio;
   tlabel22: tlabel;
   tlabel21: tlabel;
   noanim: tbooleanedit;
   noand: tbooleanedit;
   novoice: tbooleanedit;
   nodrums: tbooleanedit;
   loop_stop: tbutton;
   loop_resume: tbutton;
   loop_start: tbutton;
   tdockpanel3: tdockpanel;
   label5: tlabel;
   tlabel25: tlabel;
   tdockpanel2: tdockpanel;
   timage3: timage;
   label4: tlabel;
   label3: tlabel;
   label2: tlabel;
   edtempo: trealspinedit;
   edvol: trealspinedit;
   btinfos: tbutton;
   loopguit: tbooleanedit;
   loopbass: tbooleanedit;
   edittempo: trealspinedit;
   historyfn: thistoryedit;
   tlabel26: tlabel;
   vuRight: tdockpanel;
   vuLeft: tdockpanel;
   procedure oncreateform(const sender: TObject);
   procedure dostart(const sender: TObject);
   procedure ontimertick(const Sender: TObject);
   procedure ontimerwait(const Sender: TObject);
   procedure ontimerpause(const Sender: TObject);
   procedure dostop(const sender: TObject);
   procedure doresume(const sender: TObject);
   procedure onchangetempo(const sender: TObject);
   procedure dopatern(const sender: TObject);
   procedure onabout(const sender: TObject);
   procedure dodestroy(const sender: TObject);
   procedure doguitarstring(const sender: TObject);
   procedure doplayerstart(const sender: TObject);
   procedure doplayeresume(const sender: TObject);
   procedure doplayerpause(const sender: TObject);
   procedure doplayerstop(const sender: TObject);
   procedure ClosePlayer1;
   procedure showposition;
   procedure showlevel;
   procedure LoopProcPlayer1;
   
   procedure changepos(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure changevolume(const sender: TObject);
  
   procedure doentertrackbar(const sender: TObject);
   procedure doquit(const sender: TObject);
    procedure ChangePlugSetSoundTouch(const Sender: TObject);
   procedure onreset(const sender: TObject);
   procedure oncreatedform(const sender: TObject);
   procedure onfinfos(const sender: TObject);
   procedure sethistoryfn(const sender: TObject; var avalue: msestring;
                   var accept: Boolean);
   procedure onmouseslider(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure onsliderkeydown(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onsliderkeyup(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onsliderchange(const sender: TObject);
  
  end;
 
const
 versiontext = '1.1';
 
var
 mainfo: tmainfo;
 Timertick: Ttimer;
 Timerwait: Ttimer;
 Timerpause: Ttimer;
 tottime: ttime;
 alab : talab;
 alab2 : talab2;
 alaband : talab2;
 ach, aoh, asd, abd : tcheck;
 stopit :boolean = false;
 channels : cardinal = 2 ; // stereo output
 allok : boolean = false;
 plugsoundtouch : boolean = false;
 adrums: array[0..8] of string;
 aguitar : array[0..9] of string;
 aguitarisplaying : array[0..9] of boolean;
 ams :  array[0..8] of Tmemorystream; 
 theplayer : integer = 20;
 theplayerinfo : integer = 21;
 plugindex1, PluginIndex2: integer;
 drum_beats: array[0..3] of string; 
 posi, InputIndex1, OutputIndex1, Inputlength: integer; 
 ordir : string;
 
implementation
uses
 main_mfm;
   
 procedure tmainfo.ChangePlugSetSoundTouch(const Sender: TObject);
  var
    tempo, rate: cfloat;
  begin
         if (trim(Pchar(AnsiString(historyfn.value))) <> '') and fileexists(AnsiString(historyfn.value)) then
  begin
 
  //   label6.caption := 'Tempo: ' + floattostrf(tempo, ffFixed, 15, 1);
   
       uos_SetPluginSoundTouch(theplayer, PluginIndex2, edtempo.value, 1, cbtempo.value);
 
    end;
  end;
 
  
procedure Tmainfo.ClosePlayer1;
  begin
  {
    radiobutton1.Enabled := True;
    radiobutton2.Enabled := True;
    radiobutton3.Enabled := True;
    } 
    
   vuright.Height := 0;
    vuleft.Height := 0;
    vuLeft.Visible := False;
     vuRight.Visible := False;
    btnStart.Enabled := True;
    btnStop.Enabled := False;
    btnPause.Enabled := False;
    btnresume.Enabled := False;
    cbloop.enabled := true;
    trackbar1.value := 0;
    trackbar1.enabled := false;
    lposition.caption := '00:00:00.000';
  end;
  
 procedure Tmainfo.ontimerpause(const Sender: TObject);
var
i : integer;
begin 
Timerpause.Enabled := False;
for i:=0 to 8 do uos_pause(i);
end;

  procedure Tmainfo.ontimerwait(const Sender: TObject);
begin 
timerwait.enabled := false;
 btnStart.Enabled := True;
    btnStop.Enabled := true;
 if  cbloop.value = false then
    btnPause.Enabled := true else
      btnPause.Enabled := false;
    btnresume.Enabled := False;
    cbloop.enabled := false;
    trackbar1.enabled := true;
end;
 
procedure Tmainfo.ontimertick(const Sender: TObject);
  var
  ax : integer;
 
begin

// Timertick.Enabled := false;
 
if stopit = false then
 begin
  
if novoice.value = false then 
begin
if (posi = 1) then
begin
uos_PlaynofreePaused(4);
end
else 
if (posi = 3) and (noand.value = false) then
uos_PlaynofreePaused(8)
else 
if (posi = 5) then
uos_PlaynofreePaused(5)
else
if (posi = 7) and (noand.value = false) then
uos_PlaynofreePaused(8)
else 
if (posi = 9) then
uos_PlaynofreePaused(6)
else
if (posi = 11) and (noand.value = false) then
uos_PlaynofreePaused(8)
else   
if (posi = 13) then
uos_PlaynofreePaused(7)
else
if (posi = 15) and (noand.value = false) then
uos_PlaynofreePaused(8);
end;

if noanim.value = false then
begin
label2.visible := true;

if (posi = 1) or (posi = 9) then
begin
 label3.visible := true;
 label4.visible := false;
end else 
if (posi = 5) or (posi = 13) then
begin
 label3.visible := false;
 label4.visible := true;
end;

if (posi = 1) then
 label2.font.color := cl_red
  else
 label2.font.color := $4E574E;
 
  alaband[0].color := cl_ltgray;
  alaband[1].color := cl_ltgray;
  alaband[2].color := cl_ltgray;
  alaband[3].color := cl_ltgray; 
  
 if (posi = 1) then
begin
  alab2[0].color := cl_ltred;
  alab2[1].color := cl_ltgray;
  alab2[2].color := cl_ltgray;
  alab2[3].color := cl_ltgray;
label2.caption := '1';
end else
 if (posi = 3) then
begin
  alaband[0].color := $FFE8B8;
  alaband[1].color := cl_ltgray;
  alaband[2].color := cl_ltgray;
  alaband[3].color := cl_ltgray;
end else 
if (posi = 5) then
begin
alab2[1].font.color := cl_white;

alab2[0].font.color := cl_black;
alab2[2].font.color := cl_black;
alab2[3].font.color := cl_black;
 alab2[1].color := cl_ltred;
  alab2[0].color := cl_ltgray;
  alab2[2].color := cl_ltgray;
  alab2[3].color := cl_ltgray;
label2.caption := '2';
end else
if (posi = 7) then
begin
  alaband[1].color := $FFE8B8;
  alaband[0].color := cl_ltgray;
  alaband[2].color := cl_ltgray;
  alaband[3].color := cl_ltgray;
end else
if (posi = 9) then
begin
alab2[2].font.color := cl_white;
alab2[1].font.color := cl_black;
alab2[0].font.color := cl_black;
alab2[3].font.color := cl_black;
 alab2[2].color := cl_ltred;
  alab2[1].color := cl_ltgray;
  alab2[0].color := cl_ltgray;
  alab2[3].color := cl_ltgray;
label2.caption := '3';
end else 
if (posi = 11) then
begin
  alaband[2].color := $FFE8B8;
  alaband[1].color := cl_ltgray;
  alaband[0].color := cl_ltgray;
  alaband[3].color := cl_ltgray;
end else 
if (posi = 13) then
begin
alab2[3].font.color := cl_white;
alab2[1].font.color := cl_black;
alab2[2].font.color := cl_black;
alab2[0].font.color := cl_black;
 alab2[3].color := cl_ltred;
  alab2[1].color := cl_ltgray;
  alab2[2].color := cl_ltgray;
  alab2[0].color := cl_ltgray;
label2.caption := '4';
end else
if (posi = 15) then
begin
  alaband[3].color := $FFE8B8;
  alaband[1].color := cl_ltgray;
  alaband[2].color := cl_ltgray;
  alaband[0].color := cl_ltgray;
end;

// {
for ax := 0 to 15 do 
begin
if ax = posi -1 then
begin
alab[ax].color := cl_yellow;

if  ach[ax].value = true then 
begin
 ach[ax].frame.colorclient := cl_ltgreen;
Lach.color := cl_ltgreen;
end else
begin
 ach[ax].frame.colorclient := cl_yellow ;
Lach.color := cl_ltgray;
end;

if  aoh[ax].value = true then 
begin
 aoh[ax].frame.colorclient := cl_ltgreen;
Laoh.color := cl_ltgreen;
end else
begin
 aoh[ax].frame.colorclient := cl_yellow ;
Laoh.color := cl_ltgray;
end;

if  asd[ax].value = true then 
begin
asd[ax].frame.colorclient := cl_ltgreen;
Lasd.color := cl_ltgreen;
end else
begin
 asd[ax].frame.colorclient := cl_yellow ;
Lasd.color := cl_ltgray;
end;

if  abd[ax].value = true then 
begin
abd[ax].frame.colorclient := cl_ltgreen;
Labd.color := cl_ltgreen;
end else
begin
abd[ax].frame.colorclient := cl_yellow ;
Labd.color := cl_ltgray;
end;

// }
end else
begin
if (ax = 0) or (ax = 4) or  (ax = 8) or(ax = 12) then
begin
ach[ax].frame.colorclient := $FFB8B8;
aoh[ax].frame.colorclient := $FFB8B8;
asd[ax].frame.colorclient := $FFB8B8;
abd[ax].frame.colorclient := $FFB8B8;
end else
if (ax = 2) or (ax = 6) or  (ax = 10) or(ax = 14) then
begin
ach[ax].frame.colorclient := $FFF8B8;
aoh[ax].frame.colorclient := $FFF8B8;
asd[ax].frame.colorclient := $FFF8B8;
abd[ax].frame.colorclient := $FFF8B8;
end else
begin
ach[ax].frame.colorclient := cl_white;
aoh[ax].frame.colorclient := cl_white;
asd[ax].frame.colorclient := cl_white;
abd[ax].frame.colorclient := cl_white;
end;
alab[ax].color := cl_ltgray;

end;

end;

end else

begin

for ax := 0 to 3 do 
begin
alab2[ax].font.color := cl_black;
alab2[ax].color := cl_ltgray;
alaband[ax].color := cl_ltgray;
end;

for ax := 0 to 15 do 
begin
if (ax = 0) or (ax = 4) or  (ax = 8) or(ax = 12) then
begin
ach[ax].frame.colorclient := $FFB8B8;
aoh[ax].frame.colorclient := $FFB8B8;
asd[ax].frame.colorclient := $FFB8B8;
abd[ax].frame.colorclient := $FFB8B8;
end else
begin
ach[ax].frame.colorclient := cl_white;
aoh[ax].frame.colorclient := cl_white;
asd[ax].frame.colorclient := cl_white;
abd[ax].frame.colorclient := cl_white;
end;

alab[ax].color := cl_ltgray;
end;
Lach.color := cl_ltgray;
Laoh.color := cl_ltgray;
Lasd.color := cl_ltgray;
Labd.color := cl_ltgray;

label3.visible := false;
label4.visible := false;
label2.visible := false;
end;
 
 if nodrums.value = false then 
begin

 if  ach[posi-1].value = true then uos_PlaynofreePaused(0) ;
 if  aoh[posi-1].value = true then uos_PlaynofreePaused(1) ;
 if  asd[posi-1].value = true then uos_PlaynofreePaused(2) ;
 if  abd[posi-1].value = true then uos_PlaynofreePaused(3) ;
   
   // uos_SetGlobalEvent(true) was executed --> This set events (like pause/replay threads) to global.
    // One event (for example uos_replay) will have impact on all players.
    
 if (ach[posi-1].value = true) then
  uos_RePlay(0)  // A uos_replay() of each player will have impact on all players.
 else  
 if (aoh[posi-1].value = true) then
  uos_RePlay(1) // A uos_replay() of each player will have impact on all players.
 else  
 if (asd[posi-1].value = true) then
  uos_RePlay(2)  // A uos_replay() of each player will have impact on all players.
  else  
 if (abd[posi-1].value = true) then
  uos_RePlay(3) // A uos_replay() of each player will have impact on all players.
 
 end;


posi := posi + 1;

 if(posi > 16) then posi := 1;
 
// Timertick.Enabled := true;
  Timertick.tag := 0 ;
 end else 
 begin
 Timertick.Enabled := false;
 Timertick.tag := 1 ;
 {
// sleep(200);
  for ax := 0 to 8 do   
 begin
 uos_pause(ax);
 end;
// }
 end;
  
end;  

   procedure tmainfo.ShowLevel;
  begin
  
    vuLeft.Visible := True;
    vuRight.Visible := True;
    if trunc(uos_InputGetLevelLeft(theplayer, InputIndex1) * 44) >= 0 then
      vuLeft.Height := trunc(uos_InputGetLevelLeft(theplayer, InputIndex1) * 44);
    if trunc(uos_InputGetLevelRight(theplayer, InputIndex1) * 44) >= 0 then
      vuRight.Height := trunc(uos_InputGetLevelRight(theplayer, InputIndex1) * 44);
    vuLeft.top := 75 - vuLeft.Height;
    vuRight.top := 75 - vuRight.Height;
   
  end;  
 
 procedure tmainfo.ShowPosition;
  var
    temptime: ttime;
    ho, mi, se, ms: word;
  begin
  
    if (TrackBar1.Tag = 0) then
    begin
      if uos_InputPosition(theplayer, InputIndex1) > 0 then
      begin
        TrackBar1.value := uos_InputPosition(theplayer, InputIndex1) / inputlength;
        temptime := uos_InputPositionTime(theplayer, InputIndex1);
        ////// Length of input in time
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      end;
    end;
  
  end;  
  
procedure createdrumsplayers;
var
i : integer;
begin 

for i := 0 to 8 do   
 begin
 uos_Stop(i);
 
 // {
// if assigned( ams[i]) then ams[i].free; 
//ams[i] := TMemoryStream.Create; 
// ams[i].LoadFromFile(pchar(adrums[i]));  
// ams[i].Position:= 0;
 // }
   // Create a memory buffer from a audio file
 //  thebuffer[i] := uos_File2Buffer(pchar(sound[i]), 0, thebuffer[i], thebufferinfos[i]);
 
 if uos_CreatePlayer(i) then 

 if uos_SetGlobalEvent(i, true) then 
  // This set events (like pause/replay thread) to global.
  //One event (for example replay) will have impact on all players.  

  // using memorystream
 if uos_AddFromMemoryStream(i,ams[i],0,-1,2,512) > -1 then 
 
 // using memorybuffer
// if uos_AddFromMemoryBuffer(i,thebuffer[i],thebufferinfos[i], -1, 1024) > -1 then
  
 if uos_AddFromEndlessMuted(i, channels, 512) > -1 then 
  // this for a dummy endless input, must be last input 
  
 uos_AddIntoDevOut(i, -1, -1, -1, -1, 2, 512)  ;
  
end;
end;  
 
procedure tmainfo.oncreateform(const sender: TObject);
var
ax : integer;
spcx, spcy, posx, posy, i  : integer;
 lib1, lib2, lib3, lib4 : string;
begin
        visible := false;
        Timertick := ttimer.Create(nil);
        Timertick.interval := 100000;
        Timertick.tag := 0;
        Timertick.Enabled := False;
        Timertick.ontimer := @ontimertick;
        
        Timerwait := ttimer.Create(nil);
        Timerwait.interval := 100000;
        Timertick.tag := 0;
        Timerwait.Enabled := False;
        Timerwait.ontimer := @ontimerwait;
        
        Timerpause := ttimer.Create(nil);
        Timerpause.interval := 30000000;
        Timertick.tag := 0;
        Timerpause.Enabled := False;
        Timerpause.ontimer := @ontimerpause;
        
  drum_beats[0] := 'x0x0x0x0x0x0x000'; // closed hat
  drum_beats[1] := '00000000000000x0'; // opened hat
  drum_beats[2] := '0000x0000000x000'; // snare
  drum_beats[3] := 'x0000000x0x00000'; // kick
  
  spcx := 24;
  spcy := 24;
  posx := - 26;
  posy := 4;

 alab2[0] := tlabel1;
 alab2[1] := tlabel2;
 alab2[2] := tlabel3;
 alab2[3] := tlabel4;

 for ax := 0 to 3 do
  begin
   with alab2[ax] do
  begin
 width := 16;
  height := 16;
  visible := true;
  // textflags := [xcentered,tf_ycentered];
  caption := inttostr(ax +1);
   if ax = 0 then
  begin
  left := posx + 65 + (spcx * (1));
  top := posy;
  end
  else
  if ax = 1 then
  begin
  left := posx + 65 + (spcx * (5));
  top := posy;
  end  else
  if ax = 2 then
  begin
  left := posx + 65 + (spcx * (9));
  top := posy;
  end
  else
  begin
  left := posx + 65 + (spcx * (13));
  top := posy;
  end;
 // color := TfpgColor($FFD3D3D3);
  
  end;
  end;
// }  

alaband[0] := and1;
 alaband[1] := and2;
 alaband[2] := and3;
 alaband[3] := and4;

 for ax := 0 to 3 do
  begin
   with alaband[ax] do
  begin
 width := 16;
height := 16;
 visible := true;
  // textflags := [xcentered,tf_ycentered];
 caption := '&&';
   if ax = 0 then
  begin
 left := posx + 65 + (spcx * (3));
  top := posy;
  end
  else
  if ax = 1 then
  begin
  left := posx + 65 + (spcx * (7));
  top := posy;
  end  else
  if ax = 2 then
  begin
  left := posx + 65 + (spcx * (11));
  top := posy;
  end
  else
  begin
  left := posx + 65 + (spcx * (15));
  top := posy;
  end;
 // color := TfpgColor($FFD3D3D3);
  
  end;
  end;
// }  
 alab[0] := tlabel5;
 alab[1] := tlabel6;
 alab[2] := tlabel7;
 alab[3] := tlabel8;
 alab[4] := tlabel9;
 alab[5] := tlabel10;
 alab[6] := tlabel11;
 alab[7] := tlabel12;
 alab[8] := tlabel13;
 alab[9] := tlabel14;
 alab[10] := tlabel15;
 alab[11] := tlabel16;
 alab[12] := tlabel17;
 alab[13] := tlabel18;
 alab[14] := tlabel19;
 alab[15] := tlabel20;

 for ax := 0 to 15 do
  begin
  with alab[ax] do
  begin
 alab[ax].optionswidget1 := [ow1_fontglyphheight] ;
 alab[ax].width := 16;
 alab[ax].height := 16;
 alab[ax].visible := true;
  // textflags := [xcentered,tf_ycentered];
   alab[ax].caption := inttostr(ax +1);
  alab[ax].left := posx + 65 + (spcx * (ax +1));
 alab[ax].top :=  posy + (spcy * 1);
  end;
  end;

ach[0] := tbooleanedit1;
ach[1] := tbooleanedit2;
ach[2] := tbooleanedit3;
ach[3] := tbooleanedit4;
ach[4] := tbooleanedit5;
ach[5] := tbooleanedit6;
ach[6] := tbooleanedit7;
ach[7] := tbooleanedit8;
ach[8] := tbooleanedit9;
ach[9] := tbooleanedit10;
ach[10] := tbooleanedit11;
ach[11] := tbooleanedit12;
ach[12] := tbooleanedit13;
ach[13] := tbooleanedit14;
ach[14] := tbooleanedit15;
ach[15] := tbooleanedit16;

 for ax := 0 to 15 do
  begin
  with ach[ax] do
  begin
  Name := 'ch' + inttostr(ax +1);
   left := posx + 65 + (spcx * (ax +1));
   top := posy + (spcy * 2);
    width := 16;
    height := 16;
    frame.hiddenedges  := [edg_right,edg_top,edg_left,edg_bottom];
    hint := ' Add/Remove a Closed Hat at position ' + inttostr(ax +1) + ' ' ;
 
  end;
  if (Copy(drum_beats[0], ax+1, 1) = 'x') then
  ach[ax].value := true else  ach[ax].value := false;
  end;    
 
 
aoh[0] := tbooleanedit17;
aoh[1] := tbooleanedit18;
aoh[2] := tbooleanedit19;
aoh[3] := tbooleanedit20;
aoh[4] := tbooleanedit21;
aoh[5] := tbooleanedit22;
aoh[6] := tbooleanedit23;
aoh[7] := tbooleanedit24;
aoh[8] := tbooleanedit25;
aoh[9] := tbooleanedit26;
aoh[10] := tbooleanedit27;
aoh[11] := tbooleanedit28;
aoh[12] := tbooleanedit29;
aoh[13] := tbooleanedit30;
aoh[14] := tbooleanedit31;
aoh[15] := tbooleanedit32;
 
 for ax := 0 to 15 do
  begin
  with aoh[ax] do
  begin
  Name := 'oh' + inttostr(ax +1);
  left := posx + 65 + (spcx * (ax +1));
  top := posy + (spcy * 3);
  width := 16;
  height := 16;
   frame.hiddenedges  := [edg_right,edg_top,edg_left,edg_bottom];
  hint := ' Add/Remove a Open Hat at position ' + inttostr(ax +1) + ' ' ;
 
  if (Copy(drum_beats[1], ax+1, 1) = 'x') then
  value := true else  value := false;
  end;  
   end;   
   
 asd[0] := tbooleanedit33;
asd[1] := tbooleanedit34;
asd[2] := tbooleanedit35;
asd[3] := tbooleanedit36;
asd[4] := tbooleanedit37;
asd[5] := tbooleanedit38;
asd[6] := tbooleanedit39;
asd[7] := tbooleanedit40;
asd[8] := tbooleanedit41;
asd[9] := tbooleanedit42;
asd[10] := tbooleanedit43;
asd[11] := tbooleanedit44;
asd[12] := tbooleanedit45;
asd[13] := tbooleanedit46;
asd[14] := tbooleanedit47;
asd[15] := tbooleanedit48;
 
 for ax := 0 to 15 do
  begin
  with asd[ax] do
  begin
  Name := 'sd' + inttostr(ax +1);
  left := posx + 65 + (spcx * (ax +1));
  top := posy + (spcy * 4);
  width := 16;
  height := 16;
  frame.hiddenedges  := [edg_right,edg_top,edg_left,edg_bottom];
   hint := ' Add/Remove a Snare Drum at position ' + inttostr(ax +1) + ' ' ;
 
  if (Copy(drum_beats[2], ax+1, 1) = 'x') then
  value := true else  value := false;
  end;  
   end;  
   
abd[0] := tbooleanedit49;
abd[1] := tbooleanedit50;
abd[2] := tbooleanedit51;
abd[3] := tbooleanedit52;
abd[4] := tbooleanedit53;
abd[5] := tbooleanedit54;
abd[6] := tbooleanedit55;
abd[7] := tbooleanedit56;
abd[8] := tbooleanedit57;
abd[9] := tbooleanedit58;
abd[10] := tbooleanedit59;
abd[11] := tbooleanedit60;
abd[12] := tbooleanedit61;
abd[13] := tbooleanedit62;
abd[14] := tbooleanedit63;
abd[15] := tbooleanedit64;

 for ax := 0 to 15 do
  begin
  with abd[ax] do
  begin
  Name := 'bd' + inttostr(ax +1);
  left := posx + 65 + (spcx * (ax +1));
  top := posy + (spcy * 5);
  width := 16;
  height := 16;
   frame.hiddenedges  := [edg_right,edg_top,edg_left,edg_bottom];
  hint := ' Add/Remove a Bass Drum at position ' + inttostr(ax +1) + ' ' ;
 
  if (Copy(drum_beats[3], ax+1, 1) = 'x') then
  value := true else  value := false;
  end;  
   end;       
 
 
 for ax := 0 to 15 do
  begin
if (ax = 0) or (ax = 4) or  (ax = 8) or(ax = 12) then
begin
ach[ax].frame.colorclient := $FFB8B8;
aoh[ax].frame.colorclient := $FFB8B8;
asd[ax].frame.colorclient := $FFB8B8;
abd[ax].frame.colorclient := $FFB8B8;
end 
else
if (ax = 2) or (ax = 6) or  (ax = 10) or(ax = 14) then
begin
ach[ax].frame.colorclient := $FFF8B8;
aoh[ax].frame.colorclient := $FFF8B8;
asd[ax].frame.colorclient := $FFF8B8;
abd[ax].frame.colorclient := $FFF8B8;
end else
begin
ach[ax].frame.colorclient := cl_white;
aoh[ax].frame.colorclient := cl_white;
asd[ax].frame.colorclient := cl_white;
abd[ax].frame.colorclient := cl_white;
end;
 end;
  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

    {$IFDEF Windows}
         {$if defined(cpu64)}
        lib1 := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
        lib2 := ordir + 'lib\Windows\64bit\LibSndFile-64.dll'; 
        lib3 := ordir + 'lib\Windows\64bit\LibMpg123-64.dll';
        lib4 := ordir + 'lib\Windows\64bit\LibSoundTouch-64.dll';

        
         {$else}
        lib1 := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
        lib2 := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
        lib3 := ordir + 'lib\Windows\32bit\LibMpg123-32.dll';
        lib4 := ordir + 'lib\Windows\32bit\LibSoundTouch-32.dll';
         {$endif}
     {$ENDIF}

     {$IFDEF linux}
        {$if defined(cpu64)}
       lib1 :=  ordir + 'lib/Linux/64bit/LibPortaudio-64.so'    ;
       lib2 := ordir + 'lib/Linux/64bit/LibSndFile-64.so'   ;
       lib3 := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
       lib4 := ordir + 'lib/Linux/64bit/LibSoundTouch-64.so';
  
        {$else}
        lib1 := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
         lib2 := ordir + 'lib/Linux/32bit/LibSndFile-32.so'   ;
         lib3 := ordir + 'lib/Linux/32bit/LibMpg123-32.so';
         lib4 := ordir + 'lib/Linux/32bit/LibSoundTouch-32.so';
        {$endif}
      {$ENDIF}

     {$IFDEF freebsd}
        {$if defined(cpu64)}
         lib1 :=  ordir + 'lib/FreeBSD/64bit/libportaudio-64.so'    ;
         lib2 := ordir + 'lib/FreeBSD/64bit/libsndfile-64.so'   ;
         lib3 := ordir + 'lib/FreeBSD/64bit/libmpg123-64.so';
         lib4 := '' ;
        {$else}
        lib1 := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
        lib2 := ordir + 'lib/FreeBSD/32bit/libsndfile-32.so'   ;
        lib3 := ordir + 'lib/FreeBSD/32bit/libmpg123-32.so';
        lib4 := '' ;
        {$endif}
      {$ENDIF}
   
if uos_LoadLib(Pchar(lib1),  Pchar(lib2), Pchar(lib3), nil, nil,nil) = 0 then

begin

  if (uos_LoadPlugin('soundtouch', Pchar(lib4)) = 0) then
       begin
     plugsoundtouch := true;
       end
         else
         begin
       plugsoundtouch := false;
         edtempo.enabled := false;
       cbtempo.enabled := false;
       Button1.enabled := false;
       label6.enabled := false;
         end;    

adrums[0] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'HH.ogg';
adrums[1] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'OH.ogg'; 
adrums[2] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'SD.ogg';
adrums[3] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'BD.ogg';

adrums[4] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'one.ogg';
adrums[5] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'two.ogg'; 
adrums[6] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'three.ogg';
adrums[7] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'four.ogg';
adrums[8] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'and.ogg';

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

 posi := 1;
 
 
// songdir.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';
 
  allok := true;
  
for i := 0 to 9 do  aguitarisplaying[i]  := false;
  
// {

// if assigned( ams[i]) then ams[i].free; 
for i := 0 to 8 do
begin
 ams[i] := TMemoryStream.Create; 
 ams[i].LoadFromFile(pchar(adrums[i]));  
 ams[i].Position:= 0;
end;

createdrumsplayers ;


for i := 0 to 7 do 
 
 begin
  uos_Playnofree(i);
  if i < 4 then sleep(250) else sleep(300) ;
  end;

 // for i := 0 to 7 do  uos_stop(i); 

   end else  application.terminate;  
   
end;

procedure tmainfo.dostart(const sender: TObject);
begin
  //createdrumsplayers ;
  stopit := false;
  Timerpause.Enabled := False;
  posi := 1;
  loop_resume.Enabled := false; 
  TimerTick.Enabled := true; 
  loop_stop.Enabled := true; 
end;

procedure tmainfo.dostop(const sender: TObject);
var
i : integer;
begin
 loop_stop.Enabled := false; 
 loop_resume.Enabled := true; 
 stopit := true; 
 Timerpause.Enabled := true; 
 
end;

procedure tmainfo.doresume(const sender: TObject);
begin
 //createdrumsplayers ;
 stopit := false;
 Timerpause.Enabled := False;
 loop_resume.Enabled := false;
 loop_stop.Enabled := true; 
 TimerTick.Enabled := true; 
end;

procedure tmainfo.onchangetempo(const sender: TObject);
begin
TimerTick.Interval := trunc(edittempo.value * 1000);
label5.caption :=  inttostr(trunc(1000/edittempo.value*60/4)) + ' BPM' ;
end;


procedure tmainfo.dopatern(const sender: TObject);
 var
 ax : integer;
begin
if tbooleaneditradio(Sender).tag = 1 then
begin
  labpat.caption := 'Lesson 1' ;
  edittempo.value  := 140;
  onchangetempo(sender);
  drum_beats[0] := 'x000x000x000x000'; // closed hat
  drum_beats[1] := '0000000000000000'; // opened hat
  drum_beats[2] := '0000000000000000'; // snare
  drum_beats[3] := '0000000000000000'; // kick
  novoice.value := false;
end else
if tbooleaneditradio(Sender).tag = 2 then
begin
  labpat.caption := 'Lesson 2' ;
  edittempo.value  := 140;
  onchangetempo(sender);
  drum_beats[0] := 'x000x000x000x000'; // closed hat
  drum_beats[1] := '0000000000000000'; // opened hat
  drum_beats[2] := '0000000000000000'; // snare
  drum_beats[3] := 'x000000000000000'; // kick
  novoice.value := false;
end else
if tbooleaneditradio(Sender).tag = 3 then
begin
  labpat.caption := 'Lesson 3' ;
  edittempo.value  := 140;
  onchangetempo(sender);
  drum_beats[0] := 'x000x000x000x000'; // closed hat
  drum_beats[1] := '0000000000000000'; // opened hat
  drum_beats[2] := '00000000x0000000'; // snare
  drum_beats[3] := 'x000000000000000'; // kick
  novoice.value := false;
end else
if tbooleaneditradio(Sender).tag = 4 then
begin
  labpat.caption := 'Lesson 4' ;
  edittempo.value  := 80;
  onchangetempo(sender);
  drum_beats[0] := 'x000x000x000x000'; // closed hat
  drum_beats[1] := '0000000000000000'; // opened hat
  drum_beats[2] := '00000000x0000000'; // snare
  drum_beats[3] := 'x000x00000000000'; // kick
  novoice.value := false;
end else
if tbooleaneditradio(Sender).tag = 5 then
begin
  labpat.caption := 'Patern 1' ;
  edittempo.value  := 100;
  onchangetempo(sender);
  drum_beats[0] := 'x0x0x0x0x0x0x000'; // closed hat
  drum_beats[1] := '00000000000000x0'; // opened hat
  drum_beats[2] := '0000x0000000x000'; // snare
  drum_beats[3] := 'x0000000x0x00000'; // kick
  novoice.value := true;
end else
if tbooleaneditradio(Sender).tag = 6 then
begin
  labpat.caption := 'Patern 2' ;
 edittempo.value  := 100;
  onchangetempo(sender);
  drum_beats[0] := 'x0x0x000x0x0x0x0'; // closed hat
  drum_beats[1] := '000000x000000000'; // opened hat
  drum_beats[2] := '00x0x0000000x000'; // snare
  drum_beats[3] := 'x0000000x0x00000'; // kick
  novoice.value := true;
end else
if tbooleaneditradio(Sender).tag = 7 then
begin
  labpat.caption := 'Patern 3' ;
   edittempo.value  := 100;
  onchangetempo(sender);
  drum_beats[0] := 'x000x0x000x0x000'; // closed hat
  drum_beats[1] := '00x00000x00000x0'; // opened hat
  drum_beats[2] := '0000x0000000x000'; // snare
  drum_beats[3] := 'x00000x0x0x000x0'; // kick
  novoice.value := true;
end else
if tbooleaneditradio(Sender).tag = 8 then
begin
  labpat.caption := 'Patern 4' ;
 edittempo.value  := 100;
  onchangetempo(sender);
  drum_beats[0] := 'x000x000x000x000'; // closed hat
  drum_beats[1] := '00x000x000x000x0'; // opened hat
  drum_beats[2] := '0000x0000000x000'; // snare
  drum_beats[3] := 'x0x00000x00000x0'; // kick
  novoice.value := true;
end;
  
  for ax := 0 to 15 do
  begin
  if (Copy(drum_beats[0], ax+1, 1) = 'x') then
  ach[ax].value := true else  ach[ax].value := false;
 
  if (Copy(drum_beats[1], ax+1, 1) = 'x') then
  aoh[ax].value := true else  aoh[ax].value := false;
 
  if (Copy(drum_beats[2], ax+1, 1) = 'x') then
  asd[ax].value := true else  asd[ax].value := false;

  if (Copy(drum_beats[3], ax+1, 1) = 'x') then
  abd[ax].value := true else  abd[ax].value := false;
  end;  
  
end;

procedure tmainfo.onabout(const sender: TObject);
begin
aboutfo.caption := 'About StrumPract' ;
aboutfo.about_text.frame.colorclient := $DFFFB2;
aboutfo.about_text.value := c_linefeed+  c_linefeed +
 'StrumPract '+ versiontext + ' for '+ platformtext+  c_linefeed+
 c_linefeed + 'Compiled with FPC 3.0.2.' + c_linefeed +  c_linefeed +
 'Graphic widget: MSEgui '+mseguiversiontext + '.' + c_linefeed+
            
             'http://sourceforge.net/projects/mseide-msegui/'+
 
  c_linefeed + c_linefeed +
  'Audio library: uos (United Openlib of Sound)' + c_linefeed+ 
   'https://github.com/fredvs/uos' + c_linefeed +
   'Forum: http://uos.2369694.n4.nabble.com'+c_linefeed + c_linefeed+
 			        
             
              'Copyright 2017' + c_linefeed + 'Fred van Stappen <fiens@hotmail.com>' ;
aboutfo.show(true);
end;

procedure tmainfo.dodestroy(const sender: TObject);
var
i : integer;
begin
// gINI.writeString('songfilename', 'files', songdir.value);
//freeandnil(aboutfo);
//freeandnil(infosfo);
// if assigned(aboutfo) then aboutfo.destroy;

 freeandnil(Timertick) ;
 freeandnil(Timerwait) ;
 freeandnil(Timerpause) ;
 
 for i := 0 to 3 do
begin
  freeandnil(alab2[i]);
  freeandnil(alaband[i]);
end;

 for i := 0 to 15 do
begin
  freeandnil(alab[i]);
  freeandnil(aoh[i]);
  freeandnil(ach[i]);
  freeandnil(asd[i]);
  freeandnil(abd[i]);
end;

sleep(50);      
uos_free;
sleep(150);

end;


procedure tmainfo.doguitarstring(const sender: TObject);
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
 Tbutton(Sender).color := cl_ltgreen ;
  if uos_CreatePlayer(Tbutton(Sender).tag + 9 ) then
 if uos_AddFromFile(Tbutton(Sender).tag + 9,(pchar(aguitar[Tbutton(Sender).tag-1]))) > -1 then
 if uos_AddIntoDevOut(Tbutton(Sender).tag + 9) > -1 then
 begin
   uos_Play(Tbutton(Sender).tag + 9, -1);
   aguitarisplaying[Tbutton(Sender).tag -1 ]  := true;
 end;
 end else
 begin
 Tbutton(Sender).color := $C9BDA5 ;
  aguitarisplaying[Tbutton(Sender).tag -1 ]  := false;
 end;
  
 end;   
    
 end;   


procedure tmainfo.LoopProcPlayer1;
begin
 ShowPosition;
 ShowLevel ;
end;

procedure tmainfo.doplayerstart(const sender: TObject);
var
    samformat: shortint;
       ho, mi, se, ms: word;
  begin
 { 
    if radiobutton1.value = True then
      samformat := 0 else
    if radiobutton2.value = True then
      samformat := 1 else
    if radiobutton3.value = True then
      samformat := 2;

    radiobutton1.Enabled := False;
    radiobutton2.Enabled := False;
    radiobutton3.Enabled := False;
   }
   
     samformat := 0;
     
   //  songdir.hint := songdir.value;
     
    
    // PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // If PlayerIndex exists already, it will be overwritten...
    
     uos_Stop(theplayer) ; // done by  uos_CreatePlayer() but faster if already done before (no check)

    if uos_CreatePlayer(theplayer) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
      
     InputIndex1 := uos_AddFromFile(theplayer, pchar(AnsiString(historyfn.value)), -1, samformat, -1);
     
    //// add input from audio file with custom parameters
    ////////// FileName : filename of audio file
    //////////// PlayerIndex : Index of a existing Player
    ////////// OutputIndex : OutputIndex of existing Output // -1 : all output, -2: no output, other integer : existing output)
    ////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16) SampleFormat of Input can be <= SampleFormat float of Output
    //////////// FramesCount : default : -1 (65536 div channels)
    //  result : -1 nothing created, otherwise Input Index in array

    if InputIndex1 > -1 then
     begin
      // OutputIndex1 := uos_AddIntoDevOut(PlayerIndex1) ;
    //// add a Output into device with default parameters
    OutputIndex1 := uos_AddIntoDevOut(theplayer, -1, -1, uos_InputGetSampleRate(theplayer, InputIndex1),
     uos_InputGetChannels(theplayer, InputIndex1), samformat, -1);
    //// add a Output into device with custom parameters
    //////////// PlayerIndex : Index of a existing Player
    //////////// Device ( -1 is default Output device )
    //////////// Latency  ( -1 is latency suggested ) )
    //////////// SampleRate : delault : -1 (44100)   /// here default samplerate of input
    //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
    //////////// SampleFormat : -1 default : Int16 : (0: Float32, 1:Int32, 2:Int16)
    //////////// FramesCount : default : -1 (65536)
    //  result : -1 nothing created, otherwise Output Index in array
  
   uos_InputSetLevelEnable(theplayer, InputIndex1, 2) ;
     ///// set calculation of level/volume (usefull for showvolume procedure)
                       ///////// set level calculation (default is 0)
                          // 0 => no calcul
                          // 1 => calcul before all DSP procedures.
                          // 2 => calcul after all DSP procedures.
                          // 3 => calcul before and after all DSP procedures.

   uos_InputSetPositionEnable(theplayer, InputIndex1, 1) ;
     ///// set calculation of position (usefull for positions procedure)
                       ///////// set position calculation (default is 0)
                          // 0 => no calcul
                          // 1 => calcul position.

   uos_LoopProcIn(theplayer, InputIndex1, @LoopProcPlayer1);
 
    ///// Assign the procedure of object to execute inside the loop
    //////////// PlayerIndex : Index of a existing Player
    //////////// InputIndex1 : Index of a existing Input
    //////////// LoopProcPlayer1 : procedure of object to execute inside the loop
   
   uos_InputAddDSPVolume(theplayer, InputIndex1, 1, 1);
    ///// DSP Volume changer
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1 : Index of a existing input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume

    uos_InputSetDSPVolume(theplayer, InputIndex1, edvol.value/100, edvol.value/100, True);
     /// Set volume
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1 : InputIndex of a existing Input
    ////////// VolLeft : Left volume
    ////////// VolRight : Right volume
    ////////// Enable : Enabled
    
     {
   DSPIndex1 := uos_InputAddDSP(PlayerIndex1, InputIndex1, @DSPReverseBefore,   @DSPReverseAfter, nil, nil);
      ///// add a custom DSP procedure for input
    ////////// PlayerIndex1 : Index of a existing Player
    ////////// InputIndex1: InputIndex of existing input
    ////////// BeforeFunc : function to do before the buffer is filled
    ////////// AfterFunc : function to do after the buffer is filled
    ////////// EndedFunc : function to do at end of thread
    ////////// LoopProc : external procedure to do after the buffer is filled
   
   //// set the parameters of custom DSP
   uos_InputSetDSP(PlayerIndex1, InputIndex1, DSPIndex1, checkbox1.value);
    
   // This is a other custom DSP...stereo to mono  to show how to do a DSP ;-)  
   DSPIndex2 := uos_InputAddDSP(PlayerIndex1, InputIndex1, nil, @DSPStereo2Mono, nil, nil);
    uos_InputSetDSP(PlayerIndex1, InputIndex1, DSPIndex2, chkstereo2mono.value); 
   
   ///// add bs2b plugin with samplerate_of_input1 / default channels (2 = stereo)
  if plugbs2b = true then
  begin
   PlugInIndex1 := uos_AddPlugin(PlayerIndex1, 'bs2b',
   uos_InputGetSampleRate(PlayerIndex1, InputIndex1) , -1);
   uos_SetPluginbs2b(PlayerIndex1, PluginIndex1, -1 , -1, -1, chkst2b.value);
  end; 
  
  
  }
  /// add SoundTouch plugin with samplerate of input1 / default channels (2 = stereo)
  /// SoundTouch plugin should be the last added.
    if plugsoundtouch = true then
  begin
    PlugInIndex2 := uos_AddPlugin(theplayer, 'soundtouch', 
    uos_InputGetSampleRate(theplayer, InputIndex1) , -1);
    ChangePlugSetSoundTouch(self); //// custom procedure to Change plugin settings
   end;    
        
   inputlength := uos_InputLength(theplayer, InputIndex1);
    ////// Length of Input in samples

   tottime := uos_InputLengthTime(theplayer, InputIndex1);
    ////// Length of input in time

   DecodeTime(tottime, ho, mi, se, ms);
    
   llength.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
   
   uos_EndProc(theplayer, @ClosePlayer1);
 
    /////// procedure to execute when stream is terminated
     ///// Assign the procedure of object to execute at end
    //////////// PlayerIndex : Index of a existing Player
    //////////// ClosePlayer1 : procedure of object to execute inside the general loop
    
    btinfos.Enabled := True;
    
    trackbar1.value := 0;
    trackbar1.Enabled := True;
    btnStop.Enabled := True;
    btnresume.Enabled := False;
    if cbloop.value = true then
    begin
    uos_Play(theplayer,-1) ;
    btnpause.Enabled := false;
    end
     else
     begin
     uos_Play(theplayer) ;  /////// everything is ready, here we are, lets play it...
     btnpause.Enabled := true;
    end;
    cbloop.enabled := false; 
    songdir.value := historyfn.value;
    historyfn.hint := historyfn.value;
    Timerwait.Enabled := true;
    end else 
    begin
     showmessage( historyfn.value + ' does not exist...');
    end;
end;

procedure tmainfo.doplayeresume(const sender: TObject);
begin
  btnStop.Enabled := True;
  btnPause.Enabled := True;
  btnresume.Enabled := False;
  uos_RePlay(theplayer);
end;

procedure tmainfo.doplayerpause(const sender: TObject);
begin
    vuLeft.Visible := False;
    vuRight.Visible := False;
    vuright.Height := 0;
    vuleft.Height := 0;
    btnStop.Enabled := True;
    btnPause.Enabled := False;
    btnresume.Enabled := True;
    uos_Pause(theplayer);
end;

procedure tmainfo.doplayerstop(const sender: TObject);
begin
 uos_Stop(theplayer);
end;

procedure tmainfo.changepos(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 if TrackBar1.Tag = 0 then
   uos_InputSeek(theplayer, InputIndex1, trunc(avalue * inputlength));
 //  TrackBar1.Tag := 0;
end;

procedure tmainfo.changevolume(const sender: TObject);
begin
   uos_InputSetDSPVolume(theplayer, InputIndex1,
   edvol.value/100, edvol.value/100, True);
end;

procedure tmainfo.doentertrackbar(const sender: TObject);
begin
trackbar1.tag := 1;
end;

procedure tmainfo.doquit(const sender: TObject);
begin
application.terminate;
end;

procedure tmainfo.onreset(const sender: TObject);
begin
edtempo.value := 1;
end;

procedure tmainfo.oncreatedform(const sender: TObject);
begin
//visible := false ;
 if songdir.value = '' then
 songdir.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.ogg';
 
// if historyfn.value = '' then
// historyfn.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';
 
 historyfn.value := songdir.value ;
 
 // caption := 'StrumPract ' + versiontext ;
   
   tdockpanel1.left := 4; // this to prevent new size on new release.
   tdockpanel1.top := 6;  // this to prevent new size on new release.
   
   tdockpanel1.width := 446; // this to prevent new size on new release.
   tdockpanel1.height := 236;  // this to prevent new size on new release.
   
   tdockpanel4.left := 0; // this to prevent new size on new release.
   tdockpanel4.top := 151;  // this to prevent new size on new release.
   
   tdockpanel4.width := 446; // this to prevent new size on new release.
   tdockpanel4.height := 85;  // this to prevent new size on new release.
    
    
   width := 454;    // this to prevent new size on new release.
   height := 434;   // this to prevent new size on new release.
   
visible := true ;   

end;

procedure tmainfo.onfinfos(const sender: TObject);
var
maxwidth : integer;
temptimeinfo : ttime;
 ho, mi, se, ms: word;
begin
  uos_Stop(theplayerinfo) ;

 if uos_CreatePlayer(theplayerinfo) then
    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...
      
  if uos_AddFromFile(theplayerinfo, pchar(AnsiString(historyfn.value)), -1, 0, -1) > -1 then
  begin
  
 inputlength := uos_InputLength(theplayer, InputIndex1);
    ////// Length of Input in samples

   temptimeinfo := uos_InputLengthTime(theplayerinfo, 0);
    ////// Length of input in time

   DecodeTime(temptimeinfo, ho, mi, se, ms);
    
infosfo.infofile.caption := 'File: ' + extractfilename(historyfn.value);
infosfo.infoname.caption := 'Title: ' + msestring(ansistring(uos_InputGetTagTitle(theplayerinfo, 0)));
infosfo.infoartist.caption := 'Artist: ' + msestring(ansistring(uos_InputGetTagArtist(theplayerinfo, 0)));
infosfo.infoalbum.caption := 'Album: ' + msestring(ansistring(uos_InputGetTagAlbum(theplayerinfo, 0)));
infosfo.infoyear.caption := 'Date: ' + msestring(ansistring(uos_InputGetTagDate(theplayerinfo, 0)));
infosfo.infocom.caption := 'Comment: ' + msestring(ansistring(uos_InputGetTagComment(theplayerinfo, 0)));
infosfo.infotag.caption := 'Tag: ' + msestring(ansistring(uos_InputGetTagTag(theplayerinfo, 0)));
infosfo.infolength.caption := 'Duration: ' + format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]) ;

uos_play(theplayerinfo) ;
uos_Stop(theplayerinfo) ;

maxwidth := infosfo.infofile.width ;

if maxwidth < infosfo.infoname.width then maxwidth := infosfo.infoname.width;
if maxwidth < infosfo.infoartist.width then maxwidth := infosfo.infoartist.width;
if maxwidth < infosfo.infoalbum.width then maxwidth := infosfo.infoalbum.width;
if maxwidth < infosfo.infoyear.width then maxwidth := infosfo.infoyear.width;
if maxwidth < infosfo.infocom.width then maxwidth := infosfo.infocom.width;
if maxwidth < infosfo.infotag.width then maxwidth := infosfo.infotag.width;
if maxwidth < infosfo.infolength.width then maxwidth := infosfo.infolength.width;

infosfo.width := maxwidth + 42 ; 
// infosfo.button1.left := (infosfo.width - infosfo.button1.width)  div 2 ;
infosfo.show(true);
end;
end;

procedure tmainfo.sethistoryfn(const sender: TObject; var avalue: msestring;
               var accept: Boolean);
begin
 songdir.value := historyfn.value  ;
end;

procedure tmainfo.onmouseslider(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
if ainfo.eventkind = ek_buttonpress then trackbar1.tag := 1 else
if ainfo.eventkind =  ek_buttonrelease then trackbar1.tag := 0 ;
end;

procedure tmainfo.onsliderkeydown(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
 trackbar1.tag := 1 ;
end;

procedure tmainfo.onsliderkeyup(const sender: twidget;
               var ainfo: keyeventinfoty);
begin
 trackbar1.tag := 0 ;
end;

procedure tmainfo.onsliderchange(const sender: TObject);
 var
    temptime: ttime;
    ho, mi, se, ms: word;
begin
if (trackbar1.tag = 1) and (inputlength > 0) then
begin
        temptime := tottime *  TrackBar1.value;
        DecodeTime(temptime, ho, mi, se, ms);
        lposition.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
       
 end;
end;
 
end.
