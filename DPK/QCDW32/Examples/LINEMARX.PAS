{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   LINEMARX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
   This demo displays the results in the form of a line marker plot
   and a line plot with spline interpolation.
   A single graph in a single page is created.
   The page does not contain a menu bar.

   X and Y axes are displayed on all sides of the plotting area.


 }

unit Linemarx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_Help(thwnd: HWND; tinst: THANDLE);


implementation

{$R demo}

const
   NUMP1= 25;                        { number of data points}
  szAppName: PCHAR= 'Line Mark Demo';  {  Class Name used in call to CreateWindow.  }

var
    hX1, hY1: HGLOBAL;      {  global handles to data}
    hInst: THANDLE;              {  global instance handle}
    lpProcAbout: TFARPROC; {  pointer to the 'AboutProc' function  }

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}
procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      WGCreatePage ('LM',              {  page ID string}
        thwnd,                         {  handle to the parent window}
        tInst,                         {  application instance handle }
        'Lines and Markers',           {  Window title string }
        @StartPage1,                   {  creation function}
        NULLS,                         {  do not display the page menu bar}
        C_BLUE,                        {  window background color}
        MM_PROPORT,                    {  window sizing mode}
        0,                             {  window style - default}
        PAGE_CLIENT,
        {  window initial size and position option}
        0, 0, 0, 0);                   {  initial window size and position}
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure MM_Help(thwnd: HWND; tinst: THANDLE);
BEGIN
  lpProcAbout := MakeProcInstance (@AboutProc, hInst);
  DialogBox (tinst,            {  current instance   }
        'AboutBox',                {  resource to use       }
        thwnd,                     {  parent window handle  }
       lpProcAbout);             {  AboutProc() instance address  }
  FreeProcInstance (lpProcAbout);

END;

{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const
   fInit:  BOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z: realtype;
   lpX1, lpY1: LPREAL;
begin
  {  create simulation data for plots}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays, independent variable is the same for both data sets. }
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  allocate dependent error bar array}
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    {  create x an y data to be plotted}
    for i := 0 to  NUMP1 - 1 do begin
      z := i;
      WGPutPntrReal (lpX1, i, z + 1.0);
      WGPutPntrReal (lpY1, i, 20.0 + z * 1000.0 * randreal);
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  WGCreateGraph (pPageDesc, 
    @DrawP1G1,         {  points to function which builds graph}
    0.05, 0.05,        {  window relative position inside parent page window}
    0.95, 0.95,
    C_WHITE,           {  white background}
    C_GREEN,           {  green border}
    4);                {  border width in pixels}
  
end;
{ ************************************************************************* }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisXbottom, hAxisXtop, hAxisYleft, hAxisYright: HGOBJ; {  axes handles}
    hDataLine: HDATA;
    hTextX, hTextY: HGOBJ;  {  data set handle}
begin
  {  define a dataset}
  hDataLine := WGDefineDataSet ('LinePlotData', hX1, hY1, NUMP1);

  WGMarkDataPoint(hDataLine, 5, True);
  WGMarkDataPoint(hDataLine, 7, True);
  WGMarkDataPoint(hDataLine, 20, True);


  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_GRAY);
  
  {  scale the plotting area, x ranges from 0 to 25, y ranges from 0 to 25000}
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 25.0, 25000.0);
  
  {  set the intercepts to 0,0}
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

  {  set line style of axes to solid, RED}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_RED);
  
  {  draw the x axis, major ticks every 5 units, with 4 minor ticks between each interval}
  hAxisXbottom := WGDrawXAxis (pGrDesc, thdc, 5.0, 4, POS_BELOW);
  
  {  draw the y axis, major ticks every 5000 units, with no minor ticks}
  hAxisYleft := WGDrawYAxis (pGrDesc, thdc, 5000.0, 0, POS_LEFT);
  
  {  set line style to dotted, MAGENTA, }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_MAGENTA);
  
  {  draw a y axis grid on the major tick intervals.}
  WGDrawGrid (pGrDesc, hAxisYleft, GRID_MAJOR);
  
  {  set current font family to Swiss, 10 points, bold}
  WGSetTextParams (C_RED, FF_SWISS, 10, TEXT_BOLD);
  
  {  label the x axis}
  WGLabelAxis (pGrDesc, thdc, hAxisXbottom, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULLS);
  
  {  label the y axis, display the axis labels in scientIFic notation}
  WGLabelAxis (pGrDesc, thdc, hAxisYleft, POS_LEFT, NF_SCIENTIFIC, 1, LL_ON, NULLS);
  
  {  set line style of error bar to solid, LIGHT BLUE, width - 2}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_LIGHTBLUE);
  
  {  display a line plot without curve fill, and with spline interpolation}
  WGLinePlot (pGrDesc, thdc, hDataLine, FALSE, TRUE);
  {  set line style of line marker plot to solid, LIGHT GREEN, width - 2}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_LIGHTGREEN);
  
  WGLineMarkerPlot (pGrDesc, thdc, 
    hDataLine, MK_DIAMOND, C_LIGHTRED, 5, MKS_FILLED);

  {  Write axes titles}
  hTextX := WGTitleAxis (pGrDesc, thdc, hAxisYleft, POS_LEFT, 'Volts');
  hTextY := WGTitleAxis (pGrDesc, thdc, hAxisXbottom, POS_BELOW, 'Sample Interval');
  
  {  set current font to Arial, 12 points, bold}
  WGSetTextByName (C_GREEN, 'Arial', 12, TEXT_BOLD);
  
  {  set line style of actual plot to RED}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_RED);
  
  {  Now the top and right axes are drawn}

  {  set the intercepts to 25, 25000}
  WGSetXYIntercepts (pGrDesc, 25.0, 25000.0);
  
  {  draw the x axis, the axis will be drawn from 0 to 25, as above. Since the y intercept}
  {  is now at 25000, the x axis will appear on the top of the plotting area.}
  hAxisXtop := WGDrawXAxis (pGrDesc, thdc, 5, 4, POS_ABOVE);
  
  {  draw the y axis, the range is from 0 to 25000.0, as above. }
  {  Since the x-intercept is now at 25, }
  {  the second y-axis will appear to the right of the plotting area.}
  hAxisYright := WGDrawYAxis (pGrDesc, thdc, 5000.0, 0, POS_RIGHT);

  {  label the x and y axis}
  {  return a handle to the text object.  This handle will be used}
  {  to change the color of the X and Y Axis Titles.}
  WGLabelAxis (pGrDesc, thdc, hAxisXtop, POS_ABOVE, NF_DECIMAL, 1, LL_ON, NULLS);
  {  this time the axis labels are in engineering notation}
  WGLabelAxis (pGrDesc, thdc, hAxisYright, POS_RIGHT, NF_ENG, - 1, LL_ON, NULLS);
  
  {  change the color of the object pointed to by the handle hTextX}
  WGChangeTextColor (pGrDesc, hTextX, C_LIGHTRED);
  
  {  change the color of the object pointed to by the handle hTextY}
  WGChangeTextColor (pGrDesc, hTextY, C_LIGHTRED);
end;

{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
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
    
    WM_COMMAND:
      if (wParam = IDOK)  or (wParam = IDCANCEL) then begin
        EndDialog (hDlg, 1);
        AboutProc := TRUE;
        exit;
      end;
  end;
  AboutProc := FALSE;
end;

{ ********************************************************************* }


begin

end.
