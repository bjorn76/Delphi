//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   pangraph.c                                 *
//*   Author   :   NP                                         *
//*   Revision :   3.0                                        *
//*   Date     :   August 15, 1998                             *     
//*   Product  :   Windows Charting Tools & Real Time Graphics*
//*                 Tools.                                    *
//*   Description: Example building a graph Bigger then the   *
//*                page it is on. Scroll(or pan) arround graph*
//*                using Scroll Bar.                          *
//*				                                         	  * 
//*************************************************************


//    pangraph.C DEMO.RC HOOK.C QCWINIT.C MWCT32D.LIB


#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "qcwrt.h"

#include "menus.h" 


#define NUMSCATTER 100


HINSTANCE     hInst;               // global instance handle
       
HGLOBAL       hXScatter, hYScatter;
HGOBJ         hAxisX;
HGOBJ  hAxisY;  // axes handles
PGRAPH_DEF pGraphDesc = NULL;
   

char szAppName[] = "Bar";  /* Class Name used in call to CreateWindow. */

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


BOOL   ScBarControlProcH (PGRAPH_DEF pGrDesc, int nPos);
BOOL  ScBarControlProcV (PGRAPH_DEF pGrDesc,  int nPos);

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
    SCROLLINFO lpsi = {28, SIF_ALL, 0,100, 10, 0, 0};
  
	lpsi.cbSize = sizeof(lpsi);

    // save current instance MUST BE HERE
    hInst = hInstance; 
   
    hwnd = CreateWindow
    (
       szAppName,                           // Create main window
       "************* Quinn-Curtis Demo for Charting Tools ************",                          // Main window title
       WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN | WS_HSCROLL  | WS_VSCROLL ,
       CW_USEDEFAULT,      CW_USEDEFAULT,
       CW_USEDEFAULT,      CW_USEDEFAULT,
       NULL,
       NULL,
       hInstance,
       NULL
    );
    if (!hwnd)
       return (FALSE);
   SetScrollInfo(hwnd,  SB_HORZ, &lpsi , TRUE );
   lpsi.nPos = 50;
   SetScrollInfo(hwnd,  SB_VERT, &lpsi , TRUE );

  
    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);
    return (TRUE);
}

int CalcScroll(int nCode, int nPos, int nThumbPos)
{ 
	switch (nCode) {
	case SB_LINEDOWN : nPos += 1; break;
	case SB_LINEUP: nPos -= 1; break;
	case SB_PAGEDOWN: nPos += 10; break;
	case SB_PAGEUP : nPos -= 10; break;
	case SB_THUMBPOSITION : nPos = nThumbPos; break;
	case SB_THUMBTRACK : nPos= nThumbPos; break;
	}
	return nPos;
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
	        	"******************* Scroll Graph ********************", // Window title string
            	StartPage1, 	    // pointer to graph creation function
        		"PageMenu",
            	C_WHITE,        // window background color
            	MM_PROPORT,         // window sizing mode
            	WS_CHILD | WS_CLIPCHILDREN | WS_VISIBLE,                 // window style - default
            	PAGE_CLIENT,        // window initial size and position option
            	0, 0, 0, 0);       
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

		case WM_VSCROLL:
			{
                int nScrollCode = (int) LOWORD(wParam);
                int nThumbPos = (int) HIWORD(wParam);
                int nPos = GetScrollPos(hwnd,SB_VERT); 
			    nPos = CalcScroll(nScrollCode, nPos, nThumbPos);
				SetScrollPos(	hwnd,  SB_VERT,  nPos,  TRUE); 
			    if (pGraphDesc)
                 ScBarControlProcV ( pGraphDesc,  nPos);
				return 0;
			}
		case WM_HSCROLL:
			{
               int nScrollCode = (int) LOWORD(wParam);
                int nThumbPos = (int) HIWORD(wParam);
               int nPos = GetScrollPos(hwnd,SB_HORZ); 
			   nPos = CalcScroll(nScrollCode, nPos, nThumbPos);
			   SetScrollPos(	hwnd,  SB_HORZ,  nPos,  TRUE); 
			   if (pGraphDesc)
                 ScBarControlProcH ( pGraphDesc,  nPos);
				return 0;
			}
		case WM_PAINT: // paint main window
			hdc = BeginPaint(hwnd, &ps);
           DisplayBitmap(hdc, "BMDEMO", 0, 0);
			EndPaint(hwnd, &ps);
            return 0;

        case WM_DESTROY:
	        WRCleanup(TRUE);   // clean up charting tools memory
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
    LPREAL   lpXScatter, lpYScatter;
	

    // create simulation data for plot
/*--------------------------------------------------------------*/

    if (fInit) // do not initialize data twice
    {
        
        hXScatter = GlobalAlloc (GPTR, sizeof (realtype) * NUMSCATTER);
        hYScatter = GlobalAlloc (GPTR, sizeof (realtype) * NUMSCATTER);
	
		lpXScatter = (LPREAL) GlobalLock(hXScatter);
		lpYScatter = (LPREAL) GlobalLock(hYScatter);
	 	
		//data for plot
		for (i = 0; i < NUMSCATTER; i++)
        {
             z = (realtype) i ;
	    	 lpXScatter [i]= z;
		     lpYScatter [i] = 5 + (30 * (cos(z * 10))) + (1/(exp(z * 5)));
		}


        fInit = FALSE;

    }

/*--------------------------------------------------------------*/

    // Initialize graph
 
    // the first graph is defined here
    // DrawGraphP1G1 is the building function
    pGraphDesc = WGCreateGraph (pPageDesc,
		DrawGraphP1G1,	// function which builds graph
		 0, 0,		 // window relative position inside parent page window                                                       
         1, 1,
		 C_LIGHTGREEN, 	// white background
         -1, 	
          0);      	// border width in pixels
}

/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/

void CALLBACK DrawGraphP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	HGOBJ  hPlot;
	
    HDATA   hDataSet;        // data set handle
	
		
    // define a dataset, display the first 75 data points of the data set. 
   	hDataSet = WGDefineDataSet ("Line1", hXScatter, hYScatter, NUMSCATTER);
	
    // define the plotting area of the graph
    WGSetPlotArea(pGrDesc, hdc, 0.10, 0.1, 0.85, 0.8, C_LIGHTRED);
	
	
    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);
		

	WGScalePlotArea(pGrDesc, 0.0, 0.0, 20, 100.0);

    // Intercepts x = 0.0, y = -1.5 
	WGSetXYIntercepts (pGrDesc, 0.0, 0.0);
	
    // axis to be drawn in solid, black, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    // Draw a tick on the y axis every 0.5 from y-intercept,
     hAxisY = WGDrawYAxis (pGrDesc, hdc, 10.0, 10, POS_LEFT);

    // set current font to Modern, 6 points, bold, italic
    WGSetTextParams (C_BLACK, FF_MODERN, 10, TEXT_BOLD | TEXT_ITAL);
	
    // Label Y-axis
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, -1, LL_ON, NULL);
				
    // Draw a tick on the x axis every 25 from the intercept,
    //	 i.e., 0.0, 25.0, 50.0, 75.0 etc. up to 200.0 
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 10, POS_BELOW);
		
    // Label every major tick, i.e, 0.0, 25, 50, ..., 200
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, -1, LL_ON, NULL);
	// set text style
    WGSetTextByName (C_BLUE, "Arial", 10, TEXT_NORMAL);
	WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTRED);

	hPlot = WGScatterPlot (pGrDesc, hdc, hDataSet, MK_CIRCLE, C_LIGHTGREEN, 6, MKS_FILLED, TRUE);
	WGTextNorm(pGrDesc, hdc, "VVV Use ScrollBar to see rest of the Plot VVV", 0.12, 0.008, TA_LEFT | TA_TOP, TEXT_NORMAL);

    WGSetGraphBitBltMode(pGrDesc, TRUE);
}

//This function will change the position of X-axis. 

BOOL   ScBarControlProcH (PGRAPH_DEF pGrDesc, int nPos)
{   static int nLastPos = -1;
   	realtype rMin, rMax, rInt;
   
   if (nLastPos != nPos)
   {
     WGGetAxisRange (pGrDesc, hAxisX, &rMin, &rMax, &rInt);

   rMin = (realtype) nPos;
   rMax = rMin + 20.0;
 
  WGChangeAxisRange (pGrDesc, hAxisX, rMin, rMax, TRUE);
  WGChangeAxisIntercept(pGrDesc, hAxisY, rMin, TRUE);
  nLastPos = nPos;
   }
   return (TRUE);
}
	 
BOOL  ScBarControlProcV (PGRAPH_DEF pGrDesc,  int nPos)
{
  static int nLastPos = -1;
  realtype rMin, rMax, rInt;
 
    if (nLastPos != nPos)
   {
     WGGetAxisRange (pGrDesc, hAxisY, &rMin, &rMax, &rInt);
   
     rMax = (realtype) nPos + 50;
     rMin = rMax - 100;
    
     WGChangeAxisRange (pGrDesc, hAxisY, rMin, rMax, TRUE);
	 WGChangeAxisIntercept(pGrDesc, hAxisX, rMin, TRUE);
	 nLastPos = nPos;
	}
   return (TRUE);
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
