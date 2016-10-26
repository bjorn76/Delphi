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
unit SerDemoX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;
procedure MB_RestoreGraph(thwnd:HWND);
implementation

{$R demo}

const
 NUMP1 =100;                  // number of data points
VAR
 hX1, hY1: HGLOBAL;       // global memory handles to data
 hPlotObj, hAxisX, hAxisY, hAxisXLab, hAxisYLab,  // axes handles
 hPlotObj2, hAxisX2, hAxisY2, hAxisXLab2, hAxisYLab2: HGOBJ;  // axes handles
 pPgDesc: PPAGE_DEF;
 pGraphDesc: PGRAPH_DEF;

{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc:PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC); far; forward;
function randreal:realtype; forward;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
  pPgDesc := WGCreatePage ('PAGE1', {  page ID string}
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

      WGSavePage (pPgDesc, 'Page1.ser');

end;

procedure   MB_RestoreGraph(thwnd:HWND);
begin
         pPgDesc := WGRestorePage ('Page1.ser',thwnd,'');

		 // Graph is the first graph in a new page
	pGraphDesc := WGGetGraphInPage(pPgDesc, 0); // Get the first graph in the page
	hAxisX2 :=  WGGetUserIDObj (pGraphDesc, 1001); // Recover handle for x axis
        hAxisY2 := WGGetUserIDObj (pGraphDesc,  1002); // Recover handle for y axis
        hAxisXLab2 := WGGetUserIDObj (pGraphDesc, 1003); // Recover handle for x axis labels
        hAxisYLab2  := WGGetUserIDObj (pGraphDesc,  1004);  // Recover handle for y axis labels
        hPlotObj2 := WGGetUserIDObj (pGraphDesc, 1005); // Recover handle for line plot
	WGChangeAxisRange(pGraphDesc, hAxisY2, 0, 100, FALSE);
	WGChangeAxisRange(pGraphDesc, hAxisX2, 0, 200, TRUE);
	WGChangeAxisTicks(pGraphDesc, hAxisX2, 50, 4, POS_BELOW);
	WGChangeLabelsFormat (pGraphDesc, hAxisXLab2, NF_SCIENTIFIC);
	WGChangeLabelsFormat (pGraphDesc, hAxisYLab2, NF_SCIENTIFIC);
        WGChangeLineColor(pGraphDesc, hPlotObj2, C_BLUE, 0);

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
  X1, Y1: ARRAY[0..NUMP1-1] OF Realtype;

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
VAR
    i: INTEGER;
    z: realtype;
BEGIN
    // create simulation data for plot
   if (fInit) THEN// do not initialize data twice
   BEGIN
        // allocate global data arrays
         // create x and y data to be plotted
        for i := 0 TO NUMP1-1 DO
        BEGIN
             z :=  i;
             X1 [i] := z;
             Y1 [i] := 20 + 15.0 *
          	 cos(M_PI * z / (4.0+ 0.3 * randreal)) +
              	 3.0 * randreal;
        END;
        fInit := FALSE;
    END;
      // Initialize graph

    pGraphDesc := WGCreateGraph (pPageDesc,
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
VAR
       hDataSet: HDATA;       // data set handle

BEGIN
    // define a dataset
    hDataSet := WGDefineDataSetPtr ('60 Cycle Noise', @X1, @Y1, NUMP1);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 12, TEXT_BOLD);

    // analyze the data set and automatically scale the
    // plot area, draw and label the axes
    WGAutoAxes(pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
	    INTF_ZERO, hAxisX, hAxisY, hAxisXLab, hAxisYLab);

    // set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);

    // plot the data 
    hPlotObj := WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);

    // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

		// set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Input Waveform');
    WGSetObjUserID (pGrDesc, hAxisX, 1001);
    WGSetObjUserID (pGrDesc, hAxisY, 1002);
    WGSetObjUserID (pGrDesc, hAxisXLab, 1003);
    WGSetObjUserID (pGrDesc, hAxisYLab, 1004);
    WGSetObjUserID (pGrDesc, hPlotObj, 1005);
end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
