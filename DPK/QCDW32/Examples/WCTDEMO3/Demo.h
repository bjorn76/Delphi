#define BNUM       8              // total number of buttons 
#define BYSTART    0.3
#define BXSTART    0.07
#define BBXSTART   0.87
#define BBYSTART   0.86

#define FSTEP 1.55
#define  PI    3.141592

#define NUMP1   90                  // number of data points
#define NUMP2   30
#define NUMP10  10
#define NUMP20  20
#define NUMP4   11                // number of pie slices

#define NUMP61   21                // number of data points for graph 1
#define NUMP62   21                // number of data points for graph 2
#define NUMGROUP6 5                // number of groups

#define NUMP7     2  
#define NUMGROUP7 3  

#define NUMP8	  12
#define NUMP9 64					// number of data points for waterfall
#define NUMGROUP9 32				// number of data groups for waterfall

#define NUMPFFT    1024L         // number of points for FFT - long constant
#define MAXTIME    100.0         // total time in milliseconds

#define NUMP101 4 
#define NUMG10  2 
#define NUMP11  200              // number of data points
#define NUMP12  100              // number of data points

#define NUMPZOOM 80

#define ID_AUTO    ID_USER
#define ID_PLOTS   ID_USER + 1
#define ID_DIALOGS ID_USER + 2
#define ID_INTER   ID_USER + 3
#define ID_ZOOM    ID_USER + 4
#define ID_DS      ID_USER + 5
#define ID_ORDER   ID_USER + 6
#define ID_EXIT    ID_USER + 7

#define ID_RETURN  ID_USER + BNUM + 1
#define ID_NEXT    ID_USER + BNUM + 2
#define ID_PREV    ID_USER + BNUM + 3
#define ID_PAUSE   ID_USER + BNUM + 4

#define NUMPLOTS   11

#define PLOT1      0
#define PLOT2      1
#define PLOT3      2
 
#define ID_TIMERSTART   1
#define ID_TIMERGO      2
#define ID_TIMERDIAL    3
#define ID_TIMERDIALB   4
#define ID_TIMERDYN     5

#define STARTPER    64000  
#define PERIOD       9000  
//#define PERIOD       3000  
#define DIALPER      6500  
#define DIALPERB     2500  
#define DYNPER       1000  

#define STYLE_CHART WS_VISIBLE | WS_CAPTION | WS_POPUP 

void CALLBACK DrawPIntG1 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPIntG2 (PGRAPH_DEF pGrDesc, HDC hdc);
void CALLBACK DrawPIntG3 (PGRAPH_DEF pGrDesc, HDC hdc);

/**********************************************************************/
int CALLBACK StartWCTDll (HINSTANCE	hInstance);
void InitData (void);
PPAGE_DEF Plots (HWND hwnd);
void CALLBACK TimerRoutine (HWND hwnd, UINT wTimer);
void NextDialog (HWND hwnd, BOOL bKill);
void DynUpdate (void);
/**********************************************************************/
void UpdateZoomView (realtype rLeft, realtype rTop, realtype rRight, 
	realtype rBottom);
void UpdateDataCursorPosition (void);
void RemoveDataCursors (void);
/**********************************************************************/
int FAR PASCAL EndDemo1 (void);

