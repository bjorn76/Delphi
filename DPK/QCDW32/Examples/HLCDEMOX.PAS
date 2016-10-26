{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   HLCDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
    Special Features for this demo are:

    Graph 1:
     a high-low-close graph is displayed
     a legend will be displayed at the top of the window

    Graph 2:
     a stacked line graph is displayed.
     the x axis displays days of week instead of numeric values.
     

 }

unit Hlcdemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
  NUMP1= 21;                  {  number of data points for graph 1}
  NUMP2= 5;                   {  number of data points for graph 2}
  NUMGROUP= 5;                {  number of groups}
  szAppName: PCHAR= 'High-Low-Close Demo';  {  Class Name used in call to CreateWindow.  }

var
    hX1, hY1, hY2,      {  global handles to data}
    hGX1, hGY1: HGLOBAL;

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'High-Low-Close',          {  Page Window title string }
            @StartPage1,               {  graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
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
    DialogBox (tinst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
end;


{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initializes individual graphs.
********************************************************************* }
const
   fInit:  BOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
    i,j: INTEGER;
    lpX1, lpY1, lpY2: LPREAL;
    lpGX1, lpGY1: LPREAL;
    z, sp: RealType;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  define data for first graph}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1 * 3);
    hY2 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    lpY2 := GlobalLock (hY2);
    
    {  initialize data}
    z := 0.0;
    for i := 0  to  NUMP1 - 1 do begin
      z := z + 1.0;
      if ((i + 1) mod 5) = 0 then  z := z + 2.0;
      WGPutPntrReal (lpX1, i, z);
      sp := 10 + i + 3 * randreal;
      WGPutPntrReal (lpY1, i * 3, sp + 1.0 + 3.0 * randreal);
      WGPutPntrReal (lpY1 , i * 3 + 1, sp - 1.0 - 3.0 * randreal);
      WGPutPntrReal (lpY1, i * 3 + 2, sp);
      z := z + 1.0;
      WGPutPntrReal (lpY2 , i, 10 + i + 3 * randreal);
    end;
    
    hGX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2);
    hGY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP2 * NUMGROUP);
    
    {  get pointers to data arrays}
    lpGX1 := GlobalLock (hGX1);
    lpGY1 := GlobalLock (hGY1);
    
    for i := 0 to  NUMP2 - 1 do
      for j := 0 to  NUMGROUP - 1 do begin
        WGPutPntrReal (lpGX1, j, j);
        WGPutPntrReal (lpGY1, i * NUMP2 + j, (randreal * 5.0 * (j + 1)) + randreal);
      end;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }

  WGCreateGraph (pPageDesc,
    @DrawP1G2,      {  points to function which builds graph}
    0.5, 0.5,       {  window realtive position inside parent page window}
    0.998, 0.998,
    C_WHITE,        {  white background}
    C_LIGHTRED,     {  light red border}
    3);             {  border width in pixels}

  WGCreateGraph (pPageDesc,
    @DrawP1G1,      {  points to function which builds graph}
    0.002, 0.002,   {  window realtive position inside parent page window}
    0.66, 0.66,
    C_WHITE,        {  white background}
    C_LIGHTCYAN,    {  light cyan border}
    3);             {  border width in pixels}
end;


{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY, hLabX, hLabY: HGOBJ;
    hDataSet1, hDataSet2: HDATA;
    hStr: HGLOBAL;
    lpstr: PCHAR;
begin
  {  define a group data set for High-Low-Close plot, group size := 3}
  hDataSet1 := WGDefineGroupDataSet ('Q-C Stock', hX1, hY1, NUMP1, 3);
  
  {  define a linear data set}
  hDataSet2 := WGDefineDataSet ('DOW Jones', hX1, hY2, NUMP1);

  {  set the plotting area, background color is light gray}
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.15, 0.9, 0.8, C_LIGHTGRAY);
  
  {  Set the line style to solid black}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  {  set the font to ARIAL}
  WGSetTextByName (C_BLUE, 'Arial', 10, 0);
  
  {  analyze the group data, scale the plotting area,}
  {  draw and label the x and y axes}
  WGAutoAxes (pGrDesc, thdc, hDataSet1, AS_ROUNDCLOSE, INTF_ZERO,
    hAxisX, hAxisY, hLabX, hLabY);
  
  {  draw an x axis grid on major ticks}
  WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);
  
  {  draw an y axis grid on major ticks}
  WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);
  
  {  change the line style to solid, green, 1 pixel thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_GREEN);

  {  display a line plot of data set 2}
  WGLinePlot (pGrDesc, thdc, hDataSet2, TRUE, FALSE);
  
  {  change the line style to solid, yellow, 1 pixel thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);
  
  {  create a high-low-close plot for the group data set.}
  {  A filled box represents the Close value}
  WGHighLowClose (pGrDesc, thdc, hDataSet1, MK_BOX, C_RED, 5, MKS_FILLED);
  
  {  change to bold text }
  WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);
  
  {  display the x axis title}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Trading by Day');
  
  {  display the y axis title}
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Stock Price');
  
  {  now set text to ARIAL, size 15, bold text}
  WGSetTextByName (C_BLUE, 'Arial', 15, TEXT_BOLD);
  
  {  display the window title}
  WGTitleGraph (pGrDesc, thdc, 'High-Low-Close Plot');
  
  {  now set text to ARIAL, size 8}
  WGSetTextByName (C_BLUE, 'Arial', 8, 0);
  
  {  create legend strings}
  hStr := GlobalAlloc (GHND, 2 * LG_MAXLEN);
  lpstr := GlobalLock (hStr);
  
  {  copy the legend strings}
  lstrcpy (lpstr, 'Dow Jones');
  lstrcpy (lpstr + LG_MAXLEN, 'Quinn-Curtis');
  
  WGLegend (pGrDesc, thdc, 0.15, 0.15, 0.4, 0.4, C_RED, 1, C_BLACK, 
    C_WHITE, OR_VERT, hStr);
  
  {  legend strings can be freed immediately.}
  GlobalFree (hStr);
end;

{ ************************************************************************* }

procedure  DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;
    hDataSet: HDATA;          {  data set handle}
    i: INTEGER;
    nLineColor: array[0..NUMGROUP-1] of INTEGER;
begin
  {  define a group data set}
  hDataSet := WGDefineGroupDataSet ('STACKED LINE', hGX1, hGY1, 
    NUMP2, NUMGROUP);
  
  {  set the plotting area}
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.15, 0.9, 0.8, C_LIGHTGRAY);

  {  scale the ploting area from x := 0 to 4 and y - 0 to 55}
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 4.0, 55.0);
  
  {  set the intercepts to 0,0}
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  axes to be drawn as a solid black line, 1 pixel thick.}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  {  draw the y axis with major ticks every 5th physical unit,}
  {  with no minor ticks in between  }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 1, POS_LEFT);
  
  {  draw the x axis with major ticks every 1 physical coords and 0 minor }
  {  tick between each major tick}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 0, POS_BELOW);
  
  {  assign each line color}
  for i := 0 to  NUMGROUP - 1 do
    nLineColor [i] := i + 1;
  
  {  display the stacked line graph, filling the adjacent area beteen the lines}
  WGStackedLines (pGrDesc, thdc, hDataSet, TRUE, NULLP, NULLP, @nLineColor);
  
  {  set the font to ARIAL, 10 points}
  WGSetTextByName (C_BLUE, 'Arial', 8, 0);
  
  {  label the y-axis, display labels in decimal format}
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULLP);
  
  {  label x axis from Mon to Fri}
  WGLabelAxisDayWk (pGrDesc, thdc, hAxisX, POS_BELOW, 0, 2, FALSE);
  
  {  now set text to ARIAL, size 12, bold text}
  WGSetTextByName (C_BLUE, 'Arial', 12, TEXT_BOLD);
  
  {  display the graph title}
  WGTitleGraph (pGrDesc, thdc, 'Sales');
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
