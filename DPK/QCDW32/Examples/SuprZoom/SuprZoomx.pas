{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SuprZoomX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit SuprZoomx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}
const
 NUMP1 =80;                  // number of data points

VAR
  X1, Y1, Y2, Y3, Y4, Y5: ARRAY[0..NUMP1-1] OF Realtype;           // data arrays
  hDataSet, hDataSet2, hDataSet3, hDataSet4, hDataSet5: HDATA;        // data set handles
  hX1, hY1, hY2, hY3, hY4, hY5, hY6: HGOBJ; // axis handles
  pGraphDesc: PGRAPH_DEF;

{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
function randreal:realtype; forward;
Procedure ProcessSuperZoom(thwnd: HWND;  pGrDesc: PGRAPH_DEF;
   message: UINT; ptMouse: TPOINT ); far; forward;

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
     i,j: INTEGER;
     z:realtype;
    lpX1, lpY1: LPREAL;
    sName: string;
    pName: ARRAY[0..19] OF CHar;
    // create simulation data for plot
BEGIN
   if (fInit) then // do not initialize data twice
    begin
	// create x and y data to be plotted
	for i := 0 TO NUMP1 -1 DO
	BEGIN
	 z :=  i;
	 X1 [i] := z;
	 Y1 [i] := 15.0 *
	 cos(M_PI * z / (4.0+ 0.3 * randreal)) +
	    3.0 * randreal;
         Y2 [i] := 50 + 30.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal)) +
			 3.0 * randreal;

         Y3 [i] := 90.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal)) +
			 3.0 * randreal;

	 Y4 [i] := 200 +  225.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal)) +
			 3.0 * randreal;

	 Y5 [i] := 1.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal)) +
			 3.0 * randreal;

	END;

 	// define a dataset
	hDataSet := WGDefineDataSetPtr ('Data 1', @X1, @Y1, NUMP1);
	hDataSet2 := WGDefineDataSetPtr ('Data 2', @X1, @Y2, NUMP1);
  	hDataSet3:= WGDefineDataSetPtr ('Data 3', @X1, @Y3, NUMP1);
	hDataSet4 := WGDefineDataSetPtr ('Data 4', @X1, @Y4, NUMP1);
	hDataSet5:= WGDefineDataSetPtr ('Data 5', @X1, @Y5, NUMP1);

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

Function  ScaleAndDrawXAxis ( pGrDesc: PGRAPH_DEF; thdc: HDC;
		  rXMin, rYMin,
		  rXMax, rYMax,
		  rXInt, rYInt,
		  rYTickSpace: Realtype;
		  nPos: INTEGER): HGOBJ;
VAR
   hAxisX: HGOBJ;
BEGIN

   WGScalePlotArea (pGrDesc, rXMin,rYMin, rXMax, rYMax);
   WGSetXYIntercepts (pGrDesc, rXInt, rYInt);
   WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
   hAxisX := WGDrawXAxis(pGrDesc, thdc, rYTickSpace, 0, POS_MIDDLE);
   WGLabelAxis(pGrDesc, thdc, hAxisX, nPos, NF_DECIMAL, 1, LL_ON, '');

   ScaleAndDrawXAxis := hAxisX;
END;

Function ScaleAndDrawYAxis (pGrDesc: PGRAPH_DEF; thdc: HDC;
		  rXMin, rYMin,
		  rXMax, rYMax,
		  rXInt, rYInt,
		  rYTickSpace: Realtype;
		  nPos: INTEGER):  HGOBJ;
VAR  hAxisY: HGOBJ;
BEGIN
    WGScalePlotArea (pGrDesc, rXMin,rYMin, rXMax, rYMax);
    WGSetXYIntercepts (pGrDesc, rXInt, rYInt);
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
    hAxisY := WGDrawYAxis(pGrDesc, thdc, rYTickSpace, 0, POS_MIDDLE);
    WGLabelAxis(pGrDesc, thdc, hAxisY, nPos, NF_DECIMAL, 1, LL_ON, '');
    ScaleAndDrawYAxis :=  hAxisY;
END;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
    hAxisX, hAxisY: HGOBJ; // axes handles
BEGIN
	// define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.30, 0.20, 0.75, 0.80, C_LIGHTGRAY);
	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

// Make sure that first X and Y Axis are scales to the same coordinate system
    hX1 := ScaleAndDrawXAxis(pGrDesc, thdc, 0,   -20,  100,  20,   0,    -20, 20, POS_BELOW);
    hY1 := ScaleAndDrawYAxis(pGrDesc, thdc, 0,   -20,  100,  20,   0,    -20, 5,  POS_LEFT);

    
	// set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);
    WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);

    hY2 := ScaleAndDrawYAxis(pGrDesc, thdc, 0,   0,  100, 100, -20,    0, 20,  POS_LEFT);

    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_LIGHTBLUE);
    WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);

    hY3 := ScaleAndDrawYAxis(pGrDesc, thdc, 0, -100, 100, 100, 100, -100, 50,  POS_RIGHT);

    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_GREEN);
    WGLinePlot (pGrDesc, thdc, hDataSet3, FALSE, FALSE);

    hY4 := ScaleAndDrawYAxis(pGrDesc, thdc, 0, -100, 100, 500, 120, -100, 100,  POS_RIGHT);

    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);
    WGLinePlot (pGrDesc, thdc, hDataSet4, FALSE, FALSE);

    hY5 := ScaleAndDrawYAxis(pGrDesc, thdc, 0, -5.0, 100, 5.0, -40, -1.0, 1.0,  POS_LEFT);
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_MAGENTA);
    WGLinePlot (pGrDesc, thdc, hDataSet5, FALSE, FALSE);

		// set current font to Arial, 12 points, bold, italic
    WGSetTextByName (C_GREEN, 'Arial', 12, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Press the right mouse button and drag');
    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_USERPROC_EVENT, @ProcessSuperZoom);
end;

Procedure ProcessSuperZoom(thwnd: HWND;  pGrDesc: PGRAPH_DEF;  message: UINT; ptMouse: TPOINT );
VAR
   phAxisY: ARRAY[0..4] OF HGOBJ;
   phAxisX: ARRAY[0..1] OF HGOBJ;
   nZoomAxisMode, nZoomRoundMode, nNumXAx, nNumYAx: INTEGER;
BEGIN
  nZoomAxisMode := ZOOM_1X_MULTIPLE_Y;
  nZoomRoundMode := AS_ROUNDCLOSE;
  nNumXAx:= 1;
  nNumYAx := 5;
  phAxisY[0] := hY1;
  phAxisY[1] := hY2;
  phAxisY[2] := hY3;
  phAxisY[3] := hY4;
  phAxisY[4] := hY5;

  phAxisX[0] := hX1;

  WGStartSuperZoom (thwnd, @phAxisX, @phAxisY,
	nNumXAx, nNumYAx,
	nZoomAxisMode,
	nZoomRoundMode,
    message, TRUE);

END;


function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
