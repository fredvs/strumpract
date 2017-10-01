unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msegui,
 msetimer,ctypes, msegraphics, msegraphutils, mseclasses, msewidgets, mseforms,
 msedock, drums,recorder, songplayer, songplayer2, commander, filelistform,
 guitars, msedataedits,mseedit, msestatfile, SysUtils, Classes, uos_flat,
 aboutform, msebitmap, msesys,msemenus, msestream, msegrids, mselistbrowser,
 mseact,mseificomp,mseificompglob,mseifiglob,msestrings;

type
  tmainfo = class(tmainform)
    Timerwait: Ttimer;
    basedock: tdockpanel;
    tmainmenu1: tmainmenu;
    tfacecomp4: tfacecomp;
    tstatfile1: tstatfile;
    tframecomp1: tframecomp;
    tfacecomp5: tfacecomp;
    timagelist3: timagelist;
    tfacebutgray: tfacecomp;
    tfacecomp7: tfacecomp;
    tfacered: tfacecomp;
    tfacegreen: tfacecomp;
    tfaceorange: tfacecomp;
   tfaceplayer: tfacecomp;
   tfaceplayerlight: tfacecomp;
   tfaceplayerrev: tfacecomp;
   tfacecomp1: tfacecomp;
   tframecomp2: tframecomp;
   tfaceorangelt: tfacecomp;
   tfaceorangehz: tfacecomp;
   typecolor: tintegeredit;
   tfacebutltgray: tfacecomp;
   buttonicons: timagelist;
    procedure ontimerwait(const Sender: TObject);
    procedure oncreateform(const Sender: TObject);
    procedure oncreatedform(const Sender: TObject);
    procedure dodestroy(const Sender: TObject);
    procedure onabout(const Sender: TObject);
    procedure showdrums(const Sender: TObject);
    procedure showrecorder(const Sender: TObject);
    procedure showplayer(const Sender: TObject);
    procedure showplayer2(const Sender: TObject);
    procedure showguitars(const Sender: TObject);
    procedure onfloatall(const Sender: TObject);
    procedure ondockall(const Sender: TObject);
    procedure updatedockev(const Sender: TObject; const awidget: twidget);
    procedure beforereadev(const Sender: TObject);
    procedure afterreadev(const Sender: TObject);
    procedure ontab(const Sender: TObject);
    function issomeplaying: boolean;
    procedure showall(const Sender: TObject);

   procedure hideall(const sender: TObject);
   procedure showcommander(const sender: TObject);
   procedure showfiles(const sender: TObject);
   procedure changecolors(const sender: TObject);
   procedure changesilver(const sender: TObject);
   procedure changecarbon(const sender: TObject);
   procedure onchangevalcolor(const sender: TObject);
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
  filelistfoheight = 128;
  guitarsfoheight = 64;
  songplayerfoheight = 128;
  recorderfoheight = 128;
  commanderfoheight = 128;
  fowidth = 458;
  tabheight = 39;
  maxheightfo = 600;
  scrollwidth = 14;

var
  mainfo: tmainfo;
  tottime: ttime;
  stopit: boolean = False;
  channels: cardinal = 2; // stereo output
  allok: boolean = False;
  plugsoundtouch: boolean = False;
  ordir: string;
  hasinit: integer = 0;

implementation

uses
  main_mfm;

procedure tmainfo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;

begin
  timerwait.Enabled := False;

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
    application.ProcessMessages;
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
  hasinit := 1;

end;

procedure resizeall();
begin
  // filelistfo.height := filelistfoheight;
end;

procedure resizealltab();
begin
{
 mainfo.width := fowidth ;
 filelistfo.height := filelistfoheight + tabheight;;
 filelistfo.width := fowidth;
 }
end;

procedure tmainfo.oncreateform(const Sender: TObject);
// var x : integer;
begin
  // for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;
  tstatfile1.filename := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'status.sta';

  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 400000;
  Timerwait.Enabled := False;
  Timerwait.ontimer := @ontimerwait;
end;

procedure tmainfo.onabout(const Sender: TObject);
begin
  aboutfo.Caption := 'About StrumPract';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value := c_linefeed + c_linefeed + 'StrumPract ' + versiontext + ' for ' + platformtext + c_linefeed +
    c_linefeed + 'Compiled with FPC 3.0.3.' + c_linefeed + c_linefeed + 'Graphic widget: MSEgui ' + mseguiversiontext +
    '.' + c_linefeed + 'http://sourceforge.net/projects/mseide-msegui/' + c_linefeed + c_linefeed +
    'Audio library: uos (United Openlib of Sound)' + c_linefeed + 'https://github.com/fredvs/uos' + c_linefeed +
    'Forum: http://uos.2369694.n4.nabble.com' + c_linefeed + c_linefeed + 'Copyright 2017' +
    c_linefeed + 'Fred van Stappen <fiens@hotmail.com>';
  aboutfo.Show(True);
end;

procedure tmainfo.dodestroy(const Sender: TObject);
begin
  uos_free();
  Timerwait.Free;
end;

procedure tmainfo.oncreatedform(const Sender: TObject);
begin
  Caption := 'StrumPract ' + versiontext;

  if not fileexists(tstatfile1.filename) then
  begin
    //hide;
    showall(Sender);
    ondockall(Sender);
    // sleep(100);
    // ondockall(sender); /// otherwise size of dock is not ok
    //show;
  end;

  if (filelistfo.Visible) then
  begin
    if (filelistfo.parentwidget = nil) then
    begin
      filelistfo.bounds_cxmax := 1024;
      filelistfo.bounds_cymax := 600;
    end
    else
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := 600;
    end;
  end;

  Timerwait.Enabled := True; /// for width if scroll
end;

procedure tmainfo.showguitars(const Sender: TObject);
begin
  guitarsfo.Visible := not guitarsfo.Visible;
end;

procedure tmainfo.showrecorder(const Sender: TObject);
begin
  recorderfo.Visible := not recorderfo.Visible;
end;

procedure tmainfo.showdrums(const Sender: TObject);
begin
  drumsfo.Visible := not drumsfo.Visible;
end;

procedure tmainfo.showplayer(const Sender: TObject);
begin
  songplayerfo.Visible := not songplayerfo.Visible;
end;

procedure tmainfo.showplayer2(const Sender: TObject);
begin
  songplayer2fo.Visible := not songplayer2fo.Visible;
end;

function tmainfo.issomeplaying: boolean;
var
  x: integer;
  isplay: boolean = False;
begin
  Result := isplay;
  for x := 9 to 25 do
    if uos_GetStatus(x) = 1 then
      isplay := True;
  if drumsfo.timertick.Enabled = True then
    isplay := True;
  Result := isplay;
end;

procedure tmainfo.beginlayout();
begin
  Inc(flayoutlock);
  basedock.dragdock.beginplacement();
end;

procedure tmainfo.endlayout();
begin
  Dec(flayoutlock);
  basedock.dragdock.endplacement();
  if flayoutlock = 0 then
    updatelayout();
  Timerwait.Enabled := True;
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

      //  writeln('Number of childs: ' + inttostr(high(children1)));


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
      //   writeln('final basedock.width: ' + inttostr(basedock.width));
      //   writeln('final basedock.height: ' + inttostr(basedock.height));
      //   writeln('final basedock.top: ' + inttostr(basedock.top));
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

 {
  writeln('final2 basedock.width: ' + inttostr(basedock.width));
  writeln('final2 basedock.height: ' + inttostr(basedock.height));
  writeln('final2 basedock.top: ' + inttostr(basedock.top));
  writeln('final2 width: ' + inttostr(width));
  writeln('final2 height: ' + inttostr(height));
  }

  // if filelistfo.parentwidget <> NIL THEN filelistfo.size := sizebefdock;

  timerwait.Enabled := False; // to reset
  timerwait.Enabled := True;
end;

procedure tmainfo.updatedockev(const Sender: TObject; const awidget: twidget);
begin
  updatelayout();
end;

procedure tmainfo.onfloatall(const Sender: TObject);
var
  rect1, rect2: rectty;
  decorationheight, posi: int32;
  si1: sizety;
begin
// basedock.anchors := [an_left,an_top]  ;
  
  decorationheight := window.decoratedbounds_cy - Height;

  beginlayout();

  if drumsfo.Visible then
    drumsfo.dragdock.float();

  if guitarsfo.Visible then
    guitarsfo.dragdock.float();

  if songplayerfo.Visible then
    songplayerfo.dragdock.float();

  if songplayer2fo.Visible then
    songplayer2fo.dragdock.float();

  if recorderfo.Visible then
    recorderfo.dragdock.float();

  if filelistfo.Visible then
    filelistfo.dragdock.float();

  if commanderfo.Visible then
    commanderfo.dragdock.float();

  endlayout();

  filelistfo.bounds_cxmax := 1024;
  filelistfo.bounds_cymax := 700;

  Height := emptyheight + 20;
  Width := fowidth;

  if drumsfo.Visible then
    drumsfo.left := left;

  if guitarsfo.Visible then
    guitarsfo.left := left;

  if songplayerfo.Visible then
    songplayerfo.left := left;

  if songplayer2fo.Visible then
    songplayer2fo.left := left;

  if recorderfo.Visible then
    recorderfo.left := left;

  if filelistfo.Visible then
    filelistfo.left := left;

  if commanderfo.Visible then
    commanderfo.left := left;

  if drumsfo.Visible then
  begin
    drumsfo.top := top + Height + decorationheight;
    posi := drumsfo.top + drumsfoheight + decorationheight;
  end
  else
    posi := top + Height + decorationheight;

  if filelistfo.Visible then
  begin
    filelistfo.top := posi;
    posi := filelistfo.top + filelistfoheight + decorationheight;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.top := posi;
    posi := songplayerfo.top + songplayerfoheight + decorationheight;
  end;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.top := posi;
    posi := songplayer2fo.top + songplayerfoheight + decorationheight;
  end;

  if commanderfo.Visible then
  begin
    commanderfo.top := posi;
    posi := commanderfo.top + commanderfoheight + decorationheight;
  end;

  if guitarsfo.Visible then
  begin
    guitarsfo.top := posi;
    posi := guitarsfo.top + guitarsfoheight + decorationheight;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.top := posi;
    posi := recorderfo.top + recorderfoheight + decorationheight;
  end;

 {
 width := fowidth ;
 basedock.height := height - decorationheight +10;
 basedock.width := width - 10;
 basedock.top := 0;
 basedock.left := 0;
// }

  timerwait.Enabled := True;

end;

procedure tmainfo.ondockall(const Sender: TObject);
var
  pt1: pointty;
  decorationheight: integer = 5;
begin
// basedock.anchors := [an_left,an_top]  ;

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 700;

  //sizebefdock.cy := 500;
  //size := sizebefdock;

  beginlayout();

  basedock.dragdock.currentsplitdir := sd_horz;

  if drumsfo.Visible then
    drumsfo.parentwidget := basedock;
  if filelistfo.Visible then
    filelistfo.parentwidget := basedock;
  if songplayerfo.Visible then
    songplayerfo.parentwidget := basedock;
  if songplayer2fo.Visible then
    songplayer2fo.parentwidget := basedock;
  if commanderfo.Visible then
    commanderfo.parentwidget := basedock;
  if recorderfo.Visible then
    recorderfo.parentwidget := basedock;
  if guitarsfo.Visible then
    guitarsfo.parentwidget := basedock;

  //{
  pt1 := nullpoint;

  if drumsfo.Visible then
  begin
    drumsfo.pos := pt1;
    pt1.y := pt1.y + drumsfo.Height + decorationheight;
  end;

  if filelistfo.Visible then
  begin
    filelistfo.pos := pt1;
    pt1.y := pt1.y + filelistfo.Height + decorationheight;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.pos := pt1;
    pt1.y := pt1.y + songplayerfo.Height + decorationheight;
  end;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.pos := pt1;
    pt1.y := pt1.y + songplayer2fo.Height + decorationheight;
  end;

  if commanderfo.Visible then
  begin
    commanderfo.pos := pt1;
    pt1.y := pt1.y + commanderfo.Height + decorationheight;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.pos := pt1;
    pt1.y := pt1.y + recorderfo.Height + decorationheight;
  end;

  if guitarsfo.Visible then
    guitarsfo.pos := pt1;
  //}
  endlayout();
//basedock.anchors := [an_left,an_top,an_right,an_bottom]  ;
end;

procedure tmainfo.beforereadev(const Sender: TObject);
begin
  beginlayout();
end;

procedure tmainfo.afterreadev(const Sender: TObject);
begin
  endlayout();
end;

procedure tmainfo.ontab(const Sender: TObject);
begin
  //basedock.anchors := [an_left,an_top];
  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 700;
  beginlayout();
  ondockall(Sender); // otherwise the close button are hidden
  basedock.dragdock.currentsplitdir := sd_tabed;
  endlayout();
end;

procedure tmainfo.showall(const Sender: TObject);
begin
  //beginlayout();
  drumsfo.Show();
  filelistfo.Show();
  songplayerfo.Show();
  songplayer2fo.Show();
  commanderfo.Show();
  guitarsfo.Show();
  recorderfo.Show();

  // endlayout();
  timerwait.Enabled := True;
end;

procedure tmainfo.hideall(const sender: TObject);
begin
  //beginlayout();
  drumsfo.visible := false;
  filelistfo.visible := false;
  songplayerfo.visible := false;
  songplayer2fo.visible := false;
  commanderfo.visible := false;
  guitarsfo.visible := false;
  recorderfo.visible := false;

  // endlayout();
  timerwait.Enabled := True;
end;

procedure tmainfo.showcommander(const sender: TObject);
begin
commanderfo.Visible := not commanderfo.Visible;
end;

procedure tmainfo.showfiles(const sender: TObject);
begin
filelistfo.Visible := not filelistfo.Visible;
end;

procedure tmainfo.changecolors(const sender: TObject);
begin
typecolor.value := 0;
end;

procedure tmainfo.changesilver(const sender: TObject);
begin
typecolor.value := 1;
end;

procedure tmainfo.changecarbon(const sender: TObject);
begin
typecolor.value := 2;
end;

procedure tmainfo.onchangevalcolor(const sender: TObject);
var
ltblank : integer = $F0F0F0;
ltblack : integer = $2D2D2D;
begin
if typecolor.value = 0 then 
begin

// main
tfacegreen.template.fade_color.items[0] := $C2FF9E ;
tfacegreen.template.fade_color.items[1] := $6EB545 ;

tfaceorange.template.fade_color.items[0] := $FFF9F0 ;
tfaceorange.template.fade_color.items[1] := $FF9D14 ;

tfacered.template.fade_color.items[0] := $FFC4C4 ;
tfacered.template.fade_color.items[1] := $FF7878 ;

// players
songplayerfo.font.color := ltblack;
songplayer2fo.font.color := ltblack;

tfaceplayer.template.fade_color.items[0] := $F9FFC2 ;
tfaceplayer.template.fade_color.items[1] := $C4C999 ;

tfacebutgray.template.fade_color.items[0] := $F2F2F2 ;
tfacebutgray.template.fade_color.items[1] := $9E9E9E ;

tfacebutltgray.template.fade_color.items[0] := $FAFAFA ;
tfacebutltgray.template.fade_color.items[1] := $D1D1D1 ;

songplayerfo.tstringdisp1.font.color := ltblack;
songplayer2fo.tstringdisp1.font.color := ltblack;

songplayerfo.lposition.font.color := ltblack;
songplayer2fo.lposition.font.color := ltblack;

songplayerfo.llength.font.color := ltblack;
songplayer2fo.llength.font.color := ltblack;

songplayerfo.cbloop.frame.font.color := ltblack;
songplayer2fo.cbloop.frame.font.color := ltblack;

songplayerfo.cbtempo.frame.font.color := ltblack;
songplayer2fo.cbtempo.frame.font.color := ltblack;

songplayerfo.waveformcheck.frame.font.color := ltblack;
songplayer2fo.waveformcheck.frame.font.color := ltblack;

songplayerfo.tstringdisp2.font.color := ltblack;
songplayer2fo.tstringdisp2.font.color := ltblack;

songplayerfo.button1.font.color := ltblack;
songplayer2fo.button1.font.color := ltblack;

songplayerfo.tstringdisp1.color := cl_default;
songplayer2fo.tstringdisp1.color := cl_default;

songplayerfo.tfaceslider.template.fade_color.items[0] := $F9FFC2 ;
songplayerfo.tfaceslider.template.fade_color.items[1] := $C4C999 ;
songplayer2fo.tfaceslider.template.fade_color.items[0] := $F9FFC2 ;
songplayer2fo.tfaceslider.template.fade_color.items[1] := $C4C999 ;

songplayerfo.tfacegreen.template.fade_color.items[0] := $C2FF9E ;
songplayerfo.tfacegreen.template.fade_color.items[1] := $6EB545 ;
songplayer2fo.tfacegreen.template.fade_color.items[0] := $C2FF9E ;
songplayer2fo.tfacegreen.template.fade_color.items[1] := $6EB545 ;

tfaceplayerlight.template.fade_color.items[0] := $FDFFEB;
tfaceplayerlight.template.fade_color.items[1] := $E3E8B0;

tfaceplayerrev.template.fade_color.items[0] := $C4C999;
tfaceplayerrev.template.fade_color.items[1] := $F3FABE;

// drums
drumsfo.tfacedrums.template.fade_color.items[0] := $9AAD97 ;
drumsfo.tfacedrums.template.fade_color.items[1] := $D6F0D1 ;
drumsfo.ltempo.font.color := ltblack;
drumsfo.novoice.frame.font.color := ltblack;
drumsfo.noand.frame.font.color := ltblack;
drumsfo.nodrums.frame.font.color := ltblack;
drumsfo.noanim.frame.font.color := ltblack;
drumsfo.tlabel21.font.color := ltblack;
drumsfo.tlabel22.font.color := ltblack;
drumsfo.tlabel25.font.color := ltblack;
drumsfo.tlabel23.font.color := ltblack;

drumsfo.tstringdisp2.font.color := ltblack;


// rev
drumsfo.tfacecomp2.template.fade_color.items[0] := $D6F0D1 ;
drumsfo.tfacecomp2.template.fade_color.items[1] := $9CAF99 ;

// light
drumsfo.tfacecomp3.template.fade_color.items[0] := $F9FFF7 ;
drumsfo.tfacecomp3.template.fade_color.items[1] := $BCD4B8 ;

// recorder
recorderfo.tfacerecorder.template.fade_color.items[0] := $FFE3E3 ;
recorderfo.tfacerecorder.template.fade_color.items[1] := $DA9D9D ;

recorderfo.cbloop.frame.font.color := ltblack;
recorderfo.cbtempo.frame.font.color := ltblack;
recorderfo.bsavetofile.frame.font.color := ltblack;
recorderfo.blistenin.frame.font.color := ltblack;
recorderfo.tlabel27.font.color := ltblack;
recorderfo.label6.font.color := ltblack;
recorderfo.tlabel28.font.color := ltblack;
recorderfo.tlabel2.font.color := ltblack;
recorderfo.btinfos.font.color := ltblack;
recorderfo.button1.font.color := ltblack;
recorderfo.tstringdisp2.font.color := ltblack;
recorderfo.llength.font.color := ltblack;
recorderfo.lposition.font.color := ltblack;

// rev
recorderfo.tfacerecrev.template.fade_color.items[0] := $D9C1C1 ;
recorderfo.tfacerecrev.template.fade_color.items[1] := $FFE3E3 ;

// light
recorderfo.tfacereclight.template.fade_color.items[0] := $FFF7F7 ;
recorderfo.tfacereclight.template.fade_color.items[1] := $EDD3D3 ;

// guitar
guitarsfo.loopguit.frame.font.color := ltblack;
guitarsfo.loopbass.frame.font.color := ltblack;
guitarsfo.tstringdisp2.font.color := ltblack;
guitarsfo.tstringdisp3.font.color := ltblack;

guitarsfo.tfaceguit.template.fade_color.items[0] := $F5EADA ;
guitarsfo.tfaceguit.template.fade_color.items[1] := $BFB7AA ;

// light
guitarsfo.tfaceguitlight.template.fade_color.items[0] := $DBD3C3 ;
guitarsfo.tfaceguitlight.template.fade_color.items[1] := $FFF5E3 ;

// commander
commanderfo.nameplayers.font.color := ltblack;
commanderfo.namedrums.font.color := ltblack;
commanderfo.linkvol.font.color := ltblack;
commanderfo.linkvol2.font.color := ltblack;
commanderfo.vuin.font.color := ltblack;
commanderfo.linkvol.font.color := ltblack;
commanderfo.timemix.font.color := ltblack;
commanderfo.butinput.font.color := ltblack;
commanderfo.tfacegriptab.template.fade_color.items[0] := $F8DEFF ;
commanderfo.tfacegriptab.template.fade_color.items[1] := $CEB2D6 ;

commanderfo.volumeleft1.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft1.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft2.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeright1.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeright1.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeright2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeright2.scrollbar.face1.template :=  commanderfo.tfaceslider;

commanderfo.tslider2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.tslider2.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.tslider3.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.tslider3.scrollbar.face1.template :=  commanderfo.tfaceslider;

end;

if typecolor.value = 1 then 
begin
// main
tfacebutgray.template.fade_color.items[0] := $F2F2F2 ;
tfacebutgray.template.fade_color.items[1] := $9E9E9E ;

tfacebutltgray.template.fade_color.items[0] := $FAFAFA ;
tfacebutltgray.template.fade_color.items[1] := $D1D1D1 ;
{
tfacegreen.template.fade_color.items[0] := $FDFDFD ;
tfacegreen.template.fade_color.items[1] := $DDDDDD ;

tfaceorange.template.fade_color.items[0] := $FCFCFC ;
tfaceorange.template.fade_color.items[1] := $DDDDDD ;
}
tfacegreen.template.fade_color.items[0] := $C2FF9E ;
tfacegreen.template.fade_color.items[1] := $6EB545 ;

tfaceorange.template.fade_color.items[0] := $FFF9F0 ;
tfaceorange.template.fade_color.items[1] := $FF9D14 ;

//tfacered.template.fade_color.items[0] := $FCFCFC ;
//tfacered.template.fade_color.items[1] := $BABABA ;

tfaceplayer.template.fade_color.items[0] := $EDEDED ;
tfaceplayer.template.fade_color.items[1] := $BABABA ;

tfaceplayerlight.template.fade_color.items[0] := $FDFDFD;
tfaceplayerlight.template.fade_color.items[1] := $DDDDDD;

// players
songplayerfo.font.color := cl_default;
songplayer2fo.font.color := cl_default;

songplayerfo.tstringdisp1.font.color := cl_default;
songplayer2fo.tstringdisp1.font.color := cl_default;

songplayerfo.lposition.font.color := cl_default;
songplayer2fo.lposition.font.color := cl_default;

songplayerfo.llength.font.color := cl_default;
songplayer2fo.llength.font.color := cl_default;

songplayerfo.cbloop.frame.font.color := ltblack;
songplayer2fo.cbloop.frame.font.color := ltblack;

songplayerfo.cbtempo.frame.font.color := ltblack;
songplayer2fo.cbtempo.frame.font.color := ltblack;

songplayerfo.waveformcheck.frame.font.color := ltblack;
songplayer2fo.waveformcheck.frame.font.color := ltblack;

songplayerfo.tstringdisp2.font.color := ltblack;
songplayer2fo.tstringdisp2.font.color := ltblack;

songplayerfo.button1.font.color := ltblack;
songplayer2fo.button1.font.color := ltblack;

songplayerfo.tfaceslider.template.fade_color.items[0] := $EDEDED ;
songplayerfo.tfaceslider.template.fade_color.items[1] := $BABABA ;

songplayer2fo.tfaceslider.template.fade_color.items[0] := $EDEDED ;
songplayer2fo.tfaceslider.template.fade_color.items[1] := $BABABA ;

songplayerfo.tfacegreen.template.fade_color.items[0] := $FCFCFC ;
songplayerfo.tfacegreen.template.fade_color.items[1] := $DDDDDD ;
songplayer2fo.tfacegreen.template.fade_color.items[0] := $FCFCFC ;
songplayer2fo.tfacegreen.template.fade_color.items[1] := $DDDDDD ;

tfaceplayerrev.template.fade_color.items[0] := $BABABA;
tfaceplayerrev.template.fade_color.items[1] := $EDEDED;

// drums
drumsfo.tfacedrums.template.fade_color.items[0] := $CCCCCC ;
drumsfo.tfacedrums.template.fade_color.items[1] := $AAAAAA ;


drumsfo.ltempo.font.color := ltblack;
drumsfo.novoice.frame.font.color := ltblack;
drumsfo.noand.frame.font.color := ltblack;
drumsfo.nodrums.frame.font.color := ltblack;
drumsfo.noanim.frame.font.color := ltblack;
drumsfo.tlabel21.font.color := ltblack;
drumsfo.tlabel22.font.color := ltblack;
drumsfo.tlabel25.font.color := ltblack;
drumsfo.tlabel23.font.color := ltblack;

drumsfo.tstringdisp2.font.color := ltblack;

// rev
drumsfo.tfacecomp2.template.fade_color.items[0] := $EDEDED ;
drumsfo.tfacecomp2.template.fade_color.items[1] := $BABABA ;

// light
drumsfo.tfacecomp3.template.fade_color.items[0] := $EDEDED ;
drumsfo.tfacecomp3.template.fade_color.items[1] := $BABABA ;

// recorder

recorderfo.cbloop.frame.font.color := ltblack;
recorderfo.cbtempo.frame.font.color := ltblack;
recorderfo.bsavetofile.frame.font.color := ltblack;
recorderfo.blistenin.frame.font.color := ltblack;
recorderfo.tlabel27.font.color := ltblack;
recorderfo.label6.font.color := ltblack;
recorderfo.tlabel28.font.color := ltblack;
recorderfo.tlabel2.font.color := ltblack;
recorderfo.btinfos.font.color := ltblack;
recorderfo.button1.font.color := ltblack;
recorderfo.tstringdisp2.font.color := ltblack;
recorderfo.llength.font.color := ltblack;
recorderfo.lposition.font.color := ltblack;

recorderfo.tfacerecorder.template.fade_color.items[0] := $EDEDED ;
recorderfo.tfacerecorder.template.fade_color.items[1] := $BABABA ;

// rev
recorderfo.tfacerecrev.template.fade_color.items[0] := $BABABA ;
recorderfo.tfacerecrev.template.fade_color.items[1] := $EDEDED ;

// light
recorderfo.tfacereclight.template.fade_color.items[0] := $EDEDED ;
recorderfo.tfacereclight.template.fade_color.items[1] := $BABABA ;

// guitar
guitarsfo.loopguit.frame.font.color := ltblack;
guitarsfo.loopbass.frame.font.color := ltblack;
guitarsfo.tstringdisp2.font.color := ltblack;
guitarsfo.tstringdisp3.font.color := ltblack;
guitarsfo.tfaceguit.template.fade_color.items[0] := $EDEDED ;
guitarsfo.tfaceguit.template.fade_color.items[1] := $BABABA ;

// light
guitarsfo.tfaceguitlight.template.fade_color.items[0] := $EDEDED ;
guitarsfo.tfaceguitlight.template.fade_color.items[1] := $BABABA ;

// commander
commanderfo.nameplayers.font.color := ltblack;
commanderfo.namedrums.font.color := ltblack;
commanderfo.linkvol.font.color := ltblack;
commanderfo.linkvol2.font.color := ltblack;
commanderfo.vuin.font.color := ltblack;
commanderfo.linkvol.font.color := ltblack;
commanderfo.timemix.font.color := ltblack;
commanderfo.butinput.font.color := ltblack;

commanderfo.volumeleft1.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft1.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeleft2.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeright1.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeright1.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.volumeright2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.volumeright2.scrollbar.face1.template :=  commanderfo.tfaceslider;

commanderfo.tslider2.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.tslider2.scrollbar.face1.template :=  commanderfo.tfaceslider;
commanderfo.tslider3.scrollbar.face.template :=  commanderfo.tfaceslider;
commanderfo.tslider3.scrollbar.face1.template :=  commanderfo.tfaceslider;

commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED ;
commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA ;

filelistfo.list_files.font.color := cl_black;
end;

if typecolor.value = 2 then 
begin
// main
tfacebutgray.template.fade_color.items[0] := $888888 ;
tfacebutgray.template.fade_color.items[1] := $2A2A2A ;

tfacebutltgray.template.fade_color.items[0] := $5A5A5A ;
tfacebutltgray.template.fade_color.items[1] := $2A2A2A ;

tfacegreen.template.fade_color.items[0] := $AAAAAA ;
tfacegreen.template.fade_color.items[1] := $2A2A2A ;

tfaceorange.template.fade_color.items[0] := $D2D2D2 ;
tfaceorange.template.fade_color.items[1] := $5E5E5E ;

//tfacered.template.fade_color.items[0] := $BABABA ;
//tfacered.template.fade_color.items[1] := $5A5A5A ;

tfaceplayer.template.fade_color.items[0] := $5A5A5A ;
tfaceplayer.template.fade_color.items[1] := $2A2A2A ;

tfaceplayerlight.template.fade_color.items[0] := $5A5A5A;
tfaceplayerlight.template.fade_color.items[1] := $2A2A2A;

// players
songplayerfo.tfaceslider.template.fade_color.items[0] := $5A5A5A ;
songplayerfo.tfaceslider.template.fade_color.items[1] := $2A2A2A ;

songplayerfo.font.color := ltblank;
songplayer2fo.font.color := ltblank;

songplayerfo.tstringdisp1.font.color := ltblank;
songplayer2fo.tstringdisp1.font.color := ltblank;

songplayerfo.lposition.font.color := ltblank;
songplayer2fo.lposition.font.color := ltblank;

songplayerfo.llength.font.color := ltblank;
songplayer2fo.llength.font.color := ltblank;

songplayerfo.cbloop.frame.font.color := ltblank;
songplayer2fo.cbloop.frame.font.color := ltblank;

songplayerfo.cbtempo.frame.font.color := ltblank;
songplayer2fo.cbtempo.frame.font.color := ltblank;

songplayerfo.waveformcheck.frame.font.color := ltblank;
songplayer2fo.waveformcheck.frame.font.color := ltblank;

songplayerfo.tstringdisp2.font.color := ltblank;
songplayer2fo.tstringdisp2.font.color := ltblank;

songplayerfo.button1.font.color := ltblank;
songplayer2fo.button1.font.color := ltblank;

songplayer2fo.tfaceslider.template.fade_color.items[0] := $5A5A5A ;
songplayer2fo.tfaceslider.template.fade_color.items[1] := $2A2A2A ;

songplayerfo.tfacegreen.template.fade_color.items[0] := $AAAAAA ;
songplayerfo.tfacegreen.template.fade_color.items[1] := $5A5A5A ;
songplayer2fo.tfacegreen.template.fade_color.items[0] := $AAAAAA ;
songplayer2fo.tfacegreen.template.fade_color.items[1] := $5A5A5A ;

tfaceplayerrev.template.fade_color.items[0] := $2A2A2A;
tfaceplayerrev.template.fade_color.items[1] := $5A5A5A;

// drums
//drumsfo.panel1.font.color := cl_white;

//drumsfo.font.color := cl_black;

drumsfo.tstringdisp2.font.color := ltblank;
drumsfo.ltempo.font.color := ltblank;
drumsfo.novoice.frame.font.color := ltblank;
drumsfo.noand.frame.font.color := ltblank;
drumsfo.nodrums.frame.font.color := ltblank;
drumsfo.noanim.frame.font.color := ltblank;
drumsfo.tlabel21.font.color := ltblank;
drumsfo.tlabel22.font.color := ltblank;
drumsfo.tlabel25.font.color := ltblank;
drumsfo.tlabel23.font.color := ltblank;

drumsfo.tfacedrums.template.fade_color.items[0] := $5A5A5A ;
drumsfo.tfacedrums.template.fade_color.items[1] := $2A2A2A ;


// rev
drumsfo.tfacecomp2.template.fade_color.items[0] := $5A5A5A ;
drumsfo.tfacecomp2.template.fade_color.items[1] := $2A2A2A ;

// light
drumsfo.tfacecomp3.template.fade_color.items[0] := $BABABA ;
drumsfo.tfacecomp3.template.fade_color.items[1] := $5A5A5A ;

// recorder
recorderfo.cbloop.frame.font.color := ltblank;
recorderfo.cbtempo.frame.font.color := ltblank;
recorderfo.bsavetofile.frame.font.color := ltblank;
recorderfo.blistenin.frame.font.color := ltblank;
recorderfo.tlabel27.font.color := ltblank;
recorderfo.label6.font.color := ltblank;
recorderfo.tlabel28.font.color := ltblank;
recorderfo.tlabel2.font.color := ltblank;
recorderfo.btinfos.font.color := ltblank;
recorderfo.button1.font.color := ltblank;
recorderfo.tstringdisp2.font.color := ltblank;
recorderfo.llength.font.color := ltblank;
recorderfo.lposition.font.color := ltblank;

recorderfo.tfacerecorder.template.fade_color.items[0] := $5A5A5A ;
recorderfo.tfacerecorder.template.fade_color.items[1] := $2A2A2A ;

// rev
recorderfo.tfacerecrev.template.fade_color.items[0] := $2A2A2A ;
recorderfo.tfacerecrev.template.fade_color.items[1] := $5A5A5A ;

// light
recorderfo.tfacereclight.template.fade_color.items[0] := $5A5A5A ;
recorderfo.tfacereclight.template.fade_color.items[1] := $2A2A2A ;

// guitar
guitarsfo.loopguit.frame.font.color := ltblank;
guitarsfo.loopbass.frame.font.color := ltblank;
guitarsfo.tstringdisp2.font.color := ltblank;
guitarsfo.tstringdisp3.font.color := ltblank;
guitarsfo.tfaceguit.template.fade_color.items[0] := $5A5A5A ;
guitarsfo.tfaceguit.template.fade_color.items[1] := $2A2A2A ;

// light
guitarsfo.tfaceguitlight.template.fade_color.items[0] := $BABABA ;
guitarsfo.tfaceguitlight.template.fade_color.items[1] := $5A5A5A ;

// commander
commanderfo.nameplayers.font.color := ltblank;
commanderfo.namedrums.font.color := ltblank;
commanderfo.linkvol.font.color := ltblank;
commanderfo.linkvol2.font.color := ltblank;
commanderfo.vuin.font.color := ltblank;
commanderfo.linkvol.font.color := ltblank;
commanderfo.timemix.font.color := ltblank;
commanderfo.butinput.font.color := ltblack;

commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED ;
commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA ;

commanderfo.volumeleft1.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeleft1.scrollbar.face1.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeleft2.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeleft2.scrollbar.face1.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeright1.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeright1.scrollbar.face1.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeright2.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.volumeright2.scrollbar.face1.template :=  commanderfo.tfacesliderdark;

commanderfo.tslider2.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.tslider2.scrollbar.face1.template :=  commanderfo.tfacesliderdark;
commanderfo.tslider3.scrollbar.face.template :=  commanderfo.tfacesliderdark;
commanderfo.tslider3.scrollbar.face1.template :=  commanderfo.tfacesliderdark;

filelistfo.list_files.font.color := cl_black;

end;

songplayerfo.DrawWaveForm();
songplayer2fo.DrawWaveForm();
 
end;


end.
