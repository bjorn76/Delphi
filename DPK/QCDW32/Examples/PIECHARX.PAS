{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIECHARX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{
	This demo displays two pie charts with 11 slices.


}


unit Piecharx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation
{$R demo}

const
 NUMP1 = 11;                     { number of data points for graph 1}
 szAppName: PCHAR = 'PieCharts'; { Class Name used in call to CreateWindow.  }

var
   hPieData, 	                 { global handles to data}
   hPieStr: HGLOBAL;             { global handles for legend strings}
   lpStr: PCHAR;
   pPgDesc1, pPgDesc2: PPAGE_DEF;

{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}
procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure StartPage2 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          pPgDesc1 := WGCreatePage ('PAGE1', {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Expenses - 3D Pie Chart', {  Window title string}
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_BROWN,                   {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_FULL,                 {  window initial size and position option}
            0, 0, 0, 0);               {  initial window size and position}

          pPgDesc2 := WGCreatePage ('PAGE2', {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'Expenses - 2D Pie Chart', {  Window title string}
            @StartPage2,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,                   {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_CLIENT,               {  window initial size and position option}
            0, 0, 0, 0);
          {  disable graph selector buttons}
          if pPgDesc1 <> nil then
            WGToggleSelectors (pPgDesc1, FALSE);
          if pPgDesc2 <> nil then
            WGToggleSelectors (pPgDesc2, FALSE);
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      GlobalFree (hPieStr);
      GlobalFree (hPieData);
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


procedure  StartPage1 (pPageDesc: PPAGE_DEF);
var
    lpPie: LPReal;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data array}
    hPieData := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointer to data array}
    lpPie := GlobalLock (hPieData);

    {  allocate global string array}
    hPieStr := GlobalAlloc (GHND, NUMP1 * LG_MAXLEN);
    lpStr := GlobalLock (hPieStr);

    {  Generate some data, starting at zeroth element }
    WGPutPntrReal (lpPie, 0, 1550.0);
    WGPutPntrReal (lpPie, 1, 775.0);
    WGPutPntrReal (lpPie, 2, 350.0);
    WGPutPntrReal (lpPie, 3, 300.0);
    WGPutPntrReal (lpPie, 4, 250.0);
    WGPutPntrReal (lpPie, 5, 200.0);
    WGPutPntrReal (lpPie, 6, 220.0);
    WGPutPntrReal (lpPie, 7, 240.0);
    WGPutPntrReal (lpPie, 8, 167.0);
    WGPutPntrReal (lpPie, 9, 250.0);
    WGPutPntrReal (lpPie, 10, 750.0);
    
    {  assign strings for legend key}
    lstrcpy (lpStr, 'Tax');
    lstrcpy (lpStr + LG_MAXLEN, 'Mortgage');
    lstrcpy (lpStr + 2 * LG_MAXLEN, 'Prop Tax');
    lstrcpy (lpStr + 3 * LG_MAXLEN, 'Household');
    lstrcpy (lpStr + 4 * LG_MAXLEN, 'Auto Ins');
    lstrcpy (lpStr + 5 * LG_MAXLEN, 'Retirement');
    lstrcpy (lpStr + 6 * LG_MAXLEN, 'Clothing');
    lstrcpy (lpStr + 7 * LG_MAXLEN, 'Medical');
    lstrcpy (lpStr + 8 * LG_MAXLEN, 'Utilities');
    lstrcpy (lpStr + 9 * LG_MAXLEN, 'Food');
    lstrcpy (lpStr + 10 * LG_MAXLEN, 'Other');
    
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }

  WGCreateGraph (pPageDesc,
    @DrawP1G1,     {  points to function which builds graph}
    0.05, 0.05,    {  window relative position inside parent page window}
    0.95, 0.95,
    C_WHITE,       {  white background}
    C_MAGENTA,     {  magenta border}
    2);            {  border width in pixels}
end;
{ ************************************************************************ }
procedure  StartPage2 (pPageDesc: PPAGE_DEF);
begin
  {  Initialize graph }

  WGCreateGraph (pPageDesc,
    @DrawP2G1,     {  function which builds graph}
    0.05, 0.05,    {  window relative position inside parent page window}
    0.95, 0.95,
    C_WHITE,       {  white background}
    C_GREEN,       {  green border}
    2);            {  border width in pixels}
end;

{ ******************************************************
   Builds a 3D pie chart
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    ExplodeRel: array[0..NUMP1-1] of Realtype;
    i: INTEGER;
    hPie: HGOBJ;
    PieColor: array[0..NUMP1-1] of TCOLORREF;
begin
  {  set the plotting area for the pie}
  WGSetPlotArea (pGrDesc, thdc, 0.05, 0.05, 0.95, 0.95, C_WHITE);
  
  for i := 0 to NUMP1 - 1 do
    ExplodeRel[i] := 0.0;              {  explosion coefficient}
  ExplodeRel[5] := 0.35;               {  explode this slice 35%}
  PieColor[0] := WGGetRGBColor (C_GREEN);
  PieColor[1] := WGGetRGBColor (C_LIGHTRED);
  PieColor[2] := WGGetRGBColor (C_LIGHTBLUE);
  PieColor[3] := WGGetRGBColor (C_LIGHTMAGENTA);
  PieColor[4] := RGB (192, 65, 0);
  PieColor[5] := WGGetRGBColor (C_BROWN);
  PieColor[6] := WGGetRGBColor (C_LIGHTGRAY);
  PieColor[7] := WGGetRGBColor (C_LIGHTGREEN);
  PieColor[8] := WGGetRGBColor (C_MAGENTA);
  PieColor[9] := RGB (255, 0, 108);
  PieColor[10] := WGGetRGBColor (C_RED);
  
  {  set current font to Modern, 11 points, bold}
  WGSetTextParams (C_BLACK, FF_MODERN, 11, TEXT_BOLD);
  
  {  Display a pie chart.  A 3D pie will be drawn,}
  hPie := WGPieChart (pGrDesc, thdc, hPieData, NUMP1, PIE_3D, PIE_NUM_PERC, 
    PIE_OUT, 0.45, 0.6, 0.4, @PieColor, NULLP, NULLP, @ExplodeRel);
  
  {  Initialize legend strings}
  WGAutoLegendGroup (pGrDesc, thdc, 0.05, 0.05, C_RED, 1, - 1,
    - 1, OR_VERT, hPieStr, hPie);
  WGTitleGraph (pGrDesc, thdc, 'Monthly Expenses');
end;

{ ******************************************************
   Builds a 2D pie chart
******************************************************* }

procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    ExplodeRel: array[0..NUMP1-1] of Realtype;
    i: INTEGER;
    hPie: HGOBJ;
    PieColor: array[0..NUMP1-1] of TCOLORREF;
begin
  {  set the plotting area for the pie}
  WGSetPlotArea (pGrDesc, thdc, 0.05, 0.05, 0.95, 0.95, C_WHITE);
  
  for i := 0 to  NUMP1 - 1 do begin
    ExplodeRel[i] := 0.0;              {  explosion coefficient}
  end;
  ExplodeRel[5] := 0.4;                {  explode this slice 40%}
  
  PieColor[0] := WGGetRGBColor (C_LIGHTBLUE);
  PieColor[1] := WGGetRGBColor (C_LIGHTRED);
  PieColor[2] := WGGetRGBColor (C_YELLOW);
  PieColor[3] := WGGetRGBColor (C_LIGHTMAGENTA);
  PieColor[4] := RGB (192, 65, 0);
  PieColor[5] := WGGetRGBColor (C_RED);
  PieColor[6] := WGGetRGBColor (C_BROWN);
  PieColor[7] := WGGetRGBColor (C_LIGHTGREEN);
  PieColor[8] := WGGetRGBColor (C_MAGENTA);
  PieColor[9] := RGB (255, 0, 108);
  PieColor[10] := WGGetRGBColor (C_GRAY);
  
  {  set current font to Modern, 9 points}
  WGSetTextParams (C_BLUE, FF_MODERN, 9, 0);

  {  Display a pie chart of the data set.  A 2-D pie will be drawn,}
  {  the percentages}
  hPie := WGPieChart (pGrDesc, thdc, hPieData, NUMP1, PIE_2D, PIE_NUM_PERC, 
    PIE_OUT, 0.75, 0.6, 0.5, @PieColor, NULLP, NULLP, @ExplodeRel);
  
  {  Label pie slices}
  WGLabelPie (pGrDesc, hPie, hPieStr);
  WGTitleGraph (pGrDesc, thdc, 'Monthly Expenses');
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
{ *********************************************************************** }
begin

end.
