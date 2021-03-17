// The ALSA types and functions
// are copied from mixer.inc of fpAlsa by
// Nikolay Nikolov <nickysn@users.sourceforge.net>

// Turned into unit and dynamic loading by
// Fred vS <fiens@hotmail.com>
 
unit alsa_mixer;

{$mode objfpc}{$H+}
{$PACKRECORDS C}

interface

uses
  classes,
  sysutils,
  dynlibs,
  CTypes;
  
type

(** Mixer handle *)
  PPsnd_mixer_t = ^Psnd_mixer_t;
  Psnd_mixer_t = ^snd_mixer_t;
  snd_mixer_t = record
  end;
 (** Mixer element handle *)
  PPsnd_mixer_elem_t = ^Psnd_mixer_elem_t;
  Psnd_mixer_elem_t = ^snd_mixer_elem_t;
  snd_mixer_elem_t = record
  end;
  
  (** 
 * \brief Mixer callback function
 * \param mixer Mixer handle
 * \param mask event mask
 * \param elem related mixer element (if any)
 * \return 0 on success otherwise a negative error code
 *)
 
 type
  snd_mixer_callback_t = function(ctl: Psnd_mixer_t;
				  mask: cuint;
				  elem: Psnd_mixer_elem_t): cint; cdecl;
				  
(** 
 * \brief Mixer element callback function
 * \param elem Mixer element
 * \param mask event mask
 * \return 0 on success otherwise a negative error code
 *)
  snd_mixer_elem_callback_t = function(elem: Psnd_mixer_elem_t;
				       mask: cuint): cint; cdecl;

(** Mixer elements class handle *)
  PPsnd_mixer_class_t = ^Psnd_mixer_class_t;
  Psnd_mixer_class_t = ^snd_mixer_class_t;
  snd_mixer_class_t = record
  end;
   
(** Mixer simple element channel identifier *)
type
  snd_mixer_selem_channel_id_t = (
	(** Unknown *)
	SND_MIXER_SCHN_UNKNOWN = -1,
	(** Front left *)
	SND_MIXER_SCHN_FRONT_LEFT = 0,
	(** Front right *)
	SND_MIXER_SCHN_FRONT_RIGHT,
	(** Rear left *)
	SND_MIXER_SCHN_REAR_LEFT,
	(** Rear right *)
	SND_MIXER_SCHN_REAR_RIGHT,
	(** Front center *)
	SND_MIXER_SCHN_FRONT_CENTER,
	(** Woofer *)
	SND_MIXER_SCHN_WOOFER,
	(** Side Left *)
	SND_MIXER_SCHN_SIDE_LEFT,
	(** Side Right *)
	SND_MIXER_SCHN_SIDE_RIGHT,
	(** Rear Center *)
	SND_MIXER_SCHN_REAR_CENTER,
	SND_MIXER_SCHN_LAST = 31,
	(** Mono (Front left alias) *)
	SND_MIXER_SCHN_MONO = SND_MIXER_SCHN_FRONT_LEFT);
    
(** Mixer simple element - register options - abstraction level *)
  snd_mixer_selem_regopt_abstract = (
	(** no abstraction - try use all universal controls from driver *)
	SND_MIXER_SABSTRACT_NONE = 0,
	(** basic abstraction - Master,PCM,CD,Aux,record-Gain etc. *)
	SND_MIXER_SABSTRACT_BASIC);
  
(** Mixer simple element - register options *)
  Psnd_mixer_selem_regopt = ^snd_mixer_selem_regopt;
  snd_mixer_selem_regopt = record
	(** structure version *)
	ver: cint;
	(** v1: abstract layer selection *)
	abstract_: snd_mixer_selem_regopt_abstract;
	(** v1: device name (must be NULL when playback_pcm or capture_pcm != NULL) *)
	device: PChar;
	(** v1: playback PCM connected to mixer device (NULL == none) *)
	playback_pcm: pointer;
	(** v1: capture PCM connected to mixer device (NULL == none) *)
	capture_pcm: pointer;
  end;
  
  (** Mixer simple element identifier *)
  PPsnd_mixer_selem_id_t = ^Psnd_mixer_selem_id_t;
  Psnd_mixer_selem_id_t = ^snd_mixer_selem_id_t;
  snd_mixer_selem_id_t = record
  end;
  
  TCallbackThread = class(TThread)
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
    end;
      
// Dynamic load : Vars that will hold our dynamically loaded ALSA methods...
var
  CallbackThread : TCallbackThread;
  snd_mixer_open: function(mixer: PPsnd_mixer_t; mode: cint): cint; cdecl; 
  snd_mixer_attach: function(mixer: Psnd_mixer_t; name: PChar): cint; cdecl;
  snd_mixer_selem_register: function(mixer: Psnd_mixer_t;
			          options: Psnd_mixer_selem_regopt;
			          classp: PPsnd_mixer_class_t): cint; cdecl;
  snd_mixer_load: function(mixer: Psnd_mixer_t): cint; cdecl;
  snd_mixer_selem_id_malloc: function(ptr: PPsnd_mixer_selem_id_t): cint; cdecl;
  snd_mixer_selem_id_set_index: procedure(obj: Psnd_mixer_selem_id_t; val: cuint); cdecl;
  snd_mixer_selem_id_set_name: procedure(obj: Psnd_mixer_selem_id_t; val: PChar); cdecl;
  snd_mixer_find_selem: function(mixer: Psnd_mixer_t;
			      id: Psnd_mixer_selem_id_t): Psnd_mixer_elem_t; cdecl;
  snd_mixer_selem_get_playback_volume_range: function(elem: Psnd_mixer_elem_t;
					           min, max: Pclong): cint; cdecl;  
  snd_mixer_selem_get_playback_volume: function(elem: Psnd_mixer_elem_t; channel: 
	snd_mixer_selem_channel_id_t; value: Pclong): cint; cdecl;				           
  snd_mixer_selem_set_playback_volume_all: function(elem: Psnd_mixer_elem_t; value: clong): cint; cdecl;
  snd_mixer_selem_set_playback_volume: function(elem: Psnd_mixer_elem_t;
   channel: snd_mixer_selem_channel_id_t; value: clong): cint; cdecl;
   
  snd_mixer_set_callback: procedure(obj: Psnd_mixer_t; val: snd_mixer_callback_t); cdecl;
  snd_mixer_elem_set_callback: procedure(obj: Psnd_mixer_elem_t; val: snd_mixer_elem_callback_t); cdecl;
   
  snd_mixer_handle_events: function(mixer: Psnd_mixer_t): cint; cdecl;
  
  snd_mixer_wait: function(mixer: Psnd_mixer_t; timeout: cint): cint; cdecl;
  
  snd_mixer_close: function(mixer: Psnd_mixer_t): cint; cdecl;

 // Special function for dynamic loading of lib ...
  am_Handle: TLibHandle = dynlibs.NilHandle; // this will hold our handle for the lib

  ReferenceCounter: integer = 0;  // Reference counter
  
  hmixcallback : Psnd_mixer_t;
  thecallback: snd_mixer_elem_callback_t;				  

function ALSAmixerGetVolume(chan:integer): integer; // chan 0 = left, chan 1 = right

procedure ALSAmixerSetVolume(chan, volume :integer); // chan 0 = left, chan 1 = right volume
                                                     // volume from 0 to 100 
procedure ALSAmixerSetCallBack(callback: snd_mixer_elem_callback_t);

implementation
  
function am_IsLoaded: Boolean;
begin
  Result := (am_Handle <> dynlibs.NilHandle);
end;

function am_Load: Boolean; // load the lib
var
  thelib: string = 'libasound.so.2';
begin
  Result := False;
  if am_Handle <> dynlibs.NilHandle then // is it already there ?
  begin
    Inc(ReferenceCounter);
    Result := True; 
  end
  else
  begin // go & load the library
    am_Handle := DynLibs.SafeLoadLibrary(thelib); // obtain the handle we want
    if am_Handle <> DynLibs.NilHandle then
    begin // now we tie the functions to the VARs from above

      Pointer(snd_mixer_open)       :=
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_open'));
      Pointer(snd_mixer_attach) := 
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_attach'));
      Pointer(snd_mixer_selem_register)     := 
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_register'));
      Pointer(snd_mixer_load)    := 
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_load'));
      Pointer(snd_mixer_selem_id_malloc)      := 
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_id_malloc'));
      Pointer(snd_mixer_selem_id_set_index)      :=
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_id_set_index'));
      Pointer(snd_mixer_selem_id_set_name)      :=
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_id_set_name'));
      Pointer(snd_mixer_find_selem)      := 
         DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_find_selem'));
      Pointer(snd_mixer_selem_get_playback_volume_range)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_get_playback_volume_range'));
      Pointer(snd_mixer_selem_get_playback_volume)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_get_playback_volume'));
      Pointer(snd_mixer_selem_set_playback_volume_all)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_set_playback_volume_all'));
      Pointer(snd_mixer_selem_set_playback_volume)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_selem_set_playback_volume'));
      Pointer(snd_mixer_close)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_close'));
      Pointer(snd_mixer_set_callback)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_set_callback'));
     
      Pointer(snd_mixer_elem_set_callback)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_elem_set_callback'));
       
      Pointer(snd_mixer_handle_events)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_handle_events'));
        
       Pointer(snd_mixer_wait)      := 
        DynLibs.GetProcedureAddress(am_Handle, PChar('snd_mixer_wait'));
     
          Result           := am_IsLoaded;
      ReferenceCounter := 1;
    end;
  end;
end;

constructor TCallbackThread.Create(CreateSuspended : boolean);
  begin
    inherited Create(CreateSuspended);
    FreeOnTerminate := True;
  end; 
  
procedure TCallbackThread.Execute;
  var
   sid : Psnd_mixer_selem_id_t;
   elem : Psnd_mixer_elem_t;
   i : integer;
begin
  if am_Handle = DynLibs.NilHandle then am_Load;       // load the library 
  
  snd_mixer_open(@hmixcallback,0); 
  snd_mixer_attach(hmixcallback, 'default');
  snd_mixer_selem_register(hmixcallback, nil, nil);
  
  snd_mixer_load(hmixcallback);
 
  snd_mixer_selem_id_malloc(@sid);
  snd_mixer_selem_id_set_index(sid, 0);
  snd_mixer_selem_id_set_name(sid, 'Master');
  elem := snd_mixer_find_selem(hmixcallback, sid);
  snd_mixer_elem_set_callback(elem, thecallback);
 
  while (not Terminated) do
      begin
          i := snd_mixer_wait(hmixcallback, -1); 
          if i >= 0 then (snd_mixer_handle_events(hmixcallback));
      end;
  end;
 

procedure am_Unload();
begin
  // < Reference counting
  if ReferenceCounter > 0 then
    Dec(ReferenceCounter);
  if ReferenceCounter < 0 then
    Exit;
  // >
  if am_IsLoaded then
  begin
    DynLibs.UnloadLibrary(am_Handle);
    am_Handle := DynLibs.NilHandle;
  end;
end;

// ALSA methods:
{
function mixcallback(ctl: Psnd_mixer_t;
				  mask: cuint;
				  elem: Psnd_mixer_elem_t): cint; cdecl;
begin
writeln('Yep, mixer changed');
end;	
}			  

function ALSAmixerGetVolume(chan:integer): integer; // chan 0 = left, chan 1 = right
var
   hmix : Psnd_mixer_t;
   sid : Psnd_mixer_selem_id_t;
   elem : Psnd_mixer_elem_t;
   min, max, vol: clong;
begin
  Result := 0;
  if am_Handle = DynLibs.NilHandle then am_Load;       // load the library 
  
  snd_mixer_open(@hmix,0); 
  snd_mixer_attach(hmix, 'default');
  snd_mixer_selem_register(hmix, nil, nil);
  snd_mixer_load(hmix);
  
  snd_mixer_selem_id_malloc(@sid);
  snd_mixer_selem_id_set_index(sid, 0);
  snd_mixer_selem_id_set_name(sid, 'Master');
  elem := snd_mixer_find_selem(hmix, sid);
  
  snd_mixer_selem_get_playback_volume_range(elem, @min, @max);
   //writeln('min = ' + inttostr(min) + 'max = ' + inttostr(max));
   
  if chan = 0 then snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_FRONT_LEFT, @vol);
  //writeln('vol left = ' + inttostr(vol)); 
  
  if chan = 1 then snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_FRONT_Right, @vol);
  //writeln('vol right = ' + inttostr(vol));
 
   result := round(vol/max*100);
 
    snd_mixer_close(hmix);
      
  // if CloseLib then
  // am_unload;  // Unload library if param CloseLib is true
end; 

procedure ALSAmixerSetVolume(chan, volume :integer); // chan 0 = left, chan 1 = right volume
                                                     // volume from 0 to 100 
var
   hmix : Psnd_mixer_t;
   sid : Psnd_mixer_selem_id_t;
   elem : Psnd_mixer_elem_t;
   min, max: clong;
begin
  if am_Handle = DynLibs.NilHandle then am_Load;       // load the library 
  
  snd_mixer_open(@hmix,0); 
  snd_mixer_attach(hmix, 'default');
  snd_mixer_selem_register(hmix, nil, nil);
 
  snd_mixer_load(hmix);
  
  snd_mixer_selem_id_malloc(@sid);
  snd_mixer_selem_id_set_index(sid, 0);
  snd_mixer_selem_id_set_name(sid, 'Master');
  elem := snd_mixer_find_selem(hmix, sid);
  
  snd_mixer_selem_get_playback_volume_range(elem, @min, @max);
 
  snd_mixer_selem_set_playback_volume_all(elem, round(volume * max / 100));
  
  if chan = 0 then snd_mixer_selem_set_playback_volume(elem, SND_MIXER_SCHN_FRONT_LEFT,
   round(volume * max / 100));
 
  if chan = 1 then snd_mixer_selem_set_playback_volume(elem, SND_MIXER_SCHN_FRONT_right,
   round(volume * max / 100));
  
   snd_mixer_close(hmix);
      
  // if CloseLib then
  // am_unload;  // Unload library if param CloseLib is true
end; 

procedure ALSAmixerSetCallBack(callback: snd_mixer_elem_callback_t );
var
   sid : Psnd_mixer_selem_id_t;
   elem : Psnd_mixer_elem_t;
   i : integer;
begin
     thecallback := callback;
     CallbackThread := TCallbackThread.Create(True); 
     CallbackThread.Start;
 end;

 finalization  
 
 if assigned(CallbackThread) then CallbackThread.terminate;

 if assigned(hmixcallback) then snd_mixer_close(hmixcallback);
 am_unload;

end.
