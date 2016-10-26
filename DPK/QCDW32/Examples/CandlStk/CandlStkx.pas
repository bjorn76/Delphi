{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   CandlStkx.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit CandlStkx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1= 21;                  // number of data points for graph 1
 NUMP2= 5;                   // number of data points for graph 2
 NUMGROUP= 4;                // number of groups

VAR
  hX1, hY1, hY2: HGLOBAL;      // global handles to data
  hGX1, hGY1: HGLOBAL;

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
  X1, Y2: ARRAY[ 0..NUMP1-1] OF Realtype;
  Y1: ARRAY[0..NUMP1-1, 0..NUMGROUP-1] OF Realtype;
  lpX1, lpY1, lpY2: LPREAL;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i, j: INTEGER;
     z, sp: realtype;
BEGIN
    // create simulation data for plot
    if (fInit) THEN // do not initialize data twice
    BEGIN

	 // get pointers to data arrays
         lpX1 := @X1;
	 lpY1 := @Y1;
	 lpY2 := @Y2;

     	z := 0.0; // initialize data
        for i := 0 TO NUMP1-1 DO
        begin
	   z := z + 1.0;
	   if  (((i + 1) mod 5) = 0)  then
                z := z + 2.0;
       	   X1 [i] := z;
	   sp := 10 + i + 3 * randreal();
           Y1 [i,0] :=  sp + 1.0+3.0 * randreal();
      	   Y1 [i,1] := sp - 1.0-3.0 * randreal();
	   Y1 [i,2] := sp;
	   if ((i mod 2) <> 0) then
		Y1 [i,3] := sp + 1.0-2.0 * randreal()
	   else
		Y1 [i, 3] := sp - 1.0-2.0 * randreal();
    	   z := z + 1.0;
	   Y2 [i] := 10 + i + 3 * randreal();
        end;

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

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
VAR
   hAxisX, hAxisY, hAxisLabX, hAxisLabY: HGOBJ;
   hDataSet1: HDATA;
   hStr: HGLOBAL;
//   lpstr: PChar;
  lpstr: array[0..10] of char;
   hCandle: HGOBJ;
BEGIN
    // define a group data set for candlestick plot, group size = 3
    hDataSet1 := WGDefineGroupDataSetPtr ('Q-C Stock', lpX1, lpY1, NUMP1, NUMGROUP);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, thdc, 0.13, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, 'Arial', 10, 0);

    // analyze the group data, scale the plotting area,
    // draw and label the x and y axes
    WGAutoAxes(pGrDesc, thdc, hDataSet1, AS_ROUNDCLOSE, INTF_ZERO,
        hAxisX, hAxisY, hAxisLabX, hAxisLabY);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_LIGHTBLUE);

    // create a high-low-close plot for the group data set.
    // A filled box represents the Close value
    hCandle := WGCandlestick (pGrDesc, thdc, hDataSet1, 2, RGB(128, 0, 0), C_BLUE);
    // change to bold text
    WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Trading by Day');

    // display the y axis title
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Stock Price');

    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, 'Arial', 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, thdc, 'Candlestick Plot');

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, 'Arial', 8, 0);


    // copy the legend strings
    lstrcpy(lpstr, 'QUIN');

    WGLegendPtr(pGrDesc, thdc, 0.15, 0.15, 0.45, 0.4, C_RED, 1,
		C_BLACK, C_WHITE, OR_VERT, lpStr);

end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
