//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           
//*   Filename :   CANDLSTK.C                                  
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
//*   Product  :   Charting Tools                     
//*                                                           
//*   Description: Example Candlestick &                                   
//*                 Open-High-Low-Close                       
//                                                            
//*************************************************************

/*
    Special Features for this demo are:

    Graph 1:
     a candlestick chart is displayed
     a legend will be displayed at the top of the window

    Graph 2:
     a high-low-close-open is displayed.
     the x axis displays days of week instead of numeric values.
     
    The project for this demo includes:

    CANDLSTK.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"

#define NUMP1 21                  // number of data points for graph 1
#define NUMP2 5                   // number of data points for graph 2
#define NUMGROUP 5                // number of groups
#define GROUPSIZE 4

HINSTANCE     hInst;              // global instance handle
HGLOBAL       hX1, hY1, hY2;      // global handles to data
HGLOBAL	      hGX1, hGY1;

char szAppName[] = "Candle";  /* Class Name used in call to CreateWindow. */

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
      "Candlestick Demo",	                // Main window title
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
           	       "Candlestick",   // Page Window title string 
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
    int     i, j;
    static  BOOL fInit = TRUE;
    LPREAL  lpX1, lpY1, lpY2;
    LPREAL  lpGX1, lpGY1;
    realtype z, sp;

    // create simulation data for plot
/*--------------------------------------------------------------*/
    
    if (fInit) // do not initialize data twice
    {
        // define data for first graph
		hX1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);
		hY1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1 * GROUPSIZE);
		hY2 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1);

		// get pointers to data arrays
            lpX1 = (LPREAL) GlobalLock(hX1);
		lpY1 = (LPREAL) GlobalLock(hY1);
		lpY2 = (LPREAL) GlobalLock(hY2);

     		// initialize data
        for (i = 0, z = 0.0; i < NUMP1; i++)
        {
		   z = z + 1.0;
		   if  (((i + 1) % 5) == 0)  z = z + 2.0; 
        	   lpX1 [i] = z;
		   sp = 10 + i + 3 * randreal();
           lpY1 [i * GROUPSIZE] =  sp + 1.0+3.0 * randreal();
      	   lpY1 [i * GROUPSIZE + 1] = sp - 1.0-3.0 * randreal();
		   lpY1 [i * GROUPSIZE + 2] = sp;
		   if (i % 2)
			lpY1 [i * GROUPSIZE + 3] = sp + 1.0-2.0 * randreal();
		   else
			lpY1 [i * GROUPSIZE + 3] = sp - 1.0-2.0 * randreal();
       	   z = z + 1.0;
		   lpY2 [i] = 10 + i + 3 * randreal();
        }

    	hGX1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP2);
	    hGY1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP2 * NUMGROUP);

	// get pointers to data arrays
        lpGX1 = (LPREAL) GlobalLock(hGX1);
    	lpGY1 = (LPREAL) GlobalLock(hGY1);

	    for (i = 0; i < NUMP2; i++)
	    for (j = 0; j < NUMGROUP; j++)
	    {
    		lpGX1[j] = j;
	    	lpGY1[i*NUMP2+j] = (randreal() * 5.0 * (j+1)) + randreal();
        }
    }
/*--------------------------------------------------------------*/

      // Initialize graph 

    WGCreateGraph (pPageDesc,
		 DrawP1G1, // points to function which builds graph
 		 0.002, 0.002, // window realtive position inside parent page window
 		 0.66, 0.66,
		 C_WHITE,     // white background
 		 C_LIGHTCYAN, // light cyan border
 		 3);          // border width in pixels
}


/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1;
    HGLOBAL  hStr;
    LPSTR    lpstr;
	HGOBJ   hCandle;

    // define a group data set for candlestick plot, group size = 3
    hDataSet1 = WGDefineGroupDataSet ("Q-C Stock", hX1, hY1, NUMP1, GROUPSIZE);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, hdc, 0.13, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, "Arial", 10, 0);

    // analyze the group data, scale the plotting area,
    // draw and label the x and y axes
    WGAutoAxes(pGrDesc, hdc, hDataSet1, AS_ROUNDCLOSE, INTF_ZERO, 
        &hAxisX, &hAxisY, NULL, NULL);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_LIGHTBLUE);

    // create a high-low-close plot for the group data set.
    // A filled box represents the Close value
    hCandle = WGCandlestick (pGrDesc, hdc, hDataSet1, 2, RGB(128, 0, 0), C_BLUE);
    // change to bold text 
    WGSetTextByName (C_BLUE, "Arial", 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Trading by Day");

    // display the y axis title
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Stock Price");

    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, "Arial", 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, hdc, "Candlestick Plot");

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, "Arial", 8, 0);

    // create legend strings
    hStr = GlobalAlloc(GPTR, 1 * LG_MAXLEN);
    lpstr = GlobalLock(hStr);

    // copy the legend strings
    lstrcpy(lpstr, "QUIN");

    WGLegend(pGrDesc, hdc, 0.15, 0.15, 0.45, 0.4, C_RED, 1, 
		C_BLACK, C_WHITE, OR_VERT, hStr);
    // legend strings can be freed immediately.
    GlobalFree (hStr);
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
