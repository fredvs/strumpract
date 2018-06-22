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
   spect1: tbooleanedit;
   fond: tgroupbox;
   groupbox1: tgroupbox;
   labelleft: tlabel;
   tchartleft: tchart;
   groupbox2: tgroupbox;
   labelright: tlabel;
   tchartright: tchart;
    
   procedure onvisiblechange(const sender: TObject);
   procedure onformcreated(const sender: TObject);
   procedure onshowspec(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
  end;
 
 
var
 spectrum1fo: tspectrum1fo;
  spectrum2fo: tspectrum1fo;
     
implementation
uses
  main, dockpanel1, songplayer, spectrum1_mfm;
 
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
if norefresh = false then
begin
 if assigned(mainfo) then  mainfo.updatelayout();
 if assigned(dockpanel1fo) then  if dockpanel1fo.visible then dockpanel1fo.updatelayout();
  if assigned(dockpanel2fo) then if dockpanel2fo.visible then dockpanel2fo.updatelayout();
  
  if assigned(dockpanel3fo) then if dockpanel3fo.visible then dockpanel3fo.updatelayout();
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
 songplayer2fo.resetspectrum() ;
 end;

end.
