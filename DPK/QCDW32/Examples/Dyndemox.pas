{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DYNDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

unit Dyndemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;
 
implementation
{$R demo}

const
 NUMP1= 50;                  {  number of data points}
 RXMAX=  21.0;
 RYMAX=  20.0;


  szAppName: PCHAR = 'DynDemo';  {  Class Name used in call to CreateWindow.  }

var
  hX1, hY1,                      {  global memory handles to data}
  hPlot,                         {  line plot object handle}
  hBitmap: THANDLE;              {  bitmap object handle}
  pDynGrDesc: PGRAPH_DEF;
hDataSet: HDATA;        	 {  data set handle}

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      WGCreatePage ('PAGE1',           {  page ID string}
        thwnd,                         {  handle to the parent window}
        tInst,                         {  application instance handle }
        'Dynamic Graph',               {  Window title string }
        @StartGraphs1,                 {  pointer to graph creation function}
        'PageMenu',                    {  Name of page window menu in resource file}
        C_LIGHTGRAY,                   {  window background color}
        MM_PROPORT,                    {  window sizing mode}
        0,                             {  window style - default}
        PAGE_CLIENT,
        {  window initial size and position option}
        0, 0, 0, 0);                   {  initial window size and position}
   END;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
BEGIN
  DialogBox (tinst,            {  current instance   }
        'AboutBox',                {  resource to use       }
        thwnd,                     {  parent window handle  }
       @AboutProc);             {  AboutProc() instance address  }
END;

procedure WM_DestroyGraph;
begin
  WGCleanup (TRUE);                {  clean up charting tools memory}
  PostQuitMessage (0);
end;



{ *********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const
    fInit:  WORDBOOL = TRUE;

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
var
    i: INTEGER;
    z: Realtype;
    lpX1, lpY1: LPReal;

begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    {  create initial x and y data to be plotted}
    
    for i := 0 to  NUMP1 - 1 do begin
      z := i / RXMAX;
      WGPutPntrReal (lpX1, i, z);
      WGPutPntrReal (lpY1, i, RYMAX / 3.0 * (2.0 + cos (z) - sin (z * 2) +
        random (32767) / 10000.0));
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  
  pDynGrDesc := WGCreateGraph (pPageDesc,
    @DrawP1G1,          {  points to function which builds graph}
    0.005, 0.005,       {  window relative position inside parent page window}
    0.99, 0.99,
    C_WHITE,            {  white background}
    C_RED,              {  red   border}
    1);                 {  border width in pixels}
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var  hAxisX, hAxisY: HGOBJ;  {  axes handles}
begin
  {  define a dataset }
  hDataSet := WGDefineDataSet ('Live Data Set', hX1, hY1, NUMP1);
  
  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.1, 0.9, 0.80, C_BROWN);
  
  {  axes to be drawn in solid, black, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 19.0, 80.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  WGSetTextParams (C_BLACK, FF_SWISS, 10, 0);
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
  
  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 2, 9, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 20, 4, POS_LEFT);
  WGSetTextParams (C_BLACK, FF_MODERN, 10, 0);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  {  set line style of actual plot to BLUE}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_BLUE);

  {  plot the data and save plot handle}
  hPlot := WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);
  if hPlot = NULLH then
    exit ;

  {  display bitmap and save its handle}
  hBitmap := WGBitmapNorm (pGrDesc, thdc, 0.1, 0.1, 0.15, 0.18, 
    BM_STRETCH, 'face');
  
  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');
  
  {  set current font to Arial, 16 points, bold, italic}
  WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD  or  TEXT_ITAL);

  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Dynamic Plot');
end;
{ *************************************************************************
    FUNCTION: AboutProc

    PURPOSE:  Processes messages for 'About' dialog box

*************************************************************************** }
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

{ *********************************************************** }
{  This function is called every two seconds by the timer     }
{ *********************************************************** }
const count: INTEGER = 0;
PROCEDURE  TimerRoutine;
var
    hX, hY: HGLOBAL;
    lpX, lpY: LPREAL;
    z, ampl,
    rX1, rX2, rY1, rY2: Realtype;
    i: INTEGER;
    nump: INTEGER;
begin
IF ( NOT WGIsGraphDescValid (pDynGrDesc)) THEN
	exit;

  WGStart;
  INC (count, 1);
  if count > 600 then
    count := 1;
  {  display dIfferent number of points every time}
  nump := 10 + (count * NUMP1) mod 400;
  {  destroy original data set and data arrays}
  WGFreeDataSet (hDataSet, TRUE);
  
  {  create arrays for new data set}
  hX := GlobalAlloc (GHND, sizeof (realtype) * nump);
  hY := GlobalAlloc (GHND, sizeof (realtype) * nump);
  lpX := GlobalLock (hX);
  lpY := GlobalLock (hY);

  {  define a new dataset}
  hDataSet := WGDefineDataSet ('Live Data Set', hX, hY, nump);
  
  ampl := (RYMAX + count / 4.0) / 3.0;
  {  simulate new data}
  for i := 0 to nump - 1 do 
  begin
    z := i / RXMAX;
    WGPutPntrReal (lpX, i, z);
    WGPutPntrReal (lpY, i, ampl * (2.0 + cos (z + count) -
      sin ((z + count) * 2) + random (32767) / 10000.0));
  end;
  {  connect new data set to the plot object}
  WGReconnectDataSet (pDynGrDesc, hPlot, hDataSet);
  {  now redraw the line plot}
  WGRedrawObject (pDynGrDesc, hPlot, TRUE);
  {  get bitmap coordinates}
  WGGetObjectCoordNorm (pDynGrDesc, hBitmap, rX1, rY1, rX2, rY2);
  if rX1 > 0.55 then
  begin
    rX1 := 0.1;
    rY1 := 0.1;
    rX2 := 0.15;
    rY2 := 0.18;
  end;
  {  change bitmap size and position and redraw it immediately.}
  WGChangeObjectCoordNorm (pDynGrDesc, hBitmap, 
    rX1 + 0.022, rY1 + 0.02, rX2 + 0.03, rY2 + 0.03, TRUE);
end;
{ ************************************************************************ }

begin
end.
