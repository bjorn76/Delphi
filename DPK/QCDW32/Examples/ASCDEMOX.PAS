{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ASCDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
    Special Features for this demo are:

    Data is read from an ASCII file and displayed as a grouped
        'deep' bar graph.

    The x-axis displays months instead of numeric values.

    A legend will be displayed at the top of the window


}


unit Ascdemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

var
  hInst: THANDLE;              {  global instance handle}
  hX1, hY1: HGLOBAL;          {  global memory handles to data}

const
  szAppName:PChar = 'ASCII File Input Demo';  {  Class Name used in call to CreateWindow.  }

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far;  forward; {  these functions must be FAR}
procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER ; yTop: INTEGER):BOOL; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Deep Bars',               {  Window title string }
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_BLACK,                   {  window background color}
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


{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure StartPage1 (pPageDesc: PPAGE_DEF);
begin
  {  Initialize graph}
  WGCreateGraph (pPageDesc,
    @DrawGraphP1G1,                    {  points to function which builds graph}
    0.002, 0.002,                      {  window relative position inside parent page window}
    0.998, 0.998,
    C_BLACK,                           {  black background}
    C_WHITE,                           {  white border}
    1);                                {  border width in pixels}
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY,                      {  axes handles}
    hGroupB,		                 {  group data handle}
    hRGB: HGLOBAL;    		         {  global handle for RGB Colors}
    lpRgbColor: array[0..10] of TCOLORREF;    {  pointer for RGB Colors}
    lpcolor, lphatch: array[0..10] of INTEGER;
    hDataSet: HDATA;                   {  data set handle}
    numgroup, i: INTEGER;
    hStr1: HGLOBAL;  		         {  global memory handle for legend strings}
    lpstr1: PCHAR;		         {  pointer for legend strings}
    numpoints: LONGINT;
begin
  {  load the ascii file and define the group data set}
  hDataSet := WGLoadASCIIDataSet ('support.asc', 'Deep Group Dataset');
  {  determine the number of groups in the data set}
  WGGetDataSetArrays (hDataSet, hX1, hY1, numpoints, numgroup);

  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.12, 0.15, 0.95, 0.85, C_BLACK);
  
  {  scale the ploting area from x := 0 to 12.9 and y - 0 to 125}
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 12.9, 125.0);

  {  set the intercepts to 0,0}
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  y-axis to be drawn as solid white lines, 1 pixel thick.}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_WHITE);
  
  {  draw the y axis with major ticks every physical coord,}
  {  with 3 minor tics in between  }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 3, POS_LEFT);

  {  X-axis to be drawn in solid, white, 2 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_WHITE);

  {  draw the x axis with major ticks every 1 physical unit}
  {  and no minor ticks between major ticks}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 0, POS_BELOW);
  
  {  set current font to Times, 12 points, bold}
  WGSetTextByName (C_WHITE, 'Times New Roman', 12, TEXT_BOLD);

  {  Label the x-axis using names of the months}
  {  display labels below the axis}
  WGLabelAxisMonth (pGrDesc, thdc, hAxisX, POS_BELOW, 1, 1, TRUE);

  {  label the y- axis with numeric values, displayed to the left of the axis}
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, '');
  
  {  assign each bar an RGB value}
  for i := 0 to  numgroup - 1 do begin
    lpRgbColor[i] := WGGetRGBColor ((i mod 15) + 1);
    lpcolor[i] := 15;
    lphatch[i] := -1;
  end;
  {  display the horizontal group bar graph, center the bars}
  hGroupB := WGGroupBargraph (pGrDesc, thdc, hDataSet, 0.45, POS_MIDDLE, 
    LT_VBAR, GT_DEEPBARS, @lpRgbColor, @lphatch, @lpcolor);
  
  {  Write X axis title, and Graph Title}
  {  set current font to 10 poINTEGER Times}
  WGSetTextByName (C_WHITE, 'Times New Roman', 10, 0);
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Month');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, '# of Programmers');
  {  set current font to Times New Roman, 13 points, bold}
  WGSetTextByName (C_LIGHTGREEN, 'Times New Roman', 13, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Tech Support Summary');
  
  {  set current font to Times New Roman, 10 points, italic}
  WGSetTextByName (C_WHITE, 'Times New Roman', 10, TEXT_ITAL);

  {  allocate the legend array}
  hStr1 := GlobalAlloc (LHND, numgroup * LG_MAXLEN);
  lpstr1 := GlobalLock (hStr1);
  
  lstrcpy (lpstr1, 'C');
  lstrcpy (lpstr1 + LG_MAXLEN, 'C++');
  lstrcpy (lpstr1 + 2 * LG_MAXLEN, 'Pascal');
  lstrcpy (lpstr1 + 3 * LG_MAXLEN, 'Basic');
  lstrcpy (lpstr1 + 4 * LG_MAXLEN, 'Fortran');

  {  draw a transparent horizontal group legend,}
  {  outline the window in red and output the text in white}
  WGAutoLegendGroup (pGrDesc, thdc, 0.78, 0.06, C_RED, 2, C_WHITE, - 1,
    OR_VERT, hStr1, hGroupB);
  GlobalFree (hStr1);
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
