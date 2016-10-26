{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   STACKDEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{************************************************************}
{                FEATURES OF THIS DEMO }
{ }
{  Stacked Graphs - horizontal }
{	Logic tags }
{	Dynamic Data sets }
{ 	Timers }

{$F+,K+}
unit stackdex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}


const
  ncount: INTEGER = 0;
VAR
  thData: HDATA;		 { handles to the dynamic data sets }
  pDynGrDesc : PGRAPH_DEF;
  pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }
PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			WGCreatePage('PAGE1', { page ID string }
				thwnd,               { handle to the parent window }
				tInst,              { application instance handle }
				'Stacked Graph',    { Window title string }
				@StartGraphs1,       { pointer to graph creation function }
				'PageMenu',         { Name of page window menu in resource file }
				C_LIGHTGRAY,        { window background color }
				MM_PROPORT,         { window sizing mode }
				0,                 { window style - default }
				PAGE_EXACT,         { window initial size and position option }
				0, 0, 700, 500);    { initial window size and position }

END;

procedure WM_DestroyGraph;
begin
   WRCleanup(TRUE); 		{ clean up charting tools memory }
   PostQuitMessage(0);
end;



{*********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
BEGIN
	  { Initialize graph }

	pDynGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G1,      { points to function which builds graph }
		 0.005, 0.005,  { graph window relative position inside parent page window }
		 0.99, 0.99,
		 C_LIGHTCYAN,   { cyan background }
		 C_RED,         { red   border }
		 1);            { border width in pixels }
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX: HGOBJ;    { axis handles }
	hLabX, hStack: HGOBJ;
	hTags: HGLOBAL;
	lpTags: LPSTR;
	nTraces: INTEGER;
	nLineColor: ARRAY[0..DYN_MAXVAL-1] OF INTEGER;
	nLineWidth: ARRAY[0..DYN_MAXVAL-1] OF INTEGER;
	nLineStyle: ARRAY[0..DYN_MAXVAL-1] OF INTEGER;
       i:INTEGER;
	 rSampleInt, rResetInt:realtype;
BEGIN
	 nTraces := 8;

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.16, 0.15, 0.92, 0.85, C_WHITE);

	{ scale the plotting are for an x range of 0 to 10.0 }
	{ and y range of -2 to 2 }
	WGScalePlotArea (pGrDesc, 0.0, -2.0, 10.0, 2.0);

	{ set the intercepts to 0,-2 }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	{ axis to be drawn as solid, cyan, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

	{ set current font to Arial, 10 points, bold }
	WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);

	{ draw the x axis with major ticks every 10 physical units and 1 minor tick }
	{ The ticks will be below axis }
	hAxisX := WRDrawTimeAxis (pGrDesc,	{ pointer to graph descriptors }
			2.0,						{ major ticks every 2 seconds  }
			0,							{ no minor ticks }
			POS_BELOW, 				    { draw ticks below axis }
			OR_HORZ,					{ axis is horizontal }
			AXU_SEC);				    { time units are seconds }

	hLabX := WRLabelTimeAxis (pGrDesc,	{ pointer to graph descriptor }
			hAxisX,					    { handle to time axis }
			POS_BELOW,   			    { show labels below axis }
			DLB_NUMERIC,			    { label format as numeric }
			1,							{ # digits after decimal point }
			0,                          { ignored }
			0,                          {  }
			0,                  	    {   }
			1.0,						{ starting value displayed at the first tick }
			LL_TEXT, 				    { display last label as text }
			'Secs'); 				    { last text label }

	{ Write axis title }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');

	{ set current font to Arial, 16 points, bold, italic }
	WGSetTextByName (C_BLACK, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Stacked Graph');

	{ allocate global array for tags }
	hTags := GlobalAlloc(GHND, nTraces * TAGLEN);
	lpTags := GlobalLock (hTags);

	lstrcpy(lpTags,  'CLK - 1');
	lstrcpy(lpTags + TAGLEN, 'RTS');
	lstrcpy(lpTags + 2 * TAGLEN, 'DTR');
	lstrcpy(lpTags + 3 * TAGLEN, 'CTS');
	lstrcpy(lpTags + 4 * TAGLEN, 'DSR');
	lstrcpy(lpTags + 5 * TAGLEN, 'S1');
	lstrcpy(lpTags + 6 * TAGLEN, 'S2');
	lstrcpy(lpTags + 7 * TAGLEN, 'LAST');

	thdata := WRDefineDynDataSet ('Stacked Data', { data set name }
			nTraces,			{ 8 traces }
			'v',				{ units }
			lpTags,			    { tag names }
			0);				    { no history buffer }

	{ assign each line style, width and color }
	FOR i := 0 TO 9 DO
	BEGIN
		nLineColor [i] := i;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineStyle [1] := PS_DOT;
	nLineStyle [4] := PS_DOT;
	nLineWidth [7] := 2;

	rSampleInt := 0.1;  { sample every 0.1 seconds }
	rResetInt  := 0.8;  { reset by 20  MOD  }

	hStack := WRSetStackedGraph (pGrDesc,	{ pointer to graph descriptor }
			thdata,			{ handle to data set }
			rSampleInt,
			rResetInt,
			OR_HORZ,		{ graph is horizontal }
			NO_STEP,
			0.9,			{ 10 MOD  margin on top of plot }
			@nLineStyle,		{ line attributes }
			@nLineWidth,
			@nLineColor);

	{ Initialize automatic updating of time labels }
	WRStartTimeLabelsUpdate (pGrDesc,	{ pointer to graph descriptor }
		hLabX, 							{ handle to x axis time labels }
		hStack);						{ handle to logic graph }

	{ set current font to Arial, 8 points, bold }
	WGSetTextByName (C_BLUE, 'Arial', 8, TEXT_BOLD);

	WRLogicTags (pGrDesc,	{ pointer to graph descriptor }
		C_BLACK,				{ border color }
		1,						{ border width }
		-1,						{ use text colors defined in hStack }
		-1,						{ transparent rectangle }
        NULLH,                   { use data set tags }
		hStack);				{ handle to stacked graph }

	GlobalFree (hTags);
END;

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


{************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..DYN_MAXVAL-1] OF realtype;
	 x,i:INTEGER;
BEGIN
	{ Initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart ;
	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	{ simulate data }
	x := round(random * 32000);
	rNewVals [1] := ORD(nCount  MOD  2 <> 0);
	rNewVals [0] := ORD(x > 10000);
	rNewVals [2] := 0.5 + 0.5 * sin (1100 - nCount);
	rNewVals [3] := x / 32000;
	rNewVals [4] := ORD(x  MOD  2 = 0);
	rNewVals [5] := 0.5 + 0.5 * cos (nCount / 5);
	rNewVals [6] := ORD(nCount  MOD  3 = 0);
	rNewVals [7] := rNewVals [0];

	nCount:= nCount + 1;
	IF (nCount > 1000) THEN
		nCount := 0;

	WRUpdateData (thdata, @rNewVals, NIL);
END;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var lpProcAbout: TFARPROC;
begin
    lpProcAbout := MakeProcInstance (@AboutProc, tInst);
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            lpProcAbout);              {  AboutProc() instance address  }
    FreeProcInstance (lpProcAbout);

end;




{************************************************************************}

begin
  pDynGrDesc := NIL;
  pPageDesc1 := NIL;
end.
