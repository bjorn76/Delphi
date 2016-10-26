{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FFTDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{
    This program creates two pages of FFT related graphs.

 }

unit Fftdemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure MM_About(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;

implementation

{$R demo}


const
 NUMPFFT= 1024;                { number of points for FFT - LONGINT constant}
 MAXTIME: Realtype= 100.0;     {  total time in milliseconds}
 szAppName:PCHAR = 'FFTDemo';  {  Class Name used in call to CreateWindow.  }

var
  hSignal, hFFTCos, hFFTSin, hPower, hRestored,
  hTime, hFreq, hPowFreq: HGLOBAL;
  pSignal, pFFTCos, pFFTSin, pTime, pFreq, pPower, pRestored, pPowFreq: LPREAL;


{  Prototypes of forward referenced functions}
{$ifndef WIN32}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; export; forward;
{$else}
function AboutProc (hDlg: HWND; message: UINT; wParam: UINT; lParam: LONGINT):BOOL; stdcall; forward;
{$endif}

procedure StartPage1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure StartPage2 (pPageDesc: PPAGE_DEF); far; forward;
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
procedure DrawP2G2 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;


procedure MM_CreateGraph(thwnd: HWND; tinst: THANDLE);
BEGIN
		 { page is created in the current window }
          WGCreatePage ('PAGE1',       {  page ID string}
            thwnd,                     {  handle to the parent window}
            tInst,                     {  application instance handle }
            'DIRECT FFT',              {  Window title string }
            @StartPage1,               {  pointer to graph creation function}
            'PageMenu',                {  Name of page window menu in resource file}
            C_LIGHTGRAY,               {  window background color}
            MM_PROPORT,                {  window sizing mode}
            0,                         {  window style - default}
            PAGE_FULL  ,               {  page will fill the whole screen}
            0, 0, 0, 0);

          WGCreatePage ('PAGE2', thwnd, tInst, 'REVERSED FFT',
            @StartPage2,
            'PageMenu',
            C_BROWN, MM_PROPORT, 0, PAGE_EXACT, 20, 100, 520, 430);
  END;

procedure WM_DestroyGraph;
begin
      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure MM_About(thwnd: HWND; tinst: THANDLE);
var lpProcAbout: TFARPROC;
begin
    lpProcAbout := MakeProcInstance (@AboutProc, tInst);
    DialogBox (tInst,            {  current instance   }
            'AboutBox',                {  resource to use       }
            thwnd,                     {  parent window handle  }
            lpProcAbout);              {  AboutProc() instance address  }
    FreeProcInstance (lpProcAbout);

end;

{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when page 1 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
   In this  it also contains signal simulation calculations.
********************************************************************** }
const
   fInit:  BOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
     i: LONGINT;
     pf,interval, time: Realtype;
begin
  {  create simulation data}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}

    hSignal := GlobalAlloc (GHND, sizeof (realtype) * NUMPFFT);
    hTime := GlobalAlloc (GHND, sizeof (realtype) * NUMPFFT);
    hFreq := GlobalAlloc (GHND, sizeof (realtype) * NUMPFFT);
    hFFTSin := GlobalAlloc (GHND, sizeof (realtype) * NUMPFFT);
    hPowFreq := GlobalAlloc (GHND, sizeof (realtype) * NUMPFFT);
    
    {  get pointers to arrays}
    
    pSignal := GlobalLock (hSignal);
    pTime := GlobalLock (hTime) ;
    pFreq := GlobalLock (hFreq) ;
    pFFTSin := GlobalLock (hFFTSin);
    pPowFreq := GlobalLock (hPowFreq);
    
    {  sampling interval}
    interval := MAXTIME / NUMPFFT;
    
    {  simulate signal}
    for i := 0 to  NUMPFFT - 1 do begin
      WGPutPntrReal (pTime , i, i * interval);
      time := i * interval;
      {  simulate four 5ms pulses }
      
      if (time > 10.0)  and (time < 13.0) then
        WGPutPntrReal (pSignal, i, 10.0)
      else
        if (time > 25.0)  and (time < 28.0) then
          WGPutPntrReal (pSignal, i, - 10.0)
      else
        if (time > 40.0)  and (time < 45.0) then
          WGPutPntrReal (pSignal, i, 8.0)
      else
        if (time > 55.0)  and (time < 60.0) then
          WGPutPntrReal (pSignal, i, - 10.0)
      else
        if (time > 70.0)  and (time < 72.0) then
          WGPutPntrReal (pSignal, i, 10.0)
      else
        WGPutPntrReal (pSignal, i, 0.0);
      
      WGFFTFrequency (NUMPFFT, 1000.0 / interval, i, pf);
      WGPutPntrReal (pFreq, i, pf);
    end;
    WGPutPntrReal (pSignal, NUMPFFT * 4 div 5, - 5.0);
    WGPutPntrReal (pSignal, NUMPFFT * 4 div 5 + 1, - 6.0);
    
    {  duplicate arrays}
    hFFTCos := WGCopyMem (hSignal);
    hPower := WGCopyMem (hSignal);
    
    pFFTCos := GlobalLock (hFFTCos)  ;
    pPower := GlobalLock (hPower);

    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }

  {  Initialize graphs for page 1}

  WGCreateGraph (pPageDesc,
    @DrawP1G1,                         {  function which builds graph 1}
    0.01, 0.01,                        {  window relative position inside parent page window}
    0.99, 0.37,
    C_CYAN,                            {  background}
    C_BLACK,                           {  black border}
    1);                                {  border width in pixels}

  WGCreateGraph (pPageDesc,
    @DrawP1G2,                         {  function which builds graph}
    0.01, 0.4,                         {  window relative position inside parent page window}
    0.99, 0.7,
    C_YELLOW,                          {  light gray background}
    - 1,                               {  no border}
    0);

  WGCreateGraph (pPageDesc, 
    @DrawP1G3,                         {  function which builds graph}
    0.01, 0.7,                         {  window relative position inside parent page window}
    0.99, 0.99,
    C_YELLOW,                          {  light gray background}
    - 1,                               {  no border}
    0);
end;

{ *********************************************************************
   Routine StartPage2 is called by the Quinn-Curtis
   Windows Charting Tools when page 2 is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

procedure StartPage2 (pPageDesc: PPAGE_DEF);
begin
  WGCreateGraph (pPageDesc, @DrawP2G1, 0.01, 0.01, 0.99, 0.49, 
    C_GREEN, - 1, 0);
  WGCreateGraph (pPageDesc, @DrawP2G2, 0.01, 0.51, 0.99, 0.99,
    C_LIGHTCYAN, - 1, 0);
end;

{ ******************************************************
   Page 1 Graph 1 building procedure
******************************************************* }

procedure  DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;     {  axes handles}
    hDataSig: HDATA;  {  signal data set handle}
begin
  {  define a signal dataset }
  hDataSig := WGDefineDataSet ('Signal', hTime, hSignal, NUMPFFT);
  if (hDataSig = NULLH)  THEN              {  check IF data set is good}
    exit ;

  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.15, 0.9, 0.95, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, - 12.0, 100.0, 12.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

  {  axes to be drawn in solid, black, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  {  set current font to Arial, 11 points}
  WGSetTextByName (C_BLACK, 'Arial', 11, 0);
  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 20.0, 1, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_TEXT, 'mSec');
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 5.0, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 
    - 1, LL_TEXT, 'V');
  
  {  set line style of actual plot to MAGENTA}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_MAGENTA);
  {  plot the original signal }
  WGLinePlot (pGrDesc, thdc, hDataSig, FALSE, FALSE);
  
  {  set current font to Arial, 12 points, bold, italic}
  WGSetTextByName (C_RED, 'Arial', 12, TEXT_BOLD  or  TEXT_ITAL);
  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Time');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Signal');
  
  {  set current font to Arial, 16 points, bold}
  WGSetTextByName (C_BLUE, 'Arial', 15, TEXT_BOLD);

  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Original Waveform');
end;

{ ******************************************************
   Page 1 Graph 2 building procedure
******************************************************* }
procedure DrawP1G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
   hAxisX, hAxisY: HGOBJ;			{  axes handles}
   hDataFFTCos: HDATA;      	    {  FFT Data Set handle}
begin
  {  calculate real direct FFT}
  WGRealFFT (pFFTCos, pFFTSin, NUMPFFT, FALSE);

  {  define data set for Cosine array }
  hDataFFTCos := WGDefineDataSet ('FFT Cosine', hFreq, hFFTCos, NUMPFFT div 2);

  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.15, 0.9, 0.95, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, - 1800.0, 1000.0, 1800.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

  {  Select 'New Courier' font, black, size - 9 points}
  WGSetTextByName (C_BLACK, 'Courier New', 9, 0);
  {  set line parameters to Black, Solid, 1 pixel wide}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 100.0, 1, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_TEXT, 'Hz');
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 500.0, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);

  WGSetTextByName (C_GREEN, 'Times New Roman', 11, TEXT_BOLD  or  TEXT_ITAL);
  {  Write Y-Axis Title}
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Cosine');
  
  {  Plot FFT Cosine amplitudes}
  WGScatterPlot (pGrDesc, thdc, hDataFFTCos, MK_CIRCLE, C_RED, 2,
    MKS_FILLED, TRUE);
  
  {  Write graph title}
  WGSetTextByName (C_BLACK, 'Courier New', 15, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'FFT');
end;
{ ******************************************************
   Page 1 Graph 3 building procedure
******************************************************* }
procedure DrawP1G3 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;			{  axes handles}
    hDataFFTSin: HDATA;	            {  FFT Data Set handle}
begin
  {  define data set for FFT Sine array }
  hDataFFTSin := WGDefineDataSet ('FFT Sine', hFreq, hFFTSin, NUMPFFT div 2);
  
  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.13, 0.05, 0.9, 0.85, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, - 1800.0, 1000.0, 1800.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  Select 'New Courier' font, black, size - 9 points}
  WGSetTextByName (C_BLACK, 'Courier New', 9, 0);
  {  set line parameters to Black, Solid, 1 pixel wide}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  
  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 100.0, 1, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_TEXT, 'Hz');
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 500.0, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);

  WGSetTextByName (C_GREEN, 'Times New Roman', 11, TEXT_BOLD  or  TEXT_ITAL);
  {  Write Axes Titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Frequency');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Sine');
  
  {  Plot Sine data set}
  WGScatterPlot (pGrDesc, thdc, hDataFFTSin, MK_CIRCLE, C_RED, 2, 
    MKS_FILLED, TRUE);
end;

{ ******************************************************
   Page 2 Graph 1 building procedure
******************************************************* }

procedure DrawP2G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;   {  axes handles}
    hDataRest: HDATA;        {  handle for restored signal data set}
begin
  hRestored := WGCopyMem (hFFTCos);    {  copy Cosine array to new one}
  pRestored := GlobalLock (hRestored);
  
  WGRealFFT (pRestored, pFFTSin, NUMPFFT, TRUE);
  {  inverse FFT}
  
  {  Define data set for restored signal}
  hDataRest := WGDefineDataSet ('Restored Data', hTime, hRestored, NUMPFFT);
  
  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.9, 0.95, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, - 12.0, 100.0, 12.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  {  axes to be drawn in solid, white, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  {  set current font to Arial, 9 points, bold}
  WGSetTextByName (C_BLACK, 'Arial', 9, 0);
  
  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 20.0, 1, POS_BELOW);
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_TEXT, 'mSec');
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 5.0, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 
    - 1, LL_TEXT, 'V');
  
  {  set line style of actual plot to MAGENTA}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_MAGENTA);
  {  plot the restored signal}
  WGLinePlot (pGrDesc, thdc, hDataRest, FALSE, FALSE);
  
  {  set current font to Arial, 10 points, bold, italic}
  WGSetTextByName (C_RED, 'Arial', 10, TEXT_BOLD  or  TEXT_ITAL);
  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Time');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Signal');
  
  {  set current font to Arial, 10 points, bold}
  WGSetTextByName (C_BLUE, 'Arial', 10, TEXT_BOLD);
  
  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Restored Waveform');
end;

{ ************************************************************************* }
procedure DrawP2G2 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;   {  axes handles}
    hDataPow: HDATA;         {  handle for power spectrum data set}
begin
  {  calculate power spectrum of the original signal}
  WGPowerSpectrum (pPower, pPowFreq, NUMPFFT, MAXTIME / 1000.0 / NUMPFFT);

  {  define power spectrum data set (use only first half of array)}
  hDataPow := WGDefineDataSet ('Power Spectrum', hPowFreq, hPower, 
    NUMPFFT  div 2);
  
  {  define the plotting area of the graph }
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.13, 0.9, 0.78, C_WHITE);
  WGScalePlotArea (pGrDesc, 0.0, 0.0, 800.0, 8.0);
  WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
  
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
  WGSetTextParams (C_BLACK, FF_MODERN, 10, 0);

  {  draw and label axes}
  hAxisX := WGDrawXAxis (pGrDesc, thdc, 100.0, 1, POS_BELOW);
  if hAxisX = NULLH then
    exit ;
  WGLabelAxis (pGrDesc, thdc, hAxisX, POS_BELOW, NF_DECIMAL, - 1, LL_TEXT, 'Hz');
  hAxisY := WGDrawYAxis (pGrDesc, thdc, 2.0, 1, POS_LEFT);
  WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, - 1, LL_ON, NULLS);
  
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_LIGHTRED);
  WGScatterPlot (pGrDesc, thdc, hDataPow, MK_DOT, C_RED, 0, 0, TRUE);
  WGLinePlot (pGrDesc, thdc, hDataPow, FALSE, FALSE);

  WGSetTextByName (C_BLACK, 'Arial', 9, 0);
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Frequency');
  
  WGSetTextParams (C_BLUE, FF_SWISS, 9, 0);
  
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Power');
  WGSetTextParams (C_BLUE, FF_SWISS, 10, TEXT_BOLD);
  WGTitleGraph (pGrDesc, thdc, 'Power Spectrum');
end;



{ **********************************************************************
	FUNCTION: AboutProc
    PURPOSE:  Processes messages for 'About' dialog box
*********************************************************************** }

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

{ ************************************************************************ }

begin

end.
