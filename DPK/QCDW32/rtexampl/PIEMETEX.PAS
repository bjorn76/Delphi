{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIEMETEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{************************************************************}
{  THIS EXAMPLE PROGRAMS SHOWS HOW TO USE: }
{ }
{  	Pie Meters }
{		Meter Borders }

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Piemetex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R rtdemo}

const
  ncount: INTEGER = 0;
  NCHAN =  2;

VAR
  lpTimerRoutine: TFARPROC;
  idTimer: INTEGER;
         { global instance handle }
  thData, thData2: HDATA;
pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2: PGRAPH_DEF;



{ Prototypes of forward referenced functions }
PROCEDURE  TimerRoutine (thwnd: HWND; msg, idTimer: UINT;
	dwTime: LongInt); export; forward;

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs2 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP2G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			 WGCreatePage('PAGE1',	    { page ID string }
					thwnd,  				{ handle to the parent window }
					tInst, 				{ application instance handle }
					'Pie Meters', 		{ Window title string }
					@StartGraphs1,		{ pointer to graph creation function }
					'PageMenu',			{ Name of page window menu in resource file }
					C_CYAN,				{ page window background color }
					MM_ISOTR,			{ page sizing mode }
					0, 				{ window style - default }
					PAGE_EXACT,			{ window initial size and position option }
					0, 0, 700, 500);	{ initial window size and position }

			 WGCreatePage('PAGE2',      { page ID string }
					thwnd, 				{ handle to the parent window }
					tInst,				{ application instance handle }
					'Pie2',				{ Window title string }
					@StartGraphs2,		{ pointer to graph creation function }
					NIL,				{ no menu }
					C_CYAN,				{ page window background color }
					MM_ISOTR,			{ window sizing mode }
					0, 				{ window style - default }
					PAGE_EXACT,			{ window initial size and position option }
					0, 300, 200, 200);  { initial window size and position }


            { start 0.25 second timer }
           lpTimerRoutine := MakeProcInstance (@TimerRoutine, tInst);
            idTimer := SetTimer (NULLH, 0, 250, lpTimerRoutine);
END;

procedure WM_DestroyGraph;
begin
  KillTimer (NULLH, idTimer);	{ stop the timer }
  IF (lpTimerRoutine <> NIL) THEN
  	FreeProcInstance (lpTimerRoutine);
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
		 0.05, 0.05, { window relative position inside parent page window }
		 0.95, 0.95,
		 C_YELLOW, { yellow background }
		 C_RED,   { red  border }
		 1);      { border width in pixels }
END;

{******************************************************************************}

procedure StartGraphs2 (pPageDesc: PPAGE_DEF);
BEGIN
		{ Initialize graph }

	 pDynGrDesc2 := WGCreateGraph (pPageDesc,
		 @DrawP2G1, { points to function which builds graph }
		 0.01, 0.01, { window relative position inside parent page window }
		 0.99, 0.99,
		 C_WHITE, { white background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }
END;

{******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 hMeter: HGOBJ;
	 rMin, rMax, rCenterPoint:realtype;
	 rXCenter, rYCenter, rDiam:realtype;
	 rTickSpace, rTickRelSize:realtype;
	 nStartAngle, nEndAngle,
	 nPieColor, nPieBackcolor,
	 nSmallTicks: INTEGER;
BEGIN
	WGRaiseGraph (pGrDesc, RC_HIGH);

	thData := WRDefineDynDataSet ('Auto Text', NCHAN, 'Volts', NIL, 0);

    { set alarm limits }
	WRSetAlarm (thData, ALM_HIGH, 1.2, 'HIGH');
	WRSetAlarm (thData, ALM_LOW,  0.0, 'LOW ALARM');

	WGSetTextParams (C_WHITE, FF_SWISS, 11, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

    { pie meter parameters }
	rMin := -1.0;
	rMax := 2.0;
	rCenterPoint := 1.0;
	rYCenter := 0.4;
	rXCenter := 0.28;
	rDiam := 0.33;
	nStartAngle := 30;
	nEndAngle := 150;
	nPieColor := C_GREEN;
	nPieBackcolor := C_WHITE;
	rTickRelSize := 0.06;
	rTickSpace := 1.0;
	nSmallTicks := 10;

	hMeter := WRSetPieMeter (pGrDesc,	{ pointer to graph descriptor }
			thData,						{ handle to data set }
			0,							{ display channel 0 }
			rMin, rMax,                 { physical range }
			rCenterPoint,				{ center point for pie }
			rXCenter,					{ position of meter geometrical center, }
			rYCenter,                   { in relative coordinates }
			rDiam,						{ relative diameter }
			nStartAngle, nEndAngle,		{ meter scale, in degrees }
			nPieColor,  				{ active pie color }
			nPieBackcolor,  			{ background pie color }
			rTickRelSize,             	{ relative tick size }
			rTickSpace,					{ major tick spacing }
			nSmallTicks,				{ # of small ticks between major ticks }
			POS_OUTSIDE,				{ display ticks outside scale arc }
			1,          				{ label precision }
			TRUE,       				{ display scale arc }
			TRUE,      				   	{ display alarm arcs }
			0.06,					   	{ relative width of alarm arcs }
			NIL); 						{ default alarm arcs colors }

	rYCenter  := rYCenter - 0.15;
	{ set current font to Arial, 8 points, bold, italic }
	WGSetTextByName (C_GREEN, 'Arial', 8, TEXT_BOLD OR TEXT_ITAL);

    { change meter shape and background color }
	WRSetMeterBorder (pGrDesc,			{ pointer to graph descriptor }
			hMeter,						{ handle to the meter }
			rXCenter, rYCenter,			{ center point for border }
			rDiam + 0.15, rDiam + 0.1,  { meter rectangle relative sizes }
			WGGetRGBColor (C_BLUE),		{ background color }
			MET_RD_RECT,				{ style - round rectangle }
			C_MAGENTA,					{ magenta border }
			3);							{ 3 pixels wide }

	rXCenter := 0.68;
	rYCenter := 0.72;
	rDiam := 0.23;
	hMeter := WRSetPieMeter (pGrDesc, thData,
			1,							{ display channel 1 }
			0.0, 12.0, 0.0,  			{ min, max, pie center, in physical units }
			rXCenter, rYCenter, rDiam,	{ geometrical center point and diameter for meter }
			90, 450,                    { meter scale, in degrees }
			C_BLUE,  					{ active pie color }
			C_WHITE,  					{ background pie color }
			0.06, 1.0, 4,				{ tick parameters }
			POS_INSIDE,					{ ticks displayed inside scale arc }
			1,          				{ label precision }
			FALSE,       				{ do not display scale arc }
			FALSE,      				{ do not display alarm arcs }
			0.0, NIL); 				{ ignored }
END;

{***************************************************************************}
procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 hMeter: HGOBJ;
	 rMin, rMax, rCenterPoint:realtype;
	 rXCenter, rYCenter, rDiam:realtype;
	 rTickSpace, rTickRelSize:realtype;
	 nStartAngle, nEndAngle,
	 nPieColor, nPieBackcolor,
	 nSmallTicks: INTEGER;
BEGIN

	WGRaiseGraph (pGrDesc, RC_HIGH);

	thData2 := WRDefineDynDataSet ('PAGE 2', 1, 'Volts', NIL, 0);

	WGSetTextParams (C_GREEN, FF_MODERN, 6, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
    { meter parameters }
	rMin := 1000.0;
	rMax := 2000.0;
	rCenterPoint := 1000.0;
	rYCenter := 0.5;
	rXCenter := 0.5;
	rDiam := 0.4;
	nStartAngle := -45;
	nEndAngle := 215;
	nPieColor := C_LIGHTRED;
	nPieBackcolor := C_BLUE;
	rTickRelSize := 0.05;
	rTickSpace := 250.0;
	nSmallTicks := 5;

	WRSetPieMeter (pGrDesc,	        { pointer to graph descriptor }
			thData2,				    { handle to data set }
			0,						{ display channel 0 }
			rMin, rMax,             { physical range }
			rCenterPoint,			{ center point for oie }
			rXCenter,				{ relative coordinatez x position, in normalized units }
			rYCenter,               { relative y position, in normalized units }
			rDiam,					{ relative diameter, in normalized coordinates }
			nStartAngle, nEndAngle,	{ meter scale, in degrees }
			nPieColor,  			{ active pie color }
			nPieBackcolor,  		{ background pie color }
			rTickRelSize,           { relative tick size }
			rTickSpace,				{ major tick spacing }
			nSmallTicks,			{ # of small ticks between major ticks }
			POS_OUTSIDE,			{ display ticks outside scale arc }
			0,                      { label precision }
			TRUE,       			{ display scale arc }
			FALSE,                  { do not display alarm arcs }
			0.0,        			{ ignored }
			NIL); 		            { ignored }
END;
{*************************************************************************
	 FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)

	PURPOSE:  Processes messages for 'About' dialog box

***************************************************************************}

function  AboutProc (hDlg: HWND; message: WORD; wParam: WORD; lParam: LONGINT):WORDBOOL;
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

const
  sign :INTEGER = 1;
  rVal : Realtype = 0.0;

{************************************************************************}

PROCEDURE  TimerRoutine (thwnd: HWND; msg, idTimer: UINT;
	dwTime: LongInt);
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..NCHAN-1] OF realtype;
BEGIN
	IF ( NOT WGIsGraphDescValid (pDynGrDesc)) THEN
		exit;

	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart;
    { simulate data }
	rArg := M_PI * nCount;
	rNewVals [0] := 1.8 * sin (rArg / (1025.0 - nCount));
	rNewVals [1] := rVal + random * sign;
	rVal := rNewVals[1];
	IF (rNewVals[1] > 11.25) THEN
		sign := -1
	ELSE
		IF (rNewVals[1] < 0.5) THEN
			sign := 1;
    { update data set }
	WRUpdateData (thData, @rNewVals, NIL);
        nCount := nCount + 1;
	IF (nCount >= 1000) THEN
		nCount := 0;

	IF ( NOT WGIsGraphDescValid (pDynGrDesc2)) THEN
		exit;

	rNewVals [0] := 1000+ random * 1000.0;
	WRUpdateData (thData2, @rNewVals, NIL);
END;
{************************************************************************}


begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;

end.
