{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DDEDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit ddedemox;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, qcdde;
{ Exports }
procedure WM_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;


implementation
{$R rtdemo}
const
  ncount: INTEGER = 0;
  NT   =  8;
var
  thData: HDATA;	{ handle to dynamic data set }
  pPageDesc1 :PPAGE_DEF; { pointer to graph descriptor }
  hTags: HGLOBAL;       { handle to tag names }

{ Forward Referenced functions }

procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;


procedure WM_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
    pPageDesc1 := WGCreatePage('PAGE1', { page ID string }
	    	    thwnd,               { handle to the parent window }
		    tinst,              { application instance handle }
		    'DDE Test',         { Window title string }
		    @StartGraphs1,       { pointer to graph creation function }
		    'PageMenu',
		    C_LIGHTGRAY,        { window background color }
		    MM_ISOTR,           { window sizing mode }
		    0,					{ window style }
		    PAGE_CLIENT,
		    0, 0, 0, 0); 	   { initial window size and position }
end;

procedure WM_DestroyGraph;
begin
  WRCleanup (TRUE);      { clean up charting tools memory }
  PostQuitMessage (0);
end;


{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
begin
	{ Initialize graphs }
	WGCreateGraph (pPageDesc,
		@DrawP1G1,       { function which builds graph }
		0.005, 0.005,   { window relative position inside parent page window }
		0.99, 0.99,
		C_LIGHTGRAY,    { light gray background }
		C_WHITE,        { white border }
		1);             { border width in pixels }
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
    hAxisX, hAxisY: HGOBJ;    { axes handles }
    hScroll: HGOBJ;        	{ handle to the scrolling graph object }
    hTags: HGLOBAL;
    lpTags: LPSTR;
    nTraces:INTEGER;
    nLineColor: ARRAY[0..1] OF INTEGER;
    nLineWidth: ARRAY[0..1] OF INTEGER;
    i, nGridUpdate : INTEGER;
    rSampleInt, rResetInt:realtype;
 BEGIN
    nTraces := 2;
    nGridUpdate := 4;


	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.16, 0.15, 0.94, 0.57, C_BLACK);

	{ scale the plotting area for an x range of 0 to 1.0 }
	{ and y range of -3.0 to 3.0 }
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 10.0, 20.0);

	{ set the intercepts to 0.0, -3.0 }
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ set current font to Arial, 7 points }
	WGSetTextByName (C_RED, 'Arial', 8, 0);

	{ draw the x axis with major ticks every 0.2 physical units and no minor ticks }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 2.0, 1, POS_MIDDLE);

	{ draw the y axis with major ticks every physical unit and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_LEFT);

	{ Label the x axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetTextByName (C_RED, 'Arial', 8, TEXT_ITAL);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ Set the line style for the dynamic grids }
	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);

	{ Write axes titles }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Seconds');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'DDE Data');

	{ SET UP DYNAMIC PORTION OF GRAPH }

	{ Display a dynamic grid at the major tick interval for both }
	{ x and y axes, updating the grid every 4 seconds. }
	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	{ Assign each line width and color for the scroll graph }
	FOR i := 0 TO nTraces- 1 DO
	BEGIN
		nLineWidth [i] := 1;
	END;
	nLineColor [0] := C_LIGHTRED;
	nLineColor [1] := C_GREEN;

	rSampleInt := 0.2;   rResetInt := 0.9;



	{ Define the dynamic data set }
	thData := WRDefineDynDataSet ('DDE Data', { data set name }
			nTraces,						{ # of traces }
			'volts',						{ unit string }
			NIL,							{ no tag names }
			200);							{ history buffer size := 200 }
    { Connect hData to DDE with automatic update option. }
	WRConnectDDE (thData, 'Server', NIL, 'Test', 'Count', TRUE);


	{ create scrolling lines }
	hScroll := WRSetScrollGraph (pGrDesc,	{ pointer to graph descriptor }
			thData,                          { handle to dynamic data set }
			rSampleInt,						{ sample interval }
			rResetInt,						{ relative reset }
			OR_HORZ,						{ scroll direction is horizontal }
			NO_STEP,						{ style - linear interp }
			NIL,
			@nLineWidth, @nLineColor);

	{ Draw a 'shallow' rectangle }
	WGRectangleNormEx (pGrDesc, thdc, 0.03, 0.74, 0.45, 0.97,
			C_LIGHTGRAY, 1, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);

	{ set current font to Arial, 10 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 7, TEXT_BOLD);

	{ Display dynamic values for all traces in the dynamic data set. }
	WRSetDynText (pGrDesc,			   { pointer to graph descriptor }
			thData,					   { handle to dynamic data set }
			-1,						   { display all channels }
			0.35, 0.75, 0.44, 0.97,    { dynamic text rectangle }
			-1,						   { no border }
			0,						   { ignored }
			NIL,					   { text color }
			C_LIGHTGRAY,			   { background color }
			OR_VERT,				   { text layout is vertical }
			5,						   { max # of characters in field }
			1,						   { 1 digit after decimal point }
			hScroll,
			RC_FLAT);				   { no 3d effects }

	{ allocate global array for legends }

  hTags:= GlobalAlloc (GHND, nTraces * LG_MAXLEN);
  lpTags:= GlobalLock (hTags);
  { initialize tags (channel names) }
  lstrcpy (lpTags , 'Chan 1');
  lstrcpy (lpTags + LG_MAXLEN, 'Chan 2');

	{ display dynamic legend }
	WRDynLegend (pGrDesc,		{ pointer to graph descriptor }
		0.05, 0.75, 0.43, 0.96,	{ legend rectangle }
		-1,						{ no border }
		0,						{ ignored }
		C_BLACK,				{ black text }
		C_LIGHTGRAY,			{ light gray background }
		OR_VERT,				{ layout is vertical }
		hTags,					{ legend text }
		hScroll,				{ handle to scroll graph }
		TRUE);					{ use line symbols }

	GlobalFree (hTags);

    { set FAIL alarm message }
    WRSetAlarm (thData, ALM_FAIL, 0.0, 'FAILED');

	{ set current font to Arial, 8 points }
	WGSetTextByName (C_GREEN, 'Arial', 8, TEXT_BOLD);
    WGTextNorm (pGrDesc, thdc, 'DDE Status: ', 0.67, 0.9, TA_LEFT, TEXT_NORMAL);
    WRSetAlarmText (pGrDesc, thData, 0, 0.83, 0.9, 0.0, 0.0, C_YELLOW, 1, C_BLACK,
            'OK', NIL, TA_LEFT, OR_HORZ);


END;


BEGIN

END.
