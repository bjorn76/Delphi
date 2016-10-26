{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   NMETERX.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Nmeterx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure  TimerRoutine;

{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall;
{$endif}

implementation

{$R rtdemo}

const
  ncount: INTEGER = 0;
  NCHAN  =   5;
VAR
  hScroll, hAlarms, hTimeLab: HGOBJ;
  thData: HDATA;
  pDynGrDesc: PGRAPH_DEF;
  TiEnable: BOOLEAN;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			WGCreatePage('PAGE1',	{ page ID string }
				 thwnd, 				{ handle to the parent window }
				 tInst,				{ application instance handle }
				 'NMETER',			{ page window title string }
				 @StartGraphs1,		{ pointer to graph creation function }
				 'PageMenu',		{ Name of page window menu in resource file }
				 C_LIGHTGRAY,		{ window background color }
				 MM_ISOTR,          { window sizing mode }
				 0, 				{ window style - default }
				 PAGE_FULL,         { window initial size and position option }
				 0, 0, 0, 0);
 TiEnable := TRUE;

END;

procedure WM_DestroyGraph;
begin
  TiEnable := FALSE;
  WRCleanup(TRUE); 		{ clean up charting tools memory }
			         { and free data arrays }
 { PostQuitMessage(0);}
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
		 @DrawP1G1,   { points to function which builds graph }
		 0.01, 0.01, { window relative position inside parent page window }
		 0.99, 0.99,
		 C_YELLOW, { yellow background }
		 C_RED,    { red border }
		 1);       { border width in pixels }
END;
{*********************************************************************}
PROCEDURE ShowMeter1(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..4] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;
BEGIN
	{ set the colors for the needles }
	nColor [0] := C_LIGHTBLUE;
	nColor [1] := C_LIGHTMAGENTA;
	nColor [2] := C_LIGHTRED;
	nColor [3] := C_GREEN;
	nColor [4] := C_BLUE;

	WGSetTextByName (C_BLUE, 'Arial', 11, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
	rYCenter := 0.3;
	rXCenter := 0.25;
	rDiam := 0.3;
	WRSetMeter (pGrDesc,	{ pointer to graph descriptor }
			thData,						{ handle to dynamic data set }
			-1,							{ display all channels }
			-1.0, 2.0,        		    { min, max physical values }
			rXCenter, rYCenter, rDiam,	{ relative center and diameter }
			30, 150,					{ meter scale, in degrees }
			NEEDLE_SHORTF,				{ needle style }
			@nColor,						{ needle colors }
			0.06,						{ relative tick size }
			1.0,						{ distance between tick marks }
			9,							{ # minor ticks between major ticks }
			POS_INSIDE,					{ display ticks inside meter scale }
			POS_INSIDE,                 { display labels inside meter scale }
			1,							{ label precision set to 1 digit after dec pt }
			FALSE,						{ do not display dynamic text }
			1,							{ dyn text precision set to 1 digit after dec pt }
			FALSE,       				{ do not draw meter scale arc (ticks only) }
			TRUE,        				{ display units string }
			TRUE,       				{ show alarm arcs }
			0.0,						{ size of alarm arcs := rel tick size }
			NIL);						{ use default alarm arc colors }

	WGTextNorm (pGrDesc, thdc, 'Short Filled Needles',
		0.05, 0.25, TA_CENTER, TEXT_VERTLEFT);
END;

{****************************************************************}

PROCEDURE ShowMeter2(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..4] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;
         hMeter: HGOBJ;
BEGIN
	nColor [0] := C_LIGHTBLUE;

	rYCenter := 0.1;
	rXCenter := 0.63;
	rDiam := 0.1;

	WGSetTextByName (C_GREEN, 'Arial', 8, 0);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	hMeter := WRSetMeter (pGrDesc,
			thData,
			0,
			-2.0,  2.0,
			rXCenter, rYCenter, rDiam,
			200, 340,
			NEEDLE_SHORTH,
			@nColor,
			0.08,
			1.0,
			4,
			POS_OUTSIDE, POS_OUTSIDE,
			1,
			TRUE,
			3,
			TRUE, TRUE, TRUE,	0.1, NIL);

	WRSetMeterBorder (pGrDesc, hMeter, rXCenter, rYCenter + 0.03,
			rDiam + 0.12, rDiam + 0.15,
			RGB (255, 255, 128), MET_RECT,
			C_RED, 4);

	WGTextNorm (pGrDesc, thdc, 'Short Hollow Needle',
		0.63, 0.28, TA_CENTER, TEXT_NORMAL);

END;
{************************************************************************}

PROCEDURE ShowMeter3(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..4] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;
         hMeter: HGOBJ;
BEGIN
	nColor [0] := C_LIGHTRED;

	rYCenter := 0.1;
	rXCenter := 0.85;
	rDiam := 0.1;

	WGSetTextByName (C_GREEN, 'Arial', 8, 0);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

	hMeter := WRSetMeter (pGrDesc,
			thData,
			1,
			-2.0,  2.0,
			rXCenter, rYCenter + 0.03, rDiam,
			20, 160,
			NEEDLE_LONGH,
			@nColor,
			0.08,
			1.0,
			4,
			POS_OUTSIDE, POS_OUTSIDE,
			1,
			TRUE,
			3,
			TRUE,
			TRUE,
			TRUE,
			0.06,
			NIL);

	WRSetMeterBorder (pGrDesc, hMeter, rXCenter, rYCenter + 0.03,
			rDiam + 0.12, rDiam + 0.15,
			RGB (255, 255, 128), MET_RECT,
			C_RED, 4);

	WGTextNorm (pGrDesc, thdc, 'Long Hollow Needle',
		0.85, 0.28, TA_CENTER, TEXT_NORMAL);
END;

{***********************************************************}
PROCEDURE ShowMeter4(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..5] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;

BEGIN
	rYCenter := 0.66;
	rXCenter := 0.78;
	rDiam := 0.25;
	nColor [0] := C_LIGHTRED;

	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_GREEN);

	WGSetTextByName (C_LIGHTBLUE, 'Arial', 8, TEXT_BOLD);
	WGTextNorm (pGrDesc, thdc, 'Thick Needle',
		rXCenter, 0.37, TA_CENTER, TEXT_NORMAL);

	WGSetTextByName (C_GREEN, 'Arial', 8, 0);

	WRSetMeter (pGrDesc,
		thData, 0,
		-0.1,  1.4,
		rXCenter, rYCenter, rDiam,
		50, 130,
		NEEDLE_THICK,
		@nColor,
		0.05,
		0.2, 1, POS_MIDDLE, POS_OUTSIDE,
		1,
		TRUE,
		1,
		TRUE,
		TRUE,
		TRUE,
		0.0,
		NIL);
END;

{*********************************************************}

PROCEDURE ShowMeter5(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..5] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;
BEGIN
	rYCenter := 0.75;
	rXCenter := 0.1;
	rDiam := 0.15;
	nColor [0] := C_MAGENTA;
	nColor [1] := C_LIGHTMAGENTA;
	nColor [2] := C_LIGHTRED;
	nColor [3] := C_GREEN;
	nColor [4] := C_BLUE;

	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_GREEN);

	WGSetTextByName (C_LIGHTBLUE, 'Arial', 8, TEXT_BOLD OR TEXT_ITAL);
	WGTextNorm (pGrDesc, thdc, 'Thin Needles',
		rXCenter, 0.6, TA_CENTER, TEXT_NORMAL);

	WGSetTextByName (C_GREEN, 'Arial', 8, 0);


	WRSetMeter (pGrDesc,
		thData, -1,
		-0.1,  1.4,
		rXCenter, rYCenter, rDiam,
		0, 360,
		NEEDLE_LINE,
		@nColor,
		0.05,
		0.2, 1, POS_MIDDLE, POS_INSIDE,
		1,
		FALSE,
		1,
		FALSE,
		TRUE,
		FALSE,
		0.0,
		NIL);

END;
{*******************************************************}

PROCEDURE ShowMeter6(pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
         nColor: ARRAY[0..4] OF INTEGER;
         nAlmColor: ARRAY[0..2] OF INTEGER;
	 rXCenter, rYCenter, rDiam:realtype;
BEGIN

	nColor [0] := C_BROWN;
	nColor [1] := C_WHITE;
	nColor [2] := C_RED;
	nColor [3] := C_GREEN;
	nColor [4] := C_BLUE;

	WGSetTextByName (C_BLUE, 'Arial', 11, TEXT_BOLD);
	WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
	rYCenter := 0.78;
	rXCenter := 0.5;
	rDiam := 0.28;
	nAlmColor[0] := C_WHITE;
	nAlmColor[1] := C_MAGENTA;
	nAlmColor[2] := C_BLUE;


	WRSetMeter (pGrDesc,
			thData, -1,
			-1.0, 2.0,        { min, max }
			rXCenter, rYCenter, rDiam,
			90, 270,
			NEEDLE_LONGF,
			@nColor,
			0.08,
			1.0, 9, POS_INSIDE, POS_INSIDE,
			1,
			TRUE,
			2,
			FALSE,
			TRUE,
			TRUE,
			0.02,
			@nAlmColor);

	WGTextNorm (pGrDesc, thdc, 'Long Filled Needles',
		rXCenter - 0.05, 0.5, TA_CENTER, 90);
END;

{*****************************************************}
{ show 6 meters, each with a different needle style }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
    nChannels :INTEGER;
    rLow, rHigh:realtype;
BEGIN
        nChannels := NCHAN;
	WGRaiseGraph (pGrDesc, RC_HIGH);
	thData := WRDefineDynDataSet ('Auto Text', nChannels, 'Volts', NIL, 0);

	rHigh := 1.0;
	rLow := 0.0;
	WRSetAlarm (thData, ALM_HIGH, rHigh, 'HIGH');
	WRSetAlarm (thData, ALM_LOW,  rLow, 'LOW ALARM');

	ShowMeter1(pGrDesc, thdc);
	ShowMeter2(pGrDesc, thdc);
	ShowMeter3(pGrDesc, thdc);
	ShowMeter4(pGrDesc, thdc);
	ShowMeter5(pGrDesc, thdc);
	ShowMeter6(pGrDesc, thdc);
END;

{*************************************************************************}

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var lpProcAbout: TFARPROC;
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


Procedure  TimerRoutine;
VAR
	 rArg:realtype;
	 rNewVals: ARRAY[0..5] OF realtype;
BEGIN
  if TiEnable THEN
  BEGIN
	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	WGStart ;

	rArg := M_PI * nCount;
	rNewVals [0] := 1.8 * sin (rArg / (1025.0 - nCount));
	rNewVals [1] := sin (rArg / 52.0) * (random ) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random * 1.5) * 1.6;
	rNewVals [3] := (rNewVals[0] + rNewVals[1]) * 2.0;
	rNewVals [4] := rArg/ 1000.0;

        nCount := nCount + 1;
	IF (nCount > 1000) THEN
	  nCount := 0;

	WRUpdateData (thData, @rNewVals, pDynGrDesc);
   END;
END;
{************************************************************************}


begin
 pDynGrDesc := NIL;	 { Graph descriptors }
end.


