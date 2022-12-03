unit infosd;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock, captionstrumpract,
 mseimage, msesimplewidgets, msewidgets;

type
 tinfosdfo = class(tdockform)
   imgPreview: timage;
   infolength: tlabel;
   infobpm: tlabel;
   tracktag: tlabel;
   infochan: tlabel;
   inforate: tlabel;
   infotag: tlabel;
   infoyear: tlabel;
   infocom: tlabel;
   infoalbum: tlabel;
   infoartist: tlabel;
   infoname: tlabel;
   infofile: tlabel;
   tlabel2: tlabel;
   procedure onshow(const sender: TObject);
   procedure ondock(const sender: TObject);
   procedure onfloat(const sender: TObject);
   procedure onevstart(const sender: TObject);
 end;
var
  infosdfo, infosdfo2: tinfosdfo;

implementation
uses
main, dockpanel1, infosd_mfm;

procedure tinfosdfo.onshow(const sender: TObject);
begin
 if  (isactivated = true) and (Assigned(mainfo))
 then begin
 
   if tag = 0 then
     if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showinfos1']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
           lang_infosfo[Ord(in_infosfo)] + ' 1';
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showinfos1']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' + 
                   lang_infosfo[Ord(in_infosfo)] + ' 1';
          end;
        
   if tag = 1 then
     if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showinfos2']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': ' +
           lang_infosfo[Ord(in_infosfo)] + ' 2';
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showinfos2']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': ' + 
                   lang_infosfo[Ord(in_infosfo)] + ' 2';
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

procedure tinfosdfo.ondock(const sender: TObject);
begin
 height := 226;
 bounds_cxmax := fowidth;
 bounds_cx := fowidth;
end;

procedure tinfosdfo.onfloat(const sender: TObject);
begin
 height := 226;
 bounds_cxmax := 0;
 bounds_cx := fowidth;
end;

procedure tinfosdfo.onevstart(const sender: TObject);
begin
if parentwidget = nil then onfloat(sender) else ondock(sender);
end;

end.
