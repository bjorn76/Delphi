{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   MDIDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

unit Mdidemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure CreateMDIChild1(thwnd: HWND; tinst: THANDLE);
procedure CreateMDIChild2(thwnd: HWND; tinst: THANDLE);
procedure ResizeMDIChild2(w,h: INTEGER);
procedure ResizeMDIChild1(w,h: INTEGER);
procedure WM_DestroyGraph;

implementation

const
  NUMP1 =  80;                  { number of data points}
  NUMP2 =  30;
  szAppName: PCHAR= 'MDI Demo'; { Class Name used in call to CreateWindow.  }
  szFrame: PCHAR= 'Frame';      { Class name for 'frame' window}
  szChild: PCHAR= 'MDIChild';   { Class name for MDI windows}

  hwndFrame: THANDLE  = 0;      { Handle to MDI frame (main) window  }
  hwndMDIClient: THANDLE = 0;   { Handle to MDI client window }


{ ------------------------  global variables  ------------------------- }
var
  hX1, hY1,         {  global memory handles to data arrays}
  hX21, hY21, hX22, hY22, hX23, hY23: HGLOBAL;

  thwndChild1, thwndChild2 : HWND;

{ ---------------------  function prototypes  ----------------------- }
  pPageDesc1 : PPAGE_DEF;
  pPageDesc2 : PPAGE_DEF;


procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure StartPage2 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

function randreal:realtype; forward;

procedure ResizeMDIChild2(w,h: INTEGER);
VAR hwndPage: HWND;
begin
  hwndPage := WGGetPageWindow (pPageDesc2);
  SetWindowPos (hwndPage, NULLH, 0, 0,
                 w, h,
                 SWP_NOMOVE OR SWP_NOZORDER);
end;

procedure ResizeMDIChild1(w,h: INTEGER);
VAR hwndPage: HWND;
begin
  hwndPage := WGGetPageWindow (pPageDesc1);
  SetWindowPos (hwndPage, NULLH, 0, 0,
                 w, h,
                 SWP_NOMOVE OR SWP_NOZORDER);
end;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure CreateMDIChild1(thwnd: HWND; tinst: THANDLE);
begin
   pPageDesc1 := WGCreatePage ('PAGE1', {  page ID string}
          thwnd,                       {  handle to the parent window}
          tInst,                       {  application instance handle }
          'First Graph',               {  Window title string }
          @StartPage1,                 {  pointer to graph creation function}
          NULLS,                       {  Name of page window menu in resource file}
          C_LIGHTGRAY,                 {  window background color}
          MM_PROPORT,                  {  window sizing mode}
          WS_CHILD  or  WS_CLIPCHILDREN or  WS_VISIBLE, {  window style}
          PAGE_CLIENT,
          {  window initial size and position option}
          0, 0, 0, 0);
            {  save pointer to page descriptor in extra bytes}
   SetWindowLong (thwnd, 0, LONGINT (pPageDesc1));
   WGToggleSelectors(pPageDesc1, False);

end;

procedure CreateMDIChild2(thwnd: HWND; tinst: THANDLE);
begin
   pPageDesc2 :=
            WGCreatePage ('PAGE2',
            thwnd,
            tInst,
            ' PAGE 2',
            @StartPage2,
            NULLS,                     {  no menu}
            C_LIGHTGRAY,
            MM_FIXED,                  {  window sizing mode}
            WS_CHILD  or  WS_CLIPCHILDREN  or  WS_VISIBLE, {  window style}
            PAGE_FULL, {  window initial size and position option}
            0, 0, 0, 0);
              {  save pointer to page descriptor in extra bytes}
   SetWindowLong (thwnd, 0, LONGINT (pPageDesc2));
   WGToggleSelectors(pPageDesc2, False);

end;

procedure InitData;
var
    i: INTEGER;
    z: Realtype;
    lpX1, lpY1,
    lpX21, lpY21, lpX22, lpY22, lpX23, lpY23: LPReal;
begin

  {  create simulation data for plots}
  { -------------------------------------------------------------- }
  {  allocate global data arrays}
  hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
  hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);


  hX21 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
  hY21 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
  hX22 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
  hY22 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
  hX23 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
  hY23 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);

  {  get pointers to data arrays}
  lpX1 := GlobalLock (hX1);
  lpY1 := GlobalLock (hY1);
  lpX21 := GlobalLock (hX21);
  lpY21 := GlobalLock (hY21);
  lpX22 := GlobalLock (hX22);
  lpY22 := GlobalLock (hY22);
  lpX23 := GlobalLock (hX23);
  lpY23 := GlobalLock (hY23);

  {  create x and y data to be plotted}
  for i := 0 to  NUMP1 - 1 do begin
    z := i;
    WGPutPntrReal (lpX1, i, z);
    WGPutPntrReal (lpY1, i, 15.0 *
      cos (PI * z / (4.0 + 0.3 * randreal)) +
      3.0 * randreal);
  end;

  for i := 0 to  NUMP2 - 1 do
  begin
     WGPutPntrReal (lpX21, i, 1.0 + i);
     WGPutPntrReal (lpY21, i, 50.0 + 150.0 * (1.0 - exp (- i / 9.0)));
     WGPutPntrReal (lpX22, i, WGGetPntrReal (lpX21, i));
     WGPutPntrReal (lpY22, i, WGGetPntrReal (lpY21, i) + 80.0 * (randreal - 0.5));
     WGPutPntrReal (lpX23, i, WGGetPntrReal (lpX21, i));
     WGPutPntrReal (lpY23, i, WGGetPntrReal (lpY22, i) -
        WGGetPntrReal (lpY21, i));
  end;

end;




{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure StartPage1 (pPageDesc: PPAGE_DEF);
begin
  {  Initialize graph }

  WGCreateGraph (pPageDesc,
    @DrawP1G1,     {  points to function which builds graph}
    0.01, 0.01,      {  window relative position inside parent page window}
    0.99, 0.99,
    C_YELLOW,       {  white background}
    C_BLACK,           {  no  border}
    4);            {  border width in pixels}
end;

{ *********************************************************************
   Routine StartPage2 is called by the Quinn-Curtis
   Windows Charting Tools when page 2 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure StartPage2 (pPageDesc: PPAGE_DEF);
begin
  WGCreateGraph (pPageDesc, @DrawP2G1,
                0.01, 0.01, 0.99, 0.99,
                C_GREEN, - 1, 0);
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;     { axes handles}
    hDataSet: HDATA;
    hLabX, hLabY: HGOBJ; { data set handle}
begin
  {  define a dataset }
  hDataSet := WGDefineDataSet ('60 Cycle Noise', hX1, hY1, NUMP1);

  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.18, 0.15, 0.9, 0.8, C_LIGHTGRAY);

  {  axes to be drawn in solid, black, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

  {  set current font to Arial, 10 points, bold}
  WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

  {  analyze the data set and automatically scale the }
  {  plot area, draw and label the axes}
  WGAutoAxes (pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
    INTF_ZERO, hAxisX, hAxisY, hLabX, hLabY);

  {  set line style of actual plot to RED}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_RED);

  {  plot the data with spline interpolation on}
  WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, TRUE);

  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

  {  set current font to Arial, 16 points, bold, italic}
  WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD  or  TEXT_ITAL);

  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Input Waveform');
end;
{ ******************************************************
   Page 2 Graph 1 building procedure
******************************************************* }

procedure  DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
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
  WGSetPlotArea (pGrDesc, thdc, 0.12, 0.1, 0.9, 0.9, C_WHITE);
  WGScalePlotArea (pGrDesc, 0, -50.0, 32.0, 250.0);

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
  WGSetTextParams (C_BLACK, FF_SWISS, 6, TEXT_BOLD);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);

  WGSetTextParams (C_BLACK, FF_MODERN, 12, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Fusion Run XRK-823V');

  WGSetTextParams (C_BLACK, FF_MODERN, 10, TEXT_BOLD);
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Time - Nanoseconds');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Neutrons Detected');

  {  Allocate string array for legends}
  hStr1 := GlobalAlloc (GHND, 3 * LG_MAXLEN);
  lpstr := GlobalLock (hStr1);
  {  Initialize legends}
  WGSetTextParams (C_BLACK, FF_SWISS, 6, TEXT_BOLD);
  lstrcpy (lpstr, 'Measured Values');
  lstrcpy (lpstr + LG_MAXLEN, 'Predicted Values');
  lstrcpy (lpstr + 2 * LG_MAXLEN, 'Residuals');

  WGLegend (pGrDesc, thdc, 0.65, 0.43, 0.98, 0.68, C_BLACK, 3, - 1, C_WHITE,
    OR_VERT, hStr1);
  GlobalFree (hStr1);
end;

{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

{ ************************************************************************ }


begin
  InitData;

  pPageDesc1 :=  NIL;
  pPageDesc2 :=  NIL;

end.
