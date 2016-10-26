{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AXSCALEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{
   Menu items have been added to the graph window which allow the user to
   change the mode of graph scaling to

    	linear (x linear, y linear),
	logarithmic (x log, y log),
        or semi log (x linear, ylog)

   A modified hook file, hook_11.pas is necessary to correctly process these THEN
   menu items. The function, ChangeAxesScale, found in hook_11.pas changes
   the scaling based on the menu item selected.


 }

unit Axscalex;

interface
uses WinTypes, WinProcs, messages,qcwin, hook_11;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_Help(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R Axscaler}
{$I demodefs.inc}

var
  hInst: THANDLE;              {  global instance handle}
  hX1, hY1: HGLOBAL;                     {  global memory handles to data}
  hAxisX, hAxisY: HGOBJ;        {  global handles to x and y axes.  These}
            			        {  are needed for processesing the}
                               {  menu selections, linear, log, semi-log}
const
  szAppName:PChar = 'AxScale Demo';  {  Class Name used in call to CreateWindow.  }

  NUMP1= 500;              {  number of data points}



{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF);  far; forward; {  these functions must be FAR}
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Linear/Log',              {  Window title string }
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_CLIENT,
            {  window initial size and position option}
            0, 0, 0, 0);
  END;

procedure MM_Help(thwnd: HWND; tinst: THANDLE);
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
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const
   fInit: BOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z,rr: realtype;
   lpX1, lpY1: LPReal;
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
    {  create x and y data to be plotted}
    for i := 0 to  NUMP1 - 1 do begin
      z := i;
      WGPutPntrReal (lpX1, i, z + 1.0);
      rr := randreal;
      WGPutPntrReal (lpY1, i, 1000 + (2.0 - randreal / 2.0) * 1000 * cos (rr / 2.0) * randreal);
    end;
    fInit := FALSE;
  end;

  { -------------------------------------------------------------- }

  {  Initialize graph }
  WGCreateGraph (pPageDesc, 
    @DrawGraphP1G1,
    {  points to function which builds graph}
    0.05, 0.05,
    {  window relative position inside parent page window}
    0.95, 0.95,
    C_WHITE,                           {  white background}
    C_GREEN,                           {  green border}
    4);                                {  border width in pixels}
end;

{ ************************************************************************ }
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var hDataLine: HDATA;
    hLabelX, hLabelY: HGOBJ;
begin
  {  define a dataset}
  hDataLine := WGDefineDataSet ('LinePlotData', hX1, hY1, NUMP1);
  
  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_WHITE);
  
  {  set the x axis to log, and the y axis to linear (semi-log axes) }
  WGSetAxesScale (pGrDesc, ST_LOG, ST_LINEAR);

  {  set current font to Arial, 10 points, bold}
  WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

  {  Analyze the data set and automatically scales the plotting area,}
  {  selects the intercepts, draws and labels the axes.}
  WGAutoAxes (pGrDesc, thdc, hDataLine, AS_ROUNDCLOSE, INTF_MIN, 
    hAxisX, hAxisY, hLabelX, hLabelY);
  SaveAxesHandles(hAxisX, hAxisY);

  {  set line style of error bar to LIGHT BLUE, width 0}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_LIGHTBLUE);
  
  {  display a line plot without curve fill, and with spline interpolation}
  WGLinePlot (pGrDesc, thdc, hDataLine, FALSE, TRUE);
end;

{ ********************************************************************* }


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

{ ************************************************************************
 Loads and displays a Windows bitmap defined in resource file
************************************************************************* }
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL;
var
    thdcMem: HDC;
    bm:TBITMAP;
    thbitmap: HBITMAP;
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
