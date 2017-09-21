unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msegui,msetimer,
 ctypes,msegraphics,msegraphutils,mseclasses,msewidgets,mseforms,msedock,drums,
 recorder,songplayer,songplayer2, commander, filelistform, guitars,msedataedits,mseedit,
 msestatfile,SysUtils,Classes, uos_flat, aboutform,msebitmap, msesys,msemenus,
 msestream,msegrids,mselistbrowser;
 
type
  tmainfo = class(tmainform)
   Timerwait: Ttimer;
   buttonicons: timagelist;
   tfacecomp1: tfacecomp;
   tfacecomp2: tfacecomp;
   tfacecomp3: tfacecomp;
   basedock: tdockpanel;
   tmainmenu1: tmainmenu;
   tfacecomp4: tfacecomp;
   tstatfile1: tstatfile;
   tframecomp1: tframecomp;
   tfacecomp5: tfacecomp;
   timagelist3: timagelist;
   tfacecomp6: tfacecomp;
   tfacecomp7: tfacecomp;
   procedure ontimerwait(const Sender: TObject);
   procedure oncreateform(const sender: TObject);
   procedure oncreatedform(const sender: TObject);
   procedure dodestroy(const sender: TObject);
   procedure onabout(const sender: TObject);     
   procedure showdrums(const sender: TObject);
   procedure showrecorder(const sender: TObject);
   procedure showplayer(const sender: TObject);
   procedure showplayer2(const sender: TObject);
   procedure showguitars(const sender: TObject);
   procedure onfloatall(const sender: TObject);
   procedure ondockall(const sender: TObject);
   procedure updatedockev(const sender: TObject; const awidget: twidget);
   procedure beforereadev(const sender: TObject);
   procedure afterreadev(const sender: TObject);
   procedure ontab(const sender: TObject);
   function issomeplaying : boolean;
   procedure showall(const sender: TObject);
   
   private
    flayoutlock: int32;
   protected
    procedure beginlayout();
    procedure endlayout();
   public
    procedure updatelayout();
  end;
 
const
 versiontext = '1.5';
 emptyheight = 40;
 drumsfoheight = 236;
 filelistfoheight = 122;
 guitarsfoheight = 66;
 songplayerfoheight = 130;
 recorderfoheight = 130;
 commanderfoheight = 140;
 fowidth = 458;
 tabheight = 39;
 maxheightfo = 600; 
 scrollwidth = 12;
 
var
 mainfo: tmainfo;
 tottime: ttime;
 stopit :boolean = false;
 channels : cardinal = 2 ; // stereo output
 allok : boolean = false;
 plugsoundtouch : boolean = false;
 ordir : string;
 hasinit : integer = 0;
 
implementation
uses
 main_mfm;

 procedure tmainfo.ontimerwait(const Sender: TObject);
begin 
timerwait.enabled := false;
if fs_sbverton in container.frame.state then width := fowidth + scrollwidth  else width := fowidth ;
end; 
 
 
procedure resizeall();
begin
 filelistfo.height := filelistfoheight;
end; 

procedure resizealltab();
begin
{
 mainfo.width := fowidth ;
 filelistfo.height := filelistfoheight + tabheight;;
 filelistfo.width := fowidth;
 }
end; 
   
procedure tmainfo.oncreateform(const sender: TObject);
// var x : integer;
begin
// for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;
      tstatfile1.filename :=  IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +  'status.sta';

       Timerwait := ttimer.Create(nil);
        Timerwait.interval := 300000;
        Timerwait.Enabled := False;
       Timerwait.ontimer := @ontimerwait;

end;

procedure tmainfo.onabout(const sender: TObject);
begin
aboutfo.caption := 'About StrumPract' ;
aboutfo.about_text.frame.colorclient := $DFFFB2;
aboutfo.about_text.value := c_linefeed+  c_linefeed +
 'StrumPract '+ versiontext + ' for '+ platformtext+  c_linefeed+
 c_linefeed + 'Compiled with FPC 3.0.3.' + c_linefeed +  c_linefeed +
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
begin
 uos_free();
 Timerwait.free;
end;

procedure tmainfo.oncreatedform(const sender: TObject);
begin
caption := 'StrumPract ' + versiontext;
if not fileexists(tstatfile1.filename) then
 begin
 hide;
 showall(sender);
 ondockall(sender);
  sleep(100);
  ondockall(sender); /// otherwise size of dock is not ok
 show;
 end;
 Timerwait.Enabled := true; /// for width if scroll
end;

procedure tmainfo.showguitars(const sender: TObject);
begin
 guitarsfo.visible:= not guitarsfo.visible
end;

procedure tmainfo.showrecorder(const sender: TObject);
begin
 recorderfo.visible:= not recorderfo.visible
end;

procedure tmainfo.showdrums(const sender: TObject);
begin
 drumsfo.visible:= not drumsfo.visible
end;

procedure tmainfo.showplayer(const sender: TObject);
begin
 songplayerfo.visible:= not songplayerfo.visible
end;

procedure tmainfo.showplayer2(const sender: TObject);
begin
 songplayer2fo.visible:= not songplayer2fo.visible
end;

function tmainfo.issomeplaying : boolean;
var
x : integer;
isplay : boolean = false;
begin
result := isplay;
for x:=9 to 25 do
if uos_GetStatus(x) = 1 then isplay := true;
if drumsfo.timertick.enabled = true then isplay := true;
result := isplay;
end;

procedure tmainfo.beginlayout();
begin
 inc(flayoutlock);
 basedock.dragdock.beginplacement();
end;

procedure tmainfo.endlayout();
begin
 dec(flayoutlock);
 basedock.dragdock.endplacement();
 if flayoutlock = 0 then  updatelayout();
 Timerwait.Enabled := true;
end;

procedure tmainfo.updatelayout();
var
 maxwidth: int32;
 totheight: int32;
 totchildheight: int32;
 visiblecount: int32;
 children1: widgetarty;
 heights: integerarty;
 i1: int32;
 si1,si2,si3: sizety;
 isbig : boolean = false;
 rect1: rectty;
 w1: twidget;
begin

 if flayoutlock <= 0 then begin
 
  if basedock.dragdock.currentsplitdir = sd_tabed then begin
   if basedock.dragdock.activewidget <> nil then begin
    i1:= 0;
    repeat
     w1:= basedock.dragdock.activewidget;
     size:= addsize(size,subsize(w1.size,basedock.dragdock.dockrect.size));
     inc(i1);
    until sizeisequal(w1.size,basedock.dragdock.dockrect.size) or (i1 > 8);
   
   end;
  end
  else begin
  // resizeall;
   rect1:= application.workarea();
   children1:= basedock.dragdock.getitems();
   setlength(heights,length(children1));
   visiblecount:= 0;
   maxwidth:= 0;
   totheight:= 0;
  totchildheight := 0;
   for i1:= 0 to high(children1) do begin
    with children1[i1] do begin

    {does not work because forms have fixed size;
    si1:= container.minscrollsize(); //minimal clientarea
     addsize1(si1,framedim());        //add space for frame
    }
     si1:= size;
     heights[i1]:= si1.cy;
    
     if visible then begin
      if si1.cx > maxwidth then begin
       maxwidth:= si1.cx;
      end;
      totheight:= totheight + si1.cy;
      inc(visiblecount);
     end
     else begin
     heights[i1]:= 0;
     end;
    end;
   end;

   if visiblecount = 0 then begin
    height:= emptyheight;
   end
   else begin
    i1:= 0;
     repeat
     si1:= subsize(size,basedock.paintsize); //padding before update
     si2.cx:= maxwidth + si1.cx;
     si2.cy:= totheight + (visiblecount-1) * basedock.dragdock.splitter_size +  si1.cy;
     size:= si2;
     si2:= subsize(size,basedock.paintsize); //padding after update
     inc(i1);
    until (si1.cx = si2.cx) and (si1.cy = si2.cy) or      //padding stable
                                                 (i1 > 8);  //emergency brake
   end;
   
Timerwait.Enabled := true;  // for width of main form if scrolled.

 end;
 end;
end;

procedure tmainfo.updatedockev(const sender: TObject; const awidget: twidget);
begin
 updatelayout();
end;
 
procedure tmainfo.onfloatall(const sender: TObject);
var
 rect1,rect2: rectty;
 decorationheight, posi: int32;
  si1: sizety;
 begin
 
 filelistfo.bounds_cxmax := 1024 ;
 filelistfo.bounds_cymax := 700;
 
 decorationheight:= window.decoratedbounds_cy - height;
 
 beginlayout();
 
  if drumsfo.visible then
 drumsfo.dragdock.float();
 
  if guitarsfo.visible then
 guitarsfo.dragdock.float();
 
  if songplayerfo.visible then
 songplayerfo.dragdock.float();
 
  if songplayer2fo.visible then
 songplayer2fo.dragdock.float();
 
  if recorderfo.visible then
 recorderfo.dragdock.float();
 
  if filelistfo.visible then
 filelistfo.dragdock.float();
 
  if commanderfo.visible then
 commanderfo.dragdock.float();
 
 endlayout();

 
  if drumsfo.visible then
 drumsfo.left := left;
 
  if guitarsfo.visible then
 guitarsfo.left := left;
 
  if songplayerfo.visible then
 songplayerfo.left := left;
 
  if songplayer2fo.visible then
 songplayer2fo.left := left;
 
  if recorderfo.visible then
 recorderfo.left := left;

  if filelistfo.visible then
 filelistfo.left := left;
 
  if commanderfo.visible then
 commanderfo.left := left;
// resizeall();
 
 // showall(sender);
  
 height := emptyheight;
 width := fowidth;
 
 if drumsfo.visible then 
 begin 
 drumsfo.top:= top + height + decorationheight;
 posi := drumsfo.top + drumsfoheight + decorationheight;
 end
 else posi := top + height + decorationheight;
 
 
 if filelistfo.visible then 
 begin 
 filelistfo.top:= posi;
 posi := filelistfo.top + filelistfoheight + decorationheight;
 end;
 
 if songplayerfo.visible then 
 begin 
 songplayerfo.top:= posi;
 posi := songplayerfo.top + songplayerfoheight + decorationheight;
 end;
 
 if songplayer2fo.visible then 
 begin 
 songplayer2fo.top:= posi;
 posi := songplayer2fo.top + songplayerfoheight + decorationheight;
 end;
 
  if commanderfo.visible then 
 begin 
 commanderfo.top:= posi;
 posi := commanderfo.top + commanderfoheight + decorationheight;
 end;
 
 if guitarsfo.visible then 
 begin 
 guitarsfo.top:= posi;
 posi := guitarsfo.top + guitarsfoheight + decorationheight;
 end;
 
 if recorderfo.visible then 
 begin 
 recorderfo.top:= posi;
 posi := recorderfo.top + recorderfoheight + decorationheight;
 end;

end;

procedure tmainfo.ondockall(const sender: TObject);
var
 pt1: pointty;
  decorationheight : integer = 5;
begin

filelistfo.bounds_cxmax := fowidth ;
//filelistfo.bounds_cymax := filelistfoheight;
filelistfo.bounds_cymax := 700;

  beginlayout();

 basedock.dragdock.currentsplitdir:= sd_horz; 
 

if drumsfo.visible then
 drumsfo.parentwidget:= basedock;
if filelistfo.visible then
 filelistfo.parentwidget:= basedock;
if songplayerfo.visible then
 songplayerfo.parentwidget:= basedock;
if songplayer2fo.visible then
 songplayer2fo.parentwidget:= basedock;
 if commanderfo.visible then
 commanderfo.parentwidget:= basedock;
if recorderfo.visible then
 recorderfo.parentwidget:= basedock;
if guitarsfo.visible then
 guitarsfo.parentwidget:= basedock; 
 
//{  
 pt1:= nullpoint;
 
 if drumsfo.visible then
 begin
 drumsfo.pos:= pt1;
 pt1.y:= pt1.y + drumsfo.height + decorationheight;
 end;
 
 if filelistfo.visible then
 begin
 filelistfo.pos:= pt1;
 pt1.y:= pt1.y + filelistfo.height  + decorationheight;
 end;
 
 if songplayerfo.visible then
 begin
 songplayerfo.pos:= pt1;
 pt1.y:= pt1.y + songplayerfo.height + decorationheight;
 end;
 
 if songplayer2fo.visible then
 begin
 songplayer2fo.pos:= pt1;
 pt1.y:= pt1.y + songplayer2fo.height + decorationheight;
  end;
  
 if commanderfo.visible then
 begin
 commanderfo.pos:= pt1;
 pt1.y:= pt1.y + commanderfo.height + decorationheight;
  end; 
  
 if recorderfo.visible then
 begin
 recorderfo.pos:= pt1;
 pt1.y:= pt1.y + recorderfo.height + decorationheight;
 end;
 
 if guitarsfo.visible then
 guitarsfo.pos:= pt1; 
//} 
  endlayout(); 
 
end;

procedure tmainfo.beforereadev(const sender: TObject);
begin
 beginlayout();
end;

procedure tmainfo.afterreadev(const sender: TObject);
begin
 endlayout();
end;

procedure tmainfo.ontab(const sender: TObject);
begin
 beginlayout();
 ondockall(sender); // otherwise the close button are hidden
 basedock.dragdock.currentsplitdir:= sd_tabed;
 endlayout();
end;

procedure tmainfo.showall(const sender: TObject);
begin
 //beginlayout();
 drumsfo.show();
 filelistfo.show();
 songplayerfo.show();
 songplayer2fo.show();
 commanderfo.show();
 guitarsfo.show();
 recorderfo.show();

// endlayout();
 timerwait.enabled := true;
end;


end.
