{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   GroupLnX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit GroupLnX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}
const
  NUMP1 =21;                  // number of data points for graph 1
  NUMP2 =5;                   // number of data points for graph 2
  NUMGROUP= 5;                // number of groups

VAR
 lpX1, lpY1, lpY2,
 lpGX1, lpGY1,
 lpNX1, lpNY1,
 lpNX2, lpNY2,
 lpNX3, lpNY3,
 lpNX4, lpNY4,
 lpNX5, lpNY5: LPREAL;

   lpXStr, lpXStr2: Array[0..2 * NUMP2 * LABELLEN -1 ] OF Char;  // string arrays

  pPageDesc: PPAGE_DEF;
  pGraph2, pGraph3: PGRAPH_DEF;

  hGroupLines,
  hTextP, hTextL,
  hRectP, hRectL,
  hLabX1, hLabX2, hLabY: HGOBJ;

{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
procedure DrawP1G3 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
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
VAR
  X1, Y2: ARRAY[0..NUMP1-1] OF Realtype;
  Y1: ARRAY[0..NUMP1-1,0..2] OF Realtype;
  GX1: ARRAY[0..NUMP2-1] OF Realtype;
  GY1: ARRAY[0..NUMP2-1, 0..NUMGROUP-1] OF RealType;
 NX1, NY1,
 NX2, NY2,
 NX3, NY3,
 NX4, NY4,
 NX5, NY5: ARRAY[0..NUMP2-1] OF Realtype;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
   i, j: INTEGER;
   z, sp: Realtype;
BEGIN
    // create simulation data for plot
   if (fInit) THEN// do not initialize data twice
   BEGIN
        // define data for first graph
        lpX1 := @X1;
	lpY1 := @Y1;
	lpY2 := @Y2;
        lpNX1 := @NX1; lpNY1 := @NY1;
        lpNX2 := @NX2; lpNY2 := @NY2;
        lpNX3 := @NX3; lpNY3 := @NY3;
        lpNX4 := @NX4; lpNY4 := @NY4;
        lpNX5 := @NX5; lpNY5 := @NY5;


  	lstrcpy (lpXStr, 'Jan');
  	lstrcpy (lpXStr + LABELLEN, '');
  	lstrcpy (lpXStr + 2 * LABELLEN, 'Mar');
  	lstrcpy (lpXStr + 3 * LABELLEN, '');
  	lstrcpy (lpXStr + 4 * LABELLEN, 'May');
  	lstrcpy (lpXStr + 5 * LABELLEN, '');
  	lstrcpy (lpXStr + 6 * LABELLEN, 'Jul');
  	lstrcpy (lpXStr + 7 * LABELLEN, '');
  	lstrcpy (lpXStr + 8 * LABELLEN, 'Sept');
  	lstrcpy (lpXStr + 9 * LABELLEN, '');

  	lstrcpy (lpXStr2, 'Feb');
  	lstrcpy (lpXStr2 + LABELLEN, '');
  	lstrcpy (lpXStr2 + 2 * LABELLEN, 'Apr');
  	lstrcpy (lpXStr2 + 3 * LABELLEN, '');
  	lstrcpy (lpXStr2 + 4 * LABELLEN, 'Jun');
  	lstrcpy (lpXStr2 + 5 * LABELLEN, '');
  	lstrcpy (lpXStr2 + 6 * LABELLEN, 'Aug');
  	lstrcpy (lpXStr2 + 7 * LABELLEN, '');
  	lstrcpy (lpXStr2 + 8 * LABELLEN, '');
  	lstrcpy (lpXStr2 + 9 * LABELLEN, '');

		// initialize data
        z := 0.0;
        for i := 0 TO NUMP1 - 1 DO
        BEGIN
	   z := z + 1.0;
	   if  (((i + 1) MOD 5) = 0) THEN                     z := z + 2.0;
       	     X1 [i] := z;
	   sp := 10 + i + 3 * randreal;
           Y1 [i,0] :=  sp + 1.0+3.0 * randreal;
       	   Y1 [i, 1] := sp - 1.0-3.0 * randreal;
	   Y1 [i, 2] := sp;
       	   z := z + 1.0;
	   Y2 [i] := 10 + i + 3 * randreal;
        END;

        lpGX1 := @GX1;
    	lpGY1 := @GY1;

        for i := 0 TO NUMP2-1 DO
	  for j := 0 TO NUMGROUP-1 DO
   	     GY1[i,j] := (randreal * 5.0 * (j+1)) + randreal;

        for i:=0 TO NUMP2-1  DO
	    for j := 0 TO NUMGROUP-1  DO
		BEGIN
		  GX1[j] := j;
    		  GY1[i,j] := j*NUMP2+i + 2 + (j * randreal *3);
		END;


    for i := 0 TO NUMP2-1 DO
    BEGIN
 		NX1[i] := i * 1.0; NY1[i] := GY1[i,0];
		NX2[i] := i * 1.0; NY2[i] := GY1[i,1];
 		NX3[i] := i * 1.0; NY3[i] := GY1[i,2];
 		NX4[i] := i * 1.0; NY4[i] := GY1[i,3];
 		NX5[i] := i * 1.0; NY5[i] := GY1[i,4];
    END;

    // Initialize graph
   END;

	// Grouped Line Plot
    pGraph2 := WGCreateGraph (pPageDesc,
		 @DrawP1G2,		// points to function which builds graph
		 0.02, 0.02,	// window realtive position inside parent page window
		 0.48, 0.88,
		 C_BLUE,		// blue background
 		 C_LIGHTRED,	// light red border
		 3);			// border width in pixels

	// Stacked Line Plot
    WGCreateGraph (pPageDesc,
		 @DrawP1G1,		// points to function which builds graph
 		 0.5, 0.02,		// window realtive position inside parent page window
 		 0.98, 0.88,
		 C_WHITE,		// white background
 		 C_CYAN,		// light cyan border
 		 5);			// border width in pixels

	// Text Window - simulated buttons
    pGraph3 := WGCreateGraph (pPageDesc,
		 @DrawP1G3,		// points to function which builds graph
		 0.25, 0.895,	// window realtive position inside parent page window
		 0.75, 0.995,
 		 C_YELLOW,		// yellow background
		 C_GRAY,		// gray border
		 3);			// border width in pixels
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
     hAxisX, hAxisY, hAxisXLab, hAxisYLab: HGOBJ;
     hDataSet1: HDATA;
     nLineColor: ARRAY[0..NUMP1-1] OF INTEGER;
BEGIN
    // define a group data set for Stacked plot, group size = 3
    hDataSet1 := WGDefineGroupDataSetPtr ('Stacked', lpX1, lpY1, NUMP1, 3);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, thdc, 0.18, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, 0.0, 5.0, 50.0, 100.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 5.0);

    // draw the x axis with major ticks every 1 physical coords and 0 minor
    // tick between each major tick
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 10.0, 0, POS_BELOW);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 10, 1, POS_LEFT);

	// set the font to ARIAL, 8 points
    WGSetTextByName (C_BLACK, 'Arial', 9, 0);

    // label x and y axis in decimal format
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_ON, '');
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, '');

    // draw an x axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);

    // draw an y axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    // change the line style to solid, green, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_GREEN);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);

	nLineColor[0] := C_CYAN;
	nLineColor[1] := C_BLACK;
	nLineColor[2] := C_GREEN;

    // display the stacked line graph, filling the adjacent area beteen the lines
	WGStackedLines (pGrDesc, thdc, hDataSet1, TRUE, NIL, NIL, @nLineColor);

    // change to bold text
    WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Trading by Day');

    // display the y axis title
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Stock Price');

    // now set text to ARIAL, size 14, bold text
    WGSetTextByName (C_BLUE, 'Arial', 14, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, thdc, 'Stacked Line Plot');

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, 'Arial', 8, 0);

end;

procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
    hAxisX, hAxisY, hAxis2: HGOBJ;
    hDataSet,          // data set handle
    hNorm1, hNorm2, hNorm3, hNorm4, hNorm5: HDATA;
    i: INTEGER;
    nLineWidth, nLineColor: ARRAY[0..NUMGROUP-1] OF INTEGER;
  begin

    // define a group data set
    hDataSet := WGDefineGroupDataSetPtr ('GROUP LINE', lpGX1, lpGY1, 
        NUMP2, NUMGROUP);

	hNorm1 := WGDefineDataSetPtr('Scatter', lpNX1, lpNY1, NUMP2);
	hNorm2 := WGDefineDataSetPtr('Scat2', lpNX2, lpNY2, NUMP2);
	hNorm3 := WGDefineDataSetPtr('Scat3', lpNX3, lpNY3, NUMP2);
	hNorm4 := WGDefineDataSetPtr('Scat4', lpNX4, lpNY4, NUMP2);
	hNorm5 := WGDefineDataSetPtr('Scat5', lpNX5, lpNY5, NUMP2);


    // set the plotting area
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, -0.5, 0.0, 4.5, 40.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, -0.5, 0.0);

    // axes to be drawn as a solid black line, 1 pixel thick.
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTGRAY);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 10, 1, POS_LEFT);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 0.5, 0, POS_BELOW);

    // assign each line width
    for i := 0 TO NUMGROUP-1 DO
    	nLineWidth[i] := 2;

    // assign each line color
   	nLineColor [0] := C_GREEN;
   	nLineColor [1] := C_LIGHTMAGENTA;
   	nLineColor [2] := C_YELLOW;
   	nLineColor [3] := C_BLUE;
   	nLineColor [4] := C_LIGHTRED;

    hGroupLines := WGGroupLines (pGrDesc, thdc, hDataSet, FALSE, NIL, @nLineWidth, @nLineColor);

	WGScatterPlot(pGrDesc, thdc, hNorm1, MK_ASTERISK, C_WHITE, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, thdc, hNorm2, MK_UPTRIANGLE, C_BLACK, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, thdc, hNorm3, MK_DOWNTRIANGLE, C_YELLOW, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, thdc, hNorm4, MK_BOX, C_LIGHTCYAN, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, thdc, hNorm5, MK_CIRCLE, C_LIGHTBLUE, 8, MKS_FILLED, FALSE);


	// set the font to ARIAL, 8 points
    WGSetTextByName (C_WHITE, 'Arial', 8, 0);

    // label the y-axis, display labels in decimal format
    hLabY := WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NIL);

    // label x axis with months as strings
	hLabX1 := WGLabelAxisStringsPtr (pGrDesc, thdc, hAxisX, POS_BELOW, 1, lpXStr);

    // now set text to ARIAL, size 12, bold text
    WGSetTextByName (C_WHITE, 'Arial', 12, TEXT_BOLD);

    // display the graph title
    WGTitleGraph(pGrDesc, thdc, 'Sales');

	// Draw second X-axis below
    WGSetXYIntercepts (pGrDesc, -0.5, -5.0);
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTGRAY);
    hAxis2 := WGDrawXAxis(pGrDesc, thdc, 0.5, 0, POS_BELOW);

    WGSetTextByName (C_WHITE, 'Arial', 8, 0);
	hLabX2 := WGLabelAxisStringsPtr (pGrDesc, thdc, hAxis2, POS_BELOW, 2, lpXStr2);

end;


procedure DrawP1G3 (pGrDesc:PGRAPH_DEF; thdc:HDC);
begin
	hRectP := WGRectangleNorm (pGrDesc, thdc, 0.18, 0.075, 0.37, 0.9,
		C_BLACK, 2, TRUE, RGB(255, 255, 128));

	hRectL := WGRectangleNorm (pGrDesc, thdc, 0.57, 0.075, 0.83, 0.9,
		C_BLACK, 2, TRUE, RGB(255, 255, 128));

	WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD);

	hTextP := WGMultiTextNorm (pGrDesc, thdc, 'Print' + chr(10) + 'Portrait',
		0.2, 0.09, TA_LEFT, TEXT_NORMAL);
	hTextL := WGMultiTextNorm (pGrDesc, thdc, 'Print' + chr(10) +'Landscape',
		0.7, 0.09, TA_CENTER, TEXT_NORMAL);

end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
