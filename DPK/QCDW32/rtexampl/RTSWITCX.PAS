{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   RTSWITCX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{*   Illustrates switching dynamic data sets                 * }
{*                                                           * }
{************************************************************* }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Rtswitcx;

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
   NT=     4;

VAR
  tinstance: HWND;
  hScroll, hAlmLines, hText: HGOBJ;
  thdata1, thdata2: HDATA;
  hBut1, hBut2, hBut3: HGOBJ;
  lpRButControlProc: TFARPROC;
  pDynGrDesc: PGRAPH_DEF;
  newVal: Realtype;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

{$ifndef WIN32}
PROCEDURE  RButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	  nSelButton,  nPrevBut:INTEGER); export; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT;
          lParam: LONGINT):BOOL; export; forward;
{$else}
 PROCEDURE  RButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
     nSelButton,  nPrevBut:INTEGER); stdcall; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT;
          lParam: LONGINT):BOOL; stdcall; forward;

{$endif}

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
  tinstance := tinst;
		 { page is created in the current window }
		 { page is created in the current window }
		  WGCreatePage('PAGE1', { page ID string }
			thwnd,               { handle to the parent window }
			tInst,              { application instance handle }
			'First Graph',      { Window title string }
			@StartGraphs1,       { pointer to graph creation function }
			'PageMenu',         { Name of page window menu in resource file }
			C_LIGHTGRAY,        { window background color }
			MM_PROPORT,         { window sizing mode }
			0,                 { window style - default }
			PAGE_FULL,          { window initial size and position option }
			0, 0, 0, 0);
END;

procedure WM_DestroyGraph;
begin
  WRCleanup(TRUE); 		{ clean up charting tools memory }
  			{ and free data arrays }
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
		 @DrawP1G1, { points to function which builds graph }
		 0.005, 0.005, { window relative position inside parent page window }
		 0.69, 0.99,
		 C_BROWN, { brown background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }

	WGCreateGraph (pPageDesc,
		 @DrawP1G2, { points to function which builds graph }
		 0.71, 0.005, 0.99, 0.49,
		 C_WHITE, { brown background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }

	WGCreateGraph (pPageDesc,
		 @DrawP1G3,   { points to function which builds graph }
		 0.71, 0.51, 0.99, 0.99,
		 C_WHITE, { white background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }
END;

{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisY, hAxisX: HGOBJ;  { axes handles }
	lpTags, lpText: LPSTR;
        nLineColor,
        nLineStyle,
        nLineWidth: ARRAY[0..NT-1] OF INTEGER;
         i:INTEGER;
        rResetInt:realtype;
        nBut:INTEGER;
	bFlags: ARRAY[0..NALMLINES-1] OF BOOL;
BEGIN
			{ allocate  array for tags }
	GetMem(lpTags, NT * TAGLEN);
	lstrcpy(lpTags , 'First');
        lstrcpy(lpTags + TAGLEN,  'Second');
        lstrcpy(lpTags + 2 * TAGLEN,  'Third');
        lstrcpy(lpTags + 3 * TAGLEN,  'Fourth');

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.12, 0.15, 0.9, 0.7, C_LIGHTGRAY);

	{ scale the plotting are for an x range of 0 to 25.0 }
	{ and y range of -10 to 10 }
	WGScalePlotArea (pGrDesc, 0.0,-2.0, 25.0, 2.0);

	{ set the intercepts to 0,0 }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	{ set current font to Arial, 9 points }
	WGSetTextByName (C_MAGENTA, 'Arial', 9, TEXT_ITAL OR TEXT_BOLD);
	{ draw the x axis with major ticks every physical coord and 0 minor tick }
	{ the ticks will be positioned at the center of the axis }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 0, POS_MIDDLE);

	{ draw the y axis with major ticks every 100 physical coords and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	{ set current font to Arial, 12 points, bold }
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);
	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	{ Write axes titles }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Time');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	{ assign each line style, width and color }
	FOR i := 0 TO NT-1 DO
	BEGIN
		nLineColor [i] := i + 3;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineStyle [1] := PS_DOT;
	nLineWidth [0] := 2;

	rResetInt := 0.8;

	WGSetTextParams (C_WHITE, FF_ROMAN, 10, TEXT_BOLD);

	thdata1 := WRDefineDynDataSet ('Data # 1', NT, 'volts', lpTags, 160);
lstrcpy(lpTags ,  'Channel 1');
lstrcpy(lpTags + TAGLEN,  'Channel 2');
lstrcpy(lpTags + 2 * TAGLEN,  'Channel 3');
lstrcpy(lpTags + 3 * TAGLEN,  'Channel 4');

  	WRSetAlarm (thdata1, ALM_HIGH, 1.8, 'HIGH');
	WRSetAlarm (thdata1, ALM_LOW,  -1.8, 'LOW');

	hScroll := WRSetScrollGraph (pGrDesc, thdata1, 0.5, rResetInt,
		OR_HORZ, NO_STEP, @nLineStyle, @nLineWidth, @nLineColor);

	thdata2  := WRDefineDynDataSet ('Data # 2', NT, 'amps', lpTags, 160);
  	WRSetAlarm (thdata2, ALM_HIGH, 1.2, '*H*');
	WRSetAlarm (thdata2, ALM_LOW,  -1.2, '*L*');

	bFlags[0] := FALSE;
	bFlags[1] := TRUE;
	bFlags[2] := TRUE;
	bFlags[3] := FALSE;
	bFlags[4] := FALSE;

	hAlmLines := WRSetAlarmLines (pGrDesc,  { Pointer to graph descriptor }
			thdata1,			   { Handle to dynamic data set }
			2,				   { Alarm lines refresh period }
			OR_HORZ,		   { Alarm lines direction }
			@bFlags,			   { Flags enabling alarm lines }
			NIL, NIL, NIL);

        FreeMem(lpTags, NT * TAGLEN);

	WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);

	lpRButControlProc := MakeProcInstance (@RButtonControlProc, tInstance);
	nBut := 3;
        GetMem(lpText, nBut * TAGLEN);
	lstrcpy(lpText,  'First DS');
	lstrcpy(lpText + TAGLEN,  'Second DS');
	lstrcpy(lpText + TAGLEN * 2,  'Reset');

	hBut1 := WRSetButtonGroup (pGrDesc, lpRButControlProc, BC_LOOK_LOW,
			0.1, 0.05, 0.65, 0.11, WGGetRGBColor (C_LIGHTGRAY),
			nBut, OR_HORZ, lpText, FALSE);

        FreeMem(lpText, nBut * TAGLEN);

	hText := WRSetDynText (pGrDesc, thdata1, -1, 0.13, 0.85, 0.9, 0.95,
			C_LIGHTGRAY, 4, NIL, C_LIGHTGRAY, OR_HORZ, 4, 2, hScroll, RC_3DBORDER);
END;
{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;  { axes handles }
        nLineColor,
        nLineStyle,
        nLineWidth: ARRAY[0..NT-1] OF INTEGER;
       i:INTEGER;
BEGIN
	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.7, C_BLACK);

	{ scale the plotting are for an x range of 0 to 20.0 }
	{ and y range of -10 to 10 }
	WGScalePlotArea (pGrDesc, 0.0,-2.0, 25.0, 2.0);

	{ set the intercepts to 0,0 }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	{ set current font to Arial, 9 points }
	WGSetTextByName (C_MAGENTA, 'Arial', 8, TEXT_ITAL OR TEXT_BOLD);
	{ draw the x axis with major ticks every physical coord and 0 minor tick }
	{ the ticks will be positioned at the center of the axis }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 0, POS_MIDDLE);
	{ draw the y axis with major ticks every 100 physical coords and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ assign each line style, width and color }
	FOR i := 0 TO NT-1 DO
	BEGIN
		nLineColor [i] := i + 3;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineStyle [1] := PS_DOT;
	nLineWidth [0] := 2;

	WGSetTextParams (C_WHITE, FF_ROMAN, 10, TEXT_BOLD);
	WRSetScrollGraph (pGrDesc, thdata1, 0.5, 0.8,
		OR_HORZ, NO_STEP, @nLineStyle, @nLineWidth, @nLineColor);

		{ set current font to Arial, 11 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 11, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'First data set');
END;
{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;  { axes handles }
        nLineColor,
        nLineStyle,
        nLineWidth: ARRAY[0..NT-1] OF INTEGER;
       i:INTEGER;
BEGIN
	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.15, 0.15, 0.9, 0.7, C_BLACK);

	{ scale the plotting are for an x range of 0 to 20.0 }
	{ and y range of -10 to 10 }
	WGScalePlotArea (pGrDesc, 0.0,-2.0, 25.0, 2.0);

	{ set the intercepts to 0,0 }
	WGSetXYIntercepts (pGrDesc, 0.0, -2.0);

	{ axes to be drawn in solid, black, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	{ set current font to Arial, 9 points }
	WGSetTextByName (C_MAGENTA, 'Arial', 8, TEXT_ITAL OR TEXT_BOLD);
	{ draw the x axis with major ticks every physical coord and 0 minor tick }
	{ the ticks will be positioned at the center of the axis }
	hAxisX := WGDrawXAxis(pGrDesc, thdc, 5.0, 0, POS_MIDDLE);

	{ draw the y axis with major ticks every 100 physical coords and 1 minor ticks }
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NIL);
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	{ assign each line style, width and color }
	FOR i := 0 TO NT-1 DO
	BEGIN
		nLineColor [i] := i + 8;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;

	WRSetScrollGraph (pGrDesc, thdata2, 1.0, 0.8,
		OR_HORZ, NO_STEP, NIL, NIL, @nLineColor);
		{ set current font to Arial, 11 points, bold, italic }
	WGSetTextByName (C_RED, 'Arial', 11, TEXT_BOLD OR TEXT_ITAL);
	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Second data set');
 END;


PROCEDURE  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..DYN_MAXVAL-1] OF realtype;
BEGIN
	IF ( NOT WGIsGraphDescValid (pDynGrDesc)) THEN
		exit;

	WGStart ;

	rArg := M_PI * nCount;

	rNewVals [0] := 1.3 * sin (rArg / (1025.0 - nCount)) ;
	rNewVals [1] := sin (rArg / 52.0) * (random * 1.5) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random * 1.6) * 1.6;
	rNewVals [3] := cos (rArg / 12.0) * 1.4;

	nCount:= nCount + 1;
	IF (nCount > 1000) THEN
		nCount := 0;
	WRUpdateData (thdata1, @rNewVals, NIL);

	IF ((nCount  MOD  2) = 0) THEN
	BEGIN
		rNewVals [0] := -(nCount  MOD  11) / 7.0;
		rNewVals [1] := (nCount  MOD  5) / 4.0;
		IF (nCount  MOD  8 < 4) THEN
			rNewVals [2] := 1.0
		ELSE
			rNewVals [2] := -1.0;
		rNewVals [3] := rNewVals [0] + rNewVals[1];
		WRUpdateData (thdata2, @rNewVals, NIL);
	END;
END;
{************************************************************************}
{ button procedure - switches data sets *********************************}
{************************************************************************}
PROCEDURE  RButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	  nSelButton,  nPrevBut:INTEGER);
VAR
	  rResetInt, rsampleint, lpstep:realtype;
BEGIN
	WRGetScrollGraphParams (pDynGrDesc, hScroll, rsampleint , rResetInt, lpstep);
	IF (nSelButton = 0) THEN
	BEGIN
		WRReconnectDynDataSet (pDynGrDesc, hScroll, thdata1);
		WRReconnectDynDataSet (pDynGrDesc, hAlmLines, thdata1);
		WRReconnectDynDataSet (pDynGrDesc, hText, thdata1);
	END
	ELSE
	IF (nSelButton = 1) THEN
	BEGIN          { switch to second data set }

		WRReconnectDynDataSet (pDynGrDesc, hScroll, thdata2);
		WRReconnectDynDataSet (pDynGrDesc, hAlmLines, thdata2);
		WRReconnectDynDataSet (pDynGrDesc, hText, thdata2);
	END
	ELSE
	BEGIN
		WRResetHistBuffer(thdata1);
		WRResetHistBuffer(thdata2);
		WRResetScroll(pDynGrDesc, hScroll);
	END;
END;


procedure MM_About(thwnd: HWND; tinst: THANDLE);
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }
end;

{ *************************************************************************
    FUNCTION: AboutProc
    PURPOSE:  Processes messages for 'About' dialog box
*************************************************************************** }

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




begin
 pDynGrDesc := NIL;	 { Graph descriptors }
end.
