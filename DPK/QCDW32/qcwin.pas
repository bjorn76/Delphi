{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   QCWIN.PAS                                   *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}


{$X+,F+,A+,K+}
unit QCWin;
interface

{uses Windows;}

uses WinProcs, WinTypes, Messages;

// define RTFL in the directories/conditional defines
// section of the project options in order to use
// the single numeric type

{$ifndef RTFL}
type
  realtype = double;
const
  QCDLL = 'WCT32DR3.DLL';
{$else}
type
  realtype = single;
const
  QCDLL = 'WCT32FR3.DLL';
{$endif}

type
  DWORD = LONGINT;

  BOOL = LONGBOOL;

const
  M_PI = PI;


  NULLH: THandle = 0;               {Null Handle }
  NULLS: PChar = '';                {Null String }
  NULLP: Pointer = NIL;      {NULL pointer, CANNOT BE WRITTEN TO}

{ Windows versions }
 WV_31  =   0;
 WV_32S =   1;
 WV_NT  =   2;
 WV_95  =   3;

{****************************************************************************}
type
  UINT = CARDINAL; { 32-bit unsigned int}
  PUINT = ^UINT;
  HGRAPH = THANDLE;              { graph handle  }
  HCONT = THANDLE;               { control object handle }
  HGLOBAL = THANDLE;
  HGOBJ = THANDLE;    {32-bit change}      { graphical object handle  }
  HDATA = THANDLE;               { data set handle }
  PHDATA = ^HDATA;
  LPHDATA = ^HDATA;
  LPBOOL = ^BOOL;
  LPTCOLORREF = ^TCOLORREF;
  HMETAFILE = THANDLE;
  HCONV = THANDLE;
  HSZ = THANDLE;
  PHGOBJ = ^HGOBJ;        { pointer to object handle }
  HPREAL = ^Realtype;        { huge pointer to realtype }
  HPFLOAT = ^SINGLE;       { huge pointer to float }
  LPFLOAT = ^SINGLE;       { far pointer to float  }
  LPREAL= ^Realtype;        { pointer to realtype   }
  HPSHORT = ^short;
  LPSTR = PCHAR;
  LPSHORT = ^short;
  LPINT = ^INTEGER;
  HPINT = ^INTEGER;
  PSHORT= ^short;
  HPPOINT = ^TPOINT;       { far pointer to realtype }
  HPSTR = PChar;



const
{ Rev. 3.0 defines }
DEFAULT_MAX_POS_NUMBER = 9.9999e19;
DEFAULT_MIN_NEG_NUMBER =-9.9999e19;
DEFAULT_BADVALUE_NUMBER =1.0e20;
LOG_COORD_BADVALUE      = 32000;

  MAX_PAGES     =60;
  MAX_DATASETS  =1800;
  INIT_NUM_OBJS =20;             { initial number of objects per graph }
  MAXPATHLEN = 164;
  //BDMOD
  //MAXPATHLEN    =160;
  MAX_GRAPHS    =16;              { max number of graphs per page }

{ ways of creating page window }

  PAGE_CLIENT  = 0;               { fill parent window client area }
  PAGE_FULL    = 1;               { fill the whole screen          }
  PAGE_EXACT   = 2;               { use passed coordinates         }

{ Page Window scaling types - fixed, proportionate, and isotropic }
  MM_FIXED   =  MM_ISOTROPIC;
  MM_PROPORT =  MM_ANISOTROPIC;
  MM_ISOTR   =  9;
  MM_PROPORT_FT = 10;
  MM_ISOTR_FT = 11;
{ coordinate types }

  CO_LOG  =0;
  CO_PHYS =1;
  CO_NORM =2;
  CO_DEV  =3;

{ Point search constants }

 FNP_X    = 0;   { nearest x }
 FNP_Y    = 1;   { nearest y }
 FNP_DIST = 2;   { shortest distance }

 FNP_NORMX   = 3;   // nearest normalized x
 FNP_NORMY   = 4;   // nearest normalized y
 FNP_NORMDIST =5;   // shortest normalized distance

{ printing styles }

 PRT_FULL =   0;       { Pages and graphs are printed so that paper
                             is used maximally. Text is printed
                             proportionately to other objects }
 PRT_PROP =   1;       { Pages are printed so that paper
                             is used maximally. Graphs are printed
                             proportionately to page size.
                             Text is printed proportionately to other objects }

 PRT_EXACT =  2;   { physical size, font size in points are preserved }

{************************************************************************}
{ Graphical objects }
{************************************************************************}

 X_AXIS = 0 ;
 Y_AXIS = 1 ;
 Z_AXIS = 2 ;


    GO_PLOT   = 1;              { can be line, bars, scat, etc }
    GO_GROUP  = 2;              { can be stacked lines, bars   }
    GO_LEGEND = 3;
    GO_LINE   = 4;              { Straight line }
    GO_ARROW  = 5;              { Straight line with arrow }

    GO_LAST1  = 9;

    GO_AX     = 10;
    GO_LABELS = 11;
    GO_TEXT   = 12;
    GO_ARC    = 13;

    GO_LAST2  = 19;

{***********************************************************}

    GO_PIECHART = 20;
    GO_METAFILE = 21;
    GO_ELLIPSE  = 22;
    GO_BITMAP   = 23;
    GO_POLYGON  = 24;
    GO_RECT     = 25;
    GO_PIE      = 26;
    GO_DATACURSOR = 27;
    GO_PLOTSCALE  = 49;
    GOS_MAX  =   50;   { max value of statical graphical object }
    GO_USER  =  1000;
    GO_SERIALXYDATASET =  9997;
    GO_SERIALDYNDATASET =  9998;
    GO_SERIALENDGRAPH  =  9999;

{ Line types - subtype field }
    LT_SOLID   =  2;
    LT_LINE   =   3;
    LT_LINEMARK = 4;
    LT_SCAT   =   5;
    LT_VBAR   =   6;
    LT_HBAR   =   7;
    LT_3DVBAR =   8;
    LT_3DHBAR =   9;
    LT_LAST   =   LT_3DHBAR;

{ types of group plots }

 GT_GROUPBARS   = 0;
 GT_DEEPBARS    = 1;
 GT_STACKEDBARS = 2;
 GT_FLOATBARS   = 3;
 GT_STACKEDLINES= 5;
 GT_HILOCLOSE   = 6;
 GT_ERRORBARS   = 7;
 GT_GROUPLINES	=9;
 GT_WATERFALL	=10;

 GT_CONTOURLINE  = 20;
 GT_CONTOURFILL  = 21;

 GT_BOXWHISKER   = 11;
 GT_CANDLESTICK  = 12;
 GT_STOCKOPENHILOCLOSE =13;

{ data cursor types }

 DC_VLINE  =  0;
 DC_HLINE  =  1;
 DC_CROSS  =  2;
 DC_BOX    =  3;

 DC_HVLINE =   4;

 DC_WVLINE =   5;
 DC_WHLINE =   6;
 DC_WCROSS =   7;
 DC_WBOX   =   8;
 DC_WHVLINE =  9;

{************************************************************************}
{ Dynamic Graphical objects }
{************************************************************************}

    GO_DYN  = 100;         { First dynamic object }

 GOD_ALARMLINES = GO_DYN;      { alarm lines }
 GOD_ALARMMARKS = GO_DYN + 1;  { alarm marks (for bar graphs) }
 GOD_DYNGRID    = GO_DYN + 2;  { grid lines  }
 GOD_SCROLL     = GO_DYN + 3;  { scroll, sweep, scrolling bars, etc. }
 GOD_XYPLOT     = GO_DYN + 4;  { dynamic xy plot      }
 GOD_LABELS     = GO_DYN + 5;  { dynamic labels       }
 GOD_BARS       = GO_DYN + 6;  { dynamic bars         }
 GOD_TEXT       = GO_DYN + 7;  { dynamic text }
 GOD_MESSAGE    = GO_DYN + 8;  { message text }
 GOD_ANNUNC     = GO_DYN + 9;  { annunciator panel - compound object }
 GOD_METER      = GO_DYN + 10; { meter }
 GOD_CHCONTROL  = GO_DYN + 11; { child control }

 DYNGRAPH_BAR= 3;
 DYNGRAPH_SCATTER =2;
 DYNGRAPH_LINE =1;

 GOD_SUBT_SCLINE= 1;         { scrolling line subtype }
 GOD_SUBT_SCBAR = 2;         { scrolling bar  subtype }
 GOD_SUBT_SWLINE= 3;         { sweep line subtype }
 GOD_SUBT_LOGIC = 4;         { logic line subtype }
 GOD_SUBT_BAR   = 5;         { bar graph subtype  }
 GOD_SUBT_ALMTEXT =6;        { alarm text subtype }
 GOD_SUBT_STACKED =7;        { stacked line subtype }
 GOD_SUBT_TIME  =10;         { time subtype (for axes and labels) }
GOD_SUBT_DYNLEG =11;

GOD_SUBT_SCLINEVAR =12;

GOD_SUBT_COMBOSCROLL =13;
GOD_SUBT_COMBOSWEEP  =14;
GOD_SUBT_COMBOXY     =15;
GOD_SUBT_COMBOVARSCROLL = 16;

OBJ_NO_EVENT  =	0;
OBJ_FIND_EVENT= 1;
OBJ_EDIT_EVENT= 2;
OBJ_MOVE_EVENT= 3;
OBJ_ZOOM_EVENT= 4;
OBJ_USERZOOM_EVENT= 5;
OBJ_USERPROC_EVENT= 6;

WM_ALLMOUSEEVENTS= 99999;

 ARROW_START =1;
 ARROW_END   =2;
 ARROW_BOTH  =3;

 MAX_ALMNAME =16;
 NALMLINES =5;

{ data reduction types }

 DC_SKIP    =0;
 DC_AVERAGE =1;
 DC_MAX     =2;
 DC_MIN     =3;

{ bitmap display modes }

 BM_ORIG     =0;
 BM_STRETCH  =1;

 PW_WINDOW = 1;
 PW_CLIENT = 2;

{ COLOR CODES }
    C_RGB          = -2;
    C_TRANSPARENT  = -1;
    C_BLACK        =  0;
    C_BLUE         =  1;
    C_GREEN        =  2;
    C_CYAN         =  3;
    C_RED          =  4;
    C_MAGENTA      =  5;
    C_BROWN        =  6;
    C_LIGHTGRAY    =  7;
    C_GRAY         =  8;
    C_LIGHTBLUE    =  9;
    C_LIGHTGREEN   = 10;
    C_LIGHTCYAN    = 11;
    C_LIGHTRED     = 12;
    C_LIGHTMAGENTA = 13;
    C_YELLOW       = 14;
    C_WHITE        = 15;

    C_PALEBLUE     = 16;
    C_PALEGREEN    = 17;
    C_MEDGRAY      = 18;
    C_OFFWHITE     = 19;

    NUMCOLS        = 20;

{************************************************************************}
{ Axis scaling types  }

    ST_LINEAR   = 0;
    ST_LOG      = 1;

{************************************************************************}
{ Grid types  }

    GRID_MAJOR  = 0;
    GRID_MINOR  = 1;
    GRID_ALL    = 2;

{************************************************************************}
{ Tick mark, bar, etc. position definitions: }

  POS_BELOW    = 0;
  POS_INSIDE   = POS_BELOW;
  POS_LEFT     = 1;
  POS_RIGHT    = 2;
  POS_MIDDLE   = 3;
  POS_ABOVE    = 4;
  POS_OUTSIDE  = POS_ABOVE;
  POS_INVISIBLE = 5;

  POS_BELOW_PLOT = 6;
  POS_ABOVE_PLOT = 7;
  POS_LEFT_PLOT  = 8;
  POS_RIGHT_PLOT = 9;

  TEXT_NORMAL    = 0;
  TEXT_VERTLEFT  = 900;
  TEXT_VERTRIGHT = 2700;

  TEXT_BOLD      = 1;           { can be ORed with each other }
  TEXT_ITAL      = 2;
  TEXT_UNDERLINE = 4;

{*********************************************************************}
{ last label indicators: }
{*********************************************************************}

  LL_ON   = 0;
  LL_OFF  = 1;
  LL_TEXT = 2;

  LABELLEN = 42;
  //BDMOD
//  LABELLEN   = 40;        { maximal length of string label }
  LG_MAXLEN  = LABELLEN;  { maximal legend length }
  MAX_MESLEN = LABELLEN;  { 42 }
  MAX_MESNUM = 8 ;        { number of messages

{*********************************************************************}
{ Pie Chart Constants }
{*********************************************************************}

 PIE_NUM_NONE    = 0;
 PIE_NUM_PERC    = 1;
 PIE_NUM_VAL     = 2;
 PIE_NUM_BOTH    = 3;

 PIE_IN          = 0;
 PIE_OUT         = 1;

 PIE_2D          = 10;
 PIE_3D          = 11;

{*********************************************************************}
{ Numbers formats:                                                    }

    NF_DECIMAL    = 0;
    NF_SCIENTIFIC = 1;
    NF_ENG        = 2;
    NF_TIMEF      = 3;
    NF_DATEF      = 4;
    NF_EXP         =5;
    NF_G          =6 ;

   TM_HMS       =1;
   TM_HM        =2;
   TM_MS        =4;


   DTB_DATE_MINUTE = 1;
   DTB_DATE_HOUR   = 2;
   DTB_DATE_DAY    = 3;
   DTB_DATE_WEEK   = 4;
   DTB_DATE_MONTH  = 5;
   DTB_DATE_YEAR   = 6;


   DATE_STANDARD  = 1;
   DATE_MDY       = 2;
   DATE_DMY       = 3;
   DATE_MY        = 4;
   DATE_Y         = 5;
   DATE_MDY2000   = 6;
   DATE_DMY2000   = 7;
   DATE_MY2000    = 8;
   DATE_Y2000     = 9;

{**********************************************************************}
{ Intercept flags for auto axes.  }

    INTF_ZERO   = 0;       { use 0 for intercepts              }
    INTF_MIN    = 1;       { minimal values for both axes      }
    INTF_MAX    = 2;       { maximal values for both axes      }
    INTF_MINMAX = 3;       { min Y intercept for axis X, max for Y }
    INTF_MAXMIN = 4;       { max for X, min for Y                  }

{**********************************************************************}
{ Symbols (markers) types:                                             }

    MK_NONE          = 0;
    MK_X             = 1;
    MK_UPTRIANGLE    = 2;
    MK_DOWNTRIANGLE  = 3;
    MK_BOX           = 4;
    MK_PLUS          = 5;
    MK_ASTERISK      = 6;
    MK_DIAMOND       = 7;
    MK_CIRCLE        = 8;
    MK_DOT           = 9;
    MK_BAR          =10;
    MK_FILLEDLINE    =11;

    MK_BITMAP	  =12;
    MK_METAFILE	  =13;


    MK_LINE    =    14;

{*******************************************************************}
{ Marker and bar styles }

    MKS_FILLED     = 0;
    MKS_EMPTY      = 1;
    MKS_CDOT       = 2;

    BAR_FULL    = MKS_FILLED;
    BAR_HOLLOW  = MKS_EMPTY ;
    BAR_BORDER  = MKS_CDOT;

{**********************************************************************}
{ Autoscaling parameters: }

    AS_ROUNDCLOSE = 1;
    AS_ROUNDFAR   = 2;
    AS_EXACT = 3 ;

{********************************************************************}
{ DSP constants (windows types)                                      }
{********************************************************************}

 DSPWIN_RECTANG = 0;
 DSPWIN_PARZEN  = 1;
 DSPWIN_HANNING = 2;
 DSPWIN_WELCH   = 3;
 DSPWIN_HAMMING = 4;
 DSPWIN_EXACTB  = 5;

{*************************************************************************}
{ orientation constants }

 OR_VERT  = 0;
 OR_HORZ  = 1;

{*************************************************************************}
{ raised rectangle constants }

 RC_FLAT     = 0;      { regular }
 RC_HIGH     = 1;
 RC_DEEP     = 2;
 RC_LOW      = 3;
 RC_SHALLOW  = 4;
 RC_3DBORDER = 5;


{*************************************************************************}
{ Metafile types }

 MF_WIN    = 0;    { Old Windows metafile    }
 MF_PL     = 1;    { Placeable Aldus metafile }
 MF_ENH    = 2;    { New enhanced Windows metafile }

{*************************************************************************}
{ placeable metafile header }

BM_BMP  =   1;
BM_DIB  =   2;


BM_WINDOW = 1;
BM_CLIENT = 2;

   RHS_SOLIDFILL       = $000;
   RHS_HORIZONTAL      = $100;
   RHS_VERTICAL        = $200;
   RHS_FDIAGONAL       = $300;
   RHS_BDIAGONAL       = $400;
   RHS_CROSS           = $500;
   RHS_DIAGCROSS       = $600;

   ZOOM_SIMPLE  = 1;
   ZOOM_XY_PAIRS =2;
   ZOOM_X_NO_Y   =3;
   ZOOM_Y_NO_X   =4;
   ZOOM_1X_MULTIPLE_Y   =5;
   ZOOM_1Y_MULTIPLE_X   =6;

   GROUP_ALL_Y     =0;
   GROUP_ONE_Y     =1;
   GROUP_ALL_Y_STACKED  =2;


   ORIENT_PORTRAIT      = 1;
   ORIENT_LANDSCAPE	=2;


   NO_STEP    =0;
   STEP_START =1;
   STEP_END   =2;
   STEP_NO_RISE_LINE =3;

   LG_NONE	=0;
   LG_LINE	=1;

   LG_BAR	=2;
   LG_3DBAR	=3;
   LG_X		=4;
   LG_UPTRIANGLE =5;
   LG_DOWNTRIANGLE =6;
   LG_BOX	   =7;
   LG_PLUS	   =8;
   LG_ASTERISK	=9;
   LG_DIAMOND	=10;
   LG_CIRCLE	=11;
   LG_DOT	=12;
   LG_BITMAP	=13;
   LG_METAFILE	=14;

   LGS_FILLED    =0;
   LGS_EMPTY     =1;
   LGS_CDOT      =2;

   LGS_SOLID	=0;
   LGS_DASH	=1;
   LGS_DOT	=2;
   LGS_DASHDOT	=3;
   LGS_DASHDOTDOT=4;

   MAXLEGEND	=32;

   TYPE_NONE	=0;
   LEG_FLEX	=1;
   GEN_TEXT	=2;
   GEN_TEXTN	=3;


   BW_NONE    =0;
   BW_PERCNT  =1;
   BW_MINMAX  =2;
   BW_CONST   =3;
   BW_STDDEV  =4;
   BW_STDERR  =5;
   BW_NONOUT  =6;
   BW_COLUMN  =7;


   BW_MEAN    =0;
   BW_MEDIAN  =1;


   BW_MIDP =0;
   BW_OH   =1;
   BW_OL   =2;
   BW_UBV  =3;
   BW_LBV  =4;
   BW_EH   =5;
   BW_EL   =6;
   BW_WHHIGH =7;
   BW_WHLOW  =8;
   BW_NELEM  =9;


   BW_BOX =10;
   BW_WHISKER =11;
   BW_OUTLIER =12;
   BW_EXTREME =13;


   MAXBMNAMELEN = 80;

   MAXSAVEAXES =10;
   MAXMOUSEEVENTS =8;

   // NEW PARAMETER CONSTANTS or REV 3.0
  PARAM_START_NUM =100;
  PARAM_BW_OUTLIERCOEF =	PARAM_START_NUM + 300;
  PARAM_BW_MIDPOINTYPE =	PARAM_START_NUM + 301;
  PARAM_BW_BOXCOEF=		PARAM_START_NUM + 302;
  PARAM_BW_BOXCONST =		PARAM_START_NUM + 303;
  PARAM_BW_BOXMIN =	        PARAM_START_NUM + 304;
  PARAM_BW_BOXMAX =		PARAM_START_NUM + 305;
  PARAM_BW_OUTLIERSYMBOL =	PARAM_START_NUM + 306;
  PARAM_BW_OUTLIERFLAG=	PARAM_START_NUM + 307;
  PARAM_BW_EXTREMESYMBOL=	PARAM_START_NUM + 308;
  PARAM_BW_EXTREMEFLAG=	PARAM_START_NUM + 309;
  PARAM_BW_MIDPOINTSYMBOL=	PARAM_START_NUM + 310;
  PARAM_BW_WHISKERTYPE=	PARAM_START_NUM + 312;
  PARAM_BW_WHISKERSIZE=	PARAM_START_NUM + 313;
  PARAM_BW_WHISKERCOEF=	PARAM_START_NUM + 314;
  PARAM_BW_WHISKERMIN=		PARAM_START_NUM + 315;
  PARAM_BW_WHISKERMAX=		PARAM_START_NUM + 316;

  PARAM_CONTOUR_VALUE=	 PARAM_START_NUM + 330;
  PARAM_CONTOUR_COLOR=	   PARAM_START_NUM + 331;
  PARAM_CONTOUR_LINESTYLE=   PARAM_START_NUM + 332;
  PARAM_CONTOUR_LINEWIDTH=   PARAM_START_NUM + 333;
  PARAM_CONTOUR_NUMCONTOURS=   PARAM_START_NUM + 334;
  PARAM_CONTOUR_BITMAPGRANULARITY= PARAM_START_NUM + 335;
  PARAM_CONTOUR_LINEFLAGS=   	PARAM_START_NUM + 336;
  PARAM_CONTOUR_LABELFLAGS =  	PARAM_START_NUM + 337;
  PARAM_CONTOUR_LABELXJUST=   	PARAM_START_NUM + 338;
  PARAM_CONTOUR_LABELYJUST=   	PARAM_START_NUM + 339;
  PARAM_CONTOUR_LABELCOLOR=   	PARAM_START_NUM + 340;
  PARAM_CONTOUR_LABELPREC=     	PARAM_START_NUM + 341;
  PARAM_CONTOUR_GRAPHTYPE =   	PARAM_START_NUM + 342;

  PARAM_WATERFALL_XOFFSET=      PARAM_START_NUM + 350;
  PARAM_WATERFALL_YOFFSET =     PARAM_START_NUM + 351;
  PARAM_WATERFALL_FILL=	        PARAM_START_NUM + 352;
  PARAM_WATERFALL_BASELINE=   PARAM_START_NUM + 353;
  PARAM_WATERFALL_OUTLINE=	PARAM_START_NUM + 354;
  PARAM_WATERFALL_LINESTYLE=	PARAM_START_NUM + 355;
  PARAM_WATERFALL_LINEWIDTH=	 PARAM_START_NUM + 356;
  PARAM_WATERFALL_LINECOLOR =	 PARAM_START_NUM + 357;



type

EXT_MFHEADER = record
        key: DWORD;
        hmf: WORD;
       left,
       top,
       right,
       bottom: SHORT;
        inch: WORD;
        reserved: DWORD;
        checksum: WORD;
end;

{************************************************************************}
LINEDESC = record
   lp: TLOGPEN;               { Windows pen descriptor  }
   nWidth: INTEGER;           { line width in pixels    }
   nColor: INTEGER;           { pure color code         }
   hwnd: HWND;             { handle of the graph window }

end;
PLINEDESC = ^LINEDESC;   { NEW FOR TURBO PASCAL }


{***********************************************************************}
OBJ_META = record                   { Metafile object }
    hMem: HGLOBAL;       { memory handle for the OBJ_META descriptor }
    hmf: HMETAFILE;
    ExtHeader: EXT_MFHEADER;
    bEnh: BOOL;       { TRUE if new enhanced metafile }
end;

POBJ_META = ^OBJ_META;


{ProcType0 = function: INTEGER; stdcall;
ProcType1 = procedure (fp:Pointer); stdcall;
FuncType2 = function (fp:Pointer; thdc:HDC): THandle; stdcall;
}

{*************************************************************************}
{ Page descriptor  (page can have multiple graphs) }

PAGE_DEF = record

    hPage: HGRAPH;             { handle }
    thwnd: HWnd;              { chart page window handle}

    lpfnPage: TFarProc;   { function initializing graph}
    hwParent: HWnd;          { parent window handle}

    cxVExt,            { Viewport extents }
    cyVExt,
    cxWExt,            { Window extents  }
    cyWExt: INTEGER;
    rgbBkColor: DWORD;        { Chart page window background color}
    nMapMode,          { ISOTROPIC or ANISOTROPIC}
    nNumGraphs,        { Number of graphs on the page}
    nGraphCount,
    nSavMapMode: INTEGER;

    fInitGraph,        { Initialization flag}
    fLoaded,
    fDynamic: BOOL;          { Set to TRUE if something is dynamic}
    hSelGraph,         { handle to selected graph}
    hPrevSelGraph: HGRAPH;     { handle to previously selected graph}
    fDispSel,          { flag indicating selectors are displayed}
    fPrevDispSel,      { previous state of the flag}
    fHigh,             { flag indicating selected graph is highlighted}
    reserved1,
    fBlow,             { flag indicating selected graph is blown up}
    fMeta: BOOL;             { if not 0, output is to a metafile}

    fSelxOrg,          { Save area for selected graph window extents}
    fSelyOrg,          { and origin relative to page}
    fSelxExt,
    fSelyExt: SINGLE;

    rXOrigCoef,        { compression/expansion coefficients}
    rYOrigCoef: SINGLE;        { relative to original size}
    cxVExtOrig,        { Original Viewport extents}
    cyVExtOrig: INTEGER;

    nLTickSize,           { Large Tick Size in pixels}
    nSTickSize: INTEGER;           { Small Tick Size in pixels}

    szFileName: array[0..MAXPATHLEN-1] of CHAR; { Save file or metafile name }
    szName: array[0..15] of CHAR;        { ASCII internal name of the page }
    cMapIsotr: BOOL;         { Isotropic resizable mapping mode flag}

    bFixedText: Integer;        { if != 0, text size does not change when graph is resized }
    wUserWord1,        { user can do anything with this field}
    wUserWord2: Integer;        { user can do anything with this field}
    lpTopDesc: POINTER;         { pointer to TopDesc}

    hGrMem: array[0..MAX_GRAPHS-1] of HGLOBAL; { array of memory handles to graphs}
    hwndButton: array[0..MAX_GRAPHS-1] of HWnd;   { handles to selector buttons}
    dwSignature: DWORD;
    nPosStyle: INTEGER;
end;

 PPAGE_DEF = ^PAGE_DEF;

{************************************************************************}
 OBJ_HEAD = record                     { common header }
   nType,                  { object type         }
   nSubType: INTEGER;               { object subtype }
   lpfnObj: TFARPROC;              { function drawing the object}
   rcBoundary: TRect;             { object limits in device coordinates }
   hObj1,                   { handles of associated objects (axes) }
   hObj2: HGOBJ;
   ld: LINEDESC;
  // HGOBJ  (_cdecl FAR *lpfnDynObj) (LPVOID, LPVOID); // update func.
  // DWORD   dwLastUpdate;           // seconds count for last update
   //int    wUpdatePer;             // update period in seconds
  reserved: array [0..11] of CHAR;
   fInverse,
   fShow: BOOL;                  { if = 0, hide object }
   bCompoundFlag: BOOL;
   nUserID: UINT;

end;

POBJ_HEAD = ^OBJ_HEAD;

  CUR_PAR = record

       {  storage for current graph parameters}
    ld :LINEDESC;

    nXScaleType,       { ST_LINEAR or ST_LOG}
    nYScaleType: Integer;
    rxInt,             { intercepts}
    ryInt,

    rxMin,             { scaling values}
    rxMax,
    ryMin,
    ryMax,

    rxLMin,            { scaling values (logarithmic)}
    rxLMax,
    ryLMin,
    ryLMax: RealType;

  end;


 tm = record
         tm_sec,
         tm_min,
         tm_hour,
         tm_mday,
         tm_mon,
         tm_year,
         tm_wday,
         tm_yday,
         tm_isdst: INTEGER
end;

Ptm = ^tm;


MOUSE_EVENT_DEF = record

   nMouseAction: INTEGER;
  lpfnUserMouseProc: TFarProc;

  //x: INTEGER;
  //(HWND, LPVOID,  UINT , POINT );
end;

PMOUSE_EVENT_DEF = ^MOUSE_EVENT_DEF;

{************************************************************************}
{ Graph descriptor }

GRAPH_DEF = record


   thGraph: HGRAPH;            { handle }
   thwnd: HWnd;              { graph window handle}
   lpfnGraph: TFarProc;
   pCurrentObjDesc: POBJ_HEAD;  { pointer to currently processed object desc.}
   rgbWinBkColor,     { Chart window background color}
   rgbPlotBkColor: TColorRef;    { Plotting area background color}
   fFirstTime,
   fInit: BOOL;
   bd: LINEDESC;               { border line descriptor}
   fBorder : BOOL;         { border flag}
   hdcPrint: HDC;              { if not 0, output is to a printer}
   hdcMeta: HDC;           { if not 0, output is to a metafile}
   nDynamic: INTEGER;          { Set to TRUE if something is dynamic}


   rPlotCoord: TRect;        { logical coordinates of plotting area }
 pPageDesc: PPAGE_DEF;       { Page descriptor pointer}
   xWOrg,             { Window extents and origin in logical coords}
   yWOrg,
   cxWExt,
   cyWExt,
   xVOrg,             { Window extents and origin in device coords }
   yVOrg,
   cxVExt,
   cyVExt: INTEGER;
   fxOrg,             { Window extents and origin relative to page }
   fyOrg,
   fxExt,
   fyExt,
   fxExtOrig,
   fyExtOrig,

   rpX1,              { Plotting area coordinates relative}
   rpY1,              { to graph window}
   rpX2,
   rpY2: SINGLE;


   cp: CUR_PAR;               { current parameters}
{$ifndef RTFL}
  {$ifndef VER130}
   alignment3: INTEGER;
   {$endif}
{$endif}
   nMapMode: Integer;          {}
   cxLogPixel,        { width  of 1 pixel in logical units}
   cyLogPixel: INTEGER;        { height of 1 pixel in logical units}
   nObjCounter: Integer;
   hSelObj,           { selected object handle}
   hAxisX,
   hAxisY: HGOBJ;

   thdc: HDC;
   nNumObjs : Integer;        { number of objects in the graph }

   pGCO: POINTER;              // pointer to Graph Class Object (MFC only)
   dwSignature: DWORD;
   r1,r2,r3: BYTE;
   cIgnorePlot: BOOLEAN;
   cRaised: BYTE;                 { own hdc (real time only) }
   cRepaint: BYTE;          { if != 0 repaint graph background }

   wUserWord1,        { user can do anything with this fields }
   wUserWord2: WORD;

   hObjDup,          { memory handle for an object copy, for editing }
   hObjArr: HGLOBAL;
   pObjArr: ^HGLOBAL;          { pointer to array of object memory handles }
   bAddGrObj: BOOL;
   bBitBltMode: BOOL;
   hGrBitmap: THANDLE;
   hGrBitmapDC: HDC;
//   int      MouseEventMap[MAXMOUSEEVENTS];
//   void    (CALLBACK *lpfnUserMouseProc) (WND, PGRAPH_DEF,  UINT , POINT );
//    Alignment4: INTEGER;
    MouseEventMap: ARRAY[0..MAXMOUSEEVENTS-1] OF MOUSE_EVENT_DEF;
    hSaveAxisX: ARRAY[0..MAXSAVEAXES-1] OF HGLOBAL;
    hSaveAxisY: ARRAY[0..MAXSAVEAXES-1] OF HGLOBAL;
    nLTickSize: INTEGER;
    nSTickSize: INTEGER;

end;

PGRAPH_DEF = ^GRAPH_DEF;

{************************************************************************}
{ Dynamic data definitions **********************************************}
{************************************************************************}
const

 DYN_MAXVAL =32;      { maximal number of dynamic elements per object }
 DYNTITLELEN =64;          { DATA SET TITLE length }
 DYNUNITSLEN =16;          { length of eng. units string }
 MAX_DYNSETS =200;         { max. number of dynamic data sets }
 MAX_ALMESLEN  =32;
 TAGLEN        =32;        { channel tag length }
 MAX_ALM =7;   { max. number of alarm types }

{ Every dynamic object can have up to DYN_MAXVAL individual elements }

{************************************************************************}
type
ALARM_DEF = record                       { dynamic element descriptor }

    rAlVal: SINGLE;                { alarm value }
    szAlarmName: array [0..MAX_ALMESLEN-1] of CHAR; { alarm name }
end;

{************************************************************************}


DYNDATA_DEF = record


    cNumChannels,            { from 1 up to 32 }
    cUseCounter: Integer;
    szTitle: array[0..DYNTITLELEN-1] of CHAR; { unique title of the data set  2 }
    lpDDEDesc: POINTER;             { pointer to DDE descriptor, or NULL 44 }

    rNewVal, rPrevVal: array[0..DYN_MAXVAL-1] of SINGLE; { 48 }
    hRealData: HGLOBAL;            { memory handle for historical data array }
    hpRealData: HPFLOAT;           { huge pointer to historical data array }
    wRealTo: UINT;              { index to the next value }
    bHistFull: BOOL;            { TRUE after data array is first filled }
    nHistSize: INTEGER;            { number of samples in history buffer (real values) }
    szUnits: array[0..DYNUNITSLEN-1] of CHAR; { engineering units }
    cAlmMask: BOOL;
    nXY: INTEGER;                   { set to 1 if data used by XY plot }

    almHigh,             { alarm descriptors }
    almLow,
    almHH,
    almLL,
    almRate,             { rate of change value, per second }
    almDev,              { deviation (setp - meas) }
    almFail: ALARM_DEF;             { fail (DDE) }
    rSetp,
    rHyst,               { high and low alarm hysteresis }
    rDevHyst: Realtype;            { deviation alarm hysteresis     }
    szNormName: array[0..MAX_ALMNAME-1] of CHAR; { normal state name }
    almHighCh,almLowCh, almHHCh,almLLCh,
    almRateCh, almDevCh,
    almFailCh: ARRAY[0..DYN_MAXVAL-1] OF ALARM_DEF;
    rSetpCh: ARRAY[0..DYN_MAXVAL-1] OF Realtype;
    rHystCh: ARRAY[0..DYN_MAXVAL-1] OF Realtype;
    rDevHystCh: ARRAY[0..DYN_MAXVAL-1] OF Realtype;
    bAlmSetCh: ARRAY[0..DYN_MAXVAL-1] OF BOOL;
    bAlmEnableCh: ARRAY[0..DYN_MAXVAL-1] OF BOOL;
    bCheckChAlarms: BOOL;

    szNormNameCh: ARRAY[0..DYN_MAXVAL-1,0..MAX_ALMNAME-1] OF CHAR;

    bCheckAlarms: BOOL;        { if TRUE, check alarms }
    szTag: array[0..DYN_MAXVAL-1,0..TAGLEN-1] of CHAR; { channel tags }
    cPrevAlmOut,  { previous alarm output for every channel }
    cAlmOut: array[0..DYN_MAXVAL-1] of CHAR;      { alarm output for every channel }
    wBinNewVal,               { binary channels }
    wBinPrevVal: UINT;
    bNANCheck: INTEGER;
    hDataSet: HDATA;
end;

PDYNDATA = ^DYNDATA_DEF;



 SCATTER_DESC = record

        nOrigMarkerSize,
        nMarkerSize,
        nMarkerLogSize,
        nMarkerColor,
        nMarkerShape,
        nMarkerStyle: INTEGER;
         cDrop: BOOL;
         nAlignment1: INTEGER;
	 szBmpName: ARRAY[0..MAXBMNAMELEN-1] OF Char;
	 szMetaName: ARRAY[0..MAXBMNAMELEN-1] OF Char;
         hImage: HGOBJ;
 end;

PSCAT_DESC = ^SCATTER_DESC ;

HDIB = THANDLE;


QCBasePage = class (tobject)
public
  procedure BuildPage(p: PPAGE_DEF); virtual;
end;
PQCBasePage = ^QCBasePage;

QCBaseGraph = class (tobject)
 public
 procedure BuildGraph(p: PGRAPH_DEF; thdc: HDC); virtual;
end;
PQCBaseGraph = ^QCBaseGraph;



{************************************************************************
 * COLOR FUNCTIONS
 ************************************************************************}
function WGGetRGBColor (wColor:UINT): TColorRef; stdcall;
function WGGetPureColor (rgbColor:TColorRef): UINT;  stdcall;
function WGCreateShadeColor (rgbColor:TColorRef): TColorRef;  stdcall;

{**********************************************************************}
{ Graphics Setup                                                       }
{**********************************************************************}

function WGSetPlotArea (pGrDesc:PGRAPH_DEF; thdc:HDC;
   rX1, rY1, rX2, rY2:RealType; nColor:INTEGER): BOOL; stdcall;
procedure WGSetAxesScale (pGrDesc:PGRAPH_DEF;
         nXScaleType, nYScaleType:INTEGER); stdcall;
procedure  WGScalePlotArea (pGrDesc:PGRAPH_DEF; xmin,
     ymin, xmax, ymax:RealType); stdcall;
procedure  WGSetXYIntercepts (pGrDesc:PGRAPH_DEF;
    rxInt, ryInt:Realtype); stdcall;
procedure WGSetLineStyle (pGrDesc:PGRAPH_DEF; thdc:HDC;
    nStyle, nWidth, nColor:INTEGER); stdcall;
procedure WGSetDataFormat (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; width,
    prec:INTEGER); stdcall;
procedure WGSetTextParams (nColor, nFamily, nSize, nStyle:INTEGER); stdcall;
function  WGSetTextByName (nColor:INTEGER; szFontName:PChar; nSize,
     nStyle:INTEGER):BOOL; stdcall;
procedure WGRaiseGraph (pGrDesc:PGRAPH_DEF; nRaiseFlag:INTEGER); stdcall;

{************************************************************************
 * DRAWING FUNCTIONS
 ************************************************************************}
function  WGDrawXAxis (pGrDesc:PGRAPH_DEF; thdc:HDC;
     rTickSpace:RealType; nSmallTicks, nTickPos:INTEGER): HGOBJ; stdcall;
function  WGDrawYAxis (pGrDesc:PGRAPH_DEF; thdc:HDC;
     rTickSpace:RealType; nSmallTicks, nTickPos:INTEGER): HGOBJ; stdcall;
procedure WGDrawGrid (pGrDesc:PGRAPH_DEF; hAxis:HGOBJ; nGridType:INTEGER); stdcall;
function  WGGroupBargraph (pGrDesc:PGRAPH_DEF; thdc:HDC;
    hDataSet:HDATA; rWidth:Realtype;
    nJustify, nBarType, nGraphType:INTEGER;
    lpRgbBarColor:LPTColorRef;
    lpHatchStyle, lpBorderColor:LPInt): HGOBJ; stdcall;
function  WGFloatingBars (pGrDesc:PGRAPH_DEF; thdc:HDC;
    hDataSet:HDATA; rWidth:RealType;
    nJustify, nBarType:INTEGER;
    rgbBarColor:TColorRef; nHatchStyle, nBorderColor:INTEGER): HGOBJ; stdcall;

function  WGAutoAxes (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
    nRoundType, nInterceptFlag:INTEGER;
    var lphAxX, lphAxY, lphLabX, lphLabY:HGOBJ): BOOL; stdcall;

function  WGLinePlot (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
     bFill, bSpline:BOOL): HGOBJ; stdcall;

function  WGScatterPlot (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
    nMarkerShape, nMarkerColor, nMarkerSize, nMarkerStyle:INTEGER;
    bDrop:BOOL): HGOBJ; stdcall;

function  WGLineMarkerPlot (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
     nMarkerShape, nMarkerColor, nMarkerSize, nMarkerStyle:INTEGER): HGOBJ; stdcall;

function  WGBargraph (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
    rWidth:Realtype; nJustify, nBarType:INTEGER;
    rgbBarColor:TColorRef;
    nHatchStyle, nBorderColor:INTEGER): HGOBJ; stdcall;

function  WGStackedLines (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
   bFill:BOOL;
   lpLineStyle, lpLineWidth, lpLineColor:LPInt): HGOBJ; stdcall;

function  WGHighLowClose (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
    nMarkerShape, nMarkerColor, nMarkerSize, nMarkerStyle:INTEGER): HGOBJ; stdcall;

function  WGErrorBars (pGrDesc:PGRAPH_DEF; thdc:HDC; hDataSet:HDATA;
     nWidth:INTEGER): HGOBJ; stdcall;
function  WGLabelAxis (pGrDesc:PGRAPH_DEF; thdc:HDC; haxis:HGOBJ;
    nLabelPos:INTEGER; nFormat: UINT; nPrec, nLast:INTEGER;
    lpTextLast:PChar): HGOBJ; stdcall;

function  WGLabelAxisStrings (pGrDesc:PGRAPH_DEF; thdc:HDC; haxis:HGOBJ;
     nLabelPos, nFirstTick:INTEGER; hStr: HGLOBAL): HGOBJ; stdcall;
function  WGLabelAxisStringsPtr (pGrDesc:PGRAPH_DEF; thdc:HDC;
          haxis:HGOBJ; nLabelPos, nFirstTick:INTEGER; lpStr:LPSTR): HGOBJ; stdcall;
function  WGLabelAxisMonth (pGrDesc:PGRAPH_DEF; thdc:HDC; haxis:HGOBJ;
     nLabelPos, nFirstTick, nFirstMonth:INTEGER;
     bShort:BOOL): HGOBJ; stdcall;
function  WGLabelAxisDayWk (pGrDesc:PGRAPH_DEF; thdc:HDC; haxis:HGOBJ;
     nLabelPos, nFirstTick, nFirstDay:INTEGER; bShort:BOOL): HGOBJ; stdcall;
function  WGTextNorm (pGrDesc:PGRAPH_DEF; thdc:HDC; lpString:PChar;
          rX, rY:Realtype;
          wAlign: UINT; nOrientation:INTEGER): HGOBJ; stdcall;

function  WGText (pGrDesc:PGRAPH_DEF; thdc:HDC; hAxisX:HGOBJ;
    hAxisY:HGOBJ; lpString:PChar; rX, rY:RealType;
    wAlign: UINT;
    nOrientation:INTEGER): HGOBJ; stdcall;

function  WGTitleGraph (pGrDesc:PGRAPH_DEF; thdc:HDC; lpTitle:PChar): HGOBJ; stdcall;
function  WGTitleAxis (pGrDesc:PGRAPH_DEF; thdc:HDC; haxis:HGOBJ;
     nTitlePos:INTEGER; lpTitle:PChar): HGOBJ; stdcall;

procedure WGLabelPie (pGrDesc:PGRAPH_DEF; hPie:HGOBJ;
          hLabels: HGLOBAL); stdcall;

function  WGPieChart (pGrDesc:PGRAPH_DEF; thdc:HDC; hData:HDATA;
    nNumPoints, nPieStyle, nNumType, nNumPos:INTEGER;
    rDiam, rXCenter, rYCenter:Realtype;
    lpRgbPieColor,
    lpBorderColor, lpHatchStyle:LPINT;
    lprExplodeRel:LPReal): HGOBJ; stdcall;

function  WGAutoLegend (pGrDesc:PGRAPH_DEF; thdc:HDC;
          rX, rY:Realtype;
          nBorderColor, nBorderWidth,
          nTextColor, nBackColor, nLayout:INTEGER;
          hStr: HGLOBAL): HGOBJ; stdcall;

function WGAutoLegendGroup (pGrDesc:PGRAPH_DEF; thdc:HDC;
      rX, rY:Realtype;
      nBorderColor, nBorderWidth,
      nTextColor, nBackColor, nLayout:INTEGER;
      hStr: HGLOBAL;
      hObj:HGOBJ): HGOBJ; stdcall;

function  WGLegend (pGrDesc:PGRAPH_DEF; thdc:HDC;
        rX1, rY1, rX2, rY2:RealType;
        nBorderColor, nBorderWidth,
        nTextColor, nBackColor, nLayout:INTEGER;
        hStr: HGLOBAL): HGOBJ; stdcall;
function  WGLegendPtr (pGrDesc:PGRAPH_DEF; thdc:HDC;
        rX1, rY1, rX2, rY2:RealType;
        nBorderColor, nBorderWidth,
        nTextColor, nBackColor, nLayout:INTEGER;
        lpStr:LPSTR): HGOBJ; stdcall;

function WGLegendGroup (pGrDesc:PGRAPH_DEF; thdc:HDC;
        rX1, rY1, rX2, rY2:Realtype;
        nBorderColor, nBorderWidth, nTextColor,
        nBackColor, nLayout:INTEGER;
        hStr: HGLOBAL; hObj:HGOBJ): HGOBJ; stdcall;

function WGLegendGroupPtr (pGrDesc:PGRAPH_DEF; thdc:HDC;
        rX1, rY1, rX2, rY2:Realtype;
        nBorderColor, nBorderWidth, nTextColor,
        nBackColor, nLayout:INTEGER;
        lpStr:LPSTR; hObj:HGOBJ): HGOBJ; stdcall;

function WGLineNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
         rX1, rY1, rX2, rY2:RealType): HGOBJ; stdcall;

function WGArrowNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
    rX1, rY1, rX2, rY2:Realtype;
    nWidth, nLength:INTEGER;
    bStart, bEnd, bFill:BOOL): HGOBJ; stdcall;

function WGRectangleNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
    rX1, rY1, rX2, rY2:Realtype;
    nBorderColor, nBorderWidth:INTEGER;
     bFill:BOOL;
     rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGRectangleNormEx (pGrDesc:PGRAPH_DEF; thdc:HDC;
    rX1, rY1, rX2, rY2:Realtype;
    nBorderColor, nBorderWidth:INTEGER;
     bFill:BOOL;
     rgbBackColor:TColorRef; n3D:INTEGER): HGOBJ; stdcall;

function WGEllipseNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
   rX1, rY1, rX2, rY2:Realtype;
   nBorderColor, nBorderWidth:INTEGER;
   bFill:BOOL; rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGArcNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
    rX1, rY1, rX2, rY2, rX3,
    rY3, rX4, rY4:Realtype): HGOBJ; stdcall;

function WGPieNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
    rX1, rY1, rX2, rY2, rX3, rY3, rX4, rY4:Realtype;
    nBorderColor, nBorderWidth:INTEGER;
    bFill:BOOL;
    rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGLine (pGrDesc:PGRAPH_DEF; thdc:HDC; hAxisX:HGOBJ;
    hAxisY:HGOBJ; rX1, rY1, rX2, rY2:Realtype): HGOBJ; stdcall;

function WGArrow (pGrDesc:PGRAPH_DEF; thdc:HDC;
    hAxisX:HGOBJ; hAxisY:HGOBJ;
    rX1, rY1, rX2, rY2:Realtype;
    nWidth, nLength:INTEGER;
    bStart, bEnd, bFill:BOOL): HGOBJ; stdcall;

function WGRectangle (pGrDesc:PGRAPH_DEF; thdc:HDC;
         hAxisX:HGOBJ; hAxisY:HGOBJ;
         rX1, rY1, rX2, rY2:Realtype;
         nBorderColor, nBorderWidth:INTEGER;
         bFill:BOOL;
         rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGEllipse (pGrDesc:PGRAPH_DEF; thdc:HDC;
         hAxisX:HGOBJ; hAxisY:HGOBJ;
         rX1, rY1, rX2, rY2:Realtype;
         nBorderColor, nBorderWidth:INTEGER;
         bFill:BOOL; rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGArc (pGrDesc:PGRAPH_DEF; thdc:HDC;
         hAxisX:HGOBJ; hAxisY:HGOBJ;
         rX1, rY1, rX2, rY2,
         rX3, rY3, rX4, rY4:Realtype): HGOBJ; stdcall;

function WGPie (pGrDesc:PGRAPH_DEF; thdc:HDC;
    hAxisX:HGOBJ; hAxisY:HGOBJ;
    rX1, rY1, rX2, rY2, rX3, rY3, rX4, rY4:Realtype;
    nBorderColor, nBorderWidth:INTEGER;
    bFill:BOOL; rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGBitmapNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
         rX1, rY1, rX2, rY2:Realtype;
         nMode:INTEGER; lpName:PChar): HGOBJ; stdcall;

function WGBitmap (pGrDesc:PGRAPH_DEF; thdc:HDC;
         hAxisX:HGOBJ; hAxisY:HGOBJ;
         rX1, rY1, rX2, rY2:Realtype;
         nMode:INTEGER; lpName:PChar): HGOBJ; stdcall;

function WGPolygon (pGrDesc:PGRAPH_DEF; thdc:HDC; hAxisX:HGOBJ;
   hAxisY:HGOBJ;
    lprX, lprY:LPReal;
   nNumPoints, nBorderColor, nBorderWidth:INTEGER;
   bFill:BOOL; rgbBackColor:TColorRef): HGOBJ; stdcall;

function WGPolygonNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
	 lprX, lprY:LPReal;
        nNumPoints, nBorderColor, nBorderWidth:INTEGER;
        bFill:BOOL; rgbBackColor:TColorRef): HGOBJ; stdcall;

{************************************************************************
 * DATA SETS FUNCTIONS
 ************************************************************************}

procedure WGFreeDataSet (hDataSet:HDATA; bFreeData:BOOL); stdcall;
function WGLoadASCIIDataSet (lpFileName:PChar;
     lpDataName:PChar): HDATA; stdcall;
function WGSaveASCIIDataSet (hDataSet:HDATA; lpFileName:PChar;
      lpFormat:PChar): BOOL; stdcall;

function WGDefineDataSet (lpDataName:PChar;
      hX, hY:HGLOBAL; lNumPoints:LongInt): HDATA; stdcall;
function WGDefineDataSetPtr (lpDataName:PChar;
      hpX, hpY:LPREAL; lNumPoints:LongInt): HDATA; stdcall;

function WGDefineGroupDataSet (lpDataName:PChar;
     hIndep, hDep:HGLOBAL; lNumPoints:LongInt;
     nGroupSize:INTEGER): HDATA; stdcall;
function WGDefineGroupDataSetPtr (lpDataName:PChar;
     hpIndep, hpDep:LPREAL; lNumPoints:LongInt;
     nGroupSize:INTEGER): HDATA; stdcall;
function WGSortDataX (hDataSet:HDATA; bDirection:BOOL): BOOL; stdcall;
function WGSortDataY (hDataSet:HDATA; bDirection:BOOL): BOOL; stdcall;
function WGGetMinMaxX (hDataSet:HDATA;
         var lpXMin, lpXMax:RealType): BOOL; stdcall;
function WGGetMinMaxY (hDataSet:HDATA;
         var lpYMin, lpYMax:Realtype): BOOL; stdcall;

function WGCompressData (hOrigData:HDATA;
 wType, wSkip: UINT; lFirst, lLast:LongInt; lpNewSetName:PChar): HDATA; stdcall;
function WGPasteDataSet (lpDataName:PChar): HDATA; stdcall;
function WGGetDataSetArrays (hDataSet:HDATA;
    var lphX, lphY:HGLOBAL;
    var lpNumPoints:LongInt;
    var lpGroupSize:INTEGER): BOOL; stdcall;
function WGGetDataSetArraysPtr (hDataSet:HDATA;
    lphX, lphY:LPREAL;
    var lpNumPoints:LongInt;
    var lpGroupSize:INTEGER): BOOL; stdcall;

function WGGetDataSet (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): HDATA; stdcall;

procedure WGReconnectDataSet (pGrDesc:PGRAPH_DEF; hObj: HGOBJ;
         hDataSet: HDATA); stdcall;

{************************************************************************
 * Graph and Page Functions
 ************************************************************************}
procedure WGPrintGraph (pGrDesc:PGRAPH_DEF); stdcall;
procedure WGPrintPage (pPageDesc:PPAGE_DEF); stdcall;
function  WGCopyGraph (pGrDesc:PGRAPH_DEF): BOOL; stdcall;
function  WGCopyPage (pPageDesc:PPAGE_DEF): BOOL; stdcall;
procedure WGClosePage (pPageDesc:PPAGE_DEF); stdcall;

function  WGGetPageDesc (thwnd:HWnd):PPAGE_DEF ; stdcall;
function  WGGetGraphDesc (thwnd:HWnd):PGRAPH_DEF ; stdcall;

procedure WGDeleteGraph (pGrDesc:PGRAPH_DEF); stdcall;
function  WGIsDescValid (pDesc:Pointer): BOOL; stdcall;
function  WGIsGraphDescValid (pGrDesc:Pointer): BOOL; stdcall;
function  WGIsPageDescValid (pPgDesc:Pointer): BOOL; stdcall;

procedure WGUpdatePage (pPgDesc:PPAGE_DEF); stdcall;


{************************************************************************
 * METAFILE FUNCTIONS
 ************************************************************************}

function WGSavePageMeta (pPageDesc:PPAGE_DEF;
    bPlaceable:BOOL; lpFileName:PChar): BOOL; stdcall;
function  WGGetMetafile (lpFileName:PChar): POBJ_META; stdcall;
procedure WGDeleteMetafile (pMetaDesc:POBJ_META); stdcall;
function WGPlayMetafile (thwnd:HWnd; pMetaDesc:POBJ_META;
     x1, y1, x2, y2:INTEGER): BOOL; stdcall;
function WGMetafileNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
     rX1, rY1, rX2, rY2:Realtype; lpName:PChar): HGOBJ; stdcall;
function WGMetafile (pGrDesc:PGRAPH_DEF; thdc:HDC;
   hAxisX:HGOBJ; hAxisY:HGOBJ;
   rX1, rY1, rX2, rY2:Realtype;
   lpName:PChar): HGOBJ; stdcall;
function  WGConvertPageToMeta (pPageDesc:PPAGE_DEF): POBJ_META; stdcall;

{************************************************************************
 * FFT FUNCTIONS
 ************************************************************************}

procedure WGDSPWindow (lpRealData, lpImData:LPReal;
     lNumdat:LongInt;
     nWindowType:INTEGER); stdcall;
function WGComplexFFT (lpRealData, hpImData:LPReal;
    n:longint; bInverse:BOOL): BOOL; stdcall;
function WGRealFFT (hpX, hpSinc:LPReal;
                     n:LongInt; bInverse:BOOL): BOOL; stdcall;
function WGPowerSpectrum (lpRealData, lpImData:LPReal;
	 lNumdat:LongInt; rInterval:Realtype): BOOL; stdcall;
procedure WGFFTMagnitude (hpCos, hpSin:LPReal;
     lNumdat, i:LongInt; var pMag:Realtype); stdcall;
procedure WGFFTPhase (hpCos, hpSin:LPReal;
         i:LongInt; var  pPhase:RealType); stdcall;
procedure WGFFTFrequency (lNumdat:LongInt; rSampleFreq:Realtype;
     i:LongInt; var pFreq:RealType); stdcall;


{************************************************************************
 * GUI FUNCTIONS
 ************************************************************************}

{---- Graph/Page ------}

function  WGGetPageWindow (pPageDesc:PPAGE_DEF): HWnd; stdcall;
procedure WGToggleSelectors (pPageDesc:PPAGE_DEF; bOn:BOOL); stdcall;
procedure WGToggleHigh (pPageDesc:PPAGE_DEF; bOn:BOOL); stdcall;
procedure WGChangeGraphPos (pGrDesc:PGRAPH_DEF;
           rX1, rY1, rX2, rY2:Realtype); stdcall;
procedure WGGetGraphPos (pGrDesc:PGRAPH_DEF;
          var  lprX1, lprY1, lprX2, lpfY2:Realtype); stdcall;
procedure WGRedrawGraph (pGrDesc:PGRAPH_DEF; bRecalc:BOOL); stdcall;
function  WGGetGraphWindow (pGrDesc:PGRAPH_DEF): HWnd; stdcall;
procedure WGChangeGraphBackgnd (pGrDesc:PGRAPH_DEF; rgbColor:TColorRef); stdcall;
function  WGGetGraphBackgnd (pGrDesc:PGRAPH_DEF): TColorRef; stdcall;
procedure WGSelectGraph (pGrDesc:PGRAPH_DEF); stdcall;
function  WGGetSelectedGraph (pPageDesc:PPAGE_DEF): PGRAPH_DEF; stdcall;
procedure WGSetGraphBorder (pGrDesc:PGRAPH_DEF; bOn:BOOL;
          nColor, nWidth:INTEGER); stdcall;
procedure WGBlowupGraph (pGrDesc:PGRAPH_DEF; bDir:BOOL); stdcall;
procedure WGEditGraphDlg (pPageDesc:PPAGE_DEF); stdcall;

{---- Plotting Area ----}
procedure WGGetPlotPos (pGrDesc:PGRAPH_DEF;
                     var  lprX1, lprY1, lprX2, lprY2:Realtype); stdcall;
procedure WGChangePlotPos (pGrDesc:PGRAPH_DEF;
          rX1, rY1, rX2, rY2:Realtype); stdcall;
procedure WGChangePlotBackgnd (pGrDesc:PGRAPH_DEF;
          rgbColor:TColorRef); stdcall;
function  WGGetPlotBackgnd (pGrDesc:PGRAPH_DEF): TColorRef; stdcall;

{---- Object -----}
function  WGGetSelObject (pGrDesc:PGRAPH_DEF;
          var lpSelPoint:UINT; var lpSelGroup:INTEGER): HGOBJ; stdcall;

procedure   WGSelObject (pGrDesc:PGRAPH_DEF; hObj:HGOBJ); stdcall;
procedure   WGRedrawObject (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    bRecalc:BOOL); stdcall;
function  WGGetObjectCoord (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    var  lpX1, lpY1, lpX2, lpY2:RealType): BOOL; stdcall;
function WGGetObjectCoordNorm (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     var lprX1, lprY1, lprX2, lprY2:Realtype): BOOL; stdcall;
function  WGGetObjectPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    var  lpX1, lpY1, lpX2, lpY2:RealType): BOOL; stdcall;
function WGGetObjectPosNorm (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     var lprX1, lprY1, lprX2, lprY2:Realtype): BOOL; stdcall;

function WGChangeObjectCoord (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     rX1, rY1, rX2, rY2:Realtype; bRedraw:BOOL): BOOL; stdcall;

function WGChangeObjectCoordNorm (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     rX1, rY1, rX2, rY2:Realtype; bRedraw:BOOL): BOOL; stdcall;

function WGDuplicateObject (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): HGOBJ; stdcall;
procedure WGObjUpdate (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; hObjDup:HGOBJ); stdcall;
procedure WGDeleteObject (pGrDesc:PGRAPH_DEF; hObj:HGOBJ); stdcall;

function WGGetObjectType (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGChangeLineColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nNewColor, n:INTEGER): BOOL; stdcall;
function  WGGetObjSize (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetObjTypeSize (nObjType:INTEGER): INTEGER; stdcall;

function WGGetLineColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; n:INTEGER): TColorRef; stdcall;
function  WGGetAreaColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     n:INTEGER): TColorRef; stdcall;
function WGChangeAreaColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     rgbColor:TColorRef; n:INTEGER): BOOL; stdcall;
function WGChangeLineWidth (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
      nNewWidth, n:INTEGER): BOOL; stdcall;
function  WGGetLineWidth (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; n:INTEGER): INTEGER; stdcall;
function WGChangeLineStyle (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    nNewStyle, n:INTEGER): BOOL; stdcall;
function  WGGetLineStyle (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; n:INTEGER): INTEGER; stdcall;

function WGToggleSpline (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; bOn:BOOL): BOOL; stdcall;
function WGGetFillFlag (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): BOOL; stdcall;
function WGGetSplineFlag (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): BOOL; stdcall;
function WGChangeObjFill (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; bOn:BOOL): BOOL; stdcall;
function WGChangeMarkerColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nColor:INTEGER): BOOL; stdcall;
function  WGGetMarkerColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGChangeMarkerType (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nMarkerShape, nMarkerSize, nMarkerStyle:INTEGER): BOOL; stdcall;

function WGGetMarkerType (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    var lpMarkerShape, lpMarkerStyle, lpMarkerSize:INTEGER): BOOL; stdcall;
procedure WGShowObject (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    bShow:BOOL); stdcall;

{---- Axes ------}
function WGChangeAxisRange (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
     rMin, rMax:Realtype; bUpdate:BOOL): BOOL; stdcall;
function WGChangeAxisIntercept (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
     rInt:RealType; bUpdate:BOOL): BOOL; stdcall;
function WGChangeAxisScale (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    nScaleType:INTEGER; bUpdate:BOOL): BOOL; stdcall;
procedure WGSetTickSize (pPgDesc:PPAGE_DEF; nMajorSize,
     nMinorSize:INTEGER); stdcall;
function  WGChangeAxisTicks (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    rTickSpace:Realtype; nSmallTicks, nTickPos:INTEGER): BOOL; stdcall;
function  WGChangeGrid (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
     nGridType, nNewStyle, nNewWidth, nNewColor:INTEGER): BOOL; stdcall;
function  WGGetAxisTicks (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    var  lpTickSpace:Realtype; var lpSmallTicks, lpTickPos:INTEGER): BOOL; stdcall;
function WGGetAxisRange (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    var  lprMin, lprMax, lprInt:Realtype): BOOL; stdcall;
function WGGetAxisScale (pGrDesc:PGRAPH_DEF; hAx:HGOBJ): INTEGER; stdcall;
function WGGetAxisDir (pGrDesc:PGRAPH_DEF; hAx:HGOBJ): INTEGER; stdcall;
function WGToggleGrid (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
     nGridType:INTEGER; bOn:BOOL): BOOL; stdcall;
function WGGetGrid (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    var lpbGridMajor, lpbGridMinor:BOOL;
    var ldGridMajor, ldGridMinor:PLINEDESC): BOOL; stdcall;
procedure WGToggleGridsOrder (bGridsBelow:BOOL); stdcall;

{---- Bars ----}

function WGGetBarWidth (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    var rWidth:Realtype): BOOL; stdcall;
function WGChangeBarWidth (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     rWidth:Realtype): BOOL; stdcall;
function WGChangeHatchStyle (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nHatchStyle, n:INTEGER): BOOL; stdcall;
function WGGetHatchStyle (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; n:INTEGER): INTEGER; stdcall;
function WGChangeBarJust (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; nPos:INTEGER): BOOL; stdcall;
function WGGetBarJust (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetPlotType (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGChangePlotType (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nNewType:INTEGER): BOOL; stdcall;

{---text----}
function  WGChangeTextColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    nColor:INTEGER): BOOL; stdcall;
function  WGGetTextColor (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function  WGChangeFont (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
   lpFaceName:PChar; nSize, nOrientation, nWeight:INTEGER;
   bItalic, bUnderline:BOOL): BOOL; stdcall;
function WGGetFontName (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): PChar; stdcall;
function WGGetFontSize (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetFontWeight (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetFontOrient (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetFontItal (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): BOOL; stdcall;
function WGGetFontUnder (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): BOOL; stdcall;
function WGGetFontEsc (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetString (pGrDesc:PGRAPH_DEF; hObj:HGOBJ; n:INTEGER): PChar; stdcall;
function WGChangeString (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
        lpNewString:PChar; n:INTEGER): BOOL; stdcall;
procedure  WGGetTextSizeNorm (pGrDesc:PGRAPH_DEF; thdc:HDC;
    nDir:INTEGER; lpString:PChar; nNumChar:INTEGER;
    var rWidth, rHeight:RealType); stdcall;

{----arrows----}
function WGChangeArrow (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nLength, nWidth:INTEGER): BOOL; stdcall;
function WGChangeArrowFill (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    bFill:BOOL): BOOL; stdcall;
function WGChangeArrowPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nPos:INTEGER): BOOL; stdcall;
function WGGetArrowWidth (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetArrowLength (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetArrowFill (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): BOOL; stdcall;
function WGGetArrowPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;

{-----Labels------}
function WGGetLastLabelFlag (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGGetLastLabelText (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): PChar; stdcall;
function WGGetLabelsPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;
function WGChangeLabelsPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nNewPos:INTEGER): BOOL; stdcall;
function WGGetLabelsFormat (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): UINT; stdcall;
function WGChangeLabelsFormat (pGrDesc:PGRAPH_DEF;
    hObj:HGOBJ; nFormat:UINT): BOOL; stdcall;
function WGGetLabelsPrec (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): UINT; stdcall;
function WGChangeLabelsPrec (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nPrec: UINT): BOOL; stdcall;
function WGChangeLastLabel (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nLast:INTEGER; lpNewText:PChar): BOOL; stdcall;

{----Pie Chart----}
function WGGetPieExpl (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
    n:INTEGER; var lpExpl:RealType): BOOL; stdcall;
function WGChangePieExpl (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
          rExplode:Realtype; n:INTEGER): BOOL; stdcall;
function WGChangePieTextPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ;
     nPos:INTEGER): BOOL; stdcall;
function  WGGetPieTextPos (pGrDesc:PGRAPH_DEF; hObj:HGOBJ): INTEGER; stdcall;

function WGGetLineDesc (pGrDesc:PGRAPH_DEF;
    hObj:HGOBJ; n:INTEGER): PLINEDESC; stdcall;

{---- Mouse ----}
function WGGetMousePos (pGrDesc:PGRAPH_DEF; hAxisX:HGOBJ;
    hAxisY:HGOBJ; var lprX, lprY:REALTYPE): BOOL; stdcall;
procedure WGGetMousePosNorm (pGrDesc:PGRAPH_DEF;
    var lprX, lprY:Realtype); stdcall;
procedure WGShowMouseCoord (thwnd:HWnd; mType:INTEGER;
    bStartStop:BOOL); stdcall;
procedure WGGetGraphMouseEvent (thwnd:HWnd; message:UINT; ptMouse:TPOINT); stdcall;

{************************************************************************
 * MISCELLANEOUS FUNCTIONS
 ************************************************************************}

function  WGCopyMem (hMem: HGLOBAL): HGLOBAL; stdcall;
procedure WGSetOKCursor (hDlg:HWnd); stdcall;
procedure WGPrinterSetup (thwnd:HWnd); stdcall;
procedure WGSetPrintOptions (bGraphBk, bPlotBk, bBorder, bKeepAspect:BOOL;
          nPrintStyle:INTEGER; rX, rY:Realtype); stdcall;
procedure WGPrintOptionsDlg;
{
  PROCEDURE WGOKMsgBox (PSTR pCaption, PSTR pFormat, ...);
}
procedure WGEnableErrorMessages (bFlag:BOOL); stdcall;
function  WGGetLastError: INTEGER; stdcall;
function  WGMenuCheck (pPageDesc:PPAGE_DEF; item, pos:INTEGER): BOOL; stdcall;
procedure WGStart; stdcall;
procedure WGCleanup (bFreeData:BOOL); stdcall;
procedure WGEditObject (thwnd:HWND); stdcall;

procedure WGGraphKeyEvent (thwnd:HWND; message:UINT; nVKey: UINT;
      dwKeyData:POINTER); stdcall;
procedure DefEditObject (pGrDesc:PGRAPH_DEF); stdcall;
function ObjFind (thwnd:HWnd): HGOBJ; stdcall;
procedure WGShowData (pGrDesc:PGRAPH_DEF; hObj:HGOBJ); stdcall;
function WGGetVersion (var lpSec:INTEGER): INTEGER; stdcall;
function  WGGetDate: LPSTR; stdcall;
procedure CleanGDI (thdc:HDC); stdcall;

{**********************************************************************}
{ New 2.1 Function, outside of normal functional category                                }

{**************************************************************************}
function WGStartZoom (hwndGraph:HWND; hAxisX, hAxisY:HGOBJ;
         uMouseMessage:UINT; bUpdate:BOOL): BOOL; stdcall;
function WGGetZoom (var  lprLeft, lprTop, lprRight, lprBottom:Realtype): BOOL; stdcall;
function WGSetDataCursor (pGrDesc:PGRAPH_DEF; thdc:HDC;
	nType:INTEGER; hAxisX, hAxisY:HGOBJ;
	nSize, nLineWidth, nLineStyle, nColor:INTEGER): HGOBJ; stdcall;
procedure WGMoveDataCursor (pGrDesc:PGRAPH_DEF; hCursor:HGOBJ;
	 rX, rY:Realtype; bVisible:BOOL); stdcall;
function  WGGetNearestPoint (pGrDesc:PGRAPH_DEF;
         rX, rY:Realtype; nMode:INTEGER;
         var  lpX, lpY:Realtype;
	 lphdata:LPHDATA;
         lpNum:PUINT): BOOL; stdcall;
function WGMarkDataPoint (hDataSet:HDATA; n:UINT;
                    bSkip:BOOL): BOOL; stdcall;
function WGIsDataPointGood (hDataSet:HDATA;
                             n:UINT): BOOL; stdcall;
function WGRoundAxis (pGrDesc:PGRAPH_DEF; hAx:HGOBJ;
    var lprMin, lprMax, lprTickSpace:Realtype;
    bUpdate:BOOL): BOOL; stdcall;


{ REV 3.0 }

Procedure WGSetPrintOrient ( nOrient: INTEGER);  stdcall;
Function WGGetPrintOrient : INTEGER;  stdcall;
Procedure WGToggleOKCursor (bOn: BOOL);  stdcall;
Function WGGetNearestRGBColor (rgbColor: COLORREF ): UINT; stdcall;
Function WGMultiText (pGrDesc: PGRAPH_DEF; thdc: HDC;  hAxisX,
     hAxisY: HGOBJ; lpString:PChar;  rX,  rY: realtype;
     wAlign: UINT;  nOrientation: INTEGER): HGOBJ; stdcall;

Function WGMultiTextNorm (pGrDesc: PGRAPH_DEF; thdc: HDC;
    lpString:PChar;   rX,   rY: realtype;
    wAlign: UINT;  nOrientation: INTEGER): HGOBJ; stdcall;


// Added to GrPrim.C
Procedure WGToggleGridsLine( bGridsBelow: BOOL); stdcall;

Function  WGPolyline (pGrDesc: PGRAPH_DEF; thdc: HDC;  hAxisX,
		 hAxisY:HGOBJ;  lprX, lprY: LPREAL;
                 nNumPoints,  nBorderColor, nBorderWidth: INTEGER): HGOBJ; stdcall;

Function  WGPolylineNorm (pGrDesc: PGRAPH_DEF; thdc: HDC;
		 lprX, lprY: LPREAL;   nNumPoints,
		 nBorderColor,  nBorderWidth: INTEGER):HGOBJ ; stdcall;

 Function WGStartXCursor (hwndGraph: HWND;  hAxisX,
    hAxisY: HGOBJ;  uMouseMessage: UINT;  mode: INTEGER; bUpdate: BOOL):BOOL; stdcall;
 Function WGGetXCursor (VAR lprLeft, lprTop, lprRight, lprBottom: Realtype):BOOL; stdcall;
 Function WGSetXCursorParams (nLineStyle, nSize: INTEGER):BOOL; stdcall;
 Function WGGetXCursorParams (VAR nLineStyle, nSize: INTEGER): BOOL; stdcall;

 Function WGStartObjMove (hwndGraph: HWND;  hAxisX,
     hAxisY: HGOBJ;  uMouseMessage: UINT;  mode: INTEGER;  bUpdate: BOOL):BOOL; stdcall;
 Function WGGetObjMove (VAR lprLeft,  lprTop, lprRight,lprBottom: Realtype):BOOL; stdcall;

 Function WGStartSuperZoom ( hwndGraph: HWND;
    hAxisX, hAxisY: PHGOBJ;
    nNumAxisX,  nNumAxisY, nZoomAxisMode, nZoomRoundMode: INTEGER;
    uMouseMessage: UINT; bUpdate: BOOL):BOOL; stdcall;

// Added to Dataset.c
 Function WGGetMinMaxYGroup (hDataSet: HDATA;  nGroupNum,  nGroupMode: INTEGER;
        VAR  lpYMin, lpYMax: Realtype): BOOL; stdcall;
 Function WGCreateEvenGridDataSetPtr ( lpDataName: PChar;  hpZ: LPREAL;
    rStartX, rStartY, rIncX, rIncY: realtype;
	 lNumX, lNumY: Integer):HDATA; stdcall;
 Function WGDefineEvenGridDataSetPtr
      ( lpDataName: PChar;
        hpX,  hpY: LPREAL;
       lNumX, lNumY: INTEGER):HDATA; stdcall;
 Function WGSetDataSetRegularGrid (hDataSet: HDATA;
			  lNumX, lNumY: INTEGER): BOOL; stdcall;
 Function WGGetContourMinMaxXYZ (hDataSet: HDATA;
	  VAR lpXMin, lpXMax,lpYMin, lpYMax,lpZMin, lpZMax: Realtype):BOOL; stdcall;
 Function WGGetNearestPointPlotObjs (
	pGrDesc: PGRAPH_DEF; hPlotObj: PHGOBJ; nNumPlotObj: INTEGER;
	rX, rY: Realtype;  nMode: INTEGER; VAR lpX, lpY: Realtype;
	VAR lphData: HDATA; VAR lpNum: INTEGER): BOOL; stdcall;
 Function WGGetNearestPointNormalized (pGrDesc: PGRAPH_DEF;  rX,
	 rY: Realtype;  nMode: INTEGER; VAR lpX, lpY: Realtype;
 	VAR lphData: HDATA; VAR lpNum: INTEGER): BOOL; stdcall;

 Function WGLabelAxisDate (pGrDesc: PGRAPH_DEF; thdc: HDC; hAxis: HGOBJ;
     nLabelPos,  nDateFormat,  nBaseUnit: INTEGER;
        tStartDate: Ptm;
	szDateFormat: PChar;
	nLast: INTEGER;  lpTextLast: PChar): HGOBJ; stdcall;
 Function WGChangeDateFormat (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ;  nDateFormat: INTEGER): BOOL; stdcall;
  Function WGSetTimeFormat (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ; nTimeFormat: INTEGER ): BOOL; stdcall;
  Function WGChangeDateFormatString (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ; szDateFormat: PChar): BOOL; stdcall;
  Function WGChangeDateBaseUnits (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ; nBaseUnit: INTEGER ):BOOL; stdcall;
  Function WGChangeDateStartDate (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ; tStartDate: Ptm):BOOL; stdcall;
  Function WGGetDateFormat (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ):INTEGER; stdcall;
  Function WGGetTimeFormat (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ): INTEGER; stdcall;
  Function WGGetDateFormatString (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ; szDateFormat: PChar):BOOL; stdcall;
  Function WGGetDateBaseUnits (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ): INTEGER; stdcall;
  Function WGGetDateStartDate (pGrDesc: PGRAPH_DEF;
    hObj: HGOBJ;  tStartDate: Ptm): BOOL; stdcall;

 Function  WGRoundAxis2 ( pGrDesc: PGRAPH_DEF;  nAxOrient,
	 nAxScale: INTEGER;
         VAR lprMin, lprMax, lprTickSpace: Realtype;  nRoundMode: INTEGER): BOOL;  stdcall;

 Function WGRoundAxis3 (pGrDesc: PGRAPH_DEF; hAx: HGOBJ;
	nRoundMode: INTEGER;
    VAR lprMin, lprMax, lprTickSpace: Realtype; bUpdate: BOOL ): BOOL; stdcall;
 Function WGAxes (pGrDesc: PGRAPH_DEF; thdc: HDC;
	 xMin,  yMin,  xMax,  yMax: Realtype;
     nRoundTypeX,  nRoundTypeY,  nInterceptFlag: INTEGER;
        VAR lphAxX, lphAxY, lphLabX, lphLabY: HGOBJ):BOOL; stdcall;
 Function WGGetDataSetsRange( hDataSets: PHDATA; nNumDataSets: INTEGER;
	VAR rMinX,  rMinY,  rMaxX,  rMaxY: Realtype):BOOL; stdcall;
 Function WGGetGraphPlotObjRange(pGrDesc: PGRAPH_DEF;
    VAR rXMin,  rYMin,  rXMax,  rYMax: Realtype): BOOL; stdcall;
 Function WGAutoAxesDataSets(pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSets: PHDATA;  nNumDataSets,
     nRoundType,  nInterceptFlag: INTEGER;
	VAR lphAxX,  lphAxY,
	 lphLabX,  lphLabY: HGOBJ):BOOL; stdcall;
 Function WGAutoOneAxisDataSets (pGrDesc: PGRAPH_DEF; thdc: HDC;
     hDataSet: PHDATA;  nNumDataSets,
     nRoundTypeX,  nRoundTypeY,  nInterceptFlag,  nAxis: INTEGER;
	 rMin,  rMax: Realtype;
	VAR lphAxX,  lphLabX,
	 lphAxY,  lphLabY: HGOBJ): BOOL; stdcall;
 Function WGReAutoOneAxisDataSets (pGrDesc: PGRAPH_DEF;
 	hDataSet: PHDATA;  nNumDataSets,
    nRoundTypeX,  nRoundTypeY,  nInterceptFlag,  nAxis: INTEGER;
	 rMin,  rMax: Realtype;
	 hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
 Function WGReAxes (pGrDesc: PGRAPH_DEF;
	 xMin,  yMin,  xMax,  yMax: Realtype;
     nRoundTypeX,  nRoundTypeY,  nInterceptFlag: INTEGER;
	 hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
 Function WGReAutoAxes (pGrDesc: PGRAPH_DEF; hDataSet: HDATA;
     nRoundType,  nInterceptFlag: INTEGER;
	 hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
 Function WGReAutoAxesDataSets (pGrDesc: PGRAPH_DEF;
     hDataSet: PHDATA;  nNumDataSets,
    nRoundType,  nInterceptFlag: INTEGER;
	 hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
 Function WGChangeLabelsIntercept (pGrDesc: PGRAPH_DEF; hAx: HGOBJ;
     rInt: Realtype;  bUpdate: BOOL): BOOL; stdcall;
Procedure WGSaveAxesState(pGrDesc: PGRAPH_DEF); stdcall;
Procedure WGRestoreAxesState (pGrDesc: PGRAPH_DEF); stdcall;
 Function WGGetAxisIntercepts (pGrDesc: PGRAPH_DEF; hAx: HGOBJ;
     VAR lprAxisInt,  lprLabelsInt: Realtype):BOOL; stdcall;
Procedure WGSetAxisIntercepts (pGrDesc: PGRAPH_DEF; thdc: HDC; hAx: HGOBJ;
      rAxisInt,  rLabelsInt: Realtype); stdcall;
 Function WGAutoAxesGroupData (pGrDesc: PGRAPH_DEF; thdc: HDC; hDataSet: HDATA;
     nGroupMode,  nRoundType,  nInterceptFlag: INTEGER; VAR lphAxX, lphAxY,
	 lphLabX,  lphLabY: HGOBJ):BOOL; stdcall;
 Function WGReAutoAxesGroupData (pGrDesc: PGRAPH_DEF; hDataSet: HDATA;
     nGroupMode,  nRoundType,  nInterceptFlag: INTEGER;
     hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
 Function WGAutoAxesContourData (pGrDesc: PGRAPH_DEF; thdc: HDC;
	hDataSet: HDATA;    nRoundType,  nInterceptFlag: INTEGER;
        VAR  lphAxX,  lphAxY, lphLabX,  lphLabY: HGOBJ): BOOL; stdcall;
 Function WGReAutoAxesContourData (pGrDesc: PGRAPH_DEF;
	hDataSet: HDATA;  nRoundType, nInterceptFlag: INTEGER;
        hAxisX,  hAxisY: HGOBJ):BOOL; stdcall;
Procedure WGGetAxisPhysicalScale (pGrDesc: PGRAPH_DEF;
     hAx: HGOBJ;  VAR  rMinX, rMinY, rMaxX, rMaxY: Realtype); stdcall;
Procedure WGGetTickSize (pPgDesc: PPAGE_DEF; VAR nMajorSize,
	 nMinorSize: INTEGER); stdcall;
Procedure WGSetGraphTickSize (pGrDesc: PGRAPH_DEF;  nMajorSize,
	 nMinorSize: INTEGER); stdcall;
Procedure WGGetGraphTickSize (pGrDesc: PGRAPH_DEF; VAR nMajorSize,
	 nMinorSize: INTEGER); stdcall;

// Added to GUISup.c
 Function WGChangeTextAlign (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
				  wAlign: UINT): BOOL; stdcall;
 Function WGGetTextAlign (pGrDesc: PGRAPH_DEF; hObj: HGOBJ): UINT; stdcall;
 Function  PosToAlign( xPos,  yPos: INTEGER): INTEGER; stdcall;
 Function WGGetOffsets (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    VAR lpXOff,  lpYOff: Realtype): BOOL; stdcall;
 Function WGChangeOffsets (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     rXOff,  rYOff: Realtype):BOOL; stdcall;

 Function WGGetBaselineFlag (pGrDesc: PGRAPH_DEF; hObj: HGOBJ):BOOL; stdcall;
 Function WGGetOutlineFlag (pGrDesc: PGRAPH_DEF; hObj: HGOBJ):BOOL; stdcall;

 Function WGToggleBaseline (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; bOn: BOOL): BOOL; stdcall;
 Function WGToggleOutline (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; bOn: BOOL): BOOL; stdcall;
 Function WGSetMultiColors (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     			  bOn: BOOL; lpRGBColors: LPTCOLORREF):BOOL; stdcall;
 Function WGGetSingleColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
	      			   n: INTEGER): COLORREF; stdcall;
 Function WGChangeSingleColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
	      		 rgbNewColor: COLORREF; n: INTEGER):BOOL; stdcall;

 Function WGLinePlotEx (pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSet: HDATA; bFill: BOOL ; nStep: INTEGER ):HGOBJ; stdcall;
 Function WGGetLineStep(pGrDesc: PGRAPH_DEF; hObj: HGOBJ):INTEGER; stdcall;
 Function WGChangeLineStep(pGrDesc: PGRAPH_DEF; hObj: HGOBJ; nStep: INTEGER ): BOOL; stdcall;

 Function WGChangeMarkerSkip(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     nMarkerStart,  nMarkerSkip: INTEGER): BOOL; stdcall;
 Function WGGetMarkerSkip (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     			 VAR nMarkerStart,  nMarkerSkip: INTEGER): BOOL; stdcall;
 Function WGLogicalUnitsToDevicePixels (pGrDesc: PGRAPH_DEF;
				 nLx,  nLy:  INTEGER;
				VAR lpnDx, lpnDy: INTEGER):BOOL; stdcall;
 Function WGDevicePixelsToLogicalUnits(pGrDesc: PGRAPH_DEF;
				 nDx,  nDy: INTEGER;
				VAR lpnLx,  lpnLy: INTEGER): BOOL; stdcall;
 Function WGLogicalUnitsToPhysicalUnits (pGrDesc: PGRAPH_DEF;
				 hAxisX,  hAxisY: HGOBJ;
				 nLx,  nLy:  INTEGER;
				VAR lprPx, lprPy: Realtype): BOOL; stdcall;
 Function WGPhysicalUnitsToLogicalUnits(pGrDesc: PGRAPH_DEF;
				hAxisX,  hAxisY: HGOBJ;
				rPx,  rPy: realtype;
				VAR lpnLx,  lpnLy: INTEGER):BOOL; stdcall;
 Function WGDevicePixelsToPhysicalUnits (pGrDesc: PGRAPH_DEF;
				hAxisX,  hAxisY: HGOBJ;
				nDx,  nDy: INTEGER;
				VAR lprPx, lprPy: Realtype):BOOL; stdcall;
 Function WGPhysicalUnitsToDevicePixels(pGrDesc: PGRAPH_DEF;
				hAxisX,  hAxisY: HGOBJ;
				rPx,  rPy: realtype;
				VAR lpnDx, lpnDy: INTEGER):BOOL; stdcall;
 Function WGNormalizedUnitsToPhysicalUnits (pGrDesc: PGRAPH_DEF;
				hAxisX,  hAxisY: HGOBJ;
				rNx,  rNy: realtype;
				VAR lprPx, lprPy: Realtype):BOOL; stdcall;
 Function WGPhysicalUnitsToNormalizedUnits(pGrDesc: PGRAPH_DEF;
				HhAxisX,  hAxisY: HGOBJ;
				rPx,  rPy: realtype;
				VAR lpnNx,  lpnNy: Realtype): BOOL; stdcall;
 Function WGNormalizedUnitsToLogicalUnits (pGrDesc: PGRAPH_DEF;
				  rNx,  rNy: realtype;
				VAR lpnLx,  lpnLy: INTEGER): BOOL; stdcall;
 Function WGLogicalUnitsToNormalizedUnits(pGrDesc: PGRAPH_DEF;
				 nLx,  nLy:  INTEGER;
				VAR lprNx,  lprNy: Realtype):BOOL; stdcall;
 Function WGNormalizedUnitsToDevicePixels(pGrDesc: PGRAPH_DEF;
				rNx,  rNy: realtype;
				VAR lpnDx, lpnDy: INTEGER):BOOL; stdcall;
 Function WGDevicePixelsToNormalizedUnits(pGrDesc: PGRAPH_DEF;
				nDx,  nDy: INTEGER;
				VAR lprNx,  lprNy: Realtype):BOOL; stdcall;
 Function WGChangeMarkerDrop (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     bMarkerDrop: BOOL): BOOL; stdcall;
 Function WGGetMarkerDrop (pGrDesc: PGRAPH_DEF; hObj: HGOBJ):BOOL; stdcall;
 Function WGChangeBarBorder(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    bMarkerBorder: BOOL ):BOOL; stdcall;
 Function WGGetBarBorder (pGrDesc: PGRAPH_DEF; hObj: HGOBJ):BOOL; stdcall;
 Function WGChangeLegendBorder (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    bBorder: BOOL ): BOOL; stdcall;
 Function WGGetLegendBorder (pGrDesc: PGRAPH_DEF; hObj: HGOBJ):BOOL; stdcall;
 Function WGChangeLegendBackgroundColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    nColor: INTEGER ):BOOL; stdcall;
 Function WGGetLegendBackgroundColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ ):INTEGER; stdcall;
 Function WGGetGraphInPage (pPageDesc: PPAGE_DEF;
		   	  nGraphNum: INTEGER ):  PGRAPH_DEF; stdcall;
 Function WGGetGraphObject (pGrDesc: PGRAPH_DEF;  nObjectType,
		   	   nObjectNum: INTEGER; VAR lpnObjectSubType: INTEGER): INTEGER; stdcall;

// Added to GrObj.c
 Function WGScatterPlotEx (pGrDesc: PGRAPH_DEF; thdc: HDC;
	hDataSet: HDATA; nMarkerShape: INTEGER;  lpName: PChar;  nMarkerSize: INTEGER;
     bDrop: BOOL): HGOBJ; stdcall;
 Function WGGetMarkerName (pGrDesc: PGRAPH_DEF; hObj: HGOBJ ): PChar; stdcall;
 Function WGChangeMarkerName (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     lpName: PChar): BOOL; stdcall;



 Function WGGetPageBitmapHandle(pPageDesc: PPAGE_DEF;  nCopyArea: INTEGER):HBITMAP; stdcall;
 Function WGGetPageDIBHandle(pPageDesc: PPAGE_DEF; nCopyArea: INTEGER):HDIB; stdcall;
 Function WGGetGraphDIBHandle(pGraphDesc: PGRAPH_DEF ; nCopyArea: INTEGER):HDIB; stdcall;
 Function WGGetGraphBitmapHandle(pGraphDesc: PGRAPH_DEF ; nCopyArea: INTEGER):HBITMAP; stdcall;
 Procedure WGFreeDIB(hDib: HDIB ); stdcall;
 Procedure WGFreeBitmap(hBitmap: HBITMAP ); stdcall;
 Function WGSavePageDIB (pPageDesc: PPAGE_DEF;
    nCopyArea: INTEGER; lpFileName: PChar):BOOL; stdcall;
 Function WGSaveGraphDIB (pGraphDesc: PGRAPH_DEF;
     nCopyArea: INTEGER; lpFileName: PChar):BOOL; stdcall;

// Added to GRSup.c
Procedure WGSetMouseEventAction(pGrDesc: PGRAPH_DEF;  nMouseEvent,  nAction: INTEGER;
  lpfnUserProc: TFarProc); stdcall;
Function WGGetMouseEventAction(pGrDesc: PGRAPH_DEF;  nMouseEvent: INTEGER):INTEGER; stdcall;


// Added to QCWinit.c
//Procedure  WGProcessMouseEventAction(thwnd: HWND; nEvent,nAction: INTEGER;
//   tmessage: UINT;  ptMouse: TPOINT); stdcall;
//Procedure  WGProcessMouseEvent(thwnd: HWND;  tmessage: UINT; ptMouse: TPOINT ); stdcall;
Function WGPreAddGraphObject  (pGrDesc: PGRAPH_DEF; thdc: HDC ): BOOL; stdcall;
Function WGPostAddGraphObject  (pGrDesc: PGRAPH_DEF; thdc: HDC ): BOOL; stdcall;

// Added to Support.c
 Function WGBadValueCheck (VAR rNewValue: realtype): BOOL; stdcall;

// Added to Legend.c
  Function WGFlexLegend (pGrDesc: PGRAPH_DEF; thdc: HDC;
          rX1,  rY1,   rX2,  rY2: realtype;
         nBorderColor, nBorderWidth, nBackColor,  nLayout: INTEGER;
	 nNumObjects: UINT;
         lpTextColor: LPTCOLORREF;
	 lpSymbolShape:LPINT;
         lpSymbolColor: LPTCOLORREF;
	 lpSymbolSize,  lpSymbolStyle: LPINT;
	 lpStr: PChar): HGOBJ; stdcall;

 Function WGGetFLTextColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; n: INTEGER): COLORREF; stdcall;
 Function WGChangeFLTextColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    rgbNewColor: COLORREF; n: INTEGER): BOOL; stdcall;

 Function WGGetFLSymShape (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; n: INTEGER): INTEGER; stdcall;
 Function WGChangeFLSymShape (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     nNewShape, n: INTEGER): BOOL; stdcall;
 Function WGGetFLSymColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; n: INTEGER): COLORREF; stdcall;
 Function WGChangeFLSymColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    rgbNewColor: COLORREF; n: INTEGER): BOOL; stdcall;
 Function WGGetFLSymSize(pGrDesc: PGRAPH_DEF; hObj: HGOBJ; n: INTEGER): INTEGER; stdcall;
 Function WGChangeFLSymSize (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     nNewSize,  n: INTEGER):BOOL; stdcall;
 Function WGGetFLSymStyle (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; n:INTEGER):INTEGER; stdcall;
 Function WGChangeFLSymStyle (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
     nNewStyle,  n: INTEGER):BOOL; stdcall;

// Added to Group.c
 Function WGGroupLines (pGrDesc: PGRAPH_DEF; thdc: HDC; hDataSet: HDATA;
  bFill:  BOOL ;  lpLineStyle,  lpLineWidth,  lpLineColor: LPINT):HGOBJ; stdcall;
 Function WGWaterfallPlot (pGrDesc: PGRAPH_DEF; thdc: HDC; hDataSet: HDATA;
	 rXOff,  rYOff: Realtype; bFill, bBaseline, bOutline: BOOL;
	 pLineStyle,  pLineWidth,  pLineColor: LPINT): HGOBJ; stdcall;

 Function WGContourPlot (pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSet: HDATA;
     prContourValues: LPREAL;
     pRgbContourColor: LPTCOLORREF;
     pLineStyle,pLineWidth: LPINT;
     nNumContours, nBitmapGranularity: INTEGER;
     pLineFlags, pLabelFlags: LPBOOL;
     nLabelXJust,  nLabelYJust,  nLabelPrec: INTEGER;
     bLabelContourColor: BOOL;
     nGraphType: INTEGER):HGOBJ; stdcall;
 Function WGDeletePlotBitmap (pGrDesc: PGRAPH_DEF;  hPlotObj: HGOBJ):BOOL; stdcall;
 Function WGOpenHighLowClose (pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSet: HDATA;
	 nOpenMarkerShape,  nOpenMarkerColor,  nOpenMarkerSize,  nOpenMarkerStyle,
	 nCloseMarkerShape,  nCloseMarkerColor,  nCloseMarkerSize,
         nCloseMarkerStyle: INTEGER):  HGOBJ; stdcall;
 Function WGStockOpenHighLowClose (pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSet: HDATA;  rWidth: Realtype): HGOBJ; stdcall;

  Function WGCreateScatterSymbol (pGrDesc: PGRAPH_DEF; thdc: HDC;
     nMarkerColor,  nMarkerShape,  nMarkerStyle,  nMarkerSize: INTEGER;
	 bDrop: BOOL;  lpName: PChar): PSCAT_DESC; stdcall;

 Function WGBoxWhisker (pGrDesc: PGRAPH_DEF; thdc: HDC; hDataSet: HDATA;
	nMidPointType: INTEGER;
	 pMidPtMarkDesc:PSCAT_DESC;
	 nBoxType,  nBoxSize: INTEGER;
	 rBoxCoef,  rBoxConst,
	 rBoxPerMin,  rBoxPerMax: Realtype;
	 nBoxOutlineColor: INTEGER;
         bBoxFill: BOOL;
	 rgbHighColor,  rgbLowColor: COLORREF;
	 nWhiskerType,  nWhiskerSize: INTEGER;
          rWhiskerCoef,	 rWhiskerPerMin,  rWhiskerPerMax: realtype;
	 nWhiskerColor,  nWhiskerStyle,  nWhiskerWidth: INTEGER;
	 bOutlier: BOOL; pOutMarkDesc: PSCAT_DESC;
	 bExtreme: BOOL; pExtMarkDesc: PSCAT_DESC;
	 rOutlierCoef: realtype): HGOBJ; stdcall;


 Function WGCandlestick (pGrDesc: PGRAPH_DEF; thdc: HDC;
    hDataSet: HDATA;
	 rWidth: Realtype;
          rgbBarColor: COLORREF;  nBorderColor: INTEGER): HGOBJ; stdcall;


 Function WGChangeGroupReal(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
       				 nParam, nIndex: INTEGER;
       				 rValue: Realtype): BOOL; stdcall;
 Function WGChangeGroupInt(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
       				 nParam, nIndex: INTEGER;
       				  nValue: INTEGER): BOOL; stdcall;
 Function WGChangeGroupSymbol(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;	 nParam: INTEGER;
         			 pMarker: PSCAT_DESC ):BOOL; stdcall;
 Function WGGetGroupReal(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
	 		 nParam, nIndex: INTEGER;
	 		 VAR rValue: Realtype ): BOOL; stdcall;
 Function WGGetGroupInt(pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
	 		 nParam, nIndex: INTEGER; VAR nValue: Integer):BOOL; stdcall;


//  Added ObjSup
Procedure WGSetGraphBitBltMode(pGrDesc: PGRAPH_DEF; bBltMode: BOOL ); stdcall;
 Function WGGetGraphBitBltMode(pGrDesc: PGRAPH_DEF): BOOL; stdcall;
 Function WGGetObjUserID (pGrDesc: PGRAPH_DEF; hObj: HGOBJ): INTEGER; stdcall;
 Function WGSetObjUserID (pGrDesc: PGRAPH_DEF; hObj: HGOBJ; nUserID: INTEGER ): BOOL; stdcall;
 Function WGGetUserIDObj (pGrDesc: PGRAPH_DEF;  nUserID: INTEGER): HGOBJ; stdcall;

function RestorePage (lpFileName: PChar; hwParent:HWND; lpMenu: PChar ):PPAGE_DEF;  stdcall;
Procedure WGSavePage ( pPageDesc: PPAGE_DEF;  lpFileName: LPSTR);  stdcall;



implementation

procedure QCBasePage.BuildPage(p: PPAGE_DEF);
begin
end;

procedure QCBaseGraph.BuildGraph(p: PGRAPH_DEF; thdc: HDC);
begin
end;

function  WGGetRGBColor; external QCDLL;
function  WGGetPureColor; external QCDLL;
function  WGCreateShadeColor; external QCDLL;
function  WGSetPlotArea; external QCDLL;
procedure WGSetAxesScale; external QCDLL;
procedure WGScalePlotArea; external QCDLL;
procedure WGSetXYIntercepts; external QCDLL;
procedure WGSetLineStyle; external QCDLL;
procedure WGSetDataFormat; external QCDLL;
procedure WGSetTextParams; external QCDLL;
function  WGSetTextByName; external QCDLL;
procedure WGRaiseGraph; external QCDLL;
function  WGDrawXAxis; external QCDLL;
function  WGDrawYAxis; external QCDLL;
procedure WGDrawGrid; external QCDLL;
function  WGGroupBargraph; external QCDLL;
function  WGFloatingBars; external QCDLL;
function  WGAutoAxes; external QCDLL;
function  WGLinePlot; external QCDLL;
function  WGScatterPlot; external QCDLL;
function  WGLineMarkerPlot; external QCDLL;
function  WGBargraph; external QCDLL;
function  WGStackedLines; external QCDLL;
function  WGHighLowClose; external QCDLL;
function  WGErrorBars; external QCDLL;
function  WGLabelAxis; external QCDLL;
function  WGLabelAxisStrings; external QCDLL;
function  WGLabelAxisStringsPtr; external QCDLL;
function  WGLabelAxisMonth; external QCDLL;
function  WGLabelAxisDayWk; external QCDLL;
function  WGTextNorm; external QCDLL;
function  WGText; external QCDLL;
function  WGTitleGraph; external QCDLL;
function  WGTitleAxis; external QCDLL;
procedure WGLabelPie; external QCDLL;
function  WGPieChart; external QCDLL;
function  WGAutoLegend; external QCDLL;
function  WGAutoLegendGroup; external QCDLL;
function  WGLegend; external QCDLL;
function  WGLegendPtr;  external QCDLL;
function  WGLegendGroup; external QCDLL;
function WGLegendGroupPtr; external QCDLL;
function  WGLineNorm; external QCDLL;
function  WGArrowNorm; external QCDLL;
function  WGRectangleNorm; external QCDLL;
function  WGRectangleNormEx; external QCDLL;
function  WGEllipseNorm; external QCDLL;
function  WGArcNorm; external QCDLL;
function  WGPieNorm; external QCDLL;
function  WGLine; external QCDLL;
function  WGArrow; external QCDLL;
function  WGRectangle; external QCDLL;
function  WGEllipse; external QCDLL;
function  WGArc; external QCDLL;
function  WGPie; external QCDLL;
function  WGBitmapNorm; external QCDLL;
function  WGBitmap; external QCDLL;
function  WGPolygon; external QCDLL;
function  WGPolygonNorm; external QCDLL;
procedure WGFreeDataSet; external QCDLL;
function  WGLoadASCIIDataSet; external QCDLL;
function  WGSaveASCIIDataSet; external QCDLL;
function  WGDefineDataSet; external QCDLL;
function  WGDefineGroupDataSet; external QCDLL;
function  WGDefineDataSetPtr; external QCDLL;
function  WGDefineGroupDataSetPtr; external QCDLL;
function  WGSortDataX; external QCDLL;
function  WGSortDataY; external QCDLL;
function  WGGetMinMaxX; external QCDLL;
function  WGGetMinMaxY; external QCDLL;
function  WGCompressData; external QCDLL;
function  WGPasteDataSet; external QCDLL;
function  WGGetDataSetArrays; external QCDLL;
function WGGetDataSetArraysPtr; external QCDLL;
function  WGGetDataSet; external QCDLL;
procedure WGReconnectDataSet; external QCDLL;
procedure WGPrintGraph; external QCDLL;
procedure WGPrintPage; external QCDLL;
function  WGCopyGraph; external QCDLL;
function  WGCopyPage; external QCDLL;
procedure WGClosePage; external QCDLL;
function  WGGetPageDesc; external QCDLL;
procedure WGDeleteGraph; external QCDLL;
function  WGSavePageMeta; external QCDLL;
function  WGGetMetafile; external QCDLL;
procedure WGDeleteMetafile; external QCDLL;
function  WGPlayMetafile; external QCDLL;
function  WGMetafileNorm; external QCDLL;
function  WGMetafile; external QCDLL;
function  WGConvertPageToMeta; external QCDLL;
procedure WGDSPWindow; external QCDLL;
function  WGComplexFFT; external QCDLL;
function  WGRealFFT; external QCDLL;
function  WGPowerSpectrum; external QCDLL;
procedure WGFFTMagnitude; external QCDLL;
procedure WGFFTPhase; external QCDLL;
procedure WGFFTFrequency; external QCDLL;
function  WGGetPageWindow; external QCDLL;
procedure WGToggleSelectors; external QCDLL;
procedure WGToggleHigh; external QCDLL;
procedure WGChangeGraphPos; external QCDLL;
procedure WGGetGraphPos; external QCDLL;
procedure WGRedrawGraph; external QCDLL;
function  WGGetGraphWindow; external QCDLL;
function  WGGetGraphDesc; external QCDLL;
function  WGIsDescValid; external QCDLL;
function  WGIsGraphDescValid; external QCDLL;
function  WGIsPageDescValid; external QCDLL;

procedure WGChangeGraphBackgnd; external QCDLL;
function  WGGetGraphBackgnd; external QCDLL;
procedure WGSelectGraph; external QCDLL;
function  WGGetSelectedGraph; external QCDLL;
procedure WGSetGraphBorder; external QCDLL;
procedure WGBlowupGraph; external QCDLL;
procedure WGEditGraphDlg; external QCDLL;
procedure WGGetPlotPos; external QCDLL;
procedure WGChangePlotPos; external QCDLL;
procedure WGChangePlotBackgnd; external QCDLL;
function  WGGetPlotBackgnd; external QCDLL;
function  WGGetSelObject; external QCDLL;
procedure WGSelObject; external QCDLL;
procedure WGRedrawObject; external QCDLL ;
function  WGGetObjectCoord; external QCDLL;
function  WGGetObjectCoordNorm; external QCDLL;
function  WGGetObjectPos; external QCDLL;
function  WGGetObjectPosNorm; external QCDLL;
function  WGChangeObjectCoord; external QCDLL;
function  WGChangeObjectCoordNorm; external QCDLL;
function  WGDuplicateObject; external QCDLL;
procedure WGObjUpdate; external QCDLL;
procedure WGUpdatePage; external QCDLL;
procedure WGDeleteObject; external QCDLL;
function  WGGetObjectType; external QCDLL;
function  WGChangeLineColor; external QCDLL;
function  WGGetLineColor; external QCDLL;
function  WGGetAreaColor; external QCDLL;
function  WGChangeAreaColor; external QCDLL;
function  WGChangeLineWidth; external QCDLL;
function  WGGetLineWidth; external QCDLL;
function  WGChangeLineStyle; external QCDLL;
function  WGGetLineStyle; external QCDLL;
function  WGToggleSpline; external QCDLL;
function  WGGetFillFlag; external QCDLL;
function  WGGetSplineFlag; external QCDLL;
function  WGChangeObjFill; external QCDLL;
function  WGChangeMarkerColor; external QCDLL;
function  WGGetMarkerColor; external QCDLL;
function  WGChangeMarkerType; external QCDLL;
function  WGGetMarkerType; external QCDLL;
procedure WGShowObject;  external QCDLL;
function  WGChangeAxisRange; external QCDLL;
function  WGChangeAxisIntercept; external QCDLL;
function  WGChangeAxisScale; external QCDLL;
procedure WGSetTickSize; external QCDLL;
function  WGChangeAxisTicks; external QCDLL;
function  WGChangeGrid; external QCDLL;
function  WGGetAxisTicks; external QCDLL;
function  WGGetAxisRange; external QCDLL;
function  WGGetAxisScale; external QCDLL;
function  WGGetAxisDir; external QCDLL;
function  WGToggleGrid; external QCDLL;
procedure WGToggleGridsOrder; external QCDLL;
function  WGGetGrid; external QCDLL;
function  WGGetBarWidth; external QCDLL;
function  WGChangeBarWidth; external QCDLL;
function  WGChangeHatchStyle; external QCDLL;
function  WGGetHatchStyle; external QCDLL;
function  WGChangeBarJust; external QCDLL;
function  WGGetBarJust; external QCDLL;
function  WGGetPlotType; external QCDLL;
function  WGChangePlotType; external QCDLL;
function  WGChangeTextColor; external QCDLL;
function  WGGetTextColor; external QCDLL;
procedure WGGetTextSizeNorm ; external QCDLL;
function  WGChangeFont; external QCDLL;
function  WGGetFontName; external QCDLL;
function  WGGetFontSize; external QCDLL;
function  WGGetFontWeight; external QCDLL;
function  WGGetFontOrient; external QCDLL;
function  WGGetFontItal; external QCDLL;
function  WGGetFontUnder; external QCDLL;
function  WGGetFontEsc; external QCDLL;
function  WGGetString; external QCDLL;
function  WGChangeString; external QCDLL;
function  WGChangeArrow; external QCDLL;
function  WGChangeArrowFill; external QCDLL;
function  WGChangeArrowPos; external QCDLL;
function  WGGetArrowWidth; external QCDLL;
function  WGGetArrowLength; external QCDLL;
function  WGGetArrowFill; external QCDLL;
function  WGGetArrowPos; external QCDLL;
function  WGGetLastLabelFlag; external QCDLL;
function  WGGetLastLabelText; external QCDLL;
function  WGGetLabelsPos; external QCDLL;
function  WGChangeLabelsPos; external QCDLL;
function  WGGetLabelsFormat; external QCDLL;
function  WGChangeLabelsFormat; external QCDLL;
function  WGGetLabelsPrec; external QCDLL;
function  WGChangeLabelsPrec; external QCDLL;
function  WGChangeLastLabel; external QCDLL;
function  WGGetPieExpl; external QCDLL;
function  WGChangePieExpl; external QCDLL;
function  WGChangePieTextPos; external QCDLL;
function  WGGetPieTextPos; external QCDLL;
function  WGGetLineDesc; external QCDLL;
function  WGGetMousePos; external QCDLL;
procedure WGGetMousePosNorm; external QCDLL;
procedure WGShowMouseCoord; external QCDLL;
procedure WGGetGraphMouseEvent; external QCDLL;

function  WGCopyMem; external QCDLL;
procedure WGSetOKCursor; external QCDLL;
function  WGGetObjSize; external QCDLL;
function  WGGetObjTypeSize; external QCDLL;
procedure WGPrinterSetup; external QCDLL;
procedure WGSetPrintOptions; external QCDLL;
procedure WGPrintOptionsDlg; external QCDLL;
procedure WGEnableErrorMessages; external QCDLL;
function  WGGetLastError; external QCDLL;
function  WGMenuCheck; external QCDLL;
procedure WGStart; external QCDLL;
procedure WGCleanup; external QCDLL;
procedure WGEditObject;  external QCDLL;
procedure WGGraphKeyEvent;  external QCDLL;
procedure DefEditObject; external QCDLL;
function ObjFind; external QCDLL;
procedure WGShowData; external QCDLL;
function WGGetVersion; external QCDLL;
function WGGetDate; external QCDLL;

procedure CleanGDI; external QCDLL;

function WGStartZoom;  external QCDLL;
function WGGetZoom; external QCDLL;
function WGSetDataCursor; external QCDLL;
procedure WGMoveDataCursor; external QCDLL;
function  WGGetNearestPoint; external QCDLL;
function WGMarkDataPoint; external QCDLL;
function WGIsDataPointGood; external QCDLL;
function WGRoundAxis; external QCDLL;


Procedure WGSetPrintOrient;  external QCDLL;
Function WGGetPrintOrient;  external QCDLL;
Procedure WGToggleOKCursor;  external QCDLL;
Function WGGetNearestRGBColor; external QCDLL;
Function WGMultiText; external QCDLL;
Function WGMultiTextNorm; external QCDLL;
Procedure WGToggleGridsLine( bGridsBelow: BOOL); external QCDLL;
Function  WGPolyline; external QCDLL;
Function  WGPolylineNorm; external QCDLL;
Function WGStartXCursor; external QCDLL;
Function WGGetXCursor; external QCDLL;
Function WGSetXCursorParams; external QCDLL;
Function WGGetXCursorParams ; external QCDLL;

Function WGStartObjMove ; external QCDLL;
Function WGGetObjMove; external QCDLL;
Function WGStartSuperZoom; external QCDLL;

 Function WGGetMinMaxYGroup; external QCDLL;
 Function WGCreateEvenGridDataSetPtr ; external QCDLL;
 Function WGDefineEvenGridDataSetPtr; external QCDLL;
 Function WGSetDataSetRegularGrid ; external QCDLL;
 Function WGGetContourMinMaxXYZ; external QCDLL;
 Function WGGetNearestPointPlotObjs; external QCDLL;
 Function WGGetNearestPointNormalized ; external QCDLL;
  Function WGLabelAxisDate; external QCDLL;
 Function WGChangeDateFormat; external QCDLL;
  Function WGSetTimeFormat; external QCDLL;
  Function WGChangeDateFormatString; external QCDLL;
  Function WGChangeDateBaseUnits ; external QCDLL;
  Function WGChangeDateStartDate; external QCDLL;
  Function WGGetDateFormat; external QCDLL;
  Function WGGetTimeFormat; external QCDLL;
  Function WGGetDateFormatString; external QCDLL;
  Function WGGetDateBaseUnits; external QCDLL;
  Function WGGetDateStartDate; external QCDLL;
  Function WGRoundAxis2; external QCDLL;
  Function WGRoundAxis3; external QCDLL;
 Function WGAxes; external QCDLL;
 Function WGGetDataSetsRange; external QCDLL;
 Function WGGetGraphPlotObjRange; external QCDLL;
 Function WGAutoAxesDataSets; external QCDLL;
 Function WGAutoOneAxisDataSets; external QCDLL;
 Function WGReAutoOneAxisDataSets (pGrDesc: PGRAPH_DEF;
 	hDataSet: PHDATA;  nNumDataSets,
    nRoundTypeX,  nRoundTypeY,  nInterceptFlag,  nAxis: INTEGER;
	 rMin,  rMax: Realtype;
	 hAxisX,  hAxisY: HGOBJ):BOOL; external QCDLL;
 Function WGReAxes; external QCDLL;
 Function WGReAutoAxes; external QCDLL;
 Function WGReAutoAxesDataSets; external QCDLL;
 Function WGChangeLabelsIntercept; external QCDLL;
Procedure WGSaveAxesState; external QCDLL;
Procedure WGRestoreAxesState; external QCDLL;
 Function WGGetAxisIntercepts; external QCDLL;
Procedure WGSetAxisIntercepts ; external QCDLL;
 Function WGAutoAxesGroupData; external QCDLL;
 Function WGReAutoAxesGroupData; external QCDLL;
 Function WGAutoAxesContourData; external QCDLL;
 Function WGReAutoAxesContourData; external QCDLL;
Procedure WGGetAxisPhysicalScale; external QCDLL;
Procedure WGGetTickSize; external QCDLL;
Procedure WGSetGraphTickSize; external QCDLL;
Procedure WGGetGraphTickSize ; external QCDLL;

// Added to GUISup.c
 Function WGChangeTextAlign; external QCDLL;
 Function WGGetTextAlign ; external QCDLL;
 Function  PosToAlign; external QCDLL;
 Function WGGetOffsets; external QCDLL;
 Function WGChangeOffsets; external QCDLL;

 Function WGGetBaselineFlag; external QCDLL;
 Function WGGetOutlineFlag; external QCDLL;

 Function WGToggleBaseline; external QCDLL;
 Function WGToggleOutline ; external QCDLL;
 Function WGSetMultiColors ; external QCDLL;
 Function WGGetSingleColor ; external QCDLL;
 Function WGChangeSingleColor; external QCDLL;

 Function WGLinePlotEx ; external QCDLL;
 Function WGGetLineStep; external QCDLL;
 Function WGChangeLineStep; external QCDLL;

 Function WGChangeMarkerSkip; external QCDLL;
 Function WGGetMarkerSkip ; external QCDLL;
 Function WGLogicalUnitsToDevicePixels; external QCDLL;
 Function WGDevicePixelsToLogicalUnits; external QCDLL;
 Function WGLogicalUnitsToPhysicalUnits; external QCDLL;
 Function WGPhysicalUnitsToLogicalUnits; external QCDLL;
 Function WGDevicePixelsToPhysicalUnits ; external QCDLL;
 Function WGPhysicalUnitsToDevicePixels; external QCDLL;
 Function WGNormalizedUnitsToPhysicalUnits; external QCDLL;
 Function WGPhysicalUnitsToNormalizedUnits; external QCDLL;
 Function WGNormalizedUnitsToLogicalUnits; external QCDLL;
 Function WGLogicalUnitsToNormalizedUnits; external QCDLL;
 Function WGNormalizedUnitsToDevicePixels; external QCDLL;
 Function WGDevicePixelsToNormalizedUnits; external QCDLL;
 Function WGChangeMarkerDrop; external QCDLL;
 Function WGGetMarkerDrop; external QCDLL;
 Function WGChangeBarBorder; external QCDLL;
 Function WGGetBarBorder; external QCDLL;
 Function WGChangeLegendBorder; external QCDLL;
 Function WGGetLegendBorder; external QCDLL;
 Function WGChangeLegendBackgroundColor (pGrDesc: PGRAPH_DEF; hObj: HGOBJ;
    nColor: INTEGER ):BOOL; external QCDLL;
 Function WGGetLegendBackgroundColor; external QCDLL;
 Function WGGetGraphInPage; external QCDLL;
 Function WGGetGraphObject; external QCDLL;

// Added to GrObj.c
 Function WGScatterPlotEx ; external QCDLL;
 Function WGGetMarkerName; external QCDLL;
 Function WGChangeMarkerName;  external QCDLL;



 Function WGGetPageBitmapHandle; external QCDLL;
 Function WGGetPageDIBHandle; external QCDLL;
 Function WGGetGraphDIBHandle; external QCDLL;
 Function WGGetGraphBitmapHandle; external QCDLL;
Procedure WGFreeDIB;external QCDLL;
Procedure WGFreeBitmap; external QCDLL;
 Function WGSavePageDIB ; external QCDLL;
 Function WGSaveGraphDIB ; external QCDLL;

// Added to GRSup.c
Procedure WGSetMouseEventAction;  external QCDLL;
 Function WGGetMouseEventAction; external QCDLL;


// Added to QCWinit.c
//Procedure  WGProcessMouseEventAction;external QCDLL;
//Procedure  WGProcessMouseEvent; external QCDLL;
 Function WGPreAddGraphObject; external QCDLL;
 Function WGPostAddGraphObject; external QCDLL;

// Added to Support.c
 Function WGBadValueCheck ; external QCDLL;

// Added to Legend.c
  Function WGFlexLegend; external QCDLL;

 Function WGGetFLTextColor ; external QCDLL;
 Function WGChangeFLTextColor; external QCDLL;
 Function WGChangeFLSymShape; external QCDLL;
 Function WGGetFLSymShape; external QCDLL;
 Function WGChangeFLSymColor; external QCDLL;
 Function WGGetFLSymColor ; external QCDLL;
 Function WGGetFLSymSize; external QCDLL;
 Function WGChangeFLSymSize; external QCDLL;
 Function WGGetFLSymStyle ; external QCDLL;
 Function WGChangeFLSymStyle; external QCDLL;

// Added to Group.c
 Function WGGroupLines; external QCDLL;
 Function WGWaterfallPlot; external QCDLL;

 Function WGContourPlot; external QCDLL;
 Function WGDeletePlotBitmap; external QCDLL;
 Function WGOpenHighLowClose; external QCDLL;
 Function WGStockOpenHighLowClose ; external QCDLL;

  Function WGCreateScatterSymbol; external QCDLL;

 Function WGBoxWhisker ; external QCDLL;


 Function WGCandlestick; external QCDLL;


 Function WGChangeGroupReal; external QCDLL;
 Function WGChangeGroupInt; external QCDLL;
 Function WGChangeGroupSymbol; external QCDLL;
 Function WGGetGroupInt; external QCDLL;
 Function WGGetGroupReal; external QCDLL;

//  Added ObjSup
Procedure WGSetGraphBitBltMode; external QCDLL;
 Function WGGetGraphBitBltMode; external QCDLL;
 Function WGGetObjUserID; external QCDLL;
 Function WGSetObjUserID ; external QCDLL;
 Function WGGetUserIDObj; external QCDLL;

 Function RestorePage; external QCDLL;
 Procedure WGSavePage; external QCDLL;


end.
