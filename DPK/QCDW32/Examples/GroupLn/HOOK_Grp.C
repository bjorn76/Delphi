/***************************************************************************/
/*                                                                         */
/*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998                       */
/*                                                                         */
/***************************************************************************/
/**                                                                        */
/**   Filename :   hook_Grp.c                                                  */
/**   Author   :   QC                                                      */
/**   Revision :   3.0                                                    */
/**   Date     :   Aug 15, 1998                                        */
/**   Product  :   Windows Charting Tools                                  */
/**                                                                        */
/**   Description: Contains routines that can be modified by the user      */
/**                All the routines in the file must not be deleted.       */
/**                This file must be compiled and linked with the program. */                                   
/**                                                                        */
/**                                                                        */
/***************************************************************************/
                                                                           
// #include "stdafx.h"      // uncomment for Visual C++

#ifdef _MSC_VER
#pragma warning( disable : 4103)
#pragma pack (1)
#endif

#include <windows.h>
#include "menus.h"
#include <windowsx.h>
#include "qcwin.h"
#pragma hdrstop

#include "wx.h"

#include "support.h"

extern BOOL IsPrintText(HGOBJ hObj, LPINT orient);
extern void PrintPage (int orient);

#pragma pack (push, 8)


void ObjAct (HWND hwnd);

/*************************************************************************
   Default object editing is done in DefEditObject. You can switch to
   your own editing functions for any object type here.

 *************************************************************************/

void CALLBACK EditObject (PGRAPH_DEF pGrDesc)
{
	HGOBJ  hObj;          // handle to selected object
	int    nObjType;      // object type
    int    ret;
	UINT	nsel;


	hObj = WGGetSelObject (pGrDesc, NULL, &nsel);  // handle to selected object
	nObjType = WGGetObjectType (pGrDesc, hObj);   // determine object type
 
	switch (nObjType)
	{
/*************************************************************************
 To intercept, for example, editing of legends with your own routine called
		UserEditLegends, enter the following: 

        case GO_LEGEND:
            UserEditLegends (pGrDesc, hObj);
            break;
		
**************************************************************************/

		case GO_RECT:
			break;
		default:
			ret = DefEditObject (pGrDesc);  // can be IDOK or IDCANCEL
	}
}
/**************************************************************************/
/* This routine is called when any mouse event occured while the mouse    */
/* cursor is over the Graph window                                        */
/**************************************************************************/
void WINAPI WGGraphMouseEvent (HWND hwnd, UINT message, POINT ptMouse)
{
	switch (message)
	{
		case WM_LBUTTONDOWN:
			ObjFind (hwnd);      // default operation - find and highlight object
							     // under the mouse cursor. Can be replaced by
								 // user's own actions

			ObjAct (hwnd);		 // Perform desired action based on mouse click
			break;

		case WM_LBUTTONDBLCLK:   // default operation - edit selected object.
			WGEditObject (hwnd); // Can be replaced by user own actions
			break;

		case WM_MOUSEMOVE:       // call your routines, if you want
//            WGShowMouseCoord (hwnd, CO_PHYS, FALSE);
			break;

   		case WM_RBUTTONDOWN:

			break;
		case WM_RBUTTONDBLCLK:
            break;
    }
}

/*************************************************************************/
/* This routine is called when a WM_CHAR message is received by the      */
/* Graph window hwnd that has the focus.                                 */
/*************************************************************************/

void WINAPI WGGraphKeyEvent (HWND hwnd,   // graph window handle
    UINT message,                    // WM_KEYUP, WM_KEYDOWN or WM_CHAR
    WPARAM nVKey,                    // virtual key-code value of the key
    LPARAM dwKeyData)                // value of lParam of WM_CHAR
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

/*************************************************************************/
/* User extension for page window message processing                     */
/*************************************************************************/
LRESULT CALLBACK WGUserPageProc (HWND hwnd, UINT message,
        WPARAM wParam, LPARAM lParam)
{
	PPAGE_DEF    pPageDesc;   
	HMENU        hMenu, hSubMenu;
	BOOL bRet;
	int test =0;

  	switch (message)
	{
		/* the following section causes graph selector buttons to appear
		   in the upper right corner of the page. If you do not want
		   that to happen, simply remove WM_CREATE message processing below.
		*/
		case WM_CREATE:
			{
				DWORD  dwStyle;
				dwStyle = GetWindowLong (hwnd, GWL_STYLE);
				if (!(dwStyle & WS_CHILD))
				{
					pPageDesc = WGGetPageDesc (hwnd);
					 // initialize menu
					hMenu = GetMenu (hwnd);
					if (hMenu != NULL)
					{
					    hSubMenu = GetSubMenu (GetMenu (hwnd), IDM_OPTIONSPOS);

        				// turn on graph selection buttons
						WGToggleSelectors (pPageDesc, TRUE);
						CheckMenuItem (hSubMenu, IDM_SHOWSEL, MF_CHECKED);
					}
				}
		   }
		   return 0;

        case WM_SIZE:
             return(0);

		case WM_COMMAND: /* message: command from application menu */
    		{
        	   WORD    id = GET_WM_COMMAND_ID(wParam, lParam);

				pPageDesc = WGGetPageDesc (hwnd);
				switch (id)
				{
 				     case IDM_PSET :     // set up default printer
						WGPrinterSetup (hwnd);
						break;

					 case IDM_PRINT_GRAPH :     // Print one selected graph
						 bRet = WGPrintGraph (WGGetSelectedGraph (pPageDesc));
						 if (!bRet)
							 test = 1;
						 break;

					 case IDM_PRINT_PAGE :    // print page with all its graphs
						 bRet = WGPrintPage(pPageDesc);
						 if (!bRet)
							 test = 1;
						 break;

					 case IDM_PRINT_PARAM : // call dialog box to modify print parameters
					 	 WGPrintOptionsDlg ();
					 	 break;

					 case IDM_SAVEASMETA :    // save page as metafile
#ifdef WIN32
					 	 WGSavePageMeta(pPageDesc, MF_ENH, NULL);
#else
					 	 WGSavePageMeta(pPageDesc, MF_PL, NULL);
#endif
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
                         WGDeleteGraph (WGGetSelectedGraph (pPageDesc));
                         WGToggleSelectors (pPageDesc, TRUE);
                         break;

                     case IDM_SHOWSEL:       // show graph selectors
                          WGToggleSelectors (pPageDesc,
                          WGMenuCheck (pPageDesc, id, IDM_OPTIONSPOS));
                          break;

                     case IDM_HIGHSEL:       // highlight selected graph
                          WGToggleHigh (pPageDesc, 
                          WGMenuCheck (pPageDesc, id, IDM_OPTIONSPOS));
                          break;

                     case IDM_BLOWSEL:       // blow up selected graph
                         {
                             PGRAPH_DEF pSelGrDesc = WGGetSelectedGraph (pPageDesc);
                             if (pSelGrDesc != NULL)
                             {
                                 WGBlowupGraph (pSelGrDesc,
                                 WGMenuCheck (pPageDesc, id, IDM_GRAPHPOS));
                             }
                         }
                         break;
			          case IDM_SERIALIZE_LOAD:
                           WGRestorePage ("SAVEPAGE.ASC", pPageDesc->hwParent, "PAGEMENU");
						   break;
       				  case IDM_SERIALIZE_SAVE:
				            WGSavePage (pPageDesc, "SAVEPAGE.ASC");
							break;

                     default:
                    break;
                }
            }
            return 0;
    }
    return (DefWindowProc(hwnd, message, wParam, lParam));
}
/****************************************************************************/


// Perform desired action based on mouse click - in this sample program, the 
//  page window will be printed if either "Print Portrait" or "Print Landscape"
//  text is clicked (single) with the left mouse button
void ObjAct (HWND hwnd)
{
	PGRAPH_DEF pGraph;	  // pointer to current graph descriptor
	HGOBJ  hObj;          // handle to selected object
	int    nObjType;      // object type
	UINT	nsel;

	int orient;			// printer orientation

	pGraph = WGGetGraphDesc (hwnd);
	hObj = WGGetSelObject (pGraph, NULL, &nsel);  // handle to selected object
	nObjType = WGGetObjectType (pGraph, hObj);   // determine object type
 
	switch (nObjType)
	{
		case GO_TEXT:
			if (IsPrintText(hObj, &orient))		// If one of "Print" buttons pressed
				PrintPage(orient);				//  print PAGE WINDOW with selected orientation
			break;

		default:
			break;
	}
}
#pragma pack (pop)
