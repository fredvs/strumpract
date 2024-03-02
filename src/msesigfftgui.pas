{ MSEgui Copyright (c) 20010-2013 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

//
// experimental
//

unit msesigfftgui;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msesignal,msechart,classes,mclasses,msesigfft,msegui,msegraphutils,msemenus,
 msegraphics,mseguiglob,mseclasses,msetypes;

type
 tsigscopefft = class;
 tscopesamplerfft = class(tsigsamplerfft)
  private
   fscope: tsigscopefft;
  protected
   procedure dobufferfull; override;
  public
   constructor create(const aowner: tsigscopefft); reintroduce;
 end;

 tsigscopefft = class(tchart)
  private
   fsampler: tscopesamplerfft;
   ffftfirst: integer;
   ffftcount: integer;
   fslave: tsigscopefft;
   procedure setsampler(const avalue: tscopesamplerfft);
   procedure setslave(const avalue: tsigscopefft);
  public
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
  published
   property sampler: tscopesamplerfft read fsampler write setsampler;
   property fftfirst: integer read ffftfirst write ffftfirst default 0;
   property fftcount: integer read ffftcount write ffftcount default 0;
                               //0 -> all
   property slave: tsigscopefft read fslave write setslave;
 end;

implementation
uses
 sysutils;

{ tsigscopefft }

constructor tsigscopefft.create(aowner: tcomponent);
begin
 fsampler:= tscopesamplerfft.create(self);
 inherited;
end;

destructor tsigscopefft.destroy;
begin
 fsampler.free;
 inherited;
end;

procedure tsigscopefft.setsampler(const avalue: tscopesamplerfft);
begin
 fsampler.assign(avalue);
end;

procedure tsigscopefft.setslave(const avalue: tsigscopefft);
var
 slave1: tsigscopefft;
begin
 slave1:= avalue;
 while slave1 <> nil do begin
  if slave1 = self then begin
   raise exception.create(name+': recursive slave '+avalue.name+'.');
  end;
  slave1:= slave1.slave;
 end;
 setlinkedvar(tmsecomponent(avalue),tmsecomponent(fslave));
end;

{ tscopesamplerfft }

constructor tscopesamplerfft.create(const aowner: tsigscopefft);
begin
 fscope:= aowner;
 inherited create(aowner);
 setsubcomponent(true);
 name:= 'sampler';
end;

procedure tscopesamplerfft.dobufferfull;

 procedure handleslave(const asampler: tscopesamplerfft;
                                      const asig,afft: samplerbufferty);
          //todo: optimize  slave handling, no additional buffer copy
 var
  buf1: samplerbufferty;
  int1: integer;
  int2: integer;
  //intmin3, int3min: integer;
  int3: integer = 0;
  float1 : double = 0.0;
 begin
  with asampler do begin
  
   if sso_fftmag in options then begin
    with fscope do begin
     if (ffftfirst = 0) and (ffftcount = 0) then begin
      buf1:= afft;
     end
     else begin
      int2:= ffftcount;
      if int2 = 0 then begin
       int2:= bigint;
      end;
      setlength(buf1,length(afft));
      for int1:= 0 to high(buf1) do begin
       buf1[int1]:= copy(afft[int1],fftfirst,int2);
      end;
     end;
    end;
   end
   else begin
    buf1:= copy(asig);
   end;
   lockapplication;
   try
     with fscope.traces do begin
     for int1:= 0 to high(buf1) do begin
      if int1 >= count then begin
       break;
      end;
      
      items[int1].ydata:= realarty(buf1[int1]);
     
      {
      for int2:= 10 to 22000 - 1 do
      if items[int1].ydata[int2] > float1 then
      begin
      int3 := int2;
      float1 := items[int1].ydata[int2];
      end;
      }
       //  writeln(inttostr(items[int1].ydata[int2]));
      // writeln('+' + inttostr(int3) + '/' + inttostr(length(items[int1].ydata)));
   
      // writeln(' Freq = ' + inttostr(round(int3 / 1.494)) + ' Hz');
      // writeln(' Freq = ' + inttostr(round(int3 / 1.494)) + ' Hz');
  
     end;
    end;
   finally
    unlockapplication;
   end;
  end;
 end; //handleslave()
var
 slave: tsigscopefft;
begin
 inherited;
 slave:= self.fscope;
 while slave <> nil do begin
  handleslave(slave.fsampler,fsigbuffer,ffftbuffer);
  slave:= slave.slave;
 end;
end;

end.
