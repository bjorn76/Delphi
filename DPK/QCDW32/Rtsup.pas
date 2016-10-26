
{$A-,F+,K+,X+}
unit RTSUP;
interface

uses WinProcs, WinTypes, Messages, QCWin, QCWRT, support;

const
{************************************************************************}
  DATABUFSIZE =1024;
  DDE_OK    = 0;
  DDE_FAIL  = 1;

  MAX_CONV   = 5;
  MAX_LINKS  =16;            { max. # of items per conversation }


 ID_RTTIMER =61111;         { internal timer id  - }

 MAX_TIMELST =200;          { max. # of items in the timer list }
 DEFTIMEOUT  =3000;         { 2 seconds }

 NPOL  =14;                 { segment length for Wave algorithm }

 HR  =3600;        		 { # of secs in one hour }
 MIN =60; 		         { # of secs in one minute }

 LG_DYN = 2;                { dynamic legends code }

 LYHIGH =32000;
 LYLOW  =-20000;

 DEGREE = PI / 180.0;      { 1 degree in radians  }

  BAR_RATIO = 0.04;
  METER_RATIO = 12;          { ratio of needle lengths of different channels }
  METER_CENTER_RAD = 0.05;

{ subtypes for child controls }
 CHC_SCRBAR   =0;            { scrolling bar }
 CHC_PBUTTON  =1;            { PUSHBUTTON    }
 CHC_DPBUTTON =2;            { Default PUSHBUTTON}
 CHC_RBUTTON  =3;            { RADIOBUTTON       }
 CHC_CBOX     =4;            { CHECKBOX          }
 CHC_OWNER    =5;            { OWNER DRAW        }
 CHC_GBUTTON  =6;            // Group Button
 CHC_LED      =7;            // Led

 COMBO_LINE =1 ;
 COMBO_SCATTER= 5;
 COMBO_MULTIBAR= 6;
 COMBO_FILLED =7;
 SCROLLGRAPH_COMBO= 8;


 DYNGRAPH_BAR =3;
 DYNGRAPH_SCATTER =2;
 DYNGRAPH_LINE =1;
 
{ scaling types}
 SCALE_Y     =0;       { Y only}
 SCALE_NN    =1;
 SCALE_S_L   =2;
 SCALE_SF_LN =3;
 SCALE_SF_LH =4;
 SCALE_LN_SF =5;
 SCALE_LF_S  =6;
 SCALE_HIST  =7;

              { alarm masks   }
 ALMMASK_OK     = 0;
 ALMMASK_SETP   = 0;
 ALMMASK_HIGH   = 1;
 ALMMASK_LOW    = 2;
 ALMMASK_HH     = 4;
 ALMMASK_LL     = 8;
 ALMMASK_RATE   =16;
 ALMMASK_DEV    =32;
 ALMMASK_FAIL   =64;

{ Alarm bits                   }
{ 7    6    5   4    3  2   1   0 }
{     FAIL DEV RATE LL HH LOW HIGH }
{
{************************************************************************}
{ Control definitions }

 PID_AUTO   = 1;
 PID_MAN    = 2;

{************************************************************************}
{ DIRECTIONS: }

 DIR_LR  =0;
 DIR_RL  =1;
 DIR_TB  =2;
 DIR_BT  =3;

type
{*************************************************************************}
RTTOP_DEF = record
    lpDDS: array[0..MAX_DYNSETS-1] of PDYNDATA;   { array of pointers to descriptors }
                                   { of dynamic data sets }

    lpControlDS: array[0..MAX_CBLOCKS-1] of POINTER; { array of pointers to descriptors }
                                     { of control blocks }
    lpfnAlarmCallback: TFARPROC;       { alarm callback procedure }
    lpfnDdeCallback: TFARPROC;         { DDE callback procedure }
end;

 PRTTOP = ^RTTOP_DEF;

{************************************************************************}
DDEITEM = record
    hszItem: HSZ;          { handle of item name string }
    thdata: HDATA;            { data set handle }
    lpDataDesc: PDYNDATA;  { pointer to data set descriptor }

{    short nGrNum;   }        { group member number (for single item,  }
                             { otherwise must be -1) }
    nVal: INTEGER;             { number of values in the item }
end;
PDDEITEM = ^DDEITEM;

{************************************************************************}
DDEDATA = record
     bAutoUpdate: BOOL;   { if TRUE, update object when new value arrives }
{	PDDEITEM lpItemDesc [DYN_MAXVAL]; }
end;

{************************************************************************}
DDECONV_DESC = record              { DDE conversation descriptor }
    thconv: HCONV;            { Conversation handle }
    hszApp: HSZ;           { hanlde of service name string }
    hszTopic: HSZ;         { hanlde of topic name string }
    nUseCount: INTEGER;        { usage counter }
    pDdeDesc : array[0..MAX_LINKS-1] of PDDEITEM;
end;

PCONV_DESC = ^DDECONV_DESC;

TIMER_ITEM = record
    hAppInst: THANDLE;          { instance of application. }
    pGrDesc: PGRAPH_DEF;           { identifies object in the timer list }
    pObjDesc: PDYNOBJ_HEAD;
end;

{************************************************************************}
DYNOBJ_LEGEND = record
    header: DYNOBJ_HEAD;
    tdesc: TEXTDESC;               { font for legends }
    nNumObjects,         { number of objects }
    nMaxChar,            { Max legend length (characters) }
    nLongest,            { Number of the longest legend }
    nBackColor: SHORT;          { background color, -1 - transparent }
    cxMaxExt,            { width of the widest field }
    cyChar,              { screen character height   }
    cxWidth: INTEGER;             { width of one legend field }
    nLayout,             { OR_VERT or OR_HORZ        }
    nLegType: SHORT;            { LG_CHART or LG_GROUP      }
    bBorder: BOOL;             { legend rectangle border flag }
    pLegends: LPSTR;
    cNoSym: BYTE;              { if 1, do not draw symbols }
    reserved: array [0..6] of CHAR;
   ldesc: array[0..1] of LEGEND_DESC;
end;

{************************************************************************}

{************************************************************************}
{ DYNAMIC OBJECTS DESCRIPTORS *******************************************}
{************************************************************************}
{
DYNOBJ_GRIDS = record
    header: DYNOBJ_HEAD;
    pAxDesc: ^OBJ_AX;
END;
}

{**************************************************************************************}
{	PID  data descriptor    }
{**************************************************************************************}
PID_DEF = record
    wAlgType: WORD;		   { algorithm type }
    hPID: HCONT;             { PID block's handle }
    szTitle: array [0..DYNTITLELEN-1] of CHAR; { descriptor }
    hMeasData,        { handle of the related input data set }
    hOutData: HDATA;         { handle of the related output data set }
    lpMeasDataDesc,   { pointer to associated input data set descriptor (can be NULL) }
    lpOutDataDesc: PDYNDATA;    { pointer to associated output data set descriptor (can be NULL) }
    rSamplePeriod,    { time between updates, in minutes }
    rHighRange,       { high range of the PID output (100 %) in output eng. units }
    rLowRange,        { low range of the PID output  ( 0 % ) }
    rHighLimit,       { high limit of the PID output, for clamping }
    rLowLimit,        { low limit of the PID output, for clamping  }
    rOut,  		   { PID Algorithm output }
    rMeas,		       { measurement (input)		   }
    rSetp,            { setpoint }
    rSteadyState,     { bias }
    rMeasHighRange,   { high range of the PID input (100 %) in meas. eng. units }
    rMeasLowRange,    { low range of the PID input ( 0 % ) }
    rNewErr,
    rOldErr,
    e1, e2, e3,       { error terms t-1, t-2 and t-3 }
    rErrSum,          { sum of all previous errors }
    rRateLim,         { limit of output rate of change      }
    rLastFM,          { previous filtered measurement value }
    rFiltConst,       { Filter constant (0.0 - 1.0 ) }
    rScaleCoef, 	   { }

    rProp,            { proportional gain }
    rKi,	           { integral action constant }
    rKd: Realtype;	           { derivative constant }
    bInc,             { inc/inc flag }
    bAuto: BOOL;            { Auto/manual flag }
end;

PPID = ^PID_DEF;    { pointer to PID descriptor

{*******************************************************************}
{ Drawing and update functions }

{$ifndef WIN32}
procedure rtDefEditObject (pGrDesc:PGRAPH_DEF);
function rtObjFind (thwnd:HWND): HGOBJ;
procedure  WREditObject (thwnd:HWND);
procedure KillRTPage (hPage:HGRAPH);
function QCChildControlProc (hwndGraph:HWND; message:UINT;
    wParam:UINT; lParam:LongInt): INTEGER;
procedure  RTCleanup (lpTop:PRTTOP);
{$else}
procedure rtDefEditObject (pGrDesc:PGRAPH_DEF); stdcall;
function rtObjFind (thwnd:HWND): HGOBJ; stdcall;
procedure  WREditObject (thwnd:HWND);stdcall;
procedure KillRTPage (hPage:HGRAPH);stdcall;
function QCChildControlProc (hwndGraph:HWND; message:UINT;
    wParam:UINT; lParam:LongInt): INTEGER;  stdcall;
procedure  RTCleanup (lpTop:PRTTOP); stdcall;


{$endif}

implementation

procedure rtDefEditObject; external QCRTDLL;
function rtObjFind; external QCRTDLL;
procedure  WREditObject; external QCRTDLL;
procedure KillRTPage; external QCRTDLL;
function QCChildControlProc; external QCRTDLL;
procedure  RTCleanup; external QCRTDLL;

end.
