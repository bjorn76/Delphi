{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FLODEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 

    Special Features for this demo are:

    - floating bar graphs

    - y axis labels are displayed using strings


 }

unit Flodemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}


const
 NUMP1 = 11;                    {  number of data points for graph 1}
 szAppName: PCHAR = 'FloDemo';  {  Class Name used in call to CreateWindow.  }

var
    hX1, hY1: HGLOBAL;           {  global handles to data}
    hStr1,
    hGX1, hGY1: HGLOBAL;


{  Prototypes of forward referenced functions}

{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Floating Bars',           {  Window title string }
            @StartPage1,               {  name of graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_FULL,
            {  window initial size and position option}
            0, 0, 0, 0);
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var  lpProcAbout: TFarProc; {  pointer to the 'AboutProc' function  }
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
   functions WGCreateGraph that initializes individual graphs.
********************************************************************* }
const
   fInit:  BOOL = TRUE;


procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
     i: INTEGER;
     lpX1, lpY1:  LPREAL;
     lasterr: UINT;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }

  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  define data for first graph}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1 * 2);

    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);

    {  initialize data, set the first floating bar to zero, so that}
    {  it will not be displayed}
    WGPutPntrReal (lpX1, 0, 0);
    WGPutPntrReal (lpY1, 0, 0);
    WGPutPntrReal (lpY1, 1, 0);
    for i := 1 to  NUMP1 - 1 do begin
      WGPutPntrReal (lpX1, i, i);
      WGPutPntrReal (lpY1, i * 2, i + randreal);
      WGPutPntrReal (lpY1, i * 2 + 1, 3 + i + 2 * randreal);
    end;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  
  WGCreateGraph (pPageDesc, 
    @DrawP1G1,      {  points to function which builds graph}
    0.05, 0.05,     {  window realtive position inside parent page window}
    0.95, 0.95,
    C_WHITE,        {  white background}
    C_LIGHTRED,     {  light red border}
    3);             {  border width in pixels}
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure  DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;
    hDataSet1: HDATA;
    n: INTEGER;
    lpstr: PCHAR;
begin
  {  define the group data set }
  hDataSet1 := WGDefineGroupDataSet ('Project', hX1, hY1, NUMP1, 2);
  
  {  size the plotting area, leave plenty of room for the LONGINT }
  {  y-axis strings}
  WGSetPlotArea (pGrDesc, thdc, 0.35, 0.1, 0.95, 0.85, C_LIGHTGREEN);

  {  both axes will be linear}
  WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR);
  
  {  scale the plotting area from x^. 0 to 12 and y ^. 0 to 9.5}
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 12.0, 9.5);
  
  {  set the x and y intercepts to 0}
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  set the line style to solid black, 2 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
  
  {  set text parameters }
  WGSetTextParams (C_BLACK, FF_MODERN, 11, 0);
  
  {  draw a simple x axis}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 0, POS_BELOW);
  
  {  display the x axis in month format}
  WGLabelAxisMonth (pGrDesc, thdc, hAxisX, POS_BELOW, 0, 1, TRUE);
  
  {  draw a simple y axis}
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 1, 0, POS_LEFT);
  
  {  allocate an array for axis string labels.}
  n := 10;
  hStr1 := GlobalAlloc (GHND, n * LG_MAXLEN);
  lpstr := GlobalLock (hStr1);
  
  {  initialize the y axis string labels}
  lstrcpy (lpstr, '');
  lstrcpy (lpstr + LG_MAXLEN, 'Day Dreaming');
  lstrcpy (lpstr + 2 * LG_MAXLEN, 'R&D Feasibility Study');
  lstrcpy (lpstr + 3 * LG_MAXLEN, 'R&D Feasibility Report');
  lstrcpy (lpstr + 4 * LG_MAXLEN, 'Marketing Analysis');
  lstrcpy (lpstr + 5 * LG_MAXLEN, 'Engineering Analysis');
  lstrcpy (lpstr + 6 * LG_MAXLEN, 'Final R&D');
  lstrcpy (lpstr + 7 * LG_MAXLEN, 'Engineering Release');
  lstrcpy (lpstr + 8 * LG_MAXLEN, 'Final Marketing Plan');
  lstrcpy (lpstr + 9 * LG_MAXLEN, 'Product Introduction');
  
  {  label the y axis with some LONGINT strings}
  WGLabelAxisStrings (pGrDesc, thdc, hAxisY, POS_LEFT, 0, hStr1);
  
  {  title the x axis}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Month');
  
  {  display a floating bar graph, center the bars around the data point,}
  {  horizontal floating bars will be displayed}
  WGFloatingBars (pGrDesc, thdc, hDataSet1, 0.70, POS_MIDDLE, 
    LT_HBAR, RGB (128, 0, 128), - 1, C_YELLOW);
  
  {  change the font}
  {  set text parameters }
  WGSetTextParams (C_BLUE, FF_MODERN, 15, TEXT_BOLD);
  
  {  title the graph}
  WGTitleGraph (pGrDesc, thdc, 'Project Schedule');
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
