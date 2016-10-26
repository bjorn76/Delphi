//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   BOXWHISK.C                                 *
//*   Author   :   LAB                                        *
//*   Revision :   3.0                                        *
//*   Date     :   May 10, 1998                               *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example Box & Whisker Plots                *
//*                                                           *
//*************************************************************

/*
    Special Features for this demo are:

    Graph 1:
     a high-low-close graph is displayed

    Graph 2:
     a stacked line graph is displayed.
     the x axis displays days of week instead of numeric values.
     
    The project for this demo includes:

    BOXWHISK.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"

#define NUMP1 10                  // number of data points for graph 1
#define NUMGROUP 12               // number of groups

HINSTANCE     hInst;              // global instance handle
HGLOBAL       hX1, hY1, hY2;      // global handles to data
HGLOBAL	      hGX1, hGY1;

char szAppName[] = "BWDemo";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions
BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
    LPARAM lParam);

long CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);

BOOL DisplayBitmap (HDC hdc, LPCSTR pName, int xLeft, int yTop);
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
    wc.hbrBackground = (HBRUSH) GetStockObject(WHITE_BRUSH);
    wc.lpszMenuName = "MainMenu";	// load the main menu with the 'Start' menu item
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

    // save current instance 
    hInst = hInstance; 
   
    hwnd = CreateWindow                      // Create main window
    (
      szAppName,     
      "Box & Whisker Demo",	                // Main window title
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
		case WM_COMMAND:
			switch (wParam)
			{
            	case IDM_START:
        		// When the Start menu item is selected, the page is
                // created in the current window
		        WGCreatePage("PAGE1", // page ID string
        	       hwnd,               // handle to the parent window
	    	       hInst,              // application instance handle 
           	       "Box & Whisker",   // Page Window title string 
		           StartPage1,         // graph creation function
	      	       "PageMenu",         // Name of page window menu in resource file
	    	       C_LIGHTGRAY,        // window background color
	      	       MM_PROPORT,         // window sizing mode
	  	           0L,                 // window style - default
	      	       PAGE_CLIENT,        // window initial size and position option
        		    0, 0, 0, 0);        
        		  return 0;

    			case IDM_ABOUT:
               {
        		   DialogBox(hInst,		     /* current instance	 */
            	     "AboutBox",			 /* resource to use	     */
		             hwnd,			         /* parent window handle */
					 (DLGPROC)AboutProc); /* AboutProc() instance address */
			   }
	           return 0;
           }
    	   case WM_PAINT: // paint main window
	    		hdc = BeginPaint(hwnd, &ps);
               DisplayBitmap(hdc, "bmdemo", 0, 0);
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
   functions WGCreateGraph that initializes individual graphs.
**********************************************************************/

void CALLBACK StartPage1(PPAGE_DEF pPageDesc)
{
      // Initialize graph 
    WGCreateGraph (pPageDesc,
		 DrawP1G1, // points to function which builds graph
		 0.002, 0.002, // window realtive position inside parent page window
		 0.998, 0.998,
		 C_WHITE,     // white background
 		 C_LIGHTRED,  // light red border
		 3);          // border width in pixels
}


/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1, hDataSet2;
    HGLOBAL  hStr;
    LPSTR    lpstr;
	int numgroup, numdat;
	SCATTER_DESC *pMidPtDesc;
	SCATTER_DESC *pOutlierDesc;
	SCATTER_DESC *pExtremeDesc;


    hDataSet1 = WGLoadASCIIDataSet ("boxwhisk.txt", "Box & Whisker");
	if (hDataSet1 == 0)
		return;
    // determine the number of groups in the data set
    WGGetDataSetArrays (hDataSet1, &hX1, &hY1, &numdat, &numgroup);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, hdc, 0.13, 0.1, 0.9, 0.9, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, "Arial", 10, 0);
    // analyze the group data, scale the plotting area,

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 11.0, 75.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axes to be drawn as a solid black line, 1 pixel thick.
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between  
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10, 1, POS_LEFT);
    // label the y-axis, display labels in decimal format
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 0, POS_BELOW);
    // label the y-axis, display labels in decimal format
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_ON, NULL);
	
    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_YELLOW);

	pMidPtDesc = WGCreateScatterSymbol (pGrDesc, hdc, 
		C_WHITE, MK_DOWNTRIANGLE, MKS_FILLED, 4, FALSE, "1");
	pOutlierDesc = WGCreateScatterSymbol (pGrDesc, hdc, 
	     C_YELLOW, MK_X, MKS_FILLED, 5, FALSE, "2");
	pExtremeDesc = WGCreateScatterSymbol (pGrDesc, hdc, 
		 C_CYAN, MK_CIRCLE, MKS_FILLED, 7, FALSE, "3");

    WGBoxWhisker (pGrDesc, hdc, hDataSet1, 
		BW_MEAN,		//midpoint type
  		pMidPtDesc,
		BW_STDERR,		//box type
		5,				//box size, in points
		1.0,			//box coef
		1.0,			//box const if BW_CONST
		0.0,			//% min - if box type = BW_PERCNT
		0.0,			//box % max - if box type = BW_PERCNT
		C_RED,			//box outline line color
		TRUE,			//box fill flag
		WGGetRGBColor (C_LIGHTRED), //box upper color
		WGGetRGBColor (C_LIGHTBLUE),    //box lower color
		BW_STDDEV,		//whisker type
		5,				//whisker size, in points
		1.0,			//whisker coef
		0.0,			//whisker % min
		0.0,			//whisker % min
		C_BLACK,		//whisker color
		PS_SOLID,		//line style
		1,				//line thickness
		TRUE,
		pOutlierDesc,	// MK_X, C_YELLOW, 5, 1,  //OUTLIERS
		TRUE,
		pExtremeDesc, // MK_CIRCLE, C_CYAN, 5, 1, //EXTREMES
		1.5);


    // change to bold text 
    WGSetTextByName (C_BLUE, "Arial", 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Test Scores");

    // display the y axis title
    //WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Stock Price");
    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, "Arial", 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, hdc, "Box & Whisker Plot");

    WGSetTextByName (C_BLUE, "Arial", 8, 0);
}

/***************************************************************************/
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

/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand()/(realtype)RAND_MAX;
}
/***********************************************************************/

