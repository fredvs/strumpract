unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msegui,msetimer,
 ctypes,msegraphics,msegraphutils,mseclasses,msewidgets,mseforms,msedock,drums,
 recorder,songplayer, songplayer2, guitars,msedataedits,mseedit,msestatfile,
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
   timagelist2: timagelist;
   tframecomp1: tframecomp;
   tfacecomp5: tfacecomp;
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
   private
    flayoutlock: int32;
   protected
    procedure beginlayout();
    procedure endlayout();
   public
    procedure updatelayout();
  end;
 
const
 versiontext = '1.4';
 emptyheight = 40;
 drumsfoheight = 236;
 guitarsfoheight = 66;
 songplayerfoheight = 110;
 recorderfoheight = 128;
 fowidth = 456;
 tabheight = 39;
 
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
 drumsfo.height := drumsfoheight;
 guitarsfo.height := guitarsfoheight;
 songplayerfo.height := songplayerfoheight;
 songplayer2fo.height := songplayerfoheight;
 recorderfo.height := recorderfoheight;
 
 drumsfo.width := fowidth;
 guitarsfo.width := fowidth;
 songplayerfo.width := fowidth;
 songplayer2fo.width := fowidth;
 recorderfo.width := fowidth;
end; 

procedure resizealltab();
begin
 drumsfo.height := drumsfoheight + tabheight;
 guitarsfo.height := guitarsfoheight + tabheight;
 songplayerfo.height := songplayerfoheight + tabheight;
 songplayer2fo.height := songplayerfoheight + tabheight;
 recorderfo.height := recorderfoheight + tabheight;
 
 drumsfo.width := fowidth;
 guitarsfo.width := fowidth;
 songplayerfo.width := fowidth;
 songplayer2fo.width := fowidth;
 recorderfo.width := fowidth;
end; 
   
procedure tmainfo.oncreateform(const sender: TObject);
var
x : integer;
begin
 for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;
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
if not fileexists(tstatfile1.filename) then ondockall(sender);
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
 if flayoutlock = 0 then begin
  updatelayout();
 end;
end;

procedure tmainfo.updatelayout();
var
 maxwidth: int32;
 totheight: int32;
 visiblecount: int32;
 children1: widgetarty;
 heights: integerarty;
 i1: int32;
 si1,si2: sizety;
begin
if basedock.dragdock.currentsplitdir <> sd_tabed then begin
 if flayoutlock <= 0 then begin
  children1:= basedock.dragdock.getitems();
  setlength(heights,length(children1));
  visiblecount:= 0;
  maxwidth:= 0;
  totheight:= 0;
  for i1:= 0 to high(children1) do begin
   with children1[i1] do begin
    si1:= container.minscrollsize(); //minimal clientarea
    addsize1(si1,framedim());        //add space for frame
    heights[i1]:= si1.cy;
    if visible then begin
     if si1.cx > maxwidth then begin
      maxwidth:= si1.cx;
     end;
     totheight:= totheight + si1.cy;
     inc(visiblecount);
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
    si2.cy:= totheight + (visiblecount-1) * basedock.dragdock.splitter_size + 
                                                                        si1.cy;
    size:= si2;
    si2:= subsize(size,basedock.paintsize); //padding after update
    inc(i1);
   until (si1.cx = si2.cx) and (si1.cy = si2.cy) or      //padding stable
                                             (i1 > 8);  //emergency brake
  end;
 end;
 for i1:= 0 to high(children1) do begin
  with children1[i1] do begin
  height:= heights[i1];
  end;
 end;
 end else
 begin

 end;
end;

procedure tmainfo.updatedockev(const sender: TObject; const awidget: twidget);
begin
 updatelayout();
end;
 
procedure tmainfo.onfloatall(const sender: TObject);
var
 rect1,rect2: rectty;
 decorationheight: int32;
 begin
 decorationheight:= window.decoratedbounds_cy - height;
 
 beginlayout();
 drumsfo.dragdock.float();
 guitarsfo.dragdock.float();
 songplayerfo.dragdock.float();
 songplayer2fo.dragdock.float();
 recorderfo.dragdock.float();
 endlayout();
 height := emptyheight;
 width := fowidth;
 
 drumsfo.left := left;
 guitarsfo.left := left;
 songplayerfo.left := left;
 songplayer2fo.left := left;
 recorderfo.left := left;
 
 resizeall();
 
 drumsfo.show();
 guitarsfo.show();
 songplayerfo.show();
 recorderfo.show();
 drumsfo.top:= top + height + decorationheight;
 guitarsfo.top:= drumsfo.top + drumsfo.height + decorationheight;
 songplayerfo.top:= guitarsfo.top + guitarsfo.height + decorationheight;
 songplayer2fo.top:= songplayerfo.top + songplayerfo.height + decorationheight;
 recorderfo.top:= songplayer2fo.top + songplayer2fo.height + decorationheight;
end;

procedure tmainfo.ondockall(const sender: TObject);
var
 pt1: pointty;
begin

 basedock.dragdock.currentsplitdir:= sd_horz; 

 beginlayout();
  
 resizeall();

 drumsfo.parentwidget:= basedock;
 guitarsfo.parentwidget:= basedock;
 songplayerfo.parentwidget:= basedock;
 songplayer2fo.parentwidget:= basedock;
 recorderfo.parentwidget:= basedock;
  
 pt1:= nullpoint;
 drumsfo.pos:= pt1;
 pt1.y:= pt1.y + drumsfo.height;
 guitarsfo.pos:= pt1;
 pt1.y:= pt1.y + guitarsfo.height;
 songplayerfo.pos:= pt1;
 pt1.y:= pt1.y + songplayerfo.height;
 songplayer2fo.pos:= pt1;
 pt1.y:= pt1.y + songplayer2fo.height;
 recorderfo.pos:= pt1;

 drumsfo.show();
 songplayerfo.show();
 songplayer2fo.show();
 guitarsfo.show();
 recorderfo.show();
 
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
basedock.dragdock.currentsplitdir:= sd_tabed; 

 resizealltab();
 
 songplayerfo.parentwidget:= basedock;
 songplayer2fo.parentwidget:= basedock;
 recorderfo.parentwidget:= basedock;
 guitarsfo.parentwidget:= basedock;
 drumsfo.parentwidget:= basedock;
 
 drumsfo.show();
 songplayerfo.show();
 songplayer2fo.show();
 guitarsfo.show();
 recorderfo.show();
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
end;
end;
end;

end.
