{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   MultAxesX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit MultAxesX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1=200;                  // number of data points
 NUMSCATTER= 200;
VAR
   hXScatter, hYScatter: HGLOBAL;


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
VAR
  X1, Y1, Y2, Y3: ARRAY[0..NUMP1-1] OF Realtype;
  XScatter, YScatter: ARRAY[0..NUMSCATTER-1] OF Realtype;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i: INTEGER;
    z: realtype;
BEGIN
    // create simulation data for plot
    if (fInit) Then // do not initialize data twice
    BEGIN
        // allocate global data arrays
 		// get pointers to data arrays
 		 // create x and y data to be plotted
        for i := 0 TO NUMP1-1 DO
        BEGIN
             z := 0.005 *  i;
	     X1 [i] := z;
	     Y1 [i] := 25 + 10 * sin( z * 100 );
	     Y2 [i] := 1+  i *  i;
	     Y3 [i] := 50 + 100* sin( 50 * z);
         END;
         for i := 0 TO NUMSCATTER-1 DO
         BEGIN
               z :=  i;
	    	 XScatter [i]:=  0.005 * z;
		     YScatter [i] := 150 + 60 * sin(z * 100);
         END;
        fInit := FALSE;
      END;

    // Initialize graph

    // the first graph is defined here
    // DrawGraphP1G1 is the building function
    WGCreateGraph (pPageDesc,
		@DrawP1G1,	// function which builds graph
		 0, 0,		 // window relative position inside parent page window
                  1, 1,
		 C_WHITE, 	// white background
                 -1,
                 0);      	// border width in pixelsend;
END;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
     hAxisX, hAxisY:HGOBJ ; // axes handles
     hDataSet: HDATA;       // data set handle
BEGIN
	
    // define a dataset, display the first 75 data points of the data set. 
 	hDataSet := WGDefineDataSetPtr ('Line1', @X1, @Y1, NUMP1);
    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.3, 0.1, 0.9, 0.9, C_PALEBLUE);
	WGScalePlotArea(pGrDesc, 0.0, 0.0, 0.7, 50.0);

    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // set text style
    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_NORMAL);

    // Intercepts x = 0.0, y = -1.5
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
    // Draw a tick on the y axis every 0.5 from y-intercept,
    hAxisY := WGDrawYAxis (pGrDesc, thdc, 10.0, 0, POS_LEFT);


    // Label Y-axis
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, '');

    // Draw a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 0.1, 5, POS_BELOW);

    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, '');

	//WGLine(pGrDesc, thdc, hAxisX, hAxisY, 0, 30, 1, 30);
	// Display an array of data
    WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);

	// Intercepts x = 0.0, y = -1.5
	WGSetXYIntercepts (pGrDesc, 0.0, 50);

	 // Draw x axies on top with a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 0.1, 5, POS_ABOVE);

    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_ABOVE, NF_DECIMAL, -1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LOG) ;
	WGScalePlotArea(pGrDesc, 0.0, 1.0, 0.7, 100000);
	// define 2 datasets
    hDataSet := WGDefineDataSetPtr ('Line1', @X1, @Y2, NUMP1);

	// Intercepts x = 0.0, y = -1.5
	WGSetXYIntercepts (pGrDesc, 0.7, 1.0);

	//set scale as log scale
	// Draw a tick on the y axis every 0.5 from y-intercept,
    hAxisY := WGDrawYAxis (pGrDesc, thdc, 10, 5, POS_RIGHT);

	 // Label Y-axis
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_RIGHT, NF_SCIENTIFIC, -1, LL_ON, '');
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);
	// Display an array of data
    WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);
	

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLUE);
	//set type of the scale
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR) ;

	// set plotting area of the scale
	WGScalePlotArea(pGrDesc, 0.0, -200.0, 0.7, 150.0);
    // define  dataset
    hDataSet := WGDefineDataSetPtr ('Line1', @X1, @Y3, NUMP1);
		
    // Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, -0.1, -200.0);
    //draw y axies with 5 ticks between two major ticks & diffrence between two
	//parametre is 50
    hAxisY := WGDrawYAxis (pGrDesc, thdc, 50, 10, POS_LEFT);
    //label y axies
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, '');
    //draw line using dataset
    WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);      
	

	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_GREEN);
	//set type of the scale
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR) ;

	// set plotting area of the scale    
	WGScalePlotArea(pGrDesc, 0.0, 100.0, 0.7, 300.0);
    // define  dataset
    hDataSet := WGDefineDataSetPtr ('Line1', @XScatter, @YScatter, NUMSCATTER);

    // Intercepts x := 0.0, y = -1.5
	WGSetXYIntercepts (pGrDesc, -0.2, 100.0);

    //draw y axies with 5 ticks between two major ticks & diffrence between two
	//parametre is 50
    hAxisY := WGDrawYAxis (pGrDesc, thdc, 100, 10, POS_LEFT);
    //label y axies
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON,'');
    //draw line using dataset
    WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);


end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
