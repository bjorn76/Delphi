{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   QCWINIT.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}


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

{ **************************************************************************

  If a slot is available (which it always should be), create a page
  descriptor and save a global memory handle for the page in _TopDesc.
  Page handle is the sequential number of the chart in _TopDesc.hPgMem.
/
************************************************************************** }
function WGCreatePage (lpName:PChar; { page ASCII identifier}
               hwParent:HWND; { handle to parent, required only if    }
                               { PAGE_CLIENT style is used    }
               thInst:THandle; { module instance, required only the first time }
	           lpTitle:PChar; { page window caption       }
{$ifndef DMF}
               lpfnPage:TFarProc; { processing function       }
{$else}
               lpfnPage: PQCBasePage;
{$endif}
	           lpMenu:PChar; 	       { menu name, can be NIL  }
               nColor, { backgrownd color code                 }
               nSizeMode:INTEGER; { MM_PROPORT or MM_FIXED    }
               dwWinStyle:LongInt; { window style             }
               nPosStyle, { position style - PAGE_CLIENT, PAGE_FULL, }
                                        { or PAGE_EXACT              }
               x, y, { if PAGE_EXACT, initial position       }
               cx, cy:INTEGER): PPAGE_DEF;

var
     ppd: PPAGE_DEF;
begin
  InitDll (@_TopDesc);
  if (not (_TopDesc.bInit)) then begin
    _DevDescPtr:= GetDevDesc;          {  must be not in DLL !}
    {  initialize callback functions' instances}

     _TopDesc.hwTop:= GetActiveWindow;
    _TopDesc.hInst:= thInst;
  //   _TopDesc.hClipRgn:= 3;


    _TopDesc.cLenReal:= sizeof (realtype);
    if (not (InitTop (@_TopDesc, @PageProc, @GraphProc,
        CS_HREDRAW or CS_VREDRAW or CS_DBLCLKS or CS_PARENTDC))) then begin
      {  terminate application}
      ExitApplication;
      WGCreatePage:= NULLP;
      exit;
    end;
  end;
  
  ppd:= InitPage (lpName, hwParent, lpTitle, lpMenu,
    nColor, nSizeMode, dwWinStyle, nPosStyle, x, y, cx, cy,
    lpfnPage);
  
  WGCreatePage:= ppd;
end;

{ ************************************************************************ }
{  Create empty graph window using coordinates relative to those of page}
{ ************************************************************************ }
function WGCreateGraph (pPageDesc:PPAGE_DEF; { pointer to parent page }
{$ifndef DMF}
                        lpfnGraph:TFarProc; { processing function }
{$else}
                        lpfnGraph: PQCBaseGraph; { processing function }
{$endif}
			rX1, { relative coordinates }
			rY1, { 0, 0 - left upper corner }
			rX2, { of the page, 1,1 - right bottom }
			rY2:Realtype;
			nColor, { backgrownd color }
                        nBorderColor, { if < 0, no border }
                        nBorderWidth:INTEGER): PGRAPH_DEF;

begin

  WGCreateGraph:= InitGraph (@_TopDesc, pPageDesc, rX1, rY1, rX2, rY2,
    nColor, nBorderColor, nBorderWidth, lpfnGraph);

end;

{ ************************************************************************ }

procedure  WGEditObject (thwnd:HWND);
var
  pGrDesc: PGRAPH_DEF;                {  pointer to graph descriptor}
begin
  pGrDesc:= PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));
  HighlightObj (pGrDesc);
  {  disable graph and page windows while dialog box is active}
  EnableWindow (pGrDesc^.thwnd, FALSE);{  disable windows}
  EnableWindow (pGrDesc^.pPageDesc^.thwnd, FALSE);
  InitDLL (@_TopDesc);
  EditObject (pGrDesc);
  EnableWindow (pGrDesc^.thwnd, TRUE); {  reenable windows}
  EnableWindow (pGrDesc^.pPageDesc^.thwnd, TRUE);
end;



procedure WGOKMsgBox (pCaption:PCHAR; textstr:PCHAR; num:realtype; decs:INTEGER);
var
    szBuffer: PCHAR;
    numstr: PCHAR;
begin
  {    str(num:1:decs,numstr); }
  numstr:= '0';
  szBuffer:= textstr;

  MessageBox (0, szBuffer, pCaption, MB_OK or MB_TASKMODAL);
end;

{****************************************************************************}


{ *************************************************************************

 Processes chart page window messages before giving control to
              user procedure in HOOK.pas

************************************************************************* }


function PageProc (thwnd:HWnd; message:UINT; wParam:UINT;
                 lParam:LongInt): LongInt;

var
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
begin
  case (message) of
    WM_CREATE: begin
      pcs:= PCREATESTRUCT (lParam);
      InitDll (@_TopDesc);
      pPageDesc:= PPAGE_DEF (pcs^.lpCreateParams);
      pPageDesc^.thwnd:= thwnd;
    end;

    WM_COMMAND: begin
      id:= wParam;
      cmd:= hiword (lParam);

      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      pPageDesc:= PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if ((id >= IDM_SELECTORS) and
          (id <= IDM_SELECTORS + 16)) then begin
        if (cmd = BN_CLICKED) then begin
          pGrDesc:= GetGrDescPtr ((MAX_PAGES) +
            (pPageDesc^.hPage * MAX_GRAPHS) + id - IDM_SELECTORS);
          hDum:= pPageDesc^.hSelGraph;
          WGSelectGraph (pGrDesc);
          if (pPageDesc^.hSelGraph = hDum) then
            WGEditGraphDlg (pPageDesc);
        end;
        PageProc:= 0;
        Exit;
      end;
    end;

    WM_ERASEBKGND: begin
      PageProc:= 1;
      Exit;
    end;
    
    WM_PAINT: begin
      { paint page window }
      pPageDesc:= PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if (pPageDesc = nil) then begin
        PageProc:= 0;
        Exit;
      end;
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      thdc:= BeginPaint (thwnd, ps);
      if (pPageDesc^.fHigh) then
        HighlightGraph (pPageDesc, pPageDesc^.hSelGraph);
      if (pPageDesc^.lpfnPage <> NULLP) then begin
        if (not (pPageDesc^.fInitGraph)) then begin
          { call user routine creating graphs }
          pPageDesc^.fInitGraph:= TRUE;
{$ifndef DMF}
          ProcType1 (pPageDesc^.lpfnPage) (pPageDesc);
{$else}
          pmpntr := pPageDesc^.lpfnPage;
          pmpntr^.BuildPage(pPageDesc);
{$endif}

          if (pPageDesc^.fDispSel) then begin
            ShowGraphSelectors (pPageDesc, thdc, GS_ON);
            pPageDesc^.fPrevDispSel:= TRUE;
          end;
        end
        else

          if (pPageDesc^.fDispSel) then begin
            ShowGraphSelectors (pPageDesc, thdc, GS_MOVE);
          end;
        { this is the fastest way to fill a rectangle with color ! }

        GetClipBox (thdc, rc);
        SetBkMode (thdc, OPAQUE);
        SetBkColor (thdc, pPageDesc^.rgbBkColor);
        ExtTextOut (thdc, 0, 0, ETO_OPAQUE, @rc, nil, 0, nil);
        
        if (pPageDesc^.fHigh) then
          HighlightGraph (pPageDesc, pPageDesc^.hSelGraph);

        EndPaint (thwnd, ps);
        PageProc:= 0;
        Exit;
      end;
    end;
    WM_SIZE: begin
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      ResizePage (thwnd, LOWORD (lParam), HIWORD (lParam));
    end;

    WM_DESTROY: begin
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      pPageDesc:= PPAGE_DEF (GetWindowLong (thwnd, GWL_DESC));
      if (pPageDesc <> nil) then
        KillGraphPage (pPageDesc^.hPage);
    end;
  end;
  { the rest is processed by the user written procedure }
  PageProc:= WGUserPageProc (thwnd, message, wParam, lParam);
end;

{*************************************************************************

	FUNCTION: GraphProc (HWND, UINT, WPARAM, LPARAM)
	PURPOSE:  Processes graph child windows messages

*************************************************************************}

function GraphProc (thwnd:HWnd; message:UINT; wParam: UINT;
				   lParam:LongInt): LongInt;
var
	thdc: HDC;
	ps: TPAINTSTRUCT;
	pGrDesc: PGRAPH_DEF;                { pointer to graph descriptor }
	pPageDesc: PPAGE_DEF;
        pmgpntr: PQCBaseGraph;
begin
  case (message) of
    WM_MOUSEMOVE ,                     { mouse events }
      WM_RBUTTONDOWN ,
      WM_RBUTTONDBLCLK,
      WM_LBUTTONDOWN ,
      WM_LBUTTONDBLCLK,
      WM_LBUTTONUP,
      WM_RBUTTONUP,
      WM_MBUTTONDOWN,
      WM_MBUTTONUP,
      WM_MBUTTONDBLCLK: begin
             _DevDescPtr^.ptMouse.x := LOWORD (lParam);
             _DevDescPtr^.ptMouse.y := HIWORD (lParam);
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      WGGraphMouseEvent (thwnd, message, _DevDescPtr^.ptMouse);
      GraphProc:= 0;
      exit;
    end;

    WM_CHAR,                           { key messages }
      WM_KEYUP,
      WM_KEYDOWN: begin
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}
      WGGraphKeyEvent (thwnd, message, wParam, lParam);
      GraphProc:= 0;
      exit;
    end;

    WM_ERASEBKGND: begin
      GraphProc:= 1; exit;
    end;

    WM_PAINT: begin
      {$ifndef WIN32}
      InitDll (@_TopDesc);
      {$endif}

      pGrDesc:= PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));

      if (pGrDesc <> nil) then begin
        thdc:= BeginPaint (thwnd, ps);
        pPageDesc:= pGrDesc^.pPageDesc;
        if (not (pPageDesc^.fBlow) or (pPageDesc^.hSelGraph =
            pGrDesc^.thGraph)) then begin
          pGrDesc^.hdcPrint:= 0;
          pGrDesc^.nObjCounter:= 0;

          if (pGrDesc^.lpfnGraph <> NULLP) then begin
            if (not (pGrDesc^.fInit)) then begin
              pGrDesc^.fInit:= TRUE;
{$ifndef DMF}
              ProcType2 (pGrDesc^.lpfnGraph) (pGrDesc, thdc);
{$else}
              pmgpntr := pGrDesc^.lpfnGraph;
              pmgpntr^.BuildGraph(pGrDesc, thdc);
{$endif}
              { call user routine }

              { it is possible that user routine contained a message box which
              released control after the graph has been destroyed. So, verify }
              pPageDesc:= PPAGE_DEF (GetWindowLong (thwnd, GWL_PARENTDESC));
              if (pPageDesc = NULLP) then begin
                {                  ErrHdlr (ERR_BAD_GRAPH_HANDLE, ERP_NONE, nil); }
                GraphProc:= 0;
                exit;
              end;
              pGrDesc^.nObjCounter:= 0;
              pGrDesc^.fFirstTime:= FALSE;
              ConnectAxes (pGrDesc);
            end;
          end;
          if (not (pGrDesc^.fFirstTime)) then begin
            if (_TopDesc.bTerm) then
              ExitApplication
            else begin
              ObjectInterpreter (pGrDesc, thdc);
              pGrDesc^.cRepaint:= 1;
              if (_TopDesc.bTerm) then begin
                CleanGDI (thdc);
                ExitApplication;
              end;
            end;
          end;
        end;
        { restore system brush and pen, delete used ones }
        CleanGDI (thdc);
        {check      pGrDesc^.cRepaint := 1; } { enable background repaint }
        EndPaint (thwnd, ps);

      end;
      GraphProc:= 0;
      exit;
    end;
  end;
  GraphProc:= DefWindowProc (thwnd, message, wParam, lParam);
end;

{ ************************************************************************ }
{  Cleanup function - must be called befor application exits ************* }
{ ************************************************************************ }
procedure WGCleanup (bFreeData:BOOL);
begin
  Cleanup (@_TopDesc, bFreeData);
end;
{ ************************************************************************ }
{  Startup function - should be called first IF any Charting Tools ******* }

{  function is used before the first page is created               ******* }
{ ************************************************************************ }
procedure WGStart;
begin
  InitDll (@_TopDesc);
end;

{ ************************************************************************ }
{* This function creates page that is not displayed on the screen.*********}
{* It can be printed or converted to metafile.*****************************}
{**************************************************************************}
function WGCreateInvisiblePage (lpName:PChar; { page ASCII identifier}
               thInst:THandle; { module instance }
               lpfnPage:TFarProc; { processing function }
               nColor:INTEGER) :  PPAGE_DEF;

var
    wc: TWNDCLASS;
    thwndInv: HWND;
    i , cx, cy: INTEGER;
    pGrDesc   : PGRAPH_DEF;

begin
  wc.style:= 0;
  wc.lpfnWndProc:= @DefWindowProc;
  wc.cbClsExtra:= 0;
  wc.cbWndExtra:= 0;
  wc.hInstance:= thInst;
  wc.hIcon:= NULLH;
  wc.hCursor:= NULLH;
  wc.hbrBackground:= NULLH;
  wc.lpszMenuName:= NULLP;
  wc.lpszClassName:= 'Invisible';
  
  RegisterClass (wc);
  
  {* create invisible window *}

  cx:= GetSystemMetrics (SM_CXSCREEN);
  cy:= GetSystemMetrics (SM_CYSCREEN);

  thwndInv:= CreateWindow ('Invisible', NULLS, WS_POPUP, 
    0, 0,
    cx, cy, 
    0, 0, thInst, NULLP);

  WGCreateInvisiblePage:= WGCreatePage (lpName,
    thwndInv,                          { handle to invisible parent window }
    thInst,                            { application instance handle }
    NULLP,
    lpfnPage,
    NULLP, 
    nColor,                            { page window background color }
    MM_PROPORT,
    WS_CHILD,
    PAGE_CLIENT,
    0, 0, 0, 0);
end;


procedure WGProcessMouseEventAction(thwnd: HWND; nEvent, nAction: INTEGER;
                   message: UINT;  ptMouse: TPOINT);
VAR
    pGrDesc: PGRAPH_DEF  ;                // pointer to graph descriptor
BEGIN
    pGrDesc := PGRAPH_DEF (GetWindowLong (thwnd, GWL_DESC));
    if (pGrDesc <> Nil) then
    begin
    case nAction of
   OBJ_FIND_EVENT: ObjFind (thwnd);
   OBJ_EDIT_EVENT: WGEditObject (thwnd);
   OBJ_MOVE_EVENT: WGStartObjMove (thwnd, 0, 0, message, 0, TRUE);
   OBJ_ZOOM_EVENT: WGStartZoom (thwnd, 0, 0, message, TRUE);
   OBJ_USERZOOM_EVENT: WGStartZoom (thwnd, 0, 0, message, FALSE);
   OBJ_USERPROC_EVENT: if (  pGrDesc^.MouseEventMap[nEvent].lpfnUserMouseProc <> Nil) then
	MouseProc1 (pGrDesc^.MouseEventMap[nEvent].lpfnUserMouseProc)(thwnd, pGrDesc,  message , ptMouse );
   end;
   end;
END;

procedure  WGProcessMouseEvent( thwnd: HWND; message: UINT;  ptMouse: TPOINT);
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
     WGProcessMouseEventAction(thwnd, 7, nAction, message, ptMouse);
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
     WGProcessMouseEventAction(thwnd, nEvent, nAction, message, ptMouse);
   end;
   end;
end;

{ ************************************************************************** }


{** POINTER FUNCTIONS **}
{ ************************************************************************* }
{ Add number to pointer }

FUNCTION WGPntrAddNum (p : Pointer; n, len: INTEGER): POINTER;

VAR
    Offset : LONGINT;
    pr: POINTER;

BEGIN
{$ifndef WIN32}
    Offset := LONGINT (len) * LONGINT (n) + LONGINT (Long (P).Lo);
    pr := Ptr (Long(p).Hi + Long (Offset).Hi * SelectorInc,
                   Long (Offset).Lo);
{$ELSE}
    Offset := LONGINT (len) * LONGINT (n);
    pr := POINTER(LONGINT(p) + Offset);
{$ENDIF}
    WGPntrAddNum := pr;
END;


{reads value from element pointed to by p+n}
function WGGetPntrReal (p: POINTER; n: UINT): REALTYPE;
var rpntr: ^REALTYPE;
begin
  WGGetPntrReal := REALTYPE (WGPntrAddNum (p, n, sizerealtype)^);
end;

{write value to element pointed to by p+n}
procedure WGPutPntrReal (p: POINTER; n: UINT; r: REALTYPE);
var rpntr: ^REALTYPE;
begin
  rpntr := WGPntrAddNum (p, n, sizerealtype);
  rpntr^ := r;
end;

{reads integer value from element pointed to by p+n}
function WGGetPntrInt (p: POINTER; n: UINT): INTEGER;
var ipntr: ^INTEGER;
begin
  WGGetPntrInt := INTEGER (WGPntrAddNum (p, n, sizeinteger)^);
end;

{write integer value to element pointed to by p+n}
procedure WGPutPntrInt (p: POINTER; n: UINT; i: INTEGER);
var ipntr: ^INTEGER;
begin
  ipntr := WGPntrAddNum (p, n, sizeinteger);
  ipntr^ := i;
end;

{reads byte value from element pointed to by p+n}
function WGGetPntrByte (p: POINTER; n: UINT): BYTE;
var ipntr: ^BYTE;
begin
  WGGetPntrByte := BYTE (WGPntrAddNum (p, n, 1)^);
end;

{write byte value to element pointed to by p+n}
procedure WGPutPntrByte (p: POINTER; n: UINT; value: BYTE);
var ipntr: ^BYTE;
begin
  ipntr := WGPntrAddNum (p, n, 1);
  ipntr^ := value;
end;

