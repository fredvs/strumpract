program strumpract;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}

 {$PACKRECORDS C}

uses
 {$ifdef FPC} {$ifdef unix} cthreads, BaseUnix, {$endif} {$endif}

  Classes, 
  Math,
  SysUtils,
  msefileutils,
  msegui,
  uos_flat,
  main,
  splash;

{$ifdef unix}
var
fs: TFileStream;
ordir: string;
{$endif}

begin
{$ifdef unix}  
  ordir := filepath(statdirname);
  if not finddir(ordir) then
      createdir(ordir);
      
  ordir := ordir + directoryseparator + 'log.txt' ;
  
  fs := TFileStream.Create(ordir, fmOpenReadWrite or fmCreate);
  FpDup2(fs.Handle, StdErrorHandle);   
{$endif}

  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  application.createform(tsplashfo, splashfo);
  
 {$if defined(netbsd) or defined(darwin)}
  splashfo.windowopacity := 1;
 {$else}
  splashfo.windowopacity := 0.5;
 {$endif}
 
  application.run;
 
  uos_free();

{$ifdef unix}
  fs.Free;
  //  if fileexists(ordir) then deletefile(ordir);
{$endif}

end.

