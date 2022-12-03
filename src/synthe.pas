unit synthe;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 mseeditglob,msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 uos_mseaudio,uos_msesigaudio,msesignal,msestrings,msesignoise,msechartedit,
 msedataedits,mseedit,mseificomp,mseificompglob,mseifiglob,msesiggui,
 msestatfile,msesigfft,msesigfftgui,msegraphedits,msescrollbar,msedispwidgets,
 mserichstring,msesplitter,msesimplewidgets,msefilter,mseact,msestream,SysUtils,
 msebitmap,msedropdownlist,Math;


type
  tsynthefo = class(tdockform)
    cont: tsigcontroller;
    out: tsigoutaudio;
    noise: tsignoise;
    tsignoise4: tsignoise;
    tsigoutaudio4: tsigoutaudio;
    tsigcontroller4: tsigcontroller;
    tlayouter1: tlayouter;
    onnoiseon: tbooleanedit;
    tgroupbox3: tgroupbox;
    sampcountR: tslider;
    tsigslider1: tsigslider;
    sampcountdiR: tintegerdisp;
    noiseampR: tintegerdisp;
    tgroupbox4: tgroupbox;
    wavetypeL: tenumtypeedit;
    sliderwaveL: tslider;
    freqwavL: tintegeredit;
    sliderfreqwaveL: tslider;
    harmonwaveL: tintegeredit;
    OddwaveL: tbooleanedit;
    onwavon: tbooleanedit;
   volwavL: tintegerdisp;
   noise2: tsignoise;
   tsignoise42: tsignoise;
   wavetypeR: tenumtypeedit;
   harmonwaveR: tintegeredit;
   sliderfreqwaveR: tslider;
   volwavR: tintegerdisp;
   sliderwaveR: tslider;
   freqwavR: tintegeredit;
   sampcountdiL: tintegerdisp;
   sampcountL: tslider;
   noiseampL: tintegerdisp;
   tsigslider1L: tsigslider;
   linkwavchan: tbooleanedit;
   linknoisechan: tbooleanedit;
   OddwaveR: tbooleanedit;
   kinded: tenumtypeedit;
   kindedR: tenumtypeedit;
    procedure onclosexe(const Sender: TObject);
    procedure samcountsetexeR(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure typinitexe(const Sender: tenumtypeedit);
    procedure kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure oncreated(const Sender: TObject);
    procedure oninit(const Sender: TObject);
    procedure onwaveactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onvolwaveL(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onfreqwaveL(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onchangewave(const Sender: TObject);
    procedure onsetampnoiseR(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onresizeform(const Sender: TObject);
    procedure onquit(const Sender: TObject);
   procedure onvolwaveR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onfreqwaveR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure kindsetexeR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetampnoiseL(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure samcountsetexeL(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onvaluefreqL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onvaluefreqR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetharmL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetharmR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetwavekindL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetwavekindR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetoddL(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onsetoddR(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onkey(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onmousev(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure onchangest(const sender: TObject);
   procedure onnoiseactivate(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);

   end;

var
  synthefo: tsynthefo;
  hasinit: Boolean = False;

implementation

uses
captionstrumpract, dockpanel1, main, synthe_mfm;

procedure tsynthefo.onclosexe(const Sender: TObject);
begin
 if hasinit then
begin
  out.audio.active           := False;
//  tsigoutaudio1.audio.active := False;
  tsigoutaudio4.audio.active := False;
  onwavon.color := cl_transparent;
  onnoiseon.color := cl_transparent;
 // onpianoon.color := cl_transparent;
end;
end;

procedure tsynthefo.samcountsetexeR(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  noise.samplecount := round(19 * avalue) + 1;
  sampcountdiR.Value := noise.samplecount;
  
  if linknoisechan.value then  begin
   noise2.samplecount := noise.samplecount;
   sampcountdiL.Value := sampcountdiR.Value;
   sampcountL.value := avalue;
   end; 
end;

procedure tsynthefo.typinitexe(const Sender: tenumtypeedit);
begin
  Sender.typeinfopo := typeinfo(noisekindty);
end;

procedure tsynthefo.kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  noise.kind := noisekindty(avalue);
  
  if linknoisechan.value then
    begin
    kindedR.value := avalue;    
    noise2.kind := noise.kind;    end;
end;


procedure tsynthefo.oncreated(const Sender: TObject);
var
 ordir: string;
begin

  cont.inputtype := 0;            // from synth/noise
  tsigcontroller4.inputtype := 3; // from waveform
  Caption := 'Noise Generator' ;
  hasinit := True;

end;


procedure tsynthefo.oninit(const Sender: TObject);
begin
SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
 [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

 
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
     begin
    //  onwavon.color := cl_transparent;
      tsigoutaudio4.audio.active := False;
     end; 

end;

procedure tsynthefo.onvolwaveL(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  volwavL.Value := round(100 * avalue);
   if linkwavchan.value then
    begin
   volwavR.Value := volwavL.Value;
   sliderwaveR.value := avalue;
   end;
end;

procedure tsynthefo.onfreqwaveL(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavL.Value := bvalue;

if linkwavchan.value then
    begin
   freqwavR.Value := freqwavL.Value;
   sliderfreqwaveR.value := avalue;
   end;  
  
end;


procedure tsynthefo.onchangewave(const Sender: TObject);
var
  isoddL, isoddR: integer;
begin
  if hasinit then
  begin
  
  
  if linkwavchan.value then
    begin
   //oddwaveR.Value := oddwaveL.Value;
   //harmonwaveR.Value := harmonwaveL.Value;
  // freqwavR.value := freqwavL.value;
   end;
   
  
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
    {  
       bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwav.Value := bvalue;
     }
      
   //  sliderfreqwaveL.value := sqrt(freqwavL.Value) / 100;
   //  sliderfreqwaveR.value := sqrt(freqwavR.Value) / 100;
  
{TypeWaveL, TypeWaveR,
AHarmonicsL,AHarmonicsR : Integer;
EvenHarmonicsL, EvenHarmonicsR : Shortint;
FreqL, FreqR, VolL, VolR: single);  
}
  end;
end;

procedure tsynthefo.onsetampnoiseR(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  noiseampR.Value := round(avalue * 100);
    if linknoisechan.value then  begin
   noiseampL.Value := noiseampR.Value;
   tsigslider1L.value := avalue;
   end;
end;

procedure tsynthefo.onresizeform(const Sender: TObject);
begin
 // if hasinit then
   // tsigkeyboard1.keywidth := round(tsigkeyboard1.Width / 32);
end;


procedure tsynthefo.onquit(const Sender: TObject);
begin
  application.terminate;
end;


procedure tsynthefo.onvolwaveR(const sender: TObject; var avalue: realty;
               var accept: Boolean);

begin
    volwavR.Value := round(100 * avalue);
    if linkwavchan.value then
    begin
   volwavL.Value := volwavR.Value;
   sliderwaveL.value := avalue;
   end;
end;

procedure tsynthefo.onfreqwaveR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavR.Value := bvalue;
  
  if linkwavchan.value then
    begin
   freqwavL.Value := freqwavR.Value;
   sliderfreqwaveL.value := avalue;
   end;
end;

procedure tsynthefo.kindsetexeR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
 noise2.kind := noisekindty(avalue);
   
 if linknoisechan.value then
    begin
    kinded.value := avalue;    
    noise.kind := noise2.kind; 
     end;
end;

procedure tsynthefo.onsetampnoiseL(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 noiseampL.Value := round(avalue * 100);
  if linknoisechan.value then  begin
   noiseampR.Value := noiseampL.Value;
   tsigslider1.value := avalue;
   end;
end;

procedure tsynthefo.samcountsetexeL(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 noise2.samplecount := trunc(19 * avalue) + 1;
  sampcountdiL.Value := noise2.samplecount;
  
 if linknoisechan.value then  begin
   noise.samplecount := noise2.samplecount;
   sampcountdiR.Value := sampcountdiL.Value;
   sampcountR.value := avalue;
   end;  
end;

procedure tsynthefo.onvaluefreqL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     sliderfreqwaveL.value := sqrt(avalue) / 100;
     sliderfreqwaveR.value := sliderfreqwaveL.value;
     freqwavR.Value := avalue;
    end;  
end;

procedure tsynthefo.onvaluefreqR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     sliderfreqwaveR.value := sqrt(avalue) / 100;
     sliderfreqwaveL.value := sliderfreqwaveR.value;
     freqwavL.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetharmL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     harmonwaveR.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetharmR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     harmonwaveL.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetwavekindL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     wavetypeR.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetwavekindR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     wavetypeL.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetoddL(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     oddwaveR.Value := avalue;
    end;  
end;

procedure tsynthefo.onsetoddR(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     oddwaveL.Value := avalue;
    end;  
end;

procedure tsynthefo.onkey(const sender: twidget; var ainfo: keyeventinfoty);
begin
{
if (ainfo.eventkind =   ek_keypress)  then
      begin
    wavetypeL.optionsedit := wavetypeL.optionsedit + [oe_readonly];
    end;
    
if (ainfo.eventkind =  ek_keyrelease)  then
      begin
    wavetypeL.optionsedit := wavetypeL.optionsedit - [oe_readonly];
    end;   
    } 
end;

procedure tsynthefo.onmousev(const sender: twidget; var ainfo: mouseeventinfoty);
begin

 if (ainfo.eventkind = ek_buttonrelease)  then
      begin
      wavetypeL.optionsedit := wavetypeL.optionsedit - [oe_readonly];
     end; 
     
 if (ainfo.eventkind = ek_buttonpress)  then
      begin
      wavetypeL.optionsedit := wavetypeL.optionsedit + [oe_readonly];
     end; 
        
end;

procedure tsynthefo.onchangest(const sender: TObject);
begin
 if  (isactivated = true) then
 begin
 if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showsynth']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': Noise Generator'; 
         //  lang_infosfo[Ord(in_infosfo)] ;
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showsynth']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': Noise Generator';
          end;
          
  if norefresh = False then
    begin
      if parentwidget <> nil then
      begin
      mainfo.updatelayoutstrum();

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
      end;  
    end;
  end;         
end;

procedure tsynthefo.onnoiseactivate(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
 if hasinit then
    if avalue then
    begin
   //   onnoiseon.color := $3B4F00;
  
      out.audio.active := True;
      end
    else
     begin
   //   onnoiseon.color := cl_transparent;
      out.audio.active := False;
     end; 
end;


end.

