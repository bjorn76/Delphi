//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   ScatStep.C                                 *
//*   Author   :   DMB										  *
//*   Revision :   3.0                                        *
//*   Date     :   June 8, 1998                               *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of bitmap and metafile scatter     *
//*                plot symbols, and a line plot with         *
//*                staircase step                             *
//*                                                           *
//*************************************************************

/*
	Special Features for this demo are:

    - Displays a line plot with a staircase step - WGLinePlotEx

	- Displays a scatter plot with a user defined bitmap and
	metafile - WGScatterPlotEx

	The project for this demo includes:

	SCATSTEP.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"

#define NUMP1 25                  // number of data points
#define NUMP2 5

HINSTANCE     hInst;              // global instance handle

LPREAL  lpX1, lpY1;
LPREAL	lpX2, lpY2, lpY3, lpY4;
LPREAL	lpX5, lpY5;

HGOBJ hLegend;
HGOBJ hScatX, hScat2;
PGRAPH_DEF pGraph1;

HGOBJ   hTextX, hTextY;  


char szAppName[] = "LineMark";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message,
                             WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);

realtype randreal(void);

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
    wc.hbrBackground = (HBRUSH) GetStockObject (LTGRAY_BRUSH);
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
      szAppName,                 // Create main window
      "Demo LineMark",           // Main window title
      WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
      CW_USEDEFAULT,        CW_USEDEFAULT,
      CW_USEDEFAULT,        CW_USEDEFAULT,
      NULL,
      NULL,
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

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam,
    LPARAM lParam)
{
    switch (message)
    {
	    case WM_CREATE:
          // page is created in the current window
        	WGCreatePage("LM",	 	// page ID string
                hwnd,           	// handle to the parent window
                hInst,          	// application instance handle 
                "Page Title", 		// Window title string 
                StartPage1,     	// creation function
        		 "PageMenu",			    // do not display the page menu bar
                C_BLUE,    			// window background color
                MM_PROPORT,     	// window sizing mode
                0L,             	// window style - default
                PAGE_FULL,    		// window initial size and position option
				0, 0, 0, 0);    	// initial window size and position

        	return 0;
          
	case WM_DESTROY:
            free (lpX1);
            free (lpY1);
            free (lpX2);
            free (lpY2);
            free (lpY3);
            free (lpY4);
            free (lpX5);
            free (lpY5);

    	    WGCleanup(TRUE);        // clean up charting tools memory
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

    // create simulation data for plots
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate data arrays
    	lpX1 = calloc (NUMP1,  sizeof (realtype));
    	lpY1 = calloc (NUMP1,  sizeof (realtype));

		lpX2 = calloc (NUMP1,  sizeof (realtype));
    	lpY2 = calloc (NUMP1,  sizeof (realtype));
    	lpY3 = calloc (NUMP1,  sizeof (realtype));
    	lpY4 = calloc (NUMP1,  sizeof (realtype));
    	
		lpX5 = calloc (NUMP2,  sizeof (realtype));
    	lpY5 = calloc (NUMP2,  sizeof (realtype));


		// create x and y data to be plotted
        for (i = 0; i < NUMP1; i++)
        {
              z = (realtype) (i);
              lpX1 [i] = z + 1.0;
              lpY1 [i] = 20.0 + z * 1000.0 * randreal();

			  lpX2 [i] = lpX1[i];
			  lpY2 [i] = lpY1[i] + 1000.0 * randreal();;
  			  lpY3 [i] = lpY2[i] + 1000.0 * randreal();
			  if (i<(NUMP1/2))
  					lpY4 [i] = (33.0 + z * 200.0 * randreal()) + (z * 1250.0) + 1300;
			  else
  					lpY4 [i] = (33.0 + z * 200.0 * randreal()) + (z * 500.0) + 4000;

        }

		lpX5[0] = lpX2[10];		lpY5 [0] = lpY4[10];
		lpX5[1] = lpX2[14];		lpY5 [1] = lpY4[14];
		lpX5[2] = lpX2[17];		lpY5 [2] = lpY4[17];
		lpX5[3] = lpX2[20];		lpY5 [3] = lpY4[20];
		lpX5[4] = lpX2[22];		lpY5 [4] = lpY4[22];

        fInit = FALSE;
    }
/*--------------------------------------------------------------*/

	// Initialize graph 
    pGraph1 = WGCreateGraph (pPageDesc,
                 DrawGraphP1G1, // points to function which builds graph
                 0.05, 0.05,    // window relative position inside parent page window
                 0.95, 0.95,
                 C_WHITE,      // white background
                 C_GREEN,      // green border
                 4);           // border width in pixels

}
/***************************************************************************/
void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisXbottom, hAxisXtop, hAxisYleft, hAxisYright; // axes handles
    HDATA   hDataScat1, hDataScat2;       // data set handle
	HDATA	hDataShark, hDataLine;
	HDATA	hDataBmp;

    LPSTR   lpLegStr;

    // define a dataset
    hDataScat1 = WGDefineDataSetPtr ("Scat1", lpX1, lpY1, NUMP1);
	hDataScat2 = WGDefineDataSetPtr ("Scatter", lpX2, lpY2, NUMP1);
	hDataShark = WGDefineDataSetPtr ("Shark", lpX2, lpY3, NUMP1);
	hDataLine  = WGDefineDataSetPtr ("StepLine", lpX2, lpY4, NUMP1);
	hDataBmp = WGDefineDataSetPtr ("Bitmap", lpX5, lpY5, NUMP2);

	 // Mark some data points as invalid

	WGMarkDataPoint (hDataScat1, 5, TRUE);
	WGMarkDataPoint (hDataScat1, 7, TRUE);
	WGMarkDataPoint (hDataScat1, 20, TRUE);

    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.85, 0.85, C_WHITE);

	// scale the plotting area, x ranges from 0 to 25, y ranges from 0 to 25000
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 25.0, 20000.0);

    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // set line style of axes to solid, RED
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_RED);

    // draw the x axis, major ticks every 5 units, with 4 minor ticks between each interval
    hAxisXbottom = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);

    // draw the y axis, major ticks every 5000 units, with no minor ticks
    hAxisYleft = WGDrawYAxis(pGrDesc, hdc, 5000.0, 0, POS_LEFT);

    // set line style to dotted, MAGENTA, 
    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_MAGENTA);

    // draw a y axis grid on the major tick intervals.
    WGDrawGrid(pGrDesc, hAxisYleft, GRID_MAJOR);

    // set current font family to Swiss, 10 points, bold
    WGSetTextParams (C_RED, FF_SWISS, 10, TEXT_BOLD);

    // label the x axis
    WGLabelAxis(pGrDesc, hdc, hAxisXbottom, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	// label the y axis, display the axis labels in scientific notation
	WGLabelAxis(pGrDesc, hdc, hAxisYleft, POS_LEFT, NF_ENG, 1, LL_ON, NULL);

	//*
	// CREATE 5 DATA PLOTS, EACH WITH A DIFFERENT DATASET
	WGScatterPlot (pGrDesc, hdc, hDataScat1, 
				   MK_CIRCLE, C_BLUE, 14, MKS_FILLED, TRUE);
	WGScatterPlot (pGrDesc, hdc, hDataScat2, 
				   MK_DIAMOND, C_YELLOW, 14, MKS_FILLED, FALSE);
	
	// Set line style - color is used for text in legend
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 5, C_BLACK);
	hScatX = WGScatterPlotEx (pGrDesc, hdc, hDataShark, 
				   MK_METAFILE, "shark.wmf", 20, FALSE);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
	WGLinePlotEx (pGrDesc, hdc, hDataLine, FALSE, STEP_END);

	// Set line style - color is used for text in legend
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_GREEN);
	WGScatterPlotEx (pGrDesc, hdc, hDataBmp, 
				   MK_BITMAP, "sym2.bmp", 20, FALSE);
	//*

    // Write axes titles
	WGSetTextByName (C_BLACK, "Arial", 12, TEXT_BOLD);
	hTextY = WGTitleAxis(pGrDesc, hdc, hAxisYleft, POS_LEFT, "Volts");
	hTextX = WGTitleAxis(pGrDesc, hdc, hAxisXbottom, POS_BELOW, "Sample Interval");

    // set current font to Arial, 11 points, bold
	WGSetTextByName (C_GREEN, "Arial", 11, TEXT_BOLD);

    // set line style of actual plot to RED
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_RED);

    // Now the top and right axes are drawn
    
    // set the intercepts to 25, 25000
	WGSetXYIntercepts (pGrDesc, 25.0, 25000.0);

    // draw the x axis, the axis will be drawn from 0 to 25, as above. Since the y intercept
    // is now at 25000, the x axis will appear on the top of the plotting area.
    hAxisXtop = WGDrawXAxis(pGrDesc, hdc, 5, 4, POS_ABOVE);

    // draw the y axis, the range is from 0 to 25000.0, as above. 
    // Since the x-intercept is now at 25, 
    // the second y-axis will appear to the right of the plotting area.
    hAxisYright = WGDrawYAxis(pGrDesc, hdc, 5000.0, 0, POS_RIGHT);

    // label the x and y axis
    // return a handle to the text object.  This handle will be used
    // to change the color of the X and Y Axis Titles.
    WGLabelAxis(pGrDesc, hdc, hAxisXtop, POS_ABOVE, NF_DECIMAL, 1, LL_ON, NULL);
    // this time the axis labels are in engineering notation
    WGLabelAxis(pGrDesc, hdc, hAxisYright, POS_RIGHT, NF_ENG, -1, LL_ON, NULL);

	lpLegStr = (LPSTR) calloc (5, LG_MAXLEN);
	lstrcpy(lpLegStr, "Circular");
	lstrcpy(lpLegStr + LG_MAXLEN, "One");
	lstrcpy(lpLegStr + 2* LG_MAXLEN, "SHARK!!! (Metafile)");
	lstrcpy(lpLegStr + 3* LG_MAXLEN, "Line - Step End");
	lstrcpy(lpLegStr + 4* LG_MAXLEN, "User-defined bitmap");

    WGSetTextByName (C_BLUE, "Times New Roman", 10, TEXT_ITAL);

	hLegend = WGLegendPtr(pGrDesc, hdc, 0.18, 0.075, 0.42, 0.31, 
					 C_LIGHTBLUE, 2, -1, C_LIGHTGRAY, OR_VERT,
					 lpLegStr);

	free (lpLegStr);
}

/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}



