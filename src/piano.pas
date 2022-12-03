unit piano;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock,
 msesimplewidgets, msewidgets, mseact, msechartedit, msedataedits,
 msedropdownlist, mseedit, msegraphedits, mseificomp, mseificompglob,mseifiglob,
 msescrollbar, msesiggui, msesignal, msestatfile, msestream,sysutils,
 msedispwidgets, mserichstring, msefilter, msesigaudio, msesignoise;

type
 tpianofo = class(tdockform)
   tgroupbox6: tgroupbox;
   tsigslider3: tsigslider;
   volpiano: tintegerdisp;
   volpianoR: tintegerdisp;
   tsigslider32: tsigslider;
   linkpianochan: tbooleanedit;
   onpianoon: tbooleanedit;
   tenvelopeedit1: tenvelopeedit;
   tsigkeyboard1: tsigkeyboard;
   tsigfilter2: tsigfilter;
   tsigoutaudio1: tsigoutaudio;
   tsignoise1: tsignoise;
   tsigcontroller1: tsigcontroller;
   tsigfilter1: tsigfilter;
   procedure oncloseex(const sender: TObject);
   procedure oncreatedex(const sender: TObject);
   procedure onresizeex(const sender: TObject);
   procedure onsetsliderpiano(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onsetsliderpianoR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onpianoactivate(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onchangest(const sender: TObject);
   procedure ondockex(const sender: TObject);
   procedure onfloatex(const sender: TObject);
 end;
var
 pianofo: tpianofo;
 hasinitp: Boolean = False;

 
 
implementation
uses
main, dockpanel1, captionstrumpract, piano_mfm;
procedure tpianofo.oncloseex(const sender: TObject);
begin
 onpianoon.color := cl_transparent;
  tsigoutaudio1.audio.active := False;
end;

procedure tpianofo.oncreatedex(const sender: TObject);
begin
  tsigkeyboard1.keywidth := tsigkeyboard1.Width div 32;
   tsigcontroller1.inputtype := 0; // from synth/piano
   Caption := 'Piano Synthesizer' ;

  hasinitp := True;

end;

procedure tpianofo.onresizeex(const sender: TObject);
begin
 if hasinitp then
    tsigkeyboard1.keywidth := round(tsigkeyboard1.Width / 32);

end;

procedure tpianofo.onsetsliderpiano(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 volpiano.Value := round(100 * avalue);
   if linkpianochan.value then
    begin
   volpianoR.Value := volpiano.Value;
   tsigslider32.value := avalue;
   end;
end;

procedure tpianofo.onsetsliderpianoR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
volpianoR.Value := round(100 * avalue);
    if linkpianochan.value then  begin
   volpiano.Value := volpianoR.Value;
   tsigslider3.value := avalue;
   end;
end;

procedure tpianofo.onpianoactivate(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
 if hasinitp then
    if avalue then
    begin
   //   onpianoon.color := $3B4F00;
      tsigoutaudio1.audio.active := True;
      end
    else
    begin
  //    onpianoon.color := cl_transparent;
      tsigoutaudio1.audio.active := False;

end;
end;

procedure tpianofo.onchangest(const sender: TObject);
begin
if  (isactivated = true) then
 begin
 if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showpiano']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': Piano'; 
         //  lang_infosfo[Ord(in_infosfo)] ;
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showpiano']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': Piano';
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

procedure tpianofo.ondockex(const sender: TObject);
begin
 bounds_cxmax := fowidth;
 bounds_cx := fowidth;
end;

procedure tpianofo.onfloatex(const sender: TObject);
begin
bounds_cxmax := 0;
 bounds_cx := fowidth;
end;

end.
