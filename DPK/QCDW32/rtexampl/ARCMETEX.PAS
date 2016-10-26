{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ARCMETEX.PAS                                *
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
{  Arc Meters }
{	Meter Borders }
{	Dynamic Data sets }
{ 	Timers }
{ }
{************************************************************}

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Arcmetex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

procedure MM_About(thwnd: HWND; tinst: THANDLE);

implementation
{$R rtdemo}

const
  NCHAN  = 4;
  ncount: INTEGER = 0;

VAR
  thData: HDATA;					{ handle to dyn data set }
  hScroll: ARRAY[0..NCHAN-1] OF HGOBJ;

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc1,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3,
PDynGrDesc4: PGRAPH_DEF;



{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

PROCEDURE StartGraphsALL (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs2 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs3 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE StartGraphs4 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }

PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1GAll (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;


procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
VAR r: TRect;
    w, h: integer;
BEGIN
                         GetWindowRect(thwnd,r);
                         r.top := r.top + 30;
                         r.left := r.left + 10;
                         r.right := r.right - 10;
                         r.bottom := r.bottom - 10;
                         w := (r.right - r.left);
                         h := abs(r.bottom - r.top);
			 WGCreatePage('PAGEAll',  { page ID string }
					thwnd,             { handle to the parent window }
					tInst,           { application instance handle }
					 'Arcs',      	  { page window title string }
					 @StartGraphsAll,  { pointer to graph creation function }
					 'PageMenu',      { name of page window menu in resource file }
					 C_LIGHTGRAY,     { window background color }
					 MM_ISOTR,        { window sizing mode }
					 0,              { window style - default }
					 PAGE_EXACT,      { window initial size and position option }
                                         0, 0, 700, 500);
{					 r.left, r.top, w, h); { initial window size and position }

			 WGCreatePage('PAGE1',    { page ID string }
					 thwnd,            { handle to the parent window }
					 tInst,           { application instance handle }
					 'Arc 1',      	  { page window title string }
					 @StartGraphs1,    { pointer to graph creation function }
					 NIL,         	  { name of page window menu in resource file }
					 C_LIGHTRED,      { window background color }
					 MM_ISOTR,        { window sizing mode }
					 0,              { window style - default }
					 PAGE_EXACT,      { window initial size and position option }
					 0, 0, 200, 200); { initial window position }


			 WGCreatePage('PAGE2', thwnd, tInst, 'Arc 2', @StartGraphs2,
					 NIL, C_LIGHTBLUE, MM_ISOTR, 0, PAGE_EXACT,
					 201, 0, 200, 200);
			 WGCreatePage('PAGE3', thwnd, tInst, 'Arc 3', @StartGraphs3,
					 NIL, C_LIGHTGREEN, MM_ISOTR, 0, PAGE_EXACT,
					 0, 200, 200, 200);

			 WGCreatePage('PAGE4', thwnd, tInst, 'Arc 4', @StartGraphs4,
					NIL, C_LIGHTMAGENTA, MM_ISOTR, 0, PAGE_EXACT,
					200, 200, 200, 200);

END;

procedure WM_DestroyGraph;
begin
   WRCleanup(TRUE); 		{ clean up charting tools memory }
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
begin
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            @AboutProc);              {  AboutProc() instance address  }

end;


{*********************************************************************
	Routine StartGraphs... is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}
{ display 4 meters in a single page window }

PROCEDURE  StartGraphsAll(pPageDesc: PPAGE_DEF);
BEGIN
	 { Initialize graph }
	 pDynGrDesc := WGCreateGraph (pPageDesc,
			@DrawP1GAll, { points to function which builds graph }
			0.05, 0.05, { window relative position inside parent page window }
			0.95, 0.95,
			C_YELLOW,   { yellow background }
			C_RED,      { red   border }
			1);         { border width in pixels }
END;

{***************************************************************}
{ display one meter in a page window }

PROCEDURE StartGraphs1(pPageDesc: PPAGE_DEF);
BEGIN
	 { Initialize graph }
	 pDynGrDesc1 := WGCreateGraph (pPageDesc, @DrawP1G1,
			0.05, 0.05, 0.9, 0.99,
			C_YELLOW, C_RED, 1);
END;

{***************************************************************}

PROCEDURE StartGraphs2(pPageDesc: PPAGE_DEF);
BEGIN
	 { Initialize graph }
	 pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
			0.05, 0.05, 0.9, 0.99,
			C_YELLOW, C_RED, 1);
END;

{***************************************************************}

PROCEDURE StartGraphs3(pPageDesc: PPAGE_DEF);
BEGIN
	 pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
		 0.05, 0.05, 0.9, 0.99,
		 C_YELLOW, C_RED, 1);
END;

{***************************************************************}

PROCEDURE StartGraphs4(pPageDesc: PPAGE_DEF);
BEGIN
	 pDynGrDesc4 := WGCreateGraph (pPageDesc, @DrawP1G4,
		 0.05, 0.05, 0.9, 0.99,
		 C_YELLOW, C_RED, 1);
END;

{******************************************************
	Builds the graph using Q-C Windows Tools functions
*******************************************************}

PROCEDURE  DrawP1GAll (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nNumChannels:INTEGER;
	 rLow, rHigh:realtype;
BEGIN
        nNumChannels := NCHAN;
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ Define the dynamic data set, used by all meters }
	thData := WRDefineDynDataSet ('Auto Text', nNumChannels, 'Volts', NIL, 0);

	rHigh := 1.2;
	rLow := 0.0;
	{ set the high and low alarm limits }
	WRSetAlarm (thData, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (thData, ALM_LOW,  rLow, 'LOW ALARM');

	DrawP1G1 (pGrDesc, thdc);
	DrawP1G2 (pGrDesc, thdc);
	DrawP1G3 (pGrDesc, thdc);
	DrawP1G4 (pGrDesc, thdc);
END;

{***************************************************************}
const
	 nGraphNum1 :INTEGER = 0;

PROCEDURE  DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 hMeter: HGOBJ;
	 rMin, rMax, rCenterPoint:realtype;
	 rXCenter, rYCenter, rDiam, rXDiam:realtype;
	 rArcRelThick, rTickRelSize, rTickSpace:realtype;
	 rAlmRelThick:realtype;
	 nChan, nStartAngle, nEndAngle,
	 nArcColor, nArcBackColor,
	 nSmallTicks, nTickPos,
	 nLabelPrec, nValPrec: INTEGER;
BEGIN
	WGRaiseGraph (pGrDesc, RC_HIGH);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	IF (nGraphNum1 = 0) THEN
	BEGIN
		nGraphNum1 := 1;
		rYCenter := 0.39;
		rXCenter := 0.28;
		rDiam := 0.25;
		WGSetTextByName (C_YELLOW, 'Arial', 11, TEXT_BOLD);
		rXDiam := rDiam + 0.15;
	END
	ELSE
	BEGIN
		rYCenter := 0.6;
		rXCenter := 0.5;
		rDiam := 0.4;
		WGSetTextByName (C_YELLOW, 'Arial', 8, 0);
		rXDiam := rDiam + 0.4;
	END;

	nChan := 1;
	rMin := -1.0;
	rMax := 2.0;
	rCenterPoint := 0.0;
	nStartAngle := 30;
	nEndAngle := 150;
	nArcColor := C_LIGHTMAGENTA;
	nArcBackColor := C_WHITE;
	rArcRelThick := 0.15;
	rTickRelSize := 0.06;
	rTickSpace := 1.0;
	nSmallTicks  := 4;
	nTickPos := POS_OUTSIDE;
	nLabelPrec := 1;
	nValPrec := 2;
	rAlmRelThick := 0.0;

	hMeter := WRSetArcMeter (pGrDesc,		{ pointer to graph descriptor }
			thData,							{ handle to dyn data set }
			nChan,							{ channel id }
			rMin, rMax,						{ physical min, max range of the meter }
			rCenterPoint,					{ center point for arc }
			rXCenter, rYCenter, rDiam,		{ relative position and diameter for meter }
			nStartAngle, nEndAngle,			{ meter scale, in degrees }
			nArcColor,  					{ arc color }
			nArcBackColor,  				{ arc background color }
			rArcRelThick,					{ thickness of arc, relative to diam }
			rTickRelSize,					{ thickness of ticks, relative to diam }
			rTickSpace,						{ distance between major ticks }
			nSmallTicks,					{ # of minor ticks between major ticks }
			nTickPos,						{ position of tick marks }
			nLabelPrec,          			{ label precision }
			TRUE,       					{ dynamic text is displayed }
			nValPrec,						{ precision of dynamic text }
			TRUE,       					{ display arc scale }
			TRUE,       					{ display units }
			TRUE,     						{ display alarms }
			rAlmRelThick,					{ thickness of alarm arcs }
			NIL);							{ alarm arcs }

        ryCenter := rYCenter - 0.1;
	WRSetMeterBorder (pGrDesc,				{ pointer to graph descriptor }
			hMeter,							{ handle to the meter }
			rXCenter, rYCenter,				{ geometrical center point for border }
			rXDiam, rDiam + 0.21,			{ border dimensions }
			WGGetRGBColor (C_LIGHTBLUE),	{ background color }
			MET_RD_RECT,					{ meter shape style }
			C_GREEN,						{ border color }
			3);								{ border width }

END;
{***************************************************************}

const
	 nGraphNum2 :INTEGER = 0;

PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   rXCenter, rYCenter, rDiam:realtype;
   nAlmColor: ARRAY[0..2] OF INTEGER;
BEGIN
	WGRaiseGraph (pGrDesc, RC_HIGH);

	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	{ 2d meter }
	IF (nGraphNum2 = 0) THEN
	BEGIN
		nGraphNum2 := 1;
		rXCenter := 0.75;
		rYCenter := 0.19;
		rDiam := 0.12;
		WGSetTextByName (C_BLACK, 'Arial', 8, TEXT_BOLD);
	END
	ELSE
	BEGIN
		rXCenter := 0.5;
		rYCenter := 0.5;
		rDiam := 0.6;
		WGSetTextByName (C_BLACK, 'Arial', 8, 0);
	END;

	nAlmColor[0] := -1;	            { don't display arc for normal range }
	nAlmColor[1] := C_LIGHTRED;      { colors of alarm arcs }
	nAlmColor[2] := C_LIGHTGREEN;

	WRSetArcMeter (pGrDesc,
			thData, 0,
			-2.0, 2.0, -2.0,    { min, max, center }
			rXCenter, rYCenter,
			rDiam,
			0, 360,  			{ meter scale 0 - 360 degrees }
			C_GREEN,  			{ scale line color }
			-1,  				{ no background arcs }
			0.012,  			{ arc width }
			0.07,				{ tick size }
			1.0,				{ tick spacing }
			5,					{ # minor ticks between major ticks }
			POS_INSIDE,			{ draw ticks inside scale arc }
			1,          		{ label precision }
			TRUE,       		{ display dynamic text, }
			2,					{ dynamic text precision }
			TRUE,      			{ draw scale arc }
			TRUE,       		{ show units }
			TRUE,      			{ display alarm arcs }
			0.08,
			@nAlmColor); 		{ colors for alarm arcs }
END;

{***************************************************************}
const
	 nGraphNum3 :INTEGER = 0;

PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
   rXCenter, rYCenter, rDiam:realtype;
BEGIN
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ 2d meter }
	IF (nGraphNum3 = 0) THEN
	BEGIN
		nGraphNum3 := 1;
		rXCenter := 0.75;
		rYCenter := 0.65;
		rDiam := 0.10;
		WGSetTextParams (C_RED, FF_ROMAN, 10, TEXT_BOLD);
	END
	ELSE
	BEGIN
		rXCenter := 0.5;
		rYCenter := 0.5;
		rDiam := 0.3;
		WGSetTextParams (C_RED, FF_ROMAN, 8, 0);
	END;

	WRSetArcMeter (pGrDesc,		    { pointer to graph desc }
			thData,					{ handle to data set }
			2,						{ channel 2 is displayed }
			2.0, -2.0, 0.0,  		{ min, max, center values }
			rXCenter, rYCenter, rDiam, { center AND diameter of meter }
			200, -20,				{ meter scale, in degrees }
			C_GREEN,  				{ active arc color }
			C_LIGHTGRAY,  			{ background arc color }
			0.03,					{ arc thickness }
			0.08, 1.0, 4,			{ tick attributes }
			POS_MIDDLE,				{ tick position }
			1,          			{ label precision }
			TRUE,       			{ display dynamic text }
			3,                      { precision for dyn text }
			FALSE,       			{ don't draw scale arc }
			TRUE,       			{ display units }
			TRUE,      				{ display alarm arcs }
			0.06,                   { relative size of alarm arcs }
			NIL); 					{ default alarm arc colors }
END;

{***************************************************************}
const
	 nGraphNum4 :INTEGER = 0;

PROCEDURE DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
     rXCenter, rYCenter, rDiam, rXDiam:realtype;
     hMeter: HGOBJ;
BEGIN
	WGSetTextByName (C_YELLOW, 'Arial', 11, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	IF (nGraphNum4 = 0) THEN
	BEGIN
		nGraphNum4 := 1;
		rXCenter := 0.25;
		rYCenter := 0.78;
		rDiam := 0.15;
		rXDiam := rDiam + 0.12;
	END
	ELSE
	BEGIN
		rXCenter := 0.5;
		rYCenter := 0.5;
		rDiam := 0.40;
		rXDiam := rDiam + 0.3;
	END;

	{ 4th meter }
	WGSetTextParams (C_YELLOW, FF_SWISS, 5, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_YELLOW);

	hMeter := WRSetArcMeter (pGrDesc,
			thData,       		{ handle to dynamic data set }
			3,					{ display chan #3 of the data set }
			2.0, -2.0, 0.0,  	{ min, max, center }
			rXCenter, rYCenter, rDiam,
			-90, 90,			{ meter scale from -90 to 90 degrees }
			C_WHITE,  			{ active arc color }
			C_BLUE,  			{ background arc color }
			0.08,				{ arc thickness }
			0.05, 1.0, 1,       { tick parameters }
			POS_MIDDLE,			{ tick placement }
			1,          		{ label precision }
			TRUE,       		{ show dynamic text }
			4,           		{ dynamic text precision }
			TRUE,       		{ display scale arc }
			FALSE,       		{ do not display units }
			FALSE,      		{ do not display alarms }
			0.0, NIL); 		{ no alarm arcs }

	WRSetMeterBorder (pGrDesc,
			hMeter,
			rXCenter, rYCenter,
			rXDiam, rDiam + 0.3,
			WGGetRGBColor (C_RED),
			MET_CIRC,
			C_BLUE,
			4);
END;

{***************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..NCHAN-1] OF realtype;
BEGIN
	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart;

      { simulate data }
	rArg := M_PI * nCount;
	rNewVals [0] := 1.8 * sin (rArg / (1025.0 - nCount));
	rNewVals [1] := sin (rArg / 52.0) * (random) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random * 1.5) * 1.6;
	rNewVals [3] := (rNewVals[0] + rNewVals[1]) / 2.0;
        nCount := nCount + 1;
	IF (nCount >= 1000) THEN
		nCount := 0;

	WRUpdateData (thData, @rNewVals, NIL); { update data and all graphs }
END;

{*************************************************************************
	 FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)

	PURPOSE:  Processes messages for 'About' dialog box

**************************************************************************}
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


{***************************************************************}
begin
 pDynGrDesc := NIL;	 { Graph descriptors }
 pDynGrDesc1 := NIL;	 { Graph descriptors }
 pDynGrDesc2 := NIL;
 pDynGrDesc3 := NIL;
 pDynGrDesc4 := NIL;

end.
