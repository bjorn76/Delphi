/***************************************************************************/
/*                                                                         */
/*     Copyright (c) QUINN-CURTIS, 1992, 1998                              */
/*                                                                         */
/***************************************************************************/
/**                                                                        */
/**   Filename :   hook.c                                                  */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/**   Product  :   Windows Charting Tools                                  */
/**                                                                        */
/**   Description: Contains routines that can be modified by the user      */
/**                All the routines in the file must not be deleted.       */
/**                This file must be compiled and linked with the program. */                                   
/**                                                                        */
/**   Revisions  : 2/5/93 - "_export" was removed from EditObject def.     */
/**                3/18/93 - Keyboard message processing added.            */
/**                                                                        */
/***************************************************************************/
                                                                           
#include <windows.h>                                                       

#include "menus.h"
#include "qcwin.h"
#include "support.h"
#include "dialogs.h"

#include "demo.h"

extern int nMode;
extern HINSTANCE _hInst;
extern int nPlotNum;
extern PPAGE_DEF pPrevPage;
extern PPAGE_DEF pDynPage;
extern int  nDialCount;
extern BOOL bDialogUp;
extern BOOL bSuperZoomF;

#pragma pack (push, 8)

HWND   hwndRet, hwndNext, hwndPrev;
void CreateRetBut (HWND hwnd, int cxClient, int cyClient);

/*************************************************************************
   Default object editing is done in DefEditObject. You can switch to
   your own editing functions for any object type here.

/*************************************************************************/

void CALLBACK EditObject (PGRAPH_DEF pGrDesc)
{
	HGOBJ  hObj;          // handle to selected object
	int    nObjType;      // object type

    hObj = WGGetSelObject (pGrDesc, NULL, NULL);   // handle to selected object
    nObjType = WGGetObjectType (pGrDesc, hObj); // determine object type
 
    switch (nObjType)
    {
/*************************************************************************
 To intercept, for example, editing of legends with your own routine called
        UserEditLegends, enter the following: 

        case GO_LEGEND:
            UserEditLegends (pGrDesc, hObj);
            break;
**************************************************************************/
        default:
            DefEditObject (pGrDesc);
    }
}

/**************************************************************************/
/* This routine is called when any mouse event occured while the mouse    */
/* cursor is over the Graph window                                        */
/**************************************************************************/

void CALLBACK WGGraphKeyEvent (HWND hwnd,   // graph window handle
    UINT message,                  // WM_KEYUP, WM_KEYDOWN or WM_CHAR
	WPARAM nVKey,                    // virtual key-code value of the key
	LPARAM dwKeyData)               // value of lParam of WM_CHAR
{
    // Put your key processing here
	switch (message)
    {
        case WM_KEYUP:
            break;

        case WM_KEYDOWN:
            break;

        case WM_CHAR:
            break;
    }
}

void CALLBACK WGGraphMouseEvent (HWND hwnd, UINT message, POINT ptMouse)
{
//	static BOOL bCursorOn = FALSE;


    
	if ((bSuperZoomF) || (nMode == ID_INTER))
	  WGProcessMouseEvent( hwnd,  message,  ptMouse);
#if 0
	switch (message)
	{
		case WM_LBUTTONDOWN:
			if (nMode == ID_INTER)
				ObjFind (hwnd);  // default operation - find and highlight object
								 // under the mouse cursor. Can be replaced by
                                 // user own actions

            else
            if (nMode == ID_ZOOM)
            {
                if (!bCursorOn)
                {
                    bCursorOn = TRUE;   // turn on the data cursor
                    UpdateDataCursorPosition ();
                }
                else
                {
                    bCursorOn = FALSE;   // turn off the data cursor
                    RemoveDataCursors ();
                }
            }
            break;

        case WM_LBUTTONDBLCLK:   // default operation - edit selected object.
            if (nMode == ID_INTER)
			   WGEditObject (hwnd); // Can be replaced by user own actions
            break;

        case WM_MOUSEMOVE:       // call your routines, if you want

            if ((nMode == ID_ZOOM) && bCursorOn)
				UpdateDataCursorPosition ();
            break;

        case WM_RBUTTONDOWN:
        case WM_RBUTTONDBLCLK:
            if (nMode == ID_ZOOM)
			    WGStartZoom (hwnd, 0, 0, message, FALSE);
            break;

		case WM_RBUTTONUP:  
            if (nMode == ID_ZOOM)
			{
				realtype rLeft, rRight, rBottom, rTop;
				// get results of ZOOM operation
				if (WGGetZoom (&rLeft, &rTop, &rRight, &rBottom))
									UpdateZoomView (rLeft, rTop, rRight, rBottom);
			}
    }
#endif
}
/*************************************************************************/
/* User extension for page window message processing                     */
/*************************************************************************/
LRESULT FAR PASCAL WGUserPageProc (HWND hwnd, UINT message,
        WPARAM wParam, LPARAM lParam)
{
	PPAGE_DEF    pPageDesc;   
	HMENU        hMenu, hSubMenu;
	RECT         rcClient;
    int          cxClient, cyClient;
    int          cxBut, cyBut, x;
	static  nPrintRet=0;
    static  BOOL bPrintSetup = FALSE;

  	switch (message)
	{
        case WM_CREATE:
           pPageDesc = WGGetPageDesc (hwnd);

           GetClientRect (hwnd, &rcClient);
		   cxClient = rcClient.right - rcClient.left;
		   cyClient = rcClient.bottom - rcClient.top;
                           
           switch (nMode)
           {
               case ID_INTER:
                // initialize menu
                   hMenu = GetMenu (hwnd);
                   if (hMenu != NULL)
                   {
                      hSubMenu = GetSubMenu (GetMenu (hwnd), IDM_OPTIONSPOS);

                       // turn on graph selection buttons
                       WGToggleSelectors (pPageDesc, TRUE);
                       CheckMenuItem (hSubMenu, IDM_SHOWSEL, MF_CHECKED);
                   }
                   CreateRetBut (hwnd, cxClient, cyClient);
                   break;

               case ID_DIALOGS:
               case ID_ZOOM:
                   CreateRetBut (hwnd, cxClient, cyClient);
                   break;
                  
               case ID_PLOTS:
                   WGToggleSelectors (pPageDesc, FALSE);
                  
                   cxBut = (int)(cxClient * (1.0 - BBXSTART) * 0.8);
                   cyBut = (int)(cyClient * (1.0 - BBYSTART) * 0.35);
                  
                   x = (int)(cxClient * BBXSTART + 0.1 * cxBut);

                   hwndRet = CreateWindow ("BUTTON", "&Next",
                      WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE,
                      x, (int)(cyClient * BBYSTART + 0.3 * cyBut),
                      cxBut, cyBut,
					  hwnd,  (HMENU)(ID_NEXT), _hInst, 0);

				   hwndRet = CreateWindow ("BUTTON", "&Prev",
					  WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE,
					  x, (int)(cyClient * BBYSTART + 1.5 * cyBut),
					  cxBut, cyBut,
					  hwnd,  (HMENU) (ID_PREV),
					 _hInst, NULL);

				   x = (int)(cxClient * (1.0 - BBXSTART) - cxBut) / 2;
				   hwndRet = CreateWindow ("BUTTON", "P&ause",
					  WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE,
					  x, (int)(cyClient * BBYSTART + 0.3 * cyBut),
					  cxBut, cyBut,
					  hwnd,  (HMENU)(ID_PAUSE),
					 _hInst, NULL);

				   hwndRet = CreateWindow ("BUTTON", "&Return",
					  WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE,
					  x, (int)(cyClient * BBYSTART + 1.5 * cyBut),
					  cxBut, cyBut,
					  hwnd,  (HMENU) (ID_RETURN),
					 _hInst, NULL);

                   break;
            }  // switch
    	    return 0;

        case WM_DESTROY:
        {
            if (pPrevPage == pDynPage)
            {
                KillTimer (GetParent (hwnd), ID_TIMERDYN);
                pDynPage = NULL;
            }
            pPrevPage = NULL;
            return 0;
        }

        case WM_SIZE:

            if ((nMode == ID_INTER) ||
               (nMode == ID_DIALOGS))
            {
                cxClient = LOWORD (lParam);
                cyClient = HIWORD (lParam);

                cxBut = (int)(cxClient * (1.0 - BBXSTART) * 0.8);
				cyBut = (int)(cyClient * (1.0 - BBYSTART) * 0.8);

                MoveWindow (hwndRet, (int)(cxClient * BBXSTART + 0.1 * cxBut),
                   (int)(cyClient * BBYSTART + 0.1 * cyBut),
                   cxBut, cyBut, TRUE);
            }

            return 0;

        case WM_KEYDOWN:
            switch (wParam)
            {
                case VK_PRIOR:
                case VK_UP:
                case 'p':
                case 'P':
    			    SendMessage (hwnd, WM_COMMAND, ID_PREV, 0L);
                   break;

                case VK_NEXT:
                case VK_DOWN:
                case 'N':
                case 'n':
    			    SendMessage (hwnd, WM_COMMAND, ID_NEXT, 0L);
                break;

                case 'a':
                case 'A':
    			    SendMessage (hwnd, WM_COMMAND, ID_PAUSE, 0L);
                   break;

                case 'r':
                case 'R':
                case VK_RETURN:
                case VK_ESCAPE:
    			    SendMessage (hwnd, WM_COMMAND, ID_RETURN, 0L);
                break;
            }
            return 0;

		case WM_COMMAND: /* message: command from application menu */
       	    pPageDesc = WGGetPageDesc (hwnd);

            KillTimer (pPageDesc->hwParent, ID_TIMERGO);
            KillTimer (pPageDesc->hwParent, ID_TIMERSTART);
            KillTimer (pPageDesc->hwParent, ID_TIMERDIAL);
            KillTimer (pPageDesc->hwParent, ID_TIMERDIALB);
		  
            if (nMode != ID_INTER)
                SetTimer (pPageDesc->hwParent, ID_TIMERSTART, STARTPER, 0L);

			switch (wParam)
			{
 				   case IDM_PSET :     // set up default printer
				   {
						 nPrintRet = WGPrinterSetup (hwnd);
						 if (nPrintRet)
                           bPrintSetup = TRUE;
						 break;
				   }
				   case IDM_PRINT_GRAPH :     // Print one selected graph
 				         if (!bPrintSetup)
							 nPrintRet = WGPrinterSetup (hwnd);
						 if (nPrintRet)
						 {
						   WGPrintGraph (WGGetSelectedGraph (pPageDesc));
                           bPrintSetup = TRUE;
						 }
						 break;

				   case IDM_PRINT_PAGE :    // print page with all its graphs
 				         if (!bPrintSetup)
 				           nPrintRet = WGPrinterSetup (hwnd);
						 if (nPrintRet)
						 {
                          WGPrintPage(pPageDesc);
                          bPrintSetup = TRUE;
						 }
                  break;

               case IDM_PRINT_PARAM : // call dialog box to modify print parameters
                   WGPrintOptionsDlg ();
                   break;

               case IDM_SAVEASMETA :    // save page as metafile
				   WGSavePageMeta(pPageDesc, MF_PL, NULL);
				   break;

               case IDM_COPYGRAPH:  // copy graph to clipboard
                   WGCopyGraph (WGGetSelectedGraph (pPageDesc));
                   break;

               case IDM_COPYPAGE:  // copy page to clipboard
                   WGCopyPage (pPageDesc);
                   break;

               case IDM_PARGRAPH:  // call graph parameters dialog box
                   WGEditGraphDlg (pPageDesc);
                    break;

               case IDM_CLEAR:      // delete selected graph
                   WGToggleSelectors (pPageDesc, FALSE);
 //                  WGDeleteGraph (WGGetSelectedGraph (pPageDesc));
                   WGToggleSelectors (pPageDesc, TRUE);
                   break;

               case IDM_SHOWSEL:       // show graph selectors
                    WGToggleSelectors (pPageDesc,
                       WGMenuCheck (pPageDesc, wParam, IDM_OPTIONSPOS));
                    break;

               case IDM_HIGHSEL:       // highlight selected graph
                    WGToggleHigh (pPageDesc, 
                        WGMenuCheck (pPageDesc, wParam, IDM_OPTIONSPOS));

                    break;

               case IDM_BLOWSEL:       // blow up selected graph
                   {
                       BOOL bDir;

                       PGRAPH_DEF pSelGrDesc = WGGetSelectedGraph (pPageDesc);
                       bDir = WGMenuCheck (pPageDesc, wParam, IDM_GRAPHPOS);
                       WGBlowupGraph (pSelGrDesc, bDir);
                       if (!bDir)
                       {
                           InvalidateRect(hwndRet, NULL, TRUE); // force button
					   }
                   }
                   break;

               case ID_PAUSE:
                       KillTimer (pPageDesc->hwParent, ID_TIMERSTART);
                   break;

               case ID_RETURN:
   //                if (nMode == ID_DIALOGS)
				   if (bDialogUp)
                   {
                       nDialCount = 1;
                       NextDialog (pPageDesc->hwParent, TRUE);
                   }
                   else
                   {
                       KillTimer (pPageDesc->hwParent, ID_TIMERDYN);
                       nMode = 0;
                       pPrevPage = NULL;
                       DestroyWindow (hwnd);
                   }
                   break;

               case ID_NEXT:
                   if (nMode == ID_PLOTS)
                   {
                       ++nPlotNum;
                       Plots (pPageDesc->hwParent);
                   }
                   break;

               case ID_PREV:
                   if (nMode == ID_PLOTS)
                   {
                       --nPlotNum;
                       Plots (pPageDesc->hwParent);
                   }
                   break;

               default:
                   break;
            }
            return 0;
    }
	  return (DefWindowProc(hwnd, message, wParam, lParam));
}
/****************************************************************************/
void CreateRetBut (HWND hwnd, int cxClient, int cyClient)
{
    int     cxBut, cyBut;

    cxBut = (int)(cxClient * (1.0 - BBXSTART) * 0.8);
    cyBut = (int)(cyClient * (1.0 - BBYSTART) * 0.8);
    hwndRet = CreateWindow ("BUTTON", "Return",
       WS_CHILD | BS_PUSHBUTTON | WS_VISIBLE,
       (int)(cxClient * BBXSTART + 0.1 * cxBut),
       (int)(cyClient * BBYSTART + 0.1 * cyBut),
       cxBut, cyBut,
       hwnd,  (HMENU)(ID_RETURN),
	  _hInst, NULL);
}
/****************************************************************************/

#pragma pack (pop)
