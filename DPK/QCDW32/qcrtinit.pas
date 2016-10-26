
{*                                                                        }
{*   Description: Contains routines that can be modified by the user      }
{*                All the routines in the file must not be deleted.       }
{*                This file must be compiled and linked with the program. }
{*                The routines in the file QCWINIT.INC cannot be modified.}
{*************************************************************************}

function WGPreAddGraphObject (pGrDesc: PGRAPH_DEF; thdc: HDC): BOOL;
VAR
    hMem: HGLOBAL;           // Axis object memory handle
    j,k: INTEGER;
BEGIN
    InitDll (@_TopDesc);
    pGrDesc^.bAddGrObj := TRUE;
    pGrDesc^.fInit := TRUE;
    pGrDesc^.fFirstTime := TRUE;
    WGPreAddGraphObject := FALSE;

    for j :=  pGrDesc^.nNumObjs-1 DownTo 0 DO
    BEGIN
         hMem := WGGetPntrInt (pGrDesc^.pObjArr,j );
         if (hMem = 0) then
         begin
             k := j;
             exit;
         end;
         k := j;
     END;
    pGrDesc^.nObjCounter :=  k + 1; //number of objects presently in graph

    MapGraph(pGrDesc, thdc);  //call to establish proper viewpt settings

    WGPreAddGraphObject := TRUE;

end;

function WGPostAddGraphObject (pGrDesc: PGRAPH_DEF; thdc: HDC): BOOL;
begin
	ConnectAxes(pGrDesc);  //?NOT SURE IF NEEDED
	ReleaseDC (pGrDesc^.thwnd, thdc); // release device context
       pGrDesc^.fFirstTime := FALSE;
	WGRedrawGraph (pGrDesc, FALSE); //update graph
	pGrDesc^.bAddGrObj := FALSE;

	WGPostAddGraphObject :=  TRUE;
end;


function WGRestorePage ( lpFileName: PChar; hwParent: HWND;  lpMenu: PChar): PPAGE_DEF;
begin
    InitDll (@_TopDesc);
 	if (NOT(_TopDesc.bInit))  THEN
        BEGIN
        _DevDescPtr := GetDevDesc;
   	    _TopDesc.hwTop := GetActiveWindow;
    	_TopDesc.hInst := GetModuleHandle(char(0)) ;
        _TopDesc.cLenReal :=  sizeof (realtype);
        END;
    WGRestorePage := RestorePage (lpFileName, hwParent, lpMenu);
end;


{  If a slot is available (which it always should be), create a page
  descriptor and save a global memory handle for the page in _TopDesc.
  Page handle is the sequential number of the chart in _TopDesc.hPgMem.

**************************************************************************}

function WGCreatePage (lpName: PChar; { page ASCII identifier}
               hwParent: HWND; { handle to parent, required only if    }
                               { PAGE_CLIENT style is used    }
               thInst: THandle;     { module instance, required only the first time }
	       lpTitle: PChar;      { page window caption       }
{$ifndef DMF}
               lpfnPage:TFarProc; { processing function       }
{$else}
               lpfnPage: PQCBasePage;
{$endif}
	       lpMenu: PChar; 	       { menu name, can be NIL  }
               nColor, { backgrownd color code                 }
               nSizeMode: INTEGER; { MM_PROPORT or MM_FIXED    }
               dwWinStyle: LongInt; { window style             }
               nPosStyle, { position style - PAGE_CLIENT, PAGE_FULL, }
                                        { or PAGE_EXACT              }
               x, y, { if PAGE_EXACT, initial position       }
               cx, cy: INTEGER): PPAGE_DEF;

VAR
  aresult: PPAGE_DEF;
  sizedyndatadef: UINT;
  nsize: INTEGER;

BEGIN
    InitRTDll (@_TopDesc);
	if NOT(_TopDesc.bInit) THEN
	BEGIN
        _DevDescPtr := GetDevDesc;      { must be not in DLL ! }
                            { initialize callback functions' instances }
        _TopDesc.lpGraphProc :=  MakeProcInstance(@GraphProc, thInst);
        if (hwParent = NULLH) THEN
          _TopDesc.hwTop := GetActiveWindow
        else
        _TopDesc.hwTop := hwParent;
    	_TopDesc.hInst := thInst;
        _TopDesc.cLenReal := sizeof (realtype);
         _TopDesc.bCompoundFlag := TRUE;
         nsize := sizeof(LINEDESC);
         nsize := nsize + 1;
	if  NOT(InitTop(@_TopDesc, @PageProc, @GraphProc,
            CS_HREDRAW OR CS_VREDRAW OR CS_DBLCLKS OR CS_OWNDC OR CS_BYTEALIGNWINDOW)) THEN
    begin
      {  terminate application}
      ExitApplication;
      WGCreatePage := NULLP;
      exit;
    end;
    END;;

  aresult := InitPage (lpName, hwParent, lpTitle, lpMenu,
    nColor, nSizeMode, dwWinStyle, nPosStyle, x, y, cx, cy,
    lpfnPage);
  WGCreatePage := aresult;
END;
{************************************************************************}
{ Create empty graph window using coordinates relative to those of page }
{************************************************************************}
function WGCreateGraph (pPageDesc: PPAGE_DEF; { pointer to parent page }
{$ifndef DMF}
                        lpfnGraph:TFarProc; { processing function }
{$else}
                        lpfnGraph: PQCBaseGraph; { processing function }
{$endif}
			rX1, { relative coordinates }
			rY1, { 0, 0 - left upper corner }
			rX2, { of the page, 1,1 - right bottom }
			rY2: Realtype;
			nColor, { backgrownd color }
                        nBorderColor, { if < 0, no border }
                        nBorderWidth: INTEGER): PGRAPH_DEF;
begin
  WGCreateGraph := InitGraph (@_TopDesc, pPageDesc, rX1, rY1, rX2, rY2,
    nColor, nBorderColor, nBorderWidth, lpfnGraph);

end;

{************************************************************************}

PROCEDURE WREditObject (thwnd: HWND);
var
  pGrDesc: PGRAPH_DEF;                {  pointer to graph descriptor}
begin
  pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));
  HighlightObj (pGrDesc);
  {  disable graph and page windows while dialog box is active}
  EnableWindow (pGrDesc^.thwnd, FALSE);{  disable windows}
  EnableWindow (pGrDesc^.pPageDesc^.thwnd, FALSE);
  InitRTDll (@_TopDesc);
  rtEditObject (pGrDesc);
  EnableWindow (pGrDesc^.thwnd, TRUE); {  reenable windows}
  EnableWindow (pGrDesc^.pPageDesc^.thwnd, TRUE);
end;


{*************************************************************************

 Processes chart page window messages before giving control to
              user procedure in HOOK.pas

*************************************************************************}

function PageProc (thwnd: HWnd; message: UINT; wParam: UINT;
                 lParam: LongInt): LongInt;
VAR
  pPageDesc: PPAGE_DEF;       { pointer to page descriptor }
   thdc: HDC;                  { page window device context }
   ps: TPAINTSTRUCT;
   pcs: PCREATESTRUCT;
   hDum: THandle;
   pGrDesc: PGRAPH_DEF;
   rc: TRect;
   id, cmd: WORD;
{$ifdef DMF}
   pmpntr: PQCBasePage;
{$endif}

BEGIN
    InitRTDll (@_TopDesc);
	case message of
    	WM_CREATE:
        BEGIN
          pcs := PCREATESTRUCT (lParam);
          pPageDesc := PPAGE_DEF (pcs^.lpCreateParams);
          pPageDesc^.thwnd := thwnd;
        END;

    WM_COMMAND: begin
{    id := GET_WM_COMMAND_ID(wParam, lParam);
    cmd := GET_WM_COMMAND_CMD(wParam, lParam); }
    id := wParam;
    cmd := hiword(lParam);

      pPageDesc := PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if (id >= IDM_SELECTORS) and
          (id <= IDM_SELECTORS + 16) then
      begin
        if cmd = BN_CLICKED then
        begin
          pGrDesc := GetGrDescPtr ((MAX_PAGES) +
            (pPageDesc^.hPage * MAX_GRAPHS) +  id - IDM_SELECTORS);
          hDum := pPageDesc^.hSelGraph;
          WGSelectGraph (pGrDesc);
          if pPageDesc^.hSelGraph = hDum then
            WGEditGraphDlg (pPageDesc);
        end;
        PageProc := 0;
        Exit;
      end;
    end;
   WM_ERASEBKGND:
    begin
      PageProc := 1;
      Exit;
    end;

    WM_PAINT:
    begin                    { paint page window }
      pPageDesc := PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if NOT(WGIsPageDescValid(pPageDesc)) then
      begin
        PageProc := 0;
        Exit;
      end;
      thdc := BeginPaint (thwnd, ps);
      if NOT(pPageDesc^.fInitGraph) then
      begin
            { call user routine creating graphs }
        pPageDesc^.fInitGraph := TRUE;
{$ifndef DMF}
          ProcType1 (pPageDesc^.lpfnPage) (pPageDesc);
{$else}
          pmpntr := pPageDesc^.lpfnPage;
          pmpntr^.BuildPage(pPageDesc);
{$endif}
        if (_TopDesc.bTerm) THEN
        BEGIN
          EndPaint(thwnd, ps);
          PageProc := 0;
          Exit;
        END;
        if pPageDesc^.fDispSel then
        begin
          ShowGraphSelectors (pPageDesc, thdc, GS_ON);
          pPageDesc^.fPrevDispSel := TRUE;
        end;
        end
        else
        if pPageDesc^.fDispSel then
        begin
           if not (pPageDesc^.fPrevDispSel) then
           begin
                ShowGraphSelectors (pPageDesc, thdc, GS_ON);
                pPageDesc^.fPrevDispSel := pPageDesc^.fDispSel;
           end
           else
                ShowGraphSelectors (pPageDesc, thdc, GS_MOVE);
        end;

      { this is the fastest way to fill a rectangle with color ! }

      GetClipBox (thdc, rc);
      SetBkMode (thdc, OPAQUE);
      SetBkColor (thdc, pPageDesc^.rgbBkColor);
      ExtTextOut (thdc, 0, 0, ETO_OPAQUE, @rc, nil, 0, nil);

      if pPageDesc^.fHigh then
        HighlightGraph (pPageDesc, pPageDesc^.hSelGraph);

      EndPaint (thwnd, ps);
      PageProc := 0;
      Exit;
    end;
   WM_SIZE:
    begin
      ResizePage (thwnd, LOWORD (lParam), HIWORD (lParam));
    end;
    WM_DESTROY:
    begin
      pPageDesc := PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if WGIsPageDescValid(pPageDesc) then
         KillRTPage (pPageDesc^.hPage);
    end;
  end;
  { the rest is processed by the user written procedure }
  PageProc := WGUserPageProc (thwnd, message, wParam, lParam);
END;
{*************************************************************************

	FUNCTION: GraphProc (HWND, UINT, WPARAM, LPARAM)
	PURPOSE:  Processes graph child windows messages

*************************************************************************}

function GraphProc (thwnd: HWnd; message: UINT; wParam: UINT;
				   lParam: LongInt): LongInt;
var
	thdc: HDC;
	ps: TPAINTSTRUCT;
	pGrDesc: PGRAPH_DEF;                { pointer to graph descriptor }
	pPageDesc: PPAGE_DEF;
	rc, rcInt: TRECT;
        bRet: BOOL;
        pcs : PCREATESTRUCT;
begin
 case message of
    WM_CREATE: BEGIN
                 pcs := PCREATESTRUCT(lParam);
                 pGrDesc := PGRAPH_DEF(pcs^.lpCreateParams);
                 pGrDesc^.thdc := GetDC(thwnd);
                END;
    WM_MOUSEMOVE ,                     { mouse events }
      WM_RBUTTONDOWN ,
      WM_RBUTTONDBLCLK,
      WM_LBUTTONDOWN ,
      WM_LBUTTONDBLCLK,
      WM_LBUTTONUP,
      WM_RBUTTONUP,
      WM_MBUTTONDOWN,
      WM_MBUTTONUP,
      WM_MBUTTONDBLCLK:
      begin
             _DevDescPtr^.ptMouse.x := LOWORD (lParam);
             _DevDescPtr^.ptMouse.y := HIWORD (lParam);

{$ifndef WIN32}
      InitRTDll (@_TopDesc);
{$endif}
          WGGraphMouseEvent (thwnd, message, _DevDescPtr^.ptMouse);
          GraphProc := 0;
          exit;
      end;
      WM_CHAR,   { key messages }
      WM_KEYUP,
      WM_KEYDOWN:
      BEGIN
{$ifndef WIN32}
      InitRTDll (@_TopDesc);
{$endif}
          WGGraphKeyEvent (thwnd, message, wParam, lParam);
          GraphProc := 0;
          exit;
      END;
        WM_VSCROLL,
        WM_HSCROLL,
        WM_COMMAND,
{$ifdef WIN32}
		WM_CTLCOLORSCROLLBAR,
		WM_CTLCOLORBTN,
		WM_CTLCOLORSTATIC,
{$else}
		WM_CTLCOLOR,
{$endif}
        WM_DRAWITEM:BEGIN
	       GraphProc := QCChildControlProc (thwnd, message, wParam, lParam);
               exit;
               END;
        WM_ERASEBKGND:
        BEGIN
            pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));
            if (pGrDesc <> NULLP) THEN
                pGrDesc^.cRepaint := 1; { force background repaint }
           GraphProc :=  1;
           exit;
        END;
	WM_PAINT:
        BEGIN

{$ifndef WIN32}
			InitRTDll (@_TopDesc);
{$EndIF}
            pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));

	MapGraph (pGrDesc, pGrDesc^.thdc);
	bRet := GetUpdateRect (thwnd, rc, FALSE);
            if (bRet = FALSE) THEN
            BEGIN
              GraphProc := 0;
              exit;
            END;

            thdc := BeginPaint(thwnd, ps);
            if (pGrDesc <> NULLP) THEN
            BEGIN
                bRet := BOOL(IntersectRect (rcInt, rc, pGrDesc^.rPlotCoord));
                if (bRet = FALSE) THEN
                BEGIN
                    pGrDesc^.cIgnorePlot := TRUE;
                END;
    		pPageDesc := pGrDesc^.pPageDesc;
                if (NOT(pPageDesc^.fBlow) OR (pPageDesc^.hSelGraph = pGrDesc^.thGraph)) THEN
                BEGIN
                   pGrDesc^.nObjCounter := 0;
            	    if NOT(pGrDesc^.fInit) THEN
                   BEGIN
		      pGrDesc^.fInit := TRUE;

{$ifndef DMF}
              ProcType2 (pGrDesc^.lpfnGraph) (pGrDesc, thdc);
{$else}
              pmgpntr := pGrDesc^.lpfnGraph;
              pmgpntr^.BuildGraph(pGrDesc, thdc);
{$endif}
        { it is possible that user routine contained a message box which
            released control after the graph has been destroyed. So, verify }
     		   pPageDesc := PPAGE_DEF (GetWindowLong (thwnd, GWL_PARENTDESC));
                      if (pPageDesc = NULLP) THEN
                      BEGIN
{                           ErrHdlr (ERR_BAD_GRAPH_HANDLE, ERP_NONE, NULLP); }
                        GraphProc :=  0;
                        exit;
                      END;
                      pGrDesc^.nObjCounter := 0;
                      pGrDesc^.fFirstTime := FALSE;
                      ConnectAxes(pGrDesc);
                   END;

            	   if NOT(pGrDesc^.fFirstTime) THEN
                   BEGIN
                       ObjectInterpreter(pGrDesc, thdc);
                   END;
                   if (_TopDesc.bTerm) THEN
                       ExitApplication;
                END;
                if NOT(_TopDesc.bTerm) THEN
                BEGIN
                    pGrDesc^.cRepaint := 1; { enable repaint }
                    pGrDesc^.cIgnorePlot := FALSE;
                END;
            END;
    	    EndPaint(thwnd, ps);
           GraphProc :=  0;
           exit;
     END;
    END;
 GraphProc := DefWindowProc (thwnd, message, wParam, lParam);
END;
{************************************************************************}
{ Cleanup function - must be called befor application exits *************}
{************************************************************************}
PROCEDURE WRCleanup (bFreeData: BOOL);
BEGIN
    RTCleanup (@_TopDesc);
    Cleanup (@_TopDesc, bFreeData);
END;
{************************************************************************}
{ Startup function - should be called first if any Charting Tools *******}
{ function is used before the first page is created               *******}
{************************************************************************}
PROCEDURE  WGStart;
BEGIN
    InitRTDll (@_TopDesc);
END;
{************************************************************************}
{ This function creates page that is not displayed on the screen.********}
{ It can be printed or converted to metafile.****************************}
{************************************************************************}
FUNCTION WGCreateInvisiblePage (lpName: PChar; { page ASCII identifier}
               thInst: THandle;     { module instance }
               lpfnPage: TFarProc;  { processing function }
               nColor : INTEGER) :  PPAGE_DEF;

var
    wc: TWNDCLASS;
    thwndInv: HWND;
    i , cx, cy: INTEGER;
    pGrDesc   : PGRAPH_DEF;

begin
    wc.style := 0;
    wc.lpfnWndProc := @DefWindowProc;
    wc.cbClsExtra := 0;
    wc.cbWndExtra := 0;
    wc.hInstance  := thInst;
    wc.hIcon      := NULLH;
    wc.hCursor    := NULLH;
    wc.hbrBackground := NULLH;
    wc.lpszMenuName :=  NULLP;
    wc.lpszClassName := 'Invisible';

    RegisterClass (wc);

    {* create invisible window *}

    cx := GetSystemMetrics (SM_CXSCREEN);
    cy := GetSystemMetrics (SM_CYSCREEN);

    thwndInv := CreateWindow ('Invisible', NULLS, WS_POPUP,
        0, 0,
        cx, cy,
        0, 0, thInst, NULLP);

    WGCreateInvisiblePage := WGCreatePage (lpName,
        thwndInv,                       { handle to invisible parent window }
        thInst,                         { application instance handle }
        NULLP,
        lpfnPage,
        NULLP,
        nColor,                         { page window background color }
        MM_PROPORT,
        WS_CHILD,
        PAGE_CLIENT,
        0,0,0,0);
end;
{****************************************************************************}


 
procedure WRProcessMouseEventAction(thwnd: HWND; nEvent, nAction: INTEGER;
                   message: UINT;  ptMouse: TPOINT);
VAR
    pGrDesc: PGRAPH_DEF  ;                // pointer to graph descriptor
BEGIN
    pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));
    if (pGrDesc <> Nil) then
    begin
  case nAction of
   OBJ_FIND_EVENT: rtObjFind (thwnd);
   OBJ_EDIT_EVENT: WREditObject (thwnd);
   OBJ_MOVE_EVENT: WGStartObjMove (thwnd, 0, 0, message, 0, TRUE);
   OBJ_ZOOM_EVENT: WGStartZoom (thwnd, 0, 0, message, TRUE);
   OBJ_USERZOOM_EVENT: WGStartZoom (thwnd, 0, 0, message, FALSE);
   OBJ_USERPROC_EVENT: if (  pGrDesc^.MouseEventMap[nEvent].lpfnUserMouseProc <> Nil) then
	MouseProc1 (pGrDesc^.MouseEventMap[nEvent].lpfnUserMouseProc)(thwnd, pGrDesc,  message , ptMouse );
   end;
   end;
END;

procedure  WRProcessMouseEvent( thwnd: HWND; message: UINT;  ptMouse: TPOINT);
VAR
  nEvent, nAction: INTEGER;
  pGrDesc: PGRAPH_DEF;                // pointer to graph descriptor
 BEGIN
   nEvent := 0;
   nAction :=0;
   pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));

   if (pGrDesc <> Nil) THEN
   begin
   InitDll (@_TopDesc);
   // If All mouse message are to be trapped, call user proc
   if (pGrDesc^.MouseEventMap[7].nMouseAction = OBJ_USERPROC_EVENT) then
   begin
     nAction := pGrDesc^.MouseEventMap[7].nMouseAction;
     WRProcessMouseEventAction(thwnd, 7, nAction, message, ptMouse);
   end
   else // if a specific mouse message is to be trapped
   begin
     case message of
     WM_LBUTTONDOWN: nEvent:=0;
     WM_LBUTTONUP: nEvent := 1;
     WM_RBUTTONDOWN: nEvent:=2;
     WM_RBUTTONUP: nEvent := 3;
     WM_LBUTTONDBLCLK:nEvent:=4;
     WM_RBUTTONDBLCLK: nEvent:=5;
     WM_MOUSEMOVE:  nEvent:=6;
     end;
     nAction := pGrDesc^.MouseEventMap[nEvent].nMouseAction;
     WRProcessMouseEventAction(thwnd, nEvent, nAction, message, ptMouse);
   end;
   end;
end;



{************************************************************************
   Default object editing is done in DefEditObject. You can switch to
   your own editing functions for any object type here.
***********************************************************************}

procedure rtEditObject (pGrDesc: PGRAPH_DEF);
var
    hObj: THANDLE;          {  handle to selected object}
    nObjType: INTEGER;      {  object type}
    p1: UINT;
    p2: INTEGER;
begin
  hObj := WGGetSelObject (pGrDesc, p1, p2);
  {  handle to selected object}
  nObjType := WGGetObjectType (pGrDesc, hObj);
  {  determine object type}
  {
  CASE (nObjType) OF
      To intercept, for example, editing of legends with your own routine called
      UserEditLegends, enter the following:

      GO_LEGEND: UserEditLegends (pGrDesc, hObj);
      END
      ELSE
  }
  rtDefEditObject (pGrDesc);

end;

