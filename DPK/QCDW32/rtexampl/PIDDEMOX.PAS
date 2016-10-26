{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIDDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

unit Piddemox;

interface
uses WinTypes, WinProcs, messages,qcwin,qcwrt, rthook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure  TimerRoutine;

implementation

{$R rtdemo}

const
   ncount: INTEGER = 0;
   NUMP  = 1000;
   NT   =  3;

   rPrevMeas: Realtype = 32.0;
   rPrevContrOut: Realtype = 0.0;
   rPrevOut2 : Realtype = 4.0;
   rMeas:realtype=0.0;
   rOut :realtype = 4.0;

var
tinstance: HWND;
rNewMeas:realtype;
lpButtonControlProc, lpScrollBarControlProc,
lpAlarmEvent: TFARPROC;

pDynGrDesc,pDynGrDesc2 : PGRAPH_DEF;
hMeasTags: HGLOBAL;
hScroll, hAlarms, hText,
hGridV,  hGridH: HGOBJ;
hPID: HCONT;
hMeasData,hOutData: HDATA;
hPidBar: array[0..PID_NH-1] of HGOBJ;
hSetPtScroll, hGainScroll, hIntegralScroll, hDerivScroll, hOutScroll: HGOBJ;
hGainData, hIntegralData, hDerivData: HDATA;
rPIDSetPoint, rSamplePer: Realtype;     { sample period }
pPageDesc :  PPAGE_DEF;


{ Prototypes of forward referenced functions }
{$ifndef WIN32}
procedure AlarmEvent (thdata: HDATA; nChannel,
	 nAlmCode: INTEGER; rVal: Realtype; bOn: WordBool); export; forward;
procedure  ButtonControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	 nSel, dum: INTEGER); export; forward;
function ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  var lprCurPos, lprPrevPos: Realtype): WORDBOOL; export; forward;
{$else}
procedure AlarmEvent (thdata: HDATA; nChannel,
	 nAlmCode: INTEGER; rVal: Realtype; bOn: WordBool); stdcall; forward;
procedure  ButtonControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	 nSel, dum: INTEGER); stdcall; forward;
function ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	  var lprCurPos, lprPrevPos: Realtype): WORDBOOL; stdcall; forward;
{$endif}

          procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;  { these functions must be FAR }
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure ProcessModel (rContrOut: Realtype; var prMeas: Realtype); forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
     tinstance := tinst;
		 { page is created in the current window }
      pPageDesc := WGCreatePage ('PAGE1',
      { page ID string }
        thwnd,                         { handle to the parent window }
        tInst,                        { application instance handle }
        'PID Test',                    { Window title string }
        @StartGraphs1,                 { pointer to graph creation function }
        'PageMenu',
        { Name of page window menu in resource file }
        C_LIGHTGRAY,                   { window background color }
        MM_PROPORT,                    { window sizing mode }
        0,                             { window style - default }
        PAGE_FULL,
        5, 5, 632, 420);               { initial window size and position }


END;

procedure WM_DestroyGraph;
begin
      WRDeletePID (hPID, TRUE);        { delete PID object and its data sets }

      WRCleanup (TRUE);                { clean up charting tools memory }
      { and free data arrays }
      PostQuitMessage (0);
      FreeProcInstance (lpButtonControlProc);
      FreeProcInstance (lpScrollBarControlProc);
      FreeProcInstance (lpAlarmEvent);
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
  pDynGrDesc2 := WGCreateGraph (pPageDesc,
    @DrawP1G1,                         { function which builds graph }
    0.41, 0.01, 0.99, 0.6, C_MEDGRAY, - 1, 1);
  pDynGrDesc := WGCreateGraph (pPageDesc, @DrawP1G2, 
    0.0, 0.01, 0.4, 0.6, C_BLACK, - 1, 1);
  
  pDynGrDesc := WGCreateGraph (pPageDesc, @DrawP1G3, 
    0.01, 0.61, 0.99, 0.99, C_LIGHTGRAY, - 1, 1);
  
  WGToggleSelectors (pPageDesc, FALSE);
end;

{******************************************************
	First graph - PID output
*******************************************************}
{*****************************************************}
{ Second graph := measurement and setpoint             }
{*****************************************************}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	hAxisX, hAxisY: HGOBJ;    { axis handles }
	lpMeasTags, lpOutTags: PCHAR;
	hOutTags: HGLOBAL;
	nLineColor: array[0..1] of INTEGER;
	nLineWidth: array[0..1] of INTEGER;
	nLineStyle: array[0..1] of INTEGER;
        nGridUpdate, nTraces:INTEGER;
	 rResetInt:realtype;
	 rSetp:realtype;
	 rHighRange, rLowRange:realtype;
	 rProp, rIntg, rDeriv, rMeasHigh, rMeasLow:realtype;
	 rHighLimit, rLowLimit, rSamplePer,   { 0.25 sec }
	 rSteadyState,	 rFiltConst :realtype;

begin
  nGridUpdate := 4;
  nTraces := 2;
  rHighLimit := 8.9;
  rLowLimit := 0.9;
  rSamplePer := 1.0 / 240.0;           { 0.25 sec }
  rSteadyState := 4.0;
  rFiltConst := 0.2;
  
  { allocate global array for tags }
  hMeasTags := GlobalAlloc (GHND, nTraces * TAGLEN);
  lpMeasTags := GlobalLock (hMeasTags);
  lstrcpy (lpMeasTags, 'Meas');
  lstrcpy (lpMeasTags + TAGLEN, 'Setp');

  hOutTags := GlobalAlloc (GHND, TAGLEN);
  lpOutTags := GlobalLock (hOutTags);
  lstrcpy (lpOutTags, 'Output');

  hOutData := WRDefineDynDataSet ('PID Output Data',
  { data set name }
    1,                                 { # of traces }
    'volts',                           { unit name }
    lpOutTags,                         { tag name }
    0);                                { no history buffer needed }
  
  hMeasData := WRDefineDynDataSet ('PID Input Data', nTraces,
    'degrees F', lpMeasTags, 200);

  rSetp := 66.0;
  rPIDSetPoint := rSetp;
  rProp := 0.95;
  rIntg := 3.0;
  rDeriv := 0.05;
  rMeasHigh := 120.0;
  rMeasLow := 30.0;
  rHighRange := 10.0;
  rLowRange := 0.0;

  { set alarms }
  { output alarms }
  
  WRSetAlarm (hOutData, ALM_HIGH, rHighLimit - 1.0, '*HIGH*');
  WRSetAlarm (hOutData, ALM_LOW, rLowLimit + 0.5, '*LOW*');
  WRSetAlarm (hOutData, ALM_RATE, 1.0, 'RATE');
  WRSetAlarmHyst (hOutData, 0.5, 0.0);
  
  { measurement alarms }
  WRSetAlarm (hMeasData, ALM_DEV, 8.0, 'DEVIATION');
  WRSetAlarm (hMeasData, ALM_HIGH, 95.0, 'HOT');
  WRSetAlarm (hMeasData, ALM_LOW, 45.0, 'COLD');
  
  WRSetAlarmHyst (hMeasData, 2.0, 1.0);
  

  hPID := WRDefinePID (hMeasData,      { handle to data of input values }
    hOutData,                          { handle to data of output values }
    'PID LOOP 1',                      { object title }
    rSetp,                             { set point value }
    rProp,                             { proportional gain constant }
    rIntg,                             { integral constant }
    rDeriv,                            { derivative constant }
    rSteadyState,                      { anticipated steady state }
    rMeasHigh,
    { high range of measurement AND setpoint }
    rMeasLow,                          { low range of PID output }
    rHighRange,                        { high range of PID output values }
    rLowRange,                         { low range of PID output values }
    rHighLimit,                        { upper clamping limit of PID output }
    rLowLimit,                         { lower clamping limit of PID output }
    100.0,                             { rate limit }
    rSamplePer,
    { sample period of PID update, in minutes }
    rFiltConst,                        { filtering range }
    FALSE);
    { direction of change of PID output, rel }
  { to measurement }
  GlobalFree (hMeasTags);
  GlobalFree (hOutTags);
  
  { define the plotting area of the graph }
  WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.01, 0.99, 0.99, 
    C_LIGHTGRAY, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_3DBORDER);
  WGSetPlotArea (pGrDesc, thdc, 0.17, 0.18, 0.9, 0.76, C_BLACK);
  
  { scale the plotting are for an x range of 0 to 2.0 }
  { and y range of 30 to 120 }
  WGScalePlotArea (pGrDesc, 0.0, 30.0, 2.0, 120.0);

  { set the intercepts to 0, 30 }
  WGSetXYIntercepts (pGrDesc, 0.0, 30.0);
  
  { axes to be drawn in solid, black, 1 pixels thick }
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_CYAN);
  
  { set current font to Arial, 12 points, bold }
  WGSetTextByName (C_RED, 'Arial', 7, 0);
  
  { draw the x axis with major ticks every physical coord and 0 minor tick }
  { the ticks will be positioned at the center of the axis }
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 0.5, 1, POS_MIDDLE);
  
  { draw the y axis with major ticks every 30 degrees and 2 minor ticks }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 30.0, 2, POS_LEFT);
  
  { Label the x axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, nil);

  { Label the y axis, in decimal format, 1 digit after the decimal point. }
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, nil);

  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_GRAY);
  { display horizontal and vertical dynamic grids }
  hGridV := WRDynGrid (pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
  hGridH := WRDynGrid (pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);
  
  { set current font to Arial, 12 points, bold }
  WGSetTextByName (C_RED, 'Arial', 8, TEXT_BOLD);
  
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Minutes');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Temperature');
  { assign each line style, width and color }
  nLineColor [0] := C_YELLOW;          { measurement }
  nLineStyle [0] := PS_SOLID;
  nLineWidth [0] := 2;
  
  nLineColor [1] := C_LIGHTRED;        { setpo }
  nLineStyle [1] := PS_SOLID;
  nLineWidth [1] := 2;
  
  rResetInt := 0.8;

  hScroll := WRSetScrollGraph (pGrDesc,{ pointer to graph descriptor }
    hMeasData,                         { handle to dyn data set }
    rSamplePer,                        { sample interval }
    rResetInt,                         { reset interval }
    OR_HORZ,                           { scroll lines are horizontal }
    NO_STEP,                           { linear interpolated }
    @nLineStyle,                       { line attributes }
    @nLineWidth, 
    @nLineColor);
  
  { scale the plotting area for x range of 0 to 2.0 }
  { and y range of 0 to 10 (output) }
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 2.0, 10.0);
  { set the intercepts to 2, 30 for Output axis }
  WGSetXYIntercepts (pGrDesc, 2.0, 30.0);
  
  { draw the y axis with major ticks every 30 degrees and 2 minor ticks }
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 2.5, 4, POS_RIGHT);
  WGSetTextByName (C_LIGHTCYAN, 'Arial', 7, 0);
  
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_RIGHT_PLOT, NF_DECIMAL, 1, LL_TEXT, 'OUT');
  
  nLineColor [0] := C_LIGHTGREEN;      { output }
  nLineWidth [0] := 0;
  
  WRSetScrollGraph (pGrDesc,           { pointer to graph descriptor }
    hOutData,                          { handle to dyn data set }
    rSamplePer,                        { sample interval }
    rResetInt,                         { reset interval }
    OR_HORZ,                           { scroll lines are horizontal }
    NO_STEP,                           { linear interpolated }
    @nLineStyle,                       { line attributes }
    @nLineWidth, 
    @nLineColor);
  
  lpAlarmEvent := MakeProcInstance (@AlarmEvent, tInstance);
  { set user alarm procedure }
  WRSetAlarmProc (lpAlarmEvent);

  pGrDesc^.wUserWord1 := hPID;
  { save PID handle, use in menu (pidhook.pas) }
end;

{*****************************************************************}
{ Second page := PID bargraph      }
{*****************************************************************}
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   BarColor: array [0..2] of TCOLORREF;
   rCenterPointMeas,  rCenterPointOut:realtype;
   nPrecMeas, nPrecOut:INTEGER;
begin
  { assign each bar an RGB value }
  BarColor[0] := WGGetRGBColor (C_YELLOW);
  BarColor[1] := WGGetRGBColor (C_LIGHTRED);
  BarColor[2] := WGGetRGBColor (C_LIGHTGREEN);
  
  rCenterPointMeas := 30.0;
  rCenterPointOut := 0.0;
  nPrecMeas := 2;
  nPrecOut := 1;
  
  WGSetTextParams (C_BLUE, FF_SWISS, 12, 0);
  WRSetPIDBargraph (pGrDesc,           { pointer to graph descriptor }
    hPID,                              { handle to PID object }
    rCenterPointMeas,
    { center point of measurement and setpoint bars }
    rCenterPointOut,                   { center point of output bar }
    nPrecMeas,
    { numeric precision for measurement AND setpoint }
    nPrecOut,                          { numeric precision for output }
    'NORM',                            { Normal state string }
    'Auto',                            { Auto/Manual message strings }
    'Man', 
    @BarColor,                         { Colors of the bars }
    @hPidBar);
    { array of handles to graphical objects }
end;

{*********************************************************************}
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
	lpButtonTags: LPSTR;
	hTags: HGLOBAL;
        rProp, rIntg, rDeriv:realtype;
	nTextColor:INTEGER;
begin
  WGRectangleNormEx (pGrDesc, thdc, 0.01, 0.01, 0.99, 0.99, 
    C_LIGHTGRAY, 3, FALSE, WGGetRGBColor (C_PALEBLUE), RC_3DBORDER);
  
  hTags := GlobalAlloc (GHND, 4 * TAGLEN);
  lpButtonTags := GlobalLock (hTags);
  
  lstrcpy (lpButtonTags, '1');
  lstrcpy (lpButtonTags + TAGLEN, '2');
  lstrcpy (lpButtonTags + 2 * TAGLEN, '3');
  lstrcpy (lpButtonTags + 3 * TAGLEN, '4');
  
  lpButtonControlProc := MakeProcInstance (@ButtonControlProc, tInstance);
  
  WGRectangleNormEx (pGrDesc, thdc, 0.04, 0.04, 0.35, 0.43,
    C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
  WGSetTextByName (C_BLACK, 'Arial', 6, 0);
  WGTextNorm (pGrDesc, thdc, 'Source', 0.17, 0.15, TA_CENTER or TA_BASELINE, TEXT_NORMAL);
  WRSetButtonGroup (pGrDesc, lpButtonControlProc, BC_LOOK_RADIO, 0.05, 0.2, 0.34, 0.4, 
    WGGetRGBColor (C_LIGHTGRAY), 4, OR_HORZ, lpButtonTags, FALSE);
  
  lstrcpy (lpButtonTags , 'Auto');
  lstrcpy (lpButtonTags + TAGLEN, 'Manual');
  WGRectangleNormEx (pGrDesc, thdc, 0.04, 0.5, 0.35, 0.9, 
    C_WHITE, 5, FALSE, WGGetRGBColor (C_LIGHTGRAY), RC_SHALLOW);
  WGSetTextByName (C_BLACK, 'Arial', 6, TEXT_BOLD);
  WGTextNorm (pGrDesc, thdc, 'Mode', 0.17, 0.6, TA_CENTER or TA_BASELINE, TEXT_NORMAL);
  WGSetTextByName (C_WHITE, 'Arial', 8, TEXT_BOLD);
  WRSetButtonGroup (pGrDesc, lpButtonControlProc, BC_LOOK_HIGH, 0.05, 0.63, 0.34, 0.85,
    WGGetRGBColor (C_LIGHTRED), 2, OR_HORZ, lpButtonTags, FALSE);
  
  WGSetTextByName (C_BLACK, 'Arial', 6, TEXT_BOLD);
  WGTextNorm (pGrDesc, thdc, 'PID Parameters', 0.62, 0.15, 
    TA_CENTER or TA_BOTTOM, TEXT_NORMAL);
  
  lpScrollBarControlProc := MakeProcInstance (@ScBarControlProc, tInstance);
  hSetPtScroll := WRSetScrBarControl (pGrDesc,
    lpScrollBarControlProc, 0.5, 0.19, 0.85, 0.30, 
    RGB (255, 0, 0), 30.0, 120.0, 1.0, 10.0, rPIDSetPoint);
  nTextColor := C_RED;
  WRSetDynText (pGrDesc,               { pointer to graph descriptor }
    hMeasData, 1, 0.87, 0.19, 0.93, 0.32,
    { chan 1 := setpoint }
    - 1, 0, @nTextColor, C_LIGHTGRAY, OR_HORZ, 4, 2, NULLH, RC_FLAT);
  WGTextNorm (pGrDesc, thdc, 'Setpoint', 0.48, 0.28, 
    TA_RIGHT or TA_BOTTOM, TEXT_NORMAL);
  
  WRGetPIDConstants (hPID, rProp, rIntg, rDeriv);

  hGainScroll := WRSetScrBarControl (pGrDesc, 
    lpScrollBarControlProc, 0.5, 0.33, 0.85, 0.44,
    RGB (0, 0, 255), 0.8, 1.3, 0.01, 0.05, rProp);
  hGainData := WRDefineDynDataSet ('Gain', 1, nil, nil, 0);
  nTextColor := C_BLACK;
  WRSetDynText (pGrDesc,               { pointer to graph descriptor }
    hGainData, 0, 0.87, 0.33, 0.93, 0.44, 
    - 1, 0, @nTextColor, C_LIGHTGRAY, OR_HORZ, 
    4, 2, NULLH, RC_FLAT);
  WGTextNorm (pGrDesc, thdc, 'Gain', 0.48, 0.42, 
    TA_RIGHT or TA_BOTTOM, TEXT_NORMAL);
  { Scroll bar for Integral }
  hIntegralScroll := WRSetScrBarControl (pGrDesc, 
    lpScrollBarControlProc, 0.5, 0.47, 0.85, 0.58,
    RGB (0, 0, 255), 0.0, 6.0, 0.1, 1.0, rIntg);
  hIntegralData := WRDefineDynDataSet ('Integral', 1, nil, nil, 0);
  WRSetDynText (pGrDesc,               { pointer to graph descriptor }
    hIntegralData, 0, 0.87, 0.47, 0.93, 0.58, 
    - 1, 0, @nTextColor, C_LIGHTGRAY, OR_HORZ, 4, 2, NULLH, RC_FLAT);
  WGTextNorm (pGrDesc, thdc, 'Integral', 0.48, 0.56, 
    TA_RIGHT or TA_BOTTOM, TEXT_NORMAL);
  
  { Scroll bar for Derivative }
  hDerivScroll := WRSetScrBarControl (pGrDesc,
    lpScrollBarControlProc, 0.5, 0.61, 0.85, 0.72, 
    RGB (0, 0, 255), 0.0, 0.4, 0.01, 0.05, rDeriv);
  hDerivData := WRDefineDynDataSet ('Derivative', 1, nil, nil, 0);
  WRSetDynText (pGrDesc,               { pointer to graph descriptor }
    hDerivData, 0, 0.87, 0.61, 0.93, 0.72, 
    - 1, 0, @nTextColor, C_LIGHTGRAY, OR_HORZ, 4, 2, NULLH, RC_FLAT);
  WGTextNorm (pGrDesc, thdc, 'Derivative', 0.48, 0.7, 
    TA_RIGHT or TA_BOTTOM, TEXT_NORMAL);
  
  { Scroll bar for Output }
  hOutScroll := WRSetScrBarControl (pGrDesc,
    lpScrollBarControlProc, 0.5, 0.75, 0.85, 0.86,
    RGB (0, 255, 0), 0.0, 10.0, 0.1, 02.0, 0.0);
  WRSetDynText (pGrDesc,               { pointer to graph descriptor }
    hOutData, 0, 0.87, 0.75, 0.93, 0.86, 
    - 1, 0, @nTextColor, C_LIGHTGRAY, OR_HORZ, 4, 2, NULLH, RC_FLAT);
  WGTextNorm (pGrDesc, thdc, 'Output', 0.48, 0.84, 
    TA_RIGHT or TA_BOTTOM, TEXT_NORMAL);
  
  WRUpdateData (hGainData, @rProp, pGrDesc);
  WRUpdateData (hIntegralData, @rIntg, pGrDesc);
  WRUpdateData (hDerivData, @rDeriv, pGrDesc);

  GlobalFree (hTags);
end;
{****************************************************************}

procedure  ButtonControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ;
	   nSel, dum: INTEGER);
var
         rOut, dummy:realtype;
begin
  if nSel = 0 then                     { Auto pressed }
    WRChangePIDAutoState (hPID, TRUE)
  else begin                           { Manual pressed }
    WRChangePIDAutoState (hPID, FALSE);
    { adjust position of output scroll bar }
    WRGetLastData (hOutData, @rOut, @dummy);
    WRSetScrollPos (pGrDesc, hOutScroll, rOut);
  end;
end;

{****************************************************************}

function ScBarControlProc (pGrDesc: PGRAPH_DEF; hCtl: HGOBJ; 
	 var lprCurPos, lprPrevPos: Realtype): WORDBOOL;
var
	 rProp, rIntg, rDeriv, rOut:realtype;
begin
  if hCtl = hSetPtScroll then begin
    rPIDSetPoint := lprCurPos;
    WRChangePIDSetp (hPID, rPIDSetPoint);
  end
  else
    if hCtl = hOutScroll then begin
      if not WRGetPIDAutoState (hPID) then begin
      { is PID in manual? }
        rOut := lprCurPos;
        WRChangePIDOut (hPID, rOut);
      end
      else
        ScBarControlProc := FALSE;
      exit;
    end
  else begin
    WRGetPIDConstants (hPID, rProp, rIntg, rDeriv);
    if hCtl = hGainScroll then begin
      rProp := lprCurPos;
      WRUpdateData (hGainData, @rProp, pGrDesc);
    end
    else
      if hCtl = hIntegralScroll then begin
        rIntg := lprCurPos;
        WRUpdateData (hIntegralData, @rIntg, pGrDesc);
      end
    else
      if hCtl = hDerivScroll then begin
        rDeriv := lprCurPos;
        WRUpdateData (hDerivData, @rDeriv, pGrDesc);
      end;
    WRChangePIDConstants (hPID, rProp, rIntg, rDeriv);
  end;
  ScBarControlProc := TRUE;
end;

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

{************************************************************************}
{ Alarm Event procedure *************************************************}
{************************************************************************}
procedure  AlarmEvent (thdata: HDATA; nChannel, nAlmCode: INTEGER; 
                        rVal: Realtype; bOn: WORDBOOL);
begin
  { user processing  }
end;
{************************************************************************}

procedure  TimerRoutine;
begin
  { Do not forget to initialize the DLL every time the timer is called NOT  }
  { Otherwise the DLL will not know who is calling it. }
  { Necessary only if multiple RT Tools applications or multiple }
  { instances of the same application can run simultaneously. }
  
  if not (WGIsGraphDescValid (pDynGrDesc)) and
      not (WGIsGraphDescValid (pDynGrDesc2)) then
    exit;
  WGStart ;

  { simulate measurement }
  ProcessModel (rOut, rMeas);
  
  WRCalcPID (hPID,                     { handle to PID object }
    rMeas,
    { current measured value (calculated above) }
    rOut);                             { returns new output value }
end;


{************************************************************************}
procedure ProcessModel (rContrOut: Realtype; var prMeas: Realtype);
begin
  rNewMeas := rPrevMeas + (rPrevContrOut - 4.0) / 20.0 +
    (rPrevOut2 - 4.0) / 8.0 + (0.5 - random)/20.0;
  rPrevMeas := rNewMeas;
  rPrevOut2 := rPrevContrOut;
  rPrevContrOut := rContrOut;
  prMeas := rNewMeas;
end;
{************************************************************************}

begin
  pDynGrDesc := nil;                   { Graph descriptors }
  pDynGrDesc2 := nil;                  { Graph descriptors }
  pPageDesc := nil;

end.
