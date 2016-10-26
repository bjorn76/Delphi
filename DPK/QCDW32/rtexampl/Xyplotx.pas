{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   XYPLOTX.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{$F+,K+}
unit Xyplotx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure  TimerRoutine;
procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);

implementation

{$R rtdemo}


const
  ncount: INTEGER = 0;

  NT = 4;               { number of traces }

var
  hXY: HGOBJ;				    { handle to xy plot }
  thData: HDATA;				{ handle to dynamic data set }
  pDynGrDesc: PGRAPH_DEF;
  pPageDesc1 :  PPAGE_DEF;

  { Prototypes of forward referenced functions }

{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure StartGraphs2 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      WGCreatePage ('PAGE1',           { page ID string }
        thwnd,                         { handle to the parent window }
        tInst,                        { application instance handle }
        'XY Plot',                     { Window title string }
        @StartGraphs1,                 { pointer to graph creation function }
        'PageMenu',
        { Name of page window menu in resource file }
        C_LIGHTGRAY,                   { window background color }
        MM_PROPORT,                    { window sizing mode }
        0,                             { window style - default }
        PAGE_EXACT,
        { window initial size and position option }
        0, 0, 600, 400);               { initial window size and position }
      { if used (not used here) }

      WGCreatePage ('PAGE2',           { page ID string }
        thwnd,                         { handle to the parent window }
        tInst,                        { application instance handle }
        'XY',                          { Window title string }
        @StartGraphs2,                 { pointer to graph creation function }
        nil,
        { Name of page window menu in resource file }
        C_LIGHTGRAY,                   { window background color }
        MM_PROPORT,                    { window sizing mode }
        0,                             { window style - default }
        PAGE_EXACT,
        { window initial size and position option }
        200, 200, 500, 500);           { initial window size and position }

END;

procedure WM_DestroyGraph;
begin
      WRCleanup (TRUE);                { clean up charting tools memory }
      { and free data arrays }
      PostQuitMessage (0);
end;


{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}
{ display first page window }
procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
begin
  { Initialize graph }
  pDynGrDesc := WGCreateGraph (pPageDesc, 
    @DrawP1G1,
    { points to function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.99, 0.99, 
    C_WHITE,                           { white background }
    C_RED,                             { red   border }
    1);                                { border width in pixels }
end;

{*******************************************************************}
{ display 2nd page window }
procedure StartGraphs2 (pPageDesc: PPAGE_DEF);
begin
  { Initialize graph }
  WGCreateGraph (pPageDesc,
    @DrawP1G2,
    { points to function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.99, 0.99, 
    C_BLUE,                            { blue background }
    C_RED,                             { red   border }
    1);                                { border width in pixels }
end;

{******************************************************
  draws an XY plot
*******************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	hAxisX, hAxisY: HGOBJ;    { axis handles }
	nLineColor: array[0..NT-1] of INTEGER;
	nLineWidth: array[0..NT-1] of INTEGER;
	nLineStyle: array[0..NT-1] of INTEGER;
        i:INTEGER;
	szTags: array  [0..NT * 2 * TAGLEN-1] of CHAR;
begin
  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.9, 0.74, C_BLUE);
  
  { scale the plotting area }
  WGScalePlotArea (pGrDesc, - 1.0, - 2.0, 1.0, 2.5);

  { set the intercepts  }
  WGSetXYIntercepts (pGrDesc, - 1.0, - 2.0);
  
  { axes to be drawn in solid, cyan, 1 pixel thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  
  { set current font to Arial, 10 points, bold }
  WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);
  
  { draw the x axis with major ticks every 0.2 physical unit and no minor ticks }
   hAxisX := WGDrawXAxis(pGrDesc, thdc, 0.2, 0, POS_MIDDLE);

  { draw the y axis with major ticks every 1 physical unit and 1 minor tick }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 1.0, 1, POS_LEFT);

  { Label the x axis, in decimal format, 1 digit after the decimal point. }
   WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);

  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);
  WRDynGrid(pGrDesc,     { pointer to graph descriptor }
   hAxisX, { handle to x axis }
   GRID_MAJOR, { grid lines at major tick marks }
   5); { grid updates every 5 seconds }

   WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, 5);

  { Write axes titles }
   WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'mV');
   WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');
  
  { set current font to Arial, 16 points, bold, italic }
  WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD or TEXT_ITAL);
  
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'XY Plot');
  
  lstrcpy (szTags, 'Trace 1');
  lstrcpy (szTags + TAGLEN, 'Trace 2');
  lstrcpy (szTags + 2 * TAGLEN, 'Third');
  lstrcpy (szTags + 3 * TAGLEN, 'Fourth');

  { Define the dynamic data set for the xy plot. }
  { It has twice as many channels as traces. }
  { First NT channels are for X values, }
  { next NT channels are for Y }

  thData := WRDefineDynDataSet ('XY Data',
  { data set name }
    NT * 2,
    { # traces * 2 (to hold both x AND y coords) }
    'volts',                           { unit string }
    szTags,                            { channel names }
    0);                                { no history buffer }
  
  { assign each trace style, width and color }
  for i := 0 to NT - 1 do begin
    nLineStyle [i] := PS_SOLID;
    nLineWidth [i] := 0;
  end;
  nLineColor [0] := C_LIGHTGREEN;
  nLineColor [1] := C_LIGHTCYAN;
  nLineColor [2] := C_YELLOW;
  nLineColor [3] := C_LIGHTRED;
  
  nLineStyle [2] := PS_DOT;
  nLineWidth [0] := 2;
  
  hXY := WRSetXYGraph (pGrDesc,        { pointer to graph descriptor }
    thData,                            { handle to dynamic data set }
    40,                                { display 40 most recent points }
    @nLineStyle,                       { line attributes }
    @nLineWidth, 
    @nLineColor);
  
  WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD);
  { Dynamic legends for XY plot }
  WRDynLegend (pGrDesc, 0.15, 0.89, 0.0, 0.0, C_GREEN, 2, - 1, C_MAGENTA,
    OR_HORZ, NULLH, hXY, TRUE);
end;

{****************************************************************************}
{ draws an xy plot using the full area of the graph window }
{ no axes, titles, or labels are displayed }
{****************************************************************************}

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	nLineColor,
	nLineStyle,
	nLineWidth,
	nScatterSym,
	nScatterSize: ARRAY[0..NT-1] OF INTEGER;
	i: INTEGER;
	hAxisX, hAxisY: HGOBJ; // axes handles
 begin
	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, thdc, 0.1, 0.1, 0.9, 0.8, C_RED);

	// scale the plotting area
	WGScalePlotArea (pGrDesc, -1.0, -2.0, 1.0, 2.5);

	// set the intercepts
	WGSetXYIntercepts (pGrDesc, -1.0, -2.0);

	// axes to be drawn in solid, cyan, 1 pixel thick
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_WHITE, 'Arial', 10, TEXT_BOLD);

	// draw the x axis with major ticks every 0.2 physical unit and no minor ticks
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 0.2, 0, POS_MIDDLE);

	// draw the y axis with major ticks every 1 physical unit and 1 minor tick
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	// Label the x axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, '');

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, '');

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);
	WRDynGrid(pGrDesc,	    // pointer to graph descriptor
			hAxisX,			// handle to x axis
			GRID_MAJOR,		// grid lines at major tick marks
			5);				// grid updates every 5 seconds

	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, 5);

	// Write axes titles
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'mV');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, thdc, 'XY Scatter Plot');

	// assign trace colors
	// assign each trace style, width and color
	for i := 0 TO NT -1 DO
	BEGIN
		nLineStyle [i] := i;
		nLineWidth [i] := 1;
		nScatterSize[i] := i + 7;
		nScatterSym[i] := i;
	END;
	nLineColor [0] := C_LIGHTGREEN;
	nLineColor [1] := C_LIGHTCYAN;
	nLineColor [2] := C_YELLOW;
	nLineColor [3] := C_WHITE;

	hXY := WRSetXYScatterGraph (pGrDesc, // pointer to graph descriptor
			thData,				 // handle to dynamic data set
			40,					 // display 40 most recent points
			@nScatterSym,			 // line attributes
			@nLineColor,
			@nScatterSize,
			@nLineWidth,
			@nLineStyle);


end;

{*************************************************************************
	 FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)
	 PURPOSE:  Processes messages for 'About' dialog box

***************************************************************************}

function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL;
begin
  case message of
    WM_INITDIALOG: begin 
      AboutProc := TRUE;
      exit;
    end;
    
    WM_COMMAND: begin 
      if (wParam = IDOK)  or (wParam = IDCANCEL) then begin 
        EndDialog (hDlg, 1);
        AboutProc := TRUE;
        exit;
      end;
    end;
  end;
  AboutProc := FALSE;
end;


procedure MM_About(thwnd: HWND; tinst: THANDLE);
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
end;



{************************************************************************}

procedure  TimerRoutine;
var
	 rArg:realtype;
	 rNewVals: array[0..7] of realtype;
begin
  if not (WGIsGraphDescValid (pDynGrDesc)) then
    exit ;
  { Initialize the DLL every time the timer is called NOT  }
  { Otherwise the DLL will not know who is calling it. }
  { Necessary only if multiple RT Tools applications or multiple  }
  { instances of the same application can run simultaneously. }
  
  WGStart ;
  
  rArg := M_PI * nCount;
  { simulate data }
  rNewVals [0] := sin (rArg / 30) / 1.5 ;
  { new x for trace 0 }
  rNewVals [1] := rNewVals [0] + 0.1;  { new x for trace 1 }
  rNewVals [2] := 0.1 + sin (rArg / 20) / 1.7 ;
  { new x for trace 2 }
  rNewVals [3] := rNewVals[0];         { new x for trace 3 }
  
  rNewVals [4] := cos (rArg / 20.0) * 1.1;
  { new y for trace 0 }
  rNewVals [5] := 1.6 * cos (rArg / 7);{ new y for trace 1 }
  rNewVals [6] := - 0.05 - cos (rArg / 6);
  { new y for trace 2 }
  rNewVals [7] := 0.3 + cos (rArg / 5) + rNewVals[5] * 0.7;
  { new y for trace 3 }
  
  nCount := nCount + 1;
  if nCount > 1000 then
    nCount := 0;
  
  WRUpdateData (thData, @rNewVals, nil);
end;
{************************************************************************}

begin
  pDynGrDesc := nil;                   { Graph descriptors }
  pPageDesc1 := nil;

end.

