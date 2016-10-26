{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DEM1P3GX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{
    Three graphs are drawn in a single page window.
    The first graph window displays a bar graph, the
    second graph window displays two line plots, and the
    third graph window displays some text.

    This demo differs from DEMO3P1G.pas which displays
    three pages, each with a single graph window.

    Compare these demos for the differences between pages and graphs. 
}

unit Dem1p3gx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}


const NUMP1 = 200;                  {  number of data points}
      szAppName: PCHAR= 'Demo1P3G'; {  Class Name used in call to CreateWindow.  }

var
    hInst: THANDLE;                          {  global instance handle}
    hX1, hY1, hY2: hGLOBAL;         {  global handles to data}


{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawGraphP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawGraphP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            '1 Page, 3 Graphs',        {  Window title string}
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_CLIENT,
            {  window initial size and position option}
            0, 0, 0, 0);
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
end;

{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

const  fInit:BOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z: realtype;
   lpX1, lpY1, lpY2: LPREAL;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY2 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    lpY2 := GlobalLock (hY2);
    {  create x and y data to be plotted}
    for i := 0 to NUMP1 - 1 do begin
      z := i;
      WGPutPntrReal (lpX1, i, z);
      WGPutPntrReal (lpY1, i, sin (3.141519 * z / (225.0 - z)));
      WGPutPntrReal (lpY2, i, sin (3.141519 * z / 52.0) * randreal * 1.1);
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graphs}

  {  the first graph is defined here}
  {  DrawGraphP1G1 is the building function}
  WGCreateGraph (pPageDesc, 
    @DrawGraphP1G1,                    {  function which builds graph}
    0.51, 0.01,                        {  window relative position inside parent page window}
    0.998, 0.501,
    C_WHITE,                           {  white background}
    C_RED,                             {  red border}
    2);                                {  border width in pixels}

  {  the second graph is defined,}
  {  DrawGraphP1G2 is the building function}
  WGCreateGraph (pPageDesc, 
    @DrawGraphP1G2,                    {  function which builds graph}
    0.01, 0.37,                        {  window relative position inside parent page window}
    0.99, 0.9,
    C_BLUE,                            {  blue background}
    C_WHITE,                           {  white border}
    1);                                {  border width in pixels}

  {  finally, the third graph is defined,}
  {  DrawGraphP1G3 is the building function}
  WGCreateGraph (pPageDesc,
    @DrawGraphP1G3,                    {  points to function which builds graph}
    0.01, 0.01,                        {  window relative position inside parent page window}
    0.49, 0.3,
    C_BLACK,                           {  black background}
    C_WHITE,                           {  white border}
    4);                                {  border width in pixels}
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hDataSet: HDATA;        {  data set handle}
    hAxX, hAxY, hLabX, hLabY: HGOBJ;
begin
  {  define a dataset, display the first 75 data points of the data set. }
  hDataSet := WGDefineDataSet ('Bar Graph', hX1, hY1, 75);

  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.10, 0.15, 0.95, 0.85, C_WHITE);

  {  axis to be drawn in solid, black, 1 pixel thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

  {  set text style}
  WGSetTextByName (C_LIGHTMAGENTA, 'Arial', 8, TEXT_NORMAL);
  
  {  analyze the data, then scale the plotting area and}
  {  draw and label the x and y axes}
  WGAutoAxes (pGrDesc, thdc, hDataSet, AS_ROUNDFAR, INTF_ZERO, 
    hAxX, hAxY, hLabX, hLabY);
  
  {  display a vertical bar graph with center positioned bars}
  WGBargraph (pGrDesc, thdc, hDataSet, 0.15, POS_MIDDLE, LT_VBAR, 
    RGB (128, 0, 0), - 1, - 1);
  
  {  set current font to Arial, 10 points, bold, italic}
  WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  or  TEXT_ITAL);
  
  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Temperature Change');
end;

{ ************************************************************************************* }
{  display the line plots in graph 2}
procedure DrawGraphP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   hAxisX, hAxisY: HGOBJ;  {  axes handles}
   hDataSet1, hDataSet2: HDATA;        {  data set handles}
begin
  {  define 2 datasets}
  hDataSet1 := WGDefineDataSet ('Line1', hX1, hY1, NUMP1);
  hDataSet2 := WGDefineDataSet ('Line2', hX1, hY2, NUMP1);
  
  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.10, 0.15, 0.95, 0.75, C_YELLOW);
  
  {  x range 0.0 to 210.0, y range -1.5 to 2.0}
  WGScalePlotArea (pGrDesc, 0.0, - 1.5, 210.0, 2.0);
  
  {  Intercepts x := 0.0, y = 1.5 }
  WGSetXYIntercepts (pGrDesc, 0.0, - 1.5);

  {  axis to be drawn in solid, green, 1 pixel thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_GREEN);
  
  {  Draw a tick on the y axis every 0.5 from y-intercept,}
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 0.5, 1, POS_LEFT);
  
  {  set current font to Modern, 9 points, bold, italic}
  WGSetTextParams (C_LIGHTGREEN, FF_MODERN, 9, TEXT_BOLD  or  TEXT_ITAL);
  
  {  Label Y-axis}
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);

  {  Draw a tick on the x axis every 25 from the intercept,}
  {   i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0 }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 25.0, 5, POS_BELOW);
  
  {  Label every major tick, i.e, 0.0, 25, 50, ..., 200}
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);

  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLUE);
  {  Display an array of data}
  WGLinePlot (pGrDesc, thdc, hDataSet1, FALSE, FALSE);
  
  {  Set the line style to a solid blue red}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_RED);
  {  now display the second data set}
  WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);
  
  {  set current font to Modern, 9 points, bold, italic}
  WGSetTextParams (C_WHITE, FF_MODERN, 9, TEXT_BOLD  or  TEXT_ITAL);
  
  {  output x and y axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Temperature C');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Normalized Pressure');
end;

{ ************************************************************************ }

{  Write only text in graph 3}

procedure DrawGraphP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
 tempstr,  volstr: array[0..12] of CHAR;
begin
  {  set current font to Modern, 9 points, bold, italic}
  WGSetTextParams (C_LIGHTMAGENTA, FF_ROMAN, 10, TEXT_BOLD  or  TEXT_ITAL);
  
  {  convert some data to display as text }
  lstrcpy (tempstr, '123.5');
  lstrcpy (volstr, '5.0');
  
  {  Graph normalized coordinates are used to display text.}
  
  WGTextNorm (pGrDesc, thdc, 'Lab Results      pv=nrt study', 0.050, 0.075, TA_LEFT, TEXT_NORMAL);
  WGTextNorm (pGrDesc, thdc, 'Date                   8/18/90', 0.05, 0.2, TA_LEFT, TEXT_NORMAL);
  WGTextNorm (pGrDesc, thdc, 'Gas                    Argon', 0.05, 0.325, TA_LEFT, TEXT_NORMAL);
  WGTextNorm (pGrDesc, thdc, 'Temperature', 0.050, 0.45, TA_LEFT, TEXT_NORMAL);
  WGTextNorm (pGrDesc, thdc, tempstr, 0.33, 0.45, TA_LEFT, TEXT_NORMAL);
  WGTextNorm (pGrDesc, thdc, 'Volume', 0.050, 0.6, TA_LEFT, TEXT_NORMAL);
  lstrcat (volstr, ' liters');
  WGTextNorm (pGrDesc, thdc, volstr, 0.33, 0.6, TA_LEFT, TEXT_NORMAL);
end;

{ *************************************************************************
    FUNCTION: AboutProc
    PURPOSE:  Processes messages for 'About' dialog box
*************************************************************************** }

function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL;
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

{ ************************************************************************
 Load and display a Windows bitmap defined in resource file
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
{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

{ ********************************************************************* }
begin

end.
