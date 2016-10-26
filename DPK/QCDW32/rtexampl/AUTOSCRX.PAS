{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AUTOSCRX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Autoscrx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;
{ Exports }
procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure MM_About (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;
procedure  TimerRoutine;

implementation
{$R rtdemo}
const
  ncount: INTEGER = 0;
  NT   =  8;
var
  thData: HDATA;	{ handle to dynamic data set }
  pDynGrDesc :PGRAPH_DEF; { pointer to graph descriptor }
  hTags: HGLOBAL;       { handle to tag names }

{ Forward Referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;


procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
  WGCreatePage ('PAGE1', { page ID string }
    thwnd,               { handle to the parent window }
    tInst,               { application instance handle }
    'AUTOSCROLL',         { Window title string }
    @StartGraphs1,       { pointer to graph creation function }
    'PageMenu',
    { Name of page window menu in resource file }
    C_LIGHTGRAY,         { window background color }
    MM_PROPORT,          { window sizing mode }
    0,                   { window style - default }
    PAGE_FULL,
    { window initial size and position option }
    0, 0, 780, 580);     { initial window size and position }
  { if used (not used here) }
end;

procedure WM_DestroyGraph;
begin
  WRCleanup (TRUE);      { clean up charting tools memory }
  PostQuitMessage (0);
end;

procedure MM_About (thwnd:HWND; tinst:THANDLE);

begin
  DialogBox (tInst,    {  current instance   }
    'AboutBox',        {  resource to use       }
    thwnd,             {  parent window handle  }
    @AboutProc);      {  AboutProc() instance address  }
end;

{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Real-Time Graphics Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
begin
  { Initialize graph }
  pDynGrDesc:= WGCreateGraph (pPageDesc,
    @DrawP1G1,
    { points to function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.995, 0.995, 
    C_LIGHTGRAY,
    C_BLACK, 
    1);  { border width in pixels }
end;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hScr: array[0..AS_NH-1] of HGOBJ;  { array of object handles }
  lpTags: LPSTR;
  nLineColor: array[0..NT-1] of INTEGER;
  nTraces :INTEGER;
  i:INTEGER;
  rLow, rHigh, rSetpoint :realtype;
  rSampleInt, rRelResetInt:realtype;
begin
  nTraces:= NT;
  { allocate global array for tags }
  hTags:= GlobalAlloc (GHND, nTraces * TAGLEN);
  lpTags:= GlobalLock (hTags);
  { initialize tags (channel names) }
  lstrcpy (lpTags , 'Tank Level');
  lstrcpy (lpTags + TAGLEN, 'Steam Flow');
  lstrcpy (lpTags + 2 * TAGLEN, 'Product Flow');
  lstrcpy (lpTags + 3 * TAGLEN, 'Feed Flow');
  lstrcpy (lpTags + 4 * TAGLEN, 'Composition');
  lstrcpy (lpTags + 5 * TAGLEN, 'Column Level');
  lstrcpy (lpTags + 6 * TAGLEN, 'Recycle Flow');
  lstrcpy (lpTags + 7 * TAGLEN, 'Reflux Flow');
  { define dynamic data set }
  thData:= WRDefineDynDataSet ('Auto Scroll',
    nTraces, { # of traces }
    'volts', { units string }
    lpTags,  { tag names }
    0);      { no history buffer }
  WGRaiseGraph (pGrDesc, RC_HIGH);
  
  { assign line colors }
  for i:= 1 to nTraces - 1 do
    nLineColor[i]:= (i  mod  15) + 1;
  nLineColor[6]:= C_LIGHTRED;
  
  { set current font to Arial, 16 points, bold, italic }
  WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD or TEXT_ITAL);
  
  rSampleInt:= 0.1;       { time between samples := 0.1 s }
  rRelResetInt:= 0.8;     { reset back 20 MOD  }
  rSetpoint:= 0.0;        { set po value }
  rHigh:= 1.5;            { high alarm limit }
  rLow:= - 1.75;          { low alarm limit }

  { create an auto scroll graph }
  WRSetAutoScrollGraph (pGrDesc, { pointer to graph descriptor }
    thData,               { handle to dynamic data set }
    rSampleInt,           { sample interval }
    rRelResetInt,         { relative reset }
    - 2.0, 2.0,           { minimum AND maximum values }
    10.0,                 { range of independent variable }
    GOD_SUBT_SCLINE,      { scrolling lines }
    2,                    { 2 digits after decimal point }
    rSetpoint,            { set point value }
    rHigh,                { high alarm value }
    rLow,                 { low alarm value }
    'Seconds',            { dependent axis title }
    C_WHITE,              { plotting area color }
    @nLineColor,          { line colors }
    TRUE,                 { display dynamic values as text }
    @hScr);               { handles to individual objects  }
  { are returned in this array }

  GlobalFree (hTags);     { free tags array }
end;

{****************************************************************}
{ Timer routine - simulates new data and updates dynamic data set }
{****************************************************************}

procedure  TimerRoutine;
var
  rArg:realtype;
  rNewVals: array[0..8] of realtype;
  x:INTEGER;
begin
  { if the graph window exists, continue }
  if (not WGIsGraphDescValid (pDynGrDesc)) then
    exit;
  WGStart;
  rArg:= M_PI * nCount;
  x:= random (1000);
  { new values }
  rNewVals [0]:= sin (rArg / (1025.0 - nCount)) * 1.25 ;
  rNewVals [1]:= sin (rArg / 52.0) * (random * 1.5) * 1.1 - 1.25;
  rNewVals [2]:= cos (rArg / 200.0) * (random * 1.8) * 1.2 + 1.05;
  rNewVals [3]:= ORD (x  mod  4 <> 0);
  rNewVals [3]:= random - 2.0;
  rNewVals [4]:= cos (rArg / 20.0) / 1.1;
  rNewVals [5]:= 0.9 * cos (rArg / 7);
  rNewVals [6]:= - 1.35 - cos (rArg) / 10.0;
  rNewVals [7]:= 1.7 + (cos (rArg / 5) + rNewVals[5] * 0.7) / 10.0;
  { update the data set }
  WRUpdateData (thData, @rNewVals, pDynGrDesc);
  ncount:= ncount + 1;
  if (nCount > 1000) then
    nCount:= 0;
end;

function  AboutProc (hDlg:HWND; message:UINT; wParam:UINT;
                     lParam:LONGINT):BOOL;
begin
  case (message) of
    WM_INITDIALOG: begin
      AboutProc:= TRUE;
      exit;
    end;

    WM_COMMAND: begin
      if ((wParam = IDOK)  or (wParam = IDCANCEL)) then begin
        EndDialog (hDlg, 1);
        AboutProc:= TRUE;
        exit;
      end;
    end;
  end;
  AboutProc:= FALSE;
end;

begin
  pDynGrDesc:= nil;
end.

