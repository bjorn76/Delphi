{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   HISTDEMX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{                FEATURES OF THIS DEMO }
{ }
{		Historical Data Replay }
{		Scroll Bar Controls }
{  	Scrolling Graphs }
{		Dynamic Grids }
{		Dynamic Text }
{		Dynamic Data sets }
{      Timers }
{		LED Indicators }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Histdemx;

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
  ncount2: INTEGER = 0;
  NCH	= 3;				{ number of channels }
  SAMPINT = 0.5;
  bHist: BOOL = FALSE;
VAR
 tinstance: HWND;
 hScroll, hTimeLab: HGOBJ;
 thData, hDynTextData: HDATA;
 hScBar,   hLed1: HGOBJ;

 nHistSize: INTEGER;
 rXRange, rSampleInt: Realtype;
pDynGrDesc : PGRAPH_DEF;
lpSBControlProc, lpPButControlProc: TFARPROC;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

{$ifndef WIN32}
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); export; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; export; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; forward;
{$else}
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER); stdcall; forward;
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL; stdcall; forward;
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;

{$endif}


procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
  tinstance := tinst;
		 { page is created in the current window }
  		  WGCreatePage('PAGE1', { page ID string }
			thwnd,               { handle to the parent window }
			tInst,              { application instance handle }
			'History Graph',    { Window title string }
			@StartGraphs1,       { pointer to graph creation function }
			'PageMenu',         { Name of page window menu in resource file }
			C_LIGHTGRAY,        { window background color }
			MM_PROPORT,         { window sizing mode }
			WS_CHILD Or
                        WS_CLIPCHILDREN Or
                        WS_VISIBLE,                 { window style - default }
			PAGE_FULL,          { window initial size and position option }
			0, 0, 0, 0);
END;

procedure WM_DestroyGraph;
begin
 FreeProcInstance (lpSBControlProc);
 FreeProcInstance (lpPButControlProc);
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
		 @DrawP1G1, 	   { points to function which builds graph }
		 0.005, 0.005, { window relative position inside parent page window }
		 0.99, 0.99,
		 C_LIGHTGRAY, { light gray background }
		 C_RED,   	  { red   border }
		 1);      	  { border width in pixels }
END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	hAxisX, hAxisY: HGOBJ;    { axis handles }
	hTags: HGLOBAL;
	lpTags: LPSTR;
	rResetInt,  rMax: realtype;
       	nTraces : INTEGER;
	nLineColor: ARRAY[0..NCH-1] OF INTEGER;
	nLineWidth: ARRAY[0..NCH-1] OF INTEGER;
	nLineStyle: ARRAY[0..NCH-1] OF INTEGER;
    	i:INTEGER;
BEGIN
       	nTraces := NCH;
	{ allocate global array for tags }
	hTags  := GlobalAlloc(GHND, nTraces * DYN_MAXVAL);
	lpTags := GlobalLock (hTags);
	lstrcpy(lpTags,  'First');

	{ define the plotting area of the graph }
	WGSetPlotArea(pGrDesc, thdc, 0.12, 0.15, 0.8, 0.7, C_BLACK);

	rXRange := 20.0;

	{ scale the plotting are for an x range of 0 to 5.0 }
	{ and y range of -2 to 2 }
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	{ set the intercepts to -0.01, -2 }
	WGSetXYIntercepts (pGrDesc, -0.01, -2.0);

	{ axes to be drawn in solid, white, 1 pixels thick }
	WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_WHITE);

	{ set current font to Arial, 9 points }
	WGSetTextByName (C_MAGENTA, 'Arial', 9, TEXT_ITAL OR TEXT_BOLD);

	hAxisX := WRDrawTimeAxis(pGrDesc, 4.0, 1, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY := WGDrawYAxis(pGrDesc, thdc, 1.0, 1, POS_LEFT);

	hTimeLab := WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		2, 13, 30, 0, 3.0, LL_ON, 'LL');

	{ set current font to Arial, 10 points, bold }
	WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD);

	{ Label the y axis, in decimal format, 1 digit after the decimal point. }
	WGLabelAxis(pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NIL);

	WGSetLineStyle(pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);

	{ Write axes titles }
	WGTitleAxis(pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
	WGTitleAxis(pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

	{ set current font to Arial, 16 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD OR TEXT_ITAL);

	{ Write graph title }
	WGTitleGraph(pGrDesc, thdc, 'Input Waveform');

	{ assign each line style, width and color }
	FOR i := 0 TO nTraces- 1 DO
	BEGIN
		nLineColor [i] := 15 -i ;
		nLineStyle [i] := PS_SOLID;
		nLineWidth [i] := 0;
	END;
	nLineStyle [1] := PS_DOT;
	nLineWidth [0] := 2;

	rSampleInt := SAMPINT;   rResetInt := 0.8;

	nHistSize := 400;
	WGSetTextParams (C_BLACK, FF_ROMAN, 10, TEXT_BOLD);
	WGTextNorm (pGrDesc, thdc, 'Use scroll bar to switch to history replay mode',
	    0.45, 0.88, TA_CENTER OR TA_BASELINE, TEXT_NORMAL);
	thData := WRDefineDynDataSet ('Data', nTraces, 'volts', NIL, nHistSize);
	hScroll := WRSetScrollGraph (pGrDesc, thdata, rSampleInt, rResetInt,
		OR_HORZ, NO_STEP,@nLineStyle, @nLineWidth, @nLineColor);

	nLineWidth [2] := 2;

	lpSBControlProc := MakeProcInstance (@ScBarControlProc, tInstance);

	rMax := nHistSize * rSampleInt - rXRange;  { max value of scroll bar range }
	hScBar := WRSetScrBarControl (pGrDesc,	{ pinter to graph descriptor }
		lpSBControlProc,			{ processing function for scroll bar }
		0.12, 0.9, 0.8, 0.94,	    { position of scroll bar rectangle }
		RGB (128, 0, 0),			{ color of the scroll bar }
		0.0,						{ min value of scroll bar range }
		rMax,
		rSampleInt,					{ min change of thumb position }
						{ (by selecting scroll bar arrows) }
		rXRange,    				{ change of thumb position when }
								{ scroll bar shaft is selected }
		rMax);                      { initial thumb position }

	WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);
	lpPButControlProc := MakeProcInstance (@PButtonControlProc, tInstance);
	WRSetButtonControl (pGrDesc, lpPButControlProc,
		BC_STYLE_PUSH, BC_LOOK_HIGH,
		0.85, 0.89, 0.95, 0.95, WGGetRGBColor (C_LIGHTGREEN), 'Live', FALSE);
	hLed1 := WRSetLEDControl (pGrDesc, 0.9, 0.5, 0.025, WGGetRGBColor (C_LIGHTGRAY),
		C_LIGHTRED, C_LIGHTGREEN);

	nLineColor[0] := C_YELLOW;
	WGSetTextParams (C_BLACK, FF_SWISS, 13, TEXT_BOLD);
	hDynTextData := WRDefineDynDataSet ('Sample Data', 1, NIL, NIL, 0);
	{ displays the number of samples collected }
	WRSetDynText (pGrDesc, hDynTextData, 0, 0.82, 0.2, 0.97, 0.4,
			-1, 0, @nLineColor, C_LIGHTGRAY, OR_HORZ, 5, 0, NULLH, RC_HIGH);

	{ start automatic update of time labels }
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab, hScroll);
	GlobalFree (hTags);
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

{************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..DYN_MAXVAL-1] OF realtype;
         rMin, rMax:realtype;
	 i:INTEGER;
BEGIN

	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	WGStart ;

	rArg := M_PI * nCount;

	rNewVals [0] := 1.3 * sin (rArg / (1025.0 - nCount)) ;
	rNewVals [1] := sin (rArg / 52.0) * (random) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random * 1.5 / 50767.0) * 1.6;
        nCount:= (nCount + 1);
	IF (nCount   > 1000) THEN
		nCount := 0;
	WRUpdateData (thdata, @rNewVals, pDynGrDesc);
        ncount2 := ncount2 + 1;
	rNewVals[0] :=  nCount2;
	{ keep counter of total number of sample updates }
	WRUpdateData (hDynTextData, @rNewVals, pDynGrDesc);
END;
{************************************************************************}
{* Scroll bar procedure *************************************************}
{************************************************************************}
FUNCTION ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  VAR lprCurPos, lprPrevPos: Realtype): BOOL;
VAR
	 rDif :realtype;
	 rInc, rActual:realtype;
	 nRet: BOOL;
BEGIN
	 rDif := lprCurPos - lprPrevPos;
	IF ( NOT bHist) THEN     { not in history mode yet }
	BEGIN
		WRChangeButtonState (pDynGrDesc, hLed1, 0);

		bHist := WRShowHist (pDynGrDesc,	{ pointer to graph descriptor }
				hScroll,						{ handle to scrolling graph }
				-rDif,							{ difference between current time }
								    { and latest to be displayed }
				rXRange,  						{ range of independent variable }
				rActual);						{ actual change of indep var returned }

		IF ( NOT bHist) THEN { check if not enough samples to display history }
			{ set to end again }
			WRSetScrollPos (pDynGrDesc, hScBar, nHistSize * rSampleInt)
		ELSE { otherwise set to actual  }
		BEGIN
			WRSetScrollPos (pDynGrDesc, hScBar, lprPrevPos - rActual);
        END;
     	        ScBarControlProc:= bHist;
                exit;
	END
	ELSE
	BEGIN
		nRet := WRMoveHistScroll (pDynGrDesc,	{ pointer to graph descriptor }
				hScroll,		{ handle to scroll graph }
				rDif,			{ requested change of indep var }
				rInc);		    { actual change of indep var }

		{ rInc may be := rDif, but may be different, if buffer not yet filled }
		IF (round(rInc  * 1000) <> round (rDif * 1000)) THEN
		BEGIN  { adjust thumb position }
			WRSetScrollPos (pDynGrDesc, hScBar, lprPrevPos + rInc);
     	        ScBarControlProc := FALSE;
                exit;
		END;
     	        ScBarControlProc:= nRet;
                exit;
	END;
END;

{************************************************************************}
{* Push button procedure ************************************************}
{************************************************************************}
PROCEDURE  PButtonControlProc (pGrDesc: PGRAPH_DEF;  hCtl: HGOBJ;
	 state, dum: INTEGER);
BEGIN
	IF ((State > 0) AND bHist) THEN
		WRChangeButtonState (pDynGrDesc, hLed1, 0);

	{ continue dynamic update of scroll graph }
	WRResumeScroll (pDynGrDesc, hScroll);
	{ move scroll bar back to right side }
	WRSetScrollPos (pDynGrDesc, hScBar, nHistSize * rSampleInt - rXRange);

	bHist := FALSE;
END;

{************************************************************************}

begin
 pDynGrDesc := NIL;	 { Graph descriptors }

end.
