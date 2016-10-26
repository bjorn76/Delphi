//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1995 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   SuprZoom.c                                 *
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of zooming                         *
//*                                                           *
//*************************************************************

/*
	This example demonstrates how to implement zooming.

	The project for this program includes:

	ZOOMDEMO.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"
#include "resource.h"

#define NUMP1 80                  // number of data points
#define NUMP2 20                  // number of data points

HINSTANCE     hInst;              // global instance handle
LPREAL  lpX1, lpY1, lpY2, lpY3, lpY4, lpY5;           // data arrays
HDATA   hDataSet, hDataSet2, hDataSet3, hDataSet4, hDataSet5;        // data set handles
HGOBJ hX1, hY1, hY2, hY3, hY4, hY5, hY6; // axis handles
char szAppName[] = "Demo";  /* Class Name used in call to CreateWindow. */
PGRAPH_DEF pGraphDesc;
// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message,
			     WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   // these functions must be CALLBACK
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
	 LPARAM lParam);
void ProcessSuperZoom(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse);

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
    wc.hbrBackground = (HBRUSH) GetStockObject( LTGRAY_BRUSH);
	wc.lpszMenuName = "MainMenu";		// main window menu
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
	int	   i;
	realtype z;	

	// save current instance - MUST BE HERE
	hInst = hInstance; 

		// allocate global data arrays
	lpX1 = (LPREAL)calloc (NUMP1, sizeof (realtype));
	lpY1 = (LPREAL)calloc (NUMP1, sizeof (realtype));
	lpY2 = (LPREAL)calloc (NUMP1, sizeof (realtype));
	lpY3 = (LPREAL)calloc (NUMP1, sizeof (realtype));
	lpY4 = (LPREAL)calloc (NUMP1, sizeof (realtype));
	lpY5 = (LPREAL)calloc (NUMP1, sizeof (realtype));

	// create x and y data to be plotted
	for (i = 0; i < NUMP1; i++)
	{
		 z = (realtype) i;
		 lpX1 [i] = z;
		 lpY1 [i] = 15.0 *
		 cos(M_PI * z / (4.0+ 0.3 * randreal())) +
			 3.0 * randreal();
         lpY2 [i] = 50 + 30.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

         lpY3 [i] = 90.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

		 lpY4 [i] = 200 +  225.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

		 lpY5 [i] = 1.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();
		 
	}



	WGStart();	// necessary, because no page has been created yet
	// define a dataset 
	hDataSet = WGDefineDataSetPtr ("Data 1", lpX1, lpY1, NUMP1);
	hDataSet2 = WGDefineDataSetPtr ("Data 2", lpX1, lpY2, NUMP1);
  	hDataSet3= WGDefineDataSetPtr ("Data 3", lpX1, lpY3, NUMP1);
	hDataSet4 = WGDefineDataSetPtr ("Data 4", lpX1, lpY4, NUMP1);
	hDataSet5= WGDefineDataSetPtr ("Data 5", lpX1, lpY5, NUMP1);
 
	hwnd = CreateWindow
	(
	  szAppName,                           // Create main window
	  "Quinn-Curtis Zoom Demo",			   // Main window title
	  WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
	  CW_USEDEFAULT,  CW_USEDEFAULT,
	  CW_USEDEFAULT,  CW_USEDEFAULT,
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
		  WGCreatePage("PAGE1", // page ID string
			hwnd,               // handle to the parent window
			hInst,              // application instance handle 
			"First Graph",      // Window title string 
			StartGraphs1,       // pointer to graph creation function
			"PageMenu",         // Name of page window menu in resource file
			C_LIGHTGRAY,        // window background color
			MM_PROPORT,         // window sizing mode
			0L,                 // window style - default
			PAGE_CLIENT,        // window initial size and position option
			0, 0, 0, 0);        // initial window size and position

		  WGSaveAxesState(pGraphDesc);
							  // if used (not used here)
		  return 0;

		case WM_COMMAND:
		{
			FARPROC  lpProcAbout; /* pointer to the "AboutProc" function */
			switch (wParam) {
			case IDM_ABOUT:
				 lpProcAbout = MakeProcInstance ((FARPROC)AboutProc, hInst);
				  DialogBox(hInst,		     /* current instance	 */
					"AboutBox",	    		 /* resource to use	     */
					hwnd,			         /* parent window handle */
					 (DLGPROC)lpProcAbout); /* AboutProc() instance address */
				  FreeProcInstance(lpProcAbout);
				  break;
			case ID_ZOOM_TOP:
                              WGRestoreAxesState(pGraphDesc);
							  break;
			}

		}
		return 0;

		case WM_DESTROY:
        	free (lpX1);
        	free (lpY1);
        	free (lpY2);
        	free (lpY3);
        	free (lpY4);
        	free (lpY5);

			WGCleanup(FALSE); 		// clean up charting tools memory
			PostQuitMessage(0);
		return 0;
    }
	return (DefWindowProc(hwnd, message, wParam, lParam));
}

/**********************************************************************
   Routine StartGraphs1 is called by the Quinn-Curtis
   Windows Charting Tools when a page is created.
   It must be filled by the user, normally with
   functions WGCreateGraph that initialize individual graphs.
***********************************************************************/

void CALLBACK StartGraphs1(PPAGE_DEF pPageDesc)
{
	  // Initialize graph 

    pGraphDesc = WGCreateGraph (pPageDesc,
		 DrawP1G1, // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.99, 0.99,
		 C_WHITE, // white background
		 C_RED,   // red   border
		 1);      // border width in pixels
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

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;  // axes handles
	// define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.30, 0.20, 0.75, 0.80, C_LIGHTGRAY);


	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);

// Make sure that first X and Y Axis are scales to the same coordinate system
    hX1 = ScaleAndDrawXAxis(pGrDesc, hdc, 0,   -20,  100,  20,   0,    -20, 20, POS_BELOW);
    hY1 = ScaleAndDrawYAxis(pGrDesc, hdc, 0,   -20,  100,  20,   0,    -20, 5,  POS_LEFT);

    
	// set line style of actual plot to RED
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);

    hY2 = ScaleAndDrawYAxis(pGrDesc, hdc, 0,   0,  100, 100, -20,    0, 20,  POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTBLUE);
    WGLinePlot (pGrDesc, hdc, hDataSet2, FALSE, FALSE);

    hY3 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -100, 100, 100, 100, -100, 50,  POS_RIGHT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_GREEN);
    WGLinePlot (pGrDesc, hdc, hDataSet3, FALSE, FALSE);

    hY4 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -100, 100, 500, 120, -100, 100,  POS_RIGHT);

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_YELLOW);
    WGLinePlot (pGrDesc, hdc, hDataSet4, FALSE, FALSE);

    hY5 = ScaleAndDrawYAxis(pGrDesc, hdc, 0, -5.0, 100, 5.0, -40, -1.0, 1.0,  POS_LEFT);
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_MAGENTA);
    WGLinePlot (pGrDesc, hdc, hDataSet5, FALSE, FALSE);

		// set current font to Arial, 12 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 12, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Press the right mouse button and drag");
    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_USERPROC_EVENT, ProcessSuperZoom);


}

void ProcessSuperZoom(HWND hwnd, PGRAPH_DEF pGrDesc, UINT message, POINT ptMouse)
{ HGOBJ phAxisY[5], phAxisX[2];
  int nZoomAxisMode = ZOOM_1X_MULTIPLE_Y;
  int nZoomRoundMode = AS_ROUNDCLOSE;
  int nNumXAx= 1, nNumYAx = 5;

  phAxisY[0] = hY1;
  phAxisY[1] = hY2;
  phAxisY[2] = hY3;
  phAxisY[3] = hY4;
  phAxisY[4] = hY5;

  phAxisX[0] = hX1;
 
  WGStartSuperZoom (hwnd, phAxisX, phAxisY, 
	nNumXAx, nNumYAx, 
	nZoomAxisMode,
	nZoomRoundMode,
    message, TRUE);

}

		


/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}
/**************************************************************************
    FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)

    PURPOSE:  Processes messages for "About" dialog box

****************************************************************************/

BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    	case WM_INITDIALOG:
	        return (TRUE);

    	case WM_COMMAND:
		if (wParam == IDOK || wParam == IDCANCEL)
        {
		    EndDialog (hDlg, TRUE);
    		return (TRUE);
	    }
	    break;
    }
    return (FALSE);
}
/**************************************************************************/


