{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   EKGX.PAS                                    *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{************************************************************}
{                FEATURES OF THIS DEMO }
{ }
{  	Scroll Graphs - horizontal }
{		Bar Graph - vertical }
{		Meters - needle }
{		Buttons - push }
{		Scroll Bars }
{		Check Boxes }
{		Dynamic Text }
{		Dynamic Legends }
{		Dynamic Grids }
{		Dynamic Data sets }
{ 	    Timers }
{		Page Window is created as a child of the Main Window }
{		The mapping mode is set to isotropic to maintain the aspect ratio }
{		for the window. Otherwise, when the window is resized, the meters }
{		would not maintain the aspect ratio and would appear oval or stretched. }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Ekgx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

{$R rtdemo}
procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_ResizeGraph( x,y: INTEGER);
procedure WM_DestroyGraph;
procedure TimerRoutine;
implementation


const
  ncount: INTEGER = 0;
  NUMP  = 200;
  NCHAN =   3;

VAR

hDataHeart, hDataBrain, { Data handles for heart AND brain wave }
hDataBP, hDataO2Meter, hDataCO2Meter, hDataDiast,{ Data handles }
hBarData: HDATA;
hTimeLab, hBarGraph: HGOBJ;				{ Handle to time axis labels }
tinstance: HWND;

rEKGData: ARRAY[0..24] OF Realtype;
pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3,
pDynGrDesc4: PGRAPH_DEF;

hTags: HGLOBAL;
lpButtonTags: LPSTR;
lpButtonControlProc: TFARPROC;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
FUNCTION randsmall:REALTYPE; forward;

{$ifndef WIN32}
PROCEDURE  ButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 nSel, dum: INTEGER); export; forward;
{$else}
PROCEDURE  ButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 nSel, dum: INTEGER); stdcall; forward;
{$endif}




const
  pPageDesc :  PPAGE_DEF = NIL;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
 tinstance := tinst;
 pPageDesc := WGCreatePage('PAGE1', { page ID string }
 thwnd,			{ handle to the parent window }
 tInst,			{ application instance handle }
 'Biomedical',	{ Window title string }
 @StartGraphs1,	{ pointer to graph creation function }
 NIL,			{ Name of page window menu in resource file }
 C_GRAY,			{ window background color }
 MM_FIXED,		{ window sizing mode }
WS_CHILD OR WS_CLIPCHILDREN OR WS_VISIBLE, { window style }
 PAGE_CLIENT,
 0, 0, 0, 0);   { initial window size and position }
END;

procedure WM_ResizeGraph( x,y: INTEGER);
var
     hwndPage: HWND;
begin
  hwndPage := WGGetPageWindow (pPageDesc);
  SetWindowPos (hwndPage, NULLH, 0, 0,
  		 x, y,
  		 SWP_NOMOVE OR SWP_NOZORDER);

end;

procedure WM_DestroyGraph;
begin
  FreeProcInstance (lpButtonControlProc);
  WRCleanup(TRUE); 		{ clean up charting tools memory }
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
VAR
	 i:INTEGER;
BEGIN
	{ Create the 'data' for the EKG }
	rEKGData[0] := 0.001; rEKGData[1] := 0.6; rEKGData[2] := 0.75;  rEKGData[3] := 0.6;
	rEKGData[4] := -0.15; rEKGData[5] := -0.20; rEKGData[6] := -0.175; rEKGData[7] := 0.15;
	rEKGData[8] := 0.2;   rEKGData[9] := 0.175; rEKGData[10] := 0.001; rEKGData[11] := 0.001;
	rEKGData[12] := 0.025; rEKGData[13] := 0.035; rEKGData[14] := 0.025;
	FOR i := 15 TO 24 DO
          rEKGData[i] := 0.05 * randsmall+0.001;

	pDynGrDesc := WGCreateGraph (pPageDesc, @DrawP1G1,
		0.01, 0.01, 0.5, 0.6, C_GREEN, -1,	1);

	{ Initialize graphs for a single page }
	pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
		0.01, 0.61, 0.5, 0.99,
		C_GREEN, -1, 1);

	pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
		0.51, 0.01,	0.99, 0.75,
		C_LIGHTGRAY, C_BLACK, 2);

	pDynGrDesc4 := WGCreateGraph (pPageDesc, @DrawP1G4,
		0.51, 0.76, 0.99, 0.99,
		C_LIGHTGRAY, C_BLACK, 2);

	WGToggleSelectors (pPageDesc, FALSE);
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
{ Create the EKG Window }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY,  { axes handles }
	hScrollG1,
	hAxis2: HGOBJ;
	bFlags: ARRAY [0..NALMLINES-1] OF WORDBOOL;
	nLineColor: ARRAY[0..NALMLINES-1] OF INTEGER;
	nLineWidth: ARRAY[0..NALMLINES-1] OF INTEGER;
	nLineStyle: ARRAY[0..NALMLINES-1] OF INTEGER;
         nChannels:INTEGER;
	 rSampleInt, rResetInt:realtype;
	 rHigh, rLow, rSetp:realtype;
BEGIN
        nChannels := 1;
	WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.007, 0.99, 0.992,
			C_LIGHTGREEN, 3, FALSE, WGGetRGBColor (C_YELLOW), RC_3DBORDER);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.25, 0.17, 0.83, 0.73, C_BLACK);

	{ scale the plotting are for an x range of 0 to 10.0 }
	{ and y range of -1 to 1 }
	WGScalePlotArea (pGrDesc, 0.0, -1.0, 10.0, 1.0);

	{ set the intercepts to 0, -1 }
	WGSetXYIntercepts (pGrDesc, 0.0, -1.0);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_BLACK, 'Arial', 8, 0);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTMAGENTA);

	{ draw the x time axis with major ticks every 5 seconds and 1 minor tick }
	hAxisX := WRDrawTimeAxis (pGrDesc, 5.0, 1, POS_MIDDLE, OR_HORZ, AXU_SEC);

	hTimeLab := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_MS, 0, 0, 0,
        0, 0.0, LL_ON, NIL);

	{ draw the y axis with major ticks every 0.5 physical units and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 0.5, 1, POS_LEFT);

	{ set current font  }
	WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_ITAL);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ set the intercepts to 10, -1 }
	WGSetXYIntercepts (pGrDesc, 10.0, -1.0);
	hAxis2 := WGDrawYAxis(pGrDesc, thdc, 0.5, 1, POS_RIGHT);

	WGSetTextByName (C_BLACK, 'Arial', 8, 0);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxis2, POS_RIGHT, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetTextByName (C_YELLOW, 'Arial', 14, TEXT_BOLD OR TEXT_ITAL);
	WGTitleGraph(pGrDesc, thdc, 'EKG');

	{ Write axis title }
	WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD OR TEXT_ITAL);
	WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Normalized');

	{ define a dynamic data set }
	hDataHeart := WRDefineDynDataSet ('HeartRate', nChannels, 'volts', NIL, 0);

	nLineStyle [0] := PS_SOLID;
	nLineWidth [0] := 2;
	nLineColor [0] := C_YELLOW;

	rSampleInt := 0.1;   rResetInt := 0.5;

	{ define a horizontal real time scroll graph }
	hScrollG1 := WRSetScrollGraph (pGrDesc,	{ pointer to graph descriptor }
			hDataHeart,				{ handle to dynamic data set }
			rSampleInt,			{ time between adjacent samples }
			rResetInt,				{ relative reset interval }
			OR_HORZ,				{ direction of graph is horizontal }
			NO_STEP,				{ linear interp. }
			@nLineStyle,			{ line styles for traces }
			@nLineWidth,			{ line widths for traces }
			@nLineColor);			{ line colors for traces }

	{ assign alarm and setpoint values }
	rHigh := 0.8; 		{ high }
	rLow := -0.8;		{ low }
	rSetp := 0.0;		{ Setpo }

	WRSetAlarm (hDataHeart, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataHeart, ALM_LOW,  rLow, 'LOW');
	WRSetSetpoint (hDataHeart, rSetp);

	{ alarm line on/off flags }
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	nLineColor[0] := C_YELLOW;
	nLineColor[1] := C_LIGHTRED;
	nLineColor[2] := C_LIGHTBLUE;

	nLineStyle [1] := PS_SOLID;
	nLineStyle [2] := PS_SOLID;

	nLineWidth [0] := 1;
	nLineWidth [1] := 1;
	nLineWidth [2] := 1;

	{ draw setpoint, low, and high alarm lines }
	WRSetAlarmLines (pGrDesc,	{ pointer to graph descriptor }
			hDataHeart,				{ handle to dynamic data set }
			2,							{ 2 second update rate }
			OR_HORZ,					{ horizontal alarm lines }
			@bFlags,					{ enable desired lines }
			@nLineStyle,				{ line styles }
			@nLineWidth,				{ line widths }
			@nLineColor);			    { line colors }

	{ set current font to Arial, 8 points, bold, italic }
	WGSetTextByName (C_YELLOW, 'Arial', 8, TEXT_BOLD);

	WRSetDynText (pGrDesc,		{ pointer to graph descriptor }
			hDataHeart,				{ handle to dynamic data set }
			0,						{ display channel 0 }
			0.5, 0.84, 0.7, 0.96,   { position of dyn text rectangle }
			C_GREEN,				{ border color }
			1,						{ border width }
			NIL,					{ use colors of hScrollG1 }
			C_BLACK,				{ background color }
			OR_HORZ,				{ layout for dyn strings }
			4,						{ max # of chars for ea. field }
			2,						{ # digits after decimal point }
			hScrollG1,				{ use colors from scroll graph for text color }
			RC_3DBORDER);			{ display 3D border around perimeter }

END;

{******************************************************************************}
{ Create brain wave window }
{******************************************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;  { axes handles }
	bFlags: ARRAY [0..NALMLINES-1] OF WORDBOOL;
        nLineColor:INTEGER;
        nLineStyle:INTEGER;
        nLineWidth:INTEGER;
        nChannels: INTEGER;
	rSampleInt, rResetInt:realtype;
	rHigh, rLow, rSetp:realtype;
BEGIN
        nChannels := 1;
	WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.007, 0.99, 0.992,
			C_LIGHTGREEN, 3, FALSE, WGGetRGBColor (C_YELLOW), RC_3DBORDER);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.25, 0.19, 0.9, 0.80, C_BLACK);

	{ scale the plotting area }
	WGScalePlotArea (pGrDesc, 0.0, -1.0, 10.0, 1.0);

	{ set the intercepts  }
	WGSetXYIntercepts (pGrDesc, 0.0, -1.0);

	{ set current font to Arial, 6 points }
	WGSetTextByName (C_BLACK, 'Arial', 6, 0);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);

	hAxisX := WRDrawTimeAxis (pGrDesc, 5.0, 1, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hTimeLab := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_MS, 0, 0, 0, 0, 0.0,
		LL_ON, NIL);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 0.5, 1, POS_LEFT);
	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_YELLOW, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);
	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Brainwave');

	WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD OR TEXT_ITAL);
	{ Write axis title }
	WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Normalized');

	{**************************************************************** }
	{ now define the dynamic portion of the graph }

	{ define a dynamic data set }
	hDataBrain := WRDefineDynDataSet ('BrainWave', nChannels, 'norm', NIL, 0);

	nLineStyle := PS_SOLID;
	nLineWidth := 2;
	nLineColor := C_YELLOW;

	{ values for limits }
	rSampleInt := 0.1;   rResetInt := 0.5;

	{ define a horizontal real time scroll graph }
	WRSetScrollGraph (pGrDesc, hDataBrain, rSampleInt, rResetInt,
		OR_HORZ, NO_STEP, @nLineStyle, @nLineWidth, @nLineColor);

	{ assign alarm values }
	rHigh := 0.8; 		{ high }
	rLow := -0.8;		{ low }
	rSetp := 0.1;		{ Setpo }

	{ set the hi, lo and setpoint values }
	WRSetAlarm (hDataBrain, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataBrain, ALM_LOW,  rLow, 'LOW');
	WRSetSetpoint (hDataBrain, rSetp);

	{ alarm line state on/off }
	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	{ draw setpoint, low, and high alarm lines }
	WRSetAlarmLines (pGrDesc,	{ pointer to graph descriptor }
			hDataBrain,		{ handle to dynamic data set }
			2,					{ 2 second update rate }
			OR_HORZ,			{ horizontal alarm lines }
			@bFlags,			{ enable desired lines }
			NIL, NIL, NIL); { use defaults }
END;
{************************************************************************}

{ display meters, bargraph, and dyn text }

procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisY: HGOBJ;  { axes handles }
	nChannels:INTEGER;
        nColor :INTEGER;
        nBarTraces:INTEGER;
	nBarStyle, nTextColor: INTEGER;
	nAlmColor: ARRAY[0..2] OF INTEGER;
        rXCenter, rYCenter, rDiam :realtype;
        rLow, rHigh:realtype;
	nBarColor: TCOLORREF;
BEGIN
        nChannels := 1;
        nBarTraces := 1;
	WGRectangleNormEx (pGrDesc, thdc, 0.02, 0.02, 0.97, 0.97,
		C_MEDGRAY, 3, FALSE, WGGetRGBColor (C_MEDGRAY), RC_3DBORDER);

	hDataO2Meter := WRDefineDynDataSet ('O2', nChannels, 'O2', NIL, 0);

	rHigh := 8.0;
	rLow := 2.0;
	WRSetAlarm (hDataO2Meter, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataO2Meter, ALM_LOW,  rLow, 'LOW ALARM');

	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);
	WGTextNorm (pGrDesc, thdc, 'Vitals', 0.5, 0.1, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);

	WGSetTextByName (C_BLACK, 'Arial', 6, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
	rYCenter := 0.35;
	rXCenter := 0.3;
	rDiam := 0.4;
	nColor := C_LIGHTBLUE;
	nAlmColor[0] := C_WHITE;
	nAlmColor[1] := C_LIGHTRED;
	nAlmColor[2] := C_LIGHTCYAN;

	WRSetMeter (pGrDesc,	    { pointer to graph descriptor }
		hDataO2Meter,			{ handle to data set }
		-1,						{ display all channels }
		10.0, 0.0,        		{ Physical range from 0.0 to 10.0 }
		rXCenter, rYCenter,		{ relative x, y coords for center point }
		rDiam,					{ relative diameter }
		90, 270,				{ arc is drawn from 30 to 150 degrees }
		NEEDLE_LONGF,			{ needle type }
		@nColor,					{ needle colors }
		0.06,					{ tick length }
		5.0,					{ tick spacing }
		2,						{ 2 minor ticks }
		POS_INSIDE,				{ display ticks inside scale arc }
		POS_INSIDE,				{ display labels outside scale arc }
		0,						{ 0 digits after decimal point }
		FALSE,
		0,
		TRUE,       			{ display scale arc }
		TRUE,        			{ display units string }
		TRUE,                   { display alarm arcs }
		0.08,
		@nAlmColor);

	hDataCO2Meter := WRDefineDynDataSet ('CO2', nChannels, 'CO2', NIL, 0);

	rHigh := 9.0;
	rLow := 2.5;
	WRSetAlarm (hDataCO2Meter, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataCO2Meter, ALM_LOW,  rLow, 'LOW');

	WGSetTextByName (C_BLACK, 'Arial', 6, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_BLACK);
	rYCenter := 0.35;
	rXCenter := 0.7;
	rDiam := 0.4;
	nColor := C_LIGHTRED;

	WRSetMeter (pGrDesc,
		hDataCO2Meter,
		-1,							{ plot all channels }
		0.0, 10.0,        			{ Physical range from 0.0 to 10.0 }
		rXCenter, rYCenter,		{ relative x coord for center point }
		rDiam,						{ relative diameter }
		-90, 90,					{ meter arc scale is drawn from -90 to 90 degrees }
		NEEDLE_LONGF,				{ needle type }
		@nColor,					{ needle color }
		0.06,						{ tick length }
		5,							{ tick spacing in phys. units }
		2,							{ 2 minor ticks }
		POS_INSIDE,				{ display ticks inside arc }
		POS_INSIDE,				{ display ticks outside arc }
		0,							{ 0 digits after decimal point }
		FALSE,
		0,
		TRUE,       				{ display scale arc }
		TRUE,        				{ display units string }
		TRUE,                    	{ display alarm marks }
		0.08,
		@nAlmColor);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.23, 0.62, 0.26, 0.80, C_BLACK);

	{ scale the plotting area for an x range of 0 to 1.0 }
	{ and y range of 50.0 to 125.0 }
	WGScalePlotArea (pGrDesc, 0.0, 50.0, 1.0, 125.0);

	{ set the intercepts to 0.0, 50.0 }
	WGSetXYIntercepts (pGrDesc, 0.0, 50.0);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTGRAY);
	{ draw the y axis with major ticks every 50.0 physical coords and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 50.0, 1, POS_LEFT);

	{ set current font to Arial, 6 points }
	WGSetTextByName (C_RED, 'Arial', 6, 0);
	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ Assign each line style, width and color for the scroll graph }
	nBarColor := WGGetRGBColor (C_LIGHTRED);
	nBarStyle := -1;

	{ Define a dynamic data set }
	hBarData := WRDefineDynDataSet ('Bar 1', nBarTraces, 'volts', NIL, 0);
	hBarGraph := WRSetBargraph (pGrDesc,	{ pointer to graph descriptor }
			hBarData,			{ handle to bar graph }
			0.0,				{ center for bar at 0.0 }
			OR_VERT,			{ vertical bar }
			0.5,				{ start X-value of first bar  }
			0.0,				{ ignored, since only 1 bar }
			1.0,				{ width of bar }
			@nBarColor,   		{ bar color }
			@nBarStyle,			{ bar hatch style }
			NIL);				{ no bar border }

	WGEllipseNorm (pGrDesc, thdc, 0.22, 0.78, 0.27, 0.84, -1, 1, TRUE,
		 WGGetRGBColor (C_LIGHTRED));

	{ Display dynamic values for all traces in the dynamic data set. }
	{ set current font to Arial, 10 points }
	WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);
	nTextColor := C_YELLOW;

	WRSetDynText (pGrDesc, hBarData, 0, 0.15, 0.845, 0.35, 0.95, -1,
		0, @nTextColor, C_BLACK, OR_HORZ, 5, 1, hBarGraph, RC_3DBORDER);

	{ set current font to Arial, 6 points }
	WGSetTextByName (C_BLACK, 'Arial', 6, 0);
	WGTextNorm (pGrDesc, thdc, 'Systolic', 0.67, 0.67, TA_LEFT OR TA_BASELINE, TEXT_NORMAL);
	WGTextNorm (pGrDesc, thdc, 'Diastolic', 0.67, 0.80, TA_LEFT OR TA_BASELINE, TEXT_NORMAL);
	WGTextNorm (pGrDesc, thdc, 'Pulse', 0.67, 0.92, TA_LEFT OR TA_BASELINE, TEXT_NORMAL);

	hDataBP := WRDefineDynDataSet ('Blood Pressure', NCHAN, NIL, NIL, 0);

	nTextColor := C_LIGHTGREEN;
	WGSetTextByName (C_RED, 'Arial', 6, TEXT_BOLD);
	WRSetDynText (pGrDesc, hDataBP, 0, 0.47, 0.60, 0.65, 0.70, -1,
		0, @nTextColor, C_BLACK, OR_HORZ, 5, 1, NULLH, RC_3DBORDER);
	WRSetDynText (pGrDesc, hDataBP, 1, 0.47, 0.72, 0.65, 0.82, -1,
		0, @nTextColor, C_BLACK, OR_HORZ, 5, 1, NULLH, RC_3DBORDER);
	WRSetDynText (pGrDesc, hDataBP, 2, 0.47, 0.84, 0.65, 0.94, -1,
		0, @nTextColor, C_BLACK, OR_HORZ, 5, 1, NULLH, RC_3DBORDER);
END;

{*******************************************************************************}
{ display buttons }

procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);
BEGIN
	hTags := GlobalAlloc (GHND, 10 * TAGLEN);
	lpButtonTags :=  GlobalLock(hTags);
	lstrcpy(lpButtonTags ,  '1');	        lstrcpy(lpButtonTags+TAGLEN, '2');
	lstrcpy(lpButtonTags+2*TAGLEN ,  '3');  lstrcpy(lpButtonTags+3*TAGLEN, '4');
	lstrcpy(lpButtonTags+4*TAGLEN ,  '5');  lstrcpy(lpButtonTags+5*TAGLEN, '6');
	lstrcpy(lpButtonTags+6*TAGLEN ,  '7');  lstrcpy(lpButtonTags+7*TAGLEN, '8');
	lstrcpy(lpButtonTags+8*TAGLEN ,  '9');  lstrcpy(lpButtonTags+9*TAGLEN, '10');

	lpButtonControlProc := MakeProcInstance (@ButtonControlProc, tInstance);

	WGSetTextByName (C_MAGENTA, 'Arial', 8, TEXT_BOLD);
	WRSetButtonGroup (pGrDesc,				{ Pointer to graph descriptor }
			lpButtonControlProc,			{ Button processing function }
			BC_LOOK_HIGH,					{ Tall push buttons }
			0.08, 0.1, 0.92, 0.45,			{ Button group coordinates }
			WGGetRGBColor (C_LIGHTGRAY),	{ Button background color }
			10,						 	{ Number of buttons }
			OR_HORZ,						{ Horizontal layout }
			lpButtonTags,					{ button names }
			FALSE);						{ does not apply to this button style }

	lstrcpy(lpButtonTags ,  'Start');
        lstrcpy(lpButtonTags+TAGLEN, 'Mark');
	lstrcpy(lpButtonTags+2*TAGLEN ,  'Hist.');
        lstrcpy(lpButtonTags+3*TAGLEN, 'Reset');
	WGSetTextByName (C_BLUE, 'Arial', 8, 0);
	WRSetButtonGroup (pGrDesc,
			lpButtonControlProc,
			BC_LOOK_HIGH,
			0.08, 0.5, 0.92, 0.95,
			WGGetRGBColor (C_CYAN),
			4,
			OR_HORZ,
			lpButtonTags,
			FALSE);

	GlobalFree (hTags);
END;
{***********************************************************************}
{ control proc for buttons, no actions are performed, }
{***********************************************************************}

PROCEDURE  ButtonControlProc ( pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	   nSel,  dum: INTEGER);
BEGIN
END;

{***********************************************************************}
FUNCTION randsmall:REALTYPE;
BEGIN
	 randsmall := random/10.0;
END;

{************************************************************************}
const
     rtindex : INTEGER = 0;
     o2index : Realtype = 0.0;
     o2i: realtype = 1.0;

PROCEDURE  TimerRoutine;
VAR
     rNewValHeart, rNewValBrain, rO2Meter:realtype;
     rDataBP: ARRAY[0..NCHAN-1] OF realtype;
     rNewVal:realtype;
BEGIN
	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }


	WGStart ;

	IF (( NOT WGIsGraphDescValid(pDynGrDesc)) OR( NOT WGIsGraphDescValid(pDynGrDesc2))) THEN
		exit;
	IF (( NOT WGIsGraphDescValid(pDynGrDesc3)) OR ( NOT WGIsGraphDescValid(pDynGrDesc4))) THEN
		exit;

	rNewValHeart := rEKGData[rtindex  MOD  25];
        rtindex := rtindex + 1;
	IF (rtindex >= 1000) THEN
	    rtindex := 0;

	WRUpdateData (hDataHeart, @rNewValHeart, pDynGrDesc);

	rNewValBrain := random-0.5;
	WRUpdateData (hDataBrain, @rNewValBrain, pDynGrDesc2);

	rDataBP[0] := 130.0 + random;
	IF (rtindex < 200) THEN
		rDataBP[1] := 66.0
	ELSE
		rDataBP[1] := 67.5;
	rDataBP [2] := 85.0 + random;
	WRUpdateData (hDataBP, @rDataBP, NIL);

	{ update the oxygen meter }
	IF (rtindex  MOD  2 = 0) THEN
	BEGIN
		o2index := o2index + o2i;
		IF (o2index >= 8.0) THEN o2i := -1.0;
		IF (o2index <= 1.0) THEN o2i := 1.0;
		rO2Meter := o2index;
		WRUpdateData (hDataO2Meter,  @rO2Meter, pDynGrDesc3);
		rNewVal := random + 5.2;
                WRUpdateData (hDataCO2Meter, @rNewVal, pDynGrDesc3);
		rNewVal := random + 98.2;
		WRUpdateData (hBarData, @rNewVal, @pDynGrDesc3);
	END;
END;
{************************************************************************}


begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;
 pDynGrDesc3 := NIL;
 pDynGrDesc4 := NIL;
end.
