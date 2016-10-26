/************************************************************************/
/*                                                                      */
/*     Copyright (C) QUINN-CURTIS, 1992 - 1998                          */
/*                                                                      */
/************************************************************************/
/**                                                                     */
/**   Filename :   dialogs.h                                            */
/**   Author   :   QC                                                     */
/**   Revision :   3.0                                                    */
/**   Date     :   August 15, 1998                                        */
/**                                                                     */
/**   Description:    Prototypes for dialog box routines                */
/**                                                                     */
/**                                                                     */
/************************************************************************/

#ifdef __cplusplus
extern  "C" {
#endif

BOOL CALLBACK _export PrintAbortProc (HDC hdcPrn, int nCode);
BOOL CALLBACK _export PrintStopDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);
BOOL CALLBACK _export AxisDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL CALLBACK _export PlotDlgProc (HWND hDlg, UINT message, WPARAM wParam,
	LPARAM lParam);
BOOL CALLBACK _export BarDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL CALLBACK _export LabelsDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL CALLBACK _export LegendDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL CALLBACK _export PieChartDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export PieSliceDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export TextDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL CALLBACK _export HighLowCloseDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);
BOOL CALLBACK _export StockOpenHighLowCloseDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export WGLineParDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

// UPGRADE56 [DMB]
BOOL CALLBACK _export RGBColorDlgProc (HWND hDlg, UINT message,
	WPARAM wParam,	LPARAM lParam);

// UPGRADE7 [DMB]
BOOL CALLBACK _export LegMarkerDlgProc (HWND hDlg, UINT message,
	WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export LegRGBColorDlgProc (HWND hDlg, UINT message,
	WPARAM wParam,	LPARAM lParam);

BOOL CALLBACK _export TextRGBColorDlgProc (HWND hDlg, UINT message,
	WPARAM wParam,	LPARAM lParam);

// UPGRADE8 [DMB]
BOOL CALLBACK _export WGFileOpenDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

// UPGRADE17 [DMB]
BOOL CALLBACK _export MultiTextDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                 LPARAM lParam);

BOOL CALLBACK _export GraphParamDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export PrintParamDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export FormatDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export ArrowDlgProc (HWND hDlg, UINT message,
        WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export SaveDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);

BOOL CALLBACK _export CreateDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);



// New Rev 3.0

BOOL CALLBACK _export ContourDlgProc (HWND hDlg, UINT message, WPARAM wParam,
                                                   LPARAM lParam);
BOOL WINAPI _export MultiXYGraphDlgProc (HWND hDlg, UINT message,
		  WPARAM wParam, LPARAM lParam);



// UPGRADE-51198 [LAB] ----------V
BOOL CALLBACK _export WGMarkerDlgProc (HWND hDlg, UINT message,
	WPARAM wParam, LPARAM lParam);
BOOL CALLBACK _export BoxWhiskerDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);
// UPGRADE-51198 [LAB] ----------^
// UPGRADE-52098 [LAB] ----------V
BOOL CALLBACK _export CandlestickDlgProc (HWND hDlg, UINT message,
    WPARAM wParam, LPARAM lParam);
// UPGRADE-52098 [LAB] ----------^

#ifdef __cplusplus
}
#endif
/**************************************************************************/
