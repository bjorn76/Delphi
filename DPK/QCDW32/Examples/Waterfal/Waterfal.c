//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   Waterfal.c                                 *
//*   Author   :   DMB                                        *
//*   Revision :   3.00                                       *
//*   Date     :   April 15, 1998                             *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of building a waterfall graph      *
//*                with Charting Tools                        *
//*                                                           *
//*************************************************************



#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"
#include <time.h>    

#define NUMPOINTS 64                // number of data points
#define NUMGROUPS 32				// number of data groups

HINSTANCE     hInst;				// global instance handle

HPREAL  lpInd, lpDep;				// data arrays 
PGRAPH_DEF pGraph1;

HGOBJ hWaterfall;
HGOBJ hLegend;

char szAppName[] = "Demo";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message,
			     WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartGraphs1 (PPAGE_DEF pPageDesc);   
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

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam,
													   LPARAM lParam)
{
    switch (message)
    {
        case WM_RBUTTONDOWN:
          // When the right mouse button is pressed, the
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
      	    PAGE_CLIENT,			// window initial size and position option
	        0, 0, 0, 0);        // initial window size and position
								// if used (not used here)
          return 0;

		case WM_COMMAND:
        {
             if (wParam == IDM_ABOUT)
             {
        		  DialogBox(hInst,		     /* current instance	 */
            	    "AboutBox",	    		 /* resource to use	     */
		            hwnd,			         /* parent window handle */
				     (DLGPROC)AboutProc);    /* AboutProc() instance address */
             }
        }
        return 0;

		case WM_PAINT: // paint main window
        {
             PAINTSTRUCT ps;
             HDC  hdc = BeginPaint(hwnd, &ps);
             RECT rect;
    		 int     verWCTMain, verWCTSec;     // version of Charting Tools
    		 char    szVer[50] = {"Charting Tools version " };
    		 char    szVerNum [10];
    		 LPSTR   pDate;

    			
            // function calls to repaint main window go here
            GetClientRect (hwnd, &rect);
        	SetTextAlign (hdc, TA_BASELINE | TA_CENTER);
        	TextOut(hdc, rect.right / 2, rect.bottom / 2,
               "Press Right Mouse Button !", 26);
			 
            // Display version of the tools
			verWCTMain = WGGetVersion (&verWCTSec);
    		wsprintf (szVerNum, "%d.%d", verWCTMain, verWCTSec);
    		lstrcat (szVer, szVerNum);

            if ((verWCTMain > 2) || (verWCTSec >= 20))
            {
                pDate = WGGetDate();
        		lstrcat (szVer, ", ");
        		lstrcat (szVer, pDate);
            }
    	 	SetWindowText (hwnd, szVer);
    
			EndPaint(hwnd, &ps);
        }
  	    return 0;
    
        case WM_DESTROY:
            free (lpInd);
        	free (lpDep);

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

void  CALLBACK StartGraphs1(PPAGE_DEF pPageDesc)
{
    long     i, k;
    realtype magn;
    static  BOOL fInit = TRUE;
    // create simulation data for plot
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate data arrays
        lpInd = calloc (NUMPOINTS,  sizeof (realtype));
    	lpDep = calloc (NUMPOINTS * NUMGROUPS,  sizeof (realtype));

        // create independent and dependent data to be plotted
		for (i=0; i < NUMPOINTS; i++)
		{
			lpInd[i] = i * 2.1;
			for (k=0; k < NUMGROUPS; k++)
			{	
				magn = ((realtype) (i)/ 7.0 );
				magn = magn * 0.5 + 0.5 * magn * ((realtype) rand()/ (realtype) RAND_MAX );
				
				lpDep[i*NUMGROUPS+k] = magn * sin (lpInd[i] / 20);
				lpDep[i*NUMGROUPS+k] = lpDep[i*NUMGROUPS+k] * lpDep[i*NUMGROUPS+k];
			}
		}
        fInit = FALSE;
    }

/*--------------------------------------------------------------*/

      // Initialize graph 

    pGraph1 = WGCreateGraph (pPageDesc,
		 DrawP1G1,		// points to function which builds graph
		 0.005, 0.005,	// window relative position inside parent page window
		 0.99, 0.99,
		 C_WHITE,		// white background
		 C_RED,			// red   border
		 1);			// border width in pixels
                    
}

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;  // axes handles
    HDATA   hDataSet;        // data set handle
    int     nLineColor[NUMGROUPS];
    int     nLineColor2[NUMGROUPS];
	int		nLineWidth[NUMGROUPS];
	int		i;	

    // define a dataset 
    hDataSet = WGDefineGroupDataSetPtr ("Waterfall Plot", lpInd, lpDep, 
										NUMPOINTS, NUMGROUPS);

    // define the plotting area of the graph 
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.80, C_LIGHTGRAY);

    // axes to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

	// set current font to Arial, 12 points, bold
    WGSetTextByName (C_BLACK, "Arial", 10, TEXT_BOLD);

    // scale the plotting area
	WGScalePlotArea (pGrDesc, 0.0, 0.0, 200.0, 150.0);

    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis: 0 minor ticks and 
	//  the ticks will be positioned at the center of the axis
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 20.0, 0, POS_MIDDLE);

    // Y axis to be drawn in solid, black, 1 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 25 physical coords and 1 minor tick
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 25.0, 1, POS_LEFT);

   // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 1, LL_ON, NULL);
	   // Label the y axis, in decimal format, 1 digit after the decimal point.
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);


    // Set line style of outline to be black, dotted
    WGSetLineStyle(pGrDesc, hdc, PS_DOT, 1, C_BLACK);


	for (i=0; i<NUMGROUPS; i++)
	{
		nLineWidth[i] = 1;
		nLineColor[i] = i%16;
		nLineColor2[i] = (i%8) + 4;
	}
	hWaterfall = WGWaterfallPlot (pGrDesc, hdc, hDataSet, 1.5, 3.0,  
						TRUE, TRUE, TRUE, NULL, nLineWidth, nLineColor);
					// fill, baseline, outline

    // Write axes titles
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Sample Interval");
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Volts");

	// set current font to Arial, 16 points, bold, italic
    WGSetTextByName (C_BLUE, "Arial", 16, TEXT_BOLD | TEXT_ITAL);

    // Write graph title
    WGTitleGraph(pGrDesc, hdc, "Waterfall Plot");

	WGToggleOKCursor(FALSE);
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
/**************************************************************************/

