/*************************************************************************/
/*                                                                       */
/*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998                     */
/*                                                                       */
/*************************************************************************/
/**                                                                      */
/**   Filename :   qcwinit.c                                             */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                  */
/**   Date     :   Aug. 15, 1998                                           */
/**                                                                      */
/**   Description: Initialization, termination, and windows routines     */
/**                                                                      */
/**   Revisions:   Function WGStart added - 1/25/93                      */
/**                Function WGCreateInvisiblePage added.                 */
/**                12/27/94  rev. 2.0 - 32-bit support                   */
/**                5/9/96-  Function WGRestorePage added                 */
/**                                                                      */
/*************************************************************************/

// #include "stdafx.h"      // uncomment for Visual C++
#pragma warning( disable : 4103)
#pragma optimize( "", off )

#include <windows.h>
#include <stdio.h>
#include "menus.h"

#include <windowsx.h>
#pragma hdrstop



#include "qcwin.h"
#include "wx.h"
#include "support.h"
#include "werr.h"

#pragma pack (push, 8)


TOP_DEF  _TopDesc;                     /* global application parameters */
DEV_DEF  FAR *_DevDescPtr;



BOOL WINAPI WGPreAddGraphObject (PGRAPH_DEF pGrDesc, HDC hdc) 
				 
{
    HGLOBAL  hMem;           // Axis object memory handle
    int j;
 
    InitDll (&_TopDesc); 
	pGrDesc->bAddGrObj = TRUE;
    pGrDesc->fInit = TRUE;
    pGrDesc->fFirstTime = TRUE;
    for (j = pGrDesc->nNumObjs-1; j >=0 ; j--)     
     {
         hMem = *(pGrDesc->pObjArr + j);
         if (hMem != NULL)
             break;
     }    
    pGrDesc->nObjCounter =  j+1; //number of objects presently in graph
	MapGraph(pGrDesc, hdc);  //call to establish proper viewpt settings
    
	return TRUE;                             
		    
}

BOOL WINAPI WGPostAddGraphObject (PGRAPH_DEF  pGrDesc, HDC hdc) 
				 
{
	ConnectAxes(pGrDesc);  //?NOT SURE IF NEEDED
	ReleaseDC (pGrDesc->hwnd, hdc); // release device context
    pGrDesc->fFirstTime = FALSE;
	WGRedrawGraph (pGrDesc, FALSE); //update graph
	pGrDesc->bAddGrObj = FALSE;

	return TRUE;                             
		    
}



/***************************************************************************

  If a slot is available (which it always should be), create a page
  descriptor and save a global memory handle for the page in _TopDesc.
  Page handle is the sequential number of the chart in _TopDesc.hPgMem.

***************************************************************************/

PPAGE_DEF WINAPI WGCreatePage (LPCSTR lpName,   // page ASCII identifier
               HWND hwParent,      // handle to parent, required only if
                                   // PAGE_CLIENT style is used
               HINSTANCE   hInst,  // module instance, required only the first time
	           LPSTR lpTitle,      // page window caption
               void FAR *lpfnPage, // processing function
	           LPCSTR lpMenu,	   // menu name, can be NULL
               int   nColor,       // backgrownd color code
               int   nSizeMode,    // MM_PROPORT or MM_FIXED
               DWORD dwWinStyle,   // window style
               int   nPosStyle,    // position style - PAGE_CLIENT, PAGE_FULL,
                                   // or PAGE_EXACT
               int   x, int y,     // if PAGE_EXACT, initial position
               int   cx, int cy)  
{
    InitDll (&_TopDesc);
	if (!_TopDesc.bInit)
	{
        _DevDescPtr = GetDevDesc();     
   	    _TopDesc.hwTop = GetActiveWindow();
    	_TopDesc.hInst = hInst;
        _TopDesc.cLenReal =  sizeof (realtype);
		if (!InitTop(&_TopDesc, (LPVOID) PageProc, (LPVOID)GraphProc,
            CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS | CS_PARENTDC))
        {   // terminate application
            ExitApplication();
            return NULL;
        }
	};

    return (InitPage (lpName, hwParent, lpTitle, lpMenu,
        nColor, nSizeMode, dwWinStyle, nPosStyle, x, y, cx, cy, 
        lpfnPage));
}

PPAGE_DEF WINAPI WGRestorePage (LPSTR lpFileName, HWND hwParent, LPSTR lpMenu)
{
    InitDll (&_TopDesc);
	if (!_TopDesc.bInit)
	{
        _DevDescPtr = GetDevDesc();     
   	    _TopDesc.hwTop = GetActiveWindow();
    	_TopDesc.hInst = GetModuleHandle(NULL) ;
        _TopDesc.cLenReal =  sizeof (realtype);
    }
    return RestorePage (lpFileName, hwParent, lpMenu);
}
/**************************************************************************/
// Create empty graph window using coordinates relative to those of page
/**************************************************************************/
PGRAPH_DEF WINAPI WGCreateGraph (PPAGE_DEF pPageDesc, // pointer to parent page
						  void FAR *lpfnGraph,   // processing function
						  realtype  rX1,        // relative coordinates
						  realtype  rY1,        // 0, 0 - left upper corner
						  realtype  rX2,        // of the page, 1,1 - right bottom 
						  realtype  rY2,
						  int       nColor,        // backgrownd color
						  int       nBorderColor,  // if < 0, no border
						  int       nBorderWidth)
{
	PGRAPH_DEF   pGraphDesc;       // pointer to graph descriptor

    pGraphDesc = InitGraph (&_TopDesc, pPageDesc, rX1, rY1, rX2, rY2,
        nColor, nBorderColor, nBorderWidth, lpfnGraph);

    return pGraphDesc;
}


/**************************************************************************/

void WINAPI WGEditObject (HWND hwnd)
{
	PGRAPH_DEF  pGrDesc;                // pointer to graph descriptor
    pGrDesc = (PGRAPH_DEF) GetWindowLong (hwnd, GWL_DESC);

    HighlightObj (pGrDesc);
        // disable graph and page windows while dialog box is active
    EnableWindow(pGrDesc->hwnd, 0);        // disable windows
    EnableWindow(pGrDesc->pPageDesc->hwnd, 0);

    InitDll (&_TopDesc);
    EditObject (pGrDesc);
    EnableWindow(pGrDesc->hwnd, 1);        // reenable windows
    EnableWindow(pGrDesc->pPageDesc->hwnd, 1);
}
/***************************************************************************/
/* Equivalent of printf - displays given text and numbers in a message box */
/***************************************************************************/

void _cdecl FAR WGOKMsgBox (PSTR pCaption, PSTR pFormat, ...)
{
    char szBuffer [161];
    char *pArguments;

    pArguments = (char *) &pFormat + sizeof pFormat;
    vsprintf (szBuffer, pFormat, pArguments);
    MessageBox (NULL, szBuffer, pCaption, MB_OK | MB_TASKMODAL);
}

/**************************************************************************

 Processes chart page window messages before giving control to
              user procedure in HOOK.C

**************************************************************************/

LRESULT CALLBACK _export PageProc (HWND hwnd, UINT message, WPARAM wParam,
														   LPARAM lParam)
{
	PPAGE_DEF   pPageDesc;       // pointer to page descriptor
	HDC         hdc;             // page window device context  
    WORD        id, cmd;

	switch (message)
	{
    	case WM_CREATE:
        {
            CREATESTRUCT FAR *pcs;
            pcs = (CREATESTRUCT FAR *) lParam;
            InitDll (&_TopDesc); 
            pPageDesc = (PPAGE_DEF)pcs->lpCreateParams;
            pPageDesc->hwnd = hwnd;     // initialize hwnd field
            break;
        }

		case WM_COMMAND:
             id = GET_WM_COMMAND_ID(wParam, lParam);
             cmd =  GET_WM_COMMAND_CMD(wParam, lParam);

#ifndef WIN32
             InitDll (&_TopDesc); 
#endif
         	 pPageDesc = (PPAGE_DEF) GetWindowLong(hwnd, GWL_DESC);
             if ((id >= IDM_SELECTORS) &&
                 (id <= IDM_SELECTORS + 16))
             {
                 if (cmd == BN_CLICKED)
                 {
					HGRAPH hDum;    
                    PGRAPH_DEF pGrDesc;

                    pGrDesc = GetGrDescPtr ((HGRAPH) (MAX_PAGES +
                        (UINT) pPageDesc->hPage * MAX_GRAPHS +
                        id - IDM_SELECTORS));
                    hDum = pPageDesc->hSelGraph;
                    WGSelectGraph (pGrDesc);
                    if (pPageDesc->hSelGraph == hDum)
                        WGEditGraphDlg (pPageDesc);
                 }
                 return 0;
             }
             else
                break;

		case WM_ERASEBKGND: 
        {                   
            return 1;
        }

		case WM_PAINT:         // paint page window
		{
        	PAINTSTRUCT ps;
			RECT     rc;

         	pPageDesc = (PPAGE_DEF) GetWindowLong(hwnd, GWL_DESC);
         	if (pPageDesc == NULL)
               return 0;
#ifndef WIN32
            InitDll (&_TopDesc); 
#endif
            hdc = BeginPaint(hwnd, &ps);
            if (pPageDesc->fHigh)
                HighlightGraph (pPageDesc, pPageDesc->hSelGraph);

            if (pPageDesc->lpfnPage != NULL)
            {
                 if (!pPageDesc->fInitGraph)
                 {
                    pPageDesc->fInitGraph = TRUE;
#ifdef __cplusplus
#if QC_MEMBER        // if you use C++ but graph building functions are static,
                     // remove definition of QC_MEMBER in qcwin.h!
                    {
                        // pointer to instance of class derived from QCWBase, not function
                        QCBasePage* bld; 
                        bld = (QCBasePage FAR *)pPageDesc->lpfnPage;
                        bld->BuildPage (pPageDesc); // call member function
                    }
#else
                    // call user routine creating graphs
					   (*pPageDesc->lpfnPage) (pPageDesc);
#endif
#else
                    // call user routine creating graphs
					   (*pPageDesc->lpfnPage) (pPageDesc);
#endif
                    if (pPageDesc->fDispSel)
                    {
                         ShowGraphSelectors (pPageDesc, hdc, GS_ON);
                         pPageDesc->fPrevDispSel = TRUE;
                    }
                 }
                 else
                 if (pPageDesc->fDispSel)
                     ShowGraphSelectors (pPageDesc, hdc, GS_MOVE);
            }
        // this is the fastest way to fill a rectangle with color !
        // Although, it only works with pure colors.
        // PatBlt can be used for any RGB color

		    GetClipBox(hdc, &rc);
            SetBkMode(hdc, OPAQUE);
            SetBkColor (hdc, pPageDesc->rgbBkColor);
            ExtTextOut (hdc, 0, 0, ETO_OPAQUE, &rc, NULL, 0, NULL);

            if (pPageDesc->fHigh)
                HighlightGraph (pPageDesc, pPageDesc->hSelGraph);
    	    EndPaint(hwnd, &ps);
            return 0;
        }

        case WM_SIZE:
        {
#ifndef WIN32
             InitDll (&_TopDesc); 
#endif
            ResizePage (hwnd, LOWORD (lParam), HIWORD (lParam));
            break;
        }
	    case WM_DESTROY:
#ifndef WIN32
            InitDll (&_TopDesc); 
#endif
         	pPageDesc = (PPAGE_DEF) GetWindowLong(hwnd, GWL_DESC);
         	if (pPageDesc != NULL)
    			KillGraphPage(pPageDesc->hPage);
            break;
    }
// the rest is processed by the user written procedure
    return (WGUserPageProc(hwnd, message, wParam, lParam));
}
/**************************************************************************

	FUNCTION: GraphProc (HWND, UINT, WPARAM, LPARAM)
	PURPOSE:  Processes graph child windows messages

**************************************************************************/

LRESULT CALLBACK _export GraphProc (HWND hwnd, UINT message, WPARAM wParam,
														   LPARAM lParam)
{
	HDC         hdc;
	PAINTSTRUCT ps;
	PGRAPH_DEF  pGrDesc;                // pointer to graph descriptor
	PPAGE_DEF   pPageDesc;   

    switch (message)
	{
        case WM_MOUSEMOVE :           // mouse events
        case WM_RBUTTONDOWN :
        case WM_RBUTTONDBLCLK:        
        case WM_LBUTTONDOWN :
        case WM_LBUTTONDBLCLK:
        case WM_LBUTTONUP	  : 
        case WM_RBUTTONUP	  : 
        case WM_MBUTTONDOWN  : 
        case WM_MBUTTONUP	  : 
        case WM_MBUTTONDBLCLK: 
             _DevDescPtr->ptMouse.x = LOWORD (lParam);
             _DevDescPtr->ptMouse.y = HIWORD (lParam);
#ifndef WIN32
             InitDll (&_TopDesc); 
#endif
             WGGraphMouseEvent (hwnd, message, _DevDescPtr->ptMouse);
             return 0;

        case WM_CHAR:  // key messages
        case WM_KEYUP:
        case WM_KEYDOWN:
#ifndef WIN32
             InitDll (&_TopDesc); 
#endif
             WGGraphKeyEvent (hwnd, message, wParam, lParam);
            return 0;

        case WM_ERASEBKGND:
            return  1;

		case WM_PAINT:
        {
#ifndef WIN32
             InitDll (&_TopDesc); 
#endif
            pGrDesc = (PGRAPH_DEF)GetWindowLong (hwnd, GWL_DESC);
            if (pGrDesc != NULL)
            {
                hdc = BeginPaint(hwnd, &ps);
        		pPageDesc = pGrDesc->pPageDesc;
                if (!pPageDesc->fBlow || (pPageDesc->hSelGraph ==
                    pGrDesc->hGraph))
                {
                   pGrDesc->hdcPrint = 0;
                   pGrDesc->nObjCounter = 0;
                   if (pGrDesc->lpfnGraph != NULL)
                   {
                 	   if (!pGrDesc->fInit)
                       {
                           pGrDesc->fInit = TRUE;
#ifdef __cplusplus
#if QC_MEMBER
                    {
                        // pointer to instance of class derived from QCWBaseGraph, not function
                        QCBaseGraph* bld; 
                        bld = (QCBaseGraph FAR *)pGrDesc->lpfnGraph;
                        bld->BuildGraph (pGrDesc, hdc); // call member function
                    }
#else
                           (*pGrDesc->lpfnGraph) (pGrDesc, hdc); // call user routine
#endif
#else
						   
 						 if (!pGrDesc->bAddGrObj)
							 (*pGrDesc->lpfnGraph) (pGrDesc, hdc); // call user routine
       					else
							   pGrDesc->fFirstTime = FALSE;
#endif
              /* it is possible that user routine contained a message box which 
                 released control after the graph has been destroyed. So, verify */  
                   		  pPageDesc = (PPAGE_DEF)GetWindowLong (hwnd, GWL_PARENTDESC);
                           if (pPageDesc == NULL)
                           {
                                ErrHdlr (ERR_BAD_GRAPH_HANDLE, ERP_NONE, NULL);
                                return 0;
                           }
                           pGrDesc->nObjCounter = 0;
                           pGrDesc->fFirstTime = FALSE;
                           ConnectAxes(pGrDesc);
                        }
                   }
                   if (!pGrDesc->fFirstTime)
                   {
                       if (_TopDesc.bTerm)
                            ExitApplication();
                       else
                       {
                           ObjectInterpreter(pGrDesc, hdc);
                           pGrDesc->cRepaint = 1; // enable background repaint
                           if (_TopDesc.bTerm)
                           {
                                CleanGDI (hdc);
                                ExitApplication();
                           }
                       }
                   }
                }
                // restore system brush and pen, delete used ones
                CleanGDI (hdc);
        	    EndPaint(hwnd, &ps);
            }
            return 0;
        }
    }
    return (DefWindowProc(hwnd, message, wParam, lParam));
}
/**************************************************************************/
/* Cleanup function - must be called before application exits *************/
/**************************************************************************/
void WINAPI WGCleanup (BOOL bFreeData)
{
    Cleanup (&_TopDesc, bFreeData);
}
/**************************************************************************/
/* Startup function - should be called first if any Charting Tools ********/
/* function is used before the first page is created               ********/
/**************************************************************************/
void WINAPI WGStart(void)
{
    InitDll (&_TopDesc); 
}                       
/**************************************************************************/
/* This function creates page that is not displayed on the screen.*********/
/* It can be printed or converted to metafile.*****************************/
/**************************************************************************/
PPAGE_DEF WINAPI WGCreateInvisiblePage (LPCSTR lpName, // page ASCII identifier
               HINSTANCE hInst,  // application instance
               void FAR *lpfnPage, // processing function
               int nColor)       // backgrownd color code
{
    WNDCLASS  wc;
    HWND      hwndInv;
	PPAGE_DEF pPageDesc;

    wc.style = 0;
    wc.lpfnWndProc = DefWindowProc; 
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;  
    wc.hInstance =  hInst;  
    wc.hIcon  =     0;  
    wc.hCursor  =   0;  
    wc.hbrBackground = NULL;
    wc.lpszMenuName =  0;
    wc.lpszClassName = "Invisible";

    RegisterClass (&wc);

/* create invisible window */

    hwndInv = CreateWindow ("Invisible", NULL, WS_POPUP,
        0, 0, 
        GetSystemMetrics (SM_CXSCREEN),
        GetSystemMetrics (SM_CYSCREEN),
        0, 0, hInst, NULL);

    pPageDesc = WGCreatePage (lpName,
        hwndInv,                       // handle to invisible parent window
        hInst,                         // application instance handle 
        NULL,
        lpfnPage,
        NULL,
        nColor,                        // page window background color
        MM_PROPORT,     
        WS_CHILD,       
        PAGE_CLIENT,         
        0,0,0,0);

    return(pPageDesc);
}
/****************************************************************************/

void WINAPI  WGProcessMouseEventAction(HWND hwnd, int nEvent, int nAction, UINT message, POINT ptMouse)
{
	PGRAPH_DEF  pGrDesc;                // pointer to graph descriptor
    pGrDesc = (PGRAPH_DEF) GetWindowLong (hwnd, GWL_DESC);
	if (!pGrDesc) return;
    switch (nAction)
   {
   case OBJ_FIND_EVENT: ObjFind (hwnd); break;
   case OBJ_EDIT_EVENT: WGEditObject (hwnd); break;
   case OBJ_MOVE_EVENT:	WGStartObjMove (hwnd, 0, 0, message, 0, TRUE);
	                    break;
   case OBJ_ZOOM_EVENT: WGStartZoom (hwnd, 0, 0, message, TRUE);
                   break;
   case OBJ_USERZOOM_EVENT: WGStartZoom (hwnd, 0, 0, message, FALSE);
	                    break;
   case OBJ_USERPROC_EVENT: if ( (void *) pGrDesc->MouseEventMap[nEvent].lpfnUserMouseProc)
							pGrDesc->MouseEventMap[nEvent].lpfnUserMouseProc(hwnd, pGrDesc,  message , ptMouse );
	   break;
   }
}

void WINAPI  WGProcessMouseEvent(HWND hwnd, UINT message, POINT ptMouse)
{
    int nEvent = 0, nAction =0;
	PGRAPH_DEF  pGrDesc;                // pointer to graph descriptor
    pGrDesc = (PGRAPH_DEF) GetWindowLong (hwnd, GWL_DESC);
   
   if (!pGrDesc) return;
    InitDll (&_TopDesc); 
   // If All mouse message are to be trapped, call user proc
   if (pGrDesc->MouseEventMap[7].nMouseAction == OBJ_USERPROC_EVENT)
   {
     nAction = pGrDesc->MouseEventMap[7].nMouseAction;
     WGProcessMouseEventAction(hwnd, 7, nAction, message, ptMouse);
   } else // if a specific mouse message is to be trapped
   {
     switch (message)
	 {
     case WM_LBUTTONDOWN: nEvent=0; break;
     case WM_LBUTTONUP: nEvent = 1; break;
     case WM_RBUTTONDOWN: nEvent=2; break;
     case WM_RBUTTONUP: nEvent = 3; break;
     case WM_LBUTTONDBLCLK:nEvent=4; break;
     case WM_RBUTTONDBLCLK: nEvent=5; break;
     case WM_MOUSEMOVE:  nEvent=6; break;
	 }
     nAction = pGrDesc->MouseEventMap[nEvent].nMouseAction;
     WGProcessMouseEventAction(hwnd, nEvent, nAction, message, ptMouse);
   }
}

#pragma pack (pop)
#pragma optimize( "", on ) 
