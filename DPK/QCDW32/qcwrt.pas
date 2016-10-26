{$A+,F+,K+,X+}
{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   QCWRT.PAS                                   *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

unit QCWRT;
interface


uses WinProcs, WinTypes, Messages, QCWIN;

const
 //  Define RTFL in  conditional defines section of
 // project options to use SINGLE numeric type as realtype
{$ifndef RTFL}
 QCRTDLL = 'WRT32DR3.DLL';
{$else}
 QCRTDLL = 'WRT32FR3.DLL';
{$endif}


 AXU_SEC    = 0;       { time units codes for time axes}
 AXU_MIN    = 1;
 AXU_HOUR   = 2;

{ staircase style}

 NO_STEP    =0;
 STEP_START =1;
 STEP_END   =2;

 NORMAL_RTTRACE_COLOR_MODE =0;
 ALARM_RTTRACE_COLOR_MODE =1;

              { alarm types}
 ALM_OK    =0;
 ALM_SETP  =0;
 ALM_HIGH  =1;
 ALM_LOW   =2;
 ALM_HH    =3;
 ALM_LL    =4;
 ALM_RATE  =5;
 ALM_DEV   =6;
 ALM_FAIL  =7;

{ meter subtypes }
 GOD_SUBT_NEEDLE  = 0;       { needle meter  }
 GOD_SUBT_PIE     = 1;       { pie meter  }
 GOD_SUBT_ARC     = 2;       { arc meter  }

{********************************************************************}
{ Direction definitions                                              }
{********************************************************************}

 DYN_LEFT   = 0;       { scroll or move from right to left}
 DYN_RIGHT  = 1;
 DYN_UP     = 2;
 DYN_DOWN   = 3;

{************************************************************************}
{ Meter definitions******************************************************}
{************************************************************************}
{ needle types }

 NEEDLE_LINE     =  0;  { simple line}
 NEEDLE_THICK    =  1;  { thick lline with circle}
 NEEDLE_SHORTF   =  2;  { triangle with base at center - filled}
 NEEDLE_SHORTH   =  3;  { triangle with base at center - hollow}
 NEEDLE_LONGF    =  4;  { triangle with back plane - filled}
 NEEDLE_LONGH    =  5;  { triangle with back plane - hollow}

 MET_TICK_REG    = 0;
 MET_TICK_THICK  = 1;
 MET_TICK_TRIAG  = 2;

 MET_NOBORDER    = 0;
 MET_RECT        = 1;
 MET_CIRC        = 2;
 MET_RD_RECT     = 3;

{************************************************************************}
{ Dynamic label types ***************************************************}
{************************************************************************}
  DLB_NUMERIC  = 0;
  DLB_HMS      = 1;    { time format, hh:mm:ss. Prec ignored}
  DLB_HM       = 2;    { time format, hh:mm}
  DLB_MS       = 4;

{ CONTROL STYLES}
         { logic }
  BC_STYLE_PUSH      = 0;       { like standard push button}
  BC_STYLE_ONOFF     = 1;       { 2 state}
  BC_STYLE_XOR       = 2;       { radio button logic}
  BC_STYLE_PASSIVE   = 3;       { cannot be pressed}
         { appearance}
  BC_LOOK_LOW   = 0;            { standard pushbutton look}
  BC_LOOK_HIGH  = 1;            { "deep" pushbutton}
  BC_LOOK_RADIO = 2;            { standard radio button}
  BC_LOOK_CHECK = 3;            { "deep" check box}
  BC_LOOK_LED   = 4;            { LED}

 {************************************************************************}
{ Algorithm Definitions *************************************************}
{************************************************************************}
 MAX_CBLOCKS =128;

 ALG_NONE   = 0;
 ALG_PID    = 1;

{ PID bargraph}
{ order of handles:}
 PIDH_TITLE   =0;           { graph title}
 PIDH_LEFTYAX =1;           { left (measurement) Y axis}
 PIDH_LEFTLAB =2;           { left (measurement) Y axis labels}
 PIDH_LEFTTIT =3;           { left (measurement) Y axis title}
 PIDH_BARINP  =4;           { input (meas and setp) bargraph}
 PIDH_RIGHTYAX =5;          { right (output) Y axis}
 PIDH_RIGHTLAB =6;          { right (output) Y axis labels}
 PIDH_RIGHTTIT =7;          { right (output) Y axis title}
 PIDH_BAROUT   =8;          { output bargraph}
 PIDH_AM       =9;          { auto/manual message}
 PIDH_INPTEXT =10;          { live text for measurement and setpoint}
 PIDH_INPTAGS =11;          { tags for measurement and setpoint}
 PIDH_INPALMS =12;          { alarm text for measurement and setpoint}
 PIDH_OUTTEXT =13;          { live text for output}
 PIDH_OUTTAG  =14;          { tag for output}
 PIDH_OUTALMS =15;          { alarm text for output}

 PID_NH       =16;

{ Auto bar objects}
{ order of handles:}
 ABH_TITLE    = 0;          { graph title}
 ABH_FIRSTAX  = 1;          { left (bottom) axis}
 ABH_FIRSTLAB = 2;         { left (bottom) axis labels}
 ABH_AXTIT    = 3;          { left (bottom) axis title }
 ABH_BAR      = 4;          { bargraph}
 ABH_LASTAX   = 5;          { right (top)  axis}
 ABH_LASTLAB  = 6;          { right (top) axis labels}
 ABH_TAGS     = 7;          { tags}
 ABH_TEXT     = 8;          { live text}
 ABH_ALMMARKS = 9;          { alarm marks}
 ABH_ALMTEXT  =10;          { alarm text}

 AB_NH  = 11;

{ Auto scroll objects}
{ order of handles:}
 ASH_TITLE    = 0;          { graph title}
 ASH_XAX      = 1;          { X axis}
 ASH_XLAB     = 2;          { X axis labels}
 ASH_XTIT     = 3;          { X axis title}
 ASH_YAX      = 4;          { Y axis}
 ASH_YLAB     = 5;          { Y axis labels}
 ASH_YTIT     = 6;          { Y axis title}
 ASH_SCROLL   = 7;          { scrolling graph}
 ASH_TAGS     = 8;          { tags}
 ASH_TEXT     = 9;          { live text}
 ASH_ALMLINES =10;          { alarm lines}

 AS_NH  = 11;

{ Auto Text objects}
{ order of handles: }
 ATH_TITLE    = 0;          { graph title}
 ATH_TAGS     = 1;          { tags}
 ATH_VALUES   = 2;          { live text}
 ATH_ALMTEXT  = 3;          { alarm text}

 AT_NH  = 4;


{************************************************************************}
{ 32-Bit FUNCTION PROTOTYPES ***************************************************}
{************************************************************************}
{ Data functions ********************************************************}
{************************************************************************}
function WRDefineDynDataSet (lpTitle:LPSTR;
    nNumChans:INTEGER; lpUnits, lpTags:LPSTR; nHistSize:INTEGER): HDATA; stdcall;
procedure WRFreeDynDataSet (thData:HDATA); stdcall;
procedure WRUpdateData (thData:HDATA; prNewValues:LPReal;
    pGrDesc:PGRAPH_DEF); stdcall;
procedure WRUpdateBlockData (thData:HDATA; prNewValues:LPReal;
    nSamp:INTEGER; pGrDesc:PGRAPH_DEF); stdcall;
procedure WRGetLastData (thdata:HDATA; lprNewValues:LPReal;
     lprPrevValues:LPReal); stdcall;
function WRGetHistData (thdata:HDATA; nChan:INTEGER;
     lprUser:LPReal; nFirst, nNumSamples:INTEGER): INTEGER; stdcall;
procedure WRUpdateBinaryData (thdata:HDATA; wBinVal:UINT;
    pGrDesc:PGRAPH_DEF); stdcall;
function WRGetBinData (thData:HDATA): UINT; stdcall;
procedure WRSetBit (thdata:HDATA; nChanNum:INTEGER;
         bOn:BOOL; pGrDesc:PGRAPH_DEF); stdcall;
procedure WRSetBitExclusive (thdata:HDATA; nChanNum:INTEGER;
        pGrDesc:PGRAPH_DEF); stdcall;
function WRGetMinMaxValues (thdata:HDATA; nChan:INTEGER;
    var lprMin, lprMax:Realtype): BOOL; stdcall;
function WRReconnectDynDataSet (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    thData:HDATA): BOOL; stdcall;
procedure WRResetHistBuffer (thData:HDATA); stdcall;

{************************************************************************}
{ Dynamic graphical objects *********************************************}
{************************************************************************}
function WRSetScrollGraph (pGrDesc:PGRAPH_DEF;
    thdata:HDATA; rSampleInt, rRelResetInt:Realtype;
     nDir, nStep:INTEGER;
     lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;
function WRSetVarScroll (pGrDesc:PGRAPH_DEF;
    thdata:HDATA; rRelResetInt: realtype; nDir, nStep: INTEGER;
   lpLineStyle, lpLineWidth, lpLineColor: LPINT): HGOBJ; stdcall;

function WRSetAlarmLines (pGrDesc:PGRAPH_DEF; thdata:HDATA;
	nUpdateSec, nDir:INTEGER;
        lpbFlags:LPBOOL;
    lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;

function WRSetAlarmMarks (pGrDesc:PGRAPH_DEF; thdata:HDATA;
    hAxis:HGOBJ; nPos, nMarkSize:INTEGER;
    lpbFlags:LPBOOL;
    nLineWidth:INTEGER;
    lpLineColor:LPINT;
    lpNames:LPSTR): HGOBJ; stdcall;

function WRSetAlarmText (pGrDesc:PGRAPH_DEF;
     thdata:HDATA; nChan:INTEGER;
     rX1, rY1, rX2, rY2:Realtype;
     nBorderColor, nBorderWidth, nBackColor:INTEGER;
     lpNormMes:LPSTR;
     lpTextColor:LPINT;
     wAlign:UINT; nLayout:INTEGER): HGOBJ; stdcall;

function WRDynGrid (pGrDesc:PGRAPH_DEF; hAxis:HGOBJ;
     nGridType, nUpdateSec:INTEGER): HGOBJ; stdcall;

function WRSetXYGraph (pGrDesc:PGRAPH_DEF; thdata:HDATA;
	    nNumPoints:INTEGER;
    lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;
function WRSetStackedGraph (pGrDesc:PGRAPH_DEF; thdata:HDATA;
    rSampleInt, rRelResetInt:Realtype;
    nDir, nStep:INTEGER;
    rRelSize:Realtype;
    lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;

function WRSetLogicGraph (pGrDesc:PGRAPH_DEF; thdata:HDATA;
	rSampleInt, rRelResetInt:Realtype;
         nDir, nNumChannels:INTEGER;
	 rRelSize:Realtype;
        lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;

function WRSetDynText (pGrDesc:PGRAPH_DEF;
     thdata:HDATA; nChan:INTEGER;
     rX1, rY1, rX2, rY2:Realtype;
     nBorderColor, nBorderWidth:INTEGER;
     lpTextColor:LPINT;
     nBackColor, nLayout, nChar, nPrec:INTEGER;
     hDynObj:HGOBJ; n3D:INTEGER): HGOBJ; stdcall;

function WRLogicTags (pGrDesc:PGRAPH_DEF;
     nBorderColor, nBorderWidth, nTextColor, nBackColor:INTEGER;
     hStr:HGLOBAL; hLogObj:HGOBJ): HGOBJ; stdcall;

function WRLogicTagsPtr (pGrDesc:PGRAPH_DEF;
     nBorderColor, nBorderWidth, nTextColor, nBackColor:INTEGER;
     lpStr:LPSTR; hLogObj:HGOBJ): HGOBJ; stdcall;

function WRAutoRescale (pGrDesc:PGRAPH_DEF; hAxis:HGOBJ;
    thdata:HDATA; nChan:INTEGER;
    var lprMin, lprMax:Realtype;
    bUpdate:BOOL): BOOL; stdcall;
function WRDrawTimeAxis (pGrDesc:PGRAPH_DEF;
    rTickSpace:Realtype;
    nSmallTicks, nTickPos, nDir, nTimeUnits:INTEGER): HGOBJ; stdcall;
function WRLabelTimeAxis (pGrDesc:PGRAPH_DEF;
    hAxis:HGOBJ;
    nLabelPos, nFormat, nPrec, nStartHour, nStartMin, nStartSec:INTEGER;
    rStartNum:Realtype;
    nLast:INTEGER;
    lpTextLast:LPSTR): HGOBJ; stdcall;
Function WRChangeTimeLabelsFormat (pGrDesc: PGRAPH_DEF;
    hLab: HGOBJ; nNewFormat: INTEGER): BOOL; stdcall;
function WRDynLegend (pGrDesc:PGRAPH_DEF;
	 rX1, rY1, rX2, rY2:Realtype;
	 nBorderColor, nBorderWidth, nTextColor, nBackColor, nLayout:INTEGER;
         hStr:HGLOBAL; hDynObj:HGOBJ; bSymbols:BOOL) : HGOBJ; stdcall;
function WRDynLegendPtr (pGrDesc:PGRAPH_DEF;
	  rX1, rY1, rX2, rY2:Realtype;
	  nBorderColor, nBorderWidth, nTextColor, nBackColor, nLayout:INTEGER;
          tlpStr:LPSTR; hDynObj:HGOBJ; bSymbols:BOOL): HGOBJ; stdcall;
function WRSetScrollBargraph (pGrDesc:PGRAPH_DEF;
    thdata:HDATA; nChan:INTEGER;
    rSampleInt, rRelResetInt:Realtype;
    nDir:INTEGER;
    rWidth:Realtype;
    rgbBarColor:TCOLORREF;
    nBorderColor:INTEGER): HGOBJ; stdcall;
function WRResetScroll (pGrDesc:PGRAPH_DEF; hScroll:HGOBJ): BOOL; stdcall;

function WRSetSweepGraph (pGrDesc:PGRAPH_DEF; thdata:HDATA;
	rSampleInt:Realtype;
        nDir, nStep, nSweepLineColor:INTEGER; lpLineStyle, lpLineWidth, lpLineColor:LPINT): HGOBJ; stdcall;

function WRSetBargraph (pGrDesc:PGRAPH_DEF; thdata:HDATA;
	rCenterPoint:Realtype; nDir:INTEGER;
    rFirst, rLast, rWidth:Realtype;
    lpBarColor:LPTCOLORREF; lpHatchStyle, lpBorderColor:LPINT): HGOBJ; stdcall;

function WRSetAutoBargraph (pGrDesc:PGRAPH_DEF;
    thdata:HDATA; rMin, rMax, rCenterPoint:Realtype;
    nDir, nPrec:INTEGER;
    rSetp, rHighAlm, rLowAlm:Realtype;
    lpHighAlmMes, lpLowAlmMes:LPSTR;
    lpBarColor:LPTCOLORREF; lphAutoBar:PHGOBJ): HGOBJ; stdcall;

function WRSetAutoScrollGraph (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    rSampleInt, rRelResetInt, rMinVal, rMaxVal, rXRange:Realtype;
    nType, nPrec:INTEGER;
    rSetp, rHighAlm, rLowAlm:Realtype;
    lpXTitle:LPSTR; nPlotColor:INTEGER;
    lpLineColor:LPINT;
    bText:BOOL;
    lphAutoScroll:PHGOBJ): HGOBJ; stdcall;

function WRSetPIDBargraph (pGrDesc:PGRAPH_DEF;
    hPID:HCONT;
    rCenterPointMeas, rCenterPointOut:Realtype;
    nPrecMeas, nPrecOut:INTEGER;
    lpNorm, lpAuto, lpMan:LPSTR;
    lpBarColor:LPTCOLORREF;
    lphPidBar:PHGOBJ): HGOBJ; stdcall;

function WRSetAutoText (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    nValWidth, nPrec:INTEGER;
    lpColors:LPINT;
    lpDesc:LPSTR;
    lpFlags:LPBOOL;
    lphAutoText:PHGOBJ): HGOBJ; stdcall;

function WRSetAnnun (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    nValWidth, nPrec:INTEGER;
    lpChanColors:LPINT;
    lpRgbBackColors:LPTCOLORREF;
    rgbBackAlmColor:TCOLORREF;
    nNumRows, nNumColumns:INTEGER;
    lpFlags:LPBOOL;
    n3D:INTEGER): HGOBJ; stdcall;

    function WRSetAutoBargraph2 (pGrDesc:PGRAPH_DEF;
    thdata:HDATA; rMin, rMax, rCenterPoint:Realtype;
    nDir, nPrec, fontsize:INTEGER;
    rSetp, rHighAlm, rLowAlm:Realtype;
    lpHighAlmMes, lpLowAlmMes:LPSTR;
    lpBarColor:LPTCOLORREF; lphAutoBar:PHGOBJ): HGOBJ; stdcall;

function WRSetAutoScrollGraph2 (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    rSampleInt, rRelResetInt, rMinVal, rMaxVal, rXRange:Realtype;
    nType, nPrec, fontsize:INTEGER;
    rSetp, rHighAlm, rLowAlm:Realtype;
    lpXTitle:LPSTR; nPlotColor:INTEGER;
    lpLineColor:LPINT;
    bText:BOOL;
    lphAutoScroll:PHGOBJ): HGOBJ; stdcall;

function WRSetPIDBargraph2 (pGrDesc:PGRAPH_DEF;
    hPID:HCONT;
    rCenterPointMeas, rCenterPointOut:Realtype;
    nPrecMeas, nPrecOut, fontsize:INTEGER;
    lpNorm, lpAuto, lpMan:LPSTR;
    lpBarColor:LPTCOLORREF;
    lphPidBar:PHGOBJ): HGOBJ; stdcall;

function WRSetAutoText2 (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    nValWidth, nPrec, fontsize:INTEGER;
    lpColors:LPINT;
    lpDesc:LPSTR;
    lpFlags:LPBOOL;
    lphAutoText:PHGOBJ): HGOBJ; stdcall;

function WRSetAnnun2 (pGrDesc:PGRAPH_DEF;
    thdata:HDATA;
    nValWidth, nPrec, fontsize:INTEGER;
    lpChanColors:LPINT;
    lpRgbBackColors:LPTCOLORREF;
    rgbBackAlmColor:TCOLORREF;
    nNumRows, nNumColumns:INTEGER;
    lpFlags:LPBOOL;
    n3D:INTEGER): HGOBJ; stdcall;

function WRSetMeter (pGrDesc:PGRAPH_DEF;
     thdata:HDATA; nChan:INTEGER;
     rMin, rMax, rXCenter, rYCenter, rDiam:Realtype;
     nStartAngle, nEndAngle, nNeedleType:INTEGER;
     lpNeedleColor:LPINT;
      rTickRelSize, rTickSpace:Realtype;
      nSmallTicks, nTickPos, nLabelPos, nLabelPrec:INTEGER;
      bText:BOOL; nValPrec:INTEGER;
      bArc, bUnits, bAlarms:BOOL;
      rAlmRelThick:Realtype;
      lpAlmColor:LPINT): HGOBJ; stdcall;
                   
procedure WRSetMeterAlarmStartStop(pGrDesc:PGRAPH_DEF;
	   hMeter:HGOBJ; rStart, rStop:Realtype);  
	                      
function WRSetArcMeter (pGrDesc:PGRAPH_DEF;
     thdata:HDATA; nChan:INTEGER;
     rMin, rMax, rCenterPoint, rXCenter, rYCenter, rDiam:Realtype;
     nStartAngle, nEndAngle, nArcColor, nArcBackColor:INTEGER;
     rArcRelThick, rTickRelSize, rTickSpace:Realtype;
     nSmallTicks, nTickPos, nLabelPrec:INTEGER;
     bText:BOOL; nValPrec:INTEGER;
     bArc, bUnits, bAlarms:BOOL;
     rAlmRelThick:Realtype;
     lpAlmColor:LPINT): HGOBJ; stdcall;

function WRSetPieMeter (pGrDesc:PGRAPH_DEF;
     thdata:HDATA; nChan:INTEGER;
     rMin, rMax, rCenterPoint, rXCenter, rYCenter, rDiam:Realtype;
     nStartAngle, nEndAngle, nPieColor, nPieBackColor:INTEGER;
     rTickRelSize, rTickSpace:Realtype;
     nSmallTicks, nTickPos, nLabelPrec:INTEGER;
     bArc, bAlarms:BOOL;
     rAlmRelThick:Realtype;
     lpAlmColorL:LPINT): HGOBJ; stdcall;

procedure WRSetMeterBorder (pGrDesc:PGRAPH_DEF;
    hMeter:HGOBJ;
    rXCenter, rYCenter, rXWidth, rYHeight:Realtype;
    rgbBackColor:TCOLORREF;
    nBorderType, nBorderColor, nLineWidth:INTEGER); stdcall;

function WRSetScrBarControl (pGrDesc:PGRAPH_DEF;
    ScBarControlProc:TFARPROC; { FARPROC }
    rX1, rY1, rX2, rY2:Realtype;
    rgbBkColor:TCOLORREF;
    rScrollMin, rScrollMax, rSingleStep,
    rPageStep, rInitPos:Realtype): HGOBJ; stdcall;
Function WRChangeScrBar (pGrDesc: PGRAPH_DEF;  hScBar: HGOBJ;
     rScrollMin, rScrollMax, rSingleStep, rPageStep: Realtype): BOOL; stdcall;
Function WRGetScrBar (pGrDesc: PGRAPH_DEF; hScBar: HGOBJ;
    VAR lprMin, lprMax, lprSingleStep, lprPageStep: Realtype): BOOL; stdcall;

function WRSetButtonControl (pGrDesc:PGRAPH_DEF;
    ButControlProc:TFARPROC; { FARPROC }
    nStyle, nLook:INTEGER;
    rX1, rY1, rX2, rY2:Realtype;
    rgbBkColor:TCOLORREF;
    lpText:LPSTR;
    bTextLeft:BOOL): HGOBJ; stdcall;

function WRSetButtonGroup (pGrDesc:PGRAPH_DEF;
    ButControlProc:TFARPROC; { FARPROC }
    nLook:INTEGER;
    rX1, rY1, rX2, rY2:Realtype;
    rgbBkColor:TCOLORREF;
    nNumBut, nDir:INTEGER;
    lpText:LPSTR;
    bTextLeft:BOOL): HGOBJ; stdcall;

function WRSetLEDControl (pGrDesc:PGRAPH_DEF;
    rX, rY, rDiam:Realtype;
    rgbBkColor:TCOLORREF;
    nOnColor, nOffColor:INTEGER): HGOBJ; stdcall;

{************************************************************************}
{ Update }
{************************************************************************}
function WRStopObjTimeUpdate (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ): BOOL; stdcall;
function WRStartTimeLabelsUpdate (pGrDesc:PGRAPH_DEF;
    hLab:HGOBJ; hScroll:HGOBJ): BOOL; stdcall;
function WRStopTimeLabelsUpdate (pGrDesc:PGRAPH_DEF;
    hLab:HGOBJ; hScroll:HGOBJ): BOOL; stdcall;
procedure WRUpdateTimeLabels (pGrDesc:PGRAPH_DEF;
    hLab:HGOBJ; rTimeInc:Realtype); stdcall;
procedure WRResetTimeLabels (pGrDesc:PGRAPH_DEF;
    hLab:HGOBJ; rNewStart:Realtype); stdcall;
procedure WRUpdateObj (pGrDesc:PGRAPH_DEF; hDynObj:HGOBJ); stdcall;
function WRShowHist (pGrDesc:PGRAPH_DEF;
    hScroll:HGOBJ; rBack, rRange:Realtype;
    var lprActualBack:Realtype): BOOL; stdcall;

{**********************************************************************}
{ Alarms                                                               }
{**********************************************************************}
function WRSetAlarm (thdata:HDATA; nAlarmType:INTEGER;
     rAlmVal:Realtype;
     lpAlmMessage:LPSTR): BOOL; stdcall;

function WRSetSetpoint (thdata:HDATA; rSetp:Realtype): BOOL; stdcall;
procedure WREnableAlarmCheck (thdata:HDATA; bOn:BOOL); stdcall;
procedure WRSetAlarmProc (AlarmEventProc:TFARPROC); stdcall;
procedure WRSetAlarmHyst (thdata:HDATA; rHyst, rDevHyst:Realtype); stdcall;
function WRGetAlarm (thdata:HDATA; nAlarmType:INTEGER;
     var lprAlmVal:Realtype;
     lpbOn:LPBOOL;
     var lpAlmMessage:LPSTR): BOOL; stdcall;
function WRChangeAlarm (thdata:HDATA; nAlarmType:INTEGER;
     rAlmVal:Realtype;
     bOn:BOOL;
     lpAlmMessage:LPSTR): BOOL; stdcall;
function WRSetMessage (pGrDesc:PGRAPH_DEF; thdata:HDATA;
    nBinChanNum:INTEGER;
    rX, rY:Realtype;
    nBorderColor, nBorderWidth, nBackColor, nNumMes:INTEGER;
    lpMes:LPSTR; lpMesColor:LPINT): HGOBJ; stdcall;

{**********************************************************************}
{ Control }
{**********************************************************************}
procedure WRChangePIDSetp (hPID:HCONT; rNewSetp:Realtype); stdcall;
procedure WRGetPIDSetp (hPID:HCONT; var lprSetp:Realtype);  stdcall;
function WRGetPIDAutoState (hPID:HCONT): BOOL; stdcall;
procedure WRChangePIDAutoState (hPID:HCONT; bAuto:BOOL);  stdcall;
function WRChangePIDOut (hPID:HCONT; rOut:Realtype): BOOL; stdcall;

function WRDefinePID (hMeasData, hOutData:HDATA;
     lpTitle:LPSTR;
     rSetp, rProp, rIntg, rDeriv, rSteadyState, rMeasHigh,
     rMeasLow, rHighRange, rLowRange, rHighLimit,
     rLowLimit, rRateLim, rSamplePer, rFiltConst:Realtype;
     bIncInc:BOOL): HCONT; stdcall;

function WRCalcPID (hPID:HCONT; rMeas:Realtype; var lprOut:Realtype): BOOL; stdcall;

procedure WRChangePIDConstants (hPID:HCONT; rNewProp, rNewIntg, rNewDeriv:Realtype); stdcall;
procedure WRGetPIDConstants (hPID:HCONT; var lprProp, lprIntg, lprDeriv:Realtype); stdcall;
procedure WRChangePIDSteadyState (hPID:HCONT; rNewSteadyState:Realtype); stdcall;
procedure WRDeletePID (hPID:HCONT; bFreeData:BOOL); stdcall;
function WREditPIDDlg (hPID:HCONT): BOOL; stdcall;

{************************************************************************}
{ User interface functions **********************************************}
{************************************************************************}

function WRGetAlarmLineState (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    nAlarmType:INTEGER): BOOL; stdcall;
function WREnableAlarmLine (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
     nAlarmType:INTEGER; bOn:BOOL): BOOL; stdcall;
function WRChangeAlarmMarks (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    lpAlmName:LPSTR; nAlarmType:INTEGER;
     bOn:BOOL): BOOL; stdcall;
function WRGetAlarmMarks (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    var lpAlmName:LPSTR; nAlarmType:INTEGER): BOOL; stdcall;
function WRGetScrollGraphParams (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    var  lpSampleInt,
    lpResetInt, lpStep:Realtype): BOOL; stdcall;
function WRChangeScrollGraph (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    rSampleInt, rRelResetInt:Realtype; nStep:INTEGER): BOOL; stdcall;
function WRGetMessageParams (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    var lpMessage:LPSTR; var lpColor:INTEGER; n:INTEGER): BOOL; stdcall;
function WRChangeMessage (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    lpMessageL:LPSTR; nColor, n:INTEGER): BOOL; stdcall;
function  WRGetDynTextColor (pGrDesc:PGRAPH_DEF;
    thgobj:HGOBJ; n:INTEGER): INTEGER; stdcall;
function WRChangeDynTextColor (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ;
    nColor, n:INTEGER): BOOL; stdcall;
function WRGetAnnVal (pGrDesc:PGRAPH_DEF; hAnn:HGOBJ; n:INTEGER): HGOBJ; stdcall;
function WRGetAnnAlm (pGrDesc:PGRAPH_DEF; hAnn:HGOBJ; n:INTEGER): HGOBJ; stdcall;
function WRGetAnnUnits (pGrDesc:PGRAPH_DEF; hAnn:HGOBJ; n:INTEGER): HGOBJ; stdcall;
function WRGetAnnTitle (pGrDesc:PGRAPH_DEF; hAnn:HGOBJ): HGOBJ; stdcall;
function WRGetAnnTag (pGrDesc:PGRAPH_DEF; hAnn:HGOBJ; n:INTEGER): HGOBJ; stdcall;
function WRResumeScroll (pGrDesc:PGRAPH_DEF; hScroll:HGOBJ): BOOL; stdcall;
function WRMoveHistScroll (pGrDesc:PGRAPH_DEF;
    hScroll:HGOBJ; rInc:Realtype; var lprActualInc:RealType): BOOL; stdcall;
function WRSetScrollPos (pGrDesc:PGRAPH_DEF;
    hScBar:HGOBJ; rPos:Realtype): BOOL; stdcall;
procedure WRGetScrollPos (pGrDesc:PGRAPH_DEF; hScBar:HGOBJ; var lprPos:Realtype);
function WRGetButtonState (pGrDesc:PGRAPH_DEF; hBut:HGOBJ): INTEGER; stdcall;
function WRChangeButtonState (pGrDesc:PGRAPH_DEF; hBut:HGOBJ;
         nSel:INTEGER): INTEGER; stdcall;
procedure WRChangeButtonColor (pGrDesc:PGRAPH_DEF; hBut:HGOBJ; rgbNewColor:TCOLORREF;
        nSel:INTEGER); stdcall;
function WRGetButtonColor (pGrDesc:PGRAPH_DEF; hBut:HGOBJ; nSel:INTEGER): TCOLORREF; stdcall;
function WRChangeMeterRange (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
     rMin, rMax, rCenterPoint:Realtype; bUpdate:BOOL): BOOL; stdcall;
function WRGetMeterRange (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
    var lprMin, lprMax, lprCenter:Realtype): BOOL; stdcall;
function WRChangeMeterTicks (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
     rTickRelSize, rTickSpace:Realtype;
     nSmallTicks, nTickPos:INTEGER;
     bUpdate:BOOL): BOOL; stdcall;
function WRGetMeterTicks (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
    var lprTickRelSize, lprTickSpace:Realtype; var lpSmallTicks, lpTickPos:INTEGER): BOOL; stdcall;
function WRGetMeterCenter (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
     var lprXCenter, lprYCenter, lprDiam:Realtype): BOOL; stdcall;
function WRChangeMeterCenter (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
     rXCenter, rYCenter, rDiam:Realtype;
     bUpdate:BOOL): BOOL; stdcall;
function WRGetMeterAngles (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
    var lpStartAngle, lpEndAngle:INTEGER): BOOL; stdcall;
function WRChangeMeterAngles (pGrDesc:PGRAPH_DEF; hMeter:HGOBJ;
      nStartAngle, nEndAngle:INTEGER;
      bUpdate:BOOL): BOOL; stdcall;

{************************************************************************}
{ Miscellaneous *********************************************************}
{************************************************************************}
procedure WRDeleteRTGraph (pGrDesc:PGRAPH_DEF); stdcall;
procedure WRDeleteRTObject (pGrDesc:PGRAPH_DEF; thgobj:HGOBJ); stdcall;

function WRGetDynTypeSize (nObjType:INTEGER): INTEGER; stdcall;
procedure InitRTDll (lpTop:POINTER); stdcall;

procedure WRCleanup (bFreeData:BOOL); stdcall;
{************************************************************************}


// New Rev 3.0 Prototypes
// RTDATA.c
procedure  WRUpdateBinaryBlockData (hData: HDATA; lpnNewValues: PUINT;
     nSamp: INTEGER;  pGrDesc: PGRAPH_DEF); stdcall;
 function WRSetDynDataValidRange ( rMinNegValue, rMaxPosValue, rBadValue: Realtype):BOOL; stdcall;

// RTSup.c
//void WINAPI  WRProcessMouseEventAction(HWND hwnd, int nEvent, int nAction, UINT message, POINT ptMouse):
//void WINAPI  WRProcessMouseEvent(HWND hwnd, UINT message, POINT ptMouse):


// Alarms.c
 function WRCopyChAlarmsToDataSetAlarms(hData: HDATA; nChan: INTEGER):BOOL; stdcall;
 function WRSetAlarmCh (hData: HDATA;  nChan,  nAlarmType: INTEGER;
	 rAlmVal: Realtype; lpAlmMessage: PChar): BOOL; stdcall;
function WRSetSetpointCh (hData: HDATA; nChan: INTEGER;  rSetp: Realtype):BOOL; stdcall;
procedure WREnableAlarmCheckCh (hData: HDATA;  nChan: INTEGER;  bOn: BOOL); stdcall;
procedure WRSetAlarmHystCh (hData: HDATA;  nChan: INTEGER;  rHyst, rDevHyst: Realtype); stdcall;
function WRGetAlarmCh (hData: HDATA; nChan,  nAlarmType: INTEGER;
    VAR  lprAlmVal: Realtype; VAR lpbOn: BOOL;  lpAlmMessage: PChar):BOOL; stdcall;
 function WRChangeAlarmCh(hData: HDATA;
	 nChan, nAlarmType: INTEGER;  rAlmVal: Realtype;  bOn: BOOL;
         lpAlmMessage: PChar): BOOL; stdcall;
 function WRGetSetpoint (hData: HDATA; VAR lprSetpoint: Realtype): BOOL; stdcall;
 function WRGetSetpointCh (hData: HDATA;  nChan: INTEGER; VAR  rSetp: Realtype): BOOL; stdcall;
 function WRGetAlarmString (hData: HDATA;  nChan,
	   nAlarmType: INTEGER;  lpAlmMessage: PChar): BOOL; stdcall;
 function WRGetAlarmValue (hData: HDATA;  nChan, nAlarmType: INTEGER;
           VAR lprAlmVal: Realtype): BOOL; stdcall;
 function WRGetAlarmState (hData: HDATA;  nChan, nAlarmType: INTEGER;
              VAR lpbOn: BOOL):BOOL; stdcall;

// RText.c
 function WRSetAnnun3 (pGrDesc: PGRAPH_DEF;
	  hData: HDATA;  nValWidth, nPrec, nFontSize: INTEGER;
           lpChanColors: LPINT; lpRgbBackColors: COLORREF;
	   rgbLowAlmColor: COLORREF;  rgbHighAlmColor: COLORREF;
	    nNumRows,  nNumColumns: INTEGER;
             lpFlags: LPBOOL;  n3D: INTEGER): HGOBJ; stdcall;

// RTXY.x
 function WRSetXYScatterGraph (pGrDesc: PGRAPH_DEF; hData: HDATA;
	   nNumPoints: INTEGER;
     lpMarkerShape,  lpMarkerColor,  lpMarkerSize,
	 lpMarkerLineWidth, lpMarkerStyle: LPINT): HGOBJ; stdcall;

// SCROLL.C
 function WRSetScrollScatterGraph (pGrDesc: PGRAPH_DEF;
	hData: HDATA;  rSampleInt,  rRelResetInt: realtype;
	 nDir: INTEGER;  lpMarkerShape,   lpMarkerColor,
	 lpMarkerSize,  lpMarkerLineWidth,  lpMarkerStyle: LPINT): HGOBJ; stdcall;
procedure  WRSetScrollChannelAlarmColors(pGrDesc: PGRAPH_DEF;
			  hScroll,   hAlrmLine: HGOBJ); stdcall;
 function WRSetScrollMultiBarGraph (pGrDesc: PGRAPH_DEF;
	hData: HDATA;  rSampleInt,  rRelResetInt: realtype;
	 nDir: INTEGER;  lpLineColor: LPTCOLORREF;  rBarWidth, rBarBase,
	 rBarOffset: Realtype): HGOBJ; stdcall;
 function WRSetScrollComboGraph (pGrDesc: PGRAPH_DEF;
	hData: HDATA;  rSampleInt,  rRelResetInt: realtype;
	 nDir: INTEGER;  lpMarkerShape,	 lpMarkerColor,
	 lpMarkerSize,  lpMarkerLineWidth,
	 lpMarkerStyle: LPINT;  rBarWidth,
	 rBarBase, rBarOffset: realtype):  HGOBJ; stdcall;
procedure WRSetDynBitBltMode(pGrDesc: PGRAPH_DEF;
		       	  	hScroll: HGOBJ;  bBitBltMode: BOOL); stdcall;
  function WRGetDynBitBltMode(pGrDesc: PGRAPH_DEF;
       		  	hScroll: HGOBJ):BOOL; stdcall;
  function WRGetScrollChannelAlarmColors(pGrDesc: PGRAPH_DEF;
       		  	hScroll: HGOBJ): HGOBJ; stdcall;

// sweep.c
 function WRSetSweepScatterGraph (pGrDesc: PGRAPH_DEF;
    hData: HDATA;
     rSampleInt: Realtype;  nDir,
     nSweepLineColor:INTEGER;
	 lpMarkerShape,
	 lpMarkerColor,
	 lpMarkerSize,
	 lpMarkerLineWidth,
	 lpMarkerStyle: LPINT): HGOBJ; stdcall;
 function WRSetSweepComboGraph (pGrDesc: PGRAPH_DEF;
    hData: HDATA;  rSampleInt: realtype;  nDir,
     nSweepLineColor: INTEGER;  lpMarkerShape,
	 lpMarkerColor,  lpMarkerSize,
	 lpMarkerLineWidth,  lpMarkerStyle: LPINT;
	 rBarWidth,  rBarBase,
	 rBarOffset: realtype): HGOBJ; stdcall;

//scrvar.c
 function WRSetVarScatterScroll (pGrDesc: PGRAPH_DEF;
    hData: HDATA;  rRelResetInt: realtype;  nDir: INTEGER;
	 lpMarkerShape,  // linestyle
	 lpMarkerColor,  // line color
	 lpMarkerSize,
	 lpMarkerLineWidth,
	 lpMarkerStyle: LPINT): HGOBJ; stdcall;
 function WRSetVarComboScroll (pGrDesc: PGRAPH_DEF;
    hData: HDATA;  rRelResetInt: realtype;  nDir,
     nStep: INTEGER; 	 lpMarkerShape, lpMarkerColor,
	 lpMarkerSize,   lpMarkerLineWidth,
	 lpMarkerStyle: LPINT;  rBarWidth,
	 rBarBase,  rBarOffset: Realtype):HGOBJ; stdcall;

// rtbar.c
 function WRSetDynLineGraph (pGrDesc: PGRAPH_DEF;
        hData: HDATA;
        nDir, nStep: INTEGER;
	rFirst, rLast,  rWidth: realtype;
        nLineStyle,    nLineWidth,
        nLineColor: INTEGER): HGOBJ; stdcall;

// rtgui.c
 function WRGetSelectedChannel (pGrDesc: PGRAPH_DEF ): INTEGER; stdcall;
 function WRGetDynDataSet (pGrDesc: PGRAPH_DEF; hObj: HGOBJ ):HDATA; stdcall;


implementation
function WRDefineDynDataSet; external QCRTDLL;
procedure WRFreeDynDataSet; external QCRTDLL;
procedure WRUpdateData; external QCRTDLL;
procedure WRUpdateBlockData; external QCRTDLL;
procedure WRGetLastData; external QCRTDLL;
function WRGetHistData; external QCRTDLL;
procedure WRUpdateBinaryData; external QCRTDLL;
function WRGetBinData; external QCRTDLL;
procedure WRSetBit; external QCRTDLL;
procedure WRSetBitExclusive; external QCRTDLL;
function WRGetMinMaxValues; external QCRTDLL;
function WRReconnectDynDataSet; external QCRTDLL;
procedure WRResetHistBuffer; external QCRTDLL;
function WRSetScrollGraph; external QCRTDLL;
function WRSetVarScroll; external QCRTDLL;
function WRSetAlarmLines; external QCRTDLL;
function WRSetAlarmMarks; external QCRTDLL;
function WRSetAlarmText; external QCRTDLL;
function WRDynGrid; external QCRTDLL;
function WRSetXYGraph; external QCRTDLL;
function WRSetStackedGraph; external QCRTDLL;
function WRSetLogicGraph; external QCRTDLL;
function WRSetDynText; external QCRTDLL;
function WRLogicTags; external QCRTDLL;
function WRLogicTagsPtr; external QCRTDLL;
function WRAutoRescale; external QCRTDLL;
function WRDrawTimeAxis; external QCRTDLL;
function WRLabelTimeAxis; external QCRTDLL;
function WRChangeTimeLabelsFormat; external QCRTDLL;
function WRDynLegend; external QCRTDLL;
function WRDynLegendPtr; external QCRTDLL;
function WRSetScrollBargraph; external QCRTDLL;
function WRResetScroll; external QCRTDLL;
function WRSetSweepGraph; external QCRTDLL;
function WRSetBargraph; external QCRTDLL;
function WRSetAutoBargraph; external QCRTDLL;
function WRSetAutoScrollGraph; external QCRTDLL;
function WRSetPIDBargraph; external QCRTDLL;
function WRSetAutoText; external QCRTDLL;
function WRSetAnnun; external QCRTDLL;
function WRSetAutoBargraph2; external QCRTDLL;
function WRSetAutoScrollGraph2; external QCRTDLL;
function WRSetPIDBargraph2; external QCRTDLL;
function WRSetAutoText2; external QCRTDLL;
function WRSetAnnun2; external QCRTDLL;
procedure WRSetMeterAlarmStartStop; external QCRTDLL;
function WRSetMeter; external QCRTDLL;
function WRSetArcMeter; external QCRTDLL;
function WRSetPieMeter; external QCRTDLL;
procedure WRSetMeterBorder; external QCRTDLL;
function WRSetScrBarControl; external QCRTDLL;
function WRGetScrBar; external QCRTDLL;
function WRChangeScrBar; external QCRTDLL;
function WRSetButtonControl; external QCRTDLL;
function WRSetButtonGroup; external QCRTDLL;
function WRSetLEDControl; external QCRTDLL;
function WRStopObjTimeUpdate; external QCRTDLL;
function WRStartTimeLabelsUpdate; external QCRTDLL;
function WRStopTimeLabelsUpdate; external QCRTDLL;
procedure WRUpdateTimeLabels; external QCRTDLL;
procedure WRResetTimeLabels; external QCRTDLL;
procedure WRUpdateObj; external QCRTDLL;
function WRShowHist; external QCRTDLL;
function WRSetAlarm; external QCRTDLL;
function WRSetSetpoint; external QCRTDLL;
procedure WREnableAlarmCheck; external QCRTDLL;
procedure WRSetAlarmProc; external QCRTDLL;
procedure WRSetAlarmHyst; external QCRTDLL;
function WRGetAlarm; external QCRTDLL;
function WRChangeAlarm; external QCRTDLL;
function WRSetMessage; external QCRTDLL;
procedure WRChangePIDSetp; external QCRTDLL;
procedure WRGetPIDSetp; external QCRTDLL;
function WRGetPIDAutoState; external QCRTDLL;
procedure WRChangePIDAutoState; external QCRTDLL;
function WRChangePIDOut; external QCRTDLL;
function WRDefinePID; external QCRTDLL;
function WRCalcPID; external QCRTDLL;
procedure WRChangePIDConstants; external QCRTDLL;
procedure WRGetPIDConstants; external QCRTDLL;
procedure WRChangePIDSteadyState; external QCRTDLL;
procedure WRDeletePID; external QCRTDLL;
function WREditPIDDlg; external QCRTDLL;
function WRGetAlarmLineState; external QCRTDLL;
function WREnableAlarmLine; external QCRTDLL;
function WRChangeAlarmMarks; external QCRTDLL;
function WRGetAlarmMarks; external QCRTDLL;
function WRGetScrollGraphParams; external QCRTDLL;
function WRChangeScrollGraph; external QCRTDLL;
function WRGetMessageParams; external QCRTDLL;
function WRChangeMessage; external QCRTDLL;
function  WRGetDynTextColor; external QCRTDLL;
function WRChangeDynTextColor; external QCRTDLL;
function WRGetAnnVal; external QCRTDLL;
function WRGetAnnAlm; external QCRTDLL;
function WRGetAnnUnits; external QCRTDLL;
function WRGetAnnTitle; external QCRTDLL;
function WRGetAnnTag; external QCRTDLL;
function WRResumeScroll; external QCRTDLL;
function WRMoveHistScroll; external QCRTDLL;
function WRSetScrollPos; external QCRTDLL;
procedure WRGetScrollPos; external QCRTDLL;
function WRGetButtonState; external QCRTDLL;
function WRChangeButtonState; external QCRTDLL;
procedure WRChangeButtonColor; external QCRTDLL;
function WRGetButtonColor; external QCRTDLL;
function WRChangeMeterRange; external QCRTDLL;
function WRGetMeterRange; external QCRTDLL;
function WRChangeMeterTicks; external QCRTDLL;
function WRGetMeterTicks; external QCRTDLL;
function WRGetMeterCenter; external QCRTDLL;
function WRChangeMeterCenter; external QCRTDLL;
function WRGetMeterAngles; external QCRTDLL;
function WRChangeMeterAngles; external QCRTDLL;
procedure WRDeleteRTGraph; external QCRTDLL;
procedure WRDeleteRTObject; external QCRTDLL;
function WRGetDynTypeSize; external QCRTDLL;
procedure InitRTDll; external QCRTDLL;
procedure WRCleanup; external QCRTDLL;



procedure  WRUpdateBinaryBlockData; external QCRTDLL;
 function WRSetDynDataValidRange ; external QCRTDLL;

// RTSup.c
//void WINAPI  WRProcessMouseEventAction(HWND hwnd, int nEvent, int nAction, UINT message, POINT ptMouse):
//void WINAPI  WRProcessMouseEvent(HWND hwnd, UINT message, POINT ptMouse):

// Alarms.c
 function WRCopyChAlarmsToDataSetAlarms; external QCRTDLL;
 function WRSetAlarmCh; external QCRTDLL;
function WRSetSetpointCh ; external QCRTDLL;
procedure WREnableAlarmCheckCh; external QCRTDLL;
procedure WRSetAlarmHystCh; external QCRTDLL;
function WRGetAlarmCh; external QCRTDLL;
 function WRChangeAlarmCh; external QCRTDLL;
 function WRGetSetpoint; external QCRTDLL;
 function WRGetSetpointCh ; external QCRTDLL;
 function WRGetAlarmString ; external QCRTDLL;
 function WRGetAlarmValue ; external QCRTDLL;
 function WRGetAlarmState; external QCRTDLL;
 function WRSetAnnun3 ; external QCRTDLL;
  function WRSetXYScatterGraph ; external QCRTDLL;
  function WRSetScrollScatterGraph; external QCRTDLL;
procedure  WRSetScrollChannelAlarmColors; external QCRTDLL;
 function WRSetScrollMultiBarGraph ; external QCRTDLL;
 function WRSetScrollComboGraph ; external QCRTDLL;
procedure WRSetDynBitBltMode; external QCRTDLL;
  function WRGetDynBitBltMode; external QCRTDLL;
  function WRGetScrollChannelAlarmColors; external QCRTDLL;
  function WRSetSweepScatterGraph; external QCRTDLL;
 function WRSetSweepComboGraph; external QCRTDLL;
  function WRSetVarScatterScroll; external QCRTDLL;
 function WRSetVarComboScroll ; external QCRTDLL;
 function WRSetDynLineGraph ; external QCRTDLL;
  function WRGetSelectedChannel ; external QCRTDLL;
 function WRGetDynDataSet; external QCRTDLL;

{************************************************************************}


end.
