{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCADAX.PAS                                  *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{************************************************************}
{                FEATURES OF THIS DEMO }
{  	Scrolling lines }
{		Resetting scrolling lines }
{		Needle meters }
{		Push buttons }
{		Check Boxes }
{ }
{		Page Window is created as a child of the Main Window }
{		The mapping mode is set to isotropic to maintain the aspect ratio }
{		for the window. Otherwise, when the window is resized, the meters }
{		would not maintain the aspect ratio and would appear oval or stretched. }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Scadax;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

PROCEDURE  TimerRoutine;
procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);

implementation

{$R rtdemo}

const
  NT = 3;
  ncount: INTEGER = 0;

VAR
  tinstance: HWND;
         { global instance handle }
  hDataMeter: ARRAY[0..4] OF HDATA;		{ handle to meters data sets }
  hDataScroll: HDATA;		{ handle to dynamic data set }
  hScroll: HGOBJ;			{ handle to scrolling lines object }
  lpButtonControlProc, lpScrollControlProc, lpButtonCheckControlProc: TFARPROC;

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3,
pDynGrDesc4,
pDynGrDesc5: PGRAPH_DEF;
pPageDesc:   PPAGE_DEF;
pPageDesc2 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }


PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G5 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

{$ifndef WIN32}
PROCEDURE  ButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); export; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; export; forward;
PROCEDURE  ButtonCheckControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); export; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; forward;

{$else}
PROCEDURE  ButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); stdcall; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; stdcall; forward;
PROCEDURE  ButtonCheckControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); stdcall; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT;
      lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
tinstance := tinst;
		 { page is created in the current window }
pPageDesc := WGCreatePage('PAGE1', thwnd, tInst, 'SCADA',
	@StartGraphs1, NIL, C_CYAN, MM_ISOTR,
	WS_CHILD OR WS_CLIPCHILDREN OR WS_VISIBLE,
	PAGE_CLIENT,	0, 0, 0,0);

END;

procedure WM_DestroyGraph;
begin
  WRCleanup(TRUE); 		{ clean up  }
  FreeProcInstance (lpButtonControlProc);
  FreeProcInstance (lpButtonCheckControlProc);
  FreeProcInstance (lpScrollControlProc);
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
	{ Initialize graphs }
	{ meters }
	pDynGrDesc := WGCreateGraph (pPageDesc, @DrawP1G1,
			0.01, 0.01, 0.99, 0.3, C_CYAN, -1, 1);

	{ scrolling graph }
	pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
			0.0, 0.31, 0.99, 0.70, C_CYAN, -1, 1);

	{ push buttons }
	pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
			0.0, 0.79, 0.47, 0.99, C_CYAN, -1,	1);

	{ check boxes }
	pDynGrDesc4 := WGCreateGraph (pPageDesc, @DrawP1G4,
		 0.475, 0.79, 0.99, 0.99,C_CYAN, -1, 1);

	{ scroll bar }
	pDynGrDesc5 := WGCreateGraph (pPageDesc, @DrawP1G5,
		 0.0, 0.70, 0.99, 0.78, C_CYAN, -1, 1);

	WGToggleSelectors (pPageDesc, FALSE);
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
{ draws 5 meters across top of page }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
    i:INTEGER;
    nColor:INTEGER;
    rHigh, rLow, rSetp:realtype;
    rXCenter, rYCenter, rDiam:realtype;
    szUnits: ARRAY[0..9] OF CHAR;
    hMeter: HGOBJ;
BEGIN
	{ draw 3D rectangle covering the whole graph window }
	WGRectangleNormEx (pGrDesc, { pointer to graph descriptor }
			thdc,				{ handle to device context }
			0.0, 0.0, 1.0, 1.0,	{ boundary for rectangle }
			C_WHITE,			{ white border }
			3,					{ border width of 3 pixels }
			TRUE,				{ fill background }
			WGGetRGBColor (C_CYAN), { background color }
			RC_3DBORDER);		{ 3D border }

	{ Alarm limits: }
	rHigh := 95;     { HIGH }
	rLow :=  0.0;    { LOW }
	rSetp := 50;     { Setpo }

	WGSetTextByName (C_BLACK, 'Arial', 6, 0);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
	rYCenter := 0.6;
	rXCenter := 0.1;
	rDiam :=    0.09;
	nColor := C_LIGHTRED;

	{ use 'units' field of dynamic data sets to identify meters }
	FOR i := 0 TO 4 DO
	BEGIN
 	       CASE (i) OF
			0: lstrcpy (szUnits, 'Inlet');
			1: lstrcpy (szUnits, 'Cooler');
			2: lstrcpy (szUnits, 'Heater');
			3: lstrcpy (szUnits, 'Reactor');
			4: lstrcpy (szUnits, 'Outlet');
		END;
		{ create dynamic data set }
		hDataMeter[i] := WRDefineDynDataSet (NIL, 1, szUnits, NIL, 0);
		WRSetSetpoint (hDataMeter[i], rSetp);
		WRSetAlarm (hDataMeter[i], ALM_LOW,  rLow, 'LOW ALARM');
		WRSetAlarm (hDataMeter[i], ALM_HIGH, rHigh, 'HIGH');

		{ create needle meter }
		hMeter := WRSetMeter (pGrDesc, { pointer to graph descriptor }
			hDataMeter[i],		{ handle to data set }
			-1,					{ all channels are displayed }
			0.0,				{ minimum value }
			4.0,				{ maximum value }
			rXCenter,			{ x coord for meter center }
			rYCenter,			{ y coord for meter center }
			rDiam,				{ diameter }
			30,					{ start meter scale at 30 degrees }
			150,				{ meter scale end point at 150 degrees }
			NEEDLE_LINE + i,	{ needle type }
			@nColor, 			{ needle color }
			0.1,				{ tick size }
			1.0,				{ major ticks at 1, 2, 3, 4 }
			1,					{ number of minor tics }
			POS_OUTSIDE,        { ticks are outside of scale arc }
			POS_OUTSIDE,		{ labels along outside of scale arc }
			0,					{ 0 digits after decimal point }
			FALSE,
			0,
			TRUE,				{ Draw scale arc }
			TRUE,				{ Display units }
			FALSE,              { do not display alarm arcs }
			0.0,
			NIL);

		WRSetMeterBorder (pGrDesc,	{ pointer to graph descriptor }
			hMeter,				    { handle to meter }
			rXCenter,				{ center point for border }
			rYCenter - 0.1,
			rDiam * 1.78,          	{ border diameter, relative to graph X size }
			0.0,                    { ignored }
			WGGetRGBColor (C_WHITE), { background color }
			MET_CIRC,				{ border as circle }
			2,						{ border width }
			C_BLUE);				{ border color }

		rXCenter := rXCenter + 0.19;
	END;
END;

{*********************************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
    nTraces :INTEGER;
    nLineColor: ARRAY [0..NT-1] OF INTEGER;
    nLineStyle: ARRAY [0..NT-1] OF INTEGER;
    nLineWidth : ARRAY [0..NT-1] OF INTEGER;
    i:INTEGER;
BEGIN
        nTraces := NT;
	WGRectangleNormEx (pGrDesc, thdc, 0.05, 0.05, 0.95, 0.95,
			C_CYAN, 3, FALSE, WGGetRGBColor (C_CYAN), RC_3DBORDER);

	hDataScroll := WRDefineDynDataSet ('SCROLLG', nTraces, NIL, NIL, 200);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.1, 0.1, 0.9, 0.9, C_BLACK);

	{ scale the plotting are for an x range of 0 to 20.0 }
	{ and y range of -10 to 10 }
	WGScalePlotArea (pGrDesc, 0.0, -1.5, 10.0, 1.5);

	{ set the intercepts to 0,0 }
	WGSetXYIntercepts (pGrDesc, 0.0, -1.5);

	{ axes to be drawn in solid, black, 1 pixel thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_WHITE);

	{ draw the x axis with major ticks every physical coord and 0 minor tick }
	{ the ticks will be positioned at the center of the axis }
	WGDrawXAxis(pGrDesc, thdc, 1.0, 0, POS_MIDDLE);

	{ draw the y axis with major ticks every .25 physical coords and 0 minor ticks }
	WGDrawYAxis(pGrDesc, thdc, 0.25, 0, POS_LEFT);

	{ assign each line style, width and color }
	FOR i := 0 TO nTraces-1 DO
	BEGIN
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineColor [0] := C_YELLOW;
	nLineColor [1] := C_LIGHTRED;
	nLineColor [2] := C_LIGHTGREEN;

	{ scrolling lines }
	hScroll := WRSetScrollGraph (pGrDesc,
			hDataScroll,
			0.25,           { sample interval }
			0.7,            { reset interval }
			OR_HORZ,
			NO_STEP,
			@nLineStyle,
			@nLineWidth,
			@nLineColor);
END;
{***************************************************************}

procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
  lpButtonTags: LPSTR;
  hTags: HGLOBAL;
  hButtons: HGOBJ;
BEGIN
	WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.01, 0.99, 0.99,
			C_CYAN, 3, FALSE, WGGetRGBColor (C_CYAN), RC_3DBORDER);

	hTags := GlobalAlloc (GHND, 5 * TAGLEN);
	lpButtonTags :=  GlobalLock(hTags);

	lstrcpy(lpButtonTags,  'Inlet');
	lstrcpy(lpButtonTags+TAGLEN,  'Cooler');
	lstrcpy(lpButtonTags+2*TAGLEN,  'Heater');
	lstrcpy(lpButtonTags+3*TAGLEN,  'React');
	lstrcpy(lpButtonTags+4*TAGLEN,  'Outlet');

	lpButtonControlProc := MakeProcInstance (@ButtonControlProc, tInstance);

	WGSetTextByName (C_WHITE, 'Arial', 8, 0);
	{ button group }
	hButtons := WRSetButtonGroup (pGrDesc, lpButtonControlProc,
	    BC_LOOK_HIGH, 0.03, 0.2, 0.98, 0.8,
			WGGetRGBColor (C_LIGHTBLUE), 5, OR_HORZ, lpButtonTags, FALSE);
    { select button # 0 }
	WRChangeButtonColor(pGrDesc, hButtons, WGGetRGBColor (C_LIGHTRED), 0);

	GlobalFree (hTags);
END;
{************************************************************************}



procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
        i:INTEGER;
        x, y:realtype;
        pStr: string;
        cStr: array[0..25] OF CHAR;
        arglist: ARRAY[0..1] of INTEGER;
BEGIN
	WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.01, 0.99, 0.99,
		 C_CYAN, 3, FALSE, WGGetRGBColor (C_CYAN), RC_3DBORDER);

	lpButtonCheckControlProc := MakeProcInstance (@ButtonCheckControlProc, tInstance);
	x := 0.04;
	y := 0.1;
	WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD);
	FOR i := 0 TO 11 DO
	BEGIN
                arglist[0] := i + 1;
                pStr := IntToStr(i+1);
                StrPCopy(cStr, pStr);

        { draw check box }
		WRSetButtonControl (pGrDesc, lpButtonCheckControlProc,
			BC_STYLE_ONOFF, BC_LOOK_CHECK,
			x, y, x + 0.15, y + 0.4,
			WGGetRGBColor (C_CYAN), cStr, FALSE);
		x := x + 0.15;
		IF (i = 5) THEN
		BEGIN
			x := 0.04;
			y := 0.52;
		END;
	END;
END;

{***********************************************************************}
procedure DrawP1G5 (pGrDesc: PGRAPH_DEF; thdc: HDC);
BEGIN
	lpScrollControlProc := MakeProcInstance (@ScBarControlProc, tInstance);

	WRSetScrBarControl (pGrDesc, lpScrollControlProc, 0.1, 0.2, 0.9, 0.8,
		WGGetRGBColor (C_LIGHTBLUE), 0.0, 100.0, 1.0, 10.0, 50.0);
END;
{********************************************************************}
{ Control processing functions **************************************}
{********************************************************************}

PROCEDURE  ButtonCheckControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER);
BEGIN
	{ empty }
END;

{***********************************************************************}
PROCEDURE  ButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); BEGIN
    { when pressed, change button color to red }
	WRChangeButtonColor (pGrDesc, hCtl, WGGetRGBColor (C_LIGHTBLUE), dum);
	WRChangeButtonColor (pGrDesc, hCtl, WGGetRGBColor (C_LIGHTRED), state);
END;

{*********************************************************************}
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL;
BEGIN
	ScBarControlProc := TRUE;
END;
{************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..NT-1] OF realtype;
BEGIN
	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple }
	{ instances of the same application can run simultaneously. }

	WGStart ;
        nCount := nCount + 1;
	IF (nCount >= 1000) THEN
		nCount := 0;

	IF NOT( WGIsGraphDescValid(pDynGrDesc2)) THEN
	       exit ;
	IF (nCount = 80) THEN
		WRResetScroll (pDynGrDesc2, hScroll);
	rArg := M_PI * nCount;
	rNewVals [0] := 1.3 * sin (rArg / (1025.0 - nCount)) ;
	rNewVals [1] := sin (rArg / 52.0) * (random * 1.3) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * ( random * 1.6) * 1.6;

	WRUpdateData (hDataScroll, @rNewVals, pDynGrDesc2);

	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;
	rNewVals [0] := random * 4.0;
	WRUpdateData (hDataMeter[0], @rNewVals, pDynGrDesc);
	rNewVals [0] := random * 4.0;
	WRUpdateData (hDataMeter[1], @rNewVals, pDynGrDesc);
	rNewVals [0] := random * 4.0;
	WRUpdateData (hDataMeter[2], @rNewVals, pDynGrDesc);
	rNewVals [0] := random * 4.0;
	WRUpdateData (hDataMeter[3], @rNewVals, pDynGrDesc);
	rNewVals [0] := random * 4.0;
	WRUpdateData (hDataMeter[4], @rNewVals, pDynGrDesc);
END;

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


{************************************************************************}

begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;
 pDynGrDesc3 := NIL;
 pPageDesc :=  NIL;
 pPageDesc2 := NIL;
end.

