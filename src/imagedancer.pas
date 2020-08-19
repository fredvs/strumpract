unit imagedancer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,Math,
 msesimplewidgets,msewidgets, mseact, msedataedits, msedropdownlist, mseedit,
  mseificomp, mseificompglob, mseifiglob, msestatfile, msestream, sysutils;

type
  timagedancerfo = class(tdockform)
    tpaintbox1: tpaintbox;
   dancnum: tintegeredit;
    procedure onpaint_tpaintbox1(const Sender: twidget; const acanvas: tcanvas);
  end;

const
  deg_to_rad = pi / 180;

var
  imagedancerfo: timagedancerfo;
  multiplier: double;
  MAX_LOG: double = 0.0;
  MIN_LOG: double = 0.0;
  MAX_R: double = 100.0;
  dancernum: integer = 0;


implementation

uses
  BGRABitmap,
  BGRABitmapTypes,
  bgragraphics,
  imagedancer_mfm;

// Super Formula 

function SafePower(a, b: double; out c: double): Boolean;
var
  tmp: double;
begin
  Result := True;
  if (a = 0) then
  begin
    c := 0;
    Exit;
  end;

  if MAX_LOG = 0.0 then
    MAX_LOG := ln(MaxDouble);
  if MIN_LOG = 0.0 then
    MIN_LOG := ln(MinDouble);

  // ln(a^b) = b ln(a)
  tmp      := b * ln(a);
  if tmp > MAX_LOG then
    Result := False
  else if tmp < MIN_LOG then
    c      := 0.0
  else
    c      := exp(tmp);
end;

function r(theta, a, b, m, n1, n2, n3: double): double;
const
  EPS = 1E-9;
var
  c, pc, s, ps: double;
begin
  c    := abs(cos(m * theta / 4) / a);
  if c < EPS then
    pc := 0
  else if not SafePower(c, n2, pc) then
  begin
    Result := MAX_R;
    Exit;
  end;

  s    := abs(sin(m * theta / 4) / b);
  if s < EPS then
    ps := 0
  else if not SafePower(s, n3, ps) then
  begin
    Result := MAX_R;
    Exit;
  end;

  if pc + ps < EPS then
    Result := 0
  else if not SafePower(pc + ps, -1 / n1, Result) then
    Result := MAX_R;

  if Result > MAX_R then
    Result := MAX_R;
end;

// Fractal Tree

procedure drawTree(x1, y1, angle, depth, multiplier: single; bgra: tbgrabitmap);
var
  x2, y2: single;
begin
  if (depth > 0) then
  begin
    x2 := x1 + (cos(angle * deg_to_rad) * depth * multiplier);
    y2 := y1 + (sin(angle * deg_to_rad) * depth * multiplier);

    bgra.DrawLineAntialias(x1, y1, x2, y2, cl_dkgreen, depth, False);

    // Use even values without randomness to get a 'real' fractal image

    drawTree(x2, y2, angle - randomrange(15, 50), depth - 1.44, multiplier, bgra);
    drawTree(x2, y2, angle + randomrange(10, 25), depth - 0.72, multiplier, bgra);
    drawTree(x2, y2, angle - randomrange(10, 25), depth - 3, multiplier, bgra);
    drawTree(x2, y2, angle + randomrange(15, 50), depth - 4, multiplier, bgra);
  end;
end;

procedure timagedancerfo.onpaint_tpaintbox1(const Sender: twidget; const acanvas: tcanvas);
var
  theta: double;
  rad: double;
  x: double = 0;
  y: double = 0;
  Bitmap: tbgrabitmap;
begin
  Bitmap := tbgrabitmap.Create(Sender.bounds_cx, Sender.bounds_cy);

  if dancernum = 0 then
  begin

    multiplier := multiplier * Sender.bounds_cy / 50;

    Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_dkgreen, BGRA(0, 0, 0),
      gtLinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

    drawTree(Bitmap.Width div 2, Bitmap.Height, -91, 9, multiplier, Bitmap);

  end
  else
  if dancernum = 1 then // Super Formula
  begin
    Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_dkred, BGRA(0, 0, 0),
      gtLinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

    theta := 0.01; // prevent starting line
    Bitmap.Canvas2D.resetTransform;
    Bitmap.Canvas2D.translate(Width div 2, Height div 2);
    Bitmap.Canvas2D.lineWidth := 2;
    Bitmap.Canvas2D.strokeStyle(BGRAwhite);
    Bitmap.Canvas2D.beginPath;
    while (theta <= 2 * pi) do
    begin

      rad   := r(theta, 1, // a - size and control spikes
        1,   // b - size and control spikes
        6,   // m - number of spikes
        0.5, // n1 - roundness
        tan(multiplier * 10) * 0.5 + 0.5, // n2 - shape
        tan(multiplier * 10) * 0.5 + 0.5 // n3 - shape
        );
      x     := rad * cos(theta) * (Width div 4);
      y     := rad * sin(theta) * (Height div 4);
      Bitmap.Canvas2D.lineTo(x, y);
      theta += 0.01;           // resolution of the drawing
    end;
    Bitmap.Canvas2D.closePath; // prevent holes
    Bitmap.Canvas2D.stroke;

  end;

  Bitmap.draw(acanvas, 0, 0, False);
  Bitmap.Free;
end;

end.

