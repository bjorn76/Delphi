//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   MoveData.c                                * 
//*   Author   :   NSP                                        *
//*   Revision :   3.0                                        *
//*   Date     :   August 15, 1998                            *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of using data cursor               *
//*                                                           *
//*************************************************************



#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"

#define NUMP1 20                  // number of data points

HINSTANCE  hInst;              // global instance handle
HGLOBAL    hX1, hY1;           // global memory handles to data
HGOBJ      hAxisX, hAxisY;     // axes handles
HGOBJ      hCursor1, hCursor2, hCursor3;  // cursor handles
PGRAPH_DEF  pGrDescCurs;        // graph descriptor
HDATA   hDataSet;
LPREAL  lpX1, lpY1;

int Num;

char szAppName[] = "MoveData";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message,
			     WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   // these functions must be CALLBACK
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
     LPARAM lParam);


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

    // save current instance - MUST BE HERE
	hInst = hInstance; 
   
    hwnd = CreateWindow
    (
      szAppName,                           // Create main window
      "Quinn-Curtis Move Data Demo",			   // Main window title
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
		case WM_LBUTTONDOWN:
          // When the right mouse button is pressed, the
          // page is created in the current window
          WGCreatePage("PAGE1", // page ID string
        	hwnd,               // handle to the parent window
    	    hInst,              // application instance handle 
 	"Click and drag using the right mouse button to move data.",      // Window title string 
    	    StartGraphs1,       // pointer to graph creation function
      	    "PageMenu",         // Name of page window menu in resource file
    	    C_LIGHTGRAY,        // window background color
      	    MM_PROPORT,         // window sizing mode
  	        0L,                 // window style - default
      	    PAGE_CLIENT,        // window initial size and position option
	        0, 0, 0, 0);        // initial window size and position
                              // if used (not used here)
          return 0;
			
		case WM_COMMAND:
        {
             FARPROC  lpProcAbout; /* pointer to the "AboutProc" function */
             if (wParam == IDM_ABOUT)
             {
			     lpProcAbout = MakeProcInstance ((FARPROC)AboutProc, hInst);
        		  DialogBox(hInst,		     /* current instance	 */
            	    "AboutBox",	    		 /* resource to use	     */
		            hwnd,			         /* parent window handle */
				     (DLGPROC)lpProcAbout); /* AboutProc() instance address */
           	  	  FreeProcInstance(lpProcAbout);
             }
        }
        return 0;

		case WM_PAINT: // paint main window
        {
             PAINTSTRUCT ps;
             HDC  hdc = BeginPaint(hwnd, &ps);
             RECT rect;
    			
            // function calls to repaint main window go here
             GetClientRect (hwnd, &rect);
        	 SetTextAlign (hdc, TA_BASELINE | TA_CENTER);
        	 TextOut(hdc, rect.right / 2, rect.bottom / 2,
               "Press Left Mouse Button!", 26);
			 	  
			 EndPaint(hwnd, &ps);
        }
  	    return 0;
    
		case WM_DESTROY:
    	    WGCleanup(TRUE); 		// clean up charting tools memory
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

void CALLBACK StartGraphs1(PPAGE_DEF pPageDesc)
{
    int     i;
    realtype z;
    static  BOOL fInit = TRUE;
      
    // create simulation data for plot
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate global data arrays
        hX1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
        hY1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
        // get pointers to data arrays
        lpX1 = (LPREAL) GlobalLock(hX1);
		lpY1 = (LPREAL) GlobalLock(hY1);
         // create x and y data to be plotted
        for (i = 0; i < NUMP1; i++)
        {
             z = (realtype) i;
             lpX1 [i] = z;
             lpY1 [i] = 15.0 *
          	 cos(M_PI * z / (4.0+ 0.3 * randreal())) +
              	 3.0 * randreal();
        }
        fInit = FALSE;
    }
/*--------------------------------------------------------------*/

      // Initialize graph 

	pGrDescCurs = WGCreateGraph (pPageDesc,
		 DrawP1G1, // points to function which builds graph
		 0.005, 0.005, // window relative position inside parent page window
		 0.99, 0.99,
		 C_WHITE, // white background
		 C_RED,   // red   border
		 1);      // border width in pixels
}

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{  
	    
    // define a dataset 
    hDataSet = WGDefineDataSet ("Line1", hX1, hY1, NUMP1);
		
    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);
	
    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
			
	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);
	
    // analyze the data set and automatically scale the 
	// plot area, draw and label the axes
	WGAutoAxes(pGrDesc, hdc, hDataSet, AS_ROUNDCLOSE,
		INTF_ZERO, &hAxisX, &hAxisY, NULL, NULL);
	
	// set line style of actual plot to RED
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_RED);
	
	// plot the data
	WGLineMarkerPlot (pGrDesc, hdc,
		hDataSet, MK_CIRCLE, C_LIGHTRED, 5, MKS_CDOT);

	// set current font to Arial, 12 points, bold, italic
	WGSetTextByName (C_GREEN, "Arial", 12, TEXT_BOLD | TEXT_ITAL);
	
	// Write axes titles
	WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
	WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");
		

    WGSetMouseEventAction(pGrDesc, WM_RBUTTONDOWN, OBJ_MOVE_EVENT, NULL);
		   
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