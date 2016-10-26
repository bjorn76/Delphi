{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SWEEPDEX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{$F+,K+}
unit Sweepdex;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure  TimerRoutine;

implementation

{$R rtdemo}


const
 NT =	4;   { number od traces }
 ncount: INTEGER = 0;

var

pDynGrDesc,		{ Graph descriptors }
pDynGrDesc2,
pDynGrDesc3 ,
pDynGrDesc4 : PGRAPH_DEF;
thdata: HDATA;
pPageDesc1 :  PPAGE_DEF;

{$ifndef WIN32}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function  AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
      pPageDesc1 := WGCreatePage ('PAGE1',
      { page ID string }
        thwnd,                         { handle to the parent window }
        tInst,                        { application instance handle }
        'Sweep Graph',                 { Page window title  }
        @StartGraphs1,                 { pointer to graph creation function }
        'PageMenu',
        { Name of page window menu in resource file }
        C_GREEN,                       { page window background color }
        MM_PROPORT,                    { window sizing mode }
        0,                             { default window style }
        PAGE_FULL,                     { fill parent window }
        0, 0, 0, 0);
      
END;

procedure WM_DestroyGraph;
begin
      WRCleanup (TRUE);                { clean up charting tools memory }
      { and free data arrays }
      PostQuitMessage (0);
end;

{*********************************************************************
	Routine StartGraphs1 is called by the Quinn-Curtis
	Windows Charting Tools when a page is created.
	It must be filled by the user, normally with
	functions WGCreateGraph that initialize individual graphs.
**********************************************************************}

procedure StartGraphs1 (pPageDesc: PPAGE_DEF);
begin
  { Initialize graphs }
  pDynGrDesc := WGCreateGraph (pPageDesc, 
    @DrawP1G1,                         { function which builds graph }
    0.005, 0.005,
    { window relative position inside parent page window }
    0.49, 0.49, 
    C_RED,                             { red background }
    - 1,                               { no border }
    1);

  pDynGrDesc2 := WGCreateGraph (pPageDesc, @DrawP1G2, 
    0.5, 0.005, 0.99, 0.49, 
    C_BLUE, C_BLACK, 2);               { Light blue background, black border }
  
  pDynGrDesc3 := WGCreateGraph (pPageDesc, @DrawP1G3, 
    0.005, 0.5, 0.49, 0.99,
    C_GRAY, - 1, 0);                   { gray background, no border }
  
  pDynGrDesc4 := WGCreateGraph (pPageDesc, @DrawP1G4, 
    0.5, 0.5, 0.99, 0.99, 
    C_GRAY, - 1, 0);                   { gray background, no border }
end;

{******************************************************
	Builds the graph using Q-C Windows Charting Calls
*******************************************************}

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	 rSampleInt:realtype;
	 nLineColor: array[0..NT-1] of INTEGER;
	 nTraces : INTEGER;
	 i,nGridUpdate: INTEGER;
         hScr: array[0..AS_NH-1] of HGOBJ;

begin
  nTraces := NT;
  nGridUpdate := 4;
  
  thData := WRDefineDynDataSet ('Sweep',
  { data set name }
    nTraces,                           { # of traces }
    'volts',                           { units string }
    NULLS,                             { no channel tag names }
    0);                                { no history buffer }
  
  WGRaiseGraph (pGrDesc, RC_HIGH);
  
  { define font family  }
  WGSetTextParams (C_BLUE, FF_SWISS, 10, TEXT_BOLD);
  
  rSampleInt := 0.25;
  for i := 0 to nTraces - 1 do begin
    nLineColor[i] := C_YELLOW - i;
  end;
  
  WRSetAutoScrollGraph (pGrDesc, thdata, 
    rSampleInt,                        { sample interval }
    0.0,                               { ignored for sweep graph }
    - 2.0, 2.0,
    { min and max values of dependent variable }
    10.0,                              { range of independent variable }
    GOD_SUBT_SWLINE,                   { sweep graph subtype }
    0,                                 { ignored }
    0.0,                               { setp }
    0.0,
    { high alarm limit := low alarm limit, no alarm lines  }
    0.0, 
    'Sweeps left to right', 
    C_BLACK,                           { plotting area color }
    @nLineColor, 
    FALSE,                             { no dynamic text }
    @hScr);
  
  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 0, C_LIGHTCYAN);
  { Display dynamic grids at the major tick marks for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hScr[ASH_XAX], GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hScr[ASH_YAX], GRID_MAJOR, nGridUpdate);
end;

{******************************************************* }

procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var

	 rSampleInt:realtype;
	 nDir, nStep, i:INTEGER;
	 nSweepLineColor:INTEGER;
	 nLineStyle, nLineWidth, nLineColor: array[0..NT-1] of INTEGER;

	 hAxisX, hAxisY: HGOBJ;  { axes handles }
	 nTraces :INTEGER;
	 nGridUpdate : INTEGER;       { dynamic grids update period }
begin
  nTraces := NT;
  nGridUpdate := 3;
  WGRaiseGraph (pGrDesc, RC_HIGH);

  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_GRAY);
  
  { scale the plotting area for an x range of 20 to 0.0 (reverse) }
  { and y range of -2.0 to 2.0 }
  WGScalePlotArea (pGrDesc, 20.0, - 2.0, 0.0, 2.0);
  
  { set the intercepts to 20.0, -2.0 }
  WGSetXYIntercepts (pGrDesc, 20.0, - 2.0);
  
  { axes to be drawn in solid, yellow, 2 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_YELLOW);

  { set current font to Arial, 8 points }
  WGSetTextByName (C_CYAN, 'Arial', 8, 0);
  
  { draw the x axis with major ticks every 5 physical units and 5 minor ticks }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 5.0, 5, POS_MIDDLE);

  { draw the y axis with major ticks every physical unit and 1 minor tick }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 1.0, 1, POS_LEFT);
  
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);

  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);
  
  { choose bold text }
  WGSetTextByName (C_CYAN, 'Arial', 9, TEXT_BOLD);
  
  { Write axes titles }
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sweeps right to left');
  
  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_CYAN, 'Arial', 10, TEXT_BOLD or TEXT_ITAL);

  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Horizontal Sweep Chart');
  
  { SET UP DYNAMIC PORTION OF GRAPH }

  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_DASH, 1, C_LIGHTCYAN);
  
  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  
  rSampleInt := 0.250;
  nDir := OR_HORZ;
  nStep := NO_STEP;
  nSweepLineColor := C_LIGHTRED;
  for i := 0 to nTraces - 1 do begin
    nLineStyle[i] := PS_SOLID;
    nLineWidth[i] := 2;
  end;
  nLineColor[0] := C_YELLOW;
  nLineColor[1] := C_LIGHTMAGENTA;
  nLineColor[2] := C_LIGHTGREEN;
  nLineColor[3] := C_LIGHTCYAN;

  WRSetSweepGraph (pGrDesc, thdata, rSampleInt, nDir, nStep, nSweepLineColor, 
    @nLineStyle, @nLineWidth, @nLineColor);
end;
{*************************************************************************}

procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	 hAxisX, hAxisY: HGOBJ;  { axes handles }
	 rSampleInt:realtype;
 	 nDir, nStep:INTEGER;
 	 nSweepLineColor:INTEGER;
 	 nLineStyle, nLineWidth, nLineColor: array[0..NT-1] of INTEGER;
         nTraces, i:INTEGER;
 	 nGridUpdate: INTEGER;
begin
  nGridUpdate := 2;
  nTraces := NT;
  WGRaiseGraph (pGrDesc, RC_HIGH);
  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_LIGHTGRAY);

  { scale the plotting area }
  WGScalePlotArea (pGrDesc, - 2.0, 0.0, 2.0, 10.0);
  
  { set the intercepts to -2.0, 0.0 }
  WGSetXYIntercepts (pGrDesc, - 2.0, 0.0);
  
  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  { set current font to Arial, 8 points }
  WGSetTextByName (C_YELLOW, 'Arial', 8, 0);

  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1.0, 0, POS_MIDDLE);
  
  { draw the y axis with major ticks every physical unit and 1 minor tick }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 1.0, 1, POS_LEFT);
  
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);
  
  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);
  
  { set current font to Arial, 8 points }
  WGSetTextByName (C_BLUE, 'Arial', 8, TEXT_BOLD);
  
  { Write axis title }
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sweeps bottom to top');
  
  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_YELLOW, 'Arial', 10, TEXT_BOLD or TEXT_ITAL);
  
  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Vertical Sweep Chart');
  
  { SET UP DYNAMIC PORTION OF GRAPH }
  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_BLACK);
  
  { Display a dynamic grid at the major ticks for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

  rSampleInt := 0.250;
  nDir := OR_VERT;
  nStep := NO_STEP;
  nSweepLineColor := C_BLUE;

  for i := 0 to nTraces - 1 do begin
    nLineStyle[i] := PS_SOLID;
    nLineWidth[i] := 1;
  end;
  nLineColor[0] := C_YELLOW;
  nLineColor[1] := C_MAGENTA;
  nLineColor[2] := C_BLUE;
  nLineColor[3] := C_RED;

  WRSetSweepGraph (pGrDesc, thdata, rSampleInt, nDir, nStep, nSweepLineColor,
    @nLineStyle, @nLineWidth, @nLineColor);
end;

{*****************************************************************************}

procedure DrawP1G4 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    rSampleInt:realtype;
    nDir, nStep, i:INTEGER;
    nSweepLineColor:INTEGER;
    nLineStyle, nLineWidth, nLineColor: array[0..NT-1] of INTEGER;
    hAxisX, hAxisY: HGOBJ;  { axes handles }
    nTraces:INTEGER;
    nGridUpdate: INTEGER;
begin
  nTraces := NT;
  nGridUpdate := 4;
  WGRaiseGraph (pGrDesc, RC_HIGH);
  { define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.2, 0.18, 0.95, 0.82, C_WHITE);

  { scale the plotting area  }
  WGScalePlotArea (pGrDesc, - 2.0, 20.0, 2.0, 0.0);

  { set the intercepts to -2.0, 20.0 }
  WGSetXYIntercepts (pGrDesc, - 2.0, 20.0);

  { axes to be drawn in solid, blue, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLUE);

  { set current font to Arial, 8 points }
  WGSetTextByName (C_BLACK, 'Arial', 8, 0);

  hAxisX := WGDrawXAxis (pGrDesc, thdc, 1.0, 1, POS_MIDDLE);

  { draw the y axis with major ticks every 5 physical units and 5 minor ticks }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 5.0, 5, POS_LEFT);

  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);

  WGSetTextParams (C_BLACK, FF_ROMAN, 8, TEXT_ITAL);

  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);

  { Set the line style for the dynamic grids }
  WGSetLineStyle (pGrDesc, thdc, PS_DOT, 1, C_LIGHTBLUE);

  { Write axis title }
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sweeps top to bottom');

  { set current font to Arial, 10 points, bold, italic }
  WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD or TEXT_ITAL);

  { Write graph title }
  WGTitleGraph (pGrDesc, thdc, 'Vertical Sweep Chart');

  { SET UP DYNAMIC PORTION OF GRAPH }

  { Display a dynamic grid at the major tick interval for both }
  { x and y axes, updating the grid every 4 seconds. }
  WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

  rSampleInt := 0.250;
  nDir := OR_VERT;
  nStep := NO_STEP;
  nSweepLineColor := C_BLACK;
  for i := 0 to nTraces - 1 do begin
    nLineStyle[i] := PS_SOLID;
    nLineWidth[i] := 2;
  end;
  nLineColor[0] := C_BLUE;
  nLineColor[1] := C_MAGENTA;
  nLineColor[2] := C_GREEN;
  nLineColor[3] := C_CYAN;

  WRSetSweepGraph (pGrDesc, thdata, rSampleInt, nDir, nStep, nSweepLineColor,
    @nLineStyle, @nLineWidth, @nLineColor);
end;




{************************************************************************}

{************************************************************************}
procedure  TimerRoutine;
var
   rNewVals: array[0..NT-1] of realtype;
   rcount: realtype;
begin
  { check if graph exists }
  if not (WGIsGraphDescValid (pDynGrDesc)) then
    exit ;

  { Initialize the DLL every time the timer is called NOT  }
  { Otherwise the DLL will not know who is calling it. }
  { Necessary only if multiple RT Tools applications or multiple  }
  { instances of the same application can run simultaneously. }
  rcount := ncount;
  WGStart ;
  { simulate data }
  rNewVals[0] := sin (M_PI * rCount / (1025 - rCount)) ;
  rNewVals[1] := sin (M_PI * rCount / 52.0) * cos (rCount) * 1.1;
  rNewVals[2] := sin (M_PI * rCount / 100.0) * cos (random);
  rNewVals[3] := sin (M_PI * rCount / 26.0) * cos (rCount * rCount) * 1.1;
  nCount := nCount + 1;
  if nCount > 1000 then
    nCount := 0;

  { Update the data set and all dynamic objects using it in all graphs }
  WRUpdateData (thdata, @rNewVals, nil);
end;

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


begin
 pDynGrDesc := nil;                   { Graph descriptors }
 pDynGrDesc2 := nil;
 pDynGrDesc3 := nil;
 pPageDesc1 := nil;
end.
