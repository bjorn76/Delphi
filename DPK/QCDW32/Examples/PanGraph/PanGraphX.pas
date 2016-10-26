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
unit PanGraphX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure UpdateHorzPos (npos: INTEGER);
procedure UpdateVertPos (npos: INTEGER);

procedure WM_DestroyGraph;

implementation

{$R demo}
const
 NUMSCATTER =100;

 var
 hXScatter, hYScatter: HGLOBAL;
 hAxisX,
 hAxisY:  HGOBJ;
 pGraphDesc: PGRAPH_DEF;


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
   WS_CHILD OR WS_CLIPCHILDREN OR WS_VISIBLE,                 // window style - default
   PAGE_EXACT,        // window initial size and position option
   0, 0, 600, 400);        {  initial window size and position}
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
  XScatter, YScatter: ARRAY[0..NUMSCATTER-1] OF Realtype;
   lpXScatter, lpYScatter: LPREAL;
procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i: INTEGER;
    z: Realtype;

BEGIN

    // create simulation data for plot

    if (fInit) THEN// do not initialize data twice
    BEGIN

	lpXScatter := @XScatter;
	lpYScatter := @YScatter;

		//data for plot
	for i := 0 TO NUMSCATTER-1 DO
        BEGIN
             z :=  i ;
    	     XScatter [i]:= z;
	     YScatter [i] := 5 + (30 * (cos(z * 10))) + (1/(exp(z * 5)));
	END;
        fInit := FALSE;

    END;

    // Initialize graph

    // the first graph is defined here
    // DrawGraphP1G1 is the building function
    pGraphDesc := WGCreateGraph (pPageDesc,
		@DrawP1G1,	// function which builds graph
		 0, 0,		 // window relative position inside parent page window
                 1, 1,
		 C_LIGHTGREEN, 	// white background
                 -1,
                 0);      	// border width in pixels
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
     hPlot:HGOBJ;
     hDataSet:HDATA;        // data set handle
BEGIN

    // define a dataset, display the first 75 data points of the data set.
    hDataSet := WGDefineDataSetPtr ('Line1', lpXScatter, lpYScatter, NUMSCATTER);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.10, 0.1, 0.85, 0.8, C_LIGHTRED);


    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

	WGScalePlotArea(pGrDesc, 0.0, 0.0, 20, 100.0);

    // Intercepts x = 0.0, y = -1.5
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
    // Draw a tick on the y axis every 0.5 from y-intercept,
     hAxisY := WGDrawYAxis (pGrDesc, thdc, 10.0, 10, POS_LEFT);

    // set current font to Modern, 6 points, bold, italic
    WGSetTextParams (C_BLACK, FF_MODERN, 10, TEXT_BOLD OR TEXT_ITAL);

    // Label Y-axis
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, '');

    // Draw a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 1, 10, POS_BELOW);

    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, '');
	// set text style
    WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_NORMAL);
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTRED);

	hPlot := WGScatterPlot (pGrDesc, thdc, hDataSet, MK_CIRCLE, C_LIGHTGREEN, 6, MKS_FILLED, TRUE);
	WGTextNorm(pGrDesc, thdc, 'VVV Use ScrollBar to see rest of the Plot VVV', 0.12, 0.008, TA_LEFT OR TA_TOP, TEXT_NORMAL);

    WGSetGraphBitBltMode(pGrDesc, TRUE);

end;

Const
  nHLastPos: INTEGER = -1;

procedure UpdateHorzPos (npos: INTEGER);

var
   rMin, rMax, rInt: Realtype;
BEGIN
   if (nHLastPos <> nPos) THEN
        WGGetAxisRange (pGraphDesc, hAxisX, rMin, rMax, rInt);

   rMin := nPos;
   rMax := rMin + 20.0;

  WGChangeAxisRange (pGraphDesc, hAxisX, rMin, rMax, TRUE);
  WGChangeAxisIntercept(pGraphDesc, hAxisY, rMin, TRUE);
  nHLastPos := nPos;

END;

Const
  nVLastPos: INTEGER = -1;

procedure UpdateVertPos (npos: INTEGER);
var
   rMin, rMax, rInt: Realtype;
BEGIN
    if (nVLastPos <> nPos) THEN
    BEGIN
     WGGetAxisRange (pGraphDesc, hAxisY, rMin, rMax, rInt);

     rMax := nPos + 50;
     rMin := rMax - 100;

     WGChangeAxisRange (pGraphDesc, hAxisY, rMin, rMax, TRUE);
	 WGChangeAxisIntercept(pGraphDesc, hAxisX, rMin, TRUE);
	 nVLastPos := nPos;
	END;

END;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
