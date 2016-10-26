/******************************************************************/
/*                                                                */
/*   Filename :   WX.H                                            */
/**   Author   :   QC                                             */
/**   Revision :   3.0                                            */
/**   Date     :   August 15, 1998                                */
/*                                                                */
/******************************************************************/

#ifndef GET_WM_HSCROLL_POS
#if !defined(WIN32)
#define GET_WM_COMMAND_ID(wp, lp)             (wp)
#define GET_WM_COMMAND_HWND(wp, lp)           (HWND)LOWORD(lp)
#define GET_WM_COMMAND_CMD(wp, lp)            HIWORD(lp)
#define GET_WM_VSCROLL_CODE(wp, lp)           (wp)
#define GET_WM_VSCROLL_POS(wp, lp)            LOWORD(lp)
#define GET_WM_VSCROLL_HWND(wp, lp)           (HWND)HIWORD(lp)
#define GET_WM_HSCROLL_HWND(wp, lp)           (HWND)HIWORD(lp)
#define GET_WM_HSCROLL_CODE(wp, lp)           (wp)
#define GET_WM_HSCROLL_POS(wp, lp)            LOWORD(lp)

#define GET_WM_CTLCOLOR_HDC(wp, lp, msg)      (HDC)(wp)
#define GET_WM_CTLCOLOR_HWND(wp, lp, msg)     (HWND)LOWORD(lp)

#else       // 32-Bit

#define GET_WM_COMMAND_ID(wp, lp)             LOWORD(wp)
#define GET_WM_COMMAND_HWND(wp, lp)           (HWND)(lp)
#define GET_WM_COMMAND_CMD(wp, lp)            HIWORD(wp)
#define GET_WM_VSCROLL_CODE(wp, lp)           LOWORD(wp)
#define GET_WM_VSCROLL_POS(wp, lp)            HIWORD(wp)
#define GET_WM_VSCROLL_HWND(wp, lp)           (HWND)(lp)
#define GET_WM_HSCROLL_HWND(wp, lp)           (HWND)(lp)
#define GET_WM_HSCROLL_CODE(wp, lp)           LOWORD(wp)
#define GET_WM_HSCROLL_POS(wp, lp)            HIWORD(wp)

#endif
#endif





