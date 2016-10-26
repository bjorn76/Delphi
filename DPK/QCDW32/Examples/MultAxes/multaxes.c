//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   Multaxes.C                                 *
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
//*   Product  :   Windows Charting Tools                     *
//*                                                           *
//*   Description: Example building three 4 line plots  in one*
//*                page with 4 y-axes                         *
//*************************************************************

/*
    Four line plots are drawn in a single page window.
	using 4 different y-axies
    
    This demo differs from DEMO3P1G.C which displays
    three pages, each with a single graph window.

    Compare these demos for the differences between pages and graphs. 

    The project for this demo includes:

   multaxes.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h" 

#define NUMP1 200                  // number of data points
#define NUMSCATTER 200

HINSTANCE     hInst;               // global instance handle
HGLOBAL       hX1, hY1, hY2, hY3;       // global handles to data
HGLOBAL       hXScatter, hYScatter;

char szAppName[] = "Multaxes";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

long CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam,
    LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);   
void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);

BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
     LPARAM lParam);

realtype randreal(void);
BOOL DisplayBitmap (HDC hdc, LPCSTR pName, int xLeft, int yTop);

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
    wc.hbrBackground = (HBRUSH) GetStockObject(WHITE_BRUSH);
    wc.lpszMenuName = "MainMenu";
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
       "Multiple Axes",                          // Main window title
       WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
       CW_USEDEFAULT,      CW_USEDEFAULT,
       CW_USEDEFAULT,      CW_USEDEFAULT,
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

long CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	HDC		    hdc;
    PAINTSTRUCT ps;

    switch (message)
    {
    	case WM_COMMAND: /* message: command from application menu */
          switch (wParam)
          {
	          case IDM_START:  
        	  // When the 'start' menu item is selected, the
              // page is created in the current window
	           WGCreatePage("PAGE1",   // page ID string
            	hwnd,  		    // handle to the parent window
              	hInst,		    // application instance handle 
	        	"......1 Page, Multiple Axes......", // Window title string
            	StartPage1, 	    // pointer to graph creation function
        		"PageMenu",
            	C_WHITE,        // window background color
            	MM_PROPORT,         // window sizing mode
            	0L,                 // window style - default
            	PAGE_CLIENT,        // window initial size and position option
            	0, 0, 1, 1);
               return 0;

    		   case IDM_ABOUT:
               {
            		DialogBox(hInst,		     /* current instance	 */
                	 "AboutBox",	    		 /* resource to use	     */
		             hwnd,			         /* parent window handle */
			   	  (DLGPROC)AboutProc); /* AboutProc() instance address */
    		   }
               return 0;
          }

		case WM_PAINT: // paint main window
			hdc = BeginPaint(hwnd, &ps);
            DisplayBitmap(hdc, "BMDEMO", 0, 0);
			EndPaint(hwnd, &ps);
            return 0;

        case WM_DESTROY:
	        WGCleanup(TRUE);   // clean up charting tools memory
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
    LPREAL  lpX1, lpY1, lpY2, lpY3, lpXScatter, lpYScatter;

    // create simulation data for plot
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate global data arrays
        hX1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
        hY1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
		hY2 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
		hY3 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
        hXScatter = GlobalAlloc (GPTR, sizeof (realtype) * NUMSCATTER);
        hYScatter = GlobalAlloc (GPTR, sizeof (realtype) * NUMSCATTER);
		// get pointers to data arrays
        lpX1 = (LPREAL) GlobalLock(hX1);
        lpY1 = (LPREAL) GlobalLock(hY1);
		lpY2 = (LPREAL) GlobalLock(hY2);
		lpY3 = (LPREAL) GlobalLock(hY3);
		lpXScatter = (LPREAL) GlobalLock(hXScatter);
		lpYScatter = (LPREAL) GlobalLock(hYScatter);

		 // create x and y data to be plotted
        for (i = 0; i < NUMP1; i++)
        {
             z = 0.005 * (realtype) i;
	    	 lpX1 [i] = z;
		     lpY1 [i] = 25 + 10 * sin( z * 100 );
		     lpY2 [i] = 1+ (realtype) i * (realtype) i;
			 lpY3 [i] = 50 + 100* sin( 50 * z);
		}
	
		
		for (i = 0; i < NUMSCATTER; i++)
        {
             z = (realtype) i;
	    	 lpXScatter [i]=  0.005 * z;
		     lpYScatter [i] = 150 + 60 * sin(z * 100);
		}
        fInit = FALSE;
    }
/*--------------------------------------------------------------*/

    // Initialize graph
 
    // the first graph is defined here
    // DrawGraphP1G1 is the building function
    WGCreateGraph (pPageDesc,
		DrawGraphP1G1,	// function which builds graph
		 0, 0,		 // window relative position inside parent page window                                                       
         1, 1,
		 C_WHITE, 	// white background
         -1, 	
          0);      	// border width in pixels
}

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ hAxisX, hAxisY;  // axes handles
    HDATA   hDataSet;        // data set handle
	
	
    // define a dataset, display the first 75 data points of the data set. 
    // hDataSet = WGDefineDataSet ("Bar Graph", hX1, hY1, 100);
	hDataSet = WGDefineDataSet ("Line1", hX1, hY1, NUMP1);
    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, hdc, 0.3, 0.1, 0.9, 0.9, C_PALEBLUE);
	WGScalePlotArea(pGrDesc, 0.0, 0.0, 0.7, 50.0);

    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // set text style
    WGSetTextParams (C_BLACK, FF_SWISS, 12, TEXT_NORMAL);
	
    // Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);
    // Draw a tick on the y axis every 0.5 from y-intercept,
    hAxisY = WGDrawYAxis (pGrDesc, hdc, 10.0, 0, POS_LEFT);
	

    // Label Y-axis
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);

    // Draw a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0 
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 0.1, 5, POS_BELOW);

    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);

	//WGLine(pGrDesc, hdc, hAxisX, hAxisY, 0, 30, 1, 30);	
	// Display an array of data
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);
	
	// Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, 0.0, 50);

	 // Draw x axies on top with a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0 
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 0.1, 5, POS_ABOVE);

    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_ABOVE, NF_DECIMAL, -1, LL_ON, NULL);

   
/************ FOR PLOT 2*********************/
		
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LOG) ;
	WGScalePlotArea(pGrDesc, 0.0, 1.0, 0.7, 100000);
	// define 2 datasets
    hDataSet = WGDefineDataSet ("Line1", hX1, hY2, NUMP1);
    	
	// Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, 0.7, 1.0);
	
	//set scale as log scale
	// Draw a tick on the y axis every 0.5 from y-intercept,
    hAxisY = WGDrawYAxis (pGrDesc, hdc, 10, 5, POS_RIGHT);
	
	 // Label Y-axis
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_RIGHT, NF_SCIENTIFIC, -1, LL_ON, NULL);
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_RED);
	// Display an array of data
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);
	
/***************FOR PLOT 3*******************/
   
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLUE);
	//set type of the scale
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR) ;
	
	// set plotting area of the scale    
	WGScalePlotArea(pGrDesc, 0.0, -200.0, 0.7, 150.0);
    // define  dataset
    hDataSet = WGDefineDataSet ("Line1", hX1, hY3, NUMP1);
		
    // Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, -0.1, -200.0);
    //draw y axies with 5 ticks between two major ticks & diffrence between two
	//parametre is 50 
    hAxisY = WGDrawYAxis (pGrDesc, hdc, 50, 10, POS_LEFT);
    //label y axies
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);
    //draw line using dataset
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);      
	
	
/*************************for plot 4****************************/

	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_GREEN);
	//set type of the scale
	WGSetAxesScale (pGrDesc, ST_LINEAR, ST_LINEAR) ;

	// set plotting area of the scale    
	WGScalePlotArea(pGrDesc, 0.0, 100.0, 0.7, 300.0);
    // define  dataset
    hDataSet = WGDefineDataSet ("Line1", hXScatter, hYScatter, NUMSCATTER);
	
    // Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, -0.2, 100.0);
			
    //draw y axies with 5 ticks between two major ticks & diffrence between two
	//parametre is 50 
    hAxisY = WGDrawYAxis (pGrDesc, hdc, 100, 10, POS_LEFT);
    //label y axies
	WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);
    //draw line using dataset
    WGLinePlot (pGrDesc, hdc, hDataSet, FALSE, FALSE);      

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

/*************************************************************************
 Load and display a Windows bitmap defined in resource file
**************************************************************************/

BOOL DisplayBitmap (HDC hdc, LPCSTR pName, int xLeft, int yTop)    
{
    HDC     hdcMem;
    BITMAP  bm;
    HBITMAP hBitmap;
	
    hBitmap = LoadBitmap(hInst, pName);
    if (hBitmap == NULL)
        return(FALSE);

    hdcMem = CreateCompatibleDC(hdc);
    SelectObject(hdcMem, hBitmap); 
    GetObject(hBitmap, sizeof(BITMAP), (LPSTR)&bm);
    BitBlt(hdc, xLeft, yTop, bm.bmWidth, bm.bmHeight, hdcMem, 0, 0, SRCCOPY);
    DeleteDC(hdcMem);
    DeleteObject(hBitmap);
    return(TRUE);
}
/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}
/***********************************************************************/
