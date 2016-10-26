{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   CURSDEMX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{
	3 data cursors are turned on and off when you click the right mouse
	button over the graph window.
	The first data cursor is a vertical line and jumps to the
	data point with the nearest X value.
	The second data cursor is a horizontal line and jumps to the
	data point with the nearest Y value.
	The third data cursor is a box and jumps to the
	data point nearest to the mouse cursor.

}
unit cursdemx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}
const

 NUMP1 =80;                      { number of data points }

VAR
  hX1, hY1: HGLOBAL;           { global memory handles to data }
  hAxisX, hAxisY: HGOBJ;         { axes handles }
  hCursor1, hCursor2, hCursor3: HGOBJ;  { cursor handles }
  pGrDescCurs:   PGRAPH_DEF;     { graph descriptor }


{ Prototypes of forward referenced functions }

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far;  forward; {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
Procedure StartXCursor (thwnd: HWND; pGrDesc: PGRAPH_DEF;
           message: UINT;  ptMouse: TPOINT);far;  forward;
Procedure UpdateDataCursorPosition (thwnd: HWND; pGrDesc: PGRAPH_DEF;
         message: UINT;  ptMouse: TPOINT);far;  forward;
Procedure RemoveDataCursors (pGrDesc: PGRAPH_DEF );far;  forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
VAR i: INTEGER;
    z: Realtype;
BEGIN
          WGCreatePage('PAGE1', { page ID string }
            thwnd,               { handle to the parent window }
    	    tInst,              { application instance handle  }
           'First Graph',      { Window title string  }
    	    @StartGraphs1,       { pointer to graph creation function }
      	    'PageMenu',         { Name of page window menu in resource file }
    	    C_LIGHTGRAY,        { window background color }
      	    MM_PROPORT,         { window sizing mode }
  	    0,                 { window style - default }
      	    PAGE_CLIENT,        { window initial size and position option }
	    0, 0, 0, 0);        { initial window size and position }
                              { if used (not used here) }

END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;



{*********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
**********************************************************************}
const fInit: WORDBOOL = TRUE;
PROCEDURE  StartGraphs1(pPageDesc: PPAGE_DEF);
VAR
  i:INTEGER;
  z:realtype;
  lpX1, lpY1: LPREAL;
BEGIN
    { create simulation data for plot }
    IF (fInit) THEN { do not initialize data twice }
    BEGIN
        { allocate global data arrays }
        hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
        hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
        { get pointers to data arrays }
        lpX1 :=  GlobalLock(hX1);
	lpY1 := GlobalLock(hY1);
         { create x and y data to be plotted }
        FOR i := 0 TO NUMP1-1 DO
        BEGIN
             z :=  i;
             WGPutPntrReal(lpX1,i, z);
             WGPutPntrReal(lpY1,i,
                 15.0 * cos(M_PI * z / (4.0+ 0.3 * random))+ 3.0 * random);
        END;
        fInit := FALSE;
    END;
      { Initialize graph  }

	pGrDescCurs := WGCreateGraph (pPageDesc,
		 @DrawP1G1, { points to function which builds graph }
		 0.005, 0.005, { window relative position inside parent page window }
		 0.99, 0.99,
		 C_WHITE, { white background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }
END;

{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}

PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
    hDataSet: HDATA;        { data set handle }
    hXLab, hYLab: HGOBJ;
BEGIN
    { define a dataset  }
    hDataSet := WGDefineDataSet ('60 Cycle Noise', hX1, hY1, NUMP1);

    { define the plotting area of the graph  }
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    { axes to be drawn in solid, black, 1 pixels thick }
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ set current font to Arial, 12 points, bold }
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    { analyze the data set and automatically scale the  }
	{ plot area, draw and label the axes }
	WGAutoAxes(pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
		INTF_ZERO, hAxisX, hAxisY, hXLab, hYLab);

	{ set line style of actual plot to RED }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);

	{ plot the data with spline interpolation on }
	WGLineMarkerPlot (pGrDesc, thdc,
		hDataSet, MK_CIRCLE, C_LIGHTRED, 5, MKS_CDOT);
 
	{ Write axes titles }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

		{ set current font to Arial, 12 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 12, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Click the right button to display data cursors');

    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_USERPROC_EVENT, @StartXCursor);
    WGSetMouseEventAction(pGrDesc, WM_RBUTTONUP, OBJ_USERPROC_EVENT, @UpdateDataCursorPosition);

	hCursor3 := WGSetDataCursor (pGrDesc, thdc,
	    DC_BOX,             // box cursor
		hAxisX, hAxisY, 
		12,                 // size, in points
		3,                  // line width - 2 pixels
		PS_SOLID,           // line style
		C_BLUE);            // color


END;

{************************************************************************}
{ cursor management *****************************************************}
{************************************************************************}

Procedure StartXCursor (thwnd: HWND; pGrDesc: PGRAPH_DEF;
           message: UINT;  ptMouse: TPOINT);
BEGIN
    WGSetXCursorParams(PS_SOLID, 8);
    WGStartXCursor (thwnd, hAxisX, hAxisY,  message, DC_WHVLINE, FALSE);
END;



Procedure UpdateDataCursorPosition (thwnd: HWND; pGrDesc: PGRAPH_DEF;
         message: UINT;  ptMouse: TPOINT);
VAR
   rXMouse, rYMouse: Realtype;      // mouse position
   rX, rY: Realtype;                // nearest data point position
   hDataset: HDATA;
   nNum: INTEGER;
BEGIN
	// Get mouse cursor position in physical units
	WGGetMousePos (pGrDesc, hAxisX, hAxisY, rXMouse, rYMouse);

	// get data point closest to the mouse position
	WGGetNearestPointNormalized (pGrDesc, rXMouse, rYMouse, FNP_NORMDIST, rX, rY,
 		 	hDataset, nNum);


	// move data cursor
	WGMoveDataCursor (pGrDesc, hCursor3, rX, rY, TRUE);
END;

Procedure RemoveDataCursors (pGrDesc: PGRAPH_DEF );
BEGIN
	// turn off all three data cursors
	WGMoveDataCursor (pGrDesc, hCursor3, 0.0, 0.0, FALSE);
END;




END.


