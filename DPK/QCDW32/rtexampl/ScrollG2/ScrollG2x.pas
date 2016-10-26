{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :  DynLineX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 3, 1998                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{                FEATURES OF THIS DEMO }
{ }
{  	Annunciators }
{ 		Timers }
{************************************************************}

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit ScrollG2x;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}


const
   NCH= 3;				// number of channels
   SAMPINT=  0.5;
VAR
              // global instance handle
  hScroll, hTimeLab: ARRAY[0..8] OF HGOBJ;
  hDataSet: HDATA;
  pDynGrDesc: ARRAY[0..8] OF PGRAPH_DEF;
  i: INTEGER;


{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs2 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G5 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G6 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP2G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP2G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP2G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
function randreal:realtype; forward;

{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
  WGCreatePage('PAGE1', { page ID string }
	 	thwnd,               { handle to the parent window }
		tInst,              { application instance handle }
		'DynLine',      { Window title string }
		@StartGraphs1,       { pointer to graph creation function }
		NIL,         { Name of page window menu in resource file }
		C_LIGHTGRAY,        { window background color }
		MM_ISOTR,         { window sizing mode }
		0,                 { window style - default }
                PAGE_EXACT,         { window initial size and position option }
		0, 0, 700, 500);    { initial window size and position }
					{ if used (not used here) }
  WGCreatePage('PAGE2', { page ID string }
	 	thwnd,               { handle to the parent window }
		tInst,              { application instance handle }
		'DynLine',      { Window title string }
		@StartGraphs2,       { pointer to graph creation function }
		NIL,         { Name of page window menu in resource file }
		C_LIGHTGRAY,        { window background color }
		MM_ISOTR,         { window sizing mode }
		0,                 { window style - default }
                PAGE_EXACT,         { window initial size and position option }
		0, 0, 700, 500);    { initial window size and position }
					{ if used (not used here) }

END;

procedure WM_DestroyGraph;
begin
  WRCleanup(TRUE); 		{ clean up charting tools memory }
  PostQuitMessage(0);
end;


{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
VAR nHistSize: INTEGER;
BEGIN
	WGStart;
	nHistSize := 400;
	hDataSet := WRDefineDynDataSet ('Data', 3, 'volts', NIL, nHistSize);

	pDynGrDesc[0] := WGCreateGraph (pPageDesc,
		 @DrawP1G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.5, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[1] := WGCreateGraph (pPageDesc,
		 @DrawP1G2, 	   // points to function which builds graph
		 0.005, 0.34, // window relative position inside parent page window
		 0.5, 0.66,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[2] := WGCreateGraph (pPageDesc,
		 @DrawP1G3, 	   // points to function which builds graph
		 0.005, 0.67, // window relative position inside parent page window
		 0.5, 0.995,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[3] := WGCreateGraph (pPageDesc,
		 @DrawP1G4, 	   // points to function which builds graph
		 0.51, 0.005, // window relative position inside parent page window
		 1.0, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[4] := WGCreateGraph (pPageDesc,
		 @DrawP1G5, 	   // points to function which builds graph
		 0.51, 0.34, // window relative position inside parent page window
		 1.0, 0.66,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[5] := WGCreateGraph (pPageDesc,
		 @DrawP1G6, 	   // points to function which builds graph
		 0.51, 0.67, // window relative position inside parent page window
		 1.0, 0.995,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels



END;

procedure StartGraphs2 (pPageDesc: PPAGE_DEF);
BEGIN
	  // Initialize graph
	pDynGrDesc[6] := WGCreateGraph (pPageDesc,
		 @DrawP2G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.33, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels

	pDynGrDesc[7] := WGCreateGraph (pPageDesc,
		 @DrawP2G2, 	   // points to function which builds graph
		 0.34, 0.005, // window relative position inside parent page window
		 0.66, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[8] := WGCreateGraph (pPageDesc,
		 @DrawP2G3, 	   // points to function which builds graph
		 0.67, 0.005, // window relative position inside parent page window
		 0.995, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
END;

//	Builds the graph using Q-C Windows Charting Calls

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;
BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
  	// allocate array for tags
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 50.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[0] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Combo Graph');

	// assign each line style, width and color
	FOR i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_FILLEDLINE;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[0] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,
			rResetInt,
			OR_HORZ,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.5, 0.0,
	                0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll[0],
						  hAlarmLines);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[0], hScroll[0]);

END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;
BEGIN
  	nTraces := NCH;
        nGridUpdate:=1;


	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 10.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 2.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[1] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Scroll Multibar');

	// assign each line style, width and color
	for i := 0 TO nTraces - 1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := MK_BAR;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_LIGHTRED;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[1] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[1], hScroll[1]);

END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);

VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;

	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 25.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 5.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[2] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Sweep Combo');

	// assign each line style, width and color
	for i:=0 TO nTraces - 1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_BAR;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[2] := WRSetSweepComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,
			OR_HORZ,
			C_WHITE,
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.5, 0.0,
	        0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);

	WRSetScrollChannelAlarmColors( pGrDesc,
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[2], hScroll[2]);

END;

procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);

VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 50.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, rXRange, 2.0, 0.0 ,-2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, rXRange + 0.02, 2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[3] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Combo Graph - Inverted X and Y');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_FILLEDLINE;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[3] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.5, 0.0,
	        0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll[0],
						  hAlarmLines);


	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[3], hScroll[3]);

END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G5 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 10.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 2.0, rXRange, -2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 2.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[4] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Scroll Multibar - Inverted Y');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := MK_BAR;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_LIGHTRED;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[4] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[4], hScroll[4]);

END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G6 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;

   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 25.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, rXRange, -2.0, 0.0, 2.0);

	// set X intercepts to -0.02 so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, rXRange, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 5.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[5] := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Sweep Combo - Inverted X');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_BAR;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[5] := WRSetSweepComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,						
			OR_HORZ,
			C_WHITE,
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.5, 0.0,
	        0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[5], hScroll[5]);

END;



procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;

   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.25, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisY := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[6] := WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Combo Graph');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_FILLEDLINE;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[6] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,
			rResetInt,					
			OR_VERT,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.5, 0.0,
	        0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_VERT,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc,
						 hScroll[0],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[6], hScroll[6]);

END;

procedure DrawP2G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;

   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.25, 0.15, 0.86, 0.85, C_BLACK);

	rXRange := 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisY := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[7] := WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Scroll Multibar');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := MK_BAR;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_LIGHTRED;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[7] := WRSetScrollComboGraph (pGrDesc,	
			hDataSet,                          
			rSampleInt,						
			rResetInt,
			OR_VERT,		
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[7], hScroll[7]);

END;

procedure DrawP2G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hAlarmLines: HGOBJ;
   lpTags: ARRAY[0..NCH*DYN_MAXVAL-1] OF Char;
   rResetInt, rLow, rHigh,
   rXRange, rSampleInt: realtype;
   nLineColor ,
   nLineWidth ,
   nScatterSym,
   nScatterSize,
   nScatterStyle: ARRAY[0..NCH-1] OF Integer;
   nAlarmLineColors: ARRAY[0..4] OF INTEGER;
   i, nGridUpdate: INTEGER;
   bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
   nTraces: INTEGER;

BEGIN
	nTraces := NCH;
        nGridUpdate:=1;
	lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.25, 0.15, 0.85, 0.85, C_BLACK);

	rXRange := 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 6, TEXT_ITAL OR TEXT_BOLD);

	hAxisY := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[8] := WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, 'LL');

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Sweep Combo');

	// assign each line style, width and color
	for i:=0 TO nTraces-1 DO
	BEGIN
		nLineWidth [i] := 0;
		nScatterSize[i] := 6;
		nScatterSym[i] := i;
		nScatterStyle[i] := MKS_EMPTY;
		nLineColor[i] := 8 + i;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;
	nScatterSym[0] := MK_BAR;
	nScatterSym[1] := MK_NONE;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

hScroll[8] := WRSetSweepComboGraph (pGrDesc,
			hDataSet,
			rSampleInt,						
			OR_VERT,
			C_WHITE,
			@nScatterSym,
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nScatterStyle,
			0.35, 0.0,
	        0.01);

	rLow := -1.4;
	rHigh := 1.4;

    WRSetAlarm (hDataSet, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (hDataSet, ALM_HIGH, rHigh, 'HIGH');
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nAlarmLineColors[0] := C_WHITE;
	nAlarmLineColors[1] := C_LIGHTRED;
	nAlarmLineColors[2] := C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines := WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hDataSet,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);

	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[8], hScroll[8]);

END;



{************************************************************************}
const
 nCount: INTEGER = 1;
 nCount2 :INTEGER = 1;
PROCEDURE  TimerRoutine;
VAR
 rArg: realtype;
 rNewVals: ARRAY [0..DYN_MAXVAL-1] OF Realtype;
BEGIN
	if (NOT(WGIsGraphDescValid (pDynGrDesc[0]))) THEN
	 exit;

	rArg := M_PI * nCount;

	rNewVals [0] := 1.9 * sin (rArg / (200.0 - nCount MOD 200)) ;
	rNewVals [1] := 1.8 * sin (rArg / 52.0) * (randreal) * 1.1;
	rNewVals [2] := 1.6 *cos (rArg / 60.0) * (randreal/1.4) * 1.6;

        nCount := nCount + 1;
	if (nCount > 1000) THEN
		nCount := 0;
	WRUpdateData (hDataSet, @rNewVals, NIL);

END;
{************************************************************************}

begin
  for i := 0 TO 8 DO
  pDynGrDesc[i] := NIL;
end.

