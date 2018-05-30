unit dockpanel1;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 sysutils, msetimer,msegraphics,msegraphutils,mseevent,mseclasses,mseforms,
 msedock,msedockpanelform,msedragglob,msegraphedits,mseificomp,mseificompglob,
 mseifiglob,msescrollbar,msesimplewidgets,msewidgets;

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
      
   procedure oncreate(const sender: TObject);
  
   procedure oncreated(const sender: TObject);
   procedure ondestroy(const sender: TObject);
   procedure onresized(const sender: TObject);
   procedure ontab(const sender: TObject);
   procedure ondock(const sender: TObject);
   procedure layoutchanged(const sender: tdockcontroller);
   procedure onfloat(const sender: TObject);
   private
    flayoutlock: int32;
  protected
    procedure beginlayout();
    procedure endlayout();
  public
    procedure updatelayout();
 end;
 
 const
 emptyheight = 40;
  fowidth = 458;
  tabheight = 39;
  maxheightfo = 600;
  scrollwidth = 14;
 
 var
 dockpanel1fo: tdockpanel1fo;
 dockpanel2fo: tdockpanel1fo;
 dockpanel3fo: tdockpanel1fo;

implementation
uses
 dockpanel1_mfm;
 
 
procedure tdockpanel1fo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;

begin
  Timerwaitdp.Enabled := False;

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

 
  if (fs_sbverton in container.frame.state) then
    Width := fowidth + scrollwidth
  else
    Width := fowidth;
    
 //   Width := fowidth + scrollwidth;
    
   
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
    updatelayout();
 //Timerwaitdp.Enabled := True;
end;

procedure tdockpanel1fo.updatelayout();
var
  maxwidth: int32;
  emptyheight : int32 = 50;
  totheight: int32;
  totchildheight: int32;
  visiblecount: int32;
  children1: widgetarty;
  heights: integerarty;
  i1: int32;
  si1, si2, si3: sizety;
  w1: twidget;
begin
 if flayoutlock <= 0 then
   begin
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
      totchildheight := 0;

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
  
 //  basedock.height := height+100;
 
 //{ 
   if basedock.dragdock.currentsplitdir = sd_tabed then
   begin
  // 
   if basedock.dragdock.activewidget <> nil then
    height :=basedock.dragdock.activewidget.height + 40;
   container.height := height;
   end;
//}

//container.height := basedock.height + 150;

  Timerwaitdp.Enabled := False; // to reset
  Timerwaitdp.Enabled := True;
end;

procedure tdockpanel1fo.updatedockev(const Sender: TObject; const awidget: twidget);
begin
  updatelayout();
end; 

procedure tdockpanel1fo.oncreate(const sender: TObject);
begin
flayoutlock := 0;
  Timerwaitdp := ttimer.Create(nil);
  Timerwaitdp.interval := 250000;
  Timerwaitdp.Enabled := False;
  Timerwaitdp.ontimer := @ontimerwait;
end;

procedure tdockpanel1fo.oncreated(const sender: TObject);
begin
 
   Timerwaitdp.Enabled := True; /// for width if scroll
   // Timerwait.Enabled := true;
end;

procedure tdockpanel1fo.ondestroy(const sender: TObject);
begin
 Timerwaitdp.Free;
 end;

procedure tdockpanel1fo.onresized(const sender: TObject);
begin
 //Timerwaitdp.Enabled := False;
 // Timerwaitdp.Enabled := True;
end;

procedure tdockpanel1fo.ontab(const sender: TObject);
begin
 beginlayout();
  basedock.dragdock.currentsplitdir := sd_tabed;
 endlayout();
 // updatelayout();
 // writeln('updatedtab');
end;

procedure tdockpanel1fo.ondock(const sender: TObject);
begin
 beginlayout();
basedock.dragdock.currentsplitdir := sd_horz;
  endlayout();
// writeln('updateddok');
end;

procedure tdockpanel1fo.layoutchanged(const sender: tdockcontroller);
begin
//writeln('updated');
//updatelayout();
end;

procedure tdockpanel1fo.onfloat(const sender: TObject);
begin

end;

end.
