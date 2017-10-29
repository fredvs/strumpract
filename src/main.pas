unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface

uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msegui,
 msetimer, ctypes, msegraphics, msegraphutils, mseclasses, msewidgets, mseforms,
 msedock, drums, recorder, songplayer, songplayer2, commander, filelistform,
 guitars, msedataedits, mseedit, msestatfile, SysUtils, Classes, uos_flat,
 aboutform, msebitmap, msesys, msemenus, msestream, msegrids, mselistbrowser,
 mseact, mseificomp, mseificompglob, mseifiglob, msestrings;

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
   tfaceplayerbut: tfacecomp;
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

    procedure hideall(const Sender: TObject);
    procedure showcommander(const Sender: TObject);
    procedure showfiles(const Sender: TObject);
    procedure changecolors(const Sender: TObject);
    procedure changesilver(const Sender: TObject);
    procedure changecarbon(const Sender: TObject);
    procedure onchangevalcolor(const Sender: TObject);
    procedure onmenuaudio(const Sender: TObject);
    procedure onresized(const Sender: TObject);
  private
    flayoutlock: int32;
  protected
    procedure beginlayout();
    procedure endlayout();
  public
    procedure updatelayout();
  end;

const
  versiontext = '1.5.3';
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
  config,
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

  if not fileexists(tstatfile1.filename) then
    top := 30;

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
  //cueliststa.filename := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'cuelist.sta';
  
  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 250000;
  Timerwait.Enabled := False;
  Timerwait.ontimer := @ontimerwait;
end;

procedure tmainfo.onabout(const Sender: TObject);
begin
  aboutfo.Caption := 'About StrumPract';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value :=  c_linefeed + 'StrumPract ' + versiontext + ' for ' + platformtext +
 c_linefeed +  'https://github.com/fredvs/strumpract/releases/' +
    c_linefeed +
    c_linefeed + 'Compiled with FPC 3.0.3.' + c_linefeed + 'http://www.freepascal.org' + c_linefeed +
    c_linefeed + 'Graphic widget: MSEgui ' + mseguiversiontext + '.' + c_linefeed + 'http://sourceforge.net/projects/mseide-msegui/' +
    c_linefeed + c_linefeed + 'Audio library: uos 1.7. (United Openlib of Sound)' + c_linefeed + 'https://github.com/fredvs/uos' +
    c_linefeed + c_linefeed + 'Copyright 2017' + c_linefeed + 'Fred van Stappen <fiens@hotmail.com>';
  aboutfo.Show(True);
end;

procedure tmainfo.dodestroy(const Sender: TObject);
begin
  uos_free();
  Timerwait.Free;
end;

procedure tmainfo.oncreatedform(const Sender: TObject);
var
  x: integer;

begin
  Caption := 'StrumPract ' + versiontext;

  if not fileexists(tstatfile1.filename) then
  begin
     {$if defined(cpuarm)}
    configfo.latdrums.Value := 0.08;
    configfo.latplay.Value := 0.3;
    configfo.latrec.Value := 0.3;
      {$endif}
     showall(Sender);
    ondockall(Sender);
   end;

  if (filelistfo.Visible) then
  begin
    if (filelistfo.parentwidget = nil) then
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := 1024;
    end
    else
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := filelistfoheight;
      filelistfo.Width := fowidth;
      filelistfo.Height := filelistfoheight;
    end;
  end;

  UOS_GetInfoDevice();

  x := 0;

  while x < UOSDeviceCount do
  begin
    if UOSDeviceInfos[x].DefaultDevOut = True then
    begin

      configfo.lsuglat.Caption := 'Audio API ' + UOSDeviceInfos[x].HostAPIName + ': Suggested latency = ' +
        floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8);

    end;
    Inc(x);
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

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 1024;

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

  timerwait.Enabled := True;

end;

procedure tmainfo.ondockall(const Sender: TObject);
var
  pt1: pointty;
  decorationheight: integer = 5;
begin
  // basedock.anchors := [an_left,an_top]  ;

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 1024;

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
  
  if Height > 699 then
  begin
    timerwait.Enabled := false;
    timerwait.Enabled := True;
  end;
  

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
  filelistfo.bounds_cymax := filelistfoheight;
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

procedure tmainfo.hideall(const Sender: TObject);
begin
  //beginlayout();
  drumsfo.Visible := False;
  filelistfo.Visible := False;
  songplayerfo.Visible := False;
  songplayer2fo.Visible := False;
  commanderfo.Visible := False;
  guitarsfo.Visible := False;
  recorderfo.Visible := False;

  // endlayout();
  timerwait.Enabled := True;
end;

procedure tmainfo.showcommander(const Sender: TObject);
begin
  commanderfo.Visible := not commanderfo.Visible;
end;

procedure tmainfo.showfiles(const Sender: TObject);
begin
  filelistfo.Visible := not filelistfo.Visible;
end;

procedure tmainfo.changecolors(const Sender: TObject);
begin
  typecolor.Value := 0;
end;

procedure tmainfo.changesilver(const Sender: TObject);
begin
  typecolor.Value := 1;
end;

procedure tmainfo.changecarbon(const Sender: TObject);
begin
  typecolor.Value := 2;
end;

procedure tmainfo.onchangevalcolor(const Sender: TObject);
var
  ltblank: integer = $F0F0F0;
  ltblack: integer = $2D2D2D;
begin
  if typecolor.Value = 0 then
  begin

    // main
    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[1] := $FF7878;

    // players
    songplayerfo.font.color := ltblack;
    songplayer2fo.font.color := ltblack;

    tfaceplayer.template.fade_color.items[0] := $F9FFC2;
    tfaceplayer.template.fade_color.items[1] := $C4C999;
    
     tfaceplayerbut.template.fade_color.items[0] := $F9FFC2;
    tfaceplayerbut.template.fade_color.items[1] := $C4C999;

    tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[1] := $9E9E9E;

    tfacebutltgray.template.fade_color.items[0] := $FAFAFA;
    tfacebutltgray.template.fade_color.items[1] := $D1D1D1;

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

    songplayerfo.tstringdisp1.color := ltblack;
    songplayer2fo.tstringdisp1.color := ltblack;

    songplayerfo.cbloop.colorglyph := ltblack;
    songplayer2fo.cbloop.colorglyph := ltblack;
    songplayerfo.cbtempo.colorglyph := ltblack;
    songplayer2fo.cbtempo.colorglyph := ltblack;
    songplayerfo.waveformcheck.colorglyph := ltblack;
    songplayer2fo.waveformcheck.colorglyph := ltblack;

    songplayerfo.edvolleft.frame.colorglyph := ltblack;
    songplayer2fo.edvolleft.frame.colorglyph := ltblack;

    songplayerfo.edvolright.frame.colorglyph := ltblack;
    songplayer2fo.edvolright.frame.colorglyph := ltblack;
    songplayerfo.edtempo.frame.colorglyph := ltblack;
    songplayer2fo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.songdir.frame.button.colorglyph := ltblack;
    songplayer2fo.songdir.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.frame.button.colorglyph := ltblack;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.font.color := ltblack;
    songplayer2fo.historyfn.font.color := ltblack;
    songplayerfo.edvolleft.font.color := ltblack;
    songplayer2fo.edvolleft.font.color := ltblack;

    songplayerfo.edvolright.font.color := ltblack;
    songplayer2fo.edvolright.font.color := ltblack;
    songplayerfo.edtempo.font.color := ltblack;
    songplayer2fo.edtempo.font.color := ltblack;

    songplayerfo.btinfos.font.color := ltblack;
    songplayer2fo.btinfos.font.color := ltblack;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $F9FFC2;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $C4C999;
    songplayer2fo.tfaceslider.template.fade_color.items[0] := $F9FFC2;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $C4C999;

    songplayerfo.tfacegreen.template.fade_color.items[0] := $C2FF9E;
    songplayerfo.tfacegreen.template.fade_color.items[1] := $6EB545;
    songplayer2fo.tfacegreen.template.fade_color.items[0] := $C2FF9E;
    songplayer2fo.tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceplayerlight.template.fade_color.items[0] := $FDFFEB;
    tfaceplayerlight.template.fade_color.items[1] := $E3E8B0;

    tfaceplayerrev.template.fade_color.items[0] := $C4C999;
    tfaceplayerrev.template.fade_color.items[1] := $F3FABE;

    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    drumsfo.edittempo.frame.colorglyph := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;

    drumsfo.tfacedrums.template.fade_color.items[0] := $9AAD97;
    drumsfo.tfacedrums.template.fade_color.items[1] := $D6F0D1;
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
    drumsfo.tfacecomp2.template.fade_color.items[0] := $D6F0D1;
    drumsfo.tfacecomp2.template.fade_color.items[1] := $9CAF99;

    // light
    drumsfo.tfacecomp3.template.fade_color.items[0] := $F9FFF7;
    drumsfo.tfacecomp3.template.fade_color.items[1] := $BCD4B8;

    // recorder
    recorderfo.font.color := ltblack;
    recorderfo.tfacerecorder.template.fade_color.items[0] := $FFE3E3;
    recorderfo.tfacerecorder.template.fade_color.items[1] := $DA9D9D;

    recorderfo.cbloop.colorglyph := ltblack;
    recorderfo.cbtempo.colorglyph := ltblack;
    recorderfo.bsavetofile.colorglyph := ltblack;
    recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.songdir.frame.button.colorglyph := ltblack;
    recorderfo.historyfn.frame.button.colorglyph := ltblack;

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
    recorderfo.tfacerecrev.template.fade_color.items[0] := $D9C1C1;
    recorderfo.tfacerecrev.template.fade_color.items[1] := $FFE3E3;

    // light
    recorderfo.tfacereclight.template.fade_color.items[0] := $FFF7F7;
    recorderfo.tfacereclight.template.fade_color.items[1] := $EDD3D3;

    // guitar

    guitarsfo.font.color := ltblack;
    guitarsfo.tgroupbox1.font.color := ltblack;
    guitarsfo.tgroupbox2.font.color := ltblack;
    guitarsfo.loopguit.colorglyph := ltblack;
    guitarsfo.loopbass.colorglyph := ltblack;
    guitarsfo.loopguit.frame.font.color := ltblack;
    guitarsfo.loopbass.frame.font.color := ltblack;
    guitarsfo.tstringdisp2.font.color := ltblack;
    guitarsfo.tstringdisp3.font.color := ltblack;

    guitarsfo.tfaceguit.template.fade_color.items[0] := $F5EADA;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $BFB7AA;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $DBD3C3;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $FFF5E3;

    // commander
    commanderfo.nameplayers.font.color := ltblack;
    commanderfo.namedrums.font.color := ltblack;
    commanderfo.namegen.font.color := ltblack;
    commanderfo.nameinput.font.color := ltblack;
    commanderfo.genleftvolvalue.font.color := ltblack;
    commanderfo.genrightvolvalue.font.color := ltblack; 
    commanderfo.vuin.colorglyph := ltblack;
    commanderfo.vuin.frame.font.color := ltblack; 
    
         commanderfo.volumeleft1val.font.color := ltblack;
    commanderfo.volumeleft2val.font.color := ltblack;
  
     commanderfo.volumeright1val.font.color := ltblack;
    commanderfo.volumeright2val.font.color := ltblack;
    
      commanderfo.tslider2val.font.color := ltblack;
    commanderfo.tslider3val.font.color := ltblack;
 
    
    commanderfo.butinput.colorglyph := ltblack;
    commanderfo.butinput.frame.font.color := ltblack; 
    
    commanderfo.automix.colorglyph := ltblack;
    commanderfo.automix.frame.font.color := ltblack; 
    
    commanderfo.linkvol.colorglyph := ltblack;
    commanderfo.linkvol.frame.font.color := ltblack; 
    
    commanderfo.linkvol2.colorglyph := ltblack;
    commanderfo.linkvol2.frame.font.color := ltblack; 
    
    commanderfo.linkvolgen.colorglyph := ltblack;
    commanderfo.linkvolgen.frame.font.color := ltblack; 
     
    commanderfo.timemix.font.color := ltblack;
  
    commanderfo.timemix.frame.colorglyph := ltblack;
  
    commanderfo.tfacegriptab.template.fade_color.items[0] := $F8DEFF;
    commanderfo.tfacegriptab.template.fade_color.items[1] := $CEB2D6;
    
    
    commanderfo.timemix.frame.font.color := ltblack;
   
    commanderfo.genvolleft.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.genvolleft.scrollbar.face1.template := commanderfo.tfaceslider;
   
    commanderfo.genvolright.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.genvolright.scrollbar.face1.template := commanderfo.tfaceslider;
  

    commanderfo.volumeleft1.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeleft1.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeleft2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeleft2.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeright1.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeright1.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeright2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeright2.scrollbar.face1.template := commanderfo.tfaceslider;

    commanderfo.tslider2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.tslider2.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.tslider3.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.tslider3.scrollbar.face1.template := commanderfo.tfaceslider;


    filelistfo.list_files.font.color := ltblack;
    filelistfo.tgroupbox1.font.color := ltblack;
    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.songdir.frame.button.colorglyph := ltblack;
    filelistfo.list_files.datacols[0].color := cl_white;
    filelistfo.list_files.datacols[0].font.color := ltblack;
    filelistfo.list_files.datacols[1].color := cl_white;
    filelistfo.list_files.datacols[1].font.color := ltblack;
    filelistfo.list_files.datacols[2].color := cl_white;
    filelistfo.list_files.datacols[2].font.color := ltblack;
    filelistfo.list_files.datacols[3].color := cl_white;
    filelistfo.list_files.datacols[3].font.color := ltblack;
    filelistfo.list_files.datacols[3].colorselect := $EDEDED;
    filelistfo.list_files.datacols[3].colorglyph := ltblack;
    aboutfo.font.color := cl_black;
    // configfo.font.color := ltblack;
  end;

  if typecolor.Value = 1 then
  begin
    // main
    tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[1] := $9E9E9E;

    tfacebutltgray.template.fade_color.items[0] := $FAFAFA;
    tfacebutltgray.template.fade_color.items[1] := $D1D1D1;
{
tfacegreen.template.fade_color.items[0] := $FDFDFD ;
tfacegreen.template.fade_color.items[1] := $DDDDDD ;

tfaceorange.template.fade_color.items[0] := $FCFCFC ;
tfaceorange.template.fade_color.items[1] := $DDDDDD ;
}
    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    //tfacered.template.fade_color.items[0] := $FCFCFC ;
    //tfacered.template.fade_color.items[1] := $BABABA ;

    tfaceplayer.template.fade_color.items[0] := $EDEDED;
    tfaceplayer.template.fade_color.items[1] := $BABABA;
    
    tfaceplayerbut.template.fade_color.items[0] := $EDEDED;
    tfaceplayerbut.template.fade_color.items[1] := $BABABA;

    tfaceplayerlight.template.fade_color.items[0] := $FDFDFD;
    tfaceplayerlight.template.fade_color.items[1] := $DDDDDD;

    // players
    songplayerfo.font.color := cl_default;
    songplayer2fo.font.color := cl_default;

    songplayerfo.tstringdisp1.font.color := ltblack;
    songplayer2fo.tstringdisp1.font.color := ltblack;

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

    songplayerfo.cbloop.colorglyph := ltblack;
    songplayer2fo.cbloop.colorglyph := ltblack;
    songplayerfo.cbtempo.colorglyph := ltblack;
    songplayer2fo.cbtempo.colorglyph := ltblack;
    songplayerfo.waveformcheck.colorglyph := ltblack;
    songplayer2fo.waveformcheck.colorglyph := ltblack;

    songplayerfo.edvolleft.frame.colorglyph := ltblack;
    songplayer2fo.edvolleft.frame.colorglyph := ltblack;

    songplayerfo.edvolright.frame.colorglyph := ltblack;
    songplayer2fo.edvolright.frame.colorglyph := ltblack;
    songplayerfo.edtempo.frame.colorglyph := ltblack;
    songplayer2fo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.songdir.frame.button.colorglyph := ltblack;
    songplayer2fo.songdir.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.frame.button.colorglyph := ltblack;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.font.color := ltblack;
    songplayer2fo.historyfn.font.color := ltblack;
    songplayerfo.edvolleft.font.color := ltblack;
    songplayer2fo.edvolleft.font.color := ltblack;

    songplayerfo.edvolright.font.color := ltblack;
    songplayer2fo.edvolright.font.color := ltblack;
    songplayerfo.edtempo.font.color := ltblack;
    songplayer2fo.edtempo.font.color := ltblack;

    songplayerfo.btinfos.font.color := ltblack;
    songplayer2fo.btinfos.font.color := ltblack;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $EDEDED;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $BABABA;

    songplayer2fo.tfaceslider.template.fade_color.items[0] := $EDEDED;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $BABABA;

    songplayerfo.tfacegreen.template.fade_color.items[0] := $FCFCFC;
    songplayerfo.tfacegreen.template.fade_color.items[1] := $DDDDDD;
    songplayer2fo.tfacegreen.template.fade_color.items[0] := $FCFCFC;
    songplayer2fo.tfacegreen.template.fade_color.items[1] := $DDDDDD;

    tfaceplayerrev.template.fade_color.items[0] := $BABABA;
    tfaceplayerrev.template.fade_color.items[1] := $EDEDED;

    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    drumsfo.tfacedrums.template.fade_color.items[0] := $CCCCCC;
    drumsfo.tfacedrums.template.fade_color.items[1] := $AAAAAA;

    drumsfo.edittempo.frame.colorglyph := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;

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
    drumsfo.tfacecomp2.template.fade_color.items[0] := $EDEDED;
    drumsfo.tfacecomp2.template.fade_color.items[1] := $BABABA;

    // light
    drumsfo.tfacecomp3.template.fade_color.items[0] := $EDEDED;
    drumsfo.tfacecomp3.template.fade_color.items[1] := $BABABA;

    // recorder
    recorderfo.font.color := ltblack;

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

    recorderfo.cbloop.colorglyph := ltblack;
    recorderfo.cbtempo.colorglyph := ltblack;
    recorderfo.bsavetofile.colorglyph := ltblack;
    recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.songdir.frame.button.colorglyph := ltblack;
    recorderfo.historyfn.frame.button.colorglyph := ltblack;

    recorderfo.tfacerecorder.template.fade_color.items[0] := $EDEDED;
    recorderfo.tfacerecorder.template.fade_color.items[1] := $BABABA;

    // rev
    recorderfo.tfacerecrev.template.fade_color.items[0] := $BABABA;
    recorderfo.tfacerecrev.template.fade_color.items[1] := $EDEDED;

    // light
    recorderfo.tfacereclight.template.fade_color.items[0] := $EDEDED;
    recorderfo.tfacereclight.template.fade_color.items[1] := $BABABA;

    // guitar

    guitarsfo.font.color := ltblack;

    guitarsfo.tgroupbox1.font.color := ltblack;
    guitarsfo.tgroupbox2.font.color := ltblack;

    guitarsfo.loopguit.colorglyph := ltblack;
    guitarsfo.loopbass.colorglyph := ltblack;
    guitarsfo.loopguit.frame.font.color := ltblack;
    guitarsfo.loopbass.frame.font.color := ltblack;
    guitarsfo.tstringdisp2.font.color := ltblack;
    guitarsfo.tstringdisp3.font.color := ltblack;
    guitarsfo.tfaceguit.template.fade_color.items[0] := $EDEDED;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $BABABA;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $EDEDED;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $BABABA;

    // commander
    commanderfo.nameplayers.font.color := ltblack;
    commanderfo.namedrums.font.color := ltblack;
    commanderfo.namegen.font.color := ltblack;
    commanderfo.nameinput.font.color := ltblack;
    commanderfo.genleftvolvalue.font.color := ltblack;
    commanderfo.genrightvolvalue.font.color := ltblack;
    
      commanderfo.volumeleft1val.font.color := ltblack;
    commanderfo.volumeleft2val.font.color := ltblack;
  
     commanderfo.volumeright1val.font.color := ltblack;
    commanderfo.volumeright2val.font.color := ltblack;
    
      commanderfo.tslider2val.font.color := ltblack;
    commanderfo.tslider3val.font.color := ltblack;
 
    
    commanderfo.timemix.font.color := ltblack;
 
    commanderfo.timemix.frame.colorglyph := ltblack;
    
    commanderfo.timemix.frame.font.color := ltblack;
   
    commanderfo.genvolleft.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.genvolleft.scrollbar.face1.template := commanderfo.tfaceslider;
   
    commanderfo.genvolright.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.genvolright.scrollbar.face1.template := commanderfo.tfaceslider;

    
    commanderfo.vuin.colorglyph := ltblack;
    commanderfo.vuin.frame.font.color := ltblack; 
    
    commanderfo.butinput.colorglyph := ltblack;
    commanderfo.butinput.frame.font.color := ltblack; 
    
    commanderfo.automix.colorglyph := ltblack;
    commanderfo.automix.frame.font.color := ltblack; 
    
    commanderfo.linkvol.colorglyph := ltblack;
    commanderfo.linkvol.frame.font.color := ltblack; 
    
    commanderfo.linkvol2.colorglyph := ltblack;
    commanderfo.linkvol2.frame.font.color := ltblack; 
    
    commanderfo.linkvolgen.colorglyph := ltblack;
    commanderfo.linkvolgen.frame.font.color := ltblack; 

    commanderfo.volumeleft1.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeleft1.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeleft2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeleft2.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeright1.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeright1.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.volumeright2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.volumeright2.scrollbar.face1.template := commanderfo.tfaceslider;

    commanderfo.tslider2.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.tslider2.scrollbar.face1.template := commanderfo.tfaceslider;
    commanderfo.tslider3.scrollbar.face.template := commanderfo.tfaceslider;
    commanderfo.tslider3.scrollbar.face1.template := commanderfo.tfaceslider;

    commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED;
    commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA;

    filelistfo.list_files.font.color := ltblack;
    filelistfo.tgroupbox1.font.color := ltblack;

    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.songdir.frame.button.colorglyph := ltblack;

    filelistfo.list_files.datacols[0].color := cl_white;
    filelistfo.list_files.datacols[0].font.color := ltblack;
    filelistfo.list_files.datacols[1].color := cl_white;
    filelistfo.list_files.datacols[1].font.color := ltblack;
    filelistfo.list_files.datacols[2].color := cl_white;
    filelistfo.list_files.datacols[2].font.color := ltblack;
    filelistfo.list_files.datacols[3].color := cl_white;
    filelistfo.list_files.datacols[3].font.color := ltblack;

    filelistfo.list_files.datacols[3].colorglyph := ltblack;
    filelistfo.list_files.datacols[3].colorselect := $EDEDED;

    aboutfo.font.color := cl_black;
    // configfo.font.color := ltblack;
  end;

  if typecolor.Value = 2 then
  begin
    // main
    tfacebutgray.template.fade_color.items[0] := $888888;
    tfacebutgray.template.fade_color.items[1] := $2A2A2A;

    tfacebutltgray.template.fade_color.items[0] := $5A5A5A;
    tfacebutltgray.template.fade_color.items[1] := $2A2A2A;

    tfacegreen.template.fade_color.items[0] := $CCCCCC;
    tfacegreen.template.fade_color.items[1] := $2A2A2A;

  //  tfaceorange.template.fade_color.items[0] := $BABABA;
  //  tfaceorange.template.fade_color.items[1] := $3E3E3E;
  
    tfaceorange.template.fade_color.items[0] := $FF9D14;
    tfaceorange.template.fade_color.items[1] := $EE9D14;

    //tfacered.template.fade_color.items[0] := $BABABA ;
    //tfacered.template.fade_color.items[1] := $5A5A5A ;

    tfaceplayer.template.fade_color.items[0] := $5A5A5A;
    tfaceplayer.template.fade_color.items[1] := $2A2A2A;
    
    tfaceplayerbut.template.fade_color.items[0] := $5A5A5A;
    tfaceplayerbut.template.fade_color.items[1] := $5A5A5A;

    tfaceplayerlight.template.fade_color.items[0] := $5A5A5A;
    tfaceplayerlight.template.fade_color.items[1] := $2A2A2A;

    // players
    songplayerfo.tfaceslider.template.fade_color.items[0] := $5A5A5A;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $2A2A2A;

    songplayerfo.font.color := ltblank;
    songplayer2fo.font.color := ltblank;

    drumsfo.edittempo.frame.colorglyph := ltblank;
    drumsfo.volumedrums.frame.colorglyph := ltblank;

    songplayerfo.tstringdisp1.font.color := ltblank;
    songplayer2fo.tstringdisp1.font.color := ltblank;

    songplayerfo.lposition.font.color := ltblank;
    songplayer2fo.lposition.font.color := ltblank;

    songplayerfo.llength.font.color := ltblank;
    songplayer2fo.llength.font.color := ltblank;

    songplayerfo.cbloop.colorglyph := ltblank;
    songplayer2fo.cbloop.colorglyph := ltblank;
    songplayerfo.cbtempo.colorglyph := ltblank;
    songplayer2fo.cbtempo.colorglyph := ltblank;
    songplayerfo.waveformcheck.colorglyph := ltblank;
    songplayer2fo.waveformcheck.colorglyph := ltblank;

    songplayerfo.edvolleft.frame.colorglyph := ltblank;
    songplayer2fo.edvolleft.frame.colorglyph := ltblank;

    songplayerfo.edvolright.frame.colorglyph := ltblank;
    songplayer2fo.edvolright.frame.colorglyph := ltblank;
    songplayerfo.edtempo.frame.colorglyph := ltblank;
    songplayer2fo.edtempo.frame.colorglyph := ltblank;

    songplayerfo.historyfn.font.color := ltblank;
    songplayer2fo.historyfn.font.color := ltblank;
    songplayerfo.edvolleft.font.color := ltblank;
    songplayer2fo.edvolleft.font.color := ltblank;

    songplayerfo.edvolright.font.color := ltblank;
    songplayer2fo.edvolright.font.color := ltblank;
    songplayerfo.edtempo.font.color := ltblank;
    songplayer2fo.edtempo.font.color := ltblank;

    songplayerfo.btinfos.font.color := ltblank;
    songplayer2fo.btinfos.font.color := ltblank;

    songplayerfo.songdir.frame.button.colorglyph := ltblank;
    songplayer2fo.songdir.frame.button.colorglyph := ltblank;

    songplayerfo.historyfn.frame.button.colorglyph := ltblank;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblank;

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

    songplayer2fo.tfaceslider.template.fade_color.items[0] := $5A5A5A;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $2A2A2A;

    songplayerfo.tfacegreen.template.fade_color.items[0] := $AAAAAA;
    songplayerfo.tfacegreen.template.fade_color.items[1] := $5A5A5A;
    songplayer2fo.tfacegreen.template.fade_color.items[0] := $AAAAAA;
    songplayer2fo.tfacegreen.template.fade_color.items[1] := $5A5A5A;

    tfaceplayerrev.template.fade_color.items[0] := $2A2A2A;
    tfaceplayerrev.template.fade_color.items[1] := $5A5A5A;

    // drums
    drumsfo.tdockpanel1.font.color := cl_black;

    drumsfo.panel1.font.color := cl_white;

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

    drumsfo.tfacedrums.template.fade_color.items[0] := $5A5A5A;
    drumsfo.tfacedrums.template.fade_color.items[1] := $2A2A2A;

    // rev
    drumsfo.tfacecomp2.template.fade_color.items[0] := $5A5A5A;
    drumsfo.tfacecomp2.template.fade_color.items[1] := $2A2A2A;

    // light
    drumsfo.tfacecomp3.template.fade_color.items[0] := $BABABA;
    drumsfo.tfacecomp3.template.fade_color.items[1] := $5A5A5A;

    // recorder
    recorderfo.font.color := ltblank;

    recorderfo.cbloop.frame.font.color := ltblank;
    recorderfo.cbtempo.frame.font.color := ltblank;

    recorderfo.cbloop.colorglyph := ltblank;
    recorderfo.cbtempo.colorglyph := ltblank;
    recorderfo.bsavetofile.colorglyph := ltblank;
    recorderfo.blistenin.colorglyph := ltblank;

    recorderfo.songdir.frame.button.colorglyph := ltblank;
    recorderfo.historyfn.frame.button.colorglyph := ltblank;

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

    recorderfo.tfacerecorder.template.fade_color.items[0] := $5A5A5A;
    recorderfo.tfacerecorder.template.fade_color.items[1] := $2A2A2A;

    // rev
    recorderfo.tfacerecrev.template.fade_color.items[0] := $2A2A2A;
    recorderfo.tfacerecrev.template.fade_color.items[1] := $5A5A5A;

    // light
    recorderfo.tfacereclight.template.fade_color.items[0] := $5A5A5A;
    recorderfo.tfacereclight.template.fade_color.items[1] := $2A2A2A;

    // guitar
    guitarsfo.font.color := ltblank;
    guitarsfo.tgroupbox1.font.color := ltblank;
    guitarsfo.tgroupbox2.font.color := ltblank;

    guitarsfo.loopguit.colorglyph := ltblank;
    guitarsfo.loopbass.colorglyph := ltblank;
    guitarsfo.loopguit.frame.font.color := ltblank;
    guitarsfo.loopbass.frame.font.color := ltblank;
    guitarsfo.tstringdisp2.font.color := ltblank;
    guitarsfo.tstringdisp3.font.color := ltblank;
    guitarsfo.tfaceguit.template.fade_color.items[0] := $5A5A5A;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $2A2A2A;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $BABABA;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $5A5A5A;

    // commander
    commanderfo.nameplayers.font.color := ltblank;
    commanderfo.namedrums.font.color := ltblank;
    
    commanderfo.namegen.font.color := ltblank;
    commanderfo.nameinput.font.color := ltblank;
    commanderfo.genleftvolvalue.font.color := ltblank;
    commanderfo.genrightvolvalue.font.color := ltblank;
    
     commanderfo.volumeleft1val.font.color := ltblank;
    commanderfo.volumeleft2val.font.color := ltblank;
  
     commanderfo.volumeright1val.font.color := ltblank;
    commanderfo.volumeright2val.font.color := ltblank;
    
      commanderfo.tslider2val.font.color := ltblank;
    commanderfo.tslider3val.font.color := ltblank;
  
  
    commanderfo.timemix.font.color := ltblank;

     commanderfo.vuin.colorglyph := ltblank;
    commanderfo.vuin.frame.font.color := ltblank; 
    
    commanderfo.butinput.colorglyph := ltblank;
    commanderfo.butinput.frame.font.color := ltblank; 
    
    commanderfo.automix.colorglyph := ltblank;
    commanderfo.automix.frame.font.color := ltblank; 
    
    commanderfo.linkvol.colorglyph := ltblank;
    commanderfo.linkvol.frame.font.color := ltblank; 
    
    commanderfo.linkvol2.colorglyph := ltblank;
    commanderfo.linkvol2.frame.font.color := ltblank; 
    
    commanderfo.linkvolgen.colorglyph := ltblank;
    commanderfo.linkvolgen.frame.font.color := ltblank; 

    commanderfo.timemix.frame.colorglyph := ltblank;

    commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED;
    commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA;
    
    commanderfo.timemix.frame.font.color := ltblank;
   
    commanderfo.genvolleft.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.genvolleft.scrollbar.face1.template := commanderfo.tfacesliderdark;
   
    commanderfo.genvolright.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.genvolright.scrollbar.face1.template := commanderfo.tfacesliderdark;

    commanderfo.volumeleft1.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.volumeleft1.scrollbar.face1.template := commanderfo.tfacesliderdark;
    commanderfo.volumeleft2.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.volumeleft2.scrollbar.face1.template := commanderfo.tfacesliderdark;
    commanderfo.volumeright1.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.volumeright1.scrollbar.face1.template := commanderfo.tfacesliderdark;
    commanderfo.volumeright2.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.volumeright2.scrollbar.face1.template := commanderfo.tfacesliderdark;

    commanderfo.tslider2.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.tslider2.scrollbar.face1.template := commanderfo.tfacesliderdark;
    commanderfo.tslider3.scrollbar.face.template := commanderfo.tfacesliderdark;
    commanderfo.tslider3.scrollbar.face1.template := commanderfo.tfacesliderdark;

    // file list
    //filelistfo.list_files.fixrows[-1][0].font.color := ltblack;

    filelistfo.tgroupbox1.font.color := ltblank;
    filelistfo.historyfn.frame.button.colorglyph := ltblank;
    filelistfo.songdir.frame.button.colorglyph := ltblank;

    filelistfo.list_files.datacols[0].color := ltblack;
    filelistfo.list_files.datacols[0].font.color := ltblank;
    filelistfo.list_files.datacols[1].color := ltblack;
    filelistfo.list_files.datacols[1].font.color := ltblank;
    filelistfo.list_files.datacols[2].color := ltblack;
    filelistfo.list_files.datacols[2].font.color := ltblank;
    filelistfo.list_files.datacols[3].color := ltblack;
    filelistfo.list_files.datacols[3].font.color := ltblank;
    filelistfo.list_files.datacols[3].colorglyph := ltblank;

    filelistfo.list_files.datacols[3].colorselect := $707070;

    aboutfo.font.color := cl_black;
  end;

  songplayerfo.DrawWaveForm();
  songplayer2fo.DrawWaveForm();

end;

procedure tmainfo.onmenuaudio(const Sender: TObject);
begin
  configfo.Show(True);
end;

procedure tmainfo.onresized(const Sender: TObject);
begin
 
  if  (hasinit = 1) then
  begin
    timerwait.Enabled := False;
    timerwait.Enabled := True;
  end;
  
end;

end.
