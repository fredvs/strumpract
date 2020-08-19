unit imagedancer;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
  msegui,msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock,
  math, msesimplewidgets, msewidgets;

type
 timagedancerfo = class(tdockform)
   tpaintbox1: tpaintbox;
   procedure onpaint_tpaintbox1(const sender: twidget; const acanvas: tcanvas);
 end;

 const
  deg_to_rad = pi / 180;    

var
 imagedancerfo: timagedancerfo;
 multiplier : single;
 

implementation
 
uses
 BGRABitmap, BGRABitmapTypes, bgragraphics, imagedancer_mfm;
 

procedure drawTree(x1, y1, angle, depth, multiplier: single; bgra : tbgrabitmap);
var
  x2, y2: single;
begin
  if (depth > 0) then
  begin
    x2 := x1 + (cos(angle * deg_to_rad) * depth * multiplier);
    y2 := y1 + (sin(angle * deg_to_rad) * depth * multiplier);
 
    bgra.DrawLineAntialias(x1, y1, x2, y2, cl_dkgreen, depth, False);
    
    // Use even values without randomness to get a 'real' fractal image
    
    drawTree(x2, y2, angle - randomrange(15,50), depth - 1.44, multiplier, bgra);
    drawTree(x2, y2, angle + randomrange(10,25), depth - 0.72, multiplier, bgra);
    drawTree(x2, y2, angle - randomrange(10,25), depth - 3, multiplier, bgra);
    drawTree(x2, y2, angle + randomrange(15,50), depth - 4, multiplier, bgra);
  end;
end;       
  
procedure timagedancerfo.onpaint_tpaintbox1(const sender: twidget; const acanvas: tcanvas);
var
  bmp : tbgrabitmap;
  multcolor : double;
  
 begin
   bmp := tbgrabitmap.create(sender.bounds_cx, sender.bounds_cy);
   
   multcolor := multiplier;
  
  multiplier := multiplier * sender.bounds_cy / 50;
  
 
//  bmp.GradientFill(0, 0, bmp.Width, bmp.Height, cl_dkgreen , BGRA(round(cl_dkgreen * multcolor  / 100),125,0), 
 bmp.GradientFill(0, 0, bmp.Width, bmp.Height, cl_dkgreen , BGRA(0,0,0), 


 gtLinear, PointF(0,0), PointF(0, bmp.Height), dmSet);

  drawTree(bmp.Width div 2, bmp.Height, -91, 9, multiplier, bmp);      

  bmp.draw(acanvas, 0, 0, false);
  bmp.free;
end;

end.
