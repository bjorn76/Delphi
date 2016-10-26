//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   StockHLC.C                                 *
//*   Author   :   RQ                                         *
//*   Revision :   3.0                                        *
//*   Date     :   June 27, 1998                              *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of a Stock High-Low-Close Plot     *
//*                                                           *
//*                                                           *
//*************************************************************

/*     
    The project for this demo includes:

    STOCKHLC.C DEMO.RC  HOOK.C QCWINIT.C MWCT32D.LIB
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"
#include <time.h>

#define NUMP1 21                  // number of data points for graph 1
#define NUMP2 5                   // number of data points for graph 2
#define NUMGROUP 5                // number of groups

HINSTANCE     hInst;              // global instance handle
HGLOBAL       hX1, hY1, hY2;      // global handles to data
HGLOBAL	      hGX1, hGY1;

char szAppName[] = "HLCDemo";  /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions
BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
    LPARAM lParam);

long CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);
void CALLBACK StartPage1 (PPAGE_DEF pPageDesc);   // these functions must be 
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc);

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
      "High-Low-Close Demo",	                // Main window title
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
           	       "High-Low-Close",   // Page Window title string 
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
		hY1 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP1 * 4);
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
           lpY1 [i * 4] =  sp + 1.0+3.0 * randreal();     // High
           lpY1 [i * 4 + 1] = sp - 1.0-3.0 * randreal();  // Low
		   lpY1 [i * 4 + 2] = sp;                         // Close
 		   lpY1 [i * 4 + 3] = lpY1[i*4+1] + randreal()* (lpY1[i*4] - lpY1 [i*4+1]); // Open
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
 		 0.01, 0.01, // window realtive position inside parent page window
 		 0.99, 0.99,
		 C_WHITE,     // white background
 		 C_LIGHTCYAN, // light cyan border
 		 3);          // border width in pixels
#if 0
    WGCreateGraph (pPageDesc,
		 DrawP1G2, // points to function which builds graph
		 0.01, 0.67, // window realtive position inside parent page window
		 0.99, 0.99,
		 C_WHITE,     // white background
 		 C_LIGHTRED,  // light red border
		 3);          // border width in pixels
#endif
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
	realtype rMinX, rMinY, rMaxX, rMaxY;
	realtype rTickSpaceX, rTickSpaceY;
	struct tm tStartDate = {0,0,0,0,0,0,0,0,0};
#if 1
    // define a group data set for High-Low-Close plot, group size = 3
    hDataSet1 = WGDefineGroupDataSet ("Q-C Stock", hX1, hY1, NUMP1, 4);

    // define a linear data set
    hDataSet2 = WGDefineDataSet ("DOW Jones", hX1, hY2, NUMP1);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, hdc, 0.10, 0.15, 0.95, 0.9, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // set the font to ARIAL
    WGSetTextByName (C_BLUE, "Arial", 12, 0);

    // analyze the group data, scale the plotting area,
    // draw and label the x and y axes
//   WGAutoAxes(pGrDesc, hdc, hDataSet1, AS_ROUNDCLOSE, INTF_ZERO, 
//       &hAxisX, &hAxisY, NULL, NULL);
   WGGetMinMaxYGroup (hDataSet1,0, GROUP_ALL_Y, &rMinY,  &rMaxY);
   WGGetMinMaxX (hDataSet1,  &rMinX, &rMaxX);

    WGRoundAxis2 (pGrDesc, OR_HORZ, ST_LINEAR, 
           &rMinX,  &rMaxX, &rTickSpaceX, AS_ROUNDCLOSE);
    WGRoundAxis2 (pGrDesc, OR_VERT, ST_LINEAR, 
           &rMinY,  &rMaxY, &rTickSpaceY, AS_ROUNDCLOSE);
    rMinY = 0;
	WGScalePlotArea (pGrDesc, rMinX, rMinY, rMaxX, rMaxY);
    // set the intercepts to 0,0
	WGSetXYIntercepts (pGrDesc, rMinX ,rMinY);

    // X-axis to be drawn in solid, black, 2 pixels thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 2, C_BLACK);

    // draw the x axis with major ticks every physical coord and 0 minor tick
    // the ticks will be positioned at the center of the axis
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 7.0, 6, POS_BELOW);
	tStartDate.tm_year = 1998;
	tStartDate.tm_mon = 5;
	tStartDate.tm_mday = 1;
    WGLabelAxisDate ( pGrDesc,  hdc,  hAxisX,  POS_BELOW, DATE_MDY, 
	   DTB_DATE_DAY, &tStartDate,	NULL, LL_ON, "DATE");   
    // Y axis to be drawn in solid, black, 1 pixels thick

    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    // draw the y axis with major ticks every 100 physical coords and 1 minor ticks
    hAxisY = WGDrawYAxis(pGrDesc, hdc, rTickSpaceY, 9, POS_LEFT);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 1, LL_ON, NULL);
 
    // draw an x axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);

    // draw an y axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    // change the line style to solid, green, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_GREEN);

    // display a line plot of data set 2
    WGLinePlot (pGrDesc, hdc, hDataSet2, TRUE, FALSE);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 3, C_YELLOW);

    // create a high-low-close plot for the group data set.
    // A filled box represents the Close value
    WGStockOpenHighLowClose (pGrDesc, hdc, hDataSet1, 0.75);



    // change to bold text 
    WGSetTextByName (C_BLUE, "Arial", 12, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Trading by Day");
    // display the y axis title
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Stock Price");

    // now set text to ARIAL, size 15, bold text
    WGSetTextByName (C_BLUE, "Arial", 15, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, hdc, "Stock Open-Hi-Low-Close Plot");

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, "Arial", 14, 0);

    // create legend strings
    hStr = GlobalAlloc(GPTR, 2 * LG_MAXLEN);
    lpstr = GlobalLock(hStr);

    // copy the legend strings
    lstrcpy(lpstr, "Dow Jones");
    lstrcpy(lpstr + LG_MAXLEN, "Quinn-Curtis");

    WGLegend  (pGrDesc, hdc, 0.15, 0.15, 0.45, 0.4, C_RED, 1, C_BLACK, 
        C_WHITE, OR_VERT, hStr);

    // legend strings can be freed immediately.
    GlobalFree (hStr);
#endif
}

/***************************************************************************/

void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;                      
	HDATA   hDataSet;          // data set handle
    int     i;
    int     nLineColor[NUMGROUP];


    // define a group data set
    hDataSet = WGDefineGroupDataSet ("STACKED LINE", hGX1, hGY1, 
        NUMP2, NUMGROUP);

    // set the plotting area
    WGSetPlotArea(pGrDesc, hdc, 0.10, 0.15, 0.95, 0.8, C_LIGHTGRAY);

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, 0.0, 0.0, 4.0, 55.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 0.0);

    // axes to be drawn as a solid black line, 1 pixel thick.
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);
    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between  
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10, 1, POS_LEFT);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 1, 0, POS_BELOW);

    // assign each line color
    for (i = 0; i < NUMGROUP; i++)
    	nLineColor [i] = i + 1;
	
    // display the stacked line graph, filling the adjacent area beteen the lines
    WGStackedLines (pGrDesc, hdc, hDataSet, TRUE, NULL, NULL, nLineColor);

    // set the font to ARIAL, 8 points
    WGSetTextByName (C_BLUE, "Arial", 8, 0);

    // label the y-axis, display labels in decimal format
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    // label x axis from Mon to Fri
    WGLabelAxisDayWk (pGrDesc, hdc, hAxisX, POS_BELOW, 0, 2, FALSE);

    // now set text to ARIAL, size 12, bold text
    WGSetTextByName (C_BLUE, "Arial", 12, TEXT_BOLD);

    // display the graph title
    WGTitleGraph(pGrDesc, hdc, "Sales");

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

