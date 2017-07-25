unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msegui,msetimer,
 ctypes,msegraphics,msegraphutils,mseclasses,msewidgets,mseforms,msedock,drums,
 songplayer, guitars,msesimplewidgets,msedataedits,mseedit,msestatfile,
 msestrings,SysUtils,Classes,msegraphedits, uos_flat, aboutform, infos,
 msebitmap,mseimage,msefiledialog,msesys,mseificomp,mseificompglob,mseifiglob,
 msemenus,msescrollbar,mseact,mseevent,msestream,msedragglob,msedatanodes,
 msegrids,mselistbrowser,msemenuwidgets;
 
type
  tmainfo = class(tmainform)
   buttonicons: timagelist;
   tstatfile1: tstatfile;
   tfacecomp1: tfacecomp;
   tfacecomp2: tfacecomp;
   tfacecomp3: tfacecomp;
   basedock: tdockpanel;
   tmainmenu1: tmainmenu;
   tfacecomp4: tfacecomp;
   procedure oncreateform(const sender: TObject);
   procedure onabout(const sender: TObject);
   procedure dodestroy(const sender: TObject);
   
   procedure doquit(const sender: TObject);
   procedure oncreatedform(const sender: TObject);
  // procedure sethistoryfn(const sender: TObject; var avalue: msestring;
    //               var accept: Boolean);
  
   procedure showdrums(const sender: TObject);
   procedure showpllayer(const sender: TObject);
   procedure showguitars(const sender: TObject);
   procedure onclosemain(const sender: TObject);
   procedure befclose(const sender: tcustommseform;
                   var amodalresult: modalresultty);
   procedure onfloatall(const sender: TObject);
   procedure ondockall(const sender: TObject);
  end;
 
const
 versiontext = '1.3';
 
var
 mainfo: tmainfo;
 tottime: ttime;
 stopit :boolean = false;
 channels : cardinal = 2 ; // stereo output
 allok : boolean = false;
 plugsoundtouch : boolean = false;
 ordir : string;
 
implementation
uses
 main_mfm;
   
   
procedure tmainfo.oncreateform(const sender: TObject);

begin
 
 visible := false;
 
  
end;



procedure tmainfo.onabout(const sender: TObject);
begin
aboutfo.caption := 'About StrumPract' ;
aboutfo.about_text.frame.colorclient := $DFFFB2;
aboutfo.about_text.value := c_linefeed+  c_linefeed +
 'StrumPract '+ versiontext + ' for '+ platformtext+  c_linefeed+
 c_linefeed + 'Compiled with FPC 3.0.2.' + c_linefeed +  c_linefeed +
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
var
i : integer;
begin

// freeandnil(Timerwait) ;
 {
 freeandnil(drumsfo.Timerpause) ;
 freeandnil(drumsfo.Timertick) ;
 for i := 0 to 3 do
begin
  freeandnil(drumsfo.alab2[i]);
  freeandnil(drumsfo.alaband[i]);
end;

 for i := 0 to 15 do
begin
  freeandnil(drumsfo.alab[i]);
  freeandnil(drumsfo.aoh[i]);
  freeandnil(drumsfo.ach[i]);
  freeandnil(drumsfo.asd[i]);
  freeandnil(drumsfo.abd[i]);
end;
}
sleep(50);      
uos_free;
sleep(150);

end;

procedure tmainfo.doquit(const sender: TObject);
begin
visible := false;
application.terminate;
end;


procedure tmainfo.oncreatedform(const sender: TObject);
begin
caption := 'StrumPract ' + versiontext;
{
if (((songplayerfo.visible = false) and (songplayerfo.parentwidget <> nil))  and 
((guitarsfo.visible = false)  and (guitarsfo.parentwidget <> nil))) or 
 ((songplayerfo.parentwidget = nil) and (guitarsfo.parentwidget = nil)) then 
height := 260;

if (((songplayerfo.visible = false) and (songplayerfo.parentwidget <> nil))  and 
((guitarsfo.visible = true)  and (guitarsfo.parentwidget <> nil))) or 
 ((songplayerfo.parentwidget = nil) and ((guitarsfo.parentwidget <> nil) and
  (guitarsfo.visible = true))) then 
height := 260 + 74 ;

if (((songplayerfo.visible = true) and (songplayerfo.parentwidget <> nil))  and 
((guitarsfo.visible = false)  and (guitarsfo.parentwidget <> nil))) or 
 ((guitarsfo.parentwidget = nil) and ((songplayerfo.parentwidget <> nil) and
  (songplayerfo.visible = true)  )) then 
height := 260 + 114 ;

if (((songplayerfo.visible = true) and (songplayerfo.parentwidget <> nil))  and 
((guitarsfo.visible = true)  and (guitarsfo.parentwidget <> nil)))
 then 
height := 260 + 74 + 114;
width := 456 ;

guitarsfo.height := 74;
guitarsfo.width := 458;

songplayerfo.height := 114;
songplayerfo.width := 458;

drumsfo.height := 238;
drumsfo.width := 458;

sleep(100);
}
ondockall(sender);

end;

procedure tmainfo.showdrums(const sender: TObject);
var
i,x : integer;
apos: pointty;
isplayvisible : boolean = false;
isplaydock : boolean = false;
isguitvisible : boolean = false;
isguitdock : boolean = false;
isdrumvisible : boolean = false;
isdrumdock : boolean = false;
begin

if drumsfo.visible = true then isdrumvisible := true ;
if guitarsfo.visible = true then isguitvisible := true ;
if songplayerfo.visible = true then isplayvisible := true ;

if drumsfo.parentwidget <> nil then isdrumdock := true ;
if guitarsfo.parentwidget <> nil then isguitdock := true ;
if songplayerfo.parentwidget <> nil then isplaydock := true ;


if isdrumvisible = false then 
begin
tmainmenu1.menu[0].caption := ' &Drums-hide ' ;

drumsfo.height := 238;
drumsfo.width := 458;

guitarsfo.height := 74;
guitarsfo.width := 458;

songplayerfo.height := 114;
songplayerfo.width := 458;
drumsfo.activate;

//onfloatall(sender);
// 

if (isplayvisible = false) and 
(isguitvisible = false) then 
begin
if isdrumdock then
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
begin
height := 40;
width := 458 ;
end;
end;

if (isplayvisible = false) and 
(isguitvisible = true) then 
begin
if isdrumdock then
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if  isguitdock = true then
begin
apos.y := drumsfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if  isguitdock = true then
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isguitvisible = false) and  
(isplayvisible = true)  then 
begin
if isdrumdock then
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isplaydock = true then begin
apos.y := songplayerfo.height + 2 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if isplaydock = true then
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isguitvisible = true) and
(isplayvisible = true) then 
begin
if isdrumdock then
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isplaydock = true then
 begin
apos.y := drumsfo.height + 2;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isguitdock = true then
 begin
apos.y := drumsfo.height + songplayerfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isguitdock = true then
 begin
apos.y := drumsfo.height  + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isplaydock = true then
 begin
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isguitdock = true then
 begin
apos.y := songplayerfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isguitdock = true then
 begin
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;

end;
end;
end else
begin
 drumsfo.close; 
// tmainmenu1.menu[0].caption := ' &Drums-show ' ;
// height := height - 238 ;
// if mainfo.height < 30 then mainfo.height := 30;
 end;
if height < 40 then  height :=40 ;
end;

procedure tmainfo.showpllayer(const sender: TObject);
var
i,x : integer;
apos: pointty;
isplayvisible : boolean = false;
isplaydock : boolean = false;
isguitvisible : boolean = false;
isguitdock : boolean = false;
isdrumvisible : boolean = false;
isdrumdock : boolean = false;
begin

if drumsfo.visible = true then isdrumvisible := true ;
if guitarsfo.visible = true then isguitvisible := true ;
if songplayerfo.visible = true then isplayvisible := true ;

if drumsfo.parentwidget <> nil then isdrumdock := true ;
if guitarsfo.parentwidget <> nil then isguitdock := true ;
if songplayerfo.parentwidget <> nil then isplaydock := true ;


if isplayvisible = false then 
begin
tmainmenu1.menu[1].caption := ' &Player-hide ' ;

drumsfo.height := 238;
drumsfo.width := 458;

guitarsfo.height := 74;
guitarsfo.width := 458;

songplayerfo.height := 114;
songplayerfo.width := 458;

songplayerfo.activate;

//onfloatall(sender);
// 

if (isdrumvisible = false) and 
(isguitvisible = false) then 
begin
if isplaydock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
begin
height := 40;
width := 458 ;
end;
end;

if (isdrumvisible = false) and 
(isguitvisible = true) then 
begin
if isplaydock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if  isguitdock = true then
begin
apos.y := songplayerfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if  isguitdock = true then
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isdrumvisible = true) and 
(isguitvisible = false) then 
begin
if isplaydock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + 2 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if isdrumdock = true then
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isdrumvisible = true) and 
(isguitvisible = true) then 
begin
if isplaydock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then
 begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + 2;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos); 
if isguitdock = true then
 begin
 apos.y := drumsfo.height + songplayerfo.height + 2 ;
 guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isguitdock = true then
 begin
apos.y := songplayerfo.height  + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then
 begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isguitdock = true then
 begin
apos.y := drumsfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isguitdock = true then
 begin
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;

end;
end;
end else
begin
 songplayerfo.close; 
 //tmainmenu1.menu[1].caption := ' &Player-show ' ;
// height := height - 238 ;
// if mainfo.height < 30 then mainfo.height := 30;
 end;
if height < 40 then  height :=40 ;
end;

procedure tmainfo.showguitars(const sender: TObject);
var
i,x : integer;
apos: pointty;
isplayvisible : boolean = false;
isplaydock : boolean = false;
isguitvisible : boolean = false;
isguitdock : boolean = false;
isdrumvisible : boolean = false;
isdrumdock : boolean = false;
begin

if drumsfo.visible = true then isdrumvisible := true ;
if guitarsfo.visible = true then isguitvisible := true ;
if songplayerfo.visible = true then isplayvisible := true ;

if drumsfo.parentwidget <> nil then isdrumdock := true ;
if guitarsfo.parentwidget <> nil then isguitdock := true ;
if songplayerfo.parentwidget <> nil then isplaydock := true ;


if isguitvisible = false then 
begin
tmainmenu1.menu[2].caption := ' &Guitar-hide ' ;

drumsfo.height := 238;
drumsfo.width := 458;

guitarsfo.height := 74;
guitarsfo.width := 458;

songplayerfo.height := 114;
songplayerfo.width := 458;

guitarsfo.activate;

//onfloatall(sender);
// 

if (isdrumvisible = false) and 
(isplayvisible = false) then 
begin
if isguitdock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
begin
height := 40;
width := 458 ;
end;
end;

if (isdrumvisible = false) and 
(isplayvisible = true) then
begin
if isguitdock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if  isplaydock = true then
begin
apos.y := guitarsfo.height + 2 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if  isplaydock = true then
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isdrumvisible = true) and 
(isplayvisible = false) then 
begin
if isguitdock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
if isdrumdock = true then
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end;

if (isdrumvisible = true) and 
(isplayvisible = true) then 
begin
if isguitdock then
begin
for x:=0 to 1 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then
 begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + 2;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos); 
if isplaydock = true then
 begin
 apos.y := drumsfo.height + songplayerfo.height + 2 ;
 songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isplaydock = true then
 begin
apos.y := songplayerfo.height  + 2 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;
end else
begin
for x:=0 to 0 do
begin
height := 25;
width := 458 ;
apos.x := 0 ;
apos.y := 0 ;
if isdrumdock = true then
 begin
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
if isplaydock = true then
 begin
apos.y := drumsfo.height + 2 ;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end else
if isplaydock = true then
 begin
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
end;
end;

end;
end;
end else
begin
 guitarsfo.close; 
// tmainmenu1.menu[2].caption := ' &Guitar-show ' ;
// height := height - 238 ;
// if mainfo.height < 30 then mainfo.height := 30;
 end;
if height < 40 then  height :=40 ;
end;

procedure tmainfo.onclosemain(const sender: TObject);
begin
visible := false;
end;

procedure tmainfo.befclose(const sender: tcustommseform;
               var amodalresult: modalresultty);
begin
visible := false;
end;

procedure tmainfo.onfloatall(const sender: TObject);
begin
drumsfo.activate;
songplayerfo.activate;
guitarsfo.activate;

drumsfo.dragdock.float();
songplayerfo.dragdock.float();
guitarsfo.dragdock.float();

height := 40;

end;

procedure tmainfo.ondockall(const sender: TObject);
var
x, y : integer;
apos: pointty;
begin
drumsfo.activate;
songplayerfo.activate;
guitarsfo.activate;

// ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));  
//if fileexists( ordir+'status.sta') then y := 0 else y := 1;
//visible := false;

for x:=0 to 1 do // ones is sometimes not enough
begin
height := 25;
width := 458 ;
// 
apos.x := 0 ;
apos.y := 0 ;
drumsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + 2;
songplayerfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
apos.y := drumsfo.height + guitarsfo.height + 2 ;
guitarsfo.dragdock.dockto(mainfo.basedock.dragdock,apos);
sleep(10);
end;
//height := guitarsfo.height + drumsfo.height + guitarsfo.height + 4 ;

//activate;

end;
 
end.
