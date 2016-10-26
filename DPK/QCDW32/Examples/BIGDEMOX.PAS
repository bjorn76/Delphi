{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   BIGDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
    This program creates three pages of different graphs.
}


unit Bigdemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure WM_Paint(thdc: HDC);
procedure MM_About(thwnd: HWND; tinst: THANDLE);

implementation

{$R demo}

const
 NUMP11= 100;
 NUMP12=  32;
 NUMP2=   30;
 NUMP3=    4;
 GROUPLEN= 4;
 szAppName: PCHAR = 'BigDemo';  {  Class Name used in call to CreateWindow.  }

var
  hInst: THANDLE;                  {  global instance handle}
  hX11,hY11, hX12, hY12,  {  global handles to data arrays}
  hX21, hY21, hX22, hY22, hX23, hY23,
  hX31, hY31,
  hStr2: HGLOBAL;
  hDataSet: HDATA;      {  global memory handle for string label array}

  lpX11, lpY11, lpX12, lpY12 : LPREAL;


{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure StartPage2 (pPageDesc: PPAGE_DEF); far; forward;
procedure StartPage3 (pPageDesc: PPAGE_DEF); far; forward;

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP3G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

function randreal:realtype; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL; forward;


procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Page with Two Graphs',    {  Window title string }
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_FIXED,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_FULL  ,               {  page will fill the whole screen}
            0, 0, 0, 0);               {  initial window size and position}
                                       {  IF used (not used here)}
          WGCreatePage ('PAGE2', thwnd, hInst, ' PAGE 2', @StartPage2,
            nil,                       {  no menu}
            C_LIGHTGRAY, MM_FIXED, 0, PAGE_EXACT, 4, 20, 600, 300);

          WGCreatePage ('PAGE3', thwnd, hInst, 'Group Bargraph', @StartPage3,
            'PAGEMENU', C_GRAY, MM_FIXED, 0, PAGE_CLIENT, 0, 0, 0, 0);
  END;

procedure WM_DestroyGraph;
begin
      WGFreeDataSet (hDataSet, TRUE);  {  free data set and data arrays}

      GlobalFree (hX11);               {  free other global data arrays}
      GlobalFree (hY11);
      GlobalFree (hX21);
      GlobalFree (hY21);
      GlobalFree (hX22);
      GlobalFree (hY22);
      GlobalFree (hX23);
      GlobalFree (hY23);
      GlobalFree (hX31);
      GlobalFree (hY31);

      GlobalFree (hStr2);
      WGCleanup (FALSE);               {  clean up charting tools memory}

      PostQuitMessage (0);
end;

procedure WM_Paint(thdc: HDC);
begin
    DisplayBitmap (thdc, 'monkey.bmp', 100, 100);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
Begin
  DialogBox (tInst,            {  current instance   }
        'AboutBox',                {  resource to use       }
        thwnd,                     {  parent window handle  }
        @AboutProc);              {  AboutProc() instance address  }
END;


{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when page 1 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const
   fInit:  BOOL = TRUE;

procedure  StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z: realtype;

   lpX21, lpY21, lpX22, lpY22, lpX23, lpY23, lpX31, lpY31: LPREAL;
begin
  {  create simulation data for plots}
  { -------------------------------------------------------------- }
  if (fInit) THEN
  BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX11 := GlobalAlloc (GHND, sizeof (realtype) * NUMP11);
    hY11 := GlobalAlloc (GHND, sizeof (realtype) * NUMP11);
    hX12 := GlobalAlloc (GHND, sizeof (realtype) * NUMP12);
    hY12 := GlobalAlloc (GHND, sizeof (realtype) * NUMP12);
    hX21 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hY21 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hX22 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hY22 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hX23 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hY23 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hX31 := GlobalAlloc (GHND, sizeof (realtype) * NUMP3 * GROUPLEN);
    hY31 := GlobalAlloc (GHND, sizeof (realtype) * NUMP3 * GROUPLEN);
    
    {  get pointers to data}
    lpX11 := GlobalLock (hX11);
    lpY11 := GlobalLock (hY11);
    lpX12 := GlobalLock (hX12);
    lpY12 := GlobalLock (hY12);

    lpX21 := GlobalLock (hX21);
    lpY21 := GlobalLock (hY21);
    lpX22 := GlobalLock (hX22);
    lpY22 := GlobalLock (hY22);
    lpX23 := GlobalLock (hX23);
    lpY23 := GlobalLock (hY23);
    
    lpX31 := GlobalLock (hX31);
    lpY31 := GlobalLock (hY31);
    
    {  simulate x and y data to be plotted}
    for i := 0 to  NUMP11 - 1 do begin
      z := i;
      WGPutPntrReal (lpX11, i, z);
      WGPutPntrReal (lpY11, i, 15.0 *
        cos (PI * z / (4.0 + 0.3 * randreal)) +
        3.0 * randreal);
    end;

    for i := 64 to 95 do begin
      WGPutPntrReal (lpY12, i - 64, WGGetPntrReal (lpY11, i));
      WGPutPntrReal (lpX12, i - 64, WGGetPntrReal (lpX11, i));
    end;
    
    for i := 0 to  NUMP2 - 1 do begin
      WGPutPntrReal (lpX21, i, (1.0 + i));
      WGPutPntrReal (lpY21, i, 50.0 + 150.0 * (1.0 - exp (- i / 9.0)));
      WGPutPntrReal (lpX22, i, WGGetPntrReal (lpX21, i));
      WGPutPntrReal (lpY22, i, WGGetPntrReal (lpY21, i) + 80.0 * randreal - 0.5);
      WGPutPntrReal (lpX23, i, WGGetPntrReal (lpX21, i));
      WGPutPntrReal (lpY23, i, WGGetPntrReal (lpY22, i) - WGGetPntrReal (lpY21, i));
    end;

    for i := 0 to  NUMP3 - 1 do begin
      z := (i);
      WGPutPntrReal (lpX31, i, z + 1.0);
      WGPutPntrReal (lpY31, i * NUMP3, 20.0 + z * 10.0 * randreal);
      WGPutPntrReal (lpY31, i * NUMP3 + 1, 30.0 + z * 18.0 * randreal);
      WGPutPntrReal (lpY31, i * NUMP3 + 2, 40.0 + z * 5.0 * randreal);
      WGPutPntrReal (lpY31, i * NUMP3 + 3, 50.0 + z * 2.0 * randreal);
    end;

    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }

  {  Initialize graphs for page 1}
  
  WGCreateGraph (pPageDesc, 
    @DrawP1G1,                         {  function which builds graph}
    0.01, 0.01,                        {  window relative position inside parent page window}
    0.99, 0.35, 
    C_CYAN,                            {  background}
    C_BLACK,                           {  black border}
    1);                                {  border width in pixels}

  WGCreateGraph (pPageDesc, 
    @DrawP1G2,                         {  function which builds graph}
    0.01, 0.42,                        {  window relative position inside parent page window}
    0.99, 0.9,
    C_GRAY,                            {  gray background}
    C_BLACK,                           {  black border}
    1);                                {  border width in pixels}
end;

{ *********************************************************************
   Routine StartPage2 is called by the Quinn-Curtis
   Windows Charting Tools when page 2 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure  StartPage2 (pPageDesc: PPAGE_DEF);
begin
  WGCreateGraph (pPageDesc, @DrawP2G1, 0.01, 0.01, 0.99, 0.99,
    C_GREEN, - 1, 0);
end;

{ *********************************************************************
   Routine StartPage3 is called by the Quinn-Curtis
   Windows Charting Tools when page 3 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure StartPage3 (pPageDesc: PPAGE_DEF);
begin
  WGCreateGraph (pPageDesc, @DrawP3G1, 0.01, 0.01, 0.99, 0.99, 
    C_MAGENTA, - 1, 0);
end;

{ ******************************************************
   Page 1 Graph 1 building procedure
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;   {  axes handles}
    hDataSet1: HDATA;        {  data set handle}
begin
  {  define a dataset }
  hDataSet1 := WGDefineDataSetPtr ('60 Cycle Noise', lpX11, lpY11, NUMP11);
  if (hDataSet1 = NULLH)  THEN             {  check IF data set is good}
    exit ;

  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.1, 0.15, 0.9, 0.85, C_BLACK);
  {  scale plotting area}
  WGScalePlotArea (pGrDesc, 0.0, - 20.0, 100.0, 20.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  axes to be drawn in solid, white, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

  {  set current font to Arial, 11 points, bold}
  WGSetTextByName (C_WHITE, 'Arial', 11, TEXT_BOLD);

  hAxisX := WGDrawXAxis (pGrDesc, thdc, 20, 1, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_OFF, NULLS);
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL,
    - 1, LL_ON, NULLS);

  {  set line style of actual plot to CYAN}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_CYAN);

  {  plot the data }
  WGLinePlot (pGrDesc, thdc, hDataSet1, FALSE, FALSE);

  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

  {  Draw second Y axis}
  WGSetXYIntercepts (pGrDesc, 100.0, 0.0);
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_WHITE);
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 1, POS_RIGHT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_RIGHT, NF_DECIMAL,
    - 1, LL_ON, NULLS);

  {  draw red rectangle}
  WGRectangle (pGrDesc, thdc, hAxisX, hAxisY, 64.0, 18.0, 96.0, - 15.0,
    C_RED, 2, FALSE, 0);

  {  set current font to Arial, 15 points, bold, underlined}
  WGSetTextByName (C_YELLOW, 'Arial', 15, TEXT_BOLD  or  TEXT_UNDERLINE);

  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Input Waveform');
end;
{ ******************************************************
   Page 1 Graph 2 building procedure
******************************************************* }
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
     hAxisX, hAxisY: HGOBJ;           {  axes handles}
begin
  {  define a dataset }
  hDataSet := WGDefineDataSet ('Zoomed Data', hX12, hY12, NUMP12);
  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.10, 0.10, 0.9, 0.9, C_WHITE);
  {  scale plotting area }
  WGScalePlotArea (pGrDesc, 60, - 20.0, 96, 20.0);
  WGSetXYIntercepts (pGrDesc, 60, 0.0);

  {  Select 'New Courier' font, black, size - 10 points}
  WGSetTextByName (C_BLACK, 'Courier New', 10, 0);
  
  {  set line parameters to Black, Solid, 2 pixels wide}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
  
  {  Draw X-axis, major tick interval := 5}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 5.0, 4, POS_BELOW);
  {  Label X-Axis}
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  {  Write X-Axis Title}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');

  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 
    - 1, LL_ON, NULLS);
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');
  
  {  Draw grids with dotted lines}
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_BLACK);
  WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);
  WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);
  
  {   Draw second Y-axis at the right side of the plotting area}
  WGSetXYIntercepts (pGrDesc, 96, 0.0);
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 1, POS_RIGHT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_RIGHT, NF_DECIMAL, 
    - 1, LL_ON, NULLS);
  
  {  Plot data set}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLUE);
  WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, TRUE);
  
  {  Graph Title}
  WGSetTextByName (C_BLACK, 'Courier New', 15, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Zoom - Datapoints [64] to [96]');
end;

{ ******************************************************
   Page 2 Graph 1 building procedure
******************************************************* }

procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;
    hDataSet1, hDataSet2, hDataSet3: HDATA;  {  data set handles}
    lpstr: PCHAR;
    hStr1: HGLOBAL;                {  global memory handle for legend array }
begin
  {  Define 3 data sets}
  hDataSet1 := WGDefineDataSet ('Fitted Data', hX21, hY21, NUMP2);
  hDataSet2 := WGDefineDataSet ('Raw Data', hX22, hY22, NUMP2);
  hDataSet3 := WGDefineDataSet ('Residuals', hX23, hY23, NUMP2);

  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.16, 0.1, 0.95, 0.9, C_WHITE);
  WGScalePlotArea (pGrDesc, 0, - 50.0, 32, 250);

  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

  {  Select font of family 'FF_SWISS', 10 points.}
  WGSetTextParams (C_BLACK, FF_SWISS, 10, 0);
  {  draw axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 5, 4, POS_BELOW);
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 50, 4, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL,
    - 1, LL_ON, NULLS);

  {  Draw grid lines}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_GRAY);
  WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);
  WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

  {  Scatter Plot - data set 2}

  WGScatterPlot (pGrDesc, thdc, hDataSet2, MK_ASTERISK, C_LIGHTBLUE, 7,
    MKS_EMPTY, FALSE);

  {  Line Plot - data set 1}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_RED);
  WGLinePlot (pGrDesc, thdc, hDataSet1, FALSE, FALSE);

  {  bargraph - data set 3}
  WGBargraph (pGrDesc, thdc, hDataSet3, 0.5, POS_MIDDLE,
    LT_VBAR, RGB (0, 160, 160), - 1, C_CYAN);

  {  Label X-axis }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);

  WGSetTextParams (C_BLACK, FF_MODERN, 12, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Fusion Run XRK-823V');

  WGSetTextParams (C_BLACK, FF_MODERN, 9, TEXT_BOLD);
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Time - Nanoseconds');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Neutrons Detected');

  {  Allocate string array for legends}
  hStr1 := GlobalAlloc (GHND, 3 * LG_MAXLEN);
  lpstr := GlobalLock (hStr1);
  {  Initialize legends}
  lstrcpy (lpstr, 'Measured Values');
  lstrcpy (lpstr + LG_MAXLEN, 'Predicted Values');
  lstrcpy (lpstr + 2 * LG_MAXLEN, 'Residuals');

  WGSetTextParams(C_BLACK, FF_SWISS, 6, 0);
  WGLegend (pGrDesc, thdc, 0.65, 0.43, 0.98, 0.68, C_BLACK, 3, - 1, C_WHITE,
    OR_VERT, hStr1);
  GlobalFree (hStr1);
end;

{ ******************************************************
   Page 3 Graph 1 building procedure
******************************************************* }

procedure DrawP3G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   n: INTEGER;
   hAxisX, hAxisY, hBar: HGOBJ;
   hDataSet: HDATA;
   lpRgbBarColor: array[0..5] of TCOLORREF;
   lpstr: PCHAR;
   hRgbBarColor,
   hStr3: THANDLE;         {  global memory handle for legend array  }
begin

  WGRaiseGraph (pGrDesc, RC_HIGH);
  n := 4;                              {  number of string labels)}
  {  Allocate string array for labels}
  hStr2 := GlobalAlloc (GHND, n * LABELLEN);
  lpstr := GlobalLock (hStr2);

  {  Initialize labels array}
  lstrcpy (lpstr, 'EAST');
  lstrcpy (lpstr + LABELLEN, 'CNTRL');
  lstrcpy (lpstr + 2 * LABELLEN, 'WEST');
  lstrcpy (lpstr + 3 * LABELLEN, 'SOUTH');
  
  {  allocate array for bar colors}
  hRgbBarColor := GlobalAlloc (GHND, n * sizeof (TCOLORREF));
  
  lpRgbBarColor[0] := WGGetRGBColor (C_LIGHTBLUE);
  lpRgbBarColor[1] := WGGetRGBColor (C_LIGHTGREEN);
  lpRgbBarColor[2] := RGB (0, 160, 160);
  lpRgbBarColor[3] := WGGetRGBColor (C_LIGHTRED);
  
  {  Define group data set}
  hDataSet := WGDefineGroupDataSet ('Sales', hX31, hY31, NUMP3, GROUPLEN);
  
  {  Define plotting area}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.2, 0.9, 0.7, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 5.0, 220.0);

  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  WGSetTextByName (C_BLACK, 'Courier New', 9, 0);
  {  set line style for axes}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
  
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 1, POS_BELOW);
  WGLabelAxisStrings (pGrDesc, thdc, hAxisX, POS_BELOW, 1, hStr2);

  hAxisY := WGDrawYAxis (pGrDesc, thdc, 50, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 
    - 1, LL_ON, NULLS);
  
  {  Group bargraph - stacked bars}
  hBar := WGGroupBargraph (pGrDesc, thdc, hDataSet, 0.45, POS_MIDDLE,
    LT_VBAR, GT_STACKEDBARS, @lpRgbBarColor, NULLP, NULLP);
  
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sales Region');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Dollar Volume');
  
  {  Allocate string array for legends}
  hStr3 := GlobalAlloc (GHND, GROUPLEN * LG_MAXLEN);
  lpstr := GlobalLock (hStr3);
  lstrcpy (lpstr, 'W. Jones');
  lstrcpy (lpstr + LG_MAXLEN, 'D. Hanton');
  lstrcpy (lpstr + 2 * LG_MAXLEN, 'J. Garcia');
  lstrcpy (lpstr + 3 * LG_MAXLEN, 'T. Logan');
  
  {  draw transparent horizontal legends}
  WGLegendGroup (pGrDesc, thdc, 0.1, 0.86, 0.93, 0.99,
    - 1, 0, - 1, - 1, OR_HORZ, hStr3, hBar);
  
  WGSetTextByName (C_BLACK, 'Times New Roman', 16, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Salesmen Performance by Region');
  
  {  Free bar color array (string arrays should be freed only when the }
  {  program exits}
  
  GlobalFree (hStr3);
end;

{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

{ ************************************************************************
 Loads and displays a Windows bitmap defined in resource file
************************************************************************* }

function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL;
var
    thdcMem: HDC;
    bm: TBITMAP;
    thBitmap: HBITMAP;
begin
  thBitmap := LoadBitmap (hInst, pName);
  if thBitmap = NULLH then begin
    DisplayBitmap := FALSE;
    exit;
  end;
  
  thdcMem := CreateCompatibleDC (thdc);
  SelectObject (thdcMem, thBitmap);
  GetObject (thBitmap, sizeof (TBITMAP), @bm);
  BitBlt (thdc, xLeft, yTop, bm.bmWidth, bm.bmHeight, thdcMem, 0, 0, SRCCOPY);
  DeleteDC (thdcMem);
  DeleteObject (thBitmap);
  DisplayBitmap := TRUE;
end;
{ **********************************************************************
	FUNCTION: AboutProc

    PURPOSE:  Processes messages for 'About' dialog box

************************************************************************ }

function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL;
begin
  case message of
    WM_INITDIALOG: begin 
      AboutProc := TRUE;
      exit;
    end;
    
    WM_COMMAND: begin 
      if (wParam = IDOK)  or (wParam = IDCANCEL) then begin
        EndDialog (hDlg, 1);
        AboutProc := TRUE;
        exit;
      end;
    end;
  end;
  AboutProc := FALSE;
end;

{ ************************************************************************ }

begin

end.
