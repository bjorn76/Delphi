{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ACQDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{************************************************************}
{  THIS EXAMPLE PROGRAMS SHOWS HOW TO USE: }
{ }
{  Auto Scrolling graphs }
{  Push buttons }
{  Messages }
{	Static and dynamic Data sets }
{ 	Timers }
{ }
{  In this program 300 samples for 3 channels are collected }
{  and displayed in real time. Message 'WAIT' flashes while }
{  the data is acquired. When it is finished, you will see }
{  message 'READY'. Now you can press the button 'Start'.  }
{  Data arrays for all three channels are copied to static }
{  data set arrays and plotted as static line plots. These plots  }
{  can be edited. }
{************************************************************}
{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Acqdemox;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;
const
  NUMSAMP =  300;       { number of samples to collect }

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
function TimerRoutine: INTEGER;

implementation

{$R rtdemo}

const
  ncount: INTEGER = 0;
  PERIOD  =  0.05;      { timer period, in seconds }
  NT      =    3;       { number of traces }

VAR
thInst: THandle;
thData: HDATA;              { dynamic data set handle }
hBut,               { button control handle }
hPlot1, hPlot2, hPlot3: HGOBJ;  { static plot handles }
TiEnable: BOOLEAN;

hX, hY1, hY2, hY3: HGLOBAL;   { global memory handles to data arrays }
lpX, lpY1, lpY2, lpY3: LPREAL; { pointers to data arrays }
pDynGrDesc :PGRAPH_DEF;	{ dynamic graph }
pStatGrDesc :PGRAPH_DEF;	{ static graph }
lpPButControlProc: TFARPROC;



{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
  state, dum: INTEGER); stdcall; forward;
{$endif}

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
function randreal:realtype; forward;


procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN

		 { page is created in the current window }
    WGCreatePage('PAGE1', { page ID string }
            thwnd,               { handle to the parent window }
    	    tInst,              { application instance handle  }
    	   'Data Acquisition Example',      { Window title string }
    	    @StartGraphs1,       { pointer to graph creation function }
      	    'PageMenu',         { Name of page window menu in resource file }
	     C_LIGHTGRAY,        { window background color }
      	    MM_PROPORT,         { window sizing mode }
	    WS_CHILD OR WS_CLIPCHILDREN OR WS_VISIBLE,                 { window style}
		PAGE_FULL,          { window initial size and position option }
	        0, 0, 0, 0);
 TiEnable := TRUE;
            { start 0.1 second timer }
END;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var  lpProcAbout: TFarProc; {  pointer to the 'AboutProc' function  }
begin
    lpProcAbout := MakeProcInstance (@AboutProc, tinst);
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            lpProcAbout);              {  AboutProc() instance address  }
    FreeProcInstance (lpProcAbout);

end;

procedure WM_DestroyGraph;
begin
  TiEnable := FALSE;
  FreeMem(lpX,sizeof (realtype) * NUMSAMP);
  FreeMem(lpY1,sizeof (realtype) * NUMSAMP);
  FreeMem(lpY2,sizeof (realtype) * NUMSAMP);
  FreeMem(lpY3,sizeof (realtype) * NUMSAMP);
  WRCleanup(FALSE); 	{ clean up charting tools memory }
			{ and free data arrays }
  PostQuitMessage(0);
end;


{*********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
var i: INTEGER;
BEGIN

    { allocate global data arrays }
    for i := 0 TO NUMSAMP-1 DO { initialize to 0}
    BEGIN
      WGPutPntrReal (lpX,i,0.0);
      WGPutPntrReal (lpY1,i,0.0);
      WGPutPntrReal (lpY2,i,0.0);
      WGPutPntrReal (lpY3,i,0.0);
    END;
    { get pointers to data arrays }
{    lpX :=  GlobalLock(hX);
    lpY1 :=  GlobalLock(hY1);
    lpY2 :=  GlobalLock(hY2);
    lpY3 :=  GlobalLock(hY3);
}
    WGToggleGridsOrder (TRUE);      { force grids under plots for speed }

      { Initialize graph }
	pDynGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G1,      { points to function which builds graph }
		 0.005, 0.005,  { window relative position inside parent page window }
		 0.95, 0.5,
		 C_LIGHTGRAY,
		 C_BLACK,
		 1);      { border width in pixels }

	pStatGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G2, 	  { points to function which builds graph }
		 0.005, 0.51, { window relative position inside parent page window }
		 0.95, 0.99,
		 C_BROWN,
		 C_BLUE, 2);
END;

{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}
{ dynamic display }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
     szTags: ARRAY[0..NT * TAGLEN-1] OF CHAR;
     nMesColor: ARRAY[0..2] OF INTEGER;
     nLineColor: ARRAY[0..NT-1] OF INTEGER;
     rSampleInt, rRelResetInt:realtype;
     hScr: ARRAY[0..AS_NH-1] OF HGOBJ;
     nBinChanNum:INTEGER;   { Binary channel # for 1st message }
     nBorderColor:INTEGER;  { color of text rectangle border, -1 - no border }
     nBackColor:INTEGER;    { background color, -1 - transparent }
     nNumMes:INTEGER;       { Number of messages }
     lpMes: LPSTR;         { messages }
BEGIN
	WGRaiseGraph (pGrDesc, 1);      { show graph as raised }

	{ assign colors for each trace }
	nLineColor[0] := C_RED;
	nLineColor[1] := C_MAGENTA;
	nLineColor[2] := C_GREEN;

 	{ initialize tags }
	lstrcpy(szTags,  'ONE');
	lstrcpy(szTags + TAGLEN, 'TWO ');
	lstrcpy(szTags + 2 * TAGLEN,  'THREE');

	{ define dynamic data set with history buffer for NUMSAMP samples }
	thData := WRDefineDynDataSet ('Live Data', NT, 'volts', szTags, NUMSAMP);

	rSampleInt := PERIOD;        { sample interval }
	rRelResetInt := 0.8;

	WGSetTextByName (C_CYAN, 'Arial', 12, TEXT_BOLD);

    { create scrolling lines, axes, labels, dynamic text  }
	WRSetAutoScrollGraph (pGrDesc,
	    thData,                  { data set handle }
		rSampleInt, rRelResetInt,
		-2.0, 2.0,              { Y range }
		10.0,                   { X range, seconds }
		GOD_SUBT_SCLINE,        { scrolling lines subtype }
		2,                      { dynamic text precision }
		0.0,   { setp          { no alarm lines }
		0.0,   { high }
		0.0,   { low }
		'Seconds',              { X-axis title }
		C_WHITE,                { plotting area color }
		@nLineColor,             { trace colors }
		TRUE,                   { show dynamic text }
		@hScr);                  { array of object handles }

    { change color of Y-axis }
	WGChangeTextColor (pGrDesc, hScr[ASH_YTIT], C_RED);

	{ message parameters }
	nBinChanNum := 0;
	nBorderColor := C_YELLOW;
	nBackColor := C_BLUE;
	nNumMes := 3;

    { initialize text for messages }
        GetMem (lpMes,MAX_MESLEN * nNumMes);
	lstrcpy(lpMes,  'WAIT');
	lstrcpy(lpMes + MAX_MESLEN,  '     ');
	lstrcpy(lpMes + 2 * MAX_MESLEN,  'READY');

    { message text colors }
	nMesColor [0] := C_LIGHTRED;
	nMesColor [1] := C_LIGHTGRAY;
	nMesColor [2] := C_GREEN;

	WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD);
	{ create message object }
	WRSetMessage (pGrDesc, thData, nBinChanNum, 0.82, 0.78,
		nBorderColor, 1, nBackColor,
		nNumMes, lpMes, @nMesColor);
	freemem (lpMes, MAX_MESLEN * nNumMes);
END;
{*************************************************************************}
{ static display }

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
    hAxisX, hAxisY: HGOBJ;
    hDataSet1, hDataSet2, hDataSet3: HDATA;        { static data set handles }
BEGIN
	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.07, 0.2, 0.95, 0.88, C_LIGHTGRAY);
	WGScalePlotArea (pGrDesc, 0.0, -2.0, NUMSAMP * PERIOD, 2.0);
	{ set the intercepts }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	WGSetTextParams (C_BLUE, FF_MODERN, 12, TEXT_BOLD );
	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Static Display of Collected Data');

    { create instance of button processing function }
	lpPButControlProc := @PButtonControlProc;

    { button text parameters }
	WGSetTextParams (C_BLACK, FF_ROMAN, 8, TEXT_BOLD );
    { create green push button }
	hBut := WRSetButtonControl (pGrDesc, lpPButControlProc,
		BC_STYLE_PUSH, BC_LOOK_LOW,
		0.87, 0.03, 0.97, 0.13, WGGetRGBColor (C_GREEN), 'START', FALSE);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
	hAxisX := WGDrawXAxis(pGrDesc, thdc, NUMSAMP * PERIOD / 8, 1, POS_BELOW);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 0.5, 4, POS_LEFT);

    { label axes }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_TEXT, 'Sec');
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_TEXT, 'V');

    { Draw major grid lines }
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_CYAN);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);
    { Draw minor grid lines }
    WGSetLineStyle(pGrDesc, thdc, PS_DOT, 0, C_CYAN);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MINOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MINOR);

    { define static data sets  }
    hDataSet1 := WGDefineDataSetPtr ('Channel 1', lpX, lpY1, NUMSAMP);
    hDataSet2 := WGDefineDataSetPtr ('Channel 2', lpX, lpY2, NUMSAMP);
    hDataSet3 := WGDefineDataSetPtr ('Channel 3', lpX, lpY3, NUMSAMP);

    { create dummy plots  }
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_RED);
    hPlot1 := WGLinePlot (pGrDesc, thdc, hDataSet1, FALSE, FALSE);
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_MAGENTA);
    hPlot2 := WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_GREEN);
    hPlot3 := WGLinePlot (pGrDesc, thdc, hDataSet3, FALSE, FALSE);
END;

{*********************************************************************}
{ random real number generator in the range of 0.0 to 1.0             }
{*********************************************************************}
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;
{*************************************************************************
	FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)

    PURPOSE:  Processes messages for 'About' dialog box

***************************************************************************}

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
{************************************************************************}
{ Timer procedure }

Function  TimerRoutine: INTEGER ;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY [0..NT-1] OF realtype;
	 nMesNum:INTEGER;
BEGIN
  if TiEnable THEN
  BEGIN
    { check if graph still exists }
	IF ( NOT WGIsGraphDescValid (pDynGrDesc)) THEN
		exit;
	WGStart;

	rArg := M_PI * nCount;
    { simulate data }
	rNewVals [0] := sin (rArg / (NUMSAMP + 10.0 - nCount)) * 1.8 ;
	rNewVals [1] := sin (rArg / 52.0) * 1.1 + randreal / 1.6;
	rNewVals [2] := cos (rArg / 20.0) * 1.5 + randreal / 5.0 ;
	IF ((nCount > 100) AND (nCount < 180)) THEN
		rNewVals [2]  := rNewVals[2] + sin (rArg / 3) * 0.4;
	IF (nCount = 320) THEN
		rNewVals [0] := rNewVals[0] + 0.7;   { spike }

	IF ((nCount  MOD  10 = 0)) THEN
	BEGIN   { flash message every 0.5 sec }


		IF ( ((nCount div 10)  MOD  2) = 0) THEN
			nMesNum := 1
		ELSE
			nMesNum := 0;

		WRSetBitExclusive (thData, nMesNum, pDynGrDesc);
	END;

	nCount:=  nCount + 1;
	IF (nCount > NUMSAMP) THEN
	BEGIN
		{ stop data collection }
{		KillTimer (NULLH, idTimer);
		idTimer := NULLH; }
        { switch to 'READY' message }
                TiEnable := FALSE;
		WRSetBitExclusive (thData, 2, pDynGrDesc);
	END;
	WRUpdateData (thData, @rNewVals, pDynGrDesc);
   END;
  TimerRoutine := ncount;
END;
{************************************************************************}
{ Button procedure ******************************************************}
{************************************************************************}
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER);
VAR
	   i:INTEGER;
BEGIN
	IF (NOT(TiEnable) AND (state <> 0)) THEN
	BEGIN	{ data collection finished, button is pressed }
        { generate X data for statioc data sets }
        FOR i := 0 TO NUMSAMP - 1 DO
        BEGIN
            WGPutPntrReal(lpX, i, PERIOD * i);
        END;

        { move channel 0 data to static data set array lpY1 }
        WRGetHistData (thData, 0, lpY1,
			NUMSAMP,   { index to first sample, 0 - latest }
			NUMSAMP);
		{ display it }
		WGRedrawObject (pStatGrDesc, hPlot1, TRUE);
		{ get channel 1 data }
		WRGetHistData (thData, 1, lpY2, NUMSAMP, NUMSAMP);
		WGRedrawObject (pStatGrDesc, hPlot2, TRUE);

		WRGetHistData (thData, 2, lpY3, NUMSAMP, NUMSAMP);
		WGRedrawObject (pStatGrDesc, hPlot3, TRUE);
	END;
END;
{************************************************************************}


begin
  pDynGrDesc := NIL;	 { Graph descriptors }
  pStatGrDesc := NIL;	{ static graph }
  TiEnable := FALSE;
  GetMem ( lpX,sizeof (realtype) * NUMSAMP);
  GetMem (lpY1, sizeof (realtype) * NUMSAMP);
  GetMem (lpY2, sizeof (realtype) * NUMSAMP);
  GetMem (lpY3, sizeof (realtype) * NUMSAMP);
 end.
