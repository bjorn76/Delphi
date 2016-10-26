{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DEM3P1GX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 

    Three graphs are drawn in three separate page windows.
    The first page window displays a bar graph, the
    second page window displays two line plots, and the
    third page window displays some text.

    The three pages can be moved and resized.

    This demo differs from DEMO1P3G.pas which displays
    a single page window with three graph window.

    Compare these demos for for the differences between pages and graphs.
}

unit Dem3p1gx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}


const NUMP1 = 200;                  {  number of data points}
      szAppName: PCHAR= 'Demo3P1G'; {  Class Name used in call to CreateWindow.  }

var
    hInst: THANDLE;                          {  global instance handle}
    hX1, hY1, hY2: HGLOBAL;         {  global handles to data}


{  Prototypes of forward referenced functions}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;
procedure StartPage2 (pPageDesc: PPAGE_DEF); far; forward;
procedure StartPage3 (pPageDesc: PPAGE_DEF); far; forward;
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawGraphP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawGraphP3G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

function  AboutProc (hDlg: HWND; message: WORD; wParam: WORD; lParam: LONGINT):WORDBOOL; export; forward;
function randreal:realtype; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):WORDBOOL; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
var r: TRECT;
    w, h, x, y: Integer;
BEGIN
          GetClientRect(thwnd, r);
          w := r.right - r.left;
          h := abs(r.bottom - r.top);
          x := 0;
          y := 0;

		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Page 1, Graph 1',         {  Window title string}
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            NULLH,                     {  window style - default}
            PAGE_EXACT,
            {  window initial size and position option}
            x + w div 2,
            y + 10,
            w div 2 - 20,
            h div 2 - 20 );

          WGCreatePage ('PAGE2',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            hInst,                     {  application instance handle }
            'Page 2, Graph 1',         {  Window title string}
            @StartPage2,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            NULLH,                     {  window style - default}
            PAGE_EXACT,
            {  window initial size and position option}
            x + 20,
            y + h div 2 + 20,
            w - 30,
            h div 2 - 10);

          WGCreatePage ('PAGE3',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            hInst,                     {  application instance handle }
            'Page 3, Graph 1',         {  Window title string}
            @StartPage3,               {  pointer to graph creation function}
            NULLS,                     {  a menu is not displayed in this window}
            C_LIGHTRED,                {  window background color}
            MM_PROPORT,                {  window sizing mode}
            NULLH,                         {  window style - default}
            PAGE_EXACT,
            {  window initial size and position option}
            x + 20,
            y + 20,
            w div 2 - 30,
            h div 2 - 30);
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
VAR  lpProcAbout: TFARPROC;
begin
    lpProcAbout := MakeProcInstance (@AboutProc, tInst);
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            lpProcAbout);              {  AboutProc() instance address  }
    FreeProcInstance (lpProcAbout);

end;


{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

{  create page 1}
const   fInit: WORDBOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
    i: INTEGER;
    z: Realtype;
    lpX1, lpY1, lpY2: LPReal;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice, this data will be used by all graphs}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY2 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    lpY2 := GlobalLock (hY2);
    {  create x and y data to be plotted}
    for i := 0 to  NUMP1 - 1 do begin
      z := i;
      WGPutPntrReal (lpX1, i, z);
      WGPutPntrReal (lpY1, i, sin (3.141519 * z / (225.0 - z)));
      WGPutPntrReal (lpY2, i, sin (3.141519 * z / 52.0) * randreal * 1.1);
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }

  {  Initialize graph }
  
  WGCreateGraph (pPageDesc, 
    @DrawGraphP1G1,                    {  name of function which builds graph}
    0.0, 0.0,                          {  window relative position inside parent page window}
    1.0, 1.0,
    C_WHITE,                           {  white background}
    C_RED,                             {  red border}
    2);                                {  border width in pixels}
end;

{ ************************************************************************ }

{  create the second page}

procedure StartPage2 (pPageDesc: PPAGE_DEF);
begin
  {  Initialize graph }
  
  WGCreateGraph (pPageDesc, 
    @DrawGraphP2G1,                    {  name of function which builds graph}
    0.0, 0.0,                          {  window relative position inside parent page window}
    1.0, 1.0,
    C_BLUE,                            {  black background}
    C_WHITE,                           {  white border}
    1);                                {  border width in pixels}
end;

{ ************************************************************************ }
{  create page 3}

procedure StartPage3 (pPageDesc: PPAGE_DEF);
begin
  {  Initialize graph }
  WGCreateGraph (pPageDesc, 
    @DrawGraphP3G1,                    {  name of function which builds graph}
    0.0, 0.0,                          {  window relative position inside parent page window}
    1.0, 1.0,
    C_BLACK,                           {  black background}
    C_WHITE,                           {  white border}
    4);                                {  border width in pixels}
end;

{ ***********************************************************
   Builds graph 1 in page 1 using Q-C Windows Charting Calls
************************************************************ }

procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hDataSet: HDATA;        {  data set handle}
   hAxX, hAxY, hLabX, hLabY: HGOBJ;
begin
  {  define a dataset }
  hDataSet := WGDefineDataSet ('Bar Graph', hX1, hY1, 75);

  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.10, 0.15, 0.95, 0.85, C_WHITE);

  {  axis to be drawn in solid, black, 2 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  {  set text style}
  WGSetTextByName (C_LIGHTMAGENTA, 'Arial', 8, TEXT_NORMAL);
  
  {  auto scale the x and y axis}
  WGAutoAxes (pGrDesc, thdc, hDataSet, AS_ROUNDFAR, INTF_ZERO,
    hAxX, hAxY, hLabX, hLabY);
  
  {  output the bar graph}
  WGBargraph (pGrDesc, thdc, hDataSet, 0.2, POS_MIDDLE, LT_VBAR,
    RGB (128, 0, 0), - 1, - 1);
  
  {  set current font to Arial, 10 points, bold, italic}
  WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  or  TEXT_ITAL);
  
  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Temperature Change');
end;

{ ******************************************************
   Builds graph 1 in page 2
******************************************************* }
procedure DrawGraphP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;  		{  axes handles}
    hDataSet1, hDataSet2: HDATA;	{  data set handles}
begin
  {  define 2 datasets}
  hDataSet1 := WGDefineDataSet ('Line1', hX1, hY1, NUMP1);
  hDataSet2 := WGDefineDataSet ('Line2', hX1, hY2, NUMP1);
  
  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.15, 0.95, 0.80, C_YELLOW);

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
  
  {  Label y-axis}
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  {  Draw a tick on the x axis every 25 from the intercept,}
  {   i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 25.0, 2, POS_BELOW);
  
  {  Label every major tick, i.e, 0.0, 25, 50, ..., 200 }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLUE);
  {  Display an array of data }
  WGLinePlot (pGrDesc, thdc, hDataSet1, FALSE, FALSE);
  
  {  Set the line style to a solid blue red}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_RED);
  {  now display the second data set}
  WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);
  
  {  set current font to Modern, 9 points, bold, italic}
  WGSetTextParams (C_WHITE, FF_MODERN, 9, TEXT_BOLD  or  TEXT_ITAL);
  
  {  output x and y axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Temperature C.');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Normalized Pressure');
end;

{ ******************************************************
   Builds graph 1 in page 3
******************************************************* }

procedure DrawGraphP3G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   tempstr,  volstr: array[0..12] of CHAR;
begin
  {  set current font to Modern, 10 points, bold, italic}
  WGSetTextParams (C_LIGHTMAGENTA, FF_ROMAN, 10, TEXT_BOLD  or  TEXT_ITAL);
  
  {  convert some data to display as text }
  lstrcpy (tempstr, '123.5');
  lstrcpy (volstr, '5.0');

  {  Graph normalized coordinates are used to display text.}

  {  Graph normalized coordinates are used to display text.}
  
  WGTextNorm (pGrDesc, thdc, 'Lab Results      pv:=nrt study', 0.050, 0.075, TA_LEFT, TEXT_NORMAL);
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

function  AboutProc (hDlg: HWND; message: WORD; wParam: WORD; lParam: LONGINT):WORDBOOL;
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

function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):WORDBOOL;
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
