unit dockpanel1;

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
  SysUtils,
  msetimer,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  mseforms,
  msedock,
  msedockpanelform,
  msedragglob,
  msegraphedits,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msesimplewidgets,
  msewidgets;

type
  tdockpanel1fo = class(tdockform)
    basedock: tdockpanel;
    Timerwaitdp: Ttimer;
    tmainmenu1: tmainmenu;
    procedure ontimerwait(const Sender: TObject);

    procedure updatedockev(const Sender: TObject; const awidget: twidget);
    // procedure beforereadev(const Sender: TObject);
    // procedure afterreadev(const Sender: TObject);
    // procedure onresized(const Sender: TObject);

    procedure oncreate(const Sender: TObject);

    procedure oncreated(const Sender: TObject);
    procedure ondestroy(const Sender: TObject);
    procedure onresized(const Sender: TObject);
    procedure ontab(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onvisiblech(const Sender: TObject);
    procedure setgrip(gsize: integer);

    procedure ondockv(const Sender: TObject);
  private
    flayoutlock: int32;
  protected
    procedure beginlayout();
    procedure endlayout();
  public
    procedure updatelayoutpan();
  end;

const
  emptyheight = 40;
  fowidth     = 442;
  tabheight   = 39;
  scrollwidth = 14;

var
  dockpanel1fo: tdockpanel1fo;
  dockpanel2fo: tdockpanel1fo;
  dockpanel3fo: tdockpanel1fo;
  dockpanel4fo: tdockpanel1fo;
  dockpanel5fo: tdockpanel1fo;
  maxwidthpa, maxheightpa, maxwidthfo, maxwidth: int32;


implementation

uses
  captionstrumpract,
  commander,
  drums,
  equalizer,
  filelistform,
  guitars,
  recorder,
  imagedancer,
  main,
  spectrum1,
  waveform,
  songplayer,
  infosd,
  piano,
  synthe,
  dockpanel1_mfm;

procedure tdockpanel1fo.setgrip(gsize: integer);
begin
  container.frame.sbvert.Width := gsize;

  if (commanderfo.parentwidget = basedock) then
    commanderfo.frame.grip_size := gsize;

  if (drumsfo.parentwidget = basedock) then
    drumsfo.frame.grip_size := gsize;

  if (guitarsfo.parentwidget = basedock) then
    guitarsfo.frame.grip_size := gsize;

  if (imagedancerfo.parentwidget = basedock) then
    imagedancerfo.frame.grip_size := gsize;

  if (recorderfo.parentwidget = basedock) then
    recorderfo.frame.grip_size := gsize;


  if (songplayerfo.parentwidget = basedock) then
    songplayerfo.frame.grip_size := gsize;

  if (songplayer2fo.parentwidget = basedock) then
    songplayer2fo.frame.grip_size := gsize;

  if (spectrum1fo.parentwidget = basedock) then
    spectrum1fo.frame.grip_size := gsize;

  if (spectrum2fo.parentwidget = basedock) then
    spectrum2fo.frame.grip_size := gsize;

  if (spectrumrecfo.parentwidget = basedock) then
    spectrumrecfo.frame.grip_size := gsize;

  if (equalizerfo1.parentwidget = basedock) then
    equalizerfo1.frame.grip_size := gsize;

  if (equalizerfo2.parentwidget = basedock) then
    equalizerfo2.frame.grip_size := gsize;

  if (equalizerforec.parentwidget = basedock) then
    equalizerforec.frame.grip_size := gsize;

  if (infosdfo.parentwidget = basedock) then
    infosdfo.frame.grip_size := gsize;

  if (infosdfo2.parentwidget = basedock) then
    infosdfo2.frame.grip_size := gsize;

  if (pianofo.parentwidget = basedock) then
    pianofo.frame.grip_size := gsize;

  if (synthefo.parentwidget = basedock) then
    synthefo.frame.grip_size := gsize;

  if (wavefo.parentwidget = basedock) then
    wavefo.frame.grip_size := gsize;

  if (wavefo2.parentwidget = basedock) then
    wavefo2.frame.grip_size := gsize;

  if (waveforec.parentwidget = basedock) then
    waveforec.frame.grip_size := gsize;

end;

procedure tdockpanel1fo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;
  rect1: rectty;
begin
  if (basedock.dragdock.currentsplitdir = sd_horz) or (basedock.dragdock.currentsplitdir = sd_horz) then
  begin
    //{
    children1    := basedock.dragdock.getitems();
    visiblecount := 0;

    // writeln('Number of childs: ' + inttostr(high(children1)));

    for i1 := 0 to high(children1) do
      with children1[i1] do
        if Visible then
          Inc(visiblecount)//  writeln('Child visible: ' + inttostr(i1));
    ;
    if (visiblecount = 0) then
    begin
      //  writeln('No Child visible.');
      Width           := fowidth;
      Height          := emptyheight + 20;
      //  application.ProcessMessages;
      basedock.Height := Height - 20;
      basedock.Width  := Width;
      basedock.top    := 0;
      basedock.left   := 0;
      // writeln('width: ' + inttostr(width));
      // writeln('height: ' + inttostr(height));
      // writeln('basedock.width: ' + inttostr(basedock.width));
      // writeln('basedock.height: ' + inttostr(basedock.height));
    end;
    //}

    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;


    if (fs_sbverton in container.frame.state) then
      Width := fowidth + 8
    else
      Width := fowidth;

    basedock.Width := Width;

    bounds_cxmax := bounds_cx;
    bounds_cxmin := bounds_cx;

    rect1 := application.screenrect(window);

    maxheightfo := rect1.cy - 70;

    if visiblecount = 1 then
    begin
      bounds_cymax := bounds_cy;
      bounds_cymin := bounds_cy;
    end
    else if visiblecount > 1 then
    begin
      bounds_cymax := maxheightfo;
      bounds_cymin := 50;
    end;

    if (basedock.dragdock.currentsplitdir = sd_tabed) then
      Width := fowidth;

  end;

end;

procedure tdockpanel1fo.beginlayout();
begin
  Inc(flayoutlock);
  basedock.dragdock.beginplacement();
end;

procedure tdockpanel1fo.endlayout();
begin
  Dec(flayoutlock);
  basedock.dragdock.endplacement();
  if flayoutlock = 0 then
    updatelayoutpan();
  //Timerwaitdp.Enabled := True;
end;

procedure tdockpanel1fo.updatelayoutpan();
var
  emptyheight: int32 = 50;
  totheight, totwidth: int32;
  visiblecount: int32;
  children1: widgetarty;
  decorationheight: integer;
  heights: integerarty;
  widths: integerarty;
  i1: int32;
  si1: sizety;
  thetitle : string = '';
  thetitlet : string = '';
  w1: twidget;
  rect1: rectty;
begin
  if flayoutlock <= 0 then
  begin

    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;

    if (pianofo.parentwidget <> nil) and (pianofo.Visible) then
    begin
      pianofo.bounds_cxmax := fowidth;
      pianofo.bounds_cx    := fowidth;
    end;

    if (synthefo.parentwidget <> nil) and (synthefo.Visible) then
    begin
      synthefo.bounds_cxmax := fowidth;
      synthefo.bounds_cx    := fowidth;
    end;

    if (equalizerfo1.parentwidget <> nil) and (equalizerfo1.Visible) then
    begin
      equalizerfo1.bounds_cxmax := fowidth;
      equalizerfo1.bounds_cx    := fowidth;
    end;

    if (imagedancerfo.parentwidget <> nil) and (imagedancerfo.Visible) then
    begin
      imagedancerfo.bounds_cxmax := fowidth;
      imagedancerfo.bounds_cx    := fowidth;
      imagedancerfo.bounds_cymax := imagedancerfo.bounds_cymin;
      imagedancerfo.bounds_cy    := imagedancerfo.bounds_cymin;
    end;

    if (infosdfo.parentwidget <> nil) and (infosdfo.Visible) then
    begin
      infosdfo.bounds_cxmax := fowidth;
      infosdfo.bounds_cx    := fowidth;
      infosdfo.bounds_cymax := infosdfo.bounds_cymin;
      infosdfo.bounds_cy    := infosdfo.bounds_cymax;
    end;

    if (infosdfo2.parentwidget <> nil) and (infosdfo2.Visible) then
    begin
      infosdfo2.bounds_cxmax := fowidth;
      infosdfo2.bounds_cx    := fowidth;
      infosdfo2.bounds_cymax := infosdfo2.bounds_cymin;
      infosdfo2.bounds_cy    := infosdfo2.bounds_cymax;
    end;

    if (wavefo.parentwidget <> nil) and (wavefo.Visible) then
    begin
      wavefo.bounds_cxmax := fowidth;
      wavefo.bounds_cx    := fowidth;
    end;

    if (wavefo2.parentwidget <> nil) and (wavefo2.Visible) then
    begin
      wavefo2.bounds_cxmax := fowidth;
      wavefo2.bounds_cx    := fowidth;
    end;

    if (filelistfo.parentwidget <> nil) and (filelistfo.Visible) then
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cx    := fowidth;
    end;

    if basedock.dragdock.currentsplitdir = sd_tabed then
    begin

      //  setgrip(8);

      if basedock.dragdock.activewidget <> nil then
      begin
        i1   := 0;
        //  writeln('istab');
        repeat
          w1 := basedock.dragdock.activewidget;
          basedock.size := addsize(basedock.size, subsize(w1.size, basedock.dragdock.dockrect.size));
          Inc(i1);
        until sizeisequal(w1.size, basedock.dragdock.dockrect.size) or (i1 > 8);
      end;
      si1 := basedock.size;

      if basedock.dragdock.activewidget <> nil then
        Height         := basedock.dragdock.activewidget.Height + 40;
      container.Height := Height;

      Width := fowidth;

      if norefresh = False then
        if Timerwaitdp.Enabled then
          Timerwaitdp.restart // to reset
        else
          Timerwaitdp.Enabled := True;

    end
    else if basedock.dragdock.currentsplitdir = sd_horz then
    begin
      children1    := basedock.dragdock.getitems();
      setlength(heights, length(children1));
      visiblecount := 0;
      maxwidth     := 0;
      totheight    := 0;
  //    setgrip(8);
      container.frame.sbvert.options := [sbo_thumbtrack, sbo_moveauto, sbo_showauto];
      container.frame.sbhorz.options := [];

      // writeln('Number of childs: ' + inttostr(high(children1)));

      for i1 := 0 to high(children1) do
        with children1[i1] do
        begin
          si1         := size;
          heights[i1] := si1.cy;
          if Visible then
          begin
          if i1 = 0 then
          thetitle := tdockform(children1[i1]).dragdock.Caption else
          thetitle := thetitle +  ' + ' + tdockform(children1[i1]).dragdock.Caption ;
 
            //   writeln('Child visible: ' + inttostr(i1));

            if si1.cx > maxwidth then
              maxwidth := si1.cx;
            totheight  := totheight + si1.cy;
            Inc(visiblecount);
          end
          else
            heights[i1] := 0//   writeln('Child not visible: ' + inttostr(i1));
          ;
        end;
      si1.cx := maxwidth;
      if visiblecount = 0 then
      begin
        //   writeln('basedock.width: ' + inttostr(basedock.width));
        si1.cy := emptyheight;
        si1.cx := basedock.Width; //do not change width
      end
      else
        si1.cy := totheight + (visiblecount - 1) * basedock.dragdock.splitter_size;
      basedock.size := si1;
      container.frame.scrollpos := nullpoint;
      addsize1(si1, sizety(basedock.pos));
      i1     := 0;
      repeat
        container.frame.scrollpos := nullpoint;
        size := addsize(size, subsize(si1, container.paintsize));
        Inc(i1);
      until sizeisequal(container.paintsize, si1) or (i1 > 8);
      
      
      if system.pos('(',caption) > 0 then
         thetitlet := (system.Copy(caption, 1, system.pos('(',caption) - 2))
         else thetitlet := (caption);
      
      caption := thetitlet + ' ( ' + thetitle + ' )' ;
 
      if norefresh = False then
        if Timerwaitdp.Enabled then
          Timerwaitdp.restart // to reset
        else
          Timerwaitdp.Enabled := True;

    end // fin horz

    else if basedock.dragdock.currentsplitdir = sd_vert then
    begin
      children1    := basedock.dragdock.getitems();
      setlength(widths, length(children1));
      visiblecount := 0;
      maxheightpa  := 0;
      totwidth     := 0;

      container.frame.sbhorz.options := [sbo_thumbtrack, sbo_moveauto, sbo_showauto];
      container.frame.sbvert.options := [];

      //  setgrip(8);

      // writeln('Number of childs: ' + inttostr(high(children1)));

      for i1 := 0 to high(children1) do
        with children1[i1] do
        begin
          si1        := size;
          widths[i1] := si1.cx;
          if Visible then
          begin

          if i1 = 0 then
          thetitle := tdockform(children1[i1]).dragdock.Caption else
          thetitle := thetitle +  ' + ' + tdockform(children1[i1]).dragdock.Caption ;
 
            if si1.cy > maxheightpa then
              maxheightpa := si1.cy;
            totwidth      := totwidth + si1.cx;
            Inc(visiblecount);
          end
          else
            widths[i1] := 0//   writeln('Child not visible: ' + inttostr(i1));
          ;
        end;
      // decorationheight := window.decoratedbounds_cy - Height;

      maxheightpa   := maxheightpa + 20;
      if maxheightpa > 400 then
        maxheightpa := 400;
      si1.cy := maxheightpa - 17;

      if visiblecount = 0 then
      begin
        //   writeln('basedock.width: ' + inttostr(basedock.width));
        si1.cy := emptyheight;
        si1.cx := basedock.Width; //do not change width
      end
      else
        si1.cx := totwidth + ((visiblecount - 1) * 6);
      basedock.size := si1;
      //  writeln('final basedock.width: ' + inttostr(basedock.width));
      //  writeln('final basedock.height: ' + inttostr(basedock.height));
      //   writeln('final totheight: ' + inttostr(totheight));
      //  writeln('final basedock.top: ' + inttostr(basedock.top));

      container.frame.scrollpos := nullpoint;
      addsize1(si1, sizety(basedock.pos));
      i1 := 0;
      repeat
        container.frame.scrollpos := nullpoint;
        size := addsize(size, subsize(si1, container.paintsize));
        Inc(i1);
      until sizeisequal(container.paintsize, si1) or (i1 > 8);

      //   container.frame.sbvert.width := 0;
      //   container.frame.sbhorz.width := 10;

      rect1      := application.screenrect(window);
      maxwidthfo := rect1.cx - 20;

      if maxwidthfo < bounds_cx then
        bounds_cy := bounds_cy + 10;

      bounds_cymax := bounds_cy;
      bounds_cymin := bounds_cy;
      bounds_cxmax := maxwidthfo;

      if visiblecount = 1 then
      begin
        bounds_cxmax := bounds_cx;
        bounds_cxmin := bounds_cx;
      end;
      
     if system.pos('(',caption) > 0 then
         thetitlet := (system.Copy(caption, 1, system.pos('(',caption) - 2))
         else thetitlet := (caption);
      
      caption := thetitlet + ' ( ' + thetitle + ' )' ;
    end;
  end;
end;

procedure tdockpanel1fo.updatedockev(const Sender: TObject; const awidget: twidget);
begin
  updatelayoutpan();
end;

procedure tdockpanel1fo.oncreate(const Sender: TObject);
begin
  windowopacity := 0;
  flayoutlock := 0;
  Timerwaitdp := ttimer.Create(nil);
  Timerwaitdp.options := [to_single];
  Timerwaitdp.interval := 100000;
  Timerwaitdp.Enabled := False;
  Timerwaitdp.ontimer := @ontimerwait;
  Visible := False;
end;

procedure tdockpanel1fo.oncreated(const Sender: TObject);
begin

  if Visible then
    Timerwaitdp.Enabled := True; /// for width if scroll
  // Timerwait.Enabled := true;

end;

procedure tdockpanel1fo.ondestroy(const Sender: TObject);
begin
  Timerwaitdp.Free;
end;

procedure tdockpanel1fo.onresized(const Sender: TObject);
begin
  Timerwaitdp.Enabled := False;
  Timerwaitdp.Enabled := True;
end;

procedure tdockpanel1fo.ontab(const Sender: TObject);
begin
  beginlayout();
  basedock.dragdock.currentsplitdir := sd_tabed;
  endlayout();
  // updatelayoutpan();
  // writeln('updatedtab');
end;

procedure tdockpanel1fo.ondock(const Sender: TObject);
begin
  beginlayout();
  basedock.dragdock.currentsplitdir := sd_horz;
  endlayout();
  // writeln('updateddok');
end;

procedure tdockpanel1fo.onvisiblech(const Sender: TObject);
var
  str: string;
begin
  if (isactivated = True) then
    if Assigned(mainfo) then
    begin
      if tag = 0 then
      begin
        if Visible then
          str := lang_mainfo[Ord(ma_hide)]
        else
          str := lang_mainfo[Ord(ma_tmainmenu1_show)];
        str := str + ': ';

        mainfo.tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel1']).Caption :=
          str + lang_mainfo[Ord(ma_dockpanel)] + ' 1';  {'Show Dock Panel 1'}
      end;

      if tag = 1 then
      begin
        if Visible then
          str := lang_mainfo[Ord(ma_hide)]
        else
          str := lang_mainfo[Ord(ma_tmainmenu1_show)];
        str := str + ': ';

        mainfo.tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel2']).Caption :=
          str + lang_mainfo[Ord(ma_dockpanel)] + ' 2';  {'Show Dock Panel 1'}
      end;

      if tag = 2 then
      begin
        if Visible then
          str := lang_mainfo[Ord(ma_hide)]
        else
          str := lang_mainfo[Ord(ma_tmainmenu1_show)];
        str := str + ': ';

        mainfo.tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel3']).Caption :=
          str + lang_mainfo[Ord(ma_dockpanel)] + ' 3';  {'Show Dock Panel 1'}
      end;

      if tag = 3 then
      begin
        if Visible then
          str := lang_mainfo[Ord(ma_hide)]
        else
          str := lang_mainfo[Ord(ma_tmainmenu1_show)];
        str := str + ': ';

        mainfo.tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel4']).Caption :=
          str + lang_mainfo[Ord(ma_dockpanel)] + ' 4';  {'Show Dock Panel 1'}
      end;

      if tag = 4 then
      begin
        if Visible then
          str := lang_mainfo[Ord(ma_hide)]
        else
          str := lang_mainfo[Ord(ma_tmainmenu1_show)];
        str := str + ': ';

        mainfo.tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel5']).Caption :=
          str + lang_mainfo[Ord(ma_dockpanel)] + ' 5';  {'Show Dock Panel 1'}
      end;

    end;
end;

procedure tdockpanel1fo.ondockv(const Sender: TObject);
begin
  beginlayout();
  basedock.dragdock.currentsplitdir := sd_vert;
  endlayout();
end;

end.

