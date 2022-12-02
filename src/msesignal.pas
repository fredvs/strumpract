{ MSEgui Copyright (c) 2010-2013 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

 // Link to Portaudio and LibSnfile by FredvS


 // todo: optimize for realtime, remove the OOP approach where
 // it degrades performance, use SSE.


unit msesignal;

{$ifdef FPC}{$mode objfpc}{$h+}{$interfaces corba}{$endif}
interface

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
{$endif}

uses
  msedatalist,
  mseclasses,
  Classes,
  mclasses,
  msetypes,
  msearrayprops,
  mseevent,
  msehash,
  msesystypes,
  msereal,
  msetimer,
  mseglob,
  Math;

const
  defaultsamplefrequ = 44100; //Hz
  defaultstepcount = 4096;
  defaultenvelopesubsampling = 8;
  defaulttickdiv = 200;
  defaultsamplecount = 4096;
  defaultharmonicscount = 16;
  functionsegmentcount = 32;
{$ifdef FPC}
  semitoneln = ln(2) / 12;
  chromaticscale: array[0..12] of double =
    (1.0, exp(1 * semitoneln), exp(2 * semitoneln), exp(3 * semitoneln), exp(4 * semitoneln),
    exp(5 * semitoneln), exp(6 * semitoneln), exp(7 * semitoneln), exp(8 * semitoneln),
    exp(9 * semitoneln), exp(10 * semitoneln), exp(11 * semitoneln), 2.0);
{$else}
 semitoneln = 5.77622650467e-2;
 chromaticscale: array[0..12] of double =
    (1.0,1.05946309436,1.12246204831,1.189207115,
     1.2599210499,1.33483985417,1.41421356237,1.49830707688,
     1.58740105197,1.6817928179283051,1.78179743628,1.88774862536,2.0);
{$endif}

type
  TArSingle = array of single;

type
  siginchangeflagty   = (sic_value, sic_stream);
  siginchangeflagsty  = set of siginchangeflagty;
  psiginchangeflagsty = ^siginchangeflagsty;

const
  siginchangeresetflags = [sic_value];

type
  sigsampleroptionty  = (sso_fulltick, sso_negtrig, sso_autorun,
    sso_fftmag, sso_average); //used by tsigsamplerfft
  sigsampleroptionsty = set of sigsampleroptionty;

const
  defaultsigsampleroptions = [sso_fulltick];

type
  tcustomsigcomp = class;
  tdoublesigcomp = class;
  tsigcontroller = class;

  tcustomsigcomp = class(tmsecomponent)
  protected
    fupdating: integer;
    procedure coeffchanged(const Sender: tdatalist; const aindex: integer); virtual;
    procedure update; virtual;
  public
    procedure beginupdate;
    procedure endupdate;
  end;

  tsigcomp = class(tcustomsigcomp)

  end;

  tdoubleinputconn  = class;
  tdoubleoutputconn = class;

  inputconnarty  = array of tdoubleinputconn;
  outputconnarty = array of tdoubleoutputconn;

  psighandlerinfoty = ^sighandlerinfoty;
  sighandlerprocty  = procedure(const ainfo: psighandlerinfoty) of object;

  psiginfoty = ^siginfoty;

  sigclientinfoty = record
    infopo: psiginfoty;
  end;
  psigclientinfoty = ^sigclientinfoty;

  sigclientoptionty  = (sco_tick, sco_fulltick);
  sigclientoptionsty = set of sigclientoptionty;

  isigclient = interface(ievent)
    procedure initmodel;
    procedure Clear;
    function getinputar: inputconnarty;
    function getoutputar: outputconnarty;
    function gethandler: sighandlerprocty;
    function getzcount: integer;
    function getcomponent: TComponent;
    procedure modelchange;
    function getsigcontroller: tsigcontroller;
    function getsigclientinfopo: psigclientinfoty;
    function getsigoptions: sigclientoptionsty;
 {$ifdef FPC}
    procedure sigtick;
 {$else}
  procedure sigtick();
 {$endif}
  end;

  sigclientintfarty = array of isigclient;

  tdoublesigcomp = class(tsigcomp, isigclient)
  private
    fsigclientinfo: sigclientinfoty;
    procedure setcontroller(const avalue: tsigcontroller);
  protected
    fcontroller: tsigcontroller;
    procedure modelchange;
    procedure loaded; override;
    procedure lock;
    procedure unlock;

    //isigclient
    procedure initmodel; virtual;
    procedure sigtick; virtual;
    function getinputar: inputconnarty; virtual;
    function getoutputar: outputconnarty; virtual;
    function gethandler: sighandlerprocty; virtual; abstract;
    function getzcount: integer; virtual;
    function getsigcontroller: tsigcontroller;
    function getsigclientinfopo: psigclientinfoty;
    function getsigoptions: sigclientoptionsty; virtual;
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure lockapplication;  //releases controller lock, can not be nested,
    //call from locked signal thread only
    procedure unlockapplication;//acquires controller lock
  published
    property controller: tsigcontroller read fcontroller write setcontroller;
  end;

  tsigconn = class(tmsecomponent)
    //no solution found to link to streamed tpersistent or tobject,
    //fork of classes.pp necessary. :-(
  end;

  tdoubleconn = class(tsigconn)
  protected
    fsigintf: isigclient;
    function getcontroller: tsigcontroller;
    procedure lock;
    procedure unlock;
  public
    constructor Create(const aowner: TComponent; const asigintf: isigclient); reintroduce; virtual;
    property controller: tsigcontroller read getcontroller;
  end;

  valuescaleoptionty  = (vso_exp, vso_null); //out:= 0 for inp <= 0
  valuescaleoptionsty = set of valuescaleoptionty;

  doublescaleinfoty = record
    Value: double;
    min: double;
    max: double;
    options: valuescaleoptionsty;
    gain, offset: double;
  end;

  doubleinputconnarty = array of tdoubleinputconn;

  outputconnstatety  = (ocs_eventdriven);
  outputconnstatesty = set of outputconnstatety;

  tdoubleoutputconn = class(tdoubleconn)
  private
    function geteventdriven: Boolean;
    procedure seteventdriven(const avalue: Boolean);
  protected
    fstate: outputconnstatesty;
    fdestinations: doubleinputconnarty;
    fvalue: double;
    property eventdriven: Boolean read geteventdriven write seteventdriven;
  public
    constructor Create(const aowner: TComponent; const asigintf: isigclient; const aeventdriven: Boolean);
      reintroduce; virtual;
    property Value: double read fvalue write fvalue;
  end;

  inpscaleinfoty = record
    offset: double;
    gain: double;
    hasscale: Boolean;
    hasmin: Boolean;
    hasmax: Boolean;
    isexp: Boolean;
  end;

  sigvaluety = record
    Value: double;
    changed: siginchangeflagsty;
  end;
  psigvaluety    = ^sigvaluety;
  sigvaluepoarty = array of psigvaluety;

  tdoubleinputconn = class(tdoubleconn)
  private
    fsource: tdoubleoutputconn;
    foffset: double;
    fgain: double;
    fmin: realty;
    fmax: realty;
    fexpstart: realty;
    fexpend: realty;
    procedure setsource(const avalue: tdoubleoutputconn);
    procedure setoffset(const avalue: double);
    procedure setgain(const avalue: double);
    procedure setvalue(const avalue: double); virtual;
    procedure setmin(const avalue: realty);
    procedure setmax(const avalue: realty);
    procedure setexpstart(const avalue: realty);
    procedure setexpend(const avalue: realty);
  protected
    fsca: inpscaleinfoty;
    fv: sigvaluety;
  public
    constructor Create(const aowner: TComponent; const asigintf: isigclient); override;
    destructor Destroy; override;
  published
    property Source: tdoubleoutputconn read fsource write setsource;
    property offset: double read foffset write setoffset;
    property gain: double read fgain write setgain;
    property min: realty read fmin write setmin;
    property max: realty read fmax write setmax;
    property expstart: realty read fexpstart write setexpstart;
    property expend: realty read fexpend write setexpend;
    property Value: double read fv.Value write setvalue;
  end;

  tlimitinputconn = class(tdoubleinputconn)
  public
    constructor Create(const aowner: TComponent; const asigintf: isigclient); override;
    //deafault min = 0, default max = 1
  end;

  tchangedoubleinputconn = class(tdoubleinputconn)
  private
    fonchange: notifyeventty;
  protected
    procedure setvalue(const avalue: double); override;
  public
    constructor Create(const aowner: TComponent; const asigintf: isigclient; const aonchange: notifyeventty); reintroduce;
  end;

  sighandlerinfoty = record
    //  dest: pdouble;
    discard: Boolean;
  end;

  siginfopoarty    = array of psiginfoty;
  signahdlerprocty = procedure(siginfo: psiginfoty);

  siginfostatety  = (sis_checked, sis_eventchecked, sis_touched,
    sis_input, sis_output,
    sis_eventoutput, sis_eventinput, sis_fulltick, sis_sighandler);
  siginfostatesty = set of siginfostatety;

  inputstatety  = (ins_checked, ins_recursive);
  inputstatesty = set of inputstatety;

  inputinfoty = record
    input: tdoubleinputconn;
    Source: psiginfoty;
    state: inputstatesty;
  end;
  inputinfoarty = array of inputinfoty;

  sigdestinfoty = record
    outputindex: integer;
    destinput: tdoubleinputconn;
  end;
  sigdestinfoarty = array of sigdestinfoty;

  siginfoty = record
    intf: isigclient;
    options: sigclientoptionsty;
    handler: sighandlerprocty;
    zcount: integer;
    inputs: inputinfoarty;
    outputs: outputconnarty;
    destinations: sigdestinfoarty;
    eventdestinations: siginfopoarty;
    state: siginfostatesty;
    prev: siginfopoarty;
    connectedcount: integer;
    Next: siginfopoarty;
  end;
  siginfoarty = array of siginfoty;

  destinfoty = record
    Source: pdouble;
    dest: pdouble;
    min: double;
    max: double;
    sca: inpscaleinfoty;
  end;
  destinfoarty = array of destinfoty;

  sighandlernodeinfoty = record
    handlerinfo: sighandlerinfoty;
    handler: sighandlerprocty;
    dest: destinfoarty;
    desthigh: integer;
  end;
  psighandlernodeinfoty  = ^sighandlernodeinfoty;
  sighandlernodeinfoarty = array of sighandlernodeinfoty;

  tsigconnection = class(tdoublesigcomp)
  end;

  sigineventty        = procedure(const Sender: TObject; var sig: real) of object;
  siginbursteventty   = procedure(const Sender: TObject; var sig: realarty) of object;
  sigincomplexeventty = procedure(const Sender: TObject; var sig: complexty) of object;
  sigincomplexbursteventty = procedure(const Sender: TObject; var sig: complexarty) of object;

  tsigin = class(tsigconnection)
  private
    foutput: tdoubleoutputconn;
    foutputpo: pdouble;
    fvalue: double;
    finp: doublearty;
    foninput: sigineventty;
    foninputburst: siginbursteventty;
    finpindex: integer;
    procedure setvalue(const avalue: double);
  protected
    function getoutputar: outputconnarty; override;
    //isigclient
    procedure initmodel; override;
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure siginput(const asource: doublearty);
    procedure Clear; override;
    property output: tdoubleoutputconn read foutput;
  published
    property Value: double read fvalue write setvalue;
    property oninput: sigineventty read foninput write foninput;
    property oninputburst: siginbursteventty read foninputburst write foninputburst;
  end;

  sigouteventty      = procedure(const Sender: TObject; const sig: real) of object;
  sigoutbursteventty = procedure(const Sender: TObject; const sig: realarty) of object;

  tsigout = class(tsigconnection)
  private
    finput: tdoubleinputconn;
    finputpo: psigvaluety;
    fonoutput: sigouteventty;
    fvalue: double;
    fonoutputburst: sigoutbursteventty;
    foutp: doublearty;
    foutpindex: integer;
    fbuffersize: integer;
    procedure setinput(const avalue: tdoubleinputconn);
    function getinput: tdoubleinputconn;
    procedure setbuffersize(const avalue: integer);
    function getvalue: double;
  protected
    function getinputar: inputconnarty; override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    procedure sigoutput1(var adest: doublearty); //returns a data copy
    function sigoutput: doublearty;
    property Value: double read getvalue;
  published
    property input: tdoubleinputconn read getinput write setinput;
    property buffersize: integer read fbuffersize write setbuffersize default 0;
    property onoutput: sigouteventty read fonoutput write fonoutput;
    property onoutputburst: sigoutbursteventty read fonoutputburst write fonoutputburst;
  end;

  trealcoeff = class(trealdatalist)
  protected
    fowner: tcustomsigcomp;
    procedure doitemchange(const aindex: integer); override;
  public
    constructor Create(const aowner: tcustomsigcomp); reintroduce;
  end;

  tcomplexcoeff = class(tcomplexdatalist)
  protected
    fowner: tcustomsigcomp;
    procedure doitemchange(const aindex: integer); override;
  public
    constructor Create(const aowner: tcustomsigcomp); reintroduce;
  end;

  tdoublezcomp = class(tdoublesigcomp) //single input, single output
  private
    procedure setinput(const avalue: tdoubleinputconn);
    procedure setoutput(const avalue: tdoubleoutputconn);
  protected
    fzcount: integer;
    fzhigh: integer;
    fdoublez: doublearty;
    fzindex: integer;
    finputindex: integer;
    fdoubleinputdata: doubleararty;
    finput: tdoubleinputconn;
    foutput: tdoubleoutputconn;
    foutputpo: pdouble;
    function getinputar: inputconnarty; override;
    function getoutputar: outputconnarty; override;
    procedure setzcount(const avalue: integer);
    function getzcount: integer; override;
    procedure zcountchanged; virtual;
    procedure initmodel; override;
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    property zcount: integer read getzcount default 0;
    property output: tdoubleoutputconn read foutput write setoutput;
  published
    property input: tdoubleinputconn read finput write setinput;
  end;

  tdoubleinpconnarrayprop = class(tpersistentarrayprop)
  private
    fsigintf: isigclient;
    function getitems(const index: integer): tdoubleinputconn;
  protected
    procedure createitem(const index: integer; var item: TPersistent); override;
    procedure dosizechanged; override;
  public
    constructor Create(const asigintf: isigclient); reintroduce;
    class function getitemclasstype: persistentclassty; override;
    //used in dumpunitgroups
    property items[const index: integer]: tdoubleinputconn read getitems; default;
  end;

  tdoubleoutconnarrayprop = class(tpersistentarrayprop)
  private
    function getitems(const index: integer): tdoubleoutputconn;
  protected
    fsigintf: isigclient;
    fname: string;
    fowner: TComponent;
    feventdriven: Boolean;
    procedure createitem(const index: integer; var item: TPersistent); override;
    procedure dosizechanged; override;
  public
    constructor Create(const aowner: TComponent; const aname: string; const asigintf: isigclient; const aeventdriven: Boolean); reintroduce;
    class function getitemclasstype: persistentclassty; override;
    //used in dumpunitgroups
    property items[const index: integer]: tdoubleoutputconn read getitems; default;
  end;

  tsigmultiinp = class(tdoublesigcomp)
  private
    finputs: tdoubleinpconnarrayprop;
    procedure setinputs(const avalue: tdoubleinpconnarrayprop);
  protected
    finps: sigvaluepoarty;
    finphigh: integer;
    function getinputar: inputconnarty; override;
    procedure initmodel; override;
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
  published
    property inputs: tdoubleinpconnarrayprop read finputs write setinputs;
  end;

  tsigsampler              = class;
  samplerbufferty          = array of doublearty;
  samplerbufferfulleventty = procedure(const Sender: tsigsampler; const abuffer: samplerbufferty) of object;

  tsigsampler = class(tsigmultiinp)
  private
    fbufferlength: integer;
    fbufpo: integer;
    ftrigger: tchangedoubleinputconn;
    ftriggerlevel: tchangedoubleinputconn;
    fonbufferfull: samplerbufferfulleventty;
    ftimer: tsimpletimer;
    frefreshus: integer;
    procedure setbufferlength(const avalue: integer);
    procedure settrigger(const avalue: tchangedoubleinputconn);
    procedure settriggerlevel(const avalue: tchangedoubleinputconn);
    procedure setrefreshus(const avalue: integer);
  protected
    foptions: sigsampleroptionsty;
    fnegtrig: Boolean;
    fstarted: Boolean;
    fstartpending: Boolean;
    fpretrigger: Boolean;
    frunning: Boolean;
    fsigbuffer: samplerbufferty;
    procedure setoptions(const avalue: sigsampleroptionsty) virtual;
    procedure updateoptions(var avalue: sigsampleroptionsty); virtual;
    procedure dotimer(const Sender: TObject);
    procedure dotriggerchange(const Sender: TObject);
    procedure dobufferfull; virtual;
    procedure loaded; override;
    procedure checkautostart;
    //isigclient
    function getsigoptions: sigclientoptionsty; override;
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
    procedure initmodel; override;
    function getinputar: inputconnarty; override;
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    procedure start;
  published
    property bufferlength: integer read fbufferlength write setbufferlength default defaultsamplecount;
    property trigger: tchangedoubleinputconn read ftrigger write settrigger;
    property triggerlevel: tchangedoubleinputconn read ftriggerlevel write settriggerlevel;
    property options: sigsampleroptionsty read foptions write setoptions default defaultsigsampleroptions;
    property onbufferfull: samplerbufferfulleventty read fonbufferfull write fonbufferfull;
    property refreshus: integer read frefreshus write setrefreshus default -1;
    //micro seconds, -1 -> off, 0 -> on idle
  end;

  tsigmultiinpout = class(tsigmultiinp)
  private
    procedure setoutput(const avalue: tdoubleoutputconn);
  protected
    foutput: tdoubleoutputconn;
    foutputpo: pdouble;
    function getoutputar: outputconnarty; override;
    procedure initmodel; override;
  public
    constructor Create(aowner: TComponent); override;
    property output: tdoubleoutputconn read foutput write setoutput;
  end;

  tsigadd = class(tsigmultiinpout)
  protected
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  end;

  tsigdelay = class(tsigadd)
  private
  protected
    fz: double;
    function getzcount: integer; override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    procedure Clear; override;
  end;

  tcustomsigdelay = class(tsigadd)
  private
    fdelay: integer;
    finppo: integer;
    procedure setdelay(const avalue: integer);
  protected
    fz: doublearty;
    procedure initmodel; override;
    function getzcount: integer; override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);

    property delay: integer read fdelay write setdelay default 1;
  public
    constructor Create(aowner: TComponent); override;
    procedure Clear; override;
  end;

  tsigdelayn = class(tcustomsigdelay)
  published
    property delay;
  end;

  tsigdelayvar = class(tcustomsigdelay)
  private
    fdelayinp: tdoubleinputconn;
    fdelayinppo: pdouble;
    function getdelaymax: integer;
    procedure setdelaymax(const avalue: integer);
    procedure setdelayinp(const avalue: tdoubleinputconn);
  protected
    function getinputar: inputconnarty; override;
    procedure initmodel; override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    constructor Create(aowner: TComponent); override;
  published
    property delaymax: integer read getdelaymax write setdelaymax default 1;
    property delay: tdoubleinputconn read fdelayinp write setdelayinp;
  end;

  tdoublesigoutcomp = class(tdoublesigcomp)
  private
    procedure setoutput(const avalue: tdoubleoutputconn);
    procedure seteventdriven(const avalue: Boolean);
  protected
    foutput: tdoubleoutputconn;
    foutputpo: pdouble;
    feventdriven: Boolean;
    function getoutputar: outputconnarty; override;
    procedure initmodel; override;
    property eventdriven: Boolean read feventdriven write seteventdriven;
  public
    constructor Create(aowner: TComponent); override;
    property output: tdoubleoutputconn read foutput write setoutput;
  published
  end;

  tdoublesiginoutcomp = class(tdoublesigoutcomp)
  private
    procedure setinput(const avalue: tdoubleinputconn);
  protected
    finput: tdoubleinputconn;
    finputpo: psigvaluety;
    function getinputar: inputconnarty; override;
  public
    constructor Create(aowner: TComponent); override;
  published
    property input: tdoubleinputconn read finput write setinput;
  end;

  tsigconnector = class(tdoublesiginoutcomp)
  protected
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  end;

  ttrigconnector = class(tsigconnector)
  public
    constructor Create(aowner: TComponent); override;
  end;

  tsigeventconnector = class(tdoublesigcomp)
  end;

  sigwavetableoptionty  = (siwto_intpol);
  sigwavetableoptionsty = set of sigwavetableoptionty;

  tsigwavetable = class(tdoublesigoutcomp)
  private
    ffrequency: tdoubleinputconn;
    ffrequfact: tdoubleinputconn;
    fphase: tdoubleinputconn;
    famplitude: tdoubleinputconn;
    ftable: doublearty;
    ftablelength: integer;
    ftime: double;
    ffrequencypo: psigvaluety;
    ffrequfactpo: psigvaluety;
    fphasepo: psigvaluety;
    famplitudepo: psigvaluety;
    foninittable: siginbursteventty;
    foptions: sigwavetableoptionsty;
    fmaster: tsigwavetable;
    procedure setfrequency(const avalue: tdoubleinputconn);
    procedure setfrequfact(const avalue: tdoubleinputconn);
    procedure setphase(const avalue: tdoubleinputconn);
    procedure setamplitude(const avalue: tdoubleinputconn);
    procedure settable(const avalue: doublearty);
    procedure setoptions(const avalue: sigwavetableoptionsty);
    procedure setmaster(const avalue: tsigwavetable);
  protected
    procedure checktable;
    procedure sighandler(const ainfo: psighandlerinfoty);
    procedure sighandlerintpol(const ainfo: psighandlerinfoty);
    procedure objectevent(const Sender: TObject; const event: objecteventty); override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure initmodel; override;
    function getinputar: inputconnarty; override;
    function getzcount: integer; override;
  public
    constructor Create(aowner: TComponent); override;
    procedure Clear; override;
    property table: doublearty read ftable write settable;
  published
    property master: tsigwavetable read fmaster write setmaster;
    property frequency: tdoubleinputconn read ffrequency write setfrequency;
    property frequfact: tdoubleinputconn read ffrequfact write setfrequfact;
    property phase: tdoubleinputconn read fphase write setphase;
    property amplitude: tdoubleinputconn read famplitude write setamplitude;
    property oninittable: siginbursteventty read foninittable write foninittable;
    property options: sigwavetableoptionsty read foptions write setoptions default [];
  end;

  functionnodety = record
    xend: double;
    offs: double;
    ramp: double;
  end;
  functionnodearty = array of functionnodety;

  functionsegmentty = record
    defaultnode: functionnodety;
    nodes: functionnodearty;
  end;
  pfunctionsegmentty = ^functionsegmentty;
  functionsegmentsty = array[0..functionsegmentcount - 1] of functionsegmentty;

  tsigfuncttable = class(tsigmultiinpout)
  private
    famplitude: tdoubleinputconn;
    foninittable: sigincomplexbursteventty;
    ftable: complexarty;
    fsegments: functionsegmentsty;
    finpmin: double;
    finpmax: double;
    finpfact: double; //map input value to segmentindex
    famplitudepo: psigvaluety;
    fmaster: tsigfuncttable;
    procedure setamplitude(const avalue: tdoubleinputconn);
    procedure settable(const avalue: complexarty);
    procedure setmaster(const avalue: tsigfuncttable);
  protected
    procedure checktable;
    procedure sighandler(const ainfo: psighandlerinfoty);
    procedure objectevent(const Sender: TObject; const event: objecteventty); override;
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure initmodel; override;
    function getinputar: inputconnarty; override;
    function getzcount: integer; override;
  public
    constructor Create(aowner: TComponent); override;
    procedure Clear; override;
    property table: complexarty read ftable write settable;
    //must be ordered by re values
  published
    property master: tsigfuncttable read fmaster write setmaster;
    property amplitude: tdoubleinputconn read famplitude write setamplitude;
    property oninittable: sigincomplexbursteventty read foninittable write foninittable;
  end;

  tsigmult = class(tsigmultiinpout)
  protected
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  end;

  sigenveloperangeoptionty  = (sero_exp, sero_mix);
  sigenveloperangeoptionsty = set of sigenveloperangeoptionty;

  sigenvelopeoptionty  = (seo_eventoutput, seo_negtrig, seo_nozero);
  sigenvelopeoptionsty = set of sigenvelopeoptionty;

  envproginfoty = record
    startval: double;
    ramp: double;
    starttime: integer;
    endtime: integer;
    offset, scale: double;
    isexp: Boolean;
    maxeventdelay: integer;
  end;
  envproginfoarty = array of envproginfoty;

  envelopeinfoty = record
    floopstart: real;
    floopstartindex: integer;
    floopendindex: integer;
    freleasestart: real;
    fattack_values: complexarty;
    attack_valuespo: pcomplexarty;
    fdecay_values: complexarty;
    decay_valuespo: pcomplexarty;
    frelease_values: complexarty;
    release_valuespo: pcomplexarty;
    fprog: envproginfoarty;
    findex: integer;
    findexhigh: integer;
    fdest: double;

    fcurrval: double;
    fcurrvalbefore: double;
    fcurrisexp: Boolean;
    fattackval: double;
    fattackramp: double;
    freleaseindex: integer;
    freleaseval: double;
    freleaseramp: double;
    floopindex: integer;
    floopval: double;
    floopramp: double;
  end;

  tsigenvelope = class(tdoublesigoutcomp)
  private
    ftrigger: tchangedoubleinputconn;
    famplitudepo: psigvaluety;
    fmixpo: psigvaluety;

    fhasmix: Boolean;
    ftime: integer;
    foptions: sigenvelopeoptionsty;
    ftimescale: real;
    fmin: real;
    fmax: real;
    finfos: array [0..1] of envelopeinfoty;
    feventthreshold: real;

    fattack_options: sigenveloperangeoptionsty;
    fdecay_options: sigenveloperangeoptionsty;
    frelease_options: sigenveloperangeoptionsty;
    fmaster: tsigenvelope;
    famplitude: tdoubleinputconn;
    fmix: tlimitinputconn;
    fattack_maxeventtime: real;
    fdecay_maxeventtime: real;
    frelease_maxeventtime: real;
    function getattack_values(const index: integer): complexarty;
    procedure setattack_values(const index: integer; const avalue: complexarty);
    function getdecay_values(const index: integer): complexarty;
    procedure setdecay_values(const index: integer; const avalue: complexarty);
    function getrelease_values(const index: integer): complexarty;
    procedure setrelease_values(const index: integer; const avalue: complexarty);
    function getloopstart(const index: integer): real;
    procedure setloopstart(const index: integer; const avalue: real);

    procedure settrigger(const avalue: tchangedoubleinputconn);
    procedure setmin(const avalue: real);
    procedure setmax(const avalue: real);
    procedure setoptions(const avalue: sigenvelopeoptionsty);
    procedure setattack_options(const avalue: sigenveloperangeoptionsty);
    procedure setdecay_options(const avalue: sigenveloperangeoptionsty);
    procedure setrelease_options(const avalue: sigenveloperangeoptionsty);
    procedure setmaster(const avalue: tsigenvelope);
    procedure setamplitude(const avalue: tdoubleinputconn);
    procedure dosync;
    procedure setmix(const avalue: tlimitinputconn);
    procedure setsubsampling(avalue: integer);
  protected
    fattackpending: Boolean;
    freleasepending: Boolean;
    ffinished: Boolean;
    fsubsampling: integer;
    fsamplecount: integer;
    feventtime: integer;
    fmaxeventdelay: integer;
    procedure sighandler(const ainfo: psighandlerinfoty);
    procedure updatevalues(var ainfo: envelopeinfoty);
    procedure updatevalueindex(const aindex: integer);
    procedure updatevaluesx;

    procedure objectevent(const Sender: TObject; const event: objecteventty); override;
    procedure initmodel; override;
    function getinputar: inputconnarty; override;
    function getzcount: integer; override;
    function gethandler: sighandlerprocty; override;
    procedure dotriggerchange(const Sender: TObject);
    procedure update; override;
    procedure lintoexp(var avalue: double);
    procedure exptolin(var avalue: double);
    procedure checkindex(const index: integer);
    function getsigoptions: sigclientoptionsty; override;
  public
    constructor Create(aowner: TComponent); override;
    procedure start;
    procedure stop;
    property attack_values[const index: integer]: complexarty read getattack_values write setattack_values;
    property decay_values[const index: integer]: complexarty read getdecay_values write setdecay_values;
    property release_values[const index: integer]: complexarty read getrelease_values write setrelease_values;
    property loopstart[const index: integer]: real read getloopstart write setloopstart;
    //<0 -> inactive
  published
    property master: tsigenvelope read fmaster write setmaster;
    property trigger: tchangedoubleinputconn read ftrigger write settrigger;
    //1 -> start, -1 -> stop
    property amplitude: tdoubleinputconn read famplitude write setamplitude;
    property mix: tlimitinputconn read fmix write setmix;
    property options: sigenvelopeoptionsty read foptions write setoptions default [];
    property timescale: real read ftimescale write ftimescale; //default 1s
    property subsampling: integer read fsubsampling write setsubsampling default defaultenvelopesubsampling;
    property min: real read fmin write setmin;
    property max: real read fmax write setmax;
    property eventthreshold: real read feventthreshold write feventthreshold;
    property attack_options: sigenveloperangeoptionsty read fattack_options write setattack_options default [];
    property attack_maxeventtime: real read fattack_maxeventtime write fattack_maxeventtime; //default 0
    property decay_options: sigenveloperangeoptionsty read fdecay_options write setdecay_options default [sero_exp];
    property decay_maxeventtime: real read fdecay_maxeventtime write fdecay_maxeventtime;    //default 0
    property release_options: sigenveloperangeoptionsty read frelease_options write setrelease_options default [sero_exp];
    property release_maxeventtime: real read frelease_maxeventtime write frelease_maxeventtime; //default 0
  end;

  sigcontrollerstatety  = (scs_modelvalid, scs_hastick);
  sigcontrollerstatesty = set of sigcontrollerstatety;

  tsiginfohash = class(tpointerptruinthashdatalist)
  end;

  beforestepeventty      = procedure(const Sender: tsigcontroller; var acount: integer; var handled: Boolean) of object;
  afterstepeventty       = procedure(const Sender: tsigcontroller; const acount: integer) of object;
  sigcontrolleroptionty  = (sico_freerun, sico_autorun);
  sigcontrolleroptionsty = set of sigcontrolleroptionty;

  tsigcontroller = class(tmsecomponent)
  private
    finphash: tsiginfohash;
    foutphash: tsiginfohash;
    fmutex: mutexty;
    flockcount: integer;
    flockapplocks: integer;
    fticktime: integer;
    ftickdiv: integer;
    fonbeforetick: notifyeventty;
    fonaftertick: notifyeventty;
    fonbeforestep: beforestepeventty;
    fonbeforeupdatemodel: notifyeventty;
    fonafterupdatemodel: notifyeventty;
    fonafterstep: afterstepeventty;
    fsamplefrequ: real;
    foptions: sigcontrolleroptionsty;
    fstepcount: integer;
    ftimer: tsimpletimer;
    fsampleLeft: single;
    fsampleRight: single;
    // For Wave generator
    LookupTableLeft, LookupTableRight: array [0..1023] of single;
    PosInTableLeft, PosInTableRight: double;
    VLeft, VRight: single;
    typLsine, typRsine: integer;
    freqLsine, freqRsine: single;
    dursine, posdursine: integer;
    harmonic: integer;
    evenharm: shortint;

    procedure settickdiv(const avalue: integer);
    procedure setonbeforetick(const avalue: notifyeventty);
    procedure setonaftertick(const avalue: notifyeventty);
    procedure setoptions(const avalue: sigcontrolleroptionsty);
    procedure setsamplefrequ(const avalue: real);
    function getfreerun: Boolean;
    procedure setfreerun(const avalue: Boolean);
    function getautorun: Boolean;
    procedure setautorun(const avalue: Boolean);
    procedure setstepcount(const avalue: integer);
  protected
    fstate: sigcontrollerstatesty;
    fclients: sigclientintfarty;
    fticks: proceventarty;
    finfos: siginfoarty;
    finputnodes: siginfopoarty;
    fexecinfo: sighandlernodeinfoarty;
    fexechigh: integer;
  {$ifdef mse_debugsignal}
   procedure debugnodeinfo(const atext: string; const anode: psiginfoty);
   procedure debugpointer(const atext: string; const apointer: pointer);
  {$endif}
    procedure addclient(const aintf: isigclient);
    procedure removeclient(const aintf: isigclient);
    procedure updatemodel;
    function findinplink(const dest, Source: psiginfoty): integer;
    procedure internalstep;
    procedure loaded; override;
    function findinp(const aconn: tsigconn): psiginfoty;
    function findoutp(const aconn: tsigconn): psiginfoty;
    procedure internalexecevent(const ainfopo: psiginfoty);
    procedure dispatcheventoutput(const ainfopo: psiginfoty);
    procedure execevent(const aintf: isigclient); //must be locked
    procedure checktick;
    procedure dotick;
    function getnodenamepath(const aintf: isigclient): string;
    procedure checkoptions();
    procedure stopautorun;
    procedure doidle(var again: Boolean);
    procedure doautotick(const Sender: TObject);
  public
    // TODO set as properties
    InputType: integer;
    intodd: shortint;
    SoundFilename: string;
    Channels: integer;
    initbuf: integer;
    
    procedure SetVolume(VolL, VolR: single);

    procedure FillBufferVolume(var TheBuffer: array of single);

    procedure SetWaveTable(TypeWave, Channel, AHarmonics: integer; EvenHarmonics: shortint);

    procedure SetWaveForm(TypeWaveL, TypeWaveR, AHarmonicsL, AHarmonicsR: integer; EvenHarmonicsL, EvenHarmonicsR: shortint; FreqL, FreqR, VolL, VolR: single);

    procedure WaveFillBuffer(var TheBuffer: array of single);

    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure lockapplication;  //releases controller lock, can not be nested
    //call from locked signal thread only
    procedure unlockapplication;//acquires controller lock
    procedure modelchange;
    procedure checkmodel;
    procedure step(acount: integer = 1);
    procedure Clear;
    procedure lock;
    procedure unlock;
    property freerun: Boolean read getfreerun write setfreerun;
    property autorun: Boolean read getautorun write setautorun;
  published
    property options: sigcontrolleroptionsty read foptions write setoptions default [];
    property stepcount: integer read fstepcount write setstepcount default defaultstepcount;
    property samplefrequ: real read fsamplefrequ write setsamplefrequ;
    //default 44100
    property tickdiv: integer read ftickdiv write settickdiv default defaulttickdiv;
    property onbeforetick: notifyeventty read fonbeforetick write setonbeforetick;
    property onaftertick: notifyeventty read fonaftertick write setonaftertick;
    property onbeforestep: beforestepeventty read fonbeforestep write fonbeforestep;
    property onafterstep: afterstepeventty read fonafterstep write fonafterstep;

    property onbeforeupdatemodel: notifyeventty read fonbeforeupdatemodel write fonbeforeupdatemodel; //application.locked
    property onafterupdatemodel: notifyeventty read fonafterupdatemodel write fonafterupdatemodel;    //application.locked
  end;

procedure createsigbuffer(var abuffer: doublearty; const asize: integer);
procedure createsigarray(out abuffer: doublearty; const asize: integer);
procedure setsourceconn(const Sender: tmsecomponent; const avalue: tdoubleoutputconn; var dest: tdoubleoutputconn);
procedure setsigcontroller(const linker: tobjectlinker; const intf: isigclient; const Source: tsigcontroller; var dest: tsigcontroller);
procedure initscale(const amin, amax: double; const aoptions: valuescaleoptionsty; out ainfo: doublescaleinfoty);
procedure updatescale(var ainfo: doublescaleinfoty);
function scalevalue(const ainfo: doublescaleinfoty): double;

implementation

uses
  uos_msesigaudio,
  SysUtils,
  mseformatstr,
  msesysutils,
  msesysintf1,
  mseapplication,
  msearrayutils,
  msesys,
  msebits;

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
{$endif}

type
  tmsecomponent1 = class(tmsecomponent);

procedure initscale(const amin, amax: double; const aoptions: valuescaleoptionsty; out ainfo: doublescaleinfoty);
begin
  with ainfo do
  begin
    min     := amin;
    max     := amax;
    options := aoptions;
    updatescale(ainfo);
  end;
end;

procedure updatescale(var ainfo: doublescaleinfoty);
begin
  with ainfo do
    if (vso_exp in options) and (min > 0) and (max > 0) then
    begin
      offset := ln(min);
      gain   := ln(max) - ln(min);
    end
    else
    begin
      offset := min;
      gain   := max - min;
    end;
end;

function scalevalue(const ainfo: doublescaleinfoty): double;
begin
  with ainfo do
    if (vso_null in options) and (Value <= 0) then
      Result := 0
    else
    begin
      Result := Value * gain + offset;
      if vso_exp in options then
        Result := exp(Result);
    end;
end;

procedure createsigbuffer(var abuffer: doublearty; const asize: integer);
begin
  if (length(abuffer) < asize) or
    (psizeint(PChar(Pointer(abuffer)) - 2 * sizeof(sizeint))^ > 1) then
  begin
    abuffer := nil;
    allocuninitedarray(asize, sizeof(double), abuffer);
  end
  else
    setlength(abuffer, asize);
end;

procedure createsigarray(out abuffer: doublearty; const asize: integer);
begin
  abuffer := nil;
  allocuninitedarray(asize, sizeof(double), abuffer);
end;

procedure setsourceconn(const Sender: tmsecomponent; const avalue: tdoubleoutputconn; var dest: tdoubleoutputconn);
begin
  if dest <> nil then
    if csdestroying in dest.componentstate then
      dest.fdestinations := nil
    else
      removeitem(pointerarty(dest.fdestinations), Sender);
  tmsecomponent1(Sender).setlinkedvar(avalue, tmsecomponent(dest));
  if dest <> nil then
    additem(pointerarty(dest.fdestinations), Sender);
end;

{ trealcoeff }

constructor trealcoeff.Create(const aowner: tcustomsigcomp);
begin
  fowner := aowner;
  inherited Create;
end;

procedure trealcoeff.doitemchange(const aindex: integer);
begin
  fowner.coeffchanged(self, aindex);
  inherited;
end;

{ tcomplexcoeff }

constructor tcomplexcoeff.Create(const aowner: tcustomsigcomp);
begin
  fowner := aowner;
  inherited Create;
end;

procedure tcomplexcoeff.doitemchange(const aindex: integer);
begin
  fowner.coeffchanged(self, aindex);
  inherited;
end;

{ tcustomsigcomp }

procedure tcustomsigcomp.coeffchanged(const Sender: tdatalist; const aindex: integer);
begin
  //dummy
end;

procedure tcustomsigcomp.update;
begin
  //dummy
end;

procedure tcustomsigcomp.beginupdate;
begin
  Inc(fupdating);
end;

procedure tcustomsigcomp.endupdate;
begin
  Dec(fupdating);
  if fupdating = 0 then
    update;
end;

{ tdoublconn }

constructor tdoubleconn.Create(const aowner: TComponent; const asigintf: isigclient);
begin
  fsigintf := asigintf;
  inherited Create(aowner);
  setsubcomponent(True);
end;

//{$ifndef FPC}
function tdoubleconn.getcontroller: tsigcontroller;
begin
  Result := fsigintf.getsigcontroller;
end;

procedure tdoubleconn.lock;
var
  cont1: tsigcontroller;
begin
  cont1 := fsigintf.getsigcontroller;
  if cont1 <> nil then
    cont1.lock;
end;

procedure tdoubleconn.unlock;
var
  cont1: tsigcontroller;
begin
  cont1 := fsigintf.getsigcontroller;
  if cont1 <> nil then
    cont1.unlock;
end;
 //{$endif}

 { tdoubleoutputconn }

constructor tdoubleoutputconn.Create(const aowner: TComponent; const asigintf: isigclient; const aeventdriven: Boolean);
begin
  inherited Create(aowner, asigintf);
  if aeventdriven then
    include(fstate, ocs_eventdriven);
  include(fmsecomponentstate, cs_subcompref);
  Name := 'output';
end;

function tdoubleoutputconn.geteventdriven: Boolean;
begin
  Result := ocs_eventdriven in fstate;
end;

procedure tdoubleoutputconn.seteventdriven(const avalue: Boolean);
begin
  if avalue then
    include(fstate, ocs_eventdriven)
  else
    exclude(fstate, ocs_eventdriven);
end;

{ tdoubleinputconn }

constructor tdoubleinputconn.Create(const aowner: TComponent; const asigintf: isigclient);
begin
  fgain      := 1;
  fmin       := emptyreal;
  fmax       := emptyreal;
  fexpstart  := emptyreal;
  fexpend    := emptyreal;
  fv.changed := siginchangeresetflags;
  inherited;
  Name       := 'input';
end;

destructor tdoubleinputconn.Destroy;
begin
  Source := nil;
  inherited;
end;

procedure tdoubleinputconn.setsource(const avalue: tdoubleoutputconn);
begin
  if fsource <> avalue then
  begin
    setsourceconn(self, avalue, fsource);
    fsigintf.modelchange;
  end;
end;

procedure tdoubleinputconn.setoffset(const avalue: double);
begin
  lock;
  foffset := avalue;
  unlock;
end;

procedure tdoubleinputconn.setgain(const avalue: double);
begin
  lock;
  fgain := avalue;
  unlock;
end;

procedure tdoubleinputconn.setvalue(const avalue: double);
begin
  lock;
  fv.Value := avalue;
  include(fv.changed, sic_value);
  unlock;
end;

procedure tdoubleinputconn.setmin(const avalue: realty);
begin
  lock;
  fmin := avalue;
  unlock;
end;

procedure tdoubleinputconn.setmax(const avalue: realty);
begin
  lock;
  fmax := avalue;
  unlock;
end;

procedure tdoubleinputconn.setexpstart(const avalue: realty);
begin
  lock;
  fexpstart := avalue;
  unlock;
end;

procedure tdoubleinputconn.setexpend(const avalue: realty);
begin
  lock;
  fexpend := avalue;
  unlock;
end;

{ tdoublesigcomp }

constructor tdoublesigcomp.Create(aowner: TComponent);
begin
  inherited;
end;

destructor tdoublesigcomp.Destroy;
begin
  controller := nil;
  Clear;
  inherited;
end;

procedure tdoublesigcomp.Clear;
begin
  //dummy
end;

procedure setsigcontroller(const linker: tobjectlinker; const intf: isigclient; const Source: tsigcontroller; var dest: tsigcontroller);
begin
  if dest <> nil then
    dest.removeclient(intf);
  linker.setlinkedvar(intf, Source, tmsecomponent(dest));
  if dest <> nil then
    dest.addclient(intf);
end;

procedure tdoublesigcomp.setcontroller(const avalue: tsigcontroller);
begin
  setsigcontroller(getobjectlinker, isigclient(self), avalue, fcontroller);
end;

procedure tdoublesigcomp.modelchange;
begin
  if ([csdestroying, csloading] * componentstate = []) then
    if (fcontroller <> nil) then
      if ([csdestroying, csloading] * fcontroller.componentstate = []) then
      begin
        fcontroller.lock;
        fcontroller.modelchange;
        fcontroller.unlock;
      end;
end;

function tdoublesigcomp.getinputar: inputconnarty;
begin
  Result := nil;
end;

function tdoublesigcomp.getoutputar: outputconnarty;
begin
  Result := nil;
end;

procedure tdoublesigcomp.loaded;
begin
  inherited;
  modelchange;
  update;
end;

procedure tdoublesigcomp.initmodel;
begin
  //dummy
end;

function tdoublesigcomp.getzcount: integer;
begin
  Result := 0;
end;

function tdoublesigcomp.getsigcontroller: tsigcontroller;
begin
  Result := fcontroller;
end;

procedure tdoublesigcomp.lock;
begin
  if fcontroller <> nil then
    fcontroller.lock;
end;

procedure tdoublesigcomp.unlock;
begin
  if fcontroller <> nil then
    fcontroller.unlock;
end;

function tdoublesigcomp.getsigclientinfopo: psigclientinfoty;
begin
  Result := @fsigclientinfo;
end;

procedure tdoublesigcomp.sigtick;
begin
  //dummy
end;

function tdoublesigcomp.getsigoptions: sigclientoptionsty;
begin
  Result := [];
end;

procedure tdoublesigcomp.lockapplication;
begin
  if fcontroller <> nil then
    fcontroller.lockapplication;
end;

procedure tdoublesigcomp.unlockapplication;
begin
  if fcontroller <> nil then
    fcontroller.unlockapplication;
end;

{ tdoublezcomp }

constructor tdoublezcomp.Create(aowner: TComponent);
begin
  fzhigh  := -1;
  finput  := tdoubleinputconn.Create(self, isigclient(self));
  foutput := tdoubleoutputconn.Create(self, isigclient(self), False);
  inherited;
end;

destructor tdoublezcomp.Destroy;
begin
  inherited;
end;

procedure tdoublezcomp.zcountchanged;
begin
  //dummy
end;

procedure tdoublezcomp.Clear;
begin
  inherited;
  fdoubleinputdata := nil;
  finputindex      := 0;
  fillchar(Pointer(fdoublez)^, fzcount * sizeof(double), 0);
  fzindex          := 0;
end;

procedure tdoublezcomp.setzcount(const avalue: integer);
begin
  if fzcount <> avalue then
  begin
    if avalue < 0 then
      raise Exception.Create('Invalid coeffcount.');
    Clear;
    fzcount := avalue;
    fzhigh  := avalue - 1;
    setlength(fdoublez, avalue);
    zcountchanged;
  end;
end;

procedure tdoublezcomp.setinput(const avalue: tdoubleinputconn);
begin
  finput.Assign(avalue);
end;

procedure tdoublezcomp.setoutput(const avalue: tdoubleoutputconn);
begin
  foutput.Assign(avalue);
end;

function tdoublezcomp.getinputar: inputconnarty;
begin
  setlength(Result, 1);
  Result[0] := finput;
end;

function tdoublezcomp.getoutputar: outputconnarty;
begin
  setlength(Result, 1);
  Result[0] := foutput;
end;

procedure tdoublezcomp.initmodel;
begin
  inherited;
  foutputpo := @foutput.fvalue;
end;

function tdoublezcomp.getzcount: integer;
begin
  Result := fzcount;
end;

{ tsigout }

constructor tsigout.Create(aowner: TComponent);
begin
  finput   := tdoubleinputconn.Create(self, isigclient(self));
  finputpo := @finput;
  inherited;
end;

destructor tsigout.Destroy;
begin
  inherited;
end;

procedure tsigout.setinput(const avalue: tdoubleinputconn);
begin
  finput.Assign(avalue);
end;

function tsigout.getinput: tdoubleinputconn;
begin
  Result := finput;
end;

function tsigout.getinputar: inputconnarty;
begin
  setlength(Result, 1);
  Result[0] := finput;
end;

function tsigout.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigout.sighandler(const ainfo: psighandlerinfoty);
var
  po1: psizeint;
begin
  fvalue := finputpo^.Value;
  if Assigned(fonoutput) then
    fonoutput(self, fvalue);
  if fbuffersize > 0 then
  begin
    if foutpindex = fbuffersize then
      foutpindex := 0;
    po1          := psizeint(PChar(foutp) - 2 * sizeof(sizeint));
    if po1^ > 1 then
    begin        //new buffer necessary
      Dec(po1^); //no thread safety

      getmem(po1, fbuffersize * sizeof(double) + 2 * sizeof(sizeint));
      po1^ := 1; //refcount
      Inc(po1);
   {$ifdef FPC}
      po1^ := fbuffersize - 1; //high
   {$else}
   po1^:= fbuffersize;     //count
   {$endif}
      Inc(po1);
      if foutpindex > 0 then
        move(foutp[0], po1^, foutpindex * sizeof(double));
      Pointer(foutp)  := po1;
    end;
    foutp[foutpindex] := fvalue;
    Inc(foutpindex);
    if foutpindex = fbuffersize then
      if Assigned(fonoutputburst) then
        fonoutputburst(self, realarty(foutp))//   foutpindex:= 0;
    ;
  end;
end;

procedure tsigout.sigoutput1(var adest: doublearty);
var
  po1: psizeint;
begin
  if foutpindex > 0 then
  begin
    if adest = nil then
    begin
      getmem(po1, foutpindex * sizeof(double) + 2 * sizeof(sizeint));
      po1^           := 1; //referencount;
      Inc(po1);
  {$ifdef FPC}
      po1^           := foutpindex - 1; //high
  {$else}
   po1^:= foutpindex;   //length
  {$endif}
      Inc(po1);
      Pointer(adest) := po1;
    end
    else
    begin
      po1 := psizeint(PChar(adest) - 2 * sizeof(sizeint));
      if po1^ = 1 then
      begin
   {$ifdef FPC}
        if psizeint(PChar(po1) + 1 * sizeof(sizeint))^ < foutpindex - 1 then
        begin
   {$else}
    if psizeint(pchar(po1)+1*sizeof(sizeint))^ < foutpindex then begin
   {$endif}
          freemem(po1);        //new buffer
          getmem(po1, foutpindex * sizeof(double) + 2 * sizeof(sizeint));
          po1^           := 1; //referencount;
          Inc(po1);
    {$ifdef FPC}
          po1^           := foutpindex - 1; //high
    {$else}
     po1^:= foutpindex;   //length
    {$endif}
          Inc(po1);
          Pointer(adest) := po1;
        end
        else
        begin           //reduce buffer
    {$ifdef FPC}
          if psizeint(PChar(po1) + 1 * sizeof(sizeint))^ > foutpindex - 1 then
          begin
    {$else}
     if psizeint(pchar(po1)+1*sizeof(sizeint))^ > foutpindex then begin
    {$endif}
            reallocmem(po1, foutpindex * sizeof(double) + 2 * sizeof(sizeint));
            Pointer(adest) := PChar(po1) + 2 * sizeof(sizeint);
          end;
        end;
      end
      else
      begin
        getmem(po1, foutpindex * sizeof(double) + 2 * sizeof(sizeint)); //new buffer
        po1^           := 1; //referencount;
        Inc(po1);
   {$ifdef FPC}
        po1^           := foutpindex - 1; //high
   {$else}
    po1^:= foutpindex;   //length
   {$endif}
        Inc(po1);
        Pointer(adest) := po1;
      end;
    end;
    move(foutp[0], adest[0], foutpindex * sizeof(double));
  end
  else
    adest := nil;
end;

function tsigout.sigoutput: doublearty;
begin
  sigoutput1(Result);
end;

procedure tsigout.setbuffersize(const avalue: integer);
begin
  if fbuffersize <> avalue then
  begin
    fbuffersize := avalue;
    Clear;
  end;
end;

procedure tsigout.Clear;
begin
  inherited;
  setlength(foutp, fbuffersize);
  foutpindex := 0;
end;

function tsigout.getvalue: double;
begin
  lock;
  Result := fvalue;
  unlock;
end;

{ tsigin }

constructor tsigin.Create(aowner: TComponent);
begin
  foutput := tdoubleoutputconn.Create(self, isigclient(self), False);
  inherited;
end;

destructor tsigin.Destroy;
begin
  inherited;
end;

procedure tsigin.siginput(const asource: doublearty);
var
  int1, int2, int3: integer;
  po1: psizeint;
begin
  int1   := length(finp);
  if int1 = 0 then
    finp := asource
  else
  begin
    int1 := int1 - finpindex;
    if int1 > 0 then
    begin
      setlength(finp, length(finp)); //unique reference
      move(finp[finpindex], finp[0], int1 * sizeof(double));
    end;
    finpindex := 0;
    if asource <> finp then
    begin
      int2 := length(asource);
      int3 := int1 + int2;
      po1  := psizeint(PChar(finp) - 2 * sizeof(sizeint));
      if po1^ <> 1 then
      begin
        Dec(po1^); //no thread safety
        getmem(po1, int3 * sizeof(double) + 2 * sizeof(sizeint));
        po1^ := 1;
        move(finp[0], (PChar(po1) + 2 * sizeof(sizeint))^, int1 * sizeof(double));
      end
      else if psizeint(PChar(po1) + sizeof(sizeint))^ <> int3 - 1 then
        reallocmem(po1, int3 * sizeof(double) + 2 * sizeof(sizeint));

      Inc(po1);
   {$ifdef FPC}
      po1^          := int3 - 1;   //high
   {$else}
   po1^:= int3; //length
   {$endif}
      Inc(po1);
      Pointer(finp) := po1;
      move(asource[0], finp[int1], int2 * sizeof(double));
    end;
  end;
  // foutput.setsig(asource);
end;

function tsigin.getoutputar: outputconnarty;
begin
  setlength(Result, 1);
  Result[0] := foutput;
end;

function tsigin.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigin.sighandler(const ainfo: psighandlerinfoty);
begin
  if finpindex <= high(finp) then
  begin
    fvalue := finp[finpindex];
    Inc(finpindex);
  end
  else if Assigned(foninputburst) then
  begin
    foninputburst(self, realarty(finp));
    finpindex := 0;
    if finp <> nil then
    begin
      fvalue := finp[0];
      Inc(finpindex);
    end;
  end;
  if Assigned(foninput) then
    foninput(self, real(fvalue));
  foutputpo^ := fvalue;
end;

procedure tsigin.Clear;
begin
  inherited;
  finp      := nil;
  finpindex := 0;
end;

procedure tsigin.setvalue(const avalue: double);
begin
  lock;
  fvalue := avalue;
  unlock;
end;

procedure tsigin.initmodel;
begin
  inherited;
  foutputpo := @foutput.Value;
end;

{ tsigmultiinp }

constructor tsigmultiinp.Create(aowner: TComponent);
begin
  // foutput:= tdoubleoutputconn.create(self);
  inherited;
  finputs := tdoubleinpconnarrayprop.Create(self);
end;

destructor tsigmultiinp.Destroy;
begin
  inherited;
  finputs.Free;
end;

procedure tsigmultiinp.setinputs(const avalue: tdoubleinpconnarrayprop);
begin
  finputs.Assign(avalue);
end;


function tsigmultiinp.getinputar: inputconnarty;
begin
  Result := inputconnarty(finputs.fitems);
end;

procedure tsigmultiinp.initmodel;
var
  int1: integer;
begin
  finphigh      := finputs.Count - 1;
  setlength(finps, finphigh + 1);
  for int1      := 0 to finphigh do
    finps[int1] := @tdoubleinputconn(finputs.fitems[int1]).Value;
end;

{ tsigmultiinpout }

constructor tsigmultiinpout.Create(aowner: TComponent);
begin
  foutput := tdoubleoutputconn.Create(self, isigclient(self), False);
  inherited;
end;

procedure tsigmultiinpout.setoutput(const avalue: tdoubleoutputconn);
begin
  foutput.Assign(avalue);
end;

function tsigmultiinpout.getoutputar: outputconnarty;
begin
  setlength(Result, 1);
  Result[0] := foutput;
end;

procedure tsigmultiinpout.initmodel;
begin
  inherited;
  foutputpo := @foutput.Value;
end;

{ tdoublesigoutcomp }

constructor tdoublesigoutcomp.Create(aowner: TComponent);
begin
  foutput := tdoubleoutputconn.Create(self, isigclient(self), feventdriven);
  inherited;
end;

procedure tdoublesigoutcomp.setoutput(const avalue: tdoubleoutputconn);
begin
  foutput.Assign(avalue);
end;

function tdoublesigoutcomp.getoutputar: outputconnarty;
begin
  setlength(Result, 1);
  Result[0] := foutput;
end;

procedure tdoublesigoutcomp.initmodel;
begin
  inherited;
  foutputpo := @foutput.Value;
end;

procedure tdoublesigoutcomp.seteventdriven(const avalue: Boolean);
begin
  if feventdriven <> avalue then
  begin
    feventdriven        := avalue;
    foutput.eventdriven := avalue;
    modelchange;
  end;
end;

{ tdoubleinpconnarrayprop }

constructor tdoubleinpconnarrayprop.Create(const asigintf: isigclient);
begin
  fsigintf := asigintf;
  inherited Create(nil);
end;

procedure tdoubleinpconnarrayprop.createitem(const index: integer; var item: TPersistent);
begin
  item := tdoubleinputconn.Create(nil, fsigintf);
end;

function tdoubleinpconnarrayprop.getitems(const index: integer): tdoubleinputconn;
begin
  Result := tdoubleinputconn(inherited getitems(index));
end;

procedure tdoubleinpconnarrayprop.dosizechanged;
begin
  inherited;
  fsigintf.modelchange;
end;

class function tdoubleinpconnarrayprop.getitemclasstype: persistentclassty;
begin
  Result := tdoubleinputconn;
end;

{ tdoubleoutconnarrayprop }

constructor tdoubleoutconnarrayprop.Create(const aowner: TComponent; const aname: string; const asigintf: isigclient; const aeventdriven: Boolean);
begin
  fsigintf     := asigintf;
  fowner       := aowner;
  fname        := aname;
  feventdriven := aeventdriven;
  inherited Create(nil);
end;

procedure tdoubleoutconnarrayprop.createitem(const index: integer; var item: TPersistent);
begin
  item := tdoubleoutputconn.Create(fowner, fsigintf, feventdriven);
  tdoubleoutputconn(item).Name := fname + IntToStr(index);
end;

function tdoubleoutconnarrayprop.getitems(const index: integer): tdoubleoutputconn;
begin
  Result := tdoubleoutputconn(inherited getitems(index));
end;

procedure tdoubleoutconnarrayprop.dosizechanged;
begin
  inherited;
  fsigintf.modelchange;
end;

class function tdoubleoutconnarrayprop.getitemclasstype: persistentclassty;
begin
  Result := tdoubleoutputconn;
end;

{ tsigadd }

function tsigadd.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigadd.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
  do1: double;
begin
  do1      := 0;
  for int1 := 0 to finphigh do
    do1    := do1 + finps[int1]^.Value;
  foutputpo^ := do1;
end;

{ tsigdelay }

function tsigdelay.getzcount: integer;
begin
  Result := 1;
end;

function tsigdelay.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigdelay.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
  do1: double;
begin
  foutputpo^ := fz;
  do1        := 0;
  for int1 := 0 to finphigh do
    do1 := do1 + finps[int1]^.Value;
  fz    := do1;
end;

procedure tsigdelay.Clear;
begin
  fz := 0;
end;

{ tcustomsigdelay }

constructor tcustomsigdelay.Create(aowner: TComponent);
begin
  fdelay := 1;
  inherited;
end;

procedure tcustomsigdelay.initmodel;
begin
  inherited;
  finppo := 0;
  setlength(fz, fdelay);
end;

procedure tcustomsigdelay.Clear;
begin
  inherited;
  fillchar(fz[0], sizeof(fz[0]) * length(fz), 0);
end;

function tcustomsigdelay.getzcount: integer;
begin
  Result := fdelay;
end;

function tcustomsigdelay.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tcustomsigdelay.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
  po1: pdouble;
  do1: double;
begin
  if fdelay = 0 then
  begin
    do1      := 0;
    for int1 := 0 to finphigh do
      do1    := do1 + finps[int1]^.Value;
    foutputpo^ := do1;
  end
  else
  begin
    do1      := 0;
    for int1 := 0 to finphigh do
      do1    := do1 + finps[int1]^.Value;
    po1 := @fz[finppo];
    foutputpo^ := po1^;
    po1^ := do1;
    Inc(finppo);
    if finppo = fdelay then
      finppo := 0;
  end;
end;

procedure tcustomsigdelay.setdelay(const avalue: integer);
begin
  if fdelay <> avalue then
  begin
    lock;
    modelchange;
    fdelay := avalue;
    unlock;
  end;
end;

{ tsigdelayvar }

constructor tsigdelayvar.Create(aowner: TComponent);
begin
  inherited;
  fdelayinp := tdoubleinputconn.Create(self, isigclient(self));
end;

function tsigdelayvar.getdelaymax: integer;
begin
  Result := inherited delay;
end;

procedure tsigdelayvar.setdelaymax(const avalue: integer);
begin
  inherited  delay := avalue;
end;

procedure tsigdelayvar.setdelayinp(const avalue: tdoubleinputconn);
begin
  fdelayinp.Assign(avalue);
end;

function tsigdelayvar.getinputar: inputconnarty;
begin
  Result := inherited getinputar;
  setlength(Result, high(Result) + 2);
  Result[high(Result)] := fdelayinp;
end;

function tsigdelayvar.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigdelayvar.sighandler(const ainfo: psighandlerinfoty);
var
  int1, int2: integer;
  po1: pdouble;
  do1: double;
begin
  if fdelay = 0 then
  begin
    do1      := 0;
    for int1 := 0 to finphigh do
      do1    := do1 + finps[int1]^.Value;
    foutputpo^ := do1;
  end
  else
  begin
    po1  := @fz[finppo];
    po1^ := 0;
    for int1 := 0 to finphigh do
      po1^ := po1^ + finps[int1]^.Value;
    do1    := fdelayinppo^;
    if do1 < 0 then
      do1 := 0;
    if do1 >= fdelay then
      do1 := fdelay;
    int1  := finppo - trunc(do1);
    if int1 < 0 then
      int1 := int1 + fdelay;
    if int1 = 0 then
      int2 := fdelay - 1
    else
      int2 := int1 - 1;
    do1 := frac(do1);
    foutputpo^ := fz[int1] * (1 - do1) + fz[int2] * do1;
    Inc(finppo);
    if finppo = fdelay then
      finppo := 0;
  end;
end;

procedure tsigdelayvar.initmodel;
begin
  fdelayinppo := @fdelayinp.Value;
  inherited;
end;

 { tsigdelayvar }

 { tsigmult }

function tsigmult.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigmult.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
  do1: double;
begin
  do1      := 1;
  for int1 := 0 to finphigh do
    do1    := do1 * finps[int1]^.Value;
  foutputpo^ := do1;
end;

 { tsigcontroller }

 //{$checkpointer default}
procedure tsigcontroller.internalstep;
var
  int1, int2, inc1: integer;
  po1: psighandlernodeinfoty;
begin
  po1 := Pointer(fexecinfo);
  
 //  writeln('fexechigh ' + inttostr(fexechigh));


  for int1 := 0 to fexechigh do
  begin
    po1^.handler(psighandlerinfoty(po1));
    
      if not po1^.handlerinfo.discard then
      begin
   //     writeln('dest ' + inttostr(po1^.desthigh));

      for int2 := 0 to po1^.desthigh do
        with po1^.dest[int2] do
        begin
          if inputtype = 0 then dest^ := Source^;
          
          if (inputtype = 1) or (inputtype = 2) or (inputtype = 3) then
           begin
           if int1 > 0 then  dest^ := fsampleright
           else dest^ := fsampleleft;
           end;

          if sca.hasscale then
          begin
            dest^   := dest^ * sca.gain + sca.offset;
            if sca.isexp then
              dest^ := exp(dest^);
            if sca.hasmin and (dest^ < min) then
              dest^ := min;
            if sca.hasmax and (dest^ > max) then
              dest^ := max;
          end;
        end;
     end;
    Inc(po1);
  end;
end;

procedure tsigcontroller.step(acount: integer);
var
  int1, int2: integer;
  bo1: Boolean;
begin
  if not (scs_modelvalid in fstate) then
    updatemodel;
  bo1 := False;
  if Assigned(fonbeforestep) then
    fonbeforestep(self, acount, bo1);
  if not bo1 then
  begin
    if scs_hastick in fstate then
    begin
      fticktime := fticktime + acount;
      while fticktime > 0 do
      begin
        dotick;
        Dec(fticktime, ftickdiv);
      end;
    end;
    lock;
    try

      int2 := length(fbuffer3) - 2;

      //  if intodd = 1 then intodd := 0; 
      //  writeln('length(fbuffer3) = '+ inttostr(length(fbuffer3)));
      // writeln('length(acount) = '+ inttostr(acount));

      for int1 := acount - 1 downto 0 do
      begin
        if (inputtype = 1) or (inputtype = 2) or (inputtype = 3) then

          if length(fbuffer3) > 0 then
          begin
            if channels = 1 then
              if int2 > -1 then
              begin
                fsampleleft := fbuffer3[int2];
                fsampleright := fsampleleft;
              end;  

            if channels = 2 then
              if int2 - 1 > -1 then
              begin
               // asample := ((fbuffer3[int2] + fbuffer3[int2 - 1]) / 2);
                fsampleleft := fbuffer3[int2 -1];
                fsampleright := fbuffer3[int2];
              end;  

            int2 := int2 - channels;
          end;

        internalstep;
      end;
    finally
      // inc(intodd) ;
      unlock;
    end;
    if Assigned(fonafterstep) then
      fonafterstep(self, acount);
  end;
end;


procedure tsigcontroller.SetVolume(VolL, VolR: single);
begin
  VLeft  := VolL;
  VRight := VolR;
end;

procedure tsigcontroller.FillBufferVolume(var TheBuffer: array of single);
var
  x: integer = 0;
begin
  while x < (length(TheBuffer)) do
  begin
    TheBuffer[x]   := TheBuffer[x] * VLeft;
    if TheBuffer[x] > 1 then
      TheBuffer[x] := 1;
    if TheBuffer[x] < -1 then
      TheBuffer[x] := -1;
    TheBuffer[x + 1] := TheBuffer[x+1] * VRight;
    if TheBuffer[x + 1] > 1 then
      TheBuffer[x + 1] := 1;
    if TheBuffer[x + 1] < -1 then
      TheBuffer[x + 1] := -1;
    Inc(x, 2);
  end;
end;

procedure tsigcontroller.WaveFillBuffer(var TheBuffer: array of single);
var
  x: integer;
  sf1, sf2: single;
  i: longint;
  chan: integer;
  aFreqL, aFreqR, aPosL, aPosR, aStepL, aStepR: single;
begin
  // for x := 0 to length(TheBuffer) 
  //  do TheBuffer[x] := 0;

  // chan := channels;

  aPosL := PosInTableLeft;
  aPosR := PosInTableRight;

  aFreqL := freqLsine;
  aFreqR := freqRsine;

  aStepL := (aFreqL * 1024 / 44100);
  aStepR := (aFreqR * 1024 / 44100);
  ;

  //posdursine := 
  //posdursine + length(FBuffer3) div channels;

  x := 0;

  while x <= (length(TheBuffer)) - channels do
  begin

    sf2 := 0;
    sf1 := 0;

    sf1   := VLeft * LookupTableLeft[trunc(aPosL) and (1023)];
    aPosL := aPosL + aStepL;

    if channels = 2 then
    begin
      sf2   := VRight * LookupTableRight[trunc(aPosR) and (1023)];
      aPosR := aPosR + aStepR;
    end;

    TheBuffer[x]       := sf1;
    if channels = 2 then
      TheBuffer[x + 1] := sf2;

    Inc(x, channels);
  end;

  i := trunc(aPosL / 1024);
  PosInTableLeft := aPosL - (i * 1024);
  i := trunc(aPosR / 1024);
  PosInTableRight := aPosR - (i * 1024);

end;

procedure tsigcontroller.SetWaveForm(TypeWaveL, TypeWaveR, AHarmonicsL, AHarmonicsR: integer; EvenHarmonicsL, EvenHarmonicsR: shortint; FreqL, FreqR, VolL, VolR: single);
begin
  freqLsine := FreqL;
  freqRsine := FreqR;
  VLeft     := VolL;
  VRight    := VolR;
  SetWaveTable(TypeWaveL, 1, AHarmonicsL, EvenHarmonicsL);
  SetWaveTable(TypeWaveR, 2, AHarmonicsR, EvenHarmonicsR);
end;


procedure tsigcontroller.SetWaveTable(TypeWave, Channel, AHarmonics: integer; EvenHarmonics: shortint);
var
  i, j, l: integer;
  nPI_l, attenuation: double;
  thesample: single;
begin
  l     := 1024;
  nPI_l := 2 * PI / l;

  for i := 0 to l - 1 do  // LookUpTable
  begin

    if typewave = 0 then  // sine
    begin
      thesample   := sin(i * nPI_l);
      if thesample > 1 then
        thesample := 1;
      if thesample < -1 then
        thesample := -1;

      if Channel = 1 then
        LookupTableLeft[i]  := thesample//   writeln( floattostr((LookupTableLeft[i])) + ' left ');
      ;
      if Channel = 2 then
        LookupTableRight[i] := thesample//  writeln(  'right  ' + floattostr((LookupTableRight[i])));
      ;
    end;

    if typewave = 1 then // square
    begin
      if sin(i * nPI_l) >= 0 then
        thesample := 1
      else
        thesample := -1;

      if Channel = 1 then
        LookupTableLeft[i]  := thesample;
      if Channel = 2 then
        LookupTableRight[i] := thesample;
    end;

    if typewave = 2 then // triangle
    begin
      if Channel = 1 then
      begin
        if i < (l div 2) + 1 then
          thesample := (((l - (i * 2)) / (l / 2))) - 1
        else
          thesample := LookupTableLeft[l - i];
        if thesample > 1 then
          thesample := 1;
        if thesample < -1 then
          thesample := -1;
        LookupTableLeft[i] := thesample;
        //writeln( floattostr((LookupTableLeft[i])) + ' left '); 
      end;

      if Channel = 2 then
      begin
        if i < (l div 2) + 1 then
          thesample := (((l - (i * 2)) / (l / 2))) - 1
        else
          thesample := LookupTableRight[l - i];
        if thesample > 1 then
          thesample := 1;
        if thesample < -1 then
          thesample := -1;
        LookupTableRight[i] := thesample;
        // writeln( floattostr((LookupTableright[i])) + ' right '); 
      end;
    end;

    if typewave = 3 then // Sowtooth
    begin
      if Channel = 1 then
        LookupTableLeft[i]  := ((l - i) / (l / 2)) - 1;
      if Channel = 2 then
        LookupTableRight[i] := ((l - i) / (l / 2)) - 1;
    end;
  end;

  if AHarmonics > 0 then
    for j := 1 to AHarmonics do
      if ((((j mod 2) = 1) and (EvenHarmonics = 1)) or (EvenHarmonics = 0)) then
      begin
        attenuation := power(j + 1, 4);
        nPI_l       := 2 * j * pi / l;
        for i := 0 to l - 1 do
        begin

          if typewave = 0 then
          begin
            if Channel = 1 then
              LookupTableLeft[i]  :=
                LookupTableLeft[i] + sin(i * nPI_l) / attenuation;
            if Channel = 2 then
              LookupTableRight[i] :=
                LookupTableRight[i] + sin(i * nPI_l) / attenuation;
          end;

          if typewave = 1 then
          begin
            if Channel = 1 then
              if sin(i * nPI_l) >= 0 then
                LookupTableLeft[i] :=
                  LookupTableLeft[i] + (1 / attenuation)
              else
                LookupTableLeft[i] :=
                  LookupTableLeft[i] + (-1 / attenuation);
            if Channel = 2 then
              if sin(i * nPI_l) >= 0 then
                LookupTableRight[i] :=
                  LookupTableRight[i] + (1 / attenuation)
              else
                LookupTableRight[i] :=
                  LookupTableRight[i] + (-1 / attenuation);
          end;

        end;
      end;
end;

constructor tsigcontroller.Create(aowner: TComponent);
begin
  fsamplefrequ    := defaultsamplefrequ;
  fstepcount      := defaultstepcount;
  ftickdiv        := defaulttickdiv;
  syserror(sys_mutexcreate(fmutex), self);
  finphash        := tsiginfohash.Create;
  foutphash       := tsiginfohash.Create;
  inputtype       := 0;
  initbuf         := 0;
  intodd          := 0;
  PosInTableLeft  := 0.0;
  PosInTableRight := 0.0;
  freqLsine       := 440;
  freqRsine       := 440;
  VLeft           := 0.0;
  VRight          := 0.0;
  inherited;
end;

destructor tsigcontroller.Destroy;
begin
  stopautorun();
  inherited;
  finphash.Free;
  foutphash.Free;
  sys_mutexdestroy(fmutex);
end;

procedure tsigcontroller.addclient(const aintf: isigclient);
begin
  lock;
  adduniqueitem(pointerarty(fclients), Pointer(aintf));
  modelchange;
  unlock;
end;

procedure tsigcontroller.removeclient(const aintf: isigclient);
begin
  lock;
  removeitem(pointerarty(fclients), Pointer(aintf));
  modelchange;
  unlock;
end;

procedure tsigcontroller.modelchange;
begin
  exclude(fstate, scs_modelvalid);
end;

function tsigcontroller.findinp(const aconn: tsigconn): psiginfoty;
begin
  Result := finphash.find(ptruint(aconn));
end;

function tsigcontroller.findoutp(const aconn: tsigconn): psiginfoty;
begin
  Result := foutphash.find(ptruint(aconn));
end;

 {$ifdef mse_debugsignal}
procedure tsigcontroller.debugnodeinfo(const atext: string;
                                                   const anode: psiginfoty);
var
 str1: string;
begin
 if anode = nil then begin
  str1:= '<NIL>';
 end
 else begin
  str1:= getnodenamepath(anode^.intf) +
             ' conncount: '+inttostr(anode^.connectedcount);
 end;
 debugwriteln(atext+str1);
end;

procedure tsigcontroller.debugpointer(const atext: string;
                                                   const apointer: pointer);
begin
 debugwriteln(atext+hextostr(apointer));
end;
{$endif}

function tsigcontroller.findinplink(const dest, Source: psiginfoty): integer;
var
  int1: integer;
begin
  Result   := -1;
  for int1 := 0 to high(dest^.inputs) do
    if dest^.inputs[int1].Source = Source then
    begin
      Result := int1;
      break;
    end;
end;
//{$checkpointer on}

procedure tsigcontroller.updatemodel;
{$ifdef mse_debugsignal}
var
 indent: string;
{$endif}

  procedure resetchecked;
  var
    int1, int2: integer;
  begin
    for int1 := 0 to high(finfos) do
      with finfos[int1] do
      begin
        exclude(state, sis_checked);
        for int2 := 0 to high(inputs) do
          exclude(inputs[int2].state, ins_checked);
      end;
  end; //resetchecked
var
  visited: pointerarty;

  procedure checkrecursion(const anode: psiginfoty);
  var
    int1, int2: integer;
    po1: psiginfoty;
    visitedbefore: pointerarty;
 {$ifdef mse_debugsignal}
  indentbefore: string;
 {$endif}
  begin
 {$ifdef mse_debugsignal}
  indentbefore:= indent;
  indent:= indent+' ';
  debugnodeinfo(indent+'node ',anode);
 {$endif}
    additem(visited, anode);
    visitedbefore := visited;
    with anode^ do
      for int1 := 0 to high(destinations) do
      begin
        visited := visitedbefore;
        po1     := findinp(destinations[int1].destinput);
        int2    := findinplink(po1, anode);
        if finditem(visited, po1) >= 0 then
        begin
          if zcount = 0 then
            raise Exception.Create('No Z-delay in recursion node ' +
              getnodenamepath(intf) +
              ' -> ' + getnodenamepath(po1^.intf) + '.')
          else
          begin
            include(po1^.inputs[int2].state, ins_recursive);
            Dec(po1^.connectedcount);
          end;
        end
        else
        begin
          include(po1^.inputs[int2].state, ins_checked);
          checkrecursion(po1);
        end;
      end;
    visited := visitedbefore;
 {$ifdef mse_debugsignal}
  indent:= indentbefore;
 {$endif}
  end; //checkrecursion
var
  execorder: siginfopoarty;
  execindex: integer;

  procedure processcalcorder(const anode: psiginfoty);
  var
    int1: integer;
    po1: psiginfoty;
 {$ifdef mse_debugsignal}
  indentbefore: string;
 {$endif}
  begin
 {$ifdef mse_debugsignal}
  indentbefore:= indent;
  indent:= indent+' ';
  debugnodeinfo(inttostr(execindex)+indent+'calcnode ',anode);
 {$endif}
    if execindex > high(execorder) then
      internalerror('SIG20100916-0');
    execorder[execindex] := anode;
    Inc(execindex);
    with anode^ do
    begin
      state    := state + [sis_checked, sis_sighandler];
      for int1 := 0 to high(Next) do
      begin
        po1    := Next[int1];
   {$ifdef mse_debugsignal}
    debugnodeinfo(indent+' dest '+booltostr(sis_checked in po1^.state)+' ',po1);
   {$endif}
        if not (sis_checked in po1^.state) then
          if not (ins_recursive in po1^.inputs[findinplink(po1, anode)].state) then
          begin
            Dec(po1^.connectedcount);
            if po1^.connectedcount <= 0 then
              processcalcorder(po1);
          end;
      end;
    end;
 {$ifdef mse_debugsignal}
  indent:= indentbefore;
 {$endif}
  end; //processcalcorder()

  procedure updatesca(const ainput: tdoubleinputconn; var sca: inpscaleinfoty);
  var
    a, b: double;
  begin
    sca.offset := ainput.offset;
    sca.gain   := ainput.gain;
    sca.hasmin := not (ainput.min = emptyreal);
    sca.hasmax := not (ainput.max = emptyreal);
    sca.isexp  := (ainput.expstart > 0) and (ainput.expend > 0) and
      (ainput.expend > ainput.expstart);
    if sca.isexp then
    begin
      b          := ln(ainput.expstart);
      a          := ln(ainput.expend) - b;
      sca.offset := b + a * sca.offset;
      sca.gain   := a * sca.gain;
    end;
    sca.hasscale := sca.hasmin or sca.hasmax or sca.isexp or
      (sca.offset <> 0) or (sca.gain <> 1);
  end; //updatesca()

  procedure initinput(const ainput: tdoubleinputconn);
  begin
    with ainput do
    begin
      updatesca(ainput, fsca);
      fv.changed := [sic_value];
    end;
  end; //initinput()

  procedure updatedestinfo(const ainput: tdoubleinputconn; const asource: pdouble; var ainfo: destinfoty);
  begin
    with ainfo do
    begin
      Source := asource;
      dest   := @ainput.fv.Value;
      min    := ainput.min;
      max    := ainput.max;
      sca    := ainput.fsca;
       //   updatesca(ainput,sca);
    end;
  end; //updatedestinfo

  function isopeninput(const ainputs: inputinfoarty): Boolean;
  var
    int1: integer;
  begin
    Result   := True;
    for int1 := 0 to high(ainputs) do
      with ainputs[int1] do
        if (Source <> nil) then
        begin
          Result := False;
          break;
        end;
  end;

  procedure touchnode(const anode: psiginfoty);
  var
    int1: integer;
  begin
    with anode^ do
    begin
      include(state, sis_touched);
      for int1 := 0 to high(Next) do
        if not (sis_touched in Next[int1]^.state) then
          touchnode(Next[int1]);
    end;
  end;

  function isopenoutput(const aoutputs: outputconnarty): Boolean;
  var
    int1: integer;
  begin
    Result   := True;
    for int1 := 0 to high(aoutputs) do
      with aoutputs[int1] do
        if not (ocs_eventdriven in fstate) and (fdestinations <> nil) then
        begin
          Result := False;
          break;
        end;
  end;

var
  int1, int2, int3, int4: integer;
  po1, po2: psiginfoty;
  inputnodecount: integer;
  notconnectedcount: integer;
  ar3: inputconnarty;
begin
  if Assigned(fonbeforeupdatemodel) then
  begin
    application.lock;
    try
      fonbeforeupdatemodel(self);
    finally
      application.unlock;
    end;
  end;
  finfos         := nil;
  finphash.Clear;
  foutphash.Clear;
  fticks         := nil;
  finputnodes    := nil;
  fexecinfo      := nil;
  inputnodecount := 0;
  notconnectedcount := 0;
  setlength(finfos, length(fclients));
{$ifdef mse_debugsignal}
 debugwriteln('**updatemodel '+name);
 debugwriteln('*get info');
{$endif}

  for int1 := 0 to high(fclients) do
  begin //get basic info
    po1          := @finfos[int1];
    po1^.options := fclients[int1].getsigoptions;
    if sco_tick in po1^.options then
    begin
      setlength(fticks, high(fticks) + 2);
  {$ifdef FPC}
      fticks[high(fticks)] := @fclients[int1].sigtick;
  {$else}
   fticks[high(fticks)]:= nil;//fclients[int1].sigtick; //todo:!!!
  {$endif}
    end;
    fclients[int1].getsigclientinfopo^.infopo := po1;
    with po1^ do
    begin
      intf    := fclients[int1];
      handler := intf.gethandler;
      intf.initmodel;
      intf.Clear;
      zcount  := intf.getzcount;
  {$ifdef mse_debugsignal}
   debugwriteln('client '+getnodenamepath(intf));
  {$endif}
      ar3     := fclients[int1].getinputar;
      setlength(inputs, length(ar3));
      for int2 := 0 to high(ar3) do
        inputs[int2].input := ar3[int2];
      outputs      := fclients[int1].getoutputar;
      destinations := nil;
      for int2 := 0 to high(inputs) do
      begin
  {$ifdef mse_debugsignal}
    debugpointer(' inp ',inputs[int2].input);
  {$endif}
        finphash.add(ptruint(inputs[int2].input), po1);
        initinput(inputs[int2].input);
      end;
      for int2 := 0 to high(outputs) do
      begin
  {$ifdef mse_debugsignal}
    debugpointer(' outp ',outputs[int2]);
  {$endif}
        foutphash.add(ptruint(outputs[int2]), po1);
        with outputs[int2] do
        begin
          if ocs_eventdriven in fstate then
            include(po1^.state, sis_eventoutput);
          int3     := length(po1^.destinations);
          setlength(po1^.destinations, int3 + length(fdestinations));
          for int4 := 0 to high(fdestinations) do
            with po1^.destinations[int3 + int4] do
            begin
              outputindex := int2;
              destinput   := fdestinations[int4];
            end;
   {$ifdef mse_debugsignal}
     for int3:= 0 to high(fdestinations) do begin
      debugpointer('  dest ',fdestinations[int3]);
     end;
   {$endif}
        end;
      end;
    end;
  end;

{$ifdef mse_debugsignal}
  debugwriteln('*link items');
{$endif}
  for int1 := 0 to high(fclients) do
  begin //link the items
    po1 := @finfos[int1];
    with po1^ do
      if not (sis_checked in state) then
      begin
   {$ifdef mse_debugsignal}
    debugnodeinfo('node ',po1);
   {$endif}
        include(state, sis_checked);
        for int2 := 0 to high(outputs) do
          with outputs[int2] do
            for int3 := 0 to high(fdestinations) do
            begin
      {$ifdef mse_debugsignal}
       debugpointer('lookup inp ',fdestinations[int3]);
      {$endif}
              po2 := findinp(fdestinations[int3]);
      {$ifdef mse_debugsignal}
       debugnodeinfo(' ',po2);
      {$endif}
              if po2 = nil then
                raise Exception.Create(
                  'Destination not found. Controller: ' + self.Name + ', Node: ' +
                  getnodenamepath(fclients[int1]) +
                  ', Dest: ' + fdestinations[int3].fsigintf.getcomponent.Name + '.');
              if not (ocs_eventdriven in fstate) then
              begin
                if finditem(pointerarty(po2^.prev), po1) < 0 then
                begin
                  Inc(po2^.connectedcount);
        {$ifdef mse_debugsignal}
         debugnodeinfo(' new link ',po2);
        {$endif}
                  additem(pointerarty(po2^.prev), po1);
                  additem(pointerarty(po1^.Next), po2);
                end;
                for int4 := 0 to high(po2^.inputs) do
                  if po2^.inputs[int4].input = fdestinations[int3] then
                  begin
                    with po2^.inputs[int4] do
                    begin
                      Source := po1;
                      include(input.fv.changed, sic_stream);
                    end;
                    break;
                  end;
              end;
            end;
      end;
  end;

{$ifdef mse_debugsignal}
 debugwriteln('*check input/output');
{$endif}
  for int1 := 0 to high(fclients) do
  begin
    po1 := @finfos[int1];
    with po1^ do
    begin
      //   state:= [];
      if not isopenoutput(outputs) then
        include(state, sis_output)
      else
{$ifdef mse_debugsignal}
{$endif}
      ;
      if not isopeninput(inputs) then
        include(state, sis_input)
      else if sis_output in state then
      begin
        additem(pointerarty(finputnodes), po1, inputnodecount);
        touchnode(po1);
    {$ifdef mse_debugsignal}
     debugnodeinfo(' input node ',po1);
    {$endif}
      end
      else
        Inc(notconnectedcount)
{$ifdef mse_debugsignal}
{$endif}
      ;
    end;
  end;

{$ifdef mse_debugsignal}
 debugwriteln('*check event connections');
{$endif}
  for int1 := 0 to high(finfos) do
    with finfos[int1] do
      if not (sis_eventchecked in state) then
        for int2 := 0 to high(outputs) do
          with outputs[int2] do
            for int3 := 0 to high(fdestinations) do
            begin
              po2 := findinp(fdestinations[int3]);
              if not (sis_input in po2^.state) then
              begin
       {$ifdef mse_debugsignal}
        debugnodeinfo('event source ',@finfos[int1]);
        debugpointer(' lookup inp ',fdestinations[int3]);
        debugnodeinfo('  event ',po2);
       {$endif}
                if sis_eventchecked in po2^.state then
                  raise Exception.Create(
                    'Recursive event connection: ' + self.Name + ', Node: ' +
                    getnodenamepath(finfos[int1].intf) +
                    ', Dest: ' + getnodenamepath(po2^.intf) + '.');
                adduniqueitem(pointerarty(eventdestinations), po2);
                include(po2^.state, sis_eventinput);
                include(state, sis_eventchecked);
              end;
            end;

{$ifdef mse_debugsignal}
 debugwriteln('*check recursive without inputs');
{$endif}
  for int1 := 0 to high(fclients) do
  begin
    po1 := @finfos[int1];
    with po1^ do
      if state * [sis_input, sis_output, sis_touched, sis_eventchecked] = [sis_output] then
      begin
        additem(pointerarty(finputnodes), po1, inputnodecount);
   {$ifdef mse_debugsignal}
    debugnodeinfo(' recursive circle start ',po1);
   {$endif}
        touchnode(po1);
      end
      else if (state * [sis_input, sis_output, sis_touched] = []) and
        (sco_fulltick in options) then
      begin
        include(state, sis_fulltick);
        additem(pointerarty(finputnodes), po1, inputnodecount);
        Dec(notconnectedcount);
    {$ifdef mse_debugsignal}
     debugnodeinfo(' fulltick ',po1);
    {$endif}
        touchnode(po1);
      end;
  end;

  setlength(finputnodes, inputnodecount);

{$ifdef mse_debugsignal}
  debugwriteln('*check recursion');
{$endif}

  for int1 := 0 to high(finputnodes) do
    if not (sis_fulltick in finputnodes[int1]^.state) then
    begin
      visited := nil;
      checkrecursion(finputnodes[int1]);
    end//check recursion
{$ifdef mse_debugsignal}
{$endif}
  ;

{$ifdef mse_debugsignal}
 debugwriteln('*processcalcorder');
{$endif}
  setlength(execorder, length(finfos));
  execindex := 0;
  // resetchecked;
  for int1  := 0 to high(finputnodes) do
  begin
 {$ifdef mse_debugsignal}
  debugnodeinfo('input ',finputnodes[int1]);
 {$endif}
    resetchecked;
    processcalcorder(finputnodes[int1]);
  end;

{$ifdef mse_debugsignal}
 debugwriteln('*execorder '+inttostr(length(execorder))+' '+inttostr(execindex));
 for int1:= 0 to high(execorder) do begin
  debugnodeinfo(' ',execorder[int1]);
 end;
 for int1:= 0 to high(finfos) do begin
  po1:= @finfos[int1];
  with po1^ do begin
   if connectedcount <> 0 then begin
    debugnodeinfo('! '+inttostr(connectedcount)+ ' ',po1);
   end;
  end;
 end;
{$endif}
  if execindex + notconnectedcount <> length(execorder) then
    internalerror('SIG20100916-2')//unprocessed nodes
  ;
  setlength(fexecinfo, execindex);
  fexechigh := execindex - 1;
  for int1  := 0 to high(fexecinfo) do
  begin
    po1     := execorder[int1];
    with fexecinfo[int1] do
    begin
      handler  := po1^.handler;
      desthigh := high(po1^.destinations);
      //   handlerinfo.dest:= @fvaluedummy;
      if length(po1^.destinations) > 0 then
      begin
        setlength(dest, desthigh + 1);
        for int2 := 0 to desthigh do
        begin
          int3 := po1^.destinations[int2].outputindex;
          updatedestinfo(po1^.destinations[int2].destinput, @po1^.outputs[int3].fvalue, dest[int2]);
        end;
      end;

    end;
  end;
  include(fstate, scs_modelvalid);
  Clear;
  checktick;
{$ifdef mse_debugsignal}
 debugwriteln('*execute event start nodes');
{$endif}
  po1      := Pointer(finfos);
  for int1 := 0 to high(finfos) do
  begin
    if (po1^.state * [sis_eventoutput, sis_eventinput] = [sis_eventoutput]) and not (sco_fulltick in po1^.options) then
      internalexecevent(po1)
{$ifdef mse_debugsignal}
{$endif}
    ;
    Inc(po1);
  end;
  if Assigned(fonafterupdatemodel) then
  begin
    application.lock;
    try
      fonafterupdatemodel(self);
    finally
      application.unlock;
    end;
  end;
end;

procedure tsigcontroller.checkmodel;
begin
  if not (scs_modelvalid in fstate) then
    updatemodel;
end;

procedure tsigcontroller.loaded;
begin
  inherited;
  modelchange();
  checkoptions();
end;

procedure tsigcontroller.Clear;
var
  int1: integer;
begin
  for int1 := 0 to high(fclients) do
    fclients[int1].Clear;
end;

procedure tsigcontroller.lock;
begin
  sys_mutexlock(fmutex);
  Inc(flockcount);
end;

procedure tsigcontroller.unlock;
begin
  Dec(flockcount);
  sys_mutexunlock(fmutex);
end;

procedure tsigcontroller.internalexecevent(const ainfopo: psiginfoty);
var
  handlerinfo: sighandlerinfoty;
  int1: integer;
begin
  with ainfopo^ do
    if not (sis_sighandler in state) then
    begin
      handler(@handlerinfo);
      for int1 := 0 to high(destinations) do
        with destinations[int1] do
          with destinput do
          begin
            include(fv.changed, sic_value);
            fv.Value   := outputs[outputindex].fvalue * fsca.gain + fsca.offset;
            if fsca.isexp then
              fv.Value := exp(fv.Value);
            if fsca.hasmin and (fv.Value < min) then
              fv.Value := min;
            if fsca.hasmax and (fv.Value > max) then
              fv.Value := max;
          end;
      for int1 := 0 to high(eventdestinations) do
        internalexecevent(eventdestinations[int1]);
    end;
end;

procedure tsigcontroller.dispatcheventoutput(const ainfopo: psiginfoty);
var
  int1: integer;
begin
  with ainfopo^ do
  begin
    for int1 := 0 to high(destinations) do
      with destinations[int1] do
        with destinput do
        begin
          include(fv.changed, sic_value);
          fv.Value   := outputs[outputindex].fvalue * fsca.gain + fsca.offset;
          if fsca.isexp then
            fv.Value := exp(fv.Value);
          if fsca.hasmin and (fv.Value < min) then
            fv.Value := min;
          if fsca.hasmax and (fv.Value > max) then
            fv.Value := max;
        end;
    for int1 := 0 to high(eventdestinations) do
      internalexecevent(eventdestinations[int1]);
  end;
end;

procedure tsigcontroller.execevent(const aintf: isigclient);
begin
  checkmodel;
  internalexecevent(aintf.getsigclientinfopo^.infopo);
end;

procedure tsigcontroller.settickdiv(const avalue: integer);
begin
  ftickdiv   := avalue;
  if ftickdiv <= 0 then
    ftickdiv := 0;
end;

procedure tsigcontroller.checktick;
begin
  if (fticks <> nil) or Assigned(fonbeforetick) or Assigned(fonaftertick) then
    include(fstate, scs_hastick)
  else
    exclude(fstate, scs_hastick);
end;

procedure tsigcontroller.dotick;
var
  int1: integer;
begin
  if Assigned(fonbeforetick) then
    fonbeforetick(self);
  for int1 := high(fticks) downto 0 do
    fticks[int1];
  if Assigned(fonaftertick) then
    fonaftertick(self);
end;

procedure tsigcontroller.setonbeforetick(const avalue: notifyeventty);
begin
  fonbeforetick := avalue;
  checktick;
end;

procedure tsigcontroller.setonaftertick(const avalue: notifyeventty);
begin
  fonaftertick := avalue;
  checktick;
end;

procedure tsigcontroller.lockapplication;
var
  int1: integer;
begin
  flockapplocks := flockcount;
  for int1      := flockcount - 1 downto 0 do
    unlock;
  application.lock;
end;

procedure tsigcontroller.unlockapplication;
var
  int1: integer;
begin
  application.unlock;
  for int1 := flockapplocks - 1 downto 0 do
    lock;
end;

function tsigcontroller.getnodenamepath(const aintf: isigclient): string;
begin
  Result := ownernamepath(aintf.getcomponent);
end;

procedure tsigcontroller.setoptions(const avalue: sigcontrolleroptionsty);
begin
  if foptions <> avalue then
  begin
    foptions := sigcontrolleroptionsty(setsinglebit(longword(avalue),
      longword(foptions), longword([sico_freerun, sico_autorun])));
    if not (csloading in componentstate) then
      checkoptions();
  end;
end;

procedure tsigcontroller.setsamplefrequ(const avalue: real);
begin
  if fsamplefrequ <> avalue then
    fsamplefrequ := avalue;
end;

procedure tsigcontroller.checkoptions;
begin
  stopautorun();
  if not (csdesigning in componentstate) then
    if (fstepcount > 0) and (fsamplefrequ > 0) then
      if sico_freerun in foptions then
        application.registeronidle(@doidle)
      else if sico_autorun in foptions then
        ftimer := tsimpletimer.Create(round(1000000.0 * fstepcount / fsamplefrequ), @doautotick, True, [to_leak]);
end;

function tsigcontroller.getfreerun: Boolean;
begin
  Result := sico_freerun in options;
end;

procedure tsigcontroller.setfreerun(const avalue: Boolean);
begin
  if avalue then
    options := options + [sico_freerun]
  else
    options := options - [sico_freerun];
end;

procedure tsigcontroller.stopautorun;
begin
  application.unregisteronidle(@doidle);
  FreeAndNil(ftimer);
end;

function tsigcontroller.getautorun: Boolean;
begin
  Result := sico_autorun in options;
end;

procedure tsigcontroller.setautorun(const avalue: Boolean);
begin
  if avalue then
    options := options + [sico_autorun]
  else
    options := options - [sico_autorun];
end;

procedure tsigcontroller.setstepcount(const avalue: integer);
begin
  if fstepcount <> avalue then
  begin
    fstepcount := avalue;
    if not (csloading in componentstate) then
      checkoptions();
  end;
end;

procedure tsigcontroller.doautotick(const Sender: TObject);
begin
  step(fstepcount);
end;

procedure tsigcontroller.doidle(var again: Boolean);
begin
  step(fstepcount);
  again := True;
end;

{ tsigwavetable }

constructor tsigwavetable.Create(aowner: TComponent);
begin
  inherited;
  ffrequency      := tdoubleinputconn.Create(self, isigclient(self));
  ffrequency.Name := 'frequency';
  ffrequency.fv.Value := 0.01;
  ffrequfact      := tdoubleinputconn.Create(self, isigclient(self));
  ffrequfact.Name := 'frequfact';
  ffrequfact.fv.Value := 1;
  fphase          := tdoubleinputconn.Create(self, isigclient(self));
  fphase.Name     := 'phase';
  famplitude      := tdoubleinputconn.Create(self, isigclient(self));
  famplitude.Name := 'amplitude';
  famplitude.fv.Value := 1;
end;

procedure tsigwavetable.setfrequency(const avalue: tdoubleinputconn);
begin
  ffrequency.Assign(avalue);
end;

procedure tsigwavetable.setfrequfact(const avalue: tdoubleinputconn);
begin
  ffrequfact.Assign(avalue);
end;

procedure tsigwavetable.setphase(const avalue: tdoubleinputconn);
begin
  fphase.Assign(avalue);
end;

procedure tsigwavetable.setamplitude(const avalue: tdoubleinputconn);
begin
  famplitude.Assign(avalue);
end;

function tsigwavetable.gethandler: sighandlerprocty;
begin
  if siwto_intpol in foptions then
    Result :=
{$ifdef FPC}
      @
{$endif}
      sighandlerintpol
  else
    Result :=
{$ifdef FPC}
      @
{$endif}
      sighandler;
end;

procedure tsigwavetable.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
begin
  int1   := trunc((ftime + fphasepo^.Value) * ftablelength) mod ftablelength;
  if int1 < 0 then
    int1 := int1 + ftablelength;
  foutputpo^ := ftable[int1] * famplitudepo^.Value;
  ftime := frac(ftime + ffrequencypo^.Value * ffrequfactpo^.Value);
end;

procedure tsigwavetable.sighandlerintpol(const ainfo: psighandlerinfoty);
var
  int1: integer;
  do1: double;
begin
  do1  := (ftime + fphasepo^.Value) * ftablelength;
  int1 := trunc(do1) mod ftablelength;
  if int1 < 0 then
    int1 := int1 + ftablelength;
  foutputpo^ := (ftable[int1] +
    (ftable[(int1 + 1) mod ftablelength] - ftable[int1]) *
    ((do1 - int1) / ftablelength)
    ) * famplitudepo^.Value;
  ftime      := frac(ftime + ffrequencypo^.Value * ffrequfactpo^.Value);
end;


procedure tsigwavetable.settable(const avalue: doublearty);
begin
  ftable := avalue;
  checktable;
end;

procedure tsigwavetable.Clear;
begin
  inherited;
  lock;
  try
    if canevent(tmethod(foninittable)) then
      foninittable(self, realarty(ftable));
    checktable;
  finally
    unlock;
  end;
end;

procedure tsigwavetable.checktable;
begin
  lock;
  try
    ftime := 0;
    if ftable = nil then
      setlength(ftable, 1);
    ftablelength := length(ftable);
    sendchangeevent;
  finally
    unlock;
  end;
end;

procedure tsigwavetable.initmodel;
begin
  ffrequencypo := @ffrequency.fv;
  ffrequfactpo := @ffrequfact.fv;
  fphasepo     := @fphase.fv;
  famplitudepo := @famplitude.fv;
  inherited;
end;

function tsigwavetable.getinputar: inputconnarty;
begin
  setlength(Result, 4);
  Result[0] := ffrequency;
  Result[1] := ffrequfact;
  Result[2] := fphase;
  Result[3] := famplitude;
end;

function tsigwavetable.getzcount: integer;
begin
  Result := 1;
end;

procedure tsigwavetable.setoptions(const avalue: sigwavetableoptionsty);
begin
  if avalue <> foptions then
  begin
    foptions := avalue;
    if fcontroller <> nil then
      fcontroller.modelchange;
  end;
end;

procedure tsigwavetable.setmaster(const avalue: tsigwavetable);
var
  tab1: tsigwavetable;
begin
  if avalue <> fmaster then
  begin
    tab1 := avalue;
    while tab1 <> nil do
    begin
      if tab1 = self then
        raise Exception.Create('Recursive master.');
      tab1 := tab1.master;
    end;
    setlinkedvar(tmsecomponent(avalue), tmsecomponent(fmaster));
    if avalue <> nil then
      table := avalue.table;
  end;
end;

procedure tsigwavetable.objectevent(const Sender: TObject; const event: objecteventty);
begin
  if (event = oe_changed) and (Sender <> nil) and (Sender = master) then
    table := master.table;
end;

{ tsigfuncttable }

constructor tsigfuncttable.Create(aowner: TComponent);
begin
  inherited;
  famplitude      := tdoubleinputconn.Create(self, isigclient(self));
  famplitude.Name := 'amplitude';
  famplitudepo    := @famplitude.fv;
end;

procedure tsigfuncttable.setamplitude(const avalue: tdoubleinputconn);
begin
  famplitude.Assign(avalue);
end;

function tsigfuncttable.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigfuncttable.initmodel;
begin
  inherited;
end;

function tsigfuncttable.getinputar: inputconnarty;
begin
  setlength(Result, 1);
  Result[0] := famplitude;
  stackarray(pointerarty(inherited getinputar), pointerarty(Result));
end;

function tsigfuncttable.getzcount: integer;
begin
  Result := 1;
end;

procedure tsigfuncttable.Clear;
begin
  inherited;
  lock;
  try
    if canevent(tmethod(foninittable)) then
      foninittable(self, ftable);
    checktable;
  finally
    unlock;
  end;
end;

procedure tsigfuncttable.settable(const avalue: complexarty);
begin
  ftable := avalue;
  checktable;
end;

procedure tsigfuncttable.sighandler(const ainfo: psighandlerinfoty);
var
  int1, int2: integer;
  do1: double;
begin
  do1      := 0;
  for int1 := 0 to finphigh do
    do1    := do1 + finps[int1]^.Value;
  if do1 <= finpmin then
  begin
    with fsegments[0].defaultnode do
      foutputpo^ := (offs + do1 * ramp) * famplitudepo^.Value;
    Exit;
  end
  else if do1 >= finpmax then
  begin
    with fsegments[functionsegmentcount - 1] do
      if nodes <> nil then
        with nodes[high(nodes)] do
          foutputpo^ := (offs + do1 * ramp) * famplitudepo^.Value
      else
        with defaultnode do
          foutputpo^ := (offs + do1 * ramp) * famplitudepo^.Value;
    Exit;
  end
  else
    int1 := trunc((do1 - finpmin) * finpfact);
  with fsegments[int1] do
    if do1 <= defaultnode.xend then
      with defaultnode do
        foutputpo^ := (offs + do1 * ramp) * famplitudepo^.Value
    else
      for int2     := 0 to high(nodes) do
        with nodes[int2] do
          if do1 <= xend then
          begin
            foutputpo^ := (offs + do1 * ramp) * famplitudepo^.Value;
            break;
          end;
end;

procedure tsigfuncttable.checktable;

  procedure calc(const index: integer; out node: functionnodety);
  var
    den1: double;
  begin
    if index = high(ftable) then
    begin
      if index = 0 then
        den1 := 0
      else
      begin
        den1 := ftable[index].re - ftable[index - 1].re;
      end;
    end
    else
      den1 := ftable[index + 1].re - ftable[index].re;
    with node do
    begin
      if index >= high(ftable) then
        xend := bigreal
      else
        xend := ftable[index + 1].re;
      if den1 = 0 then
      begin
        offs := ftable[index].im;
        ramp := 0;
      end
      else
      begin
        if index = high(ftable) then
          ramp := (ftable[index].im - ftable[index - 1].im) / den1
        else
          ramp := (ftable[index + 1].im - ftable[index].im) / den1;
        offs := ftable[index].im - ftable[index].re * ramp;
      end;
    end;
  end;

var
  int1, int2: integer;
  ar1: booleanarty;
  po1: pfunctionsegmentty;
begin
  lock;
  try
    finalize(fsegments);
    fillchar(fsegments, sizeof(fsegments), 0);
    finpmin  := 0;
    finpmax  := 0;
    finpfact := 0;
    if high(ftable) >= 0 then
    begin
      finpmin := bigreal;
      finpmax := -bigreal;
      for int1 := 0 to high(ftable) do
        with ftable[int1] do
        begin
          if (int1 > 0) and (re < ftable[int1 - 1].re) then
            raise Exception.Create('Invalid table order');
          if re < finpmin then
            finpmin := re;
          if re > finpmax then
            finpmax := re;
        end;
      finpfact := finpmax - finpmin;
      if finpfact > 0 then
        finpfact := functionsegmentcount / finpfact
      else
        finpfact := 0;
      setlength(ar1, functionsegmentcount);
      for int1   := 0 to high(ftable) do
      begin
        int2     := trunc((ftable[int1].re - finpmin) * finpfact);
        if int2 >= functionsegmentcount then
          int2 := functionsegmentcount - 1;
        if int2 < 0 then
          int2 := 0;
        with fsegments[int2] do
        begin
          if ar1[int2] or (int2 > 0) then
          begin //multiple nodes
            setlength(nodes, high(nodes) + 2);
            calc(int1, nodes[high(nodes)]);
          end
          else
            calc(int1, defaultnode);
          ar1[int2] := True;
        end;
      end;
      po1      := @fsegments[0];
      for int1 := 1 to high(fsegments) do
      begin
        if po1^.nodes = nil then
          fsegments[int1].defaultnode := po1^.defaultnode
        else
          fsegments[int1].defaultnode := po1^.nodes[high(po1^.nodes)];
        Inc(po1);
      end;
    end;
    sendchangeevent;
  finally
    unlock;
  end;
end;

procedure tsigfuncttable.setmaster(const avalue: tsigfuncttable);
var
  tab1: tsigfuncttable;
begin
  if avalue <> fmaster then
  begin
    tab1 := avalue;
    while tab1 <> nil do
    begin
      if tab1 = self then
        raise Exception.Create('Recursive master.');
      tab1 := tab1.master;
    end;
    setlinkedvar(tmsecomponent(avalue), tmsecomponent(fmaster));
    if avalue <> nil then
      table := avalue.table;
  end;
end;

procedure tsigfuncttable.objectevent(const Sender: TObject; const event: objecteventty);
begin
  if (event = oe_changed) and (Sender <> nil) and (Sender = master) then
    table := master.table;
end;

{ tsigenvelope }

constructor tsigenvelope.Create(aowner: TComponent);

  procedure initinfo(var ainfo: envelopeinfoty);
  begin
    with ainfo do
    begin
      freleasestart := 1;
      ftimescale    := 1;
      floopstart    := -1;
    end;
  end; //initinfo()
begin
  fsubsampling   := defaultenvelopesubsampling;
  fmin           := 0.001;
  fmax           := 1;
  feventthreshold := 0.1;
  initinfo(finfos[0]);
  initinfo(finfos[1]);
  fdecay_options := [sero_exp];
  frelease_options := [sero_exp];
  inherited;
  ftrigger       := tchangedoubleinputconn.Create(self, isigclient(self),
                                        {$ifdef fpc}
    @
{$endif}
    dotriggerchange);
  ftrigger.Name  := 'trigger';
  famplitude     := tdoubleinputconn.Create(self, isigclient(self));
  famplitude.Name := 'amplitude';
  famplitude.Value := 1;
  fmix           := tlimitinputconn.Create(self, isigclient(self));
  fmix.Name      := 'mix';
end;

procedure tsigenvelope.lintoexp(var avalue: double);
var
  scale, offset: double;
  do1: double;
begin
  if (fmin > 0) and (fmax > 0) then
  begin
    offset := ln(fmin);
    scale  := ln(fmax) - offset;
    if scale <> 0 then
    begin
      do1      := avalue * (fmax - fmin) + fmin;
      if do1 > 0 then
        avalue := (ln(do1) - offset) / scale;
    end;
  end;
end;

procedure tsigenvelope.exptolin(var avalue: double);
var
  scale, offset: double;
  do1: double;
begin
  if (fmin > 0) and (fmax > 0) then
  begin
    offset := ln(fmin);
    scale  := ln(fmax) - offset;
    do1    := fmax - fmin;
    if do1 <> 0 then
      avalue := (exp(avalue * scale + offset) - fmin) / do1;
  end;
end;

procedure tsigenvelope.updatevalues(var ainfo: envelopeinfoty);
var
  timsca: double;
  timoffs: double;
  eventtimescale: real;
  isexpbefore: Boolean;
  isexpbeforeset: Boolean;

  procedure setscale(const options: sigenveloperangeoptionsty; const progindex: integer; var sta: double);
  begin
    with ainfo.fprog[progindex] do
    begin
      isexp := sero_exp in options;
      if isexp then
      begin
        if (fmin > 0) and (fmax > 0) then
        begin
          offset := ln(fmin);
          scale  := ln(fmax) - offset;
        end
        else
        begin
          scale  := 1; //invalid
          offset := 0;
        end;
        if isexpbeforeset and not isexpbefore then
          lintoexp(sta);
      end
      else
      begin
        offset := fmin;
        scale  := fmax - fmin;
        if isexpbeforeset and isexpbefore then
          exptolin(sta);
      end;
      isexpbefore    := isexp;
      isexpbeforeset := True;
    end;
  end; //setscale

  procedure setend(const options: sigenveloperangeoptionsty; var progindex: integer; var ti: integer; var sta: double);
  begin
    setscale(options, progindex, double(sta));
    with ainfo.fprog[progindex] do
    begin //end item
      startval  := sta;
      ramp      := 0;
      starttime := ti;
      endtime   := -1;
      Inc(progindex);
    end;
  end; //setend

  procedure calc(const options: sigenveloperangeoptionsty; const maxeventtime: double; const valueitem: complexty; var progindex: integer; var ti: integer; var sta: double);
  var
    int3: integer;
  begin
    setscale(options, progindex, double(sta));
    with ainfo.fprog[progindex] do
    begin
      maxeventdelay := round(maxeventtime * eventtimescale);
      starttime := ti;
      startval := sta;
      int3    := ti;
      ti      := round((valueitem.re + timoffs) * timsca);
      endtime := ti;
      if int3 >= ti then
        int3 := ti - 1;
      ramp := (valueitem.im - sta) / (ti - int3);
      sta  := valueitem.im;
    end;
    Inc(progindex);
  end; //calc
var
  int1, int2, int3: integer;
  ti: integer;
  sta: double;
  do1: double;
  aftertrigvalues: complexarty;
  decaystart: double;
  opt1: sigenveloperangeoptionsty;
begin
  if fupdating > 0 then
    Exit;
  lock;
  try
    ffinished := False;
    if fcontroller <> nil then
      do1     := fcontroller.samplefrequ
    else
      do1     := 44100;
    eventtimescale := do1 / fsubsampling;
    fhasmix := (sero_mix in fattack_options) or (sero_mix in fdecay_options) or
      (sero_mix in frelease_options);
    with ainfo do
    begin
      isexpbefore      := False;
      isexpbeforeset   := False;
      attack_valuespo  := @fattack_values;
      decay_valuespo   := @fdecay_values;
      release_valuespo := @frelease_values;
      if @ainfo = @finfos[1] then
      begin
        if not (sero_mix in fattack_options) then
          attack_valuespo  := @finfos[0].fattack_values;
        if not (sero_mix in fdecay_options) then
          decay_valuespo   := @finfos[0].fdecay_values;
        if not (sero_mix in frelease_options) then
          release_valuespo := @finfos[0].frelease_values;
      end;

      int1         := high(attack_valuespo^);
      allocuninitedarray(int1 + high(decay_valuespo^) + 2, sizeof(complexty),
        aftertrigvalues);
      for int2     := 0 to int1 do
        aftertrigvalues[int2] := attack_valuespo^[int2];
      if int1 >= 0 then
        decaystart := attack_valuespo^[int1].re
      else
        decaystart := 0;
      Inc(int1);
      for int2     := 0 to high(decay_valuespo^) do
        with aftertrigvalues[int2 + int1] do
        begin
          re := decay_valuespo^[int2].re + decaystart;
          im := decay_valuespo^[int2].im;
        end;
      fprog := nil;
      timoffs := 0;
      timsca  := ftimescale / fsubsampling;
      if fcontroller <> nil then
        timsca := timsca * fcontroller.samplefrequ;
      ftime           := 0;
      fattackval      := 0;
      fattackramp     := 0;
      floopstartindex := -1;
      floopendindex   := -1;
      floopval        := 0;
      floopramp       := 1;
      freleaseindex   := -1;
      freleaseval     := 0;
      freleaseramp    := 0;

      int1 := high(aftertrigvalues) + 2; //+ enditem
      if floopstart >= 0 then
        for int2 := 0 to high(decay_valuespo^) do
          if decay_valuespo^[int2].re >= floopstart then
          begin
            floopstartindex := int2 + length(attack_valuespo^); //fvaluestrig index
            floopendindex   := length(aftertrigvalues);
            break;
          end;
      if high(aftertrigvalues) >= 0 then
      begin
        fattackval    := aftertrigvalues[0].im;
        freleasestart := aftertrigvalues[high(aftertrigvalues)].re;
      end;

      if high(release_valuespo^) >= 0 then
      begin
        int1         := int1 + high(release_valuespo^) + 2; //+enditem
        freleaseval  := release_valuespo^[0].im;
        freleaseramp := release_valuespo^[0].re;
        if freleaseramp > 0 then
          freleaseramp := 1 / (freleaseramp * timsca);
      end;
      setlength(fprog, int1);
      findex     := high(fprog); //init inactive
      findexhigh := findex;
      ti         := 0;
      sta        := fattackval;
      int1       := 0;
      int3       := high(aftertrigvalues);
      for int2 := 0 to high(attack_valuespo^) do
        calc(fattack_options, fattack_maxeventtime, aftertrigvalues[int2], int1, ti, sta);
      for int2 := length(attack_valuespo^) to int3 do
        calc(fdecay_options, fdecay_maxeventtime, aftertrigvalues[int2], int1, ti, sta);
      if floopstartindex >= 0 then
      begin
        do1 := sta;
        calc(fdecay_options, fdecay_maxeventtime, makecomplex(
          aftertrigvalues[int3].re + aftertrigvalues[floopstartindex].re - floopstart,
          aftertrigvalues[floopstartindex].im), int1, ti, sta);
        sta := do1;
        Inc(floopstartindex); //fprog index
      end
      else
      begin
        opt1   := fdecay_options;
        if (decay_valuespo^ = nil) and (attack_valuespo^ <> nil) then
          opt1 := fattack_options;
        setend(opt1, int1, ti, sta);
      end;
      if high(release_valuespo^) >= 0 then
      begin
        ti := 0;
        freleaseindex := int1; //prog index
        for int2 := 0 to high(release_valuespo^) do
          calc(frelease_options, frelease_maxeventtime, release_valuespo^[int2],
            int1, ti, sta);
        setend(frelease_options, int1, ti, sta);
      end;
      if fprog[0].endtime > 0 then
        fattackramp := 1 / fprog[0].endtime;
      sendchangeevent;
    end;
  finally
    unlock;
  end;
end;

procedure tsigenvelope.sighandler(const ainfo: psighandlerinfoty);

  procedure startattack(var ainfo: envelopeinfoty);
  begin
    with ainfo do
    begin
      ftime  := 0;
      findex := 0;
      with fprog[0] do
      begin
        if fcurrisexp and not isexp then
          exptolin(fcurrval);
        if not fcurrisexp and isexp then
          lintoexp(fcurrval);
        ramp       := (fattackval - fcurrval) * fattackramp;
        if ramp = 0 then
          startval := fattackval
        else
          startval := fcurrval;
      end;
    end;
  end; //startattack()

  procedure startrelease(var ainfo: envelopeinfoty);
  begin
    with ainfo do
      if freleaseindex >= 0 then
      begin
        ftime  := 0;
        findex := freleaseindex;
        with fprog[findex] do
        begin
          if fcurrisexp and not isexp then
            exptolin(fcurrval);
          if not fcurrisexp and isexp then
            lintoexp(fcurrval);
          ramp       := (freleaseval - fcurrval) * freleaseramp;
          if ramp = 0 then
            startval := freleaseval
          else
            startval := fcurrval;
        end;
      end;
  end; //startrelease()

  procedure calc(var ainfo: envelopeinfoty);
  begin
    with ainfo do
      with fprog[findex] do
      begin
        fcurrisexp := isexp;
        fcurrval   := startval + ramp * (ftime - starttime);
        if isexp then
        begin
          if (fcurrval <= 0) and not (seo_nozero in foptions) then
            fdest := 0
          else
          begin
            fdest := exp(fcurrval * scale + offset) * famplitudepo^.Value;
          end;
        end
        else
          fdest := (fcurrval * scale + offset) * famplitudepo^.Value;
        if endtime >= 0 then
        begin
          Inc(ftime);
          if (ftime > endtime) then
            if findex = floopendindex then
            begin
              findex := floopstartindex;
              ftime  := fprog[floopstartindex].starttime;
            end
            else
              Inc(findex);
        end;
      end;
  end; //calc()
var
  bo1: Boolean;
  int1: integer;
begin
  if fattackpending or (ftrigger.fv.Value = 1) then
  begin
    ftrigger.fv.Value := 0;
    fattackpending    := False;
    ffinished         := False;
    startattack(finfos[0]);
    startattack(finfos[1]);
  end;
  if freleasepending or (ftrigger.fv.Value = -1) then
  begin
    ftrigger.fv.Value := 0;
    freleasepending   := False;
    ffinished         := False;
    startrelease(finfos[0]);
    startrelease(finfos[1]);
  end;
  ainfo^.discard := True;
  if fsamplecount = 0 then
  begin
    fsamplecount := fsubsampling;
    if feventdriven then
    begin
      calc(finfos[0]);
      with finfos[0] do
      begin
        fmaxeventdelay := fprog[findex].maxeventdelay;
        bo1 := False;
        if fhasmix then
        begin
          calc(finfos[1]);
          with finfos[1] do
          begin
            int1 := fprog[findex].maxeventdelay;
            if int1 < fmaxeventdelay then
              fmaxeventdelay := int1;
            bo1 := (feventtime >= fmaxeventdelay) or
              (abs(fcurrval - fcurrvalbefore) > feventthreshold);
          end;
        end;
        bo1 := bo1 or (feventtime >= fmaxeventdelay) or
          (abs(fcurrval - fcurrvalbefore) > feventthreshold);
        if bo1 then
          fcurrvalbefore := fcurrval;
      end;
      if fhasmix then
      begin
        calc(finfos[1]);
        with finfos[1] do
          if bo1 then
          begin
            fcurrvalbefore := fcurrval;
            foutputpo^     := finfos[1].fdest * fmixpo^.Value +
              finfos[0].fdest * (1 - fmixpo^.Value);
          end;
      end
      else
      begin
        if bo1 then
          foutputpo^ := finfos[0].fdest;
      end;
      if bo1 then
      begin
        feventtime := 0;
        fcontroller.dispatcheventoutput(fsigclientinfo.infopo);
      end;
      Inc(feventtime);
    end
    else
    begin
      ainfo^.discard := False;
      calc(finfos[0]);
      ffinished      := finfos[0].findex = finfos[0].findexhigh;
      if fhasmix then
      begin
        calc(finfos[1]);
        ffinished  := ffinished and (finfos[1].findex = finfos[1].findexhigh);
        foutputpo^ := finfos[1].fdest * fmixpo^.Value +
          finfos[0].fdest * (1 - fmixpo^.Value);
      end
      else
        foutputpo^ := finfos[0].fdest;
    end;
  end;
  if not ffinished then
    Dec(fsamplecount);
end;

function tsigenvelope.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigenvelope.checkindex(const index: integer);
begin
  if (index < 0) or (index > 1) then
    raise Exception.Create(ownernamepath(self) + ': Invalid array index ' +
      IntToStr(index) + '.');
end;

procedure tsigenvelope.updatevalueindex(const aindex: integer);
begin
  updatevalues(finfos[aindex]);
  if aindex = 0 then
    updatevalues(finfos[1])//affects both
  ;
end;

function tsigenvelope.getattack_values(const index: integer): complexarty;
begin
  checkindex(index);
  Result := finfos[index].fattack_values;
end;

procedure tsigenvelope.setattack_values(const index: integer; const avalue: complexarty);
begin
  checkindex(index);
  finfos[index].fattack_values := avalue;
  updatevalueindex(index);
end;

function tsigenvelope.getdecay_values(const index: integer): complexarty;
begin
  checkindex(index);
  Result := finfos[index].fdecay_values;
end;

procedure tsigenvelope.setdecay_values(const index: integer; const avalue: complexarty);
begin
  checkindex(index);
  finfos[index].fdecay_values := avalue;
  updatevalueindex(index);
end;

function tsigenvelope.getrelease_values(const index: integer): complexarty;
begin
  checkindex(index);
  Result := finfos[index].frelease_values;
end;

procedure tsigenvelope.setrelease_values(const index: integer; const avalue: complexarty);
begin
  checkindex(index);
  finfos[index].frelease_values := avalue;
  updatevalueindex(index);
end;

function tsigenvelope.getloopstart(const index: integer): real;
begin
  checkindex(index);
  Result := finfos[index].floopstart;
end;

procedure tsigenvelope.setloopstart(const index: integer; const avalue: real);
begin
  checkindex(index);
  finfos[index].floopstart := avalue;
  updatevalues(finfos[index]);
end;

procedure tsigenvelope.settrigger(const avalue: tchangedoubleinputconn);
begin
  ftrigger.Assign(avalue);
end;

function tsigenvelope.getinputar: inputconnarty;
begin
  setlength(Result, 3);
  Result[0] := ftrigger;
  Result[1] := famplitude;
  Result[2] := fmix;
end;

function tsigenvelope.getzcount: integer;
begin
  Result := 1;
end;

procedure tsigenvelope.initmodel;
begin
  inherited;
  famplitudepo := @famplitude.fv;
  fmixpo       := @fmix.fv;
  updatevaluesx;
end;

procedure tsigenvelope.setmin(const avalue: real);
begin
  fmin := avalue;
  updatevaluesx;
end;

procedure tsigenvelope.setmax(const avalue: real);
begin
  fmax := avalue;
  updatevaluesx;
end;

procedure tsigenvelope.setoptions(const avalue: sigenvelopeoptionsty);
begin
  if avalue <> foptions then
  begin
    eventdriven := seo_eventoutput in avalue;
    foptions    := avalue;
    updatevaluesx;
  end;
end;

procedure tsigenvelope.dotriggerchange(const Sender: TObject);
begin
  if ftrigger.fv.Value = 1 then
    fattackpending  := True;
  if ftrigger.fv.Value = -1 then
    freleasepending := True;
  ftrigger.fv.Value := 0;
end;

procedure tsigenvelope.start;
begin
  lock;
  fattackpending := True;
  unlock;
end;

procedure tsigenvelope.stop;
begin
  lock;
  freleasepending := True;
  unlock;
end;

procedure tsigenvelope.update;
begin
  inherited;
  updatevaluesx;
end;

procedure tsigenvelope.setattack_options(const avalue: sigenveloperangeoptionsty);
begin
  if fattack_options <> avalue then
  begin
    fattack_options := avalue;
    updatevaluesx;
  end;
end;

procedure tsigenvelope.setdecay_options(const avalue: sigenveloperangeoptionsty);
begin
  if fdecay_options <> avalue then
  begin
    fdecay_options := avalue;
    updatevaluesx;
  end;
end;

procedure tsigenvelope.setrelease_options(const avalue: sigenveloperangeoptionsty);
begin
  if frelease_options <> avalue then
  begin
    frelease_options := avalue;
    updatevaluesx;
  end;
end;

procedure tsigenvelope.dosync;

  procedure setval(const aindex: integer);
  begin
    attack_values[aindex]  := master.attack_values[aindex];
    decay_values[aindex]   := master.decay_values[aindex];
    release_values[aindex] := master.release_values[aindex];
    loopstart[aindex]      := master.loopstart[aindex];
  end; //setval()
begin
  beginupdate;
  setval(0);
  setval(1);
  endupdate;
end;

procedure tsigenvelope.setmaster(const avalue: tsigenvelope);
var
  env1: tsigenvelope;
begin
  if avalue <> fmaster then
  begin
    env1 := avalue;
    while env1 <> nil do
    begin
      if env1 = self then
        raise Exception.Create('Recursive master.');
      env1 := env1.master;
    end;
    setlinkedvar(tmsecomponent(avalue), tmsecomponent(fmaster));
    if avalue <> nil then
      dosync;
  end;
end;

procedure tsigenvelope.objectevent(const Sender: TObject; const event: objecteventty);
begin
  if (event = oe_changed) and (Sender <> nil) and (Sender = master) then
    dosync;
end;

procedure tsigenvelope.setamplitude(const avalue: tdoubleinputconn);
begin
  famplitude.Assign(avalue);
end;

procedure tsigenvelope.updatevaluesx;
begin
  updatevalues(finfos[0]);
  updatevalues(finfos[1]);
end;

procedure tsigenvelope.setmix(const avalue: tlimitinputconn);
begin
  fmix.Assign(avalue);
end;

function tsigenvelope.getsigoptions: sigclientoptionsty;
begin
  Result := inherited getsigoptions;
  if feventdriven then
    Result := Result + [sco_fulltick];
end;

procedure tsigenvelope.setsubsampling(avalue: integer);
begin
  if avalue < 1 then
    avalue     := 1;
  fsubsampling := avalue;
end;

{ tchangedoubleinputconn }

constructor tchangedoubleinputconn.Create(const aowner: TComponent; const asigintf: isigclient; const aonchange: notifyeventty);
begin
  fonchange := aonchange;
  inherited Create(aowner, asigintf);
end;

procedure tchangedoubleinputconn.setvalue(const avalue: double);
begin
  lock;
  inherited;
  if tmsecomponent(owner).canevent(tmethod(fonchange)) then
    try
      fonchange(self);
    finally
      unlock
    end
  else
    unlock;
end;

{ tsigsampler }

constructor tsigsampler.Create(aowner: TComponent);
begin
  fbufferlength := defaultsamplecount;
  frefreshus := -1;
  foptions := defaultsigsampleroptions;
  inherited;
  ftrigger := tchangedoubleinputconn.Create(self, isigclient(self),
                                   {$ifdef FPC}
    @
{$endif}
    dotriggerchange);
  ftrigger.Name := 'trigger';
  ftriggerlevel := tchangedoubleinputconn.Create(self, isigclient(self),
                                   {$ifdef FPC}
    @
{$endif}
    dotriggerchange);
  ftriggerlevel.Name := 'triggerlevel';
  ftimer := tsimpletimer.Create(0,
{$ifdef FPC}
    @
{$endif}
    dotimer, False, [to_leak]);
end;

destructor tsigsampler.Destroy;
begin
  ftimer.Free;
  inherited;
end;

function tsigsampler.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigsampler.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
  do1: double;
begin
  if not frunning and fstarted then
  begin
    if sso_autorun in foptions then
      do1 := 1
    else if fnegtrig then
      do1 := ftriggerlevel.Value - ftrigger.Value
    else
      do1 := ftrigger.Value - ftriggerlevel.Value;
    if do1 >{=} 0 then
    begin
      if fpretrigger then
      begin
        fbufpo   := 0;
        frunning := True;
        fstarted := False;
      end;
    end
    else
      fpretrigger := True;
  end;
  if frunning then
  begin
    for int1 := 0 to high(fsigbuffer) do
      fsigbuffer[int1][fbufpo] := finps[int1]^.Value;
    Inc(fbufpo);
    if fbufpo = fbufferlength then
    begin
      frunning := False;
      dobufferfull;
      checkautostart;
    end;
  end
  else if fstartpending then
  begin
    fstartpending := False;
    start;
  end;
end;

procedure tsigsampler.Clear;
begin
  frunning := False;
  inherited;
end;

procedure tsigsampler.setbufferlength(const avalue: integer);
begin
  if fbufferlength <> avalue then
  begin
    lock;
    if avalue = 0 then
      fbufferlength := 1
    else
      fbufferlength := avalue;
    modelchange;
    unlock;
  end;
end;

procedure tsigsampler.initmodel;
var
  int1: integer;
begin
  inherited;
  fsigbuffer := nil;
  setlength(fsigbuffer, finputs.Count);
  for int1   := 0 to high(fsigbuffer) do
    setlength(fsigbuffer[int1], fbufferlength);
  checkautostart();
end;

procedure tsigsampler.settrigger(const avalue: tchangedoubleinputconn);
begin
  ftrigger.Assign(avalue);
end;

procedure tsigsampler.settriggerlevel(const avalue: tchangedoubleinputconn);
begin
  ftriggerlevel.Assign(avalue);
end;

procedure tsigsampler.dotriggerchange(const Sender: TObject);
begin
  //dummy
end;

procedure tsigsampler.start;
begin
  lock;
  fstarted    := True;
  frunning    := False;
  fpretrigger := sso_autorun in foptions;
  unlock;
end;

procedure tsigsampler.dobufferfull;
begin
  if Assigned(fonbufferfull) then
    fonbufferfull(self, fsigbuffer);
end;

function tsigsampler.getinputar: inputconnarty;
begin
  setlength(Result, 2);
  Result[0] := ftrigger;
  Result[1] := ftriggerlevel;
  stackarray(pointerarty(inherited getinputar), pointerarty(Result));
end;

procedure tsigsampler.checkautostart;
begin
  if (sso_autorun in foptions) and (frefreshus < 0) and
    (componentstate * [csloading, csdesigning] = []) then
    start;
end;

procedure tsigsampler.setoptions(const avalue: sigsampleroptionsty);
var
  optionsbefore: sigsampleroptionsty;
begin
  if foptions <> avalue then
  begin
    optionsbefore := foptions;
    foptions      := avalue;
    updateoptions(foptions);
    fnegtrig      := sso_negtrig in foptions;
    if (sso_fulltick in foptions) xor (sso_fulltick in optionsbefore) then
      modelchange;
    if not (sso_autorun in optionsbefore) then
      checkautostart;
  end;
end;

procedure tsigsampler.setrefreshus(const avalue: integer);
begin
  if frefreshus <> avalue then
  begin
    frefreshus := avalue;
    if avalue < 0 then
    begin
      ftimer.Enabled := False;
      checkautostart;
    end
    else
    begin
      ftimer.interval  := avalue;
      if componentstate * [csloading, csdesigning] = [] then
        ftimer.Enabled := True;
    end;
  end;
end;

procedure tsigsampler.dotimer(const Sender: TObject);
begin
  lock;
  if not fstarted and not frunning then
    start
  else
    fstartpending := True;
  unlock;
end;

procedure tsigsampler.loaded;
begin
  inherited;
  if not (csdesigning in componentstate) then
    if (frefreshus >= 0) then
      ftimer.Enabled := True
    else
      checkautostart;
end;

procedure tsigsampler.updateoptions(var avalue: sigsampleroptionsty);
begin
  exclude(avalue, sso_fftmag);
end;

function tsigsampler.getsigoptions: sigclientoptionsty;
begin
  Result := inherited getsigoptions;
  if sso_fulltick in foptions then
    include(Result, sco_fulltick);
end;

{ tdoublesiginoutcomp }

constructor tdoublesiginoutcomp.Create(aowner: TComponent);
begin
  finput   := tdoubleinputconn.Create(self, isigclient(self));
  finputpo := @finput.fv;
  inherited;
end;

procedure tdoublesiginoutcomp.setinput(const avalue: tdoubleinputconn);
begin
  finput.Assign(avalue);
end;

function tdoublesiginoutcomp.getinputar: inputconnarty;
begin
  setlength(Result, 1);
  Result[0] := finput;
end;

{ tsigconnector }

function tsigconnector.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigconnector.sighandler(const ainfo: psighandlerinfoty);
begin
  foutputpo^ := finputpo^.Value;
end;

{ ttrigconnector }

constructor ttrigconnector.Create(aowner: TComponent);
begin
  inherited;
  include(foutput.fstate, ocs_eventdriven);
end;

{ tlimitinputconn }

constructor tlimitinputconn.Create(const aowner: TComponent; const asigintf: isigclient);
begin
  inherited;
  fmin := 0;
  fmax := 1;
end;

end.

