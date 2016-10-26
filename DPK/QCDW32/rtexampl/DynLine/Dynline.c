//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1998                *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   DynLine.c                                  *
//*   Author   :   RA                                         *
//*   Revision :   3.0                                        *
//*   Date     :   July 1, 1998                              *
//*   Product  :   Real-Time Graphics Tools for Windows       *
//*                                                           *
//*************************************************************
//*************************************************************/
//
// Demonstrates Dynamic Line and bar graphs

#include <windows.h>
#include <stdlib.h>
#include <math.h>
#include <malloc.h>

#include "qcwin.h"
#include "qcwrt.h"
#include "menus.h"

#define   NCH	  	 3				// number of channels
#define   SAMPINT  0.5

HINSTANCE  hInst;              // global instance handle
HGOBJ      hScroll[6], hTimeLab[6];
HDATA      hData;

char  szAppName[] = "Dynline";  /* Class Name used in call to CreateWindow. */
int   idTimer;
PGRAPH_DEF pDynGrDesc[6] = {NULL, NULL, NULL, NULL, NULL, NULL};

// Prototypes of forward referenced functions

LRESULT CALLBACK  MainWndProc (HWND hwnd, UINT message,
				  WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);

void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G4 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G5 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G6 (PGRAPH_DEF pGrDesc, HDC hdc);

BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
	 LPARAM lParam);

void CALLBACK  TimerRoutine (HWND hwnd, UINT msg, UINT idTimer,
	DWORD dwTime);

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
	 // set the signal handler to be the application's own;

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

	 // save current instance - MUST BE HERE
	 hInst = hInstance; 

	 hwnd = CreateWindow
	 (
		szAppName,                           // Create main window
		"Quinn-Curtis Easy Demo",			   // Main window title
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

LRESULT CALLBACK  MainWndProc (HWND hwnd, UINT message, WPARAM wParam,
														LPARAM lParam)
{
	switch (message)
	{
		case WM_CREATE:
		 // page is created in the current window
		  WGCreatePage("PAGE1", // page ID string
			hwnd,               // handle to the parent window
			hInst,              // application instance handle
			"Multi Scroll",    // Window title string
			StartGraphs1,       // pointer to graph creation function
			"PageMenu",         // Name of page window menu in resource file
			C_LIGHTGRAY,        // window background color
			MM_PROPORT,         // window sizing mode
			0L,                 // window style - default
			PAGE_FULL,          // window initial size and position option
			0, 0, 0, 0); 

		  idTimer = SetTimer (NULL, 0, (int)(SAMPINT * 1000), 
	           (TIMERPROC)TimerRoutine);  // start 0.5 second timer

		  return 0;

		case WM_COMMAND:
		{
			 if (wParam == IDM_ABOUT)
			 {
				  DialogBox(hInst,		    /* current instance	 */
					"AboutBox",	    		    /* resource to use	    */
					hwnd,			             /* parent window handle */
					 (DLGPROC)AboutProc);  /* AboutProc() instance address */
			 }
		}
		return 0;

		case WM_DESTROY:
			KillTimer (NULL, idTimer);
			WRCleanup(TRUE); 		// clean up charting tools memory
									// and free data arrays
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

void  CALLBACK StartGraphs1(PPAGE_DEF pPageDesc)
{ 
	  // Initialize graph
	WGStart();
	hData = WRDefineDynDataSet ("Data", 32, "volts", NULL, 0);

	pDynGrDesc[0] = WGCreateGraph (pPageDesc,
		 DrawP1G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.5, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      
	// border width in pixels
	pDynGrDesc[1] = WGCreateGraph (pPageDesc,
		 DrawP1G2, 	   // points to function which builds graph
		 0.005, 0.34, // window relative position inside parent page window
		 0.5, 0.66,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[2] = WGCreateGraph (pPageDesc,
		 DrawP1G3, 	   // points to function which builds graph
		 0.005, 0.67, // window relative position inside parent page window
		 0.5, 0.995,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[3] = WGCreateGraph (pPageDesc,
		 DrawP1G4, 	   // points to function which builds graph
		 0.51, 0.005, // window relative position inside parent page window
		 1.0, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[4] = WGCreateGraph (pPageDesc,
		 DrawP1G5, 	   // points to function which builds graph
		 0.51, 0.34, // window relative position inside parent page window
		 1.0, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[5] = WGCreateGraph (pPageDesc,
		 DrawP1G6, 	   // points to function which builds graph
		 0.51, 0.67, // window relative position inside parent page window
		 1.0, 0.995,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels


}



/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
    realtype rXRange;
	int    	nTraces = NCH;


	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	hAxisX = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);;
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Dynamic Line");

WRSetDynLineGraph ( pGrDesc,
        hData,
          OR_VERT,       
		  NO_STEP,
          0.002,  
          31.998,     
          1.0,        
	      PS_SOLID, 
	      3, 
	      RGB(0,255,0));
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
    realtype rXRange;
	int    	nTraces = NCH;


	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 30.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	hAxisX = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);;
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);


	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Dynamic Line");

WRSetDynLineGraph ( pGrDesc,
        hData,
          OR_VERT,       
		  STEP_NO_RISE_LINE,
          0.0,  
          32.0,     
          0.9,        
	      PS_SOLID, 
	      0, 
	      RGB(255,255,0));
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
    realtype rXRange;
	int    	nTraces = NCH;
	int  i;
    int nBarColor[32];


	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, rXRange, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	hAxisX = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);;
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Dynamic Line");
	for (i=0; i < 32; i++)
	{
       nBarColor[i] = RGB(255, 255,0);
	}

WRSetBargraph ( pGrDesc,  hData,
	0.0, OR_VERT, 
    0.002,  
    31.998,     
    0.8,       
    nBarColor, NULL, NULL);
}

void  CALLBACK DrawP1G4 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
    realtype rXRange;
	int    	nTraces = NCH;


	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, rXRange, 0.0, 0.0, 20.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	hAxisX = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);;
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_RIGHT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_RIGHT, NF_DECIMAL, 1, LL_ON, NULL);
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Dynamic Line");

WRSetDynLineGraph ( pGrDesc,
        hData,
          OR_VERT,       
		  NO_STEP,
          0.002,  
          31.998,     
          1.0,        
	      PS_SOLID, 
	      3, 
	      RGB(0,255,0));
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G5 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
    realtype rXRange;
	int    	nTraces = NCH;


	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 32.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 25, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	hAxisX = WGDrawXAxis(pGrDesc, hdc, 5.0, 4, POS_BELOW);;
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 5.0, 4, POS_LEFT);

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);


	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Dynamic Line");

WRSetDynLineGraph ( pGrDesc,
        hData,
          OR_HORZ,       
		  STEP_START,
          0.1,  
          31.99,     
          1.0,        
	      PS_SOLID, 
	      0, 
	      RGB(255,255,0));
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G6 (PGRAPH_DEF pGrDesc, HDC hdc)
{

}


/**************************************************************************
	FUNCTION: AboutProc(HWND, UINT, WPARAM, LPARAM)

	PURPOSE:  Processes messages for "About" dialog box

****************************************************************************/

BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
	LPARAM lParam)
{
	switch (message)
	{
		case WM_INITDIALOG:
			return (TRUE);

		case WM_COMMAND:
		if (wParam == IDOK || wParam == IDCANCEL)
		{
			EndDialog(hDlg, TRUE);
			return (TRUE);
		}
		break;
	}
	return (FALSE);
}

/**************************************************************************/

void CALLBACK  TimerRoutine (HWND hwnd, UINT msg, UINT idTimer,
	DWORD dwTime)
{
	static int nCount = 1;
	realtype rArg;
	realtype rNewVals [32];
	int i;

	if (!WGIsGraphDescValid (pDynGrDesc[0]))
		return;

	rArg = M_PI * nCount;

	for (i=0; i < 32; i++)
	{
	  rNewVals [i] = 10 + 10 * sin (rArg / (200.0 - nCount % 200)) ;
	  nCount++;
	}
	if (nCount++ > 1000)
		nCount = 0;
	WRUpdateData (hData, (LPREAL) &rNewVals, NULL);
}
