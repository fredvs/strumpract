{ Thanks to PCurtis@Lazarus forum }

{ FredvS fiens@hotmail.com 2021 }

unit win_mixer;

{$mode objfpc}{$H+}
{$PACKRECORDS C}

interface

uses
  Windows,
  ctypes,
  SysUtils,
  ActiveX,
  ComObj;

const
  CLASS_IMMDeviceEnumerator : TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
  IID_IMMDeviceEnumerator : TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
  IID_IAudioEndpointVolume : TGUID = '{5CDF2C82-841E-4546-9722-0CF74078229A}';

type
  PAUDIO_VOLUME_NOTIFICATION_DATA = ^AUDIO_VOLUME_NOTIFICATION_DATA;
  AUDIO_VOLUME_NOTIFICATION_DATA = record
    guidEventContext: TGUID;
    bMuted: BOOL;
    fMasterVolume: Single;
    nChannels: UINT;
    afChannelVolumes: Single;
  end;

  IAudioEndpointVolumeCallback = interface(IUnknown)
    ['{657804FA-D6AD-4496-8A60-352752AF4F89}']
    function OnNotify(pNotify: PAUDIO_VOLUME_NOTIFICATION_DATA): HRESULT; stdcall;
  end;
  
   IAudioEndpointVolume = interface(IUnknown)
    ['{5CDF2C82-841E-4546-9722-0CF74078229A}']
    function RegisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): HRESULT; stdcall;
    function UnregisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): HRESULT; stdcall;
    function GetChannelCount(out PInteger): HRESULT; stdcall;
    function SetMasterVolumeLevel(fLevelDB: single; pguidEventContext: PGUID): HRESULT; stdcall;
    function SetMasterVolumeLevelScalar(fLevelDB: single; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetMasterVolumeLevel(out fLevelDB: single): HRESULT; stdcall;
    function GetMasterVolumeLevelScaler(out fLevelDB: single): HRESULT; stdcall;
    function SetChannelVolumeLevel(nChannel: Integer; fLevelDB: double; pguidEventContext: PGUID): HRESULT; stdcall;
    function SetChannelVolumeLevelScalar(nChannel: Integer; fLevelDB: double; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetChannelVolumeLevel(nChannel: Integer; out fLevelDB: double): HRESULT; stdcall;
    function GetChannelVolumeLevelScalar(nChannel: Integer; out fLevel: double): HRESULT; stdcall;
    function SetMute(bMute: Boolean; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetMute(out bMute: Boolean): HRESULT; stdcall;
    function GetVolumeStepInfo(pnStep: Integer; out pnStepCount: Integer): HRESULT; stdcall;
    function VolumeStepUp(pguidEventContext: PGUID): HRESULT; stdcall;
    function VolumeStepDown(pguidEventContext: PGUID): HRESULT; stdcall;
    function QueryHardwareSupport(out pdwHardwareSupportMask): HRESULT; stdcall;
    function GetVolumeRange(out pflVolumeMindB: double; out pflVolumeMaxdB: double; out pflVolumeIncrementdB: double): HRESULT; stdcall;
  end;

  IAudioMeterInformation = interface(IUnknown)
  ['{C02216F6-8C67-4B5B-9D00-D008E73E0064}']
  end;

  IPropertyStore = interface(IUnknown)
  end;

  IMMDevice = interface(IUnknown)
  ['{D666063F-1587-4E43-81F1-B948E807363F}']
    function Activate(const refId: TGUID; dwClsCtx: DWORD;  pActivationParams: PInteger; out pEndpointVolume: IAudioEndpointVolume): HRESULT; stdCall;
    function OpenPropertyStore(stgmAccess: DWORD; out ppProperties: IPropertyStore): HRESULT; stdcall;
    function GetId(out ppstrId: PLPWSTR): HRESULT; stdcall;
    function GetState(out State: Integer): HRESULT; stdcall;
  end;


  IMMDeviceCollection = interface(IUnknown)
  ['{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}']
  end;

  IMMNotificationClient = interface(IUnknown)
  ['{7991EEC9-7E89-4D85-8390-6C703CEC60C0}']
  end;

  IMMDeviceEnumerator = interface(IUnknown)
  ['{A95664D2-9614-4F35-A746-DE8DB63617E6}']
    function EnumAudioEndpoints(dataFlow: TOleEnum; deviceState: SYSUINT; DevCollection: IMMDeviceCollection): HRESULT; stdcall;
    function GetDefaultAudioEndpoint(EDF: SYSUINT; ER: SYSUINT; out Dev :IMMDevice ): HRESULT; stdcall;
    function GetDevice(pwstrId: pointer; out Dev: IMMDevice): HRESULT; stdcall;
    function RegisterEndpointNotificationCallback(pClient: IMMNotificationClient): HRESULT; stdcall;
  end;
  
 const
  WM_VOLNOTIFY = WM_USER + 1;
  
type
Tproc = procedure;  

type
 TEndpointVolumeCallback = class(TInterfacedObject, IAudioEndpointVolumeCallback)
    FDeviceEnumerator: IMMDeviceEnumerator;
    FMMDevice: IMMDevice;
    FAudioEndpointVolume: IAudioEndpointVolume;
    function OnNotify(pNotify: PAUDIO_VOLUME_NOTIFICATION_DATA): HRESULT; stdcall; 
    procedure Init();
 end; 
 
 procedure WINmixerSetCallBack(callback: Tproc);
 
 function WINmixerGetVolume(chan:integer): integer; // chan 0 = left, chan 1 = right

 procedure WINmixerSetVolume(chan, volume :integer); // chan 0 = left, chan 1 = right volume
                                                    // volume from 0 to 100 

 procedure WINmixerFreeCallback();

var
  wm_MasterVolLeft, wm_MasterVolRight : integer; 
  wm_MasterMuted : boolean;
  
implementation

var
  ACallBack : TProc;
  AEndpoint : TEndpointVolumeCallback;

procedure WINmixerFreeCallback();
begin
if assigned(AEndpoint) then AEndpoint.free;
end;
 
procedure WINmixerSetVolume(chan, volume :integer); // chan 0 = left, chan 1 = right volume
var
  pEndpointVolume: IAudioEndpointVolume;
  LDeviceEnumerator: IMMDeviceEnumerator;
  Dev: IMMDevice;
  avol : single;
begin
  OleCheck(CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, 
  CLSCTX_INPROC_SERVER, IID_IMMDeviceEnumerator, LDeviceEnumerator));
  OleCheck(LDeviceEnumerator.GetDefaultAudioEndpoint(0, 0, Dev));
 
  OleCheck(Dev.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, pEndpointVolume));
  avol := volume/100;
  (pEndpointVolume.SetMasterVolumeLevelScalar(avol, @GUID_NULL));
end;

function WINmixerGetVolume(chan:integer): integer; // chan 0 = left, chan 1 = right
var
  pEndpointVolume: IAudioEndpointVolume;
  LDeviceEnumerator: IMMDeviceEnumerator;
  Dev: IMMDevice;
  avol : single;
begin
  OleCheck(CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, CLSCTX_INPROC_SERVER,
   IID_IMMDeviceEnumerator, LDeviceEnumerator)); 
  OleCheck(LDeviceEnumerator.GetDefaultAudioEndpoint(0, 0, dev));
  OleCheck(Dev.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, pEndpointVolume));
    
  (pEndpointVolume.GetMasterVolumeLevelScaler(avol));
   
   result := round(avol * 100);
end;
 
procedure WINmixerSetCallBack(callback: Tproc);
begin
 AEndpoint := TEndpointVolumeCallback.create();
 AEndpoint.init();
 ACallBack := callback; 
end;

 procedure TEndpointVolumeCallback.Init();
 begin
   OleCheck(CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, CLSCTX_INPROC_SERVER,
    IID_IMMDeviceEnumerator, FDeviceEnumerator));
  OleCheck(FDeviceEnumerator.GetDefaultAudioEndpoint(0, 0, FMMDevice));
  OleCheck(FMMDevice.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, FAudioEndpointVolume));
  OleCheck(FAudioEndpointVolume.RegisterControlChangeNotify(self));
 end;
 
function TEndpointVolumeCallback.OnNotify(pNotify: PAUDIO_VOLUME_NOTIFICATION_DATA): HRESULT; stdcall;
begin
  wm_MasterVolLeft := Round(100 * pNotify^.fMasterVolume);
  wm_MasterVolRight := wm_MasterVolLeft; // todo
  wm_MasterMuted := pNotify^.bMuted;
  ACallBack;
end;

initialization
 CoInitialize(nil);

finalization  
 CoUninitialize;
 AEndpoint := nil;

end.