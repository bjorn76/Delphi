{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ANNDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{                FEATURES OF THIS DEMO }
{ }
{  	Annunciators }
{ 		Timers }
{************************************************************}

{$F+,K+}   { Smart Callbacks, Far Memory Model }

unit Anndemox;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
PROCEDURE  TimerRoutine;

implementation

{$R rtdemo}


const
  ncount: INTEGER = 0;
  NR= 4;
  NC= 8;

VAR
  thdata: HDATA;
  pPageDesc1 :  PPAGE_DEF;

pDynGrDesc:  PGRAPH_DEF;

{ Prototypes of forward referenced functions }

PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
function randreal:realtype; forward;

{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
  WGCreatePage('PAGE1', { page ID string }
				 	thwnd,               { handle to the parent window }
					tInst,              { application instance handle }
					'Annunciators',      { Window title string }
					@StartGraphs1,       { pointer to graph creation function }
					NIL,         { Name of page window menu in resource file }
					C_LIGHTGRAY,        { window background color }
					MM_ISOTR,         { window sizing mode }
				0,                 { window style - default }
				PAGE_EXACT,         { window initial size and position option }
				0, 0, 700, 500);    { initial window size and position }
					{ if used (not used here) }

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
VAR
	hTags: HGLOBAL;
	lpTags: LPSTR;
  	i, j, ij, nNumRows, nNumCols:INTEGER;
        args: ARRAY[0..0] OF INTEGER;
        pTags, pDataName: string;
	cTags, cDataName: ARRAY[0..24] OF CHAR;
BEGIN
	nNumRows := NR;
	nNumCols := NC;

	hTags := GlobalAlloc (GHND, NR * NC * TAGLEN);
	lpTags :=  GlobalLock(hTags);

	FOR i := 0 TO nNumRows -1 DO
		FOR j := 0 TO nNumCols - 1 DO
		BEGIN
			ij := i * nNumCols + j;
                         STR(ij:1, pTags);
                         pTags := 'Chan ' + pTags;
                         StrPCopy(cTags,pTags);
			lstrcpy(lpTags+ij*TAGLEN,  cTags);
		END;

	StrPCopy(cDataName, 'Annunciator Panel');
	thData := WRDefineDynDataSet (cDataName, NR * NC, 'volts', lpTags, 0);

	{ Initialize graphs }
	pDynGrDesc := WGCreateGraph (pPageDesc,
		@DrawP1G1, { function which builds graph }
		0.005, 0.005, { window relative position inside parent page window }
		0.995, 0.995,
		C_LIGHTBLUE, { light gray background }
		C_WHITE,   { white border }
		1);      { border width in pixels }

	GlobalFree (hTags);
END;
{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR
	 rgbBackColors: ARRAY[0..NR*NC-1] OF TCOLORREF;
         rgbcolor,rgbBackAlmColor: TCOLORREF;
	 nValWidth, nPrec: INTEGER;
         nChanColors: ARRAY[0..NR*NC-1] OF INTEGER;
	 nNumRows, nNumCols, n3D:INTEGER;
	i, j, ij: INTEGER;
        rHigh, rLow:realtype;
	bFlags: ARRAY[0..3] OF BOOL;
BEGIN
  
	bFlags[0] := TRUE; bFlags[1] :=  TRUE;
        bFlags[2] :=  TRUE; bFlags[3] :=  TRUE;
	WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);

	rHigh := 0.95;
	rLow := 0.05;

	{ set the high and low alarm values }
	WRSetAlarm (thdata, ALM_HIGH, rHigh, '*HIGH*');
	WRSetAlarm (thdata, ALM_LOW, rLow, '*LOW*');
	WRSetAlarmHyst (thdata, 0.02, 0.0);

	nValWidth := 8;
	nPrec := 4;
	nNumRows := NR;
	nNumCols := NC;

	FOR i := 0 TO nNumRows- 1 DO
	BEGIN
		CASE (i) OF
			0: rgbColor := WGGetRGBColor(C_LIGHTGRAY);
			1: rgbColor := WGGetRGBColor(C_BROWN);
			2: rgbColor := WGGetRGBColor(C_MAGENTA);
			3: rgbColor := WGGetRGBColor(C_GREEN);
		END;
		FOR j := 0 TO nNumCols - 1 DO
		BEGIN
			ij := i * nNumCols + j;
			nChanColors[ij] := C_BLACK;
			rgbBackColors[ij] := rgbColor;
		END;
	END;
	rgbBackAlmColor := WGGetRGBColor(C_LIGHTRED);

	n3D := RC_LOW;

	WRSetAnnun (pGrDesc,	{ pointer to graph descriptor }
		thdata,				{ handle to dyn data set }
		nValWidth,			{ # characters in value field }
		nPrec,				{ # of digits after dec. point for dyn text }
		@nChanColors,		{ colors for text strings for each channel }
		@rgbBackColors,	    { colors for background for each cell }
		rgbBackAlmColor,	{ background alarm color }
		nNumRows,			{ # of rows in annunciator }
		nNumCols,           { # of cols in annunciator }
		@bFlags,				{ enable components of annunciator }
		n3D);	  			{ 3D effects }
END;

{************************************************************************}

PROCEDURE  TimerRoutine;
VAR
	 rNewVals: ARRAY[0..NR * NC - 1] OF realtype;
	 i, j:INTEGER;
BEGIN
	{ Initialize the DLL every time the timer is called NOT  }
	{ Otherwise the DLL will not know who is calling it. }
	{ Necessary only if multiple RT Tools applications or multiple  }
	{ instances of the same application can run simultaneously. }

	WGStart ;

	IF NOT( WGIsGraphDescValid(pDynGrDesc)) THEN
	       exit ;

	FOR i := 0 TO NR-1 DO
		FOR j := 0 TO NC-1 DO
			rNewVals[i * NC + j] := (randreal);

	{ Update the data }
	WRUpdateData (thdata, @rNewVals, NIL);
END;
{************************************************************************}

begin
  pPageDesc1 := NIL;
end.

