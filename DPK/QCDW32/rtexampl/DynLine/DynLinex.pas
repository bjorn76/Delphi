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

unit DynLinex;

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
  hScroll, hTimeLab: ARRAY[0..5] OF HGOBJ;
  hDataSet: HDATA;
  pDynGrDesc: ARRAY[0..5] OF PGRAPH_DEF;
  i: INTEGER;


{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G5 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G6 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
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
BEGIN
	  // Initialize graph
 	WGStart;
	hDataSet := WRDefineDynDataSet ('Data', 32, 'volts', NIL, 0);

	pDynGrDesc[0] := WGCreateGraph (pPageDesc,
		 @DrawP1G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.5, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);

 	// border width in pixels
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
		 1.0, 0.99,
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


//	Builds the graph using Q-C Windows Charting Calls

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
     hAxisX, hAxisY: HGOBJ;  // axes handles
     rXRange: realtype;
     nTraces: INTEGER;
BEGIN
        nTraces := NCH;
	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.8, C_BLACK);

	rXRange := 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);;
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
//	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  OR  TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Dynamic Line');

WRSetDynLineGraph ( pGrDesc,
        hDataSet,
          OR_VERT,       
		  NO_STEP,
          0.002,  
          31.998,
          1.0,        
	      PS_SOLID, 
	      3, 
	      RGB(0,255,0));
END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);

VAR
    hAxisX, hAxisY: HGOBJ;  // axes handles
     rXRange: realtype;
     nTraces: INTEGER;
BEGIN
        nTraces := NCH;
	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.8, C_BLACK);

	rXRange := 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 30.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);;
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');


	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
//	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  OR  TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Dynamic Line');

WRSetDynLineGraph ( pGrDesc,
        hDataSet,
          OR_VERT,       
		  STEP_NO_RISE_LINE,
          0.0,
          32.0,     
          0.9,
	      PS_SOLID, 
	      0,
	      RGB(255,255,0));
END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);

VAR
    i: INTEGER;
    nBarColor: ARRAY[0..31] OF INTEGER;
    hAxisX, hAxisY: HGOBJ;  // axes handles
     rXRange: realtype;
     nTraces: INTEGER;
BEGIN
        nTraces := NCH;

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.8, C_BLACK);

	rXRange := 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);;
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
//	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  OR  TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Dynamic Line');
	for i:=0 TO 31 DO
         nBarColor[i] := RGB(255, 255,0);

WRSetBargraph ( pGrDesc,  hDataSet,
	0.0, OR_VERT,
    0.002,
    31.998,
    0.8,       
    @nBarColor, NIL, NIL);
END;

procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);

VAR
    hAxisX, hAxisY: HGOBJ;  // axes handles
     rXRange: realtype;
     nTraces: INTEGER;
BEGIN
        nTraces := NCH;

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.8, C_BLACK);

	rXRange := 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, rXRange, 0.0, 0.0, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);;
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_RIGHT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_RIGHT, NF_DECIMAL, 1, LL_ON, '');
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
//	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  OR  TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Dynamic Line');

WRSetDynLineGraph ( pGrDesc,
        hDataSet,
          OR_VERT,
		  NO_STEP,
          0.002,  
          31.998,
          1.0,        
	      PS_SOLID, 
	      3, 
	      RGB(0,255,0));
END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G5 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR

    hAxisX, hAxisY: HGOBJ;  // axes handles
     rXRange: realtype;
     nTraces: INTEGER;
BEGIN
        nTraces := NCH;

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.8, C_BLACK);

	rXRange := 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 25, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);;
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');


	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
//	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD  OR  TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'Dynamic Line');

WRSetDynLineGraph ( pGrDesc,
        hDataSet,
          OR_HORZ,       
		  STEP_START,
          0.1,  
          31.99,
          1.0,
	      PS_SOLID, 
	      0, 
	      RGB(255,255,0));
END;

//*******************************************************
//	Builds the graph using Q-C Windows Charting Calls
//********************************************************/
procedure DrawP1G6 (pGrDesc: PGRAPH_DEF; thdc: HDC);
BEGIN

END;

{************************************************************************}
const
 nCount: INTEGER = 1;
PROCEDURE  TimerRoutine;
VAR
  rArg:realtype;
  rNewVals: ARRAY [0..31] OF realtype;
  i: INTEGER;
BEGIN
	if (NOT(WGIsGraphDescValid (pDynGrDesc[0]))) THEN
		exit;

	rArg := M_PI * nCount;

	for i:=0 TO 31 DO
	BEGIN
	  rNewVals [i] := 10 + 10 * sin (rArg / (200.0 - nCount MOD 200)) ;
	  nCount:= nCount + 1;
	END;
	if (nCount > 1000) THEN
		nCount := 0;
	WRUpdateData (hDataSet, @rNewVals, NIL);

END;
{************************************************************************}

begin
  for i := 0 TO 5 DO
  pDynGrDesc[i] := NIL;
end.

