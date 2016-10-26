{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   Waterfallx.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Waterfallx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
  NUMPOINTS= 64;                // number of data points
 NUMGROUPS= 32;				// number of data groups
VAR
  lpInd: ARRAY[0..NUMPOINTS-1] OF Realtype;
  lpDep: ARRAY[0..NUMPOINTS-1, 0..NUMGROUPS-1] OF Realtype;				// data arrays
  pGraph1: PGRAPH_DEF;
  hWaterfall,  hLegend: HGOBJ;

{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
function randreal:realtype; forward;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
  WGCreatePage ('PAGE1', {  page ID string}
    thwnd,              {  handle to the parent window}
    tInst,              {  application instance handle}
    'First Graph',      {  Window title string}
    @StartGraphs1,      {  pointer to graph creation function}
    'PageMenu',
    {  Name of page window menu in resource file}
    C_LIGHTGRAY,        {  window background color}
    MM_PROPORT,         {  window sizing mode}
    0,                  {  window style - default}
    PAGE_CLIENT,
    {  window initial size and position option}
    0, 0, 0, 0);        {  initial window size and position}
end;

procedure WM_DestroyGraph;
begin
  WGCleanup (TRUE); {  clean up charting tools memory}
  PostQuitMessage (0);
end;

{ *******************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
*********************************************************** }

const
 fInit: BOOL = TRUE;


procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i, k: INTEGER;
    magn: Realtype;
BEGIN
    if (fInit) THEN
    BEGIN

        // create independent and dependent data to be plotted
		for i:=0 TO NUMPOINTS-1 DO
		BEGIN
			lpInd[i] := i * 2.1;
			for k:=0 TO NUMGROUPS-1 DO
			BEGIN
				magn := ( (i)/ 7.0 );
				magn := magn * 0.5 + 0.5 * magn * ( randreal );
				lpDep[i,k] := magn * sin (lpInd[i] / 20);
				lpDep[i,k] := lpDep[i,k] * lpDep[i,k];
			END;
		END;
        fInit := FALSE;
    END;
      // Initialize graph

      WGCreateGraph (pPageDesc,
		 @DrawP1G1, // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.99, 0.99,
		 C_WHITE, // white background
		 C_RED,   // red   border
		 1);
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
   hAxisX, hAxisY: HGOBJ;  // axes handles
   hDataSet: HDATA;        // data set handle
   nLineColor: ARRAY[0..NUMGROUPS-1] OF INTEGER;
   nLineColor2: ARRAY[0..NUMGROUPS-1] OF INTEGER;
   nLineWidth: ARRAY[0..NUMGROUPS-1] OF INTEGER;
   i: INTEGER;
BEGIN
    // define a dataset
    hDataSet := WGDefineGroupDataSetPtr ('Waterfall Plot', @lpInd, @lpDep,
					NUMPOINTS, NUMGROUPS);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    // scale the plotting area
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 200.0, 150.0);

    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis: 0 minor ticks and 
	//  the ticks will be positioned at the center of the axis
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 20.0, 0, POS_MIDDLE);

    // Y axis to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 25 physical coords and 1 minor tick
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 25.0, 1, POS_LEFT);

   // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');
	   // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');


    // Set line style of outline to be black, dotted
    WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_BLACK);


    for i:=0 TO NUMGROUPS -1 DO
    BEGIN
		nLineWidth[i] := 1;
		nLineColor[i] := i MOD 16;
		nLineColor2[i] := (i MOD 8) + 4;
    END;
   hWaterfall := WGWaterfallPlot (pGrDesc, thdc, hDataSet, 1.5, 3.0,
			TRUE, TRUE, TRUE, NIL, @nLineWidth, @nLineColor);
					// fill, baseline, outline

    // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_BLUE, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Waterfall Plot');

    WGToggleOKCursor(FALSE);
end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
