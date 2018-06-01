unit spectrum1;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,msegraphedits,
 SysUtils,mseificomp,mseificompglob,mseifiglob,msescrollbar,msesimplewidgets,
 msewidgets;

type
 tspectrum1fo = class(tdockform)
   groupbox1: tgroupbox;
   tprogressbar10: tprogressbar;
   tprogressbar9: tprogressbar;
   tprogressbar8: tprogressbar;
   tprogressbar7: tprogressbar;
   tprogressbar6: tprogressbar;
   tprogressbar5: tprogressbar;
   tprogressbar4: tprogressbar;
   tprogressbar3: tprogressbar;
   tprogressbar2: tprogressbar;
   tprogressbar1: tprogressbar;
   groupbox2: tgroupbox;
   tprogressbar11: tprogressbar;
   tprogressbar12: tprogressbar;
   tprogressbar13: tprogressbar;
   tprogressbar14: tprogressbar;
   tprogressbar15: tprogressbar;
   tprogressbar16: tprogressbar;
   tprogressbar17: tprogressbar;
   tprogressbar18: tprogressbar;
   tprogressbar19: tprogressbar;
   tprogressbar20: tprogressbar;
   spect1: tbooleanedit;
   procedure onvisiblechange(const sender: TObject);
   procedure onformcreated(const sender: TObject);
   procedure onshowspec(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
  end;
 
   equalizer_band_type=record
    lo_freq,hi_freq:integer;
    text:string[10];
  end;
var
 spectrum1fo: tspectrum1fo;
  spectrum2fo: tspectrum1fo;
implementation
uses
  main, dockpanel1, spectrum1_mfm;
 
procedure tspectrum1fo.onvisiblechange(const sender: TObject);
begin
  if Visible then
  begin
   if assigned(mainfo) then
   if caption = 'Spectrum Player 1' then
    mainfo.tmainmenu1.menu[3].submenu[9].Caption := ' Hide Spectrum 1 '
    else  mainfo.tmainmenu1.menu[3].submenu[10].Caption := ' Hide Spectrum 2 ';
  end
  else
  begin
   // dostop(Sender);
  if assigned(mainfo) then  
  if caption = 'Spectrum Player 1' then
    mainfo.tmainmenu1.menu[3].submenu[9].Caption := ' Show Spectrum 1 '
    else  mainfo.tmainmenu1.menu[3].submenu[10].Caption := ' Show Spectrum 2 ';
  end;

 if assigned(mainfo) then  mainfo.updatelayout();
  if dockpanel1fo.visible then dockpanel1fo.updatelayout();
  if dockpanel2fo.visible then dockpanel2fo.updatelayout();
  
  if dockpanel3fo.visible then dockpanel3fo.updatelayout();
end;

procedure tspectrum1fo.onformcreated(const sender: TObject);
var
 Equalizer_Bands:array[1..10] of equalizer_band_type;
i : integer = 1;
begin
Equalizer_Bands[1].lo_freq:=18;
   Equalizer_Bands[1].hi_freq:=46;
   Equalizer_Bands[1].Text:='31';
   Equalizer_Bands[2].lo_freq:=47;
   Equalizer_Bands[2].hi_freq:=94;
   Equalizer_Bands[2].Text:='62';
   Equalizer_Bands[3].lo_freq:=95;
   Equalizer_Bands[3].hi_freq:=188;
   Equalizer_Bands[3].Text:='125';
   Equalizer_Bands[4].lo_freq:=189;
   Equalizer_Bands[4].hi_freq:=375;
   Equalizer_Bands[4].Text:='250';
   Equalizer_Bands[5].lo_freq:=376;
   Equalizer_Bands[5].hi_freq:=750;
   Equalizer_Bands[5].Text:='500';
   Equalizer_Bands[6].lo_freq:=751;
   Equalizer_Bands[6].hi_freq:=1500;
   Equalizer_Bands[6].Text:='1K';
   Equalizer_Bands[7].lo_freq:=1501;
   Equalizer_Bands[7].hi_freq:=3000;
   Equalizer_Bands[7].Text:='2K';
   Equalizer_Bands[8].lo_freq:=3001;
   Equalizer_Bands[8].hi_freq:=6000;
   Equalizer_Bands[8].Text:='4K';
   Equalizer_Bands[9].lo_freq:=6001;
   Equalizer_Bands[9].hi_freq:=12000;
   Equalizer_Bands[9].Text:='8K';
   Equalizer_Bands[10].lo_freq:=12001;
   Equalizer_Bands[10].hi_freq:=20000;
   Equalizer_Bands[10].Text:='16K';

 while i < 21 do
  begin
  if i < 11 then
     TProgressBar(findcomponent('tprogressbar'+inttostr(i))).frame.caption:=
    Equalizer_Bands[i].Text else
     TProgressBar(findcomponent('tprogressbar'+inttostr(i))).frame.caption:=
    Equalizer_Bands[i-10].Text;    
  inc(i);
  end;

end;

procedure tspectrum1fo.onshowspec(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
var
i : integer =1;               
begin
if avalue = false then
 begin 
while i < 21 do
begin
    TProgressBar(findcomponent('tprogressbar'+inttostr(i))).value:= 0;
  inc(i);
  end; 
 end;
 end;

end.
