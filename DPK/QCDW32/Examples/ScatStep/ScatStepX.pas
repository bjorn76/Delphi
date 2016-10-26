{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ScatStepX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit ScatStepX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1 =25;                  // number of data points
 NUMP2 =5;

var
  X1, Y1,
  X2, Y2, Y3, Y4: ARRAY[0..NUMP1-1] OF Realtype;
  X5, Y5: ARRAY[0..NUMP2-1] OF Realtype;

 hLegend: HGOBJ;
 hScatX, hScat2: HGOBJ;
 pGraph1: PGRAPH_DEF;
 hTextX, hTextY:HGOBJ;


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
    i: INTEGER;
    z: Realtype;
BEGIN
    // create simulation data for plots
   if (fInit) THEN// do not initialize data twice
   BEGIN
		// create x and y data to be plotted
        for i := 0 TO NUMP1 DO
        BEGIN
              z :=  (i);
              X1 [i] := z + 1.0;
              Y1 [i] := 20.0 + z * 1000.0 * randreal;

	      X2 [i] := X1[i];
	      Y2 [i] := Y1[i] + 1000.0 * randreal;
  	      Y3 [i] := Y2[i] + 1000.0 * randreal;
	      if (i<(NUMP1/2)) THEN
  	    	Y4 [i] := (33.0 + z * 200.0 * randreal) + (z * 1250.0) + 1300
	      else
  	    	Y4 [i] := (33.0 + z * 200.0 * randreal) + (z * 500.0) + 4000;

        END;
	X5[0] := X2[10];		Y5 [0] := Y4[10];
	X5[1] := X2[14];		Y5 [1] := Y4[14];
	X5[2] := X2[17];		Y5 [2] := Y4[17];
	X5[3] := X2[20];		Y5 [3] := Y4[20];
	X5[4] := X2[22];		Y5 [4] := Y4[22];

        fInit := FALSE;
    END;

	// Initialize graph
    pGraph1 := WGCreateGraph (pPageDesc,
                 @DrawP1G1, // points to function which builds graph
                 0.05, 0.05,    // window relative position inside parent page window
                 0.95, 0.95,
                 C_WHITE,      // white background
                 C_GREEN,      // green border
                 4);           // border width in pixels


end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
    hAxisXbottom, hAxisXtop, hAxisYleft, hAxisYright:   HGOBJ; // axes handles
    hDataScat1, hDataScat2: HDATA;       // data set handle
    hDataShark, hDataLine: HDATA;
    hDataBmp: HDATA;
    lpLegStr: Array[0..5 * LG_MAXLEN-1] Of CHAR;
BEGIN
    // define a dataset
    hDataScat1 := WGDefineDataSetPtr ('Scat1', @X1, @Y1, NUMP1);
    hDataScat2 := WGDefineDataSetPtr ('Scatter', @X2, @Y2, NUMP1);
    hDataShark := WGDefineDataSetPtr ('Shark', @X2, @Y3, NUMP1);
    hDataLine  := WGDefineDataSetPtr ('StepLine', @X2, @Y4, NUMP1);
    hDataBmp := WGDefineDataSetPtr ('Bitmap', @X5, @Y5, NUMP2);

	 // Mark some data points as invalid

	WGMarkDataPoint (hDataScat1, 5, TRUE);
	WGMarkDataPoint (hDataScat1, 7, TRUE);
	WGMarkDataPoint (hDataScat1, 20, TRUE);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.85, 0.85, C_WHITE);

	// scale the plotting area, x ranges from 0 to 25, y ranges from 0 to 25000
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 25.0, 20000.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // set line style of axes to solid, RED
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);

    // draw the x axis, major ticks every 5 units, with 4 minor ticks between each interval
    hAxisXbottom := WGDrawXAxis(pGrDesc, thdc, 5.0, 4, POS_BELOW);

    // draw the y axis, major ticks every 5000 units, with no minor ticks
    hAxisYleft := WGDrawYAxis(pGrDesc, thdc, 5000.0, 0, POS_LEFT);

    // set line style to dotted, MAGENTA, 
    WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_MAGENTA);

    // draw a y axis grid on the major tick intervals.
    WGDrawGrid(pGrDesc, hAxisYleft, GRID_MAJOR);

    // set current font family to Swiss, 10 points, bold
    WGSetTextParams (C_RED, FF_SWISS, 10, TEXT_BOLD);

    // label the x axis
    WGLabelAxis(pGrDesc, thdc, hAxisXbottom, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	// label the y axis, display the axis labels in scientific notation
	WGLabelAxis(pGrDesc, thdc, hAxisYleft, POS_LEFT, NF_ENG, 1, LL_ON, '');

	//*
	// CREATE 5 DATA PLOTS, EACH WITH A DIFFERENT DATASET
	WGScatterPlot (pGrDesc, thdc, hDataScat1, 
				   MK_CIRCLE, C_BLUE, 14, MKS_FILLED, TRUE);
	WGScatterPlot (pGrDesc, thdc, hDataScat2,
				   MK_DIAMOND, C_YELLOW, 14, MKS_FILLED, FALSE);
	
	// Set line style - color is used for text in legend
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 5, C_BLACK);
	hScatX := WGScatterPlotEx (pGrDesc, thdc, hDataShark, 
				   MK_METAFILE, 'shark.wmf', 20, FALSE);

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);
	WGLinePlotEx (pGrDesc, thdc, hDataLine, FALSE, STEP_END);

	// Set line style - color is used for text in legend
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_GREEN);
	WGScatterPlotEx (pGrDesc, thdc, hDataBmp, 
				   MK_BITMAP, 'sym2.bmp', 20, FALSE);
	//*

    // Write axes titles
	WGSetTextByName (C_BLACK, 'Arial', 12, TEXT_BOLD);
	hTextY := WGTitleAxis(pGrDesc, thdc, hAxisYleft, POS_LEFT, 'Volts');
	hTextX := WGTitleAxis(pGrDesc, thdc, hAxisXbottom, POS_BELOW, 'Sample Interval');

    // set current font to Arial, 11 points, bold
	WGSetTextByName (C_GREEN, 'Arial', 11, TEXT_BOLD);

    // set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);

    // Now the top and right axes are drawn
    
    // set the intercepts to 25, 25000
	WGSetXYIntercepts (pGrDesc, 25.0, 25000.0);

    // draw the x axis, the axis will be drawn from 0 to 25, as above. Since the y intercept
    // is now at 25000, the x axis will appear on the top of the plotting area.
    hAxisXtop := WGDrawXAxis(pGrDesc, thdc, 5, 4, POS_ABOVE);

    // draw the y axis, the range is from 0 to 25000.0, as above. 
    // Since the x-intercept is now at 25, 
    // the second y-axis will appear to the right of the plotting area.
    hAxisYright := WGDrawYAxis(pGrDesc, thdc, 5000.0, 0, POS_RIGHT);

    // label the x and y axis
    // return a handle to the text object.  This handle will be used
    // to change the color of the X and Y Axis Titles.
    WGLabelAxis(pGrDesc, thdc, hAxisXtop, POS_ABOVE, NF_DECIMAL, 1, LL_ON, '');
    // this time the axis labels are in engineering notation
    WGLabelAxis(pGrDesc, thdc, hAxisYright, POS_RIGHT, NF_ENG, -1, LL_ON, '');

    lstrcpy(lpLegStr, 'Circular');
    lstrcpy(lpLegStr + LG_MAXLEN, 'One');
    lstrcpy(lpLegStr + 2* LG_MAXLEN, 'Metafile');
    lstrcpy(lpLegStr + 3* LG_MAXLEN, 'Line');
    lstrcpy(lpLegStr + 4* LG_MAXLEN, 'Bitmap');

    WGSetTextByName (C_BLUE, 'Times New Roman', 10, TEXT_ITAL);

	hLegend := WGLegendPtr(pGrDesc, thdc, 0.18, 0.075, 0.42, 0.31,
					 C_LIGHTBLUE, 2, -1, C_LIGHTGRAY, OR_VERT,
					 lpLegStr);

end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
