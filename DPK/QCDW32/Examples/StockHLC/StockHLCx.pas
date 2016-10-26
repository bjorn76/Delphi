{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   StockHLCX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit StockHLCx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1= 21;                  // number of data points for graph 1
 NUMP2= 5;                   // number of data points for graph 2
 NUMGROUP= 5;                // number of groups

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
  X1, Y2: ARRAY[0..NUMP1-1] OF Realtype;
  Y1: ARRAY[0..NUMP1-1, 0..3] OF Realtype;
  GX1: ARRAY[0..NUMP2-1] OF Realtype;
  GY1: ARRAY[0..NUMP2-1, 0..NUMGROUP-1] OF Realtype;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i, j: INTEGER;
    z, sp: realtype;
BEGIN
    // create simulation data for plot

    if (fInit) THEN // do not initialize data twice
    BEGIN

     		// initialize data
        for i := 0 TO NUMP1-1 DO
        BEGIN
	    z := z + 1.0;
	    if  (((i + 1) MOD 5) = 0) THEN
              z := z + 2.0;
             X1 [i] := z;
	     sp := 10 + i + 3 * randreal;
             Y1 [i,0] :=  sp + 1.0+3.0 * randreal;     // High
             Y1 [i,1] := sp - 1.0-3.0 * randreal;  // Low
	     Y1 [i, 2] := sp;                         // Close
 	     Y1 [i, 3] := Y1[4,1] + randreal* (Y1[i,0] - Y1 [i,1]); // Open
       	     z := z + 1.0;
	     Y2 [i] := 10 + i + 3 * randreal;
        end;


	    for i := 0 TO NUMP2 - 1 DO
	    for j := 0 TO NUMGROUP - 1 DO
	    BEGIN
    		GX1[j] := j;
	    	GY1[i,j] := (randreal * 5.0 * (j+1)) + randreal;
            END;
    END;

      // Initialize graph


    WGCreateGraph (pPageDesc,
		 @DrawP1G1, // points to function which builds graph
 		 0.01, 0.01, // window realtive position inside parent page window
 		 0.99, 0.99,
		 C_WHITE,     // white background
 		 C_LIGHTCYAN, // light cyan border
 		 3);          // border width in pixels

end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
    tStartDate: tm; //  = (0,0,0,0,0,0,0,0,0);
    hAxisX, hAxisY:  HGOBJ;
    hDataSet1, hDataSet2: HDATA;
    lpstr: ARRAY[0..2 * LG_MAXLEN-1] OF CHAR;
    rMinX, rMinY, rMaxX, rMaxY: realtype;
    rTickSpaceX, rTickSpaceY:  realtype;
Begin

    // define a group data set for High-Low-Close plot, group size := 3
    hDataSet1 := WGDefineGroupDataSetPtr ('Q-C Stock', @X1, @Y1, NUMP1, 4);

    // define a linear data set
    hDataSet2 := WGDefineDataSetPtr ('DOW Jones', @X1, @Y2, NUMP1);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, thdc, 0.10, 0.15, 0.95, 0.9, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, 'Arial', 8, 0);

    // analyze the group data, scale the plotting area,
    // draw and label the x and y axes
//   WGAutoAxes(pGrDesc, thdc, hDataSet1, AS_ROUNDCLOSE, INTF_ZERO,
//       &hAxisX, &hAxisY, NIL, NIL);
   WGGetMinMaxYGroup (hDataSet1,0, GROUP_ALL_Y, rMinY,  rMaxY);
   WGGetMinMaxX (hDataSet1,  rMinX, rMaxX);

    WGRoundAxis2 (pGrDesc, OR_HORZ, ST_LINEAR,
           rMinX,  rMaxX, rTickSpaceX, AS_ROUNDCLOSE);
    WGRoundAxis2 (pGrDesc, OR_VERT, ST_LINEAR,
           rMinY,  rMaxY, rTickSpaceY, AS_ROUNDCLOSE);
    rMinY := 0;
    WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);
    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, rMinX ,rMinY);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis with major ticks every physical coord and 0 minor tick
    // the ticks will be positioned at the center of the axis
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 7.0, 6, POS_BELOW);
         tStartDate.tm_sec := 0;
         tStartDate.tm_min := 0;
         tStartDate.tm_hour := 0;
         tStartDate.tm_wday := 0;
         tStartDate.tm_yday := 0;
         tStartDate.tm_isdst := 0;
         
        tStartDate.tm_year := 1998;
	tStartDate.tm_mon := 5;
	tStartDate.tm_mday := 1;
    WGLabelAxisDate ( pGrDesc,  thdc,  hAxisX,  POS_BELOW, DATE_MDY,
	   DTB_DATE_DAY, @tStartDate,	NIL, LL_ON, 'DATE');
    // Y axis to be drawn in solid, black, 1 pixels thick

    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
    // draw the y axis with major ticks every 100 physical coords and 1 minor ticks
    hAxisY := WGDrawYAxis(pGrDesc, thdc, rTickSpaceY, 9, POS_LEFT);
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');
 
    // draw an x axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);

    // draw an y axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    // change the line style to solid, green, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_GREEN);

    // display a line plot of data set 2
    WGLinePlot (pGrDesc, thdc, hDataSet2, TRUE, FALSE);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 3, C_YELLOW);

    // create a high-low-close plot for the group data set.
    // A filled box represents the Close value
    WGStockOpenHighLowClose (pGrDesc, thdc, hDataSet1, 0.75);

    // change to bold text 
    WGSetTextByName (C_BLUE, 'Arial', 12, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Trading by Day');
    // display the y axis title
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Stock Price');

    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, 'Arial', 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, thdc, 'Stock Open-Hi-Low-Close Plot');

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, 'Arial', 14, 0);

 
    // copy the legend strings
    lstrcpy(lpstr, 'Dow Jones');
    lstrcpy(lpstr + LG_MAXLEN, 'Quinn-Curtis');

    WGLegendPtr  (pGrDesc, thdc, 0.15, 0.15, 0.45, 0.4, C_RED, 1, C_BLACK,
        C_WHITE, OR_VERT, lpStr);


end;



function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
