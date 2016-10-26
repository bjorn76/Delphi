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
unit AutoAxesx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1 =80;                  // number of data points
 NUMDATASETS =10;

var
  hX1, hY1: HGLOBAL;    {  global memory handles to data}
  hDataSetArray: ARRAY[0..NUMDATASETS-1] OF HDATA;
  hPlotObjects: ARRAY[0..NUMDATASETS-1] OF HGOBJ;

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
  X1, Y1: ARRAY[0..NUMDATASETS-1, 0..NUMP1-1] OF Realtype;

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
       	for j:=0 TO NUMDATASETS-1 DO
       	begin
          // create pointers to data arrays
          lpX1 :=  @X1[j,0];
          lpY1 :=  @Y1[j,0];
         // create x and y data to be plotted
          for i := 0 TO NUMP1 -1 DO
          BEGIN
             z :=  i;
             X1 [j,i] := z;
             Y1 [j,i] := j * 10 + 5.0 *
          	 cos(M_PI * z / (4.0+ 0.3 * randreal)) +
              	 3.0 * randreal;
	  END;
          str(j:1,sName);
          sName := 'Dataset' + sName;
          StrPCopy(pName,sName);
         hDataSetArray[j] := WGDefineDataSetPtr (pName, lpX1, lpY1, NUMP1);
          fInit := FALSE;
       END;
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
   i: INTEGER;
   hAxisX, hAxisY, hAxisLabY, hAxisLabX: HGOBJ;
BEGIN
    // define a dataset

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 10 points, bold
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    // analyze the data set and automatically scale the
    // plot area, draw and label the axes
    WGAutoAxesDataSets(pGrDesc, thdc, @hDataSetArray, NUMDATASETS,
		AS_ROUNDCLOSE,
	    INTF_ZERO, hAxisX, hAxisY, hAxisLabX, HAxisLabY);

    // plot the data with spline interpolation on
	for i:=0 TO NUMDATASETS -1 DO
	BEGIN
     WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, i);
     hPlotObjects[i] := WGLinePlot (pGrDesc, thdc, hDataSetArray[i], FALSE, TRUE);
	END;

    // Write axes titles
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

		// set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, thdc, 'Input Waveform');

   // set line style of arrow to solid, BLACK, 0 pixels wide
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 0, C_BLACK);

    // draw an arrow.  This arrow will point to the left, and will be filled
    WGArrow (pGrDesc, thdc, hAxisX, hAxisY, 0.0, 0.0, 5, 5, 6, 6, TRUE, FALSE, TRUE);

end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
