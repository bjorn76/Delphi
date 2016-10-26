//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1998                *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   ScrollG2.c                                  *
//*   Author   :   RA                                         *
//*   Revision :   3.0                                        *
//*   Date     :   July 10, 1998                              *
//*   Product  :   Real-Time Graphics Tools for Windows       *
//*                                                           *
//*************************************************************
//*************************************************************/
//
// Demonstrates Multi-scroll graphs

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
HGOBJ      hScroll[9], hTimeLab[9];
HDATA      hData;

char  szAppName[] = "ScrollG2";  /* Class Name used in call to CreateWindow. */
int   idTimer;
PGRAPH_DEF pDynGrDesc[9] = {NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};

// Prototypes of forward referenced functions

LRESULT CALLBACK  MainWndProc (HWND hwnd, UINT message,
				  WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);

void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK StartGraphs2 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G4 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G5 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G6 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP2G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP2G2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP2G3 (PGRAPH_DEF pGrDesc, HDC hdc);

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
		  WGCreatePage("PAGE2", // page ID string
			hwnd,               // handle to the parent window
			hInst,              // application instance handle
			"Multi Scroll",    // Window title string
			StartGraphs2,       // pointer to graph creation function
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
{ int nHistSize;

	  // Initialize graph
	WGStart();
	nHistSize = 400;
	hData = WRDefineDynDataSet ("Data", 3, "volts", NULL, nHistSize);

	pDynGrDesc[0] = WGCreateGraph (pPageDesc,
		 DrawP1G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.5, 0.33,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
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
		 1.0, 0.66,
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

void  CALLBACK StartGraphs2(PPAGE_DEF pPageDesc)
{ 

	  // Initialize graph
	pDynGrDesc[6] = WGCreateGraph (pPageDesc,
		 DrawP2G1, 	   // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.33, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels

	pDynGrDesc[7] = WGCreateGraph (pPageDesc,
		 DrawP2G2, 	   // points to function which builds graph
		 0.34, 0.005, // window relative position inside parent page window
		 0.66, 0.99,
		 C_LIGHTGRAY, // light gray background
		 C_RED,   	  // red   border
		 1);      	  // border width in pixels
	pDynGrDesc[8] = WGCreateGraph (pPageDesc,
		 DrawP2G3, 	   // points to function which builds graph
		 0.67, 0.005, // window relative position inside parent page window
		 0.995, 0.99,
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
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
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

	hTimeLab[0] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_FILLEDLINE;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[0] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.5, 0.0,
	        0.01);

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
						 hScroll[0],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[0], hScroll[0]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.90, C_BLACK);

	rXRange = 10.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 2.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[1] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	WGTitleGraph(pGrDesc, hdc, "Scroll Multibar");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = MK_BAR;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_LIGHTRED;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[1] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[1], hScroll[1]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	realtype rHigh, rLow;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;
	int     nAlarmLineColors[5];
	BOOL    bFlags [NALMLINES];
	HGOBJ   hAlarmLines;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.90, C_BLACK);

	rXRange = 25.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, -2.0, rXRange, 2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -0.02, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 5.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[2] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	WGTitleGraph(pGrDesc, hdc, "Sweep Combo");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_BAR;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[2] = WRSetSweepComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			OR_HORZ,
			C_WHITE,
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.5, 0.0,
	        0.01);

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
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[2], hScroll[2]);
	free (lpTags);
}

void  CALLBACK DrawP1G4 (PGRAPH_DEF pGrDesc, HDC hdc)
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
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
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
	WGScalePlotArea (pGrDesc, rXRange, 2.0, 0.0 ,-2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, rXRange + 0.02, 2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[3] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	WGTitleGraph(pGrDesc, hdc, "Combo Graph - Inverted X and Y");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_FILLEDLINE;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[3] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.5, 0.0,
	        0.01);

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
						 hScroll[0],
						  hAlarmLines);


	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[3], hScroll[3]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G5 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.90, C_BLACK);

	rXRange = 10.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, 0.0, 2.0, rXRange, -2.0);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, 0.0, 2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 2.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[4] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	WGTitleGraph(pGrDesc, hdc, "Scroll Multibar - Inverted Y");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = MK_BAR;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_LIGHTRED;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[4] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_HORZ,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[4], hScroll[4]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP1G6 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	realtype rHigh, rLow;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;
	int     nAlarmLineColors[5];
	BOOL    bFlags [NALMLINES];
	HGOBJ   hAlarmLines;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.10, 0.10, 0.9, 0.90, C_BLACK);

	rXRange = 25.0;

	// scale the plotting are for an x range of 0 to 5.0
	// and y range of -2 to 2
	WGScalePlotArea (pGrDesc, rXRange, -2.0, 0.0, 2.0);

	// set X intercepts to -0.02 so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, rXRange, -2.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisX = WRDrawTimeAxis(pGrDesc, 5.0, 9, POS_MIDDLE, OR_HORZ, AXU_SEC);
	hAxisY = WGDrawYAxis(pGrDesc, hdc, 1.0, 1, POS_LEFT);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[5] = WRLabelTimeAxis (pGrDesc, hAxisX, POS_BELOW, DLB_HMS,
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
	WGTitleGraph(pGrDesc, hdc, "Sweep Combo - Inverted X");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_BAR;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[5] = WRSetSweepComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			OR_HORZ,
			C_WHITE,
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.5, 0.0,
	        0.01);

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
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[5], hScroll[5]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP2G1 (PGRAPH_DEF pGrDesc, HDC hdc)
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
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;
	BOOL    bFlags [NALMLINES];

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.20, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisY = WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[6] = WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, "LL");

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

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
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_FILLEDLINE;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[6] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_VERT,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.5, 0.0,
	        0.01);

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
			OR_VERT,				// lines are horizontal
			bFlags,					// enable/disable particular lines
			NULL,					// default style - PS_SOLID
			nLineWidth,
			nAlarmLineColors);
    
	WRSetScrollChannelAlarmColors( pGrDesc, 
						 hScroll[0],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[6], hScroll[6]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP2G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.20, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisY = WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[7] = WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, "LL");

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Scroll Multibar");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = MK_BAR;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_LIGHTRED;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[7] = WRSetScrollComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			rResetInt,					
			OR_VERT,		
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.3, 0.0,
	        0.05);

	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[7], hScroll[7]);
	free (lpTags);
}

/*******************************************************
	Builds the graph using Q-C Windows Charting Calls
********************************************************/
void  CALLBACK DrawP2G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ   hAxisX, hAxisY;  // axes handles
	LPSTR    lpTags;
	realtype rResetInt;
    realtype rXRange, rSampleInt;
	realtype rHigh, rLow;
	int    	nTraces = NCH;
	int  	nLineColor [NCH];
	int    	nLineWidth [NCH];
	int    nScatterSym[NCH];
	int    nScatterSize[NCH];
	int    nScatterStyle[NCH];
	int    	i, nGridUpdate=1;
	int     nAlarmLineColors[5];
	BOOL    bFlags [NALMLINES];
	HGOBJ   hAlarmLines;

	// allocate array for tags
	lpTags  = calloc(nTraces, DYN_MAXVAL);
	lstrcpy(lpTags, "First");

	// define the plotting area of the graph
	WGSetPlotArea(pGrDesc, hdc, 0.20, 0.10, 0.9, 0.9, C_BLACK);

	rXRange = 50.0;

	WGScalePlotArea (pGrDesc, -2.0, 0.0, 2.0, rXRange);

	// set X intercepts to -0.02, so that Y-axis is not erased by fat line
	WGSetXYIntercepts (pGrDesc, -2.0, 0.0);

	// axes to be drawn in solid, white, 1 pixels thick
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_WHITE);

	// set current font to Arial, 9 points
	WGSetTextByName (C_MAGENTA, "Arial", 9, TEXT_ITAL | TEXT_BOLD);

	hAxisY = WRDrawTimeAxis(pGrDesc, 10.0, 9, POS_MIDDLE, OR_VERT, AXU_SEC);
	hAxisX = WGDrawXAxis(pGrDesc, hdc, 1.0, 1, POS_BELOW);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_WHITE);

	WRDynGrid(pGrDesc, hAxisX, GRID_MAJOR, nGridUpdate);
	WRDynGrid(pGrDesc, hAxisY, GRID_MAJOR, nGridUpdate);

	hTimeLab[8] = WRLabelTimeAxis (pGrDesc, hAxisY, POS_LEFT, DLB_HMS,
		0, 13, 30, 0, 3.0, LL_ON, "LL");

	// set current font to Arial, 10 points, bold
	WGSetTextByName (C_RED, "Arial", 10, TEXT_BOLD);

	// Label the y axis, in decimal format, 1 digit after the decimal point.
	WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);

	WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_LIGHTCYAN);

	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 10, TEXT_BOLD | TEXT_ITAL);

	// Write graph title
	WGTitleGraph(pGrDesc, hdc, "Sweep Combo");

	// assign each line style, width and color
	for (i = 0; i < nTraces; i++)
	{
		nLineWidth [i] = 0;
		nScatterSize[i] = 6;
		nScatterSym[i] = i;
		nScatterStyle[i] = MKS_EMPTY;
		nLineColor[i] = 8 + i;
	}
	nLineColor[0] = C_YELLOW;
	nLineColor[1] = C_LIGHTMAGENTA;
	nLineColor[2] = C_LIGHTCYAN;
	nScatterSym[0] = MK_BAR;
	nScatterSym[1] = MK_NONE;

	rSampleInt = SAMPINT;   rResetInt = 0.98;

hScroll[8] = WRSetSweepComboGraph (pGrDesc,	
			hData,                          
			rSampleInt,						
			OR_VERT,
			C_WHITE,
			nScatterSym,		
			nLineColor,
			nScatterSize,
			nLineWidth,
			nScatterStyle,
			0.35, 0.0,
	        0.01);

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
						 hScroll[2],
						  hAlarmLines);



	// start automatic update of time labels
	WRStartTimeLabelsUpdate (pGrDesc, hTimeLab[8], hScroll[8]);
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

	if (!WGIsGraphDescValid (pDynGrDesc[0]))
		return;

	rArg = M_PI * nCount;

	rNewVals [0] = 1.9 * sin (rArg / (200.0 - nCount % 200)) ;
	rNewVals [1] = 1.8 * sin (rArg / 52.0) * (rand() / 32767.0) * 1.1;
	rNewVals [2] = 1.6 *cos (rArg / 60.0) * (rand() / 50767.0) * 1.6;

	if (nCount++ > 1000)
		nCount = 0;
	WRUpdateData (hData, (LPREAL) &rNewVals, NULL);
}
