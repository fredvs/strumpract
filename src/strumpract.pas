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
  msegui,
  uos_flat,
  splash;

{$ifdef unix}
var
fs: TFileStream;
ordir: string;
{$endif}

begin
{$ifdef unix}  
  ordir := ExtractFilePath(ParamStr(0)) + 
      directoryseparator + 'ini' 
    + directoryseparator + 'log.txt' ;
    
  fs := TFileStream.Create(ordir, fmOpenReadWrite or fmCreate);
  FpDup2(fs.Handle, StdErrorHandle);   
{$endif}

  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  application.createform(tsplashfo, splashfo);
  splashfo.windowopacity := 0.5;
 
  application.run;
 
  uos_free();

{$ifdef unix}
  fs.Free;
  //  if fileexists(ordir) then deletefile(ordir);
{$endif}

end.

