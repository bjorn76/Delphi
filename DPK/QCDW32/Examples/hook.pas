{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   HOOK.PAS                                    *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
{$X+,F+,A+,K+}
unit Hook;

interface
uses WinTypes, WinProcs, Messages, qcwin, support;


{$I Menus.INC}  { Menu Constants }

function WGCreatePage (lpName:PChar; hwParent:HWND;
	       thInst:THandle; lpTitle:PChar;
{$ifndef DMF}
               lpfnPage:TFarProc; { processing function       }
{$else}
               lpfnPage: PQCBasePage;
{$endif}
               lpMenu:PChar;
	       nColor, nSizeMode:INTEGER;
	       dwWinStyle:LongInt;
	       nPosStyle, x, y, cx, cy:INTEGER): PPAGE_DEF;

function WGCreateInvisiblePage (lpName:PChar; thInst:THandle;
	       lpfnPage:TFarProc; nColor:INTEGER) :  PPAGE_DEF;

function WGCreateGraph (pPageDesc:PPAGE_DEF;
{$ifndef DMF}
                        lpfnGraph:TFarProc; { processing function }
{$else}
                        lpfnGraph: PQCBaseGraph; { processing function }
{$endif}
			rX1, rY1, rX2, rY2:Realtype;
			nColor, nBorderColor, nBorderWidth:INTEGER): PGRAPH_DEF;
procedure WGCleanup (bFreeData:BOOL);
procedure WGStart;
procedure  WGEditObject (thwnd:HWND);


procedure WGGraphMouseEvent (thwnd:HWnd; message:UINT;
			      ptMouse:TPoint);
procedure WGGraphKeyEvent (thwnd:HWND; message, nVKey:UINT;
     dwKeyData:LONGINT);

function  WGUserPageProc (thwnd:HWND; message:UINT;
	 wParam:UINT; lParam:LONGINT):LONGINT;
procedure EditObject (pGrDesc:PGRAPH_DEF);

function WGRestorePage ( lpFileName: PChar; hwParent: HWND;
         lpMenu: PChar): PPAGE_DEF;


function  WGGetPntrReal (p:POINTER; n:UINT): REALTYPE;
procedure WGPutPntrReal (p:POINTER; n:UINT; r:REALTYPE);
function  WGGetPntrInt (p:POINTER; n:UINT): INTEGER;
procedure WGPutPntrInt (p:POINTER; n:UINT; i:INTEGER);
function  WGGetPntrByte (p:POINTER; n:UINT): BYTE;
procedure WGPutPntrByte (p:POINTER; n:UINT; value:BYTE);


{***********************************************************************}
implementation

{$ifndef WIN32}
function PageProc (thwnd:HWnd; message:UINT; wParam:UINT;
		 lParam:LongInt): LongInt; export; forward;
function GraphProc (thwnd:HWnd; message:UINT; wParam:UINT;
				   lParam:LongInt): LongInt; export; forward;
{$else}
function PageProc (thwnd:HWnd; message:UINT; wParam:UINT;
		 lParam:LongInt): LongInt; stdcall; forward;
function GraphProc (thwnd:HWnd; message:UINT; wParam:UINT;
				   lParam:LongInt): LongInt;stdcall; forward;
{$endif}
procedure WGProcessMouseEventAction(thwnd: HWND; nEvent, nAction: INTEGER;
                   message: UINT;  ptMouse: TPOINT); forward;
procedure  WGProcessMouseEvent( thwnd: HWND; message: UINT;  ptMouse: TPOINT); forward;


type ProcType2 = procedure (pGrDesc: PGRAPH_DEF; thdc: HDC);
     ProcType1 = procedure (pPageDesc: PPAGE_DEF);
     MouseProc1 = procedure  ( thwnd: HWND; pGrDesc: PGRAPH_DEF; message: UINT;  ptMouse: TPOINT);

     Long = record
	Lo, Hi : WORD;
     end;

const
  hButtonBrush: HBRUSH = 0;
  szPageName: PChar = 'PgWin';
  szGraphName: PChar = 'GrWin';
  hPg: HGRAPH = 0;                { Page descriptor handle            }

var
   _TopDesc: TOP_DEF;                     { global application parameters }
   _DevDescPtr: ^DEV_DEF;
   _hInst: THandle;                      { Stores the current instance   }
   sizerealtype, sizereal, sizesingle, sizedouble, sizeinteger,
   sizepointer, sizelong: WORD;


{************************************************************************
   Default object editing is done in DefEditObject. You can switch to
   your own editing functions for any object type here.
***********************************************************************}


{ *********************************************************************** }

procedure EditObject (pGrDesc:PGRAPH_DEF);
var
    hObj: THANDLE;          {  handle to selected object}
    nObjType: INTEGER;      {  object type}
    p1: UINT;
    p2: INTEGER;
begin
  hObj:= WGGetSelObject (pGrDesc, p1, p2);
  {  handle to selected object}
  nObjType:= WGGetObjectType (pGrDesc, hObj);
  {  determine object type}
  (*
  CASE (nObjType) OF
  { ************************************************************************
  To intercept, for example, editing of legends with your own routine called
  UserEditLegends, enter the following:

  GO_LEGEND: UserEditLegends (pGrDesc, hObj);
  END
  ELSE
  }
  *)
  DefEditObject (pGrDesc);

end;

{ ************************************************************************ }
{  This routine is called when any mouse event occured while the mouse     }
{  cursor is over the Graph window                                         }
{ ************************************************************************ }

procedure WGGraphMouseEvent (thwnd:HWND; message:UINT; ptMouse:TPOINT);
begin
  WGProcessMouseEvent( thwnd,  message,  ptMouse);
   exit;

  case (message) of
    WM_LBUTTONDOWN:
      ObjFind (thwnd);
    {  default operation - find and highlight object}
    {  under the mouse cursor. Can be replaced by}
    {  user's own actions}

    WM_LBUTTONDBLCLK:
      {  default operation - edit selected object.}
      WGEditObject (thwnd);            {  Can be replaced by user own actions}

    WM_MOUSEMOVE:                      {  call your routines, IF you want}
      {             WGShowMouseCoord (hwnd, CO_PHYS, FALSE);  }
      ;

    WM_RBUTTONDOWN: ;
    WM_RBUTTONDBLCLK:
      {             WGShowMouseCoord (hwnd, CO_PHYS, TRUE);}
      ;
  end;

end;

{ ************************************************************************ }
{  This routine is called when a WM_CHAR message is received by the        }
{  Graph window hwnd that has the focus.                                   }
{ ************************************************************************ }

procedure WGGraphKeyEvent (thwnd:HWND; message, nVKey:UINT; 
     dwKeyData:LONGINT);
begin
  case (message) of
    { Put your key processing here }
    WM_KEYUP:;
    WM_KEYDOWN:;
    WM_CHAR:;
  end;
end;


{ *********************************************************************** }
{  User extension for page window message processing                      }
{ *********************************************************************** }
function  WGUserPageProc (thwnd:HWND; message:UINT; 
	 wParam:UINT; lParam:LONGINT):LONGINT;

var
    pSelGrDesc: PGRAPH_DEF;
    pPageDesc: PPAGE_DEF;
    thMenu, hSubMenu: HMENU;
    dwStyle : LONGINT;

begin
  case (message) of
    {   the following section causes graph selector buttons to appear
    in the upper right corner of the page. If you do not want
    that to happen, simply remove WM_CREATE message processing below
    }
    WM_CREATE: begin
      dwStyle:= GetWindowLong (thwnd, GWL_STYLE);
      if ((dwStyle and WS_CHILD) = 0) then begin
	pPageDesc:= WGGetPageDesc (thwnd);
	{  initialize menu}
	thMenu:= GetMenu (thwnd);
	if (thMenu <> NULLH) then begin
	  hSubMenu:= GetSubMenu (GetMenu (thwnd), IDM_OPTIONSPOS);

	  {  turn on graph selection buttons}
	  WGToggleSelectors (pPageDesc, TRUE);
	  CheckMenuItem (hSubMenu, IDM_SHOWSEL, MF_CHECKED);
	end;
      end;
      WGUserPageProc:= 0;
      exit;
    end;
    
    WM_COMMAND: begin
      {  message: command from application menu  }
      pPageDesc:= WGGetPageDesc (thwnd);
      case (wParam) of
	IDM_PSET :                     {  set up default printer}
	  WGPrinterSetup (thwnd);
	IDM_PRINT_GRAPH :              {  Print one selected graph}
	  WGPrintGraph (WGGetSelectedGraph (pPageDesc));
	
	IDM_PRINT_PAGE :               {  print page with all its graphs}
	  WGPrintPage (pPageDesc);
	
	IDM_PRINT_PARAM :
	  {  call dialog box to modIFy print parameters}
	  WGPrintOptionsDlg;

	IDM_SAVEASMETA :               {  save page as metafile}
	  WGSavePageMeta (pPageDesc, TRUE, NULLP);
	
	IDM_COPYGRAPH:                 {  copy graph to clipboard}
	  WGCopyGraph (WGGetSelectedGraph (pPageDesc));
	
	IDM_COPYPAGE:                  {  copy page to clipboard}
	  WGCopyPage (pPageDesc);

	IDM_PARGRAPH:                  {  call graph parameters dialog box}
	  WGEditGraphDlg (pPageDesc);
	
	IDM_CLEAR: begin 
	  {  delete selected graph}
	  WGToggleSelectors (pPageDesc, FALSE);
	  WGDeleteGraph (WGGetSelectedGraph (pPageDesc));
	  WGToggleSelectors (pPageDesc, TRUE);
	end;
	
	IDM_SHOWSEL: begin 
	  {  show graph selectors}
	  WGToggleSelectors (pPageDesc, 
	    WGMenuCheck (pPageDesc, wParam, IDM_OPTIONSPOS));
	end;

	IDM_HIGHSEL: begin
	  {  highlight selected graph}
	  WGToggleHigh (pPageDesc, 
	    WGMenuCheck (pPageDesc, wParam, IDM_OPTIONSPOS));
	end;

	IDM_BLOWSEL: begin 
	  {  blow up selected graph}
	  pSelGrDesc:= WGGetSelectedGraph (pPageDesc);
	  if (pSelGrDesc <> NULLP) then begin
	    WGBlowupGraph (pSelGrDesc,
	      WGMenuCheck (pPageDesc, wParam, IDM_GRAPHPOS));
	  end;
	end;
      end;
      WGUserPageProc:= 0;
      exit;
    end;
  end;
  WGUserPageProc:= DefWindowProc (thwnd, message, wParam, lParam);
end;
{ * ************************************************************************* }


{$I QCWINIT.PAS}

begin
  sizerealtype:= sizeof (realtype);
  sizereal:= sizeof (real);
  sizesingle:= sizeof (single);
  sizedouble:= sizeof (double);
  sizeinteger:= sizeof (integer);
  sizepointer:= sizeof (pointer);
  sizelong:= sizeof (longint);

end.
