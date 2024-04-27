
unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$I uos_define.inc}

{$if defined(netbsd) or defined(darwin)}
 {$define nofade}
{$endif}

interface

uses
 {$ifdef windows}win_mixer,{$endif}msetypes,
  msefileutils,
  mseglob,
  config,
  configlayout,
  BGRABitmap,
  BGRABitmapTypes,
  BGRAGradients,
  BGRAGradientScanner,
  mseguiglob,
  po2arrays,
  msegraphedits,
  msescrollbar,
  Process,
  mseguiintf,
  mseapplication,
  msestat,
  msegui,
  msegraphics,
  msegraphutils,
  mseclasses,
  msewidgets,
  mseforms,
  msechart,
  msedock,
  msedataedits,
  mseedit,
  msestatfile,
  SysUtils,
  Classes,
  Math,
  msebitmap,
  synthe,
  msesys,
  msemenus,
  msestream,
  msegrids,
  mselistbrowser,
  mseact,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestrings,
  msedatanodes,
  msedragglob,
  msedropdownlist,
  msefiledialogx,
  msegridsglob,
  msetimer,{$IFDEF unix}dynlibs,
 {$ENDIF}msestockobjects,
  mseconsts,
  captionstrumpract,
  mseimage;

type
  boundchild = record
    left: integer;
    top: integer;
    Width: integer;
    Height: integer;
    Name: string;
  end;

type
  tmainfo = class(tmainform)
    Timerwait: Ttimer;
    Timeract: Ttimer;
    basedock: tdockpanel;
    tmainmenu1: tmainmenu;
    tstatfile1: tstatfile;
    tfacebutgray: tfacecomp;
    tfacered: tfacecomp;
    tfacegreen: tfacecomp;
    tfaceorange: tfacecomp;
    tfaceplayer: tfacecomp;
    tfaceplayerlight: tfacecomp;
    typecolor: tintegeredit;
    tfacebutltgray: tfacecomp;
    tfiledialog1: tfiledialogx;
    dancnum: tintegeredit;
    ttimer1: ttimer;
    ttimer2: ttimer;
    tframecomp1: tframecomp;
    drumsvisible: tintegeredit;
    sliderimage: tbitmapcomp;
    vievmenuicons: timagelist;
    buttonicons: timagelist;

    tfiledialogx2: tfiledialogx;
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
    function issomeplaying: Boolean;
    procedure showall(const Sender: TObject);

    procedure hideall(const Sender: TObject);
    procedure showcommander(const Sender: TObject);
    procedure showfiles(const Sender: TObject);
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
    procedure ondockplayerstag(const Sender: TObject);
    procedure ondockplayersx2(const Sender: TObject);
    procedure ondockplayerstabx2(const Sender: TObject);
    procedure ondockjam(const Sender: TObject);
    procedure dragfloat(const Sender: TObject);
    procedure onexit(const Sender: TObject);
    procedure ondockrec(const Sender: TObject);
    procedure ondockrec2(const Sender: TObject);
    procedure loadlayout(const Sender: TObject);
    procedure savelayout(const Sender: TObject);
    procedure onshowrandom(const Sender: TObject);
    procedure onrandomlayout(const Sender: TObject);
    procedure showimagedancer(const Sender: TObject);
    procedure onimagedancer(const Sender: TObject);
    procedure ondancerlayout(const Sender: TObject);
    procedure onclose(const Sender: TObject);
    procedure ontimertransp(const Sender: TObject);
    procedure showequalizer1(const Sender: TObject);
    procedure showequalizer2(const Sender: TObject);
    procedure showequalizerrec(const Sender: TObject);
    procedure onsetwindowdancer(const Sender: TObject);
    procedure onalwaysontop(const Sender: TObject);
    procedure onhidedancer(const Sender: TObject);
    procedure ontimeridle(const Sender: TObject);
    procedure setlangstrumpract(thelang: string);
    procedure onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onlangset(const Sender: TObject);
    procedure onactiv(const Sender: TObject);
    procedure showinfos1(const Sender: TObject);
    procedure showinfos2(const Sender: TObject);
    procedure onfloatdancer(const Sender: TObject);
    procedure ondockdancer(const Sender: TObject);
    procedure onshowsynth(const Sender: TObject);
    procedure onshowpiano(const Sender: TObject);
    procedure ondockvert(const Sender: TObject);
    procedure resizema(fontheight: integer);
    procedure applyfont(fontval: integer);
    procedure onconfiglayout(const Sender: TObject);
    procedure afterfaceplayer(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
    procedure beforefaceplayer(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty; var handled: Boolean);
    procedure aftergreen(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
    procedure beforegreen(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty; var handled: Boolean);
  private
    flayoutlock: int32;
  protected
    procedure beginlayout();
    procedure endlayout();
    procedure paintslider();
  public
    procedure updatelayoutstrum();
  end;

function RoundMath(aV: double): int64; overload;
function RoundMath(aV: single): int64; overload;

const
  versiontext = '3.8.0';

var
  statdirname: msestring = '^/.strumpract';
  dialoglive: Boolean = False;
  drumsfoheight: integer = 274;
  filelistfoheight: integer = 128;
  wavefoheight: integer = 128;
  guitarsfoheight: integer = 64;
  songplayerfoheight: integer = 128;
  spectrum1foheight: integer = 128;
  recorderfoheight: integer = 128;
  commanderfoheight: integer = 128;
  equalizerfoheight: integer = 142;
  emptyheight: integer = 40;
  fowidth: integer = 442;
  tabheight: integer = 39;
  scrollwidth: integer = 14;
  mainfo: tmainfo;
  stopit: Boolean = False;
  isactivated: Boolean = False;
  channels: cardinal = 2;
  // stereo output
  allok: Boolean = False;
  plugsoundtouch: Boolean = False;
  ordir: msestring;
  hasinit: integer = 0;
  oktimer: integer = 0;
  maxheightfo: integer;
  norefresh: Boolean = False;
  thesender: integer;
  fontheightused: integer = 12;
  // stopplayers: boolean = false;

implementation

uses
  errorform,
  splash,
  findmessage,
  infosd,
  piano,
  conflang,
  drums,
  recorder,
  songplayer,
  commander,
  randomnote,

  // {$if not defined(darwin)}  
  imagedancer,
  // {$endif}

  filelistform,
  spectrum1,
  waveform,
  dockpanel1,
  equalizer,
  aboutform,
  uos_flat,
  guitars,
  dialogfiles,
  main_mfm;

function RoundMath(aV: double): int64; overload;
begin
  if aV >= 0 then
    Result := Trunc(aV + 0.5)
  else
    Result := Trunc(aV - 0.5);
end;

function RoundMath(aV: single): int64; overload;
begin
  if aV >= 0 then
    Result := Trunc(aV + 0.5)
  else
    Result := Trunc(aV - 0.5);
end;

procedure tmainfo.paintslider();
var
  poswav, poswav2: pointty;
  x, heightslider, widthslider, step, step2: integer;
  rect1: rectty;
  arimage: array[0..4] of tbitmapcomp;
begin

  arimage[0] := sliderimage;
  arimage[1] := commanderfo.sliderimage;
  arimage[2] := commanderfo.sliderimage2;
  arimage[3] := commanderfo.sliderimage3;
  arimage[4] := commanderfo.sliderimage4;

  for x := 0 to 4 do
  begin

    rect1.pos := nullpoint;

    if x = 0 then
      rect1.size := equalizerfo1.tslider1.paintsize
    else if x = 1 then
      rect1.size := commanderfo.sysvol.paintsize
    else if x = 2 then
      rect1.size := commanderfo.volumeleft1.paintsize
    else if x = 3 then
      rect1.size := commanderfo.tslider3.paintsize else;
    if x = 4 then
      rect1.size := commanderfo.sysvol.paintsize;

    heightslider := rect1.size.cy;
    widthslider  := rect1.size.cx;

    if x = 4 then
      step := heightslider div 16
    else
      step := heightslider div 11;

    step2 := 0;

    with arimage[x].bitmap do
    begin
      size   := rect1.size;
      masked := False;
      init(cl_transparent);

      poswav.x  := 0;
      poswav2.x := widthslider;
      poswav.y  := 0;
      poswav2.y := 0;

      while poswav.y < heightslider do
      begin

        if ((step2 < 6) and (x = 4)) or ((step2 = 5) and (x = 0)) then
          Canvas.drawline(poswav, poswav2, cl_ltred)
        else if typecolor.Value = 2 then
          Canvas.drawline(poswav, poswav2, cl_gray)
        else
          Canvas.drawline(poswav, poswav2, $FCFCFC);

        Inc(poswav.y, 1);
        poswav2.y := poswav.y;
        Canvas.drawline(poswav, poswav2, cl_dkgray);
        if typecolor.Value = 2 then
          Canvas.drawline(poswav, poswav2, cl_black)
        else
          Canvas.drawline(poswav, poswav2, $FCFCFC);


        Inc(poswav.y, step);
        Inc(step2);
        poswav2.y := poswav.y;
      end;

      poswav.x  := 0;
      poswav2.x := 0;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_dkgray)
      else
        Canvas.drawline(poswav, poswav2, cl_ltgray);

      poswav.x  := widthslider - 1;
      poswav2.x := widthslider - 1;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_dkgray)
      else
        Canvas.drawline(poswav, poswav2, cl_ltgray);

      poswav.x  := roundmath((widthslider - 1) / 2) - 2;
      poswav2.x := roundmath((widthslider - 1) / 2) - 2;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_dkgray)
      else
        Canvas.drawline(poswav, poswav2, cl_gray);

      poswav.x  := roundmath((widthslider - 1) / 2) + 2;
      poswav2.x := roundmath((widthslider - 1) / 2) + 2;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_dkgray)
      else
        Canvas.drawline(poswav, poswav2, cl_gray);

      poswav.x  := roundmath((widthslider - 1) / 2) + 1;
      poswav2.x := roundmath((widthslider - 1) / 2) + 1;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_black)
      else
        Canvas.drawline(poswav, poswav2, cl_ltgray);

      poswav.x  := roundmath((widthslider - 1) / 2) - 1;
      poswav2.x := roundmath((widthslider - 1) / 2) - 1;
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_black)
      else
        Canvas.drawline(poswav, poswav2, cl_ltgray);

      poswav.x  := roundmath((widthslider - 1) / 2);
      poswav2.x := roundmath((widthslider - 1) / 2);
      poswav.y  := 0;
      poswav2.y := heightslider;
      if typecolor.Value = 2 then
        Canvas.drawline(poswav, poswav2, cl_black)
      else
        Canvas.drawline(poswav, poswav2, cl_ltgray);

      transparentcolor := cl_transparent;
      masked           := True;
    end;
  end;

end;

procedure tmainfo.applyfont(fontval: integer);
begin
  fontheightused := fontval;
  commanderfo.resizeco(fontval);
  drumsfo.resizedr(fontval);
  equalizerfo1.resizeeq(fontval);
  equalizerfo2.resizeeq(fontval);
  equalizerforec.resizeeq(fontval);
  songplayerfo.resizesp(fontval);
  songplayer2fo.resizesp(fontval);
  spectrum1fo.resizespc(fontval);
  spectrum2fo.resizespc(fontval);
  spectrumrecfo.resizespc(fontval);
  infosdfo.resizein(fontval);
  synthefo.resizesy(fontval);
  pianofo.resizepi(fontval);
  guitarsfo.resizegu(fontval);
  recorderfo.resizere(fontval);
  infosdfo2.resizein(fontval);
  imagedancerfo.resizeda(fontval);
  filelistfo.resizefi(fontval);
  configlayoutfo.resizecl(fontval);
  configfo.resizecs(fontval);
  aboutfo.resizeab(fontval);
  findmessagefo.resizefm(fontval);
  conflangfo.resizecl(fontval);
  
  paintslider();

  resizema(fontval);

  if fontval < 12 then
  begin
    tmainmenu1.menu.itembynames(['sepquit']).Visible := False;
    tmainmenu1.menu.items[3].Visible := False;
  end
  else
  begin
    tmainmenu1.menu.itembynames(['sepquit']).Visible := True;
    tmainmenu1.menu.items[3].Visible := True;
  end;

  updatelayoutstrum();

  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayoutpan();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayoutpan();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayoutpan();

  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayoutpan();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayoutpan();

  application.ProcessMessages;
end;

procedure tmainfo.resizema(fontheight: integer);
var
  ratio: double;
begin
  ratio           := fontheight / 12;
  emptyheight     := roundmath(40 * ratio);
  fowidth         := roundmath(442 * ratio);
  tabheight       := roundmath(39 * ratio);
  drumsfoheight   := roundmath(274 * ratio);
  filelistfoheight := roundmath(128 * ratio);
  wavefoheight    := roundmath(128 * ratio);
  guitarsfoheight := roundmath(64 * ratio);
  songplayerfoheight := roundmath(128 * ratio);
  spectrum1foheight := roundmath(128 * ratio);
  recorderfoheight := roundmath(128 * ratio);
  commanderfoheight := roundmath(128 * ratio);
  equalizerfoheight := roundmath(142 * ratio);
  tmainmenu1.menu.font.Height := fontheight;

end;

procedure tmainfo.setlangstrumpract(thelang: string);
var
  x: shortint;
  str: string;
  ratio: float;
begin
  ratio := fontheightused / 12;
  createnewlang(thelang);

  conflangfo.ok.Caption := lang_stockcaption[Ord(sc_close)];
  conflangfo.setasdefault.frame.Caption := lang_mainfo[Ord(ma_setasdefault)];
  conflangfo.Caption    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_language)];

  conflangfo.gridlang.rowcount := length(lang_langnames);

  for x := 0 to length(lang_langnames) - 1 do
  begin
    conflangfo.gridlangtext[x] := lang_langnames[x];
    str := trim(copy(lang_langnames[x], system.pos('[', lang_langnames[x]), 10));
    str := StringReplace(str, '[', '', [rfReplaceAll]);
    str := StringReplace(str, ']', '', [rfReplaceAll]);
    conflangfo.gridlangcode[x] := str;
  end;

 {$ifdef unix}
    if (thelang = 'el') or (thelang = 'ru') or
      (thelang = 'ar') or (thelang = 'he') or (thelang = 'zh') then
      begin
      mainfo.mainmenu.menu.font.name := 'Unifont' ;
      mainfo.mainmenu.menu.font.height := roundmath(14*ratio);
      dockpanel1fo.mainmenu.menu.font.name := 'Unifont' ;
      dockpanel1fo.mainmenu.menu.font.height := roundmath(14*ratio);
      dockpanel2fo.mainmenu.menu.font.name := 'Unifont' ;
      dockpanel2fo.mainmenu.menu.font.height := roundmath(14*ratio);
      dockpanel3fo.mainmenu.menu.font.name := 'Unifont' ;
      dockpanel3fo.mainmenu.menu.font.height := roundmath(14*ratio);
      dockpanel4fo.mainmenu.menu.font.name := 'Unifont' ;
      dockpanel4fo.mainmenu.menu.font.height := roundmath(14*ratio);
      dockpanel5fo.mainmenu.menu.font.name := 'Unifont' ;
      dockpanel5fo.mainmenu.menu.font.height := roundmath(14*ratio);
      
   with infosdfo do
    begin
     font.name := 'Unifont' ;
     //font.height := roundmath(14*ratio);
    infoname.frame.font.name := 'Unifont' ;
    infoartist.frame.font.name := 'Unifont' ;
    infoalbum.frame.font.name := 'Unifont' ;
    infoyear.frame.font.name := 'Unifont' ;
    infolength.frame.font.name := 'Unifont' ;
    infotag.frame.font.name := 'Unifont' ;
    tracktag.frame.font.name := 'Unifont' ;
    infocom.frame.font.name := 'Unifont' ;
    infofile.frame.font.name := 'Unifont' ;
    inforate.frame.font.name := 'Unifont' ;
    infochan.frame.font.name := 'Unifont' ;
    infobpm.frame.font.name := 'Unifont' ;
   
    infoname.font.name := 'Unifont' ;
    infoartist.font.name := 'Unifont' ;
    infoalbum.font.name := 'Unifont' ;
    infoyear.font.name := 'Unifont' ;
    infolength.font.name := 'Unifont' ;
    infotag.font.name := 'Unifont' ;
    tracktag.font.name := 'Unifont' ;
    infocom.font.name := 'Unifont' ;
    infofile.font.name := 'Unifont' ;
    inforate.font.name := 'Unifont' ;
    infochan.font.name := 'Unifont' ;
    infobpm.font.name := 'Unifont' ;
    
    //tlabel2.font.name := 'Unifont' ;
    
    infoname.frame.font.height := 12 ;
    infoartist.frame.font.height := 12 ;
    infoalbum.frame.font.height := 12 ;
    infoyear.frame.font.height := 12 ;
    infolength.frame.font.height := 12 ;
    infotag.frame.font.height := 12 ;
    tracktag.frame.font.height := 12 ;
    infocom.frame.font.height := 12 ;
    infofile.frame.font.height := 12 ;
    inforate.frame.font.height := 12 ;
    infochan.frame.font.height := 12 ;
    infobpm.frame.font.height := 12 ;
    end;
    
    with infosdfo2 do
    begin
     font.name := 'Unifont' ;
     //font.height := 14;
    infoname.frame.font.name := 'Unifont' ;
    infoartist.frame.font.name := 'Unifont' ;
    infoalbum.frame.font.name := 'Unifont' ;
    infoyear.frame.font.name := 'Unifont' ;
    infolength.frame.font.name := 'Unifont' ;
    tracktag.frame.font.name := 'Unifont' ;
    infotag.frame.font.name := 'Unifont' ;
    infocom.frame.font.name := 'Unifont' ;
    infofile.frame.font.name := 'Unifont' ;
    inforate.frame.font.name := 'Unifont' ;
    infochan.frame.font.name := 'Unifont' ;
    infobpm.frame.font.name := 'Unifont' ;
    //tlabel2.font.name := 'Unifont' ;
    
     infoname.font.name := 'Unifont' ;
    infoartist.font.name := 'Unifont' ;
    infoalbum.font.name := 'Unifont' ;
    infoyear.font.name := 'Unifont' ;
    infolength.font.name := 'Unifont' ;
    infotag.font.name := 'Unifont' ;
    tracktag.font.name := 'Unifont' ;
    infocom.font.name := 'Unifont' ;
    infofile.font.name := 'Unifont' ;
    inforate.font.name := 'Unifont' ;
    infochan.font.name := 'Unifont' ;
    infobpm.font.name := 'Unifont' ;
    
    infoname.frame.font.height := 12 ;
    infoartist.frame.font.height := 12 ;
    infoalbum.frame.font.height := 12 ;
    infoyear.frame.font.height := 12 ;
    infolength.frame.font.height := 12 ;
    infotag.frame.font.height := 12 ;
    tracktag.frame.font.height := 12 ;
    
    infocom.frame.font.height := 12 ;
    infofile.frame.font.height := 12 ;
    inforate.frame.font.height := 12 ;
    infochan.frame.font.height := 12 ;
    infobpm.frame.font.height := 12 ;
    end;
                 
      commanderfo.font.name := 'Unifont' ;
      commanderfo.font.height := 14;
   
   with drumsfo do
    begin
      font.name := 'Unifont' ;
      font.height := 14;
      
      labpat.font.name := 'Unifont' ;
      lach.font.name := 'Unifont' ;
      laoh.font.name := 'Unifont' ;
      lasd.font.name := 'Unifont' ;
      labd.font.name := 'Unifont' ;
      tstringdisp2.font.name := 'Unifont' ;
      tlabel23.font.name := 'Unifont' ;
      tlabel21.font.name := 'Unifont' ;
      tlabel22.font.name := 'Unifont' ;
      
      langcount.frame.font.name := 'Unifont' ;
      novoice.frame.font.name := 'Unifont' ;
      noand.frame.font.name := 'Unifont' ;
      nodrums.frame.font.name := 'Unifont' ;
      noanim.frame.font.name := 'Unifont' ;
     end;
      
      randomnotefo.font.name := 'Unifont' ;
      randomnotefo.font.height := 20;
      
      randomnotefo.pconfigtext.font.name := 'Unifont' ;
      randomnotefo.pconfigtext.font.height := 20;
      
      randomnotefo.tstringdisp1.font.name := 'Unifont' ;
      randomnotefo.tstringdisp1.font.height := 64;
      
       randomnotefo.tgroupbox1.frame.font.name := 'Unifont' ;
      randomnotefo.tgroupbox1.frame.font.height := 22;
      
      randomnotefo.tgroupbox2.frame.font.name := 'Unifont' ;
      randomnotefo.tgroupbox2.frame.font.height := 22;
      
      randomnotefo.tgroupbox3.frame.font.name := 'Unifont' ;
      randomnotefo.tgroupbox3.frame.font.height := 22;
      
         randomnotefo.tgroupbox1.font.name := 'Unifont' ;
      randomnotefo.tgroupbox1.font.height := 22;
      
      randomnotefo.tgroupbox2.font.name := 'Unifont' ;
      randomnotefo.tgroupbox2.font.height := 22;
      
      randomnotefo.tgroupbox3.font.name := 'Unifont' ;
      randomnotefo.tgroupbox3.font.height := 22;
      
      randomnotefo.tmemoedit1.font.name := 'Unifont' ;
      randomnotefo.tmemoedit1.font.height := 22;
            
      songplayerfo.font.name := 'Unifont' ;
      songplayer2fo.font.name := 'Unifont' ;
      recorderfo.font.name := 'Unifont' ;
      songplayerfo.font.height := roundmath(14*ratio);
      songplayer2fo.font.height := roundmath(14*ratio);
      recorderfo.font.height := roundmath(14*ratio);
    
      conflangfo.font.name := 'Unifont' ;
      conflangfo.font.height := roundmath(14*ratio);
      spectrum1fo.font.name := 'Unifont' ;
      spectrum1fo.font.height := roundmath(14*ratio);
      spectrum2fo.font.name := 'Unifont' ;
      spectrum2fo.font.height := roundmath(14*ratio);
      spectrumrecfo.font.name := 'Unifont' ;
      spectrumrecfo.font.height := roundmath(14*ratio);;
      
      equalizerfo1.font.name := 'Unifont' ;
      equalizerfo1.font.height := roundmath(14*ratio);
      equalizerfo2.font.name := 'Unifont' ;
      equalizerfo2.font.height := roundmath(14*ratio);
      equalizerforec.font.name := 'Unifont' ;
      equalizerforec.font.height := roundmath(14*ratio);
      
      equalizerfo1.loadset.font.name := 'Unifont' ;
      equalizerfo1.loadset.font.height := roundmath(14*ratio);
      equalizerfo1.saveset.font.name := 'Unifont' ;
      equalizerfo1.saveset.font.height := roundmath(14*ratio);
    
      equalizerfo2.loadset.font.name := 'Unifont' ;
      equalizerfo2.loadset.font.height := roundmath(14*ratio);
      equalizerfo2.saveset.font.name := 'Unifont' ;
      equalizerfo2.saveset.font.height := roundmath(14*ratio);
      
      equalizerforec.loadset.font.name := 'Unifont' ;
      equalizerforec.loadset.font.height := roundmath(14*ratio);
      equalizerforec.saveset.font.name := 'Unifont' ;
      equalizerforec.saveset.font.height := roundmath(14*ratio);
           
      equalizerfo1.EQEN.frame.font.name := 'Unifont' ;
      equalizerfo1.EQEN.frame.font.height := roundmath(14*ratio);
      equalizerfo2.EQEN.frame.font.name := 'Unifont' ;
      equalizerfo2.EQEN.frame.font.height := roundmath(14*ratio);
      equalizerforec.EQEN.frame.font.name := 'Unifont' ;
      equalizerforec.EQEN.frame.font.height := roundmath(14*ratio);

      songplayerfo.btinfos.font.name := 'Unifont' ;
      songplayerfo.btinfos.font.height := roundmath(14*ratio);
      songplayerfo.tstringdisp2.font.name := 'Unifont' ;
      songplayerfo.tstringdisp2.font.height := roundmath(14*ratio);
      
      songplayerfo.tstringdisp1.font.name := 'Unifont' ;
      songplayerfo.tstringdisp1.font.height := roundmath(14*ratio);
      songplayer2fo.tstringdisp1.font.name := 'Unifont' ;
      songplayer2fo.tstringdisp1.font.height := roundmath(14*ratio);
         
      songplayer2fo.btinfos.font.name := 'Unifont' ;
      songplayer2fo.btinfos.font.height := roundmath(14*ratio);
      songplayer2fo.tstringdisp2.font.name := 'Unifont' ;
      songplayer2fo.tstringdisp2.font.height := roundmath(14*ratio);
          
      spectrum1fo.spect1.frame.font.name := 'Unifont' ;
      spectrum1fo.spect1.frame.font.height := 14;
      spectrum2fo.spect1.frame.font.name := 'Unifont' ;
      spectrum2fo.spect1.frame.font.height := 14;
      spectrumrecfo.spect1.frame.font.name := 'Unifont' ;
      spectrumrecfo.spect1.frame.font.height := 14;
 
      filelistfo.font.name := 'Unifont' ;
      filelistfo.font.height := roundmath(14*ratio);;
      
      filelistfo.list_files.font.name := 'Unifont' ;
      filelistfo.list_files.font.height := roundmath(14*ratio);
      
      filelistfo.list_files.rowfonts[0].name := 'Unifont' ;
      filelistfo.list_files.rowfonts[0].height := roundmath(14*ratio);
      filelistfo.list_files.rowfonts[1].name := 'Unifont' ;
      filelistfo.list_files.rowfonts[1].height := roundmath(14*ratio);
     
      messagefontname := 'Unifont';
      messagefontheight := roundmath(14*ratio);
         
      end else
      begin
     
      mainfo.mainmenu.menu.font.name := 'stf_default' ;
      mainfo.mainmenu.menu.font.height := roundmath(12*ratio);
      commanderfo.font.name := 'stf_default' ;
      commanderfo.font.height := 12;
      drumsfo.font.name := 'stf_default' ;
      drumsfo.font.height := 12;
      songplayerfo.font.name := 'stf_default' ;
      songplayer2fo.font.name := 'stf_default' ;
      recorderfo.font.name := 'stf_default' ;
      songplayerfo.font.height := 12;
      songplayer2fo.font.height := 12;
      recorderfo.font.height := 12;
      conflangfo.font.name := 'stf_default' ;
      conflangfo.font.height := 12;
      spectrum1fo.font.name := 'stf_default' ;
      spectrum1fo.font.height := 12;
      spectrum2fo.font.name := 'stf_default' ;
      spectrum2fo.font.height := 12;
      spectrumrecfo.font.name := 'stf_default' ;
      spectrumrecfo.font.height := 12;
   
      equalizerfo1.font.name := 'stf_default' ;
      equalizerfo1.font.height := 10;
      equalizerfo2.font.name := 'stf_default' ;
      equalizerfo2.font.height := 10;
      equalizerforec.font.name := 'stf_default' ;
      equalizerforec.font.height := 10;
      
      filelistfo.font.name := 'stf_default' ;
      filelistfo.font.height := roundmath(13*ratio);;
      filelistfo.list_files.font.name := 'stf_default' ;
      filelistfo.list_files.font.height := fontheightused;
      
      filelistfo.list_files.rowfonts[0].name := 'stf_default' ;
      filelistfo.list_files.rowfonts[0].height := fontheightused;
  
      filelistfo.list_files.rowfonts[1].name := 'stf_default' ;
      filelistfo.list_files.rowfonts[1].height := fontheightused;
          
      randomnotefo.font.name := 'stf_default' ;
      randomnotefo.font.height := 24;
      
      randomnotefo.tgroupbox1.frame.font.name := 'stf_default' ;
      randomnotefo.tgroupbox1.frame.font.height := 20;
      
      randomnotefo.tgroupbox2.frame.font.name := 'stf_default' ;
      randomnotefo.tgroupbox2.frame.font.height := 20;
      
      randomnotefo.tgroupbox3.frame.font.name := 'stf_default' ;
      randomnotefo.tgroupbox3.frame.font.height := 20;
      
      
      randomnotefo.pconfigtext.font.name := 'stf_default' ;
      randomnotefo.pconfigtext.font.height := 20;
      
      randomnotefo.tstringdisp1.font.name := 'stf_default' ;
      randomnotefo.tstringdisp1.font.height := 62;
      
      randomnotefo.tmemoedit1.font.name := 'Unifont' ;
      randomnotefo.tmemoedit1.font.height := 20;
        
      messagefontname := 'stf_default';
      messagefontheight := 12;
      
    with infosdfo do
    begin
     font.name := 'stf_default' ;
    // font.height := 14;
    //tlabel2.font.name := 'stf_default' ;
    infoname.frame.font.name := 'stf_default' ;
    infoartist.frame.font.name := 'stf_default' ;
    tracktag.frame.font.name := 'stf_default' ;
    infoalbum.frame.font.name := 'stf_default' ;
    infoyear.frame.font.name := 'stf_default' ;
    infolength.frame.font.name := 'stf_default' ;
    infotag.frame.font.name := 'stf_default' ;
    infocom.frame.font.name := 'stf_default' ;
    infofile.frame.font.name := 'stf_default' ;
    inforate.frame.font.name := 'stf_default' ;
    infochan.frame.font.name := 'stf_default' ;
    infobpm.frame.font.name := 'stf_default' ;
     infoname.font.name := 'stf_default' ;
    infoartist.font.name := 'stf_default' ;
    infoalbum.font.name := 'stf_default' ;
    infoyear.font.name := 'stf_default' ;
    infolength.font.name := 'stf_default' ;
    infotag.font.name := 'stf_default' ;
    tracktag.font.name := 'stf_default' ;
    infocom.font.name := 'stf_default' ;
    infofile.font.name := 'stf_default' ;
    inforate.font.name := 'stf_default' ;
    infochan.font.name := 'stf_default' ;
    infobpm.font.name := 'stf_default' ;
    infoname.frame.font.height := 10 ;
    infoartist.frame.font.height := 10 ;
    infoalbum.frame.font.height := 10 ;
    infoyear.frame.font.height := 10 ;
    infolength.frame.font.height := 10 ;
    tracktag.frame.font.height := 10 ;
    infotag.frame.font.height := 10 ;
    infocom.frame.font.height := 10 ;
    infofile.frame.font.height := 10 ;
    inforate.frame.font.height := 10 ;
    infochan.frame.font.height := 10 ;
    infobpm.frame.font.height := 10 ;
    end;
    
    with infosdfo2 do
    begin
     font.name := 'stf_default' ;
    // font.height := 14;
    //tlabel2.font.name := 'stf_default' ;
    infoname.frame.font.name := 'stf_default' ;
    infoartist.frame.font.name := 'stf_default' ;
    infoalbum.frame.font.name := 'stf_default' ;
    infoyear.frame.font.name := 'stf_default' ;
    infolength.frame.font.name := 'stf_default' ;
    infotag.frame.font.name := 'stf_default' ;
    tracktag.frame.font.name := 'stf_default' ;
    infocom.frame.font.name := 'stf_default' ;
    infofile.frame.font.name := 'stf_default' ;
    inforate.frame.font.name := 'stf_default' ;
    infochan.frame.font.name := 'stf_default' ;
    infobpm.frame.font.name := 'stf_default' ;
      infoname.font.name := 'stf_default' ;
    infoartist.font.name := 'stf_default' ;
    infoalbum.font.name := 'stf_default' ;
    infoyear.font.name := 'stf_default' ;
    infolength.font.name := 'stf_default' ;
    infotag.font.name := 'stf_default' ;
    tracktag.font.name := 'stf_default' ;
    infocom.font.name := 'stf_default' ;
    infofile.font.name := 'stf_default' ;
    inforate.font.name := 'stf_default' ;
    infochan.font.name := 'stf_default' ;
    infobpm.font.name := 'stf_default' ;
     infoname.frame.font.height := 10 ;
    infoartist.frame.font.height := 10 ;
    infoalbum.frame.font.height := 10 ;
    infoyear.frame.font.height := 10 ;
    infolength.frame.font.height := 10 ;
    infotag.frame.font.height := 10 ;
    infocom.frame.font.height := 10 ;
    infofile.frame.font.height := 10 ;
    inforate.frame.font.height := 10 ;
    infochan.frame.font.height := 10 ;
    infobpm.frame.font.height := 10 ;
 
    end;
    
      with drumsfo do
    begin
      font.name := 'stf_default' ;
      font.height := 12;
      
      labpat.font.name := 'stf_default' ;
      lach.font.name := 'stf_default' ;
      laoh.font.name := 'stf_default' ;
      lasd.font.name := 'stf_default' ;
      labd.font.name := 'stf_default' ;
      tstringdisp2.font.name := 'stf_default' ;
      tlabel23.font.name := 'stf_default' ;
      tlabel21.font.name := 'stf_default' ;
      tlabel22.font.name := 'stf_default' ;
      
      langcount.frame.font.name := 'stf_default' ;
      novoice.frame.font.name := 'stf_default' ;
      noand.frame.font.name := 'stf_default' ;
      nodrums.frame.font.name := 'stf_default' ;
      noanim.frame.font.name := 'stf_default' ;
     end;
    
      equalizerfo1.font.name := 'stf_default' ;
      equalizerfo1.font.height := roundmath(12*ratio);
      equalizerfo2.font.name := 'stf_default' ;
      equalizerfo2.font.height := roundmath(12*ratio);
      equalizerforec.font.name := 'stf_default' ;
      equalizerforec.font.height := roundmath(12*ratio);
      
      equalizerfo1.loadset.font.name := 'stf_default' ;
      equalizerfo1.loadset.font.height := roundmath(12*ratio);
      equalizerfo1.saveset.font.name := 'stf_default' ;
      equalizerfo1.saveset.font.height := roundmath(12*ratio);
    
      equalizerfo2.loadset.font.name := 'stf_default' ;
      equalizerfo2.loadset.font.height := roundmath(12*ratio);
      equalizerfo2.saveset.font.name := 'stf_default' ;
      equalizerfo2.saveset.font.height := roundmath(12*ratio);
      
      equalizerforec.loadset.font.name := 'stf_default' ;
      equalizerforec.loadset.font.height := roundmath(12*ratio);
      equalizerforec.saveset.font.name := 'stf_default' ;
      equalizerforec.saveset.font.height := roundmath(12*ratio);
    
      equalizerfo1.EQEN.frame.font.name := 'stf_default' ;
      equalizerfo1.EQEN.frame.font.height := roundmath(12*ratio);
      equalizerfo2.EQEN.frame.font.name := 'stf_default' ;
      equalizerfo2.EQEN.frame.font.height := roundmath(12*ratio);
      equalizerforec.EQEN.frame.font.name := 'stf_default' ;
      equalizerforec.EQEN.frame.font.height := roundmath(12*ratio);
      
      songplayerfo.btinfos.font.name := 'stf_default' ;
      songplayerfo.btinfos.font.height := roundmath(12*ratio);
      songplayerfo.tstringdisp2.font.name := 'stf_default' ;
      songplayerfo.tstringdisp2.font.height := roundmath(12*ratio);
      
      songplayer2fo.btinfos.font.name := 'stf_default' ;
      songplayer2fo.btinfos.font.height := roundmath(12*ratio);
      songplayer2fo.tstringdisp2.font.name := 'stf_default' ;
      songplayer2fo.tstringdisp2.font.height := roundmath(12*ratio);
      
      songplayerfo.tstringdisp1.font.name := 'stf_default' ;
      songplayerfo.tstringdisp1.font.height := roundmath(12*ratio);
      songplayer2fo.tstringdisp1.font.name := 'stf_default' ;
      songplayer2fo.tstringdisp1.font.height := roundmath(12*ratio);
             
      spectrum1fo.spect1.frame.font.name := 'stf_default' ;
      spectrum1fo.spect1.frame.font.height := 14;
      spectrum2fo.spect1.frame.font.name := 'stf_default' ;
      spectrum2fo.spect1.frame.font.height := 14;
      spectrumrecfo.spect1.frame.font.name := 'stf_default' ;
      spectrumrecfo.spect1.frame.font.height := 14;
 
      dockpanel1fo.mainmenu.menu.font.name := 'stf_default' ;
      dockpanel1fo.mainmenu.menu.font.height := roundmath(12*ratio);
      dockpanel2fo.mainmenu.menu.font.name := 'stf_default' ;
      dockpanel2fo.mainmenu.menu.font.height := roundmath(12*ratio);;
      dockpanel3fo.mainmenu.menu.font.name := 'stf_default' ;
      dockpanel3fo.mainmenu.menu.font.height := roundmath(12*ratio);;
      dockpanel4fo.mainmenu.menu.font.name := 'stf_default' ;
      dockpanel4fo.mainmenu.menu.font.height := roundmath(12*ratio);;
      dockpanel5fo.mainmenu.menu.font.name := 'stf_default' ;
      dockpanel5fo.mainmenu.menu.font.height := roundmath(12*ratio);;
         
      end;
      
      onchangevalcolor(nil);

 {$endif}

  with mainfo do
  begin
    if (thelang = 'id') or (thelang = 'el') then
      tframecomp1.template.extraspace := 2
    else if (thelang = 'fr') or (thelang = 'es') then
      tframecomp1.template.extraspace := 4
    else if (thelang = 'de') or (thelang = 'pt') or (thelang = 'pl') or (thelang = 'ar') then
      tframecomp1.template.extraspace := 6
    else if (thelang = 'ru') or (thelang = 'eo') then
      tframecomp1.template.extraspace := 7
    else
      tframecomp1.template.extraspace := 10;

    Caption := lang_mainfo[Ord(ma_mainfo)] + ' ' + versiontext;  {'StrumPract'}

    basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];  {'Drag a form here using right-border grip.'}

    //  tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
    tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

    //  tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];  {'&Tab'}
    tmainmenu1.menu.itembynames(['tab']).hint := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}

    tmainmenu1.menu.itembynames(['layout', 'dockall']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_dockall)];  {'&Dock all visible windows'}
    tmainmenu1.menu.itembynames(['layout', 'dockall']).hint    := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

    tmainmenu1.menu.itembynames(['layout', 'floatall']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_floatall)];  {'&Float all visible windows'}
    tmainmenu1.menu.itembynames(['layout', 'floatall']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_floatall_hint)];  {'Float windows in independent forms'}

    tmainmenu1.menu.itembynames(['layout', 'taball']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_taball)];  {'&Tab all visible windows'}
    tmainmenu1.menu.itembynames(['layout', 'taball']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_taball_hint)];  {'Make windows tabed in one form'}

    tmainmenu1.menu.itembynames(['layout', 'jamsession']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_jamsession)];  {'&Jam Session'}

    tmainmenu1.menu.itembynames(['layout', 'djwave']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_djwave)];  {'DJ Console Wave'}

    tmainmenu1.menu.itembynames(['layout', 'djinfo']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_djinfo)];  {'DJ Console Info'}

    tmainmenu1.menu.itembynames(['layout', 'recordstage']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_recordstage)];  {'&Record stage'}

    tmainmenu1.menu.itembynames(['layout', 'chordrandom']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_chordrandom)];  {'&Chords Randomizer'}

    tmainmenu1.menu.itembynames(['layout', 'imagedancer']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_imagedancer)];  {'&Image Dancer'}

    tmainmenu1.menu.itembynames(['layout', 'savelayout']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_savelayout)];  {'Save Layout'}
    tmainmenu1.menu.itembynames(['layout', 'savelayout']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_savelayout_hint)];  {'Save current layout'}

    tmainmenu1.menu.itembynames(['layout', 'loadlayout']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_loadlayout)];  {'Load Layout'}
    tmainmenu1.menu.itembynames(['layout', 'loadlayout']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_loadlayout_hint)];  {'Load saved layout'}

    tmainmenu1.menu.itembynames(['layout']).Caption := lang_mainfo[Ord(ma_tmainmenu1_layout)];  {'&Layout'}
    tmainmenu1.menu.itembynames(['layout']).hint    := lang_mainfo[Ord(ma_tmainmenu1_layout_hint)];  {'Layout of windows'}

    tmainmenu1.menu.itembynames(['show', 'showall']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showall)];  {'Show All'}

    tmainmenu1.menu.itembynames(['show', 'hideall']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_hideall)];  {'Hide All'}

    if drumsfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showdrums']).Caption := str +
      lang_commanderfo[Ord(co_namedrums_hint)];

    //  lang_mainfo[Ord(ma_tmainmenu1_parentitem_showdrums)];  {'Show Drums'}

    if filelistfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showlist']).Caption := str +
      lang_mainfo[Ord(ma_fileslist)];

    //  tmainmenu1.menu.itembynames(['show','showlist']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showlist)];  {'Show File List'}


    if songplayerfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showplay1']).Caption := str +
      lang_commanderfo[Ord(co_nameplayers_hint)];

    //  tmainmenu1.menu.itembynames(['show','showplay1']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showplay1)];  {'Show Player 1'}

    if songplayer2fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showplay2']).Caption := str +
      lang_commanderfo[Ord(co_nameplayers2_hint)];

    //   tmainmenu1.menu.itembynames(['show','showplay2']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showplay2)];  {'Show Player 2'}

    if commanderfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showcommander']).Caption := str +
      lang_commanderfo[Ord(co_commanderfo)];

    //  tmainmenu1.menu.itembynames(['show','showcommander']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showcommander)];  {'Show Commander'}

    if recorderfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showrecorder']).Caption := str +
      lang_mainfo[Ord(ma_recorder)];

    //  tmainmenu1.menu.itembynames(['show','showrecorder']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showrecorder)];  {'Show Recorder'}

    if guitarsfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showguitar']).Caption := str +
      lang_randomnotefo[Ord(ra_tbutton5)];

    // tmainmenu1.menu.itembynames(['show','show guitar']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showguitar)];  {'Show Guitars'}

    if spectrum1fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showspectrum1']).Caption := str +
      lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    //  tmainmenu1.menu.itembynames(['show','showspectrum1']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showspectrum1)];  {'Show Spectrum 1'}

    if spectrum2fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showspectrum2']).Caption := str +
      lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    //  tmainmenu1.menu.itembynames(['show','showspectrum2']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showspectrum2)];  {'Show Spectrum 2'}

    if spectrumrecfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showspectrumrec']).Caption := str +
      lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)];

    // tmainmenu1.menu.itembynames(['show','showspectrumrec']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showspectrumrec)];  {'Show Spectrum Rec'}

    if wavefo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showwave1']).Caption := str +
      lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    // tmainmenu1.menu.itembynames(['show','showwave1']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showwave1)];  {'Show WaveForm 1'}

    if wavefo2.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showwave2']).Caption := str +
      lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    //  tmainmenu1.menu.itembynames(['show','showwave2']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showwave2)];  {'Show WaveForm 2'}

    if waveforec.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showwaverec']).Caption := str +
      lang_mainfo[Ord(ma_waveform)] + ' ' + lang_mainfo[Ord(ma_recorder)];

    //    tmainmenu1.menu.itembynames(['show','showwaverec']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showwaverec)];  {'Show WaveForm Rec'}

    if equalizerfo1.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showequ1']).Caption := str +
      lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    //      tmainmenu1.menu.itembynames(['show','showequ1']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showequ1)];  {'Show Equalizer 1'}

    if equalizerfo2.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showequ2']).Caption := str +
      lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    //      tmainmenu1.menu.itembynames(['show','showequ2']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showequ2)];  {'Show Equalizer 2'}

    if equalizerforec.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showequrec']).Caption := str +
      lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_mainfo[Ord(ma_recorder)];

    //      tmainmenu1.menu.itembynames(['show','showequrec']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showequrec)];  {'Show Equalizer Rec'}

    if equalizerforec.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showchords']).Caption := str +
      lang_randomnotefo[Ord(ra_randomnotefo)];

    //      tmainmenu1.menu.itembynames(['show','showchords']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showchords)];  {'Show Chord Randomizer'}

    //       {$if not defined(darwin)}
    if imagedancerfo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'showimagedancer']).Caption := str +
      lang_mainfo[Ord(ma_tmainmenu1_parentitem_imagedancer)];

    //   {$endif}   

    with dockpanel1fo do
    begin
      basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

      //   tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
      tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

      //  tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];    {'&Tab'}
      tmainmenu1.menu.itembynames(['tab']).hint := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}
    end;

    with dockpanel2fo do
    begin
      basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

      // tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
      tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

      // tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];    {'&Tab'}
      tmainmenu1.menu.itembynames(['tab']).hint := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}
    end;

    with dockpanel3fo do
    begin
      basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

      //  tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
      tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

      //  tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];    {'&Tab'}
      tmainmenu1.menu.itembynames(['tab']).hint := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}
    end;

    with dockpanel4fo do
    begin
      basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

      // tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
      tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

      // tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];    {'&Tab'}
      tmainmenu1.menu.itembynames(['tab']).hint := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}
    end;

    with dockpanel5fo do
    begin
      basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

      //  tmainmenu1.menu.itembynames(['dock']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dock)];  {'&Dock'}
      tmainmenu1.menu.itembynames(['dock']).hint := lang_mainfo[Ord(ma_tmainmenu1_dock_hint)];  {'Dock windows in one form'}

      tmainmenu1.menu.itembynames(['tab']).Caption := lang_mainfo[Ord(ma_tmainmenu1_tab)];    {'&Tab'}
      tmainmenu1.menu.itembynames(['tab']).hint    := lang_mainfo[Ord(ma_tmainmenu1_tab_hint)];  {'One form with tabs'}
    end;

    //      tmainmenu1.menu.itembynames(['show','showimagedancer']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showimagedancer)];  {'Show Image Dancer'}
    dockpanel1fo.Caption := lang_mainfo[Ord(ma_dockpanel)] + ' 1';
    if dockpanel1fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel1']).Caption :=
      str + lang_mainfo[Ord(ma_dockpanel)] + ' 1';  {'Show Dock Panel 1'}

    //   tmainmenu1.menu.itembynames(['show','panels','showpanel2']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showpanel2)];  {'Show Dock Panel 2'}
    if dockpanel2fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    dockpanel2fo.Caption := lang_mainfo[Ord(ma_dockpanel)] + ' 2';

    tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel2']).Caption :=
      str + lang_mainfo[Ord(ma_dockpanel)] + ' 2';  {'Show Dock Panel 2'}

    dockpanel2fo.basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];


    //  tmainmenu1.menu.itembynames(['show','panels','showpanel3']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showpanel3)];  {'Show Dock Panel 3'}
    if dockpanel3fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel3']).Caption :=
      str + lang_mainfo[Ord(ma_dockpanel)] + ' 3';  {'Show Dock Panel 3'}

    dockpanel3fo.basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];


    dockpanel3fo.Caption := lang_mainfo[Ord(ma_dockpanel)] + ' 3';
    //   tmainmenu1.menu.itembynames(['show','panels','showpanel4']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showpanel4)];  {'Show Dock Panel 4'}

    if dockpanel4fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel4']).Caption :=
      str + lang_mainfo[Ord(ma_dockpanel)] + ' 4';  {'Show Dock Panel 4'}

    dockpanel4fo.basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

    dockpanel4fo.Caption := lang_mainfo[Ord(ma_dockpanel)] + ' 4';
    // tmainmenu1.menu.itembynames(['show','panels','showpanel5']).caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_showpanel5)];  {'Show Dock Panel 5'}
    if dockpanel5fo.Visible then
      str := lang_mainfo[Ord(ma_hide)]
    else
      str := lang_mainfo[Ord(ma_tmainmenu1_show)];
    str := str + ': ';

    tmainmenu1.menu.itembynames(['show', 'panels', 'showpanel5']).Caption :=
      str + lang_mainfo[Ord(ma_dockpanel)] + ' 5';  {'Show Dock Panel 5'}

    dockpanel5fo.Caption := lang_mainfo[Ord(ma_dockpanel)] + ' 5';

    dockpanel5fo.basedock.dockingareacaption := lang_mainfo[Ord(ma_basedockdragdock)];

    tmainmenu1.menu.itembynames(['show', 'panels']).Caption := lang_mainfo[Ord(ma_tmainmenu1_panels)];  {'&Panels'}

    tmainmenu1.menu.itembynames(['show']).Caption := lang_mainfo[Ord(ma_tmainmenu1_show)];  {'&Show'}
    tmainmenu1.menu.itembynames(['show']).hint    := lang_mainfo[Ord(ma_tmainmenu1_show_hint)];  {'Show/hide windows'}


    tmainmenu1.menu.itembynames(['dancer', 'square']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_square)];  {'Square'}

    tmainmenu1.menu.itembynames(['dancer', 'triangle']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_triangle)];  {'Triangle'}

    tmainmenu1.menu.itembynames(['dancer', 'lines']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_lines)];  {'Lines'}

    tmainmenu1.menu.itembynames(['dancer', 'fractraltree']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_fractraltree)];  {'Fractal Tree'}

    tmainmenu1.menu.itembynames(['dancer', 'superformula']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_superformula)];  {'Super Formula'}

    tmainmenu1.menu.itembynames(['dancer', 'hyperformula']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_hyperformula)];  {'Hyper Formula'}

    tmainmenu1.menu.itembynames(['dancer', 'atom']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_atom)];  {'Atom'}

    tmainmenu1.menu.itembynames(['dancer', 'spiralhue']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_spiralhue)];  {'Spiral Hue'}

    tmainmenu1.menu.itembynames(['dancer', 'spiralrainbow']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_spiralrainbow)];  {'Spiral Rainbow'}

    tmainmenu1.menu.itembynames(['dancer', 'spiralmove']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_spiralmove)];  {'Spiral Move'}

    tmainmenu1.menu.itembynames(['dancer', 'turtle1']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_turtle1)];  {'Turtle 1'}

    tmainmenu1.menu.itembynames(['dancer', 'turtle2']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_turtle2)];  {'Turtle 2'}

    tmainmenu1.menu.itembynames(['dancer', 'fractalcircles']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_fractalcircles)];  {'Fractal Circles'}

    tmainmenu1.menu.itembynames(['dancer', 'normalform']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_normalform)];  {'Normal form'}
    tmainmenu1.menu.itembynames(['dancer', 'normalform']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_normalform_hint)];  {'Use this form to set the size for Ellipse and (Round)Rectangle forms.'}

    tmainmenu1.menu.itembynames(['dancer', 'ellipse']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_ellipse)];  {'Ellipse'}

    tmainmenu1.menu.itembynames(['dancer', 'roundrect']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_roundrect)];  {'Rounded rect'}

    tmainmenu1.menu.itembynames(['dancer', 'rect']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_rect)];  {'Rectangle'}

    tmainmenu1.menu.itembynames(['dancer', 'alwaystop']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_alwaystop)];  {'Always on top'}

    tmainmenu1.menu.itembynames(['dancer', 'transparent']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_transparent)];  {'Transparent'}

    tmainmenu1.menu.itembynames(['dancer', 'hidedancer']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_hidedancer)];  {'Hide Dancer'}

    tmainmenu1.menu.itembynames(['dancer']).Caption := lang_mainfo[Ord(ma_tmainmenu1_dancer)];  {'Da&ncer'}
    tmainmenu1.menu.itembynames(['dancer']).hint    := lang_mainfo[Ord(ma_tmainmenu1_dancer_hint)];  {'Dancing Animations'}

    // tmainmenu1.menu.itembynames(['config', 'style', 'gold']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_gold)];  {'Gold'}

    //  tmainmenu1.menu.itembynames(['config', 'style', 'silver']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_silver)];  {'Silver'}

    //   tmainmenu1.menu.itembynames(['config', 'style', 'carbon']).Caption := lang_mainfo[Ord(ma_tmainmenu1_parentitem_carbon)];  {'Carbon'}

    //   tmainmenu1.menu.itembynames(['config', 'style']).Caption := lang_mainfo[Ord(ma_tmainmenu1_style)];  {'&Style'}
    //   tmainmenu1.menu.itembynames(['config', 'style']).hint    := lang_mainfo[Ord(ma_tmainmenu1_style_hint)];  {'Layout style Gold, Silver or Carbon'}

    //   tmainmenu1.menu.itembynames(['config', 'audio']).hint :=
    //     lang_mainfo[Ord(ma_tmainmenu1_parentitem_audio_hint)];  {'Config of audio and colors'}

    //  tmainmenu1.menu.itembynames(['config', 'audio']).Caption :=
    //   lang_mainfo[Ord(ma_tmainmenu1_parentitem_audio_hint)];  {'Config of audio and colors'}

    //   lang_mainfo[Ord(ma_tmainmenu1_parentitem_audio)] + ' + System ';  {'Audio'}

    // tmainmenu1.menu.itembynames(['language']).hint    := lang_mainfo[Ord(ma_tmainmenu1_parentitem_language_hint)];  {'Set language'}

    tmainmenu1.menu.itembynames(['config']).Caption := lang_mainfo[Ord(ma_tmainmenu1_config)];  {'&Config'}
    tmainmenu1.menu.itembynames(['config']).hint    := lang_mainfo[Ord(ma_tmainmenu1_config_hint)];  {'Configuration setting'}

    tmainmenu1.menu.itembynames(['about']).Caption := lang_mainfo[Ord(ma_tmainmenu1_about)];  {'&About'}
    tmainmenu1.menu.itembynames(['about']).hint    := lang_mainfo[Ord(ma_tmainmenu1_about_hint)];  {'About StrumPract'}

    tmainmenu1.menu.itembynames(['quit']).Caption := lang_mainfo[Ord(ma_tmainmenu1_quit)];  {'&Quit'}
    tmainmenu1.menu.itembynames(['quit']).hint    := lang_mainfo[Ord(ma_tmainmenu1_quit_hint)];  {'Terminate StrumPract'}

  end;

  with findmessagefo do
    tbutton3.Caption := lang_stockcaption[Ord(sc_close)];

  with infosdfo do
  begin
    Caption := lang_commanderfo[Ord(co_nameplayers_hint)] + ' ' +
      lang_infosfo[Ord(in_infosfo)];
    //tlabel2.Caption := lang_infosfo[Ord(in_tlabel2)] + ' ';  {'No Image Tag'}
    infoname.frame.Caption := lang_infosfo[Ord(in_infonameframe)];  {'Title'}
    infoartist.frame.Caption := lang_infosfo[Ord(in_infoartistframe)];  {'Artist'}
    infoalbum.frame.Caption := lang_infosfo[Ord(in_infoalbumframe)];  {'Album'}
    infoyear.frame.Caption := lang_infosfo[Ord(in_infoyearframe)];  {'Year'}
    infolength.frame.Caption := lang_infosfo[Ord(in_infolengthframe)];  {'Duration'}
    infotag.frame.Caption := lang_infosfo[Ord(in_infotagframe)];  {'Genre'}
    infocom.frame.Caption := lang_infosfo[Ord(in_infocomframe)];  {'Comment'}
    tracktag.frame.Caption := lang_infosfo[Ord(in_tracktagframe)];  {'Track'}
    infofile.frame.Caption := lang_infosfo[Ord(in_infofileframe)];  {'File Name'}
    inforate.frame.Caption := lang_infosfo[Ord(in_inforateframe)];  {'Rate'}
    infochan.frame.Caption := lang_infosfo[Ord(in_infochanframe)];  {'Chan'}
    infobpm.frame.Caption := lang_infosfo[Ord(in_infobpmframe)];  {'BMP'}
  end;

  with infosdfo2 do
  begin
    Caption := lang_commanderfo[Ord(co_nameplayers2_hint)] + ' ' +
      lang_infosfo[Ord(in_infosfo)];
    //tlabel2.Caption := lang_infosfo[Ord(in_tlabel2)] + ' ';  {'No Image Tag'}
    infoname.frame.Caption := lang_infosfo[Ord(in_infonameframe)];  {'Title'}
    infoartist.frame.Caption := lang_infosfo[Ord(in_infoartistframe)];  {'Artist'}
    infoalbum.frame.Caption := lang_infosfo[Ord(in_infoalbumframe)];  {'Album'}
    infoyear.frame.Caption := lang_infosfo[Ord(in_infoyearframe)];  {'Year'}
    tracktag.frame.Caption := lang_infosfo[Ord(in_tracktagframe)];  {'Track'}
    infolength.frame.Caption := lang_infosfo[Ord(in_infolengthframe)];  {'Duration'}
    infotag.frame.Caption := lang_infosfo[Ord(in_infotagframe)];  {'Genre'}
    infocom.frame.Caption := lang_infosfo[Ord(in_infocomframe)];  {'Comment'}
    infofile.frame.Caption := lang_infosfo[Ord(in_infofileframe)];  {'File Name'}
    inforate.frame.Caption := lang_infosfo[Ord(in_inforateframe)];  {'Rate'}
    infochan.frame.Caption := lang_infosfo[Ord(in_infochanframe)];  {'Chan'}
    infobpm.frame.Caption := lang_infosfo[Ord(in_infobpmframe)];  {'BMP'}
  end;

  with songplayerfo do
  begin
    Caption := lang_commanderfo[Ord(co_nameplayers_hint)];

    frame.grip_hint := lang_commanderfo[Ord(co_commanderfogriphint)];
    ;  {' Use that grip panel to drag/drop the window. '}

    tgroupbox1.hint := lang_commanderfo[Ord(co_nameplayers_hint)];  {' Player 1 '}

    tstringdisp2.Value := lang_commanderfo[Ord(co_nameplayers_hint)];

    edvolleft.hint := lang_songplayerfo[Ord(so_edvolleft_hint)];  {' Change Left volume '}

    //  button1.hint := lang_songplayerfo[Ord(so_button1_hint)];      {' Reset to tempo original '}

    trackbar1.hint := lang_songplayerfo[Ord(so_trackbar1_hint)];  {' Click to change position of sound '}

    historyfn.hint := lang_songplayerfo[Ord(so_historyfn_hint)];  {' History of Cue files '}

    tstringdisp1.hint := lang_commanderfo[Ord(co_nameplayers_hint)];  {' Player 1 '}

    edvolright.hint := lang_songplayerfo[Ord(so_edvolright_hint)];  {' Change Right volume '}

    edtempo.hint := lang_songplayerfo[Ord(so_edtempo_hint)];      {' Change tempo of song '}

    btinfos.hint    := lang_songplayerfo[Ord(so_btinfos_hint)];   {' Show infos of the song '}
    btinfos.Caption := lang_songplayerfo[Ord(so_btinfos)];        {'Info'}

    button2.hint := lang_songplayerfo[Ord(so_button2_hint)];      {' Detect BMP from current position and set it to Drums tempo. '}

    btnStop.hint := lang_commanderfo[Ord(co_btnStop_hint)];       {' Stop player '}

    btnResume.hint := lang_songplayerfo[Ord(so_btnResume_hint)];  {' Resume player '}

    btnStart.hint := lang_songplayerfo[Ord(so_btnStart_hint)];    {' Load from cue and Start player '}

    BtnCue.hint := lang_songplayerfo[Ord(so_BtnCue_hint)];        {' Load from cue and Pause player '}

    btnPause.hint := lang_commanderfo[Ord(co_btnPause_hint)];     {' Pause player '}

    tbutton6.hint := lang_songplayerfo[Ord(so_tbutton6_hint)];    {' Choose a  wav, ogg, flac or mp3 audio file '}

    lposition.hint := lang_songplayerfo[Ord(so_lposition_hint)];  {' Position of sound '}

    // llength.hint := lang_songplayerfo[Ord(so_llength_hint)];      {' Length of sound '}

    cbloopb.hint       := lang_songplayerfo[Ord(so_cbloopb_hint)];  {' Enable looping the song. (Pause is not enabled with loop.) '}
    setmono.hint       := lang_songplayerfo[Ord(so_setmono_hint)];  {'Mono/Stereo'}
    waveformcheck.hint := lang_songplayerfo[Ord(so_waveformcheck_hint)];  {' Show wave form in slider '}

    playreverse.hint := lang_songplayerfo[Ord(so_playreverse_hint)];  {' Enable playing reverse.'}

    cbloopb.hint := lang_songplayerfo[Ord(so_cbloopb_hint)];       {' Enable looping the song. (Pause is not enabled with loop.) '}

    cbtempo.hint := lang_songplayerfo[Ord(so_cbtempo_hint)];      {' Enable stretching (changing tempo) '}

    playreverseb.hint   := lang_songplayerfo[Ord(so_playreverse_hint)];  {' Enable playing reverse.'}
    waveformcheckb.hint := lang_songplayerfo[Ord(so_waveformcheck_hint)];  {' Show wave form in slider '}
    setmonob.hint       := lang_songplayerfo[Ord(so_setmono_hint)];  {' Set Mono-Stereo '}
    //   cbtempob.hint       := lang_songplayerfo[Ord(so_cbtempo_hint)];  {' Enable stretching (changing tempo) '}
    hintlabel.Caption   := lang_commanderfo[Ord(co_hintlabel)];   {'Invalid value.  Reset to 100.'}

    hintlabel2.Caption := lang_commanderfo[Ord(co_hintlabel2)];   {'Or press Esc key for previous value.'}

  end;

  with recorderfo do
  begin
    Caption         := lang_mainfo[Ord(ma_recorder)];
    frame.grip_hint := lang_commanderfo[Ord(co_commanderfogriphint)];  {' Use that grip panel to drag/drop the window. '}

    tgroupbox1.hint := lang_mainfo[Ord(ma_recorder)]; {' Player 1 '}

    tstringdisp2.Value := lang_mainfo[Ord(ma_recorder)];

    edvol.hint := lang_songplayerfo[Ord(so_edvolleft_hint)];  {' Change Left volume '}

    button1.hint := lang_songplayerfo[Ord(so_button1_hint)];  {' Reset to tempo original '}

    trackbar1.hint := lang_songplayerfo[Ord(so_trackbar1_hint)];  {' Click to change position of sound '}

    historyfn.hint := lang_songplayerfo[Ord(so_historyfn_hint)];  {' History of Cue files '}

    tstringdisp2.hint := lang_mainfo[Ord(ma_recorder)];       {' Recorder'}

    edvolr.hint := lang_songplayerfo[Ord(so_edvolright_hint)];  {' Change Right volume '}

    edtempo.hint := lang_songplayerfo[Ord(so_edtempo_hint)];  {' Change tempo of song '}

    btinfos.hint    := lang_songplayerfo[Ord(so_btinfos_hint)];  {' Show infos of the song '}
    btinfos.Caption := lang_songplayerfo[Ord(so_btinfos)];    {'Info'}

    btnStop.hint := lang_commanderfo[Ord(co_btnStop_hint)];   {' Stop player '}

    btnResume.hint := lang_songplayerfo[Ord(so_btnResume_hint)];  {' Resume player '}

    btnStart.hint := lang_songplayerfo[Ord(so_btnStart_hint)];  {' Load from cue and Start player '}

    btnPause.hint := lang_commanderfo[Ord(co_btnPause_hint)];  {' Pause player '}

    tbutton6.hint := lang_songplayerfo[Ord(so_tbutton6_hint)];  {' Choose a  wav, ogg, flac or mp3 audio file '}

    lposition.hint := lang_songplayerfo[Ord(so_lposition_hint)];  {' Position of sound '}

    //  llength.hint := lang_songplayerfo[Ord(so_llength_hint)];  {' Length of sound '}

    cbloop.hint := lang_songplayerfo[Ord(so_cbloopb_hint)];   {' Enable looping the song. (Pause is not enabled with loop.) '}

    cbtempo.hint := lang_songplayerfo[Ord(so_cbtempo_hint)];  {' Enable stretching (changing tempo) '}

    hintlabel.Caption := lang_commanderfo[Ord(co_hintlabel)];  {'Invalid value.  Reset to 100.'}

    hintlabel2.Caption := lang_commanderfo[Ord(co_hintlabel2)];  {'Or press Esc key for previous value.'}

  end;


  with songplayer2fo do
  begin
    Caption := lang_commanderfo[Ord(co_nameplayers2_hint)];

    frame.grip_hint := lang_commanderfo[Ord(co_commanderfogriphint)];
    ;  {' Use that grip panel to drag/drop the window. '}

       //  dragdock.caption := lang_songplayerfo[Ord(so_songplayerfodragdock)];  {' Play2 '}

    tgroupbox1.hint := lang_commanderfo[Ord(co_nameplayers2_hint)]; {' Player 2 '}

    tstringdisp2.Value := lang_commanderfo[Ord(co_nameplayers2_hint)];

    edvolleft.hint := lang_songplayerfo[Ord(so_edvolleft_hint)];  {' Change Left volume '}

    //   button1.hint := lang_songplayerfo[Ord(so_button1_hint)];      {' Reset to tempo original '}

    trackbar1.hint := lang_songplayerfo[Ord(so_trackbar1_hint)];  {' Click to change position of sound '}

    historyfn.hint := lang_songplayerfo[Ord(so_historyfn_hint)];  {' History of Cue files '}

    tstringdisp1.hint := lang_commanderfo[Ord(co_nameplayers2_hint)];  {' Player 1 '}

    edvolright.hint := lang_songplayerfo[Ord(so_edvolright_hint)];  {' Change Right volume '}

    edtempo.hint := lang_songplayerfo[Ord(so_edtempo_hint)];      {' Change tempo of song '}

    btinfos.hint    := lang_songplayerfo[Ord(so_btinfos_hint)];   {' Show infos of the song '}
    btinfos.Caption := lang_songplayerfo[Ord(so_btinfos)];        {'Info'}

    button2.hint := lang_songplayerfo[Ord(so_button2_hint)];      {' Detect BMP from current position and set it to Drums tempo. '}

    btnStop.hint := lang_commanderfo[Ord(co_btnStop_hint)];       {' Stop player '}

    btnResume.hint := lang_songplayerfo[Ord(so_btnResume_hint)];  {' Resume player '}

    btnStart.hint := lang_songplayerfo[Ord(so_btnStart_hint)];    {' Load from cue and Start player '}

    BtnCue.hint := lang_songplayerfo[Ord(so_BtnCue_hint)];        {' Load from cue and Pause player '}

    btnPause.hint := lang_commanderfo[Ord(co_btnPause_hint)];     {' Pause player '}

    tbutton6.hint := lang_songplayerfo[Ord(so_tbutton6_hint)];    {' Choose a  wav, ogg, flac or mp3 audio file '}

    lposition.hint := lang_songplayerfo[Ord(so_lposition_hint)];  {' Position of sound '}

    llength.hint := lang_songplayerfo[Ord(so_llength_hint)];      {' Length of sound '}

    cbloopb.hint       := lang_songplayerfo[Ord(so_cbloopb_hint)];  {' Enable looping the song. (Pause is not enabled with loop.) '}
    setmono.hint       := lang_songplayerfo[Ord(so_setmono_hint)];  {'Mono/Stereo'}
    waveformcheck.hint := lang_songplayerfo[Ord(so_waveformcheck_hint)];  {' Show wave form in slider '}

    playreverse.hint := lang_songplayerfo[Ord(so_playreverse_hint)];  {' Enable playing reverse.'}

    cbloopb.hint := lang_songplayerfo[Ord(so_cbloopb_hint)];       {' Enable looping the song. (Pause is not enabled with loop.) '}

    cbtempo.hint := lang_songplayerfo[Ord(so_cbtempo_hint)];      {' Enable stretching (changing tempo) '}

    playreverseb.hint   := lang_songplayerfo[Ord(so_playreverse_hint)];  {' Enable playing reverse.'}
    waveformcheckb.hint := lang_songplayerfo[Ord(so_waveformcheck_hint)];  {' Show wave form in slider '}
    setmonob.hint       := lang_songplayerfo[Ord(so_setmono_hint)];  {' Set Mono-Stereo '}
    //   cbtempob.hint       := lang_songplayerfo[Ord(so_cbtempo_hint)];  {' Enable stretching (changing tempo) '}
    hintlabel.Caption   := lang_commanderfo[Ord(co_hintlabel)];   {'Invalid value.  Reset to 100.'}

    hintlabel2.Caption := lang_commanderfo[Ord(co_hintlabel2)];   {'Or press Esc key for previous value.'}

  end;

  with guitarsfo do
    Caption := lang_randomnotefo[Ord(ra_tbutton5)];

  with commanderfo do
  begin

    frame.grip_hint := lang_commanderfo[Ord(co_commanderfogriphint)];  {'Use that grip panel to drag/drop the window.'}

    Caption := lang_commanderfo[Ord(co_commanderfo)];    {'Commander'}

    loop_start.hint := lang_commanderfo[Ord(co_loop_start_hint)];  {'Start Drums'}

    loop_stop.hint := lang_commanderfo[Ord(co_loop_stop_hint)];  {'Pause Drums'}

    loop_resume.hint := lang_commanderfo[Ord(co_loop_resume_hint)];  {'Resume Drums'}

    tslider2.hint := lang_commanderfo[Ord(co_tslider2_hint)];  {'General Volume of drums'}

    namedrums.hint := lang_commanderfo[Ord(co_namedrums_hint)];  {'Drums set'}

    tslider2val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    tslider3.hint := lang_commanderfo[Ord(co_tslider3_hint)];  {'Volume of input (mic or input)'}

    nameinput.hint := lang_commanderfo[Ord(co_nameinput_hint)];  {'Input (mic or aux in)'}

    butinput.hint := lang_commanderfo[Ord(co_butinput_hint)];  {'Enable Live Input'}

    tslider3val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    genvolright.hint := lang_commanderfo[Ord(co_genvolright_hint)];  {'Right Volume General in %'}

    genvolleft.hint := lang_commanderfo[Ord(co_genvolleft_hint)];  {'Left Volume General in %'}

    genleftvolvalue.hint := lang_commanderfo[Ord(co_genleftvolvalue_hint)];  {'General left volume. Click to reset to 100%.'}

    genrightvolvalue.hint := lang_commanderfo[Ord(co_genrightvolvalue_hint)];  {'General right volume. Click to reset to 100%.'}

    linkvolgenb.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Lock left and right volume General'}

    namegen.hint := lang_commanderfo[Ord(co_namegen_hint)];  {'General Volume in %'}

    sysvol.hint := lang_commanderfo[Ord(co_sysvol_hint)];  {'System Master Volume'}

    sysvolbut.hint := lang_commanderfo[Ord(co_sysvol_hint)];  {'System Master Volume'}

    timemix.hint := lang_commanderfo[Ord(co_timemix_hint)];  {'Change mixing time in 1/100 second'}

    btnStop.hint := lang_commanderfo[Ord(co_btnStop_hint)];  {'Stop player'}

    btnResume.hint := lang_songplayerfo[Ord(so_btnResume_hint)];  {'Resume player'}

    btnStart.hint := lang_commanderfo[Ord(co_btnStart_hint)];  {'Load and Start Player'}

    volumeleft1.hint := lang_commanderfo[Ord(co_volumeleft1_hint)];  {'Left Volume Player 1'}

    volumeright1.hint := lang_commanderfo[Ord(co_volumeright1_hint)];  {'Right Volume Player 1'}

    tbutton2.hint := lang_commanderfo[Ord(co_tbutton2_hint)];  {'Start Player 1 --> MIX --> Stop Player 2'}

    tbutton3.hint := lang_commanderfo[Ord(co_tbutton3_hint)];  {'Start Player 2 --> MIX --> Stop Player 1'}

    volumeright2.hint := lang_commanderfo[Ord(co_volumeright2_hint)];  {'Right Volume Player 2'}

    volumeleft2.hint := lang_commanderfo[Ord(co_volumeleft2_hint)];  {'Left Volume Player 2'}

    btncue.hint := lang_commanderfo[Ord(co_btncue_hint)];  {'Cue-Load-Pause Player'}

    btnStart2.hint := lang_commanderfo[Ord(co_btnStart_hint)];  {'Load and Start Player'}

    btncue2.hint := lang_commanderfo[Ord(co_btncue_hint)];  {'Cue-Load-Pause Player'}

    btnStop2.hint := lang_commanderfo[Ord(co_btnStop_hint)];  {'Stop player'}

    btnResume2.hint := lang_songplayerfo[Ord(so_btnResume_hint)];  {'Resume player'}

    volumeleft1val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    volumeright1val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    volumeright2val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    volumeleft2val.hint := lang_commanderfo[Ord(co_tslider2val_hint)];  {'Click to switch to 100% <> 0% '}

    btnPause.hint := lang_commanderfo[Ord(co_btnPause_hint)];  {'Pause player'}

    btnPause2.hint := lang_commanderfo[Ord(co_btnPause_hint)];  {'Pause player'}

    tbutton5.hint := lang_commanderfo[Ord(co_tbutton5_hint)];  {'Pause Mixing'}

    tbutton6.hint := lang_commanderfo[Ord(co_tbutton5_hint)];  {'Pause Mixing'}

    tbutton4.hint := lang_commanderfo[Ord(co_tbutton5_hint)];  {'Pause Mixing'}

    linkvolb.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Lock left and right volume Player 1'}

    linkvol2b.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Lock left and right volume Player 2'}

    speccalcb.hint := lang_commanderfo[Ord(co_speccalcb_hint)];  {'Enable Spectrum Frequencies Calculation'}

    guimixb.hint := lang_commanderfo[Ord(co_guimixb_hint)];  {'Graphic-anim while mixing (if cpu too low set it off)'}

    vuinb.hint := lang_commanderfo[Ord(co_vuinb_hint)];  {'View Meters on/off'}

    automixb.hint := lang_commanderfo[Ord(co_automixb_hint)];  {'Auto Mixing on/off'}

    directmixb.hint := lang_commanderfo[Ord(co_directmixb_hint)];  {'Direct MIX (0 second time)'}

    nameplayers.hint := lang_commanderfo[Ord(co_nameplayers_hint)];  {'Player 1'}

    nameplayers2.hint := lang_commanderfo[Ord(co_nameplayers2_hint)];  {'Player 2'}

    directmix.hint := lang_commanderfo[Ord(co_directmixb_hint)];  {'Direct MIX (0 second time)'}

    vuin.hint := lang_commanderfo[Ord(co_vuinb_hint)];   {'View Meters on/off'}

    automix.hint := lang_commanderfo[Ord(co_automixb_hint)];  {'Auto Mixing on/off'}

    speccalc.hint := lang_commanderfo[Ord(co_speccalcb_hint)];  {'Enable Spectrum Frequencies Calculation'}

    guimix.hint := lang_commanderfo[Ord(co_guimixb_hint)];  {'Graphic-anim while mixing (if cpu too low set it off)'}

    linkvol2.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Lock left and right volume Player'}

    linkvol.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Lock left and right volume Player'}

    linkvolgen.hint := lang_commanderfo[Ord(co_linkvol_hint)];  {'Link left and right volume general'}

    randommix.hint := lang_commanderfo[Ord(co_brandommix_hint)];

    Brandommix.hint := lang_commanderfo[Ord(co_Brandommix_hint)];  {'Randomize mixing list'}

    hintlabel.Caption := lang_commanderfo[Ord(co_hintlabel)];      {'Invalid value.  Reset to 100.'}

    hintlabel2.Caption := lang_commanderfo[Ord(co_hintlabel2)];    {'Or press Esc key for previous value.'}

  end;

  with equalizerfo1 do
  begin
    Caption         := lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];
    EQEN.frame.Caption := lang_mainfo[Ord(ma_equalizer)] + ' 1 ';
    loadset.hint    := lang_equalizerfo[Ord(eq_loadset_hint)];  {' Load a Settings file  '}
    loadset.Caption := lang_filelistfo[Ord(fi_tbutton3)];       {'Load'}
    saveset.hint    := lang_equalizerfo[Ord(eq_saveset_hint)];  {' Save Settings in a file '}
    saveset.Caption := lang_stockcaption[Ord(sc_save)];         {'Save'}
  end;

  with equalizerfo2 do
  begin
    Caption         := lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];
    EQEN.frame.Caption := lang_mainfo[Ord(ma_equalizer)] + ' 2 ';
    //tstringdisp21.Width := EQEN.Width + 2;
    //groupbox2.frame.Caption := lang_equalizerfo[Ord(eq_groupbox2frame)];  {'right '}
    //tbutton11.hint := lang_equalizerfo[Ord(eq_tbutton11_hint)];  {' Reset to 0 gain '}
    loadset.hint    := lang_equalizerfo[Ord(eq_loadset_hint)];  {' Load a Settings file  '}
    loadset.Caption := lang_filelistfo[Ord(fi_tbutton3)];  {'Load'}
    saveset.hint    := lang_equalizerfo[Ord(eq_saveset_hint)];  {' Save Settings in a file '}
    saveset.Caption := lang_stockcaption[Ord(sc_save)];   {'Save'}
    //groupbox1.frame.Caption := lang_equalizerfo[Ord(eq_groupbox1frame)];  {'left'}
    //tstringdisp21.hint := lang_equalizerfo[Ord(eq_tstringdisp21_hint)];  {'Ebable Equalizer'}
  end;

  with equalizerforec do
  begin
    Caption := lang_mainfo[Ord(ma_equalizer)] + ' ' + lang_mainfo[Ord(ma_recorder)];
    EQEN.frame.Caption := lang_mainfo[Ord(ma_equalizer)] + ' Rec ';

    //tstringdisp21.Width := EQEN.Width + 2;
    //groupbox2.frame.Caption := lang_equalizerfo[Ord(eq_groupbox2frame)];  {'right '}
    //tbutton11.hint := lang_equalizerfo[Ord(eq_tbutton11_hint)];  {' Reset to 0 gain '}
    loadset.hint    := lang_equalizerfo[Ord(eq_loadset_hint)];  {' Load a Settings file  '}
    loadset.Caption := lang_filelistfo[Ord(fi_tbutton3)];  {'Load'}
    saveset.hint    := lang_equalizerfo[Ord(eq_saveset_hint)];  {' Save Settings in a file '}
    saveset.Caption := lang_stockcaption[Ord(sc_save)];   {'Save'}
    //groupbox1.frame.Caption := lang_equalizerfo[Ord(eq_groupbox1frame)];  {'left'}
    //tstringdisp21.hint := lang_equalizerfo[Ord(eq_tstringdisp21_hint)];  {'Ebable Equalizer'}
  end;


  with spectrum1fo do
  begin
    Caption := lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

    Spect1.frame.Caption := Caption;
    //tstringdisp2.Width   := Spect1.Width + 2;

    // groupbox2.frame.Caption := lang_equalizerfo[Ord(eq_groupbox2frame)];   {'right'}
    tchartright.hint := lang_spectrum1fo[Ord(sp_tchartright_hint)];  {' Right Frequency spectrum '}

    // groupbox1.frame.Caption := lang_equalizerfo[Ord(eq_groupbox1frame)];   {'left'}

    tchartleft.hint := lang_spectrum1fo[Ord(sp_tchartleft_hint)];          {' Left Frequency spectrum '}

    //tstringdisp2.hint := lang_spectrum1fo[Ord(sp_tstringdisp2_hint)];      {'Enable Spectrum'}

  end;

  with spectrum2fo do
  begin
    Caption := lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

    Spect1.frame.Caption := Caption;
    //tstringdisp2.Width   := Spect1.Width + 2;

    // groupbox2.frame.Caption := lang_equalizerfo[Ord(eq_groupbox2frame)];   {'right'}
    tchartright.hint := lang_spectrum1fo[Ord(sp_tchartright_hint)];  {' Right Frequency spectrum '}

    //   groupbox1.frame.Caption := lang_equalizerfo[Ord(eq_groupbox1frame)];   {'left'}

    tchartleft.hint := lang_spectrum1fo[Ord(sp_tchartleft_hint)];          {' Left Frequency spectrum '}

    //tstringdisp2.hint := lang_spectrum1fo[Ord(sp_tstringdisp2_hint)];      {'Enable Spectrum'}

  end;

  with spectrumrecfo do
  begin
    Caption := lang_spectrum1fo[Ord(sp_spectrum1fo)] + ' ' + lang_mainfo[Ord(ma_recorder)];

    Spect1.frame.Caption := Caption;
    //tstringdisp2.Width   := Spect1.Width + 2;

    //   groupbox2.frame.Caption := lang_equalizerfo[Ord(eq_groupbox2frame)];   {'right'}
    tchartright.hint := lang_spectrum1fo[Ord(sp_tchartright_hint)];  {' Right Frequency spectrum '}

    //    groupbox1.frame.Caption := lang_equalizerfo[Ord(eq_groupbox1frame)];   {'left'}

    tchartleft.hint := lang_spectrum1fo[Ord(sp_tchartleft_hint)];          {' Left Frequency spectrum '}

    //tstringdisp2.hint := lang_spectrum1fo[Ord(sp_tstringdisp2_hint)];      {'Enable Spectrum'}

  end;

  with wavefo do
    Caption := lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers_hint)];

  with wavefo2 do
    Caption := lang_mainfo[Ord(ma_waveform)] + ' ' + lang_commanderfo[Ord(co_nameplayers2_hint)];

  with waveforec do
    Caption := lang_mainfo[Ord(ma_waveform)] + ' ' + lang_mainfo[Ord(ma_recorder)];

  with filelistfo do
  begin
    filelistfo.frame.grip_hint := lang_filelistfo[Ord(fi_filelistfoframegriphint)];  {' Use this grip panel to drag/drop the window'}

    //  filelistfo.dragdock.caption := lang_filelistfo[Ord(fi_filelistfo)];  {'Files'}

    filelistfo.Caption := lang_filelistfo[Ord(fi_filelistfo)];  {'Audio files'}

    //filescount.hint := lang_filelistfo[Ord(fi_filescount_hint)];  {'Number of files in the list'}

    tbutton11.hint := lang_filelistfo[Ord(fi_tbutton11_hint)];  {'Find a word in list'}

    tbutton1.hint := lang_filelistfo[Ord(fi_tbutton1_hint)];  {'Sent selected song to cue for Player 1'}

    tbutton2.hint := lang_filelistfo[Ord(fi_tbutton2_hint)];  {'Sent selected song to cue for Player 2'}

    list_files.hint := lang_filelistfo[Ord(fi_list_files_hint)];  {'To move a row: click+hold into the fixed column and drag the row where you want.'}

    list_files.fixrows[-1].captions[0].Caption := lang_filelistfo[Ord(fi_list_files_name)];  {'Name of sound'}
    list_files.fixrows[-1].captions[1].Caption := lang_filelistfo[Ord(fi_list_files_ext)];  {'Ext'}
    list_files.fixrows[-1].captions[1].hint    := lang_filelistfo[Ord(fi_list_files_ext_hint)];  {'File extension'}
    list_files.fixrows[-1].captions[2].Caption := lang_filelistfo[Ord(fi_list_files_size)];  {'Size'}
    list_files.fixrows[-1].captions[2].hint    := lang_filelistfo[Ord(fi_list_files_size_hint)];  {'Size in Kb of the file'}
    list_files.fixrows[-1].captions[3].hint    := lang_filelistfo[Ord(fi_list_files_mix_hint)];  {'Include for mix.  Clicking on the fixed cell ---> select all/none.'}

    tbutton3.hint := lang_filelistfo[Ord(fi_tbutton3_hint)];  {'Load custom play-list'}

    tbutton4.hint := lang_filelistfo[Ord(fi_tbutton4_hint)];  {'Save custom play-list'}

    tbutton5.hint := lang_filelistfo[Ord(fi_tbutton5_hint)];  {'Add file in custom play-list'}

    historyfn.hint := lang_filelistfo[Ord(fi_historyfn_hint)];  {'History of Directories'}

    tbutton6.hint := lang_filelistfo[Ord(fi_tbutton6_hint)];  {'Choose a audio directory with wav, ogg, flac or mp3'}
  end;


  with drumsfo do
  begin

    frame.grip_hint := lang_filelistfo[Ord(fi_filelistfoframegriphint)];  {' Use that grip panel to drag/drop Drums form. '}

    Caption := lang_commanderfo[Ord(co_namedrums_hint)];  {' Drums '}

    tstringdisp2.Value := Caption;

    tdockpanel1.hint := lang_commanderfo[Ord(co_namedrums_hint)];  {' Drums set '}

    labd.Caption := lang_drumsfo[Ord(dr_labd)];      {'Bass'}

    lasd.Caption := lang_drumsfo[Ord(dr_lasd)];      {'Snare'}

    laoh.Caption := lang_drumsfo[Ord(dr_laoh)];      {'Open H'}

    lach.Caption := lang_drumsfo[Ord(dr_lach)];      {'Close H'}

    labpat.Caption := lang_drumsfo[Ord(dr_labpat)];  {'Patern 1'}

    tbooleaneditradio8.hint := lang_drumsfo[Ord(dr_tbooleaneditradio8_hint)];  {' Drums Patern 1 '}
    tbooleaneditradio7.hint := lang_drumsfo[Ord(dr_tbooleaneditradio7_hint)];  {' Drums Patern 2 '}
    tbooleaneditradio6.hint := lang_drumsfo[Ord(dr_tbooleaneditradio6_hint)];  {' Drums Patern 3 '}
    tbooleaneditradio5.hint := lang_drumsfo[Ord(dr_tbooleaneditradio5_hint)];  {' Drums Patern 4 '}

    str          := lang_drumsfo[Ord(dr_lesson4_hint)];
    str          := trim(StringReplace(str, '.', '.' + lineend, [rfReplaceAll]));
    lesson4.hint := str;

    // lesson4.hint := lang_drumsfo[Ord(dr_lesson4_hint)];  {'Last lesson. Do the same as 3th lesson but increasing the tempo. On count "2" you may add a "boom" on the Bass Drum. Congratulation, you are a drummer now. ;-) '}

    str          := lang_drumsfo[Ord(dr_lesson3_hint)];
    str          := trim(StringReplace(str, '.', '.' + lineend, [rfReplaceAll]));
    lesson3.hint := str;

    //  lesson3.hint := lang_drumsfo[Ord(dr_lesson3_hint)];  {' 3th lesson Do the same as second lesson and on count "3" add a "clack" on the Snare Drum. This is the most difficult. Still count loud with your voice. '}
    str          := lang_drumsfo[Ord(dr_lesson2_hint)];
    str          := trim(StringReplace(str, '.', '.' + lineend, [rfReplaceAll]));
    lesson2.hint := str;

    //    lesson2.hint := lang_drumsfo[Ord(dr_lesson2_hint)];  {' Second lesson. Do the same as first lesson and on count "1" add a "boom" with your right foot on the Bass Drum. Still count loud with your voice. '}

    str          := lang_drumsfo[Ord(dr_lesson1_hint)];
    str          := trim(StringReplace(str, '.', '.' + lineend, [rfReplaceAll]));
    lesson1.hint := str;

    //    lesson1.hint := lang_drumsfo[Ord(dr_lesson1_hint)];  {' First lesson. With the stick hit the closed hat on each count. Count loud with your voice too. '}
    tlabel22.Caption     := lang_drumsfo[Ord(dr_tlabel22)];  {'Patern'}
    tlabel21.Caption     := lang_drumsfo[Ord(dr_tlabel21)];  {'Lesson'}
    noanim.frame.Caption := lang_drumsfo[Ord(dr_noanim)];  {'no anim'}
    noanim.hint          := lang_drumsfo[Ord(dr_noanim_hint)];  {' No graphic animation. '}
    noand.frame.Caption  := lang_drumsfo[Ord(dr_noand)];  {'no "and"'}
    noand.hint           := lang_drumsfo[Ord(dr_noand_hint)];  {' No "and" between 2 numbers. '}
    novoice.frame.Caption := lang_drumsfo[Ord(dr_novoice)];  {'no voice'}
    novoice.hint         := lang_drumsfo[Ord(dr_novoice_hint)];  {' No counting voice '}
    nodrums.frame.Caption := lang_drumsfo[Ord(dr_nodrums)];  {'no drums'}
    nodrums.hint         := lang_drumsfo[Ord(dr_nodrums_hint)];  {' No drums sound.  '}
    loop_stop.hint       := lang_drumsfo[Ord(dr_loop_stop_hint)];  {' Stop loop '}
    loop_resume.hint     := lang_drumsfo[Ord(dr_loop_resume_hint)];  {' Resume loop '}
    loop_start.hint      := lang_drumsfo[Ord(dr_loop_start_hint)];  {' Start loop '}
    edittempo.hint       := lang_drumsfo[Ord(dr_edittempo_hint)];  {'BPM (Beats per minut)'}
    tlabel23.Caption     := lang_drumsfo[Ord(dr_tlabel23)];  {'Volume'}
    volumedrums.hint     := lang_drumsfo[Ord(dr_volumedrums_hint)];  {' General volume of Drums '}
    ltempo.hint          := lang_drumsfo[Ord(dr_ltempo_hint)];  {' Beats per minuts - interval in 1/10000 second. '}

    tstringdisp2.hint := lang_commanderfo[Ord(co_namedrums_hint)];  {' Drums set '}

    multbpm.hint := lang_drumsfo[Ord(dr_multbpm_hint)];  {' Set BPM X 2 '}
    divbpm.hint  := lang_drumsfo[Ord(dr_divbpm_hint)];  {' Set BPM / 2 '}

    langcount.frame.Caption := lang_drumsfo[Ord(dr_langcount)];  {'Lang'}
    langcount.hint          := lang_drumsfo[Ord(dr_langcount_hint)];  {'Language for counting'}

  end;


  with randomnotefo do
  begin
    Caption := lang_randomnotefo[Ord(ra_randomnotefo)];  {'Chord Randomizer'}

    guitpb1.hint := lang_randomnotefo[Ord(ra_timage8_hint)];  {'Click to listen to the guitar chord'}

    keyb1pb.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse1_1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse1_2.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse1_3.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    guitpb1.hint := lang_randomnotefo[Ord(ra_timage8_hint)];  {'Click to listen to the guitar chord'}

    keyb2pb.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse2_1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse2_2.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse2_3.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    keyb3pb.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];   {'Click to listen to piano chord'}

    elipse3_1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse3_2.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse3_3.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    chord1drop.hint := lang_randomnotefo[Ord(ra_chord1drop_hint)];  {'Select a chord'}

    chord2drop.hint := lang_randomnotefo[Ord(ra_chord1drop_hint)];  {'Select a chord'}

    chord3drop.hint := lang_randomnotefo[Ord(ra_chord1drop_hint)];  {'Select a chord'}

    tbutton4.hint := lang_randomnotefo[Ord(ra_tbutton4_hint)];  {'Close all StrumPract (Click the icon in corner of the form to close only Randomizer)'}

    bnbchords.hint    := lang_randomnotefo[Ord(ra_bnbchords_hint)];  {'Randomize chords'}
    bnbchords.Caption := lang_randomnotefo[Ord(ra_bnbchords)];  {'Randomize'}

    btnfixed.hint    := lang_randomnotefo[Ord(ra_btnfixed_hint)];  {'Manual fixed chords'}
    btnfixed.Caption := lang_randomnotefo[Ord(ra_btnfixed)];  {'Fixed'}

    tbutton5.hint    := lang_randomnotefo[Ord(ra_tbutton5_hint)];  {' Tuned guitar string '}
    tbutton5.Caption := lang_randomnotefo[Ord(ra_tbutton5)];  {'Tuned Guitars'}


    keyb4pb.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse4_1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse4_2.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse4_3.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    guitpb1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to the guitar chord'}

    chord5drop.hint := lang_randomnotefo[Ord(ra_chord1drop_hint)];  {'Select a chord'}

    keyb5pb.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse5_1.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse5_2.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    elipse5_3.hint := lang_randomnotefo[Ord(ra_keyb1_hint)];  {'Click to listen to piano chord'}

    guitpb1.hint := lang_randomnotefo[Ord(ra_timage8_hint)];  {'Click to listen to the guitar chord'}

    bchord1.hint     := lang_randomnotefo[Ord(ra_bchord1_hint)];  {'Re-do a randomizer for chord 1'}
    bchord5.hint     := lang_randomnotefo[Ord(ra_bchord1_hint)];  {'Re-do a randomizer for chord 5'}
    bchord4.hint     := lang_randomnotefo[Ord(ra_bchord1_hint)]; {'Re-do a randomizer for chord 4'}
    bchord3.hint     := lang_randomnotefo[Ord(ra_bchord1_hint)];  {'Re-do a randomizer for chord 3'}
    bchord2.hint     := lang_randomnotefo[Ord(ra_bchord1_hint)];  {'Re-do a randomizer for chord 2'}
    tbutton2.hint    := lang_randomnotefo[Ord(ra_tbutton2_hint)];  {'Clear chords'}
    tbutton2.Caption := lang_randomnotefo[Ord(ra_tbutton2_hint)];  {'Clear'}

    tbutton3.hint    := lang_randomnotefo[Ord(ra_nodrumsframe)];  {'Show drums set'}
    tbutton3.Caption := lang_commanderfo[Ord(co_namedrums_hint)];  {'Drums'}

    tgroupbox1.frame.Caption := lang_randomnotefo[Ord(ra_tgroupbox1frame)];  {'Chords'}

    bool7th.frame.Caption := lang_randomnotefo[Ord(ra_bool7th)];  {' 7th'}
    bool7th.hint          := lang_randomnotefo[Ord(ra_bool7th_hint)];  {'Enable 7th Chords'}

    boolminor.frame.Caption := lang_randomnotefo[Ord(ra_boolminorframe)];  {' minor'}
    boolminor.hint          := lang_randomnotefo[Ord(ra_boolminor_hint)];  {'Enable minor Chords'}

    boolmajor.frame.Caption := lang_randomnotefo[Ord(ra_boolmajorframe)];  {' Major'}
    boolmajor.hint          := lang_randomnotefo[Ord(ra_boolmajor_hint)];  {'Enable Major Chords'}

    bool9th.frame.Caption := lang_randomnotefo[Ord(ra_bool9thframe)];  {' 9th'}
    bool9th.hint          := lang_randomnotefo[Ord(ra_bool9th_hint)];  {'Enable 9th Chords'}

    withsharp.frame.Caption := lang_randomnotefo[Ord(ra_withsharpframe)];  {' # (Sharp)'}
    withsharp.hint          := lang_randomnotefo[Ord(ra_withsharp_hint)];  {'Enable Sharp-Chords #'}

    bosound.frame.Caption := lang_randomnotefo[Ord(ra_bosoundframe)];  {' Sound'}
    bosound.hint          := lang_randomnotefo[Ord(ra_bosound_hint)];  {'Enable Sound of Chords'}

    tgroupbox2.frame.Caption := lang_randomnotefo[Ord(ra_tgroupbox2frame)];  {'Number'}

    numchord.hint := lang_randomnotefo[Ord(ra_numchord_hint)];  {'Total chords'}

    // maxnote.frame.caption := lang_randomnotefo[Ord(ra_maxnoteframe)];  {'Max'}
    maxnote.hint := lang_randomnotefo[Ord(ra_maxnote_hint)];  {'Maximum number of chords'}

    withrandom.frame.Caption := lang_randomnotefo[Ord(ra_withrandomframe)];  {' Random num'}
    withrandom.hint          := lang_randomnotefo[Ord(ra_withrandom_hint)];  {'Randomize the number of chords'}

    tgroupbox3.frame.Caption := lang_commanderfo[Ord(co_namedrums_hint)]; {'Drums'}

    bpm.hint := lang_randomnotefo[Ord(ra_bpm_hint)];  {'Tempo of Drums in BPM'}

    nodrums.frame.Caption := lang_randomnotefo[Ord(ra_nodrumsframe)];  {' Enable Drums'}
    nodrums.hint          := lang_randomnotefo[Ord(ra_nodrums_hint)];  {'Enable random Drums tempo'}

    bconfig.hint := lang_randomnotefo[Ord(ra_bconfig_hint)];  {'Configure the "Clear" message'}
    //timage3.hint := lang_randomnotefo[Ord(ra_timage8_hint)];  {'Click to listen to the guitar chord'}

  end;

end;

procedure tmainfo.ontimeract(const Sender: TObject);
begin
  if randomnotefo.Visible = False then
    activate;
end;

procedure tmainfo.ontimerwait(const Sender: TObject);
var
  children1: widgetarty;
  i1, visiblecount: int32;
  rect1: rectty;
begin

  if (basedock.dragdock.currentsplitdir = sd_horz) or (basedock.dragdock.currentsplitdir = sd_horz) then
    if Visible and (oktimer = 0) then
    begin

      children1    := basedock.dragdock.getitems();
      visiblecount := 0;

      // writeln('Number of childs: ' + inttostr(high(children1)));

      for i1 := 0 to high(children1) do
        with children1[i1] do
          if Visible then
            Inc(visiblecount); //  writeln('Child visible: ' + inttostr(i1));

      if (visiblecount = 0) then
      begin
        //  writeln('No Child visible.');
        resizema(fontheightused);
        Width           := fowidth;
        Height          := emptyheight + 20;
        application.ProcessMessages;
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

      if not fileexists(tstatfile1.filename) then
        top := 30;

      hasinit := 1;

      rect1 := application.screenrect(window);

      maxheightfo := rect1.cy - 70;

      if (fs_sbverton in container.frame.state) then
        Width := fowidth + scrollwidth//  writeln('Has scrollwidth');
      else
        Width := fowidth// writeln('Has NO scrollwidth');
      ;

      bounds_cx := Width;

      bounds_cxmax   := bounds_cx;
      bounds_cxmin   := bounds_cx;
      basedock.Width := Width;

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

    end;
 end;

procedure tmainfo.oncreateform(const Sender: TObject);
var
  rect1: rectty;
  ordir: msestring;
begin

{$if defined(netbsd) or defined(darwin)}
   vievmenuicons.options := [bmo_masked]; 
   buttonicons.options := [bmo_masked]; 
{$endif}

{$if defined(nofade)}
  // tfaceplayer.template.fade_color.count := 1;
  //tfaceplayerbut.template.fade_color.count := 1;

  tfacebutgray.template.fade_color.Count   := 1;
  tfacebutltgray.template.fade_color.Count := 1;

  tfacegreen.template.fade_color.Count  := 1;
  tfaceorange.template.fade_color.Count := 1;
  tfacered.template.fade_color.Count    := 1;

  //btfaceplayerlight.template.fade_color.count := 1;
  //tfaceplayerrev.template.fade_color.count := 1;

{$endif}

 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
  windowopacity := 0;
 {$endif}

  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  Visible     := False;
  flayoutlock := 0;

  rect1 := application.screenrect(window);

  maxheightfo := rect1.cy - 70;
  // for x := 0 to 4 do tmainmenu1.menu.items[x].visible := false;

{$ifdef mswindows}
  statdirname := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'ini');
{$endif}

  ordir := filepath(statdirname);

  if not finddir(ordir) then
    createdir(ordir);

  //tstatfile1.filename := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
  //  'ini' + directoryseparator + 'stat.ini');

  tstatfile1.filename := msestring(ordir + directoryseparator + 'stat.ini');

  Timerwait          := ttimer.Create(nil);
  Timerwait.interval := 400000;
  Timerwait.Enabled  := False;
  Timerwait.options  := [to_single];
  Timerwait.ontimer  := @ontimerwait;

  Timeract          := ttimer.Create(nil);
  Timeract.interval := 500000;
  Timeract.Enabled  := False;
  Timeract.options  := [to_single];
  Timeract.ontimer  := @ontimeract;
end;

procedure tmainfo.onabout(const Sender: TObject);
begin
  aboutfo.Caption          := lang_mainfo[Ord(ma_tmainmenu1_about_hint)];
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value := c_linefeed + 'StrumPract ' + versiontext + ' ' + platformtext +
    c_linefeed +
    'https://github.com/fredvs/strumpract/releases/' + c_linefeed +
    c_linefeed + 'Compiler: FPC 3.2.2.' +
    c_linefeed + 'http://www.freepascal.org' + c_linefeed + c_linefeed +
    'Graphic widget: MSEgui ' + mseguiversiontext +
    '.' + c_linefeed + 'https://github.com/mse-org/mseide-msegui' +
    c_linefeed + c_linefeed +
    'Graphic library: BGRABitmap v11.5.8.' + c_linefeed +
    'https://github.com/bgrabitmap/bgrabitmap' + c_linefeed + c_linefeed +
    'Audio library: uos 1.8.0.' + c_linefeed +
    'https://github.com/fredvs/uos' + c_linefeed + c_linefeed +
    '© 2017-2024' + c_linefeed +
    'Fred van Stappen <fiens@hotmail.com>';
  aboutfo.Show(True);
end;

procedure tmainfo.dodestroy(const Sender: TObject);
begin
  Timerwait.Enabled := False;
  Timeract.Enabled  := False;
  Timerwait.Free;
  Timeract.Free;
  //   {$if not defined(darwin)}
  statusanim        := 0;
  //    {$endif}

  // ordir      := msestring(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));
  ordir := filepath(statdirname);

  filelistfo.tstatfile1.writestat(ordir + directoryseparator + 'list.ini');

  // application.ProcessMessages;
  // uos_free();

end;

procedure tmainfo.oncreatedform(const Sender: TObject);
var
  x: integer;
  haswav: Boolean = False;
 {$IFDEF unix}
 bo : boolean;
gl_Handle:TLibHandle=dynlibs.NilHandle;
{$ENDIF}
begin
{$IF DEFined(unix)}
  gl_Handle := DynLibs.SafeLoadLibrary('libGL.so.1'); 
  // check if gl is installed
  if gl_Handle  <> DynLibs.NilHandle then bo := true
  else bo := false;
  if bo then DynLibs.UnloadLibrary(gl_Handle) else
  begin
  tmainmenu1.menu.itembynames(['dancer','square']).visible := false;
  tmainmenu1.menu.itembynames(['dancer','triangle']).visible := false;
  tmainmenu1.menu.itembynames(['dancer','lines']).visible := false;
  end;
{$ENDIF}

  //  resizema(fontheightused);

  Caption := 'StrumPract ' + versiontext;

  //setlangstrumpract('fr');

  beginlayout();

  oktimer := 1;

  commanderfo.guimix.Value := False;

  if not fileexists(tstatfile1.filename) then
  begin
    {$if defined(cpuarm) or defined(cpuaarch64)}
    configfo.latdrums.Value := 0.08;
    configfo.latplay.Value  := 0.3;
    configfo.latrec.Value   := 0.3;
    
    with songplayerfo do
    begin
      waveformcheck.Value         := False;
      waveformcheck.tag           := 0;
      waveformcheck.face.template := mainfo.tfacebutgray;
    end;

    with songplayer2fo do
    begin
      waveformcheck.Value         := False;
      waveformcheck.tag           := 0;
      waveformcheck.face.template := mainfo.tfacebutgray;
    end;
    {$endif}

    typecolor.Value := 2;
    ondockplayersx2(Sender);

    oktimer := 1;
  end;

  if (filelistfo.Visible) then
    if (filelistfo.parentwidget = nil) then
    begin
      filelistfo.bounds_cxmax := 0;
      filelistfo.bounds_cymax := maxheightfo;
    end
    else
    begin
      filelistfo.bounds_cxmax := fowidth;
      filelistfo.bounds_cymax := filelistfoheight;
      filelistfo.Width        := fowidth;
      filelistfo.Height       := filelistfoheight;
    end;

  if (wavefo.Visible) then
    if (wavefo.parentwidget = nil) then
    begin
      wavefo.bounds_cxmax := 0;
      wavefo.bounds_cymax := 0;
    end
    else
    begin
      wavefo.bounds_cxmax := fowidth;
      wavefo.bounds_cymax := wavefoheight;
      wavefo.Width        := fowidth;
      wavefo.Height       := wavefoheight;
      if haswav = False then
        Height := Height + 10;
      haswav := True;
    end;

  if (wavefo2.Visible) then
    if (wavefo2.parentwidget = nil) then
    begin
      wavefo2.bounds_cxmax := 0;
      wavefo2.bounds_cymax := 0;
    end
    else
    begin
      if haswav = False then
        Height       := Height + 10;
      haswav         := True;
      wavefo2.bounds_cxmax := fowidth;
      wavefo2.bounds_cymax := wavefoheight;
      wavefo2.Width  := fowidth;
      wavefo2.Height := wavefoheight;
    end;

  if (waveforec.Visible) then
    if (waveforec.parentwidget = nil) then
    begin
      waveforec.bounds_cxmax := 0;
      waveforec.bounds_cymax := 0;
    end
    else
    begin
      if haswav = False then
        Height         := Height + 10;
      haswav           := True;
      waveforec.bounds_cxmax := fowidth;
      waveforec.bounds_cymax := wavefoheight;
      waveforec.Width  := fowidth;
      waveforec.Height := wavefoheight;

    end;

  UOS_GetInfoDevice();

  x := 0;

  while x < UOSDeviceCount do
  begin
    if UOSDeviceInfos[x].DefaultDevOut = True then
      configfo.lsuglat.Caption :=
        msestring('Audio API ' + UOSDeviceInfos[x].HostAPIName +
        ': Suggested latency = ' +
        floattostrf(UOSDeviceInfos[x].LatencyLowOut, ffFixed, 15, 8));
    Inc(x);
  end;


  endlayout();

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

  //   {$if not defined(darwin)}  

  if dancnum.Value = 12 then
  begin
    imagedancerfo.Caption := 'Dancing Fractal Circles by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum := 12;
  end
  else if dancnum.Value = 11 then
  begin
    imagedancerfo.Caption := 'Dancing Turtle 2 by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum := 11;
  end
  else if dancnum.Value = 10 then
  begin
    imagedancerfo.Caption := 'Dancing Turtle 1 by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum := 10;
  end
  else if dancnum.Value = 9 then
  begin
    imagedancerfo.Caption := 'Dancing Lines';
    imagedancerfo.openglwidget.Visible := True;
    //imagedancerfo.tpaintbox1.Visible := False;
    dancernum := 9;
  end
  else if dancnum.Value = 8 then
  begin
    imagedancerfo.Caption := 'Dancing Triangle';
    imagedancerfo.openglwidget.Visible := True;
    //imagedancerfo.tpaintbox1.Visible := False;
    dancernum := 8;
  end
  else if dancnum.Value = 3 then
  begin
    imagedancerfo.Caption := 'Dancing Square';
    imagedancerfo.openglwidget.Visible := True;
    //imagedancerfo.tpaintbox1.Visible := False;
    dancernum := 3;
  end
  else if dancnum.Value = 4 then
  begin
    imagedancerfo.Caption := 'Dancing Atom by Winni';
    dancernum := 4;
    imagedancerfo.openglwidget.Visible := False;
    //imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 5 then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Hue by Winni';
    dancernum := 5;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 6 then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Rainbow by Winni';
    dancernum := 6;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 7 then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Move by Winni';
    dancernum := 7;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 0 then
  begin
    imagedancerfo.Caption := 'Fractal Tree by Lainz';
    dancernum := 0;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 1 then
  begin
    imagedancerfo.Caption := 'Super Formula';
    dancernum := 1;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end
  else if dancnum.Value = 2 then
  begin
    imagedancerfo.Caption := 'Hyper formula';
    dancernum := 2;
    imagedancerfo.openglwidget.Visible := False;
    // imagedancerfo.tpaintbox1.Visible := True;
  end;

  if imagedancerfo.Visible = True then
    multiplier := 0.7;

  //  {$endif}  

  if randomnotefo.Visible = True then
  begin
    randomnotefo.bringtofront;
    randomnotefo.refreshform(Sender);
  end;
  //visible := false;

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

function tmainfo.issomeplaying: Boolean;
var
  x: integer;
  isplay: Boolean = False;
begin
  Result := isplay;
  for x  := 9 to 25 do
    if uos_GetStatus(x) = 1 then
      isplay := True;
  if drumsfo.timertick.Enabled = True then
    isplay   := True;
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
  if (hasinit = 1) and (flayoutlock = 0) then
    updatelayoutstrum();

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

end;

procedure tmainfo.updatelayoutstrum();
var
  maxwidth: int32;
  totheight, totwidth: int32;
  visiblecount: int32;
  children1: widgetarty;
  heights: integerarty;
  widths: integerarty;
  i1: int32;
  si1: sizety;
  w1: twidget;
  rect1: rectty;
  thetitle: string = '';
  thetitlet: string = '';
begin
  if flayoutlock <= 0 then
  begin
    resizema(fontheightused);

    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;

    if (pianofo.parentwidget <> nil) and (pianofo.Visible) then
    begin
      pianofo.bounds_cxmax := fowidth;
      pianofo.bounds_cx    := fowidth;
    end;

    // {$if not defined(darwin)}
    if (imagedancerfo.parentwidget <> nil) and (imagedancerfo.Visible) then
    begin
      imagedancerfo.bounds_cxmax := fowidth;
      imagedancerfo.bounds_cx    := fowidth;
      imagedancerfo.bounds_cymax := imagedancerfo.bounds_cymin;
      imagedancerfo.bounds_cy    := imagedancerfo.bounds_cymin;
    end;
    //  {$endif} 

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
      if basedock.dragdock.activewidget <> nil then
      begin
        i1   := 0;
        repeat
          w1 := basedock.dragdock.activewidget;
          basedock.size := addsize(basedock.size, subsize(w1.size, basedock.dragdock.dockrect.
            size));
          Inc(i1);
        until sizeisequal(w1.size, basedock.dragdock.dockrect.size) or (i1 > 8);
      end;
      si1 := basedock.size;

      container.frame.scrollpos := nullpoint;
      addsize1(si1, sizety(basedock.pos));
      i1 := 0;
      repeat
        container.frame.scrollpos := nullpoint;
        size := addsize(size, subsize(si1, container.paintsize));
        Inc(i1);
      until sizeisequal(container.paintsize, si1) or (i1 > 8);

      Width := fowidth;

      if timerwait.Enabled then
        timerwait.restart // to reset
      else
        timerwait.Enabled := True;

    end
    else if basedock.dragdock.currentsplitdir = sd_horz then
    begin
      children1    := basedock.dragdock.getitems();
      setlength(heights, length(children1));
      visiblecount := 0;
      maxwidth     := 0;
      totheight    := 0;

      container.frame.sbvert.options := [sbo_thumbtrack, sbo_moveauto, sbo_showauto];
      container.frame.sbhorz.options := [];

      for i1 := 0 to high(children1) do
        with children1[i1] do
        begin
          si1         := size;
          heights[i1] := si1.cy;
          if Visible then
          begin

            if i1 = 0 then
              thetitle := tdockform(children1[i1]).dragdock.Caption
            else
              thetitle := thetitle + ' + ' + tdockform(children1[i1]).dragdock.Caption;

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
        si1.cx := basedock.Width;
        //do not change width
        if typecolor.Value = 2 then
        begin
          basedock.color := $474747;
          color          := $474747;
        end
        else if typecolor.Value = 3 then
        begin
          basedock.color := cl_gray;
          color          := cl_gray;
        end
        else
        begin
          basedock.color := cl_gray;
          color          := cl_gray;
        end;

      end
      else
      begin
        si1.cy         := totheight + (visiblecount - 1) * basedock.dragdock.splitter_size;
        basedock.color := cl_gray;
        color          := cl_gray;
      end;

      basedock.size := si1;
      //   writeln('final basedock.width: ' + inttostr(basedock.width));
      //   writeln('final basedock.height: ' + inttostr(basedock.height));
      //   writeln('final basedock.top: ' + inttostr(basedock.top));

      container.frame.scrollpos := nullpoint;
      addsize1(si1, sizety(basedock.pos));
      i1 := 0;
      repeat
        container.frame.scrollpos := nullpoint;
        size := addsize(size, subsize(si1, container.paintsize));
        Inc(i1);
      until sizeisequal(container.paintsize, si1) or (i1 > 8);

      if system.pos('(', Caption) > 0 then
        thetitlet := (system.Copy(Caption, 1, system.pos('(', Caption) - 2))
      else
        thetitlet := (Caption);

      Caption := thetitlet + ' ( ' + thetitle + ' )';

      if timerwait.Enabled then
        timerwait.restart // to reset
      else
        timerwait.Enabled := True;

    end

    else if basedock.dragdock.currentsplitdir = sd_vert then
    begin
      children1    := basedock.dragdock.getitems();
      setlength(widths, length(children1));
      visiblecount := 0;
      maxheightpa  := 0;
      totwidth     := 0;

      container.frame.sbhorz.options := [sbo_thumbtrack, sbo_moveauto, sbo_showauto];
      container.frame.sbvert.options := [];

      //setgrip(8);

      // writeln('Number of childs: ' + inttostr(high(children1)));

      for i1 := 0 to high(children1) do
        with children1[i1] do
        begin
          si1        := size;
          widths[i1] := si1.cx;
          if Visible then
          begin
            if i1 = 0 then
              thetitle    := tdockform(children1[i1]).dragdock.Caption
            else
              thetitle    := thetitle + ' + ' + tdockform(children1[i1]).dragdock.Caption;
            if si1.cy > maxheightpa then
              maxheightpa := si1.cy;
            totwidth := totwidth + si1.cx;
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
      if system.pos('(', Caption) > 0 then
        thetitlet := (system.Copy(Caption, 1, system.pos('(', Caption) - 2))
      else
        thetitlet := (Caption);

      Caption := thetitlet + ' ( ' + thetitle + ' )';

    end;

  end;

end;

procedure tmainfo.updatedockev(const Sender: TObject; const awidget: twidget);
begin
  updatelayoutstrum();
end;

procedure tmainfo.onfloatall(const Sender: TObject);
var
  posi: int32;
  leftdec: integer = 40;
  leftposi: integer;
  topdec: integer = 30;
  ratio: double;
begin
  // basedock.anchors := [an_left,an_top]  ;

  oktimer := 1;

  resizema(fontheightused);
  ratio := fontheightused / 12;

  beginlayout();

  norefresh := True;

  if drumsfo.Visible then
    drumsfo.dragdock.float();

  if guitarsfo.Visible then
    guitarsfo.dragdock.float();

  if pianofo.Visible then
    pianofo.dragdock.float();

  if synthefo.Visible then
    synthefo.dragdock.float();

  if songplayerfo.Visible then
    songplayerfo.dragdock.float();

  if infosdfo.Visible then
    infosdfo.dragdock.float();

  if infosdfo2.Visible then
    infosdfo2.dragdock.float();

  if spectrum1fo.Visible then
    spectrum1fo.dragdock.float();

  // {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.dragdock.float();
  //  {$endif}  

  if spectrum2fo.Visible then
    spectrum2fo.dragdock.float();

  if spectrumrecfo.Visible then
    spectrumrecfo.dragdock.float();

  if equalizerfo1.Visible then
    equalizerfo1.dragdock.float();

  if equalizerfo2.Visible then
    equalizerfo2.dragdock.float();

  if equalizerforec.Visible then
    equalizerforec.dragdock.float();

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

  wavefo2.bounds_cxmax := 0;
  wavefo2.bounds_cymax := 0;

  wavefo.bounds_cxmax := 0;
  wavefo.bounds_cymax := 0;

  waveforec.bounds_cxmax := 0;
  waveforec.bounds_cymax := 0;

  wavefo2.bounds_cx := roundmath(300 * ratio);
  wavefo2.bounds_cy := roundmath(100 * ratio);
  ;

  wavefo.bounds_cx := roundmath(300 * ratio);
  ;
  wavefo.bounds_cy := roundmath(100 * ratio);
  ;

  waveforec.bounds_cx := roundmath(300 * ratio);
  waveforec.bounds_cy := roundmath(100 * ratio);

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 0;

  infosdfo.bounds_cxmax := 0;
  infosdfo.bounds_cymax := 0;

  infosdfo2.bounds_cxmax := 0;
  infosdfo2.bounds_cymax := 0;

  infosdfo.Height := roundmath(226 * ratio);
  ;
  infosdfo.Width  := fowidth;

  infosdfo2.Height := infosdfo.Height;
  infosdfo2.Width  := infosdfo.Width;

  pianofo.bounds_cxmax := 0;

  Height := emptyheight + 20;
  Width  := fowidth;

  left := 0;
  top  := 0;

  endlayout();

  leftposi := 0;

  //    {$if not defined(darwin)}
  if imagedancerfo.Visible then
  begin
    imagedancerfo.left := leftposi + leftdec;
    leftposi           := imagedancerfo.left;
  end;
  // {$endif}

  if filelistfo.Visible then
  begin
    filelistfo.left := leftposi + leftdec;
    leftposi        := filelistfo.left;
  end;

  if drumsfo.Visible then
  begin
    drumsfo.left := leftposi + leftdec;
    leftposi     := drumsfo.left;
  end;

  if guitarsfo.Visible then
  begin
    guitarsfo.left := leftposi + leftdec;
    leftposi       := guitarsfo.left;
  end;

  if pianofo.Visible then
  begin
    pianofo.left := leftposi + leftdec;
    leftposi     := pianofo.left;
  end;

  if synthefo.Visible then
  begin
    synthefo.left := leftposi + leftdec;
    leftposi      := synthefo.left;
  end;

  if spectrumrecfo.Visible then
  begin
    spectrumrecfo.left := leftposi + leftdec;
    leftposi           := spectrumrecfo.left;
  end;

  if equalizerforec.Visible then
  begin
    equalizerforec.left := leftposi + leftdec;
    leftposi := equalizerforec.left;
  end;

  if waveforec.Visible then
  begin
    waveforec.left := leftposi + leftdec;
    leftposi       := waveforec.left;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.left := leftposi + leftdec;
    leftposi        := recorderfo.left;
  end;

  if infosdfo.Visible then
  begin
    infosdfo.left := leftposi + leftdec;
    leftposi      := infosdfo.left;
  end;

  if spectrum1fo.Visible then
  begin
    spectrum1fo.left := leftposi + leftdec;
    leftposi         := spectrum1fo.left;
  end;

  if equalizerfo1.Visible then
  begin
    equalizerfo1.left := leftposi + leftdec;
    leftposi          := equalizerfo1.left;
  end;

  if wavefo.Visible then
  begin
    wavefo.left := leftposi + leftdec;
    leftposi    := wavefo.left;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.left := leftposi + leftdec;
    leftposi          := songplayerfo.left;
  end;

  if infosdfo2.Visible then
  begin
    infosdfo2.left := leftposi + leftdec;
    leftposi       := infosdfo2.left;
  end;

  if spectrum2fo.Visible then
  begin
    spectrum2fo.left := leftposi + leftdec;
    leftposi         := spectrum2fo.left;
  end;

  if equalizerfo2.Visible then
  begin
    equalizerfo2.left := leftposi + leftdec;
    leftposi          := equalizerfo2.left;
  end;

  if wavefo2.Visible then
  begin
    wavefo2.left := leftposi + leftdec;
    leftposi     := wavefo2.left;
  end;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.left := leftposi + leftdec;
    leftposi           := songplayer2fo.left;
  end;


  if commanderfo.Visible then
  begin
    commanderfo.left := leftposi + leftdec;
    leftposi         := commanderfo.left;
  end;

  top := 0;

  posi := 124;

  // {$if not defined(darwin)}
  if imagedancerfo.Visible then
  begin
    imagedancerfo.top := posi;
    posi := imagedancerfo.top + topdec;
    imagedancerfo.activate;
  end;
  //  {$endif}

  if filelistfo.Visible then
  begin
    filelistfo.top := posi;
    posi           := filelistfo.top + topdec;
    filelistfo.activate;
  end;

  if drumsfo.Visible then
  begin
    drumsfo.top := posi;
    posi        := drumsfo.top + topdec;
    drumsfo.activate;
  end;

  if guitarsfo.Visible then
  begin
    guitarsfo.top := posi;
    posi          := guitarsfo.top + topdec;
    guitarsfo.activate;
  end;

  if pianofo.Visible then
  begin
    pianofo.top := posi;
    posi        := pianofo.top + topdec;
    pianofo.activate;
  end;

  if synthefo.Visible then
  begin
    synthefo.top := posi;
    posi         := synthefo.top + topdec;
    synthefo.activate;
  end;

  if spectrumrecfo.Visible then
  begin
    spectrumrecfo.top := posi;
    posi := spectrumrecfo.top + topdec;
    spectrumrecfo.activate;
  end;

  if equalizerforec.Visible then
  begin
    equalizerforec.top := posi;
    posi := equalizerforec.top + topdec;
    equalizerforec.activate;
  end;

  if waveforec.Visible then
  begin
    waveforec.top := posi;
    posi          := waveforec.top + topdec;
    waveforec.activate;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.top := posi;
    posi           := recorderfo.top + topdec;
    recorderfo.activate;
  end;

  if infosdfo.Visible then
  begin
    infosdfo.top := posi;
    posi         := infosdfo.top + topdec;
    infosdfo.activate;
  end;

  if spectrum1fo.Visible then
  begin
    spectrum1fo.top := posi;
    posi := spectrum1fo.top + topdec;
    spectrum1fo.activate;
  end;

  if equalizerfo1.Visible then
  begin
    equalizerfo1.top := posi;
    posi := equalizerfo1.top + topdec;
    equalizerfo1.activate;
  end;

  if wavefo.Visible then
  begin
    wavefo.top := posi;
    posi       := wavefo.top + topdec;
    wavefo.activate;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.top := posi;
    posi := songplayerfo.top + topdec;
    songplayerfo.activate;
  end;

  if infosdfo2.Visible then
  begin
    infosdfo2.top := posi;
    posi          := infosdfo2.top + topdec;
    infosdfo2.activate;
  end;

  if spectrum2fo.Visible then
  begin
    spectrum2fo.top := posi;
    posi := spectrum2fo.top + topdec;
    spectrum2fo.activate;
  end;

  if equalizerfo2.Visible then
  begin
    equalizerfo2.top := posi;
    posi := equalizerfo2.top + topdec;
    equalizerfo2.activate;
  end;

  if wavefo2.Visible then
  begin
    wavefo2.top := posi;
    posi        := wavefo2.top + topdec;
    wavefo2.activate;
  end;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.top := posi;
    posi := songplayer2fo.top + +topdec;
    songplayer2fo.activate;
  end;

  if commanderfo.Visible then
  begin
    commanderfo.top := posi;
    posi := commanderfo.top + +topdec;
    commanderfo.activate;
  end;

  norefresh := False;
  //  activate;

  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  norefresh := False;

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;


  if timeract.Enabled then
    timeract.restart // to reset
  else
    timeract.Enabled := True;
end;

procedure tmainfo.dragfloat(const Sender: TObject);
begin

  with tdockpanel1fo(Sender) do
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

    if equalizerfo1.parentwidget = basedock then
      equalizerfo1.dragdock.float();

    if equalizerfo2.parentwidget = basedock then
      equalizerfo2.dragdock.float();

    if equalizerforec.parentwidget = basedock then
      equalizerforec.dragdock.float();

    if wavefo.parentwidget = basedock then
      wavefo.dragdock.float();

    if wavefo2.parentwidget = basedock then
      wavefo2.dragdock.float();

    if waveforec.parentwidget = basedock then
      waveforec.dragdock.float();
  end;

end;

procedure tmainfo.ondockjam(const Sender: TObject); // Jam layout
var
  pt1: pointty;
  decorationheight: integer = 5;
begin
  // basedock.anchors := [an_left,an_top]  ;

  oktimer := 1;

  // {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.dragdock.float();
  // {$endif}

  infosdfo.Visible  := False;
  infosdfo2.Visible := False;

  dockpanel5fo.Visible := False;
  dockpanel4fo.Visible := False;
  spectrum1fo.Visible  := False;
  spectrum2fo.Visible  := False;

  recorderfo.dragdock.float();
  recorderfo.Visible := False;

  recorderfo.dragdock.float();
  recorderfo.Visible := False;

  equalizerforec.dragdock.float();
  equalizerforec.Visible := False;

  spectrumrecfo.dragdock.float();
  spectrumrecfo.Visible := False;

  waveforec.dragdock.float();
  waveforec.Visible := False;

  waveforec.dragdock.float();
  waveforec.Visible := False;

  wavefo.dragdock.float();
  wavefo.Visible := False;

  wavefo2.dragdock.float();
  wavefo2.Visible := False;

  songplayerfo.Visible  := True;
  songplayer2fo.Visible := True;
  drumsfo.Visible       := True;
  guitarsfo.Visible     := True;
  equalizerfo1.Visible  := True;
  equalizerfo2.Visible  := True;

  commanderfo.Visible := True;

  commanderfo.automix.Value := True;

  filelistfo.Visible := True;
  decorationheight   := window.decoratedbounds_cy - Height;

  commanderfo.automix.Value := True;


  beginlayout();

  norefresh := True;

  basedock.dragdock.currentsplitdir := sd_horz;


  with dockpanel3fo do
  begin
    //  dragfloat(dockpanel3fo);

    basedock.dragdock.currentsplitdir := sd_horz;

    Visible := True;

    drumsfo.Visible      := True;
    drumsfo.parentwidget := basedock;

    guitarsfo.Visible      := True;
    guitarsfo.parentwidget := basedock;

    pt1 := nullpoint;

    drumsfo.pos := pt1;
    pt1.y       := pt1.y + drumsfo.Height + decorationheight;

    guitarsfo.pos := pt1;
    pt1.y         := pt1.y + guitarsfo.Height + decorationheight;

    if dockpanel3fo.Timerwaitdp.Enabled then
      dockpanel3fo.Timerwaitdp.restart // to reset
    else
      dockpanel3fo.Timerwaitdp.Enabled := True;
  end;

  with dockpanel1fo do
  begin
    basedock.dragdock.currentsplitdir := sd_horz;

    //  dragfloat(dockpanel1fo);

    Visible := True;

    songplayerfo.Visible      := True;
    songplayerfo.parentwidget := basedock;

    //  spectrum1fo.Visible      := True;
    //  spectrum1fo.parentwidget := basedock;

    equalizerfo1.Visible      := True;
    equalizerfo1.parentwidget := basedock;

    pt1 := nullpoint;

    //   spectrum1fo.pos := pt1;
    //   pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo1.pos := pt1;
    pt1.y := pt1.y + equalizerfo1.Height + decorationheight;

    songplayerfo.pos := pt1;

    if dockpanel1fo.Timerwaitdp.Enabled then
      dockpanel1fo.Timerwaitdp.restart // to reset
    else
      dockpanel1fo.Timerwaitdp.Enabled := True;

  end;

  with dockpanel2fo do
  begin
    basedock.dragdock.currentsplitdir := sd_horz;

    Visible := True;

    waveforec.Visible := False;

    songplayer2fo.Visible      := True;
    songplayer2fo.parentwidget := basedock;

    equalizerfo2.Visible      := True;
    equalizerfo2.parentwidget := basedock;

    pt1 := nullpoint;

    equalizerfo2.pos := pt1;
    pt1.y := pt1.y + equalizerfo2.Height + decorationheight;

    songplayer2fo.pos := pt1;

    if dockpanel2fo.Timerwaitdp.Enabled then
      dockpanel2fo.Timerwaitdp.restart // to reset
    else
      dockpanel2fo.Timerwaitdp.Enabled := True;

  end;

  // with dockpanel4fo do
  // begin
  //   basedock.dragdock.currentsplitdir := sd_vert;

  //  Visible          := True;
  synthefo.Visible      := True;
  synthefo.parentwidget := nil;

  pianofo.Visible      := True;
  pianofo.parentwidget := nil;

   { pt1 := nullpoint;

    synthefo.pos := pt1;
    pt1.x        := pt1.x + synthefo.Width + decorationheight;

    pianofo.pos := pt1;
   }
  // end;

  filelistfo.Visible      := True;
  filelistfo.parentwidget := basedock;

  commanderfo.Visible      := True;
  commanderfo.parentwidget := basedock;

  filelistfo.bounds_cxmax  := fowidth;
  filelistfo.bounds_cymax  := filelistfoheight;
  filelistfo.Width         := fowidth;
  filelistfo.Height        := filelistfoheight;
  filelistfo.parentwidget  := basedock;
  commanderfo.parentwidget := basedock;

  pt1 := nullpoint;

  filelistfo.pos := pt1;
  pt1.y          := pt1.y + filelistfo.Height + decorationheight;

  commanderfo.pos := pt1;
  pt1.y           := pt1.y + commanderfo.Height + decorationheight;

  dockpanel1fo.left := 0;
  dockpanel1fo.top  := decorationheight;

  // dockpanel3fo.left := 0;
  // dockpanel3fo.top  := songplayerfo.Height + 
  // songplayerfo.Height + 30 + (2 * decorationheight);

  left := dockpanel1fo.Width + 10;
  top  := decorationheight;

  dockpanel2fo.left := left + Width + 8;
  dockpanel2fo.top  := dockpanel1fo.top;

  dockpanel3fo.left := dockpanel1fo.left;

  dockpanel3fo.top := songplayerfo.Height + equalizerfo1.Height + 24 + (2 * decorationheight);

  synthefo.top  := dockpanel3fo.top;
  synthefo.left := dockpanel3fo.right + 10;

  pianofo.top  := synthefo.top;
  pianofo.left := synthefo.right + 10;

  norefresh := False;

  endlayout();
  // sleep(1);
  // application.ProcessMessages;

  oktimer := 0;

  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayoutpan();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayoutpan();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayoutpan();

  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayoutpan();

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

end;

procedure tmainfo.ondockplayersx2(const Sender: TObject); // DJ LayoutX2
begin
  ondockplayers(Sender);
  sleep(200);
  application.ProcessMessages;
  ondockplayers(Sender);
end;

procedure tmainfo.ondockplayerstabx2(const Sender: TObject); // DJ LayoutX2
begin
  ondockplayerstag(Sender);
  sleep(200);
  application.ProcessMessages;
  ondockplayerstag(Sender);
end;

procedure tmainfo.ondockplayers(const Sender: TObject); // DJ Layout
var
  pt1: pointty;
  rect1: rectty;
  decorationheight: integer = 5;
  interv: integer;
begin
  // basedock.anchors := [an_left,an_top]  ;

  norefresh := True;

  oktimer           := 1;
  infosdfo.Visible  := False;
  infosdfo.dragdock.float();
  infosdfo2.Visible := False;
  infosdfo2.dragdock.float();
  synthefo.Visible  := False;
  synthefo.dragdock.float();
  pianofo.Visible   := False;
  pianofo.dragdock.float();

  //  {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.dragdock.float();
  //  {$endif}

  // imagedancerfo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;
  spectrum1fo.Visible  := True;
  //spectrum1fo.dragdock.float();

  spectrum2fo.Visible := True;
  //spectrum1fo.dragdock.float();

  songplayerfo.Visible := True;
  //spectrum1fo.dragdock.float();

  songplayer2fo.Visible := True;
  //spectrum1fo.dragdock.float();

  guitarsfo.dragdock.float();
  guitarsfo.Visible := False;

  drumsfo.dragdock.float();
  drumsfo.Visible := False;

  recorderfo.dragdock.float();
  recorderfo.Visible := False;

  equalizerfo1.Visible := True;
  equalizerfo2.Visible := True;

  equalizerforec.dragdock.float();
  equalizerforec.Visible := False;

  spectrumrecfo.dragdock.float();
  spectrumrecfo.Visible := False;

  waveforec.dragdock.float();
  waveforec.Visible := False;

  commanderfo.Visible := True;

  commanderfo.automix.Value := True;

  filelistfo.Visible := True;

  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  filelistfo.dragdock.float();
  wavefo.dragdock.float();
  wavefo2.dragdock.float();

  basedock.dragdock.currentsplitdir := sd_horz;
  decorationheight := window.decoratedbounds_cy - Height;

  beginlayout();

  with dockpanel1fo do
  begin

    // dragfloat(dockpanel1fo);

    songplayerfo.parentwidget := basedock;

    spectrum1fo.parentwidget := basedock;

    equalizerfo1.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    spectrum1fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo1.pos := pt1;
    pt1.y := pt1.y + equalizerfo1.Height + decorationheight;

    songplayerfo.pos := pt1;

    // dockpanel1fo.Timerwaitdp.Enabled := False;
    // dockpanel1fo.Timerwaitdp.Enabled := True;
  end;

  with dockpanel2fo do
  begin
    // dragfloat(dockpanel2fo);
    songplayer2fo.parentwidget := basedock;
    spectrum2fo.parentwidget   := basedock;
    equalizerfo2.parentwidget  := basedock;

    //{
    pt1 := nullpoint;

    spectrum2fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo2.pos := pt1;
    pt1.y := pt1.y + equalizerfo2.Height + decorationheight;


    songplayer2fo.pos := pt1;

    //  dockpanel2fo.Timerwaitdp.Enabled := False;
    //  dockpanel2fo.Timerwaitdp.Enabled := True;
  end;


  basedock.dragdock.currentsplitdir := sd_horz;
  commanderfo.parentwidget          := basedock;

  rect1 := application.screenrect(window);

  interv := (rect1.cx - (3 * foWidth)) div 2;

  decorationheight := window.decoratedbounds_cy - Height;

  dockpanel1fo.left := 0;
  dockpanel1fo.top  := decorationheight;

  filelistfo.left := commanderfo.Width + interv;
  filelistfo.top  := commanderfo.Height + roundmath(2.5 * decorationheight) - 2;

  filelistfo.Height := (songplayerfo.Height + spectrum1fo.Height + equalizerfo1.Height) - commanderfo.Height - (decorationheight div 2);

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.Width        := fowidth;

  //filelistfo.Height := 400;

  left := filelistfo.left;
  // top  := filelistfo.Height + (decorationheight * 2) - 4;
  top  := decorationheight;

  dockpanel2fo.top := dockpanel1fo.top;

  dockpanel2fo.left := filelistfo.right + interv;

  endlayout();

  interv := ((rect1.cy - (songplayerfo.Height + spectrum1fo.Height + equalizerfo1.Height) - (decorationheight * 5)) div 2);

  wavefo2.bounds_cxmax := 0;
  wavefo2.bounds_cymax := 0;
  wavefo.bounds_cxmax  := 0;
  wavefo.bounds_cymax  := 0;

  wavefo.Width   := dockpanel2fo.right - 2;
  wavefo2.Width  := wavefo.Width;
  wavefo.Height  := interv;
  wavefo2.Height := interv;

  wavefo.top := songplayerfo.Height + spectrum1fo.Height + equalizerfo1.Height + (3 * decorationheight);

  wavefo2.top := wavefo.bottom + decorationheight;

  wavefo.left  := 0;
  wavefo2.left := 0;

  application.ProcessMessages;
  //  visible:= true;

  dockpanel1fo.Visible := True;
  dockpanel2fo.Visible := True;
  wavefo.Visible       := True;
  wavefo2.Visible      := True;

  //application.ProcessMessages;

  Visible := True;

  oktimer := 0;

  updatelayoutstrum();

  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayoutpan();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayoutpan();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayoutpan();

  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayoutpan();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayoutpan();


  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;


  norefresh := False;

end;

/////

procedure tmainfo.ondockplayerstag(const Sender: TObject); // DJ tag image Layout
var
  pt1: pointty;
  rect1: rectty;
  decorationheight: integer = 5;
  interv: integer;
begin
  // basedock.anchors := [an_left,an_top]  ;

  norefresh := True;

  oktimer := 1;

  synthefo.Visible := False;
  synthefo.dragdock.float();
  pianofo.Visible  := False;
  pianofo.dragdock.float();
  wavefo.Visible   := False;
  wavefo.dragdock.float();
  wavefo2.Visible  := False;
  wavefo2.dragdock.float();

  // {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.dragdock.float();
  // {$endif}

  // imagedancerfo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;
  spectrum1fo.Visible  := True;
  //spectrum1fo.dragdock.float();

  infosdfo.Visible  := True;
  infosdfo2.Visible := True;

  spectrum2fo.Visible := True;
  //spectrum1fo.dragdock.float();

  songplayerfo.Visible := True;
  //spectrum1fo.dragdock.float();

  songplayer2fo.Visible := True;
  //spectrum1fo.dragdock.float();

  guitarsfo.dragdock.float();
  guitarsfo.Visible := False;

  drumsfo.dragdock.float();
  drumsfo.Visible := False;

  recorderfo.dragdock.float();
  recorderfo.Visible := False;

  equalizerfo1.Visible := True;
  equalizerfo2.Visible := True;

  equalizerforec.dragdock.float();
  equalizerforec.Visible := False;

  spectrumrecfo.dragdock.float();
  spectrumrecfo.Visible := False;

  waveforec.dragdock.float();
  waveforec.Visible := False;

  commanderfo.Visible := True;

  commanderfo.automix.Value := True;

  filelistfo.Visible := True;

  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  filelistfo.dragdock.float();

  basedock.dragdock.currentsplitdir := sd_horz;
  decorationheight := window.decoratedbounds_cy - Height;

  beginlayout();

  with dockpanel1fo do
  begin

    // dragfloat(dockpanel1fo);

    songplayerfo.parentwidget := basedock;

    spectrum1fo.parentwidget := basedock;

    equalizerfo1.parentwidget := basedock;

    //infosdfo.Width  := songplayerfo.Width;
    //infosdfo.Height := 228;
    infosdfo.parentwidget := basedock;

    //{
    pt1 := nullpoint;

    infosdfo.pos := pt1;
    pt1.y        := pt1.y + infosdfo.Height + decorationheight;

    spectrum1fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo1.pos := pt1;
    pt1.y := pt1.y + equalizerfo1.Height + decorationheight;

    songplayerfo.pos := pt1;

    // dockpanel1fo.Timerwaitdp.Enabled := False;
    // dockpanel1fo.Timerwaitdp.Enabled := True;
  end;

  with dockpanel2fo do
  begin
    // dragfloat(dockpanel2fo);
    songplayer2fo.parentwidget := basedock;
    spectrum2fo.parentwidget   := basedock;
    equalizerfo2.parentwidget  := basedock;

    //infosdfo2.Width  := songplayerfo.Width;
    //infosdfo2.Height := 228;
    infosdfo2.parentwidget := basedock;


    //{
    pt1 := nullpoint;

    infosdfo2.pos := pt1;
    pt1.y         := pt1.y + infosdfo2.Height + decorationheight;

    spectrum2fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo2.pos := pt1;
    pt1.y := pt1.y + equalizerfo2.Height + decorationheight;


    songplayer2fo.pos := pt1;

    //  dockpanel2fo.Timerwaitdp.Enabled := False;
    //  dockpanel2fo.Timerwaitdp.Enabled := True;
  end;


  basedock.dragdock.currentsplitdir := sd_horz;
  commanderfo.parentwidget          := basedock;

  rect1 := application.screenrect(window);

  interv := (rect1.cx - (3 * foWidth)) div 2;

  decorationheight := window.decoratedbounds_cy - Height;
{
  infosdfo.dragdock.float();
 
  infosdfo.Width  := songplayerfo.Width;
  infosdfo.Height := 228;

 infosdfo2.dragdock.float();
 
  infosdfo2.Width  := infosdfo.Width;
  infosdfo2.Height := infosdfo.Height;

  infosdfo.top  := decorationheight;
  infosdfo2.top := decorationheight;
 }

  dockpanel1fo.left := 0;
  dockpanel1fo.top  := decorationheight;

  filelistfo.left := commanderfo.Width + interv;
  filelistfo.top  := commanderfo.Height + roundmath(2.5 * decorationheight) - 2;

  filelistfo.Height := (songplayerfo.Height + spectrum1fo.Height + equalizerfo1.Height + equalizerfo1.Height) - (decorationheight div 2);

  filelistfo.bounds_cxmax := fowidth;
  filelistfo.Width        := fowidth;

  //filelistfo.Height := 400;

  left := filelistfo.left;
  // top  := filelistfo.Height + (decorationheight * 2) - 4;
  top  := decorationheight;

  dockpanel2fo.top := dockpanel1fo.top;

  dockpanel2fo.left := filelistfo.right + interv;

  infosdfo.left  := dockpanel1fo.left;
  infosdfo2.left := dockpanel2fo.left;

  endlayout();

  interv := ((rect1.cy - (songplayerfo.Height + spectrum1fo.Height + equalizerfo1.Height) - (decorationheight * 5)) div 2);

  application.ProcessMessages;
  //  visible:= true;

  dockpanel1fo.Visible := True;
  dockpanel2fo.Visible := True;

  infosdfo.bringtofront;
  infosdfo2.bringtofront;

  //application.ProcessMessages;

  Visible := True;

  oktimer := 0;

  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayoutpan();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayoutpan();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayoutpan();

  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayoutpan();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayoutpan();


  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;


  norefresh := False;

end;

////

procedure tmainfo.ondockall(const Sender: TObject);
var
  pt1: pointty;
  decorationheight: integer = 5;
  rect1: rectty;
begin
  oktimer          := 1;
  // basedock.anchors := [an_left,an_top]  ;
  decorationheight := window.decoratedbounds_cy - Height;
  norefresh        := True;
  filelistfo.bounds_cxmax := fowidth;
  filelistfo.bounds_cymax := 1024;

  wavefo.bounds_cxmax := fowidth;
  wavefo.bounds_cymax := 100;

  wavefo2.bounds_cxmax := fowidth;
  wavefo2.bounds_cymax := 100;

  waveforec.bounds_cxmax := fowidth;
  waveforec.bounds_cymax := 100;

  // {$if not defined(darwin)}
  imagedancerfo.Height := fowidth;

  imagedancerfo.bounds_cxmax := fowidth;
  imagedancerfo.bounds_cx := fowidth;
  //  {$endif}
  rect1 := application.screenrect(window);

  beginlayout();

  basedock.dragdock.currentsplitdir := sd_horz;

  if drumsfo.Visible then
    drumsfo.parentwidget  := basedock;
  if synthefo.Visible then
    synthefo.parentwidget := basedock;
  if pianofo.Visible then
    pianofo.parentwidget  := basedock;

  if filelistfo.Visible then
    filelistfo.parentwidget    := basedock;
  if songplayerfo.Visible then
    songplayerfo.parentwidget  := basedock;
  if songplayer2fo.Visible then
    songplayer2fo.parentwidget := basedock;
  if commanderfo.Visible then
    commanderfo.parentwidget   := basedock;
  //  {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.parentwidget := basedock;
  // {$endif}

  if spectrum1fo.Visible then
    spectrum1fo.parentwidget  := basedock;
  if equalizerfo1.Visible then
    equalizerfo1.parentwidget := basedock;

  if infosdfo.Visible then
    infosdfo.parentwidget := basedock;

  if infosdfo2.Visible then
    infosdfo2.parentwidget := basedock;

  if spectrum2fo.Visible then
    spectrum2fo.parentwidget  := basedock;
  if equalizerfo2.Visible then
    equalizerfo2.parentwidget := basedock;

  if spectrumrecfo.Visible then
    spectrumrecfo.parentwidget := basedock;

  if equalizerforec.Visible then
    equalizerforec.parentwidget := basedock;

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
    pt1.y       := pt1.y + drumsfo.Height + decorationheight;
  end;

  if synthefo.Visible then
  begin
    synthefo.pos := pt1;
    pt1.y        := pt1.y + synthefo.Height + decorationheight;
  end;

  if pianofo.Visible then
  begin
    pianofo.pos := pt1;
    pt1.y       := pt1.y + pianofo.Height + decorationheight;
  end;

  if filelistfo.Visible then
  begin
    filelistfo.pos := pt1;
    pt1.y          := pt1.y + filelistfo.Height + decorationheight;
  end;

  if infosdfo.Visible then
  begin
    infosdfo.pos := pt1;
    pt1.y        := pt1.y + infosdfo.Height + decorationheight;
  end;

  if spectrum1fo.Visible then
  begin
    spectrum1fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;
  end;

  if equalizerfo1.Visible then
  begin
    equalizerfo1.pos := pt1;
    pt1.y := pt1.y + equalizerfo1.Height + decorationheight;
  end;

  if wavefo.Visible then
  begin
    wavefo.pos := pt1;
    pt1.y      := pt1.y + wavefo.Height + decorationheight;
  end;

  if songplayerfo.Visible then
  begin
    songplayerfo.pos := pt1;
    pt1.y := pt1.y + songplayerfo.Height + decorationheight;
  end;

  if infosdfo2.Visible then
  begin
    infosdfo2.pos := pt1;
    pt1.y         := pt1.y + infosdfo2.Height + decorationheight;
  end;

  if spectrum2fo.Visible then
  begin
    spectrum2fo.pos := pt1;
    pt1.y           := pt1.y + spectrum2fo.Height + decorationheight;
  end;

  if equalizerfo2.Visible then
  begin
    equalizerfo2.pos := pt1;
    pt1.y := pt1.y + equalizerfo2.Height + decorationheight;
  end;

  if wavefo2.Visible then
  begin
    wavefo2.pos := pt1;
    pt1.y       := pt1.y + wavefo2.Height + decorationheight;
  end;

  if songplayer2fo.Visible then
  begin
    songplayer2fo.pos := pt1;
    pt1.y := pt1.y + songplayer2fo.Height + decorationheight;
  end;

  //   {$if not defined(darwin)}
  if imagedancerfo.Visible then
  begin
    imagedancerfo.pos := pt1;
    pt1.y := pt1.y + imagedancerfo.Height + decorationheight;
  end;
  //  {$endif}

  if commanderfo.Visible then
  begin
    commanderfo.pos := pt1;
    pt1.y           := pt1.y + commanderfo.Height + decorationheight;
  end;

  if spectrumrecfo.Visible then
  begin
    spectrumrecfo.pos := pt1;
    pt1.y := pt1.y + spectrumrecfo.Height + decorationheight;
  end;

  if equalizerforec.Visible then
  begin
    equalizerforec.pos := pt1;
    pt1.y := pt1.y + equalizerforec.Height + decorationheight;
  end;

  if recorderfo.Visible then
  begin
    recorderfo.pos := pt1;
    pt1.y          := pt1.y + recorderfo.Height + decorationheight;
  end;

  if waveforec.Visible then
  begin
    waveforec.pos := pt1;
    pt1.y         := pt1.y + waveforec.Height + decorationheight;
  end;

  if guitarsfo.Visible then
    guitarsfo.pos := pt1;
  //}

  endlayout();

  norefresh := False;

  left := (rect1.cx - Width) div 2;

  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

  if timeract.Enabled then
    timeract.restart // to reset
  else
    timeract.Enabled := True;
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

  wavefo.bounds_cy    := wavefoheight;
  wavefo2.bounds_cy   := wavefoheight;
  waveforec.bounds_cy := wavefoheight;

  //  infosdfo.width := fowidth;
  //  infosdfo2.width := fowidth;
  // infosdfo.bounds_cxmax := fowidth;
  // infosdfo2.bounds_cxmax := fowidth;

  beginlayout();
  oktimer := 1;

  ondockall(Sender);
  oktimer := 1;

  // otherwise the close button are hidden
  basedock.dragdock.currentsplitdir := sd_tabed;
  sleep(1);
  endlayout();

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

end;

procedure tmainfo.showall(const Sender: TObject);
begin
  norefresh := True;
  beginlayout();
  drumsfo.Show();
  filelistfo.Show();
  songplayerfo.Show();
  songplayer2fo.Show();
  commanderfo.Show();
  guitarsfo.Show();
  recorderfo.Show();
  equalizerfo1.Show();
  equalizerfo2.Show();
  equalizerforec.Show();
  spectrum1fo.Show();
  spectrum2fo.Show();
  spectrumrecfo.Show();
  synthefo.Show();
  pianofo.Show();
  wavefo.Show();
  wavefo2.Show();
  waveforec.Show();
  //  {$if not defined(darwin)}
  imagedancerfo.Show();
  // {$endif}

  norefresh := False;
  endlayout();

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

  if timeract.Enabled then
    timeract.restart // to reset
  else
    timeract.Enabled := True;

end;

procedure tmainfo.hideall(const Sender: TObject);
begin
  beginlayout();
  norefresh          := True;
  drumsfo.Visible    := False;
  filelistfo.Visible := False;
  songplayerfo.Visible := False;
  songplayer2fo.Visible := False;
  synthefo.Visible   := False;

  infosdfo.Visible      := False;
  infosdfo2.Visible     := False;
  //    {$if not defined(darwin)}
  imagedancerfo.Visible := False;
  // {$endif}

  pianofo.Visible := False;
  commanderfo.Visible := False;
  guitarsfo.Visible := False;
  recorderfo.Visible := False;
  spectrum1fo.Visible := False;
  spectrum2fo.Visible := False;
  spectrumrecfo.Visible := False;
  wavefo.Visible := False;
  wavefo2.Visible := False;
  waveforec.Visible := False;
  equalizerfo1.Visible := False;
  equalizerfo2.Visible := False;
  equalizerforec.Visible := False;
  norefresh := False;
  endlayout();
  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

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

procedure tmainfo.onchangevalcolor(const Sender: TObject);
var
  ltblank: integer = $F0F0F0;
  ltblack: integer = $2D2D2D;
  thecolor1: integer = $2D2D2D;
  thecolor2: integer = $2D2D2D;
  asliders: tasliders;
  asliders2: tasliders;
  aslidersr: tasliders;
  abuttons: tabuttons;
  abuttons2: tabuttons;
  abuttonsr: tabuttons;
  x: integer;
begin
  paintslider();

  // wavefo.trackbar1.face.template    := tfaceplayer;
  // wavefo2.trackbar1.face.template   := tfaceplayer;
  // waveforec.trackbar1.face.template := recorderfo.tfacerecorder;

  commanderfo.vuleft.bar_face.fade_color.items[0]    := configlayoutfo.tcoloredit1.Value;
  commanderfo.vuleft2.bar_face.fade_color.items[0]   := configlayoutfo.tcoloredit12.Value;
  commanderfo.vuright.bar_face.fade_color.items[0]   := configlayoutfo.tcoloredit2.Value;
  commanderfo.vuright2.bar_face.fade_color.items[0]  := configlayoutfo.tcoloredit22.Value;
  songplayerfo.vuleft.bar_face.fade_color.items[0]   := configlayoutfo.tcoloredit1.Value;
  songplayer2fo.vuleft.bar_face.fade_color.items[0]  := configlayoutfo.tcoloredit12.Value;
  songplayerfo.vuright.bar_face.fade_color.items[0]  := configlayoutfo.tcoloredit2.Value;
  songplayer2fo.vuright.bar_face.fade_color.items[0] := configlayoutfo.tcoloredit22.Value;

  // commanderfo.sysvol.scrollbar.facebutton.template := commanderfo.tfacebutton;

  with equalizerfo1 do
  begin
    asliders[1]  := tslider1;
    asliders[2]  := tslider2;
    asliders[3]  := tslider3;
    asliders[4]  := tslider4;
    asliders[5]  := tslider5;
    asliders[6]  := tslider6;
    asliders[7]  := tslider7;
    asliders[8]  := tslider8;
    asliders[9]  := tslider9;
    asliders[10] := tslider10;
    asliders[11] := tslider11;
    asliders[12] := tslider12;
    asliders[13] := tslider13;
    asliders[14] := tslider14;
    asliders[15] := tslider15;
    asliders[16] := tslider16;
    asliders[17] := tslider17;
    asliders[18] := tslider18;
    asliders[19] := tslider19;
    asliders[20] := tslider20;
  end;

  with equalizerfo2 do
  begin
    asliders2[1]  := tslider1;
    asliders2[2]  := tslider2;
    asliders2[3]  := tslider3;
    asliders2[4]  := tslider4;
    asliders2[5]  := tslider5;
    asliders2[6]  := tslider6;
    asliders2[7]  := tslider7;
    asliders2[8]  := tslider8;
    asliders2[9]  := tslider9;
    asliders2[10] := tslider10;
    asliders2[11] := tslider11;
    asliders2[12] := tslider12;
    asliders2[13] := tslider13;
    asliders2[14] := tslider14;
    asliders2[15] := tslider15;
    asliders2[16] := tslider16;
    asliders2[17] := tslider17;
    asliders2[18] := tslider18;
    asliders2[19] := tslider19;
    asliders2[20] := tslider20;
  end;

  with equalizerforec do
  begin
    aslidersr[1]  := tslider1;
    aslidersr[2]  := tslider2;
    aslidersr[3]  := tslider3;
    aslidersr[4]  := tslider4;
    aslidersr[5]  := tslider5;
    aslidersr[6]  := tslider6;
    aslidersr[7]  := tslider7;
    aslidersr[8]  := tslider8;
    aslidersr[9]  := tslider9;
    aslidersr[10] := tslider10;
    aslidersr[11] := tslider11;
    aslidersr[12] := tslider12;
    aslidersr[13] := tslider13;
    aslidersr[14] := tslider14;
    aslidersr[15] := tslider15;
    aslidersr[16] := tslider16;
    aslidersr[17] := tslider17;
    aslidersr[18] := tslider18;
    aslidersr[19] := tslider19;
    aslidersr[20] := tslider20;
  end;

  with equalizerfo1 do
  begin
    abuttons[1]  := tbutton1;
    abuttons[2]  := tbutton2;
    abuttons[3]  := tbutton3;
    abuttons[4]  := tbutton4;
    abuttons[5]  := tbutton5;
    abuttons[6]  := tbutton6;
    abuttons[7]  := tbutton7;
    abuttons[8]  := tbutton8;
    abuttons[9]  := tbutton9;
    abuttons[10] := tbutton10;
    abuttons[11] := tbutton11;
    abuttons[12] := tbutton12;
    abuttons[13] := tbutton13;
    abuttons[14] := tbutton14;
    abuttons[15] := tbutton15;
    abuttons[16] := tbutton16;
    abuttons[17] := tbutton17;
    abuttons[18] := tbutton18;
    abuttons[19] := tbutton19;
    abuttons[20] := tbutton20;
  end;

  with equalizerfo2 do
  begin
    abuttons2[1]  := tbutton1;
    abuttons2[2]  := tbutton2;
    abuttons2[3]  := tbutton3;
    abuttons2[4]  := tbutton4;
    abuttons2[5]  := tbutton5;
    abuttons2[6]  := tbutton6;
    abuttons2[7]  := tbutton7;
    abuttons2[8]  := tbutton8;
    abuttons2[9]  := tbutton9;
    abuttons2[10] := tbutton10;
    abuttons2[11] := tbutton11;
    abuttons2[12] := tbutton12;
    abuttons2[13] := tbutton13;
    abuttons2[14] := tbutton14;
    abuttons2[15] := tbutton15;
    abuttons2[16] := tbutton16;
    abuttons2[17] := tbutton17;
    abuttons2[18] := tbutton18;
    abuttons2[19] := tbutton19;
    abuttons2[20] := tbutton20;
  end;

  with equalizerforec do
  begin
    abuttonsr[1]  := tbutton1;
    abuttonsr[2]  := tbutton2;
    abuttonsr[3]  := tbutton3;
    abuttonsr[4]  := tbutton4;
    abuttonsr[5]  := tbutton5;
    abuttonsr[6]  := tbutton6;
    abuttonsr[7]  := tbutton7;
    abuttonsr[8]  := tbutton8;
    abuttonsr[9]  := tbutton9;
    abuttonsr[10] := tbutton10;
    abuttonsr[11] := tbutton11;
    abuttonsr[12] := tbutton12;
    abuttonsr[13] := tbutton13;
    abuttonsr[14] := tbutton14;
    abuttonsr[15] := tbutton15;
    abuttonsr[16] := tbutton16;
    abuttonsr[17] := tbutton17;
    abuttonsr[18] := tbutton18;
    abuttonsr[19] := tbutton19;
    abuttonsr[20] := tbutton20;
  end;

  ///  
  if typecolor.Value = 3 then
  begin
    font.color          := cl_black;
    synthefo.font.color := cl_black;

    synthefo.color := $FEB7F9;
    pianofo.color  := $FEB7F9;

    pianofo.font.color := cl_black;
    synthefo.tgroupbox4.font.color := cl_black;
    synthefo.tgroupbox3.font.color := cl_black;
    filelistfo.historyfn.font.color := cl_black;

    songplayerfo.historyfn.font.color  := cl_black;
    songplayer2fo.historyfn.font.color := cl_black;

    songplayerfo.historyfn.dropdown.cols[0].colorselect  := $FFCD8F;
    songplayer2fo.historyfn.dropdown.cols[0].colorselect := $FFCD8F;

    songplayerfo.cbloopb.font.color  := cl_black;
    songplayer2fo.cbloopb.font.color := cl_black;

    songplayerfo.playreverseb.font.color  := cl_black;
    songplayer2fo.playreverseb.font.color := cl_black;

    songplayerfo.waveformcheckb.font.color  := cl_black;
    songplayer2fo.waveformcheckb.font.color := cl_black;

    songplayerfo.setmonob.font.color  := cl_black;
    songplayer2fo.setmonob.font.color := cl_black;

    songplayerfo.cbtempob.font.color  := cl_black;
    songplayer2fo.cbtempob.font.color := cl_black;

    commanderfo.Brandommix.font.color  := cl_black;
    commanderfo.linkvolgenb.font.color := cl_black;
    commanderfo.linkvolb.font.color    := cl_black;
    commanderfo.speccalcb.font.color   := cl_black;
    commanderfo.guimixb.font.color     := cl_black;
    commanderfo.linkvol2b.font.color   := cl_black;
    commanderfo.automixb.font.color    := cl_black;
    commanderfo.vuinb.font.color       := cl_black;
    commanderfo.directmixb.font.color  := cl_black;

    dockpanel1fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel2fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel3fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel4fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel5fo.tmainmenu1.menu.font.color := cl_black;

    wavefo.tmainmenu1.menu.font.color    := cl_black;
    wavefo2.tmainmenu1.menu.font.color   := cl_black;
    waveforec.tmainmenu1.menu.font.color := cl_black;

    dockpanel1fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel2fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel3fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel4fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel5fo.basedock.dragdock.splitter_color := $B7BA8F;

    basedock.dragdock.splitter_color := $B7BA8F;

    wavefo.echelle.datacols.font.color := cl_black;
    wavefo.echelle.datacols.color      := $B7BA8F;
    wavefo.echelle.datacols.font.colorbackground := $B7BA8F;

    wavefo2.echelle.datacols.font.color := cl_black;
    wavefo2.echelle.datacols.color      := $B7BA8F;
    wavefo2.echelle.datacols.font.colorbackground := $B7BA8F;

    dialogfilesfo.list_files.frame.colorclient := $F9FFC2;

    filelistfo.historyfn.dropdown.cols[0].colorselect := $FFC782;

    wavefo.container.color  := cl_default;
    wavefo2.container.color := cl_default;

    spectrum1fo.container.color   := cl_default;
    spectrum2fo.container.color   := cl_default;
    spectrumrecfo.container.color := cl_default;
    commanderfo.container.color   := cl_default;
    guitarsfo.container.color     := cl_default;

    filelistfo.list_files.fixrows.color          := cl_default;
    filelistfo.list_files.fixrows[-1].font.color := cl_default;

    filelistfo.list_files.fixcols.color           := cl_default;
    filelistfo.list_files.fixcols[-1].font.color  := cl_default;
    filelistfo.list_files.fixcols[-1].colorselect := cl_ltgray;

    for x := 0 to filelistfo.list_files.rowcount - 1 do
      filelistfo.list_files.rowfontstate[x] := 0;

    filelistfo.list_files.datacols.colorselect := $FFC87A;

    tmainmenu1.menu.font.color := cl_black;
    tmainmenu1.menu.colorglyph := cl_black;
    tmainmenu1.menu.colorglyphactive := cl_black;
    wavefo.tmainmenu1.menu.colorglyph := thecolor1;
    wavefo.tmainmenu1.menu.colorglyphactive := thecolor1;
    waveforec.tmainmenu1.menu.colorglyph := cl_black;
    waveforec.tmainmenu1.menu.colorglyphactive := cl_black;
    wavefo2.tmainmenu1.menu.colorglyph := thecolor1;
    wavefo2.tmainmenu1.menu.colorglyphactive := thecolor2;
    randomnotefo.color := $DED9D1;
    randomnotefo.tstringdisp1.font.color := cl_black;
    randomnotefo.bchord1.font.color := cl_black;
    randomnotefo.bchord2.font.color := cl_black;
    randomnotefo.bchord3.font.color := cl_black;
    randomnotefo.bchord4.font.color := cl_black;
    randomnotefo.bchord5.font.color := cl_black;

    filelistfo.container.color := $FDB0FB;
    filelistfo.color           := $FDB0FB;

    songplayerfo.edvolleft.font.color   := cl_black;
    songplayerfo.edvolright.font.color  := cl_black;
    songplayer2fo.edvolleft.font.color  := cl_black;
    songplayer2fo.edvolright.font.color := cl_black;

    songplayerfo.historyfn.frame.button.color := $FDB0FB;
    songplayerfo.edvolleft.color  := $FDB0FB;
    songplayerfo.edvolleft.frame.colorbutton := $FDB0FB;
    songplayerfo.edvolright.color := $FDB0FB;
    songplayerfo.edvolright.frame.colorbutton := $FDB0FB;
    songplayerfo.edtempo.color    := $FDB0FB;
    songplayerfo.edtempo.frame.colorbutton := $FDB0FB;

    songplayerfo.edpitch.color  := $FDB0FB;
    songplayerfo.edpitch.frame.colorbutton := $FDB0FB;
    songplayer2fo.edpitch.color := $FDB0FB;
    songplayer2fo.edpitch.frame.colorbutton := $FDB0FB;

    recorderfo.edtempo.color := $FDB0FB;
    recorderfo.edtempo.frame.colorbutton := $FDB0FB;

    songplayer2fo.historyfn.frame.button.color := $FDB0FB;
    songplayer2fo.edvolleft.color  := $E7B0E8;
    songplayer2fo.edvolleft.frame.colorbutton := $FDB0FB;
    songplayer2fo.edvolright.color := $E7B0E8;
    songplayer2fo.edvolright.frame.colorbutton := $FDB0FB;
    songplayer2fo.edtempo.color    := $E7B0E8;
    songplayer2fo.edtempo.frame.colorbutton := $FDB0FB;

    recorderfo.edtempo.color := $FDB0FB;
    recorderfo.edtempo.frame.colorbutton := $FDB0FB;


    commanderfo.timemix.frame.colorbutton := $FDB0FB;
    commanderfo.timemix.color := $FDB0FB;

    filelistfo.historyfn.frame.button.color := $FDB0FB;
    filelistfo.container.color := $FDB0FB;
    filelistfo.color           := $FDB0FB;
    filelistfo.list_files.face.fade_color.items[0] := $FDB0FB;

    wavefo.trackbar1.color    := $FCD4FB;
    wavefo2.trackbar1.color   := $FCD4FB;
    waveforec.trackbar1.color := $FCD4FB;

    with infosdfo do
    begin
      container.color := $E7B0E8;

      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      infoyear.font.color   := cl_black;
      infocom.font.color    := cl_black;
      infotag.font.color    := cl_black;
      infolength.font.color := cl_black;
      tbutton1.font.color   := cl_black;
      inforate.font.color   := cl_black;
      tracktag.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;

      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      tracktag.frame.font.color   := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
    end;
    with infosdfo2 do
    begin
      container.color       := $E7B0E8;
      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      infoyear.font.color   := cl_black;
      infocom.font.color    := cl_black;
      infotag.font.color    := cl_black;
      tbutton1.font.color   := cl_black;
      infolength.font.color := cl_black;
      inforate.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;
      tracktag.font.color   := cl_black;


      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      tracktag.frame.font.color   := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
    end;


    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.nodrums.frame.font.color    := cl_black;
    randomnotefo.withsharp.frame.font.color  := cl_black;
    randomnotefo.maxnote.frame.font.color    := cl_black;
    randomnotefo.bpm.frame.font.color        := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.boolminor.frame.font.color  := cl_black;
    randomnotefo.bosound.frame.font.color    := cl_black;
    randomnotefo.tbutton3.font.color         := cl_black;
    randomnotefo.tbutton5.font.color         := cl_black;
    randomnotefo.tbutton2.font.color         := cl_black;
    randomnotefo.bnbchords.font.color        := cl_black;
    randomnotefo.btnfixed.font.color         := cl_black;
    randomnotefo.tgroupbox1.frame.font.color := cl_black;
    randomnotefo.tgroupbox2.frame.font.color := cl_black;
    randomnotefo.tgroupbox3.frame.font.color := cl_black;

    // main

    songplayerfo.font.color  := thecolor1;
    songplayer2fo.font.color := thecolor2;

    {$if not defined(nofade)}
    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[1] := $FF7878;


 //    tfaceplayer.template.fade_color.items[0]    := $FFE8FF;
 //   tfaceplayer.template.fade_color.items[1]    := $E7B0E8;

    //tfaceplayerbut.template.fade_color.items[0] := $FFE8FF;
    //tfaceplayerbut.template.fade_color.items[1] := $E7B0E8;
    
    tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[1] := $E7B0E8;

    tfacebutltgray.template.fade_color.items[0] := $DADADA;
    tfacebutltgray.template.fade_color.items[1] := $D5D5D5;
 //   tfaceplayerlight.template.fade_color.items[0] := $FFDEEE;
 //   tfaceplayerlight.template.fade_color.items[1] := $FD9EFF;
    //tfaceplayerrev.template.fade_color.items[0] := $FFDEEE;
    //tfaceplayerrev.template.fade_color.items[1] := $FD9EFF;
 
    {$else}
    tfacegreen.template.fade_color.items[0]     := $C2FF9E;
    tfaceorange.template.fade_color.items[0]    := $FF9900;
    tfacered.template.fade_color.items[0]       := $FFC4C4;
    //  tfaceplayer.template.fade_color.items[0]    := $E7B0E8;
    //tfaceplayerbut.template.fade_color.items[0] := $E7B0E8;
    tfacebutgray.template.fade_color.items[0]   := $F2F2F2;
    tfacebutltgray.template.fade_color.items[0] := $D2D2D2;
    //   tfaceplayerlight.template.fade_color.items[0] := $E7BAE8;
    //tfaceplayerrev.template.fade_color.items[0] := $FFDEEE;
    {$endif}

    songplayerfo.tstringdisp1.font.color  := cl_black;
    songplayer2fo.tstringdisp1.font.color := cl_black;

    songplayerfo.lposition.font.color  := thecolor1;
    songplayer2fo.lposition.font.color := thecolor2;

    songplayerfo.llength.font.color  := thecolor1;
    songplayer2fo.llength.font.color := thecolor2;

    songplayerfo.waveformcheck.frame.font.color  := thecolor1;
    songplayer2fo.waveformcheck.frame.font.color := thecolor2;

    songplayerfo.playreverse.frame.font.color  := thecolor1;
    songplayer2fo.playreverse.frame.font.color := thecolor2;

    songplayerfo.tstringdisp2.font.color  := thecolor1;
    songplayer2fo.tstringdisp2.font.color := thecolor2;

    songplayerfo.button1.font.color  := thecolor1;
    songplayer2fo.button1.font.color := thecolor2;

    songplayerfo.button2.font.color  := thecolor1;
    songplayer2fo.button2.font.color := thecolor2;

    equalizerfo1.loadset.font.color   := thecolor1;
    equalizerfo2.loadset.font.color   := thecolor2;
    equalizerforec.loadset.font.color := thecolor1;

    equalizerfo1.saveset.font.color   := thecolor1;
    equalizerfo2.saveset.font.color   := thecolor2;
    equalizerforec.saveset.font.color := thecolor1;


    songplayerfo.tstringdisp1.color  := cl_black;
    songplayer2fo.tstringdisp1.color := cl_black;

    songplayerfo.playreverse.frame.font.color  := thecolor1;
    songplayer2fo.playreverse.frame.font.color := thecolor2;

    songplayerfo.setmono.frame.font.color  := thecolor1;
    songplayer2fo.setmono.frame.font.color := thecolor2;

    songplayerfo.setmono.colorglyph  := thecolor1;
    songplayer2fo.setmono.colorglyph := thecolor2;

    songplayerfo.playreverse.colorglyph  := thecolor1;
    songplayer2fo.playreverse.colorglyph := thecolor2;

    songplayerfo.edvolleft.frame.colorglyph  := thecolor1;
    songplayer2fo.edvolleft.frame.colorglyph := thecolor2;

    recorderfo.edvol.frame.colorglyph   := thecolor1;
    recorderfo.edvolr.frame.colorglyph  := thecolor1;
    recorderfo.edtempo.frame.colorglyph := thecolor2;

    songplayerfo.edvolright.frame.colorglyph  := thecolor1;
    songplayer2fo.edvolright.frame.colorglyph := thecolor2;
    songplayerfo.edtempo.frame.colorglyph     := thecolor1;
    songplayer2fo.edtempo.frame.colorglyph    := thecolor2;

    songplayerfo.edpitch.frame.colorglyph  := thecolor1;
    songplayer2fo.edpitch.frame.colorglyph := thecolor2;

    recorderfo.edvol.frame.colorglyph   := thecolor1;
    recorderfo.edvolr.frame.colorglyph  := thecolor1;
    recorderfo.edtempo.frame.colorglyph := thecolor1;

    waveforec.trackbar1.color := $FCD4FB;

    waveforec.sliderimage.bitmap.Canvas.color := $FCD4FB;

    songplayerfo.historyfn.frame.button.colorglyph  := thecolor1;
    songplayer2fo.historyfn.frame.button.colorglyph := thecolor2;

    songplayerfo.historyfn.dropdown.colorclient  := ltblank;
    songplayer2fo.historyfn.dropdown.colorclient := ltblank;

    songplayerfo.historyfn.font.color  := thecolor1;
    songplayer2fo.historyfn.font.color := thecolor2;
    songplayerfo.edvolleft.font.color  := thecolor1;
    songplayer2fo.edvolleft.font.color := thecolor2;

    recorderfo.edvol.font.color   := ltblack;
    recorderfo.edvolr.font.color  := ltblack;
    recorderfo.edtempo.font.color := ltblack;

    songplayerfo.edvolright.font.color  := thecolor1;
    songplayer2fo.edvolright.font.color := thecolor2;
    songplayerfo.edtempo.font.color     := thecolor1;
    songplayer2fo.edtempo.font.color    := thecolor2;

    songplayerfo.edpitch.font.color  := thecolor1;
    songplayer2fo.edpitch.font.color := thecolor2;

    songplayerfo.btinfos.font.color  := thecolor1;
    songplayer2fo.btinfos.font.color := thecolor2;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $FFC2F5;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $FD9EFF;
    songplayer2fo.tfaceslider.template.fade_color.items[0] := $FFC2F5;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $FD9EFF;


    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    drumsfo.multbpm.font.color := ltblack;
    drumsfo.divbpm.font.color  := ltblack;

    drumsfo.edittempo.frame.colorglyph   := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;

    drumsfo.sensib.frame.colorglyph := ltblack;

    //drumsfo.tfacedrums.template.fade_color.items[0] := $FFEBFD;
    //drumsfo.tfacedrums.template.fade_color.items[1] := $E7B0E8;
    drumsfo.ltempo.font.color          := ltblack;
    drumsfo.novoice.frame.font.color   := ltblack;
    drumsfo.langcount.frame.font.color := ltblack;
    drumsfo.langcount.font.color       := ltblack;
    drumsfo.langcount.dropdown.colorclient := ltblank;

    drumsfo.langcount.frame.button.colorglyph := ltblack;


    drumsfo.noand.frame.font.color   := ltblack;
    drumsfo.nodrums.frame.font.color := ltblack;
    drumsfo.noanim.frame.font.color  := ltblack;
    drumsfo.tlabel21.font.color      := ltblack;
    drumsfo.tlabel22.font.color      := ltblack;
    drumsfo.tlabel25.font.color      := ltblack;
    drumsfo.tlabel23.font.color      := ltblack;

    drumsfo.tstringdisp2.font.color := ltblack;

    // rev
    //  drumsfo.tfacecomp2.template.fade_color.items[0] := $FFEBFD;
    //  drumsfo.tfacecomp2.template.fade_color.items[1] := $E7B0E8;

    // light
    //  drumsfo.tfacecomp3.template.fade_color.items[0] := $FFEBFD;
    // drumsfo.tfacecomp3.template.fade_color.items[1] := $E7B0E8;

    // recorder
    recorderfo.font.color := ltblack;

    // recorderfo.tfacerecorder.template.fade_color.items[0] := $FFE3E3;
    //  recorderfo.tfacerecorder.template.fade_color.items[1] := $DA9D9D;

    recorderfo.cbloop.colorglyph      := ltblack;
    recorderfo.cbtempo.colorglyph     := ltblack;
    recorderfo.bsavetofile.colorglyph := ltblack;
    recorderfo.sentcue1.colorglyph    := ltblack;

    recorderfo.bwav.colorglyph       := ltblack;
    recorderfo.bogg.colorglyph       := ltblack;
    recorderfo.bwav.frame.font.color := ltblack;
    recorderfo.bogg.frame.font.color := ltblack;

    recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.historyfn.frame.button.colorglyph := ltblack;

    recorderfo.historyfn.dropdown.colorclient := ltblank;

    recorderfo.cbloop.frame.font.color      := ltblack;
    recorderfo.cbtempo.frame.font.color     := ltblack;
    recorderfo.bsavetofile.frame.font.color := ltblack;
    recorderfo.sentcue1.frame.font.color    := ltblack;
    recorderfo.blistenin.frame.font.color   := ltblack;
    recorderfo.btinfos.font.color           := ltblack;
    recorderfo.button1.font.color           := ltblack;
    recorderfo.tstringdisp2.font.color      := ltblack;
    recorderfo.llength.font.color           := ltblack;
    recorderfo.lposition.font.color         := ltblack;

    // rev
    //recorderfo.tfacerecrev.template.fade_color.items[0] := $FFEBFD;
    //recorderfo.tfacerecrev.template.fade_color.items[1] := $E7B0E8;

    // light
    // recorderfo.tfacereclight.template.fade_color.items[0] := $FFEBFD;
    // recorderfo.tfacereclight.template.fade_color.items[1] := $E7B0E8;

    // guitar

    guitarsfo.font.color          := ltblack;
    guitarsfo.tgroupbox1.font.color := ltblack;
    guitarsfo.tgroupbox2.font.color := ltblack;
    guitarsfo.loopguit.colorglyph := ltblack;
    guitarsfo.loopbass.colorglyph := ltblack;
    guitarsfo.loopguit.frame.font.color := ltblack;
    guitarsfo.loopbass.frame.font.color := ltblack;
    guitarsfo.tstringdisp2.font.color := ltblack;
    guitarsfo.tstringdisp3.font.color := ltblack;

{
    guitarsfo.tfaceguit.template.fade_color.items[0] := $FFE6FF;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $FFB2FF;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $FFE6FF;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $FFB2FF;
}
    // Equalizer
    with equalizerfo1 do
    begin
      fond.color := $E7B0E8;

      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;
      EQEN.frame.font.color := thecolor1;
      EQEN.frame.colorclient := $E7B0E8;
      EQEN.color := $E7B0E8;
    end;

    with equalizerfo2 do
    begin
      fond.color      := $E7B0E8;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;

      font.color           := thecolor2;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;


      EQEN.frame.font.color := ltblack;
      EQEN.frame.colorclient := $E7B0E8;
      EQEN.color := $E7B0E8;
    end;

    with equalizerforec do
    begin
      // loadset.face.template := recorderfo.tfacerecorder;
      // saveset.face.template := recorderfo.tfacerecorder;
      fond.color      := $E7B0E8;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;

      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      EQEN.frame.colorclient := $E7B0E8;
      EQEN.color := $E7B0E8;
      EQEN.frame.font.color := cl_black;
      //  EQEN.face.template := recorderfo.tfacerecorder;
    end;

    for x := 1 to 20 do
    begin
      abuttons[x].font.color  := thecolor1;
      abuttons2[x].font.color := thecolor2;
      abuttonsR[x].font.color := ltblack;

    end;

    // commander
    commanderfo.nameplayers.font.color      := ltblack;
    commanderfo.nameplayers2.font.color     := ltblack;
    commanderfo.namedrums.font.color        := ltblack;
    commanderfo.namegen.font.color          := ltblack;
    commanderfo.nameinput.font.color        := ltblack;
    commanderfo.genleftvolvalue.font.color  := ltblack;
    commanderfo.genrightvolvalue.font.color := ltblack;
    commanderfo.sysvolbut.font.color        := ltblack;

    commanderfo.volumeleft1val.font.color := ltblack;
    commanderfo.volumeleft2val.font.color := ltblack;

    commanderfo.volumeright1val.font.color := ltblack;
    commanderfo.volumeright2val.font.color := ltblack;

    commanderfo.tslider2val.font.color := ltblack;
    commanderfo.tslider3val.font.color := ltblack;


    commanderfo.butinput.colorglyph       := ltblack;
    commanderfo.butinput.frame.font.color := ltblack;

    commanderfo.timemix.font.color := ltblack;

    commanderfo.timemix.frame.colorglyph := ltblack;

    // commanderfo.tfacegriptab.template.fade_color.items[0] := $F8DEFF;
    // commanderfo.tfacegriptab.template.fade_color.items[1] := $CEB2D6;

    commanderfo.timemix.frame.font.color := ltblack;

    filelistfo.list_files.font.color          := ltblack;
    filelistfo.tgroupbox1.font.color          := ltblack;
    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.historyfn.dropdown.colorclient := ltblank;
    filelistfo.list_files.datacols[0].color   := $FFEBFD;
    filelistfo.list_files.datacols[0].font.color := ltblack;
    filelistfo.list_files.datacols[1].color   := $FFEBFD;
    filelistfo.list_files.datacols[1].font.color := ltblack;
    filelistfo.list_files.datacols[2].color   := $FFEBFD;
    filelistfo.list_files.datacols[2].font.color := ltblack;
    filelistfo.list_files.datacols[3].color   := $FFEBFD;
    filelistfo.list_files.datacols[3].font.color := ltblack;
    filelistfo.list_files.datacols[3].colorselect := $EDEDED;
    filelistfo.list_files.datacols[3].colorglyph := ltblack;

    filelistfo.list_files.datacols[0].colorselect := $FFC87A;
    filelistfo.list_files.datacols[1].colorselect := $FFC87A;
    filelistfo.list_files.datacols[2].colorselect := $FFC87A;

    aboutfo.font.color := cl_black;

    with spectrum1fo do
    begin
      tchartleft.color           := $E7B0E8;
      tchartleft.colorchart      := $E7B0E8;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color := configlayoutfo.tcoloredit1.Value;

      tchartright.color      := $E7B0E8;
      tchartright.colorchart := $E7B0E8;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := configlayoutfo.tcoloredit1.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit2.Value;

      fond.color      := $E7B0E8;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;
      spect1.frame.font.color := thecolor1;
      groupbox1.frame.font.color := thecolor1;
      groupbox2.frame.font.color := thecolor1;
      spect1.frame.colorclient := cl_default;
      spect1.color    := $E7B0E8;
    end;

    with spectrum2fo do
    begin
      tchartleft.color      := $E7B0E8;
      tchartleft.colorchart := $E7B0E8;
      tchartleft.traces[0].chartkind := tck_bar;

      tchartright.color      := $E7B0E8;
      tchartright.colorchart := $E7B0E8;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := configlayoutfo.tcoloredit12.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit22.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      fond.color      := $E7B0E8;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;
      spect1.frame.font.color := thecolor2;
      groupbox1.frame.font.color := thecolor2;
      groupbox2.frame.font.color := thecolor2;
      spect1.frame.colorclient := thecolor2;
      spect1.color    := $E7B0E8;
    end;

    with spectrumrecfo do
    begin
      tchartleft.colorchart          := $E7B0E8;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color     := $E7B0E8;

      tchartleft.color  := $E7B0E8;
      tchartright.color := $E7B0E8;

      tchartright.colorchart          := $E7B0E8;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := $C69EFF;
      tchartright.traces[0].bar_face.fade_color.items[1] := $C69EFF;
      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      tchartright.traces[0].color := $C69EFF;
      fond.color      := $E7B0E8;
      groupbox1.color := $E7B0E8;
      groupbox2.color := $E7B0E8;
      spect1.frame.font.color := ltblack;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color    := $E7B0E8;

      //  spect1.face.template := recorderfo.tfacerecorder;
    end;

    songplayerfo.btnresume.imagenrdisabled  := -2;
    songplayer2fo.btnresume.imagenrdisabled := -2;
    songplayerfo.btncue.imagenrdisabled     := -2;
    songplayer2fo.btncue.imagenrdisabled    := -2;
    songplayerfo.btnstart.imagenrdisabled   := -2;
    songplayer2fo.btnstart.imagenrdisabled  := -2;
    songplayerfo.btnpause.imagenrdisabled   := -2;
    songplayer2fo.btnpause.imagenrdisabled  := -2;
    songplayerfo.btnstop.imagenrdisabled    := -2;
    songplayer2fo.btnstop.imagenrdisabled   := -2;

    commanderfo.btnresume.imagenrdisabled   := -2;
    commanderfo.btnresume2.imagenrdisabled  := -2;
    commanderfo.btncue.imagenrdisabled      := -2;
    commanderfo.btncue2.imagenrdisabled     := -2;
    commanderfo.btnstart.imagenrdisabled    := -2;
    commanderfo.btnstart2.imagenrdisabled   := -2;
    commanderfo.btnpause.imagenrdisabled    := -2;
    commanderfo.btnpause2.imagenrdisabled   := -2;
    commanderfo.btnstop.imagenrdisabled     := -2;
    commanderfo.btnstop2.imagenrdisabled    := -2;
    commanderfo.loop_start.imagenrdisabled  := -2;
    commanderfo.loop_stop.imagenrdisabled   := -2;
    commanderfo.loop_resume.imagenrdisabled := -2;

    recorderfo.btnresume.imagenrdisabled := -2;
    recorderfo.tbutton2.imagenrdisabled  := -2;
    recorderfo.btnstart.imagenrdisabled  := -2;
    recorderfo.btnpause.imagenrdisabled  := -2;
    recorderfo.btnstop.imagenrdisabled   := -2;

    drumsfo.loop_resume.imagenrdisabled := -2;
    drumsfo.loop_start.imagenrdisabled  := -2;
    drumsfo.loop_stop.imagenrdisabled   := -2;

  end;

  ///

  if typecolor.Value = 0 then
  begin

    font.color          := cl_black;
    synthefo.font.color := cl_black;
    pianofo.font.color  := cl_black;
    synthefo.tgroupbox4.font.color := cl_black;
    synthefo.tgroupbox3.font.color := cl_black;
    filelistfo.historyfn.font.color := cl_black;

    synthefo.color := $DBDFB8;
    pianofo.color  := $DBDFB8;

    songplayerfo.edvolleft.font.color   := cl_black;
    songplayerfo.edvolright.font.color  := cl_black;
    songplayer2fo.edvolleft.font.color  := cl_black;
    songplayer2fo.edvolright.font.color := cl_black;

    songplayerfo.historyfn.font.color  := cl_black;
    songplayer2fo.historyfn.font.color := cl_black;

    songplayerfo.cbloopb.font.color  := cl_black;
    songplayer2fo.cbloopb.font.color := cl_black;

    songplayerfo.playreverseb.font.color  := cl_black;
    songplayer2fo.playreverseb.font.color := cl_black;

    songplayerfo.waveformcheckb.font.color  := cl_black;
    songplayer2fo.waveformcheckb.font.color := cl_black;

    songplayerfo.setmonob.font.color  := cl_black;
    songplayer2fo.setmonob.font.color := cl_black;

    songplayerfo.cbtempob.font.color  := cl_black;
    songplayer2fo.cbtempob.font.color := cl_black;

    songplayerfo.historyfn.dropdown.cols[0].colorselect  := $FFCD8F;
    songplayer2fo.historyfn.dropdown.cols[0].colorselect := $FFCD8F;

    commanderfo.Brandommix.font.color  := cl_black;
    commanderfo.linkvolgenb.font.color := cl_black;
    commanderfo.linkvolb.font.color    := cl_black;
    commanderfo.speccalcb.font.color   := cl_black;
    commanderfo.guimixb.font.color     := cl_black;
    commanderfo.linkvol2b.font.color   := cl_black;
    commanderfo.automixb.font.color    := cl_black;
    commanderfo.vuinb.font.color       := cl_black;
    commanderfo.directmixb.font.color  := cl_black;

    dockpanel1fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel2fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel3fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel4fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel5fo.tmainmenu1.menu.font.color := cl_black;

    wavefo.tmainmenu1.menu.font.color    := cl_black;
    wavefo2.tmainmenu1.menu.font.color   := cl_black;
    waveforec.tmainmenu1.menu.font.color := cl_black;

    dockpanel1fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel2fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel3fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel4fo.basedock.dragdock.splitter_color := $B7BA8F;
    dockpanel5fo.basedock.dragdock.splitter_color := $B7BA8F;

    basedock.dragdock.splitter_color := $B7BA8F;

    wavefo.echelle.datacols.font.color := cl_black;
    wavefo.echelle.datacols.color      := $B7BA8F;
    wavefo.echelle.datacols.font.colorbackground := $B7BA8F;

    wavefo2.echelle.datacols.font.color := cl_black;
    wavefo2.echelle.datacols.color      := $B7BA8F;
    wavefo2.echelle.datacols.font.colorbackground := $B7BA8F;

    dialogfilesfo.list_files.frame.colorclient := $F9FFC2;

    filelistfo.historyfn.dropdown.cols[0].colorselect := $FFC782;

    wavefo.container.color  := cl_default;
    wavefo2.container.color := cl_default;

    spectrum1fo.container.color   := cl_default;
    spectrum2fo.container.color   := cl_default;
    spectrumrecfo.container.color := cl_default;
    commanderfo.container.color   := cl_default;
    guitarsfo.container.color     := cl_default;

    filelistfo.list_files.fixrows.color          := cl_default;
    filelistfo.list_files.fixrows[-1].font.color := cl_default;

    filelistfo.list_files.fixcols.color           := cl_default;
    filelistfo.list_files.fixcols[-1].font.color  := cl_default;
    filelistfo.list_files.fixcols[-1].colorselect := cl_ltgray;

    for x := 0 to filelistfo.list_files.rowcount - 1 do
      filelistfo.list_files.rowfontstate[x] := 0;

    filelistfo.list_files.datacols.colorselect := $FFC87A;

    tmainmenu1.menu.font.color := cl_black;
    tmainmenu1.menu.colorglyph := cl_black;
    tmainmenu1.menu.colorglyphactive := cl_black;
    wavefo.tmainmenu1.menu.colorglyph := thecolor1;
    wavefo.tmainmenu1.menu.colorglyphactive := thecolor1;
    waveforec.tmainmenu1.menu.colorglyph := cl_black;
    waveforec.tmainmenu1.menu.colorglyphactive := cl_black;
    wavefo2.tmainmenu1.menu.colorglyph := thecolor1;
    wavefo2.tmainmenu1.menu.colorglyphactive := thecolor2;
    randomnotefo.color := $DED9D1;
    randomnotefo.tstringdisp1.font.color := cl_black;
    randomnotefo.bchord1.font.color := cl_black;
    randomnotefo.bchord2.font.color := cl_black;
    randomnotefo.bchord3.font.color := cl_black;
    randomnotefo.bchord4.font.color := cl_black;
    randomnotefo.bchord5.font.color := cl_black;

    filelistfo.container.color := $D2D8A5;
    filelistfo.color           := $D2D8A5;

    songplayerfo.historyfn.frame.button.color := $D2D8A5;
    songplayerfo.edvolleft.color  := $D2D8A5;
    songplayerfo.edvolleft.frame.colorbutton := $D2D8A5;
    songplayerfo.edvolright.color := $D2D8A5;
    songplayerfo.edvolright.frame.colorbutton := $D2D8A5;
    songplayerfo.edtempo.color    := $D2D8A5;
    songplayerfo.edtempo.frame.colorbutton := $D2D8A5;

    songplayerfo.edpitch.color  := $D2D8A5;
    songplayerfo.edpitch.frame.colorbutton := $D2D8A5;
    songplayer2fo.edpitch.color := $D2D8A5;
    songplayer2fo.edpitch.frame.colorbutton := $D2D8A5;

    songplayer2fo.historyfn.frame.button.color := $D2D8A5;
    songplayer2fo.edvolleft.color  := $D2D8A5;
    songplayer2fo.edvolleft.frame.colorbutton := $D2D8A5;
    songplayer2fo.edvolright.color := $D2D8A5;
    songplayer2fo.edvolright.frame.colorbutton := $D2D8A5;
    songplayer2fo.edtempo.color    := $D2D8A5;
    songplayer2fo.edtempo.frame.colorbutton := $D2D8A5;

    recorderfo.edtempo.color := $D2D8A5;
    recorderfo.edtempo.frame.colorbutton := $D2D8A5;

    commanderfo.timemix.frame.colorbutton := $D2D8A5;
    commanderfo.timemix.color := $D2D8A5;

    filelistfo.container.color := $D2D8A5;
    filelistfo.color           := $D2D8A5;
    filelistfo.list_files.face.fade_color.items[0] := $D2D8A5;

    filelistfo.historyfn.frame.button.color := $D2D8A5;

    wavefo.trackbar1.color    := $D2D8A5;
    wavefo2.trackbar1.color   := $D2D8A5;
    waveforec.trackbar1.color := $D2D8A5;

    with infosdfo do
    begin
      container.color       := $D2D8A5;
      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      infoyear.font.color   := cl_black;
      infocom.font.color    := cl_black;
      tbutton1.font.color   := cl_black;
      infotag.font.color    := cl_black;
      infolength.font.color := cl_black;
      tbutton1.font.color   := cl_black;
      inforate.font.color   := cl_black;
      tracktag.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;

      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      tracktag.frame.font.color   := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
    end;
    with infosdfo2 do
    begin
      container.color       := $D2D8A5;
      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      infoyear.font.color   := cl_black;
      tbutton1.font.color   := cl_black;
      infocom.font.color    := cl_black;
      infotag.font.color    := cl_black;
      infolength.font.color := cl_black;
      inforate.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;
      tracktag.font.color   := cl_black;


      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      tracktag.frame.font.color   := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
    end;


    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.nodrums.frame.font.color    := cl_black;
    randomnotefo.withsharp.frame.font.color  := cl_black;
    randomnotefo.maxnote.frame.font.color    := cl_black;
    randomnotefo.bpm.frame.font.color        := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.boolminor.frame.font.color  := cl_black;
    randomnotefo.bosound.frame.font.color    := cl_black;
    randomnotefo.tbutton3.font.color         := cl_black;
    randomnotefo.tbutton5.font.color         := cl_black;
    randomnotefo.tbutton2.font.color         := cl_black;
    randomnotefo.bnbchords.font.color        := cl_black;
    randomnotefo.btnfixed.font.color         := cl_black;
    randomnotefo.tgroupbox1.frame.font.color := cl_black;
    randomnotefo.tgroupbox2.frame.font.color := cl_black;
    randomnotefo.tgroupbox3.frame.font.color := cl_black;


    // main
    songplayerfo.font.color  := thecolor1;
    songplayer2fo.font.color := thecolor2;


     {$if not defined(nofade)} 
   
    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[1] := $FF7878;

  //  tfaceplayer.template.fade_color.items[0]    := $F9FFC2;
  //  tfaceplayer.template.fade_color.items[1]    := $C4C999;
   
    //tfaceplayerbut.template.fade_color.items[0] := $F9FFC2;
    //tfaceplayerbut.template.fade_color.items[1] := $C4C999;

    tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[1] := $9E9E9E;

    tfacebutltgray.template.fade_color.items[0] := $DADADA;
    tfacebutltgray.template.fade_color.items[1] := $D2D2D2;
    
//    tfaceplayerlight.template.fade_color.items[0] := $EBEDDA;
//    tfaceplayerlight.template.fade_color.items[1] := $D2D6A3;

    //tfaceplayerrev.template.fade_color.items[0] := $C4C999;
    //tfaceplayerrev.template.fade_color.items[1] := $F3FABE;
 
    {$else}

    //   tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[0] := $C2FF9E;

    //  tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[0] := $FF9900;

    // tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[0] := $FF7878;

    // tfaceplayer.template.fade_color.items[0]    := $C4C999;
    //  tfaceplayer.template.fade_color.items[0]    := $C4C999;
    //  tfaceplayerbut.template.fade_color.items[0] := $C4C999;
    //tfaceplayerbut.template.fade_color.items[0] := $C4C999;

    //  tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[0] := $F2F2F2;

    //  tfacebutltgray.template.fade_color.items[0] := $FAFAFA;
    tfacebutltgray.template.fade_color.items[0] := $D2D2D2;

    //   tfaceplayerlight.template.fade_color.items[0] := $FDFFEB;
    //  tfaceplayerlight.template.fade_color.items[0] := $CFD4A1;

    //  tfaceplayerrev.template.fade_color.items[0] := $C4C999;
    //tfaceplayerrev.template.fade_color.items[0] := $F3FABE;


    {$endif}

    songplayerfo.tstringdisp1.font.color  := cl_black;
    songplayer2fo.tstringdisp1.font.color := cl_black;

    songplayerfo.lposition.font.color  := thecolor1;
    songplayer2fo.lposition.font.color := thecolor2;

    songplayerfo.llength.font.color  := thecolor1;
    songplayer2fo.llength.font.color := thecolor2;

    songplayerfo.waveformcheck.frame.font.color  := thecolor1;
    songplayer2fo.waveformcheck.frame.font.color := thecolor2;

    songplayerfo.playreverse.frame.font.color  := thecolor1;
    songplayer2fo.playreverse.frame.font.color := thecolor2;

    songplayerfo.tstringdisp2.font.color  := thecolor1;
    songplayer2fo.tstringdisp2.font.color := thecolor2;

    songplayerfo.button1.font.color  := thecolor1;
    songplayer2fo.button1.font.color := thecolor2;

    songplayerfo.button2.font.color  := thecolor1;
    songplayer2fo.button2.font.color := thecolor2;

    equalizerfo1.loadset.font.color   := thecolor1;
    equalizerfo2.loadset.font.color   := thecolor2;
    equalizerforec.loadset.font.color := thecolor1;

    equalizerfo1.saveset.font.color   := thecolor1;
    equalizerfo2.saveset.font.color   := thecolor2;
    equalizerforec.saveset.font.color := thecolor1;


    songplayerfo.tstringdisp1.color  := cl_black;
    songplayer2fo.tstringdisp1.color := cl_black;

    songplayerfo.playreverse.frame.font.color  := thecolor1;
    songplayer2fo.playreverse.frame.font.color := thecolor2;

    songplayerfo.setmono.frame.font.color  := thecolor1;
    songplayer2fo.setmono.frame.font.color := thecolor2;

    songplayerfo.setmono.colorglyph  := thecolor1;
    songplayer2fo.setmono.colorglyph := thecolor2;

    songplayerfo.playreverse.colorglyph  := thecolor1;
    songplayer2fo.playreverse.colorglyph := thecolor2;

    songplayerfo.edvolleft.frame.colorglyph  := thecolor1;
    songplayer2fo.edvolleft.frame.colorglyph := thecolor2;

    recorderfo.edvol.frame.colorglyph   := thecolor1;
    recorderfo.edvolr.frame.colorglyph  := thecolor1;
    recorderfo.edtempo.frame.colorglyph := thecolor2;

    songplayerfo.edvolright.frame.colorglyph  := thecolor1;
    songplayer2fo.edvolright.frame.colorglyph := thecolor2;
    songplayerfo.edtempo.frame.colorglyph     := thecolor1;
    songplayer2fo.edtempo.frame.colorglyph    := thecolor2;

    songplayerfo.edpitch.frame.colorglyph  := thecolor1;
    songplayer2fo.edpitch.frame.colorglyph := thecolor2;

    recorderfo.edvol.frame.colorglyph   := ltblack;
    recorderfo.edvolr.frame.colorglyph  := ltblack;
    recorderfo.edtempo.frame.colorglyph := ltblack;

    waveforec.trackbar1.color := $D2D8A5;

    waveforec.sliderimage.bitmap.Canvas.color := $D2D8A5;

    songplayerfo.historyfn.frame.button.colorglyph  := thecolor1;
    songplayer2fo.historyfn.frame.button.colorglyph := thecolor2;

    songplayerfo.historyfn.dropdown.colorclient  := ltblank;
    songplayer2fo.historyfn.dropdown.colorclient := ltblank;

    songplayerfo.historyfn.font.color  := thecolor1;
    songplayer2fo.historyfn.font.color := thecolor2;
    songplayerfo.edvolleft.font.color  := thecolor1;
    songplayer2fo.edvolleft.font.color := thecolor2;

    recorderfo.edvol.font.color   := ltblack;
    recorderfo.edvolr.font.color  := ltblack;
    recorderfo.edtempo.font.color := ltblack;

    songplayerfo.edpitch.font.color  := thecolor1;
    songplayer2fo.edpitch.font.color := thecolor2;

    songplayerfo.edvolright.font.color  := thecolor1;
    songplayer2fo.edvolright.font.color := thecolor2;
    songplayerfo.edtempo.font.color     := thecolor1;
    songplayer2fo.edtempo.font.color    := thecolor2;

    songplayerfo.btinfos.font.color  := thecolor1;
    songplayer2fo.btinfos.font.color := thecolor2;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $F9FFC2;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $C4C999;
    songplayer2fo.tfaceslider.template.fade_color.items[0] := $F9FFC2;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $C4C999;


    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    drumsfo.multbpm.font.color := ltblack;
    drumsfo.divbpm.font.color  := ltblack;

    drumsfo.edittempo.frame.colorglyph   := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;

    drumsfo.sensib.frame.colorglyph := ltblack;

    // drumsfo.tfacedrums.template.fade_color.items[0] := $9AAD97;
    // drumsfo.tfacedrums.template.fade_color.items[1] := $D6F0D1;
    drumsfo.ltempo.font.color          := ltblack;
    drumsfo.novoice.frame.font.color   := ltblack;
    drumsfo.langcount.frame.font.color := ltblack;
    drumsfo.langcount.font.color       := ltblack;
    drumsfo.langcount.dropdown.colorclient := ltblank;

    drumsfo.langcount.frame.button.colorglyph := ltblack;


    drumsfo.noand.frame.font.color   := ltblack;
    drumsfo.nodrums.frame.font.color := ltblack;
    drumsfo.noanim.frame.font.color  := ltblack;
    drumsfo.tlabel21.font.color      := ltblack;
    drumsfo.tlabel22.font.color      := ltblack;
    drumsfo.tlabel25.font.color      := ltblack;
    drumsfo.tlabel23.font.color      := ltblack;

    drumsfo.tstringdisp2.font.color := ltblack;

    // rev
    //   drumsfo.tfacecomp2.template.fade_color.items[0] := $D6F0D1;
    //  drumsfo.tfacecomp2.template.fade_color.items[1] := $9CAF99;

    // light
    //  drumsfo.tfacecomp3.template.fade_color.items[0] := $F9FFF7;
    //  drumsfo.tfacecomp3.template.fade_color.items[1] := $BCD4B8;

    // recorder
    recorderfo.font.color := ltblack;

    //   recorderfo.tfacerecorder.template.fade_color.items[0] := $FFE3E3;
    //   recorderfo.tfacerecorder.template.fade_color.items[1] := $DA9D9D;

    recorderfo.cbloop.colorglyph      := ltblack;
    recorderfo.cbtempo.colorglyph     := ltblack;
    recorderfo.bsavetofile.colorglyph := ltblack;
    recorderfo.sentcue1.colorglyph    := ltblack;

    recorderfo.bwav.colorglyph       := ltblack;
    recorderfo.bogg.colorglyph       := ltblack;
    recorderfo.bwav.frame.font.color := ltblack;
    recorderfo.bogg.frame.font.color := ltblack;

    recorderfo.blistenin.colorglyph := ltblack;

    recorderfo.historyfn.frame.button.colorglyph := ltblack;

    recorderfo.historyfn.dropdown.colorclient := ltblank;

    recorderfo.cbloop.frame.font.color      := ltblack;
    recorderfo.cbtempo.frame.font.color     := ltblack;
    recorderfo.bsavetofile.frame.font.color := ltblack;
    recorderfo.sentcue1.frame.font.color    := ltblack;
    recorderfo.blistenin.frame.font.color   := ltblack;
    recorderfo.btinfos.font.color           := ltblack;
    recorderfo.button1.font.color           := ltblack;
    recorderfo.tstringdisp2.font.color      := ltblack;
    recorderfo.llength.font.color           := ltblack;
    recorderfo.lposition.font.color         := ltblack;

    // rev
    // recorderfo.tfacerecrev.template.fade_color.items[0] := $D9C1C1;
    // recorderfo.tfacerecrev.template.fade_color.items[1] := $FFE3E3;

    // light
    // recorderfo.tfacereclight.template.fade_color.items[0] := $FFF7F7;
    // recorderfo.tfacereclight.template.fade_color.items[1] := $EDD3D3;

    // guitar

    guitarsfo.font.color          := ltblack;
    guitarsfo.tgroupbox1.font.color := ltblack;
    guitarsfo.tgroupbox2.font.color := ltblack;
    guitarsfo.loopguit.colorglyph := ltblack;
    guitarsfo.loopbass.colorglyph := ltblack;
    guitarsfo.loopguit.frame.font.color := ltblack;
    guitarsfo.loopbass.frame.font.color := ltblack;
    guitarsfo.tstringdisp2.font.color := ltblack;
    guitarsfo.tstringdisp3.font.color := ltblack;
{
    guitarsfo.tfaceguit.template.fade_color.items[0] := $F5EADA;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $BFB7AA;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $DBD3C3;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $FFF5E3;
}
    // Equalizer
    with equalizerfo1 do
    begin
      fond.color := $D2D8A5;

      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color        := $D2D8A5;
      groupbox2.color        := $D2D8A5;
      EQEN.frame.font.color  := thecolor1;
      EQEN.frame.colorclient := $D2D8A5;

      EQEN.color := $D2D8A5;
    end;

    with equalizerfo2 do
    begin
      fond.color      := $D2D8A5;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;

      font.color           := thecolor2;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;


      EQEN.frame.font.color := ltblack;
      EQEN.frame.colorclient := $D2D8A5;
      EQEN.color := $D2D8A5;
    end;

    with equalizerforec do
    begin
      //  loadset.face.template := recorderfo.tfacerecorder;
      //  saveset.face.template := recorderfo.tfacerecorder;
      fond.color      := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;

      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      EQEN.frame.colorclient := $D2D8A5;
      EQEN.color := $D2D8A5;
      EQEN.frame.font.color := cl_black;
      //  EQEN.face.template := recorderfo.tfacerecorder;
    end;

    for x := 1 to 20 do
    begin
      abuttons[x].font.color  := thecolor1;
      abuttons2[x].font.color := thecolor2;
      abuttonsR[x].font.color := ltblack;
    end;

    // commander
    commanderfo.nameplayers.font.color      := ltblack;
    commanderfo.nameplayers2.font.color     := ltblack;
    commanderfo.namedrums.font.color        := ltblack;
    commanderfo.namegen.font.color          := ltblack;
    commanderfo.nameinput.font.color        := ltblack;
    commanderfo.genleftvolvalue.font.color  := ltblack;
    commanderfo.genrightvolvalue.font.color := ltblack;
    commanderfo.sysvolbut.font.color        := ltblack;

    commanderfo.volumeleft1val.font.color := ltblack;
    commanderfo.volumeleft2val.font.color := ltblack;

    commanderfo.volumeright1val.font.color := ltblack;
    commanderfo.volumeright2val.font.color := ltblack;

    commanderfo.tslider2val.font.color := ltblack;
    commanderfo.tslider3val.font.color := ltblack;


    commanderfo.butinput.colorglyph       := ltblack;
    commanderfo.butinput.frame.font.color := ltblack;

    commanderfo.timemix.font.color := ltblack;

    commanderfo.timemix.frame.colorglyph := ltblack;

    //  commanderfo.tfacegriptab.template.fade_color.items[0] := $F8DEFF;
    //  commanderfo.tfacegriptab.template.fade_color.items[1] := $CEB2D6;

    commanderfo.timemix.frame.font.color := ltblack;

    filelistfo.list_files.font.color          := ltblack;
    filelistfo.tgroupbox1.font.color          := ltblack;
    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.historyfn.dropdown.colorclient := ltblank;
    filelistfo.list_files.datacols[0].color   := $FEFFF7;
    filelistfo.list_files.datacols[0].font.color := ltblack;
    filelistfo.list_files.datacols[1].color   := $FEFFF7;
    filelistfo.list_files.datacols[1].font.color := ltblack;
    filelistfo.list_files.datacols[2].color   := $FEFFF7;
    filelistfo.list_files.datacols[2].font.color := ltblack;
    filelistfo.list_files.datacols[3].color   := $FEFFF7;
    filelistfo.list_files.datacols[3].font.color := ltblack;
    filelistfo.list_files.datacols[3].colorselect := $EDEDED;
    filelistfo.list_files.datacols[3].colorglyph := ltblack;

    filelistfo.list_files.datacols[0].colorselect := $FFC87A;
    filelistfo.list_files.datacols[1].colorselect := $FFC87A;
    filelistfo.list_files.datacols[2].colorselect := $FFC87A;

    aboutfo.font.color := cl_black;

    with spectrum1fo do
    begin
      tchartleft.color           := $D2D8A5;
      tchartleft.colorchart      := $D2D8A5;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color := configlayoutfo.tcoloredit1.Value;

      tchartright.color      := $D2D8A5;
      tchartright.colorchart := $D2D8A5;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := configlayoutfo.tcoloredit1.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit2.Value;

      fond.color      := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      spect1.frame.font.color := thecolor1;
      groupbox1.frame.font.color := thecolor1;
      groupbox2.frame.font.color := thecolor1;
      spect1.frame.colorclient := cl_default;
      spect1.color    := $D2D8A5;
    end;

    with spectrum2fo do
    begin
      tchartleft.color      := $D2D8A5;
      tchartleft.colorchart := $D2D8A5;
      tchartleft.traces[0].chartkind := tck_bar;

      tchartright.color      := $D2D8A5;
      tchartright.colorchart := $D2D8A5;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := configlayoutfo.tcoloredit12.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit22.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      fond.color      := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      spect1.frame.font.color := thecolor2;
      groupbox1.frame.font.color := thecolor2;
      groupbox2.frame.font.color := thecolor2;
      spect1.frame.colorclient := thecolor2;
      spect1.color    := $D2D8A5;
    end;

    with spectrumrecfo do
    begin
      tchartleft.colorchart          := $D2D8A5;
      tchartleft.traces[0].chartkind := tck_bar;
      tchartleft.traces[0].color     := $D2D8A5;

      tchartleft.color  := $D2D8A5;
      tchartright.color := $D2D8A5;

      tchartright.colorchart          := $D2D8A5;
      tchartright.traces[0].chartkind := tck_bar;

      tchartleft.traces[0].bar_face.fade_color.items[1]  := $C69EFF;
      tchartright.traces[0].bar_face.fade_color.items[1] := $C69EFF;
      tchartleft.traces[0].bar_face.fade_color.items[0]  := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      tchartright.traces[0].color := $C69EFF;
      fond.color      := $D2D8A5;
      groupbox1.color := $D2D8A5;
      groupbox2.color := $D2D8A5;
      spect1.frame.font.color := ltblack;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color    := cl_default;

      //  spect1.face.template := recorderfo.tfacerecorder;
    end;

    songplayerfo.btnresume.imagenrdisabled  := -2;
    songplayer2fo.btnresume.imagenrdisabled := -2;
    songplayerfo.btncue.imagenrdisabled     := -2;
    songplayer2fo.btncue.imagenrdisabled    := -2;
    songplayerfo.btnstart.imagenrdisabled   := -2;
    songplayer2fo.btnstart.imagenrdisabled  := -2;
    songplayerfo.btnpause.imagenrdisabled   := -2;
    songplayer2fo.btnpause.imagenrdisabled  := -2;
    songplayerfo.btnstop.imagenrdisabled    := -2;
    songplayer2fo.btnstop.imagenrdisabled   := -2;

    commanderfo.btnresume.imagenrdisabled   := -2;
    commanderfo.btnresume2.imagenrdisabled  := -2;
    commanderfo.btncue.imagenrdisabled      := -2;
    commanderfo.btncue2.imagenrdisabled     := -2;
    commanderfo.btnstart.imagenrdisabled    := -2;
    commanderfo.btnstart2.imagenrdisabled   := -2;
    commanderfo.btnpause.imagenrdisabled    := -2;
    commanderfo.btnpause2.imagenrdisabled   := -2;
    commanderfo.btnstop.imagenrdisabled     := -2;
    commanderfo.btnstop2.imagenrdisabled    := -2;
    commanderfo.loop_start.imagenrdisabled  := -2;
    commanderfo.loop_stop.imagenrdisabled   := -2;
    commanderfo.loop_resume.imagenrdisabled := -2;

    recorderfo.btnresume.imagenrdisabled := -2;
    recorderfo.tbutton2.imagenrdisabled  := -2;
    recorderfo.btnstart.imagenrdisabled  := -2;
    recorderfo.btnpause.imagenrdisabled  := -2;
    recorderfo.btnstop.imagenrdisabled   := -2;

    drumsfo.loop_resume.imagenrdisabled := -2;
    drumsfo.loop_start.imagenrdisabled  := -2;
    drumsfo.loop_stop.imagenrdisabled   := -2;

  end;

  if typecolor.Value = 1 then
  begin
    font.color          := cl_black;
    synthefo.font.color := cl_black;
    pianofo.font.color  := cl_black;

    synthefo.color := $D2D2D2;
    pianofo.color  := $D2D2D2;

    synthefo.tgroupbox4.font.color  := cl_black;
    synthefo.tgroupbox3.font.color  := cl_black;
    filelistfo.historyfn.font.color := cl_black;

    songplayerfo.historyfn.font.color  := cl_black;
    songplayer2fo.historyfn.font.color := cl_black;

    songplayerfo.edvolleft.font.color   := cl_black;
    songplayerfo.edvolright.font.color  := cl_black;
    songplayer2fo.edvolleft.font.color  := cl_black;
    songplayer2fo.edvolright.font.color := cl_black;

    songplayerfo.historyfn.dropdown.cols[0].colorselect  := $FFCD8F;
    songplayer2fo.historyfn.dropdown.cols[0].colorselect := $FFCD8F;

    songplayerfo.cbloopb.font.color  := cl_black;
    songplayer2fo.cbloopb.font.color := cl_black;

    songplayerfo.playreverseb.font.color  := cl_black;
    songplayer2fo.playreverseb.font.color := cl_black;

    songplayerfo.waveformcheckb.font.color  := cl_black;
    songplayer2fo.waveformcheckb.font.color := cl_black;

    songplayerfo.setmonob.font.color  := cl_black;
    songplayer2fo.setmonob.font.color := cl_black;

    songplayerfo.cbtempob.font.color  := cl_black;
    songplayer2fo.cbtempob.font.color := cl_black;

    commanderfo.Brandommix.font.color  := cl_black;
    commanderfo.linkvolgenb.font.color := cl_black;
    commanderfo.linkvolb.font.color    := cl_black;
    commanderfo.speccalcb.font.color   := cl_black;
    commanderfo.guimixb.font.color     := cl_black;
    commanderfo.linkvol2b.font.color   := cl_black;
    commanderfo.automixb.font.color    := cl_black;
    commanderfo.vuinb.font.color       := cl_black;
    commanderfo.directmixb.font.color  := cl_black;
    dialogfilesfo.list_files.frame.colorclient := cl_ltgray;

    dockpanel1fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel2fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel3fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel4fo.tmainmenu1.menu.font.color := cl_black;
    dockpanel5fo.tmainmenu1.menu.font.color := cl_black;

    wavefo.tmainmenu1.menu.font.color    := cl_black;
    wavefo2.tmainmenu1.menu.font.color   := cl_black;
    waveforec.tmainmenu1.menu.font.color := cl_black;

    dockpanel1fo.basedock.dragdock.splitter_color := cl_ltgray;
    dockpanel2fo.basedock.dragdock.splitter_color := cl_ltgray;
    dockpanel3fo.basedock.dragdock.splitter_color := cl_ltgray;
    dockpanel4fo.basedock.dragdock.splitter_color := cl_ltgray;
    dockpanel5fo.basedock.dragdock.splitter_color := cl_ltgray;

    basedock.dragdock.splitter_color := cl_ltgray;

    wavefo.echelle.datacols.font.color := cl_black;
    wavefo.echelle.datacols.color      := cl_gray;
    wavefo.echelle.datacols.font.colorbackground := cl_gray;

    wavefo2.echelle.datacols.font.color := cl_black;
    wavefo2.echelle.datacols.color      := cl_gray;
    wavefo2.echelle.datacols.font.colorbackground := cl_gray;

    filelistfo.historyfn.dropdown.cols[0].colorselect := $FFC782;
    spectrum1fo.container.color   := cl_default;
    spectrum2fo.container.color   := cl_default;
    spectrumrecfo.container.color := cl_default;
    commanderfo.container.color   := cl_default;
    guitarsfo.container.color     := cl_default;

    wavefo.container.color  := cl_default;
    wavefo2.container.color := cl_default;
    filelistfo.list_files.fixrows.color := cl_default;
    filelistfo.list_files.fixrows[-1].font.color := cl_black;

    filelistfo.list_files.fixcols.color           := cl_default;
    filelistfo.list_files.fixcols[-1].font.color  := cl_default;
    filelistfo.list_files.fixcols[-1].colorselect := cl_ltgray;

    for x := 0 to filelistfo.list_files.rowcount - 1 do
      filelistfo.list_files.rowfontstate[x] := 0;

    filelistfo.list_files.datacols.colorselect := $FFC87A;

    wavefo.tmainmenu1.menu.colorglyph  := cl_black;
    tmainmenu1.menu.colorglyph         := cl_black;
    tmainmenu1.menu.colorglyphactive   := cl_black;
    wavefo.tmainmenu1.menu.colorglyphactive := cl_black;
    wavefo2.tmainmenu1.menu.colorglyph := cl_black;
    wavefo2.tmainmenu1.menu.colorglyphactive := cl_black;

    waveforec.tmainmenu1.menu.colorglyph       := cl_black;
    waveforec.tmainmenu1.menu.colorglyphactive := cl_black;

    randomnotefo.color         := cl_ltgray;
    tmainmenu1.menu.font.color := cl_black;
    randomnotefo.tstringdisp1.font.color := cl_black;
    randomnotefo.bchord1.font.color := cl_black;
    randomnotefo.bchord2.font.color := cl_black;
    randomnotefo.bchord3.font.color := cl_black;
    randomnotefo.bchord4.font.color := cl_black;
    randomnotefo.bchord5.font.color := cl_black;

    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.nodrums.frame.font.color    := cl_black;
    randomnotefo.withsharp.frame.font.color  := cl_black;
    randomnotefo.maxnote.frame.font.color    := cl_black;
    randomnotefo.bpm.frame.font.color        := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.withrandom.frame.font.color := cl_black;
    randomnotefo.boolmajor.frame.font.color  := cl_black;
    randomnotefo.boolminor.frame.font.color  := cl_black;
    randomnotefo.bosound.frame.font.color    := cl_black;
    randomnotefo.tbutton3.font.color         := cl_black;
    randomnotefo.tbutton5.font.color         := cl_black;
    randomnotefo.tbutton2.font.color         := cl_black;
    randomnotefo.bnbchords.font.color        := cl_black;
    randomnotefo.btnfixed.font.color         := cl_black;
    randomnotefo.tgroupbox1.frame.font.color := cl_black;
    randomnotefo.tgroupbox2.frame.font.color := cl_black;
    randomnotefo.tgroupbox3.frame.font.color := cl_black;

    filelistfo.container.color := $D0D0D0;

    songplayerfo.historyfn.frame.button.color := $D0D0D0;
    songplayerfo.edvolleft.color  := $D0D0D0;
    songplayerfo.edvolleft.frame.colorbutton := $D0D0D0;
    songplayerfo.edvolright.color := $D0D0D0;
    songplayerfo.edvolright.frame.colorbutton := $D0D0D0;
    songplayerfo.edtempo.color    := $D0D0D0;
    songplayerfo.edtempo.frame.colorbutton := $D0D0D0;

    songplayerfo.edpitch.color  := $D0D0D0;
    songplayerfo.edpitch.frame.colorbutton := $D0D0D0;
    songplayer2fo.edpitch.color := $D0D0D0;
    songplayer2fo.edpitch.frame.colorbutton := $D0D0D0;

    songplayer2fo.historyfn.frame.button.color := $D0D0D0;
    songplayer2fo.edvolleft.color  := $D0D0D0;
    songplayer2fo.edvolleft.frame.colorbutton := $D0D0D0;
    songplayer2fo.edvolright.color := $D0D0D0;
    songplayer2fo.edvolright.frame.colorbutton := $D0D0D0;
    songplayer2fo.edtempo.color    := $D0D0D0;
    songplayer2fo.edtempo.frame.colorbutton := $D0D0D0;

    recorderfo.edtempo.color := $D0D0D0;
    recorderfo.edtempo.frame.colorbutton := $D0D0D0;

    commanderfo.timemix.frame.colorbutton := $D0D0D0;
    commanderfo.timemix.color := $D0D0D0;

    filelistfo.container.color := $D0D0D0;
    filelistfo.color           := $D0D0D0;
    filelistfo.historyfn.frame.button.color := $D0D0D0;
    filelistfo.list_files.face.fade_color.items[0] := $D0D0D0;

    wavefo.trackbar1.color    := $E0E0E0;
    wavefo2.trackbar1.color   := $E0E0E0;
    waveforec.trackbar1.color := $E0E0E0;

    with infosdfo do
    begin
      container.color       := $D0D0D0;
      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      tbutton1.font.color   := cl_black;
      infoyear.font.color   := cl_black;
      infocom.font.color    := cl_black;
      infotag.font.color    := cl_black;
      tracktag.font.color   := cl_black;
      infolength.font.color := cl_black;
      inforate.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;

      tracktag.frame.font.color   := cl_black;
      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
    end;

    with infosdfo2 do
    begin
      container.color       := $D0D0D0;
      infofile.font.color   := cl_black;
      infoartist.font.color := cl_black;
      infoname.font.color   := cl_black;
      tracktag.font.color   := cl_black;
      infoalbum.font.color  := cl_black;
      tbutton1.font.color   := cl_black;
      infoyear.font.color   := cl_black;
      infocom.font.color    := cl_black;
      infotag.font.color    := cl_black;
      infolength.font.color := cl_black;
      inforate.font.color   := cl_black;
      infochan.font.color   := cl_black;
      infobpm.font.color    := cl_black;

      infofile.frame.font.color   := cl_black;
      infoartist.frame.font.color := cl_black;
      infoname.frame.font.color   := cl_black;
      infoalbum.frame.font.color  := cl_black;
      infoyear.frame.font.color   := cl_black;
      infocom.frame.font.color    := cl_black;
      infotag.frame.font.color    := cl_black;
      infolength.frame.font.color := cl_black;
      inforate.frame.font.color   := cl_black;
      infochan.frame.font.color   := cl_black;
      infobpm.frame.font.color    := cl_black;
      tracktag.frame.font.color   := cl_black;
    end;


    // main
  {$if not defined(nofade)}    
    tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[1] := $9E9E9E;

    tfacebutltgray.template.fade_color.items[0] := $DADADA;
    tfacebutltgray.template.fade_color.items[1] := $D5D5D5;

    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[1] := $FF7878;


  //  tfaceplayer.template.fade_color.items[0] := $EDEDED;
  //  tfaceplayer.template.fade_color.items[1] := $BABABA;

    //tfaceplayerbut.template.fade_color.items[0] := $EDEDED;
    //tfaceplayerbut.template.fade_color.items[1] := $BABABA;

  //  tfaceplayerlight.template.fade_color.items[0] := $E6E6E6;
  //  tfaceplayerlight.template.fade_color.items[1] := $C7C7C7;
    
  //  tfaceplayerrev.template.fade_color.items[0] := $BABABA;
   // tfaceplayerrev.template.fade_color.items[1] := $EDEDED;
    
    {$else}

    //   tfacebutgray.template.fade_color.items[0] := $F2F2F2;
    tfacebutgray.template.fade_color.items[0] := $F2F2F2;

    //    tfacebutltgray.template.fade_color.items[0] := $FAFAFA;
    tfacebutltgray.template.fade_color.items[0] := $D2D2D2;

    //  tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[0] := $C2FF9E;

    //  tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[0] := $FF9900;

    //   tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[0] := $FF7878;

    //    tfaceplayer.template.fade_color.items[0] := $EDEDED;
    //    tfaceplayer.template.fade_color.items[0] := $C4C4C4;

    //   tfaceplayerbut.template.fade_color.items[0] := $EDEDED;
    //tfaceplayerbut.template.fade_color.items[0] := $BABABA;

    //  tfaceplayerlight.template.fade_color.items[0] := $FDFDFD;
    //  tfaceplayerlight.template.fade_color.items[0] := $CCCCCC;

    //   tfaceplayerrev.template.fade_color.items[0] := $BABABA;
    //    tfaceplayerrev.template.fade_color.items[0] := $EDEDED;
    {$endif}

    // players
    songplayerfo.font.color  := cl_default;
    songplayer2fo.font.color := cl_default;

    songplayerfo.tstringdisp1.font.color  := ltblack;
    songplayer2fo.tstringdisp1.font.color := ltblack;

    songplayerfo.lposition.font.color  := cl_default;
    songplayer2fo.lposition.font.color := cl_default;

    songplayerfo.llength.font.color       := cl_default;
    songplayer2fo.llength.font.color      := cl_default;
    songplayerfo.tstringdisp2.font.color  := ltblack;
    songplayer2fo.tstringdisp2.font.color := ltblack;

    songplayerfo.button1.font.color  := ltblack;
    songplayer2fo.button1.font.color := ltblack;

    songplayerfo.button2.font.color  := ltblack;
    songplayer2fo.button2.font.color := ltblack;

    equalizerfo1.loadset.font.color   := ltblack;
    equalizerfo2.loadset.font.color   := ltblack;
    equalizerforec.loadset.font.color := ltblack;

    equalizerfo1.saveset.font.color   := ltblack;
    equalizerfo2.saveset.font.color   := ltblack;
    equalizerforec.saveset.font.color := ltblack;

    songplayerfo.edvolleft.frame.colorglyph  := ltblack;
    songplayer2fo.edvolleft.frame.colorglyph := ltblack;

    recorderfo.edvol.frame.colorglyph   := ltblack;
    recorderfo.edvolr.frame.colorglyph  := ltblack;
    recorderfo.edtempo.frame.colorglyph := ltblack;

    songplayerfo.edvolright.frame.colorglyph  := ltblack;
    songplayer2fo.edvolright.frame.colorglyph := ltblack;
    songplayerfo.edtempo.frame.colorglyph     := ltblack;
    songplayer2fo.edtempo.frame.colorglyph    := ltblack;

    songplayerfo.edpitch.frame.colorglyph  := ltblack;
    songplayer2fo.edpitch.frame.colorglyph := ltblack;

    songplayerfo.historyfn.frame.button.colorglyph  := ltblack;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblack;

    songplayerfo.historyfn.dropdown.colorclient  := ltblank;
    songplayer2fo.historyfn.dropdown.colorclient := ltblank;

    songplayerfo.historyfn.font.color  := ltblack;
    songplayer2fo.historyfn.font.color := ltblack;
    songplayerfo.edvolleft.font.color  := ltblack;
    songplayer2fo.edvolleft.font.color := ltblack;

    songplayerfo.edvolright.font.color  := ltblack;
    songplayer2fo.edvolright.font.color := ltblack;
    songplayerfo.edtempo.font.color     := ltblack;
    songplayer2fo.edtempo.font.color    := ltblack;

    songplayerfo.edpitch.font.color  := ltblack;
    songplayer2fo.edpitch.font.color := ltblack;

    songplayerfo.btinfos.font.color  := ltblack;
    songplayer2fo.btinfos.font.color := ltblack;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $EDEDED;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $BABABA;

    songplayer2fo.tfaceslider.template.fade_color.items[0] := $EDEDED;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $BABABA;

    // drums
    drumsfo.tdockpanel1.font.color := ltblack;

    drumsfo.panel1.font.color := ltblack;

    // drumsfo.tfacedrums.template.fade_color.items[0] := $CCCCCC;
    // drumsfo.tfacedrums.template.fade_color.items[1] := $AAAAAA;

    drumsfo.edittempo.frame.colorglyph   := ltblack;
    drumsfo.volumedrums.frame.colorglyph := ltblack;
    drumsfo.sensib.frame.colorglyph      := ltblack;

    drumsfo.ltempo.font.color          := ltblack;
    drumsfo.novoice.frame.font.color   := ltblack;
    drumsfo.langcount.frame.font.color := ltblack;
    drumsfo.langcount.font.color       := ltblack;
    drumsfo.langcount.frame.button.colorglyph := ltblack;
    drumsfo.langcount.dropdown.colorclient := ltblank;

    drumsfo.noand.frame.font.color   := ltblack;
    drumsfo.nodrums.frame.font.color := ltblack;
    drumsfo.noanim.frame.font.color  := ltblack;
    drumsfo.tlabel21.font.color      := ltblack;
    drumsfo.tlabel22.font.color      := ltblack;
    drumsfo.tlabel25.font.color      := ltblack;
    drumsfo.tlabel23.font.color      := ltblack;

    drumsfo.tstringdisp2.font.color := ltblack;

    drumsfo.multbpm.font.color := ltblack;
    drumsfo.divbpm.font.color  := ltblack;

    // rev
    // drumsfo.tfacecomp2.template.fade_color.items[0] := $EDEDED;
    // drumsfo.tfacecomp2.template.fade_color.items[1] := $BABABA;

    // light
    // drumsfo.tfacecomp3.template.fade_color.items[0] := $EDEDED;
    // drumsfo.tfacecomp3.template.fade_color.items[1] := $BABABA;

    // recorder
    recorderfo.font.color := ltblack;

    recorderfo.bwav.colorglyph           := ltblack;
    recorderfo.bogg.colorglyph           := ltblack;
    recorderfo.bwav.frame.font.color     := ltblack;
    recorderfo.bogg.frame.font.color     := ltblack;
    recorderfo.cbloop.frame.font.color   := ltblack;
    recorderfo.cbtempo.frame.font.color  := ltblack;
    recorderfo.bsavetofile.frame.font.color := ltblack;
    recorderfo.sentcue1.frame.font.color := ltblack;
    recorderfo.blistenin.frame.font.color := ltblack;
    //   recorderfo.label6.font.color       := ltblack;
    recorderfo.btinfos.font.color        := ltblack;
    recorderfo.button1.font.color        := ltblack;
    recorderfo.tstringdisp2.font.color   := ltblack;
    recorderfo.llength.font.color        := ltblack;
    recorderfo.lposition.font.color      := ltblack;
    recorderfo.cbloop.colorglyph         := ltblack;
    recorderfo.cbtempo.colorglyph        := ltblack;
    recorderfo.bsavetofile.colorglyph    := ltblack;
    recorderfo.sentcue1.colorglyph       := ltblack;
    recorderfo.blistenin.colorglyph      := ltblack;
    recorderfo.historyfn.frame.button.colorglyph := ltblack;
    recorderfo.historyfn.dropdown.colorclient := ltblank;
    // recorderfo.tfacerecorder.template.fade_color.items[0] := $EDEDED;
    // recorderfo.tfacerecorder.template.fade_color.items[1] := $BABABA;
    // recorderfo.tfacerecrev.template.fade_color.items[0] := $BABABA;
    // recorderfo.tfacerecrev.template.fade_color.items[1] := $EDEDED;

    // light
    // recorderfo.tfacereclight.template.fade_color.items[0] := $EDEDED;
    // recorderfo.tfacereclight.template.fade_color.items[1] := $BABABA;

    // guitar
    guitarsfo.font.color          := ltblack;
    guitarsfo.tgroupbox1.font.color := ltblack;
    guitarsfo.tgroupbox2.font.color := ltblack;
    guitarsfo.loopguit.colorglyph := ltblack;
    guitarsfo.loopbass.colorglyph := ltblack;
    guitarsfo.loopguit.frame.font.color := ltblack;
    guitarsfo.loopbass.frame.font.color := ltblack;
    guitarsfo.tstringdisp2.font.color := ltblack;
    guitarsfo.tstringdisp3.font.color := ltblack;

    {
    guitarsfo.tfaceguit.template.fade_color.items[0] := $EDEDED;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $BABABA;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $EDEDED;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $BABABA;
    }
    // Equalizer
    with equalizerfo1 do
    begin
      fond.color      := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color := cl_default;
      groupbox2.color := cl_default;

      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;


      EQEN.frame.font.color := ltblack;
      EQEN.frame.colorclient := cl_default;
      EQEN.color := cl_default;
    end;

    with equalizerfo2 do
    begin
      fond.color           := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color      := cl_default;
      groupbox2.color      := cl_default;
      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      EQEN.frame.font.color := ltblack;
      EQEN.frame.colorclient := cl_default;
      EQEN.color := cl_default;
    end;

    with equalizerforec do
    begin
      fond.color           := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      groupbox1.color      := cl_default;
      groupbox2.color      := cl_default;
      font.color           := ltblack;
      groupbox1.font.color := ltblack;
      groupbox2.font.color := ltblack;

      EQEN.frame.font.color := ltblack;
      EQEN.frame.colorclient := cl_default;
      EQEN.color := cl_default;
    end;

    for x := 1 to 20 do
    begin
      abuttons[x].font.color  := ltblack;
      abuttons2[x].font.color := ltblack;
      abuttonsR[x].font.color := ltblack;
    end;

    // commander
    commanderfo.nameplayers.font.color      := ltblack;
    commanderfo.nameplayers2.font.color     := ltblack;
    commanderfo.namedrums.font.color        := ltblack;
    commanderfo.namegen.font.color          := ltblack;
    commanderfo.nameinput.font.color        := ltblack;
    commanderfo.genleftvolvalue.font.color  := ltblack;
    commanderfo.genrightvolvalue.font.color := ltblack;
    commanderfo.sysvolbut.font.color        := ltblack;

    commanderfo.volumeleft1val.font.color := ltblack;
    commanderfo.volumeleft2val.font.color := ltblack;

    commanderfo.volumeright1val.font.color := ltblack;
    commanderfo.volumeright2val.font.color := ltblack;

    commanderfo.tslider2val.font.color := ltblack;
    commanderfo.tslider3val.font.color := ltblack;

    commanderfo.timemix.font.color        := ltblack;
    commanderfo.timemix.frame.colorglyph  := ltblack;
    commanderfo.timemix.frame.font.color  := ltblack;
    commanderfo.butinput.colorglyph       := ltblack;
    commanderfo.butinput.frame.font.color := ltblack;
    //  commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED;
    //  commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA;

    filelistfo.list_files.font.color := ltblack;
    filelistfo.tgroupbox1.font.color := ltblack;

    filelistfo.historyfn.frame.button.colorglyph := ltblack;
    filelistfo.historyfn.dropdown.colorclient    := ltblank;

    filelistfo.list_files.datacols[0].color      := cl_white;
    filelistfo.list_files.datacols[0].font.color := ltblack;
    filelistfo.list_files.datacols[1].color      := cl_white;
    filelistfo.list_files.datacols[1].font.color := ltblack;
    filelistfo.list_files.datacols[2].color      := cl_white;
    filelistfo.list_files.datacols[2].font.color := ltblack;
    filelistfo.list_files.datacols[3].color      := cl_white;
    filelistfo.list_files.datacols[3].font.color := ltblack;

    filelistfo.list_files.datacols[3].colorglyph  := ltblack;
    filelistfo.list_files.datacols[3].colorselect := $EDEDED;

    filelistfo.list_files.datacols[0].colorselect := $FFC87A;
    filelistfo.list_files.datacols[1].colorselect := $FFC87A;
    filelistfo.list_files.datacols[2].colorselect := $FFC87A;

    aboutfo.font.color := cl_black;

    songplayerfo.btnresume.imagenrdisabled  := -2;
    songplayer2fo.btnresume.imagenrdisabled := -2;
    songplayerfo.btncue.imagenrdisabled     := -2;
    songplayer2fo.btncue.imagenrdisabled    := -2;
    songplayerfo.btnstart.imagenrdisabled   := -2;
    songplayer2fo.btnstart.imagenrdisabled  := -2;
    songplayerfo.btnpause.imagenrdisabled   := -2;
    songplayer2fo.btnpause.imagenrdisabled  := -2;
    songplayerfo.btnstop.imagenrdisabled    := -2;
    songplayer2fo.btnstop.imagenrdisabled   := -2;
    commanderfo.btnresume.imagenrdisabled   := -2;
    commanderfo.btnresume2.imagenrdisabled  := -2;
    commanderfo.btncue.imagenrdisabled      := -2;
    commanderfo.btncue2.imagenrdisabled     := -2;
    commanderfo.btnstart.imagenrdisabled    := -2;
    commanderfo.btnstart2.imagenrdisabled   := -2;
    commanderfo.btnpause.imagenrdisabled    := -2;
    commanderfo.btnpause2.imagenrdisabled   := -2;
    commanderfo.btnstop.imagenrdisabled     := -2;
    commanderfo.btnstop2.imagenrdisabled    := -2;
    commanderfo.loop_start.imagenrdisabled  := -2;
    commanderfo.loop_stop.imagenrdisabled   := -2;
    commanderfo.loop_resume.imagenrdisabled := -2;

    recorderfo.btnresume.imagenrdisabled := -2;
    recorderfo.tbutton2.imagenrdisabled  := -2;
    recorderfo.btnstart.imagenrdisabled  := -2;
    recorderfo.btnpause.imagenrdisabled  := -2;
    recorderfo.btnstop.imagenrdisabled   := -2;

    drumsfo.loop_resume.imagenrdisabled := -2;
    drumsfo.loop_start.imagenrdisabled  := -2;
    drumsfo.loop_stop.imagenrdisabled   := -2;

    with spectrum1fo do
    begin

      tchartleft.colorchart := cl_background;
      tchartleft.color := cl_default;
      tchartright.color := cl_default;
      tchartright.colorchart := cl_background;
      tchartleft.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit1.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit2.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      fond.color := cl_default;

      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color := cl_default;
    end;

    with spectrum2fo do
    begin
      tchartleft.colorchart := cl_background;
      tchartleft.color := cl_default;
      tchartright.color := cl_default;
      tchartright.colorchart := cl_background;
      tchartleft.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit12.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit22.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      fond.color      := cl_default;
      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color    := cl_default;
    end;

    with spectrumrecfo do
    begin
      tchartleft.colorchart := cl_background;
      tchartleft.color := cl_default;
      tchartright.color := cl_default;
      tchartleft.traces[0].bar_face.fade_color.items[1] := $9A9A9A;
      tchartright.traces[0].bar_face.fade_color.items[1] := $9A9A9A;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.colorchart := cl_background;
      fond.color      := cl_default;
      groupbox1.color := cl_default;
      groupbox2.color := cl_default;
      groupbox1.frame.font.color := ltblack;
      groupbox2.frame.font.color := ltblack;
      spect1.frame.font.color := ltblack;
      spect1.frame.colorclient := cl_default;
      spect1.color    := cl_default;
    end;

  end;

  if typecolor.Value = 2 then
  begin
    font.color          := cl_white;
    synthefo.font.color := cl_white;
    pianofo.font.color  := cl_white;

    synthefo.color := $4B4B4B;
    pianofo.color  := $4B4B4B;

    songplayerfo.edvolleft.font.color   := cl_white;
    songplayerfo.edvolright.font.color  := cl_white;
    songplayer2fo.edvolleft.font.color  := cl_white;
    songplayer2fo.edvolright.font.color := cl_white;

    songplayerfo.historyfn.dropdown.cols[0].colorselect  := $573000;
    songplayer2fo.historyfn.dropdown.cols[0].colorselect := $573000;

    songplayerfo.historyfn.font.color  := cl_white;
    songplayer2fo.historyfn.font.color := cl_white;

    songplayerfo.cbloopb.font.color  := cl_white;
    songplayer2fo.cbloopb.font.color := cl_white;

    songplayerfo.playreverseb.font.color  := cl_white;
    songplayer2fo.playreverseb.font.color := cl_white;

    songplayerfo.waveformcheckb.font.color  := cl_white;
    songplayer2fo.waveformcheckb.font.color := cl_white;

    songplayerfo.setmonob.font.color  := cl_white;
    songplayer2fo.setmonob.font.color := cl_white;

    songplayerfo.cbtempob.font.color  := cl_white;
    songplayer2fo.cbtempob.font.color := cl_white;

    commanderfo.Brandommix.font.color  := cl_white;
    commanderfo.linkvolgenb.font.color := cl_white;
    commanderfo.linkvolb.font.color    := cl_white;
    commanderfo.speccalcb.font.color   := cl_white;
    commanderfo.guimixb.font.color     := cl_white;
    commanderfo.linkvol2b.font.color   := cl_white;
    commanderfo.automixb.font.color    := cl_white;
    commanderfo.vuinb.font.color       := cl_white;
    commanderfo.directmixb.font.color  := cl_white;

    filelistfo.historyfn.font.color := cl_white;

    synthefo.tgroupbox4.font.color := cl_white;

    synthefo.tgroupbox3.font.color := cl_white;

    dialogfilesfo.list_files.frame.colorclient := cl_gray;

    dockpanel1fo.tmainmenu1.menu.font.color := cl_white;
    dockpanel2fo.tmainmenu1.menu.font.color := cl_white;
    dockpanel3fo.tmainmenu1.menu.font.color := cl_white;
    dockpanel4fo.tmainmenu1.menu.font.color := cl_white;
    dockpanel5fo.tmainmenu1.menu.font.color := cl_white;

    wavefo.tmainmenu1.menu.font.color    := cl_white;
    wavefo2.tmainmenu1.menu.font.color   := cl_white;
    waveforec.tmainmenu1.menu.font.color := cl_white;

    dockpanel1fo.basedock.dragdock.splitter_color := cl_black;
    dockpanel2fo.basedock.dragdock.splitter_color := cl_black;
    dockpanel3fo.basedock.dragdock.splitter_color := cl_black;
    dockpanel4fo.basedock.dragdock.splitter_color := cl_black;
    dockpanel5fo.basedock.dragdock.splitter_color := cl_black;

    basedock.dragdock.splitter_color := cl_black;

    wavefo.echelle.datacols.font.color := cl_white;
    wavefo.echelle.datacols.color      := $575757;
    wavefo.echelle.datacols.font.colorbackground := $575757;

    wavefo2.echelle.datacols.font.color := cl_white;
    wavefo2.echelle.datacols.color      := $575757;
    wavefo2.echelle.datacols.font.colorbackground := $575757;

    filelistfo.historyfn.dropdown.cols[0].colorselect := $A35A00;
    wavefo.container.color        := $575757;
    wavefo2.container.color       := $575757;
    spectrum1fo.container.color   := $575757;
    spectrum2fo.container.color   := $575757;
    spectrumrecfo.container.color := $575757;
    commanderfo.container.color   := $575757;
    guitarsfo.container.color     := $575757;

    filelistfo.list_files.fixrows.color          := $575757;
    filelistfo.list_files.fixrows[-1].font.color := cl_white;

    filelistfo.list_files.fixcols.color           := $575757;
    filelistfo.list_files.fixcols[-1].font.color  := cl_white;
    filelistfo.list_files.fixcols[-1].colorselect := cl_dkgray;

    randomnotefo.color         := cl_black;
    tmainmenu1.menu.font.color := cl_white;
    tmainmenu1.menu.colorglyph := cl_white;
    tmainmenu1.menu.colorglyphactive := cl_white;
    wavefo.tmainmenu1.menu.colorglyph := cl_white;
    wavefo.tmainmenu1.menu.colorglyphactive := cl_white;
    wavefo2.tmainmenu1.menu.colorglyph := cl_white;
    wavefo2.tmainmenu1.menu.colorglyphactive := cl_white;
    waveforec.tmainmenu1.menu.colorglyph := cl_white;
    waveforec.tmainmenu1.menu.colorglyphactive := cl_white;

    randomnotefo.tstringdisp1.font.color     := cl_white;
    randomnotefo.bchord1.font.color          := cl_white;
    randomnotefo.bchord2.font.color          := cl_white;
    randomnotefo.bchord3.font.color          := cl_white;
    randomnotefo.bchord4.font.color          := cl_white;
    randomnotefo.bchord5.font.color          := cl_white;
    randomnotefo.withrandom.frame.font.color := cl_white;
    randomnotefo.nodrums.frame.font.color    := cl_white;
    randomnotefo.withsharp.frame.font.color  := cl_white;
    randomnotefo.maxnote.frame.font.color    := cl_white;
    randomnotefo.bpm.frame.font.color        := cl_white;
    randomnotefo.boolmajor.frame.font.color  := cl_white;
    randomnotefo.withrandom.frame.font.color := cl_white;
    randomnotefo.boolmajor.frame.font.color  := cl_white;
    randomnotefo.boolminor.frame.font.color  := cl_white;
    randomnotefo.bosound.frame.font.color    := cl_white;
    randomnotefo.tbutton3.font.color         := cl_white;
    randomnotefo.tbutton5.font.color         := cl_white;
    randomnotefo.tbutton2.font.color         := cl_white;
    randomnotefo.bnbchords.font.color        := cl_white;
    randomnotefo.btnfixed.font.color         := cl_white;
    randomnotefo.tgroupbox1.frame.font.color := cl_white;
    randomnotefo.tgroupbox2.frame.font.color := cl_white;
    randomnotefo.tgroupbox3.frame.font.color := cl_white;

    filelistfo.container.color := $474747;

    songplayerfo.historyfn.frame.button.color := $474747;
    songplayerfo.edvolleft.color  := $474747;
    songplayerfo.edvolleft.frame.colorbutton := $474747;
    songplayerfo.edvolright.color := $474747;
    songplayerfo.edvolright.frame.colorbutton := $474747;
    songplayerfo.edtempo.color    := $474747;
    songplayerfo.edtempo.frame.colorbutton := $474747;

    songplayerfo.edpitch.color  := $474747;
    songplayerfo.edpitch.frame.colorbutton := $474747;
    songplayer2fo.edpitch.color := $474747;
    songplayer2fo.edpitch.frame.colorbutton := $474747;

    songplayer2fo.historyfn.frame.button.color := $474747;
    songplayer2fo.edvolleft.color  := $474747;
    songplayer2fo.edvolleft.frame.colorbutton := $474747;
    songplayer2fo.edvolright.color := $474747;
    songplayer2fo.edvolright.frame.colorbutton := $474747;
    songplayer2fo.edtempo.color    := $474747;
    songplayer2fo.edtempo.frame.colorbutton := $474747;

    commanderfo.timemix.frame.colorbutton := $474747;
    commanderfo.timemix.color := $474747;

    filelistfo.container.color := $474747;
    filelistfo.color           := $474747;
    filelistfo.historyfn.frame.button.color := $474747;
    filelistfo.list_files.face.fade_color.items[0] := $474747;

    wavefo.trackbar1.color    := $424242;
    wavefo2.trackbar1.color   := $424242;
    waveforec.trackbar1.color := $424242;

    with infosdfo do
    begin
      container.color           := $3A3A3A;
      infofile.font.color       := cl_white;
      infoartist.font.color     := cl_white;
      tbutton1.font.color       := cl_white;
      infoname.font.color       := cl_white;
      infoalbum.font.color      := cl_white;
      infoyear.font.color       := cl_white;
      infocom.font.color        := cl_white;
      infotag.font.color        := cl_white;
      tracktag.font.color       := cl_white;
      infolength.font.color     := cl_white;
      inforate.font.color       := cl_white;
      infochan.font.color       := cl_white;
      infobpm.font.color        := cl_white;
      tracktag.frame.font.color := cl_white;
      infofile.frame.font.color := cl_white;
      infoartist.frame.font.color := cl_white;
      infoname.frame.font.color := cl_white;
      infoalbum.frame.font.color := cl_white;
      infoyear.frame.font.color := cl_white;
      infocom.frame.font.color  := cl_white;
      infotag.frame.font.color  := cl_white;
      infolength.frame.font.color := cl_white;
      inforate.frame.font.color := cl_white;
      infochan.frame.font.color := cl_white;
      infobpm.frame.font.color  := cl_white;
    end;

    with infosdfo2 do
    begin
      container.color           := $3A3A3A;
      infofile.font.color       := cl_white;
      infoartist.font.color     := cl_white;
      infoname.font.color       := cl_white;
      infoalbum.font.color      := cl_white;
      tbutton1.font.color       := cl_white;
      tracktag.font.color       := cl_white;
      infoyear.font.color       := cl_white;
      infocom.font.color        := cl_white;
      infotag.font.color        := cl_white;
      infolength.font.color     := cl_white;
      inforate.font.color       := cl_white;
      infochan.font.color       := cl_white;
      infobpm.font.color        := cl_white;
      tracktag.frame.font.color := cl_white;
      infofile.frame.font.color := cl_white;
      infoartist.frame.font.color := cl_white;
      infoname.frame.font.color := cl_white;
      infoalbum.frame.font.color := cl_white;
      infoyear.frame.font.color := cl_white;
      infocom.frame.font.color  := cl_white;
      infotag.frame.font.color  := cl_white;
      infolength.frame.font.color := cl_white;
      inforate.frame.font.color := cl_white;
      infochan.frame.font.color := cl_white;
      infobpm.frame.font.color  := cl_white;
    end;

    with spectrum1fo do
    begin
      tchartleft.color := $3A3A3A;
      tchartleft.colorchart := $3A3A3A;
      tchartleft.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit1.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit2.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartleft.color := $3A3A3A;
      tchartright.color := $3A3A3A;
      tchartleft.color := $3A3A3A;
      tchartright.colorchart := $3A3A3A;
      fond.color      := $3A3A3A;
      groupbox1.color := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox2.color := $3A3A3A;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color    := $3A3A3A;
    end;

    with spectrum2fo do
    begin
      tchartleft.colorchart := $3A3A3A;
      tchartright.colorchart := $3A3A3A;
      tchartleft.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit12.Value;
      tchartright.traces[0].bar_face.fade_color.items[1] := configlayoutfo.tcoloredit22.Value;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartleft.color := $3A3A3A;
      tchartright.color := $3A3A3A;
      fond.color      := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color := $3A3A3A;
      groupbox2.color := $3A3A3A;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color    := $3A3A3A;
    end;

    with spectrumrecfo do
    begin
      tchartleft.colorchart  := $3A3A3A;
      tchartright.colorchart := $3A3A3A;
      tchartleft.traces[0].bar_face.fade_color.items[1] := cl_white;
      tchartright.traces[0].bar_face.fade_color.items[1] := cl_white;
      tchartleft.traces[0].bar_face.fade_color.items[0] := $F7F7F7;
      tchartright.traces[0].bar_face.fade_color.items[0] := $F7F7F7;

      tchartleft.color  := $3A3A3A;
      tchartright.color := $3A3A3A;

      fond.color      := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color := $3A3A3A;
      groupbox2.color := $3A3A3A;
      spect1.frame.font.color := ltblank;
      spect1.frame.colorclient := $4A4A4A;
      spect1.color    := $3A3A3A;
    end;


  {$if not defined(nofade)}
    tfacebutgray.template.fade_color.items[0] := $888888;
    tfacebutgray.template.fade_color.items[1] := $2A2A2A;

    tfacebutltgray.template.fade_color.items[0] := $5A5A5A;
    tfacebutltgray.template.fade_color.items[1] := $2A2A2A;


    tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[1] := $6EB545;

   // tfaceorange.template.fade_color.items[0] := $D97E00;
   // tfaceorange.template.fade_color.items[1] := $6E4000;
    
    tfaceorange.template.fade_color.items[0] := $FFF9F0;
    tfaceorange.template.fade_color.items[1] := $FF9D14;

    tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[1] := $FF7878;

  //  tfaceplayer.template.fade_color.items[0] := $5A5A5A;
  //  tfaceplayer.template.fade_color.items[1] := $2A2A2A;

    //tfaceplayerbut.template.fade_color.items[0] := $5A5A5A;
    //tfaceplayerbut.template.fade_color.items[1] := $2A2A2A;

  //  tfaceplayerlight.template.fade_color.items[0] := $6A6A6A;
  //  tfaceplayerlight.template.fade_color.items[1] := $3A3A3A;
    
    //tfaceplayerrev.template.fade_color.items[0] := $BDBDBD;
    //tfaceplayerrev.template.fade_color.items[1] := $9A9A9A;
   
    {$else}

    //     tfacebutgray.template.fade_color.items[0] := $888888;
    tfacebutgray.template.fade_color.items[0] := $888888;

    //  tfacebutltgray.template.fade_color.items[0] := $5A5A5A;
    tfacebutltgray.template.fade_color.items[0] := $2A2A2A;

    //  tfacegreen.template.fade_color.items[0] := $C2FF9E;
    tfacegreen.template.fade_color.items[0] := $C2FF9E;

    //   tfaceorange.template.fade_color.items[0] := $D97E00;
    tfaceorange.template.fade_color.items[0] := $FF9900;

    //   tfacered.template.fade_color.items[0] := $FFC4C4;
    tfacered.template.fade_color.items[0] := $FF7878;

    //   tfaceplayer.template.fade_color.items[0] := $5A5A5A;
    //  tfaceplayer.template.fade_color.items[0] := $2A2A2A;

    //   tfaceplayerbut.template.fade_color.items[0] := $5A5A5A;
    //tfaceplayerbut.template.fade_color.items[0] := $2A2A2A;

    //   tfaceplayerlight.template.fade_color.items[0] := $5A5A5A;
    //  tfaceplayerlight.template.fade_color.items[0] := $454545;

    //     tfaceplayerrev.template.fade_color.items[0] := $BABABA;
    //  tfaceplayerrev.template.fade_color.items[0] := $BDBDBD;

     {$endif}

    // players
    songplayerfo.btnresume.imagenrdisabled  := -1;
    songplayer2fo.btnresume.imagenrdisabled := -1;
    songplayerfo.btncue.imagenrdisabled     := -1;
    songplayer2fo.btncue.imagenrdisabled    := -1;
    songplayerfo.btnstart.imagenrdisabled   := -1;
    songplayer2fo.btnstart.imagenrdisabled  := -1;
    songplayerfo.btnpause.imagenrdisabled   := -1;
    songplayer2fo.btnpause.imagenrdisabled  := -1;
    songplayerfo.btnstop.imagenrdisabled    := -1;
    songplayer2fo.btnstop.imagenrdisabled   := -1;

    recorderfo.btnresume.imagenrdisabled := -1;
    recorderfo.tbutton2.imagenrdisabled  := -1;
    recorderfo.btnstart.imagenrdisabled  := -1;
    recorderfo.btnpause.imagenrdisabled  := -1;
    recorderfo.btnstop.imagenrdisabled   := -1;

    drumsfo.loop_resume.imagenrdisabled := -1;
    drumsfo.loop_start.imagenrdisabled  := -1;
    drumsfo.loop_stop.imagenrdisabled   := -1;

    commanderfo.btnresume.imagenrdisabled   := -1;
    commanderfo.btnresume2.imagenrdisabled  := -1;
    commanderfo.btncue.imagenrdisabled      := -1;
    commanderfo.btncue2.imagenrdisabled     := -1;
    commanderfo.btnstart.imagenrdisabled    := -1;
    commanderfo.btnstart2.imagenrdisabled   := -1;
    commanderfo.btnpause.imagenrdisabled    := -1;
    commanderfo.btnpause2.imagenrdisabled   := -1;
    commanderfo.btnstop.imagenrdisabled     := -1;
    commanderfo.btnstop2.imagenrdisabled    := -1;
    commanderfo.loop_start.imagenrdisabled  := -1;
    commanderfo.loop_stop.imagenrdisabled   := -1;
    commanderfo.loop_resume.imagenrdisabled := -1;

    songplayerfo.tfaceslider.template.fade_color.items[0] := $5A5A5A;
    songplayerfo.tfaceslider.template.fade_color.items[1] := $2A2A2A;

    songplayerfo.font.color  := ltblank;
    songplayer2fo.font.color := ltblank;

    drumsfo.edittempo.frame.colorglyph        := ltblank;
    drumsfo.volumedrums.frame.colorglyph      := ltblank;
    drumsfo.langcount.frame.button.colorglyph := ltblank;
    drumsfo.sensib.frame.colorglyph           := ltblank;
    drumsfo.langcount.dropdown.colorclient    := ltblack;

    songplayerfo.tstringdisp1.font.color  := cl_black;
    songplayer2fo.tstringdisp1.font.color := cl_black;

    songplayerfo.lposition.font.color  := ltblank;
    songplayer2fo.lposition.font.color := ltblank;

    songplayerfo.llength.font.color          := ltblank;
    songplayer2fo.llength.font.color         := ltblank;
    songplayerfo.edvolleft.frame.colorglyph  := ltblank;
    songplayer2fo.edvolleft.frame.colorglyph := ltblank;

    recorderfo.edvol.frame.colorglyph  := ltblank;
    recorderfo.edvolr.frame.colorglyph := ltblank;

    recorderfo.edtempo.frame.colorglyph := ltblank;

    songplayerfo.edpitch.frame.colorglyph  := ltblank;
    songplayer2fo.edpitch.frame.colorglyph := ltblank;

    songplayerfo.edvolright.frame.colorglyph  := ltblank;
    songplayer2fo.edvolright.frame.colorglyph := ltblank;
    songplayerfo.edtempo.frame.colorglyph     := ltblank;
    songplayer2fo.edtempo.frame.colorglyph    := ltblank;

    songplayerfo.historyfn.font.color  := ltblank;
    songplayer2fo.historyfn.font.color := ltblank;
    songplayerfo.edvolleft.font.color  := ltblank;
    songplayer2fo.edvolleft.font.color := ltblank;

    recorderfo.edtempo.font.color := ltblank;
    recorderfo.edtempo.font.color := ltblank;


    songplayerfo.historyfn.dropdown.colorclient  := ltblack;
    songplayer2fo.historyfn.dropdown.colorclient := ltblack;

    songplayerfo.edvolright.font.color  := ltblank;
    songplayer2fo.edvolright.font.color := ltblank;
    songplayerfo.edtempo.font.color     := ltblank;
    songplayer2fo.edtempo.font.color    := ltblank;
    songplayerfo.edpitch.font.color     := ltblank;
    songplayer2fo.edpitch.font.color    := ltblank;

    songplayerfo.btinfos.font.color  := ltblank;
    songplayer2fo.btinfos.font.color := ltblank;
    songplayerfo.historyfn.frame.button.colorglyph := ltblank;
    songplayer2fo.historyfn.frame.button.colorglyph := ltblank;

    songplayerfo.historyfn.dropdown.colorclient  := ltblack;
    songplayer2fo.historyfn.dropdown.colorclient := ltblack;
    songplayerfo.tstringdisp2.font.color         := ltblank;
    songplayer2fo.tstringdisp2.font.color        := ltblank;

    songplayerfo.button1.font.color  := ltblank;
    songplayer2fo.button1.font.color := ltblank;

    songplayerfo.button2.font.color  := ltblank;
    songplayer2fo.button2.font.color := ltblank;

    equalizerfo1.loadset.font.color   := ltblank;
    equalizerfo2.loadset.font.color   := ltblank;
    equalizerforec.loadset.font.color := ltblank;

    equalizerfo1.saveset.font.color   := ltblank;
    equalizerfo2.saveset.font.color   := ltblank;
    equalizerforec.saveset.font.color := ltblank;

    songplayer2fo.tfaceslider.template.fade_color.items[0] := $5A5A5A;
    songplayer2fo.tfaceslider.template.fade_color.items[1] := $2A2A2A;

    // drums
    drumsfo.tdockpanel1.font.color := cl_black;

    drumsfo.panel1.font.color := cl_white;

    drumsfo.tstringdisp2.font.color    := ltblank;
    drumsfo.ltempo.font.color          := ltblank;
    drumsfo.novoice.frame.font.color   := ltblank;
    drumsfo.langcount.frame.font.color := ltblank;
    drumsfo.langcount.font.color       := ltblank;
    drumsfo.noand.frame.font.color     := ltblank;
    drumsfo.nodrums.frame.font.color   := ltblank;
    drumsfo.noanim.frame.font.color    := ltblank;
    drumsfo.tlabel21.font.color        := ltblank;
    drumsfo.tlabel22.font.color        := ltblank;
    drumsfo.tlabel25.font.color        := ltblank;
    drumsfo.tlabel23.font.color        := ltblank;
    drumsfo.multbpm.font.color         := ltblank;
    drumsfo.divbpm.font.color          := ltblank;
    // drumsfo.tfacedrums.template.fade_color.items[0] := $5A5A5A;
    // drumsfo.tfacedrums.template.fade_color.items[1] := $2A2A2A;

    // rev
    // drumsfo.tfacecomp2.template.fade_color.items[0] := $5A5A5A;
    // drumsfo.tfacecomp2.template.fade_color.items[1] := $2A2A2A;

    // light
    //  drumsfo.tfacecomp3.template.fade_color.items[0] := $BABABA;
    //  drumsfo.tfacecomp3.template.fade_color.items[1] := $5A5A5A;

    // recorder
    recorderfo.font.color           := ltblank;
    recorderfo.cbloop.frame.font.color := ltblank;
    recorderfo.cbtempo.frame.font.color := ltblank;
    recorderfo.bwav.colorglyph      := ltblank;
    recorderfo.bogg.colorglyph      := ltblank;
    recorderfo.bwav.frame.font.color := ltblank;
    recorderfo.bogg.frame.font.color := ltblank;
    recorderfo.cbloop.colorglyph    := ltblank;
    recorderfo.cbtempo.colorglyph   := ltblank;
    recorderfo.bsavetofile.colorglyph := ltblank;
    recorderfo.sentcue1.colorglyph  := ltblank;
    recorderfo.blistenin.colorglyph := ltblank;
    recorderfo.historyfn.frame.button.colorglyph := ltblank;
    recorderfo.historyfn.dropdown.colorclient := ltblack;
    recorderfo.bsavetofile.frame.font.color := ltblank;
    recorderfo.sentcue1.frame.font.color := ltblank;
    recorderfo.blistenin.frame.font.color := ltblank;
    recorderfo.btinfos.font.color   := ltblank;
    recorderfo.button1.font.color   := ltblank;
    recorderfo.tstringdisp2.font.color := ltblank;
    recorderfo.llength.font.color   := ltblank;
    recorderfo.lposition.font.color := ltblank;
    //   recorderfo.tfacerecorder.template.fade_color.items[0] := $5A5A5A;
    //  recorderfo.tfacerecorder.template.fade_color.items[1] := $2A2A2A;

    // rev
    //  recorderfo.tfacerecrev.template.fade_color.items[0] := $2A2A2A;
    //  recorderfo.tfacerecrev.template.fade_color.items[1] := $5A5A5A;

    // light
    //  recorderfo.tfacereclight.template.fade_color.items[0] := $5A5A5A;
    //   recorderfo.tfacereclight.template.fade_color.items[1] := $2A2A2A;

    // guitar
    guitarsfo.font.color          := ltblank;
    guitarsfo.tgroupbox1.font.color := ltblank;
    guitarsfo.tgroupbox2.font.color := ltblank;
    guitarsfo.loopguit.colorglyph := ltblank;
    guitarsfo.loopbass.colorglyph := ltblank;
    guitarsfo.loopguit.frame.font.color := ltblank;
    guitarsfo.loopbass.frame.font.color := ltblank;
    guitarsfo.tstringdisp2.font.color := ltblank;
    guitarsfo.tstringdisp3.font.color := ltblank;

    {
    guitarsfo.tfaceguit.template.fade_color.items[0] := $5A5A5A;
    guitarsfo.tfaceguit.template.fade_color.items[1] := $2A2A2A;

    // light
    guitarsfo.tfaceguitlight.template.fade_color.items[0] := $BABABA;
    guitarsfo.tfaceguitlight.template.fade_color.items[1] := $5A5A5A;
    }
    // Equalizer
    with equalizerfo1 do
    begin
      fond.color           := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.font.color := ltblank;
      groupbox2.font.color := ltblank;
      font.color           := ltblank;
      groupbox1.color      := $3A3A3A;
      groupbox2.color      := $3A3A3A;
      EQEN.frame.font.color := ltblank;
      EQEN.frame.colorclient := $4A4A4A;
      EQEN.color           := $3A3A3A;
    end;

    with equalizerfo2 do
    begin
      fond.color           := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color      := $3A3A3A;
      groupbox2.color      := $3A3A3A;
      groupbox1.font.color := ltblank;
      groupbox2.font.color := ltblank;
      font.color           := ltblank;
      EQEN.frame.font.color := ltblank;
      EQEN.frame.colorclient := $4A4A4A;
      EQEN.color           := $3A3A3A;
    end;

    with equalizerforec do
    begin
      fond.color           := $3A3A3A;
      groupbox1.frame.font.color := ltblank;
      groupbox2.frame.font.color := ltblank;
      groupbox1.color      := $3A3A3A;
      groupbox2.color      := $3A3A3A;
      groupbox1.font.color := ltblank;
      groupbox2.font.color := ltblank;
      font.color           := ltblank;
      EQEN.frame.font.color := ltblank;
      EQEN.frame.colorclient := $4A4A4A;
      EQEN.color           := $3A3A3A;
    end;

    for x := 1 to 20 do
    begin
      abuttons[x].font.color  := ltblank;
      abuttons2[x].font.color := ltblank;
      abuttonsR[x].font.color := ltblank;
    end;

    // commander
    commanderfo.nameplayers.font.color  := ltblank;
    commanderfo.nameplayers2.font.color := ltblank;
    commanderfo.namedrums.font.color    := ltblank;

    commanderfo.namegen.font.color          := ltblank;
    commanderfo.nameinput.font.color        := ltblank;
    commanderfo.genleftvolvalue.font.color  := ltblank;
    commanderfo.genrightvolvalue.font.color := ltblank;
    commanderfo.sysvolbut.font.color        := ltblank;

    commanderfo.volumeleft1val.font.color := ltblank;
    commanderfo.volumeleft2val.font.color := ltblank;

    commanderfo.volumeright1val.font.color := ltblank;
    commanderfo.volumeright2val.font.color := ltblank;

    commanderfo.tslider2val.font.color := ltblank;
    commanderfo.tslider3val.font.color := ltblank;

    commanderfo.timemix.font.color := ltblank;

    commanderfo.butinput.colorglyph       := ltblank;
    commanderfo.butinput.frame.font.color := ltblank;

    commanderfo.automix.colorglyph       := ltblank;
    commanderfo.automix.frame.font.color := ltblank;

    commanderfo.timemix.frame.colorglyph := ltblank;

    // commanderfo.tfacegriptab.template.fade_color.items[0] := $EDEDED;
    // commanderfo.tfacegriptab.template.fade_color.items[1] := $BABABA;

    commanderfo.timemix.frame.font.color := ltblank;


    filelistfo.historyfn.frame.button.colorglyph := ltblank;
    filelistfo.historyfn.dropdown.colorclient    := ltblack;

    filelistfo.list_files.datacols[0].color      := ltblack;
    filelistfo.list_files.datacols[0].font.color := ltblank;
    filelistfo.list_files.datacols[1].color      := ltblack;
    filelistfo.list_files.datacols[1].font.color := ltblank;
    filelistfo.list_files.datacols[2].color      := ltblack;
    filelistfo.list_files.datacols[2].font.color := ltblank;
    filelistfo.list_files.datacols[3].color      := ltblack;
    filelistfo.list_files.datacols[3].font.color := ltblank;
    filelistfo.list_files.datacols[3].colorglyph := ltblank;

    for x := 0 to filelistfo.list_files.rowcount - 1 do
      filelistfo.list_files.rowfontstate[x] := 1;

    filelistfo.list_files.datacols.colorselect    := $B55B00;
    filelistfo.list_files.datacols[3].colorselect := $707070;

    aboutfo.font.color := cl_black;
  end;

  if lastrowplayed <> -1 then
    if typecolor.Value = 2 then
    begin
      filelistfo.list_files.rowcolorstate[lastrowplayed] := 2;
      filelistfo.list_files.rowfontstate[lastrowplayed]  := 1;
    end
    else
    begin
      filelistfo.list_files.rowcolorstate[lastrowplayed] := 0;
      filelistfo.list_files.rowfontstate[lastrowplayed]  := 0;
    end;

  commanderfo.volumeright2.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.volumeright1.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.volumeleft2.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.volumeleft1.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.sysvol.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.genvolright.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];

  commanderfo.genvolleft.scrollbar.facebutton.image.alignment :=
    [al_xcentered, al_stretchx, al_stretchy];
  commanderfo.tslider2.scrollbar.facebutton.image.alignment   :=
    [al_xcentered, al_stretchx, al_stretchy];
  commanderfo.tslider3.scrollbar.facebutton.image.alignment   :=
    [al_xcentered, al_stretchx, al_stretchy];


  songplayerfo.DrawWaveForm();
  songplayer2fo.DrawWaveForm();

  commanderfo.ontimerinit(nil);
  songplayerfo.ontimercheck(nil);
  songplayer2fo.ontimercheck(nil);

end;

procedure tmainfo.onmenuaudio(const Sender: TObject);
begin
  application.ProcessMessages;
  songplayerfo.doplayerstop(Sender);
  songplayer2fo.doplayerstop(Sender);
  uos_Stop(therecplayer);
  application.ProcessMessages;
  configfo.oncheckdevices(nil);
  application.ProcessMessages;
  configfo.tstringdisp1.Visible := False;
  configfo.Show(True);
end;

procedure tmainfo.onresized(const Sender: TObject);
begin

  if (hasinit = 1) then
    if timerwait.Enabled then
      timerwait.restart // to reset
    else
      timerwait.Enabled := True;

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
  updatelayoutstrum();
end;

procedure tmainfo.onmaindock(const Sender: TObject);
begin

  basedock.dragdock.currentsplitdir := sd_horz;
  updatelayoutstrum();

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

procedure tmainfo.onexit(const Sender: TObject);
begin
  Close;
end;

procedure tmainfo.showpan4(const Sender: TObject);
begin
  dockpanel4fo.Visible := not dockpanel4fo.Visible;
end;

procedure tmainfo.showpan5(const Sender: TObject);
begin
  dockpanel5fo.Visible := not dockpanel5fo.Visible;
end;

procedure tmainfo.ondockrec2(const Sender: TObject);
begin
  ondockrec(Sender);
  sleep(100);
  application.ProcessMessages;
  ondockrec(Sender);
end;

procedure tmainfo.ondockrec(const Sender: TObject); // Record Stage layout
var
  pt1: pointty;
  rect1: rectty;
  interv: integer;
  decorationheight: integer = 5;
begin
  oktimer           := 1;
  infosdfo.Visible  := False;
  infosdfo.dragdock.float();
  infosdfo2.Visible := False;
  infosdfo2.dragdock.float();
  synthefo.Visible  := False;
  synthefo.dragdock.float();
  pianofo.Visible   := False;
  pianofo.dragdock.float();

  //   {$if not defined(darwin)}
  if imagedancerfo.Visible then
    imagedancerfo.dragdock.float();
  // {$endif}

  wavefo.Visible := False;
  wavefo.dragdock.float();

  wavefo2.Visible := False;
  wavefo2.dragdock.float();

  basedock.dragdock.currentsplitdir := sd_horz;
  decorationheight := window.decoratedbounds_cy - Height;

  rect1 := application.screenrect(window);

  interv := (rect1.cx - (songplayerfo.Width + recorderfo.Width + 20)) div 2;

  drumsfo.dragdock.float();
  drumsfo.Visible := False;

  guitarsfo.dragdock.float();
  guitarsfo.Visible := False;

  spectrum2fo.dragdock.float();
  spectrum2fo.Visible := False;

  songplayer2fo.dragdock.float();
  songplayer2fo.Visible := False;

  wavefo2.dragdock.float();
  wavefo2.Visible := False;

  commanderfo.dragdock.float();
  commanderfo.Visible := False;

  filelistfo.dragdock.float();
  filelistfo.Visible := False;

  equalizerfo2.dragdock.float();
  equalizerfo2.Visible := False;

  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  spectrum1fo.Visible    := True;
  songplayerfo.Visible   := True;
  wavefo.Visible         := True;
  waveforec.Visible      := True;
  recorderfo.Visible     := True;
  equalizerfo1.Visible   := True;
  equalizerforec.Visible := True;

  spectrumrecfo.Visible := True;

  norefresh := True;

  commanderfo.automix.Value := False;

  songplayerfo.edvolleft.Value  := 100;
  songplayerfo.edvolright.Value := 100;

  recorderfo.sentcue1.Value := True;

  beginlayout();

  with dockpanel1fo do
  begin
    Visible := True;

    songplayerfo.Visible      := True;
    songplayerfo.parentwidget := basedock;

    spectrum1fo.Visible      := True;
    spectrum1fo.parentwidget := basedock;

    equalizerfo1.Visible      := True;
    equalizerfo1.parentwidget := basedock;

    pt1 := nullpoint;

    spectrum1fo.pos := pt1;
    pt1.y           := pt1.y + spectrum1fo.Height + decorationheight;

    equalizerfo1.pos := pt1;
    pt1.y := pt1.y + equalizerfo1.Height + decorationheight;

    songplayerfo.pos := pt1;
    pt1.y := pt1.y + songplayerfo.Height + decorationheight;


    if dockpanel1fo.Timerwaitdp.Enabled then
      dockpanel1fo.Timerwaitdp.restart // to reset
    else
      dockpanel1fo.Timerwaitdp.Enabled := True;

  end;

  recorderfo.Visible      := True;
  recorderfo.parentwidget := basedock;

  spectrumrecfo.Visible      := True;
  spectrumrecfo.parentwidget := basedock;

  equalizerforec.Visible      := True;
  equalizerforec.parentwidget := basedock;

  waveforec.bounds_cxmax := fowidth;
  waveforec.bounds_cymax := wavefoheight;
  waveforec.Width        := fowidth;
  waveforec.Height       := wavefoheight;

  waveforec.Visible      := True;
  waveforec.parentwidget := basedock;

  pt1 := nullpoint;

  spectrumrecfo.pos := pt1;
  pt1.y := pt1.y + spectrumrecfo.Height + decorationheight;

  equalizerforec.pos := pt1;
  pt1.y := pt1.y + equalizerforec.Height + decorationheight;

  recorderfo.pos := pt1;
  pt1.y          := pt1.y + recorderfo.Height + decorationheight;

  waveforec.pos := pt1;

  left := interv;
  top  := decorationheight + 4;

  dockpanel1fo.left := recorderfo.Width + 10 + interv;

  wavefo.dragdock.float();
  wavefo.left := left;

  wavefo.Width := (2 * fowidth) + 10;

  wavefo.Height := songplayerfoheight;

  wavefo.top := equalizerforec.Height + (3 * songplayerfoheight) + (2 * decorationheight);

  dockpanel1fo.top := equalizerforec.Height - (decorationheight div 2) + 8;

  endlayout();

  norefresh := False;
  dockpanel1fo.activate;
  wavefo.activate;

  Visible := True;
  if timeract.Enabled then
    timeract.restart // to reset
  else
    timeract.Enabled := True;

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;

end;

procedure tmainfo.loadlayout(const Sender: TObject);
var
  ordir: msestring;
begin

  ordir := GetUserDir + directoryseparator;

  tfiledialogx2.controller.icon        := icon;
  tfiledialogx2.controller.captionopen := 'Open Layout File';
  tfiledialogx2.controller.fontcolor   := cl_black;

  tfiledialogx2.controller.filter     := '"*.lay"';
  if tfiledialogx2.controller.filename = '' then
    tfiledialogx2.controller.filename := ordir;
  tfiledialogx2.controller.options := [fdo_sysfilename, fdo_savelastdir];

  if tfiledialogx2.controller.Execute(fdk_open) = mr_ok then
    if fileexists(tfiledialogx2.controller.filename) then
      mainfo.tstatfile1.readstat(msestring(tfiledialogx2.controller.filename));

end;

procedure tmainfo.savelayout(const Sender: TObject);
begin

  tfiledialogx2.controller.icon        := icon;
  tfiledialogx2.controller.captionsave := 'Save Layout as (must have ".lay" as extension).';
  tfiledialogx2.controller.fontcolor   := cl_black;

  tfiledialogx2.controller.filter     := '"*.lay"';
  if tfiledialogx2.controller.filename = '' then
    tfiledialogx2.controller.filename := GetUserDir + directoryseparator + 'mylayout.lay';
  tfiledialogx2.controller.options := [fdo_sysfilename, fdo_savelastdir];

  if tfiledialogx2.controller.Execute(fdk_save) = mr_ok then
    tstatfile1.writestat(tfiledialogx2.controller.filename);

end;

procedure tmainfo.onshowrandom(const Sender: TObject);
begin
  randomnotefo.Visible := not randomnotefo.Visible;
end;

procedure tmainfo.onrandomlayout(const Sender: TObject);
begin
   //  {$if not defined(darwin)}  
  statusanim := 0;
  //  {$endif}
  dockpanel1fo.Visible  := False;
  dockpanel2fo.Visible  := False;
  dockpanel3fo.Visible  := False;
  dockpanel4fo.Visible  := False;
  dockpanel5fo.Visible  := False;
  //     {$if not defined(darwin)}
  imagedancerfo.Visible := False;
  //  {$endif}
  infosdfo.Visible      := False;
  infosdfo2.Visible     := False;

  synthefo.Visible := False;
  pianofo.Visible  := False;

  hideall(nil);

  commanderfo.Visible := True;
  filelistfo.Visible  := True;

  songplayerfo.Visible  := True;
  songplayer2fo.Visible := True;

  oktimer := 1;

  ondockall(nil);

  oktimer := 0;
 
   if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;
    
  sleep(200);
  randomnotefo.Visible := True;
  randomnotefo.bringtofront;
 end;

procedure tmainfo.showimagedancer(const Sender: TObject);
begin
  //   {$if not defined(darwin)}
  imagedancerfo.Visible := not imagedancerfo.Visible;
  if imagedancerfo.Visible then
    imagedancerfo.bringtofront;
  //  {$endif}   
end;

procedure tmainfo.onimagedancer(const Sender: TObject);
{$IFDEF unix}
var
bo : boolean;
gl_Handle:TLibHandle=dynlibs.NilHandle;
{$ENDIF}
begin
  //{$if not defined(darwin)}
{$IFDEF unix}
  gl_Handle := DynLibs.SafeLoadLibrary('libGL.so.1'); // check if gl is installed
 if gl_Handle  <> DynLibs.NilHandle then bo := true
  else bo := false;
  if bo then    DynLibs.UnloadLibrary(gl_Handle);
 {$ENDIF}

  if (tmenuitem(Sender).tag = 12) then
  begin
    imagedancerfo.Caption := 'Dancing Fractal Circles by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 12;
    dancnum.Value := 12;
  end
  else if (tmenuitem(Sender).tag = 11) then
  begin
    imagedancerfo.Caption := 'Dancing Turtle 2 by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 11;
    dancnum.Value := 11;
  end
  else if (tmenuitem(Sender).tag = 10) then
  begin
    imagedancerfo.Caption := 'Dancing Turtle 1 by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 10;
    dancnum.Value := 10;
  end
  else if (tmenuitem(Sender).tag = 9) then
  begin
   {$IFDEF unix} 
  if bo then begin
  {$ENDIF}
    imagedancerfo.Caption := 'Dancing Lines';
    imagedancerfo.openglwidget.Visible := True;
    dancernum     := 9;
    dancnum.Value := 9;
    {$IFDEF unix} 
  end;
  {$ENDIF}
  end
  else if (tmenuitem(Sender).tag = 8) then
  begin
     {$IFDEF unix} 
  if bo then begin
  {$ENDIF}
    imagedancerfo.Caption := 'Dancing Triangle';
    imagedancerfo.openglwidget.Visible := True;
    dancernum     := 8;
    dancnum.Value := 8;
     {$IFDEF unix} 
  end;
  {$ENDIF}
  end
  else if (tmenuitem(Sender).tag = 7) then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Move by Winni';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 7;
    dancnum.Value := 7;
  end
  else if (tmenuitem(Sender).tag = 6) then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Rainbow by Winni';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 6;
    dancnum.Value := 6;
  end
  else if (tmenuitem(Sender).tag = 5) then
  begin
    imagedancerfo.Caption := 'Dancing Spiral Hue by Winni';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 5;
    dancnum.Value := 5;
  end
  else if (tmenuitem(Sender).tag = 4) then
  begin
    imagedancerfo.Caption := 'Dancing Atom by Winni';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 4;
    dancnum.Value := 4;
  end
  else if (tmenuitem(Sender).tag = 3) then
  begin

  {$IFDEF unix} 
  if bo then begin
  {$ENDIF}
    imagedancerfo.Caption := 'Dancing Square';
    imagedancerfo.openglwidget.Visible := True;
    dancernum     := 3;
    dancnum.Value := 3;
  {$IFDEF unix} 
   end;
  {$ENDIF}
  end
  else if (tmenuitem(Sender).tag = 0) then
  begin
    imagedancerfo.Caption := 'Fractal Tree by Lainz';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 0;
    dancnum.Value := 0;
  end
  else if (tmenuitem(Sender).tag = 1) then
  begin
    imagedancerfo.Caption := 'Super Formula';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 1;
    dancnum.Value := 1;
  end
  else if (tmenuitem(Sender).tag = 2) then
  begin
    imagedancerfo.Caption := 'Hyper formula';
    imagedancerfo.openglwidget.Visible := False;
    dancernum     := 2;
    dancnum.Value := 2;
  end;

  imagedancerfo.Visible := True;
  //  {$ENDIF}
end;

procedure tmainfo.ondancerlayout(const Sender: TObject);
begin
  //{$if not defined(darwin)}
  infosdfo.Visible  := False;
  infosdfo2.Visible := False;
  synthefo.Visible  := False;
  pianofo.Visible   := False;

  dockpanel1fo.Visible := False;
  dockpanel2fo.Visible := False;
  dockpanel3fo.Visible := False;
  dockpanel4fo.Visible := False;
  dockpanel5fo.Visible := False;

  wavefo.Visible         := False;
  wavefo2.Visible        := False;
  waveforec.Visible      := False;
  drumsfo.Visible        := False;
  recorderfo.Visible     := False;
  equalizerfo1.Visible   := False;
  equalizerfo2.Visible   := False;
  equalizerforec.Visible := False;

  guitarsfo.Visible     := False;
  spectrum1fo.Visible   := False;
  spectrum2fo.Visible   := False;
  spectrumrecfo.Visible := False;
  commanderfo.Visible   := True;
  filelistfo.Visible    := True;

  songplayerfo.Visible  := True;
  songplayer2fo.Visible := True;

  oktimer := 1;

  ondockall(nil);

  oktimer := 0;

  if timerwait.Enabled then
    timerwait.restart // to reset
  else
    timerwait.Enabled := True;


  left := 200;
  top  := 30;
  imagedancerfo.dragdock.float();
  imagedancerfo.bounds_cxmax := 0;
  imagedancerfo.bounds_cymax := 0;
  imagedancerfo.Height := Height;
  imagedancerfo.top := top;
  imagedancerfo.left := right + 10;
  imagedancerfo.Width := Height;
  imagedancerfo.top := top;

  imagedancerfo.dragdock.float();

  imagedancerfo.Visible := True;

  //  {$ENDIF}

end;

procedure tmainfo.onclose(const Sender: TObject);
begin

  if drumsfo.Visible then
    drumsvisible.Value := 1
  else
    drumsvisible.Value := 0;

  imagedancerfo.Visible := False;

  infosdfo.ttimer1.Enabled  := False;
  infosdfo2.ttimer1.Enabled := False;

  uos_Stop(theplayer);
  uos_Stop(theplayer2);
  //  {$if not defined(darwin)}  
  statusanim := 0;
  //  {$endif}
  songplayerfo.Timerwait.Enabled := False;
  songplayerfo.Timersent.Enabled := False;
  songplayer2fo.Timerwait.Enabled := False;
  songplayer2fo.Timersent.Enabled := False;

end;

procedure tmainfo.ontimertransp(const Sender: TObject);
begin

  if allok = False then
  begin
    ttimer1.Enabled := False;
 {$if defined(netbsd) or defined(darwin)}
  windowopacity := 1;
 {$else}
    windowopacity   := 0;
 {$endif}
    application.ProcessMessages;
    application.createform(terrorfo, errorfo);
    errorfo.Show;
    application.ProcessMessages;
    sleep(2000);
    application.terminate;
  end
  else
  begin
   {$if not defined(netbsd) and not defined(darwin)}
    windowopacity := windowopacity + 0.1;
    //{
    dockpanel1fo.windowopacity := dockpanel1fo.windowopacity + 0.1;
    dockpanel2fo.windowopacity := dockpanel2fo.windowopacity + 0.1;
    dockpanel3fo.windowopacity := dockpanel3fo.windowopacity + 0.1;
    dockpanel4fo.windowopacity := dockpanel4fo.windowopacity + 0.1;
    dockpanel5fo.windowopacity := dockpanel5fo.windowopacity + 0.1;

    commanderfo.windowopacity    := commanderfo.windowopacity + 0.1;
    songplayerfo.windowopacity   := songplayerfo.windowopacity + 0.1;
    songplayer2fo.windowopacity  := songplayer2fo.windowopacity + 0.1;
    filelistfo.windowopacity     := filelistfo.windowopacity + 0.1;
    wavefo.windowopacity         := wavefo.windowopacity + 0.1;
    wavefo2.windowopacity        := wavefo2.windowopacity + 0.1;
    waveforec.windowopacity      := waveforec.windowopacity + 0.1;
    spectrum1fo.windowopacity    := spectrum1fo.windowopacity + 0.1;
    spectrum2fo.windowopacity    := spectrum2fo.windowopacity + 0.1;
    spectrumrecfo.windowopacity  := spectrumrecfo.windowopacity + 0.1;
    equalizerfo1.windowopacity   := equalizerfo1.windowopacity + 0.1;
    equalizerfo2.windowopacity   := equalizerfo2.windowopacity + 0.1;
    equalizerforec.windowopacity := equalizerforec.windowopacity + 0.1;
    drumsfo.windowopacity        := drumsfo.windowopacity + 0.1;
    randomnotefo.windowopacity   := randomnotefo.windowopacity + 0.1;
    guitarsfo.windowopacity      := guitarsfo.windowopacity + 0.1;
    recorderfo.windowopacity     := recorderfo.windowopacity + 0.1;

    imagedancerfo.windowopacity := imagedancerfo.windowopacity + 0.1;
    {$ENDIF}
    if windowopacity >= 1 then
      ttimer1.Enabled           := False;

  end;

end;

procedure tmainfo.showequalizer1(const Sender: TObject);
begin
  equalizerfo1.Visible := not equalizerfo1.Visible;
end;

procedure tmainfo.showequalizer2(const Sender: TObject);
begin
  equalizerfo2.Visible := not equalizerfo2.Visible;
end;

procedure tmainfo.showequalizerrec(const Sender: TObject);
begin
  equalizerforec.Visible := not equalizerforec.Visible;
end;

procedure tmainfo.onsetwindowdancer(const Sender: TObject);
begin
  //       {$if not defined(darwin)}
  if (tmenuitem(Sender).tag = 0) then      // normal
  begin
    typwindow := 0;
    imagedancerfo.OptionsWindow := [];
    imagedancerfo.frame.grip_size := 8;
  end
  else if (tmenuitem(Sender).tag = 1) then // ellipse
  begin
    typwindow := 1;
    imagedancerfo.OptionsWindow := [wo_ellipse, wo_noframe];
    imagedancerfo.frame.grip_size := 0;
  end
  else if (tmenuitem(Sender).tag = 2) then // round rect
  begin
    typwindow := 2;
    imagedancerfo.OptionsWindow := [wo_rounded, wo_noframe];
    imagedancerfo.frame.grip_size := 0;
  end
  else if (tmenuitem(Sender).tag = 3) then // rect
  begin
    typwindow := 3;
    imagedancerfo.OptionsWindow := [wo_noframe];
    imagedancerfo.frame.grip_size := 0;
  end;

  imagedancerfo.Window.RecreateWindow;
  statusanim := 1;

  if alwaystop = 0 then
    imagedancerfo.bringtofront;
  //    {$endif}  
end;

procedure tmainfo.onalwaysontop(const Sender: TObject);
begin
  //  {$if not defined(darwin)}
  if as_checked in mainfo.tmainmenu1.menu.itembynames(['dancer', 'alwaystop']).state then
  begin
    alwaystop := 1;
    imagedancerfo.OptionsWindow := imagedancerfo.OptionsWindow + [wo_alwaysontop];
  end
  else
  begin
    alwaystop := 0;
    imagedancerfo.OptionsWindow := imagedancerfo.OptionsWindow - [wo_alwaysontop];
  end;

  imagedancerfo.Window.RecreateWindow;
  statusanim := 1;

  if alwaystop = 0 then
    imagedancerfo.bringtofront;
  //   {$endif}   
end;

procedure tmainfo.onhidedancer(const Sender: TObject);
begin
  //  {$if not defined(darwin)}
  imagedancerfo.Visible := False;
  //  {$endif}
end;

procedure tmainfo.ontimeridle(const Sender: TObject);
var
  MousePos: pointty;
  AProcess: TProcess;
begin
  MousePos   := application.mouse.pos;
  MousePos.X := MousePos.X + 1;
  application.mouse.pos := MousePos;
  application.ProcessMessages;
  MousePos.X := MousePos.X - 1;
  application.mouse.pos := MousePos;
  application.ProcessMessages;

  if configlayoutfo.bosleep.Value then
  begin
    AProcess := TProcess.Create(nil);

      {$WARN SYMBOL_DEPRECATED OFF}
       {$ifdef linux}
    AProcess.Executable := '/usr/bin/xset';
    AProcess.Parameters.Add('dpms');
    AProcess.Parameters.Add('force');
    AProcess.Parameters.Add('off');
     {$else}
      AProcess.CommandLine := 'rundll32.exe powrprof.dll, SetSuspendState Sleep';
       {$endif}
      {$WARN SYMBOL_DEPRECATED ON}
    AProcess.Priority := ppRealTime;
    AProcess.Options  := [poNoConsole];
    AProcess.Execute;
    AProcess.Free;
  end;

end;

procedure tmainfo.onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
begin

  if ttimer2.Enabled then
    ttimer2.restart // to reset
  else
    ttimer2.Enabled := True;

end;

procedure tmainfo.onlangset(const Sender: TObject);
begin
  conflangfo.Show(True);
 // conflangfo.resizecl(fontheightused);
end;

procedure tmainfo.onactiv(const Sender: TObject);
var
  x: integer;
  oldlang: msestring;
  rect1: rectty;
  fontheightsugg: integer;
begin
  {$ifdef darwin} 
  tmainmenu1.menu.itembynames(['dancer', 'ellipse']).visible := false;
  tmainmenu1.menu.itembynames(['dancer', 'roundrect']).visible := false;
  tmainmenu1.menu.itembynames(['dancer', 'transparent']).visible := false;
  {$endif}

  rect1 := application.screenrect(window);

 {$ifdef mswindows}// to check
  fontheightsugg := roundmath(rect1.cx / 1330 * 12);
 {$else}
 fontheightsugg := roundmath(rect1.cx / 1368 * 12);
 {$endif}

  configlayoutfo.autoheight.frame.Caption := 'Use at loading suggested font height: ' + IntToStr(fontheightsugg);

  if configlayoutfo.autoheight.Value then
    configlayoutfo.fontheight.Value := fontheightsugg;

  fontheightused := roundmath(configlayoutfo.fontheight.Value);
  resizema(fontheightused);
  applyfont(fontheightused);

  oncreatedform(Sender);

  if isactivated = False then
  begin
    isactivated := True;
    conflangfo.Visible := False;
    oldlang := MSEFallbackLang;

    if conflangfo.setasdefault.Value = True then
    begin
      for x := 0 to conflangfo.gridlang.rowcount - 1 do
        if conflangfo.gridlangbool[x] = True then
          MSEFallbackLang := conflangfo.gridlangcode[x];

      if oldlang <> MSEFallbackLang then
        setlangstrumpract(MSEFallbackLang);
    end
    else
      setlangstrumpract(MSEFallbackLang);

    configlayoutfo.onchangehint(Sender);
  end;
  if mainfo.drumsvisible.Value = 1 then
    drumsfo.Visible := True;

  infosdfo.onshow(nil);
  infosdfo2.onshow(nil);
  synthefo.onchangest(nil);
  pianofo.onchangest(nil);

  updatelayoutstrum();

  if dockpanel1fo.Visible then
    dockpanel1fo.updatelayoutpan();

  if dockpanel2fo.Visible then
    dockpanel2fo.updatelayoutpan();

  if dockpanel3fo.Visible then
    dockpanel3fo.updatelayoutpan();

  if dockpanel4fo.Visible then
    dockpanel4fo.updatelayoutpan();

  if dockpanel5fo.Visible then
    dockpanel5fo.updatelayoutpan();

  onchangevalcolor(nil);

  configlayoutfo.onsetcolor(nil);

  splashfo.Close;

end;

procedure tmainfo.showinfos1(const Sender: TObject);
begin
  infosdfo.Visible := not infosdfo.Visible;
end;

procedure tmainfo.showinfos2(const Sender: TObject);
begin
  infosdfo2.Visible := not infosdfo2.Visible;
end;

procedure tmainfo.onfloatdancer(const Sender: TObject);
begin
  //   {$if not defined(darwin)}
  imagedancerfo.dragdock.float();
  imagedancerfo.Visible := True;
  updatelayoutstrum();
  //    {$endif}
end;

procedure tmainfo.ondockdancer(const Sender: TObject);
begin
  //   {$if not defined(darwin)}
  imagedancerfo.parentwidget := basedock;
  imagedancerfo.Visible      := True;
  updatelayoutstrum();
  //    {$endif}
end;

procedure tmainfo.onshowsynth(const Sender: TObject);
begin
  synthefo.Visible := not synthefo.Visible;
end;

procedure tmainfo.onshowpiano(const Sender: TObject);
begin
  pianofo.Visible := not pianofo.Visible;
end;

procedure tmainfo.ondockvert(const Sender: TObject);
begin
  basedock.dragdock.currentsplitdir := sd_vert;
  updatelayoutstrum();
end;

procedure tmainfo.onconfiglayout(const Sender: TObject);
begin
  configlayoutfo.onsetfontres(Sender);
  configlayoutfo.Show(True);
end;

procedure tmainfo.afterfaceplayer(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  //  point1, point2: pointty;
  image: TBGRABitmap;
  grad: TBGRAGradientScanner;
begin
{  
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  Canvas.drawline(point1, point2, cl_red);

}

  image := TBGRABitmap.Create(ClientWidth, ClientHeight, CSSSilver);

  grad := TBGRAGradientScanner.Create($3B3B3B, $626262, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True);

  image.FillRect(0, 0, arect.cx, arect.cy, grad, dmDrawWithTransparency, daFloydSteinberg);


  image.Draw(Canvas, 0, 0, True);
  image.Free;
  grad.Free;
end;

procedure tmainfo.beforefaceplayer(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty; var handled: Boolean);
var
  //  point1, point2: pointty;
  image: TBGRABitmap;
  grad: TBGRAGradientScanner;
begin
  handled := False;

  image := TBGRABitmap.Create(ClientWidth, ClientHeight, CSSSilver);

  if typecolor.Value = 2 then
    grad := TBGRAGradientScanner.Create($3B3B3B, $626262, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True)
  else if typecolor.Value = 0 then
    grad := TBGRAGradientScanner.Create($D4D8A8, $E7EAD2, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True)
  else if typecolor.Value = 1 then
    grad := TBGRAGradientScanner.Create($C9C9C9, $E1E1E1, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True)
  else if typecolor.Value = 3 then
    grad := TBGRAGradientScanner.Create($FDA4FE, $FFD5F0, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True);


  image.FillRect(0, 0, arect.cx, arect.cy, grad, dmDrawWithTransparency, daFloydSteinberg);


  image.Draw(Canvas, 0, 0, True);
  image.Free;
  grad.Free;
end;

procedure tmainfo.aftergreen(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  //  point1, point2: pointty;
  image: TBGRABitmap;
  grad: TBGRAGradientScanner;
begin
{  
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  Canvas.drawline(point1, point2, cl_red);

}

  image := TBGRABitmap.Create(ClientWidth, ClientHeight, CSSSilver);

  grad := TBGRAGradientScanner.Create($6EB545, $C2FF9E, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True);

  image.FillRect(0, 0, arect.cx, arect.cy, grad, dmDrawWithTransparency, daFloydSteinberg);


  image.Draw(Canvas, 0, 0, True);
  image.Free;
  grad.Free;
end;

procedure tmainfo.beforegreen(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty; var handled: Boolean);
var
  image: TBGRABitmap;
  grad: TBGRAGradientScanner;
begin

  handled := False;

  image := TBGRABitmap.Create(ClientWidth, ClientHeight, CSSSilver);

  grad := TBGRAGradientScanner.Create($6EB545, $C2FF9E, gtLinear, PointF(0, 0), PointF(0, arect.cy), True, True);

  image.FillRect(0, 0, arect.cx, arect.cy, grad, dmDrawWithTransparency, daFloydSteinberg);


  image.Draw(Canvas, 0, 0, True);
  image.Free;
  grad.Free;
end;


end.

