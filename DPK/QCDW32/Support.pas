{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SUPPORT.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{*                                                                     }
{*   Description:  Prototypes for support routines.                    }
{*                 No user Callable routines are found here.           }
{*                                                                     }
{**********************************************************************}


{$A+}
unit Support;
interface
uses WinProcs, WinTypes, Messages,QCWin;

const


 MAXREAD = 32768;
 MAXPOLY = 1025;
 POLYLINE_BLOCKSIZE = 200;
 MAXWEXT  =    13000;       { Max Window Extent in logical coords }

 VER_MAJOR =  1;            { version number }
 VER_MINOR =  0;

 STYLE_POPUP = WS_POPUP or WS_CAPTION or WS_SYSMENU
		 or WS_MINIMIZEBOX or WS_MAXIMIZEBOX or WS_THICKFRAME or WS_CLIPCHILDREN;

 STYLE_CHILD = WS_CHILD or WS_CLIPSIBLINGS or WS_VISIBLE;

  OBJ_DUP    =   32001; {HANDLE} { (MAX_OBJS + 1),handle for duplicate object }

  GWL_DESC      = 0;       { offset to graph desc. pointer }
  GWL_TOPDESC   = 4;       { offset to topdesc pointer }


{ offsets to private data of graph windows }
  GWL_PARENTDESC= 8;       { offset to parent's descriptor pointer }
  GWW_TABFLAG   =12;       { offset to data table owned window flag }
  GWW_GRAPHEXTRA= 14;      { # of extra bytes }

{ offsets to private user data of page windows }
  GWW_PUSER     = 16;      { can use these 4 bytes }
  GWW_PAGEEXTRA =20;      { # of extra bytes }

{ offsets to private data of DATA table windows }

  GWW_OBJMEM   = 0;   { offset to curve/group object memory handle }
  GWW_CYCHAR   = 4;
  GWW_VSCRPOS  = 8;   { offset to current position of scroll bar thumb }
  GWW_VSCRMAX  = 12;
  GWW_HSCRPOS  =16;
  GWW_HSCRMAX  =20;
  GWW_CXVAL    =24;
  GWW_HWEDIT   =28;
  GWW_JLAST    =32;
  GWL_ILAST    =36;
  GWW_TABEXTRA = GWL_ILAST +4;



{**********************************************************************}
{ data table window messages }

 TM_ENTERED =	 (WM_USER+1);
 TM_ESCAPE  =	 (WM_USER+2);
 TM_UP	    =    (WM_USER+3);
 TM_DOWN    =    (WM_USER+4);
 TM_TAB	    =    (WM_USER+5);
 TM_KEY	    =    (WM_USER+6);
 TM_LEFT    =    (WM_USER+7);
 TM_RIGHT   =    (WM_USER+8);

{**********************************************************************}

  LARGETICK =  4;
  SMALLTICK =  2;          { Tick sizes in screen pixels }
  DEPTH_CONST = 1/4;
  BR_LIM = 0.01;
  BORDER_RATIO = 0.01;

  MK_DEFAULT_SIZE =  6;  { default size of markers in points }

{*************************************************************************}
{ line options }

 LN_NOFILL =  0;
 LN_FILL   =  11;

{*********************************************************************}
{ label types }

  LB_NUMERIC =  0;
  LB_STRING  =  1;
  LB_MONTH   =  2;
  LB_DAYOFWK =  3;

{**********************************************************************}
{ selectors on / off   }

 GS_OFF = 0;
 GS_ON  = 1;
 GS_MOVE= 2;

{**********************************************************************}
{ MISC }

  COM_REDRAW   = 3;
  COM_TABLE    = 4;
  COM_LINETOBAR= 5;
  COM_BARTOLINE= 6;
  COM_SPLINE   = 7;

  DLG_DISABLE =  (0); {LONG}
  DLG_DOWN_ENABLE =  ($80000000);  {LONG}
  DLG_RIGHT_ENABLE = ($8000);
  DLG_ENABLE      =  ($8000);

  MAXSIZE    =   8;

    GO_SUBT_NOTEXT= 0;
    GO_SUBT_TEXT  = 1;
    GO_SUBT_AXLAB = 2;
    Go_SUBT_GTITLE = 3;
{ legend types }

 LG_CHART = 0;
 LG_GROUP = 1;
 LG_DYN = 2;

{*************************************************************************}
{ dialog box extension flags: }

 DEX_NONE  = 0;
 DEX_RIGHT = 1;
 DEX_DOWN  = 2;
 DEX_BOTH  = 3;

 GO_SUBT_AUTO  =     9;
 GO_SUBT_MAN   =    10;

 DATANAMELEN =32;
 MAXGROUPLEN = 32;
 MAXPIE  =   32;
 MAXBMNAMELEN =  80;

 TEXT_LEN = 120;

type

{*************************************************************************}
TEXTDESC = record

    lFont: TLogFont;           { font descriptor }
    nColor,          { text color code }
    nFontNum,
    nSizeInd,        { index to size table for given font. If -1, }
                             { the table is not used, size taken from nPointSize }
    nOrigPointSize,  { font size in points at the time of creation or }
                             { user change (not affected by resizing) }
    nPointSize,      { font size in points }
    nSizeDev: INTEGER;
    fResize: BOOL;
    lpText: PChar;          { pointer to text string }
    MaxLen: INTEGER;

    nType: INTEGER;
    rgbColor: COLORREF;
    rX,
    rY: realtype;
     nNumLines: INTEGER ;

end;
{************************************************************************}


XYDATA_DEF= record                  { XY data set descriptor }

   lNumPoints: LongInt;
    hX,                    { memory handles }
    hY: HGLOBAL;
    hpX,
    hpY: HPREAL;
    lpMask: LPINT;
    cGroupSize: INTEGER;
    cUseCounter: INTEGER;
    szDataName: array[0..DATANAMELEN-1] of CHAR;  { unique name of the data set }
 end;

PXYDATA_DEF = ^XYDATA_DEF;
{*************************************************************************}
{ Screen and printer global descriptor }

DEV_DEF= record


    cxScreen,        { Screen width }
    cyScreen,        { Screen height }
    nScLogPixelsX,   { Screen pixels per logical inch }
    nScLogPixelsY,

    cxPage,          { size of printer page in printer pixels }
    cyPage,
    cxLogPixels,     { # of printer pixels per logical inch }
    cyLogPixels: INTEGER;
    nScaleFactorX,
    nScaleFactorY: INTEGER;

    ptMouse: TPoint;         { Position of mouse pointer in device coord.}
    bPrinterAvail: BOOL;
    hWCTDllInst:THANDLE;
    nColors: LONGINT;         { Number of screen colors }
    xOrgPage,
    yOrgPage: INTEGER;
    bGraphModePrint: BOOL;

end;

PDEV_DEF  = ^DEV_DEF;

{*************************************************************************}
TOP_DEF= record
    hwTop: HWnd;                { Top (user application) window handle }
    bInit: BOOL;
    hPgMem: array [0..MAX_PAGES] of HGlobal; { array of handles to chart pages }
    xyDesc: array[0..MAX_DATASETS-1] of PXYDATA_DEF;
    bMFC: BOOL;
    res1: array[0..255] of INTEGER;
    ct: TEXTDESC;                  { current text parameters }
    hClipRgn: THANDLE;             { handle to "open" clipping region }
{$ifndef RTFL}
  {$ifndef VER130}
    alignment1: INTEGER;
  {$endif}
{$endif}
    nNumPages: UINT;            { number of chart pages }
    hInst: THandle;                { Global application instance handle }
    bErrRep,              { Error Reporting Flag }
    bTerm: BOOL;                { Termination Flag }
    lpfnDynRescale: TFarProc;


    lpGraphProc: TFarProc;          { graph window class procedure }
    hChartCur: HCursor;
    verMajor,             { major version number }
    verMinor: INTEGER;
    bGridsBelow: BOOL;
    cRTSemaphore: BOOL;
    res2: INTEGER;
    bFrame,            { if set, print frame around picture }
    bGraphBackgnd,     { if set, print graph window background }
    bPlotBackgnd,      { if set, print plotting area background}
    bPropWidth, { if set, line width is proportional, otherwise in pixels}
    bPropText: BOOL;  { if set, printed text size is proportional, otherwise in points}
    nPrintStyle: INTEGER; { can be PRT_FULL, PRT_PROP, PRT_EXACT }
    bKeepAspect: BOOL;  { if TRUE, maintain aspect ratio }
    fLeft,        { printer hdc normalized coordinates of the left upper corner }
    fTop: SINGLE;

    cLenReal: Integer;     { number of bytes in REALTYPE (4 or 8)  }
    bInitPrintParam: BOOL;

    bBadValueFlag: BOOL;      // Set to TRUE if bad values allowed
   alignment2: INTEGER;

   rMaxPosNumber,
   rMinNegNumber,
   rBadValueNumber: realtype;
    nObjCounter: INTEGER;
   bSerializeFlag,
   bCompoundFlag: BOOL;
   RestoreDynObject: TFARPROC;
   SaveDynObject: TFARPROC;
   pDevDesc: PDEV_DEF;

    lpRTTop: POINTER;
end;
PTOP_DEF = ^TOP_DEF;

{************************************************************************}
{************************************************************************}
{ Dynamic objects (RT Tools)                                           }
{************************************************************************}

DYNOBJ_HEAD = record                  { common header }

   nType,                  { object type }
   nSubType: SHORT;               { object subtype}
   lpfnObj: TFARPROC;
   rcBoundary: TRECT;             { object limits in device coordinates}
   hObj1,                   { handles of associated objects (axes)}
   hObj2: HGOBJ;
   ld: LINEDESC;
   lpfnDynObj: TFARPROC;
   dwLastUpdate: LONGINT;           { seconds count for last update}
   wUpdatePer: WORD;             { update period in seconds}
   fInverse,
   fShow: BYTE;                  { if = 0, hide object      }
end;
PDYNOBJ_HEAD = ^DYNOBJ_HEAD;

{************************************************************************}
 LEGEND_DESC= record                   { Legend descriptor }
    hObj: HGOBJ;
    szLegend: array[0..LG_MAXLEN] of CHAR;
 end;

{$ifdef OBJDEFS}
OBJ_AX= record                     { Axis }

   header: OBJ_HEAD;
   rxMin,               { scaling values }
   rxMax,
   ryMin,
   ryMax,
   rxInt,               { intercepts }
   ryInt,
   rTickSpace,         { distance between ticks in eng. units }
   rLMin,              { limits for logarithmic scale }
   rLMax,
   rFirstTick: Realtype;         { value of the first tick number}
   nScaleType,         { CT_LINEAR or CT_LOG }
   nPerpScaleType,     { Scale type for perpendicular axis }
   nDir,               { can be OR_VERT or OR_HORZ }
   nMajTicks,          { number of major ticks}
   nSmallTicks,      { number of minor ticks between 2 major ticks}
   nTickPos: INTEGER;           { position of the ticks relative to axis }
   fGridMajor, { flag indicating if grid is enabled for Major ticks}
   fGridMinor: BOOL; { flag indicating if grid is enabled for minor ticks }
   ldMajor,            { grid line descriptors}
   ldMinor: LINEDESC;
   fAuto,              { Automatic axis flag }
   bRedraw: BOOL;            { Redraw flag }
   pLabDesc: POINTER;           { pointer to related labels object}
   cTimeUnits: CHAR;
   cDynGrids: CHAR;
   reserved: array [0..7] of CHAR;
end;

{************************************************************************}

OBJ_TEXT= record
    header: OBJ_HEAD;
    tdesc: TEXTDESC;              { text descriptor, must follow header ! }
    fRedraw: BOOL;            { redraw flag }
    x,                  { logical coordinates of text }
    y,
    xstart,
    ystart: INTEGER;
    relX,               { Text coordinates relative }
    relY: SINGLE;               { to graph window }
    rX,                 { coordinates in eng. units. }
    rY: Realtype;

    wAlign: WORD;
    hd: THandle;                 { handle to related object or window }
    nOrientation: INTEGER;
    dwStringExt: LongInt;
    nPos: INTEGER;               { flag of relative position }
    sizeString: SIZE;
    szText: array[0..TEXT_LEN] of CHAR;         { Text String }
    reserved: array[0..4] of CHAR;
end;

{************************************************************************}

OBJ_LABELS= record                     { Labels }

    header: OBJ_HEAD;
    tdesc: TEXTDESC;              { text descriptor, must follow header ! }
    nLabelPos,          { position of labels relative to axis }
    nDir,               { can be OR_VERT or OR_HORZ }
    nLast,              { last label flag }
    nType: INTEGER;              { numeric, string, date }
    hStr: THandle;            { handle to array of strings }
    lpStr: PCHAR;
    nFormat: WORD;            { NF_SCIENTIFIC, NF_DECIMAL, etc. }
    cPrec: CHAR;              { # of digits after . Also, # of first entry}
                                  {   for month or day of week labels }
    fPrecMan: BYTE;           { if on, precision is set manually. Also,
                                     if on - show only 3 characters
                                     for month or day of week labels }
    wStringExt,         { Largest label string length }
    wStringExt2: INTEGER;     { for scientific notation, length of exponent.}
    bFirstTick: BYTE;         { # of tick where first month is displayed  }
    szTextLast: array[0..12] of CHAR;     { Text String  for last label}
    cSavedString: CHAR;
    wSize: WORD;
    reserved: array [0..6] of CHAR;
end;


{************************************************************************}

OBJ_PLOT= record                   { Lines, bars, etc. }

    header: OBJ_HEAD;
    rxMin,               { scaling values}
    rxMax,
    ryMin,               { scaling values }
    ryMax,
    rRelBarWidth: Realtype;       { width relative to plot area}
                                  { scatter plot parameters}
    nOrigMarkerSize,    { marker size in points at the time of creation or}
    nMarkerSize,        { size of marker in points}
    nMarkerLogSize,     { size of marker in logical units}
    nMarkerColor,       { Marks' color (Scatter plot)}
    nMarkerShape,
    nMarkerStyle: INTEGER;  { MKS_FULL, MKS_CDOT, etc. Also bar border flag}
    hDataSet: THandle;           { handle for data set descriptor}
    nDataWidth,         { number of characters in a data field}
    nDataPrec: INTEGER;          { data precision for data table,
                                     clipboard export }
    xyDesc: XYDATA_DEF;            { data set descriptor}
    hMemLogData: THandle;        { memory handle to array of actual
                                     points (logical coords) }
    hMemLogData2: THandle;       { memory handle to array of calculated
                                     points (logical coords) }
    yInt: INTEGER;               { Logical y corresponding to intercept }
    bJustify,           { bar relative position }
    bReserved: BYTE;          { bar relative position }
    bUpdateAxes;
    wSelPoint: CARDINAL;  { sequential number of selected point}
    wNumPointsPrev: CARDINAL;
    resDyn: array [0..5] of CHAR;
{------------------------------------------------------------------------}
    cFill: CHAR;              { FLAG FOR FILLING AREA UNDER LINE }
    nNumSplinePoints: INTEGER;
    rgbBarColor: TColorRef;        { for Bargraph }
    cHatchStyle,        { bar brush hatch style }
    cSpline,            { FLAG FOR cubic spline interpolation }
    cDrop: CHAR;              { For scatter plot - drop down flag }
{------------------------------------------------------------------------}
{-Dynamic area
{------------------------------------------------------------------------}
    xyPrev: INTEGER;             { previous value }
    reserved: array [0..15] of CHAR;
end;

{************************************************************************}


OBJ_GROUP= record                   { Group objects }

    header: OBJ_HEAD;
    rxMin,               { scaling values }
    rxMax,
    ryMin,
    ryMax,
    rRelBarWidth: Realtype;       { bar width relative to plot area }
    nOrigMarkerSize,    { marker size in points at the time of creation or }
    nMarkerSize,        { size of marker in points }
    nMarkerLogSize,     { size of marker in logical units }
    nMarkerColor,       { Marks' color (Scatter plot) }
    nMarkerShape,
    nMarkerStyle: INTEGER;  { MKS_FULL, MKS_CDOT, etc. Also bar border flag }
    hDataSet: THandle;      { handle for data set descriptors }
    nDataWidth,        { number of characters in a data field }
    nDataPrec: INTEGER;         { data precision for data table,
                                    clipboard export }
    xyDesc: XYDATA_DEF;           { data set descriptor }
    hMemLogX: THandle;      { memory handle to array of X (logic. coords) }
                { up to this place must be identical with OBJ_CURVE }

    hMemLogY: THandle; { memory handle to array of Y (logic. coords) }
    yInt: INTEGER;               { Logical y corresponding to intercept }
    bJustify,
    bReserved: BYTE;
    bUpdateAxes: BOOL;
    wSelPoint: WORD;          { sequential number of selected point }

    resDyn: array [0..5] of CHAR;
{------------------------------------------------------------------------}
    bGroupType: BYTE;
    cyZero: INTEGER;           { Y in logical units for 0.0 }

    ld: array[0..MAXGROUPLEN-1] of LINEDESC;    { descriptors for lines or bar borders }
    rgbBarColor: array[0..MAXGROUPLEN-1] of TColorRef;
    cHatchStyle: array[0..MAXGROUPLEN-1] of CHAR;
    nSelGroup: INTEGER;          { selected group number }
    reserved: array [0..19] of CHAR;
end;

{************************************************************************}


{*******************************************************************}

 PIE_DESC= record                   { Pie descriptor }
    rVal: realtype;         { value }
    rgbPieColor: TColorRef;
    ld: LINEDESC;           { border }
    fExplode: BOOL;     { explode flag }
    rExplodeRel: SINGLE;  { relative distance of exploded pie from center }
    szTitle: array[0..LG_MAXLEN-1] of CHAR;
    cHatchStyle,
    cBorder: CHAR;
    Reserved: array[0..1] of CHAR;
end;

{************************************************************************}
 LEGEND_DESC= record                   { Legend descriptor }
    hObj: THandle;
    szLegend: array[0..LG_MAXLEN-1] of CHAR;
 end;

{************************************************************************}
OBJ_LEGEND= record                   { Legend object }
    header: OBJ_HEAD;
    tdesc: TEXTDESC;               { font for legends }
    nNumObjects,         { number of objects }
    nMaxChar,            { Max legend length (characters) }
    nLongest,            { Number of the longest legend }
    cxMaxExt,
    nBackColor,          { background color, -1 - transparent }
    cxMaxExt,
    cyChar,
    cxWidth: INTEGER;
    nLayout,             { OR_VERT or OR_HORZ }
    nLegType: INTEGER;            { LG_CHART or LG_GROUP }
    bBorder: BOOL;             { legend rectangle border flag }
    pLegends: PChar;
    cNoSym: CHAR;
    reserved: array [0..6] of CHAR;
    ldesc: array[0..1] of LEGEND_DESC;
end;

{************************************************************************}
OBJ_PIECHART= record                   { Pie object }
    header: OBJ_HEAD;
    tdesc: TEXTDESC;               { font for numbers }
    rRelX,               { scaling values }
    rRelY,
    rRelDiam: SINGLE;            { diameter relative to plot area }
    hMemData: THANDLE;            { handle to real data array }
    nNumPoints: INTEGER;
    nNumType,            { type of number display }
    nNumPos,             { number position - inside or out }
    nSel: INTEGER;                { last selected slice }
    lpData: LPREAL;
    reserved: array [0..5] of CHAR;
    pdesc: array[0..2] of PIE_DESC;
end;

{************************************************************************}
OBJ_LINE= record                   { straight line object }

    header: OBJ_HEAD;
    fRedraw: BOOL;           { redraw flag }
    rX1,
    rY1,
    rX2,
    rY2: Realtype;
    rc: RECT;
    reserved: array [0..1] of CHAR;
end;

OBJ_ARROW= record                   { arrow object }
    header: OBJ_HEAD;
    fRedraw: BOOL;           { redraw flag }
    rX1,
    rY1,
    rX2,
    rY2: Realtype;
    nArrowLength,     { arrow length and width in points }
    nArrowWidth,
    nArrowLogLength,  { arrow length and width in logical units }
    nArrowLogWidth: INTEGER;

    bFill,            { if TRUE, arrow is filled }
    fStart,           { if TRUE, arrow at line beginning }
    fEnd: BOOL;             { if TRUE, arrow at line end }
    reserved: array [0..1] of CHAR;
end;


OBJ_RECT= record                   { rectangle object }

    header: OBJ_HEAD;
    fRedraw: BOOL;          { redraw flag }
    rX1,
    rY1,
    rX2,
    rY2: Realtype;
    rgbBackColor: TColorRef;
    cFill: CHAR;              { FLAG FOR FILLING BACKGROUND }
    C3D: char;
    reserved: array [0..8] of CHAR;
end;

OBJ_ARC= record                   { arc and pie object }

    header: OBJ_HEAD;
    fRedraw: BOOL;          { redraw flag }
    x1,
    y1,
    x2,
    y2,
    x3,
    y3,
    x4,
    y4: INTEGER;
    rX1,
    rY1,
    rX2,
    rY2,
    rX3,
    rY3,
    rX4,
    rY4: Realtype;

    rgbBackColor: TColorRef;
    cFill: Char;               { FLAG FOR FILLING BACKGROUND }

    reserved: array [0..8] of CHAR;
end;

OBJ_POLYGON= record                   { polygon object }
       TPOINT
    header: OBJ_HEAD;
    fRedraw: BOOL;             { redraw flag }
    nNumPoints: INTEGER;          { polygon size }
    lpLogData: ^TPOINT;         { handle to array of points }
    prX,                 { pointers to data }
    prY: Pointer;

    rgbBackColor: TColorRef;
    cFill: CHAR;               { FLAG FOR FILLING BACKGROUND  }
    cRestored: CHAR;
    reserved: array [0..7] of CHAR;
end;


OBJ_BITMAP= record                   { bitmap object }

    header: OBJ_HEAD;
    fRedraw: BOOL;          { redraw flag }
    rX1,
    rY1,
    rX2,
    rY2: Realtype;
    nMode: INTEGER;
    szName: array[0..MAXBMNAMELEN] of CHAR;  { name of the bitmap }

    reserved: array [0..8] of CHAR;
end;


OBJ_METAFILE= record                   { bitmap object }

    header: OBJ_HEAD;
    fRedraw: BOOL;                 { redraw flag }
    rX1,
    rY1,
    rX2,
    rY2: RealType;
    nMode: INTEGER;
    szName: array[0..MAXBMNAMELEN] of CHAR;  { name of the metafile }
    res1: CHAR;
    pDescMeta: POBJ_META;
    hmf: THandle;                         { metafile handle }
    ExtHeader: EXT_MFHEADER;              { EXTENDED HEADER }

    reserved: array [0..7] of CHAR;
end;
{$endif}

{$ifndef WIN32}
function ErrHdlr (nErrCode, fPar:INTEGER;
                  szParam:PCHAR): INTEGER;
procedure InitDll (lpTop:PTOP_DEF);
function InitTop (lpTop:PTOP_DEF; lpPageProc, lpGraphProc:POINTER;
    gwStyle: INTEGER): BOOL;
procedure   SetupDefPrinter;
function InitPage (lpName:PChar;
                   hwParent:HWND;
                   lpTitle:PChar;
                   lpMenu:PChar;
                   nColor:INTEGER;
                   nSizeMode:INTEGER;
                   dwWinStyle:LongInt;
                   nPosStyle:INTEGER;
                   x, y, cx, cy:INTEGER;
                   lpfnPage:POINTER): PPAGE_DEF;

function CreatePageWindow (pPageDesc:PPAGE_DEF;
                            szClassName:PChar;
                            hwParent, hMenu:HWnd;
                            szCaption:PChar;
                            dwWinStyle:LongInt;
                            nPosStyle, x, y, cx, cy:INTEGER): HWnd; 
function InitGraph (lpTop:PTOP_DEF;
                     pPageDesc:PPAGE_DEF;
                     rX1, rY1, rX2, Y2:Realtype;
                     nColor, nBorderColor,
                     nBorderWidth:INTEGER;
                     lpfnGraph:POINTER): PGRAPH_DEF;

function  CreateChild (szClassName:PChar;
                        pGraphDesc:PGRAPH_DEF;
                        hInst:THandle): HWnd;
function   DataTableProc (thwnd:HWnd; uini:UINT; wpara:UINT; lpara:LongInt): LongInt;
function   EditProc (thwnd:HWnd; uini:UINT; wpara: UINT; lpara:LongInt): LongInt;
function   GetDevDesc: POINTER; 
procedure  HighlightGraph (pPageDesc:PPAGE_DEF; thGraph:HGRAPH);
procedure  ResizePage (thwnd:HWnd; cxNewVExt, cyNewVExt:INTEGER);
procedure  HighlightObj (pGrDesc:PGRAPH_DEF);
function   GetGrDescPtr (hGr:HGRAPH): PGRAPH_DEF;
function   GetPgDescPtr (hPg:HGRAPH): PPAGE_DEF;
procedure  ShowGraphSelectors (pPageDesc:PPAGE_DEF; thdc:HDC; nAction:INTEGER);
procedure  KillGraphPage (hPage:HGRAPH);
procedure  ConnectAxes (pGrDesc:PGRAPH_DEF);
procedure  ObjectInterpreter (pGrDesc:PGRAPH_DEF; thdc:HDC);
procedure  PrinterCleanup;
procedure  Cleanup (lpTop:PTOP_DEF; bFreeData:BOOL);
procedure  FreeAllDataSets (bFreeData:BOOL);
procedure  ExitApplication;
procedure MapGraph (pGrDesc:PGRAPH_DEF; thdc:HDC);

{$else}

function ErrHdlr (nErrCode, fPar:INTEGER;
                  szParam:PCHAR): INTEGER; stdcall;
procedure InitDll (lpTop:PTOP_DEF); stdcall;
function InitTop (lpTop:PTOP_DEF; lpPageProc, lpGraphProc:POINTER;
    gwStyle: INTEGER): BOOL;stdcall;
procedure   SetupDefPrinter;stdcall;
function InitPage (lpName:PChar;
                   hwParent:HWND;
                   lpTitle:PChar;
                   lpMenu:PChar;
                   nColor:INTEGER;
                   nSizeMode:INTEGER;
                   dwWinStyle:LongInt;
                   nPosStyle:INTEGER;
                   x, y, cx, cy:INTEGER;
                   lpfnPage:POINTER): PPAGE_DEF;  stdcall;

function CreatePageWindow (pPageDesc:PPAGE_DEF;
                            szClassName:PChar;
                            hwParent, hMenu:HWnd;
                            szCaption:PChar;
                            dwWinStyle:LongInt;
                            nPosStyle, x, y, cx, cy:INTEGER): HWnd; stdcall;
function InitGraph (lpTop:PTOP_DEF;
                     pPageDesc:PPAGE_DEF;
                     rX1, rY1, rX2, Y2:Realtype;
                     nColor, nBorderColor,
                     nBorderWidth:INTEGER;
                     lpfnGraph:POINTER): PGRAPH_DEF; stdcall;

function  CreateChild (szClassName:PChar;
                        pGraphDesc:PGRAPH_DEF;
                        hInst:THandle): HWnd; stdcall;
function   DataTableProc (thwnd:HWnd; uini:UINT; wpara:UINT; lpara:LongInt): LongInt; stdcall;
function   EditProc (thwnd:HWnd; uini:UINT; wpara: UINT; lpara:LongInt): LongInt;stdcall;
function   GetDevDesc: POINTER; stdcall;
procedure  HighlightGraph (pPageDesc:PPAGE_DEF; thGraph:HGRAPH);stdcall;
procedure  ResizePage (thwnd:HWnd; cxNewVExt, cyNewVExt:INTEGER);stdcall;
procedure  HighlightObj (pGrDesc:PGRAPH_DEF);stdcall;
function   GetGrDescPtr (hGr:HGRAPH): PGRAPH_DEF;stdcall;
function   GetPgDescPtr (hPg:HGRAPH): PPAGE_DEF;stdcall;
procedure  ShowGraphSelectors (pPageDesc:PPAGE_DEF; thdc:HDC; nAction:INTEGER);stdcall;
procedure  KillGraphPage (hPage:HGRAPH);stdcall;
procedure  ConnectAxes (pGrDesc:PGRAPH_DEF);stdcall;
procedure  ObjectInterpreter (pGrDesc:PGRAPH_DEF; thdc:HDC);stdcall;
procedure  PrinterCleanup;stdcall;
procedure  Cleanup (lpTop:PTOP_DEF; bFreeData:BOOL);stdcall;
procedure  FreeAllDataSets (bFreeData:BOOL);stdcall;

procedure  ExitApplication;stdcall;
procedure MapGraph (pGrDesc:PGRAPH_DEF; thdc:HDC);stdcall;

{$endif}

implementation

{*********************************************************************}
{ Function prototypes ************************************************}
{*********************************************************************}
{ Window procedures }


procedure InitDll; external QCDLL;
function  InitTop; external QCDLL;
function  ErrHdlr; external QCDLL;
procedure SetupDefPrinter; external QCDLL;
function  InitPage; external QCDLL;
function  CreatePageWindow; external QCDLL;
function  InitGraph; external QCDLL;
function  CreateChild; external QCDLL;
function  DataTableProc; external QCDLL;
function  EditProc; external QCDLL;
function  GetDevDesc; external QCDLL;
procedure HighlightGraph ; external QCDLL;
procedure ResizePage; external QCDLL;
procedure HighlightObj; external QCDLL;
function  GetGrDescPtr; external QCDLL;
function  GetPgDescPtr; external QCDLL;
procedure ShowGraphSelectors; external QCDLL;
procedure KillGraphPage ; external QCDLL;
procedure ConnectAxes ; external QCDLL;
procedure ObjectInterpreter ; external QCDLL;
procedure PrinterCleanup; external QCDLL;
procedure FreeAllDataSets; external QCDLL;
procedure Cleanup; external QCDLL;
procedure  ExitApplication; external QCDLL;
procedure MapGraph; external QCDLL;

end.
