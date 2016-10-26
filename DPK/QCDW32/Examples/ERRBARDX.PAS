{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ERRBARDX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
   ERRBARD.PAS
   This demo displays the results in the form of error bars and area plot.
}

unit Errbardx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
  NUMP1 = 25;                   {  number of data points}
  szAppName: PCHAR= 'ErrBars';  {  Class Name used in call to CreateWindow.  }

var
  hInst: THANDLE;                        {  global instance handle}
  hX1, hY1, hY2: HGLOBAL;       {  global handles to data}

{  Prototypes of forward referenced functions}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      WGCreatePage ('PAGE1',           {  page ID string}
        thwnd,                         {  handle to the parent window}
        tInst,                         {  application instance handle }
        'Error Bars Demo',             {  Window title string }
        @StartPage1,                   {  pointer to graph creation function}
        'PageMenu',
        C_LIGHTRED,                    {  window background color}
        MM_PROPORT,                    {  window sizing mode}
        0,                             {  window style - default}
        PAGE_FULL,
        {  window initial size and position option}
        0, 0, 0, 0);                   {  initial window size and position}
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const  fInit:BOOL = TRUE;

procedure  StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z: realtype;
   lpX1, lpY1, lpY2: LPREAL;
begin
  {  create simulation data for plots}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays, independent variable is the same for both data sets. }
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  allocate dependent error bar array}
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1 * 2);
    {  allocate dependent line array}
    hY2 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    lpY2 := GlobalLock (hY2);
    {  create x and y data to be plotted}
    for i := 0 to  NUMP1 - 1 do begin
      z := (i);
      WGPutPntrReal (lpX1, i, z + 1.0);
      WGPutPntrReal (lpY2, i, 20.0 + z * 10.0 * randreal);
      WGPutPntrReal (lpY1, i * 2, WGGetPntrReal (lpY2, i) + 10.0 * randreal);
      WGPutPntrReal (lpY1, i * 2 + 1, WGGetPntrReal (lpY2, i) - 10.0 * randreal);
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }

  {  Initialize graph }
  WGCreateGraph (pPageDesc,
    @DrawGraphP1G1,       {  points to function which builds graph}
    0.05, 0.05,           {  window relative position inside parent page window}
    0.95, 0.95,
    C_WHITE,              {  white background}
    C_GREEN,              {  green border}
    4);                   {  border width in pixels}

end;

{ ************************************************************************* }
{  Displays an error bar plot and a line plot with filled area.}
{  Axes are manually scaled and labeled.}
{  A y-axis grid is drawn.}
{ ************************************************************************* }
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var    hAxisX, hAxisY: HGOBJ;          {  axes handles}
       hDataErrorB, hDataLine: HGOBJ;  {  data set handle}
begin
  {  define a group dataset }
  hDataErrorB := WGDefineGroupDataSet ('Error Bar Data', hX1, hY1, NUMP1, 2);
  
  {  define a one dimensional dataset}
  hDataLine := WGDefineDataSet ('LinePlotData', hX1, hY2, NUMP1);

  {  define the plotting area of the graph, set the background color}
  {  of the plotting area to blue}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.95, 0.85, C_BLUE);
  {  Scale the plotting area to x for 0 to 25, y for 0 to 250}
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 25.0, 250.0);
  
  {  set the intercepts to 0,0}
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  set line style for axes to a solid, red line}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_RED);
  
  {  draw the x axis, with major tick every 5 units of X,}
  {  and 4 minor ticks in each major interval}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 5.0, 4, POS_BELOW);
  
  {  draw the y axis, with major tick every 50 units of Y, and no minor ticks }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 50.0, 0, POS_LEFT);
  
  {  set line style of grids to dotted, minimal width, MAGENTA, }
  {  and display a y-axis grid on major ticks.}
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 0, C_MAGENTA);
  
  {  draw a y-axis grid at major tick marks}
  WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);
  
  {  set current font to Roman, 10 points, bold}
  WGSetTextParams (C_BLUE, FF_ROMAN, 10, TEXT_BOLD);
  
  {  label the x- and y- axis}
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULLS);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULLS);
  
  {  set line style of the line plot to solid, minimal width, black}
  WGSetLineStyle (pGrDesc, thdc, PS_DASH, 0, C_BLACK);

  {  display a line plot with area fill, and without spline interpolation}
  WGLinePlot (pGrDesc, thdc, hDataLine, TRUE, FALSE);
  
  {  set line style of error bars to solid, YELLOW, width := 1}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);
  
  {  plot the error bars with a length of 5 points}
  WGErrorBars (pGrDesc, thdc, hDataErrorB, 5);
  
  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'X Axis Title');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Y Axis Title');
  
  {  set current font to Roman, 12 points, bold}
  WGSetTextParams (C_GREEN, FF_ROMAN, 12, TEXT_BOLD);
  
  {  output a tilted (45 degrees) message at x := 12.5, y = 125.0}
  WGText (pGrDesc, thdc, hAxisX, hAxisY, 'TEST', 12.5, 125.0, TA_CENTER, 450);
  
  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Graph Title');
  
  {  set current font family to SWISS, 10 points, italic}
  WGSetTextParams (C_GREEN, FF_SWISS, 10, TEXT_ITAL);

  { draw background rectangle }
  WGRectangleNormEx (pGrDesc, thdc, 0.33, 0.06, 0.67, 0.12,
        C_LIGHTGRAY, 2, TRUE, WGGetRGBColor (C_LIGHTGRAY), RC_3DBORDER);
  {  output a text string, underneath the graph title,}
  {  can be useful IF a second graph title is desired }
  WGTextNorm (pGrDesc, thdc, 'Data Collected 11/15/92', 0.5, 0.075, TA_CENTER, TEXT_NORMAL);
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
