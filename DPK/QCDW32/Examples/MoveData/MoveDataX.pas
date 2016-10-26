{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   MoveData.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit MoveDataX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1 =20;                  // number of data points

 VAR
  hX1, hY1: HGLOBAL;           // global memory handles to data
  hAxisX, hAxisY: HGOBJ;     // axes handles
  hCursor1, hCursor2, hCursor3: HGOBJ; // cursor handles
  pGrDescCurs: PGRAPH_DEF;       // graph descriptor
   hDataSet: HDATA;
  lpX1, lpY1: LPREAL;
  Num: INTEGER;


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
  X1, Y1: ARRAY[ 0..NUMP1-1] OF Realtype;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
     i: INTEGER;
     z: Realtype;
BEGIN
    // create simulation data for plot
    if (fInit) THEN // do not initialize data twice
    BEGIN
       lpX1 := @X1;
       lpY1 := @Y1;
         // create x and y data to be plotted
        for i := 0 TO NUMP1-1 DO
        BEGIN
             z := i;
             X1 [i] := z;
             Y1 [i] := 15.0 *
          	 cos(M_PI * z / (4.0+ 0.3 * randreal)) +
              	 3.0 * randreal;
        END;
        fInit := FALSE;
    END;

      // Initialize graph

	pGrDescCurs := WGCreateGraph (pPageDesc,
		 @DrawP1G1, // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.99, 0.99,
		 C_WHITE, // white background
		 C_RED,   // red   border
		 1);      // border width in pixels
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR hAxisXLab, hAxisYLab: HGOBJ;
BEGIN

    hDataSet := WGDefineDataSetPtr ('Line1', lpX1, lpY1, NUMP1);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);
	
    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
			
	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    // analyze the data set and automatically scale the 
	// plot area, draw and label the axes
	WGAutoAxes(pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
		INTF_ZERO, hAxisX, hAxisY, hAxisXLab, hAxisYLab);

	// set line style of actual plot to RED
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);
	
	// plot the data
	WGLineMarkerPlot (pGrDesc, thdc,
		hDataSet, MK_CIRCLE, C_LIGHTRED, 5, MKS_CDOT);

	// set current font to Arial, 12 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 12, TEXT_BOLD OR TEXT_ITAL);
	
	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');
		

    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_MOVE_EVENT, NIL);

end;

function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;


begin
end.
