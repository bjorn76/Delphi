//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1998                *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   Simple.c                                  *
//*   Author   :   RA                                         *
//*   Revision :   3.0                                        *
//*   Date     :   July 10, 1998                              *
//*   Product  :   Real-Time Graphics Tools for Windows       *
//*                                                           *
//*************************************************************
//*************************************************************/
//
// Demonstrates a Simple scroll graph

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
HGOBJ      hScroll;
HDATA      hData;

char  szAppName[] = "Simple";  /* Class Name used in call to CreateWindow. */
int   idTimer;
PGRAPH_DEF pDynGrDesc = NULL;
HGOBJ hTimeLab;
// Prototypes of forward referenced functions

LRESULT CALLBACK  MainWndProc (HWND hwnd, UINT message,
				  WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);

void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);

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

		  idTimer = SetTimer (NULL, 0, (int)(SAMPINT * 2000), 
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
{ int  nHistSize;

	  // Initialize graph
	WGStart();
	nHistSize = 400;
	hData = WRDefineDynDataSet ("Data", 3, "volts", NULL, nHistSize);

	pDynGrDesc = WGCreateGraph (pPageDesc,
		 DrawP1G1, 	   // points to function which builds graph
		 0.02, 0.02, // window relative position inside parent page window
		 0.98, 0.98,
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
	HGOBJ   hAlarmLines;
	LPSTR    lpTags;
	realtype rResetInt, rLow, rHigh;
    realtype rXRange, rSampleInt;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int     nAlarmLineColors[5];
	int    	nLineWidth [NCH];
	int    	i, nGridUpdate=1;
	BOOL    bFlags [NALMLINES];

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 50.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, "LL");

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Combo Graph");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

    hScroll = WRSetScrollGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			NO_STEP,		
			NULL,
			nLineWidth,
			nLineColor);

	rLow = -1.4;
	rHigh = 1.4;

    WRSetAlarm (hData, ALM_LOW,  rLow, "LOW");
	WRSetAlarm (hData, ALM_HIGH, rHigh, "HIGH");
	bFlags[0] = FALSE;
	bFlags[1] = TRUE;
	bFlags[2] = TRUE;
	bFlags[3] = FALSE;
	bFlags[4] = FALSE;

	nAlarmLineColors[0] = C_WHITE;
	nAlarmLineColors[1] = C_LIGHTRED;
	nAlarmLineColors[2] = C_LIGHTBLUE;

	// Draw alarm lines
	hAlarmLines = WRSetAlarmLines (pGrDesc,		// pointer to graph descriptor
			hData,					// handle to data set
			2,						// alarm line updated every 2 seconds
			OR_HORZ,				// lines are horizontal
			bFlags,					// enable/disable particular lines
			NULL,					// default style - PS_SOLID
			nLineWidth,
			nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll,
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab, hScroll);
	free (lpTags);
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
	static int nCount2 = 1;
	realtype rArg;
	realtype rNewVals [DYN_MAXVAL];

	if (!WGIsGraphDescValid (pDynGrDesc))
		return;

	rArg = M_PI * nCount;

	rNewVals [0] = 1.9 * sin (rArg / (200.0 - nCount % 200)) ;
	rNewVals [1] = 1.8 * sin (rArg / 52.0) * (rand() / 32767.0) * 1.1;
	rNewVals [2] = 1.6 *cos (rArg / 60.0) * (rand() / 50767.0) * 1.6;

	if (nCount++ > 1000)
		nCount = 0;
	WRUpdateData (hData, (LPREAL) &rNewVals, pDynGrDesc);
}
