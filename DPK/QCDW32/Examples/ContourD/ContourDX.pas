{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ContourDX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit ContourDX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1= 30;                  // number of data points for graph 1

VAR
  ContourData: HDATA;

{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure StartGraphs2 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
procedure DrawP2G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
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

 WGCreatePage ('PAGE2', {  page ID string}
    thwnd,              {  handle to the parent window}
    tInst,              {  application instance handle}
    'Second Graph',      {  Window title string}
    @StartGraphs2,      {  pointer to graph creation function}
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

Function functionproc1( x,  y: Realtype): Realtype;
VAR
   z, w: Realtype;
BEGIN
	result := ( 3.5 * sin(sqrt(x*x + y*y)));
 	w := sin (x / 2.0) +  randReal * 0.3;
 	z := result + w * ( 8 - (y + 7) / 2);
 	functionproc1 :=  z;
END;

const
 fInit: BOOL = TRUE;
VAR
  X1: ARRAY[ 0..NUMP1-1, 0..NUMP1-1] OF Realtype;
  lpX1: LPREAL;

procedure  CreateData;
VAR
  i,j, k: INTEGER;
  lpX1: LPREAL;
BEGIN
    k := 0;
    // create simulation data for plots
    if (fInit) THEN
    BEGIN
      WGStart;    // Initialize the DLL if WGCreatePage is no the first call
      lpX1 := @X1;

      for i:=0 TO NUMP1 -1  DO
	  for j:=0 TO NUMP1 - 1 DO
              X1[i,j] := functionproc1( (j - 15)/2, (i-15) / 2);

      ContourData := WGCreateEvenGridDataSetPtr ('', lpX1,
       -7.5, -7.5, 0.5, 0.5,NUMP1, NUMP1);
        fInit := FALSE;
    END;
END;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i, j: INTEGER;
     z, sp: realtype;
BEGIN
    // create simulation data for plot
    if (fInit) THEN // do not initialize data twice
    BEGIN
      CreateData;
    END;

      // Initialize graph

    WGCreateGraph (pPageDesc,
		 @DrawP1G1, // points to function which builds graph
 		 0.002, 0.002, // window realtive position inside parent page window
 		 0.66, 0.66,
		 C_WHITE,     // white background
 		 C_LIGHTCYAN, // light cyan border
 		 3);          // border width in pixels
end;

procedure StartGraphs2 (pPageDesc:PPAGE_DEF);
Begin

  // Initialize graph
    WGCreateGraph (pPageDesc,
                 @DrawP2G1, // points to function which builds graph
                 0.05, 0.05,    // window relative position inside parent page window
                 0.95, 0.95,
                 C_WHITE,       // white background
                 C_GREEN,       // green border
                 4);            // border width in pixels
End;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

const
    rContourValues: ARRAY[0..7] OF Realtype = (-3.5, -2.1, -1.1, 0.0, 2.1, 3.1, 4.1, 5.1);
    rgbColors: Array[0..9] OF ColorRef = (1, 11, 12, 13, 14, C_LIGHTGRAY, C_GREEN, C_RED, C_BLACK, C_BLACK);
    nLineStyle: Array[0..7] OF INTEGER = (PS_SOLID, PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID);
    nLineWidth:Array[0..7] OF INTEGER = (1,1,1,1,1,1,1,1);
    bContourLineFlags: Array[0..7] OF BOOL = (TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);
    bContourLabelFlags: Array[0..7] OF BOOL = (TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
    hAxisX, hAxisY, hAxisXLab, hAxisYLab:  HGOBJ;        // axes handles
    i, granularity: INTEGER;
    rMinX, rMinY, rMaxX, rMaxY, rMinZ, rMaxZ: Realtype;
BEGIN
   WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.95, 0.85, C_WHITE);

{$ifndef XXX}  // An auto axis call which can also be used
   WGAutoAxesContourData ( pGrDesc,  thdc,
	  ContourData,  AS_ROUNDFAR, INTF_MIN,  hAxisX, hAxisY,
	   hAxisXLab, hAxisYLab);
{$else}
    for i:=0 TO 7 DO
	rgbColors[i] := WGGetRGBColor(rgbColors[i]);


    WGGetContourMinMaxXYZ (ContourData, rMinX, rMaxX,
				rMinY, rMaxY,
				rMinZ, rMaxZ);
    WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, rMinX, rMinY);

    // set line style for axes to a solid, black line
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 0, C_BLACK);

    // draw the x axis
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 1.0, 0, POS_BELOW);

    // draw the y axis
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 0, POS_LEFT);

    // set line style of grids to dotted, minimal width, MAGENTA,
    // and display a y-axis grid on major ticks.

    // set current font to Roman, 10 points, bold
    WGSetTextParams (C_BLUE, FF_ROMAN, 10, TEXT_BOLD);

    // label the x- and y- axis
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

{$endif}

   WGSetLineStyle(pGrDesc, thdc, PS_DOT, 0, C_MAGENTA);

    // draw a y-axis grid at minor and major tick marks
   WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);
   WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
   WGSetTextParams (C_BLACK, FF_ROMAN, 14, TEXT_BOLD);

   granularity := 1;
   WGSetTextParams (C_BLACK, FF_ROMAN, 10, TEXT_BOLD);

   WGContourPlot ( pGrDesc,  thdc,
        ContourData,
        @rContourValues,
        @rgbColors,
	@nLineStyle,
	@nLineWidth,
        7,
    	granularity,
        @bContourLineFlags,
    	@bContourLabelFlags,
    	POS_RIGHT,
    	POS_ABOVE,
    	1,
    	TRUE,
        GT_CONTOURLINE);

   // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'X Axis Title');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Y Axis Title');

    // set current font to Roman, 12 points, bold
    WGSetTextParams (C_BLACK, FF_ROMAN, 12, TEXT_BOLD);

   // output a tilted (45 degrees) message at x = 12.5, y = 125.0
    WGText (pGrDesc, thdc, hAxisX, hAxisY, 'TEST', 12.5, 125.0, TA_CENTER, 450);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Graph Title');
end;

procedure DrawP2G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
    hAxisX, hAxisY, hAxisXLab, hAxisYLab: HGOBJ;         // axes handles
    i, granularity: INTEGER;
BEGIN
   WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.95, 0.85, C_WHITE);

   WGAutoAxesContourData ( pGrDesc,  thdc,
	  ContourData,  AS_ROUNDFAR, INTF_MIN,  hAxisX, hAxisY,
	   hAxisXLab, hAxisYLab);

    for i:=0 TO 7 DO // Convert Simple Colors to RGB Colors
		rgbColors[i] := WGGetRGBColor(rgbColors[i]);
	for i:=0 TO 7 DO
        BEGIN
		 bContourLineFlags[i] := FALSE;
		 bContourLabelFlags[i] := TRUE;
	END;
    granularity := 1;
    WGSetTextParams (C_BLACK, FF_MODERN, 8, TEXT_NORMAL);
    WGContourPlot ( pGrDesc,  thdc,
        ContourData,
        @rContourValues,
        @rgbColors,
	@nLineStyle,
	@nLineWidth,
        7,
	granularity,
	@bContourLineFlags,
	@bContourLabelFlags,
	POS_LEFT,
	POS_ABOVE,
	1,
	FALSE,
        GT_CONTOURFILL);

   // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'X Axis Title');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Y Axis Title');

    // set current font to Roman, 12 points, bold
    WGSetTextParams (C_BLACK, FF_ROMAN, 12, TEXT_BOLD);

   // output a tilted (45 degrees) message at x = 12.5, y = 125.0
    WGText (pGrDesc, thdc, hAxisX, hAxisY, 'TEST', 12.5, 125.0, TA_CENTER, 450);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Graph Title');



end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
