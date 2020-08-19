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
 multiplier : Double;
 MAX_LOG: Double = 0.0;
 MIN_LOG: Double = 0.0;
 MAX_R: Double = 100.0;
 dancernum : integer = 0;
 

implementation
 
uses
 BGRABitmap, BGRABitmapTypes, bgragraphics, imagedancer_mfm;
 
// Super Formula 

function SafePower(a, b: Double; out c: Double): Boolean;
var
  tmp: Double;
begin
  Result := true;
 // if (a < 0) then
 //   raise Exception.Create('1st argument of Power() must not be negative');
  if (a = 0) then begin
 //   if (b = 0) then
  //    raise Exception.Create('Both arguments of Power() must not be zero.');
    c := 0;
    exit;
  end;

  if MAX_LOG = 0.0 then
    MAX_LOG := ln(MaxDouble);
  if MIN_LOG = 0.0 then
    MIN_LOG := ln(MinDouble);

  // ln(a^b) = b ln(a)
  tmp := b * ln(a);
  if tmp > MAX_LOG then
    Result := false
  else
  if tmp < MIN_LOG then
    c := 0.0
  else
    c := exp(tmp);
end;

function r(theta, a, b, m, n1, n2, n3: double): double;
const
  EPS = 1E-9;
var
  c, pc, s, ps: Double;
begin
{
  if (a = 0) then
    raise Exception.Create('a must not be zero.');
  if (b = 0) then
    raise Exception.Create('b must not be zero');
  if (m = 0) then
    raise Exception.Create('m must not be zero');
  if (n1 = 0) then
    raise Exception.Create('n1 must not be zero');
  if (n2 = 0) then
    raise Exception.Create('n2 must not be zero');
  if (n3 = 0) then
    raise Exception.Create('n3 must not be zero');
}
  c := abs(cos(m * theta / 4) / a);
  if c < EPS then
    pc := 0
  else
  if not SafePower(c, n2, pc) then begin
    Result := MAX_R;
    exit;
  end;

  s := abs(sin(m * theta / 4) / b);
  if s < EPS then
    ps := 0
  else
  if not SafePower(s, n3, ps) then begin
    Result := MAX_R;
    exit;
  end;

  if pc + ps < EPS then
    Result := 0
  else
  if not SafePower(pc + ps, -1/n1, Result) then
    Result := MAX_R;

  if Result > MAX_R then Result := MAX_R;
end;
 
// Fractal Tree

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
  theta: double;
  rad: double;
  x: double = 0;
  y: double = 0;
  Bitmap : tbgrabitmap;
  
 begin
   Bitmap := tbgrabitmap.create(sender.bounds_cx, sender.bounds_cy);

if dancernum = 0 then
begin   
 
  multiplier := multiplier * sender.bounds_cy / 50;
  
 
//  bmp.GradientFill(0, 0, bmp.Width, bmp.Height, cl_dkgreen , BGRA(round(cl_dkgreen * multcolor  / 100),125,0), 
 Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_dkgreen , BGRA(0,0,0), 


 gtLinear, PointF(0,0), PointF(0, Bitmap.Height), dmSet);

  drawTree(Bitmap.Width div 2, Bitmap.Height, -91, 9, multiplier, Bitmap);   
  
end else

if dancernum = 1 then // Super Formula
begin
 Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_dkred, BGRA(0,0,0),
  gtLinear, PointF(0,0), PointF(0, Bitmap.Height), dmSet);


  theta := 0.01; // prevent starting line
  Bitmap.Canvas2D.resetTransform;
  Bitmap.Canvas2D.translate(Width div 2, Height div 2);
  Bitmap.Canvas2D.lineWidth := 2;
  Bitmap.Canvas2D.strokeStyle(BGRAwhite);
  Bitmap.Canvas2D.beginPath;
  while (theta <= 2 * pi) do
  begin
    {
      If you want to control the formula with mouse positions replace with
      mouseX / 100
      mouseY / 100
    }
    rad := r(theta, 1, // a - size and control spikes
      1, // b - size and control spikes
      6, // m - number of spikes
      0.5, // n1 - roundness
      tan(multiplier*10) * 0.5 + 0.5, // n2 - shape
      tan(multiplier*10) * 0.5 + 0.5 // n3 - shape
      );
    x := rad * cos(theta) * (Width div 4);
    y := rad * sin(theta) * (Height div 4);
   // try
      Bitmap.Canvas2D.lineTo(x, y);
   {
    except
      on e: exception do
      begin
        // prevent floating point overflow
        exit;
      end;
    end;
    }
    theta += 0.01; // resolution of the drawing
  end;
  Bitmap.Canvas2D.closePath; // prevent holes
  Bitmap.Canvas2D.stroke;
     
end;

  Bitmap.draw(acanvas, 0, 0, false);
  Bitmap.free;
end;

end.
