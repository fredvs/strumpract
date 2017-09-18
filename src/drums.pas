unit drums;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob, msetimer, mseguiglob,mseguiintf,mseapplication,msestat,msemenus,
 msegui,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,
 msesimplewidgets,msewidgets,msegraphedits,msedataedits, SysUtils,Classes,
 msedragglob,mseificomp,mseificompglob,mseifiglob,msescrollbar,msetypes,mseact,
 mseedit,msestatfile,msestream,msestrings;

type
 talab =  array[0..15] of tlabel;
 talab2 =  array[0..3] of tlabel;
 tcheck = array[0..15] of tbooleanedit;

type
 tdrumsfo = class(tdockform)
   Timertick: Ttimer;
   Timerpause: Ttimer;
   tfacedrums: tfacecomp;
   tdockpanel1: tgroupbox;
   and4: tlabel;
   and3: tlabel;
   and2: tlabel;
   and1: tlabel;
   labd: tlabel;
   lasd: tlabel;
   laoh: tlabel;
   lach: tlabel;
   tlabel1: tlabel;
   tlabel2: tlabel;
   tlabel3: tlabel;
   tlabel4: tlabel;
   tlabel5: tlabel;
   tlabel6: tlabel;
   tlabel7: tlabel;
   tlabel8: tlabel;
   tlabel9: tlabel;
   tlabel10: tlabel;
   tlabel11: tlabel;
   tlabel12: tlabel;
   tlabel17: tlabel;
   tlabel18: tlabel;
   tlabel19: tlabel;
   tlabel20: tlabel;
   labpat: tlabel;
   panel1: tgroupbox;
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
   label4: tlabel;
   label2: tlabel;
   label3: tlabel;
   label5: tlabel;
   edittempo: trealspinedit;
   tlabel25: tlabel;
   tlabel26: tlabel;
   tlabel13: tlabel;
   tlabel14: tlabel;
   tlabel15: tlabel;
   tlabel16: tlabel;
   tbooleanedit1: tbooleanedit;
   tbooleanedit2: tbooleanedit;
   tbooleanedit3: tbooleanedit;
   tbooleanedit4: tbooleanedit;
   tbooleanedit5: tbooleanedit;
   tbooleanedit6: tbooleanedit;
   tbooleanedit7: tbooleanedit;
   tbooleanedit8: tbooleanedit;
   tbooleanedit9: tbooleanedit;
   tbooleanedit10: tbooleanedit;
   tbooleanedit11: tbooleanedit;
   tbooleanedit12: tbooleanedit;
   tbooleanedit13: tbooleanedit;
   tbooleanedit14: tbooleanedit;
   tbooleanedit15: tbooleanedit;
   tbooleanedit16: tbooleanedit;
   tbooleanedit17: tbooleanedit;
   tbooleanedit18: tbooleanedit;
   tbooleanedit19: tbooleanedit;
   tbooleanedit20: tbooleanedit;
   tbooleanedit21: tbooleanedit;
   tbooleanedit22: tbooleanedit;
   tbooleanedit23: tbooleanedit;
   tbooleanedit24: tbooleanedit;
   tbooleanedit25: tbooleanedit;
   tbooleanedit26: tbooleanedit;
   tbooleanedit27: tbooleanedit;
   tbooleanedit28: tbooleanedit;
   tbooleanedit29: tbooleanedit;
   tbooleanedit30: tbooleanedit;
   tbooleanedit31: tbooleanedit;
   tbooleanedit32: tbooleanedit;
   tbooleanedit33: tbooleanedit;
   tbooleanedit34: tbooleanedit;
   tbooleanedit35: tbooleanedit;
   tbooleanedit36: tbooleanedit;
   tbooleanedit37: tbooleanedit;
   tbooleanedit38: tbooleanedit;
   tbooleanedit39: tbooleanedit;
   tbooleanedit40: tbooleanedit;
   tbooleanedit41: tbooleanedit;
   tbooleanedit42: tbooleanedit;
   tbooleanedit43: tbooleanedit;
   tbooleanedit44: tbooleanedit;
   tbooleanedit45: tbooleanedit;
   tbooleanedit46: tbooleanedit;
   tbooleanedit47: tbooleanedit;
   tbooleanedit48: tbooleanedit;
   tbooleanedit49: tbooleanedit;
   tbooleanedit50: tbooleanedit;
   tbooleanedit51: tbooleanedit;
   tbooleanedit52: tbooleanedit;
   tbooleanedit53: tbooleanedit;
   tbooleanedit54: tbooleanedit;
   tbooleanedit55: tbooleanedit;
   tbooleanedit56: tbooleanedit;
   tbooleanedit57: tbooleanedit;
   tbooleanedit58: tbooleanedit;
   tbooleanedit59: tbooleanedit;
   tbooleanedit60: tbooleanedit;
   tbooleanedit61: tbooleanedit;
   tbooleanedit62: tbooleanedit;
   tbooleanedit63: tbooleanedit;
   tbooleanedit64: tbooleanedit;
   tfacecomp2: tfacecomp;
   procedure ontimertick(const Sender: TObject);
   procedure ontimerpause(const Sender: TObject);
   procedure dostart(const sender: TObject);
   procedure dostop(const sender: TObject);
   procedure doresume(const sender: TObject);
   procedure onchangetempo(const sender: TObject);
   procedure dopatern(const sender: TObject);
   procedure createdrumsplayers;
   procedure createvoiceplayers;
   procedure stopvoiceplayers;
   procedure visiblechangeev(const sender: TObject);
   procedure oncreatedrums(const sender: TObject);
   procedure oncreateddrums(const sender: TObject);
   
   procedure onmousewindow(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure onsetnovoice(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure ondestroi(const sender: TObject);
 end;
var
 drumsfo: tdrumsfo;
  posi :integer = 1;
  initdrum : integer = 1;
  adrums: array[0..8] of string;
 drum_beats: array[0..3] of string; 
 ams :  array[0..8] of Tmemorystream; 
  alab : talab;
 alab2 : talab2;
 alaband : talab2;
  ach, aoh, asd, abd : tcheck;
implementation
uses
main, uos_flat,
 drums_mfm;
 
 procedure tdrumsfo.ontimerpause(const Sender: TObject);
var
i : integer;
begin 
Timerpause.Enabled := False;
label2.caption := '0';
for i:=0 to 8 do uos_pause(i);
end; 
 
procedure tdrumsfo.ontimertick(const Sender: TObject);
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
 
 if noanim.value = false then
begin
 application.lock();    
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
 label2.font.color := $40733D;
 
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

posi := posi + 1;

 if(posi > 16) then posi := 1;
 
// Timertick.Enabled := true;
  Timertick.tag := 0 ;
  
    application.unlock();
 end else 
 begin
 Timertick.Enabled := false;
 Timertick.tag := 1 ;

  end;
 end;

 procedure tdrumsfo.dostart(const sender: TObject);
begin
  stopit := false;
  label2.enabled := true;
  Timerpause.Enabled := False;
  posi := 1;
  loop_resume.Enabled := false; 
  TimerTick.Enabled := true; 
  loop_stop.Enabled := true; 
end;

procedure tdrumsfo.dostop(const sender: TObject);
begin
 label2.enabled := false;
 loop_stop.Enabled := false; 
 loop_resume.Enabled := true; 
 stopit := true; 
 Timerpause.Enabled := true; 
end;

procedure tdrumsfo.doresume(const sender: TObject);
begin
 label2.enabled := false;
 stopit := false;
 Timerpause.Enabled := False;
 loop_resume.Enabled := false;
 loop_stop.Enabled := true; 
 TimerTick.Enabled := true; 

end;

procedure tdrumsfo.onchangetempo(const sender: TObject);
begin

TimerTick.Interval := trunc(edittempo.value * 1000);
label5.caption :=  inttostr(trunc(1000/edittempo.value*60/4)) + ' BPM' ;

end;


procedure tdrumsfo.dopatern(const sender: TObject);
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
 // novoice.value := false;
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
 //  novoice.value := false;
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
 // novoice.value := false;
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
 // novoice.value := false;
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
 // novoice.value := true;
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
 // novoice.value := true;
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
 // novoice.value := true;
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
 // novoice.value := true;
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

procedure tdrumsfo.visiblechangeev(const sender: TObject);
begin
{
if visible then begin
  mainfo.tmainmenu1.menu[0].hint := ' Hide Drums ' ;
 end
 else begin
  mainfo.tmainmenu1.menu[0].hint := ' Show Drums ' ;
 end;
 }
 mainfo.updatelayout();
end;

procedure tdrumsfo.createdrumsplayers;
var
i : integer;
begin 

for i := 0 to 3 do   
 begin
 uos_Stop(i);
 
 ams[i] := TMemoryStream.Create; 
 ams[i].LoadFromFile(pchar(adrums[i]));  
 ams[i].Position:= 0;
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

procedure tdrumsfo.stopvoiceplayers;
//var
//i : integer;
begin 
{
for i := 4 to 8 do   
 begin
 uos_Stop(i);
 end;
}
 end;

procedure tdrumsfo.createvoiceplayers;
var
i : integer;
timerisenabled : boolean = false; 
begin 

if timertick.enabled = true then timerisenabled := true;
timertick.enabled := false;
if tag = 0 then
for i := 4 to 8 do   
 begin
 uos_Stop(i);
// uos_freeplayer(i);
  
 ams[i] := TMemoryStream.Create; 
 ams[i].LoadFromFile(pchar(adrums[i]));  
 ams[i].Position:= 0;
 
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
tag := 1;
if timerisenabled = true then timertick.enabled := true; 

end;   


procedure tdrumsfo.oncreatedrums(const sender: TObject);
var
ordir : string;
spcx, spcy, posx, posy, ax  : integer;
lib1, lib2, lib3, lib4 : string;
 i1: int32;
begin
// visible := false;
       
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
      
         {$if defined(cpu64) and defined(linux) }
   lib1 := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
  lib2 := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
  lib3 := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
  lib4 := ordir + 'lib/Linux/64bit/LibSoundTouch-64.so';
     {$ENDIF}
  {$if defined(cpu86) and defined(linux)}
  lib1 := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
  lib2 := ordir + 'lib/Linux/32bit/LibSndFile-32.so';
   lib3 := ordir + 'lib/Linux/32bit/LibMpg123-32.so';
   lib4 := ordir + 'lib/Linux/32bit/LibSoundTouch-32.so';
  {$ENDIF}
   {$if defined(linux) and defined(cpuarm)}
  lib1 := ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so';
  lib2 := ordir + 'lib/Linux/arm_raspberrypi/libsndfile-arm.so';
  lib3 := ordir + 'lib/Linux/arm_raspberrypi/libmpg123-arm.so';
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
        plugsoundtouch := true
         else
        plugsoundtouch := false;
        
   // songdir.value :=  ordir + 'sound' + directoryseparator +  'song' + directoryseparator + 'test.mp3';
 
  allok := true;
  
   end   else  application.terminate;  

        Timertick := ttimer.Create(nil);
        Timertick.interval := 100000;
        Timertick.tag := 0;
        Timertick.Enabled := False;
        Timertick.ontimer := @ontimertick;
        
        Timerpause := ttimer.Create(nil);
        Timerpause.interval := 30000000;    
        Timerpause.Enabled := False;
        Timerpause.ontimer := @ontimerpause;

  drum_beats[0] := 'x0x0x0x0x0x0x000'; // closed hat
  drum_beats[1] := '00000000000000x0'; // opened hat
  drum_beats[2] := '0000x0000000x000'; // snare
  drum_beats[3] := 'x0000000x0x00000'; // kick
       
  spcx := 24;
  spcy := 24;
  posx := - 26;
  posy := 6;

 alab2[0] := tlabel1;
 alab2[1] := tlabel2;
 alab2[2] := tlabel3;
 alab2[3] := tlabel4;
 for i1:= 0 to high(alab2) do begin
  alab2[i1].createfont();
 end;

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
 
adrums[0] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'HH.ogg';
adrums[1] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'OH.ogg'; 
adrums[2] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'SD.ogg';
adrums[3] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'BD.ogg';

adrums[4] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'one.ogg';
adrums[5] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'two.ogg'; 
adrums[6] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'three.ogg';
adrums[7] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'four.ogg';
adrums[8] := ordir + 'sound' + directoryseparator +  'voice' + directoryseparator + 'and.ogg';
 
 
// if assigned( ams[i]) then ams[i].free; 

 createdrumsplayers ;

 posi := 1;
 
{
for i := 0 to 3 do 
 
 begin
  uos_Playnofree(i);
  if i < 4 then sleep(250) else sleep(300) ;
  end; 
}  
        
end;

procedure tdrumsfo.oncreateddrums(const sender: TObject);
begin
//height := 238;
//width := 458;
caption := 'Drums set';
end;

procedure tdrumsfo.onmousewindow(const sender: twidget;
               var ainfo: mouseeventinfoty);
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

procedure tdrumsfo.onsetnovoice(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);

begin


if (avalue = false) and (tag = 0) then
createvoiceplayers;
// else stopvoiceplayers;

end;

procedure tdrumsfo.ondestroi(const sender: TObject);
begin
Timerpause.free;
Timertick.free;
end;
 
end.
