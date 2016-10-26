{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AUTOAXES.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit MultiPltX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
  NUMP1 =8;                    // number of data points

VAR
lpXStr: ARRAY[0..NUMP1 *LABELLEN-1] OF CHAR;                    // string array
		   
lpX1, lpY1, lpY2: ARRAY[0..7] of Realtype;          // data arrays

hBar, hScat, hLineMark, hLine,
hTextLeft, hTextCenter, hTextRight,
hTextLeft2, hTextCenter2, hTextRight2: HGOBJ;
pGraph1: PGRAPH_DEF ;
hDataSet, hDataSet2: HDATA;        // data set handles

hMultiText,hMulti2: HGOBJ;

bSucc: BOOL;

rgbColors,
rgbLineMarkColors,
rgbLineColors: ARRAY[0..NUMP1-1] OF COLORREF;	// for line plot

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
VAR i: INTEGER;
    z: Realtype;
BEGIN
    // create simulation data for plot

    if (fInit) THEN // do not initialize data twice
   BEGIN

        // create x and y data to be plotted
        FOR i := 0 TO NUMP1 - 1 DO
        BEGIN
            z := i;
            lpX1 [i] := z;
        END;
        lpY1[0] := 50.0;
        lpY1[1] := 26.2;
        lpY1[2] := 111.2;
        lpY1[3] := 116.6;
        lpY1[4] := -871.3;
        lpY1[5] := 28.6;
    	lpY1[6] := -138.3;
        lpY1[7] := -294.1;

        lpY2[0] := 20.0;
        lpY2[1] := 22.25;
        lpY2[2] := 18.75;
        lpY2[3] := 12.5;
        lpY2[4] := 8.25;
        lpY2[5] := 11.0;
    	lpY2[6] := 12.0;
        lpY2[7] := 11.5;


		// copy strings to x axis string array, be sure to index correctly when
        // assigning each string!
		lstrcpy (lpXStr, '3Q96');
		lstrcpy (lpXStr + LABELLEN, '4Q96');
		lstrcpy (lpXStr + 2 * LABELLEN, '1Q97');
		lstrcpy (lpXStr + 3 * LABELLEN, '2Q97');
		lstrcpy (lpXStr + 4 * LABELLEN, '3Q97');
		lstrcpy (lpXStr + 5 * LABELLEN, '4Q97');
		lstrcpy (lpXStr + 6 * LABELLEN, '1Q98');

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
   i: INTEGER;
BEGIN
    // define a dataset
    hDataSet := WGDefineDataSetPtr ('Loss', @lpX1, @lpY1, NUMP1);
    hDataSet2 := WGDefineDataSetPtr ('Stock Price', @lpX1, @lpY2, NUMP1);

    // define the plotting area of the graph,
    // set the background color of the plotting area to light cyan
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_PALEBLUE);

    // scale the plotting are for an x range of 0 to 7.95
    // and y range of -900 to 200
	WGScalePlotArea (pGrDesc, 0.0,-900.0, 7.95, 200.0);

    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis with major ticks every physical coord and 0 minor tick
    // the ticks will be positioned at the center of the axis
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 0, POS_MIDDLE);

    // Y axis to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 100 physical coords and 1 minor ticks
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 100.0, 1, POS_LEFT);

    // draw an axis grid on the major tick intervals
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

        FOR i := 0 TO NUMP1 - 1 DO
	BEGIN
		rgbColors[i] := WGGetRGBColor(i);
		rgbLineMarkColors[i] := WGGetRGBColor(i + 9);
		rgbLineColors[i] := WGGetRGBColor(i + 9);
	END;

	// *---------------------------------------------------------
	// Draw plots using multiple colors - one for each data point
	// display a bar graph with centered bars, width equals 0.9, no hatching or border
	hBar := WGBargraph (pGrDesc, thdc, hDataSet, 0.9, POS_MIDDLE, LT_3DVBAR,
		    WGGetRGBColor (C_MAGENTA), -1, -1); 
	bSucc := WGSetMultiColors (pGrDesc, hBar, TRUE, @rgbColors);

	hScat := WGScatterPlot (pGrDesc, thdc, hDataSet, MK_DOWNTRIANGLE, C_WHITE, 
				   18, MKS_FILLED, FALSE);
	bSucc := WGSetMultiColors (pGrDesc, hScat, TRUE, @rgbColors);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_YELLOW);
	hLineMark := WGLineMarkerPlot (pGrDesc, thdc, hDataSet, 
								  MK_CIRCLE, C_YELLOW, 10, MKS_FILLED);
	bSucc := WGSetMultiColors (pGrDesc, hLineMark, TRUE, @rgbLineMarkColors);

	// *---------------------------------------------------------

    // set the font to Arial, size 10
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

	// Label the axes with strings, display labels at the bottom of the plotting area
	WGLabelAxisStringsPtr(pGrDesc, thdc, hAxisX, POS_BELOW_PLOT, 1, lpXStr);

    // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

    // set line style of arrow to solid, BLACK, 0 pixels wide
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 0, C_BLACK);

    // draw an arrow.  This arrow will point to the left, and will be filled
    WGArrow (pGrDesc, thdc, hAxisX, hAxisY, 4.55, -785.0, 5.5, -775.0, 6, 6, TRUE, FALSE, TRUE);

    // load the 'star' meta file and display it in the plotting area
    WGMetafile (pGrDesc, thdc, hAxisX, hAxisY, 4.25, -450.0, 7.25, -850.0,
            'STAR.WMF');

	// *---------------------------------------------------------
	// Draw various multi-line text strings, with different angles
	// and colors
	WGSetTextByName (C_BLACK, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);
	hMultiText :=  WGMultiText (pGrDesc, thdc, hAxisX, hAxisY,
			'Multiple' + char(13) + 'Lines ' + char(13) + 'of Text', 1.0, -450.0,
		    TA_LEFT, TEXT_NORMAL);

	// Rotated 30 degrees
	WGSetTextByName (C_RED, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);
	hMultiText :=  WGMultiText (pGrDesc, thdc, hAxisX, hAxisY,
			'Multiple' + char(13) + 'Lines ' + char(13) + 'of Text', 2.5, -450.0,
		    TA_LEFT, 300); 

	// Rotated 90 degrees
	WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);
	hMultiText :=  WGMultiText (pGrDesc, thdc, hAxisX, hAxisY, 
			'Multiple' + char(13) + 'Lines ' + char(13) + 'of Text', 7.0, -450.0,
		    TA_LEFT, TEXT_VERTLEFT);

	// Rotated 270 degrees
	WGSetTextByName (C_BLUE, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);
	hMultiText :=  WGMultiText (pGrDesc, thdc, hAxisX, hAxisY, 
			'Multiple' + char(13) + 'Lines ' + char(13) + 'of Text', 7.0, -450.0,
		    TA_LEFT, TEXT_VERTRIGHT);

	// Rotated 0 degrees
	WGSetTextByName (C_YELLOW, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);
	hMulti2 := WGMultiText (pGrDesc, thdc, hAxisX, hAxisY,
			'Multiple' + char(13) + 'Lines ' + char(13) + 'of Text', 7.0, -450.0,
		    TA_LEFT, TEXT_NORMAL);

    // Now output 3 strings in the center of the metafile 'star'
	hTextCenter2 := WGText (pGrDesc, thdc, hAxisX, hAxisY, 
			'Big Loss', 5.75, -610.0,
			TA_CENTER, TEXT_NORMAL);

	WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);
	hTextLeft2 := WGText (pGrDesc, thdc, hAxisX, hAxisY,
			'Big Loss', 5.75, -655.0,
		    TA_LEFT, TEXT_NORMAL);

	WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD);
	hTextRight2 := WGText (pGrDesc, thdc, hAxisX, hAxisY,
			'Big Loss', 5.75, -655.0,
		    TA_RIGHT, TEXT_NORMAL);

	// 3 multi-text string with different alignment
	WGSetTextByName (C_WHITE, 'Arial', 12, TEXT_BOLD);
	hTextCenter := WGTextNorm (pGrDesc, thdc, 'CENTER STRING', 0.5, 0.27,
			TA_CENTER  OR  TA_BOTTOM, TEXT_NORMAL);
	WGSetTextByName (C_YELLOW, 'Arial', 12, TEXT_BOLD);
	hTextLeft := WGTextNorm (pGrDesc, thdc, 'LEFT STRING', 0.5, 0.3, 
			TA_LEFT, TEXT_NORMAL);
	WGSetTextByName (C_LIGHTRED, 'Arial', 12, TEXT_BOLD);
	hTextRight := WGTextNorm (pGrDesc, thdc, 'RIGHT STRING', 0.5, 0.3,
			TA_RIGHT, TEXT_NORMAL);

	// Additional test of more rotations with WGMultiTextNorm
	WGSetTextByName (C_BLACK, 'Arial', 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, thdc, 'RIGHT' + char(13) +'STRING',
			0.2, 0.4, TA_LEFT, TEXT_NORMAL);

	WGSetTextByName (C_RED, 'Arial', 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, thdc, 'RIGHT'+ char(13) + 'STRING',
			0.3, 0.4, TA_LEFT, 300);

	WGSetTextByName (C_BLUE, 'Arial', 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, thdc, 'RIGHT'+ char(13) + 'STRING',
			0.4, 0.4, TA_LEFT, TEXT_VERTLEFT);

	WGSetTextByName (C_WHITE, 'Arial', 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, thdc, 'RIGHT'+ char(13) + 'STRING',
			0.5, 0.4, TA_LEFT, TEXT_VERTRIGHT);
	// *---------------------------------------------------------

    // set current font to Arial, 12 points
    WGSetTextByName (C_WHITE, 'Arial', 12, 0);

    // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Quarter');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Millions of dollars');

    // plot second data set in different coordinates
    // scale the plotting are for an x range of 0 to 7.95
    // and y range of 0 to 25
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 7.95, 25.0);

    // set the intercepts to right side
	WGSetXYIntercepts (pGrDesc, 7.95, 0.0);

    // Second Y axis to be drawn in solid, Red, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);

    // draw the y axis with major ticks every 5 physical coords and 4 minor ticks
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_RIGHT);

    // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_RIGHT, NF_DECIMAL, 1, LL_TEXT, '$');

	// plot stock price data
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 4, C_LIGHTRED);
	hLine := WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);
	bSucc := WGSetMultiColors (pGrDesc, hLine, TRUE, @rgbLineColors);

    // set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_WHITE, 'Arial', 16, TEXT_BOLD  OR  TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'BIG Computer Co.');
 
end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
