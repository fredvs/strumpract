unit spectrum1;

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
  msegraphedits,
  SysUtils,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msesimplewidgets,
  msewidgets,
  msechart,
  msedispwidgets,
  mserichstring;

type
  tspectrum1fo = class(tdockform)
    fond: tgroupbox;
    groupbox1: tgroupbox;
    tchartleft: tchart;
    groupbox2: tgroupbox;

    labelright: tlabel;
    labelleft: tlabel;
    tchartright: tchart;
    tstringdisp2: tstringdisp;
    Spect1: tbooleanedit;
    procedure onvisiblechange(const Sender: TObject);
    procedure onformcreated(const Sender: TObject);
    procedure onshowspec(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure crea(const Sender: TObject);
    procedure changecolors(const Sender: TObject);
    procedure changesilver(const Sender: TObject);
  end;


var
  spectrum1fo: tspectrum1fo;
  spectrum2fo: tspectrum1fo;
  spectrumrecfo: tspectrum1fo;

implementation

uses
  main,
  dockpanel1,
  songplayer,
  recorder,
  spectrum1_mfm;

procedure tspectrum1fo.onvisiblechange(const Sender: TObject);
begin
  if Visible then
  begin
    if Assigned(mainfo) then
      if Caption = 'Spectrum Player 1' then
        mainfo.tmainmenu1.menu[4].submenu[9].Caption  := ' Hide Spectrum 1 '
      else if Caption = 'Spectrum Player 2' then
        mainfo.tmainmenu1.menu[4].submenu[10].Caption := ' Hide Spectrum 2 '
      else if Caption = 'Spectrum Recorder' then
        mainfo.tmainmenu1.menu[4].submenu[11].Caption := ' Hide Spectrum Rec ';
  end
  else if Assigned(mainfo) then
    if Caption = 'Spectrum Player 1' then
      mainfo.tmainmenu1.menu[4].submenu[9].Caption  := ' Show Spectrum 1 '
    else if Caption = 'Spectrum Player 2' then
      mainfo.tmainmenu1.menu[4].submenu[10].Caption := ' Show Spectrum 2 '
    else if Caption = 'Spectrum Recorder' then
      mainfo.tmainmenu1.menu[4].submenu[11].Caption := ' Show Spectrum Rec '// dostop(Sender);
  ;
  if norefresh = False then
  begin
    if Assigned(mainfo) then
      mainfo.updatelayoutstrum();
    if Assigned(dockpanel1fo) then
      if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();
    if Assigned(dockpanel2fo) then
      if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();
    if Assigned(dockpanel3fo) then
      if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();
    if Assigned(dockpanel4fo) then
      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();
    if Assigned(dockpanel5fo) then
      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayoutpan();

  end;
end;

procedure tspectrum1fo.onformcreated(const Sender: TObject);
begin
  //    tchartleft.traces.count := 10;
  //  tchartright.traces.count := 10;

  tchartleft.traces[0].chartkind := tck_bar;

  tchartright.traces[0].chartkind := tck_bar;
end;

procedure tspectrum1fo.onshowspec(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue = False then
    if Caption = 'Spectrum Player 1' then
      songplayerfo.resetspectrum()
    else if Caption = 'Spectrum Player 2' then
      songplayer2fo.resetspectrum()
    else if Caption = 'Spectrum Recorder' then
      recorderfo.resetspectrum();
end;

procedure tspectrum1fo.crea(const Sender: TObject);
begin
  windowopacity := 0;
end;

procedure tspectrum1fo.changecolors(const Sender: TObject);
begin
end;

procedure tspectrum1fo.changesilver(const Sender: TObject);
begin
end;

end.

