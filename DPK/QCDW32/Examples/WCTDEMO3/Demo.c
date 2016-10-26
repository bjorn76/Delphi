//*************************************************************
//*                                                           *
//*     Copyright (c) QUINN-CURTIS, 1998                      *
//*                                                           *
//*************************************************************
//*                                                           *
//*   Filename :   DEMO.c                                     *
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
//*                                                           *
//*   Description: DEMO PROGRAM                               *
//*                                                           *
//*************************************************************
										
#include <windows.h>
#include <stdlib.h>
#include <math.h>

#include "qcwin.h"
#include "support.h"
#include "menus.h"
#include "demo.h"

HBRUSH hMainBrush;

#define RXDYNMAX  15.0
#define RYDYNMAX  20.0

char szTitle[] = "Quinn-Curtis Charting Tools for Windows";
HWND hwndButtons [BNUM];  // buttons handles
BOOL bDialogUp = FALSE;
HWND hDialogParent;

char *szExpl[] = 
{     
    "Automatically cycle through charts",
    "Examples of various charts",
    "Built in dialog boxes for editing charts",
    "Edit, print, and save a chart interactively",
    "Super zooming of multiple axes",
    "NEW Rev. 3.0 features, data sheets and programming examples",
    "Ordering information",
    "Exit",
};

char *szBut[] = 
{     
    "&Auto",
    "&Charts",
    "&Dialogs",
    "&Interactive",
    "&Zoom",
    "Data &sheets",
    "&Order",
    "&Exit",
};

int cxScreen, cyScreen;

HINSTANCE _hInst = NULL;              // global instance handle
int  nMode = 0;
int  nPlotNum = 0;
int  nDialCount = 0;
int  nDialNum = 0;
PPAGE_DEF pPrevPage = NULL;
PPAGE_DEF pDynPage = NULL;

char szAppName[] = "WCTDemo"; /* Class Name used in call to CreateWindow. */

// Prototypes of forward referenced functions

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message,
			     WPARAM wParam, LPARAM lParam);

BOOL InitApplication(HINSTANCE);
BOOL InitInstance(HINSTANCE, int);

void CALLBACK StartGraphsInt (PPAGE_DEF pPageDesc);
void CALLBACK StartGraphsZoom (PPAGE_DEF pPageDesc);
void CALLBACK StartGraphsDlg (PPAGE_DEF pPageDesc);
void CALLBACK StartHeader (PPAGE_DEF pPageDesc);
void CALLBACK StartPict   (PPAGE_DEF pPageDesc);

void CALLBACK StartPage1  (PPAGE_DEF pPageDesc);
void CALLBACK StartPage2  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage3  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage4  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage5  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage6  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage7  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage8  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage9  (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage10 (PPAGE_DEF pPageDesc);   
void CALLBACK StartPage11 (PPAGE_DEF pPageDesc);   

BOOL CALLBACK AboutProc (HWND hDlg, UINT message, WPARAM wParam,
     LPARAM lParam);
void CreateData(void);

extern HGLOBAL  hPieData; 
extern HGLOBAL	hPieStr;
extern HGLOBAL	hFloStr;
extern HGLOBAL  hYAxStr; 
extern HGLOBAL  hIntX1, hIntY1, hIntX12, hIntY12, hIntX13, hIntY13, hIntX14, hIntY14;
extern HGLOBAL  hX11, hY11, hX12, hY12, hX111, hY111, hXPict, hYPict;
extern HGLOBAL  hX21, hY21, hY22, hY23, hX31, hY31, hY32;
extern HGLOBAL  hX51, hY51, hX61, hY61, hY62, hGX61, hGY61;
extern HGLOBAL  hX71, hY71, hX81, hY81, hY82, hY83;
extern HGLOBAL  hX101, hY101, hX102, hY102;
extern HGLOBAL  hX112, hY112, hX113, hY113;
extern HGLOBAL  hSignal, hFFTCos, hFFTSin, hPower;
extern HGLOBAL  hTime, hFreq, hPowFreq;
extern LPREAL   lpX71, lpY71;
extern HPREAL   pSignal, pTime, pFreq, pPower, pPowFreq;
extern HDATA    hDataSet, hWFDataSet;        // data set handle
extern PGRAPH_DEF  pDynGrDesc;
extern HDATA   hLiveData, hLiveData2, hLiveData3;
extern HGOBJ   hPlot, hPlot2, hPlot3;
extern HGOBJ   hAxisXZ, hAxisYZ;  // axes handles
extern HGOBJ   hCursor1;
extern HGOBJ  hTextX, hTextY;

extern HPREAL  lpIndWater, lpDepWater;				// data arrays for waterfall plot

extern LPREAL  lpZoomX1, lpZoomY1, lpZoomY2, lpZoomY3, lpZoomY4, lpZoomY5;           // data arrays
extern HDATA   hZoomDataSet, hZoomDataSet2, hZoomDataSet3, 
        hZoomDataSet4, hZoomDataSet5;        // data set handles
extern HGOBJ hX1, hZoomY1, hZoomY2, hZoomY3, hZoomY4, hZoomY5, hZoomY6; // axis handles
extern BOOL bSuperZoomF;



PGRAPH_DEF pGrDescZoom1;
PGRAPH_DEF pGrDescZoom2;

/***********************************************************************/
/* random real number generator in the range of 0.0 to 1.0             */
/***********************************************************************/
realtype randreal(void)
{
    return (realtype)rand() / (realtype)RAND_MAX;
}
/*******************************************************
  FUNCTION: WinMain (HINSTANCE, HINSTANCE, LPSTR, int)

  PURPOSE: calls initialization function,
           processes message loop
********************************************************/

int PASCAL WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
   	            LPSTR lpCmdLine, int nCmdShow)
{
    MSG msg;

    cxScreen = (int) GetSystemMetrics (SM_CXSCREEN);
    cyScreen = (int) GetSystemMetrics (SM_CYSCREEN);
    _hInst = hInstance;

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
    DeleteObject (hMainBrush);

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
    wc.hIcon = LoadIcon(hInstance, "CHART");
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_BACKGROUND + 1);
 
    wc.lpszMenuName = "MainMenu";		// main window menu
    wc.lpszClassName = szAppName;
#ifdef WIN32
    WGStart();
//    StartWCTDll (hInstance);
#endif
    return (RegisterClass(&wc));
}

/*******************************************************
  FUNCTION: InitInstance(HINSTANCE, int)
  PURPOSE:  Saves instance handle and creates main window
********************************************************/
BOOL InitInstance (HINSTANCE hInstance, int nCmdShow)
{
    HWND   hwnd;

    hMainBrush = CreateSolidBrush(RGB(0, 128, 128));

    // save current instance - MUST BE HERE
    _hInst = hInstance; 
    InitData ();
   
    hwnd = CreateWindow
    (
      szAppName,                           // Create main window
      "Quinn-Curtis Demo",		    	   // Main window title
      WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
      0, 0,
      CW_USEDEFAULT,  CW_USEDEFAULT,
      NULL,
      NULL,
      hInstance,
      NULL
    );
  
    if (!hwnd)
      return (FALSE);
  
    ShowWindow(hwnd, SW_SHOWMAXIMIZED);
    UpdateWindow(hwnd);
    return (TRUE);
}

/************************************************************************/
/* Interactive page with two graphs                                     */
/************************************************************************/
PPAGE_DEF Interactive (HWND hwnd, BOOL bAuto)
{
    if (bSuperZoomF)
		bSuperZoomF = FALSE;

    return WGCreatePage("PAGE1", // page ID string
      hwnd,               // handle to the parent window
      _hInst,             // application instance handle 
      "First Graph",      // Window title string 
      StartGraphsInt,     // pointer to graph creation function
      "PageMenu",         // Name of page window menu in resource file
      C_LIGHTCYAN,        // window background color
      MM_PROPORT,         // window sizing mode
  	  0L,                 // window style - default
      PAGE_CLIENT,          // window initial size and position option
	  0, 0, 0, 0);        // initial window size and position
}
/************************************************************************/
/* Interactive page with two graphs                                     */
/************************************************************************/
PPAGE_DEF Zoom (HWND hwnd, BOOL bAuto)
{
    return WGCreatePage("PAGE2", // page ID string
      hwnd,               // handle to the parent window
      _hInst,             // application instance handle 
      "Zoom",        // Window title string 
      StartGraphsZoom,    // pointer to graph creation function
      NULL,         // Name of page window menu in resource file
      C_CYAN,             // window background color
    MM_ISOTR,           // window sizing mode
//      MM_PROPORT,         // window sizing mode
 	  0L,                 // window style - default
      PAGE_CLIENT,          // window initial size and position option
	  0, 0, 0, 0);        // initial window size and position
}
/************************************************************************/
/* Dialogs demo                                                         */
/************************************************************************/
void Dialogs (HWND hwnd, BOOL bAuto)
{
    PPAGE_DEF pPageDesc;
    if (bSuperZoomF)
			bSuperZoomF = FALSE;

    pPageDesc = WGCreatePage("DIALOGS", // page ID string
      hwnd,               // handle to the parent window
      _hInst,              // application instance handle 
      "DIALOGS",          // Window title string 
      StartGraphsDlg,
      NULL,
      C_LIGHTBLUE,
      MM_PROPORT,         // window sizing mode
  	  0L,                 // window style - default
      PAGE_CLIENT,        // window initial size and position option
	  0, 0, 0, 0);        // initial window size and position
	
       hDialogParent = hwnd;
      KillTimer (pPageDesc->hwParent, ID_TIMERGO);
      KillTimer (pPageDesc->hwParent, ID_TIMERSTART);
      SetTimer  (pPageDesc->hwParent, ID_TIMERDIALB, DIALPERB, 0L);

      pPrevPage = pPageDesc;
}
/************************************************************************/
/* Sequence of plots                                                    */
/************************************************************************/
PPAGE_DEF Plots (HWND hwnd)
{
    PPAGE_DEF pPageDesc = NULL;

    if (nPlotNum >= NUMPLOTS)
        nPlotNum = 0;
    else
    if (nPlotNum < 0)
        nPlotNum = NUMPLOTS - 1;

    KillTimer (hwnd, ID_TIMERDYN);
    if (bSuperZoomF)
		bSuperZoomF = FALSE;

    switch (nPlotNum)
    {

        case 0:
          pPageDesc = WGCreatePage("PAGE 1", hwnd, _hInst, "Page 1", StartPage1,
           NULL, C_LIGHTGRAY, MM_PROPORT, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 1:
          pPageDesc = WGCreatePage("PAGE 2", hwnd, _hInst, "Page 2", StartPage2,
              NULL, C_WHITE, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
            break;

        case 2:
          pPageDesc = WGCreatePage("PAGE 3", hwnd, _hInst, "Page 3", StartPage3,
              NULL, C_CYAN, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 3:
          pPageDesc = WGCreatePage("PAGE 4", hwnd, _hInst, "Page 4", StartPage4,
              NULL, C_LIGHTCYAN, MM_PROPORT, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 4:
          pPageDesc = WGCreatePage("PAGE 5", hwnd, _hInst, "Page 5", StartPage5,
              NULL, C_LIGHTGRAY, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 5:
          pPageDesc = WGCreatePage("PAGE 6", hwnd, _hInst, "Page 6", StartPage6,
              NULL, C_LIGHTGRAY, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 6:
          pPageDesc = WGCreatePage("PAGE 7", hwnd, _hInst, "Page 7", StartPage7,
              NULL, C_LIGHTBLUE, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 7:
          pPageDesc = WGCreatePage("PAGE 8", hwnd, _hInst, "Page 8", StartPage8,
              NULL, C_YELLOW, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 8:
          pPageDesc = WGCreatePage("PAGE 9", hwnd, _hInst, "Page 9", StartPage9,
              NULL, C_LIGHTGRAY, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;
// Up to here used PAGE_FULL
        case 9:
          pPageDesc = WGCreatePage("PAGE 10", hwnd, _hInst, "Page 10", StartPage10,
              NULL, C_BLUE, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          break;

        case 10:
          pPageDesc = WGCreatePage("Page 11", hwnd, _hInst,
            "Dynamic Demo", StartPage11,
              NULL, C_LIGHTGRAY, MM_FIXED, STYLE_CHART, PAGE_CLIENT, 0, 0, 0, 0);
          pDynPage = pPageDesc;
          SetTimer  (hwnd, ID_TIMERDYN, DYNPER, 0L);
          break;
    }

    if (pPrevPage != NULL)
    {
        DestroyWindow (pPrevPage->hwnd);
	}

	pPrevPage = pPageDesc;
	return pPageDesc;
}
/*************************************************************************
	Main window procedure
**************************************************************************/

LRESULT CALLBACK MainWndProc (HWND hwnd, UINT message, WPARAM wParam,
													   LPARAM lParam)
{
	int x, xBut, y;
	static int cx, cy;
	int   i;

	switch (message)
	{
		case WM_CREATE:
		{

			cx = cxScreen / 7;
			cy = cyScreen / 20;
				
			xBut = (int) (cxScreen * 0.75);

			for (i = 0; i < BNUM; i++)
			{
				y = (int)(cyScreen * BYSTART + cy / 2.4 +
				   (int) (FSTEP * cy * i));

				hwndButtons [i] = CreateWindow ("BUTTON", szBut[i],
				   WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE, xBut,
				   y, cx, cy,
				   hwnd, (HMENU)(ID_USER + i),
				  _hInst, NULL);
			}

			y = (int)(cyScreen * BXSTART / 2);
            if (bSuperZoomF)
				bSuperZoomF = FALSE;

			WGCreatePage("PAGEPICT",
			  hwnd, _hInst, NULL,
			  StartPict,
			  NULL, 
			  C_WHITE,
			  MM_PROPORT, 
			  WS_CHILD | WS_VISIBLE,                
			  PAGE_EXACT,
			  (int)(cxScreen * 0.73),
			  y,
			  (int)(0.26 * cxScreen),
			  (int)(cyScreen * BYSTART) - 2 * y); 

			WGCreatePage("PAGETITLE",
			  hwnd, _hInst, NULL,
			  StartHeader,
			  NULL, 
			  C_CYAN,
			  MM_PROPORT, 
			  WS_CHILD | WS_VISIBLE,                
			  PAGE_EXACT,
			  10,
			  10,
			  cxScreen  - 10,
			  (int)(cyScreen * BYSTART) - y);

			SetTimer (hwnd, ID_TIMERSTART, STARTPER, NULL);
		}
		return 0;

		case WM_TIMER:     
			TimerRoutine (hwnd, wParam);
			return 0;

		case WM_COMMAND:
		{
			UINT wRet;

			KillTimer (hwnd, ID_TIMERGO);
			SetTimer (hwnd, ID_TIMERSTART, STARTPER, 0L);
		//	if (nMode != ID_DIALOGS)
				nMode = 0;

            switch (wParam)
            {
               case IDM_ABOUT:
               {
                 FARPROC  lpProcAbout; 
			     lpProcAbout = MakeProcInstance ((FARPROC)AboutProc, _hInst);
        		      DialogBox(_hInst,		     /* current instance	 */
            	     "AboutBox",	    		 /* resource to use	     */
		              hwnd,			         /* parent window handle */
				     (DLGPROC)lpProcAbout); /* AboutProc() instance address */
           	     	  FreeProcInstance(lpProcAbout);
               }
               break;

               case ID_AUTO    :
                   nMode = ID_PLOTS;
                   KillTimer (hwnd, ID_TIMERSTART);
                   SetTimer (hwnd, ID_TIMERGO, PERIOD, 0L);
        		    nPlotNum = -1;
                   TimerRoutine (hwnd, ID_TIMERGO);
                   break;

               case ID_PLOTS   :
                   nPlotNum = 0;
                   nMode = wParam;
                   Plots (hwnd);
               break;

               case ID_DIALOGS :
                   nMode = wParam;
                   nDialNum = 0;
                   nDialCount = 0;
                   Dialogs (hwnd, FALSE);
               break;

               case ID_INTER   :
                   nMode = wParam;
                   KillTimer (hwnd, ID_TIMERSTART);
                   pPrevPage = Interactive (hwnd, FALSE);
               break;

               case ID_ZOOM  :
                   nMode = wParam;
                   KillTimer (hwnd, ID_TIMERSTART);
                   pPrevPage = Zoom (hwnd, FALSE);
               break;

               case ID_DS   :
                   nMode = wParam;
                   KillTimer (hwnd, ID_TIMERSTART);
                   wRet = WinExec ("WRITE WCTDS.DOC", SW_SHOWMAXIMIZED);
                   if (wRet < 32)
                        MessageBox (NULL, "Cannot Load WRITE.EXE", "Error",
                             MB_OK | MB_TASKMODAL);
                   break;

               case ID_ORDER   :
                   nMode = wParam;
                   KillTimer (hwnd, ID_TIMERSTART);
                   wRet = WinExec ("WRITE WCTORDER.DOC", SW_SHOWMAXIMIZED);
                   if (wRet < 32)
                        MessageBox (NULL, "Cannot Load WRITE.EXE", "Error",
                             MB_OK | MB_TASKMODAL);
                   break;

               case ID_EXIT :
                   DestroyWindow (hwnd);
#ifdef WIN32
//        EndDemo1();
#endif
               break;
            }
        }
        return 0;

        case WM_KEYDOWN:
            switch (wParam)
            {
                case 'A':
                case 'a':
    			   SendMessage (hwnd, WM_COMMAND, ID_AUTO, 0L);
                   break;

                case 'C':
                case 'c':
    			   SendMessage (hwnd, WM_COMMAND, ID_PLOTS, 0L);
                   break;

                case 'D':
                case 'd':
    			   SendMessage (hwnd, WM_COMMAND, ID_DIALOGS, 0L);
                   break;

                case 'I':
                case 'i':
    			    SendMessage (hwnd, WM_COMMAND, ID_INTER, 0L);
                   break;

                case 'Z':
                case 'z':
    			   SendMessage (hwnd, WM_COMMAND, ID_ZOOM, 0L);
                   break;

                case 'S':
                case 's':
    			   SendMessage (hwnd, WM_COMMAND, ID_DS, 0L);
                   break;

                case 'O':
                case 'o':
    			   SendMessage (hwnd, WM_COMMAND, ID_ORDER, 0L);
                   break;

                case 'e':
                case 'E':
                case VK_ESCAPE:
    			   SendMessage (hwnd, WM_COMMAND, ID_EXIT, 0L);
                break;
            }
            return 0;


		case WM_PAINT: // paint main window
        {
             PAINTSTRUCT ps;
             HDC  hdc = BeginPaint(hwnd, &ps);
             int  len;
             int  cyBot;  

             x = (int)(cxScreen * BXSTART);
             y = (int)(cyScreen * BYSTART);
             cyBot = x / 2;  

             Rectangle (hdc, x, y, cxScreen - x, cyScreen - cyBot);

             x += 3;
			 SelectObject (hdc, hMainBrush); 
             Rectangle (hdc, x, (int)(cyScreen * BYSTART) + 3, cxScreen - x,
               cyScreen - cyBot - 3);

             x = (int)(x * 1.5);
			 SetBkMode (hdc, TRANSPARENT);

             for (i = 0; i < BNUM; i++)
             {
                y = (int)(cyScreen * BYSTART + cy / 2.0 +
                   (int) (FSTEP * cy * i));
            	 len = lstrlen (szExpl[i]);
            	 TextOut (hdc, x, y, szExpl[i], len);
             }
    		 EndPaint(hwnd, &ps);
        }
  	    return 0;
    
        case WM_DESTROY:
            KillTimer (hwnd, ID_TIMERSTART);
            KillTimer (hwnd, ID_TIMERGO);
            KillTimer (hwnd, ID_TIMERDYN);

            if (hYAxStr != NULL)
                GlobalFree (hYAxStr);
            if (hPieStr != NULL)
    			GlobalFree (hPieStr);
            if (hFloStr != NULL)
    			GlobalFree (hFloStr);
            if (hPieData != NULL)
    			GlobalFree (hPieData);

            free (lpIndWater);
        	free (lpDepWater);

    	    WGCleanup(TRUE); 		// clean up charting tools memory
                                   // and free data arrays
        	PostQuitMessage(0);
	    return 0;
    }
    return (DefWindowProc(hwnd, message, wParam, lParam));
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
void NextDialog (HWND hwnd, BOOL bKill)
{
    HGOBJ  hObj;
    HWND   hDlg, hPrev, hNew;
    static bStop;
    HTASK hDemoTask, hTask;

    PGRAPH_DEF pGrDesc;

    pGrDesc = WGGetSelectedGraph (pPrevPage);
    if (pGrDesc == NULL)
        return ;

    if ((nDialCount++ % 2 == 0))
    {                          // show dialog
		bDialogUp = TRUE;
        KillTimer (hwnd, ID_TIMERDIALB);
        if (pGrDesc->pObjArr [nDialNum] == NULL)
        {
            KillTimer (hwnd, ID_TIMERDIAL);
            nDialCount =  nDialNum = 0;
            SetTimer (hwnd, ID_TIMERSTART, STARTPER, 0L);
            return ;
        }
#ifndef WIN32	  
		EnableHardwareInput (FALSE);
#endif
        hObj = (HGOBJ) (nDialNum + 1);
        WGSelObject (pGrDesc, hObj);
        SetTimer (hwnd, ID_TIMERDIAL, DIALPER, 0L);
		
        nDialNum++;
        HighlightObj (pGrDesc);
        DefEditObject (pGrDesc);
        if (bStop && (pPrevPage != NULL))
        {
            DestroyWindow (pPrevPage->hwnd);
            pPrevPage = NULL;
            nMode = 0;
		    bDialogUp = FALSE;
        }

    }
    else 
    {   // remove dialog
	   
        KillTimer (hwnd, ID_TIMERDIAL);
        hDlg = hPrev = GetWindow (hwnd, GW_HWNDFIRST);
       hDemoTask = GetWindowTask (hwnd);
      
       SetTimer (hwnd, ID_TIMERDIAL, DIALPER, 0L);
        while (hDlg != NULL)
        {
          hNew = GetWindow (hDlg, GW_HWNDNEXT);
           if ((hDlg == hNew) || (hDlg == NULL))
                break;
           hTask = GetWindowTask (hDlg);
           if (hTask == hDemoTask)
           {
		     if (GetWindowLong(hDlg, DWL_DLGPROC))
              SendMessage (hDlg, WM_COMMAND, IDCANCEL, 0L);
		   }
            hPrev = hDlg;
			hDlg = hNew;
        }
		bDialogUp = FALSE;
        SetTimer (hwnd, ID_TIMERDIALB, DIALPERB, 0L);

#ifndef WIN32
	EnableHardwareInput (TRUE);
#endif
        SetFocus (pPrevPage->hwnd);
    }
    bStop = bKill;
}
/**************************************************************************/
void CALLBACK TimerRoutine (HWND hwnd, UINT wTimer)
{
    if (IsIconic (hwnd))
        return ;

    switch (wTimer)
    {
        case ID_TIMERSTART:
            KillTimer (hwnd, ID_TIMERSTART);
            nMode = ID_PLOTS;
            SetTimer (hwnd, ID_TIMERGO, PERIOD, 0L);
            break;

        case ID_TIMERGO:
		   ++nPlotNum;
            Plots (hwnd);
            break;

        case ID_TIMERDIAL:
        case ID_TIMERDIALB:
            NextDialog (hwnd, FALSE);
            break;

        case ID_TIMERDYN:
            DynUpdate ();
            break;
  	}
}
/**************************************************************************/
void InitData (void)
{
    int     i,  k;
    realtype z;
    realtype sp;
	realtype interval, time;
    realtype magn;

    static  BOOL fInit = TRUE;
    LPREAL  lpIntX1, lpIntY1;
    LPREAL  lpIntX12, lpIntY12, lpIntX13, lpIntY13, lpIntX14, lpIntY14;
    LPREAL  lpX11, lpY11, lpY12;
    LPREAL  lpX21, lpY21, lpY22, lpY23;
	LPREAL  lpX31, lpY31, lpY32;
    LPREAL  lpX51, lpY51;
    LPREAL  lpX61, lpY61, lpY62;
    LPREAL  lpX81, lpY81, lpY82, lpY83;
    LPREAL  lpGX61, lpGY61;
    LPREAL  lpX101, lpY101;
    LPREAL  lpX102, lpY102;
	LPREAL  lpX111, lpY111;
	LPREAL  lpX112, lpY112, lpX113, lpY113;

    LPREAL  lpPie;
    LPSTR   lpPieStr;
  
    // create simulation data for plot
/*--------------------------------------------------------------*/
    if (fInit) // do not initialize data twice
    {
        // allocate global data arrays
        hIntX1  = GlobalAlloc (GMF, sizeof (realtype) * NUMP1);
        hIntY1  = GlobalAlloc (GMF, sizeof (realtype) * NUMP1);
        hIntX12 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);
        hIntY12 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);
        hIntX13 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);
        hIntY13 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);
        hIntX14 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);
        hIntY14 = GlobalAlloc (GMF, sizeof (realtype) * NUMP2);

        hX11 = GlobalAlloc (GMF, sizeof (realtype) * NUMP20);
        hY11 = GlobalAlloc (GMF, sizeof (realtype) * NUMP20);
        hY12 = GlobalAlloc (GMF, sizeof (realtype) * NUMP20);

        hX21 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY21 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY22 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY23 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);

        hX31 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY31 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY32 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);

        hX51 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);
        hY51 = GlobalAlloc (GMF, sizeof (realtype) * NUMP10);

		
		hX61 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP61);
		hY61 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP61 * 4);
		hY62 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP61);
    	hGX61 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP62);
	    hGY61 = GlobalAlloc (GPTR, sizeof (realtype) * NUMP62);
		
		hX71 = GlobalAlloc (GMF, sizeof (realtype) * NUMP7 * NUMGROUP7);
		hY71 = GlobalAlloc (GMF, sizeof (realtype) * NUMP7);

		hX81 = GlobalAlloc (GMF, sizeof (realtype) * NUMP8);
		hY81 = GlobalAlloc (GMF, sizeof (realtype) * NUMP8);
		hY82 = GlobalAlloc (GMF, sizeof (realtype) * NUMP8);
		hY83 = GlobalAlloc (GMF, sizeof (realtype) * NUMP8);

        hSignal = GlobalAlloc (GMF, sizeof (realtype) * NUMPFFT);
		hTime   = GlobalAlloc (GMF, sizeof (realtype) * NUMPFFT);
	    hFreq   = GlobalAlloc (GMF, sizeof (realtype) * NUMPFFT);
        hPowFreq = GlobalAlloc (GMF, sizeof (realtype) * NUMPFFT);
        
		hX101 = GlobalAlloc (GMF, sizeof (realtype) * NUMP101);
		hY101 = GlobalAlloc (GMF, sizeof (realtype) * NUMP101 * NUMG10);
		hX102 = GlobalAlloc (GMF, sizeof (realtype) * NUMP101);
		hY102 = GlobalAlloc (GMF, sizeof (realtype) * NUMP101 * NUMG10);

		hX111 = GlobalAlloc (GMF, sizeof (realtype) * NUMP11);
		hY111 = GlobalAlloc (GMF, sizeof (realtype) * NUMP11);
		hX112 = GlobalAlloc (GMF, sizeof (realtype) * NUMP11);
		hY112 = GlobalAlloc (GMF, sizeof (realtype) * NUMP11);
		hX113 = GlobalAlloc (GMF, sizeof (realtype) * NUMP12);
		hY113 = GlobalAlloc (GMF, sizeof (realtype) * NUMP12);

		hXPict = GlobalAlloc (GMF, sizeof (realtype) * 3);
		hYPict = GlobalAlloc (GMF, sizeof (realtype) * 3);

        // get pointers to data arrays
        lpIntX1  = (LPREAL) GlobalLock(hIntX1);
        lpIntY1  = (LPREAL) GlobalLock(hIntY1);
        lpIntX12 = (LPREAL) GlobalLock(hIntX12);
        lpIntY12 = (LPREAL) GlobalLock(hIntY12);
		lpIntX13 = (LPREAL) GlobalLock(hIntX13);
        lpIntY13 = (LPREAL) GlobalLock(hIntY13);
		lpIntX14 = (LPREAL) GlobalLock(hIntX14);
        lpIntY14 = (LPREAL) GlobalLock(hIntY14);

        lpX11 = (LPREAL) GlobalLock(hX11);
        lpY11 = (LPREAL) GlobalLock(hY11);
        lpY12 = (LPREAL) GlobalLock(hY12);

        lpX21 = (LPREAL) GlobalLock(hX21);
        lpY21 = (LPREAL) GlobalLock(hY21);
        lpY22 = (LPREAL) GlobalLock(hY22);
        lpY23 = (LPREAL) GlobalLock(hY23);

        lpX31 = (LPREAL) GlobalLock(hX31);
        lpY31 = (LPREAL) GlobalLock(hY31);
        lpY32 = (LPREAL) GlobalLock(hY32);

        lpX51 = (LPREAL) GlobalLock(hX51);
        lpY51 = (LPREAL) GlobalLock(hY51);

        lpX61 = (LPREAL) GlobalLock(hX61);
        lpY61 = (LPREAL) GlobalLock(hY61);
        lpY62 = (LPREAL) GlobalLock(hY62);

        lpGX61 = (LPREAL) GlobalLock(hGX61);
    	lpGY61 = (LPREAL) GlobalLock(hGY61);

        lpX71 = (LPREAL) GlobalLock(hX71);
        lpY71 = (LPREAL) GlobalLock(hY71);

        lpX81 = (LPREAL) GlobalLock(hX81);
        lpY81 = (LPREAL) GlobalLock(hY81);
        lpY82 = (LPREAL) GlobalLock(hY82);
        lpY83 = (LPREAL) GlobalLock(hY83);

        lpX101 = (LPREAL) GlobalLock(hX101);
        lpY101 = (LPREAL) GlobalLock(hY101);
        lpX102 = (LPREAL) GlobalLock(hX102);
        lpY102 = (LPREAL) GlobalLock(hY102);
        lpX111 = (LPREAL) GlobalLock(hX111);
        lpY111 = (LPREAL) GlobalLock(hY111);
        lpX112 = (LPREAL) GlobalLock(hX112);
        lpY112 = (LPREAL) GlobalLock(hY112);
        lpX113 = (LPREAL) GlobalLock(hX113);
        lpY113 = (LPREAL) GlobalLock(hY113);

        pSignal = (HPREAL) GlobalLock (hSignal);
        pTime   = (HPREAL) GlobalLock (hTime) ; 
        pFreq   = (HPREAL) GlobalLock (hFreq) ; 
        pPowFreq = (HPREAL) GlobalLock (hPowFreq);

        lpIndWater = calloc (NUMP9,  sizeof (realtype));
    	lpDepWater = calloc (NUMP9 * NUMGROUP9,  sizeof (realtype));

         // create x and y data to be plotted

        for (i = 0; i < NUMP2; i++)
		{
            lpIntX12[i] = 1.0 + (realtype) i;
            lpIntY12[i] = 50.0 + 150.0 * (1.0 - exp (-i / 9.0));
            lpIntX13[i] = lpIntX12 [i];
            lpIntY13[i] = lpIntY12 [i] + 80.0 * (randreal() - 0.5);
            lpIntX14[i] = lpIntX12 [i];
            lpIntY14[i] = lpIntY13 [i] - lpIntY12 [i];
		}

        for (i = 0; i < NUMP10; i++)  // for page 2
        {
            lpX21[i] = i + 1982;
            lpY22[i] = 2.0 + randreal() + i;
            lpY23[i] = 8.0 + randreal() + i;
            lpY21[i] = lpY23[i] + randreal() + 0.5;
            lpX31[i] = i + 1992;
            lpY31[i] = (i+10) + 2.0 + randreal();
            lpY32[i] = 22.0 - randreal() - i;
        }

    	hPieData = GlobalAlloc (GMF, sizeof (realtype) * NUMP4);
    	// get pointer to data array
		lpPie = (LPREAL) GlobalLock(hPieData);

        // allocate global string array
        hPieStr = GlobalAlloc(GMF, NUMP4 * LG_MAXLEN);
        lpPieStr = (LPSTR) GlobalLock (hPieStr);

      	// Generate some data, starting at zeroth element 
		lpPie[0] = 1550.0;
		lpPie[1] = 775.0;
		lpPie[2] = 350.0;
		lpPie[3] = 300.0;
		lpPie[4] = 250.0;
		lpPie[5] = 200.0;
		lpPie[6] = 220.0;
		lpPie[7] = 240.0;
		lpPie[8] = 167.0;
		lpPie[9] = 250.0;
		lpPie[10] = 750.0;

        // assign strings for legend key
        lstrcpy(lpPieStr, "Tax");
        lstrcpy(lpPieStr + LG_MAXLEN, "Mortgage");
		lstrcpy(lpPieStr + 2 * LG_MAXLEN, "Prop Tax");
        lstrcpy(lpPieStr + 3 * LG_MAXLEN, "Household");
        lstrcpy(lpPieStr + 4 * LG_MAXLEN, "Auto Ins");
        lstrcpy(lpPieStr + 5 * LG_MAXLEN, "Retirement");
        lstrcpy(lpPieStr + 6 * LG_MAXLEN, "Clothing");
        lstrcpy(lpPieStr + 7 * LG_MAXLEN, "Medical");
        lstrcpy(lpPieStr + 8 * LG_MAXLEN, "Utilities");
    	lstrcpy(lpPieStr + 9 * LG_MAXLEN, "Food");
	    lstrcpy(lpPieStr + 10 * LG_MAXLEN, "Other");

        for (i = 0; i < NUMP1; i++)
        {
             z = (realtype) i;
             lpIntX1 [i] = z;
             lpIntY1 [i] = 15.0 *
          	 cos(PI * z / (4.0+ 0.3 * randreal())) +
              	 3.0 * randreal();
        }

        for (i = 0, z = 0.0; i < NUMP61; i++)
        {
		   z = z + 1.0;
		   if  (((i + 1) % 5) == 0)  z = z + 2.0; 
        	   lpX61 [i] = z;
		   sp = 10 + i + 3 * randreal() * randreal();
           lpY61 [i * 4] =  sp + 1.0+3.0 * randreal();
           lpY61 [i * 4 + 1] = sp - 1.0-3.0 * randreal();
		   lpY61 [i * 4 + 2] = sp;
 		   lpY61 [i * 4 + 3] = lpY61[i*4+1] + randreal()* (lpY61[i*4] - lpY61 [i*4+1]);
       	   z = z + 1.0;
		   lpY62 [i] = 10 + i + 3 * randreal();
        }

	    for (i = 0; i < NUMP62; i++)
	    {
    		lpGX61[i] = lpX61[i];
	    	lpGY61[i] = ((randreal() * 5.0 * (i+1)) + randreal()) * 80;
        }

        for (i = 0; i < NUMP7; i++)
             lpY71 [i] = (realtype) i;
		lpX71[0] = 5.9;
	    lpX71[1] = 7.0; 
		lpX71[2] = 10.0;
		lpX71[3] = 3;
    	lpX71[4] = 3.6;
		lpX71[5] = 3.8;

	    for (i = 0; i < NUMP8; i++)
		{
              z = (realtype) (i);
              lpX81 [i] = z + 1.0;
              lpY81 [i] =  z *  randreal() + 5.0 * randreal();
              lpY82 [i] =  z * randreal() + 6.0 * randreal();
		}

		lpY82[4] = 5.0;		lpY82[5] = 7.82;
		lpY82[6] = 4.56;

		lpY83[0] = 3.99;	lpY83[1] = 4.48;
		lpY83[2] = 4.10;	lpY83[3] = 3.70;
		lpY83[4] = 3.52;	lpY83[5] = 3.09;
		lpY83[6] = 2.68;	lpY83[7] = 3.68;
		lpY83[8] = 3.41;	lpY83[9] = 3.36;
		lpY83[10] = 4.21;	lpY83[11] = 4.48;

        // sampling interval
        interval = MAXTIME / (realtype) NUMPFFT;

        // simulate signal
        for (i = 0; i < NUMPFFT; i++)
        {
            time = *(pTime + i) = i * interval;
             z = time / 2.0;
            
            pSignal [i] = 13.0 *
			 cos(PI * z / (7.0 + 0.95 * randreal())) +
                 4.5 * sin (7.0 * z / (1.0 + 0.1))
			  + 6.0 * cos (4.0 * z);
			if (i==0) 
				pSignal[i] = 100;

			if (i < 300)
            {
				 pSignal [i] += (randreal() - 0.5) * 20.0;
			}

			WGFFTFrequency (NUMPFFT, 1000.0 / interval, i,  pFreq + i);
		}
        *pSignal = 0.0;

        *(pSignal + NUMPFFT * 4 / 5) = -5.0;
		*(pSignal + NUMPFFT * 4 / 5 + 1) = -6.0;
	 
        // duplicate arrays
        hPower  = WGCopyMem (hSignal);
        pPower  = (HPREAL) GlobalLock (hPower);

        lpY101[0] = 85; lpY101[1] = 89; lpX101[0] = 11;
        lpY101[2] = 89; lpY101[3] = 93; lpX101[1] = 8;
        lpY101[4] = 91; lpY101[5] = 94; lpX101[2] = 5;
        lpY101[6] = 92; lpY101[7] = 96; lpX101[3] = 2;

        lpY102[0] = 91; lpY102[1] = 93; lpX102[0] = 10;
        lpY102[2] = 92; lpY102[3] = 94; lpX102[1] = 7;
        lpY102[4] = 93; lpY102[5] = 95; lpX102[2] = 4;
        lpY102[6] = 94; lpY102[7] = 96; lpX102[3] = 1;

        for (i = 0; i < NUMP20; i++)
        {
	        z = (realtype) (i - 10.0);

        	lpX11[i] = z + 10.0;
        	lpY11[i] = 25.0 * (1.0 / (sqrt(56.5))) * exp(-((z * z)/(18.0)));

        	lpY12[i] = 25.0 * (1.0/(sqrt(56.5)))*
        		exp(-((z * z)/(18.0))) + ( 0.5 - randreal());
        }

        for (i = 0; i < NUMP11; i++)
        {
			 z = (realtype) (i + 2)/ RXDYNMAX;
             lpX111 [i] = z;
			 lpY111 [i] = RYDYNMAX / 3.0 * (2.0 + cos (z) - sin (z * 2) +
                rand () / 10000.0);
			 
			 lpX112 [i] = z;
			 lpY112 [i] = /*RYDYNMAX /*/ 1.75 * (2.0 + cos (z*2)  +
                rand () / 25000.0); // randreal() * 2;
		}

        for (i = 0; i < NUMP12; i++)
        {
			 z = (realtype) (i + 2)/ RXDYNMAX;

			 lpX113 [i] = z * 2;
			 lpY113 [i] = 45.75 + (4.0 * cos (z*6)  +
                rand () / 15000.0); // randreal() * 2;
		}


        lpX51[0] = 15.0;
        lpY51[0] = 0.25;

		for (i = 1; i < NUMP10; i++)
		{
			lpX51[i] = 15 + (i + 1) * 66.0;
			lpY51[i] = lpY51 [i - 1] * (15.0 * randreal());

		}
		for (i = 1; i < NUMP10; i++)
		{
			if (i < NUMP10/2)
				lpY51[i] = lpY51[i] * lpY51[i] * lpY51[i-1];
		}

        // create independent and dependent data to be plotted
		// in waterfall plot
		for (i=0; i < NUMP9; i++)
		{
			lpIndWater[i] = i * 2.1;
			for (k=0; k < NUMGROUP9; k++)
			{	
				magn = ((realtype) (i)/ 7.0 );
				magn = magn * 0.5 + 0.5 * magn * ((realtype) rand()/ (realtype) RAND_MAX );
				
				lpDepWater[i*NUMGROUP9+k] = magn * sin (lpIndWater[i] / 20);
				lpDepWater[i*NUMGROUP9+k] = lpDepWater[i*NUMGROUP9+k] * lpDepWater[i*NUMGROUP9+k];
			}
		}


	lpZoomX1 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));
	lpZoomY1 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));
	lpZoomY2 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));
	lpZoomY3 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));
	lpZoomY4 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));
	lpZoomY5 = (LPREAL)calloc (NUMPZOOM, sizeof (realtype));

	// create x and y data to be plotted
	for (i = 0; i < NUMPZOOM; i++)
	{
		 z = (realtype) i;
		 lpZoomX1 [i] = z;
		 lpZoomY1 [i] = 15.0 *
		 cos(M_PI * z / (4.0+ 0.3 * randreal())) +
			 3.0 * randreal();
         lpZoomY2 [i] = 50 + 30.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

         lpZoomY3 [i] = 90.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

		 lpZoomY4 [i] = 200 +  225.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();

		 lpZoomY5 [i] = 1.0 *
		 sin(M_PI * z / (5.0+ 0.3 * randreal())) +
			 3.0 * randreal();
		 
	}



	CreateData();
        
		
		WGStart ();
        // define a dataset 
    hDataSet = WGDefineDataSet ("60 Cycle Noise", hIntX1, hIntY1, NUMPZOOM);

	hZoomDataSet = WGDefineDataSetPtr ("Zoom Data 1", lpZoomX1, lpZoomY1, NUMPZOOM);
	hZoomDataSet2 = WGDefineDataSetPtr ("Zoom Data 2", lpZoomX1, lpZoomY2, NUMPZOOM);
  	hZoomDataSet3= WGDefineDataSetPtr ("Zoom Data 3", lpZoomX1, lpZoomY3, NUMPZOOM);
	hZoomDataSet4 = WGDefineDataSetPtr ("Zoom Data 4", lpZoomX1, lpZoomY4, NUMPZOOM);
	hZoomDataSet5= WGDefineDataSetPtr ("Zoom Data 5", lpZoomX1, lpZoomY5, NUMPZOOM);
 
        fInit = FALSE;
    }
}
/**********************************************************************/

void CALLBACK StartGraphsInt(PPAGE_DEF pPageDesc)
{
#if 0
    WGCreateGraph (pPageDesc,
		 DrawPIntG1, 
		 0.005, 0.005, // window relative position inside parent page window
		 0.995, 0.395,
		 C_WHITE, // white background
		 C_RED,   // red   border
		 2);      // border width in pixels
#endif
    WGCreateGraph (pPageDesc,
		 DrawPIntG2, 
		 0.005, 0.005, // window relative position inside parent page window
		 0.995, BBYSTART - 0.005,
   		 C_GREEN, -1, 0);

    WGCreateGraph (pPageDesc,
		 DrawPIntG3, 
		 1.0 - BBXSTART, BBYSTART, // window relative position inside parent page window
		 BBXSTART, 0.995,
   		 C_WHITE, C_BLACK, 2);
}
/***************************************************************************/

void DynUpdate (void)
{
	HGLOBAL hX, hY, hX2, hY2, hX3, hY3;
	static  int count = 0;
	LPREAL  lpX, lpY, lpX2, lpY2, lpX3, lpY3;
	realtype   z, ampl;
	int     i, dx;
	LONG    nump, nump2;

    if (pDynGrDesc == NULL)
        return ;
	count++;
    if (count > 30000)
        count = 1;

    WGGetDataSetArrays (hLiveData, &hX, &hY, &nump, NULL);
    WGGetDataSetArrays (hLiveData2, &hX2, &hY2, &nump, NULL);
    WGGetDataSetArrays (hLiveData3, &hX3, &hY3, &nump2, NULL);

    dx = (int)(nump * 2.0 / RXDYNMAX);

	lpX = (LPREAL) GlobalLock(hX);
	lpY = (LPREAL) GlobalLock(hY);

	lpX2 = (LPREAL) GlobalLock(hX2);
	lpY2 = (LPREAL) GlobalLock(hY2);
	lpX3 = (LPREAL) GlobalLock(hX3);
	lpY3 = (LPREAL) GlobalLock(hY3);

	ampl = (RYDYNMAX + (count % 100) / 20.0) / 3.0;

	// simulate new data
    for (i = 0; i < nump; i++)
	{
        if (i < nump - dx)
        {
            lpY [i] = lpY [i + dx];
            lpY2 [i] = lpY2 [i + dx];
        }
        else
        {
    		z = lpX[i];
            lpY [i] = ampl * (2.0 + cos (z + count) -
    		   sin ((z + count) * 2) + rand () / 10000.0);
            lpY2 [i] = (ampl -2.0) * (1.0 + cos (z + count/2) /*-
    		   sin ((z + count) * 2) */+ rand () / 12000.0);
        }
	}

    for (i = 0; i < nump2; i++)
	{
        if (i < nump2 - dx)
        {
            lpY3 [i] = lpY3 [i + dx];
       }
        else
        {
    		z = lpX3[i];
            lpY3 [i] = ((ampl -1.0) * 5.0 + (29.0 + 5 * (cos (4 * z + count))
							+ rand () / 2000.0)) - 10.0;
        }
	}

	// now redraw the line plot
//	WGRedrawObject (pDynGrDesc, hPlot, TRUE);
//	WGRedrawObject (pDynGrDesc, hPlot2, TRUE);
//	WGRedrawObject (pDynGrDesc, hPlot3, TRUE);
	WGRedrawGraph(pDynGrDesc, TRUE);
}
/**************************************************************************/
void UpdateZoomView (realtype rLeft, realtype rTop, realtype rRight, 
	realtype rBottom)
{
    // round axes and change ranges 
	WGRoundAxis (pGrDescZoom2, hAxisXZ, &rLeft, &rRight, NULL, TRUE);
	WGRoundAxis (pGrDescZoom2, hAxisYZ, &rBottom, &rTop, NULL, TRUE);
	 // change intercepts
	WGChangeAxisIntercept (pGrDescZoom2, hAxisYZ, rLeft, FALSE);
	WGChangeAxisIntercept (pGrDescZoom2, hAxisXZ, rBottom, TRUE);
}
/**************************************************************************/
void UpdateDataCursorPosition (void)
{
	realtype rXMouse, rYMouse;      // mouse position
    realtype rX, rY;                // nearest data point position
    static realtype rXPrev = 0.0;
    static realtype rYPrev = 0.0;
   LPSTR    lpText;
//    CHAR     lpText[20];
	
    if (!WGIsGraphDescValid ( pGrDescZoom1))                     
    	return;
	// Get mouse cursor position in physical units
	WGGetMousePos (pGrDescZoom1, hAxisXZ, hAxisYZ, &rXMouse, &rYMouse);

	// get data point closest to the mouse position
	WGGetNearestPoint (pGrDescZoom1, rXMouse, rYMouse, FNP_DIST, &rX, &rY, 
			NULL, NULL);
	// move data cursor
    if (rX != rXPrev)
    {           
    	lpText = ftoa (rX, 2, NF_DECIMAL);
        rXPrev = rX;
    	WGChangeString (pGrDescZoom1, hTextX, lpText, 0);
        WGRedrawObject (pGrDescZoom1, hTextX, FALSE);
	}	
    if (rY != rYPrev)
    {
        rYPrev = rY;
    	lpText = ftoa (rY, 2, NF_DECIMAL);
    	WGChangeString (pGrDescZoom1, hTextY, lpText, 0);    
    	WGRedrawObject (pGrDescZoom1, hTextY, FALSE);
    }	
	WGMoveDataCursor (pGrDescZoom1, hCursor1, rX, rY, TRUE);
               

}
/**************************************************************************/
void RemoveDataCursors (void)
{
	  if (!WGIsGraphDescValid ( pGrDescZoom1))                     
    	return;

	// turn off all data cursor
	WGMoveDataCursor (pGrDescZoom1, hCursor1, 0.0, 0.0, FALSE);
}
/**************************************************************************/
