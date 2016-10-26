{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   BARDEMOX.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}

{ 
    A single, simple bar graph is created in a graph window.  
    The x-axis is labeled with strings instead of numeric values.

    An arrow is used to point to a specIFic bar in the bar graph.

    Also, a metafile is loaded and displayed in the plotting area.


 }

unit Bardemox;

interface
uses WinTypes, WinProcs, messages,qcwin, hook;

procedure StartPage1 (pPageDesc: PPAGE_DEF); 

implementation

{$R demo}

const NUMP1= 8;                    {  number of data points}
var
  hInst: THANDLE;              {  global instance handle}
  hXStr, hX1, hY1, hY2: HGLOBAL;    {  global memory handles to data}

const
  szAppName:PChar = 'BarDemo';  {  Class Name used in call to CreateWindow.  }

{  Prototypes of forward referenced functions}

procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC); far; forward;
function randreal:realtype; forward;




{ *********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
********************************************************************** }

const  fInit: WORDBOOL = TRUE;

procedure StartPage1 (pPageDesc: PPAGE_DEF);
var
   i: INTEGER;
   z: realtype;
   lpX1, lpY1, lpY2: LPREAL;
   lpXStr: PCHAR;
begin
  {  create simulation data for plot}
  { -------------------------------------------------------------- }
  if (fInit) THEN BEGIN
  {  do not initialize data twice}
    {  allocate global data arrays}
    hX1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY1 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    hY2 := GlobalAlloc (GHND, sizeof (realtype) * NUMP1);
    {  global array for x-axis string labels}
    hXStr := GlobalAlloc (GHND, (NUMP1 - 1) * LABELLEN);
    {  get pointers to data arrays}
    lpX1 := GlobalLock (hX1);
    lpY1 := GlobalLock (hY1);
    lpY2 := GlobalLock (hY2);
    lpXStr := GlobalLock (hXStr);
    
    {  create x and y data to be plotted}
    for i := 0 to   NUMP1 - 1 do 
    begin
      z := i;
      WGPutPntrReal (lpX1, i, z);
    end;
    WGPutPntrReal (lpY1, 0, 0.0);
    WGPutPntrReal (lpY1, 1, 26.2);
    WGPutPntrReal (lpY1, 2, 111.2);
    WGPutPntrReal (lpY1, 3, 116.6);
    WGPutPntrReal (lpY1, 4, - 871.3);
    WGPutPntrReal (lpY1, 5, 28.6);
    WGPutPntrReal (lpY1, 6, - 138.3);
    WGPutPntrReal (lpY1, 7, - 294.1);

    WGPutPntrReal (lpY2, 0, 20.0);
    WGPutPntrReal (lpY2, 1, 22.25);
    WGPutPntrReal (lpY2, 2, 18.75);
    WGPutPntrReal (lpY2, 3, 12.5);
    WGPutPntrReal (lpY2, 4, 8.25);
    WGPutPntrReal (lpY2, 5, 11);
    WGPutPntrReal (lpY2, 6, 12);
    WGPutPntrReal (lpY2, 7, 11.5);
    
    {  copy strings to x axis string array, be sure to index correctly when}
    {  assigning each string!}
    lstrcpy (lpXStr, '1Q91');
    lstrcpy (lpXStr + LABELLEN, '2Q91');
    lstrcpy (lpXStr + 2 * LABELLEN, '3Q91');
    lstrcpy (lpXStr + 3 * LABELLEN, '4Q91');
    lstrcpy (lpXStr + 4 * LABELLEN, '1Q92');
    lstrcpy (lpXStr + 5 * LABELLEN, '2Q92');
    lstrcpy (lpXStr + 6 * LABELLEN, '3Q92');
    
    fInit := FALSE;
  end;
  { -------------------------------------------------------------- }

  {  Initialize graph}
  
  WGCreateGraph (pPageDesc,
    @DrawGraphP1G1, {  points to function which builds graph}
    0.002, 0.002,   {  window relative position inside parent page window}
    0.998, 0.998,
    C_YELLOW,       {  yellow background}
    C_BLACK,        {  black border}
    1);             {  border width in pixels}

end;

{ ******************************************************
   Builds the graph using Q-C Windows Charting Calls
******************************************************* }

procedure DrawGraphP1G1 (pGrDesc: PGRAPH_DEF; thdc: HDC);
var
    hAxisX, hAxisY: HGOBJ;  {  axes handles}
    hDataSet, hDataSet2: HDATA;        {  data set handle}
begin
    {  define a dataset }
    hDataSet := WGDefineDataSet ('First Graph', hX1, hY1, NUMP1);
    hDataSet2 := WGDefineDataSet ('Stock Price', hX1, hY2, NUMP1);

    {  define the plotting area of the graph,}
    {  set the background color of the plotting area to light cyan}
    WGSetPlotArea (pGrDesc, thdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTCYAN);

    {  scale the plotting are for an x range of 0 to 7.95}
    {  and y range of -900 to 200}
    WGScalePlotArea (pGrDesc, 0.0, - 900.0, 7.95, 200.0);

    {  set the intercepts to 0,0}
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
    
    {  X-axis to be drawn in solid, black, 2 pixels thick}
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 2, C_BLACK);
    
    {  draw the x axis with major ticks every physical coord and 0 minor tick}
    {  the ticks will be positioned at the center of the axis}
    hAxisX := WGDrawXAxis (pGrDesc, thdc, 1, 0, POS_MIDDLE);

    {  Y axis to be drawn in solid, black, 1 pixels thick}
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 1, C_BLACK);
    
    {  draw the y axis with major ticks every 100 physical coords and 1 minor ticks}
    hAxisY := WGDrawYAxis (pGrDesc, thdc, 100, 1, POS_LEFT);
    
    {  draw an axis grid on the major tick intervals}
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);
    
    {  display a bar graph with centered bars, width equals 0.9, no hatching or border}
    WGBargraph (pGrDesc, thdc, hDataSet, 0.9, POS_MIDDLE, LT_VBAR, 
      WGGetRGBColor (C_GREEN), - 1, - 1);
    
    {  set the font to Arial, size 10}
    WGSetTextByName (C_BLACK, 'Arial', 10, TEXT_BOLD);

    {  Label the axes with strings, display labels at the bottom of the plotting area}
    WGLabelAxisStrings (pGrDesc, thdc, hAxisX, POS_BELOW_PLOT, LL_OFF, hXStr);

    {  Label the y axis, in decimal format, 1 digit after the decimal point.}
    WGLabelAxis (pGrDesc, thdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULLS);
    
    {  set line style of arrow to solid, BLACK, 0 pixels wide}
    WGSetLineStyle (pGrDesc, thdc, PS_SOLID, 0, C_BLACK);
    
    {  draw an arrow.  This arrow will point to the left, and will be filled}
    WGArrow (pGrDesc, thdc, hAxisX, hAxisY, 4.55, - 785, 5.5, - 775, 6, 6, TRUE, FALSE, TRUE);
    
    {  load the 'star' meta file and display it in the plotting area}
    WGMetafile (pGrDesc, thdc, hAxisX, hAxisY, 4.25, - 450, 7.25, - 850, 
      'STAR.WMF');
    
    {  now output a string in the center of the metafile 'star'}
    WGText (pGrDesc, thdc, hAxisX, hAxisY, 'Big Loss', 5.75, - 630.0, 
      TA_CENTER, TEXT_NORMAL);
    
    {  set current font to Arial, 12 points}
    WGSetTextByName (C_GREEN, 'Arial', 12, 0);
    
    {  Write axes titles}
    WGTitleAxis (pGrDesc, thdc, hAxisX, POS_BELOW, 'Quarter');
    WGTitleAxis (pGrDesc, thdc, hAxisY, POS_LEFT, 'Millions of dollars');

    { plot second data set in different coordinates }

    { scale the plotting are for an x range of 0 to 7.95 }
    { and y range of 0 to 25                             }
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 7.95, 25.0);

    { set the intercepts to right side }
    WGSetXYIntercepts (pGrDesc, 7.95, 0.0);

    { Second Y axis to be drawn in solid, Red, 1 pixels thick }
    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 1, C_RED);

    { draw the y axis with major ticks every 5 physical coords and 4 minor ticks }
    hAxisY := WGDrawYAxis(pGrDesc, thdc, 5.0, 4, POS_RIGHT);

    { Label the y axis, in decimal format, 1 digit after the decimal point. }
    WGLabelAxis(pGrDesc, thdc, hAxisY, POS_RIGHT, NF_DECIMAL, 1, LL_TEXT, '$');

    WGSetLineStyle(pGrDesc, thdc, PS_SOLID, 2, C_LIGHTRED);
    { plot stock price data  }
    WGLinePlot (pGrDesc, thdc, hDataSet2, FALSE, FALSE);

    {  set current font to Arial, 16 points, bold, italic}
    WGSetTextByName (C_GREEN, 'Arial', 16, TEXT_BOLD  or  TEXT_ITAL);
    
    {  Write graph title}
    WGTitleGraph (pGrDesc, thdc, 'BIG Computer Co.');
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
