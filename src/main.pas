unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I define.inc}

interface

uses
  msetypes, mseglob, mseguiglob, msegraphedits, mseguiintf, mseapplication, msestat, msegui,
  msetimer, msegraphics, msegraphutils, mseclasses, msewidgets, mseforms, msechart, status,
  msedock, msedataedits, mseedit, msestatfile, SysUtils, Classes, math,
  msebitmap, msesys, msemenus, msestream, msegrids, mselistbrowser,
  mseact, mseificomp, mseificompglob, mseifiglob, msestrings;

type
  tmainfo = class(tmainform)
    Timerwait: Ttimer;
    Timeract: Ttimer;
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
    procedure ontimeract(const Sender: TObject);
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
    procedure showspectrum(const Sender: TObject);
    procedure showpan1(const Sender: TObject);
    procedure showpan2(const Sender: TObject);
    procedure showpan4(const Sender: TObject);
    procedure showpan5(const Sender: TObject);
    procedure showpan3(const Sender: TObject);
    procedure onshowspectrum2(const Sender: TObject);
    procedure onshowspectrumrec(const Sender: TObject);
    procedure onmaintab(const Sender: TObject);
    procedure onmaindock(const Sender: TObject);
    procedure onshowwave2(const Sender: TObject);
    procedure onshowwave1(const Sender: TObject);
    procedure onshowwaverec(const Sender: TObject);
    procedure ondockplayers(const Sender: TObject);
    procedure ondockjam(const Sender: TObject);
    procedure dragfloat(const Sender: TObject);
    procedure onexit(const sender: TObject);
    procedure ondockrec(const sender: TObject);
    procedure loadlayout(const sender: TObject);
    procedure savelayout(const sender: TObject);
   procedure onshowrandom(const sender: TObject);
   procedure onrandomlayout(const sender: TObject);
  private
    flayoutlock: int32;
  protected
    procedure beginlayout();
    procedure endlayout();
  public
    procedure updatelayout();
  end;

const
  versiontext = '1.8.2';
  emptyheight = 40;
  drumsfoheight = 236;
  filelistfoheight = 128;
  wavefoheight = 128;
  guitarsfoheight = 64;
  songplayerfoheight = 128;
  spectrum1foheight = 128;
  recorderfoheight = 128;
  commanderfoheight = 128;
  fowidth = 442;
  tabheight = 39;
  scrollwidth = 14;

var
  mainfo: tmainfo;
  stopit: boolean = False;
  channels: cardinal = 2; // stereo output
  allok: boolean = False;
  plugsoundtouch: boolean = False;
  ordir: string;
  hasinit: integer = 0;
  maxheightfo : integer;
  norefresh: boolean = False;

implementation

uses
  config, drums, recorder, songplayer, commander, randomnote,
  filelistform, spectrum1, waveform, dockpanel1,
  aboutform, uos_flat, guitars, main_mfm;
  
procedure tmainfo.ontimeract(const Sender: TObject);
begin
if randomnotefo.visible = false then activate;
end;

procedure tmainfo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;
  rect1: rectty;

begin
 
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
  
  bounds_cxmax := 0;

  if not fileexists(tstatfile1.filename) then
    top := 30;

  if (fs_sbverton in container.frame.state) then
    Width := fowidth + scrollwidth
  else
    Width := fowidth;

  hasinit := 1;

  bounds_cxmax := bounds_cx;
  bounds_cxmin := bounds_cx;
  
  rect1 := application.screenrect(window);
  
  maxheightfo := rect1.cy - 70; 

  if bounds_cy < maxheightfo then
    bounds_cymax := bounds_cy
  else
    bounds_cymax := maxheightfo;
  bounds_cymin := bounds_cy;
  
  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayout();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayout();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayout();
    
  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayout();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayout();  

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
 var  rect1: rectty;

begin

      SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
  [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);
 
  visible := false;
  flayoutlock := 0;
  
  rect1 := application.screenrect(window);
  
  maxheightfo := rect1.cy - 70; 
  // for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;
  tstatfile1.filename := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
  'ini'  + directoryseparator +  'stat.ini';
  
  Timerwait := ttimer.Create(nil);
  Timerwait.interval := 100000;
  Timerwait.Enabled := False;
  Timerwait.options := [to_single];
  Timerwait.ontimer := @ontimerwait;
  
  Timeract := ttimer.Create(nil);
  Timeract.interval := 500000;
  Timeract.Enabled := False;
  Timeract.options := [to_single];
  Timeract.ontimer := @ontimeract;
end;

procedure tmainfo.onabout(const Sender: TObject);
begin
  aboutfo.Caption := 'About StrumPract';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value := c_linefeed + 'StrumPract ' + versiontext + ' for ' + platformtext + c_linefeed +
    'https://github.com/fredvs/strumpract/releases/' + c_linefeed + c_linefeed + 'Compiled with FPC 3.2.0.' +
    c_linefeed + 'http://www.freepascal.org' + c_linefeed + c_linefeed + 'Graphic widget: MSEgui ' + mseguiversiontext +
    '.' + c_linefeed + 'https://github.com/mse-org/mseide-msegui' + c_linefeed + c_linefeed +
    'Audio library: uos 1.8. (United Openlib of Sound)' + c_linefeed + 'https://github.com/fredvs/uos' + c_linefeed +
    c_linefeed + 'Copyright 2019' + c_linefeed + 'Fred van Stappen <fiens@hotmail.com>';
  aboutfo.Show(True);
end;

procedure tmainfo.dodestroy(const Sender: TObject);

begin

   ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
 
filelistfo.tstatfile1.writestat(ordir+  'ini'  + directoryseparator +  'list.ini');
  uos_free();
  Timerwait.Free;
  Timeract.Free;
end;

procedure tmainfo.oncreatedform(const Sender: TObject);
var
  x: integer;
  haswav : boolean = false;

begin
  Caption := 'StrumPract ' + versiontext;
   beginlayout();
  
  visible := true;

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
      filelistfo.bounds_cxmax := 0;
      filelistfo.bounds_cymax := maxheightfo;
    end
    else
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := filelistfoheight;
      filelistfo.Width := fowidth;
      filelistfo.Height := filelistfoheight;
    end;
  end;

  if (wavefo.Visible) then
  begin
    if (wavefo.parentwidget = nil) then
    begin
      wavefo.bounds_cxmax := 0;
      wavefo.bounds_cymax := 0;
    end
    else
    begin
      wavefo.bounds_cxmax := fowidth;
      wavefo.bounds_cymax := wavefoheight;
      wavefo.Width := fowidth;
      wavefo.Height := wavefoheight;
     if haswav = false then height := height + 10;
      haswav := true;
    end;
  end;

  if (wavefo2.Visible) then
  begin
    if (wavefo2.parentwidget = nil) then
    begin
      wavefo2.bounds_cxmax := 0;
      wavefo2.bounds_cymax := 0;
    end
    else
    begin
      if haswav = false then height := height + 10;
      haswav := true;
      wavefo2.bounds_cxmax := fowidth;
      wavefo2.bounds_cymax := wavefoheight;
      wavefo2.Width := fowidth;
      wavefo2.Height := wavefoheight;
    end;
  end;
  
   if (waveforec.Visible) then
  begin
    if (waveforec.parentwidget = nil) then
    begin
      waveforec.bounds_cxmax := 0;
      waveforec.bounds_cymax := 0;
    end
    else
    begin
      if haswav = false then height := height + 10;
      haswav := true;
      waveforec.bounds_cxmax := fowidth;
      waveforec.bounds_cymax := wavefoheight;  
      waveforec.Width := fowidth;
      waveforec.Height := wavefoheight;
    
    end;
  end;

  UOS_GetInfoDevice();
  
  x := 0;

  while x < UOSDeviceCount do
  begin
    if UOSDeviceInfos[x].DefaultDevOut = True then
    begin

      configfo.lsuglat.Caption := 'Audio API ' + UOSDeviceInfos[x].HostAPIName + 
      ': Suggested latency = ' +
        floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8);

    end;
    Inc(x);
  end;
  
   endlayout();
 
    if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
 
 if randomnotefo.visible = true then
 randomnotefo.bringtofront;
 
  randomnotefo.refreshform(sender); 


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
 
    if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;

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

  if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
end;

procedure tmainfo.updatedockev(const Sender: TObject; const awidget: twidget);
begin
  updatelayout();
end;

procedure tmainfo.onfloatall(const Sender: TObject);
var
  
  decorationheight, posi: int32;
  leftdec: integer = 70;
  topdec: integer = 40;
begin
  // basedock.anchors := [an_left,an_top]  ;

  decorationheight := window.decoratedbounds_cy - Height;

  beginlayout();
  
  norefresh := true;

  if drumsfo.Visible then
    drumsfo.dragdock.float();

  if guitarsfo.Visible then
    guitarsfo.dragdock.float();

  if songplayerfo.Visible then
    songplayerfo.dragdock.float();

  if spectrum1fo.Visible then
    spectrum1fo.dragdock.float();

  if spectrum2fo.Visible then
    spectrum2fo.dragdock.float();
    
   if spectrumrecfo.Visible then
    spectrumrecfo.dragdock.float();  

  if songplayer2fo.Visible then
    songplayer2fo.dragdock.float();

  if recorderfo.Visible then
    recorderfo.dragdock.float();

  if filelistfo.Visible then
    filelistfo.dragdock.float();

  if commanderfo.Visible then
    commanderfo.dragdock.float();

  if spectrum2fo.Visible then
    spectrum2fo.dragdock.float();
    
  if spectrumrecfo.Visible then
    spectrumrecfo.dragdock.float();  

  if wavefo.Visible then
    wavefo.dragdock.float();

  if wavefo2.Visible then
    wavefo2.dragdock.float();
    
   if waveforec.Visible then
    waveforec.dragdock.float();  
    
    norefresh := false;
 
  wavefo2.bounds_cxmax := 0;
  wavefo2.bounds_cymax := 0;

  wavefo.bounds_cxmax := 0;
  wavefo.bounds_cymax := 0;
  
  waveforec.bounds_cxmax := 0;
  waveforec.bounds_cymax := 0;

  wavefo2.bounds_cx := 300;
  wavefo2.bounds_cy := 100;

  wavefo.bounds_cx := 300;
  wavefo.bounds_cy := 100;
  
  waveforec.bounds_cx := 300;
  waveforec.bounds_cy := 100;

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 0;

  Height := emptyheight + 20;
  Width := fowidth;

  left := 0;
  top := 0;
  
  endlayout();
   
  if drumsfo.Visible then
    drumsfo.left := leftdec;

  if guitarsfo.Visible then
    guitarsfo.left := drumsfo.left + leftdec;

  if songplayerfo.Visible then
    songplayerfo.left := guitarsfo.left + leftdec;

  if songplayer2fo.Visible then
    songplayer2fo.left := songplayerfo.left + leftdec;

  if recorderfo.Visible then
    recorderfo.left := songplayer2fo.left + leftdec;
    
  if spectrumrecfo.Visible then
    spectrumrecfo.left := recorderfo.left + leftdec;
  
  if filelistfo.Visible then
  begin
    filelistfo.Height := 300;
    filelistfo.left := spectrumrecfo.left + leftdec;
  end;

  if commanderfo.Visible then
    commanderfo.left := filelistfo.left + leftdec;

  if spectrum1fo.Visible then
    spectrum1fo.left := commanderfo.left + leftdec;

  if spectrum2fo.Visible then
    spectrum2fo.left := spectrum1fo.left + leftdec;

  if wavefo.Visible then
    wavefo.left := spectrum2fo.left + leftdec;

  if wavefo2.Visible then
    wavefo2.left := wavefo.left + leftdec;
    
   if waveforec.Visible then
    waveforec.left := wavefo2.left + leftdec;  

  top := 0;

  if drumsfo.Visible then
  begin
    drumsfo.top := 120;
    posi := drumsfo.top + topdec;
    drumsfo.activate;
  end
  else
    posi := top + 120;

  if guitarsfo.Visible then
  begin
    guitarsfo.top := posi;
    posi := guitarsfo.top + topdec;
    guitarsfo.activate;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.top := posi;
    posi := songplayerfo.top + topdec;
    songplayerfo.activate;
  end
  else
    posi := top + topdec;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.top := posi;
    posi := songplayer2fo.top + +topdec;
    songplayer2fo.activate;
  end
  else
    posi := top + topdec;

  if recorderfo.Visible then
  begin
    recorderfo.top := posi;
    posi := recorderfo.top + topdec;
    recorderfo.activate;
  end;
  
  if spectrumrecfo.Visible then
  begin
    spectrumrecfo.top := posi;
    posi := spectrumrecfo.top + topdec;
    spectrumrecfo.activate;
  end
  else
    posi := top + topdec;

  if filelistfo.Visible then
  begin
    filelistfo.top := posi;
    posi := filelistfo.top + topdec;
    filelistfo.activate;
  end
  else
    posi := top + topdec;

  if commanderfo.Visible then
  begin
    commanderfo.top := posi;
    posi := commanderfo.top + +topdec;
    commanderfo.activate;
  end
  else
    posi := top + topdec;

  if spectrum1fo.Visible then
  begin
    spectrum1fo.top := posi;
    posi := spectrum1fo.top + topdec;
    spectrum1fo.activate;
  end
  else
    posi := top + topdec;

  if spectrum2fo.Visible then
  begin
    spectrum2fo.top := posi;
    posi := spectrum2fo.top + topdec;
    spectrum2fo.activate;
  end
  else
    posi := top + topdec;
  
  if wavefo.Visible then
  begin
    wavefo.top := posi;
    posi := wavefo.top + topdec;
    wavefo.activate;
   end
  else
    posi := top + topdec;

  if wavefo2.Visible then
  begin
    wavefo2.top := posi;
    posi := wavefo2.top + topdec;
    wavefo2.activate;
  end;
  
  if waveforec.Visible then
  begin
    waveforec.top := posi;
    waveforec.activate;
  end; 
  
norefresh := false;
  //  activate;
  if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;

  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;
  
     if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;   
  
 end;
 
procedure tmainfo.dragfloat(const Sender: TObject);
begin

with tdockpanel1fo(sender) do
  begin
  if drumsfo.parentwidget = basedock then
      drumsfo.dragdock.float();

    if guitarsfo.parentwidget = basedock then
      guitarsfo.dragdock.float();

    if songplayerfo.parentwidget = basedock then
      songplayerfo.dragdock.float();
       if songplayer2fo.parentwidget = basedock then
      songplayer2fo.dragdock.float();

    if recorderfo.parentwidget = basedock then
      recorderfo.dragdock.float();

    if filelistfo.parentwidget = basedock then
      filelistfo.dragdock.float();

    if commanderfo.parentwidget = basedock then
      commanderfo.dragdock.float();

    if spectrum1fo.parentwidget = basedock then
      spectrum1fo.dragdock.float();

    if spectrum2fo.parentwidget = basedock then
      spectrum2fo.dragdock.float();
      
     if spectrumrecfo.parentwidget = basedock then
      spectrumrecfo.dragdock.float();  

    if wavefo.parentwidget = basedock then
      wavefo.dragdock.float();

    if wavefo2.parentwidget = basedock then
      wavefo2.dragdock.float();
      
        if waveforec.parentwidget = basedock then
      waveforec.dragdock.float();
      end;
   
   end; 

procedure tmainfo.ondockjam(const Sender: TObject);
var
  pt1: pointty;
  decorationheight: integer = 5;
begin
  // basedock.anchors := [an_left,an_top]  ;
 
  beginlayout();
  
  norefresh := true;

  basedock.dragdock.currentsplitdir := sd_horz;
  
   decorationheight := window.decoratedbounds_cy - Height;
  
  commanderfo.automix.value := true;    
  
 

  with dockpanel3fo do
  begin
  //  dragfloat(dockpanel3fo);
    
    Visible := True;

    drumsfo.Visible := True;
    drumsfo.parentwidget := basedock;

    guitarsfo.Visible := True;
    guitarsfo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    if drumsfo.Visible then
    begin
      drumsfo.pos := pt1;
      pt1.y := pt1.y + drumsfo.Height + decorationheight;
    end;

    if guitarsfo.Visible then
    begin
      guitarsfo.pos := pt1;
      pt1.y := pt1.y + guitarsfo.Height + decorationheight;
    end;
    if dockpanel3fo.Timerwaitdp.Enabled then
  dockpanel3fo.Timerwaitdp.restart // to reset
 else dockpanel3fo.Timerwaitdp.Enabled := True;
  end;

  with dockpanel1fo do
  begin

  //  dragfloat(dockpanel1fo);

    Visible := True;
   
    songplayerfo.Visible := True;
    songplayerfo.parentwidget := basedock;

    spectrum1fo.Visible := True;
    spectrum1fo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    if spectrum1fo.Visible then
    begin
      spectrum1fo.pos := pt1;
      pt1.y := pt1.y + spectrum1fo.Height + decorationheight;
    end;

    if songplayerfo.Visible then
    begin
      songplayerfo.pos := pt1;
      pt1.y := pt1.y + songplayerfo.Height + decorationheight;
    end;
      if dockpanel1fo.Timerwaitdp.Enabled then
  dockpanel1fo.Timerwaitdp.restart // to reset
 else dockpanel1fo.Timerwaitdp.Enabled := True;

  end;

  with dockpanel2fo do
  begin
  // dragfloat(dockpanel2fo);

    Visible := True;
    
     waveforec.Visible := false;

    songplayer2fo.Visible := True;
    songplayer2fo.parentwidget := basedock;

    spectrum2fo.Visible := True;
    spectrum2fo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    spectrum2fo.pos := pt1;
    pt1.y := pt1.y + spectrum1fo.Height + decorationheight;

    songplayer2fo.pos := pt1;
    pt1.y := pt1.y + songplayerfo.Height + decorationheight;

   if dockpanel2fo.Timerwaitdp.Enabled then
  dockpanel2fo.Timerwaitdp.restart // to reset
 else dockpanel2fo.Timerwaitdp.Enabled := True;

   end;
   
   
  with dockpanel4fo do
  begin
  
  // dragfloat(dockpanel4fo);

    Visible := True;
     recorderfo.Visible := True;
    recorderfo.parentwidget := basedock;
    
    recorderfo.sentcue1.value := false;
 
    spectrumrecfo.Visible := True;
    spectrumrecfo.parentwidget := basedock;
    
     pt1 := nullpoint;

    recorderfo.pos := pt1;
    pt1.y := pt1.y + recorderfo.Height + decorationheight;

    spectrumrecfo.pos := pt1;
    
      if dockpanel4fo.Timerwaitdp.Enabled then
  dockpanel4fo.Timerwaitdp.restart // to reset
 else dockpanel4fo.Timerwaitdp.Enabled := True;

  
end;

     //{
   
// filelistfo.dragdock.float();
  filelistfo.Visible := True;
//  commanderfo.dragdock.float();
  commanderfo.Visible := True;
  wavefo.Visible := False;
  wavefo2.Visible := False;
 
   filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := filelistfoheight;
      filelistfo.Width := fowidth;
      filelistfo.Height := filelistfoheight;

  filelistfo.parentwidget := basedock;

  commanderfo.parentwidget := basedock;

   pt1 := nullpoint;

  filelistfo.pos := pt1;
  pt1.y := pt1.y + filelistfo.Height + decorationheight;

  commanderfo.pos := pt1;
  pt1.y := pt1.y + commanderfo.Height + decorationheight;

  endlayout();
 
  dockpanel1fo.left := 0;
  dockpanel1fo.top := decorationheight;

  dockpanel3fo.left := 0;
  dockpanel3fo.top := songplayerfo.Height + songplayerfo.Height + 30 + (2 * decorationheight);

  left := dockpanel1fo.Width + 10;
  top:= decorationheight;

  dockpanel2fo.left := left + Width + 8;
  dockpanel2fo.top := dockpanel1fo.top;
  
   dockpanel4fo.left := left ;
  dockpanel4fo.top := songplayerfo.Height + songplayerfo.Height + 30 + (2 * decorationheight);
  
  norefresh := false;
  sleep(1);
 
  
     if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;
 
   if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;

end;

procedure tmainfo.ondockplayers(const Sender: TObject);
var
  pt1: pointty;
  rect1: rectty;
  decorationheight: integer = 5;
  interv : integer;
begin
  // basedock.anchors := [an_left,an_top]  ;
   
    norefresh := true;
    
   dockpanel1fo.visible := false;
   dockpanel2fo.visible := false;
   dockpanel3fo.visible := false;
  spectrum1fo.Visible := true;
  spectrum2fo.Visible := true;
  songplayerfo.Visible := true;
  songplayer2fo.Visible := true;
  wavefo.Visible := false;
  wavefo2.Visible := false;
  drumsfo.Visible := False;
   
  guitarsfo.Visible := False;
  
  waveforec.Visible := false;
  
  commanderfo.Visible := true; 
  
  commanderfo.automix.value := true; 
  
  filelistfo.Visible := true;
  recorderfo.Visible := true;  
   
  dockpanel4fo.visible := false;
  dockpanel5fo.visible := false;
    
  basedock.dragdock.currentsplitdir := sd_horz;
    decorationheight := window.decoratedbounds_cy - Height;
 
  with dockpanel1fo do
  begin

  // dragfloat(dockpanel1fo);

    songplayerfo.parentwidget := basedock;

    spectrum1fo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

     spectrum1fo.pos := pt1;
      pt1.y := pt1.y + spectrum1fo.Height + decorationheight;
   
      songplayerfo.pos := pt1;
      pt1.y := pt1.y + songplayerfo.Height + decorationheight;
    // dockpanel1fo.Timerwaitdp.Enabled := False;
   // dockpanel1fo.Timerwaitdp.Enabled := True;
  end;

  with dockpanel2fo do
  begin
  // dragfloat(dockpanel2fo);
  
    songplayer2fo.parentwidget := basedock;

    spectrum2fo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    spectrum2fo.pos := pt1;
    pt1.y := pt1.y + spectrum1fo.Height + decorationheight;

    songplayer2fo.pos := pt1;
    pt1.y := pt1.y + songplayerfo.Height + decorationheight;

  //  dockpanel2fo.Timerwaitdp.Enabled := False;
  //  dockpanel2fo.Timerwaitdp.Enabled := True;
  end;
     beginlayout();
  filelistfo.dragdock.float();
  commanderfo.dragdock.float();
  wavefo.dragdock.float();
  wavefo2.dragdock.float();
  recorderfo.dragdock.float();
  
  recorderfo.sentcue1.value := false;

    basedock.dragdock.currentsplitdir := sd_horz;
  commanderfo.parentwidget := basedock;
  
  left := 0;
  top := decorationheight;
  
  rect1 := application.screenrect(window);
  
  interv := (rect1.cx- ( 3 * foWidth)) div 2 ;

  dockpanel1fo.left := left;
  dockpanel1fo.top := commanderfoheight + 74;

  filelistfo.left := commanderfo.Width + interv;
  filelistfo.top := decorationheight;
  filelistfo.Height := (3 * commanderfoHeight) + (2*decorationheight) +4;
  
  recorderfo.left := filelistfo.left + filelistfo.Width + interv;
  recorderfo.top := decorationheight;
  
   dockpanel2fo.top := dockpanel1fo.top;
   
   dockpanel2fo.left := filelistfo.left + filelistfo.Width + interv;
   
    //endlayout();
    
      interv := (rect1.cy- 194 - ( 3 *songplayerfoHeight)) div 2;
  
  wavefo2.bounds_cxmax := 0;
  wavefo2.bounds_cymax := 0;

  wavefo.bounds_cxmax := 0;
  wavefo.bounds_cymax := 0;
  
  wavefo.Width := recorderfo.left + recorderfo.Width - 2;
  wavefo2.Width := recorderfo.left + recorderfo.Width - 2;
  wavefo.Height := interv;
  wavefo2.Height := interv;
 
  wavefo.top :=  (3 * songplayerfoHeight) + 126;
 
  wavefo2.top := (3 * songplayerfoHeight) + 158 + interv;
  
  wavefo.left := 0;
  wavefo2.left := 0;
  
   //  visible:= true;
   
   spectrumrecfo.Visible := false;  
           
    dockpanel1fo.visible := true;
    dockpanel2fo.visible := true;
   wavefo.visible := true;
   wavefo2.visible := true;
   
       
   endlayout();  
   
  application.processmessages;
   
    rect1 := application.screenrect(window);
      interv := (rect1.cy- 194 - ( 3 *songplayerfoHeight)) div 2;
  
   wavefo2.bounds_cxmax := 0;
  wavefo2.bounds_cymax := 0;

  wavefo.bounds_cxmax := 0;
  wavefo.bounds_cymax := 0;
  
  wavefo.Width := recorderfo.left + recorderfo.Width - 2;
  wavefo2.Width := recorderfo.left + recorderfo.Width - 2;
  wavefo.Height := interv;
  wavefo2.Height := interv;
  
  
  wavefo.top :=  (3 * songplayerfoHeight) + 126;
 
  wavefo2.top := (3 * songplayerfoHeight) + 158 + interv;
  
  wavefo.left := 0;
  wavefo2.left := 0;
  
   visible := true;
   
      if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;
    
    norefresh := false; 

 
end;

procedure tmainfo.ondockall(const Sender: TObject);
var
  pt1: pointty;
  decorationheight: integer = 5;
  rect1: rectty;
begin
  // basedock.anchors := [an_left,an_top]  ;
  decorationheight := window.decoratedbounds_cy - Height;
  norefresh := true;
  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 1024;

  wavefo.bounds_cxmax := fowidth;
  wavefo.bounds_cymax := 100;

  wavefo2.bounds_cxmax := fowidth;
  wavefo2.bounds_cymax := 100;
  
   waveforec.bounds_cxmax := fowidth;
  waveforec.bounds_cymax := 100;

  //sizeecbefdock.cy := 500;
  //size := sizebefdock;
  
  rect1 := application.screenrect(window);

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
  if spectrum1fo.Visible then
    spectrum1fo.parentwidget := basedock;

  if spectrum2fo.Visible then
    spectrum2fo.parentwidget := basedock;
    
  if spectrumrecfo.Visible then
    spectrumrecfo.parentwidget := basedock;   

  if wavefo.Visible then
    wavefo.parentwidget := basedock;

  if wavefo2.Visible then
    wavefo2.parentwidget := basedock;
    
   if waveforec.Visible then
    waveforec.parentwidget := basedock;  

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

  if spectrum1fo.Visible then
  begin
    spectrum1fo.pos := pt1;
    pt1.y := pt1.y + spectrum1fo.Height + decorationheight;
  end;

  if spectrum2fo.Visible then
  begin
    spectrum2fo.pos := pt1;
    pt1.y := pt1.y + spectrum2fo.Height + decorationheight;
  end;
  
   if spectrumrecfo.Visible then
  begin
    spectrumrecfo.pos := pt1;
    pt1.y := pt1.y + spectrumrecfo.Height + decorationheight;
  end;

  if wavefo.Visible then
  begin
    wavefo.pos := pt1;
    pt1.y := pt1.y + wavefo.Height + decorationheight;
  end;

  if wavefo2.Visible then
  begin
    wavefo2.pos := pt1;
    pt1.y := pt1.y + wavefo2.Height + decorationheight;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.pos := pt1;
    pt1.y := pt1.y + recorderfo.Height + decorationheight;
  end;
  
   if waveforec.Visible then
  begin
    waveforec.pos := pt1;
    pt1.y := pt1.y + waveforec.Height + decorationheight;
  end;

  if guitarsfo.Visible then
    guitarsfo.pos := pt1;
  //}
   
  endlayout();
  
   
  if timerwait.Enabled then
  timerwait.restart // to reset
else timerwait.Enabled := True;
 
    norefresh := false;
     
    left :=  (rect1.cx- Width) div 2 ; 
  
  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
   dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

   if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;
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

  wavefo.bounds_cxmax := fowidth;
  wavefo.bounds_cymax := wavefoheight;
  
   waveforec.bounds_cxmax := fowidth;
  waveforec.bounds_cymax := wavefoheight;

  wavefo2.bounds_cxmax := fowidth;
  wavefo2.bounds_cymax := wavefoheight;

  wavefo.bounds_cy := wavefoheight;
  wavefo2.bounds_cy := wavefoheight;
   waveforec.bounds_cy := wavefoheight;

  beginlayout();
  ondockall(Sender); // otherwise the close button are hidden
  basedock.dragdock.currentsplitdir := sd_tabed;
  sleep(1);
  endlayout();
  
   dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
   dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

end;

procedure tmainfo.showall(const Sender: TObject);
begin
 norefresh := true;
  beginlayout();
  drumsfo.Show();
  filelistfo.Show();
  songplayerfo.Show();
  songplayer2fo.Show();
  commanderfo.Show();
  guitarsfo.Show();
  recorderfo.Show();
  spectrum1fo.Show();
  spectrum2fo.Show();
   spectrumrecfo.Show();
  wavefo.Show();
  wavefo2.Show();
   waveforec.Show();
norefresh := false;
   endlayout();
  
   if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
 
   if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;
 
 end;

procedure tmainfo.hideall(const Sender: TObject);
begin
  //beginlayout();
  norefresh := true;
  drumsfo.Visible := False;
  filelistfo.Visible := False;
  songplayerfo.Visible := False;
  songplayer2fo.Visible := False;
  commanderfo.Visible := False;
  guitarsfo.Visible := False;
  recorderfo.Visible := False;
  spectrum1fo.Visible := False;
  spectrum2fo.Visible := False;
  spectrumrecfo.Visible := False;
  wavefo.Visible := False;
  wavefo2.Visible := False;
   waveforec.Visible := False;
  norefresh := false;
  // endlayout();
   if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
 
  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
   dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

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
    wavefo.trackbar1.face.template := tfaceplayer;
    wavefo2.trackbar1.face.template := tfaceplayer;
    waveforec.trackbar1.face.template := recorderfo.tfacerecorder;
 
  if typecolor.Value = 0 then
  begin
    randomnotefo.color := $DED9D1;
    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.nodrums.frame.font.color := cl_black;
    randomnotefo.withsharp.frame.font.color := cl_black;
    randomnotefo.maxnote.frame.font.color := cl_black;
    randomnotefo.bpm.frame.font.color := cl_black;
    
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

    songplayerfo.playreverse.frame.font.color := ltblack;
    songplayer2fo.playreverse.frame.font.color := ltblack;

    songplayerfo.setmono.frame.font.color := ltblack;
    songplayer2fo.setmono.frame.font.color := ltblack;

    songplayerfo.tstringdisp2.font.color := ltblack;
    songplayer2fo.tstringdisp2.font.color := ltblack;

    songplayerfo.button1.font.color := ltblack;
    songplayer2fo.button1.font.color := ltblack;

    songplayerfo.button2.font.color := ltblack;
    songplayer2fo.button2.font.color := ltblack;

    songplayerfo.tstringdisp1.color := ltblack;
    songplayer2fo.tstringdisp1.color := ltblack;

    songplayerfo.cbloop.colorglyph := ltblack;
    songplayer2fo.cbloop.colorglyph := ltblack;
    songplayerfo.cbtempo.colorglyph := ltblack;
    songplayer2fo.cbtempo.colorglyph := ltblack;
    songplayerfo.waveformcheck.colorglyph := ltblack;
    songplayer2fo.waveformcheck.colorglyph := ltblack;

    songplayerfo.playreverse.frame.font.color := ltblack;
    songplayer2fo.playreverse.frame.font.color := ltblack;

    songplayerfo.setmono.frame.font.color := ltblack;
    songplayer2fo.setmono.frame.font.color := ltblack;

    songplayerfo.setmono.colorglyph := ltblack;
    songplayer2fo.setmono.colorglyph := ltblack;

    songplayerfo.playreverse.colorglyph := ltblack;
    songplayer2fo.playreverse.colorglyph := ltblack;

    songplayerfo.edvolleft.frame.colorglyph := ltblack;
    songplayer2fo.edvolleft.frame.colorglyph := ltblack;
   
    recorderfo.edvol.frame.colorglyph := ltblack;
    recorderfo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.edvolright.frame.colorglyph := ltblack;
    songplayer2fo.edvolright.frame.colorglyph := ltblack;
    songplayerfo.edtempo.frame.colorglyph := ltblack;
    songplayer2fo.edtempo.frame.colorglyph := ltblack;
    
    recorderfo.edvol.frame.colorglyph := ltblack;
    recorderfo.edtempo.frame.colorglyph := ltblack;
    
    waveforec.trackbar1.color := $F9FFC2;
    
     waveforec.sliderimage.bitmap.canvas.color := $F9FFC2;


    songplayerfo.songdir.frame.button.colorglyph := ltblack;
    songplayer2fo.songdir.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.frame.button.colorglyph := ltblack;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblack;
    
    songplayerfo.historyfn.dropdown.colorclient := ltblank;
    songplayer2fo.historyfn.dropdown.colorclient := ltblank;

    songplayerfo.historyfn.font.color := ltblack;
    songplayer2fo.historyfn.font.color := ltblack;
    songplayerfo.edvolleft.font.color := ltblack;
    songplayer2fo.edvolleft.font.color := ltblack;
    
    recorderfo.edvol.font.color := ltblack;
    recorderfo.edtempo.font.color := ltblack;

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

   {
    wavefo.waveon.frame.font.color := ltblack;
    wavefo.waveon.color := $F9FFC2;
    wavefo2.waveon.frame.font.color := ltblack;
    wavefo2.waveon.color := $F9FFC2;

    wavefo.waveon.colorglyph := ltblack;
    wavefo2.waveon.colorglyph := ltblack;
}

    tfaceplayerlight.template.fade_color.items[0] := $FDFFEB;
    tfaceplayerlight.template.fade_color.items[1] := $E3E8B0;

    tfaceplayerrev.template.fade_color.items[0] := $C4C999;
    tfaceplayerrev.template.fade_color.items[1] := $F3FABE;

    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    drumsfo.multbpm.font.color := ltblack;
    drumsfo.divbpm.font.color := ltblack;

    drumsfo.edittempo.frame.colorglyph := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;

    drumsfo.tfacedrums.template.fade_color.items[0] := $9AAD97;
    drumsfo.tfacedrums.template.fade_color.items[1] := $D6F0D1;
    drumsfo.ltempo.font.color := ltblack;
    drumsfo.novoice.frame.font.color := ltblack;
    drumsfo.langcount.frame.font.color := ltblack;
    drumsfo.langcount.font.color := ltblack;
    drumsfo.langcount.dropdown.colorclient := ltblank;
    
    drumsfo.langcount.frame.button.colorglyph := ltblack;

   
     
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
    recorderfo.sentcue1.colorglyph := ltblack;
     
    recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.songdir.frame.button.colorglyph := ltblack;
    recorderfo.historyfn.frame.button.colorglyph := ltblack;
    
    recorderfo.historyfn.dropdown.colorclient := ltblank;
 
    recorderfo.cbloop.frame.font.color := ltblack;
    recorderfo.cbtempo.frame.font.color := ltblack;
    recorderfo.bsavetofile.frame.font.color := ltblack;
    recorderfo.sentcue1.frame.font.color := ltblack;
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
    
    commanderfo.guimix.colorglyph := ltblack;
    commanderfo.guimix.frame.font.color := ltblack;

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
    filelistfo.historyfn.dropdown.colorclient := ltblank;
  
    
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

    commanderfo.vuleft.bar_face.fade_color.items[0] := $CEB2D6;
    commanderfo.vuleft2.bar_face.fade_color.items[0] := $CEB2D6;
    commanderfo.vuright.bar_face.fade_color.items[0] := $CEB2D6;
    commanderfo.vuright2.bar_face.fade_color.items[0] := $CEB2D6;
    songplayerfo.vuleft.bar_face.fade_color.items[0] := $CEB2D6;
    songplayer2fo.vuleft.bar_face.fade_color.items[0] := $CEB2D6;
    songplayerfo.vuright.bar_face.fade_color.items[0] := $CEB2D6;
    songplayer2fo.vuright.bar_face.fade_color.items[0] := $CEB2D6;

    with spectrum1fo do
    begin
      tchartleft.colorchart := $D2D8A5;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color := $C69EFF;
      labelleft.font.color := ltblack;

      tchartright.colorchart := $D2D8A5;
      tchartright.traces[0].chartkind := tck_bar;
      tchartright.traces[0].color := $C69EFF;
      labelright.font.color := ltblack;

      fond.color := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := $D2D8A5;
    end;

    with spectrum2fo do
    begin
      tchartleft.colorchart := $D2D8A5;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color := $C69EFF;
      labelleft.font.color := ltblack;

      tchartright.colorchart := $D2D8A5;
      tchartright.traces[0].chartkind := tck_bar;
      tchartright.traces[0].color := $C69EFF;
      labelright.font.color := ltblack;

      fond.color := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := $D2D8A5;
    end;
    
     with spectrumrecfo do
    begin
      tchartleft.colorchart := $EDC0C0;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color := $C69EFF;
      labelleft.font.color := ltblack;

      tchartright.colorchart := $EDC0C0;
      tchartright.traces[0].chartkind := tck_bar;
      tchartright.traces[0].color := $C69EFF;
      labelright.font.color := ltblack;
      fond.color := $EDC0C0;
      groupbox1.color := $EDC0C0;
      groupbox2.color := $EDC0C0;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := $EDC0C0;
    end;

    songplayerfo.btnresume.imagenrdisabled := -2;
    songplayer2fo.btnresume.imagenrdisabled := -2;
    songplayerfo.btncue.imagenrdisabled := -2;
    songplayer2fo.btncue.imagenrdisabled := -2;
    songplayerfo.btnstart.imagenrdisabled := -2;
    songplayer2fo.btnstart.imagenrdisabled := -2;
    songplayerfo.btnpause.imagenrdisabled := -2;
    songplayer2fo.btnpause.imagenrdisabled := -2;
    songplayerfo.btnstop.imagenrdisabled := -2;
    songplayer2fo.btnstop.imagenrdisabled := -2;

    commanderfo.btnresume.imagenrdisabled := -2;
    commanderfo.btnresume2.imagenrdisabled := -2;
    commanderfo.btncue.imagenrdisabled := -2;
    commanderfo.btncue2.imagenrdisabled := -2;
    commanderfo.btnstart.imagenrdisabled := -2;
    commanderfo.btnstart2.imagenrdisabled := -2;
    commanderfo.btnpause.imagenrdisabled := -2;
    commanderfo.btnpause2.imagenrdisabled := -2;
    commanderfo.btnstop.imagenrdisabled := -2;
    commanderfo.btnstop2.imagenrdisabled := -2;
    commanderfo.loop_start.imagenrdisabled := -2;
    commanderfo.loop_stop.imagenrdisabled := -2;
    commanderfo.loop_resume.imagenrdisabled := -2;

    recorderfo.btnresume.imagenrdisabled := -2;
    recorderfo.tbutton2.imagenrdisabled := -2;
    recorderfo.btnstart.imagenrdisabled := -2;
    recorderfo.btnpause.imagenrdisabled := -2;
    recorderfo.btnstop.imagenrdisabled := -2;

    drumsfo.loop_resume.imagenrdisabled := -2;
    drumsfo.loop_start.imagenrdisabled := -2;
    drumsfo.loop_stop.imagenrdisabled := -2;

  end;

  if typecolor.Value = 1 then
  begin
   randomnotefo.color := cl_ltgray;
   randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.nodrums.frame.font.color := cl_black;
    randomnotefo.withsharp.frame.font.color := cl_black;
    randomnotefo.maxnote.frame.font.color := cl_black;
    randomnotefo.bpm.frame.font.color := cl_black;
    
    
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

    songplayerfo.playreverse.frame.font.color := ltblack;
    songplayer2fo.playreverse.frame.font.color := ltblack;

    songplayerfo.setmono.frame.font.color := ltblack;
    songplayer2fo.setmono.frame.font.color := ltblack;

    songplayerfo.tstringdisp2.font.color := ltblack;
    songplayer2fo.tstringdisp2.font.color := ltblack;

    songplayerfo.button1.font.color := ltblack;
    songplayer2fo.button1.font.color := ltblack;

    songplayerfo.button2.font.color := ltblack;
    songplayer2fo.button2.font.color := ltblack;

    songplayerfo.cbloop.colorglyph := ltblack;
    songplayer2fo.cbloop.colorglyph := ltblack;
    songplayerfo.cbtempo.colorglyph := ltblack;
    songplayer2fo.cbtempo.colorglyph := ltblack;
    songplayerfo.waveformcheck.colorglyph := ltblack;
    songplayer2fo.waveformcheck.colorglyph := ltblack;

    songplayerfo.playreverse.frame.font.color := ltblack;
    songplayer2fo.playreverse.frame.font.color := ltblack;

    songplayerfo.setmono.frame.font.color := ltblack;
    songplayer2fo.setmono.frame.font.color := ltblack;

    songplayerfo.setmono.colorglyph := ltblack;
    songplayer2fo.setmono.colorglyph := ltblack;

    songplayerfo.playreverse.colorglyph := ltblack;
    songplayer2fo.playreverse.colorglyph := ltblack;

    songplayerfo.edvolleft.frame.colorglyph := ltblack;
    songplayer2fo.edvolleft.frame.colorglyph := ltblack;
    
     recorderfo.edvol.frame.colorglyph := ltblack;
    recorderfo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.edvolright.frame.colorglyph := ltblack;
    songplayer2fo.edvolright.frame.colorglyph := ltblack;
    songplayerfo.edtempo.frame.colorglyph := ltblack;
    songplayer2fo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.songdir.frame.button.colorglyph := ltblack;
    songplayer2fo.songdir.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.frame.button.colorglyph := ltblack;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblack;
    
    songplayerfo.historyfn.dropdown.colorclient := ltblank;
    songplayer2fo.historyfn.dropdown.colorclient := ltblank;

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
{
    wavefo.waveon.frame.font.color := ltblack;
    wavefo.waveon.color := $EDEDED;
    wavefo2.waveon.frame.font.color := ltblack;
    wavefo2.waveon.color := $EDEDED;

    wavefo.waveon.colorglyph := ltblack;
    wavefo2.waveon.colorglyph := ltblack;
}
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
    drumsfo.langcount.frame.font.color := ltblack;
    drumsfo.langcount.font.color := ltblack;
     drumsfo.langcount.frame.button.colorglyph := ltblack;
     drumsfo.langcount.dropdown.colorclient := ltblank;
       
    drumsfo.noand.frame.font.color := ltblack;
    drumsfo.nodrums.frame.font.color := ltblack;
    drumsfo.noanim.frame.font.color := ltblack;
    drumsfo.tlabel21.font.color := ltblack;
    drumsfo.tlabel22.font.color := ltblack;
    drumsfo.tlabel25.font.color := ltblack;
    drumsfo.tlabel23.font.color := ltblack;

    drumsfo.tstringdisp2.font.color := ltblack;

    drumsfo.multbpm.font.color := ltblack;
    drumsfo.divbpm.font.color := ltblack;

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
    recorderfo.sentcue1.frame.font.color := ltblack;
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
     recorderfo.sentcue1.colorglyph := ltblack;
     recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.songdir.frame.button.colorglyph := ltblack;
    recorderfo.historyfn.frame.button.colorglyph := ltblack;
    
    recorderfo.historyfn.dropdown.colorclient := ltblank;

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
    
    
     commanderfo.guimix.colorglyph := ltblack;
    commanderfo.guimix.frame.font.color := ltblack;
   
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

    commanderfo.vuleft.bar_face.fade_color.items[0] := $EDEDED;
    commanderfo.vuleft2.bar_face.fade_color.items[0] := $EDEDED;
    commanderfo.vuright.bar_face.fade_color.items[0] := $EDEDED;
    commanderfo.vuright2.bar_face.fade_color.items[0] := $EDEDED;
    songplayerfo.vuleft.bar_face.fade_color.items[0] := $EDEDED;
    songplayer2fo.vuleft.bar_face.fade_color.items[0] := $EDEDED;
    songplayerfo.vuright.bar_face.fade_color.items[0] := $EDEDED;
    songplayer2fo.vuright.bar_face.fade_color.items[0] := $EDEDED;

    filelistfo.list_files.font.color := ltblack;
    filelistfo.tgroupbox1.font.color := ltblack;

    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.songdir.frame.button.colorglyph := ltblack;
    
    filelistfo.historyfn.dropdown.colorclient := ltblank;
   
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

    songplayerfo.btnresume.imagenrdisabled := -2;
    songplayer2fo.btnresume.imagenrdisabled := -2;
    songplayerfo.btncue.imagenrdisabled := -2;
    songplayer2fo.btncue.imagenrdisabled := -2;
    songplayerfo.btnstart.imagenrdisabled := -2;
    songplayer2fo.btnstart.imagenrdisabled := -2;
    songplayerfo.btnpause.imagenrdisabled := -2;
    songplayer2fo.btnpause.imagenrdisabled := -2;
    songplayerfo.btnstop.imagenrdisabled := -2;
    songplayer2fo.btnstop.imagenrdisabled := -2;

    commanderfo.btnresume.imagenrdisabled := -2;
    commanderfo.btnresume2.imagenrdisabled := -2;
    commanderfo.btncue.imagenrdisabled := -2;
    commanderfo.btncue2.imagenrdisabled := -2;
    commanderfo.btnstart.imagenrdisabled := -2;
    commanderfo.btnstart2.imagenrdisabled := -2;
    commanderfo.btnpause.imagenrdisabled := -2;
    commanderfo.btnpause2.imagenrdisabled := -2;
    commanderfo.btnstop.imagenrdisabled := -2;
    commanderfo.btnstop2.imagenrdisabled := -2;
    commanderfo.loop_start.imagenrdisabled := -2;
    commanderfo.loop_stop.imagenrdisabled := -2;
    commanderfo.loop_resume.imagenrdisabled := -2;

    recorderfo.btnresume.imagenrdisabled := -2;
    recorderfo.tbutton2.imagenrdisabled := -2;
    recorderfo.btnstart.imagenrdisabled := -2;
    recorderfo.btnpause.imagenrdisabled := -2;
    recorderfo.btnstop.imagenrdisabled := -2;

    drumsfo.loop_resume.imagenrdisabled := -2;
    drumsfo.loop_start.imagenrdisabled := -2;
    drumsfo.loop_stop.imagenrdisabled := -2;

    commanderfo.vuleft.bar_face.fade_color.items[0] := $6A6A6A;
    commanderfo.vuleft2.bar_face.fade_color.items[0] := $6A6A6A;
    commanderfo.vuright.bar_face.fade_color.items[0] := $6A6A6A;
    commanderfo.vuright2.bar_face.fade_color.items[0] := $6A6A6A;
    songplayerfo.vuleft.bar_face.fade_color.items[0] := $6A6A6A;
    songplayer2fo.vuleft.bar_face.fade_color.items[0] := $6A6A6A;
    songplayerfo.vuright.bar_face.fade_color.items[0] := $6A6A6A;
    songplayer2fo.vuright.bar_face.fade_color.items[0] := $6A6A6A;

    with spectrum1fo do
    begin

      tchartleft.colorchart := cl_background;
      tchartleft.traces[0].color := $9A9A9A;
      labelleft.font.color := ltblack;

      tchartright.colorchart := cl_background;
      tchartright.traces[0].color := $9A9A9A;
      labelright.font.color := ltblack;

      fond.color := cl_default;

      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := cl_default;
    end;

    with spectrum2fo do
    begin
      tchartleft.colorchart := cl_background;
      tchartleft.traces[0].color := $9A9A9A;
      labelleft.font.color := ltblack;

      tchartright.colorchart := cl_background;
      tchartright.traces[0].color := $9A9A9A;
      labelright.font.color := ltblack;
      fond.color := cl_default;
      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := cl_default;
    end;
    
    
    with spectrumrecfo do
    begin
      tchartleft.colorchart := cl_background;
      tchartleft.traces[0].color := $9A9A9A;
      labelleft.font.color := ltblack;

      tchartright.colorchart := cl_background;
      tchartright.traces[0].color := $9A9A9A;
      labelright.font.color := ltblack;
      fond.color := cl_default;
      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.colorglyph := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := cl_default;
    end;

  end;

  if typecolor.Value = 2 then
  begin
    randomnotefo.color := cl_black;
    randomnotefo.withrandom.frame.font.color := cl_white;
    randomnotefo.nodrums.frame.font.color := cl_white;
    randomnotefo.withsharp.frame.font.color := cl_white;
    randomnotefo.maxnote.frame.font.color := cl_white;
    randomnotefo.bpm.frame.font.color := cl_white;
    
    

    with spectrum1fo do
    begin
      // labelleft.color := $3A3A3A;
      // labelright.color := $3A3A3A;

      tchartleft.colorchart := $3A3A3A;
      tchartleft.traces[0].color := $7A7A7A;
      labelleft.font.color := ltblank;

      tchartright.colorchart := $3A3A3A;
      tchartright.traces[0].color := $7A7A7A;
      labelright.font.color := ltblank;

      fond.color := $3A3A3A;
      groupbox1.color := $3A3A3A;

      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;

      groupbox2.color := $3A3A3A;
      spect1.colorglyph := ltblank;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color := $3A3A3A;
    end;

    with spectrum2fo do
    begin
      tchartleft.colorchart := $3A3A3A;
      tchartleft.traces[0].color := $7A7A7A;
      labelleft.font.color := ltblank;
      //  labelleft.color := $3A3A3A;
      //   labelright.color := $3A3A3A;
      tchartright.colorchart := $3A3A3A;
      tchartright.traces[0].color := $7A7A7A;
      labelright.font.color := ltblank;

      fond.color := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color := $3A3A3A;
      groupbox2.color := $3A3A3A;
      spect1.colorglyph := ltblank;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color := $3A3A3A;
    end;
    
    
    with spectrumrecfo do
    begin
      tchartleft.colorchart := $3A3A3A;
      tchartleft.traces[0].color := $7A7A7A;
      labelleft.font.color := ltblank;
      //  labelleft.color := $3A3A3A;
      //   labelright.color := $3A3A3A;
      tchartright.colorchart := $3A3A3A;
      tchartright.traces[0].color := $7A7A7A;
      labelright.font.color := ltblank;

      fond.color := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color := $3A3A3A;
      groupbox2.color := $3A3A3A;
      spect1.colorglyph := ltblank;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color := $3A3A3A;
    end;

    commanderfo.vuleft.bar_face.fade_color.items[0] := $aAaAaA;
    commanderfo.vuleft2.bar_face.fade_color.items[0] := $aAaAaA;
    commanderfo.vuright.bar_face.fade_color.items[0] := $aAaAaA;
    commanderfo.vuright2.bar_face.fade_color.items[0] := $aAaAaA;
    songplayerfo.vuleft.bar_face.fade_color.items[0] := $aAaAaA;
    songplayer2fo.vuleft.bar_face.fade_color.items[0] := $aAaAaA;
    songplayerfo.vuright.bar_face.fade_color.items[0] := $aAaAaA;
    songplayer2fo.vuright.bar_face.fade_color.items[0] := $aAaAaA;

    tfacebutgray.template.fade_color.items[0] := $888888;
    tfacebutgray.template.fade_color.items[1] := $2A2A2A;

    tfacebutltgray.template.fade_color.items[0] := $5A5A5A;
    tfacebutltgray.template.fade_color.items[1] := $2A2A2A;

    // tfacegreen.template.fade_color.items[0] := $5A5A5A;

    tfacegreen.template.fade_color.items[0] := $0F4700;
    tfacegreen.template.fade_color.items[1] := $2A2A2A;

    //   tfacegreen.template.fade_color.items[0] := $C2FF9E;
    //  tfacegreen.template.fade_color.items[1] := $6EB545;


    //  tfaceorange.template.fade_color.items[0] := $BABABA;
    //  tfaceorange.template.fade_color.items[1] := $3E3E3E;

    tfaceorange.template.fade_color.items[0] := $D97E00;
    tfaceorange.template.fade_color.items[1] := $6E4000;

    //tfacered.template.fade_color.items[0] := $BABABA ;
    //tfacered.template.fade_color.items[1] := $5A5A5A ;

    tfaceplayer.template.fade_color.items[0] := $5A5A5A;
    tfaceplayer.template.fade_color.items[1] := $2A2A2A;

    tfaceplayerbut.template.fade_color.items[0] := $5A5A5A;
    tfaceplayerbut.template.fade_color.items[1] := $2A2A2A;

    tfaceplayerlight.template.fade_color.items[0] := $5A5A5A;
    tfaceplayerlight.template.fade_color.items[1] := $2A2A2A;

    // players
    songplayerfo.btnresume.imagenrdisabled := -1;
    songplayer2fo.btnresume.imagenrdisabled := -1;
    songplayerfo.btncue.imagenrdisabled := -1;
    songplayer2fo.btncue.imagenrdisabled := -1;
    songplayerfo.btnstart.imagenrdisabled := -1;
    songplayer2fo.btnstart.imagenrdisabled := -1;
    songplayerfo.btnpause.imagenrdisabled := -1;
    songplayer2fo.btnpause.imagenrdisabled := -1;
    songplayerfo.btnstop.imagenrdisabled := -1;
    songplayer2fo.btnstop.imagenrdisabled := -1;

    recorderfo.btnresume.imagenrdisabled := -1;
    recorderfo.tbutton2.imagenrdisabled := -1;
    recorderfo.btnstart.imagenrdisabled := -1;
    recorderfo.btnpause.imagenrdisabled := -1;
    recorderfo.btnstop.imagenrdisabled := -1;

    drumsfo.loop_resume.imagenrdisabled := -1;
    drumsfo.loop_start.imagenrdisabled := -1;
    drumsfo.loop_stop.imagenrdisabled := -1;

    commanderfo.btnresume.imagenrdisabled := -1;
    commanderfo.btnresume2.imagenrdisabled := -1;
    commanderfo.btncue.imagenrdisabled := -1;
    commanderfo.btncue2.imagenrdisabled := -1;
    commanderfo.btnstart.imagenrdisabled := -1;
    commanderfo.btnstart2.imagenrdisabled := -1;
    commanderfo.btnpause.imagenrdisabled := -1;
    commanderfo.btnpause2.imagenrdisabled := -1;
    commanderfo.btnstop.imagenrdisabled := -1;
    commanderfo.btnstop2.imagenrdisabled := -1;
    commanderfo.loop_start.imagenrdisabled := -1;
    commanderfo.loop_stop.imagenrdisabled := -1;
    commanderfo.loop_resume.imagenrdisabled := -1;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $5A5A5A;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $2A2A2A;

    songplayerfo.font.color := ltblank;
    songplayer2fo.font.color := ltblank;

    drumsfo.edittempo.frame.colorglyph := ltblank;
    drumsfo.volumedrums.frame.colorglyph := ltblank;
     drumsfo.langcount.frame.button.colorglyph := ltblank;
     
     drumsfo.langcount.dropdown.colorclient := ltblack;
    
   
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

    songplayerfo.playreverse.frame.font.color := ltblank;
    songplayer2fo.playreverse.frame.font.color := ltblank;

    songplayerfo.setmono.frame.font.color := ltblank;
    songplayer2fo.setmono.frame.font.color := ltblank;

    songplayerfo.setmono.colorglyph := ltblank;
    songplayer2fo.setmono.colorglyph := ltblank;

    songplayerfo.playreverse.colorglyph := ltblank;
    songplayer2fo.playreverse.colorglyph := ltblank;

    songplayerfo.edvolleft.frame.colorglyph := ltblank;
    songplayer2fo.edvolleft.frame.colorglyph := ltblank;
    
      recorderfo.edvol.frame.colorglyph := ltblank;
    recorderfo.edtempo.frame.colorglyph := ltblank;


    songplayerfo.edvolright.frame.colorglyph := ltblank;
    songplayer2fo.edvolright.frame.colorglyph := ltblank;
    songplayerfo.edtempo.frame.colorglyph := ltblank;
    songplayer2fo.edtempo.frame.colorglyph := ltblank;

    songplayerfo.historyfn.font.color := ltblank;
    songplayer2fo.historyfn.font.color := ltblank;
    songplayerfo.edvolleft.font.color := ltblank;
    songplayer2fo.edvolleft.font.color := ltblank;
    
    songplayerfo.historyfn.dropdown.colorclient := ltblack;
    songplayer2fo.historyfn.dropdown.colorclient := ltblack;

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
    
    songplayerfo.historyfn.dropdown.colorclient := ltblack;
    songplayer2fo.historyfn.dropdown.colorclient := ltblack;


    songplayerfo.cbloop.frame.font.color := ltblank;
    songplayer2fo.cbloop.frame.font.color := ltblank;

    songplayerfo.cbtempo.frame.font.color := ltblank;
    songplayer2fo.cbtempo.frame.font.color := ltblank;

    songplayerfo.waveformcheck.frame.font.color := ltblank;
    songplayer2fo.waveformcheck.frame.font.color := ltblank;

    songplayerfo.playreverse.frame.font.color := ltblank;
    songplayer2fo.playreverse.frame.font.color := ltblank;

    songplayerfo.setmono.frame.font.color := ltblank;
    songplayer2fo.setmono.frame.font.color := ltblank;

    songplayerfo.tstringdisp2.font.color := ltblank;
    songplayer2fo.tstringdisp2.font.color := ltblank;

    songplayerfo.button1.font.color := ltblank;
    songplayer2fo.button1.font.color := ltblank;

    songplayerfo.button2.font.color := ltblank;
    songplayer2fo.button2.font.color := ltblank;

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
    drumsfo.langcount.frame.font.color := ltblank;
    drumsfo.langcount.font.color := ltblank;
   
    drumsfo.noand.frame.font.color := ltblank;
    drumsfo.nodrums.frame.font.color := ltblank;
    drumsfo.noanim.frame.font.color := ltblank;
    drumsfo.tlabel21.font.color := ltblank;
    drumsfo.tlabel22.font.color := ltblank;
    drumsfo.tlabel25.font.color := ltblank;
    drumsfo.tlabel23.font.color := ltblank;

    drumsfo.multbpm.font.color := ltblank;
    drumsfo.divbpm.font.color := ltblank;

    drumsfo.tfacedrums.template.fade_color.items[0] := $5A5A5A;
    drumsfo.tfacedrums.template.fade_color.items[1] := $2A2A2A;

    // rev
    drumsfo.tfacecomp2.template.fade_color.items[0] := $5A5A5A;
    drumsfo.tfacecomp2.template.fade_color.items[1] := $2A2A2A;

    // light
    drumsfo.tfacecomp3.template.fade_color.items[0] := $BABABA;
    drumsfo.tfacecomp3.template.fade_color.items[1] := $5A5A5A;

  {  wavefo.waveon.frame.font.color := ltblank;
    wavefo.waveon.color := $5A5A5A;
    wavefo2.waveon.frame.font.color := ltblank;
    wavefo2.waveon.color := $5A5A5A;

    wavefo.waveon.colorglyph := ltblank;
    wavefo2.waveon.colorglyph := ltblank;
}
    // recorder
    recorderfo.font.color := ltblank;

    recorderfo.cbloop.frame.font.color := ltblank;
    recorderfo.cbtempo.frame.font.color := ltblank;

    recorderfo.cbloop.colorglyph := ltblank;
    recorderfo.cbtempo.colorglyph := ltblank;
    recorderfo.bsavetofile.colorglyph := ltblank;
     recorderfo.sentcue1.colorglyph := ltblank;
    recorderfo.blistenin.colorglyph := ltblank;

    recorderfo.songdir.frame.button.colorglyph := ltblank;
    recorderfo.historyfn.frame.button.colorglyph := ltblank;
    
    recorderfo.historyfn.dropdown.colorclient := ltblack;
  
    recorderfo.bsavetofile.frame.font.color := ltblank;
     recorderfo.sentcue1.frame.font.color := ltblank;
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
    
    commanderfo.guimix.colorglyph := ltblank;
    commanderfo.guimix.frame.font.color := ltblank;

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
    
    filelistfo.historyfn.dropdown.colorclient := ltblack;
  
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

if lastrowplayed <> -1 then
begin
  if typecolor.Value = 2 then         
   filelistfo.list_files.rowcolorstate[lastrowplayed]:= 2 else
     filelistfo.list_files.rowcolorstate[lastrowplayed]:= 0;
end;       

  songplayerfo.DrawWaveForm();
  songplayer2fo.DrawWaveForm();

  // songplayerfo.formDrawWaveForm();
  // songplayer2fo.formDrawWaveForm();

end;

procedure tmainfo.onmenuaudio(const Sender: TObject);
begin
  configfo.Show(True);
end;

procedure tmainfo.onresized(const Sender: TObject);
begin

  if (hasinit = 1) then
  begin
    if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;
  end;

end;

procedure tmainfo.showspectrum(const Sender: TObject);
begin
  spectrum1fo.Visible := not spectrum1fo.Visible;
end;

procedure tmainfo.showpan1(const Sender: TObject);
begin
  dockpanel1fo.Visible := not dockpanel1fo.Visible;
end;

procedure tmainfo.showpan2(const Sender: TObject);
begin
  dockpanel2fo.Visible := not dockpanel2fo.Visible;
 end;

procedure tmainfo.showpan3(const Sender: TObject);
begin
  dockpanel3fo.Visible := not dockpanel3fo.Visible;
 end;

procedure tmainfo.onshowspectrum2(const Sender: TObject);
begin
  spectrum2fo.Visible := not spectrum2fo.Visible;
end;

procedure tmainfo.onshowspectrumrec(const Sender: TObject);
begin
  spectrumrecfo.Visible := not spectrumrecfo.Visible;
end;

procedure tmainfo.onmaintab(const Sender: TObject);
begin
  basedock.dragdock.currentsplitdir := sd_tabed;
  updatelayout();
end;

procedure tmainfo.onmaindock(const Sender: TObject);
begin

  basedock.dragdock.currentsplitdir := sd_horz;
  updatelayout();
 
end;

procedure tmainfo.onshowwave1(const Sender: TObject);
begin
  wavefo.Visible := not wavefo.Visible;
end;

procedure tmainfo.onshowwave2(const Sender: TObject);
begin
  wavefo2.Visible := not wavefo2.Visible;
end;

procedure tmainfo.onshowwaverec(const Sender: TObject);
begin
  waveforec.Visible := not waveforec.Visible;
end;

procedure tmainfo.onexit(const sender: TObject);
begin
close;
end;

procedure tmainfo.showpan4(const sender: TObject);
begin
 dockpanel4fo.Visible := not dockpanel4fo.Visible;
end;

procedure tmainfo.showpan5(const sender: TObject);
begin
 dockpanel5fo.Visible := not dockpanel5fo.Visible;
end;

procedure tmainfo.ondockrec(const Sender: TObject);
var
  pt1: pointty;
  rect1 : rectty;
  interv : integer;
  decorationheight: integer = 5;
begin
  // basedock.anchors := [an_left,an_top]  ;
   basedock.dragdock.currentsplitdir := sd_horz;
  decorationheight := window.decoratedbounds_cy - Height;
  
  rect1 := application.screenrect(window);
  
  interv := (rect1.cx- (songplayerfo.Width + recorderfo.Width + 20)) div 2 ;
  
  wavefo.visible := false;

  beginlayout();
  
  norefresh := true;
  
  commanderfo.automix.value := false; 
  
  songplayerfo.edvolleft.value := 100;
  songplayerfo.edvolright.value := 100;
  
  dockpanel1fo.visible := false;
  dockpanel2fo.visible := false;
  dockpanel3fo.visible := false;
  dockpanel4fo.visible := false;
  dockpanel5fo.visible := false;
  
with dockpanel1fo do
  begin

  //  dragfloat(dockpanel1fo);

    songplayerfo.Visible := True;
    songplayerfo.parentwidget := basedock;

    spectrum1fo.Visible := True;
    spectrum1fo.parentwidget := basedock;
    
     //{
    pt1 := nullpoint;

      spectrum1fo.pos := pt1;
      pt1.y := pt1.y + spectrum1fo.Height + decorationheight;
  
 
      songplayerfo.pos := pt1;
      pt1.y := pt1.y + songplayerfo.Height + decorationheight;
      
        
      if dockpanel1fo.Timerwaitdp.Enabled then
  dockpanel1fo.Timerwaitdp.restart // to reset
 else dockpanel1fo.Timerwaitdp.Enabled := True;

  end;
        
     recorderfo.Visible := True;
    recorderfo.parentwidget := basedock;

    spectrumrecfo.Visible := True;
    spectrumrecfo.parentwidget := basedock;
    
     spectrumrecfo.Visible := True;
    spectrumrecfo.parentwidget := basedock;
            
      waveforec.bounds_cxmax := fowidth;
      waveforec.bounds_cymax := wavefoheight;
      waveforec.Width := fowidth;
      waveforec.Height := wavefoheight;
     
     waveforec.Visible := True;
     waveforec.parentwidget := basedock;
     
       pt1 := nullpoint;

    recorderfo.pos := pt1;
    pt1.y := pt1.y + recorderfo.Height + decorationheight;

    spectrumrecfo.pos := pt1;
    
     pt1.y := pt1.y + spectrumrecfo.Height + decorationheight;
      
     waveforec.pos := pt1; 
     
       endlayout();
   
  filelistfo.Visible := false;
  commanderfo.Visible := false;
  
 recorderfo.sentcue1.value := true;
  
 left := interv;
 top := decorationheight + 4;

  dockpanel1fo.left := recorderfo.width + 10 + interv;
  dockpanel1fo.top := recorderfo.height + (1*decorationheight) + 8 ;
  
   wavefo.dragdock.float();
   wavefo.left := left;
  
   
  wavefo.width := (2*fowidth) + 10;
  
  wavefo.height := songplayerfoheight;
  
  wavefo.top := (3*songplayerfoheight) + (3*decorationheight);

  drumsfo.Visible := False;
   
  guitarsfo.Visible := False;
  
  spectrum2fo.Visible := false;
  songplayer2fo.Visible := false;
  wavefo2.Visible := false;
  
  commanderfo.Visible := false; 
  filelistfo.Visible := false;
 
    norefresh := false;
    dockpanel1fo. activate; 
    wavefo. activate; 
    
    visible := true;
     if timeract.Enabled then
  timeract.restart // to reset
 else timeract.Enabled := True;
  
   if timerwait.Enabled then
  timerwait.restart // to reset
 else timerwait.Enabled := True;

end;

procedure tmainfo.loadlayout(const sender: TObject);
var
ordir : string;
begin
 ordir := ExtractFilePath(ParamStr(0))
 + 'layout' + directoryseparator;

typstat := 1;
statusfo.color := $C9BCA7;
statusfo.list_files.frame.caption := 'Choose a layout';
statusfo.list_files.path := utf8decode(ordir);
statusfo.layoutname.visible := false;
statusfo.list_files.visible := true;
statusfo.activate;
end;

procedure tmainfo.savelayout(const sender: TObject);
begin
typstat := 0;
statusfo.caption := 'Layout';
statusfo.color := $C9BCA7;
statusfo.layoutname.value := 'mylayout';
statusfo.layoutname.frame.caption := 'Choose a layout name';
statusfo.layoutname.visible := true;
statusfo.list_files.visible := false;
statusfo.activate;
end;

procedure tmainfo.onshowrandom(const sender: TObject);
begin
 randomnotefo.Visible := not randomnotefo.Visible;
end;

procedure tmainfo.onrandomlayout(const sender: TObject);
begin
ondockall(sender);
sleep(200);
randomnotefo.visible := true;
randomnotefo.bringtofront;
end;

end.
