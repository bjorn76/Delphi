{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AUTOTEXX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{                FEATURES OF THIS DEMO }
{ }
{	Dynamic Data sets }
{	Automatic Text Display }
{	Editing functions for some of the automatic text objects. }
{ 	Timers - A simple timer is used to time updates of the graph. }
{************************************************************}


{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Autotexx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation
 {$R rtdemo}

const
  NCHAN  =  12;
  ncount: INTEGER = 0;

VAR

thdata: HDATA;			    { handle to the dynamic data sets. }

lpTags, lpText: LPSTR;

hAutoText: ARRAY [0..AT_NH-1] OF HGOBJ;  { handles of graphical objects for auto text }

pDynGrDesc: PGRAPH_DEF;  { pointers to graph descriptor }

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
			WGCreatePage('PAGE1', { page ID string }
				thwnd,              { handle to the parent window }
				tInst,             { application instance handle }
				'AUTOTEXT',    	   { Window title string }
				@StartGraphs1,      { pointer to graph creation function }
				'PageMenu',        { Name of page window menu in resource file }
				C_LIGHTGRAY,       { window background color }
				MM_PROPORT,        { window sizing mode }
				0,                { window style - default }
				PAGE_FULL,         { window initial size and position option }
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
BEGIN	{ Initialize graph }
	pDynGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G1, { points to function which builds graph }
		 0.005, 0.005, { window relative position inside parent page window }
		 0.8, 0.8,
		 C_WHITE,
		 C_BLACK,
		 1);      { border width in pixels }

END;

{******************************************************
	Builds the graph using Q-C Windows Charting AND Real-Time Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
        intstr: string;
        nColors: ARRAY[0..NCHAN-1] OF INTEGER;
	i:INTEGER;
	nChans :INTEGER;
	nValWidth: INTEGER;
        rHigh, rLow:realtype;
	bFlags: ARRAY[0..4] OF BOOL;
        arglist: ARRAY[0..1] OF INTEGER;
BEGIN
	nChans := NCHAN;
        rHigh := 0.9; rLow := 0.1;
	{ Show the graph window as 'raised' }
	WGRaiseGraph (pGrDesc, RC_HIGH);

	{ assign each channel line a color }
	FOR i := 0 to NChans - 1 DO
		nColors[i] := (14 - i)  MOD  14;

	{ allocate global array for tags }
        getmem (lpTags,nChans * TAGLEN);
	{ assign tag names for dynamic data set channels }
	FOR i := 0 TO nChans - 1 DO
        BEGIN
          intstr := 'Chan ' + IntToStr(i+1);
          StrPCopy(lpTags + i * TAGLEN, intstr);
        END;

	{ define a dynamic data set }
	thdata := WRDefineDynDataSet ('Auto Text', nChans, 'volts', lpTags, 0);

	WRSetAlarm (thData, ALM_LOW,  rLow, 'LOW');
	WRSetAlarm (thData, ALM_HIGH, rHigh, 'HIGH');

	{ free tag names }

	{ set current font to Arial }
	WGSetTextByName (C_RED, 'Arial', 6, 0);

	bFlags[0] := TRUE;
	bFlags[1] := TRUE;
	bFlags[2] := FALSE;	{ exclude setpo }
	bFlags[3] := TRUE;
	bFlags[4] := TRUE;


        getmem(lpText,nChans * LG_MAXLEN);
	{ assign text names for descriptors }
	lstrcpy(lpText ,  'Tank Level');
	lstrcpy(lpText + LG_MAXLEN ,  'Steam Flow');
	lstrcpy(lpText + 2 * LG_MAXLEN ,  'Product Flow');
	lstrcpy(lpText + 3 * LG_MAXLEN ,  'Feed Flow');
	lstrcpy(lpText + 4 * LG_MAXLEN ,  'Composition');
	lstrcpy(lpText + 5 * LG_MAXLEN ,  'Column Level');
	lstrcpy(lpText + 6 * LG_MAXLEN ,  'Recycle Flow');
	lstrcpy(lpText + 7 * LG_MAXLEN ,  'Reflux Flow');
	lstrcpy(lpText + 8 * LG_MAXLEN ,  'Temperature');
	lstrcpy(lpText + 9 * LG_MAXLEN ,  'Volts');
	lstrcpy(lpText + 10 * LG_MAXLEN ,  'Decay');
	lstrcpy(lpText + 11 * LG_MAXLEN ,  'Steam Pressure');

	nValWidth := 8;
	WRSetAutoText (pGrDesc,	{ pointer to graph descriptor }
		thdata,				{ handle to dynamic data set }
		nValWidth,			{ maximum width of 'value' field }
		3,   				{ # digits after decimal pt }
		@nColors,			{ channel colors }
		lpText,				{ descriptor strings }
		@bFlags,				{ enable/disable columns }
		@hAutoText);			{ return object handles }

	{ free tag names }
       freemem(lpTags, nChans * TAGLEN);
       freemem(lpText, nChans * LG_MAXLEN);
END;
{*************************************************************************
	 FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)
	 PURPOSE:  Processes messages for 'About' dialog box
***************************************************************************}



{****************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 i:INTEGER;
	 nSize:INTEGER;
	 rArg:realtype;
	 rNewVals: ARRAY [0..NCHAN-1] OF realtype;
BEGIN

	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	{ Initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple }
	{ instances of the same application can run simultaneously. }

	WGStart ;

	rArg := M_PI * nCount;
	{ assign a dynamic value to each channel }
	rNewVals [0] := sin (rArg / (1025.0 - nCount)) * 1.8 ;
	rNewVals [1] := sin (rArg / 52.0) * (random * 1.5) * 1.1;
	rNewVals [2] := cos (rArg / 60.0) * (random ) * 1.5;
	rNewVals [3] := sin (rArg / 20.0) * (random) * 1.1;
	rNewVals [4] := cos (rArg / 40.0) * (random * 1.5) * 1.5;
	rNewVals [5] := ORD( (nCount  MOD  4 ) <> 0);
	rNewVals [6] := sin (rArg / 70.0) * (random * 1.3) * 2.1;
	rNewVals [7] := cos (rArg / 70.0) * (random * 1.3) * 1.8;
	FOR i := 8 TO NCHAN-1 DO
		rNewVals[i] := random * 32.0;

        ncount := ncount + 1;
	IF (nCount  >= 1000) THEN
		  nCount := 0;

	{ after 25 updates, change the title of the graph }
	IF (nCount = 25) THEN
	BEGIN
		WGChangeString (pDynGrDesc, hAutoText[ATH_TITLE], 'Automatic Text', 0);
		WGRedrawObject (pDynGrDesc, hAutoText[ATH_TITLE], TRUE);
	END;


	{ after 15 updates, change the text style of 'values' }
	IF (nCount = 15) THEN
	BEGIN
		nSize := WGGetFontSize (pDynGrDesc, hAutoText[ATH_VALUES]);
		WGChangeFont (pDynGrDesc, hAutoText[ATH_TAGS], 'Book Antiqua',
			nSize, 0, FW_BOLD, TRUE, TRUE);
		WGRedrawObject (pDynGrDesc, hAutoText[ATH_TAGS], TRUE);
	END;

	{ update hData windows }
	WRUpdateData (thdata, @rNewVals, NIL);
END;
{************************************************************************}

begin
 pDynGrDesc := NIL;	 { Graph descriptors }

end.

