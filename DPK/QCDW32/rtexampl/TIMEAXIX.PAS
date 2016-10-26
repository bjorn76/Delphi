{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   TIMEAXIX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{************************************************************}
{                FEATURES OF THIS DEMO }
{  	Scroll Graphs - vertical and horizontal }
{		Time Axis drawing }
{		Time Axis labeling }
{		Time Label updating }
{		Dynamic Text }
{		Dynamic Legends }
{		Dynamic Grids }
{		Dynamic Data sets }
{ 	    Timers, 2 timers are used - a 0.5 sec and a 1 sec timer }
{		Alarm Text }
{ }
{		Page Window is created as a child of the Main Window }
{		Note: The Windows timers are not very accurate. }
{			  The timers are used to demonstrate updating the time }
{			  axis labels at different update rates. }

{$F+,K+}
unit Timeaxix;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure Timer1Routine;
procedure Timer2Routine;

implementation

{$R rtdemo}
const
  NT = 16;
  szAppName:PChar = 'TADemo';  {  Class Name used in call to CreateWindow.  }
  ncount1: INTEGER = 0;
  ncount2: INTEGER = 0;
var
thData, thData2, thData3: HDATA;	{ handles to the dynamic data sets }
hScroll, hScroll2, hScroll3: HGOBJ;	 { handles to the scrolling graph objects }

hTimeLabX: HGOBJ;
pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3: PGRAPH_DEF;
pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;


function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;


procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      pPageDesc1 := WGCreatePage ('PAGE1',
      { page ID string }
        thwnd,                         { handle to the parent window }
        tInst,                        { application instance handle }
        'Time Axis Demo',              { Window title string }
        @StartGraphs1,                 { pointer to graph creation function }
        nil,                           { No menu }
        C_LIGHTGRAY,                   { window background color }
        MM_PROPORT,                    { window sizing mode }
        0,                             { default window style }
        PAGE_FULL,
        0, 0, 0, 0);
      
   END;

procedure WM_DestroyGraph;
begin

      WRCleanup (TRUE);                { clean up charting tools memory }
      { and free data arrays }
      PostQuitMessage (0);
end;

{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
begin
  { Initialize graphs }
  pDynGrDesc := WGCreateGraph (pPageDesc, 
    @DrawP1G1,                         { function which builds graph }
    0.005, 0.005,
    { graph window relative position inside parent page window }
    0.99, 0.49,
    C_WHITE,                           { white background }
    - 1,                               { no border }
    0);
  
  pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2, 
    0.001, 0.5, 0.5, 0.99, 
    C_MAGENTA, - 1, 0);                { Magenta background, no border }
  
  pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
    0.51, 0.5, 0.99, 0.99, 
    C_MAGENTA, - 1, 0);                { Magenta background, no border }

end;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	hAxisX, hAxisY: HGOBJ;    { axis handles }
	hTags: HGLOBAL;
	lpTags: LPSTR;
	bFlags: array[0..NALMLINES-1] of WORDBOOL;
        i,nTraces :INTEGER;
	nLineColor: array[0..NT-1] of INTEGER;
	nLineWidth: array[0..NT-1] of INTEGER;
	nLineStyle: array[0..NT-1] of INTEGER;
        rSampleInt, rResetInt:realtype;
        rHigh, rLow:realtype;
 begin
   nTraces := NT;
   { define the plotting area of the graph }
   WGSetPlotArea (pGrDesc, thdc, 0.1, 0.13, 0.7, 0.8, C_BLACK);
   
   { scale the plotting area for an x range of 0 to 5.0 }
   { and y range of -2.0 to 2.0 }
   WGScalePlotArea (pGrDesc, 0.0, - 2.0, 5.0, 2.0);

   { set the intercepts to 0.0, -2.0 }
   WGSetXYIntercepts (pGrDesc, 0.0, - 2.0);
   
   { axes to be drawn in solid, cyan, 1 pixel thick }
   WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

   { set current font to Arial, 8 points }
   WGSetTextByName (C_RED, 'Arial', 8, 0);

   { draw the y axis with major ticks every 0.5 physical units and 1 minor tick }
   hAxisY := WGDrawYAxis (pGrDesc, thdc, 0.5, 1, POS_LEFT);
   
   { Label the y axis, in decimal format, 1 digit after the decimal point. }
   WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);

   { Write axis title }
   WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');
   
   { Write graph title }
   WGTitleGraph (pGrDesc, thdc, '0.5 second timer');

   {********************************************************************** }
   { SET UP DYNAMIC PORTION OF GRAPH }

   { set current font to Arial, 8 points }
   WGSetTextByName (C_GREEN, 'Arial', 8, 0);
   
   { Draw a horizontal time axis with tick marks }
   hAxisX := WRDrawTimeAxis (pGrDesc, 1.0, 4, POS_MIDDLE, OR_HORZ, AXU_SEC);

   { Label the horizontal time axis }
   hTimeLabX := WRLabelTimeAxis (pGrDesc, 
     hAxisX,                           { time axis handle }
     POS_BELOW,                        { label position }
     DLB_MS,                           { label format MM:SS }
     0,                                { does not apply to this label format }
     0,                                { does not apply to this label format }
     0,                                { # minutes for first tick label }
     0,                                { # seconds for first tick label }
     0,                                { does not apply to this label format }
     LL_ON,                            { display last label }
     nil);
     { this parameter is ignored since LL_ON }
   
   { Assign each line style, width and color for the scroll graph }
   for i := 0 to nTraces - 1 do begin
     nLineStyle [i] := PS_SOLID;
     nLineWidth [i] := 0;
     nLineColor [i] := i;
   end;
   nLineColor [7] := C_YELLOW;
   nLineStyle [7] := PS_DOT;
   nLineStyle [1] := PS_DOT;

   { Define the dynamic data set }
   thData := WRDefineDynDataSet ('Scroll 1',
   { dynamic data set name }
     nTraces,                          { # of channels in the data set }
     'volts',                          { engineering units for all channels. }
     nil,                              { tag names - not used }
     200);                             { size of historical buffer }
   
   rSampleInt := 0.5;
   rResetInt := 0.8;

   hScroll := WRSetScrollGraph (pGrDesc,
   { pointer to graph descriptor }
     thData,                           { handle to dynamic data set }
     rSampleInt,                       { period between adjacent samples }
     rResetInt,                        { relative reset interval }
     OR_HORZ,                          { direction of graph is horizontal }
     NO_STEP,                          { no step }
     @nLineStyle,                      { line styles for traces }
     @nLineWidth,                      { line widths for traces }
     @nLineColor);                     { line colors for traces }

   { set the flags for the alarm lines }
   bFlags[0] := FALSE;
   bFlags[1] := TRUE;
   bFlags[2] := TRUE;
   bFlags[3] := FALSE;
   bFlags[4] := FALSE;
   
   { Assign each line style, width and color for the alarm lines }
   nLineStyle [0] := PS_SOLID;
   nLineStyle [1] := PS_SOLID;
   nLineStyle [2] := PS_SOLID;
   
   nLineColor [0] := C_YELLOW;
   nLineColor [1] := C_LIGHTRED;
   nLineColor [2] := C_LIGHTBLUE;
   
   rHigh := 0.95;                      { High alarm limit }
   rLow := - 1.0;                      { Low }

   { Set low and high alarm limits }
   WRSetAlarm (thData, ALM_LOW, rLow, 'LOW');
   WRSetAlarm (thData, ALM_HIGH, rHigh, 'HIGH');

   { Draw alarm lines }
   WRSetAlarmLines (pGrDesc,           { Pointer to graph descriptor }
     thData,                           { Handle to dynamic data set }
     2,                                { Alarm lines refresh period }
     OR_HORZ,                          { Alarm lines direction }
     @bFlags,                          { Flags enabling alarm lines }
     @nLineStyle,                      { Line styles }
     @nLineWidth,                      { Line widths }
     @nLineColor);                     { Line colors }

   { Draw a 'shallow' rectangle }
   WGRectangleNormEx (pGrDesc, thdc, 0.75, 0.02, 0.99, 0.97,
     C_LIGHTGRAY, 1, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
   
   WGSetTextParams (C_GREEN, FF_ROMAN, 6, 0);
   
   { Display alarm text }
   WRSetAlarmText (pGrDesc, thdata, - 1, 0.88, 0.05, 0.93, 0.96, - 1,
     0, C_LIGHTGRAY, 'NORM', nil, TA_CENTER, OR_VERT);
   
   { Display dynamic values for all traces in the dynamic data set. }
   WRSetDynText (pGrDesc, 
     thdata,                           { Handle to dynamic data set }
     - 1,                              { Display all channels }
     0.84, 0.05, 0.87, 0.96,           { Position of text rectangle }
     - 1,                              { No border }
     0,
     nil, 
     C_LIGHTGRAY,                      { Background color }
     OR_VERT,                          { Text layout }
     5,                                { Max characters in each field }
     1,                                { # of digits after decimal point }
     hScroll,                            { No associated object }
     RC_FLAT);                         { No 3D effect }
   
   { allocate global array for tags for legend }
   hTags := GlobalAlloc (GHND, nTraces * LG_MAXLEN);
   lpTags := GlobalLock (hTags);
   lstrcpy (lpTags, 'C1');
   lstrcpy (lpTags + LG_MAXLEN, 'C2');
   lstrcpy (lpTags + 2 * LG_MAXLEN, 'C3');
   lstrcpy (lpTags + 3 * LG_MAXLEN, 'C4');
   lstrcpy (lpTags + 4 * LG_MAXLEN, 'C5');
   lstrcpy (lpTags + 5 * LG_MAXLEN, 'C6');
   lstrcpy (lpTags + 6 * LG_MAXLEN, 'C7');
   lstrcpy (lpTags + 7 * LG_MAXLEN, 'C8');
   lstrcpy (lpTags + 8 * LG_MAXLEN, 'C9');
   lstrcpy (lpTags + 9 * LG_MAXLEN, 'C10');
   lstrcpy (lpTags + 10 * LG_MAXLEN, 'C11');
   lstrcpy (lpTags + 11 * LG_MAXLEN, 'C12');
   lstrcpy (lpTags + 12 * LG_MAXLEN, 'C13');
   lstrcpy (lpTags + 13 * LG_MAXLEN, 'C14');
   lstrcpy (lpTags + 14 * LG_MAXLEN, 'C15');
   lstrcpy (lpTags + 15 * LG_MAXLEN, 'C16');

   { display dynamic legend for scrolling lines object }
   WRDynLegend (pGrDesc,
     0.76, 0.05, 0.81, 0.96,           { Position of legend rectangle }
     - 1,                              { No border }
     0,
     - 1,
     { Use text colors from scrolling lines object }
     C_LIGHTGRAY,                      { Background color }
     OR_VERT,                          { Layout }
     hTags,                            { Legend strings }
     hScroll,                          { Handle to scrolling lines object }
     TRUE);                            { Display line symbols }
   
   { free tags array }
   GlobalFree (hTags);
 end;

{*********************************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	hAxisX, hAxisY,  { axes handles }
	hScroll2,
	hLabY: HGOBJ;
        nTraces:INTEGER;
	nLineColor: array[0..3] of INTEGER;
	nLineWidth: array[0..3] of INTEGER;
	nLineStyle: array[0..3] of INTEGER;
        i, nGridUpdate:INTEGER;

begin
  nGridUpdate := 1;
  nTraces := 4;                        { Show the graph window as raised  }
  WGRaiseGraph (pGrDesc, RC_HIGH);
  
  { Define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.15, 0.95, 0.85, C_WHITE);
  
  { Scale the plotting are for an x range of -1.0 to 1.0 }
  { and y range of 0.0 to 10.0 }
  WGScalePlotArea (pGrDesc, - 1.0, 0.0, 1.0, 10.0);

  { Set the intercepts to -1, 0 }
  WGSetXYIntercepts (pGrDesc, - 1.0, 0.0);
  
  { Axes to be drawn in solid, cyan, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 8, TEXT_BOLD);

  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

  { Draw a vertical time axis with tick marks. Units are seconds. }
  hAxisY := WRDrawTimeAxis (pGrDesc, 5.0, 4, POS_LEFT, OR_VERT, AXU_SEC);

  { Label the vertical time axis }
  hLabY := WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_MS, 0, 0, 0, 
    0, 0, LL_ON, nil);

  { Draw the x axis with major ticks every 0.5 physical units and no minor ticks }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 0.5, 0, POS_BELOW);
  
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);
  
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, '0.5 second timer');
  
  { Set the line style for the dynamic grid }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_BLACK);
  
  { Display dynamic grids at the major tick interval for both }
  { x and y axes, updating the grids every second. }
  WRDynGrid (pGrDesc,                  { pointer to graph descriptor }
    hAxisX,                            { handle to X axis }
    GRID_MAJOR,                        { grid lines at major tick marks }
    nGridUpdate);                      { update period, in seconds }

  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  
  { Define the dynamic data set }
  thdata2 := WRDefineDynDataSet ('Scroll 2', nTraces, 'volts', nil, 0);
  
  { Assign each line style, width and color }
  for i := 0 to nTraces - 1 do begin
    nLineColor [i] := i + 4;
    nLineStyle [i] := PS_SOLID;
    nLineWidth [i] := 1;
  end;
  nLineWidth [0] := 2;

  { Create a scrolling graph }
  hScroll2 := WRSetScrollGraph (pGrDesc,
  { pointer to graph descriptor }
    thdata2,                           { handle to dynamic data set }
    0.5,                               { period between adjacent samples }
    0.8,                               { relative reset interval }
    OR_VERT,                           { direction of graph is vertical }
    NO_STEP,                           { no step }
    @nLineStyle,                       { line styles for traces }
    @nLineWidth,                       { line widths for traces }
    @nLineColor);                      { line colors for traces }

  { Initialize automatic updating of time labels based on reset }
  { of scrolling lines object hScroll2 }

  WRStartTimeLabelsUpdate (pGrDesc,    { pointer to graph descriptor }
    hLabY,                             { handle to y axis time labels }
    hScroll2);                         { handle to scroll graph }
end;
{****************************************************************************}

procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	hAxisX, hAxisY,  { axes handles }
	hLabY, Scroll3: HGOBJ;
	nTraces:INTEGER;
        nLineColor:INTEGER;
        rSampleInt, rResetInt:realtype;
begin
  nTraces := 1;                        { Show the graph window as raised  }
  WGRaiseGraph (pGrDesc, RC_HIGH);
  
  { Define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.15, 0.95, 0.85, C_WHITE);
  
  { Scale the plotting are for an x range of -0.5 to 0.5 }
  { and y range of 0.0 to 20.0 }
  WGScalePlotArea (pGrDesc, - 0.5, 0.0, 0.5, 20.0);

  { Set the intercepts to -0.5, 0.0 }
  WGSetXYIntercepts (pGrDesc, - 0.5, 0.0);
  
  { Axes to be drawn in solid, cyan, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 8, TEXT_BOLD);

  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

  { Draw the vertical time axis, time units are seconds }
  hAxisY := WRDrawTimeAxis (pGrDesc, 5.0, 4, POS_MIDDLE, OR_VERT, AXU_SEC);

  { Label the vertical time axis }
  hLabY := WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_MS, 0, 0, 0, 0, 0, 
    LL_ON, nil);

  { Draw the x axis with major ticks every 0.25 physical units and 5 minor ticks }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 0.25, 5, POS_BELOW);
  
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);

  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, '1 second timer');
  
  { Define the dynamic data set }
  thdata3 := WRDefineDynDataSet ('Scroll 3', nTraces, 'volts', nil, 0);
  
  { Assign line color }
  nLineColor := C_GREEN;

  rSampleInt := 1.0;   rResetInt := 0.4;

  { Create a scroll graph }
  hScroll3 := WRSetScrollGraph (pGrDesc, thdata3, rSampleInt, rResetInt, 
    OR_VERT, NO_STEP,
    nil,                               { default line style - solid }
    nil,                               { default line width - 0 }
    @nLineColor);
  
  { Initialize automatic updating of time labels based on reset of  }
  { scrolling lines object hScroll3 }
  WRStartTimeLabelsUpdate (pGrDesc, hLabY, hScroll3);
end;

{************************************************************************}
const
   bFirstReset :WORDBOOL = FALSE;

procedure  Timer1Routine;
var
	 rArg:realtype;
	 rNewVals: array [0..NT-1] of realtype;
begin
  { Initialize the DLL every time the timer is called with WGStart  NOT  }
  { Otherwise the DLL will not know who is calling it. }
  { Necessary only if multiple RT Tools applications or multiple  }
  { instances of the same application can run simultaneously. }

  WGStart ;

  { Check if graph is still there }
  if not (WGIsGraphDescValid (pDynGrDesc)) then
    exit ;

  rArg := M_PI * nCount1;
  { simulate data }
  rNewVals [0] := sin (rArg / (1020.0 - nCount1));
  rNewVals [1] := sin (rArg / 52.0) * 1.4 + (randreal);
  rNewVals [2] := cos (rArg / 60.0) - rNewVals[1] / 2.0;
  rNewVals [3] := cos (rArg / 22.0) * (randreal) * 0.25;
  rNewVals [4] := sin (rArg / 32.0) * (randreal) * 1.1;
  rNewVals [5] := cos (rArg / 73.0) * (randreal) * 0.8;
  rNewVals [6] := cos (rArg / 34.0) * (randreal) * 0.15;
  rNewVals [7] := sin (rArg / 65.0) * (randreal) * 1.3;
  rNewVals [8] := cos (rArg / 26.0) * (randreal) * 1.5;
  rNewVals [9] := cos (rArg / 17.0) * (randreal) * 1.75;
  rNewVals [10] := cos (rArg / 39.0) * (randreal) * 0.25;
  rNewVals [11] := sin (rArg / 21.0) * (randreal) * 1.4;
  rNewVals [12] := cos (rArg / 32.0) * 1.95;
  rNewVals [13] := cos (rArg / 63.0) * (randreal) * 0.85;
  rNewVals [14] := sin (rArg / 44.0) * (randreal) * 1.2;
  rNewVals [15] := cos (rArg / 24.0) * (randreal) * 0.3;

  { Update data set thdata and scrolling lines in graph pDynGrDesc  }
  WRUpdateData (thdata, @rNewVals, pDynGrDesc);
  nCount1 := nCount1 + 1;
  if nCount1 > 1000 then
    nCount1 := 0;

  { After the first reset, update the graph every second }
  if not bFirstReset then begin
    if nCount1 = 11 then begin
      WRUpdateTimeLabels (pDynGrDesc, hTimeLabX, 1.0);
      bFirstReset := TRUE;
      nCount1 := 0;
    end;
  end
  else
    if nCount1  mod  2 = 0 then
      WRUpdateTimeLabels (pDynGrDesc, hTimeLabX, 1.0);

  if not WGIsGraphDescValid (pDynGrDesc2) then
    exit ;
  rNewVals [0] := sin (rArg / (1050.0 - nCount1));
  rNewVals [1] := sin (rArg / 52.0) * (randreal) * 1.4;
  rNewVals [2] := cos (rArg / 60.0) * (randreal) * 0.5;
  rNewVals [3] := cos (rArg / 22.0) * (randreal) * 0.25;
  
  { Update data set thdata2 and scrolling lines in graph pDynGrDesc2 }
  WRUpdateData (thdata2, @rNewVals, pDynGrDesc2);
end;
{************************************************************************}


procedure  Timer2Routine;
var
        rNewVal, rArg:realtype;
begin
  WGStart ;

  if not WGIsGraphDescValid (pDynGrDesc3) then
    exit;

  rArg := M_PI * nCount2;
  rNewVal := cos (rArg / 24.0) / 4.0 + (randreal) * 0.2;
  WRUpdateData (thdata3, @rNewVal, pDynGrDesc3);
  nCount2 := nCount2 + 1;
  if nCount2 > 500 then
    nCount2 := 0;
end;

{*************************************************************************}

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var lpProcAbout: TFARPROC;
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
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

{*************************************************************************}
{*************************************************************************}

begin
 pDynGrDesc := nil;                   { Graph descriptors }
 pDynGrDesc2 := nil;
 pDynGrDesc3 := nil;
 pPageDesc1 := nil;

end.
