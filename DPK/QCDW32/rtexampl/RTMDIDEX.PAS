{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   RTMDIDEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Rtmdidex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure CreateMDIChild1(thwnd: HWND; tinst: THANDLE);
procedure CreateMDIChild2(thwnd: HWND; tinst: THANDLE);
procedure ResizeMDIChild2(w,h: INTEGER);
procedure ResizeMDIChild1(w,h: INTEGER);
procedure WM_DestroyGraph;
procedure TimerRoutine;

implementation
{$R rtdemo}


const
  ncount: INTEGER = 0;

  NT = 8;               { number of traces }

var

  hXY: HGOBJ;				    { handle to xy plot }
  thData: HDATA;				{ handle to dynamic data set }
  pDynGrDesc: PGRAPH_DEF;
  pPageDesc1:  PPAGE_DEF;
  pPageDesc2:  PPAGE_DEF;

  hAutoBar: ARRAY [0..AB_NH-1] OF HGOBJ;    { handles of graphical objects for auto bars. }
  hTags: HGLOBAL;       { handle to tag names }
  lpTags: LPSTR;

const

  hwndFrame: THANDLE  = 0;      { Handle to MDI frame (main) window  }
  hwndMDIClient: THANDLE = 0;   { Handle to MDI client window }



procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure StartGraphs2 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure ResizeMDIChild2(w,h: INTEGER);
VAR hwndPage: HWND;
begin
  hwndPage := WGGetPageWindow (pPageDesc2);
  SetWindowPos (hwndPage, NULLH, 0, 0,
                 w, h,
                 SWP_NOMOVE OR SWP_NOZORDER);
end;

procedure ResizeMDIChild1(w,h: INTEGER);
VAR hwndPage: HWND;
begin
  hwndPage := WGGetPageWindow (pPageDesc1);
  SetWindowPos (hwndPage, NULLH, 0, 0,
                 w, h,
                 SWP_NOMOVE OR SWP_NOZORDER);
end;

procedure WM_DestroyGraph;
begin
      WRCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure CreateMDIChild1(thwnd: HWND; tinst: THANDLE);
begin
   pPageDesc1 := WGCreatePage ('PAGE1', {  page ID string}
          thwnd,                       {  handle to the parent window}
          tInst,                       {  application instance handle }
          'First Graph',               {  Window title string }
          @StartGraphs1,                 {  pointer to graph creation function}
          NULLS,                       {  Name of page window menu in resource file}
          C_LIGHTGRAY,                 {  window background color}
          MM_PROPORT,                  {  window sizing mode}
          WS_CHILD  or  WS_CLIPCHILDREN or  WS_VISIBLE, {  window style}
          PAGE_CLIENT,
          {  window initial size and position option}
          0, 0, 0, 0);
            {  save pointer to page descriptor in extra bytes}
          SetWindowLong (thwnd, 0, LONGINT (pPageDesc1));

end;

procedure CreateMDIChild2(thwnd: HWND; tinst: THANDLE);
begin

   pPageDesc2 :=
            WGCreatePage ('PAGE2',
            thwnd,
            tInst,
            ' PAGE 2',
            @StartGraphs2,
            NULLS,                     {  no menu}
            C_LIGHTGRAY,
            MM_PROPORT,                  {  window sizing mode}
            WS_CHILD  or  WS_CLIPCHILDREN  or  WS_VISIBLE, {  window style}
            PAGE_FULL, {  window initial size and position option}
            0, 0, 0, 0);
              {  save pointer to page descriptor in extra bytes}
   SetWindowLong (thwnd, 0, LONGINT (pPageDesc2));

end;

{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}
{ display first page window }
procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
begin
  { Initialize graph }
  pDynGrDesc := WGCreateGraph (pPageDesc, 
    @DrawP1G1,
    { points to function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.99, 0.99,
    C_WHITE,                           { white background }
    C_RED,                             { red   border }
    1);                                { border width in pixels }
end;

{*******************************************************************}
{ display 2nd page window }
procedure StartGraphs2 (pPageDesc: PPAGE_DEF);
begin

  { Initialize graph }
  WGCreateGraph (pPageDesc,
    @DrawP1G2,
    { points to function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.99, 0.99,
    C_BLUE,                            { blue background }
    C_RED,                             { red   border }
    1);                                { border width in pixels }
end;

{******************************************************
	Builds the first MDI Window
*******************************************************}
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hScr: array[0..AS_NH-1] of HGOBJ;  { array of object handles }
  nLineColor: array[0..NT-1] of INTEGER;
  nTraces :INTEGER;
  i:INTEGER;
  rLow, rHigh, rSetpoint :realtype;
  rSampleInt, rRelResetInt:realtype;
  nVer, nSec : INTEGER;
  VerStr, SecStr : STRING;
  CString :  array[0..20] of CHAR;
begin
  nTraces:= NT;

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

  nVer := WGGetVersion (nSec);
  STR(nVer, VerStr);
  STR(nSec, SecStr);
  VerStr := 'Version:' + VerStr + '.' + SecStr;
  Strpcopy (CString, VerStr);
  WGTextNorm (pGrDesc, thdc, CString, 0.8, 0.9, TA_LEFT OR TA_TOP, TEXT_NORMAL);


  GlobalFree (hTags);     { free tags array }
end;

{******************************************************
	Builds the saecond MDI Window
*******************************************************}

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
{*********************************************************************}
VAR
  BarColor: ARRAY [0..NT-1] OF TCOLORREF;
  i:INTEGER;
  nTraces:INTEGER;
BEGIN
  nTraces := NT;
	{ Show the graph window as raised  }

 	{ assign each bar an RGB value }
  FOR i := 0 TO nTraces - 1 DO
  	BarColor[i] := WGGetRGBColor ((i  MOD  15) + 2);

	{ Display a vertical auto bar graph }
	{ Handles to each object created by this function are returned }
	{ in hAutoBar. These handles will be used to change various }
	{ attributes of the graph }
   WRSetAutoBargraph (pGrDesc, thdata, 2.0, -2.0,  0.1,
		OR_VERT, 2, 0.15, 0.9, -0.9, 'HighAlm', 'L', @BarColor, @hAutoBar);
END;
{************************************************************************}

procedure  TimerRoutine;
var
	 rArg:realtype;
	 rNewVals: array[0..7] of realtype;
begin
  if not (WGIsGraphDescValid (pDynGrDesc)) then
    exit ;
  { Initialize the DLL every time the timer is called NOT  }
  { Otherwise the DLL will not know who is calling it. }
  { Necessary only if multiple RT Tools applications or multiple  }
  { instances of the same application can run simultaneously. }

  WGStart ;

  rArg := M_PI * nCount;
  { simulate data }
  rNewVals [0] := sin (rArg / 30) / 1.5 ;
  { new x for trace 0 }
  rNewVals [1] := rNewVals [0] + 0.1;  { new x for trace 1 }
  rNewVals [2] := 0.1 + sin (rArg / 20) / 1.7 ;
  { new x for trace 2 }
  rNewVals [3] := rNewVals[0];         { new x for trace 3 }
  
  rNewVals [4] := cos (rArg / 20.0) * 1.1;
  { new y for trace 0 }
  rNewVals [5] := 1.6 * cos (rArg / 7);{ new y for trace 1 }
  rNewVals [6] := - 0.05 - cos (rArg / 6);
  { new y for trace 2 }
  rNewVals [7] := 0.3 + cos (rArg / 5) + rNewVals[5] * 0.7;
  { new y for trace 3 }

  nCount := nCount + 1;
  if nCount > 1000 then
    nCount := 0;

  WRUpdateData (thData, @rNewVals, nil);
end;
{ ************************************************************************ }


begin
  pDynGrDesc := nil;                   { Graph descriptors }
  pPageDesc1 := nil;

  WGStart;
  hTags:= GlobalAlloc (GHND, NT * TAGLEN);
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
  thData:= WRDefineDynDataSet ('Process Values',
    NT, { # of traces }
    'volts', { units string }
    lpTags,  { tag names }
    0);      { no history buffer }

end.
