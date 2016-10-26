{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FETALMOX.PAS                                *
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
{  Scroll Graphs - horizontal }
{	Scroll Bars - vertical }
{	Time Axis - drawing and labeling }
{	Check Boxes }
{	Dynamic Text }
{	Dynamic Data sets }
{ 	Timers }

{$F+,K+}   { Smart Callbacks, Far Memory Model }
unit Fetalmox;


interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
PROCEDURE  TimerRoutine;


implementation
{$R rtdemo}

const
  ncount: INTEGER = 0;
  NUMP =  200;
  NT   =  3;
  NUMCHECKBOX =5;
  NUMSCROLLBARS= 2;
  rTotalVol :Realtype = 0;
  rPrim : Realtype= 0;
  rSec : Realtype = 0;

VAR
  thInst: THandle;
              { global instance handle }
  hDataHeart,	hDataContract,
  hPrimData, hSecData,	{ global handles to dynamic data sets }
  hTotalVol, hVolDeliv: HDATA;	{ global handles to dynamic data sets }
  hDynText1, hDynText2: HGOBJ;	{ global handles to dynamic data sets }

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3: PGRAPH_DEF;
pPageDesc :  PPAGE_DEF;

 hCheckBox: ARRAY[0..NUMCHECKBOX-1] OF HGOBJ;			{ global handle to check boxes }
 hScroll: ARRAY[0..NUMSCROLLBARS-1] OF HGOBJ;			{ global handle to scroll bars }



{ Prototypes of forward referenced functions }


{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; export; forward;
PROCEDURE  CheckBoxControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; stdcall; forward;
PROCEDURE  CheckBoxControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); stdcall; forward;
{$endif}

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			pPageDesc := WGCreatePage('PAGE1', { page ID string }
				thwnd,           { handle to the parent window }
				tInst,          { application instance handle }
				'Monitor',      { Window title string }
				@StartGraphs1,   { pointer to graph creation function }
				NIL,         { Name of page window menu in resource file }
				C_WHITE,        { window background color }
				MM_PROPORT,     { window sizing mode }
				WS_CHILD OR WS_CLIPCHILDREN OR WS_VISIBLE, { window style - default }
				PAGE_CLIENT,
				0, 0, 0, 0);    { ignored }
										  { if used (not used here) }
END;

procedure WM_DestroyGraph;
begin
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
BEGIN
	WGToggleSelectors (pPageDesc, FALSE);
	pDynGrDesc := WGCreateGraph (pPageDesc, @DrawP1G1,
		0.01, 0.01, 0.5, 0.5, C_BLUE, -1, 1);
	pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
		0.51, 0.01, 0.99, 0.5, C_BLUE, -1,	1);
	pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
		0.01, 0.51, 0.99, 0.99,	C_LIGHTGRAY, C_BLUE, 2);
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;  { axes handles }
	bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
	nLineColor,
 	nLineStyle,
        nLineWidth,
        nTraces :INTEGER;
        rSampleInt, rResetInt,
        rHigh, rLow, rSetp:realtype;
BEGIN
        nTraces := 1;
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.85, C_BLACK);

	{ scale the plotting are for an x range of 0 to 30.0 }
	{ and y range of 125 to 175 }
	WGScalePlotArea (pGrDesc, 0.0, 125.0, 30.0, 175.0);

	{ set the intercepts to 0, 125 }
	WGSetXYIntercepts (pGrDesc, 0.0, 125.0);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_WHITE, 'Arial', 8, 0);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTCYAN);

	{ draw the x axis with major ticks every 10 physical coords and 2 minor tick }
	{ the ticks will be positioned at the center of the axis }
	hAxisX := WRDrawTimeAxis (pGrDesc, 10.0, 2, POS_MIDDLE, OR_HORZ, AXU_SEC);
	WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_MS, 0, 0, 0, 0,
			0.0, LL_ON, NIL);

	{ draw the y axis with major ticks every 25 physical units and 5 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 25.0, 5, POS_LEFT);

	{ Label the y axis, in decimal format, 0 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NIL);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTCYAN);

	{ now display a y axis on the right edge of the graph }
	{ set the intercepts to 30, 125 }
	WGSetXYIntercepts (pGrDesc, 30.0, 125.0);
	{ draw the y axis with major ticks every 10 physical coords and 0 minor ticks }
	WGDrawYAxis(pGrDesc, thdc, 10.0, 0, POS_RIGHT);

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_YELLOW, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Fetal Heart Rate');

	{**************************************************************** }
	{ define a dynamic data set }
	hDataHeart := WRDefineDynDataSet ('HeartRate',	{ data set name }
			nTraces,			{ # of traces (1) }
			'volts',			{ unit name for data set }
			NIL,				{ no tag names }
			0);				    { no buffer needed }

	rSampleInt := 0.25;          { sample interval }
	rResetInt := 0.5;

	nLineStyle := PS_SOLID;
	nLineWidth := 0;
	nLineColor := C_LIGHTRED;

	{ define a horizontal real time scroll graph }
	WRSetScrollGraph (pGrDesc,	{ pointer to graph descriptor }
			hDataHeart,				{ handle to dynamic data set }
			rSampleInt,				{ period between adjacent samples }
			rResetInt,				{ relative reset interval }
			OR_HORZ,				{ horizontal scroll }
			NO_STEP,				{ linear interp }
			@nLineStyle,			{ line styles for traces }
			@nLineWidth,			{ line widths for traces }
			@nLineColor);			{ line colors for traces }

	{ assign alarm and setpoint values }
	rHigh := 170; 		{ high }
	rLow := 130;		    { low }
	rSetp := 0.25;		{ Setpo }

	WRSetAlarm (hDataHeart, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataHeart, ALM_LOW,  rLow, 'LOW');
	WRSetSetpoint (hDataHeart, rSetp);

	{ alarm line state on/off }
	bFlags[0] := TRUE;         	{ setpo }
	bFlags[1] := TRUE;			{ high }
	bFlags[2] := TRUE;			{ low }
	bFlags[3] := FALSE;			{ high-high }
	bFlags[4] := FALSE;			{ low-low }

	{ draw setpoint, low, and high alarm lines }
	WRSetAlarmLines (pGrDesc,	{ pointer to graph descriptor }
			hDataHeart,			{ handle to data set }
			2,					{ update alm lines every 2 sec }
			OR_HORZ,			{ horizontal alm lines }
			@bFlags,				{ line enable flags }
			NIL,				{ use default line attributes }
			NIL,
			NIL);
END;

{*************************************************************************}

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;  { axes handles }
	bFlags: ARRAY [0..NALMLINES-1] OF BOOL;
	nLineColor,
 	nLineStyle,
        nLineWidth,
        nTraces :INTEGER;
        rSampleInt, rResetInt,
        rHigh, rLow, rSetp:realtype;
BEGIN
        ntraces := 1;
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.85, C_BLACK);

	{ scale the plotting are for an x range of 0 to 5.0 }
	{ and y range of -2 to 2 }
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 30.0, 200.0);

	{ set the intercepts to 0, -2 }
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_WHITE, 'Arial', 8, 0);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTCYAN);

	{ draw the x axis with major ticks every 10 physical coord and 1 minor tick }
	{ the ticks will be positioned at the center of the axis }
	hAxisX := WRDrawTimeAxis (pGrDesc,	{ pointer to graph descriptors }
			10.0,						{ major ticks every 10 units }
			1,							{ 1 minor tick between each major tick }
			POS_MIDDLE, 			    { draw centered at the axis }
			OR_HORZ,					{ axis is horizontal }
			AXU_SEC);				    { units are seconds }

	WRLabelTimeAxis (pGrDesc,	{ pointer to graph descriptor }
			hAxisX,				{ handle to time axis }
			POS_BELOW,   		{ show labels below axis }
			DLB_MS,				{ label format in MM::SS }
			0, 0,               { ignored }
			0,                  { starting at 0 minutes }
			0,                  { starting at 0 seconds }
			0.0,			    { ignored }
			LL_ON,			    { display last label }
			NIL);			    { ignored }

	{ draw the y axis with major ticks every 25 physical units and 5 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 25.0, 5, POS_LEFT);

	{ Label the y axis, in decimal format, no digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NIL);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTCYAN);

	{ now display an Y-axis at the right edge of the graph }
	{ set the intercepts to 30, 0 }
	WGSetXYIntercepts (pGrDesc, 30.0, 0.0);

	WGDrawYAxis(pGrDesc, thdc, 25.0, 5, POS_RIGHT);

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_YELLOW, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);
	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Contraction Rate');

	{**************************************************************** }
	{ define a dynamic data set }
	hDataContract := WRDefineDynDataSet ('ContractRate', nTraces, 'volts', NIL, 0);

	nLineWidth  := 0;
	nLineColor  := C_YELLOW;

	rSampleInt := 0.25;   rResetInt := 0.5;

	{ define a horizontal real time scrolling graph }
	WRSetScrollGraph (pGrDesc, hDataContract, rSampleInt, rResetInt,
		OR_HORZ, NO_STEP, NIL, @nLineWidth, @nLineColor);

	{ assign alarm values }
	rHigh := 195; 	{ high }
	rLow :=  10;		{ low }

	WRSetAlarm (hDataContract, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (hDataContract, ALM_LOW,  rLow,  'LOW');

	{ alarm line state on/off }
	bFlags[0] := TRUE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	{ draw setpoint, low, and high alarm lines, use default line attributes }
	WRSetAlarmLines (pGrDesc, hDataContract, 2, OR_HORZ, @bFlags, NIL, NIL, NIL);
END;

{*********************************************************************************}

procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	lpCheckBControlProc, lpScrollBarControlProc: TFARPROC;
	 nTextColor:INTEGER;
BEGIN
	WGRectangleNormEx (pGrDesc,		{ pointer to graph descriptor }
			thdc,								{ handle to device context }
			0.02, 0.02, 0.98, 0.98,		{ boundary for rectangle (around graph window) }
			C_WHITE,							{ white border }
			5,									{ 5 pixels wide }
			FALSE,							{ background filled }
			WGGetRGBColor (C_BLUE),		{ ignored }
			RC_3DBORDER);					{ 3D border effect }


	{:= 	{ - 1-------------------------------------- }
	{ check boxes }
	lpCheckBControlProc := @CheckBoxControlProc;

	WGSetTextByName (C_RED, 'Arial', 9, TEXT_BOLD);
	hCheckBox[0] := WRSetButtonControl (pGrDesc,	{ pointer to graph descriptor }
			lpCheckBControlProc,				{ button processing function }
			BC_STYLE_ONOFF,					    { on/off logic }
			BC_LOOK_CHECK,						{ check box look }
			0.04, 0.1, 0.25, 0.23,				    { boundary of check box }
			WGGetRGBColor (C_LIGHTGRAY),	    { background color }
			'Start',							{ text string }
			FALSE);								{ text displayed to right of check box }
	hCheckBox[1] := WRSetButtonControl (pGrDesc, lpCheckBControlProc,
			BC_STYLE_ONOFF, BC_LOOK_CHECK,
			0.04, 0.23, 0.25, 0.36,
			WGGetRGBColor (C_LIGHTGRAY), 'Primary', FALSE);
	hCheckBox[2] := WRSetButtonControl (pGrDesc, lpCheckBControlProc,
			BC_STYLE_ONOFF, BC_LOOK_CHECK,
			0.04, 0.36, 0.25, 0.49,
			WGGetRGBColor (C_LIGHTGRAY), 'Secondary', FALSE);
	hCheckBox[3] := WRSetButtonControl (pGrDesc, lpCheckBControlProc,
			BC_STYLE_ONOFF, BC_LOOK_CHECK,
			0.04, 0.49, 0.25, 0.62,
			WGGetRGBColor (C_LIGHTGRAY), 'Concurrent', FALSE);
	hCheckBox[4] := WRSetButtonControl (pGrDesc, lpCheckBControlProc,
			BC_STYLE_ONOFF, BC_LOOK_CHECK,
			0.04, 0.62, 0.25, 0.75,
			WGGetRGBColor (C_LIGHTGRAY), 'Reset', FALSE);

    { Select first three check boxes }
    WRChangeButtonState (pGrDesc, hCheckBox[0], 0);
    WRChangeButtonState (pGrDesc, hCheckBox[1], 0);
    WRChangeButtonState (pGrDesc, hCheckBox[2], 0);

	{:= 	{ - 1-------------------------------------- }
	{ scroll bars }
	{ set current font to Arial, 8 points, bold }
	WGSetTextByName (C_BLUE, 'Arial', 8, TEXT_BOLD);

	lpScrollBarControlProc := @ScBarControlProc;
	WGTextNorm (pGrDesc, thdc, 'Primary', 0.32, 0.12, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);
	hScroll[0] := WRSetScrBarControl (pGrDesc,	{ pointer to graph descriptor }
			lpScrollBarControlProc,				{ processing function for scroll bar }
			0.3, 0.17, 0.33, 0.78,				{ boundary for scroll bar }
			RGB (0, 0, 255),					{ color for scroll bar shaft }
			0.0, 1000.0,						{ scale from 0 to 1000 }
			10.0,								{ arrow increment is 10.0 }
			100.0,								{ page increment is 100 }
			0.0);								{ starting thumb position is at 0.0 }

	WGTextNorm (pGrDesc, thdc, 'Secondary', 0.445, 0.12,
	    TA_CENTER OR TA_BASELINE, TEXT_NORMAL);
	hScroll[1] := WRSetScrBarControl (pGrDesc,
			lpScrollBarControlProc, 0.42, 0.17, 0.45, 0.78,
			RGB (0, 0, 255), 0.0, 1000.0, 10.0, 100.0, 0.0);

	nTextColor := C_YELLOW;
	hPrimData := WRDefineDynDataSet ('Prim', { dyn data set name }
		1,       							{ 1 channel }
		NIL,								{ no units }
		NIL,								{ no tags }
		0);									{ no buffer }

	WRSetDynText (pGrDesc,				{ handle to graph desc }
			hPrimData,					{ handle to data set }
			0,							{ display channel 0 }
			0.29, 0.81, 0.35, 0.93,		{ coordinates of dynamic text }
			C_WHITE,					{ white border }
			1,							{ border 1 pixel wide }
			@nTextColor, 				{ text color  }
			C_BLACK,					{ black background }
			OR_HORZ,					{ horizontal layout }
			4,							{ 4 characters max }
			0,							{ 0 digits after decimal point }
			NULLH,						{ no associated dynamic object }
			RC_3DBORDER);				{ 3D border around bounding rectangle }

	hSecData := WRDefineDynDataSet ('Sec', 1, NIL, NIL, 0);

	WRSetDynText (pGrDesc, hSecData, 0, 0.41, 0.81, 0.47, 0.93,
		C_WHITE, 0, @nTextColor, C_BLACK, OR_HORZ, 4, 0, NULLH, RC_3DBORDER);

	hTotalVol := WRDefineDynDataSet ('TotalV', 1, NIL, NIL, 0);
	hVolDeliv := WRDefineDynDataSet ('VolDel', 1, NIL, NIL, 0);

    { show static text on raised rectangle }
	WGRectangleNormEx (pGrDesc, thdc, 0.50, 0.15, 0.70, 0.50,
			C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
	WGSetTextByName (C_RED, 'Arial', 8, 0);
	WGTextNorm (pGrDesc, thdc, 'Primary', 0.60, 0.23, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);
	WGTextNorm (pGrDesc, thdc, 'Pitosin', 0.60, 0.48, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);

	WGRectangleNormEx (pGrDesc, thdc, 0.75, 0.15, 0.95, 0.50,
			C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
	WGTextNorm (pGrDesc, thdc, 'Secondary', 0.85, 0.23, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);
	WGTextNorm (pGrDesc, thdc, 'Ringers', 0.85, 0.48, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);

	WGSetTextByName (C_RED, 'Arial', 8, 0);
	WGRectangleNormEx (pGrDesc, thdc, 0.50, 0.55, 0.70, 0.85,
			C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
	WGTextNorm (pGrDesc, thdc, 'Total Vol', 0.60, 0.63, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);


	WGRectangleNormEx (pGrDesc, thdc, 0.75, 0.55, 0.95, 0.85,
			C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
	WGTextNorm (pGrDesc, thdc, 'Vol Deliv', 0.85, 0.63, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);

	WGSetTextByName (C_YELLOW, 'Arial', 8, TEXT_BOLD);
	WRSetDynText (pGrDesc, hPrimData, 0, 0.55, 0.25, 0.65, 0.41,
		C_YELLOW, 0, @nTextColor, C_RED, OR_HORZ, 4, 0, NULLH, RC_3DBORDER);
	WRSetDynText (pGrDesc, hSecData, 0, 0.80, 0.25, 0.90, 0.41,
		C_YELLOW, 0, @nTextColor, C_RED, OR_HORZ, 4, 0, NULLH, RC_3DBORDER);
	WRSetDynText (pGrDesc, hTotalVol, 0, 0.55, 0.65, 0.65, 0.81,
		C_YELLOW, 0, @nTextColor, C_RED, OR_HORZ, 4, 0, NULLH, RC_3DBORDER);
	WRSetDynText (pGrDesc, hVolDeliv, 0, 0.80, 0.65, 0.90, 0.81,
		C_YELLOW, 0, @nTextColor, C_RED, OR_HORZ, 4, 0, NULLH, RC_3DBORDER);
END;

{ This processing function will update the dynamic text underneath }
{ each scroll bar. It also updates the dynamic text windows in the lower right }
{ quadrant of the page.  }
const
     rTPrim :Realtype= 0;
     rTSec : Realtype = 0;

FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL;
VAR
     rDynVal:realtype;
       bStartOn, bPrimOn, bSecOn:INTEGER;
BEGIN
	rDynVal := lprCurPos;

	{ find the state of each check box }
	bStartOn := WRGetButtonState(pDynGrDesc3, hCheckBox[0]);
	bPrimOn  := WRGetButtonState(pDynGrDesc3, hCheckBox[1]);
	bSecOn   := WRGetButtonState(pDynGrDesc3, hCheckBox[2]);

	IF (hCtl = hScroll[0]) THEN	{ if 1st scroll bar selected }
	BEGIN
		IF (bStartOn <> 0) THEN
		BEGIN
			IF (bPrimOn <> 0) THEN
			BEGIN
				{ update all dyn objs in graph window 3 (2 dyn text objects) }
				WRUpdateData (hPrimData,  @rDynVal, pDynGrDesc3);
				rTPrim := rDynVal;
				rPrim := rDynVal;

			END
			ELSE IF (rDynVal < 1) THEN
			BEGIN
				WRUpdateData (hPrimData,  @rDynVal, pDynGrDesc3);
				rTPrim := 0.0;
			END;
		END;
	END
	ELSE
	BEGIN
		IF (hCtl = hScroll[1]) THEN	{ if second scroll bar selected }
		BEGIN
			IF (bStartOn <> 0) THEN
			BEGIN
				IF (bSecOn <> 0) THEN
				BEGIN
					rTSec := rDynVal;
					rSec := rDynVal;
					WRUpdateData (hSecData,  @rDynVal, pDynGrDesc3);
				END
				ELSE IF (rDynVal < 1) THEN
					WRUpdateData (hSecData,  @rDynVal, pDynGrDesc3);
			END;

		END;
	END;
	IF ((hCtl = hScroll[0]) OR (hCtl = hScroll[1])) THEN
	BEGIN
		rTotalVol := rTPrim + rTSec;
		{ total volume distributed through prim AND sec lines for each hour }
		IF (bStartOn <> 0) THEN
			WRUpdateData (hTotalVol,  @rTotalVol, pDynGrDesc3)
		ELSE
		BEGIN
			rTotalVol := 0.0;
			WRUpdateData (hTotalVol,  @rTotalVol, pDynGrDesc3);
		END;
	END;
        ScBarControlProc := TRUE;
END;

{ Dynamic text objects will be updated depending upon the currently selected check boxes, }
{ No dynamic text objects are updated if 'start' was not selected. }
{ Only primary, total vol are updated if 'primary' selected. }
{ Only secondary, total vol are updated if 'secondary' selected. }
{	  Concurrent is ignored }
{ Reset will reset all dynamic text objects to 0.0 }

PROCEDURE  CheckBoxControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER);
VAR
	 i, nButState:INTEGER;
	 rCur, rPrev:realtype;
BEGIN
	rCur := 0.0;
        rPrev := 0.0;

	{ if start pressed, update the dyn text windows with selected values }
	IF (hCtl = hCheckBox[0]) THEN
	BEGIN

			IF (State <> 0) THEN
			BEGIN
				ScBarControlProc (pGrDesc, hScroll[0], rPrim, rPrev);
				ScBarControlProc (pGrDesc, hScroll[1], rSec, rPrev);

			END
			ELSE
			BEGIN
				ScBarControlProc (pGrDesc, hScroll[0], rCur, rPrev);
				ScBarControlProc (pGrDesc, hScroll[1], rCur, rPrev);

			END;
	END
	ELSE
	{ primary on }
	IF (hCtl = hCheckBox[1]) THEN
	BEGIN
			IF (State <> 0) THEN
				ScBarControlProc (pGrDesc, hScroll[0], rPrim, rPrev)
			ELSE
				ScBarControlProc (pGrDesc, hScroll[0], rCur, rPrev);
		END
	ELSE
	{ secondary on }
	IF (hCtl = hCheckBox[2]) THEN
	BEGIN
			IF (State <> 0) THEN
				ScBarControlProc (pGrDesc, hScroll[1], rSec, rPrev)
			ELSE
				ScBarControlProc (pGrDesc, hScroll[1], rCur, rPrev);
	END
	ELSE
	{ reset }
	IF (hCtl = hCheckBox[4]) THEN
	BEGIN
		IF (State <> 0) THEN  { 0 - not checked }
		BEGIN
			{ if reset box selected, turn all other check boxes off }
			FOR i := 0 TO  NUMCHECKBOX - 1 DO
			BEGIN
					nButState := WRGetButtonState (pGrDesc, hCheckBox[i]);
					IF (nButState = 1) THEN
					BEGIN
						IF (i = 0) THEN
						BEGIN
							{ reset the scroll bars }
							ScBarControlProc (pGrDesc, hScroll[0], rCur, rPrev);
							ScBarControlProc (pGrDesc, hScroll[1], rCur, rPrev);
						END;
						WRChangeButtonState (pGrDesc, hCheckBox[i], 0);
					END;
			END;
		END;
	END;
END;


const
   j :INTEGER= 0;
   rVolDeliv :realtype = 0.0;

{************************************************************************}
PROCEDURE  TimerRoutine;
VAR
	 rNewValHeart, rNewValContract :realtype;
BEGIN

   	WGStart ;

	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	{ update fetal heart rate }
	rNewValHeart  := 135.0 + random * 25;
	WRUpdateData (hDataHeart,  @rNewValHeart, pDynGrDesc);

	IF (j > 32700) THEN
	    j := 0;
        j := j + 1;
	rNewValContract := ( 1.0 + sin(M_PI * j / 502)) * (random) * 100.1;
	IF NOT( WGIsGraphDescValid(pDynGrDesc2)) THEN
	       exit ;
	{ update contraction rate }
	WRUpdateData (hDataContract,  @rNewValContract, pDynGrDesc2);

	{ total vol delivered to patient }
	IF ( (j  MOD  4) = 0) THEN
	BEGIN
		rVolDeliv := rVolDeliv + rTotalVol / 3600;
		IF ( NOT WGIsGraphDescValid(pDynGrDesc3)) THEN
		       exit;
		WRUpdateData (hVolDeliv,  @rVolDeliv, NIL);
	END;
END;
{*************************************************************************}

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var lpProcAbout: TFARPROC;
begin
    lpProcAbout := MakeProcInstance (@AboutProc, tInst);
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            lpProcAbout);              {  AboutProc() instance address  }
    FreeProcInstance (lpProcAbout);

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
{************************************************************************}


begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;
 pDynGrDesc3 := NIL;
 pPageDesc := NIL;
end.

