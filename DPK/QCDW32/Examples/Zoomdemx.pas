{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ZOOMDEMX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Zoomdemx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}
const
   NUMP1 =80;                  { number of data points }

var
  lpX1, lpY1: LPREAL;               { data arrays }
  hDataSet: HDATA;        { data set handle }


{ Prototypes of forward referenced functions }

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far;  forward; {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
VAR i: INTEGER;
    z: Realtype;
BEGIN
	GetMem (lpX1, NUMP1 * sizeof (realtype));
	GetMem (lpY1, NUMP1 * sizeof (realtype));

	{ create x and y data to be plotted }
	FOR i := 0 TO NUMP1 - 1 DO
	BEGIN
		 z := i;
		 WGPutPntrReal(lpX1,i,z);
		 WGPutPntrReal(lpY1,i, 15.0 * cos(M_PI * z / (4.0+ 0.3 * random)) +
			 3.0 * random);
	END;

	WGStart;	{ necessary, because no page has been created yet }
	{ define a dataset }
	hDataSet := WGDefineDataSetPtr ('60 Cycle Noise', lpX1, lpY1, NUMP1);

		 { page is created in the current window }
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

PROCEDURE  StartGraphs1(pPageDesc: PPAGE_DEF);
BEGIN
	  { Initialize graph  }

    WGCreateGraph (pPageDesc,
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
    hAxisX, hAxisY: HGOBJ;  { axes handles }
    hLabX, hLabY: HGOBJ; {axes labels}
BEGIN
	{ define the plotting area of the graph  }
    WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

	{ axes to be drawn in solid, black, 1 pixels thick }
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ set current font to Arial, 12 points, bold }
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    { analyze the data set and automatically scale the  }
    { plot area, draw and label the axes }
	WGAutoAxes(pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE,
		INTF_ZERO, hAxisX, hAxisY, hLabX, hLabY);

	{ set line style of actual plot to RED }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_RED);

	{ plot the data  }
	WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, FALSE);

    { Write axes titles }
    WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
    WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

		{ set current font to Arial, 12 points, bold, italic }
    WGSetTextByName (C_GREEN, 'Arial', 12, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
     WGTitleGraph(pGrDesc, thdc, 'Press the right mouse button and drag');
     WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_ZOOM_EVENT, NIL);

END;

{************************************************************************}

BEGIN

END.
