unit imagedancer;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  bgragraphics,
  BGRABitmap,
  BGRADefaultBitmap,
  BGRABitmapTypes,
  msethread,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  mseforms,
  msedock,
  Math,
  msesimplewidgets,
  msewidgets,
  mseact,
  msedataedits,
  msedropdownlist,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msestatfile,
  msestream,
  SysUtils,
  mseopenglwidget,
  msewindowwidget;

type
  pInvalidateImage = procedure of object;

type
  timagedancerfo = class(tdockform)

    tpaintbox1: tpaintbox;
    openglwidget: topenglwidget;
    procedure onpaint_imagedancerfo(const Sender: twidget; const acanvas: tcanvas);
    procedure onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
    procedure InvalidateImage;
    procedure ondestroy(const Sender: TObject);
    procedure oncreat(const Sender: TObject);
    procedure onshow(const Sender: TObject);
    procedure rotentexe(const Sender: TObject);

    procedure clientrectchangedexe(const Sender: tcustomwindowwidget);
    procedure createwinidexe(const Sender: tcustomwindowwidget; const aparent: winidty; const awidgetrect: rectty; var aid: winidty);
    procedure onrenderexe(const Sender: tcustomopenglwidget; const aupdaterect: rectty);
    procedure onhide(const Sender: TObject);
  protected
    thethread: tmsethread;
    function Execute(thread: tmsethread): integer;

  private
    rendercount: integer;
    renderstart: longword;
    frotx, froty, frotz: real;

  end;

type
  TSegment = record
    Start,
    stop: integer;
    BrightCol: Boolean;
  end;

  TSEgmentAr = array of TSegment;

  TRing = record
    radius: integer;
    ColBright,
    ColDark: TBGRAPixel;
    lineWidth: integer;    // 2..8
    Clockwise: Boolean;
    SegmentCount: integer; // 3 .. 6
    Segments: TSegmentAr;
    Speed: integer;        // 1..10;
  end;

const
  deg_to_rad = pi / 180;
  MaxRing    = 7;
  MinRadius  = 90;
  Deg2Rad    = pi / 180;
  Rad2Deg    = 180 / pi;

var
  Rings: array[0..MaxRing] of TRing;
  Center: TPointF;
  TimerTic: integer = 0;

  TimerTicinterval: integer = 0;

  imagedancerfo: timagedancerfo;
  multiplier: double;
  MAX_LOG: double = 0.0;
  MIN_LOG: double = 0.0;
  MAX_R: double = 100.0;
  dancernum: integer = 0;
  isbuzy: Boolean = False;
  evPauseImage: PRTLEvent;// for pausing
  statusanim: integer = -1;

implementation

uses
  main,
  msegl,
  mseglu,
  msesysutils,
  imagedancer_mfm;

var
  Bitmap: tbgrabitmap;


// Atom

function GetRandomDark(Pix: TBGRAPixel): TBGRAPixel;
var
  HSL: THSLAPixel;
  lightness: word;
begin
  HSL       := BGRAToHSLA(Pix);
  // lightNess := maxSmallint div 4 + random(maxSmallint div 4);
  lightNess := maxSmallint div 4 + round(maxSmallint / 4 * multiplier);
  Result    := HSLAToBGRA(HSLA(HSL.hue, HSL.saturation, lightness));
end;

function getRandomHue(area: integer): TBGRAPixel;
var
  offset, range: integer;
  hue: integer;
  HSL: THSLAPixel;
begin
  range  := 360 div (MaxRing + 1);
  offset := area * range + range div 2;
  if odd(area) then
    offset := 180 + offset;
  if offset > 360 then
    offset := offset - 360;
  // hue      := offset + random(range) - range div 2;
  hue      := offset + round(range * multiplier) - range div 2;
  HSL      := HSLA(round(hue / 360 * $FFFF), $FFFF, maxSmallint);
  Result   := HSLAToBGRA(HSL);
end;


function CreateSegments(SgCount: integer): TSEgmentAr;  // SgCount ..3..6
var
  seglen: integer; // degrees
  numparts: integer;
  i: integer;
  ar: array of integer;

  procedure dumbsort;
  var
    k, m, tmp: integer;
  begin
    for k := 0 to high(ar) - 1 do
      for m := k + 1 to high(ar) do
        if ar[m] < ar[k] then
        begin
          tmp   := ar[m];
          ar[m] := ar[k];
          ar[k] := tmp;
        end//m
    ;      // k
  end;

begin
  numparts := 10 - SgCount;
  seglen   := 360 div SgCount;
  setlength(ar, numparts * 2);

  for i := 0 to high(ar) do
    ar[i] := random(seglen);

  // ar[i] := round(seglen * multiplier);
  dumbsort;
  setlength(Result, numparts);
  i := 0;
  while i < high(ar) do
  begin
    Result[i div 2].Start := ar[i];
    Result[i div 2].stop  := ar[i + 1];
    // avoid zero length
    if ar[i] = ar[i + 1] then
      Inc(Result[i div 2].stop, 2);
    Result[i div 2].BrightCol := boolean(random(2));
    Inc(i, 2);
  end; // while
end;

procedure InitRings;
var
  i: integer;
begin
  for i := 0 to MaxRing do
    with Rings[i] do
    begin
      // radius       := MinRadius + i * 20 + random(11) - 5;
      radius := MinRadius + round(i * 34 * multiplier);

      ColBright    := GetRandomHue(i);
      //    ColBright    := GetRandomHue(round(i * multiplier));
      ColDark      := GetRandomDark(ColBright);
      //  LineWidth    := Random(7) + 2; // 2..8
      LineWidth    := round(8 * multiplier) + 1;
      //   SegmentCount := random(4) + 3; // 3 .. 6
      SegmentCount := round(7 * multiplier) + 1;
      Segments     := CreateSegments(SegmentCount);
      //  speed        := random(11) + 1;
      speed        := round(12 * multiplier) + 1;
      Clockwise    := boolean(random(2));
    end// with
  ;    // i
end;


procedure incF(var f: single; Increment: single); inline;
begin
  f := f + Increment;
end;

procedure rangeToCircle(var start, stop: single); inline;
var
  tmp: integer;
begin
  if (start >= 360) or (stop >= 360) then
  begin
    tmp := trunc(start) div 360;
    incF(start, -tmp * 360);
    incF(stop, -tmp * 360);
  end;
  if (start < 0) or (stop < 0) then
  begin
    tmp := abs(trunc(start)) div 360;
    incF(start, (tmp + 1) * 360);
    incF(stop, (tmp + 1) * 360);
  end;
end;


function rotatePoly(Poly: ArrayOfTPointF; angleDegrees: single; Center: TPointF): ArrayOfTPointF; inline;
var
  Sinus, Cosinus: single;
  P: TPointF;
  i: integer;
begin
  setLength(Result, length(poly));
  Math.SinCos(Deg2Rad * angleDegrees, Sinus, Cosinus);
  for i := 0 to high(Poly) do
    if poly[i] = EmptyPointF then
      Result[i]   := EmptyPointF
    else
    begin
      P.x         := Poly[i].x - Center.x;
      P.y         := Poly[i].y - Center.y;
      Result[i].x := P.x * cosinus - P.y * sinus + Center.x;
      Result[i].y := P.x * sinus + P.y * cosinus + Center.y;
    end// else
  ;    // i
end;


procedure DrawAtom(Img: TBGRAbitmap);
const
  rx = 50;
  ry = 20;
var
  Poly, Poly1: ArrayOfTPointF;
  angle, turn: integer;
  sinus, cosinus: single;
begin
  //turn := TimerTic  mod 360;
  turn := round(TimerTic * multiplier * 10) mod 360;

  setlength(poly, 0);
  for angle := 90 + 45 to 360 + 45 do
  begin
    Math.sincos(angle * Deg2Rad, sinus, cosinus);
    setLength(poly, length(poly) + 1);
    poly[high(poly)] := PointF(cosinus * rx + Center.x, sinus * ry + Center.y);
  end;
  poly1 := rotatePoly(poly, turn, center);
  img.DrawPolyLineAntialias(poly1, getRandomHue(round(multiplier * 10)), 2);
  poly1 := rotatePoly(poly, -60 + turn, center);
  img.DrawPolyLineAntialias(poly1, getRandomHue(round(multiplier * 20)), 2);
  poly1 := rotatePoly(poly, 240 + turn, center);
  img.DrawPolyLineAntialias(poly1, getRandomHue(round(multiplier * 30)), 2);
  Img.FillEllipseAntialias(Center.x, Center.y, 10, 10, getRandomHue(round(multiplier * 40)));
  setlength(poly, 0);
  for angle := 90 + 45 downto 90 do
  begin
    Math.sincos(angle * Deg2Rad, sinus, cosinus);
    setLength(poly, length(poly) + 1);
    poly[high(poly)] := PointF(cosinus * rx + Center.x, sinus * ry + Center.y);
  end;
  poly1 := rotatePoly(poly, 240 + turn, center);
  img.DrawPolyLineAntialias(poly1, getRandomHue(round(multiplier * 30)), 2);

end;

// Spiral

function createSpiral(Center: TPointF; AngleOffset, rotations, MaxRadius, MinRadius: single; clockwise: Boolean): ArrayOfTPointF;
var
  sinus, cosinus, RadiusStep, ro: single;
  Steps, i, sign: integer;
begin
  Steps      := round(rotations * 360);
  RadiusStep := (MaxRadius - MinRadius) / steps;
  ro         := MaxRadius;
  setLength(Result, steps);
  if clockwise then
    sign := +1
  else
    sign := -1;
  for i  := 0 to steps - 1 do
  begin
    Math.sincos((sign * i + AngleOffset) * deg2Rad, sinus, cosinus);
    Result[i].x := ro * cosinus + Center.x;
    Result[i].y := ro * sinus + Center.y;
    incF(ro, -RadiusStep);
  end;
end;


procedure DrawSpiral(Img: TBGRAbitmap);
var
  spiral: ArrayOfTPointF;
  turn: integer;
  rot: Boolean;
begin
  turn := round(multiplier * TimerTic) mod 360;

  if odd(TimerTic) then
    rot := True
  else
    rot := False;

  spiral := createSpiral(center, -10 * Turn, 20, imagedancerfo.tpaintbox1.Width, 0, rot);

  bitmap.DrawPolyLineAntialias(spiral, getRandomHue(round(multiplier * 30)), round(multiplier * 14));

  //bitmap.DrawPolyLineAntialias(spiral,cssred,round(1 * 14));

end;


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

procedure drawTree(x1, y1, angle, depth, multiplierdraw: single; bgra: tbgrabitmap);
var
  x2, y2: single;
begin
  if (depth > 0) then
  begin
    x2 := x1 + (cos(angle * deg_to_rad) * depth * multiplierdraw);
    y2 := y1 + (sin(angle * deg_to_rad) * depth * multiplierdraw);

    bgra.DrawLineAntialias(x1, y1, x2, y2, round(cl_yellow * multiplier / 20), depth, False);

    // Use even values without randomness to get a 'real' fractal image

    drawTree(x2, y2, angle - randomrange(15, 50), depth - 1.44, multiplierdraw, bgra);
    drawTree(x2, y2, angle + randomrange(10, 25), depth - 0.72, multiplierdraw, bgra);
    drawTree(x2, y2, angle - randomrange(10, 25), depth - 3, multiplierdraw, bgra);
    drawTree(x2, y2, angle + randomrange(15, 50), depth - 4, multiplierdraw, bgra);
  end;
end;

procedure timagedancerfo.onpaint_imagedancerfo(const Sender: twidget; const acanvas: tcanvas);
var
  theta: double;
  rad: double;
  x: double = 0;
  y: double = 0;
  y2: double = 0;
  init: double = 0;
  i, k, m, z, offset: integer;
  col: TBGRAPixel;
  start, stop: single;
  LocalSpeed, Delta: single;
begin

  if isbuzy = False then
  begin

    isbuzy := True;

    if (Bitmap.Width <> Sender.bounds_cx) or (Bitmap.Height <> Sender.bounds_cy) then
      bitmap.SetSize(Sender.bounds_cx, Sender.bounds_cy);

    if dancernum = 0 then // Fractral Tree
    begin

      // multiplier := multiplier * Sender.bounds_cy / 50;

      Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_dkgreen, BGRA(0, 0, 0),
        gtLinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

      drawTree(Bitmap.Width div 2, Bitmap.Height, -91, 9, multiplier * Sender.bounds_cy / 50, Bitmap);

    end
    else if dancernum = 1 then // Super Formula
    begin

      Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, $FFEDDE, $FF9D4D,
        gtlinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

      theta := 0.01; // prevent starting line
      Bitmap.Canvas2D.resetTransform;
      Bitmap.Canvas2D.translate(Width div 2, Height div 2);

      y2 := round(4 * multiplier);

      if y2 = 0 then
        y2 := 1;
      Bitmap.Canvas2D.lineWidth := y2;
      Bitmap.Canvas2D.strokeStyle(round(cl_yellow * multiplier / 20));
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

    end
    else if dancernum = 2 then // Hyper formula
    begin

      Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, cl_black, cl_black,
        gtLinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

      theta := 0.01; // prevent starting line
      Bitmap.Canvas2D.resetTransform;
      Bitmap.Canvas2D.translate(Width div 2, Height div 2);

      y2 := round(4 * multiplier);

      if y2 = 0 then
        y2 := 1;
      Bitmap.Canvas2D.lineWidth := y2;
      Bitmap.Canvas2D.strokeStyle(round(cl_yellow * multiplier / 20));
      Bitmap.Canvas2D.beginPath;
      y2   := round(15 * multiplier);
      if y2 < 3 then
        y2 := 3;

      while (theta <= 2 * pi) do
      begin

        rad   := r(theta, 1, // a - size and control spikes
          1,    // b - size and control spikes
          y2,   // m - number of spikes
          0.5,  // n1 - roundness
          tan(multiplier * 8) * 0.5 + 0.5, // n2 - shape
          tan(multiplier * 8) * 0.5 + 0.5 // n3 - shape
          );
        x     := round(multiplier * 5 * rad * cos(theta) * (Width div 4));
        y     := round(multiplier * 5 * rad * sin(theta) * (Height div 4));
        Bitmap.Canvas2D.lineTo(x, y);
        theta += 0.01;           // resolution of the drawing
      end;
      Bitmap.Canvas2D.closePath; // prevent holes
      Bitmap.Canvas2D.stroke;

    end
    else if dancernum = 4 then // Atom
    begin
      center := PointF(Bitmap.Width / 2, Bitmap.Height / 2);
      //   Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, BGRA(0, 10, 80), BGRABlack,
      //     gtlinear, PointF(0, 0), PointF(0, Bitmap.Height), dmSet);

      bitmap.Fill(cssBlack);

      InitRings;

      for i := 0 to MaxRing do
        for m := 0 to rings[i].SegmentCount - 1 do
        begin
          offset       := 360 div rings[i].SegmentCount;
          for k        := 0 to high(rings[i].Segments) do
          begin
            localSpeed := rings[i].Speed / 10;
            if not rings[i].Clockwise then
              localspeed := -localspeed;
            if rings[i].Segments[k].BrightCol then
              col := rings[i].ColBright
            else
              col := rings[i].ColDark;
            Delta := TimerTic * localSpeed * multiplier;
            start := rings[i].Segments[k].Start + m * offset + Delta;
            stop := rings[i].Segments[k].Stop + m * offset + Delta;
            rangeToCircle(start, stop);

            Bitmap.Arc(Center.x, Center.y, rings[i].radius, rings[i].radius,
              start * deg2Rad, stop * deg2Rad, col, rings[i].lineWidth, False, BGRAPixelTransparent);

          end; // k
        end    // m
      ;        // i
      DrawAtom(Bitmap);

    end
    else if dancernum = 5 then // Spiral
    begin
      center := PointF(Bitmap.Width / 2, Bitmap.Height / 2);
      bitmap.Fill(cssBlack);
      DrawSpiral(bitmap);
    end;

    Bitmap.draw(acanvas, 0, 0, False);
    isbuzy := False;
  end;

end;

function timagedancerfo.Execute(thread: tmsethread): integer;
begin

  repeat

    if (isbuzy = False) and (Visible = True) and (tpaintbox1.Visible = True) then
    begin
      application.queueasynccall(@InvalidateImage);
      RTLeventResetEvent(evPauseImage);
      RTLeventWaitFor(evPauseImage);// is there a pause waiting ?
      RTLeventSetEvent(evPauseImage);
    end;
    sleep(10);
  until statusanim = 0;

end;


procedure timagedancerfo.onmouse(const Sender: twidget; var ainfo: mouseeventinfoty);
begin

  with ainfo do
    if eventkind in [ek_buttonpress] then
      if tag = 0 then
      begin
        tag     := 1;
        options := [fo_maximized, fo_autoreadstat, fo_autowritestat, fo_savepos,
          fo_savezorder, fo_savestate];
        invalidate;
      end
      else
      begin
        tag     := 0;
        options := [fo_autoreadstat, fo_autowritestat,
          fo_savepos, fo_savezorder, fo_savestate];
        invalidate;
      end;
end;

procedure timagedancerfo.InvalidateImage;
begin
  onpaint_imagedancerfo(tpaintbox1, tpaintbox1.getcanvas);
end;

procedure timagedancerfo.ondestroy(const Sender: TObject);
begin
  statusanim := 0;
  RTLeventSetEvent(evPauseimage);
  thethread.terminate();
  application.waitforthread(thethread);
  thethread.Destroy();
  Bitmap.Free;
  RTLeventdestroy(evPauseImage);
end;

procedure timagedancerfo.oncreat(const Sender: TObject);
begin
  evPauseImage := RTLEventCreate;
  thethread    := tmsethread.Create(@Execute);
  RTLeventResetEvent(evPauseImage);
  Bitmap       := tbgrabitmap.Create(1000, 600);
  InitRings;
  center       := PointF(Width / 2, Height / 2);

end;

procedure timagedancerfo.onshow(const Sender: TObject);
begin
  openglwidget.fpsmax := 30;
  renderstart         := timestamp;
  mainfo.tmainmenu1.menu[3].submenu[16].Caption := ' Hide Image Dancer ';
end;

procedure timagedancerfo.clientrectchangedexe(const Sender: tcustomwindowwidget);
begin
  glmatrixmode(gl_projection);
  glloadidentity();
  gluperspective(45, Sender.aspect, 1, 10);
  glmatrixmode(gl_modelview);
end;

procedure timagedancerfo.createwinidexe(const Sender: tcustomwindowwidget; const aparent: winidty; const awidgetrect: rectty; var aid: winidty);
begin
{ does not work
 glenable(gl_blend);
 glblendfunc(gl_src_alpha_saturate,gl_one);
 glenable(gl_polygon_smooth);
}
  glmatrixmode(gl_modelview);
  glloadidentity();
  gltranslatef(0, 0, -2);
end;


procedure timagedancerfo.onrenderexe(const Sender: tcustomopenglwidget; const aupdaterect: rectty);
var
  lwo1: longword;
  int1: integer;
begin
  if openglwidget.Visible then
  begin

    glclear(gl_color_buffer_bit);

    if multiplier < 0.1 then
      multiplier := 0;

    glpushmatrix();
    glrotatef(multiplier * 360, 1, multiplier, multiplier);
    glrotatef(multiplier * 360, multiplier, 1, multiplier);
    glrotatef(multiplier * 360, multiplier, multiplier, 1);

    glbegin(gl_quads);
    glcolor3f(1, 0, multiplier);
    glvertex3f(-0.5, -0.5, 0);
    glcolor3f(multiplier, 1, 0);
    glvertex3f(0.5, -0.5, 0);
    glcolor3f(multiplier, multiplier, 1);
    glvertex3f(0.5, 0.5, 0);
    glcolor3f(1, 1, 1);
    glvertex3f(-0.5, 0.5, 0);
    glend();
    glpopmatrix();

    Inc(rendercount);
    int1 := integer(Sender.rendertimestampus - renderstart);
    if int1 > 1000000 then
    begin
      //fpsdisp.value:= (rendercount*1000000)/int1;
      rendercount := 0;
      renderstart := Sender.rendertimestampus;
    end;
  end;
end;

procedure timagedancerfo.rotentexe(const Sender: TObject);
begin
  frotx := 0;
  froty := 0;
  frotz := 0;
end;

procedure timagedancerfo.onhide(const Sender: TObject);
begin
  mainfo.tmainmenu1.menu[3].submenu[16].Caption := ' Show Image Dancer ';
end;

end.

