{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCBARDEX.PAS                                *
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
{  	Scrolling Bar Graphs }
{		Dynamic Grids }
{		Dynamic Data sets }
{ 	    Timers }

{$F+}
unit Scbardex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
function  AboutProc (hDlg: HWND; message: WORD; wParam: WORD; lParam: LONGINT):WORDBOOL;

implementation

{$R rtdemo}

const
  ncount: INTEGER = 0;
  NCH = 4;
VAR
  lpTimerRoutine: TFARPROC;
  idTimer: INTEGER;

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3,
pDynGrDesc4: PGRAPH_DEF;
thData: HDATA;
pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }
PROCEDURE  TimerRoutine (thwnd: HWND; msg, idTimer: UINT;
	dwTime: LongInt); export; forward;
PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;


procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
	   pPageDesc1 := WGCreatePage('PAGE1', { page ID string }
						thwnd,               { handle to the parent window }
						tInst,              { application instance handle }
						'Scrolling Bar Graphs',      { Page window title }
						@StartGraphs1,       { pointer to graph creation function }
						'PageMenu',         { Name of page window menu in resource file }
						C_GREEN,            { page window background color }
						MM_PROPORT,         { window sizing mode }
						0,                 { default window style }
						PAGE_FULL,          { fill parent window }
						0, 0, 0, 0);

             { start 0.25 second timer }
  	    lpTimerRoutine := MakeProcInstance (@TimerRoutine, tInst);
            idTimer := SetTimer (NULLH, 0, 250, lpTimerRoutine);

END;

procedure WM_DestroyGraph;
begin
   KillTimer (NULLH, idTimer);	{ stop the timer }
   IF (lpTimerRoutine <> NIL) THEN
   	FreeProcInstance (lpTimerRoutine);
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
	{ Initialize graphs }
	pDynGrDesc := WGCreateGraph (pPageDesc,
			@DrawP1G1,       { function which builds graph }
			0.005, 0.005,   { window relative position inside parent page window }
			0.49, 0.49,
			C_LIGHTCYAN,    { light cyan background }
			-1,             { no border }
			1);      

	pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
			0.5, 0.005, 0.99, 0.49,
			C_BLUE, C_BLACK, 2); { blue background, black border }

	pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
			0.005, 0.5, 0.49, 0.99,
			C_GRAY, -1, 0); { gray background, no border }

	pDynGrDesc4 := WGCreateGraph (pPageDesc, @DrawP1G4,
			0.5, 0.5, 0.99, 0.99,
			C_GRAY, -1, 0); { gray background, no border }
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	rSampleInt: realtype;
	nTraces,  nBarColor: INTEGER;
	hScr: ARRAY[0..AS_NH-1] OF HGOBJ;        { array of object handles }
BEGIN
	nTraces := NCH;

	thData := WRDefineDynDataSet ('Scrolling Bar', { pointer to graph descriptor }
			nTraces,					  { # of traces }
			'volts',					  { units string }
			NIL,						  { no channel tag names }
			0);							  { no history buffer }

	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define font family  }
	WGSetTextParams (C_BLUE, FF_SWISS, 10, TEXT_BOLD);

	rSampleInt := 0.25;
	nBarColor := C_YELLOW;
    { create automatic scrolling bar graph }
	WRSetAutoScrollGraph (pGrDesc, thdata,
		rSampleInt,             { sample interval }
		0.25,                   { reset interval }
		-2.0, 2.0,              { min and max values of dependent variable }
		5.0,                    { range of independent variable }
		GOD_SUBT_SCBAR,         { scroll bar graph subtype }
		2,                      { # digits after dec pt }
		0.0,                    { setp }
		1.75,                   { high alarm limit }
		-1.75,					{ low alarm limit }
		'Scrolls left to right',
		C_BLACK,                { plotting area color }
		@nBarColor,             { bar color }
		TRUE,                   { display dynamic text }
		@hScr);
END;

{******************************************************* }

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 rSampleInt, rBarWidth:realtype;
	 nDir: INTEGER;
         hAxisX, hAxisY: HGOBJ;        { axes handles }
	 nGridUpdate: INTEGER;       { dynamic grids update period }
BEGIN
	nGridUpdate := 3;       { dynamic grids update period }
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_GRAY);

	{ scale the plotting area for an x range of 20 to 0.0 (reverse) }
	{ and y range of -2.0 to 2.0 }
	WGScalePlotArea (pGrDesc, 20.0, -2.0, 0.0, 2.0);

	{ set the intercepts to 20.0, -2.0 }
	WGSetXYIntercepts (pGrDesc, 20.0, -2.0);

	{ axes to be drawn in solid, yellow, 2 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_YELLOW);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_LIGHTCYAN, 'Arial', 8, 0);

	{ draw the x axis with major ticks every 5 physical units and 5 minor ticks }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 5, POS_MIDDLE);

	{ draw the y axis with major ticks every physical unit and 1 minor tick }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	{ Label the x axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ choose bold text }
	WGSetTextByName (C_LIGHTCYAN, 'Arial', 9, TEXT_BOLD);

	{ Write axes titles }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Scrolls right to left');

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_LIGHTCYAN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Horizontal Scrolling Bar');

	{ SET UP DYNAMIC PORTION OF GRAPH }

	{ Set the line style for the dynamic grids }
	WGSetLineStyle(pGrDesc, thdc, PS_DASH, 1, C_LIGHTCYAN);

	{ Display a dynamic grid at the major tick interval for both }
	{ x and y axes, updating the grid every 4 seconds. }
	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	rSampleInt := 0.250;
	nDir := OR_HORZ;
	rBarWidth := rSampleInt / 2.0;

	WRSetScrollBargraph (pGrDesc, thdata, 1, rSampleInt, 0.5, nDir, rBarWidth,
		RGB (100, 255, 128), C_LIGHTGREEN);
END;

{*************************************************************************}
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 rSampleInt, rBarWidth:realtype;
         hAxisX, hAxisY: HGOBJ;        { axes handles }
 	 nDir:INTEGER;
	 nGridUpdate :INTEGER;
BEGIN
 	 nGridUpdate := 2;
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_LIGHTGRAY);

	{ scale the plotting area }
	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, 10.0);

	{ set the intercepts to -2.0, 0.0 }
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_YELLOW, 'Arial', 8, 0);

	hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 0, POS_MIDDLE);

	{ draw the y axis with major ticks every physical unit and 1 minor tick }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	{ Label the x axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_BLUE, 'Arial', 8, TEXT_BOLD);

	{ Write axis title }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Scrolls bottom to top');

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_YELLOW, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Vertical Scrolling Bar');

	{ SET UP DYNAMIC PORTION OF GRAPH }
	{ Set the line style for the dynamic grids }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 0, C_BLACK);

	{ Display a dynamic grid at the major ticks for both }
	{ x and y axes, updating the grid every 4 seconds. }
	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	rSampleInt := 0.5;
	nDir := OR_VERT;
	rBarWidth := rSampleInt / 3;

	WRSetScrollBargraph (pGrDesc, thdata, 3, rSampleInt, 0.5, nDir, rBarWidth,
		RGB (255, 64, 64), C_LIGHTRED);
END;

{*****************************************************************************}

procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 rSampleInt, rBarWidth, rRelReset:realtype;
         hAxisX, hAxisY: HGOBJ;        { axes handles }
 	 nDir:INTEGER;
	 nGridUpdate :INTEGER;
BEGIN
 	 nGridUpdate := 4;

	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_WHITE);

	{ scale the plotting area }
	WGScalePlotArea (pGrDesc, -2.0, 20.0, 2.0, 0.0);

	{ set the intercepts to -2.0, 20.0 }
	WGSetXYIntercepts (pGrDesc, -2.0, 20.0);

	{ axes to be drawn in solid, blue, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLUE);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_BLACK, 'Arial', 8, 0);

  	hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 1, POS_MIDDLE);

	{ draw the y axis with major ticks every 5 physical units and 5 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 5, POS_LEFT);

	{ Label the x axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetTextParams (C_BLACK, FF_ROMAN, 8, TEXT_ITAL);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ Set the line style for the dynamic grids }
	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTBLUE);

	{ Write axis title }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Scrolls top to bottom');

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph (pGrDesc, thdc, 'Vertical Scrolling Bars');

	{ SET UP DYNAMIC PORTION OF GRAPH }

	{ Display a dynamic grid at the major tick interval for both }
	{ x and y axes, updating the grid every 4 seconds. }
	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	rSampleInt := 0.250;
	rRelReset := 0.01;
	nDir := OR_VERT;

	WRSetScrollBargraph (pGrDesc, thdata, 2, rSampleInt, rRelReset, nDir, 0.0,
		RGB (128, 128, 255), C_LIGHTBLUE);
END;


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

function  AboutProc (hDlg: HWND; message: WORD; wParam: WORD; lParam: LONGINT):WORDBOOL;
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

PROCEDURE  TimerRoutine (thwnd: HWND; msg, idTimer: UINT;
	dwTime: LongInt);
VAR
   rNewVals:  ARRAY [0..NCH-1] of realtype;
   rncount: realtype;
BEGIN
    { check if graph exists }
	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	{ Initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple }
	{ instances of the same application can run simultaneously. }

	WGStart ;
    { simulate data }
    rncount := ncount;
	rNewVals[0] := sin(M_PI * rnCount / (1025 - rnCount)) ;
	rNewVals[1] := sin(M_PI * rnCount / 52.0) * cos(rnCount) * 1.1;
	rNewVals[2] := sin(M_PI * rnCount / 100.0) * cos (random);
	rNewVals[3] := sin(M_PI * rnCount / 26.0) * cos (rnCount * rnCount) * 1.1;
        ncount := ncount + 1;
	IF (nCount >= 1000) THEN
		nCount := 0;

{ Update the data set and all dynamic objects using it in all graphs }
	WRUpdateData (thdata, @rNewVals, NIL);
END;
{************************************************************************}

begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;
 pDynGrDesc3 := NIL;
 pDynGrDesc4 := NIL;
 pPageDesc1 := NIL;

 end.

