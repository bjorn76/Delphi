{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   LOGICDEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{                FEATURES OF THIS DEMO }
{ }
{  Logic Graphs - horizontal }
{	Logic tags }
{	Dynamic Data sets }
{ 	Timers }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Logicdex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}

const
  ncount: INTEGER = 0;
  NDIGCHAN  =	8;
VAR

pDynGrDesc : PGRAPH_DEF;
thdata: HDATA;					{ handle to data set }

{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			WGCreatePage('PAGE1', { page ID string }
				thwnd,               { handle to the parent window }
				tInst,              { application instance handle }
				'Logic Graph',      { Window title string }
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
		{ and free data arrays }
  PostQuitMessage(0);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
end;



{*********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
BEGIN
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
	hAxisX, hLogic: HGOBJ;    { axis handles }
	hTags: HGLOBAL;
	lpTags: LPSTR;
        nTraces :INTEGER;
	nLineColor: ARRAY[0..NDIGCHAN-1] OF INTEGER;
	nLineWidth: ARRAY[0..NDIGCHAN-1] OF INTEGER;
	nLineStyle: ARRAY[0..NDIGCHAN-1] OF INTEGER;
	i:INTEGER;
	 rSampleInt, rResetInt:realtype;
BEGIN
        nTraces := 4;

    { define data set }
	thData := WRDefineDynDataSet ('Logic Data', { data set name }
			nTraces,			{ 4 analog traces (not used) }
			'v',				{ units }
 			NIL,			    { no tag names }
			0);				    { no history buffer }

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.16, 0.15, 0.92, 0.85, C_WHITE);

	{ scale the plotting are for an x range of 0 to 10.0 }
	{ and y range of -2 to 2 }
	WGScalePlotArea (pGrDesc, 0.0, -2.0, 10.0, 2.0);

	{ set the intercepts to 0,-2 }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	{ axis to be drawn in solid, cyan, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_CYAN);

	{ set current font to Arial, 10 points, bold }
	WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);

	{ draw the x axis }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 2.0, 0, POS_BELOW);
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);

	{ Write axis title }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');

	{ set current font to Arial, 16 points, bold, italic }
	WGSetTextByName (C_BLACK, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Logic Graph');

	{ assign each line style, width and color }
	FOR i := 0 TO  NDIGCHAN - 1 DO
	BEGIN
		nLineColor [i] := i;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineStyle [1] := PS_DOT;
	nLineStyle [4] := PS_DOT;
	nLineWidth [0] := 2;

	rSampleInt := 0.5; { sample every 0.25 seconds }
	rResetInt  := 0.8;  { reset by 20  MOD  }

	hLogic := WRSetLogicGraph (pGrDesc,	{ pointer to graph descriptor }
			thData,			{ handle to data set }
			rSampleInt,
			rResetInt,
			OR_HORZ,		{ graph is horizontal }
                        8,              { 8 digital channels }
			1.0,			{ full plotting area }
			@nLineStyle,		{ line attributes }
			@nLineWidth,
			@nLineColor);

	{ allocate global array for tags }
	hTags := GlobalAlloc(GHND, NDIGCHAN * LG_MAXLEN);
	lpTags := GlobalLock (hTags);

	lstrcpy(lpTags ,  'CLK - 1');
	lstrcpy(lpTags + LG_MAXLEN ,  'RTS');
	lstrcpy(lpTags + 2 * LG_MAXLEN ,  'DTR');
	lstrcpy(lpTags + 3 * LG_MAXLEN ,  'CTS');
	lstrcpy(lpTags + 4 * LG_MAXLEN ,  'DSR');
	lstrcpy(lpTags + 5 * LG_MAXLEN ,  'S1');
	lstrcpy(lpTags + 6 * LG_MAXLEN ,  'S2');
	lstrcpy(lpTags + 7 * LG_MAXLEN ,  'S3');


	{ set current font to Arial, 8 points, bold, italic }
	WGSetTextByName (C_BLUE, 'Arial', 8, TEXT_BOLD);

	WRLogicTags (pGrDesc,	{ pointer to graph descriptor }
		C_BLACK,				{ border color }
		2,						{ border width }
		-1,						{ use text colors defined in hLogic }
		-1,						{ transparent rectangle }
		hTags,
		hLogic);				{ handle to logic graph }

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
       x:INTEGER;
        wBinVal,  wMask: UINT;
BEGIN
	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart;
	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

        { simulate data     }
	x := random(32767);
        wBinVal := x;

	wMask := 1;
	IF ( (nCount  MOD  2) <> 0) THEN
           wBinVal := (wBinVal OR wMask)   { set bit }
        ELSE
            wBinVal := wBinVal AND NOT(wMask); { reset bit  }
        wMask := 2;
        IF ((nCount  MOD  4) <> 0) THEN
           wBinVal := (wBinVal OR wMask)   { set bit }
	ELSE
            wBinVal := wBinVal AND NOT(wMask); { reset bit  }

	nCount:= nCount + 1;
	IF (nCount > 1000) THEN
		nCount := 0;

    WRUpdateBinaryData (thData, wBinVal, pDynGrDesc);
   END;
{************************************************************************}

begin
 pDynGrDesc := NIL;	 { Graph descriptors }

end.

