unit spectrum1;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,msegraphedits,
 SysUtils,mseificomp,mseificompglob,mseifiglob,msescrollbar,msesimplewidgets,
 msewidgets,msechart;

type
 tspectrum1fo = class(tdockform)
   fond: tgroupbox;
   groupbox1: tgroupbox;
   tchartleft: tchart;
   groupbox2: tgroupbox;
    
   labelright: tlabel;
   labelleft: tlabel;
   tchartright: tchart;
   Spect1: tbooleanedit;
   procedure onvisiblechange(const sender: TObject);
   procedure onformcreated(const sender: TObject);
   procedure onshowspec(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure crea(const sender: TObject);
   procedure changecolors(const sender: TObject);
   procedure changesilver(const sender: TObject);
  end;
 
 
var
 spectrum1fo: tspectrum1fo;
 spectrum2fo: tspectrum1fo;
 spectrumrecfo: tspectrum1fo;
     
implementation
uses
  main, dockpanel1, songplayer, recorder, spectrum1_mfm;
 
procedure tspectrum1fo.onvisiblechange(const sender: TObject);
begin
  if Visible then
  begin
   if assigned(mainfo) then
   if caption = 'Spectrum Player 1' then
    mainfo.tmainmenu1.menu[4].submenu[9].Caption := ' Hide Spectrum 1 '
    else
    if caption = 'Spectrum Player 2' then
      mainfo.tmainmenu1.menu[4].submenu[10].Caption := ' Hide Spectrum 2 '
    else  
     if caption = 'Spectrum Recorder' then
      mainfo.tmainmenu1.menu[4].submenu[11].Caption := ' Hide Spectrum Rec ' 
  end
  else
  begin
   // dostop(Sender);
  if assigned(mainfo) then  
  if caption = 'Spectrum Player 1' then
    mainfo.tmainmenu1.menu[4].submenu[9].Caption := ' Show Spectrum 1 '
    else  if caption = 'Spectrum Player 2' then
    mainfo.tmainmenu1.menu[4].submenu[10].Caption := ' Show Spectrum 2 '
    else  if caption = 'Spectrum Recorder' then
    mainfo.tmainmenu1.menu[4].submenu[11].Caption := ' Show Spectrum Rec ';
  end;
if norefresh = false then
begin
 if assigned(mainfo) then  mainfo.updatelayout();
 if assigned(dockpanel1fo) then  if dockpanel1fo.visible then dockpanel1fo.updatelayout();
  if assigned(dockpanel2fo) then if dockpanel2fo.visible then dockpanel2fo.updatelayout();
 if assigned(dockpanel3fo) then if dockpanel3fo.visible then dockpanel3fo.updatelayout();
 if assigned(dockpanel4fo) then if dockpanel4fo.visible then dockpanel4fo.updatelayout();
 if assigned(dockpanel5fo) then if dockpanel5fo.visible then dockpanel5fo.updatelayout();
  
end;  
end;

procedure tspectrum1fo.onformcreated(const sender: TObject);
begin
//    tchartleft.traces.count := 10;
//  tchartright.traces.count := 10;

 tchartleft.traces[0].chartkind := tck_bar ;

   tchartright.traces[0].chartkind := tck_bar ;
 end;

procedure tspectrum1fo.onshowspec(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
              
begin
if avalue = false then
  if caption = 'Spectrum Player 1' then songplayerfo.resetspectrum() else
 if caption = 'Spectrum Player 2' then songplayer2fo.resetspectrum() else
if caption = 'Spectrum Recorder' then recorderfo.resetspectrum()  ;
 end;

procedure tspectrum1fo.crea(const sender: TObject);
begin
windowopacity := 0;
end;

procedure tspectrum1fo.changecolors(const sender: TObject);
begin
end;

procedure tspectrum1fo.changesilver(const sender: TObject);
begin
end;

end.
