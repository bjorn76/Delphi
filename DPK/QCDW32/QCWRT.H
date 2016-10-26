/*************************************************************************/
/*                                                                       */
/*     Copyright (C) QUINN-CURTIS, Inc, 1994 - 1998                      */
/*                                                                       */
/*************************************************************************/
/**                                                                      */
/**   Filename :   qcwrt.h                                               */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/**                                                                      */
/**   Product  :   Windows Real Time Tools                               */
/**   Description: QC Windows Real Time Tools Definitions and            */
/**                Function Prototypes                                   */
/**                                                                      */
/*************************************************************************/

#ifndef  _QCRTH
#define  _QCRTH        1



#ifdef __cplusplus
extern  "C" {
#endif

#pragma pack(push, 8)

#define AXU_SEC     0       // time units codes for time axes
#define AXU_MIN     1
#define AXU_HOUR    2

// staircase style

#define NO_STEP    0
#define STEP_START 1
#define STEP_END   2

#define NORMAL_RTTRACE_COLOR_MODE 0
#define ALARM_RTTRACE_COLOR_MODE 1


              // alarm types 
#define ALM_OK    0
#define ALM_SETP  0
#define ALM_HIGH  1
#define ALM_LOW   2
#define ALM_HH    3
#define ALM_LL    4
#define ALM_RATE  5
#define ALM_DEV   6
#define ALM_FAIL  7

// meter subtypes
#define GOD_SUBT_NEEDLE   0       /* needle meter  */
#define GOD_SUBT_PIE      1       /* pie meter  */
#define GOD_SUBT_ARC      2       /* arc meter  */

/**********************************************************************/
/* Direction definitions                                              */
/**********************************************************************/

#define DYN_LEFT    0       // scroll or move from right to left
#define DYN_RIGHT   1 
#define DYN_UP      2 
#define DYN_DOWN    3 

/**************************************************************************/
/* Meter definitions*******************************************************/
/**************************************************************************/
// needle types

#define NEEDLE_LINE       0  // simple line
#define NEEDLE_THICK      1  // thick lline with circle
#define NEEDLE_SHORTF     2  // triangle with base at center - filled
#define NEEDLE_SHORTH     3  // triangle with base at center - hollow
#define NEEDLE_LONGF      4  // triangle with back plane - filled
#define NEEDLE_LONGH      5  // triangle with back plane - hollow

#define MET_NOBORDER     0
#define MET_RECT         1
#define MET_CIRC         2
#define MET_RD_RECT      3

/**************************************************************************/
/* Dynamic label types ****************************************************/
/**************************************************************************/
#define  DLB_NUMERIC   0
#define  DLB_HMS       1    // time format, hh:mm:ss. Prec ignored
#define  DLB_HM        2    // time format, hh:mm
#define  DLB_MS        4 

// CONTROL STYLES
         // logic
#define  BC_STYLE_PUSH       0       // like standard push button
#define  BC_STYLE_ONOFF      1       // 2 state
#define  BC_STYLE_XOR        2       // radio button logic
#define  BC_STYLE_PASSIVE    3       // cannot be pressed
         // appearance
#define  BC_LOOK_LOW    0            // standard pushbutton look
#define  BC_LOOK_HIGH   1            // "deep" pushbutton
#define  BC_LOOK_RADIO  2            // standard radio button
#define  BC_LOOK_CHECK  3            // "deep" check box
#define  BC_LOOK_LED    4            // LED

 /**************************************************************************/
/* Algorithm Definitions **************************************************/
/**************************************************************************/
#define  MAX_CBLOCKS 128

#define ALG_NONE    0
#define ALG_PID     1

// PID bargraph
// order of handles: 
#define PIDH_TITLE   0           // graph title  
#define PIDH_LEFTYAX 1           // left (measurement) Y axis
#define PIDH_LEFTLAB 2           // left (measurement) Y axis labels
#define PIDH_LEFTTIT 3           // left (measurement) Y axis title
#define PIDH_BARINP  4           // input (meas and setp) bargraph
#define PIDH_RIGHTYAX 5          // right (output) Y axis
#define PIDH_RIGHTLAB 6          // right (output) Y axis labels 
#define PIDH_RIGHTTIT 7          // right (output) Y axis title
#define PIDH_BAROUT   8          // output bargraph
#define PIDH_AM       9          // auto/manual message
#define PIDH_INPTEXT 10          // live text for measurement and setpoint
#define PIDH_INPTAGS 11          // tags for measurement and setpoint
#define PIDH_INPALMS 12          // alarm text for measurement and setpoint
#define PIDH_OUTTEXT 13          // live text for output
#define PIDH_OUTTAG  14          // tag for output
#define PIDH_OUTALMS 15          // alarm text for output

#define PID_NH       16   

// Auto bar objects
// order of handles: 
#define ABH_TITLE     0          // graph title  
#define ABH_FIRSTAX   1          // left (bottom) axis
#define ABH_FIRSTLAB  2          // left (bottom) axis labels
#define ABH_AXTIT     3          // left (bottom) axis title
#define ABH_BAR       4          // bargraph
#define ABH_LASTAX    5          // right (top)  axis
#define ABH_LASTLAB   6          // right (top) axis labels
#define ABH_TAGS      7          // tags 
#define ABH_TEXT      8          // live text 
#define ABH_ALMMARKS  9          // alarm marks
#define ABH_ALMTEXT  10          // alarm text 

#define AB_NH   11

// Auto scroll objects
// order of handles: 
#define ASH_TITLE     0          // graph title  
#define ASH_XAX       1          // X axis
#define ASH_XLAB      2          // X axis labels
#define ASH_XTIT      3          // X axis title
#define ASH_YAX       4          // Y axis
#define ASH_YLAB      5          // Y axis labels
#define ASH_YTIT      6          // Y axis title
#define ASH_SCROLL    7          // scrolling graph
#define ASH_TAGS      8          // tags 
#define ASH_TEXT      9          // live text 
#define ASH_ALMLINES 10          // alarm lines 

#define AS_NH   11

// Auto Text objects
// order of handles: 
#define ATH_TITLE     0          // graph title  
#define ATH_TAGS      1          // tags 
#define ATH_VALUES    2          // live text 
#define ATH_ALMTEXT   3          // alarm text 

#define AT_NH   4

/**************************************************************************/
/* FUNCTION PROTOTYPES ****************************************************/
/**************************************************************************/
/* Data functions *********************************************************/
/**************************************************************************/
HDATA WINAPI _export WRDefineDynDataSet (LPSTR lpTitle,
    int nNumChans, LPSTR lpUnits, LPSTR lpTags, int nHistSize);

BOOL WINAPI _export WRFreeDynDataSet (HDATA hData);
void WINAPI _export WRDrawScroll (PGRAPH_DEF pGrDesc, HGOBJ hDynObj);
void WINAPI _export WRUpdateData (HDATA hData, LPREAL lprNewValues, 
    PGRAPH_DEF pGrDesc);
void WINAPI _export WRUpdateBlockData (HDATA hData, LPREAL lprNewValues, 
    int nSamp, PGRAPH_DEF pGrDesc);
void WINAPI _export WRGetLastData (HDATA hData, LPREAL lprNewValues,
    LPREAL lprPrevValues);
int WINAPI _export WRGetHistData (HDATA hData, int nChan, 
    HPREAL lprUser, int nFirst, int nNumSamples);
void WINAPI _export WRUpdateBinaryData (HDATA hData, UINT wBinVal,
    PGRAPH_DEF pGrDesc);
UINT WINAPI _export WRGetBinData (HDATA hData);
void WINAPI _export WRSetBit (HDATA hData, int nChanNum, 
        BOOL bOn, PGRAPH_DEF pGrDesc);
void WINAPI _export WRSetBitExclusive (HDATA hData, int nChanNum, 
        PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WRGetMinMaxValues (HDATA hData, int nChan, 
    LPREAL lprMin, LPREAL lprMax);
BOOL WINAPI _export WRReconnectDynDataSet (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    HDATA hData);
void WINAPI _export WRResetHistBuffer (HDATA hData);

/**************************************************************************/
/* Dynamic graphical objects **********************************************/
/**************************************************************************/
HGOBJ WINAPI _export WRSetScrollGraph (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rSampleInt, realtype rRelResetInt, int nDir,    
    int nStep, LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

///////////////NEW OBJECT
HGOBJ WINAPI _export WRSetVarScroll (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rRelResetInt, int nDir,    
    int nStep, LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

HGOBJ WINAPI _export WRSetAlarmLines (PGRAPH_DEF pGrDesc, HDATA hData,
	int nUpdateSec, int nDir, BOOL FAR *lpbFlags, 
    LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

HGOBJ WINAPI _export WRSetAlarmMarks (PGRAPH_DEF pGrDesc, HDATA hData,
    HGOBJ hAxis, int nPos, int nMarkSize, BOOL FAR *lpbFlags, 
    int nLineWidth, LPINT lpLineColor, LPSTR lpNames);

HGOBJ WINAPI _export WRSetAlarmText (PGRAPH_DEF pGrDesc,
     HDATA hData, int nChan, realtype  rX1, realtype rY1, realtype rX2, 
     realtype rY2, int nBorderColor, int nBorderWidth, 
	 int nBackColor, LPSTR lpNormMes, LPINT lpTextColor, UINT wAlign, int nLayout);

HGOBJ WINAPI _export WRDynGrid (PGRAPH_DEF pGrDesc, HGOBJ hAxis,
    int nGridType, int nUpdateSec);

HGOBJ WINAPI _export WRSetXYGraph (PGRAPH_DEF pGrDesc, HDATA hData,
	int nNumPoints, 
    LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);
HGOBJ WINAPI _export WRSetStackedGraph (PGRAPH_DEF pGrDesc, HDATA hData,
    realtype rSampleInt, realtype rRelResetInt, int nDir, int nStep, 
    realtype rRelSize,
    LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

HGOBJ WINAPI _export WRSetLogicGraph (PGRAPH_DEF pGrDesc, HDATA hData,
	realtype rSampleInt, realtype rRelResetInt, int nDir, int nNumChannels,
	realtype rRelSize, LPINT lpLineStyle, LPINT lpLineWidth, 
	LPINT lpLineColor);

HGOBJ WINAPI _export WRSetDynText (PGRAPH_DEF pGrDesc,
     HDATA hData, int nChan, realtype rX1, realtype rY1,
     realtype  rX2, realtype rY2, int nBorderColor,
     int nBorderWidth, LPINT lpTextColor, int  nBackColor,  
     int nLayout, int nChar, int nPrec, HGOBJ hDynObj, int n3D);

HGOBJ WINAPI _export WRLogicTags (PGRAPH_DEF pGrDesc,
     int nBorderColor, int nBorderWidth, int nTextColor, 
     int nBackColor, HGLOBAL hStr, HGOBJ hLogObj);

HGOBJ WINAPI _export WRLogicTagsPtr (PGRAPH_DEF pGrDesc,
     int nBorderColor, int nBorderWidth, int nTextColor, 
     int nBackColor, LPSTR lpStr, HGOBJ hLogObj);

BOOL WINAPI _export WRAutoRescale (PGRAPH_DEF pGrDesc, HGOBJ hAxis,
    HDATA hData, int nChan, LPREAL lprMin, LPREAL lprMax, BOOL bUpdate);
HGOBJ WINAPI _export WRDrawTimeAxis (PGRAPH_DEF pGrDesc, 
    realtype rTickSpace, int nSmallTicks,
    int nTickPos, int nDir,  int nTimeUnits);
HGOBJ WINAPI _export WRLabelTimeAxis (PGRAPH_DEF pGrDesc, 
    HGOBJ hAxis, int nLabelPos, int nFormat,
    int nPrec, int nStartHour, int nStartMin, int nStartSec,
	realtype rStartNum, int nLast, LPSTR lpTextLast);
HGOBJ WINAPI _export WRDynLegend (PGRAPH_DEF pGrDesc, 
	 realtype  rX1, realtype  rY1, realtype  rX2, realtype  rY2,
	 int  nBorderColor, int nBorderWidth, int nTextColor,  int  nBackColor, 
	 int nLayout, HGLOBAL hStr, HGOBJ hDynObj, BOOL bSymbols);
HGOBJ WINAPI _export WRDynLegendPtr (PGRAPH_DEF pGrDesc, 
	 realtype  rX1, realtype  rY1, realtype  rX2, realtype  rY2,
	 int  nBorderColor, int nBorderWidth, int nTextColor,  int  nBackColor, 
	 int nLayout, LPSTR lpStr, HGOBJ hDynObj, BOOL bSymbols);
HGOBJ WINAPI _export WRSetScrollBargraph (PGRAPH_DEF pGrDesc,
    HDATA hData, int nChan, realtype rSampleInt, realtype rRelResetInt, int nDir,
    realtype rWidth, COLORREF rgbBarColor,
    int nBorderColor);
BOOL WINAPI _export WRResetScroll (PGRAPH_DEF pGrDesc, HGOBJ hScroll);

HGOBJ WINAPI _export WRSetSweepGraph (PGRAPH_DEF pGrDesc, HDATA hData,
	realtype rSampleInt, int nDir,    
	int nStep, int nSweepLineColor,
    LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

HGOBJ WINAPI _export WRSetBargraph (PGRAPH_DEF pGrDesc, HDATA hData,
	realtype rCenterPoint, int nDir, 
    realtype rFirst, realtype rLast, realtype rWidth,
    COLORREF FAR *lpBarColor, LPINT lpHatchStyle, LPINT lpBorderColor);

HGOBJ WINAPI _export WRSetAutoBargraph (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rMin, realtype rMax, realtype rCenterPoint,
    int nDir, int nPrec, realtype rSetp, realtype rHighAlm,
    realtype rLowAlm, LPSTR lpHighAlmMes, LPSTR lpLowAlmMes,
	COLORREF FAR *lpBarColor, PHGOBJ lphAutoBar);

HGOBJ WINAPI _export WRSetAutoBargraph2 (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rMin, realtype rMax, realtype rCenterPoint,
    int nDir, int nPrec, int nFontSize, realtype rSetp, realtype rHighAlm,
    realtype rLowAlm, LPSTR lpHighAlmMes, LPSTR lpLowAlmMes,
	COLORREF FAR *lpBarColor, PHGOBJ lphAutoBar);

HGOBJ WINAPI _export WRSetAutoScrollGraph (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rSampleInt, realtype rRelResetInt, 
    realtype rMinVal, realtype rMaxVal, realtype rXRange, 
    int nType, int nPrec, realtype rSetp, realtype rHighAlm,
    realtype rLowAlm, LPSTR    lpXTitle, int nPlotColor, 
    LPINT lpLineColor, BOOL bText,PHGOBJ lphAutoScroll);

HGOBJ WINAPI _export WRSetAutoScrollGraph2 (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rSampleInt, realtype rRelResetInt, 
    realtype rMinVal, realtype rMaxVal, realtype rXRange, 
    int nType, int nPrec, int nFontSize, realtype rSetp, realtype rHighAlm,
    realtype rLowAlm, LPSTR    lpXTitle, int nPlotColor, 
    LPINT lpLineColor, BOOL bText,PHGOBJ lphAutoScroll);

HGOBJ WINAPI _export WRSetPIDBargraph (PGRAPH_DEF pGrDesc,
    HCONT hPID, realtype rCenterPointMeas,
	realtype rCenterPointOut, int nPrecMeas, int nPrecOut,              
    LPSTR lpNorm, LPSTR lpAuto, LPSTR lpMan, 
    COLORREF FAR *lpBarColor, PHGOBJ lphPidBar);  

HGOBJ WINAPI _export WRSetPIDBargraph2 (PGRAPH_DEF pGrDesc,
    HCONT hPID, realtype rCenterPointMeas,
	realtype rCenterPointOut, int nPrecMeas, int nPrecOut, int nFontSize,
    LPSTR lpNorm, LPSTR lpAuto, LPSTR lpMan, 
    COLORREF FAR *lpBarColor, PHGOBJ lphPidBar);

HGOBJ WINAPI _export WRSetAutoText (PGRAPH_DEF pGrDesc,
    HDATA hData, int nValWidth, int nPrec, LPINT lpColors,
    LPSTR lpDesc, BOOL FAR *lpFlags, PHGOBJ lphAutoText);

HGOBJ WINAPI _export WRSetAutoText2 (PGRAPH_DEF pGrDesc,
    HDATA hData, int nValWidth, int nPrec, int nFontSize, LPINT lpColors,
    LPSTR lpDesc, BOOL FAR *lpFlags, PHGOBJ lphAutoText);

HGOBJ WINAPI _export WRSetAnnun (PGRAPH_DEF pGrDesc,
    HDATA hData, int nValWidth, int nPrec, LPINT lpChanColors,
    COLORREF FAR *lpRgbBackColors, COLORREF rgbBackAlmColor,
    int nNumRows, int nNumColumns, BOOL FAR *lpFlags, int n3D);
 
HGOBJ WINAPI _export WRSetAnnun2 (PGRAPH_DEF pGrDesc,
    HDATA hData, int nValWidth, int nPrec, int nFontSize, LPINT lpChanColors,
    COLORREF FAR *lpRgbBackColors, COLORREF rgbBackAlmColor,
    int nNumRows, int nNumColumns, BOOL FAR *lpFlags, int n3D);
void WINAPI _export WRSetMeterAlarmStartStop(PGRAPH_DEF pGrDesc,
	 HGOBJ  hMeter, realtype  rStart, 
	 realtype  rStop);           
 
HGOBJ WINAPI _export WRSetMeter (PGRAPH_DEF pGrDesc,
     HDATA hData, int  nChan, realtype  rMin, realtype rMax,    
     realtype  rXCenter, realtype rYCenter,   
     realtype  rDiam, int nStartAngle,
     int     nEndAngle, int nNeedleType, LPINT lpNeedleColor,  
     realtype  rTickRelSize, realtype  rTickSpace, int nSmallTicks, int nTickPos, 
     int nLabelPos, int nLabelPrec, BOOL bText, int nValPrec,
     BOOL bArc, BOOL bUnits, BOOL bAlarms, realtype rAlmRelThick, LPINT lpAlmColor);

HGOBJ WINAPI _export WRSetArcMeter (PGRAPH_DEF pGrDesc,
     HDATA hData, int nChan,      
     realtype  rMin,  realtype rMax, realtype  rCenterPoint,
     realtype  rXCenter, realtype rYCenter, realtype  rDiam, int nStartAngle, 
     int nEndAngle, int nArcColor, int nArcBackColor, realtype rArcRelThick,
     realtype  rTickRelSize, realtype  rTickSpace, int nSmallTicks, int nTickPos, 
     int nLabelPrec, BOOL bText, int nValPrec, BOOL bArc,      
     BOOL bUnits, BOOL bAlarms, realtype  rAlmRelThick, LPINT lpAlmColor);

HGOBJ WINAPI _export WRSetPieMeter (PGRAPH_DEF pGrDesc,
     HDATA hData, int  nChan,      
     realtype  rMin,  realtype rMax, realtype  rCenterPoint,
     realtype  rXCenter, realtype rYCenter, realtype rDiam, int nStartAngle,
     int  nEndAngle, int nPieColor,  int nPieBackColor, 
     realtype  rTickRelSize, realtype rTickSpace, int nSmallTicks, int nTickPos, 
     int  nLabelPrec, BOOL bArc, 
     BOOL bAlarms, realtype rAlmRelThick, LPINT lpAlmColor);

void WINAPI _export WRSetMeterBorder (PGRAPH_DEF pGrDesc,
    HGOBJ hMeter, realtype  rXCenter, realtype  rYCenter,
    realtype rXWidth, realtype rYHeight, 
    COLORREF rgbBackColor, int nBorderType,
    int nBorderColor, int nBorderWidth);

HGOBJ WINAPI _export WRSetScrBarControl (PGRAPH_DEF pGrDesc, 
    FARPROC ScBarControlProc, realtype rX1, realtype rY1, 
    realtype rX2, realtype rY2, COLORREF rgbBkColor,
    realtype rScrollMin, realtype rScrollMax, realtype rSingleStep, 
    realtype rPageStep, realtype rInitPos);

HGOBJ WINAPI _export WRSetButtonControl (PGRAPH_DEF pGrDesc, 
    FARPROC ButControlProc, int nStyle, int nLook,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, 
    COLORREF rgbBkColor, LPSTR lpText, BOOL bTextLeft);

HGOBJ WINAPI _export WRSetButtonGroup (PGRAPH_DEF pGrDesc, 
    FARPROC ButControlProc, int nLook,    
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, COLORREF rgbBkColor,
    int nNumBut, int nDir, LPSTR lpText, BOOL bTextLeft);

HGOBJ WINAPI _export WRSetLEDControl (PGRAPH_DEF pGrDesc, 
    realtype rX, realtype rY, realtype rDiam, COLORREF rgbBkColor,  
    int nOnColor, int nOffColor);

HGOBJ WINAPI _export WRSetMessage (PGRAPH_DEF pGrDesc, HDATA hData,       
    int     nBinChanNum, realtype  rX, realtype rY,
    int     nBorderColor, int nBorderWidth, int nBackColor,  
    int     nNumMes, LPSTR lpMes, LPINT lpMesColor);

/**************************************************************************/
/* Update */
/**************************************************************************/
BOOL WINAPI _export WRStopObjTimeUpdate (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WRStartTimeLabelsUpdate (PGRAPH_DEF pGrDesc,
    HGOBJ hLab, HGOBJ hScrollObj);
BOOL WINAPI _export WRStopTimeLabelsUpdate (PGRAPH_DEF pGrDesc,
    HGOBJ hLab, HGOBJ hScrollObj);
void WINAPI _export WRUpdateTimeLabels (PGRAPH_DEF pGrDesc,
    HGOBJ hLab, realtype rTimeInc);
void WINAPI _export WRResetTimeLabels (PGRAPH_DEF pGrDesc,
    HGOBJ hLab, realtype rNewStart);
BOOL WINAPI _export WRChangeTimeLabelsFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hLab, int nNewFormat);
void WINAPI _export WRUpdateObj (PGRAPH_DEF pGrDesc, HGOBJ hDynObj);
BOOL WINAPI _export WRShowHist (PGRAPH_DEF pGrDesc, 
    HGOBJ hScroll, realtype rBack, realtype rRange, LPREAL lprActualBack);

/************************************************************************/
/* Alarms                                                               */
/************************************************************************/
BOOL WINAPI _export WRSetAlarm (HDATA hData, int nAlarmType,
    realtype rAlmVal, LPSTR lpAlmMessage);

BOOL WINAPI _export WRSetSetpoint (HDATA hData, realtype rSetp);
void WINAPI _export WREnableAlarmCheck (HDATA hData, BOOL bOn);
void WINAPI _export WRSetAlarmProc (FARPROC AlarmEventProc);
void WINAPI _export WRSetAlarmHyst (HDATA hData, realtype rHyst,
	realtype rDevHyst);
BOOL WINAPI _export WRGetAlarm (HDATA hData, int nAlarmType, 
    LPREAL lprAlmVal, BOOL FAR *lpbOn, LPSTR FAR *lpAlmMessage);
BOOL WINAPI _export WRChangeAlarm (HDATA hData, int nAlarmType,
    realtype rAlmVal, BOOL bOn, LPSTR lpAlmMessage);

/************************************************************************/
/* Control */
/************************************************************************/
void WINAPI _export WRChangePIDSetp (HCONT hPID, realtype rNewSetp);
BOOL WINAPI _export WRGetPIDSetp (HCONT hPID, LPREAL lprSetp);
BOOL WINAPI _export WRGetPIDAutoState (HCONT hPID);
void WINAPI _export WRChangePIDAutoState (HCONT hPID, BOOL bAuto);
BOOL WINAPI _export WRChangePIDOut (HCONT hPID, realtype rOut);

HCONT WINAPI _export WRDefinePID (HDATA hMeasData, HDATA hOutData, 
     LPSTR  lpTitle, realtype rSetp, realtype rProp, 
     realtype rIntg, realtype rDeriv, realtype rSteadyState, realtype rMeasHigh, 
     realtype rMeasLow, realtype rHighRange, realtype rLowRange, realtype rHighLimit, 
     realtype rLowLimit, realtype rRateLim, realtype rSamplePer, 
     realtype rFiltConst, BOOL bIncInc);

BOOL WINAPI _export WRCalcPID (HCONT hPID, realtype rMeas, LPREAL lprOut);

void WINAPI _export WRChangePIDConstants (HCONT hPID, realtype rNewProp,
    realtype rNewIntg, realtype rNewDeriv);
BOOL WINAPI _export WRGetPIDConstants (HCONT hPID, LPREAL lprProp,
    LPREAL lprIntg, LPREAL lprDeriv);
void WINAPI _export WRChangePIDSteadyState (HCONT hPID, realtype rNewSteadyState);
void WINAPI _export WRDeletePID (HCONT hPID, BOOL bFreeData);
BOOL WINAPI _export WREditPIDDlg (HCONT hPID);

/**************************************************************************/
/* User interface functions ***********************************************/
/**************************************************************************/

BOOL WINAPI _export WRGetAlarmLineState (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
    int nAlarmType);
BOOL WINAPI _export WREnableAlarmLine (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
     int nAlarmType, BOOL bOn);
BOOL WINAPI _export WRChangeAlarmMarks (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPSTR lpAlmName, int nAlarmType, BOOL bOn);
BOOL WINAPI _export WRGetAlarmMarks (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPSTR FAR *lpAlmName, int nAlarmType);
BOOL WINAPI _export WRGetScrollGraphParams (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lpSampleInt, LPREAL lpResetInt, LPINT lpStep);
BOOL WINAPI _export WRChangeScrollGraph (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    realtype rSampleInt, realtype rRelResetInt, int nStep);
BOOL WINAPI _export WRGetMessageParams (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPSTR FAR *lpMessage, LPINT lpColor, int n);
BOOL WINAPI _export WRChangeMessage (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPSTR lpMessage, int nColor, int n);
int WINAPI _export WRGetDynTextColor (PGRAPH_DEF pGrDesc, 
    HGOBJ hObj, int n);
BOOL WINAPI _export WRChangeDynTextColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nColor, int n);
HGOBJ WINAPI _export WRGetAnnVal (PGRAPH_DEF pGrDesc, HGOBJ hAnn, 
    int n);
HGOBJ WINAPI _export WRGetAnnAlm (PGRAPH_DEF pGrDesc, HGOBJ hAnn, 
    int n);
HGOBJ WINAPI _export WRGetAnnUnits (PGRAPH_DEF pGrDesc, HGOBJ hAnn, 
    int n);
HGOBJ WINAPI _export WRGetAnnTitle (PGRAPH_DEF pGrDesc, HGOBJ hAnn);
HGOBJ WINAPI _export WRGetAnnTag (PGRAPH_DEF pGrDesc, HGOBJ hAnn, 
    int n);
BOOL WINAPI _export WRResumeScroll (PGRAPH_DEF pGrDesc, HGOBJ hScroll);
BOOL WINAPI _export WRMoveHistScroll (PGRAPH_DEF pGrDesc, 
    HGOBJ  hScroll, realtype rInc, LPREAL lprActualInc);
BOOL WINAPI _export WRSetScrollPos (PGRAPH_DEF pGrDesc, 
   HGOBJ hScBar, realtype rPos);
void WINAPI _export WRGetScrollPos (PGRAPH_DEF pGrDesc, HGOBJ hScBar, 
    LPREAL lprPos);
BOOL WINAPI _export WRGetScrBar (PGRAPH_DEF pGrDesc, HGOBJ hScBar, 
    LPREAL lprMin, LPREAL lprMax, LPREAL lprSingleStep, LPREAL lprPageStep);
BOOL WINAPI _export WRChangeScrBar (PGRAPH_DEF pGrDesc, HGOBJ hScBar, 
    realtype rScrollMin, realtype rScrollMax, realtype rSingleStep, 
    realtype rPageStep);
int WINAPI _export WRGetButtonState (PGRAPH_DEF pGrDesc, HGOBJ hBut);
int WINAPI _export WRChangeButtonState (PGRAPH_DEF pGrDesc, 
    HGOBJ hBut, int nSel);
void WINAPI _export WRChangeButtonColor (PGRAPH_DEF pGrDesc, 
    HGOBJ hBut, COLORREF rgbNewColor, int nSel);
COLORREF WINAPI _export WRGetButtonColor (PGRAPH_DEF pGrDesc, 
    HGOBJ hBut, int nSel);
BOOL WINAPI _export WRChangeMeterRange (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    realtype rMin, realtype rMax, realtype rCenterPoint, BOOL bUpdate);
BOOL WINAPI _export WRGetMeterRange (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    LPREAL lprMin, LPREAL lprMax, LPREAL lprCenter);
BOOL WINAPI _export WRChangeMeterTicks (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    realtype rTickRelSize, realtype rTickSpace, int nSmallTicks, 
    int nTickPos, BOOL bUpdate);
BOOL WINAPI _export WRGetMeterTicks (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    LPREAL lprTickRelSize, LPREAL lprTickSpace, 
    LPINT lpSmallTicks, LPINT lpTickPos);
BOOL WINAPI _export WRGetMeterCenter (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    LPREAL lprXCenter, LPREAL lprYCenter, LPREAL lprDiam);
BOOL WINAPI _export WRChangeMeterCenter (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    realtype rXCenter, realtype rYCenter, realtype rDiam, BOOL bUpdate);
BOOL WINAPI _export WRGetMeterAngles (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
    LPINT lpStartAngle, LPINT lpEndAngle);
BOOL WINAPI _export WRChangeMeterAngles (PGRAPH_DEF pGrDesc, HGOBJ hMeter,
     int nStartAngle, int nEndAngle, BOOL bUpdate);
HWND WINAPI _export WRGetButtonWindow (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);

/**************************************************************************/
/* Miscellaneous **********************************************************/
/**************************************************************************/
void WINAPI _export WRDeleteRTGraph (PGRAPH_DEF pGrDesc);
void WINAPI _export WRDeleteRTObject (PGRAPH_DEF pGrDesc, HGOBJ hObj);

int WINAPI _export WRGetDynTypeSize (int nObjType);
void WINAPI _export InitRTDll (LPVOID lpTop);

void WINAPI WRCleanup (BOOL bFreeData);
/**************************************************************************/



// New Rev 3.0 Prototypes
// RTDATA.c
void WINAPI _export WRUpdateBinaryBlockData (HDATA hData, UINT *lpnNewValues, 
    int nSamp, PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WRSetDynDataValidRange (realtype rMinNegValue,
											realtype rMaxPosValue,
											realtype rBadValue);

// RTSup.c
void WINAPI  WRProcessMouseEventAction(HWND hwnd, int nEvent, int nAction, UINT message, POINT ptMouse);
void WINAPI  WRProcessMouseEvent(HWND hwnd, UINT message, POINT ptMouse);


// Alarms.c
BOOL WINAPI _export WRCopyChAlarmsToDataSetAlarms(HDATA hData, int nChan);
BOOL WINAPI _export WRSetAlarmCh (HDATA hData, int nChan, int nAlarmType,
	realtype rAlmVal, LPSTR lpAlmMessage);
BOOL WINAPI _export WRSetSetpointCh (HDATA hData, int nChan, realtype rSetp);
void WINAPI _export WREnableAlarmCheckCh (HDATA hData, int nChan, BOOL bOn); 
void WINAPI _export WRSetAlarmHystCh (HDATA hData, int nChan, realtype rHyst, realtype rDevHyst); 
BOOL WINAPI _export WRGetAlarmCh (HDATA hData, int nChan, int nAlarmType, 
    LPREAL lprAlmVal, BOOL FAR *lpbOn, LPSTR FAR *lpAlmMessage);  
BOOL WINAPI _export WRChangeAlarmCh(HDATA hData, 
	int nChan,int nAlarmType,realtype rAlmVal,BOOL bOn,	LPSTR lpAlmMessage);
BOOL WINAPI _export WRGetSetpoint (HDATA hData, LPREAL lprSetpoint);
BOOL WINAPI _export WRGetSetpointCh (HDATA hData, int nChan, LPREAL rSetp);
BOOL WINAPI _export WRGetAlarmString (HDATA hData, int nChan, 
									  int nAlarmType,  LPSTR FAR *lpAlmMessage) ; 
BOOL WINAPI _export WRGetAlarmValue (HDATA hData, int nChan, 
									  int nAlarmType,  LPREAL lprAlmVal);  
BOOL WINAPI _export WRGetAlarmState (HDATA hData, int nChan, 
									  int nAlarmType,  LPBOOL lpbOn);  

// RText.c
HGOBJ WINAPI _export WRSetAnnun3 (PGRAPH_DEF pGrDesc,
	HDATA  hData, int nValWidth, int    nPrec, 
    int   nFontSize, LPINT lpChanColors, COLORREF FAR *lpRgbBackColors,
	COLORREF rgbLowAlmColor, COLORREF rgbHighAlmColor,
	int     nNumRows, int nNumColumns, BOOL FAR *lpFlags, int n3D);

// RTXY.x
HGOBJ WINAPI _export WRSetXYScatterGraph (PGRAPH_DEF pGrDesc, HDATA hData,
	int   nNumPoints, 
    LPINT lpMarkerShape, LPINT lpMarkerColor, LPINT lpMarkerSize,
	LPINT lpMarkerLineWidth,
    LPINT lpMarkerStyle);

// SCROLL.C
HGOBJ WINAPI _export WRSetScrollScatterGraph (PGRAPH_DEF pGrDesc, 
	HDATA hData, realtype rSampleInt, realtype rRelResetInt,
	int nDir, LPINT lpMarkerShape,  LPINT lpMarkerColor,  
	LPINT lpMarkerSize, LPINT lpMarkerLineWidth, LPINT lpMarkerStyle); 
void  WINAPI _export WRSetScrollChannelAlarmColors(PGRAPH_DEF pGrDesc, 
						  HGOBJ	hScroll,
						  HGOBJ hAlrmLine);
HGOBJ WINAPI _export WRSetScrollMultiBarGraph (PGRAPH_DEF pGrDesc, 
	HDATA hData, realtype rSampleInt, realtype rRelResetInt,
	int nDir, COLORREF *lpLineColor, realtype rBarWidth,realtype rBarBase,
	realtype rBarOffset);
HGOBJ WINAPI _export WRSetScrollComboGraph (PGRAPH_DEF pGrDesc, 
	HDATA hData, realtype rSampleInt, realtype rRelResetInt,
	int nDir, LPINT lpMarkerShape,	LPINT lpMarkerColor, 
	LPINT lpMarkerSize, LPINT lpMarkerLineWidth,
	LPINT lpMarkerStyle, realtype rBarWidth,
	realtype rBarBase,realtype rBarOffset);
void  WINAPI _export WRSetDynBitBltMode(PGRAPH_DEF pGrDesc, 
						  HGOBJ	hScroll, BOOL bBitBltMode);
BOOL  WINAPI _export WRGetDynBitBltMode(PGRAPH_DEF pGrDesc, 
						  HGOBJ	hScroll);
HGOBJ  WINAPI _export WRGetScrollChannelAlarmColors(PGRAPH_DEF pGrDesc, 
						  HGOBJ	hScroll);

// sweep.c
HGOBJ WINAPI _export WRSetSweepScatterGraph (PGRAPH_DEF pGrDesc, 
    HDATA hData,
	realtype rSampleInt, int nDir,    
    int nSweepLineColor, 
	LPINT lpMarkerShape,  
	LPINT lpMarkerColor, 
	LPINT lpMarkerSize,   
	LPINT lpMarkerLineWidth,
	LPINT lpMarkerStyle);
HGOBJ WINAPI _export WRSetSweepComboGraph (PGRAPH_DEF pGrDesc, 
    HDATA hData, realtype rSampleInt, int nDir,    
    int nSweepLineColor, LPINT lpMarkerShape, 
	LPINT lpMarkerColor, LPINT lpMarkerSize,   
	LPINT lpMarkerLineWidth, LPINT lpMarkerStyle,
	realtype rBarWidth,	realtype rBarBase,
	realtype rBarOffset) ;

//scrvar.c
HGOBJ WINAPI _export WRSetVarScatterScroll (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rRelResetInt, int nDir,    
	LPINT lpMarkerShape,  // linestyle
	LPINT lpMarkerColor,  // line color
	LPINT lpMarkerSize,   
	LPINT lpMarkerLineWidth,
	LPINT lpMarkerStyle);
HGOBJ WINAPI _export WRSetVarComboScroll (PGRAPH_DEF pGrDesc,
    HDATA hData, realtype rRelResetInt, int nDir,    
    int nStep, 	LPINT lpMarkerShape,LPINT lpMarkerColor,  
	LPINT lpMarkerSize,  LPINT lpMarkerLineWidth,
	LPINT lpMarkerStyle, realtype rBarWidth,
	realtype rBarBase,	realtype rBarOffset);

// rtbar.c
HGOBJ WINAPI _export WRSetDynLineGraph (PGRAPH_DEF pGrDesc,
    HDATA    hData, 
    int      nDir, 
	int      nStep,
	realtype rFirst, 
    realtype rLast, realtype rWidth,  
	int      nLineStyle, int   nLineWidth, 
	int      nLineColor);

// rtgui.c
int WINAPI _export WRGetSelectedChannel (PGRAPH_DEF pGrDesc);		
HDATA WINAPI _export WRGetDynDataSet (PGRAPH_DEF pGrDesc, HGOBJ hObj);

/************************************************************************/
/************************************************************************/
#pragma pack(pop)

#ifdef __cplusplus
}
#endif


/**************************************************************************/
#endif


