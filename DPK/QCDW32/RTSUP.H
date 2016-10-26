/********************************************************************/
/*                                                                  */
/*     Copyright (C) QUINN-CURTIS, Inc, 1994 - 1998                 */
/*                                                                  */
/********************************************************************/
/**                                                                 */
/**   Filename :   rtsup.h                                          */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/**   Product  :   Real Time Graphics Tools for Windows             */
/**                                                                 */
/**   Description:  Prototypes for RT support routines              */
/**                                                                 */
/********************************************************************/

#ifndef  _RTSUPPH
#define  _RTSUPPH        1
#pragma pack(push, 8)

#ifdef __cplusplus
extern  "C" {
#endif

#include "qcdde.h"               // dde definitions

/**************************************************************************/
#define  DATABUFSIZE 1024
#define  DDE_OK     0
#define  DDE_FAIL   1

#define  MAX_CONV    5
#define  MAX_LINKS  16            // max. # of items per conversation


#define ID_RTTIMER 61111         // internal timer id  - 

#define MAX_TIMELST 200          // max. # of items in the timer list
#define DEFTIMEOUT  3000         // 3 seconds

// #define NPOL  14                 // segment length for Wave algorithm
#define NPOL  100                 // segment length for Wave algorithm

#define HR  3600L        		 /* # of secs in one hour */
#define MIN 60L 		         /* # of secs in one minute */

#define LYHIGH 32000L
#define LYLOW  -20000L

#define DEGREE M_PI / 180.0      // 1 degree in radians   

#define  BAR_RATIO  0.04
#define  METER_RATIO  12          // ratio of needle lengths of different channels
#define  METER_CENTER_RAD  0.05   // 

// subtypes for child controls
#define CHC_SCRBAR   0            // scrolling bar
#define CHC_PBUTTON  1            // PUSHBUTTON
#define CHC_DPBUTTON 2            // Default PUSHBUTTON
#define CHC_RBUTTON  3            // RADIOBUTTON
#define CHC_CBOX     4            // CHECKBOX
#define CHC_OWNER    5            // OWNER DRAW
#define CHC_GBUTTON  6            // Group Button
#define CHC_LED      7            // Led

// subtypes for scroll graphs


#define COMBO_LINE 1
#define COMBO_SCATTER 5
#define COMBO_MULTIBAR 6
#define COMBO_FILLED 7
#define SCROLLGRAPH_COMBO 8


// subtypes for dyn graphs (bar and line

#define DYNGRAPH_BAR 3
#define DYNGRAPH_SCATTER 2
#define DYNGRAPH_LINE 1

// scaling types
#define SCALE_Y     0       // Y only
#define SCALE_NN    1
#define SCALE_S_L   2
#define SCALE_SF_LN 3
#define SCALE_SF_LH 4
#define SCALE_LN_SF 5
#define SCALE_LF_S  6
#define SCALE_HIST  7

              // alarm masks
#define ALMMASK_OK      0
#define ALMMASK_SETP    0
#define ALMMASK_HIGH    1
#define ALMMASK_LOW     2
#define ALMMASK_HH      4
#define ALMMASK_LL      8
#define ALMMASK_RATE   16
#define ALMMASK_DEV    32
#define ALMMASK_FAIL   64

// Alarm bits
// 7    6    5   4    3  2   1   0
//     FAIL DEV RATE LL HH LOW HIGH
//
/**************************************************************************/
// Control definitions

#define PID_AUTO    1
#define PID_MAN     2

/**************************************************************************/
// DIRECTIONS:

#define DIR_LR  0
#define DIR_RL  1
#define DIR_TB  2
#define DIR_BT  3

/***************************************************************************/
typedef struct              // item connection descriptor
{
    HSZ   hszItem;          // handle of item name string
    HDATA hData;            // data set handle
	DYNDATA_DEF FAR *lpDataDesc;  // pointer to data set descriptor

//    short nGrNum;           // group member number (for single item,
//                            // otherwise must be -1)
	short nVal;             // number of values in the item
}
DDEITEM;
typedef DDEITEM far *PDDEITEM;

/**************************************************************************/
typedef struct              // Data set's DDE descriptor
{
    BOOL     bAutoUpdate;   // if TRUE, update object when new value arrives
//	PDDEITEM lpItemDesc [DYN_MAXVAL];
}
DDEDAT;

/**************************************************************************/
typedef struct     
{
    PDYNDATA lpDDS[MAX_DYNSETS];   // array of pointers to descriptors
                                   // of dynamic data sets

    LPVOID lpControlDS[MAX_CBLOCKS]; // array of pointers to descriptors
                                     // of control blocks
    FARPROC lpfnAlarmCallback;       // alarm callback procedure
    FARPROC lpfnDdeCallback;         // DDE callback procedure
}
RTTOP_DEF;
typedef RTTOP_DEF FAR *PRTTOP;

/**************************************************************************/
typedef struct              // DDE conversation descriptor
{
    HCONV hConv;            // Conversation handle
    HSZ   hszApp;           // hanlde of service name string
    HSZ   hszTopic;         // hanlde of topic name string
    short nUseCount;        // usage counter
    PDDEITEM pDdeDesc[MAX_LINKS];
}
DDECONV_DESC;
typedef DDECONV_DESC far *PCONV_DESC;

typedef struct                     // dynamic element descriptor
{
    HINSTANCE   hAppInst;          // instance of application.
    PGRAPH_DEF  pGrDesc;           // identifies object in the timer list 
    PDYNOBJ_HEAD pObjDesc;
}
TIMER_ITEM;


/**************************************************************************/
typedef struct                   /* Legend object */
{
    DYNOBJ_HEAD  header;
    TEXTDESC  tdesc;               // font for legends
    int     nNumObjects;         // number of objects
    int     nMaxChar;            // Max legend length (characters)   
    int     nLongest;            // Number of the longest legend
    long      nBackColor;
    int       cxMaxExt;            // width of the widest field
    int       cyChar;              // screen character height
    int       cxWidth;             // width of one legend field
    int     nLayout;             // OR_VERT or OR_HORZ
    int     nLegType;            // LG_CHART or LG_GROUP
    BOOL      bBorder;             // legend rectangle border flag
    LPSTR     pLegends;
    BOOL      cNoSym;              // if 1, do not draw symbols
	int		  nMarkerLogSize[MAXLEGEND]; // debbie fix

	COLORREF  pLegTextColor[MAXLEGEND]; // UPGRADE7 [DMB]
	int		  pLegSymShape[MAXLEGEND];  // UPGRADE7 [DMB]
	COLORREF  pLegSymColor[MAXLEGEND];  // UPGRADE7 [DMB]

	int		  pLegSymSize[MAXLEGEND];
	int		  pLegSymStyle[MAXLEGEND];
	BOOL	  bFlex;				// UPGRADE7 [DMB]
	BOOL	  bSym;					// UPGRADE7 [DMB]
	int		  nSelSym;				// UPGRADE7 [DMB] - index of selected symbol  
	LEGEND_DESC  ldesc[2];     
}
DYNOBJ_LEGEND;

/**************************************************************************/

/****************************************************************************************/
/*	PID  data descriptor    */
/****************************************************************************************/
typedef struct 	
{									    
    WORD	 wAlgType;		   // algorithm type
    HCONT    hPID;             // PID block's handle
    char     szTitle [DYNTITLELEN]; // descriptor
    HDATA    hMeasData;        // handle of the related input data set 
    HDATA    hOutData;         // handle of the related output data set 
    PDYNDATA lpMeasDataDesc;   // pointer to associated input data set descriptor (can be NULL)
    PDYNDATA lpOutDataDesc;    // pointer to associated output data set descriptor (can be NULL)
    realtype rSamplePeriod,    /* time between updates, in minutes */
             rHighRange,       /* high range of the PID output (100 %) in output eng. units */
             rLowRange,        /* low range of the PID output  ( 0 % ) */
             rHighLimit,       /* high limit of the PID output, for clamping */
             rLowLimit,        /* low limit of the PID output, for clamping  */
             rOut,  		   /* PID Algorithm output */
             rMeas,		       /* measurement (input)		   */
             rSetp,            /* setpoint */ 
             rSteadyState,     /* bias */
             rMeasHighRange,   /* high range of the PID input (100 %) in meas. eng. units */
             rMeasLowRange,    /* low range of the PID input ( 0 % ) */
             rNewErr,   
             rOldErr,   
	         e1, e2, e3,       /* error terms t-1, t-2 and t-3 */
	         rErrSum;          /* sum of all previous errors */
    realtype rRateLim;         /* limit of output rate of change      */
	realtype rLastFM;          /* previous filtered measurement value */
	realtype rFiltConst;       /* Filter constant (0.0 - 1.0 ) */
    realtype rScaleCoef; 	   /* */

    realtype rProp;            /* proportional gain */
    realtype rKi;	           /* integral action constant */
    realtype rKd;	           /* derivative constant */
    BOOL     bInc;             // inc/inc flag
    BOOL     bAuto;            // Auto/manual flag
} PID_DEF;

typedef PID_DEF far *PPID;    // pointer to PID descriptor

/*********************************************************************/
// Drawing and update functions 
BOOL NT4Check(void);
BOOL NPolyline(HDC hdc, POINT *lppt, int cPoints);
BOOL  SmallBlockPolyline( HDC  hdc,	POINT * lppt, int  cPoints);

void _cdecl _export DrawScroll (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl _export DrawVarScroll (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl _export DrawSweep (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl UpdateScroll (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void _cdecl UpdateVarScroll (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void _cdecl UpdateSweep (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void _cdecl _export DrawNothing (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl _export UpdateNothing (PGRAPH_DEF pGrDesc,  
    PDYNOBJ_HEAD pObjDesc);
void DrawGrid (PGRAPH_DEF pGrDesc, HDC hdc, OBJ_AX FAR *pAxDesc);
void _cdecl _export DrawDynLabels (PGRAPH_DEF pGrDesc, HDC hdc,
	DYNOBJ_LABELS FAR *pObjDesc);
void _cdecl UpdateDynLabels (PGRAPH_DEF pGrDesc, 
    DYNOBJ_LABELS FAR *pObjDesc, realtype rTimeInc); 
int  rtBarParams (DYNOBJ_BAR FAR *pObjDesc,
    PGRAPH_DEF pGrDesc);
void UpdateTraces (PGRAPH_DEF pGrDesc, HDC hdc,  DYNOBJ_SCROLL FAR *pObjDesc, 
    COLORREF rgbBack, BOOL bRev);
void UpdateObj (PGRAPH_DEF pGrDesc, HGOBJ hDynObj);
void QCInvalidateRect (PGRAPH_DEF pGrDesc, LPRECT lprc);
// void InvalidatePlot (PGRAPH_DEF pGrDesc);
void ScrollLabelsUpdate (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc, int n);
void StartScrollUpdate (DYNOBJ_SCROLL FAR *pObjDesc, HDC hdc, LPRECT prc);
void UpdateOneTrace (PGRAPH_DEF pGrDesc, HDC hdc, 
    DYNOBJ_SCROLL FAR *pObjDesc, int n, int nStart);
void ResetScroll (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc, 
    int nNewMaxDispPts, realtype rRange, int nRescaleType);
int ChangeNumPoints (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc, 
    realtype rIndRange, LPINT lpRescaleType, HGOBJ hAx);
void CopyHistScroll (DYNOBJ_SCROLL FAR *pObjDesc, HPFLOAT hpTemp, 
    int nOldDispPts, int nNewMaxDispPts, int nRescaleType);
void AdjustTimeLabels (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL  FAR *pObjDesc, 
    realtype rBack, BOOL bRescale, realtype rRange, realtype rPrevRange);
void DrawLast (PGRAPH_DEF pGrDesc, HDC hdc, DYNOBJ_SCROLL FAR *pObjDesc, HPINT hpDep);

/****************************************************************/
// Data conversion

void ConvertDyn (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc,
    HPFLOAT lprNewVal, HPINT hpLogVal, int n);
void ConvertStacked (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc,
    HPFLOAT lprNewVal, HPINT hpLogVal, int n);
void ConvertLogic (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc,
    UINT uNewVal, HPINT hpLogVal, int n);

void RecalcScroll (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void RecalcXY (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void RecalcScVar (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc, 
     int nAxDir, realtype rOldRange, realtype rOldMax);
void InitX (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL  FAR *pObjDesc);
void CALLBACK _export RescaleDynObj (PGRAPH_DEF pGrDesc, 
     DYNOBJ_SCROLL FAR *pObjDesc, int nAxObj);
void ConvertAlarms (PGRAPH_DEF pGrDesc, DYNOBJ_ALARMLINES FAR *pObjDesc);
void RecalcAlarmLines (PDYNDATA lpDataDesc);

/****************************************************************/
/* Data Sets ****************************************************/
/****************************************************************/
PDYNDATA GetObjDataDesc (PDYNOBJ_HEAD pObjDesc);
void  FreeAllDynDataSets (void);
PDYNDATA GetDataDesc (HDATA hData);
BOOL CopyHistData (DYNOBJ_SCROLL FAR *pObjDesc, 
                    UINT wLast, UINT wFirst);
HDATA GetDynDataHandle (PDYNDATA pDataDesc);

/****************************************************************/
/* Object support ***********************************************/
/****************************************************************/

POBJ_HEAD  StartDynObj (PGRAPH_DEF pGrDesc, int nType,
    int nSubType);
int  WINAPI _export rtDefEditObject (PGRAPH_DEF pGrDesc);
void  CALLBACK rtEditObject (PGRAPH_DEF pGrDesc);
HGOBJ WINAPI _export rtObjFind (HWND hwnd);
void  WINAPI WREditObject (HWND hwnd);
// Rev 3.0 Changed prototype  adding scatter symbols
HGOBJ InitScrollDesc (PGRAPH_DEF pGrDesc, 
	DYNOBJ_SCROLL  FAR *pObjDesc, realtype rResetInt, int nTraces,
    LPINT lpLineStyle, LPINT lpLineWidth,
    LPINT lpLineColor, LPINT lpScatterSym, LPINT lpScatterSize,
	DYNDATA_DEF FAR *lpDataDesc);
void InitDynRange (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc);
void InitDynLines (PGRAPH_DEF pGrDesc, HGOBJ hDynObj,
     LPINT pLineColor, LPINT pLineWidth, LPINT pLineStyle, LPINT pScatterSym,
	 LPINT pScatterSize);
void DifBar (DYNOBJ_SCROLL FAR *pObjDesc, PGRAPH_DEF pGrDesc, int nWidth,
	int indep, int depOld, int depNew, BOOL bBorder);
void RescaleBars (PGRAPH_DEF pGrDesc, DYNOBJ_BAR FAR *pObjDesc);

// void StartAuto (PGRAPH_DEF pGrDesc, LPINT lpPlotColor, LPINT lpTextColor); 
void StartAuto (PGRAPH_DEF pGrDesc, LPINT lpPlotColor, LPINT lpTextColor, 
	LPINT lpTitleColor, LPINT lpAxColor, LPINT lpPixSize, 
	LPINT lpTextSize, float FAR *lprcxText, float FAR *lprcyText);
void InitAlarms (HDATA hData, PDYNDATA lpDataDesc, int nPlotColor, realtype rHigh, 
	realtype rLow, realtype rSetp, LPSTR lpHighAlmMes, LPSTR lpLowAlmMes,
	LPINT lpAlmTextColor, LPINT lpAlmLineColor);
	
void CALLBACK _export RecalcText (PGRAPH_DEF pGrDesc, HDC hdc,
    PDYNOBJ_HEAD pObjDesc, float fCoef);
void RecalcAlarmText (PGRAPH_DEF pGrDesc, HDC hdc,
    DYNOBJ_ALARMMARKS FAR *pObjDesc, float fCoef);
int CalcAlarmExt (PGRAPH_DEF pGrDesc, PDYNDATA lpDataDesc);
void  CalcDynTextXSize (PGRAPH_DEF pGrDesc,
    DYNOBJ_TEXT FAR *pTextDesc);
void  CalcDynTextYSize (PGRAPH_DEF pGrDesc,
    DYNOBJ_TEXT FAR *pTextDesc);
BOOL CalcTextItem (PGRAPH_DEF pGrDesc, DYNOBJ_TEXT FAR *pObjDesc,
    LPRECT lprc, int x, int y, UINT wAlign);
void ResetTimeLabels (PGRAPH_DEF pGrDesc, DYNOBJ_LABELS FAR *pObjDesc, 
    realtype rNewStart);
void TimeLabRedraw (PGRAPH_DEF pGrDesc, DYNOBJ_LABELS FAR *pLabDesc, 
    LPREAL lprStart, realtype lPrevTime);
int CALLBACK _export QCChildControlProc (HWND hwndGraph, UINT message, 
    WPARAM wParam, LONG lParam);
int GetRescaleType (int nOldSize, int nNewSize, int nPoints, 
      int nHistSize, BOOL bSrcFull);
void WINAPI _export TextItemCoords (PGRAPH_DEF pGrDesc, 
    OBJ_LEGEND FAR *pLegDesc, int num, UINT wAlign, LPINT lpX, LPINT lpY);
DYNOBJ_LABELS FAR *GetLabDesc (PGRAPH_DEF pGrDesc, HGOBJ hAx);
void CalcMesSize (PGRAPH_DEF pGrDesc, DYNOBJ_MESSAGE FAR *pObjDesc);
HGOBJ InitXYObj (int nSubType, PGRAPH_DEF pGrDesc, 
	int nNumPoints, LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);
BOOL GetScrMinMax (PGRAPH_DEF pGrDesc, DYNOBJ_SCROLL FAR *pObjDesc, 
    LPFLOAT prMin, LPFLOAT prMax);
HGOBJ CALLBACK _export RestoreDynObject (HFILE fh, PGRAPH_DEF pGrDesc, 
    HDC hdc, int nType, int size);
BOOL CALLBACK _export SaveDynObject (HFILE fh, PGRAPH_DEF pGrDesc, 
    PDYNOBJ_HEAD pObjDesc);

/***************************************************************/
/* GDI SUPPORT								                   */
/***************************************************************/
HPEN   SelectDynPenIndirect (HDC hdc, LPLOGPEN lpLogPen);
HBRUSH SelectScBarBrushPen (PGRAPH_DEF pGrDesc, 
	DYNOBJ_SCROLL FAR *pObjDesc, BOOL bNarrow);
void Clip (PGRAPH_DEF pGrDesc, HDC hdc);
void Unclip (PGRAPH_DEF pGrDesc, HDC hdc);
HBRUSH TextBrushPen (PGRAPH_DEF pGrDesc, HDC hdc, DYNOBJ_TEXT FAR *pObjDesc, 
    HPEN FAR *lpPen);
int GetContrastColor (int nColor);
BOOL IsColorStock (COLORREF rgbBkColor);
BOOL IsVisible (HDC hdc, LPRECT prc);

/********************************************************************/
/* Timer functions                                                  */
/********************************************************************/

BOOL  PutToTimerList (PGRAPH_DEF pGrDesc, PDYNOBJ_HEAD pObjDesc);
void  RemoveFromTimerList (PGRAPH_DEF pGrDesc,
	 PDYNOBJ_HEAD pObjDesc);
BOOL WINAPI _export StartUpdateTimer (void);
void WINAPI _export StopUpdateTimer (void);
BOOL WINAPI _export SetObjTimeUpdate (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    UINT wTimeSec);

/**************************************************************************/
int WINAPI _export rtDisplayDialogBoxParam (DLGPROC lpDlgProc,
    LPCSTR lpDlgName, HWND hwnd, DWORD dwInitParam);

/**************************************************************************/
// DDE

HDDEDATA CALLBACK _export DdeCallback (UINT wType, UINT wFmt, HCONV hConv,
    HSZ hsz1, HSZ hsz2, HDDEDATA hData, DWORD lData1, DWORD lData2);
PSTR GetTextData (HDDEDATA hData);
BOOL ProcessDDEData (HSZ hszItem, PCONV_DESC pConvDesc, int nType);
void DDECleanup (void);
HDDEDATA CALLBACK DumDdeEvent (UINT type, UINT fmt, HCONV hconv,
        HSZ hsz1, HSZ hsz2, HDDEDATA hData, DWORD dwData1, DWORD dwData2);

/****************************************************************/
/* Miscellaneous ************************************************/
/****************************************************************/
BOOL IsDataDescValid (PDYNDATA pD);
int   rtErrHdlr (int nErrCode, int fPar, LPCSTR szParam);
BOOL  WINAPI _export InitRTTop (TOP_DEF FAR *lpTop);
void  WINAPI _export KillRTPage (HGRAPH hPage);

void  KillRTGraph (PPAGE_DEF pPageDesc, HGRAPH hGr);
void  CALLBACK DumAlarmEvent (HDATA hData, int nChannel, int nAlmType,
	 realtype rVal, BOOL bOn);
void  CheckAlarmStatus (PDYNDATA lpDataDesc, HDATA hData);
void  ControlCleanup (void);
float TabSin (int nAng);
float TabCos (int nAng);
void WINAPI _export RTCleanup  (TOP_DEF FAR *lpTop);
void WINAPI _export rtGetAbsPix (PGRAPH_DEF pGrDesc, LPINT lpcxPix, LPINT lpcyPix);


// New Rev 3.0 Prototypes
// rtsup.c
int ComboLineType(DYNOBJ_SCROLL FAR *pObjDesc, int nTrace);
HBRUSH GetScatterBrush(PGRAPH_DEF pGrDesc, HDC hdc, int style, 
					   COLORREF rgbFgColor, HBRUSH *hOldBrush);
void DrawScrollScatterPolyMark(PGRAPH_DEF pGrDesc, HDC hdc, 
						   DYNOBJ_SCROLL FAR *pObjDesc, 
						   int nTrace,
						   POINT *nPoint,
						   int nNumPoints,
						   LOGPEN *lp,
						   BOOL bErase);
void AlarmCheckPoly(PGRAPH_DEF pGrDesc, 
					HDC hdc,
					DYNOBJ_SCROLL FAR *pObjDesc,
					int nTrace,
					POINT *lppt, int cPoints, 
					int nScrollDir, BOOL bErase);
void AlarmCheckStepLine(PGRAPH_DEF pGrDesc, 
						HDC hdc,
				  DYNOBJ_SCROLL FAR *pObjDesc,
				  int nTrace,
				  POINT p, POINT pminus1, 
				  int nStep, int dir,
  				  LOGPEN *lp,
				  BOOL bErase);
void StepLine(HDC hdc, POINT p, POINT pminus1, int nStep, int dir);
void StepPolyline(PGRAPH_DEF pGrDesc, HDC hdc, DYNOBJ_SCROLL FAR *pObjDesc, int nTrace,
                            POINT *lppt, int nPoints, int nStep, int dir, BOOL bErase);
void swapints(int *a, int *b);
BOOL CheckBadLogValue(int v);
BOOL CheckBadLogPoint(POINT *p1, POINT * p2);
BOOL FindFirstGoodPoint(POINT *pData, int nPoints, int *nStart);
void SimpleDynBar (DYNOBJ_SCROLL FAR *pObjDesc,  HDC hdc, PGRAPH_DEF pGrDesc,
    int  nWidth,int  indep, int  nBase, int  depNew, HBRUSH  hBarColor,
	HBRUSH  hBkColor, BOOL bBorder);
void SimpleDynBarHat (DYNOBJ_SCROLL FAR *pObjDesc,  HDC hdc, PGRAPH_DEF pGrDesc,
    int  nWidth, int  indep, int  nBase, int  depPrev, int  depNew,
	HBRUSH  hBarColor, HBRUSH  hBkColor,   BOOL bBorder);
void DrawScrollPolyBar(PGRAPH_DEF pGrDesc, HDC hdc, DYNOBJ_SCROLL FAR *pObjDesc, 
						   int nTrace, POINT *nPoint, int nNumPoints,
						   COLORREF rgbNormalColor, BOOL bErase);
void ScrollMultiDrawSegment(PGRAPH_DEF pGrDesc, HDC hdc,
				  DYNOBJ_SCROLL FAR *pObjDesc, int nTrace,
				  POINT p, POINT pminus1, LOGPEN *lp, BOOL bErase);
void ScrollMultiDrawPoly(PGRAPH_DEF pGrDesc, 
				  HDC hdc,  DYNOBJ_SCROLL FAR *pObjDesc, int nTrace,
				  POINT *lppt,  int nPoints, LOGPEN *lp, BOOL bErase);
// rtax.c
void DrawDynGridsAndAlarms(PGRAPH_DEF pGrDesc);
int  RTConnectAxLine (PGRAPH_DEF pGrDesc, OBJ_PLOT *pCurveDesc);

#ifdef __cplusplus
}
#endif
#pragma pack(pop)

/**************************************************************************/
#endif
