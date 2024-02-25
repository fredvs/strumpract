unit synthe;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  mseeditglob,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  uos_mseaudio,
  uos_msesigaudio,
  msesignal,
  msestrings,
  msesignoise,
  msechartedit,
  msedataedits,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msesiggui,
  msedock,
  msestatfile,
  msesigfft,
  msesigfftgui,
  msegraphedits,
  msescrollbar,
  msedispwidgets,
  mserichstring,
  msesplitter,
  msesimplewidgets,
  msefilter,
  mseact,
  msestream,
  SysUtils,
  msebitmap,
  msedropdownlist,
  Math;

type
  tsynthefo = class(tdockform)
    cont: tsigcontroller;
    out: tsigoutaudio;
    noise: tsignoise;
    tsignoise4: tsignoise;
    tsigoutaudio4: tsigoutaudio;
    tsigcontroller4: tsigcontroller;
    noise2: tsignoise;
    tsignoise42: tsignoise;
    tgroupbox4: tgroupbox;
    sliderfreqwaveL: tslider;
    sliderfreqwaveR: tslider;
    wavetypeL: tenumtypeedit;
    sliderwaveL: tslider;
    freqwavL: tintegeredit;
    harmonwaveL: tintegeredit;
    OddwaveL: tbooleanedit;
    volwavL: tintegerdisp;
    wavetypeR: tenumtypeedit;
    harmonwaveR: tintegeredit;
    volwavR: tintegerdisp;
    sliderwaveR: tslider;
    freqwavR: tintegeredit;
    linkwavchan: tbooleanedit;
    OddwaveR: tbooleanedit;
    onwavon: tbooleanedit;
    onnoiseon: tbooleanedit;
    tgroupbox3: tgroupbox;
    sampcountR: tslider;
    tsigslider1: tsigslider;
    sampcountdiR: tintegerdisp;
    noiseampR: tintegerdisp;
    sampcountdiL: tintegerdisp;
    sampcountL: tslider;
    noiseampL: tintegerdisp;
    tsigslider1L: tsigslider;
    linknoisechan: tbooleanedit;
    kinded: tenumtypeedit;
    kindedR: tenumtypeedit;
    procedure onclosexe(const Sender: TObject);
    procedure samcountsetexeR(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure typinitexe(const Sender: tenumtypeedit);
    procedure kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure oncreated(const Sender: TObject);
    procedure oninit(const Sender: TObject);
    procedure onwaveactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onvolwaveL(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onfreqwaveL(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangewave(const Sender: TObject);
    procedure onsetampnoiseR(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onquit(const Sender: TObject);
    procedure onvolwaveR(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onfreqwaveR(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure kindsetexeR(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetampnoiseL(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure samcountsetexeL(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onvaluefreqL(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onvaluefreqR(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetharmL(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetharmR(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetwavekindL(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetwavekindR(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure onsetoddL(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onsetoddR(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onmousev(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure onchangest(const Sender: TObject);
    procedure onnoiseactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);

    procedure resizesy(fontheight: integer);

  end;

var
  synthefo: tsynthefo;
  hasinit: Boolean = False;

implementation

uses
  captionstrumpract,
  dockpanel1,
  main,
  synthe_mfm;

var
  boundchildsy: array of boundchild;

procedure tsynthefo.resizesy(fontheight: integer);
var
  childrensp: widgetarty;
  heights: integerarty;
  widths: integerarty;
  tops: integerarty;
  lefts: integerarty;
  i1, i2: integer;
  ratio: double;
begin
  ratio        := fontheight / 12;
  bounds_cxmax := 0;
  bounds_cxmin := 0;
  bounds_cymax := 0;
  bounds_cymin := 0;
  bounds_cxmax := floor(442 * ratio);
  bounds_cxmin := bounds_cxmax;
  bounds_cymax := floor(284 * ratio);
  bounds_cymin := bounds_cymax;
  font.Height  := fontheight;

  frame.grip_size := floor(8 * ratio);

  for i1 := 0 to childrencount - 1 do
    for i2 := 0 to length(boundchildsy) - 1 do
      if children[i1].Name = boundchildsy[i2].Name then
      begin
        children[i1].left   := floor(boundchildsy[i2].left * ratio);
        children[i1].top    := floor(boundchildsy[i2].top * ratio);
        children[i1].Width  := floor(boundchildsy[i2].Width * ratio);
        children[i1].Height := floor(boundchildsy[i2].Height * ratio);
      end;

  tgroupbox4.font.Height := fontheight;
  tgroupbox4.font.color  := font.color;
  tgroupbox3.font.Height := fontheight;
  tgroupbox3.font.color  := font.color;

  with tgroupbox4 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildsy) - 1 do
        if children[i1].Name = boundchildsy[i2].Name then
        begin
          children[i1].left   := floor(boundchildsy[i2].left * ratio);
          children[i1].top    := floor(boundchildsy[i2].top * ratio);
          children[i1].Width  := floor(boundchildsy[i2].Width * ratio);
          children[i1].Height := floor(boundchildsy[i2].Height * ratio);
        end;

  tgroupbox3.font.Height := fontheight;

  with tgroupbox3 do
    for i1 := 0 to childrencount - 1 do
      for i2 := 0 to length(boundchildsy) - 1 do
        if children[i1].Name = boundchildsy[i2].Name then
        begin
          children[i1].left   := floor(boundchildsy[i2].left * ratio);
          children[i1].top    := floor(boundchildsy[i2].top * ratio);
          children[i1].Width  := floor(boundchildsy[i2].Width * ratio);
          children[i1].Height := floor(boundchildsy[i2].Height * ratio);
        end;
end;

procedure tsynthefo.onclosexe(const Sender: TObject);
begin
  if hasinit then
  begin
    out.audio.active := False;
    //  tsigoutaudio1.audio.active := False;
    tsigoutaudio4.audio.active := False;
    onwavon.color   := cl_transparent;
    onnoiseon.color := cl_transparent;
    // onpianoon.color := cl_transparent;
  end;
end;

procedure tsynthefo.samcountsetexeR(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noise.samplecount  := floor(19 * avalue) + 1;
  sampcountdiR.Value := noise.samplecount;

  if linknoisechan.Value then
  begin
    noise2.samplecount := noise.samplecount;
    sampcountdiL.Value := sampcountdiR.Value;
    sampcountL.Value   := avalue;
  end;
end;

procedure tsynthefo.typinitexe(const Sender: tenumtypeedit);
begin
  Sender.typeinfopo := typeinfo(noisekindty);
end;

procedure tsynthefo.kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  noise.kind := noisekindty(avalue);

  if linknoisechan.Value then
  begin
    kindedR.Value := avalue;
    noise2.kind   := noise.kind;
  end;
end;


procedure tsynthefo.oncreated(const Sender: TObject);
var
  ordir: string;
begin

  cont.inputtype := 0;            // from synth/noise
  tsigcontroller4.inputtype := 3; // from waveform
  Caption        := 'Noise Generator';
  hasinit        := True;

end;


procedure tsynthefo.oninit(const Sender: TObject);
var
  i1, childn: integer;
begin
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  setlength(boundchildsy, childrencount);

  childn := childrencount;

  for i1 := 0 to childrencount - 1 do
  begin
    boundchildsy[i1].left   := children[i1].left;
    boundchildsy[i1].top    := children[i1].top;
    boundchildsy[i1].Width  := children[i1].Width;
    boundchildsy[i1].Height := children[i1].Height;
    boundchildsy[i1].Name   := children[i1].Name;
  end;

  with tgroupbox4 do
  begin
    setlength(boundchildsy, length(boundchildsy) + tgroupbox4.childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildsy[i1 + childn].left   := children[i1].left;
      boundchildsy[i1 + childn].top    := children[i1].top;
      boundchildsy[i1 + childn].Width  := children[i1].Width;
      boundchildsy[i1 + childn].Height := children[i1].Height;
      boundchildsy[i1 + childn].Name   := children[i1].Name;
    end;
    childn := length(boundchildsy);
  end;

  with tgroupbox3 do
  begin
    setlength(boundchildsy, length(boundchildsy) + tgroupbox3.childrencount);

    for i1 := 0 to childrencount - 1 do
    begin
      boundchildsy[i1 + childn].left   := children[i1].left;
      boundchildsy[i1 + childn].top    := children[i1].top;
      boundchildsy[i1 + childn].Width  := children[i1].Width;
      boundchildsy[i1 + childn].Height := children[i1].Height;
      boundchildsy[i1 + childn].Name   := children[i1].Name;
    end;
  end;

end;

procedure tsynthefo.onwaveactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
    begin
      //  onwavon.color := $3B4F00;
      tsigoutaudio4.audio.active := True;
      sleep(10);
      onchangewave(Sender);
    end
    else
      tsigoutaudio4.audio.active := False//  onwavon.color := cl_transparent;
  ;

end;

procedure tsynthefo.onvolwaveL(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volwavL.Value := floor(100 * avalue);
  if linkwavchan.Value then
  begin
    volwavR.Value     := volwavL.Value;
    sliderwaveR.Value := avalue;
  end;
end;

procedure tsynthefo.onfreqwaveL(const Sender: TObject; var avalue: realty; var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := floor(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavL.Value := bvalue;

  if linkwavchan.Value then
  begin
    freqwavR.Value        := freqwavL.Value;
    sliderfreqwaveR.Value := avalue;
  end;

end;


procedure tsynthefo.onchangewave(const Sender: TObject);
var
  isoddL, isoddR: integer;
begin
  if hasinit then
  begin

    if linkwavchan.Value then
      //oddwaveR.Value := oddwaveL.Value;
      //harmonwaveR.Value := harmonwaveL.Value;
      // freqwavR.value := freqwavL.value;
    ;


    if oddwaveL.Value then
      isoddL := 1
    else
      isoddL := 0;

    if oddwaveR.Value then
      isoddR := 1
    else
      isoddR := 0;

    tsigcontroller4.SetWaveForm(wavetypeL.Value, wavetypeR.Value,
      harmonwaveL.Value, harmonwaveR.Value,
      isoddL, isoddR,
      freqwavL.Value, freqwavR.Value,
      volwavL.Value / 100, volwavR.Value / 100);

{TypeWaveL, TypeWaveR,
AHarmonicsL,AHarmonicsR : Integer;
EvenHarmonicsL, EvenHarmonicsR : Shortint;
FreqL, FreqR, VolL, VolR: single);  
}
  end;
end;

procedure tsynthefo.onsetampnoiseR(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noiseampR.Value := floor(avalue * 100);
  if linknoisechan.Value then
  begin
    noiseampL.Value    := noiseampR.Value;
    tsigslider1L.Value := avalue;
  end;
end;

procedure tsynthefo.onquit(const Sender: TObject);
begin
  application.terminate;
end;


procedure tsynthefo.onvolwaveR(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volwavR.Value := floor(100 * avalue);
  if linkwavchan.Value then
  begin
    volwavL.Value     := volwavR.Value;
    sliderwaveL.Value := avalue;
  end;
end;

procedure tsynthefo.onfreqwaveR(const Sender: TObject; var avalue: realty; var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := floor(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavR.Value := bvalue;

  if linkwavchan.Value then
  begin
    freqwavL.Value        := freqwavR.Value;
    sliderfreqwaveL.Value := avalue;
  end;
end;

procedure tsynthefo.kindsetexeR(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  noise2.kind := noisekindty(avalue);

  if linknoisechan.Value then
  begin
    kinded.Value := avalue;
    noise.kind   := noise2.kind;
  end;
end;

procedure tsynthefo.onsetampnoiseL(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noiseampL.Value := floor(avalue * 100);
  if linknoisechan.Value then
  begin
    noiseampR.Value   := noiseampL.Value;
    tsigslider1.Value := avalue;
  end;
end;

procedure tsynthefo.samcountsetexeL(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noise2.samplecount := trunc(19 * avalue) + 1;
  sampcountdiL.Value := noise2.samplecount;

  if linknoisechan.Value then
  begin
    noise.samplecount  := noise2.samplecount;
    sampcountdiR.Value := sampcountdiL.Value;
    sampcountR.Value   := avalue;
  end;
end;

procedure tsynthefo.onvaluefreqL(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
  begin
    sliderfreqwaveL.Value := sqrt(avalue) / 100;
    sliderfreqwaveR.Value := sliderfreqwaveL.Value;
    freqwavR.Value        := avalue;
  end;
end;

procedure tsynthefo.onvaluefreqR(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
  begin
    sliderfreqwaveR.Value := sqrt(avalue) / 100;
    sliderfreqwaveL.Value := sliderfreqwaveR.Value;
    freqwavL.Value        := avalue;
  end;
end;

procedure tsynthefo.onsetharmL(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
    harmonwaveR.Value := avalue;
end;

procedure tsynthefo.onsetharmR(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
    harmonwaveL.Value := avalue;
end;

procedure tsynthefo.onsetwavekindL(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
    wavetypeR.Value := avalue;
end;

procedure tsynthefo.onsetwavekindR(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if linkwavchan.Value then
    wavetypeL.Value := avalue;
end;

procedure tsynthefo.onsetoddL(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if linkwavchan.Value then
    oddwaveR.Value := avalue;
end;

procedure tsynthefo.onsetoddR(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if linkwavchan.Value then
    oddwaveL.Value := avalue;
end;

procedure tsynthefo.onmousev(const Sender: twidget; var ainfo: mouseeventinfoty);
begin

  if (ainfo.eventkind = ek_buttonrelease) then
    wavetypeL.optionsedit := wavetypeL.optionsedit - [oe_readonly];

  if (ainfo.eventkind = ek_buttonpress) then
    wavetypeL.optionsedit := wavetypeL.optionsedit + [oe_readonly];

end;

procedure tsynthefo.onchangest(const Sender: TObject);
begin
  if (isactivated = True) then
  begin
    if Visible then
      mainfo.tmainmenu1.menu.itembynames(['show', 'showsynth']).Caption :=
        lang_mainfo[Ord(ma_hide)] + ': Noise Generator'//  lang_infosfo[Ord(in_infosfo)] ;

    else
      mainfo.tmainmenu1.menu.itembynames(['show', 'showsynth']).Caption :=
        lang_mainfo[Ord(ma_tmainmenu1_show)] + ': Noise Generator';

    if (norefresh = False) and (parentwidget <> nil) then
    begin

      if (parentwidget = mainfo.basedock) or
        (mainfo.basedock.dragdock.currentsplitdir = sd_tabed) then
        mainfo.updatelayoutstrum();

      if (parentwidget = dockpanel1fo.basedock) or
        (dockpanel1fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel1fo.Visible then
          dockpanel1fo.updatelayoutpan();

      if (parentwidget = dockpanel2fo.basedock) or
        (dockpanel2fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel2fo.Visible then
          dockpanel2fo.updatelayoutpan();

      if (parentwidget = dockpanel3fo.basedock) or
        (dockpanel3fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel3fo.Visible then
          dockpanel3fo.updatelayoutpan();

      if (parentwidget = dockpanel4fo.basedock) or
        (dockpanel4fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel4fo.Visible then
          dockpanel4fo.updatelayoutpan();

      if (parentwidget = dockpanel5fo.basedock) or
        (dockpanel5fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel5fo.Visible then
          dockpanel5fo.updatelayoutpan();
    end;
  end;
end;

procedure tsynthefo.onnoiseactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
      out.audio.active := True
    else
      out.audio.active := False;
end;


end.

