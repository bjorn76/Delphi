//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, 1998                      *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   WCTDEMO.C                                  *
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
//*                                                           *
//*   Description: DEMO PROGRAM FOR WINDOWS CHARTING TOOLS    *
//*                                                           *
//*************************************************************

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"
#include "demo.h"
#include "support.h"

#define  CAPTHEIGHT  11        // CAPTION TEXT SIZE
#define  CAPTLEFT    0.03
#define  CAPTTOP	 0.1     
#define  CAPTINT	 0.24     

HINSTANCE  hInst;             // global instance handle
HGLOBAL    hYAxStr;        

HGLOBAL  hIntX1, hIntY1, hIntX12, hIntY12, hIntX13, hIntY13, hIntX14, hIntY14;

HGLOBAL  hX11, hY11, hX12, hY12, hX111, hY111, hXPict, hYPict;
HGLOBAL  hX21, hY21, hY22, hY23, hX31, hY31, hY32;
HGLOBAL  hX51, hY51, hX61, hY61, hY62, hGX61, hGY61;
HGLOBAL  hX71, hY71, hX81, hY81, hY82, hY83;
HGLOBAL  hX101, hY101, hX102, hY102;

HGLOBAL hX112, hY112, hX113, hY113;

HGLOBAL  hPieData = NULL; 
HGLOBAL	 hPieStr = NULL;
HGLOBAL	 hFloStr = NULL;
LPREAL   lpX71, lpY71;

HDATA   hLiveData = 0, hLiveData2 = 0, hLiveData3 = 0;
HDATA   hDataSet;        // data set handle
HGOBJ   hPlot, hPlot2, hPlot3;
HGOBJ   hAxX, hAxY;
HGOBJ   hAxisXZ, hAxisYZ;  // axes handles
PGRAPH_DEF  pDynGrDesc = NULL;
HGOBJ   hCursor1;
HGOBJ  hTextX, hTextY;

LPREAL  lpZoomX1, lpZoomY1, lpZoomY2, lpZoomY3, lpZoomY4, lpZoomY5;           // data arrays
HDATA   hZoomDataSet, hZoomDataSet2, hZoomDataSet3, 
        hZoomDataSet4, hZoomDataSet5;        // data set handles
HGOBJ hZoomX1, hZoomY1, hZoomY2, hZoomY3, hZoomY4, hZoomY5, hZoomY6; // axis handles

HDATA   ContourData, hWFDataSet;  // data set handle

HGLOBAL  hSignal, hFFTCos, hFFTSin, hPower;
HGLOBAL  hTime, hFreq, hPowFreq;
HPREAL   pSignal, pTime, pFreq, pPower, pPowFreq;

HPREAL  lpIndWater, lpDepWater;				// data arrays for waterfall plot
BOOL bSuperZoomF=FALSE;

void CALLBACK DrawPZoomG1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPZoomG2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPZoomG3 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawPDlgG2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPHead (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPPict (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc);

realtype functionproc1(realtype x, realtype y);
void CreateData(void);
void CALLBACK DrawP2G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP2G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP2G3 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP3G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP3G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP3G3 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP4G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP4G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP5G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP5G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP6G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP6G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP6G3 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP7G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP7G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP8G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP8G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP9G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP9G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP9G3 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP9G4 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP10G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP10G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawP11G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP11G2 (PGRAPH_DEF pGrDesc, HDC hdc);

void CALLBACK DrawDlgG2 (PGRAPH_DEF pGrDesc, HDC hdc);
void ProcessSuperZoom(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse);
void RestoreZoomAxes(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse);

// Captions

char szCapInt1[] =
"Double click on any graphical object (axis, labels, plot, legends, text, etc.) to bring up";
char szCapInt2[] =
"a dialog box for that object. Use the menu to print a graph or save it to a metafile.";
char szCapInt3[] ="Select an object with the left mouse button, then drag it with the right mouse button.";

#if 0
char szCapZoom1[] =
"Click the right mouse button on the first graph and drag.";
char szCapZoom2[] =
"The second graph will display zoomed area.";
char szCapZoom3[] =
"To see a data cursor, click left mouse button in the first graph.";
#endif

char szCapZoom1[] =
"The Rev 3.0 super zoom function will zoom up to ten sets of x and y axes.";
char szCapZoom2[] =
"Click the right mouse button graph and drag in the graph area.";
char szCapZoom3[] =
"The graph will rescale all of the axes and the corresponding line plots.";

char szCapDlg1[] =
"Built-in dialog boxes for editing graphical objects require no programming";
char szCapDlg2[] = "on your part.";

char szCap11[] =
"Plots of different types, in this case line plot and bar graph, can be combined";
char szCap12[] = "in the same chart.";

//char szCap21[] = "The area fill option for line plots creates very effective charts.";
char szCap21[] = "Rev. 3.0 adds contour lines and filled contours with contour labels. Contour data";
char szCap22[] = "can be randomly oriented xyz data values, or z-values sampled on an evenly";
char szCap23[] = "spaced xy grid.";

char szCap31[] = "Graph windows can overlap, creating special effects.";

char szCap41[] =
"Pie charts can be two- and three-dimensional. They have slice explosion";
char szCap42[] = "and labeling options.";

char szCap51[] =
"Charts can have linear, logarithmic, and semi-logarithmic scaling. Decimal,";
char szCap52[] =
"scientific, and engineering formats can be used for axes' numeric labels.";

char szCap61[] =
"The Rev. 3.0 Open-High-Low-Close plot is an excellent tool for displaying stock";
char szCap62[] =
" market data. Individual data points can be assigned unique colors.";

char szCap71[] =
"Horizontal bar graphs can be combined with the actual numeric values for";
char szCap72[] = "each bar.";

char szCap81[] = "Rev. 3.0 adds new chart types which use bitmaps and metafiles";
char szCap82[] = "as chart elements.";

char szCap91[] =
"The Charting Tools for Windows include high performance FFT and Power ";
char szCap92[] = "Spectrum functions. Rev 3.0 adds Waterfall plots as well.";

char szCap101[] =
"Floating bars are great for displaying project and other time-line data.";

char szCap111[] = "Graphical objects can be updated in real time. Rev. 3.0 uses";
char szCap112[] = "bit block transfers for flickerless updates.";

char szTit[] = "Charting Tools for Windows Rev. 3.0";
char szVer32[] = "32-bit version";
char szVer16[] = "16-bit version";
char szLogo1[] = "Copyright (C) Quinn-Curtis, Inc., 1993-1998";
char szLogo2[] = "Quinn-Curtis, Inc.";
char szLogo3[] = "35 Highland Circle, Needham, MA 02494";
char szLogo4[] = "(781) 449-6155";
char szLogo5[] = "http://www.quinn-curtis.com";

extern PGRAPH_DEF pGrDescZoom1;
extern PGRAPH_DEF pGrDescZoom2;
/**********************************************************************/
void CALLBACK StartGraphsZoom(PPAGE_DEF pPageDesc)
{
	pGrDescZoom1 = WGCreateGraph (pPageDesc,
		 DrawPZoomG1,     // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.99, BBYSTART - 0.005,
		 C_WHITE,  // gray  background
		 C_RED,   // red   border
		 1);      // border width in pixels
	WGSaveAxesState(pGrDescZoom1);

//	pGrDescZoom2 = WGCreateGraph (pPageDesc,
//		 DrawPZoomG2,  // points to function which builds graph
//		 0.1, 0.49, // window relative position inside parent page window
//		 0.9, BBYSTART - 0.005,
//		 C_WHITE, C_GREEN,  2);     

    WGCreateGraph (pPageDesc,
		 DrawPZoomG3, 
		 1.0 - BBXSTART, BBYSTART, // window relative position inside parent page window
		 BBXSTART, 0.995,
   		 C_WHITE, C_BLACK, 2);
}
/**********************************************************************/

void CALLBACK StartGraphsDlg (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc,
		 DrawPIntG2, 
		 0.005, 0.005, // window relative position inside parent page window
		 0.995, BBYSTART-0.005,
		 C_WHITE, C_RED, 2);      // border width in pixels

#if 1
    WGCreateGraph (pPageDesc,
		 DrawPDlgG2, 
		 1.0 - BBXSTART, BBYSTART, // window relative position inside parent page window
		 BBXSTART, 0.995,
   		 C_WHITE, C_BLACK, 2);
#endif
}

/**********************************************************************/

void CALLBACK StartHeader (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc,
		 DrawPHead, 0.0, 0.0, 1.0, 1.0, 
		 C_CYAN, C_WHITE, 2);
}
/**********************************************************************/

void CALLBACK StartPict (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc,
		 DrawPPict, 0.0, 0.0, 1.0, 1.0, 
		 C_CYAN, -1, 0);
}
/**********************************************************************/

void CALLBACK StartPage1(PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc,
		 DrawP1G1, 0.005, 0.005, 0.995, BBYSTART - 0.005,
		 C_WHITE,  C_RED,  1); 

    WGCreateGraph (pPageDesc,
 	     DrawP1G2, 1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_CYAN, 2);
}
/**********************************************************************/

void CALLBACK StartPage2(PPAGE_DEF pPageDesc)
{

    WGCreateGraph (pPageDesc, DrawP2G1, 
                 0.015, 0.015, 0.38, 0.42,
                 C_PALEBLUE, C_GREEN, 4);          

    WGCreateGraph (pPageDesc, DrawP2G2, 
                 0.05, 0.05, 0.95, BBYSTART-0.005,//0.95,
                 C_PALEGREEN, C_GREEN, 4);            


    WGCreateGraph (pPageDesc,  DrawP2G3, 
		 1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 3);
}

/**********************************************************************/

void CALLBACK StartPage3(PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP3G2, 0.15, 0.12, 0.5, 0.42,
    	C_WHITE, -1, 0);

    WGCreateGraph (pPageDesc, DrawP3G1, 0.01, 0.01, 0.995, BBYSTART-0.005,
	    C_YELLOW, -1, 0);

    WGCreateGraph (pPageDesc, DrawP3G3, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/

void CALLBACK StartPage4(PPAGE_DEF pPageDesc)
{
      // Initialize graphs

    WGCreateGraph (pPageDesc, DrawP4G1, 0.01, 0.01, 0.99, BBYSTART-0.005,
    	C_WHITE, -1, 0);

    WGCreateGraph (pPageDesc, DrawP4G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/

void CALLBACK StartPage5(PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP5G1, 0.01, 0.01, 0.99, BBYSTART-0.005,
  		C_LIGHTCYAN, -1, 0);

    WGCreateGraph (pPageDesc, DrawP5G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}

/**********************************************************************/

void CALLBACK StartPage6(PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP6G1, 
 					0.01, 0.01, 0.99, 0.58,
					C_WHITE, C_GREEN, 3);          

    WGCreateGraph (pPageDesc, DrawP6G2, 
					0.01, 0.59, 0.99, BBYSTART-0.005,
					C_WHITE, C_LIGHTRED, 3);          

    WGCreateGraph (pPageDesc, DrawP6G3, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}

/**********************************************************************/
void CALLBACK StartPage7 (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP7G1, 0.002, 0.002,	
 		 0.998, BBYSTART-0.005, C_BLACK, C_WHITE, 1);

    WGCreateGraph (pPageDesc, DrawP7G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/
void CALLBACK StartPage8 (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP8G1, 0.01, 0.01, 0.99, BBYSTART-0.005,
         C_LIGHTBLUE, C_BLACK, 2);

    WGCreateGraph (pPageDesc, DrawP8G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/
void CALLBACK StartPage9 (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP9G1, 0.01, 0.01, 0.99, 0.39,
  		C_YELLOW, -1, 0);
    WGCreateGraph (pPageDesc, DrawP9G2, 0.01, 0.41, 0.33, BBYSTART-0.005,
  		C_CYAN, -1, 0);
    WGCreateGraph (pPageDesc, DrawP9G3, 0.34, 0.41, 0.99, BBYSTART-0.005,
  		C_WHITE, C_RED, 1);
    WGCreateGraph (pPageDesc, DrawP9G4, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/
void CALLBACK StartPage10 (PPAGE_DEF pPageDesc)
{
    WGCreateGraph (pPageDesc, DrawP10G1,
		 0.005, 0.005, 0.99, BBYSTART-0.005, C_WHITE, C_RED, 1);
    WGCreateGraph (pPageDesc, DrawP10G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/**********************************************************************/
void CALLBACK StartPage11 (PPAGE_DEF pPageDesc)
{
    pDynGrDesc = WGCreateGraph (pPageDesc,
		 DrawP11G1, 0.005, 0.005, 0.99, BBYSTART-0.005, C_GREEN, C_YELLOW, 1);

    WGCreateGraph (pPageDesc, DrawP11G2, 
 	    1.0 - BBXSTART, BBYSTART, BBXSTART, 0.995, C_WHITE, C_BLACK, 2);
}
/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawPIntG1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;  // axes handles

    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
    WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);

    // analyze the data set and automatically scale the 
    // plot area, draw and label the axes
    WGAutoAxes(pGrDesc, hdc, hDataSet, AS_ROUNDCLOSE,
	    INTF_ZERO, &hAxisX, &hAxisY, NULL, NULL);

    // set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_RED);

    // plot the data with spline interpolation on
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);

    // Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

		// set current font to Arial, 16 points, bold, italic
    WGSetTextParams (C_GREEN, FF_SWISS, 16, TEXT_BOLD | TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "Input Waveform");
}
/*******************************************************
   Page 1 Graph 2 building procedure
********************************************************/

void CALLBACK DrawPIntG2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1, hDataSet2, hDataSet3;  // data set handles
    LPSTR   lpstr;
    HGLOBAL hStr1;   // global memory handle for legend array 

    // Define 3 data sets

    hDataSet1 = WGDefineDataSet ("Fitted Data", hIntX12, hIntY12, NUMP2);
    hDataSet2 = WGDefineDataSet ("Raw Data", hIntX13, hIntY13, NUMP2);
    hDataSet3 = WGDefineDataSet ("Residuals", hIntX14, hIntY14, NUMP2);

    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.12, 0.1, 0.95, 0.88, C_WHITE);
	WGScalePlotArea(pGrDesc, 0,-50.0, 32, 250);

	WGSetXYIntercepts(pGrDesc, 0.0, 0.0);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);

    // Select font of family "FF_SWISS", 10 points.
    WGSetTextParams (C_BLACK, FF_SWISS, 12, 0);
    // draw axes
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 5, 4, POS_BELOW);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 50, 4, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL,
      -1, LL_ON, NULL);

    // Draw grid lines
    WGSetLineStyle (pGrDesc, hdc, PS_SOLID, 1, C_GRAY);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

    // Scatter Plot - data set 2

    WGScatterPlot(pGrDesc, hdc, hDataSet2, MK_ASTERISK, C_LIGHTBLUE, 7,
    	MKS_EMPTY, FALSE);
 
    // Line Plot - data set 1
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
    WGLinePlot (pGrDesc, hdc, hDataSet1, FALSE, FALSE);
  
    // bargraph - data set 3
    WGBargraph (pGrDesc, hdc, hDataSet3, 0.5, POS_MIDDLE,
       LT_VBAR, RGB (0, 160, 160), -1, C_CYAN);

    // Label X-axis 
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);

    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Fusion Run XRK-823V");

    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Time - Nanoseconds");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Neutrons Detected");

    // Allocate string array for legends
    hStr1 = GlobalAlloc(GMF, 3 * LG_MAXLEN);
	lpstr = (LPSTR)GlobalLock (hStr1);
    // Initialize legends
    lstrcpy(lpstr, "Measured Values");
    lstrcpy(lpstr + LG_MAXLEN, "Predicted Values");
    lstrcpy(lpstr + 2 * LG_MAXLEN, "Residuals");
    
	WGSetTextParams (C_BLACK, FF_SWISS, 9, TEXT_BOLD);

	WGLegend(pGrDesc, hdc, 0.7, 0.33, 0.9, 0.66, C_BLACK, 3, -1, C_WHITE,
        OR_VERT, hStr1);
   	GlobalFree(hStr1);
	WGSetGraphBitBltMode(pGrDesc, TRUE);

//   WGSetMouseEventAction(pGrDesc, WM_LBUTTONDOWN, OBJ_FIND_EVENT, NULL);
//   WGSetMouseEventAction(pGrDesc, WM_LBUTTONDOWN, OBJ_FIND_EVENT, NULL);

}



HGOBJ  ScaleAndDrawXAxis (PGRAPH_DEF pGrDesc, HDC hdc, 
						  realtype rXMin, realtype rYMin, 
						  realtype rXMax, realtype rYMax,
						  realtype rXInt, realtype rYInt,
						  realtype rYTickSpace,
						  int nPos)
{   HGOBJ hAxisX;

	WGScalePlotArea (pGrDesc, rXMin,rYMin, rXMax, rYMax);
	WGSetXYIntercepts (pGrDesc, rXInt, rYInt);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, rYTickSpace, 0, POS_MIDDLE);
    WGLabelAxis(pGrDesc, hdc, hAxisX, nPos, NF_DECIMAL, 1, LL_ON, NULL);
  
	return hAxisX;
}

HGOBJ  ScaleAndDrawYAxis (PGRAPH_DEF pGrDesc, HDC hdc, 
						  realtype rXMin, realtype rYMin, 
						  realtype rXMax, realtype rYMax,
						  realtype rXInt, realtype rYInt,
						  realtype rYTickSpace,
						  int nPos)
{ HGOBJ hAxisY;

	WGScalePlotArea (pGrDesc, rXMin,rYMin, rXMax, rYMax);
	WGSetXYIntercepts (pGrDesc, rXInt, rYInt);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, rYTickSpace, 0, POS_MIDDLE);
    WGLabelAxis(pGrDesc, hdc, hAxisY, nPos, NF_DECIMAL, 1, LL_ON, NULL);

	return hAxisY;

}

/*********************************************************************/
void CALLBACK DrawPZoomG1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	// define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.30, 0.20, 0.75, 0.80, C_WHITE);


	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, "Arial", 11, TEXT_BOLD);

// Make sure that first X and Y Axis are scales to the same coordinate system
    hZoomX1 = ScaleAndDrawXAxis(pGrDesc, hdc, 0,   -20,  100,  20,   0,    -20, 20, POS_BELOW);
    hZoomY1 = ScaleAndDrawYAxis(pGrDesc, hdc, 0,   -20,  100,  20,   0,    -20, 5,  POS_LEFT);

    
	// set line style of actual plot to RED
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
    WGLinePlot (pGrDesc, hdc, hZoomDataSet, FALSE, FALSE);

    hZoomY2 = ScaleAndDrawYAxis(pGrDesc, hdc, 0,   0,  100, 100, -20,    0, 20,  POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTBLUE);
    WGLinePlot (pGrDesc, hdc, hZoomDataSet2, FALSE, FALSE);

    hZoomY3 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -100, 100, 100, 100, -100, 50,  POS_RIGHT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_GREEN);
    WGLinePlot (pGrDesc, hdc, hZoomDataSet3, FALSE, FALSE);

    hZoomY4 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -100, 100, 500, 120, -100, 100,  POS_RIGHT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_YELLOW);
    WGLinePlot (pGrDesc, hdc, hZoomDataSet4, FALSE, FALSE);

    hZoomY5 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -5.0, 100, 5.0, -40, -1.0, 1.0,  POS_LEFT);
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_MAGENTA);
    WGLinePlot (pGrDesc, hdc, hZoomDataSet5, FALSE, FALSE);

		// set current font to Arial, 12 points, bold, italic
	WGSetTextByName (C_BLUE, "Arial", 12, TEXT_BOLD);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Click and drag right mouse button to zoom. Double click right mouse button to reset.");
    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_USERPROC_EVENT, ProcessSuperZoom);
    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDBLCLK, OBJ_USERPROC_EVENT, RestoreZoomAxes);
	WGSetGraphBitBltMode(pGrDesc, TRUE);
    bSuperZoomF = TRUE;
}

void RestoreZoomAxes(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse)
{
  WGRestoreAxesState(WGGetGraphDesc(hwnd));
}


void ProcessSuperZoom(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse)
{ 

	HGOBJ phAxisY[5], phAxisX[2];
  int nZoomAxisMode = ZOOM_1X_MULTIPLE_Y;
  int nZoomRoundMode = AS_ROUNDCLOSE;
  int nNumXAx= 1, nNumYAx = 5;

  phAxisY[0] = hZoomY1;
  phAxisY[1] = hZoomY2;
  phAxisY[2] = hZoomY3;
  phAxisY[3] = hZoomY4;
  phAxisY[4] = hZoomY5;

  phAxisX[0] = hZoomX1;
 
  WGStartSuperZoom (hwnd, phAxisX, phAxisY, 
	nNumXAx, nNumYAx, 
	nZoomAxisMode,
	nZoomRoundMode,
    message, TRUE);

}

void CALLBACK DrawPZoomG2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	// define the plotting area of the graph 
	WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.80, C_BLUE);

	// axes to be drawn in solid, black, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
	WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);

	// analyze the data set and automatically scale the 
	// plot area, draw and label the axes
	WGAutoAxes(pGrDesc, hdc, hDataSet, AS_ROUNDCLOSE,
		INTF_MIN, &hAxisXZ, &hAxisYZ, NULL, NULL);
	WGTitleAxis(pGrDesc, hdc, hAxisYZ, POS_LEFT, "Volts");

	// set line style for grids
	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 0, C_GRAY);

    WGDrawGrid (pGrDesc, hAxisXZ, GRID_MAJOR);
    WGDrawGrid (pGrDesc, hAxisYZ, GRID_MAJOR);
					   
	// set line style of actual plot
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTCYAN);

	WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);

	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Zoom Window");
}

/***************************************************************************/
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
	HDATA   hDataSet1, hDataSet2;
    HGLOBAL  hStr1;
    LPSTR    lpstr;

    hDataSet1 = WGDefineDataSet ("Fitted Data", hX11, hY11, NUMP20);
    hDataSet2 = WGDefineDataSet ("Raw Data", hX11, hY12, NUMP20);

    WGSetTextParams (C_BLACK, FF_SWISS, 12, 0);

    WGSetPlotArea(pGrDesc, hdc, 0.1, 0.15, 0.9, 0.85, C_LIGHTGRAY);
   
    WGAutoAxes(pGrDesc, hdc, hDataSet1, AS_ROUNDFAR,
    	INTF_ZERO, &hAxisX, &hAxisY, NULL, NULL);

    WGSetLineStyle (pGrDesc, hdc, PS_DOT, 1, C_BLACK);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3, C_CYAN);
    WGBargraph (pGrDesc, hdc, hDataSet2, 0.5, POS_MIDDLE,
       LT_VBAR,RGB (100, 0, 255), -1, C_CYAN);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_LIGHTRED);
    WGLinePlot (pGrDesc, hdc, hDataSet1, FALSE, TRUE);

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Argon Concentration PPM");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Dye / Wafer");

    WGSetTextParams (C_BLACK, FF_SWISS, 15, TEXT_BOLD);
	WGTitleGraph(pGrDesc, hdc, "Gaussian Fit to Histogram Data");
  
    hStr1 = GlobalAlloc(GMF,3*LG_MAXLEN);
    lpstr = GlobalLock(hStr1);
    lstrcpy(lpstr,"Experimental Data");
    lstrcpy(lpstr+LG_MAXLEN,"Predicted Values");
    lstrcpy(lpstr+2*LG_MAXLEN,"Residuals");

	WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);
	WGAutoLegend(pGrDesc, hdc, 0.66, 0.12, 0, 3, 0, 15, OR_VERT, hStr1);
    GlobalFree (hStr1);
}

/**************************************************************************/
realtype functionproc1(realtype x, realtype y)
{
	realtype result, w;

	result = ( 3.5 * sin(sqrt(x*x + y*y)));
	w = sin (x / 2.0) + (realtype ) rand()/ 100000.0;
	result += w * ( 8 - (y + 7) / 2);

	return result;
}
void   CreateData(void)
{
    int      i,j, k = 0;
    static  BOOL fInit = TRUE;
    LPREAL  lpX1;

    // create simulation data for plots
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
      WGStart();    // Initialize the DLL if WGCreatePage is no the first call  
      lpX1 = calloc(30*30, sizeof(realtype));

		 
      for (i=0; i < 30; i++)
		  for (j=0; j < 30; j++)
		    lpX1[k++] =  
			functionproc1((realtype) j / 2.0 -7.5, (realtype)i / 2.0 - 7.5);
      ContourData = WGCreateEvenGridDataSetPtr (NULL, lpX1,
       -7.5, -7.5, 0.5, 0.5,30, 30);
        fInit = FALSE;
    }
}

void CALLBACK DrawP2G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	realtype rContourValues[8] = {-3.5, -2.1, -1.1, 0.0, 2.1, 3.1, 4.1, 5.1};
 
	HGOBJ   hAxisX, hAxisY;          // axes handles
	COLORREF rgbColors[10] = {1, 11, 12, 13, 14, C_LIGHTGRAY, C_GREEN, C_RED, C_BLACK, C_BLACK};
    int nLineStyle[8] = {PS_SOLID, PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID};
	int nLineWidth[8] = {1,1,1,1,1,1,1,1};
	int bContourLineFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
	int bContourLabelFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
    int i, granularity;

    WGSetPlotArea(pGrDesc, hdc, 0.13, 0.13, 0.95, 0.87, C_WHITE);
    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);

    WGAutoAxesContourData (pGrDesc, hdc, ContourData,  
							AS_ROUNDFAR, INTF_MIN,  &hAxisX, &hAxisY,
							NULL, NULL);

    for (i=0; i < 8; i++) // Convert Simple Colors to RGB Colors
		rgbColors[i] = WGGetRGBColor(rgbColors[i]);


	for (i=0; i < 8; i++)
	{
		 bContourLineFlags[i] = FALSE;
		 bContourLabelFlags[i] = FALSE;
	}
    granularity = 1;
    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGContourPlot (pGrDesc, hdc, ContourData, rContourValues,
					rgbColors, nLineStyle, nLineWidth, 7,
					granularity, bContourLineFlags, bContourLabelFlags, 
					POS_LEFT, POS_ABOVE, 1, FALSE, GT_CONTOURFILL);

    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "West");

    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Geographic Survey Natick");
}

void CALLBACK DrawP2G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	realtype rContourValues[8] = {-3.5, -2.1, -1.1, 0.0, 2.1, 3.1, 4.1, 5.1};
 
	HGOBJ   hAxisX, hAxisY;        
	COLORREF rgbColors[10] = {1, 11, 12, 13, 14, C_LIGHTGRAY, C_GREEN, C_RED, C_BLACK, C_BLACK};
    int nLineStyle[8] = {PS_SOLID, PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID};
	int nLineWidth[8] = {1,1,1,1,1,1,1,1};
	int bContourLineFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
	int bContourLabelFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
    int i, granularity;
	realtype rMinX, rMinY, rMaxX, rMaxY, rMinZ, rMaxZ;

    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.95, 0.85, C_WHITE);

    for (i=0; i < 8; i++)
		rgbColors[i] = WGGetRGBColor(rgbColors[i]);


	WGGetContourMinMaxXYZ (ContourData, &rMinX, &rMaxX,
										&rMinY, &rMaxY,
 										&rMinZ, &rMaxZ);
    WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);

    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_BLACK);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 0, POS_BELOW);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 0, POS_LEFT);

    // set line style of grids to dotted, minimal width, MAGENTA, 
    // and display a y-axis grid on major ticks.
  
    WGSetTextParams (C_BLUE, FF_SWISS, 10, TEXT_BOLD);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);

    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 0, C_MAGENTA);
    WGDrawGrid(pGrDesc, hAxisY, GRID_ALL);
    WGDrawGrid(pGrDesc, hAxisX, GRID_ALL);

    granularity = 1;
  
    WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);
    WGContourPlot (pGrDesc,  hdc, ContourData, rContourValues,
					rgbColors, nLineStyle, nLineWidth, 7,
					granularity, bContourLineFlags, bContourLabelFlags, 
					POS_LEFT, POS_ABOVE, 1, FALSE, GT_CONTOURLINE);

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "South");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "West");

    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Natick");

	{
	int borderColor, borderWidth, backColor;

	COLORREF lpTextColors[9];
	int lpShapes[9], lpSizes[9], lpStyles[9];

	LPSTR  lpLegStr;

	lpLegStr = (LPSTR) calloc (9, LG_MAXLEN);

	lstrcpy(lpLegStr, " Less Than -3.5");
	lstrcpy(lpLegStr + LG_MAXLEN, "-3.5 to -2.1");
	lstrcpy(lpLegStr + 2*LG_MAXLEN, "-2.1 to -1.1");
	lstrcpy(lpLegStr + 3*LG_MAXLEN, "-1.1 to 0.0");
	lstrcpy(lpLegStr + 4*LG_MAXLEN, "0.0 to 2.1");
	lstrcpy(lpLegStr + 5*LG_MAXLEN, "2.1 to 3.1");
	lstrcpy(lpLegStr + 6*LG_MAXLEN, "3.1 to 4.1");
	lstrcpy(lpLegStr + 7*LG_MAXLEN, "4.1 to 5.1");
	lstrcpy(lpLegStr + 8*LG_MAXLEN, "Greater than 5.1");

	// Legend text string colors
	for (i=0; i < 9; i++)
	{
	  lpTextColors[i] = RGB(0,0,0);	
	  lpShapes[i] = LG_BAR;
	  lpSizes[i] = 9; 
	  lpStyles[i] = LGS_FILLED;  
	}

    backColor = C_WHITE;
	borderColor = RGB(0,0,0);
	borderWidth = 4;

    WGSetTextParams (C_BLACK, FF_SWISS, 8, TEXT_NORMAL);

	WGFlexLegend (pGrDesc, hdc, 0.82, 0.60, 0.99, 0.98,
					borderColor, borderWidth, backColor, OR_HORZ,
					9, lpTextColors, lpShapes, rgbColors, 
					lpSizes, lpStyles, lpLegStr);

	free (lpLegStr);
	}
}


/**************************************************************************/
void CALLBACK DrawP3G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1, hDataSet2;

    hDataSet1 = WGDefineDataSet ("Raw Data", hX21, hY22, 10);
    hDataSet2 = WGDefineDataSet ("Raw Data 2", hX31, hY31, 10);

    WGSetPlotArea(pGrDesc, hdc, 0.1, 0.1, 0.9, 0.9, C_LIGHTGRAY);
	WGScalePlotArea(pGrDesc, 1982,0,2002,30);
	WGSetXYIntercepts(pGrDesc, 1982.0, 0.0);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);
    WGSetTextParams (C_BLACK, FF_SWISS, 10, 0);

    hAxisX = WGDrawXAxis(pGrDesc, hdc, 2.0, 7, POS_BELOW);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 5, 4, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL,
      -1, LL_ON, NULL);

    WGSetLineStyle (pGrDesc, hdc, PS_DOT, 1, C_BLACK);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3,C_CYAN);
    WGBargraph (pGrDesc, hdc, hDataSet1, 0.6, POS_MIDDLE,
		  LT_3DVBAR,RGB (255, 0, 0), -1, C_CYAN);

    WGBargraph (pGrDesc, hdc, hDataSet2, 0.6, POS_MIDDLE,
		  LT_3DVBAR,RGB (0, 60, 160), -1, C_CYAN);

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Year");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Millions of PC's SOLD");

    WGSetTextParams (C_BLACK, FF_SWISS, 16, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, " Personal Computers Sold Worldwide");
    WGSetTextParams (C_BLACK, FF_SWISS, 16, 0);
    WGText(pGrDesc, hdc,hAxisX, hAxisY,"Actual Reported Sales", 1982.5,
        13.0, TA_LEFT, 0);
    WGText(pGrDesc, hdc,hAxisX, hAxisY, "IWWF Forecast", 1994, 23.0,
        TA_LEFT, 0);
}

/**************************************************************************/
void CALLBACK DrawP3G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1;

    hDataSet1 = WGDefineDataSet ("Raw Data 3", hX21, hY32, 10);
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.9, C_BLACK);
   
	WGScalePlotArea(pGrDesc, 1982,0,1992,25);
	WGSetXYIntercepts(pGrDesc, 1982.0, 0.0);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);
    WGSetTextParams (C_BLACK, FF_SWISS, 7, 0);

    hAxisX = WGDrawXAxis(pGrDesc, hdc, 2, 0, POS_BELOW);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 5, 0, POS_LEFT);
   
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL,
      -1, LL_ON, NULL);

    WGSetLineStyle (pGrDesc, hdc, PS_DOT, 1, C_BLACK);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3,C_CYAN);
    WGBargraph (pGrDesc, hdc, hDataSet1, 0.75, POS_MIDDLE,
		  LT_VBAR,RGB (0, 160, 0), -1, C_CYAN);

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Year");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "10,000's SOLD");

    WGSetTextParams (C_BLACK, FF_SWISS, 8, 0);
    WGTitleGraph(pGrDesc, hdc, "Minicomputer Sales");
}

/*******************************************************
   Builds a 3D pie chart
********************************************************/

void CALLBACK DrawP4G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    realtype   ExplodeRel[NUMP4];
	int        i;
    HGOBJ     hPie;
    COLORREF   PieColor[NUMP4];

    // set the plotting area for the pie
    WGSetPlotArea(pGrDesc, hdc, 0.05, 0.05, 0.95, 0.95, C_WHITE);

    for (i = 0; i < NUMP4; i++)
		ExplodeRel[i] = 0.0;          // explosion coefficient
	ExplodeRel[5] = 0.35;              // explode this slice 35%

	PieColor[0] = WGGetRGBColor (C_YELLOW);//C_GREEN);
    PieColor[1] = WGGetRGBColor (C_LIGHTRED);
    PieColor[2] = WGGetRGBColor (C_LIGHTBLUE);
    PieColor[3] = WGGetRGBColor (C_LIGHTMAGENTA);
	PieColor[4] = RGB (0, 161, 228);//RGB (192, 65, 0);
	PieColor[5] = RGB (13, 188, 0);//WGGetRGBColor (C_BROWN);
    PieColor[6] = WGGetRGBColor (C_LIGHTGRAY);
    PieColor[7] = WGGetRGBColor (C_MAGENTA);
    PieColor[8] = WGGetRGBColor (C_LIGHTGREEN);
    PieColor[9] = RGB (255, 0, 108);
    PieColor[10] = RGB (128, 161, 255);//WGGetRGBColor (C_RED);

    // set current font to Modern, 10 points, bold
    WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);

    // Display a pie chart.  A 3D pie will be drawn,
	hPie = WGPieChart (pGrDesc, hdc, hPieData, NUMP4, PIE_3D, PIE_NUM_PERC,
		 PIE_OUT, 0.45, 0.6, 0.4, PieColor, NULL, NULL, ExplodeRel);

    // Initialize legend strings
    WGAutoLegendGroup (pGrDesc, hdc, 0.05, 0.05, C_RED, 1, -1,
        -1, OR_VERT, hPieStr, hPie);

    // set current font to ROMAN, 13 points, bold
    WGSetTextParams (C_BLACK, FF_SWISS, 13, TEXT_BOLD | TEXT_ITAL);
    WGTitleGraph (pGrDesc, hdc, "Monthly Expenses");

    WGSetLineStyle (pGrDesc, hdc, PS_SOLID, 2, C_LIGHTRED);
	WGArrowNorm (pGrDesc, hdc, 0.52, 0.88, 0.82, 0.68, 4, 8,
        FALSE, TRUE, TRUE);
    WGSetTextParams (C_GREEN, FF_SWISS, 14, TEXT_BOLD | TEXT_ITAL);

    WGRectangleNorm (pGrDesc, hdc, 0.20, 0.8, 0.56, 0.9, C_BLUE, 2, TRUE,
              WGGetRGBColor (C_LIGHTCYAN));
	WGTextNorm(pGrDesc, hdc, "Save for retirement!", 0.235, 0.82, 0, 0);
}
/**************************************************************************/

void CALLBACK DrawP5G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisXLog, hAxisYLog, hAxisXLin, hAxisYLin;
    HDATA   hDataSet1;

    hDataSet1 = WGDefineDataSet ("Fitted Data", hX51, hY51, NUMP10);

    WGSetTextParams (C_BLACK, FF_SWISS, 11, 0);

    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.125, 0.88, 0.875, C_WHITE);
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LOG);
    WGAutoAxes(pGrDesc, hdc, hDataSet1, AS_ROUNDCLOSE,
    	INTF_MIN, &hAxisXLog, &hAxisYLog, NULL, NULL);
  
    WGSetLineStyle (pGrDesc, hdc, PS_SOLID, 1, C_GRAY);

    WGDrawGrid(pGrDesc, hAxisXLog, GRID_MAJOR);
    WGDrawGrid(pGrDesc, hAxisYLog, GRID_ALL);
   
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
    WGLinePlot (pGrDesc, hdc, hDataSet1, FALSE, FALSE);

    WGSetTextParams (C_BLACK, FF_SWISS, 15, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Electron Density Function");
    WGSetTextParams (C_BLACK,  FF_SWISS, 11, 0);

    WGTitleAxis(pGrDesc, hdc, hAxisXLog, POS_BELOW, "Picometers");

    WGTitleAxis(pGrDesc, hdc, hAxisYLog, POS_LEFT, "Electron Density");

    WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR);
    WGAutoAxes(pGrDesc, hdc, hDataSet1, AS_ROUNDCLOSE,
	    INTF_MAX, &hAxisXLin, &hAxisYLin, NULL, NULL);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_YELLOW);
    WGLinePlot (pGrDesc, hdc, hDataSet1, TRUE, TRUE);
}
/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/
void CALLBACK DrawP6G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1, hDataSet2;
    HGLOBAL  hStr;
    LPSTR    lpstr;
	realtype rMinX, rMinY, rMaxX, rMaxY;
	realtype rTickSpaceX, rTickSpaceY;
	struct tm tStartDate = {0,0,0,0,0,0,0,0,0};

	COLORREF rgbColors[NUMP1];
	HGOBJ	 hStock;
	int		 i;
	HGLOBAL  hX, hY;
	LPREAL   lpX, lpY;
	LONG     nump;

    hDataSet1 = WGDefineGroupDataSet ("Q-C Stock", hX61, hY61, NUMP61, 4);
    hDataSet2 = WGDefineDataSet ("DOW Jones", hX61, hY62, NUMP61);

    WGSetPlotArea(pGrDesc, hdc, 0.10, 0.15, 0.95, 0.8, C_LIGHTGRAY);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGSetTextByName (C_BLUE, "Arial", 10, 0);

    WGGetMinMaxYGroup (hDataSet1,0, GROUP_ALL_Y, &rMinY,  &rMaxY);
    WGGetMinMaxX (hDataSet1,  &rMinX, &rMaxX);

    WGRoundAxis2 (pGrDesc, OR_HORZ, ST_LINEAR, 
           &rMinX,  &rMaxX, &rTickSpaceX, AS_ROUNDCLOSE);
    WGRoundAxis2 (pGrDesc, OR_VERT, ST_LINEAR, 
           &rMinY,  &rMaxY, &rTickSpaceY, AS_ROUNDCLOSE);
    rMinY = 0;
	WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);
	WGSetXYIntercepts (pGrDesc, rMinX ,rMinY);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 7.0, 6, POS_BELOW);
	tStartDate.tm_year = 1998;
	tStartDate.tm_mon = 5;
	tStartDate.tm_mday = 1;
    WGLabelAxisDate ( pGrDesc,  hdc,  hAxisX,  POS_BELOW, DATE_MDY, 
	   DTB_DATE_DAY, &tStartDate,	NULL, LL_ON, "DATE");   

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, rTickSpaceY, 9, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
 
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_CYAN);
    WGLinePlot (pGrDesc, hdc, hDataSet2, TRUE, FALSE);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3, C_YELLOW);
    hStock = WGStockOpenHighLowClose (pGrDesc, hdc, hDataSet1, 0.75);

    WGSetTextByName (C_BLUE, "Arial", 10, TEXT_BOLD);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Trading by Day");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Stock Price");
   
	WGSetTextByName (C_BLUE, "Arial", 15, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Stock Open-Hi-Low-Close Plot");

    WGSetTextByName (C_BLUE, "Times New Roman", 11, TEXT_ITAL);
    hStr = GlobalAlloc(GPTR, 2 * LG_MAXLEN);
    lpstr = GlobalLock(hStr);
    lstrcpy(lpstr, "Dow Jones");
    lstrcpy(lpstr + LG_MAXLEN, "Quinn-Curtis");

    WGLegend  (pGrDesc, hdc, 0.13, 0.10, 0.33, 0.35, C_RED, 2, C_BLUE, 
        C_WHITE, OR_VERT, hStr);

    GlobalFree (hStr);

    WGGetDataSetArrays (hDataSet1, &hX, &hY, &nump, NULL);
	lpX = (LPREAL) GlobalLock(hX);
	lpY = (LPREAL) GlobalLock(hY);

	for (i=0; i<nump; i++)
	{
		if (lpY[i*4+3]  < 14.0)
			rgbColors[i] = WGGetRGBColor(C_LIGHTGREEN);
		else if (lpY[i*4+3] > 27.0)
			rgbColors[i] = WGGetRGBColor(C_LIGHTRED);
		else
			rgbColors[i] = WGGetRGBColor(C_YELLOW);

	}
	WGSetMultiColors (pGrDesc, hStock, TRUE, rgbColors);
}

void CALLBACK DrawP6G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;                      
	HDATA   hDataSet;        
    int     i;
    int     nLineColor[5];
	struct tm tStartDate = {0,0,0,0,0,0,0,0,0};

    hDataSet = WGDefineDataSet ("Volume", hGX61, hGY61, NUMP62);

    WGSetPlotArea(pGrDesc, hdc, 0.10, 0.15, 0.95, 0.8, C_LIGHTGRAY);
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 50.0, 6500.0);
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 1000, 1, POS_LEFT);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 7.0, 6, POS_BELOW);

	tStartDate.tm_year = 1998;
	tStartDate.tm_mon = 5;
	tStartDate.tm_mday = 1;
    WGLabelAxisDate ( pGrDesc,  hdc,  hAxisX,  POS_BELOW, DATE_MDY, 
	   DTB_DATE_DAY, &tStartDate,	NULL, LL_ON, "DATE");   

    for (i = 0; i < 5; i++)
    	nLineColor [i] = i + 1;
	
	WGBargraph (pGrDesc, hdc, hDataSet, 1.0, POS_MIDDLE, 
			LT_3DVBAR, RGB(0, 94, 255), -1, C_YELLOW);
  
	WGSetTextByName (C_BLUE, "Arial", 8, 0);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    WGSetTextByName (C_BLUE, "Arial", 12, TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Trading Volume");
}

/***************************************************************************/
void CALLBACK DrawP7G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;       // axes handles
    HDATA   hDataSet;             // data set handle
    HGOBJ   hGroupB;		        // group data handle
    COLORREF RgbColor[NUMGROUP7];  // one color for each group
	int		HatchStyle[NUMGROUP7];
    HGLOBAL  hStr1;            // global memory handle to legends 
    LPSTR    lpstr1, lpYAxStr;

            // allocate global string array for legend
	hStr1 = GlobalAlloc(GMF, NUMGROUP7 * LG_MAXLEN);
        // allocate global string array for y axis strings
	hYAxStr = GlobalAlloc(GMF, NUMGROUP7 * LG_MAXLEN);
	lpstr1 = (LPSTR) GlobalLock (hStr1);
	lpYAxStr = (LPSTR) GlobalLock (hYAxStr);

	    // Initialize legend strings
    lstrcpy(lpstr1, "Wound Balata");
    lstrcpy(lpstr1 + LG_MAXLEN, "Wound Surlyn");
	lstrcpy(lpstr1 + 2 * LG_MAXLEN, "Two Piece Surlyn");
	
	// Initialize y axis strings
	lstrcpy(lpYAxStr, "");
    lstrcpy(lpYAxStr + LG_MAXLEN, "8-Iron");
    lstrcpy(lpYAxStr + 2 * LG_MAXLEN, "Driver");

    // define a dataset 
    hDataSet = WGDefineGroupDataSet ("Group", hY71, hX71, NUMP7, NUMGROUP7);

    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.05, 0.15, 0.95, 0.8, C_BLACK);
    
    // scale theplot area from x 0 to 11 and y -0.5 to 2.0
	WGScalePlotArea (pGrDesc, 0.0, -0.5, 11.0, 2.0);

    // set the intercepts to 0, -0.5
	WGSetXYIntercepts (pGrDesc, 0.0, -0.5);

    // Y-axis to be drawn as a solid line, black (background color), 1 pixels thick.
    // The y-axis will not be visible, however, the y axis labels will.
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks at every whole number, with no minor tics 
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 1, 0, POS_LEFT);

    // X axis to be drawn in solid, white, 2 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_WHITE);

    // draw the x axis with major ticks every 2 physical units and no minor tick between each major tick
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 2, 0, POS_ABOVE);

    // set current font to Roman family, 12 points, bold
    WGSetTextParams (C_WHITE, FF_SWISS, 12, TEXT_BOLD);

    // Label the x-axis, display labels below the axis, in decimal format,
    // 1 digit after the decimal point.  The last label is displayed
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

    WGSetTextParams (C_WHITE, FF_SWISS, 14, TEXT_BOLD);
    // label the y axis with strings, place these strings 
    // to the right of the axis
    WGLabelAxisStrings(pGrDesc, hdc, hAxisY, POS_RIGHT, LL_ON, hYAxStr);

    // assign each bar an RGB value
    RgbColor[2] = WGGetRGBColor (C_LIGHTBLUE);
    RgbColor[1] = RGB(64, 192, 128);//WGGetRGBColor (C_MAGENTA);
    RgbColor[0] = RGB(255, 215, 0);//WGGetRGBColor (C_LIGHTBLUE);

	HatchStyle[0] = -1; // no hatch
	HatchStyle[1] = HS_FDIAGONAL;
	HatchStyle[2] = -1;
    // display the horizontal group bar graph, center the bars
    hGroupB = WGGroupBargraph(pGrDesc, hdc, hDataSet, 0.2, POS_MIDDLE,
        LT_HBAR, GT_GROUPBARS, RgbColor, HatchStyle, NULL);

   // Write X axis title, and Graph Title
   // set current font to 10 point 
    WGSetTextParams (C_WHITE, FF_SWISS, 11, TEXT_NORMAL);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Thousands of revolutions per minute");

   // set current font to 14 point 
    WGSetTextParams (C_LIGHTGREEN, FF_SWISS, 18, TEXT_NORMAL | TEXT_BOLD);
    WGTitleGraph(pGrDesc, hdc, "Spin Rate Comparison");

    // now display some text at the end of each bar
    WGSetTextParams (C_WHITE, FF_MODERN, 11, TEXT_BOLD);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "60%",
        lpX71[0] + 0.025 * lpX71[0], lpY71[0] - 0.12, TA_LEFT, TEXT_NORMAL);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "70%",
        lpX71[1] + 0.025 * lpX71[1], lpY71[0] + .1, TA_LEFT, TEXT_NORMAL);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "100%",
        lpX71[2] + 0.025 * lpX71[2], lpY71[0] + .3, TA_LEFT, TEXT_NORMAL);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "80%",
		lpX71[3] + 0.025 * lpX71[3], lpY71[1] - 0.12, TA_LEFT, TEXT_NORMAL);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "90%",
        lpX71[4] + 0.025 * lpX71[4], lpY71[1] + .1, TA_LEFT, TEXT_NORMAL);
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "100%",
        lpX71[5] + 0.025 * lpX71[5], lpY71[1] + .3, TA_LEFT, TEXT_NORMAL);
   
    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_ITAL | TEXT_BOLD);

    // draw a transparent horizontal group legend,
    // outline the window in red and output the text in white
    WGLegendGroup(pGrDesc, hdc, 0.13, 0.13, 0.88, 0.23, C_RED, 2, 
		C_BLACK, C_LIGHTGRAY,
    	OR_HORZ, hStr1, hGroupB);
    GlobalFree (hStr1);  
}

/***********************************************************************/
void CALLBACK DrawP8G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
	HDATA	hRainData, hSunData;
	HDATA	hRainAvg;
	HGOBJ   hRainAct;
	COLORREF rgbColors[NUMP8];
	int		i;

	hRainData = WGDefineDataSet ("Rain", hX81, hY82, NUMP8);
	hSunData = WGDefineDataSet ("Sunshine", hX81, hY81, NUMP8);

	hRainAvg = WGDefineDataSet ("Avg.Rain", hX81, hY83, NUMP8);

	WGSetPlotArea(pGrDesc, hdc, 0.1, 0.10, 0.925, 0.83, C_LIGHTGRAY);
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 13.0, 10.0);
	WGSetXYIntercepts(pGrDesc, 0.0, 0.0);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_WHITE);
//	WGSetTextByName (C_WHITE, "Courier New", 10, 0);
    WGSetTextParams (C_WHITE, FF_SWISS, 10, 0);
	
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 0, POS_BELOW);

	WGLabelAxisMonth (pGrDesc, hdc, hAxisX, POS_BELOW, 1, 1, TRUE);

    WGSetTextParams (C_WHITE, FF_SWISS, 12, 0);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 2.0, 1, POS_LEFT);
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 0, C_GRAY);
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_BLACK);

    WGSetTextParams (C_WHITE, FF_SWISS, 12, TEXT_BOLD);
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Rain/Snow Inches");

//	WGSetTextByName (C_WHITE, "Courier New", 10, 0);
    WGSetTextParams (C_WHITE, FF_SWISS, 10, 0);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Boston Monthly Averages and Actuals");

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3, C_YELLOW);
	hRainAct = WGLinePlot (pGrDesc, hdc, hRainData, FALSE, FALSE);
	WGScatterPlotEx (pGrDesc, hdc, hRainData, 
				   MK_METAFILE, "umbrell4.wmf", 20, FALSE);
    WGSetTextParams (C_YELLOW, FF_SWISS, 12, TEXT_BOLD);
//	WGSetTextByName (C_CYAN, "Courier New", 10, 0);
	WGText (pGrDesc, hdc, hAxisX, hAxisY, "Actual &", 6.0, 9.5,
			TA_LEFT, 0);
//	WGSetTextByName (C_BLACK, "Courier New", 10, 0);
    WGSetTextParams (C_LIGHTRED, FF_SWISS, 12, TEXT_BOLD);
	WGText (pGrDesc, hdc, hAxisX, hAxisY, "Projected", 6.0, 8.75,
			TA_LEFT, 0);
	
	for (i=0; i<NUMP8; i++)
		if (i<6)
			rgbColors[i] = WGGetRGBColor(C_YELLOW);
		else 
			rgbColors[i] = WGGetRGBColor(C_LIGHTRED);
	WGSetMultiColors (pGrDesc, hRainAct, TRUE, rgbColors);
#if 0	
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_LIGHTRED);
	WGLinePlot (pGrDesc, hdc, hSunData, FALSE, FALSE);
	WGScatterPlotEx (pGrDesc, hdc, hSunData, 
				   MK_METAFILE, "sun2.wmf", 20, FALSE);
#endif
	// Plot Averages
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_LIGHTGREEN);
	WGLineMarkerPlot (pGrDesc, hdc, hRainAvg, MK_DOWNTRIANGLE,
						C_BLUE, 8, MKS_FILLED);
    WGSetTextParams (C_BLUE, FF_SWISS, 12, TEXT_BOLD);
//	WGSetTextByName (C_BLUE, "Courier New", 10, 0);
	WGText (pGrDesc, hdc, hAxisX, hAxisY, "Average", 6, 2.1,
			TA_LEFT, 0);

    WGSetTextParams (C_LIGHTGREEN, FF_SWISS, 16, TEXT_BOLD);
//	WGSetTextByName (C_LIGHTGREEN, "Courier New", 16, TEXT_BOLD);
	WGTitleGraph(pGrDesc, hdc, "El Nino 1998");
}

/***************************************************************************/

void CALLBACK DrawP9G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;   // axes handles
    HDATA   hDataSig;         // signal data set handle

    // define a signal dataset 
    hDataSig = WGDefineDataSet ("Signal", hTime, hSignal, NUMPFFT);
    if (hDataSig == 0) // check if data set is good
        return ;

    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.1, 0.14, 0.95, 0.8, C_WHITE);
    WGScalePlotArea(pGrDesc, 0.0, -30.0, 101.0, 30.0);
    WGSetXYIntercepts(pGrDesc, 0.0, -30.0);

	// axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
	// set current font to Arial, 11 points
    WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);
    // draw and label axes
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 25.0, 4, POS_BELOW);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10.0, 1, POS_LEFT);
    // set line style of actual plot to MAGENTA
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_MAGENTA);
    // plot the original signal 
    WGLinePlot (pGrDesc, hdc, hDataSig, FALSE, FALSE);

    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1,
        LL_TEXT, "mSec");
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL,
      -1, LL_TEXT, "V");

		// set current font to Arial, 11 points, bold, italic
    WGSetTextParams (C_BLACK, FF_SWISS, 11, TEXT_BOLD);
	// Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Time");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Signal");

		// set current font to Arial, 14 points, bold
    WGSetTextParams (C_BLACK, FF_SWISS, 14, TEXT_BOLD);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "Original Waveform");
}
/***************************************************************************/
void CALLBACK DrawP9G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;   // axes handles
    HDATA   hDataPow;         // handle for power spectrum data set
    int i;

    for (i = 0; i < NUMPFFT; i++)
    {
        *(pPower + i) = *(pSignal + i);
        *(pPowFreq + i) = 0.0;
    }
    // calculate power spectrum of the original signal
    WGPowerSpectrum (pPower, pPowFreq, NUMPFFT, MAXTIME /1000.0 / NUMPFFT);

    // define power spectrum data set (use only first half of array)
    hDataPow = WGDefineDataSet ("Power Spectrum", hPowFreq, hPower,
        NUMPFFT /2);

    // define the plotting area of the graph 
	WGSetPlotArea(pGrDesc, hdc, 0.15, 0.13, 0.91, 0.78, C_WHITE);
	WGScalePlotArea(pGrDesc, 0.0, 0.0, 100.0, 50.0); // 800 dmb, 42.0, dmb
	WGSetXYIntercepts(pGrDesc, 0.0, 0.0);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGSetTextParams (C_BLACK, FF_SWISS, 10, TEXT_BOLD);

    // draw and label axes
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 20.0, 4, POS_BELOW);
    if (hAxisX == 0)
        return ;
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_TEXT, "Hz");
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10.0, 1, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);

    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_BLACK);
    // draw an x axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);

    // draw an y axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    WGBargraph (pGrDesc, hdc, hDataPow, 3.0, POS_MIDDLE,
		  LT_VBAR, RGB (255, 0, 0), -1, -1);

	WGSetTextParams (C_YELLOW, FF_SWISS, 9, TEXT_BOLD);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Frequency");

    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Power");
    WGSetTextParams (C_BLUE, FF_SWISS, 12, TEXT_BOLD);
    WGTitleGraph (pGrDesc, hdc, "Power Spectrum");
}
/***************************************************************************/
void CALLBACK DrawP9G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ	hWaterfall;
	HGOBJ   hAxisX, hAxisY;  // axes handles
    int     nLineColor[NUMGROUP9];
    int     nLineColor2[NUMGROUP9];
	int		nLineWidth[NUMGROUP9];
	int		i;	

    WGSetPlotArea(pGrDesc, hdc, 0.125, 0.15, 0.95, 0.80, C_LIGHTGRAY);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 200.0, 150.0);
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    hAxisX = WGDrawXAxis(pGrDesc, hdc, 50.0, 4, POS_BELOW);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 50.0, 4, POS_LEFT);

    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_ON, NULL);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    // Set line style of outline to be black, dotted
    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_BLACK);

	for (i=0; i<NUMGROUP9; i++)
	{
		nLineWidth[i] = 1;
		nLineColor[i] = i%16;
		nLineColor2[i] = (i%8) + 4;
	}
    hWFDataSet = WGDefineGroupDataSetPtr ("Waterfall Plot", lpIndWater, 
											lpDepWater, NUMP9, NUMGROUP9);

	hWaterfall = WGWaterfallPlot (pGrDesc, hdc, hWFDataSet, 1.5, 3.5,  
						TRUE, TRUE, TRUE, NULL, nLineWidth, nLineColor);
					// fill, baseline, outline

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

    WGSetTextByName (C_BLUE, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
    WGTitleGraph(pGrDesc, hdc, "Waterfall Plot");
}

/***************************************************************************/
void CALLBACK DrawP10G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    int n;
    HGOBJ   hAxisX, hAxisY;                      
    HDATA   hDataSet1, hDataSet2;
    LPSTR    lpstr;

    hDataSet1 = WGDefineGroupDataSet ("Project", hX101, hY101, 4, NUMG10);
    hDataSet2 = WGDefineGroupDataSet ("Project", hX102, hY102, 4, NUMG10);

    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.95, 0.85, C_YELLOW);

    WGSetLineStyle(pGrDesc,hdc, PS_SOLID, 1, C_BLACK);
    WGSetTextParams (C_BLACK, FF_MODERN, 10, 0);

	WGScalePlotArea(pGrDesc, 85, 0.0, 96, 12.0);

	WGSetXYIntercepts(pGrDesc, 85, 12.0);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 3, POS_ABOVE);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_ABOVE, NF_DECIMAL,
      -1, LL_ON, NULL);

	WGSetXYIntercepts(pGrDesc, 85, 0.0);
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 3, POS_BELOW);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL,
      -1, LL_ON, NULL);

    n = 13;
    hFloStr = GlobalAlloc(GMF, n * LABELLEN);
	lpstr = GlobalLock(hFloStr);

    lstrcpy(lpstr+11 * LABELLEN, "CYRIX 486");
    lstrcpy(lpstr+10 * LABELLEN, "INTEL 486");
    lstrcpy(lpstr+9 * LABELLEN, "");
    lstrcpy(lpstr+8 * LABELLEN, "CYRIX 586");
    lstrcpy(lpstr+7 * LABELLEN, "INTEL 586");
    lstrcpy(lpstr+6 * LABELLEN, "");
    lstrcpy(lpstr+5 * LABELLEN, "CYRIX 686");
    lstrcpy(lpstr+4 * LABELLEN, "INTEL 686");
    lstrcpy(lpstr+3 * LABELLEN, "");
    lstrcpy(lpstr+2 * LABELLEN, "CYRIX 786");
    lstrcpy(lpstr+1 * LABELLEN, "INTEL 786");
    lstrcpy(lpstr,"");
 
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 1, 0, POS_LEFT);

    WGLabelAxisStrings(pGrDesc, hdc, hAxisY, POS_LEFT, 0, hFloStr);

    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Development Cycle Timetable");

    WGSetLineStyle(pGrDesc,hdc, PS_DOT, 1, C_BLACK);
    WGDrawGrid(pGrDesc, hAxisX, GRID_MAJOR);
   
    WGFloatingBars (pGrDesc, hdc, hDataSet1, 0.95, POS_MIDDLE,
       LT_HBAR,RGB (160, 160, 0), -1, C_CYAN);

    WGFloatingBars (pGrDesc, hdc, hDataSet2, 0.95, POS_MIDDLE,
       LT_HBAR,RGB (160, 0, 0), -1, C_CYAN);

    WGSetTextParams (C_BLACK, FF_SWISS, 15, 0);
    WGTitleGraph(pGrDesc, hdc, "CYRIX TRIES TO BEAT INTEL AT ITS OWN GAME");
    WGSetTextParams (C_BLACK, FF_SWISS, 10, 0);
    lstrcpy(lpstr, "INTEL");
    lstrcpy(lpstr + LG_MAXLEN, "CYRIX");
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGLegend(pGrDesc, hdc, 0.78, 0.19, 0.96, 0.4, 0,3,0, 15, OR_VERT, hFloStr);
}

/**************************************************************************/
void CALLBACK DrawP11G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;  // axes handles

    hLiveData = WGDefineDataSet ("Live Data Set", hX111, hY111, NUMP11);
    hLiveData2 = WGDefineDataSet ("Data Set", hX112, hY112, NUMP11);
    hLiveData3 = WGDefineDataSet ("Set", hX113, hY113, NUMP12);

    WGSetPlotArea(pGrDesc, hdc, 0.1, 0.1, 0.9, 0.85, C_BLACK);

    //WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGScalePlotArea(pGrDesc, 0.0, 0.0, 16.0, 80.0);
    WGSetXYIntercepts(pGrDesc, 0.0, 0.0);

    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_BOLD);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // draw and label axes
    hAxX = hAxisX = WGDrawXAxis(pGrDesc, hdc, 2, 9, POS_BELOW);
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);
    hAxY = hAxisY = WGDrawYAxis(pGrDesc, hdc, 20, 4, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);

    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

    WGDrawGrid (pGrDesc, hAxX, GRID_MAJOR);
    WGDrawGrid (pGrDesc, hAxY, GRID_MAJOR);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_LIGHTRED);

    hPlot = WGLinePlot (pGrDesc, hdc, hLiveData, FALSE, FALSE);
    if (hPlot == 0)
        return ;

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_YELLOW);
    hPlot2 = WGLinePlot (pGrDesc, hdc, hLiveData2, FALSE, FALSE);
    if (hPlot2 == 0)
        return;

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_LIGHTGREEN);
    hPlot3 = WGScatterPlot (pGrDesc, hdc, hLiveData3, 
				MK_BOX, C_LIGHTBLUE, 7, MKS_CDOT, FALSE);
    if (hPlot3 == 0)
        return;

    WGSetTextParams (C_WHITE, FF_SWISS, 11, TEXT_BOLD);

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

    WGSetTextParams (C_WHITE , FF_SWISS, 16, TEXT_BOLD);

    WGTitleGraph(pGrDesc, hdc, "Dynamic Trend");
	WGSetGraphBitBltMode(pGrDesc, TRUE);

}

/***************************************************************************/
void CALLBACK DrawPIntG3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_RED, FF_SWISS, CAPTHEIGHT, 0);
	WGTextNorm(pGrDesc, hdc, szCapInt1, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCapInt2, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCapInt3, CAPTLEFT, CAPTTOP + 2 * CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawPZoomG3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_RED, FF_SWISS, CAPTHEIGHT, 0);
	WGTextNorm(pGrDesc, hdc, szCapZoom1, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCapZoom2, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCapZoom3, CAPTLEFT, CAPTTOP + 2 * CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawPDlgG2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	WGSetTextParams (C_BLUE, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCapDlg1, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCapDlg2, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}

/***************************************************************************/
void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap11, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
  	WGTextNorm(pGrDesc, hdc, szCap12, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP2G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap21, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap22, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap23, CAPTLEFT, CAPTTOP + 2 * CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP3G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap31, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP4G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap41, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap42, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP5G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.

    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap51, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap52, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP6G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap61, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap62, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP7G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap71, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap72, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP8G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	// Select font of family "FF_SWISS", CAPTHEIGHT points.
	WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap81, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap82, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP9G4 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	// Select font of family "FF_SWISS", CAPTHEIGHT points.
	WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap91, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap92, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP10G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap101, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawP11G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    // Select font of family "FF_SWISS", CAPTHEIGHT points.
    WGSetTextParams (C_BLACK, FF_SWISS, CAPTHEIGHT, 0);

	WGTextNorm(pGrDesc, hdc, szCap111, CAPTLEFT, CAPTTOP, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szCap112, CAPTLEFT, CAPTTOP + CAPTINT, TA_LEFT, 0);

}
/***************************************************************************/
void CALLBACK DrawPHead (PGRAPH_DEF pGrDesc, HDC hdc)
{
    WGSetTextParams (C_LIGHTCYAN, FF_SWISS, 22, TEXT_BOLD | TEXT_ITAL);
	WGTextNorm(pGrDesc, hdc, szTit, 0.03, 0.06, TA_LEFT, 0);
    WGSetTextParams (C_LIGHTBLUE, FF_SWISS, 8, TEXT_BOLD | TEXT_ITAL);
#ifdef WIN32
	WGTextNorm(pGrDesc, hdc, szVer32, 0.03, 0.37, TA_LEFT, 0);
#else
	WGTextNorm(pGrDesc, hdc, szVer16, 0.03, 0.37, TA_LEFT, 0);
#endif

    WGSetTextParams (C_BLACK, FF_SWISS, 9, 0);
	WGTextNorm(pGrDesc, hdc, szLogo1, 0.03, 0.5, TA_LEFT, 0);

    WGSetTextParams (C_BLACK, FF_SWISS, 9, 0);
	WGTextNorm(pGrDesc, hdc, szLogo2, 0.03, 0.6, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szLogo3, 0.03, 0.7, TA_LEFT, 0);
	WGTextNorm(pGrDesc, hdc, szLogo4, 0.35,  0.7, TA_LEFT, 0);

    WGSetTextParams (C_BLACK, FF_SWISS, 9, 0);
	WGTextNorm(pGrDesc, hdc, szLogo5, 0.03,  0.8, TA_LEFT, 0);
}
/***************************************************************************/
void CALLBACK DrawPPict (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HDATA    hDataSet;
	LPREAL   lpX, lpY;
	COLORREF RgbColor[3];

	lpX = (LPREAL) GlobalLock(hXPict);
	lpY = (LPREAL) GlobalLock(hYPict);

	lpX[0] = 2.0;

	lpY[0] = 9.0;
	lpY[1] = 6.0;
	lpY[2] = 8.0;

	hDataSet = WGDefineGroupDataSet ("Pict", hXPict, hYPict, 1, 3);

	WGSetPlotArea(pGrDesc, hdc, 0.07, 0.07, 0.93, 0.92, C_GREEN);
	WGScalePlotArea(pGrDesc, 0.0, 0.0, 4.0, 10.0);

	WGSetXYIntercepts(pGrDesc, 0.0, 0.0);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

	WGDrawXAxis(pGrDesc, hdc, 2, 0, POS_BELOW);
	WGDrawYAxis(pGrDesc, hdc, 5.0, 0, POS_LEFT);

	// assign each bar an RGB value
	RgbColor[0] = WGGetRGBColor (C_YELLOW);
	RgbColor[1] = WGGetRGBColor (C_LIGHTBLUE);
	RgbColor[2] = WGGetRGBColor (C_LIGHTRED);

	WGGroupBargraph(pGrDesc, hdc, hDataSet, 0.75, POS_MIDDLE,
		LT_VBAR, GT_GROUPBARS, RgbColor, NULL, NULL);
}

