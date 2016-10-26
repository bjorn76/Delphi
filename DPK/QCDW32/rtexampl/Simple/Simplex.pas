{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SimpleX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 4                             *
 *   Product  :   Delphi R-T Graphics Tools for Windows *
 *                                                           **
 *************************************************************

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Simplex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}


const
  NCH=	 3;				// number of channels
  SAMPINT=  0.5;


VAR
  hDataSet: HDATA;
  pPageDesc1 :  PPAGE_DEF;

pDynGrDesc:  PGRAPH_DEF;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
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
				'Simple',      { Window title string }
	       			@StartGraphs1,       { pointer to graph creation function }
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
VAR
  nHistSize: INTEGER;
BEGIN

	  // Initialize graph
	WGStart;
	nHistSize := 400;
	hDataSet := WRDefineDynDataSet ('Data', 3, 'volts', NIL, nHistSize);

	pDynGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G1, 	   // points to function which builds graph
		 0.02, 0.02, // window relative position inside parent page window
		 0.98, 0.98,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
END;
{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
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
   hTimeLab, hScroll: HGOBJ;
 BEGIN
	nTraces := NCH;
        nGridUpdate:=1;

   lstrcpy(lpTags, 'First');

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange := 50.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, 'Arial', 9, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	for i := 0 TO nTraces -1 DO
	BEGIN
		nLineWidth [i] := 0;
	END;
	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTMAGENTA;
	nLineColor[2] := C_LIGHTCYAN;

	rSampleInt := SAMPINT;   rResetInt := 0.98;

    hScroll := WRSetScrollGraph (pGrDesc,
			hDataSet,
			rSampleInt,
			rResetInt,
			OR_HORZ,
			NO_STEP,
			NIL,
			@nLineWidth,
			@nLineColor);

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
			hDataset,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			@bFlags,					// enable/disable particular lines
			NIL,					// default style - PS_SOLID
			@nLineWidth,
			@nAlarmLineColors);

	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll,
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab, hScroll);
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
	if (NOT(WGIsGraphDescValid (pDynGrDesc))) THEN
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
  pPageDesc1 := NIL;
end.

