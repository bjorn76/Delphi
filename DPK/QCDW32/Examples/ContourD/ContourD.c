
//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   ContourD.c                                 *
//*   Author   :   RQ                                         *
//*   Revision :   3.0                                        *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of contour routines                *
//*                                                           *
//*************************************************************



#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"


HINSTANCE  hInst;              // global instance handle
HDATA   ContourData;  // data set handle

char szAppName[] = "Contours";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

LRESULT  CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
realtype functionproc1(realtype x, realtype y);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void   CreateData(void );
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);   // these functions must be 
void  CALLBACK StartPage2(PPAGE_DEF pPageDesc);
void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void  CALLBACK DrawGraphP2G1 (PGRAPH_DEF pGrDesc, HDC hdc);

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
        szAppName,                           // Create main window
        "Main Window Title",                        // Main window title
        WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
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

LRESULT  CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
	{
    	case WM_CREATE:
			CreateData();
	    	WGCreatePage("PAGE1", // page ID string
                hwnd,               // handle to the parent window
                hInst,              // application instance handle 
                "Line Contours",  // Window title string 
                StartPage1,         // pointer to graph creation function
	        	"PageMenu",
                C_WHITE,         // window background color
                MM_PROPORT,         // window sizing mode
                0L,                 // window style - default
                PAGE_CLIENT,          // window initial size and position option
                0, 0, 0, 0);        // initial window size and position
                                    // if used (not used here)
	    	WGCreatePage("PAGE2", // page ID string
                hwnd,               // handle to the parent window
                hInst,              // application instance handle 
                "Filled Contours",  // Window title string 
                StartPage2,         // pointer to graph creation function
	        	"PageMenu",
                C_WHITE,         // window background color
                MM_PROPORT,         // window sizing mode
                0L,                 // window style - default
                PAGE_CLIENT,          // window initial size and position option
                0, 0, 0, 0);        // initial window size and position
                                    // if used (not used here)
	
		return 0;

    	case WM_DESTROY:
    	    WGCleanup(TRUE);        // clean up charting tools memory
            PostQuitMessage(0);
            return 0;
    }
    return (DefWindowProc(hwnd, message, wParam, lParam));
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

/**********************************************************************
   Routine StartPage1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
***********************************************************************/

void  CALLBACK StartPage1(PPAGE_DEF pPageDesc)
{
 
  // Initialize graph 
    WGCreateGraph (pPageDesc,
                 DrawGraphP1G1, // points to function which builds graph
                 0.05, 0.05,    // window relative position inside parent page window
                 0.95, 0.95,
                 C_WHITE,       // white background
                 C_GREEN,       // green border
                 4);            // border width in pixels

}

void  CALLBACK StartPage2(PPAGE_DEF pPageDesc)
{
 
  // Initialize graph 
    WGCreateGraph (pPageDesc,
                 DrawGraphP2G1, // points to function which builds graph
                 0.05, 0.05,    // window relative position inside parent page window
                 0.95, 0.95,
                 C_WHITE,       // white background
                 C_GREEN,       // green border
                 4);            // border width in pixels

}

/***************************************************************************/
// Displays an line contour plot
/***************************************************************************/
void  CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	realtype rContourValues[8] = {-3.5, -2.1, -1.1, 0.0, 2.1, 3.1, 4.1, 5.1};
 
	HGOBJ   hAxisX, hAxisY;          // axes handles
	COLORREF rgbColors[10] = {1, 11, 12, 13, 14, C_LIGHTGRAY, C_GREEN, C_RED, C_BLACK, C_BLACK};
    int nLineStyle[8] = {PS_SOLID, PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID};
	int nLineWidth[8] = {1,1,1,1,1,1,1,1};
	int bContourLineFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
	int bContourLabelFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
    int i, granularity;
	realtype rMinX, rMinY, rMaxX, rMaxY, rMinZ, rMaxZ;

   WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.95, 0.85, C_WHITE);

#if 0 // An auto axis call which can also be used
   WGAutoAxesContourData ( pGrDesc,  hdc, 
	  ContourData,  AS_ROUNDFAR, INTF_MIN,  &hAxisX, &hAxisY,
	   NULL, NULL);
#else
    for (i=0; i < 8; i++)
		rgbColors[i] = WGGetRGBColor(rgbColors[i]);


	WGGetContourMinMaxXYZ (ContourData, &rMinX, &rMaxX,
										&rMinY, &rMaxY,
 										&rMinZ, &rMaxZ);
    WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, rMinX, rMinY);

    // set line style for axes to a solid, black line
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 0, C_BLACK);

    // draw the x axis
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 0, POS_BELOW);

    // draw the y axis
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 0, POS_LEFT);

    // set line style of grids to dotted, minimal width, MAGENTA, 
    // and display a y-axis grid on major ticks.
  
    // set current font to Roman, 10 points, bold
    WGSetTextParams (C_BLUE, FF_ROMAN, 10, TEXT_BOLD);

    // label the x- and y- axis
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);

#endif

   WGSetLineStyle(pGrDesc, hdc, PS_DOT, 0, C_MAGENTA);

    // draw a y-axis grid at minor and major tick marks
   WGDrawGrid(pGrDesc, hAxisY, GRID_ALL);
   WGDrawGrid(pGrDesc, hAxisX, GRID_ALL);
   WGSetTextParams (C_BLACK, FF_ROMAN, 14, TEXT_BOLD);

   granularity = 1;
   WGSetTextParams (C_BLACK, FF_ROMAN, 10, TEXT_BOLD);
  
   WGContourPlot ( pGrDesc,  hdc,
        ContourData,
        rContourValues,
        rgbColors,    
		nLineStyle,
		nLineWidth,
	    7,
		granularity,
	    bContourLineFlags,
		bContourLabelFlags, 
		POS_RIGHT,
		POS_ABOVE,
		1,
		TRUE,
        GT_CONTOURLINE);

   // Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "X Axis Title");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Y Axis Title");

    // set current font to Roman, 12 points, bold
    WGSetTextParams (C_BLACK, FF_ROMAN, 12, TEXT_BOLD);

   // output a tilted (45 degrees) message at x = 12.5, y = 125.0
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "TEST", 12.5, 125.0, TA_CENTER, 450);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "Graph Title");
}

/***************************************************************************/
// Displays an filled contour plot
/***************************************************************************/
void  CALLBACK DrawGraphP2G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	realtype rContourValues[8] = {-3.5, -2.1, -1.1, 0.0, 2.1, 3.1, 4.1, 5.1};
 
	HGOBJ   hAxisX, hAxisY;          // axes handles
	COLORREF rgbColors[10] = {1, 11, 12, 13, 14, C_LIGHTGRAY, C_GREEN, C_RED, C_BLACK, C_BLACK};
    int nLineStyle[8] = {PS_SOLID, PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID,PS_SOLID};
	int nLineWidth[8] = {1,1,1,1,1,1,1,1};
	int bContourLineFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
	int bContourLabelFlags[8] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};
    int i, granularity;

   WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.95, 0.85, C_WHITE);

   WGAutoAxesContourData ( pGrDesc,  hdc, 
	  ContourData,  AS_ROUNDFAR, INTF_MIN,  &hAxisX, &hAxisY,
	   NULL, NULL);

    for (i=0; i < 8; i++) // Convert Simple Colors to RGB Colors
		rgbColors[i] = WGGetRGBColor(rgbColors[i]);


	for (i=0; i < 8; i++)
	{
		 bContourLineFlags[i] = FALSE;
		 bContourLabelFlags[i] = TRUE;
	}
    granularity = 1;
    WGSetTextParams (C_BLACK, FF_MODERN, 8, TEXT_NORMAL);
    WGContourPlot ( pGrDesc,  hdc,
        ContourData,
        rContourValues,
        rgbColors,    
		nLineStyle,
		nLineWidth,
	    7,
		granularity,
	    bContourLineFlags,
		bContourLabelFlags, 
		POS_LEFT,
		POS_ABOVE,
		1,
		FALSE,
        GT_CONTOURFILL);

   // Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "X Axis Title");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Y Axis Title");

    // set current font to Roman, 12 points, bold
    WGSetTextParams (C_BLACK, FF_ROMAN, 12, TEXT_BOLD);

   // output a tilted (45 degrees) message at x = 12.5, y = 125.0
    WGText (pGrDesc, hdc, hAxisX, hAxisY, "TEST", 12.5, 125.0, TA_CENTER, 450);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "Graph Title");


	{
	int borderColor;
	int borderWidth;
	int	backColor;

	COLORREF lpTextColors[9];
	int lpShapes[9];
	int lpSizes[9];
	int lpStyles[9];

	LPSTR  lpLegStr;


	lpLegStr = (LPSTR) calloc (9, LG_MAXLEN);

	lstrcpy(lpLegStr, " < -3.5");
	lstrcpy(lpLegStr + LG_MAXLEN, "-3.5 to -2.1");
	lstrcpy(lpLegStr + 2*LG_MAXLEN, "-2.1 to -1.1");
	lstrcpy(lpLegStr + 3*LG_MAXLEN, "-1.1 to 0.0");
	lstrcpy(lpLegStr + 4*LG_MAXLEN, "0.0 to 2.1");
	lstrcpy(lpLegStr + 5*LG_MAXLEN, "2.1 to 3.1");
	lstrcpy(lpLegStr + 6*LG_MAXLEN, "3.1 to 4.1");
	lstrcpy(lpLegStr + 7*LG_MAXLEN, "4.1 to 5.1");
	lstrcpy(lpLegStr + 8*LG_MAXLEN, "> 5.1");

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
	borderWidth = 1;

    WGSetTextParams (C_BLACK, FF_MODERN, 10, TEXT_NORMAL);


	WGFlexLegend (pGrDesc, hdc, 0.7, 0.05, 0.98, 0.5,
					borderColor, borderWidth, backColor, OR_VERT,
					9, lpTextColors, lpShapes, rgbColors, 
					lpSizes, lpStyles, lpLegStr);

	free (lpLegStr);
	}
}

/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}
/***********************************************************************/

realtype functionproc1(realtype x, realtype y)
{
	realtype result, w;

	result = ( 3.5 * sin(sqrt(x*x + y*y)));
	w = sin (x / 2.0) + (realtype ) rand()/ 100000.0;
	result += w * ( 8 - (y + 7) / 2);

	return result;
}


