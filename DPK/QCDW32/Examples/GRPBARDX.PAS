{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   GRPBARDX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{

    Special Features for this demo are:

    This demo will display a horizontal grouped bar graph.

    The y axis displays text strings instead of numeric values.

    A text string is displayed at the end of each bar.

    A legend will be displayed at the top of the window


 }


unit Grpbardx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation
{$R demo}


const
  NUMP1= 2;                     { number of data points}
  NUMGROUPS= 3;		        { group size}
  szAppName: PCHAR= 'Group Bar Demo';  {  Class Name used in call to CreateWindow.  }

var
  hInst: THANDLE;                {  global instance handle}
  hX1,hY1,
  hYAxStr: HGLOBAL;     {  global handle to string array}
  lpX1, lpY1: LPReal;

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}
procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL; forward;
function randreal:realtype; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle}
            'Group Bars',              {  Window title string }
            @StartPage1,               {  graph creation function}
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
      GlobalFree (hYAxStr);
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
   z: Realtype;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1 * NUMGROUPS);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    
    {  create x and y data to be plotted}
    for i := 0 to NUMP1 - 1 do
      WGPutPntrReal (lpY1, i, i);
    WGPutPntrReal (lpX1, 0, 5.9);
    WGPutPntrReal (lpX1, 1, 7.0);
    WGPutPntrReal (lpX1, 2, 10.0);
    WGPutPntrReal (lpX1, 3, 3);
    WGPutPntrReal (lpX1, 4, 3.6);
    WGPutPntrReal (lpX1, 5, 3.8);
    
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  
  WGCreateGraph (pPageDesc,
    @DrawP1G1,         {  points to function which builds graph}
    0.002, 0.002,      {  window relative position inside parent page window}
    0.998, 0.998,
    C_BLACK,           {  black background}
    C_WHITE,           {  white border}
    1);                {  border width in pixels}

end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;       {  axes handles}
    hDataSet: HDATA;             {  data set handle}
    hGroupB: HGOBJ;		        {  group data handle}
    RgbColor: array[0..NUMGROUPS-1] of TCOLORREF;  {  one color for each group}
    hStr1: HGLOBAL;            {  global memory handle to legends }
    lpstr1, lpYAxStr: PCHAR;

begin
  {  allocate global string array for legend}
  hStr1 := GlobalAlloc (GHND, NUMGROUPS * LG_MAXLEN);
  {  allocate global string array for y axis strings}
  hYAxStr := GlobalAlloc (GHND, NUMGROUPS * LG_MAXLEN);
  lpstr1 := GlobalLock (hStr1);
  lpYAxStr := GlobalLock (hYAxStr);

  {  Initialize legend strings}
  lstrcpy (lpstr1, 'Wound Balata');
  lstrcpy (lpstr1 + LG_MAXLEN, 'Wound Surlyn');
  lstrcpy (lpstr1 + 2 * LG_MAXLEN, 'Two Piece Surlyn');
  
  {  Initialize y axis strings}
  lstrcpy (lpYAxStr, '');
  lstrcpy (lpYAxStr + LG_MAXLEN, '8-Iron');
  lstrcpy (lpYAxStr + 2 * LG_MAXLEN, 'Driver');
  
  {  define a dataset }
  hDataSet := WGDefineGroupDataSet ('Group', hY1, hX1, NUMP1, NUMGROUPS);
  
  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.05, 0.15, 0.95, 0.8, C_BLACK);

  {  scale theplot area from x 0 to 11 and y -0.5 to 2.0}
  WGScalePlotArea (pGrDesc, 0.0, - 0.5, 11.0, 2.0);

  {  set the intercepts to 0, -0.5}
  WGSetXYIntercepts (pGrDesc, 0.0, - 0.5);
  
  {  Y-axis to be drawn as a solid line, black (background color), 1 pixels thick.}
  {  The y-axis will not be visible, however, the y axis labels will.}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  {  draw the y axis with major ticks at every whole number, with no minor tics }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 1, 0, POS_LEFT);
  
  {  X axis to be drawn in solid, white, 2 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_WHITE);
  
  {  draw the x axis with major ticks every 2 physical units and no minor tick between each major tick}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 2, 0, POS_ABOVE);
  
  {  set current font to Roman family, 12 points, bold}
  WGSetTextParams (C_WHITE, FF_ROMAN, 12, TEXT_BOLD);
  
  {  Label the x-axis, display labels below the axis, in decimal format,}
  {  1 digit after the decimal point.  The last label is displayed}
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULLS);
  
  {  label the y axis with strings, place these strings }
  {  to the right of the axis}
  WGLabelAxisStrings (pGrDesc, thdc, hAxisY, POS_RIGHT, LL_ON, hYAxStr);

  {  assign each bar an RGB value}
  RgbColor[0] := WGGetRGBColor (C_GREEN);
  RgbColor[1] := WGGetRGBColor (C_MAGENTA);
  RgbColor[2] := WGGetRGBColor (C_LIGHTBLUE);
  
  {  display the horizontal group bar graph, center the bars}
  hGroupB := WGGroupBargraph (pGrDesc, thdc, hDataSet, 0.2, POS_MIDDLE,
    LT_HBAR, GT_GROUPBARS, @RgbColor, NULLP, NULLP);
  
  {  Write X axis title, and Graph Title}
  {  set current font to 10 point }
  WGSetTextParams (C_WHITE, FF_ROMAN, 11, TEXT_NORMAL);
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Thousands of revolutions per minute');

  {  set current font to 14 point }
  WGSetTextParams (C_YELLOW, FF_ROMAN, 14, TEXT_NORMAL);
  WGTitleGraph (pGrDesc, thdc, 'Spin Rate Comparison');
  
  {  now display some text at the end of each bar}
  WGSetTextParams (C_WHITE, FF_MODERN, 10, TEXT_BOLD);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '60%', 
    WGGetPntrReal (lpX1, 0) + 0.025 * WGGetPntrReal (lpX1, 0), 
    WGGetPntrReal (lpY1, 0) - 0.12, TA_LEFT, TEXT_NORMAL);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '70%',
    WGGetPntrReal (lpX1, 1) + 0.025 * WGGetPntrReal (lpX1, 1),
    WGGetPntrReal (lpY1, 0) + 0.1, TA_LEFT, TEXT_NORMAL);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '100%', 
    WGGetPntrReal (lpX1, 2) + 0.025 * WGGetPntrReal (lpX1, 2), 
    WGGetPntrReal (lpY1, 0) + 0.3, TA_LEFT, TEXT_NORMAL);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '80%',
    WGGetPntrReal (lpX1, 3) + 0.025 * WGGetPntrReal (lpX1, 3), 
    WGGetPntrReal (lpY1, 1) - 0.12, TA_LEFT, TEXT_NORMAL);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '90%', 
    WGGetPntrReal (lpX1, 4) + 0.025 * WGGetPntrReal (lpX1, 4), 
    WGGetPntrReal (lpY1, 1) + 0.1, TA_LEFT, TEXT_NORMAL);
  WGText (pGrDesc, thdc, hAxisX, hAxisY, '100%', 
    WGGetPntrReal (lpX1, 5) + 0.025 * WGGetPntrReal (lpX1, 5), 
    WGGetPntrReal (lpY1, 1) + 0.3, TA_LEFT, TEXT_NORMAL);
  
  {  set current font to 8 points, italic}
  WGSetTextParams (C_WHITE, FF_ROMAN, 9, TEXT_ITAL);
  
  {  draw a transparent horizontal group legend,}
  {  outline the window in red and output the text in white}
  WGLegendGroup (pGrDesc, thdc, 0.15, 0.15, 0.85, 0.25, C_RED, 2, C_WHITE, - 1,
    OR_HORZ, hStr1, hGroupB);
  GlobalFree (hStr1);
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

{ ************************************************************************
 Loads and displays a Windows bitmap defined in resource file
************************************************************************* }
function DisplayBitmap (thdc: HDC; pName: PCHAR; xLeft: INTEGER; yTop: INTEGER):BOOL;
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

{ ********************************************************************* }
begin

end.
