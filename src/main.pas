unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msegui,msetimer,
 ctypes,msegraphics,msegraphutils,mseclasses,msewidgets,mseforms,msedock,drums,
 recorder,songplayer, songplayer2, filelistform, guitars,msedataedits,mseedit,msestatfile,
 SysUtils,Classes, uos_flat, aboutform,msebitmap, msesys,msemenus,msestream,
 msegrids,mselistbrowser;
 
type
  tmainfo = class(tmainform)
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
   procedure onchangelayout(const sender: tdockcontroller);
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
 filelistfoheight = 119;
 guitarsfoheight = 66;
 songplayerfoheight = 110;
 recorderfoheight = 128;
 fowidth = 458;
 tabheight = 39;
 maxheightfo = 600; 
 scrollwidth = 14;
 
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
 
procedure resizeall();
begin

 mainfo.width := fowidth;

 drumsfo.height := drumsfoheight;
 guitarsfo.height := guitarsfoheight;
 songplayerfo.height := songplayerfoheight;
 songplayer2fo.height := songplayerfoheight;
 recorderfo.height := recorderfoheight;
 filelistfo.height := filelistfoheight;
 
 drumsfo.width := fowidth;
 guitarsfo.width := fowidth;
 songplayerfo.width := fowidth;
 songplayer2fo.width := fowidth;
 recorderfo.width := fowidth;
 filelistfo.width := fowidth;
end; 

procedure resizealltab();
begin
 mainfo.width := fowidth ;
 drumsfo.height := drumsfoheight + tabheight;
 guitarsfo.height := guitarsfoheight + tabheight;
 songplayerfo.height := songplayerfoheight + tabheight;
 songplayer2fo.height := songplayerfoheight + tabheight;
 recorderfo.height := recorderfoheight + tabheight;
 filelistfo.height := filelistfoheight + tabheight;;
 
 drumsfo.width := fowidth;
 guitarsfo.width := fowidth;
 songplayerfo.width := fowidth;
 songplayer2fo.width := fowidth;
 recorderfo.width := fowidth;
 filelistfo.width := fowidth;
end; 
   
procedure tmainfo.oncreateform(const sender: TObject);
// var x : integer;
begin
// for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;
tstatfile1.filename :=  IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +  'status.sta';
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
 if flayoutlock = 0 then
  updatelayout();
 
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
 si1,si2: sizety;
 isbig : boolean = false;
 rect1: rectty;
begin
if basedock.dragdock.currentsplitdir <> sd_tabed then begin
 if flayoutlock <= 0 then begin
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
    
    si1:= container.minscrollsize(); //minimal clientarea
   // si1.cy:= height; //minimal clientarea
   // si1.cx:= width;
    addsize1(si1,framedim());        //add space for frame
   
    heights[i1]:= si1.cy;
   
   if visible then begin
   
     if si1.cx > maxwidth then maxwidth:= si1.cx;
      
      totheight:= totheight + si1.cy;
          
     inc(visiblecount);
    end else heights[i1]:= 0;
   end;
  end;
  
    
  if visiblecount = 0 then begin
   height:= emptyheight;
  end
  else begin
  
   i1:= 0;
 //  if isbig then maxwidth := maxwidth + scrollwidth;
   repeat
    si1:= subsize(size,basedock.paintsize); //padding before update
    si2.cx:= maxwidth + si1.cx;
    si2.cy:= totheight + (visiblecount-1) * basedock.dragdock.splitter_size + 
                                                                        si1.cy;
    size:= si2;
    si2:= subsize(size,basedock.paintsize); //padding after update
    inc(i1);
   until (si1.cx = si2.cx) and (si1.cy = si2.cy) or      //padding stable
                                                (i1 > 8);  //emergency brake
  
 end;
 end;
 
 
// {
 for i1:= 0 to high(children1) do begin
  with children1[i1] do begin
  height:= heights[i1];
  end;
 end;
// }

// maxheightfo
// height := ScreenHeight ;

 if (si2.cy + 40  > rect1.cy) then else height:= height + 4;

   if (si2.cy +40  > rect1.cy) 
   or ((filelistfo.visible = true) and (filelistfo.parentwidget = basedock)) then
   width := fowidth + scrollwidth else width := fowidth ;
   
 // container.height := height;
 // basedock.height := totheight;
 // if container.frame.sbvert <> nil then  width := fowidth + scrollwidth else width := fowidth +2 ;
 si1 :=   basedock.paintsize;
 si1.cy :=   height;
 //basedock.paintsize := si1;
 
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
 
 resizeall();
 
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

// showall(sender);
 
// width := width +4;

filelistfo.bounds_cxmax := fowidth ;
filelistfo.bounds_cymax := filelistfoheight;
//filelistfo.bounds_cymax := 700;

  resizeall();

 basedock.dragdock.currentsplitdir:= sd_horz; 
 
   beginlayout();

if drumsfo.visible then
 drumsfo.parentwidget:= basedock;
if filelistfo.visible then
 filelistfo.parentwidget:= basedock;
if songplayerfo.visible then
 songplayerfo.parentwidget:= basedock;
if songplayer2fo.visible then
 songplayer2fo.parentwidget:= basedock;
if recorderfo.visible then
 recorderfo.parentwidget:= basedock;
if guitarsfo.visible then
 guitarsfo.parentwidget:= basedock; 
 
 // {  
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

ondockall(sender); // otherwise the close button are hidden

basedock.dragdock.currentsplitdir:= sd_tabed; 

 resizealltab();
 
 if songplayerfo.visible then
 songplayerfo.parentwidget:= basedock;
 
  if songplayer2fo.visible then
 songplayer2fo.parentwidget:= basedock;
 
  if filelistfo.visible then
 filelistfo.parentwidget:= basedock;
 
  if recorderfo.visible then
 recorderfo.parentwidget:= basedock;
 
  if guitarsfo.visible then
 guitarsfo.parentwidget:= basedock;
 
  if drumsfo.visible then
 drumsfo.parentwidget:= basedock;
 
 width := width +2;
// showall(sender);

 end;
 

procedure tmainfo.onchangelayout(const sender: tdockcontroller);
begin

if (basedock.dragdock.currentsplitdir = sd_tabed) and
(basedock.dragdock.activewidget <> nil) then 
begin

if basedock.dragdock.activewidget = drumsfo then 
begin
basedock.dragdock.tab_faceactivetab := drumsfo.tfacedrums;
height := drumsfoheight + tabheight;
end else
if basedock.dragdock.activewidget = guitarsfo then 
begin
basedock.dragdock.tab_faceactivetab := guitarsfo.tfaceguitars;
height := guitarsfoheight + tabheight;
end else
if (basedock.dragdock.activewidget = songplayerfo)
 or (basedock.dragdock.activewidget = songplayer2fo) then 
 begin
height := songplayerfoheight + tabheight;
basedock.dragdock.tab_faceactivetab := songplayerfo.tfaceplayer;
end else
if basedock.dragdock.activewidget = recorderfo then 
begin
height := recorderfoheight + tabheight;
basedock.dragdock.tab_faceactivetab := recorderfo.tfacerecorder;
end
else
if basedock.dragdock.activewidget = filelistfo then 
begin
height := filelistfoheight + tabheight;
basedock.dragdock.tab_faceactivetab := songplayerfo.tfaceplayer;
end;
end;
end;

procedure tmainfo.showall(const sender: TObject);
begin
 drumsfo.show();
 songplayerfo.show();
 songplayer2fo.show();
 guitarsfo.show();
 recorderfo.show();
 filelistfo.show();
end;

end.
