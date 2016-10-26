{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCROLLGX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{$F+,K+}
unit scvardex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
procedure MM_About (thwnd:HWND; tinst:THANDLE);
procedure WM_DestroyGraph;
procedure  TimerRoutine;

implementation
{$R rtdemo}
const
  ncount: INTEGER = 0;
  nTraces: INTEGER = 4;


var
  hScroll, hScroll2: HGOBJ; { handles to the scrolling graph objects }
  thData: HDATA; { handles to the dynamic data sets }

pDynGrDesc,	 { Graph descriptors }
pDynGrDesc2: PGRAPH_DEF;
pPageDesc1 :  PPAGE_DEF;

{ Prototypes of forward referenced functions }
{$ifndef WIN32}
function  AboutProc (hDlg:HWND; message:UINT; wParam:UINT;
                     lParam:LONGINT):BOOL;export; forward;
{$else}
function  AboutProc (hDlg:HWND; message:UINT; wParam:UINT;
                     lParam:LONGINT):BOOL;stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF); forward;
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);  forward;
procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC);  forward;

procedure MM_CreateGraph (thwnd:HWND; tinst:THANDLE);
begin
  { page is created in the current window }
  pPageDesc1:=
    WGCreatePage ('PAGE1',  { page ID string }
    thwnd,                  { handle to the parent window }
    tInst,                  { application instance handle }
    'Simulator',            { Window title string }
    @StartGraphs1,          { pointer to graph creation function }
    '',                     { no menu }
    C_LIGHTGRAY,            { window background color }
    MM_ISOTR,               { window sizing mode }
    WS_CHILD or WS_CLIPCHILDREN or WS_VISIBLE,
    { window style }
    PAGE_CLIENT,
    0, 0, 0, 0);            { initial window size and position }
  { if used (not used here) }

end;

procedure WM_DestroyGraph;
begin
  WRCleanup (TRUE);   { clean up charting tools memory }
  PostQuitMessage (0);
end;

procedure MM_About (thwnd:HWND; tinst:THANDLE);
var  lpProcAbout: TFarProc;
begin
  lpProcAbout:= MakeProcInstance (@AboutProc, tinst);
  DialogBox (tInst,    {  current instance   }
    'AboutBox',        {  resource to use       }
    thwnd,             {  parent window handle  }
    lpProcAbout);      {  AboutProc() instance address  }
  FreeProcInstance (lpProcAbout);
end;

{***********************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**************************************************************}

procedure StartGraphs1 (pPageDesc:PPAGE_DEF);
begin

  { Define the dynamic data set }
  thData:= WRDefineDynDataSet ('Scroll 1',
  { data set name }
    nTraces+1,     { # of traces }
    'volts',     { unit string }
    '',          { no tag names }
    0);


  { Initialize graphs }
  pDynGrDesc:=
    WGCreateGraph (pPageDesc,
    @DrawP1G1,    { function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.49, 0.995,
    C_LIGHTGRAY,  { light gray background }
    C_WHITE,      { white border }
    1);           { border width in pixels }

  pDynGrDesc2:= WGCreateGraph (pPageDesc, @DrawP1G2,
    0.5, 0.005, 0.99, 0.995,
    C_LIGHTBLUE, C_BLACK, 2);

end;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}
procedure DrawP1G1 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hAxisX, hAxisY: HGOBJ;    { axis handles }
  hTimeLabX : HGOBJ; { time axis label}
  hTags: HGLOBAL;
	lpTags: LPSTR;
	nLineColor: array[0..3] of INTEGER;
	nLineWidth: array[0..3] of INTEGER;
	nLineStyle: array[0..3] of INTEGER;
	i, nGridUpdate: INTEGER;
        rHigh, rLow, rSetpoint: realtype;
begin
  nGridUpdate:= 5;
  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.18, 0.15, 0.92, 0.65, C_BLACK);
  { scale the plotting area for an x range of 0 to 1.0 }
  { and y range of -2.0 to 2.5 }
  WGScalePlotArea (pGrDesc, 0.0, -2.0, 20.0, 2.5);
  { set the intercepts to 0.0, -2.0 }
  WGSetXYIntercepts (pGrDesc, 0.0, -2.0);
  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  { set current font to Arial, 7 points }
  WGSetTextByName (C_RED, 'Arial', 10, 0);
  {time axis}
  hAxisX := WRDrawTimeAxis (pGrDesc, 5.0, 4, POS_MIDDLE, OR_HORZ, AXU_SEC);
  { Label the horizontal time axis}
  hTimeLabX := WRLabelTimeAxis (pGrDesc,
  		hAxisX,	 	{ time axis handle}
  		POS_BELOW,	{ label position}
  		DLB_MS,	  	{ label format MM:SS}
  		0,	  	{ does not apply to this label format}
  		0,	  	{ does not apply to this label format }
  		0,	  	{ # minutes for first tick label }
  		0,	  	{ # seconds for first tick label }
  		0,	  	{ does not apply to this label format }
  		LL_ON,	  	{ display last label }
  		NIL);	  	{ this parameter is ignored since LL_ON}



  { draw the y axis with major ticks every physical unit and 1 minor ticks }
  hAxisY:= WGDrawYAxis (pGrDesc, thdc, 1.0, 1, POS_LEFT);

  WGSetTextByName (C_RED, 'Arial', 8, TEXT_ITAL);
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);

  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_LIGHTCYAN);
  { set current font to Arial, 8 points }
  WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);
  { Write axes titles }
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Minutes');
  WGTextNorm (pGrDesc, thdc, 'Volts', 0.1, 0.35,
    TA_CENTER or TA_BOTTOM, TEXT_VERTLEFT);
  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_GREEN, 'Arial', 10, TEXT_BOLD or TEXT_ITAL);
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Horizontal Strip Chart');
  { SET UP DYNAMIC PORTION OF GRAPH }
  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  { Assign each line width and color for the scroll graph }
  for i:= 0 to nTraces - 1 do begin
    nLineWidth [i]:= 2;
    nLineStyle[i]:= PS_SOLID;
  end;
  nLineColor [0]:= C_LIGHTGREEN;
  nLineColor [1]:= C_CYAN;
  nLineColor [2]:= C_BLUE;
  nLineColor [3]:= C_LIGHTRED;

  { create variable scrolling graph  }
  hScroll := WRSetVarScroll (pGrDesc,
		thData,       { handle to dynamic data set }
                0.8,         { relative reset }
                OR_HORZ,     { scroll direction is horizontal }
                NO_STEP,     { style - linear interp }
                @nLineStyle,
                @nLineWidth,
                @nLineColor);



end;

{************************************************************}
procedure DrawP1G2 (pGrDesc:PGRAPH_DEF; thdc:HDC);
var
  hTags: HGLOBAL;
  lpTags: LPSTR;
  hAxisX, hAxisY: HGOBJ;  { axes handles }
  nTraces :INTEGER;
  nLineColor: array[0..3] of INTEGER;
  nLineStyle: array[0..3] of INTEGER;
  nLineWidth: array[0..3] of INTEGER;
  i, nGridUpdate:INTEGER;
  rHigh, rLow, rSetpoint:realtype;
begin
  nTraces:= 4;
  nGridUpdate:= 1;

  { Define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.14, 0.15, 0.85, 0.7, C_WHITE);
  { Scale the plotting are for an x range of -2.0 to 2.5 }
  { and y range of -5.0 to 5.0 }
  WGScalePlotArea (pGrDesc, -2.0, -5.0, 2.5, 5.0);
  { Set the intercepts to -2, 0 }
  WGSetXYIntercepts (pGrDesc, -2.0, -5.0);
  { Axes to be drawn in solid, cyan, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 8, 0);
  { Draw the x axis with major ticks every physical coord and 1 minor tick }
  hAxisX:= WGDrawXAxis (pGrDesc, thdc, 1.0, 1, POS_MIDDLE);
  { Draw the y axis with major ticks every 0.1 physical coords and no minor ticks }
  hAxisY:= WGDrawYAxis (pGrDesc, thdc, 2.0, 0, POS_LEFT);
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);
  { Set current font to Arial, 8 points }
  WGSetTextByName (C_WHITE, 'Arial', 8, TEXT_BOLD);
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Vertical Strip Chart');
  { Set the line style for the dynamic grid }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_BLACK);
  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every second. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);


  { Assign each line style, width and color }
  for i:= 0 to nTraces - 1 do begin
    nLineStyle [i]:= PS_SOLID;
    nLineWidth [i]:= 1;
  end;
  nLineWidth [0]:= 2;
  nLineColor [0]:= C_GREEN;
  nLineColor [1]:= C_MAGENTA;
  nLineColor [2]:= C_BLUE;
  nLineColor [3]:= C_LIGHTRED;

  { Create a variable scroll graph }
   hScroll := WRSetVarScroll (pGrDesc,
		thData, 0.8, OR_VERT, STEP_END,
                Nil, Nil, @nLineColor);

end;


{*************************************************************}

{**********************************************************
    FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)
    PURPOSE:  Processes messages for 'About' dialog box
***********************************************************}

function  AboutProc (hDlg:HWND; message:UINT;
                     wParam:UINT; lParam:LONGINT):BOOL;
begin
  case (message) of
    WM_INITDIALOG: begin
      AboutProc:= TRUE;
      exit;
    end;

    WM_COMMAND: begin
      if ((wParam = IDOK)  or (wParam = IDCANCEL)) then begin
        EndDialog (hDlg, 1);
        AboutProc:= TRUE;
        exit;
      end;
    end;
  end;
  AboutProc:= FALSE;
end;


{***********************************************************}
procedure  TimerRoutine;
var
	 rArg:realtype;
	 rNewVals: array[0..4] of realtype;
         rMin, rMax:realtype;
	 i:INTEGER;
begin

  WGStart ;
  if (not (WGIsGraphDescValid (pDynGrDesc))) then
    exit ;

  rArg:= PI * nCount;
  { simulate data }
  rNewVals [0]:= sin (rArg / 20.0) * 1.1;
  rNewVals [1]:= 1.6 * sin (rArg / 7) * (random) * 1.4;
  rNewVals [2]:= -0.05 - cos (rArg / 6.0);
  rNewVals [3]:= -0.3 + cos (rArg / 5.0) + rNewVals[2] * 0.7;

  if (nCount mod 40 = 0) then
     rNewVals[4] := 8.6
  else
      rNewVals[4] := 0.05 + 0.04 * (nCount mod 9);
  nCount:= nCount + 1;
  if (nCount > 1000) then
     nCount := 0;

  { Update the data set }
  WRUpdateData (thdata, @rNewVals, nil);

end;

begin
  pDynGrDesc:= nil;
  pDynGrDesc2:= nil;
  pPageDesc1:= nil;
end.

