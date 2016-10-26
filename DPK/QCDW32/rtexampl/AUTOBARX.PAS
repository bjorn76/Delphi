{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AUTOBARX.PAS                                *
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
{  Auto Bar Graphs - vertical and horizontal }
{	Dynamic Text - automatically displayed by Auto Bar function }
{	Dynamic Legends - automatically displayed by Auto Bar function }
{	Alarm Text - automatically displayed by Auto Bar function }
{	Dynamic Data sets }
{ 	Timers - A simple timer is used to time updates of the graphs. }
{ 	Editing functions are used to change the attributes of some  }
{ 	of the graphical objects created by the Auto Bar function. }
{************************************************************}


{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Autobarx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}

const
  NUMLED = 7;
  ncount: INTEGER = 0;
  nBarCount :INTEGER=0;
  NCH1 =    8;				{ # of channels for the 1st bar graph }
  NCH2 =    4;				{ # of channels for the 2nd AND 3rd bar graph }

VAR

thData, thData2: HDATA;			{ handles to the dynamic data sets. }
hTags: HGLOBAL;					{ handle to tag name }
hAutoBar: ARRAY [0..AB_NH-1] OF HGOBJ;    { handles of graphical objects for auto bars. }

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2,
pDynGrDesc3: PGRAPH_DEF;
pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }

{ Prototypes of forward referenced functions }
PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G2 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
PROCEDURE DrawP1G3 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			WGCreatePage('PAGE1', { page ID string }
				thwnd,              { handle to the parent window }
				tInst,             { application instance handle }
				'AUTOBARS',    	   { Window title string }
				@StartGraphs1,      { pointer to graph creation function }
				'PageMenu',        { Name of page window menu in resource file }
				C_LIGHTGRAY,       { window background color }
				MM_PROPORT,        { window sizing mode }
				0,                { window style - default }
				PAGE_FULL,         { window initial size and position option }
				0, 0, 780, 580);   { initial window size and position }
										  { if used (not used here) }
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
		 0.99, 0.5,
		 C_WHITE,
		 C_BLACK,
		 1);      { border width in pixels }

	pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2,
		 0.005, 0.5, 0.5, 0.99,
		 C_WHITE, C_RED, 1);

	pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3,
		 0.51, 0.5, 0.99, 0.99,
		 C_LIGHTGRAY, C_GREEN, 2);

END;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	lpTags: LPSTR;
	BarColor: ARRAY [0..NCH1-1] OF TCOLORREF;
        i:INTEGER;
        nTraces:INTEGER;
	nPrec: INTEGER;
        rMin, rMax, rCenterPoint:realtype;
        rSetp, rHighAlm, rLowAlm:realtype;
BEGIN
         nTraces := NCH1;
	{ Show the graph window as 'raised' }
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ assign each bar an RGB color }
	FOR i := 1 TO  nTraces - 1 DO
		BarColor[i] := WGGetRGBColor ((i  MOD  14) + 1);
	BarColor[0] := RGB (192, 0, 96);

	{ allocate global array for tags }
	hTags := GlobalAlloc(GHND, nTraces * TAGLEN);
	lpTags :=  GlobalLock (hTags);

	{ assign tag names to dynamic data set channels }
	lstrcpy(lpTags ,  'CH 1');
	lstrcpy(lpTags + TAGLEN ,  'CH 2');
	lstrcpy(lpTags + 2 * TAGLEN ,  'CH 3');
	lstrcpy(lpTags + 3 * TAGLEN ,  'CH 4');
	lstrcpy(lpTags + 4 * TAGLEN ,  'CH 5');
	lstrcpy(lpTags + 5 * TAGLEN ,  'CH 6');
	lstrcpy(lpTags + 6 * TAGLEN ,  'CH 7');
	lstrcpy(lpTags + 7 * TAGLEN ,  'CH 8');

	{ define a dynamic data set }
	thData := WRDefineDynDataSet ('Auto Bar',
			nTraces,		{ 8 channels }
			'volts',		{ units string }
			lpTags,		    { tag names  }
			0);			    { no history buffer is needed }

	{ set current font to Arial, 6 points }
	WGSetTextByName (C_RED, 'Arial', 6, 0);

	{ display an auto bar, in a vertical mode }
	rMin := -1.5;
	rMax := 1.5;
	rCenterPoint := -1.5;
	nPrec := 3;
	rSetp := 0.3;
	rHighAlm := 1.0;
	rLowAlm := -1.0;
	WRSetAutoBargraph (pGrDesc,
			thdata,			{ handle to dynamic data set }
			rMin,			{ minimum value of dynamic bar graph }
			rMax, 			{ maximum value of dynamic bar graph }
			rCenterPoint,   { center point of bar graph }
			OR_VERT,		{ bar orientation }
			nPrec,			{ # digits after the decimal point }
			rSetp,			{ set point value }
			rHighAlm,		{ high alarm value }
			rLowAlm,		{ low alarm value }
			'*HI*',		    { high alarm message }
			'*LO*',	      	{ low alarm message }
			@BarColor,   	{ rgb colors for bars }
			NIL);			{ returns handles to graphics objects, not needed }
	WRSetAlarmHyst (thdata, 0.1, 0.0); { set alarm hysteresis }

	{ free tag names }
	GlobalFree (hTags);
END;

{*********************************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 BarColor: ARRAY [0..9] OF TCOLORREF;
         nTraces:INTEGER;
         i:INTEGER;
BEGIN
        nTraces := NCH2;
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ assign each bar an RGB color }
	FOR i := 0 TO nTraces - 1 DO
		BarColor[i] := WGGetRGBColor ((i  MOD  15) + 3);

	{ define a dynamic data set }
	thdata2 := WRDefineDynDataSet ('Auto Bar 2', nTraces, 'v', NIL, 0);

	{ display a horizontal auto bar graph }
	WRSetAutoBargraph (pGrDesc, thdata2, -1.5, 1.5,  0.0,
		OR_HORZ, 3, 0.3, 0.7, -0.7, 'High', 'Low', @BarColor, NIL);
END;

{*********************************************************************}
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
  BarColor: ARRAY [0..NCH2-1] OF TCOLORREF;
  i:INTEGER;
  nTraces:INTEGER;
BEGIN
  nTraces := NCH2;
	{ Show the graph window as raised  }
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ assign each bar an RGB value }
	FOR i := 0 TO nTraces - 1 DO
		BarColor[i] := WGGetRGBColor ((i  MOD  15) + 2);

	{ Display a vertical auto bar graph }
	{ Handles to each object created by this function are returned }
	{ in hAutoBar. These handles will be used to change various }
	{ attributes of the graph }
	WRSetAutoBargraph (pGrDesc, thdata2, 2.0, -2.0,  0.1,
		OR_VERT, 2, 0.15, 0.9, -0.9, 'HighAlm', 'L', @BarColor, @hAutoBar);
END;


{****************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	bRedraw: BOOL;
	rArg:realtype;
	rNewVals: ARRAY [0..NCH1-1] OF realtype;
BEGIN
        bRedraw := FALSE;
	IF ( NOT WGIsGraphDescValid (pDynGrDesc)) THEN
		exit;

	{ Do not forget to initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart ;

	rArg := M_PI * nCount;
	{ assign a dynamic value to each channel }
	rNewVals [0] := sin (rArg / (1025.0 - nCount)) * 1.8 ;
	rNewVals [1] := sin (rArg / 52.0) * (random * 1.5) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random) * 1.5;
	rNewVals [3] := sin (rArg / 20.0) * (random) * 1.1;
	rNewVals [4] := cos (rArg / 40.0) * (random * 1.5) * 1.5;
	rNewVals [5] := ORD((nCount  MOD  4) <> 0);
	rNewVals [6] := sin (rArg / 70.0) * (random * 1.2) * 2.1;
	rNewVals [7] := cos (rArg / 70.0) * (random * 1.2) * 1.8;

        ncount := ncount + 1;
	IF (nCount > 1000) THEN
		  nCount := 0;

	{ update thdata  }
	WRUpdateData (thdata, @rNewVals, NIL);

	IF ( NOT WGIsGraphDescValid (pDynGrDesc2)) THEN
		exit;

	{ updata thdata2  }
	WRUpdateData (thdata2, @rNewVals, NIL);

	{ after 12 updates change the OK string for thdata }
	IF (nCount = 12) THEN
		  WRChangeAlarm (thdata, ALM_OK, 0.0, FALSE, '**NORM**');

	{ after 20 updates change text color of alarm messages in graph 3 }
	IF (nCount = 20) THEN
	BEGIN
		IF ( NOT WGIsGraphDescValid (pDynGrDesc3)) THEN
			exit;
		WRChangeDynTextColor (pDynGrDesc3, hAutoBar [ABH_ALMTEXT], C_YELLOW, ALM_HIGH);
		WRChangeDynTextColor (pDynGrDesc3, hAutoBar [ABH_ALMTEXT], C_YELLOW, ALM_LOW);
		WRChangeDynTextColor (pDynGrDesc3, hAutoBar [ABH_ALMTEXT], C_GREEN, ALM_OK);
		bRedraw := TRUE;
	END;

	{ Change the color of each dynamic bar in graph 3 to yellow }
	IF (nBarCount < 4) THEN
		IF ( (nCount  MOD  25) = 0) THEN
		BEGIN
			IF ( NOT WGIsGraphDescValid (pDynGrDesc3)) THEN
				exit;
			WGChangeAreaColor (pDynGrDesc3, hAutoBar[ABH_BAR],
				WGGetRGBColor(C_YELLOW), nBarCount);
			nBarCount:= nBarCount + 1;
			bRedraw := TRUE;
		END;

	IF (bRedraw) THEN
		WGRedrawGraph (pDynGrDesc3, FALSE);
END;
{************************************************************************}

begin
  pPageDesc1 := NIL;
  pDynGrDesc := NIL;
  pDynGrDesc2 := NIL;
  pDynGrDesc3 := NIL;
end.
