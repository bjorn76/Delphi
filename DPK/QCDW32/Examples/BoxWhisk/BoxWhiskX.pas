{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   BOXWHISKX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   3.0                                         *
 *   Date     :   Nov. 2, 1998                             *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit BoxWhiskX;

interface
uses WinTypes, WinProcs, messages,qcwin, hook, SysUtils;

procedure MB_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}

const
 NUMP1 =10;                  // number of data points for graph 1
 NUMGROUP =12;               // number of groups

var
     hX1, hY1: HGLOBAL;      // global handles to data

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

BEGIN

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
    hAxisX, hAxisY: HGOBJ;
    hDataSet1: HDATA;
    numgroup, numdat: INTEGER;
    pMidPtDesc,  pOutlierDesc, pExtremeDesc: PSCAT_DESC;
BEGIN

    hDataSet1 := WGLoadASCIIDataSet ('boxwhisk.txt', 'Box & Whisker');
   if (hDataSet1 = 0) Then
	exit;
    // determine the number of groups in the data set
    WGGetDataSetArrays (hDataSet1, hX1, hY1, numdat, numgroup);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, thdc, 0.13, 0.1, 0.9, 0.9, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, 'Arial', 10, 0);
    // analyze the group data, scale the plotting area,

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 11.0, 75.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axes to be drawn as a solid black line, 1 pixel thick.
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between  
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 10, 1, POS_LEFT);
    // label the y-axis, display labels in decimal format
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NIL);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX := WGDrawXAxis(pGrDesc, thdc, 1, 0, POS_BELOW);
    // label the y-axis, display labels in decimal format
    WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_ON, NIL);
	
    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);

    pMidPtDesc := WGCreateScatterSymbol (pGrDesc, thdc,
		C_WHITE, MK_DOWNTRIANGLE,
                MKS_FILLED, 4,
                FALSE, '1');
    pOutlierDesc := WGCreateScatterSymbol (pGrDesc, thdc,
	     C_YELLOW, MK_X, MKS_FILLED, 5, FALSE, '2');
    pExtremeDesc := WGCreateScatterSymbol (pGrDesc, thdc,
		 C_CYAN, MK_CIRCLE, MKS_FILLED, 7, FALSE, '3');

    WGBoxWhisker (pGrDesc, thdc, hDataSet1,
		BW_MEAN,		//midpoint type
  		pMidPtDesc,
		BW_STDERR,		//box type
		5,				//box size, in points
		1.0,			//box coef
		1.0,			//box const if BW_CONST
		0.0,			//% min - if box type = BW_PERCNT
		0.0,			//box % max - if box type = BW_PERCNT
		C_RED,			//box outline line color
		TRUE,			//box fill flag
		WGGetRGBColor (C_LIGHTRED), //box upper color
		WGGetRGBColor (C_LIGHTBLUE),    //box lower color
		BW_STDDEV,		//whisker type
		5,				//whisker size, in points
		1.0,			//whisker coef
		0.0,			//whisker % min
		0.0,			//whisker % min
		C_BLACK,		//whisker color
		PS_SOLID,		//line style
		1,				//line thickness
		TRUE,
		pOutlierDesc,	// MK_X, C_YELLOW, 5, 1,  //OUTLIERS
		TRUE,
		pExtremeDesc, // MK_CIRCLE, C_CYAN, 5, 1, //EXTREMES
		1.5);


    // change to bold text 
    WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Test Scores');

    // display the y axis title
    //WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Stock Price');
    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, 'Arial', 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, thdc, 'Box & Whisker Plot');

    WGSetTextByName (C_BLUE, 'Arial', 8, 0);
end;

function randreal:realtype;
begin
  randreal:= random (32766) / 32767.0;
end;


begin
end.
