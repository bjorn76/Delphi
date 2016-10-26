{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   METADEMX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
{ *************************************************************}
{ *                                                           *}
{ *     Copyright (c) QUINN-CURTIS, 1992, 1993                *}
{ *                                                           *}
{ *************************************************************}
{ *                                                           *}
{ *   Filename :   metademo.pas                               *}
{ *   Author   :   MS                                         *}
{ *   Revision :   1.01                                       *}
{ *   Date     :   January 12, 1993                           *}
{ *   Product  :   Windows Charting Tools                     *}
{ *                                                           *}
{ *   Description: Example using metafile functions           *}
{ *                                                           *}
{ *************************************************************}

{ 
    This program is based on EASYGRAF.
    
    It demonstrates how to convert a page to metafile and play
    it in the main window. It also loads a metafile 'star.wmf'
    and plays it in the main window.


 }

unit Metademx;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
procedure WM_DestroyGraph;
procedure WM_PaintGraph(thwnd: HWND; tinst: THANDLE);

implementation

{$R demo}
const
  NUMP1 = 90;                   { number of data points}
  szAppName: PCHAR = 'MetaDemo';{ Class Name used in call to CreateWindow.  }

  pMetaDesc1: POBJ_META = nil;
  pMetaDesc2: POBJ_META = nil;
  pPageDesc : PPAGE_DEF = nil;

var
  hX1, hY1: HGLOBAL;   {  global handles to data}


{  Prototypes of forward referenced functions}
procedure StartGraphs1 (pPageDesc: PPAGE_DEF); far; forward;   {  these functions must be FAR}
procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;

procedure WM_CreateGraph(thwnd: HWND; tinst: THANDLE);
var    rect: TRECT;
       coef: INTEGER;
BEGIN
	 { page is created in the current window }
      GetWindowRect (thwnd, rect);
      {  create page }
{    coef := 1440 / GetDeviceCaps(MetaDemoForm.thdc, LOGPIXELSX)
 }
      pPageDesc := WGCreatePage ('PAGE1', {  page ID string}
        thwnd,                         {  handle to the parent window}
        tInst,                         {  application instance handle }
        'Page Window',                 {  Window title string }
        @StartGraphs1,                 {  pointer to graph creation function}
        'PageMenu',                    {  Name of page window menu in resource file}
        C_LIGHTGRAY,                   {  window background color}
        MM_PROPORT,                    {  window sizing mode}
        0,                             {  window style - default}
        PAGE_EXACT,                    {  window initial size and position option}
        rect.left,                     {  initial window size and position}
        rect.top + rect.bottom div 2,
        rect.right,
        rect.bottom div 2);

      {  page is converted to metafile which is played in the main window}

      if (pPageDesc <> nil)  and (pMetaDesc1 = nil) then begin
        pMetaDesc1 := WGConvertPageToMeta (pPageDesc);

        {  load a metafile}
        pMetaDesc2 := WGGetMetafile ('star.wmf');

        InvalidateRect (thwnd, nil, TRUE);
        {  force main window update}
        UpdateWindow (thwnd);
  END;
END;

procedure WM_DestroyGraph;
begin
      {  destroy memory metafiles }
      WGDeleteMetafile (pMetaDesc1);
      WGDeleteMetafile (pMetaDesc2);

      WGCleanup (TRUE);                {  clean up charting tools memory}
      PostQuitMessage (0);
end;

procedure WM_PaintGraph(thwnd: HWND; tinst: THANDLE);
var    rect: TRECT;
begin
  GetClientRect (thwnd, rect);
      {  play memory metafiles}
  if pMetaDesc1 <> nil then
    WGPlayMetafile (thwnd, pMetaDesc1, 10, 10,
    rect.right div 2, rect.bottom div 3);
  if pMetaDesc2 <> nil then
    WGPlayMetafile (thwnd, pMetaDesc2,
          rect.right div 2, 10, rect.right - 20, rect.bottom div 3);
end;


{ *********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }
const
   fInit:  BOOL = TRUE;

procedure  StartGraphs1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   lpX1, lpY1:  LPREAL;
   z: realtype;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    
    {  create x and y data to be plotted}
    for i := 0 to  NUMP1 - 1 do begin
      z := i;
      WGPutPntrReal (lpX1, i, z);
      WGPutPntrReal (lpY1, i, 15.0 *
        cos (PI * z / (4.0 + 0.3 * randreal)) +
        3.0 * randreal);
    end;
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }
  
  {  Initialize graph }
  
  WGCreateGraph (pPageDesc, 
    @DrawP1G1,    {  points to function which builds graph}
    0.02, 0.02,   {  window relative position inside parent page window}
    0.99, 0.99,
    C_WHITE,      {  white background}
    C_BLACK,      {  black border}
    1);           {  border width in pixels}
end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY, hLabX, hLabY: HGOBJ;  {  axes handles}
    hDataSet: HDATA;        {  data set handle}
begin
  {  define a dataset }
  hDataSet := WGDefineDataSet ('60 Cycle Noise', hX1, hY1, NUMP1);
  
  {  define the plotting area of the graph}
  WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTCYAN);
  
  {  axes to be drawn in solid, black, 1 pixels thick}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);

  {  set current font to Arial, 12 points, bold}
  WGSetTextByName (C_BLACK, 'Arial', 12, TEXT_BOLD);
  
  {  analyze the data set and automatically scale the }
  {  plot area, draw and label the axes}
  WGAutoAxes (pGrDesc, thdc, hDataSet, AS_ROUNDCLOSE, 
    INTF_ZERO, hAxisX, hAxisY, hLabX, hLabY);
  
  {  set line style of actual plot to RED}
  WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_RED);
  
  {  plot the data with spline interpolation on}
  WGLinePlot (pGrDesc, thdc, hDataSet, FALSE, TRUE);
  
  {  Write axes titles}
  WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Sample Interval');
  WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Volts');

  {  set current font to Arial, 16 points, bold, italic}
  WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD  or  TEXT_ITAL);
  
  {  Write graph title}
  WGTitleGraph (pGrDesc, thdc, 'Input Waveform');
end;
{ ********************************************************************* }
{  random real number generator in the range of 0.0 to 1.0              }
{ ********************************************************************* }
function randreal:realtype;
begin
  randreal := random (32766) / 32767.0;
end;

{ ********************************************************************* }

begin
end.
