unit dockpanel1;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msegui,
  SysUtils, msetimer, msegraphics, msegraphutils, mseevent, mseclasses, mseforms,
  msedock, msedockpanelform, msedragglob, msegraphedits, mseificomp, mseificompglob,
  mseifiglob, msescrollbar, msesimplewidgets, msewidgets;
  

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
  fowidth = 442;
  tabheight = 39;
  scrollwidth = 14;

var
  dockpanel1fo: tdockpanel1fo;
  dockpanel2fo: tdockpanel1fo;
  dockpanel3fo: tdockpanel1fo;
  dockpanel4fo: tdockpanel1fo;
  dockpanel5fo: tdockpanel1fo;

implementation

uses
  captionstrumpract,
  main, dockpanel1_mfm;

procedure tdockpanel1fo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;
   rect1: rectty;
  
begin
  // Timerwaitdp.Enabled := False;

  //{
  children1 := basedock.dragdock.getitems();
  visiblecount := 0;
  
  // writeln('Number of childs: ' + inttostr(high(children1)));

  for i1 := 0 to high(children1) do
    with children1[i1] do
      if Visible then
      begin
        //  writeln('Child visible: ' + inttostr(i1));
        Inc(visiblecount);
      end;
  if (visiblecount = 0) then
  begin
    //  writeln('No Child visible.');
    Width := fowidth;
    Height := emptyheight + 20;
    //  application.ProcessMessages;
    basedock.Height := Height - 20;
    basedock.Width := Width;
    basedock.top := 0;
    basedock.left := 0;
    // writeln('width: ' + inttostr(width));
    // writeln('height: ' + inttostr(height));
    // writeln('basedock.width: ' + inttostr(basedock.width));
    // writeln('basedock.height: ' + inttostr(basedock.height));
  end;
  //}

    bounds_cxmax := 0;
    bounds_cxmin := 0;


  if (fs_sbverton in container.frame.state) then
    Width := fowidth + 12
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

  //   Width := fowidth + scrollwidth;
  // onvisiblech(Sender);
  
   
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
  maxwidth: int32;
  emptyheight: int32 = 50;
  totheight: int32;
  visiblecount: int32;
  children1: widgetarty;
  heights: integerarty;
  i1: int32;
  si1 : sizety;
  w1: twidget;
begin
  if flayoutlock <= 0 then
  begin

    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;

    if basedock.dragdock.currentsplitdir = sd_tabed then
    begin

      if basedock.dragdock.activewidget <> nil then

      begin
        i1 := 0;
        //  writeln('istab');
        repeat
          w1 := basedock.dragdock.activewidget;
          basedock.size := addsize(basedock.size, subsize(w1.size, basedock.dragdock.dockrect.size));
          Inc(i1);
        until sizeisequal(w1.size, basedock.dragdock.dockrect.size) or (i1 > 8);
      end;
      si1 := basedock.size;

    end
    else
    begin
      children1 := basedock.dragdock.getitems();
      setlength(heights, length(children1));
      visiblecount := 0;
      maxwidth := 0;
      totheight := 0;
     
      // writeln('Number of childs: ' + inttostr(high(children1)));

      for i1 := 0 to high(children1) do
      begin
        with children1[i1] do
        begin
          si1 := size;
          heights[i1] := si1.cy;
          if Visible then
          begin

            //   writeln('Child visible: ' + inttostr(i1));

            if si1.cx > maxwidth then
            begin
              maxwidth := si1.cx;
            end;
            totheight := totheight + si1.cy;
            Inc(visiblecount);
          end
          else
          begin
            //   writeln('Child not visible: ' + inttostr(i1));
            heights[i1] := 0;
          end;
        end;
      end;
      si1.cx := maxwidth;
      if visiblecount = 0 then
      begin
        //   writeln('basedock.width: ' + inttostr(basedock.width));
        si1.cy := emptyheight;
        si1.cx := basedock.Width; //do not change width
      end
      else
      begin
        si1.cy := totheight + (visiblecount - 1) * basedock.dragdock.splitter_size;
      end;
      basedock.size := si1;
      //  writeln('final basedock.width: ' + inttostr(basedock.width));
      //  writeln('final basedock.height: ' + inttostr(basedock.height));
      //   writeln('final totheight: ' + inttostr(totheight));
      //  writeln('final basedock.top: ' + inttostr(basedock.top));
    end;

    container.frame.scrollpos := nullpoint;
    addsize1(si1, sizety(basedock.pos));
    i1 := 0;
    repeat
      container.frame.scrollpos := nullpoint;
      size := addsize(size, subsize(si1, container.paintsize));
      Inc(i1);
    until sizeisequal(container.paintsize, si1) or (i1 > 8);

  end;

  //{
  if basedock.dragdock.currentsplitdir = sd_tabed then
  begin

    if basedock.dragdock.activewidget <> nil then
      Height := basedock.dragdock.activewidget.Height + 40;
    container.Height := Height;
  end;
  //}
if norefresh = false then begin

if Timerwaitdp.Enabled then
  Timerwaitdp.restart // to reset
 else Timerwaitdp.Enabled := True;
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
  visible := false;
end;

procedure tdockpanel1fo.oncreated(const Sender: TObject);
begin

 if visible then Timerwaitdp.Enabled := True; /// for width if scroll
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
if  (isactivated = true) then
begin
  if assigned(mainfo) then
  begin
   if tag = 0 then
    begin  
     if visible then str := lang_mainfo[Ord(ma_hide)] else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
      str := str + ': ' ;
      
       mainfo.tmainmenu1.menu.itembynames(['show','panels','showpanel1']).caption := 
        str + lang_mainfo[Ord(ma_dockpanel)] + ' 1' ;  {'Show Dock Panel 1'}
    end;
    
    if tag = 1 then
    begin  
     if visible then str := lang_mainfo[Ord(ma_hide)] else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
      str := str + ': ' ;
      
       mainfo.tmainmenu1.menu.itembynames(['show','panels','showpanel2']).caption := 
        str + lang_mainfo[Ord(ma_dockpanel)] + ' 2' ;  {'Show Dock Panel 1'}
    end;
    
    if tag = 2 then
    begin  
     if visible then str := lang_mainfo[Ord(ma_hide)] else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
      str := str + ': ' ;
      
       mainfo.tmainmenu1.menu.itembynames(['show','panels','showpanel3']).caption := 
        str + lang_mainfo[Ord(ma_dockpanel)] + ' 3' ;  {'Show Dock Panel 1'}
    end;
    
    if tag = 3 then
    begin  
     if visible then str := lang_mainfo[Ord(ma_hide)] else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
      str := str + ': ' ;
      
       mainfo.tmainmenu1.menu.itembynames(['show','panels','showpanel4']).caption := 
        str + lang_mainfo[Ord(ma_dockpanel)] + ' 4' ;  {'Show Dock Panel 1'}
    end;
    
    if tag = 4 then
    begin  
     if visible then str := lang_mainfo[Ord(ma_hide)] else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
      str := str + ': ' ;
      
       mainfo.tmainmenu1.menu.itembynames(['show','panels','showpanel5']).caption := 
        str + lang_mainfo[Ord(ma_dockpanel)] + ' 5' ;  {'Show Dock Panel 1'}
    end;
    
   end;
 end;
end;

end.
