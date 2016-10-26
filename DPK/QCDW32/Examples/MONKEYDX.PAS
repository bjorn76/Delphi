{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   MONKEYDX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
    A single, simple graph is created in a graph window.

    Also, a bitmap is loaded and stacked in the plotting area.


 }

unit Monkeydx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1 = 8;                         { number of data points for graph 1}
 szAppName: PCHAR = 'Monkey Demo';  { Class Name used in call to CreateWindow.  }

var
    hX1, hY1,           {  global handles to data}
    hXStr: HGLOBAL;



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
            'Go Bananas',              {  Window title string}
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_WHITE,                   {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_CLIENT,               {  window initial size and position option}
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




{ ********************************************************************** }

procedure StartPage1 (pPageDesc: PPAGE_DEF);
begin
  {  create simulation data for plots}
  
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  WGCreateGraph (pPageDesc, 
    @DrawP1G1,        {  points to function which builds graph}
    0.01, 0.01,       {  window realtive position inside parent page window}
    0.99, 0.99,
    C_YELLOW,         {  white background}
    C_GREEN,          {  green border}
    1);               {  border width in pixels}
end;

{ ********************************************************************* }
procedure  DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   hAxisX, hAxisY: HGOBJ;
   i, j, v1: INTEGER;
   x1, y1, x2, y2: Realtype;
begin
  {  set the plotting area, using a white plotting background}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.2, 0.9, 0.80, C_WHITE);
  
  {  now scale the plotting area}
  WGScalePlotArea (pGrDesc, 1987.0, 0.0, 1992.5, 150.0);

  {  set the intercepts to x := 1986, and y = 0}
  WGSetXYIntercepts (pGrDesc, 1987, 0.0);
  
  {  use a solid black line for the axes}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

  {  select a font}
  WGSetTextByName (C_BLACK, 'Courier New', 10, 0);
  
  {  draw the x axis, at every physical coord, no minor tics }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 0, POS_BELOW);
  
  {  label the x axis}
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  {  draw the y axis, every 10 units, with 1 minor tic in between }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 20, 1, POS_LEFT);

  {  label the y axis}
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  {  display the axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Production Year');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, '100,000 s of Dollars');

  {  now we'll draw the bitmaps}
  x1 := 1987.75;
  x2 := 1988.25;
  
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 3, C_CYAN);

  for i := 0 to  4 do begin
    v1 := round (2.0 + 5.0 * randreal);
    y1 := 1.0;
    y2 := 20.0;
    for j := 0 to  v1 - 1 do begin
      WGBitmap (pGrDesc, thdc, hAxisX, hAxisY, x1, y2, x2, y1, 
        BM_STRETCH, 'monkey.bmp');
      y1 := y1 + 19.0;
      y2 := y2 + 19.0;
    end;
    x1 := x1 + 1.0;
    x2 := x2 + 1.0;
  end;
  WGSetTextByName (C_RED, 'Courier New', 16, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Banana Production');
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

{ ************************************************************************* }
begin

end.
