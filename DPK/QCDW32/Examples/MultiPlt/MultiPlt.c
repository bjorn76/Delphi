//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   MultiPlt.c                                 *
//*   Author   :   DMB                                        *
//*   Revision :   3.0                                        *
//*   Date     :   June 10, 1998                              *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example building using multi-line text 	  *
//*					strings and multiple colors within a 	  *
//*					simple plot								  *
//*                                                           *
//*************************************************************

/*
    The project for this demo includes:

    MULTIPLT.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"

#define NUMP1 8                    // number of data points

HINSTANCE   hInst;                 // global instance handle

LPSTR   lpXStr;                    // string array 
		   
LPREAL  lpX1, lpY1, lpY2;          // data arrays 

char szAppName[] = "MDemo";  /* Class Name used in call to CreateWindow. */

HGOBJ hTextLeft, hTextCenter, hTextRight;
HGOBJ hTextLeft2, hTextCenter2, hTextRight2;
PGRAPH_DEF pGraph1;
HDATA   hDataSet, hDataSet2;        // data set handles

HGOBJ hMultiText;
HGOBJ hMulti2;

// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);  
void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);

realtype randreal(void);

HGOBJ hBar, hScat, hLineMark, hLine;
BOOL bSucc;

COLORREF rgbColors[NUMP1];
COLORREF rgbLineMarkColors[NUMP1];
COLORREF rgbLineColors[NUMP1];	// for line plot


/*******************************************************
  FUNCTION: WinMain (HINSTANCE, HINSTANCE, LPSTR, int)

  PURPOSE: calls initialization function,
           processes message loop
********************************************************/

int PASCAL WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
                    LPSTR lpCmdLine, int nCmdShow)
{
  MSG msg;

  if (!hPrevInstance)
     if (!InitApplication(hInstance))
        return (FALSE);

  if (!InitInstance(hInstance, nCmdShow))
     return (FALSE);

  // Message loop
	while (GetMessage(&msg, NULL, 0, 0))
  {
     TranslateMessage(&msg);
     DispatchMessage(&msg);
  };
  return (msg.wParam);
}

/*******************************************************
  FUNCTION: InitApplication (HINSTANCE)
  PURPOSE: Initializes window data and
           registers window classes
********************************************************/

BOOL InitApplication (HINSTANCE hInstance)
{
    WNDCLASS  wc;

    // main window class
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = MainWndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = LoadIcon(hInstance, "LOGO");
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH) GetStockObject (WHITE_BRUSH);
    wc.lpszMenuName = NULL;
    wc.lpszClassName = szAppName;

    return (RegisterClass(&wc));
}

/*******************************************************
  FUNCTION: InitInstance(HINSTANCE, int)
  PURPOSE:  Saves instance handle and creates main window
********************************************************/
BOOL InitInstance (HINSTANCE hInstance, int nCmdShow)
{
    HWND   hwnd;

    // save current instance MUST BE HERE
    hInst = hInstance; 
   
    hwnd = CreateWindow
    (
      szAppName,                           // Create main window
      "Bar graph demo",                    // Main window title
      WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
      CW_USEDEFAULT,      CW_USEDEFAULT,
      CW_USEDEFAULT,      CW_USEDEFAULT,
      NULL,               NULL,
      hInstance,
      NULL
    );
  
    if (!hwnd)
      return (FALSE);
  
    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);
    return (TRUE);
}

/*************************************************************************
    Main window procedure
**************************************************************************/

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    	case WM_CREATE:
    	  	WGCreatePage("PAGE1",	 // page ID string
            		hwnd, 		     // handle to the parent window
            		hInst,		     // application instance handle 
            		"Bar Graph",	 // Window title string
            		StartPage1, 	 // pointer to graph creation function
            		"PageMenu",	     // Name of page window menu in resource file
            		C_LIGHTGRAY,     // window background color
            		MM_PROPORT,      // window sizing mode
            		0L,              // window style - default
            		PAGE_FULL,     // window initial size and position option
		        0, 0, 0, 0);         // initial window size and position
                        		     //  (not used here)
            return 0;

        case WM_DESTROY:
            free (lpX1);
        	free (lpY1);
    	    free (lpY2);

    	    WGCleanup(FALSE);            // clean up charting tools memory
			free (lpXStr);
            PostQuitMessage(0);
            return 0;
    }
    return (DefWindowProc(hwnd, message, wParam, lParam));
}

/**********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
***********************************************************************/

void CALLBACK StartPage1(PPAGE_DEF pPageDesc)
{
    int     i;
    realtype z;
    static  BOOL fInit = TRUE;
    // create simulation data for plot
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate data arrays
        lpX1 = calloc (NUMP1,  sizeof (realtype));
    	lpY1 = calloc (NUMP1,  sizeof (realtype));
    	lpY2 = calloc (NUMP1,  sizeof (realtype));

        // array for x-axis string labels
		lpXStr = calloc (NUMP1 - 1, LABELLEN); 
        // create x and y data to be plotted
        for (i = 0; i < NUMP1; i++)
        {
            z = (realtype) i;
            lpX1 [i] = z;
        }
        lpY1[0] = 50.0;
        lpY1[1] = 26.2;
        lpY1[2] = 111.2;
        lpY1[3] = 116.6;
        lpY1[4] = -871.3;
        lpY1[5] = 28.6;
    	lpY1[6] = -138.3;
        lpY1[7] = -294.1;

        lpY2[0] = 20.0;
        lpY2[1] = 22.25;
        lpY2[2] = 18.75;
        lpY2[3] = 12.5;
        lpY2[4] = 8.25;
        lpY2[5] = 11.0;
    	lpY2[6] = 12.0;
        lpY2[7] = 11.5;


		// copy strings to x axis string array, be sure to index correctly when
        // assigning each string!
		lstrcpy (lpXStr, "3Q96");
		lstrcpy (lpXStr + LABELLEN, "4Q96");
		lstrcpy (lpXStr + 2 * LABELLEN, "1Q97");
		lstrcpy (lpXStr + 3 * LABELLEN, "2Q97");
		lstrcpy (lpXStr + 4 * LABELLEN, "3Q97");
		lstrcpy (lpXStr + 5 * LABELLEN, "4Q97");
		lstrcpy (lpXStr + 6 * LABELLEN, "1Q98");

        fInit = FALSE;
    }
/*--------------------------------------------------------------*/

      // Initialize graph 
		pGraph1 = WGCreateGraph (pPageDesc,
                 DrawGraphP1G1, // points to function which builds graph
                 0.002, 0.002,  // window relative position inside parent page window
                 0.998, 0.998,
                 C_GREEN,       // yellow background
                 C_BLACK,       // black border
                 1);            // border width in pixels

}

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;  // axes handles
	int i;

    // define a dataset 
    hDataSet = WGDefineDataSetPtr ("Loss", lpX1, lpY1, NUMP1);
    hDataSet2 = WGDefineDataSetPtr ("Stock Price", lpX1, lpY2, NUMP1);

    // define the plotting area of the graph,
    // set the background color of the plotting area to light cyan
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.80, C_PALEBLUE);

    // scale the plotting are for an x range of 0 to 7.95
    // and y range of -900 to 200
	WGScalePlotArea (pGrDesc, 0.0,-900.0, 7.95, 200.0);

    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis with major ticks every physical coord and 0 minor tick
    // the ticks will be positioned at the center of the axis
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 0, POS_MIDDLE);

    // Y axis to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 100 physical coords and 1 minor ticks
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 100.0, 1, POS_LEFT);

    // draw an axis grid on the major tick intervals
    WGDrawGrid(pGrDesc, hAxisY, GRID_MAJOR);

	for (i=0; i<NUMP1; i++)
	{
		rgbColors[i] = WGGetRGBColor(i);
		rgbLineMarkColors[i] = WGGetRGBColor(i + 9);
		rgbLineColors[i] = WGGetRGBColor(i + 9);
	}

	// *---------------------------------------------------------
	// Draw plots using multiple colors - one for each data point
	// display a bar graph with centered bars, width equals 0.9, no hatching or border
	hBar = WGBargraph (pGrDesc, hdc, hDataSet, 0.9, POS_MIDDLE, LT_3DVBAR, 
		    WGGetRGBColor (C_MAGENTA), -1, -1); 
	bSucc = WGSetMultiColors (pGrDesc, hBar, TRUE, rgbColors);

	hScat = WGScatterPlot (pGrDesc, hdc, hDataSet, MK_DOWNTRIANGLE, C_WHITE, 
				   18, MKS_FILLED, FALSE);
	bSucc = WGSetMultiColors (pGrDesc, hScat, TRUE, rgbColors);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_YELLOW);
	hLineMark = WGLineMarkerPlot (pGrDesc, hdc, hDataSet, 
								  MK_CIRCLE, C_YELLOW, 10, MKS_FILLED);
	bSucc = WGSetMultiColors (pGrDesc, hLineMark, TRUE, rgbLineMarkColors);

	// *---------------------------------------------------------

    // set the font to Arial, size 10
    WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);

	// Label the axes with strings, display labels at the bottom of the plotting area
	WGLabelAxisStringsPtr(pGrDesc, hdc, hAxisX, POS_BELOW_PLOT, 1, lpXStr);

    // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);

    // set line style of arrow to solid, BLACK, 0 pixels wide
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_BLACK);

    // draw an arrow.  This arrow will point to the left, and will be filled
    WGArrow (pGrDesc, hdc, hAxisX, hAxisY, 4.55, -785.0, 5.5, -775.0, 6, 6, TRUE, FALSE, TRUE);

    // load the 'star' meta file and display it in the plotting area
    WGMetafile (pGrDesc, hdc, hAxisX, hAxisY, 4.25, -450.0, 7.25, -850.0,
            "STAR.WMF");

	// *---------------------------------------------------------
	// Draw various multi-line text strings, with different angles
	// and colors
	WGSetTextByName (C_BLACK, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
	hMultiText =  WGMultiText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Multiple\f\rLines \f\rof Text", 1.0, -450.0,
		    TA_LEFT, TEXT_NORMAL);

	// Rotated 30 degrees
	WGSetTextByName (C_RED, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
	hMultiText =  WGMultiText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Multiple\f\rLines \f\rof Text", 2.5, -450.0,
		    TA_LEFT, 300); 

	// Rotated 90 degrees
	WGSetTextByName (C_GREEN, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
	hMultiText =  WGMultiText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Multiple\f\rLines \f\rof Text", 7.0, -450.0,
		    TA_LEFT, TEXT_VERTLEFT);

	// Rotated 270 degrees
	WGSetTextByName (C_BLUE, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
	hMultiText =  WGMultiText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Multiple\f\rLines \f\rof Text", 7.0, -450.0,
		    TA_LEFT, TEXT_VERTRIGHT);

	// Rotated 0 degrees
	WGSetTextByName (C_YELLOW, "Arial", 16, TEXT_BOLD | TEXT_ITAL);
	hMulti2 = WGMultiText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Multiple\f\rLines \f\rof Text", 7.0, -450.0,
		    TA_LEFT, TEXT_NORMAL);

    // Now output 3 strings in the center of the metafile 'star'
	hTextCenter2 = WGText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Big Loss", 5.75, -610.0,
			TA_CENTER, TEXT_NORMAL);

	WGSetTextByName (C_BLUE, "Arial", 10, TEXT_BOLD);
	hTextLeft2 = WGText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Big Loss", 5.75, -655.0,
		    TA_LEFT, TEXT_NORMAL);

	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD);
	hTextRight2 = WGText (pGrDesc, hdc, hAxisX, hAxisY, 
			"Big Loss", 5.75, -655.0,
		    TA_RIGHT, TEXT_NORMAL);

	// 3 multi-text string with different alignment
	WGSetTextByName (C_WHITE, "Arial", 12, TEXT_BOLD);
	hTextCenter = WGTextNorm (pGrDesc, hdc, "CENTER STRING", 0.5, 0.27, 
			TA_CENTER | TA_BOTTOM, TEXT_NORMAL);
	WGSetTextByName (C_YELLOW, "Arial", 12, TEXT_BOLD);
	hTextLeft = WGTextNorm (pGrDesc, hdc, "LEFT STRING", 0.5, 0.3, 
			TA_LEFT, TEXT_NORMAL);
	WGSetTextByName (C_LIGHTRED, "Arial", 12, TEXT_BOLD);
	hTextRight = WGTextNorm (pGrDesc, hdc, "RIGHT STRING", 0.5, 0.3, 
			TA_RIGHT, TEXT_NORMAL);

	// Additional test of more rotations with WGMultiTextNorm 
	WGSetTextByName (C_BLACK, "Arial", 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, hdc, "RIGHT\n STRING", 
			0.2, 0.4, TA_LEFT, TEXT_NORMAL);

	WGSetTextByName (C_RED, "Arial", 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, hdc, "RIGHT\n STRING", 
			0.3, 0.4, TA_LEFT, 300);

	WGSetTextByName (C_BLUE, "Arial", 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, hdc, "RIGHT\n STRING", 
			0.4, 0.4, TA_LEFT, TEXT_VERTLEFT);

	WGSetTextByName (C_WHITE, "Arial", 12, TEXT_BOLD);
	WGMultiTextNorm (pGrDesc, hdc, "RIGHT\n STRING", 
			0.5, 0.4, TA_LEFT, TEXT_VERTRIGHT);
	// *---------------------------------------------------------

    // set current font to Arial, 12 points
    WGSetTextByName (C_WHITE, "Arial", 12, 0);

    // Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Quarter");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Millions of dollars");

    // plot second data set in different coordinates
    // scale the plotting are for an x range of 0 to 7.95
    // and y range of 0 to 25
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 7.95, 25.0);

    // set the intercepts to right side 
	WGSetXYIntercepts (pGrDesc, 7.95, 0.0);

    // Second Y axis to be drawn in solid, Red, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_RED);

    // draw the y axis with major ticks every 5 physical coords and 4 minor ticks
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_RIGHT);

    // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_RIGHT, NF_DECIMAL, 1, LL_TEXT, "$");
    
	// plot stock price data 
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 4, C_LIGHTRED);
	hLine = WGLinePlot (pGrDesc, hdc, hDataSet2, FALSE, FALSE);
	bSucc = WGSetMultiColors (pGrDesc, hLine, TRUE, rgbLineColors);

    // set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_WHITE, "Arial", 16, TEXT_BOLD | TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "BIG Computer Co.");
}

/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}
/***********************************************************************/

