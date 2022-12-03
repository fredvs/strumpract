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
  captionstrumpract,
  main,
  dockpanel1,
  songplayer,
  recorder,
  spectrum1_mfm;

procedure tspectrum1fo.onvisiblechange(const Sender: TObject);
begin
 if  (isactivated = true) then
 begin  
     if tag = 0 then
     if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrum1']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];       
   
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrum1']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' + 
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];       
      end;
      
     if tag = 1 then
     if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrum2']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];       
   
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrum2']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' + 
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];       
      end;
      
     if tag = 2 then
     if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrumrec']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)];       
   
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showspectrumrec']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' + 
          lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)];        
      end;   
      
   
      if (norefresh = False) and (parentwidget <> nil) then
      begin
     
       if (parentwidget = mainfo.basedock) or 
       (mainfo.basedock.dragdock.currentsplitdir = sd_tabed) then
          mainfo.updatelayoutstrum();
      
      if (parentwidget = dockpanel1fo.basedock) or 
       (dockpanel1fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();
     
      if (parentwidget = dockpanel2fo.basedock) or 
       (dockpanel2fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();
     
      if (parentwidget = dockpanel3fo.basedock) or 
       (dockpanel3fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();
      
      if (parentwidget = dockpanel4fo.basedock) or 
       (dockpanel4fo.basedock.dragdock.currentsplitdir = sd_tabed) then
      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();
      
      if (parentwidget = dockpanel5fo.basedock) or 
       (dockpanel5fo.basedock.dragdock.currentsplitdir = sd_tabed) then
      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayoutpan();
      end; 
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
    if tag = 0 then
      songplayerfo.resetspectrum()
    else if tag = 1 then
      songplayer2fo.resetspectrum()
    else if tag = 2 then
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

