{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCROLLGX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{$F+,K+}
unit Scrollgx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure MM_About (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;
procedure  TimerRoutine;

implementation
{$R rtdemo}
const
  NUMLED = 7;
  ncount: INTEGER = 0;

var
  hScroll, hScroll2: HGOBJ; { handles to the scrolling graph objects }
  thData, thData2: HDATA; { handles to the dynamic data sets }
  hLED: array[0..NUMLED-1] of HGOBJ;	 { handles to LED controls }
  hAxisY: HGOBJ;  { axis handle }

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3: PGRAPH_DEF;
pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg:HWND; message:UINT; wParam:UINT;
                     lParam:LONGINT):BOOL;export; forward;
{$else}
function  AboutProc (hDlg:HWND; message:UINT; wParam:UINT;
                     lParam:LONGINT):BOOL;stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF); forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);  forward;
procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC);  forward;
procedure DrawP1G3 (pGrDesc:PGRAPH_DEF; thdc:HDC);  forward;

procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
  pPageDesc1:=
    WGCreatePage ('PAGE1',  { page ID string }
    thwnd,                  { handle to the parent window }
    tInst,                  { application instance handle }
    'Simulator',            { Window title string }
    @StartGraphs1,          { pointer to graph creation function }
    '',                     { no menu }
    C_LIGHTGRAY,            { window background color }
    MM_ISOTR,               { window sizing mode }
    WS_CHILD or WS_CLIPCHILDREN or WS_VISIBLE,
    { window style }
    PAGE_CLIENT,
    0, 0, 0, 0);            { initial window size and position }
  { if used (not used here) }

end;

procedure WM_DestroyGraph;
begin
  WRCleanup (TRUE);   { clean up charting tools memory }
  PostQuitMessage (0);
end;

procedure MM_About (thwnd:HWND; tinst:THANDLE);
var  lpProcAbout: TFarProc;
begin
  lpProcAbout:= MakeProcInstance (@AboutProc, tinst);
  DialogBox (tInst,    {  current instance   }
    'AboutBox',        {  resource to use       }
    thwnd,             {  parent window handle  }
    lpProcAbout);      {  AboutProc() instance address  }
  FreeProcInstance (lpProcAbout);
end;

{***********************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**************************************************************}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
begin
  { Initialize graphs }
  pDynGrDesc:=
    WGCreateGraph (pPageDesc,
    @DrawP1G1,    { function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.49, 0.8,
    C_LIGHTGRAY,  { light gray background }
    C_WHITE,      { white border }
    1);           { border width in pixels }

  pDynGrDesc2:= WGCreateGraph (pPageDesc, @DrawP1G2,
    0.5, 0.005, 0.99, 0.8,
    C_LIGHTBLUE, C_BLACK, 2);

  pDynGrDesc3:= WGCreateGraph (pPageDesc, @DrawP1G3,
    0.005, 0.81, 0.99, 0.99,
    C_LIGHTGRAY, - 1, 0);
end;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hAxisX: HGOBJ;    { axis handles }
  hTags: HGLOBAL;
	lpTags: LPSTR;
	bFlags: array[0..NALMLINES-1] of WORDBOOL;
        nTraces :INTEGER;
	nLineColor: array[0..2] of INTEGER;
	nLineWidth: array[0..2] of INTEGER;
	nLineStyle: array[0..2] of INTEGER;
	i, nGridUpdate: INTEGER;
        rSampleInt, rResetInt: realtype;
        rHigh, rLow, rSetpoint: realtype;
begin
  nTraces:= 3;
  nGridUpdate:= 4;
  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.24, 0.15, 0.95, 0.57, C_BLACK);
  { scale the plotting area for an x range of 0 to 1.0 }
  { and y range of -3.0 to 3.0 }
  WGScalePlotArea (pGrDesc, 0.0, - 3.0, 1.0, 3.0);
  { set the intercepts to 0.0, -3.0 }
  WGSetXYIntercepts (pGrDesc, 0.0, - 3.0);
  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  { set current font to Arial, 7 points }
  WGSetTextByName (C_RED, 'Arial', 8, 0);
  { draw the x axis with major ticks every 0.2 physical units
    and no minor ticks }
  hAxisX:= WGDrawXAxis (pGrDesc, thdc, 0.2, 0, POS_MIDDLE);
  { draw the y axis with major ticks every physical unit and 1 minor ticks }
  hAxisY:= WGDrawYAxis (pGrDesc, thdc, 1.0, 1, POS_LEFT);
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);
  WGSetTextByName (C_RED, 'Arial', 8, TEXT_ITAL);
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);
  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);
  { set current font to Arial, 8 points }
  WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);
  { Write axes titles }
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Minutes');
  WGTextNorm (pGrDesc, thdc, 'Volts', 0.1, 0.35,
    TA_CENTER or TA_BOTTOM, TEXT_VERTLEFT);
  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD or TEXT_ITAL);
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Horizontal Strip Chart');
  { SET UP DYNAMIC PORTION OF GRAPH }
  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  { Assign each line width and color for the scroll graph }
  for i:= 0 to nTraces - 1 do begin
    nLineWidth [i]:= 2;
    nLineStyle[i]:= PS_SOLID;
  end;
  nLineColor [0]:= C_LIGHTRED;
  nLineColor [1]:= C_WHITE;
  nLineColor [2]:= C_LIGHTGREEN;
  rSampleInt:= 0.02;   rResetInt:= 0.95;
  { Define the dynamic data set }
  thData:= WRDefineDynDataSet ('Scroll 1',
  { data set name }
    nTraces,     { # of traces }
    'volts',     { unit string }
    '',          { no tag names }
    200);
  { history buffer size := 200 }
  { create scrolling lines  }
  hScroll:=
    WRSetScrollGraph (pGrDesc, { pointer to graph descriptor }
    thData,      { handle to dynamic data set }
    rSampleInt,  { sample interval }
    rResetInt,   { relative reset }
    OR_HORZ,     { scroll direction is horizontal }
    NO_STEP,     { style - linear interp }
    @nLineStyle,
    @nLineWidth,
    @nLineColor);
  { set the flags for the alarm lines }
  bFlags[0]:= TRUE;
  bFlags[1]:= TRUE;
  bFlags[2]:= TRUE;
  bFlags[3]:= FALSE;
  bFlags[4]:= FALSE;
  { Assign colors for alarm lines }
  nLineColor [0]:= C_YELLOW;
  nLineColor [1]:= C_RED;
  nLineColor [2]:= C_BLUE;
  rHigh:= 0.95;     { High }
  rLow:= - 1.4;     { Low }
  rSetpoint:= 0.25; { Setpoint }
  { Assign setpoint, low and high alarm values }
  WRSetSetpoint (thData, rSetpoint);
  WRSetAlarm (thData, ALM_LOW, rLow, 'LOW');
  WRSetAlarm (thData, ALM_HIGH, rHigh, 'HIGH');
  WRSetAlarmHyst (thData, 0.02, 0.0);

  { Draw alarm lines }
  WRSetAlarmLines (pGrDesc,   { pointer to graph descriptor }
    thData,     { handle to data set }
    2,          { alarm line updated every 2 seconds }
    OR_HORZ,    { lines are horizontal }
    @bFlags,    { enable/disable particular lines }
    @nLineStyle,{ default style - PS_SOLID }
    @nLineWidth,
    @nLineColor);

  { Draw a 'shallow' rectangle }
  WGRectangleNormEx (pGrDesc, thdc, 0.03, 0.74, 0.95, 0.97,
    C_LIGHTGRAY, 1, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);

  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_GREEN, 'Arial', 6, TEXT_BOLD or TEXT_ITAL);

  { Draw alarm text }
  WRSetAlarmText (pGrDesc,  { pointer to graph descriptor }
    thData,                 { handle to dyn data set }
    - 1,                    { display all channels }
    0.52, 0.75, 0.71, 0.97, { alarm text rectangle }
    - 1,                    { no border }
    0,                      { border width - ignored }
    C_LIGHTGRAY,            { alarm text background color }
    'NORM',                 { normal message }
    nil,                    { use default text colors }
    TA_CENTER,              { string alignment }
    OR_VERT);               { layout is vertical }

  { Assign colors for dynamic text }
  nLineColor [0]:= C_LIGHTRED;
  nLineColor [1]:= C_WHITE;
  nLineColor [2]:= C_LIGHTGREEN;

  { Display dynamic values for all traces in the dynamic data set. }
  WRSetDynText (pGrDesc,    { pointer to graph descriptor }
    thData,                 { handle to dynamic data set }
    - 1,                    { display all channels }
    0.79, 0.75, 0.94, 0.97, { dynamic text rectangle }
    - 1,                    { no border }
    0,                      { ignored }
    nil,                    { use text color from hScroll }
    C_LIGHTGRAY,            { background color }
    OR_VERT,                { text layout is vertical }
    5,                      { max # of characters in field }
    2,                      { 1 digit after decimal point }
    hScroll,
    RC_FLAT);                 { no 3d effects }

  { allocate global array for legends }
  hTags:= GlobalAlloc (GHND, nTraces * LG_MAXLEN);
  lpTags:= LPSTR (GlobalLock (hTags));
  lstrcpy (lpTags, 'Chan 1');
  lstrcpy (lpTags + LG_MAXLEN, 'Chan 2');
  lstrcpy (lpTags + 2 * LG_MAXLEN, 'Chan 3');

  { display dynamic legend }
  WRDynLegend (pGrDesc,       { pointer to graph descriptor }
    0.05, 0.75, 0.43, 0.96,   { legend rectangle }
    - 1,                      { no border }
    0,                        { ignored }
    C_BLACK,                  { black text }
    C_LIGHTGRAY,              { light gray background }
    OR_VERT,                  { layout is vertical }
    hTags,                    { legend text  }
    hScroll,                  { handle to scroll graph }
    TRUE);                    { use symbols }
  GlobalFree (hTags);


end;

{************************************************************}
procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hTags: HGLOBAL;
  lpTags: LPSTR;
  hAxisX, hAxisY: HGOBJ;  { axes handles }
  nTraces :INTEGER;
  nLineColor: array[0..3] of INTEGER;
  nLineStyle: array[0..3] of INTEGER;
  nLineWidth: array[0..3] of INTEGER;
  textcolors: array[0..3] of INTEGER;
  i, nGridUpdate:INTEGER;
  bFlags: array[0..NALMLINES-1] of WORDBOOL;
  rSampleInt, rResetInt:realtype;
  rHigh, rLow, rSetpoint:realtype;
begin
  nTraces:= 4;
  nGridUpdate:= 1;
  { Show the graph window as a raised graph }
  WGRaiseGraph (pGrDesc, RC_HIGH);
  { Define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.15, 0.55, 0.91, C_WHITE);
  { Scale the plotting are for an x range of -2.0 to 2.0 }
  { and y range of 0.0 to 1.0 }
  WGScalePlotArea (pGrDesc, - 2.0, 0.0, 2.0, 1.0);
  { Set the intercepts to -2, 0 }
  WGSetXYIntercepts (pGrDesc, - 2.0, 0.0);
  { Axes to be drawn in solid, cyan, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 6, 0);
  { Draw the x axis with major ticks every physical coord and 1 minor tick }
  hAxisX:= WGDrawXAxis (pGrDesc, thdc, 1.0, 1, POS_MIDDLE);
  { Draw the y axis with major ticks every 0.1 physical coords and no minor ticks }
  hAxisY:= WGDrawYAxis (pGrDesc, thdc, 0.2, 0, POS_LEFT);
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);
  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 8, TEXT_BOLD);
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Vertical Strip Chart');
  { Set the line style for the dynamic grid }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_BLACK);
  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every second. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  { Define the dynamic data set }
  thData2:= WRDefineDynDataSet ('Scroll 2', nTraces, 'volts', nil, 200);
  { Assign each line style, width and color }
  for i:= 0 to nTraces - 1 do begin
    nLineColor [i]:= i + 4;
    nLineStyle [i]:= PS_SOLID;
    nLineWidth [i]:= 1;
    textcolors[i]:= - 1;
  end;
  nLineWidth [0]:= 2;
  { Vaklues for limits }
  rSampleInt:= 0.02;   rResetInt:= 0.5;
  { Create a scroll graph }
  hScroll2:= WRSetScrollGraph (pGrDesc, thData2, rSampleInt, rResetInt,
    OR_VERT, STEP_END, @nLineStyle, @nLineWidth, @nLineColor);
  { Draw a rectangle with a 3D border }
  WGRectangleNormEx (pGrDesc, thdc, 0.56, 0.19, 0.98, 0.81,
    C_BLACK, 2, TRUE, WGGetRGBColor (C_WHITE), RC_3DBORDER);
  WGSetTextByName (C_WHITE, 'Arial', 6, 0);
  { Display the dynamic text for a traces in the data set }
  WRSetDynText (pGrDesc, thdata2, - 1, 0.75, 0.2, 0.85, 0.8, - 1,
    0, @textcolors, C_WHITE, OR_VERT, 5, 1, NULLH, 0);
  { Set the flags for the alarm lines }
  bFlags[0]:= FALSE;
  bFlags[1]:= TRUE;
  bFlags[2]:= TRUE;
  bFlags[3]:= FALSE;
  bFlags[4]:= FALSE;
  { Set the color and style of the alarm lines }
  nLineStyle [0]:= PS_SOLID;
  nLineStyle [1]:= PS_SOLID;
  nLineStyle [2]:= PS_SOLID;
  nLineColor [0]:= C_YELLOW;
  nLineColor [1]:= C_RED;
  nLineColor [2]:= C_BLUE;
  rHigh:= 0.95;                        { High }
  rLow:= - 1.4;                        { Low }
  rSetpoint:= 0.25;                    { Setpoint }
  { Assign setpoint, low and high alarm values }
  WRSetSetpoint (thdata2, rSetpoint);
  WRSetAlarm (thdata2, ALM_LOW, rLow, '*LO*');
  WRSetAlarm (thdata2, ALM_HIGH, rHigh, '*HI*');
  { Display the alarm lines for the data set }
  WRSetAlarmLines (pGrDesc, thdata2, 2, OR_VERT,
    @bFlags, @nLineStyle, @nLineWidth, @nLineColor);
  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 6, 0);
  { Display the alarm text for all traces in the data set }
  WRSetAlarmText (pGrDesc, thdata2, - 1, 0.83, 0.2, 0.97, 0.8, - 1,
    0, C_WHITE, '', nil, TA_CENTER, OR_VERT);
  { Allocate global array for tags }
  hTags:= GlobalAlloc (GHND, nTraces * LG_MAXLEN);
  lpTags:= LPSTR (GlobalLock (hTags));
  lstrcpy (lpTags, 'CH1');
  lstrcpy (lpTags + LG_MAXLEN, 'CH2');
  lstrcpy (lpTags + 2 * LG_MAXLEN, 'CH3');
  lstrcpy (lpTags + 3 * LG_MAXLEN, 'CH4');
  { Display the dynamic legend for all traces }
  WGSetTextByName (C_WHITE, 'Arial', 4, 0);
  WRDynLegend (pGrDesc, 0.57, 0.2, 0.74, 0.8, - 1,
    0, C_BLACK, C_WHITE, OR_VERT, hTags, hScroll2, FALSE);
  { Free global array }
  GlobalFree (hTags);
end;


{*************************************************************}
procedure DrawP1G3 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
	 x:realtype;
	 i:INTEGER;
begin
  { Show the graph window as a raised graph }
  WGRaiseGraph (pGrDesc, RC_HIGH);
  x:= 0.1;
  { Create a row of LED Controls }
  for i:= 0 to NUMLED - 1 do begin
    { Create a LED Control }
    hLED[i]:=
      WRSetLEDControl (pGrDesc,{ pointer of graph descriptor }
      x, 0.6,
      { position of left, top side of LED rect. }
      0.04,  { relative diameter of LED }
      WGGetRGBColor (C_LIGHTGRAY), { background color }
      i * 2, { 'on' color code }
      i * 2 + 1); { 'off' color code }
    x:= x + 0.14;
  end;
  { set current font to Arial, 8 points }
  WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);
  { Write graph title }
  WGTextNorm (pGrDesc, thdc, 'LED Controls', 0.5, 0.25,
    TA_CENTER or TA_BASELINE, TEXT_NORMAL);
end;

{**********************************************************
    FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)
    PURPOSE:  Processes messages for 'About' dialog box
***********************************************************}

function  AboutProc (hDlg:HWND; message:UINT;
                     wParam:UINT; lParam:LONGINT):BOOL;
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


{***********************************************************}
procedure  TimerRoutine;
var
	 rArg:realtype;
	 rNewVals: array[0..3] of realtype;
         rMin, rMax:realtype;
	 i:INTEGER;
begin

  WGStart ;
  if (not (WGIsGraphDescValid (pDynGrDesc))) then
    exit ;

  rArg:= PI * nCount;
  { simulate data }
  rNewVals [0]:= sin (rArg / (1020.0 - nCount));
  rNewVals [1]:= sin (rArg / 52.0) * (random) * 1.4;
  rNewVals [2]:= cos (rArg / 60.0) * (random) * 0.5;

  nCount:= nCount + 1;
  if (nCount > 1000) then
    nCount:= 0;
  { Update the data set }
  WRUpdateData (thdata, @rNewVals, nil);

  { rescale Y axis based on collected data }
  if (nCount = 70) then
    WRAutoRescale (pDynGrDesc, hAxisY, thdata, - 1, rMin, rMax, TRUE);

  rNewVals [0]:= sin (rArg / (1050.0 - nCount));
  rNewVals [1]:= sin (rArg / 52.0) * (random) * 1.6;
  rNewVals [2]:= cos (rArg / 60.0) * (random) * 0.5;
  rNewVals [3]:= cos (rArg / 22.0) * (random) * 0.25;
  if (not WGIsGraphDescValid (pDynGrDesc2)) then
    exit;
  WRUpdateData (thdata2, @rNewVals, nil);

  { Change the state of LED controls }
  for i:= 0 to NUMLED - 1 do
    WRChangeButtonState (pDynGrDesc3, hLED[i], nCount  mod  2);
end;

begin
  pDynGrDesc:= nil;
  pDynGrDesc2:= nil;
  pDynGrDesc3:= nil;
  pPageDesc1:= nil;
end.

