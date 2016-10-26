{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   UIObjX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit UIObjx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
  NUMP1 = 80;                  // number of data points
VAR
   X1, Y1: ARRAY[0..NUMP1-1] OF Realtype;      // global memory handles to data

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
        for i := 0 TO NUMP1-1 DO
        BEGIN
             z := i;
             X1 [i] := z;
             Y1 [i] := 15.0 *
          	 cos(M_PI * z / (4.0+ 0.3 * randreal())) +
              	 3.0 * randreal();
        END
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
       hAxisX, hAxisY, hAxisLabX, hAxisLabY:HGOBJ;  // axes handles
       hDataSet:HDATA;        // data set handle
       hText: HGOBJ;
       lpstr: ARRAY[0..LG_MAXLEN-1] OF CHAR;
BEGIN
    // define a dataset
    hDataSet := WGDefineDataSetPtr ('60 Cycle Noise', @X1, @Y1, NUMP1);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    // analyze the data set and automatically scale the
    // plot area, draw and label the axes
    WGAutoAxes(pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
	    INTF_ZERO, hAxisX, hAxisY, hAxisLabX, hAxisLabY);

    // set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);


    WGLineMarkerPlot ( pGrDesc,  thdc,
	            hDataSet, MK_BOX , C_RED, 3, MKS_EMPTY);

    // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Axis Titles Not Moveable');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Axis Titles Not Moveable');
    hText := WGText(pGrDesc, thdc, hAxisX, hAxisY, 'The Physical  STRING', 45, -15, TA_CENTER OR TA_TOP,0);
    hText := WGTextNorm(pGrDesc, thdc, 'The Normal STRING', 0.5, 0.25, TA_CENTER OR TA_TOP,0);

		// set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);
	WGBitmap (pGrDesc, thdc, hAxisX, hAxisY, 1.0, 15,8, 5,
			   BM_STRETCH, 'monkey.bmp');
     // Initialize legends
    lstrcpy(lpstr, 'Measured Values');
    WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD);
	WGLegendPtr (pGrDesc, thdc, 0.65, 0.43, 0.98, 0.58, C_BLACK, 3, -1, C_WHITE,
        OR_VERT, @lpstr);

    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    // Write graph title
     WGTitleGraph(pGrDesc, thdc, 'Axes, Plot Text, Legends, Data points, Bitmaps and this Title are moveable.');

end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
