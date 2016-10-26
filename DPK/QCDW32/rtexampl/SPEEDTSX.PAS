{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SPEEDTSX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

{$F+,K+}
unit Speedtsx;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook, sysutils;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R rtdemo}

const
  szAppName:PChar = 'Speedtst';  {  Class Name used in call to CreateWindow.  }
   NUMP =  500;
   NT   =  4;

VAR
  hText: HGOBJ;
  thData: HDATA;
  ncount: INTEGER;

pDynGrDesc: PGRAPH_DEF;
rVal: ARRAY [0..NUMP-1,0..NT-1] of Realtype;


{ Prototypes of forward referenced functions }
PROCEDURE StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
PROCEDURE DrawP1G1 (pGrDesc: PGRAPH_DEF;  thdc: HDC); far; forward;
function randreal:realtype; forward;
PROCEDURE NewVal (pGrDesc: PGRAPH_DEF; hText: HGOBJ); forward;

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
			'First Graph',      { Window title string  }
			@StartGraphs1,       { pointer to graph creation function }
			'PageMenu',         { Name of page window menu in resource file }
			C_LIGHTGRAY,        { window background color }
			MM_PROPORT,         { window sizing mode }
			0,                 { window style - default }
			PAGE_FULL,          { window initial size and position option }
			0, 0, 0, 0);

			NewVal (pDynGrDesc, hText);
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
      { Initialize graph  }

	pDynGrDesc := WGCreateGraph (pPageDesc,
		 @DrawP1G1, { points to function which builds graph }
		 0.005, 0.005, { window relative position inside parent page window }
		 0.99, 0.89,
		 C_LIGHTGRAY, { white background }
		 C_RED,   { red   border }
		 1);      { border width in pixels }
END;

{******************************************************
   Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
VAR

	 szTags: ARRAY[0..TAGLEN-1] OF CHAR;
	 nLineColor: ARRAY[0..NT-1] OF INTEGER;
	 rSampleInt:realtype;
	 i: INTEGER;
BEGIN
	lstrcpy(szTags, 'Scroll');
	rSampleInt := 0.1;
	FOR i := 0 TO NT-1 DO
       	BEGIN
		nLineColor[i] := C_YELLOW - i;
	END;
	thData := WRDefineDynDataSet ('100 Points, 0.75 Reset', NT,
		'volts', NIL, 0);

	{ set current font to Arial }
	WGSetTextByName (C_LIGHTGREEN, 'Arial', 10, TEXT_BOLD);

	WRSetAutoScrollGraph (pGrDesc, thData,
		rSampleInt,         { sample interval }
		0.75,               { reset interval }
		-2.0, 2.0,          { min and max values of dependent variable }
		10.0,               { range of independent variable }
		GOD_SUBT_SCLINE,    { scrolling lines graph subtype }
		0,                  { ignored }
		0.0,                { setp }
		0.0,                { high alarm limit := low alarm limit, no alarm lines }
		0.0,
		NIL,
		C_BLACK,            { plotting area color }
		@nLineColor,
		FALSE,              { no dynamic text }
		NIL);

	{ set current font to Arial, 11 points, bold }
	WGSetTextByName (C_RED, 'Arial', 11, TEXT_BOLD);

	WGRectangleNormEx (pGrDesc, thdc, 0.33, 0.895, 0.67, 0.97, C_LIGHTGRAY,
		3, FALSE, NULLH, RC_3DBORDER);

	hText := WGTextNorm (pGrDesc, thdc, '              ',
			  0.5, 0.91, TA_TOP OR TA_CENTER, 0);
END;

{************************************************************************}
PROCEDURE NewVal (pGrDesc: PGRAPH_DEF; hText: HGOBJ);
VAR
	rArg:realtype;
	rTime: SINGLE;
	t1, t2: LONGINT;
	szBuf: ARRAY[0..29] OF CHAR;
        pStr: string;
        nRate: INTEGER;
	i: INTEGER;
BEGIN
	{ generate data first }
	FOR nCount := 0 TO NUMP-1 DO
	BEGIN
		rArg := M_PI * nCount;

		rVal [nCount][0] := sin (rArg / (NUMP + 10 - nCount)) ;
		rVal [nCount][1] := sin (rArg / 52.0) * (randreal) * 1.1;
		rVal [nCount][2] := cos (rArg / 60.0) * (randreal) * 0.5;
		rVal [nCount][3] := rVal[nCount][0] + 0.1;
	END;

	t1 := GetTickCount ;
	FOR i := 0 TO 1 DO
	FOR nCount := 0 TO NUMP -1  DO
	BEGIN
		WRUpdateData (thData, @rVal[nCount][0], pGrDesc);
	END;
	t2 := GetTickCount ;
	rTime := (t2 - t1) / 1000.0;
	nRate := round( NUMP  * 2.0 / rTime + 0.5);
        pStr := IntToStr(nRate);
	StrPCopy(szBuf,pStr);
	lstrcat (szBuf, ' updates / second');
	WGChangeString (pGrDesc, hText, szBuf, 0);
	WGRedrawObject (pGrDesc, hText, FALSE);
END;
{************************************************************************}

begin
 pDynGrDesc := NIL;

end.

