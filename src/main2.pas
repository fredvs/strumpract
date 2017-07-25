unit main2;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock;

type
 tmain2fo = class(tdockform)
 end;
var
 main2fo: tmain2fo;
implementation
uses
 main2_mfm;
end.
