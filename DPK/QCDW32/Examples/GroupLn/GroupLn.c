//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998         *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   GroupLn.C                                  *
//*   Author   :   DMB                                        *
//*   Revision :   3.0                                        *
//*   Date     :   June 5, 1998                               *
//*   Product  :   Charting Tools for Windows                 *
//*                                                           *
//*   Description: Example of group line plot vs. 			  *
//*                stacked line plot plots                    *
//*                                                           *
//*                                                           *
//*************************************************************

/*
    Special Features for this demo are:

    Graph 1:
	 a grouped line plot is displayed
    Graph 2:
     a stacked line graph is displayed.
     
*/

#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "menus.h"

#define NUMP1 21                  // number of data points for graph 1
#define NUMP2 5                   // number of data points for graph 2
#define NUMGROUP 5                // number of groups

#define BTN_HIDE 0				// hide print buttons (text & rect) and surrounding graph window
#define BTN_SHOW 1				// show print buttons  and surrounding graph window


HINSTANCE     hInst;              // global instance handle

LPREAL  lpX1, lpY1, lpY2;

LPREAL  lpGX1, lpGY1;

LPREAL  lpNX1, lpNY1;
LPREAL  lpNX2, lpNY2;
LPREAL  lpNX3, lpNY3;
LPREAL  lpNX4, lpNY4;
LPREAL  lpNX5, lpNY5;


LPSTR   lpXStr, lpXStr2;  // string arrays 

PPAGE_DEF pPageDesc;
PGRAPH_DEF pGraph2, pGraph3;

HGOBJ	hGroupLines;
HGOBJ	hTextP, hTextL;
HGOBJ	hRectP, hRectL;
HGOBJ	hLabX1, hLabX2, hLabY;
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
void CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc);

BOOL DisplayBitmap (HDC hdc, LPCSTR pName, int xLeft, int yTop);
realtype randreal(void);

void DisplayPrintWindow(int mode);

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
      "Group Lines Demo",	                // Main window title
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
		        pPageDesc = 
					WGCreatePage("PAGE1", // page ID string
        	       hwnd,               // handle to the parent window
	    	       hInst,              // application instance handle 
           	       "Grouped Line Plot", // Page Window title string 
		           StartPage1,         // graph creation function
	      	       "PageMenu",         // Name of page window menu in resource file
	    	       C_LIGHTGRAY,        // window background color
	      	       MM_PROPORT,         // window sizing mode
	  	           0L,                 // window style - default
	      	       PAGE_EXACT,        // window initial size and position option
        		    100, 75, 800, 575);        
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
			  free (lpX1);	free (lpY1);	free (lpY2);
			  free (lpGX1); free(lpGY1);

			  free(lpNX1);	free(lpNY1);
			  free(lpNX2);	free(lpNY2);
			  free(lpNX3);	free(lpNY3);
			  free(lpNX4);	free(lpNY4);
			  free(lpNX5);	free(lpNY5);
  	          WGCleanup(TRUE);   // clean up charting tools memory
              PostQuitMessage(0);
   			  free (lpXStr);
			  free (lpXStr2);

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

    realtype z, sp;

    // create simulation data for plot
/*--------------------------------------------------------------*/
    
    if (fInit) // do not initialize data twice
    {
        // define data for first graph
        lpX1 = calloc (NUMP1, sizeof(realtype));
		lpY1 = calloc (NUMP1 * 3, sizeof(realtype));
		lpY2 = calloc (NUMP1, sizeof(realtype));


		lpXStr = calloc (NUMP2*2, LABELLEN); 
		lpXStr2 = calloc (NUMP2*2, LABELLEN); 

		lstrcpy (lpXStr, "Jan");
		lstrcpy (lpXStr + LABELLEN, "");
		lstrcpy (lpXStr + 2 * LABELLEN, "Mar");
		lstrcpy (lpXStr + 3 * LABELLEN, "");
		lstrcpy (lpXStr + 4 * LABELLEN, "May");
		lstrcpy (lpXStr + 5 * LABELLEN, "");
		lstrcpy (lpXStr + 6 * LABELLEN, "Jul");
		lstrcpy (lpXStr + 7 * LABELLEN, "");
		lstrcpy (lpXStr + 8 * LABELLEN, "Sept");
		lstrcpy (lpXStr + 9 * LABELLEN, "");

		lstrcpy (lpXStr2, "Feb");
		lstrcpy (lpXStr2 + LABELLEN, "");
		lstrcpy (lpXStr2 + 2 * LABELLEN, "Apr");
		lstrcpy (lpXStr2 + 3 * LABELLEN, "");
		lstrcpy (lpXStr2 + 4 * LABELLEN, "Jun");
		lstrcpy (lpXStr2 + 5 * LABELLEN, "");
		lstrcpy (lpXStr2 + 6 * LABELLEN, "Aug");
		lstrcpy (lpXStr2 + 7 * LABELLEN, "");
		lstrcpy (lpXStr2 + 8 * LABELLEN, "");
		lstrcpy (lpXStr2 + 9 * LABELLEN, "");
	
		// initialize data
        for (i = 0, z = 0.0; i < NUMP1; i++)
        {
		   z = z + 1.0;
		   if  (((i + 1) % 5) == 0)  z = z + 2.0; 
        	   lpX1 [i] = z;
		   sp = 10 + i + 3 * randreal();
               lpY1 [i * 3] =  sp + 1.0+3.0 * randreal();
        	   lpY1 [i * 3 + 1] = sp - 1.0-3.0 * randreal();
		   lpY1 [i * 3 + 2] = sp;
        	   z = z + 1.0;
		   lpY2 [i] = 10 + i + 3 * randreal();
        }

		
        lpGX1 = calloc (NUMP2, sizeof(realtype));
    	lpGY1 = calloc (NUMP2 * NUMGROUP, sizeof(realtype));;

		lpNX1 = calloc (NUMP2, sizeof(realtype));
		lpNY1 = calloc (NUMP2, sizeof(realtype));
 		lpNX2 = calloc (NUMP2, sizeof(realtype));
		lpNY2 = calloc (NUMP2, sizeof(realtype));
		lpNX3 = calloc (NUMP2, sizeof(realtype));
		lpNY3 = calloc (NUMP2, sizeof(realtype));
		lpNX4 = calloc (NUMP2, sizeof(realtype));
		lpNY4 = calloc (NUMP2, sizeof(realtype));
		lpNX5 = calloc (NUMP2, sizeof(realtype));
		lpNY5 = calloc (NUMP2, sizeof(realtype));
	    for (i = 0; i < NUMP2; i++)
		{
			for (j = 0; j < NUMGROUP; j++)
	    		lpGY1[i*NUMP2+j] = (randreal() * 5.0 * (j+1)) + randreal();
         	
		}
	    for (i = 0; i < NUMP2; i++)
		{
			for (j = 0; j < NUMGROUP; j++)
			{
    			lpGX1[j] = j;
	    		lpGY1[i*NUMP2+j] = j*NUMP2+i + 2 + (j * randreal() *3);
			}
		}

    for (i = 0; i < NUMP2; i++)
    {
 		lpNX1[i] = i * 1.0;		lpNY1[i] = lpGY1[i*5];
		lpNX2[i] = i * 1.0;		lpNY2[i] = lpGY1[i*5 + 1];
 		lpNX3[i] = i * 1.0;		lpNY3[i] = lpGY1[i*5 + 2];
 		lpNX4[i] = i * 1.0;		lpNY4[i] = lpGY1[i*5 + 3];
 		lpNX5[i] = i * 1.0;		lpNY5[i] = lpGY1[i*5 + 4];	  
    }
 }
/*--------------------------------------------------------------*/

    // Initialize graph 


	// Grouped Line Plot
    pGraph2 = WGCreateGraph (pPageDesc,
		 DrawP1G2,		// points to function which builds graph
		 0.02, 0.02,	// window realtive position inside parent page window
		 0.48, 0.88,
		 C_BLUE,		// blue background
 		 C_LIGHTRED,	// light red border
		 3);			// border width in pixels

	// Stacked Line Plot
    WGCreateGraph (pPageDesc,
		 DrawP1G1,		// points to function which builds graph
 		 0.5, 0.02,		// window realtive position inside parent page window
 		 0.98, 0.88,
		 C_WHITE,		// white background
 		 C_CYAN,		// light cyan border
 		 5);			// border width in pixels

	// Text Window - simulated buttons
    pGraph3 = WGCreateGraph (pPageDesc,
		 DrawP1G3,		// points to function which builds graph
		 0.25, 0.895,	// window realtive position inside parent page window
		 0.75, 0.995,
 		 C_YELLOW,		// yellow background
		 C_GRAY,		// gray border
		 3);			// border width in pixels

}


/*******************************************************
   Builds the graph using Q-C Windows Charting Calls                        
********************************************************/
void CALLBACK DrawP1G1 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY;
    HDATA   hDataSet1;
    int		nLineColor[NUMP1];

    // define a group data set for Stacked plot, group size = 3
    hDataSet1 = WGDefineGroupDataSetPtr ("Stacked", lpX1, lpY1, NUMP1, 3);

    // set the plotting area, background color is light gray
    WGSetPlotArea(pGrDesc, hdc, 0.18, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // Set the line style to solid black
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_BLACK);

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, 0.0, 5.0, 50.0, 100.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, 0.0, 5.0);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 10.0, 0, POS_BELOW);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between  
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10, 1, POS_LEFT);

	// set the font to ARIAL, 8 points
    WGSetTextByName (C_BLACK, "Arial", 9, 0);

    // label x and y axis in decimal format
    WGLabelAxis(pGrDesc, hdc, hAxisX, POS_BELOW, NF_DECIMAL, 0, LL_ON, NULL);
    WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    // draw an x axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisX, GRID_MAJOR);

    // draw an y axis grid on major ticks
    WGDrawGrid (pGrDesc, hAxisY, GRID_MAJOR);

    // change the line style to solid, green, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_GREEN);

    // change the line style to solid, yellow, 1 pixel thick
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_YELLOW);

	nLineColor[0] = C_CYAN;
	nLineColor[1] = C_BLACK;
	nLineColor[2] = C_GREEN;

    // display the stacked line graph, filling the adjacent area beteen the lines
	WGStackedLines (pGrDesc, hdc, hDataSet1, TRUE, NULL, NULL, nLineColor);

    // change to bold text 
    WGSetTextByName (C_BLUE, "Arial", 10, TEXT_BOLD);

    // display the x axis title
    WGTitleAxis(pGrDesc, hdc, hAxisX, POS_BELOW, "Trading by Day");

    // display the y axis title
    WGTitleAxis(pGrDesc, hdc, hAxisY, POS_LEFT, "Stock Price");

    // now set text to ARIAL, size 14, bold text
    WGSetTextByName (C_BLUE, "Arial", 14, TEXT_BOLD);

    // display the window title
    WGTitleGraph(pGrDesc, hdc, "Stacked Line Plot");

    // now set text to ARIAL, size 8
    WGSetTextByName (C_BLUE, "Arial", 8, 0);

}

/***************************************************************************/

void CALLBACK DrawP1G2 (PGRAPH_DEF pGrDesc, HDC hdc)
{
    HGOBJ   hAxisX, hAxisY, hAxis2;
	HDATA   hDataSet;          // data set handle
	HDATA	hNorm1, hNorm2, hNorm3, hNorm4, hNorm5;

    int     i;
    int     nLineColor[NUMGROUP];
	int		nLineWidth[NUMGROUP];


    // define a group data set
    hDataSet = WGDefineGroupDataSetPtr ("GROUP LINE", lpGX1, lpGY1, 
        NUMP2, NUMGROUP);

	hNorm1 = WGDefineDataSetPtr("Scatter", lpNX1, lpNY1, NUMP2);
	hNorm2 = WGDefineDataSetPtr("Scat2", lpNX2, lpNY2, NUMP2);
	hNorm3 = WGDefineDataSetPtr("Scat3", lpNX3, lpNY3, NUMP2);
	hNorm4 = WGDefineDataSetPtr("Scat4", lpNX4, lpNY4, NUMP2);
	hNorm5 = WGDefineDataSetPtr("Scat5", lpNX5, lpNY5, NUMP2);


    // set the plotting area
    WGSetPlotArea(pGrDesc, hdc, 0.15, 0.15, 0.9, 0.8, C_LIGHTGRAY);

    // scale the ploting area from x = 0 to 4 and y - 0 to 55
    WGScalePlotArea (pGrDesc, -0.5, 0.0, 4.5, 40.0);

    // set the intercepts to 0,0
    WGSetXYIntercepts (pGrDesc, -0.5, 0.0);

    // axes to be drawn as a solid black line, 1 pixel thick.
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTGRAY);

    // draw the y axis with major ticks every 5th physical unit,
    // with no minor ticks in between  
    hAxisY = WGDrawYAxis(pGrDesc, hdc, 10, 1, POS_LEFT);

    // draw the x axis with major ticks every 1 physical coords and 0 minor 
    // tick between each major tick
    hAxisX = WGDrawXAxis(pGrDesc, hdc, 0.5, 0, POS_BELOW);

    // assign each line width
    for (i = 0; i < NUMGROUP; i++)
    	nLineWidth[i] = 2;
	
    // assign each line color
   	nLineColor [0] = C_GREEN;
   	nLineColor [1] = C_LIGHTMAGENTA;
   	nLineColor [2] = C_YELLOW;
   	nLineColor [3] = C_BLUE;
   	nLineColor [4] = C_LIGHTRED;

    hGroupLines = WGGroupLines (pGrDesc, hdc, hDataSet, FALSE, NULL, nLineWidth, nLineColor);

	WGScatterPlot(pGrDesc, hdc, hNorm1, MK_ASTERISK, C_WHITE, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, hdc, hNorm2, MK_UPTRIANGLE, C_BLACK, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, hdc, hNorm3, MK_DOWNTRIANGLE, C_YELLOW, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, hdc, hNorm4, MK_BOX, C_LIGHTCYAN, 8, MKS_FILLED, FALSE);
	WGScatterPlot(pGrDesc, hdc, hNorm5, MK_CIRCLE, C_LIGHTBLUE, 8, MKS_FILLED, FALSE);


	// set the font to ARIAL, 8 points
    WGSetTextByName (C_WHITE, "Arial", 8, 0);

    // label the y-axis, display labels in decimal format
    hLabY = WGLabelAxis(pGrDesc, hdc, hAxisY, POS_LEFT, NF_DECIMAL, 0, LL_ON, NULL);

    // label x axis with months as strings
	hLabX1 = WGLabelAxisStringsPtr (pGrDesc, hdc, hAxisX, POS_BELOW, 1, lpXStr);

    // now set text to ARIAL, size 12, bold text
    WGSetTextByName (C_WHITE, "Arial", 12, TEXT_BOLD);

    // display the graph title
    WGTitleGraph(pGrDesc, hdc, "Sales");

	// Draw second X-axis below
    WGSetXYIntercepts (pGrDesc, -0.5, -5.0);
    WGSetLineStyle(pGrDesc, hdc, PS_SOLID, 1, C_LIGHTGRAY);
    hAxis2 = WGDrawXAxis(pGrDesc, hdc, 0.5, 0, POS_BELOW);

    WGSetTextByName (C_WHITE, "Arial", 8, 0);
	hLabX2 = WGLabelAxisStringsPtr (pGrDesc, hdc, hAxis2, POS_BELOW, 2, lpXStr2);
}

/***************************************************************************/

void CALLBACK DrawP1G3 (PGRAPH_DEF pGrDesc, HDC hdc)
{
	hRectP = WGRectangleNorm (pGrDesc, hdc, 0.18, 0.075, 0.37, 0.9,
		C_BLACK, 2, TRUE, RGB(255, 255, 128));

	hRectL = WGRectangleNorm (pGrDesc, hdc, 0.57, 0.075, 0.83, 0.9,
		C_BLACK, 2, TRUE, RGB(255, 255, 128));

	WGSetTextByName (C_BLACK, "Arial", 11, TEXT_BOLD);

	hTextP = WGMultiTextNorm (pGrDesc, hdc, "Print\nPortrait", 
		0.2, 0.09, TA_LEFT, TEXT_NORMAL);
	hTextL = WGMultiTextNorm (pGrDesc, hdc, "Print\nLandscape", 
		0.7, 0.09, TA_CENTER, TEXT_NORMAL);
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

BOOL IsPrintText(HGOBJ hObj, LPINT orient)
{
	if (hObj == hTextP) 
	{
		*orient = ORIENT_PORTRAIT;
		return TRUE;
	}
	else if (hObj == hTextL)
	{
		*orient = ORIENT_LANDSCAPE;
		return TRUE;
	}
	return FALSE;
}

void PrintPage (int orient)
{
	WGSetPrintOrient (orient);		// Set desired output orientation
	DisplayPrintWindow (BTN_HIDE);	// Hide print text, buttons, and graph window
	WGPrintPage (pPageDesc);		// Print page with selected orient
	DisplayPrintWindow (BTN_SHOW);	// Show print text, buttons, and graph window
}

void DisplayPrintWindow(int mode)
{
	if (mode == BTN_HIDE)	
	{
		// Hide printing buttons and text while printing
		WGShowObject (pGraph3, hRectP, FALSE);
		WGShowObject (pGraph3, hTextP, FALSE);
		WGShowObject (pGraph3, hRectL, FALSE);
		WGShowObject (pGraph3, hTextL, FALSE);

		// Hide graph window while printing
		WGSetGraphBorder (pGraph3, FALSE, C_GRAY, 3);

		// Change color of axis labels to LIGHTGRAY b/c white doesn't show up on printer
		WGChangeTextColor (pGraph2, hLabX1, C_LIGHTGRAY);
		WGChangeTextColor (pGraph2, hLabX2, C_LIGHTGRAY);
		WGChangeTextColor (pGraph2, hLabY, C_LIGHTGRAY);
	}
	else // show again
	{
		// Show printing buttons and text when done printing
		WGShowObject (pGraph3, hRectP, TRUE);
		WGShowObject (pGraph3, hTextP, TRUE);
		WGShowObject (pGraph3, hRectL, TRUE);
		WGShowObject (pGraph3, hTextL, TRUE);

		// Redraw graph window with original border color
		WGSetGraphBorder (pGraph3, TRUE, C_GRAY, 3);
		WGRedrawGraph (pGraph3, FALSE);

		// Change color of axis labels back to WHITE
		WGChangeTextColor (pGraph2, hLabX1, C_WHITE);
		WGChangeTextColor (pGraph2, hLabX2, C_WHITE);
		WGChangeTextColor (pGraph2, hLabY, C_WHITE);

		WGRedrawObject (pGraph2, hLabX1, FALSE);
		WGRedrawObject (pGraph2, hLabX2, FALSE);
		WGRedrawObject (pGraph2, hLabY, FALSE);
	}
}