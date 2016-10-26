/*************************************************************************/
/*                                                                       */
/*     Copyright (c) QUINN-CURTIS, Inc., 1992 - 1998                     */
/*                                                                       */
/*************************************************************************/
/**                                                                      */
/**   Filename :   qcwin.h                                               */
/**   Author   :   QC                                                     */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                         */
/**                                                                      */
/**   Product  :   Charting Tools for Windows                            */
/**                                                                      */
/**   Description: QC Windows Charting Tools Definitions and             */
/**                Function Prototypes                                   */
/**                                                                      */
/**   Revisions:   1.3. Definitions added for Real-Time Tools            */
/**                1.5 7/13/94 - Support of Real-Time Tools              */
/**                2.0 12/28/94 - 32-bit support                         */
/**                                                                      */
/*************************************************************************/

#ifndef  _QCWINH
#define  _QCWINH        1

#pragma pack(push, 8)

#ifdef RTFL                /* first define RTFL if you need realtype=float */
#define realtype float                 /* can be double or float */
#else
#define realtype double                /* can be double or float */
#endif

#ifdef __cplusplus
extern  "C" {

#define QC_MEMBER   1   /* This definition enables using class member functions
                           for page and graph building. If you use C++ but
                           want this functions to be static, as in C,
                           delete this line !!! */
#endif
/**********************************************************************/
#ifdef __BORLANDC__
#pragma warn -par
    #ifdef __WIN32__
        #ifndef WIN32
            #define WIN32 __WIN32__
        #endif
    #endif
#else               // Microsoft
#define M_PI        3.14159265358979323846
#define M_2PI       6.28318530718 
#ifdef WIN32
#define _export
#endif
#endif              // end Microsoft

/****************************************************************************/
// Windows versions
#define WV_31     0
#define WV_32S    1
#define WV_NT     2
#define WV_95     3
/****************************************************************************/

typedef  long    HGRAPH;              /* graph handle  */
typedef  HANDLE   HCONT;               /* control object handle */

#ifndef  WIN32
typedef  HANDLE   HGOBJ;               /* graphical object handle  */
typedef  HANDLE   HDATA;               /* data set handle */
typedef  HGOBJ    FAR  *PHGOBJ;        /* pointer to object handle */
typedef  realtype huge *HPREAL;        /* huge pointer to realtype */
typedef  float    huge *HPFLOAT;       /* huge pointer to float */
typedef  float    far  *LPFLOAT;       /* far pointer to float  */
typedef  realtype far  *LPREAL;        /* pointer to realtype   */
//typedef  short    huge *HPSHORT;
//typedef  short    far  *LPSHORT;
typedef  int      far  *LPINT; 
typedef  int      huge *HPINT; 
//typedef  short    near *PSHORT;
typedef  POINT    huge *HPPOINT;       /* far pointer to realtype */
typedef  char     huge *HPSTR;
#else
typedef  int		HGOBJ;         /* graphical object handle  */
typedef  UINT     HDATA;               /* data set handle */
typedef  HGOBJ    *PHGOBJ;             /* pointer to object handle */
typedef  realtype *HPREAL;             /* pointer to realtype */
typedef  float    *HPFLOAT;            /* pointer to float */
typedef  float    *LPFLOAT;            /* pointer to float */
typedef  realtype *LPREAL;             /* pointer to realtype     */
//typedef  short    *HPSHORT;
//typedef  short    *LPSHORT;
typedef  int      *LPINT; 
typedef  int      *HPINT; 
//typedef  short    *PSHORT; 
typedef  POINT    *HPPOINT;       /* far pointer to realtype */
typedef  char     *HPSTR;
#define  _fmemcpy  memcpy

#ifndef hmemcpy
#define  hmemcpy   memcpy
#endif

#define	 _fmalloc  malloc
#define  _fmemset  memset
#define  _fstrcpy  strcpy
#define  _fstrncpy strncpy
#define  _ffree	   free

// Rev. 3.0 defines
#define  DEFAULT_MAX_POS_NUMBER  9.9999e19
#define  DEFAULT_MIN_NEG_NUMBER -9.9999e19
#define  DEFAULT_BADVALUE_NUMBER 1.0e20
#define  LOG_COORD_BADVALUE      32000L

#endif		// WIN32

#define  MAX_PAGES     60
#define  MAX_DATASETS  1800
#define  INIT_NUM_OBJS  20             /* initial number of objects per graph */
#define  MAXPATHLEN    164
#define  MAX_GRAPHS    16              /* max number of graphs per page */

/* ways of creating page window */

#define  PAGE_CLIENT   0               /* fill parent window client area */
#define  PAGE_FULL     1               /* fill the whole screen          */
#define  PAGE_EXACT    2               /* use passed coordinates         */

/* Page Window scaling types - fixed, proportionate, and isotropic */
#define  MM_FIXED     MM_ISOTROPIC
#define  MM_PROPORT   MM_ANISOTROPIC
#define  MM_ISOTR     9  
#define  MM_PROPORT_FT 10           // proportionate with fixed text size
#define  MM_ISOTR_FT 11             // isotropic with fixed text size

/* coordinate types */

#define CO_LOG  0
#define CO_PHYS 1
#define CO_NORM 2
#define CO_DEV  3

/* Point search constants */

#define FNP_X    0   // nearest x
#define FNP_Y    1   // nearest y
#define FNP_DIST 2   // shortest distance

#define FNP_NORMX    3   // nearest normalized x
#define FNP_NORMY    4   // nearest normalized y
#define FNP_NORMDIST 5   // shortest normalized distance


/* printing styles */

#define PRT_FULL    0       /* Pages and graphs are printed so that paper
                             is used maximally. Text is printed 
                             proportionately to other objects */
#define PRT_PROP    1       /* Pages are printed so that paper
                             is used maximally. Graphs are printed
                             proportionately to page size.
                             Text is printed proportionately to other objects */

#define PRT_EXACT   2   /* physical size, font size in points are preserved */


#ifndef X_AXIS
#define X_AXIS  0
#define Y_AXIS  1
#define Z_AXIS  2
#endif

/**************************************************************************/
/* Graphical objects */
/**************************************************************************/

#define    GO_PLOT   1              /* can be line, bars, scat, etc */
#define    GO_GROUP  2              /* can be stacked lines, bars   */
#define    GO_LEGEND 3
#define    GO_LINE   4              /* Straight line */
#define    GO_ARROW  5              /* Straight line with arrow */

#define    GO_LAST1  9
            
#define    GO_AX     10
#define    GO_LABELS 11  
#define    GO_TEXT   12
#define    GO_ARC    13
         
#define    GO_LAST2  19

/*************************************************************/

#define    GO_PIECHART 20
#define    GO_METAFILE 21
#define    GO_ELLIPSE 22            
#define    GO_BITMAP  23
#define    GO_POLYGON 24
#define    GO_RECT    25
#define    GO_PIE     26
#define    GO_DATACURSOR 27
#define    GO_PLOTSCALE 49      // dummy object for save/restore
#define    GOS_MAX     50   // max value of statical graphical object
#define    GO_USER    1000
#define    GO_SERIALXYDATASET        9997
#define    GO_SERIALDYNDATASET       9998
#define    GO_SERIALENDGRAPH    9999            
/* Line types - subtype field */

#define    LT_SOLID     2 // Added to support scroll bars in RT Legend
#define    LT_LINE      3
#define    LT_LINEMARK  4
#define    LT_SCAT      5 
#define    LT_VBAR      6
#define    LT_HBAR      7
#define    LT_3DVBAR    8
#define    LT_3DHBAR    9
#define    LT_LAST      LT_3DHBAR

/* types of group plots */

#define GT_GROUPBARS    0
#define GT_DEEPBARS     1
#define GT_STACKEDBARS  2
#define GT_FLOATBARS    3
#define GT_STACKEDLINES 5
#define GT_HILOCLOSE    6
#define GT_ERRORBARS    7

#define	GT_GROUPLINES	9			// UPGRADE3 
#define	GT_WATERFALL	10			// UPGRADE4	

#define GT_CONTOURLINE   20
#define GT_CONTOURFILL   21

#define GT_BOXWHISKER    11			//3.0 UPGRADE
#define GT_CANDLESTICK   12			//3.0 UPGRADE 
#define GT_STOCKOPENHILOCLOSE 13

/* data cursor types */

#define DC_VLINE    0   // vertical line
#define DC_HLINE    1   // horizontal line
#define DC_CROSS    2   // crosshair             
#define DC_BOX      3   // square

// Xcursor only
#define DC_HVLINE    4   // Hor and vert lines

#define DC_WVLINE    5   // Hor and vert lines
#define DC_WHLINE    6   // horizontal line
#define DC_WCROSS    7   // crosshair             
#define DC_WBOX      8   // square
#define DC_WHVLINE   9   // Hor and vert lines

/**************************************************************************/
/* Dynamic Graphical objects */
/**************************************************************************/

#define    GO_DYN   100         /* First dynamic object */

#define GOD_ALARMLINES GO_DYN      /* alarm lines */
#define GOD_ALARMMARKS GO_DYN + 1  /* alarm marks (for bar graphs) */
#define GOD_DYNGRID    GO_DYN + 2  /* grid lines  */
#define GOD_SCROLL     GO_DYN + 3  /* scroll, sweep, scrolling bars, etc. */
#define GOD_XYPLOT     GO_DYN + 4  /* dynamic xy plot      */
#define GOD_LABELS     GO_DYN + 5  /* dynamic labels       */
#define GOD_BARS       GO_DYN + 6  /* dynamic bars         */
#define GOD_TEXT       GO_DYN + 7  /* dynamic text */
#define GOD_MESSAGE    GO_DYN + 8  /* message text */
#define GOD_ANNUNC     GO_DYN + 9  /* annunciator panel - compound object */
#define GOD_METER      GO_DYN + 10 /* meter */
#define GOD_CHCONTROL  GO_DYN + 11 /* child control */
#define GOD_LEGEND     GO_DYN + 12 // used only for save/restore

#define GOD_SUBT_SCLINE 1         // scrolling line subtype 
#define GOD_SUBT_SCBAR  2         // scrolling bar  subtype 
#define GOD_SUBT_SWLINE 3         // sweep line subtype 
#define GOD_SUBT_LOGIC  4         // logic line subtype 


//#define GOD_SUBT_SCCOMBO 8

// #define SCROLLGRAPH_LINE 1


// subtypes for dyn graphs (bar and line

#define DYNGRAPH_BAR 3
#define DYNGRAPH_SCATTER 2
#define DYNGRAPH_LINE 1


#define GOD_SUBT_BAR    5         // bar graph subtype 
#define GOD_SUBT_ALMTEXT 6        // alarm text subtype 
#define GOD_SUBT_STACKED 7        // stacked line subtype 
#define GOD_SUBT_TIME   10        // time subtype (for axes and labels)
#define GOD_SUBT_DYNLEG 11        // dynamic legend subtype

#define GOD_SUBT_SCLINEVAR 12      // variable scrolling lines 

#define GOD_SUBT_COMBOSCROLL 13
#define GOD_SUBT_COMBOSWEEP  14
#define GOD_SUBT_COMBOXY     15
#define GOD_SUBT_COMBOVARSCROLL     16

#define OBJ_NO_EVENT	0
#define OBJ_FIND_EVENT 1
#define OBJ_EDIT_EVENT 2
#define OBJ_MOVE_EVENT 3
#define OBJ_ZOOM_EVENT 4
#define OBJ_USERZOOM_EVENT 5
#define OBJ_USERPROC_EVENT 6

#define WM_ALLMOUSEEVENTS 99999

#define ARROW_START 1
#define ARROW_END   2
#define ARROW_BOTH  3

#define MAX_ALMNAME 16
#define NALMLINES 5

/* data reduction types */

#define DC_SKIP    0
#define DC_AVERAGE 1
#define DC_MAX     2
#define DC_MIN     3

/* bitmap display modes */

#define BM_ORIG     0       
#define BM_STRETCH  1

// Bitmap copy area
#ifndef PW_WINDOW
#define PW_WINDOW        1
#define PW_CLIENT        2
#endif


/* COLOR CODES */

#define    C_RGB           -2      // for RGB colors
#define    C_TRANSPARENT   -1 
#define    C_BLACK          0
#define    C_BLUE           1
#define    C_GREEN          2
#define    C_CYAN           3
#define    C_RED            4
#define    C_MAGENTA        5
#define    C_BROWN          6
#define    C_LIGHTGRAY      7
#define    C_GRAY           8    
#define    C_LIGHTBLUE      9  
#define    C_LIGHTGREEN    10 
#define    C_LIGHTCYAN     11 
#define    C_LIGHTRED      12 
#define    C_LIGHTMAGENTA  13 
#define    C_YELLOW        14 
#define    C_WHITE         15

#define    C_PALEBLUE      16
#define    C_PALEGREEN     17
#define    C_MEDGRAY       18
#define    C_OFFWHITE      19

#define    NUMCOLS         20

/**************************************************************************/
/* Axis scaling types  */

#define    ST_LINEAR    0
#define    ST_LOG       1

/**************************************************************************/
/* Grid types  */

#define    GRID_MAJOR   0
#define    GRID_MINOR   1
#define    GRID_ALL     2

/**************************************************************************/
/* Tick mark, bar, etc. position definitions: */

#define  POS_BELOW     0
#define  POS_INSIDE    POS_BELOW  
#define  POS_LEFT      1
#define  POS_RIGHT     2
#define  POS_MIDDLE    3
#define  POS_ABOVE     4
#define  POS_OUTSIDE  POS_ABOVE  
#define  POS_INVISIBLE 5

#define  POS_BELOW_PLOT 6
#define  POS_ABOVE_PLOT 7
#define  POS_LEFT_PLOT  8
#define  POS_RIGHT_PLOT 9

#define  TEXT_NORMAL    0
#define  TEXT_VERTLEFT  900
#define  TEXT_VERTRIGHT 2700

#define  TEXT_BOLD       1           /* can be ORed with each other */
#define  TEXT_ITAL       2
#define  TEXT_UNDERLINE  4

/***********************************************************************/
/* last label indicators: */
/***********************************************************************/

#define  LL_ON   0
#define  LL_OFF  1
#define  LL_TEXT 2

#define  LABELLEN   42        /* maximal length of string label */
#define  LG_MAXLEN  LABELLEN  // maximal legend length
#define  MAX_MESLEN LABELLEN  // 42
#define  MAX_MESNUM 8         // number of messages

/***********************************************************************/
/* Pie Chart Constants */
/***********************************************************************/

#define PIE_NUM_NONE     0
#define PIE_NUM_PERC     1
#define PIE_NUM_VAL      2
#define PIE_NUM_BOTH     3

#define PIE_IN           0
#define PIE_OUT          1

#define PIE_2D          10
#define PIE_3D          11

/***********************************************************************/
/* Numbers formats:                                                    */

#define    NF_DECIMAL     0
#define    NF_SCIENTIFIC  1
#define    NF_ENG         2 
#define    NF_TIMEF       3
#define    NF_DATEF       4
#define    NF_EXP         5 
#define    NF_G           6 

#define  TM_HMS       1    // time format, hh:mm:ss. Prec ignored
#define  TM_HM        2    // time format, hh:mm
#define  TM_MS        4 

// Date Time bases
#define  DTB_DATE_MINUTE  1
#define  DTB_DATE_HOUR    2
#define  DTB_DATE_DAY     3
#define  DTB_DATE_WEEK    4 
#define  DTB_DATE_MONTH   5 
#define  DTB_DATE_YEAR    6

// Date Formats 
#define  DATE_STANDARD   1 //  Jan. 2, 1998
#define  DATE_MDY        2//  1/2/98, 1/2/02
#define  DATE_DMY        3 //  2/1/98, 2/1/02
#define  DATE_MY         4 // 1/98
#define  DATE_Y          5 // 98
#define  DATE_MDY2000    6 // 1/2/1998, 1/2/2002
#define  DATE_DMY2000    7// 2/1/1998, 2/1/2002
#define  DATE_MY2000     8 // 1/1998
#define  DATE_Y2000      9 // 1998

/************************************************************************/
/* Intercept flags for auto axes.  */

#define    INTF_ZERO   0       /* use 0 for intercepts              */
#define    INTF_MIN    1       /* minimal values for both axes      */
#define    INTF_MAX    2       /* maximal values for both axes      */
#define    INTF_MINMAX 3       /* min Y intercept for axis X, max for Y */
#define    INTF_MAXMIN 4       /* max for X, min for Y                  */

/************************************************************************/
/* Symbols (markers) types:                                             */

#define    MK_NONE        0
#define    MK_X           1
#define    MK_UPTRIANGLE   2
#define    MK_DOWNTRIANGLE 3 
#define    MK_BOX         4
#define    MK_PLUS        5
#define    MK_ASTERISK    6
#define    MK_DIAMOND     7
#define    MK_CIRCLE      8
#define    MK_DOT         9
#define    MK_BAR          10       // Added to support bars in RT combo plot
#define    MK_FILLEDLINE	11      // Added to support fille lines in RT combo plot

#define	   MK_BITMAP	  12		// 3.0 UPGRADE - for WGScatterPlotEx
#define	   MK_METAFILE	  13		// 3.0 UPGRADE - for WGScatterPlotEx

///ADDED FOR BOX & WHISKERS ONLY
#define    MK_LINE        14

/*********************************************************************/
/* Marker and bar styles */

#define    MKS_FILLED     0 
#define    MKS_EMPTY      1
#define    MKS_CDOT       2

#define    BAR_FULL    MKS_FILLED       
#define    BAR_HOLLOW  MKS_EMPTY      
#define    BAR_BORDER  MKS_CDOT       





/************************************************************************/
/* Autoscaling parameters: */

#define    AS_ROUNDCLOSE  1
#define    AS_ROUNDFAR    2
#define    AS_EXACT  3

/**********************************************************************/
/* DSP constants (windows types)                                      */
/**********************************************************************/

#define DSPWIN_RECTANG 0
#define DSPWIN_PARZEN  1
#define DSPWIN_HANNING 2
#define DSPWIN_WELCH   3
#define DSPWIN_HAMMING 4
#define DSPWIN_EXACTB  5

/***************************************************************************/
/* orientation constants */

#define OR_VERT   0
#define OR_HORZ   1

/***************************************************************************/
// raised rectangle constants

#define RC_FLAT     0      // regular
#define RC_HIGH     1       
#define RC_DEEP     2
#define RC_LOW      3
#define RC_SHALLOW  4
#define RC_3DBORDER 5

 
/***************************************************************************/
// Metafile types 

#define MF_WIN     0    // Old Windows metafile
#define MF_PL      1    // Placeable Aldus metafile
#define MF_ENH     2    // New enhanced Windows metafile

#define MAXMOUSEEVENTS 8 // Support WM_LBUTTONDOWN, WM_RBUTTONDOWN,
						 // WM_LBUTTONCLICK, WM_RBUTTONCLICK
						 // and WM_MOUSEMOVE events
  
/***************************************************************************/
/* placeable metafile header */  
#pragma pack(push,1)
typedef struct
{
        DWORD   key;
        WORD    hmf;
        short   left;
        short   top;
        short   right;
        short   bottom;
        WORD    inch;
        DWORD   reserved;
        WORD    checksum;
} EXT_MFHEADER;

#ifndef __BORLANDC__
#ifndef _TM_DEFINED
struct tm {
        int tm_sec;     /* seconds after the minute - [0,59] */
        int tm_min;     /* minutes after the hour - [0,59] */
        int tm_hour;    /* hours since midnight - [0,23] */
        int tm_mday;    /* day of the month - [1,31] */
        int tm_mon;     /* months since January - [0,11] */
        int tm_year;    /* years since 1900 */
        int tm_wday;    /* days since Sunday - [0,6] */
        int tm_yday;    /* days since January 1 - [0,365] */
        int tm_isdst;   /* daylight savings time flag */
        };
#define _TM_DEFINED
#endif
#else
#include "time.h"
#endif

/*************************************************************************/
typedef struct                   /* Metafile object */
{
    HGLOBAL      hMem;       /* memory handle for the OBJ_META descriptor */
    HMETAFILE    hmf;
    EXT_MFHEADER ExtHeader;
    BOOL         bEnh;       /* TRUE if new enhanced metafile */    
}
OBJ_META;

#pragma pack(pop)

/**************************************************************************/
typedef struct  
{
   LOGPEN  lp;               /* Windows pen descriptor  */
   int   nWidth;           /* line width in pixels    */
   long   nColor;           /* pure color code         */
   HWND    hwnd;             /* handle of the graph window */
}  LINEDESC;



typedef OBJ_META far *POBJ_META;

/***************************************************************************/
/* Page descriptor  (page can have multiple graphs) */

typedef struct
{
    HGRAPH  hPage;             // handle
    HWND    hwnd;              // chart page window handle
    void    (CALLBACK *lpfnPage) (LPVOID); // function initializing graphs
    HWND    hwParent;          // parent window handle
    int     cxVExt;            // Viewport extents
    int     cyVExt;      
    int     cxWExt;            // Window extents
    int     cyWExt;      
    DWORD   rgbBkColor;        // Chart page window background color
    int   nMapMode;          // ISOTROPIC or ANISOTROPIC
    int   nNumGraphs;        // Number of graphs on the page
    int   nGraphCount; 
    int   nSavMapMode;

    BOOL    fInitGraph;        // Initialization flag
    BOOL    fLoaded;
    BOOL    fDynamic;          // Set to TRUE if something is dynamic
    HGRAPH  hSelGraph;         // handle to selected graph
    HGRAPH  hPrevSelGraph;     // handle to previously selected graph
    BOOL    fDispSel;          // flag indicating selectors are displayed 
    BOOL    fPrevDispSel;      // previous state of the flag
    BOOL    fHigh;             // flag indicating selected graph is highlighted
    BOOL    reserved1;         // 
    BOOL    fBlow;             // flag indicating selected graph is blown up
    BOOL    fMeta;             // if not 0, output is to a metafile

    float   fSelxOrg;          // Save area for selected graph window extents
    float   fSelyOrg;          // and origin relative to page
    float   fSelxExt;         
    float   fSelyExt;

    float   rXOrigCoef;        // compression/expansion coefficients  
    float   rYOrigCoef;        // relative to original size 
    int     cxVExtOrig;        // Original Viewport extents
    int     cyVExtOrig;      

    int    nLTickSize;           // Large Tick Size in pixels
    int    nSTickSize;           // Small Tick Size in pixels

    char    szFileName[MAXPATHLEN]; // Save file or metafile name
    char    szName[16];        // ASCII internal name of the page
    BOOL    cMapIsotr;         // Isotropic resizable mapping mode flag 
    int    bFixedText;        // if != 0, text size does not change when graph is resized  
    long    wUserWord1;        // user can do anything with this field
    long    wUserWord2;        // user can do anything with this field
    LPVOID  lpTopDesc;         // pointer to TopDesc 

    HGLOBAL hGrMem [MAX_GRAPHS]; // array of memory handles to graphs
    HWND    hwndButton [MAX_GRAPHS];   // handles to selector buttons
    DWORD   dwSignature;
    int     nPosStyle;
} PAGE_DEF;

typedef PAGE_DEF far *PPAGE_DEF;

/**************************************************************************/
typedef struct                     // common header
{
   int   nType;                  // object type
   int   nSubType;               // object subtype 
   HGOBJ   (_cdecl FAR *lpfnObj) (LPVOID, HDC); // function drawing the object
   RECT    rcBoundary;             // object limits in device coordinates
   HGOBJ   hObj1;                   // handles of associated objects (axes) 
   HGOBJ   hObj2;
   LINEDESC ld;
   HGOBJ  (_cdecl FAR *lpfnDynObj) (LPVOID, LPVOID); // update func.
   DWORD   dwLastUpdate;           // seconds count for last update
   int    wUpdatePer;             // update period in seconds
//   char    reserved [12]; // Need to match DYNOBJ_HEAD structure
   BOOL    fInverse;
   BOOL    fShow;                  // if = 0, hide object 
   BOOL    bCompoundFlag;
   UINT     nUserID;
}
OBJ_HEAD;  
typedef OBJ_HEAD FAR *POBJ_HEAD;

/**************************************************************************/
typedef struct
{
       //  storage for current graph parameters
    LINEDESC ld;
    int    nXScaleType;       // ST_LINEAR or ST_LOG
    int    nYScaleType;
    realtype rxInt;             // intercepts
    realtype ryInt;

    realtype rxMin;             // scaling values
    realtype rxMax;
    realtype ryMin;
    realtype ryMax;

    realtype rxLMin;            // scaling values (logarithmic)
    realtype rxLMax;
    realtype ryLMin;
    realtype ryLMax;

}  CUR_PAR;

/**************************************************************************/
/* Graph descriptor */

#define MAXSAVEAXES 10
typedef struct
{
   int      nMouseAction;
   void    (CALLBACK *lpfnUserMouseProc) (HWND, LPVOID,  UINT , POINT ); 
} MOUSE_EVENT_DEF;

typedef MOUSE_EVENT_DEF *PMOUSE_EVENT_DEF;

typedef struct
{
   HGRAPH  hGraph;            // handle
   HWND    hwnd;              // graph window handle
   void    (CALLBACK *lpfnGraph) (LPVOID, HDC); // function drawing the graph
   POBJ_HEAD pCurrentObjDesc;  // pointer to currently processed object desc.
   COLORREF rgbWinBkColor;     // Chart window background color
   COLORREF rgbPlotBkColor;    // Plotting area background color
   BOOL    fFirstTime;
   BOOL    fInit;
   LINEDESC bd;               // border line descriptor 
   BOOL    fBorder;           // border flag
   HDC     hdcPrint;          // if not 0, output is to a printer  
   HDC     hdcMeta;           // if not 0, output is to a metafile
   int     nDynamic;          // Set to > 0 if something is dynamic
   RECT    rPlotCoord;        // logical coordinates of plotting area
   PPAGE_DEF pPageDesc;       // Page descriptor pointer
   int     xWOrg;             // Window extents and origin in logical coords
   int     yWOrg;
   int     cxWExt;         
   int     cyWExt;

   int     xVOrg;             // Window extents and origin in device coords
   int     yVOrg;
   int     cxVExt;         
   int     cyVExt;

   float   fxOrg;             // Window extents and origin relative to page
   float   fyOrg;
   float   fxExt;         
   float   fyExt;
   float   fxExtOrig;         
   float   fyExtOrig;

   float   rpX1;              // Plotting area coordinates relative
   float   rpY1;              // to graph window
   float   rpX2;         
   float   rpY2;

   CUR_PAR cp;               // current parameters

   int   nMapMode;          //
   int     cxLogPixel;        // width  of 1 pixel in logical units
   int     cyLogPixel;        // height of 1 pixel in logical units
   int   nObjCounter;
   HGOBJ   hSelObj;           // selected object handle
   HGOBJ   hAxisX;
   HGOBJ   hAxisY;
   HDC     hdc;               // own hdc (real time only)
   int   nNumObjs;          // number of objects in the graph
   LPVOID  pGCO;              // pointer to Graph Class Object (MFC only)
   DWORD   dwSignature;
   BOOL    cIgnorePlot;
   char    cRaised;           // 0 - flat, 1 - raised, 2 - low  
//   char    reserved;
   char    cRepaint;          // if != 0 repaint graph background  
   WORD    wUserWord1;        // user can do anything with this field
   WORD    wUserWord2;        // user can do anything with this field
   HGLOBAL hObjDup;          // memory handle for an object copy, for editing
   HGLOBAL hObjArr;
   HGLOBAL FAR *pObjArr;          // pointer to array of object memory handles
   BOOL		bAddGrObj;
   BOOL    bBitBltMode;
   HBITMAP hGrBitmap;
   HDC hGrBitmapDC;
//   int      MouseEventMap[MAXMOUSEEVENTS];
//   void    (CALLBACK *lpfnUserMouseProc) (WND, PGRAPH_DEF,  UINT , POINT ); 
   MOUSE_EVENT_DEF MouseEventMap[MAXMOUSEEVENTS];
   HGLOBAL   hSaveAxisX[MAXSAVEAXES]; // User to restore axes to default values
   HGLOBAL   hSaveAxisY[MAXSAVEAXES];
    int    nLTickSize;           // Large Tick Size in pixels
    int    nSTickSize;           // Small Tick Size in pixels

} GRAPH_DEF;
typedef GRAPH_DEF  *PGRAPH_DEF;


/**************************************************************************/
/* Dynamic data definitions ***********************************************/
/**************************************************************************/
#define DYN_MAXVAL 32      // maximal number of dynamic elements per object
#define DYNTITLELEN 64          // DATA SET TITLE length
#define DYNUNITSLEN 16          // length of eng. units string
#define MAX_DYNSETS 200         // max. number of dynamic data sets
#define MAX_ALMESLEN  32
#define TAGLEN        32        // channel tag length
#define MAX_ALM 7   // max. number of alarm types

/* Every dynamic object can have up to DYN_MAXVAL individual elements */



// NEW PARAMETER CONSTANTS or REV 3.0
#define PARAM_START_NUM 100
#define PARAM_BW_OUTLIERCOEF	PARAM_START_NUM + 300
#define PARAM_BW_MIDPOINTYPE	PARAM_START_NUM + 301
#define PARAM_BW_BOXCOEF		PARAM_START_NUM + 302
#define PARAM_BW_BOXCONST		PARAM_START_NUM + 303
#define PARAM_BW_BOXMIN			PARAM_START_NUM + 304
#define PARAM_BW_BOXMAX			PARAM_START_NUM + 305
#define PARAM_BW_OUTLIERSYMBOL	PARAM_START_NUM + 306
#define PARAM_BW_OUTLIERFLAG	PARAM_START_NUM + 307
#define PARAM_BW_EXTREMESYMBOL	PARAM_START_NUM + 308
#define PARAM_BW_EXTREMEFLAG	PARAM_START_NUM + 309
#define PARAM_BW_MIDPOINTSYMBOL	PARAM_START_NUM + 310
#define PARAM_BW_WHISKERTYPE	PARAM_START_NUM + 312
#define PARAM_BW_WHISKERSIZE	PARAM_START_NUM + 313
#define PARAM_BW_WHISKERCOEF	PARAM_START_NUM + 314
#define PARAM_BW_WHISKERMIN		PARAM_START_NUM + 315
#define PARAM_BW_WHISKERMAX		PARAM_START_NUM + 316

#define PARAM_CONTOUR_VALUE				PARAM_START_NUM + 330
#define PARAM_CONTOUR_COLOR				PARAM_START_NUM + 331
#define PARAM_CONTOUR_LINESTYLE			PARAM_START_NUM + 332
#define PARAM_CONTOUR_LINEWIDTH			PARAM_START_NUM + 333
#define PARAM_CONTOUR_NUMCONTOURS		PARAM_START_NUM + 334
#define PARAM_CONTOUR_BITMAPGRANULARITY	PARAM_START_NUM + 335
#define PARAM_CONTOUR_LINEFLAGS			PARAM_START_NUM + 336
#define PARAM_CONTOUR_LABELFLAGS		PARAM_START_NUM + 337
#define PARAM_CONTOUR_LABELXJUST		PARAM_START_NUM + 338
#define PARAM_CONTOUR_LABELYJUST		PARAM_START_NUM + 339
#define PARAM_CONTOUR_LABELCOLOR		PARAM_START_NUM + 340
#define PARAM_CONTOUR_LABELPREC			PARAM_START_NUM + 341
#define PARAM_CONTOUR_GRAPHTYPE			PARAM_START_NUM + 342

#define PARAM_WATERFALL_XOFFSET		    PARAM_START_NUM + 350
#define PARAM_WATERFALL_YOFFSET		    PARAM_START_NUM + 351
#define PARAM_WATERFALL_FILL		    PARAM_START_NUM + 352
#define PARAM_WATERFALL_BASELINE		PARAM_START_NUM + 353
#define PARAM_WATERFALL_OUTLINE		    PARAM_START_NUM + 354
#define PARAM_WATERFALL_LINESTYLE		PARAM_START_NUM + 355
#define PARAM_WATERFALL_LINEWIDTH		PARAM_START_NUM + 356
#define PARAM_WATERFALL_LINECOLOR		PARAM_START_NUM + 357


/**************************************************************************/

typedef struct                       // dynamic element descriptor
{
	float rAlVal;                // alarm value
    char  szAlarmName [MAX_ALMESLEN]; // alarm name
}
ALARM_DEF;

/**************************************************************************/
typedef struct                  // dynamic data set descriptor
{
    int    cNumChannels;            // from 1 up to 32
    int    cUseCounter;
    char    szTitle [DYNTITLELEN]; // unique title of the data set  2
	LPVOID  lpDDEDesc;             // pointer to DDE descriptor, or NULL 44
				  
    float   rNewVal [DYN_MAXVAL]; // values                             48
    float   rPrevVal[DYN_MAXVAL];
    HGLOBAL hRealData;            // memory handle for historical data array
    HPFLOAT hpRealData;           // huge pointer to historical data array  
    UINT    wRealTo;              // index to the next value
    BOOL    bHistFull;            // TRUE after data array is first filled  
    int     nHistSize;            // number of samples in history buffer (real values)
    char    szUnits [DYNUNITSLEN]; // engineering units
    BOOL    cAlmMask;
    int     nXY;                   // set to 1 if data used by XY plot 
	// Current Alarm States
    ALARM_DEF almHigh;             // alarm descriptors
    ALARM_DEF almLow;
    ALARM_DEF almHH;
    ALARM_DEF almLL;
    ALARM_DEF almRate;             // rate of change value, per second
    ALARM_DEF almDev;              // deviation (setp - meas)
    ALARM_DEF almFail;             // fail (DDE) 
    realtype  rSetp;
    realtype  rHyst;               // high and low alarm hysteresis
    realtype  rDevHyst;            // deviation alarm hysteresis
    char szNormName [MAX_ALMNAME]; // normal state name

    // Channel Alarm States
    ALARM_DEF almHighCh[DYN_MAXVAL];             // alarm descriptors
    ALARM_DEF almLowCh[DYN_MAXVAL];
    ALARM_DEF almHHCh[DYN_MAXVAL];
    ALARM_DEF almLLCh[DYN_MAXVAL];
    ALARM_DEF almRateCh[DYN_MAXVAL];             // rate of change value, per second
    ALARM_DEF almDevCh[DYN_MAXVAL];              // deviation (setp - meas)
    ALARM_DEF almFailCh[DYN_MAXVAL];             // fail (DDE) 
    realtype  rSetpCh[DYN_MAXVAL];
    realtype  rHystCh[DYN_MAXVAL];               // high and low alarm hysteresis
    realtype  rDevHystCh[DYN_MAXVAL];            // deviation alarm hysteresis
    BOOL      bAlmSetCh[DYN_MAXVAL]; 
    BOOL      bAlmEnableCh[DYN_MAXVAL]; 
	BOOL      bCheckChAlarms;

	char szNormNameCh[DYN_MAXVAL][MAX_ALMNAME]; // normal state name

    BOOL      bCheckAlarms;        // if TRUE, check alarms
    char      szTag[DYN_MAXVAL][TAGLEN]; // channel tags
    char      cPrevAlmOut[DYN_MAXVAL];  // previous alarm output for every channel
    char      cAlmOut[DYN_MAXVAL];      // alarm output for every channel
    UINT      wBinNewVal;               // binary channels
    UINT      wBinPrevVal;   
// Rev 3.0 Bad values
    int     bNANCheck;
	HDATA   hDataSet; // handle value for this dataset
}
DYNDATA_DEF;  
typedef DYNDATA_DEF far *PDYNDATA;
/***************************************************************************/
/* Function prototypes *************************************************/
/***********************************************************************/
/*************************************************************************
 * COLOR FUNCTIONS
 *************************************************************************/

COLORREF WINAPI _export WGGetRGBColor (UINT wColor);
UINT     WINAPI _export WGGetPureColor (COLORREF rgbColor);
COLORREF WINAPI _export WGCreateShadeColor(COLORREF rgbColor);

/************************************************************************/
/* Graphics Setup                                                       */
/************************************************************************/
BOOL WINAPI _export WGSetPlotArea (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype  rX1, realtype  rY1, realtype  rX2, realtype rY2, int nColor);

void WINAPI _export WGSetAxesScale (PGRAPH_DEF pGrDesc,
    int nXScaleType, int nYScaleType);
void  WINAPI _export WGScalePlotArea (PGRAPH_DEF pGrDesc, realtype xmin,
    realtype ymin, realtype xmax, realtype ymax);
void  WINAPI _export WGSetXYIntercepts (PGRAPH_DEF pGrDesc,
    realtype rxInt, realtype ryInt);
void WINAPI _export WGSetLineStyle (PGRAPH_DEF pGrDesc, HDC hdc, 
    int nStyle, int nWidth, int nColor);
void WINAPI _export WGSetDataFormat (PGRAPH_DEF pGrDesc, HGOBJ  hObj, int width,
    int prec);
void WINAPI _export WGSetTextParams (int nColor, int nFamily,
    int nSize, int nStyle);
BOOL WINAPI _export WGSetTextByName (int nColor, LPCSTR szFontName,
    int nSize, int nStyle);
void WINAPI _export WGRaiseGraph (PGRAPH_DEF pGrDesc, int nRaiseFlag);

/*************************************************************************
 * DRAWING FUNCTIONS
 *************************************************************************/
HGOBJ WINAPI _export WGDrawXAxis (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype rTickSpace, int nSmallTicks, int nTickPos);
HGOBJ WINAPI _export WGDrawYAxis (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype rTickSpace, int nSmallTicks, int nTickPos);
void WINAPI _export WGDrawGrid (PGRAPH_DEF pGrDesc, HGOBJ hAxis, int nGridType);
HGOBJ WINAPI _export WGGroupBargraph (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, realtype rWidth, int nJustify, int nBarType, int nGraphType,
    COLORREF FAR *lpRgbBarColor, LPINT lpHatchStyle, LPINT lpBorderColor);
HGOBJ WINAPI _export WGFloatingBars (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, realtype rWidth, int nJustify, int nBarType,      
    COLORREF rgbBarColor, int nHatchStyle, int nBorderColor);

BOOL WINAPI _export WGAutoAxes (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    int nRoundType, int nInterceptFlag, PHGOBJ lphAxX, PHGOBJ lphAxY,
    PHGOBJ lphLabX, PHGOBJ lphLabY);
BOOL WINAPI _export WGRoundAxis (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    LPREAL lprMin, LPREAL lprMax, LPREAL lprTickSpace, BOOL bUpdate);
// New
void WINAPI _export RoundAxis (int nRoundType, int nLen, LPREAL amin,
    LPREAL amax, LPREAL rTickSpace, int nAxDir);
BOOL WINAPI _export WGRoundAxis2 (PGRAPH_DEF pGrDesc, int nAxOrient,
	int nAxScale, 
    LPREAL lprMin, LPREAL lprMax, LPREAL lprTickSpace, int nRoundMode);
//    
HGOBJ WINAPI _export WGLinePlot (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    BOOL bFill, BOOL bSpline);

HGOBJ WINAPI _export WGScatterPlot (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    int nMarkerShape, int nMarkerColor, int nMarkerSize,
    int nMarkerStyle, BOOL bDrop);

HGOBJ WINAPI _export WGLineMarkerPlot (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, int nMarkerShape, int nMarkerColor,
    int nMarkerSize, int nMarkerStyle);

HGOBJ WINAPI _export WGBargraph (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    realtype rWidth, int nJustify, int nBarType, COLORREF rgbBarColor,
    int nHatchStyle, int nBorderColor);

HGOBJ WINAPI _export WGStackedLines (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
  BOOL bFill, LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);

HGOBJ WINAPI _export WGHighLowClose (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    int nMarkerShape, int nMarkerColor, int nMarkerSize,
    int nMarkerStyle);

HGOBJ WINAPI _export WGErrorBars (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    int nWidth);
HGOBJ WINAPI _export WGLabelAxis(PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
   int nLabelPos, int nFormat, int nPrec, int nLast, LPSTR lpTextLast);

HGOBJ WINAPI _export WGLabelAxisStrings(PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nFirstTick, HGLOBAL hStr);
HGOBJ WINAPI _export WGLabelAxisStringsPtr(PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nFirstTick, LPSTR lpStr);
HGOBJ WINAPI _export WGLabelAxisStringsNew(PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nFirstTick, LPSTR lpStr);

HGOBJ WINAPI _export WGLabelAxisMonth (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nFirstTick, int nFirstMonth, BOOL bShort);
HGOBJ WINAPI _export WGLabelAxisDayWk (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nFirstTick, int nFirstDay, BOOL bShort);
HGOBJ WINAPI _export WGTextNorm (PGRAPH_DEF pGrDesc, HDC hdc, LPSTR lpString,
			  realtype rX, realtype  rY, UINT wAlign, int nOrientation);

HGOBJ WINAPI _export WGText (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, LPSTR lpString, realtype rX, realtype rY, UINT wAlign,
    int nOrientation);

HGOBJ WINAPI _export WGTitleGraph(PGRAPH_DEF pGrDesc, HDC hdc, LPSTR lpTitle);
HGOBJ WINAPI _export WGTitleAxis(PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nTitlePos, LPSTR lpTitle);

void WINAPI _export WGLabelPie(PGRAPH_DEF pGrDesc, HGOBJ hPie, HGLOBAL hLabels);
void WINAPI _export WGLabelPiePtr (PGRAPH_DEF pGrDesc, HGOBJ hPie,
    LPSTR pLabels);
HGOBJ WINAPI _export WGPieChart (PGRAPH_DEF pGrDesc, HDC hdc, HGLOBAL hData,
    int nNumPoints, int nPieStyle, int nNumType, int nNumPos,
    realtype rDiam, realtype rXCenter, realtype rYCenter,
    COLORREF FAR *lpRgbPieColor,
    LPINT lpBorderColor, LPINT lpHatchStyle, LPREAL lprExplodeRel);

HGOBJ WINAPI _export WGAutoLegend (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype rX, realtype rY, int nBorderColor, int nBorderWidth, 
        int nTextColor, int nBackColor, int nLayout, HGLOBAL hStr);

HGOBJ WINAPI _export WGAutoLegendGroup (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype  rX, realtype  rY, int nBorderColor, int nBorderWidth,
    int nTextColor, int nBackColor, int nLayout, HGLOBAL hStr,
    HGOBJ hObj);

HGOBJ  WINAPI _export WGLegend (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype  rX1, realtype rY1, realtype  rX2, realtype rY2,
        int nBorderColor, int nBorderWidth, 
        int nTextColor, int nBackColor, int nLayout, HGLOBAL hStr);

HGOBJ  WINAPI _export WGLegendPtr (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype  rX1, realtype rY1, realtype  rX2, realtype rY2,
        int nBorderColor, int nBorderWidth, 
        int nTextColor, int nBackColor, int nLayout, LPSTR lpStr);

HGOBJ  WINAPI _export WGLegendGroup (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype  rX1, realtype rY1, realtype  rX2, realtype rY2,
        int nBorderColor, int nBorderWidth, int nTextColor, 
        int nBackColor, int nLayout, HGLOBAL hStr, HGOBJ hObj);

HGOBJ  WINAPI _export WGLegendGroupPtr (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype  rX1, realtype rY1, realtype  rX2, realtype rY2,
        int nBorderColor, int nBorderWidth, int nTextColor, 
        int nBackColor, int nLayout, LPSTR lpStr, HGOBJ hObj);

HGOBJ WINAPI _export WGLineNorm (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2);

HGOBJ WINAPI _export WGArrowNorm (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, int nWidth, int nLength,
    BOOL bStart, BOOL bEnd, BOOL bFill);

// RQ Rev. 3.0 Changed prototypes - bFill from BOOL to int
HGOBJ WINAPI _export WGRectangleNorm (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, int nBorderColor, 
    int nBorderWidth, int  bFill, COLORREF rgbBackColor);

HGOBJ WINAPI _export WGRectangleNormEx (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, int nBorderColor, 
    int nBorderWidth, int bFill, COLORREF rgbBackColor, int n3D);

HGOBJ WINAPI _export WGRectangle (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    int nBorderColor, int nBorderWidth, int bFill,
    COLORREF rgbBackColor);

HGOBJ WINAPI _export WGEllipse (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    int nBorderColor, int nBorderWidth, int bFill, COLORREF rgbBackColor);

HGOBJ WINAPI _export WGPie (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    realtype rX3, realtype rY3, realtype rX4, realtype rY4,
    int nBorderColor, int nBorderWidth, int bFill,
    COLORREF rgbBackColor);

HGOBJ WINAPI _export WGEllipseNorm (PGRAPH_DEF pGrDesc, HDC hdc,
   realtype rX1, realtype rY1, realtype rX2, realtype rY2,
   int nBorderColor, int nBorderWidth, int  bFill, COLORREF rgbBackColor);

HGOBJ WINAPI _export WGPieNorm (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, realtype rX3, realtype rY3, realtype rX4,
    realtype rY4, int nBorderColor, int nBorderWidth, int bFill,
    COLORREF rgbBackColor);

HGOBJ WINAPI _export WGPolygon (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
   HGOBJ hAxisY, LPREAL lprX, LPREAL lprY, int nNumPoints,
   int nBorderColor, int nBorderWidth, int bFill, COLORREF rgbBackColor);

HGOBJ WINAPI _export WGPolygonNorm (PGRAPH_DEF pGrDesc, HDC hdc,
	LPREAL lprX, LPREAL lprY, int nNumPoints, int nBorderColor,
    int nBorderWidth, int  bFill, COLORREF  rgbBackColor);

// End


HGOBJ WINAPI _export WGArcNorm (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, realtype rX3,
    realtype rY3, realtype rX4, realtype rY4);


HGOBJ WINAPI _export WGLine (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2);

HGOBJ WINAPI _export WGArrow (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX, HGOBJ hAxisY,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    int nWidth, int nLength, BOOL bStart, BOOL bEnd, BOOL bFill);

HGOBJ WINAPI _export WGArc (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    realtype rX3, realtype rY3, realtype rX4, realtype rY4);

HGOBJ WINAPI _export WGBitmapNorm (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, int nMode, LPCSTR lpName);

HGOBJ WINAPI _export WGBitmap (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2, realtype rY2,
    int nMode, LPCSTR lpName);

HGOBJ WINAPI _export WGSetDataCursor (PGRAPH_DEF pGrDesc, HDC hdc, 
	int nType, HGOBJ hAxisX, HGOBJ hAxisY, 
	int nSize, int nLineWidth, int nLineStyle, int nColor);

void WINAPI _export WGMoveDataCursor (PGRAPH_DEF pGrDesc, HGOBJ hCursor,
	 realtype rX, realtype rY, BOOL bVisible);

/*************************************************************************
 * DATA SETS FUNCTIONS
 *************************************************************************/

void WINAPI _export WGFreeDataSet (HDATA hDataSet, BOOL bFreeData);
HDATA WINAPI _export WGLoadASCIIDataSet (LPSTR lpFileName,
    LPSTR lpDataName);
BOOL WINAPI _export WGSaveASCIIDataSet (HDATA hDataSet, LPSTR lpFileName,
     LPSTR lpFormat);

HDATA WINAPI _export WGDefineDataSet (LPSTR lpDataName, HGLOBAL  hX,
    HGLOBAL hY, LONG lNumPoints);
HDATA WINAPI _export WGDefineDataSetPtr (LPSTR lpDataName, HPREAL hpX,
    HPREAL hpY, LONG lNumPoints);

HDATA WINAPI _export WGDefineGroupDataSet (LPSTR lpDataName,
    HGLOBAL  hIndep, HGLOBAL hDep, LONG lNumPoints,
    int nGroupSize);
HDATA WINAPI _export WGDefineGroupDataSetPtr (LPSTR lpDataName,
    HPREAL hpX, HPREAL hpY, LONG lNumPoints, int nGroupSize);

BOOL WINAPI _export WGSortDataX (HDATA hDataSet, BOOL bDirection);
BOOL WINAPI _export WGSortDataY (HDATA hDataSet, BOOL bDirection);
BOOL WINAPI _export WGGetMinMaxX (HDATA hDataSet, LPREAL lpXMin,
    LPREAL lpXMax);
BOOL WINAPI _export WGGetMinMaxY (HDATA hDataSet, LPREAL lpYMin,
    LPREAL lpYMax);

HDATA WINAPI _export WGCompressData (HDATA hOrigData, UINT wType,
    UINT wSkip, LONG lFirst, LONG lLast, LPSTR lpNewSetName);
HDATA WINAPI _export WGPasteDataSet (LPSTR lpDataName);
BOOL WINAPI _export WGGetDataSetArrays (HDATA hDataSet,
    HGLOBAL FAR *lphX, HGLOBAL FAR *lphY, LONG FAR *lpNumPoints,
    LPINT lpGroupSize);
BOOL WINAPI _export WGGetDataSetArraysPtr (HDATA hDataSet,
    HPREAL * hpX, HPREAL *hpY, LONG *lpNumPoints,  LPINT lpGroupSize);
HDATA WINAPI _export WGGetDataSet (PGRAPH_DEF pGrDesc, HGOBJ hObj);

void WINAPI _export WGReconnectDataSet (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    HDATA hDataSet);
BOOL WINAPI _export WGGetNearestPoint (PGRAPH_DEF pGrDesc, realtype rX, 
    realtype rY, int nMode, LPREAL lpX, LPREAL lpY, 
	HDATA FAR *lphData, UINT FAR *lpNum);
BOOL WINAPI _export WGMarkDataPoint (HDATA hDataSet, UINT n, BOOL bSkip);
BOOL WINAPI _export WGIsDataPointGood (HDATA hDataSet, UINT n);

/*************************************************************************
 * Graph and Page Functions
 *************************************************************************/
BOOL WINAPI _export WGPrintGraph (PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WGPrintPage  (PPAGE_DEF pPageDesc);
BOOL WINAPI _export WGPrintPageDC (PPAGE_DEF pPageDesc, HDC hdc, realtype rX1, 
    realtype rY1, realtype rX2, realtype rY2);
BOOL WINAPI _export WGPrintPageEx (PPAGE_DEF pPageDesc, realtype rX1, 
    realtype rY1, realtype rX2, realtype rY2);

BOOL WINAPI _export WGCopyGraph  (PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WGCopyPage   (PPAGE_DEF pPageDesc);
void WINAPI _export WGClosePage  (PPAGE_DEF pPageDesc);

BOOL  WINAPI _export WGSavePage (PPAGE_DEF pPageDesc, LPSTR lpFileName);
PPAGE_DEF WINAPI WGRestorePage (LPSTR lpFileName, HWND hwParent, LPSTR lpMenu);

BOOL       WINAPI _export WGSaveGraph (PGRAPH_DEF pGrDesc, LPSTR lpFileName);
PGRAPH_DEF WINAPI _export WGRestoreGraph (PPAGE_DEF pPgDesc, LPSTR lpFileName);

PGRAPH_DEF WINAPI WGCreateGraph (PPAGE_DEF pPageDesc,
	void FAR *lpfnGraph, realtype rX1, realtype rY1, realtype rX2,
    realtype rY2, int nColor, int nBorderColor, int  nBorderWidth);

PPAGE_DEF WINAPI WGCreatePage (LPCSTR lpName, HWND hwParent,
  HINSTANCE hInst, LPSTR lpTitle, void FAR *lpfnPage, LPCSTR lpMenu,
  int nColor, int nMapMode, DWORD dwWinStyle,int nPosStyle,
  int x, int y, int cx,int cy);
PPAGE_DEF WINAPI WGCreateInvisiblePage (LPCSTR lpName, 
    HINSTANCE hInst, void FAR *lpfnPage, int nColor);

PPAGE_DEF WINAPI _export WGGetPageDesc (HWND hwnd);
PGRAPH_DEF WINAPI _export WGGetGraphDesc (HWND hwnd);

void WINAPI _export WGDeleteGraph  (PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WGIsDescValid  (LPVOID lpDesc);
BOOL WINAPI _export WGIsGraphDescValid (PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WGIsPageDescValid (PPAGE_DEF pPgDesc);

void WINAPI _export WGUpdatePage (PPAGE_DEF pPageDesc);

/*************************************************************************
 * METAFILE FUNCTIONS
 *************************************************************************/

BOOL WINAPI _export WGSavePageMeta (PPAGE_DEF pPageDesc, 
    int nMFType, LPSTR lpFileName);
POBJ_META WINAPI _export WGGetMetafile (LPCSTR lpFileName);
void WINAPI _export WGDeleteMetafile (POBJ_META pMetaDesc);
BOOL WINAPI _export WGPlayMetafile (HWND hwnd, POBJ_META pMetaDesc,
    int x1, int y1, int x2, int y2);
BOOL WINAPI _export WGPlayMetafileDC (HWND hwnd, HDC hdc, POBJ_META  pMetaDesc,
    int x1, int y1, int x2, int y2);
HGOBJ WINAPI _export WGMetafileNorm (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, LPCSTR lpName);
HGOBJ WINAPI _export WGMetafile (PGRAPH_DEF pGrDesc, HDC hdc,
    HGOBJ hAxisX, HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2,
    realtype rY2, LPCSTR lpName);
POBJ_META WINAPI _export WGConvertPageToMeta (PPAGE_DEF pPageDesc);
void WINAPI _export QCMakeMetaFile (HDC hdcMeta, PPAGE_DEF pPageDesc,
									LPRECT rcBounds, int nMFType);

/*************************************************************************
 * FFT FUNCTIONS
 *************************************************************************/

void WINAPI _export WGDSPWindow (HPREAL hpRealData, HPREAL hpImData,
    LONG lNumdat, int nWindowType);

BOOL WINAPI _export WGComplexFFT (HPREAL hpRealData, HPREAL hpImData, LONG n,
    BOOL bInverse);
BOOL WINAPI _export WGRealFFT (HPREAL hpX, HPREAL hpSinc, LONG n, BOOL bInverse);
BOOL WINAPI _export WGPowerSpectrum (HPREAL hpRealData, HPREAL hpImData,
	LONG lNumdat, realtype rInterval);
void WINAPI _export WGFFTMagnitude(HPREAL hpCos, HPREAL hpSin,
    LONG lNumdat, LONG i, HPREAL pMag);
void WINAPI _export WGFFTPhase (HPREAL hpCos, HPREAL hpSin, LONG i,
    HPREAL pPhase);
void WINAPI _export WGFFTFrequency (LONG lNumdat, realtype rSampleFreq,
    LONG i, HPREAL pFreq);

/*************************************************************************
 * GUI FUNCTIONS
 *************************************************************************/

/*---- Graph/Page ------*/

HWND WINAPI _export WGGetPageWindow (PPAGE_DEF pPagedesc);
void WINAPI _export WGToggleSelectors (PPAGE_DEF pPageDesc, BOOL bOn);
void WINAPI _export WGToggleHigh (PPAGE_DEF pPageDesc, BOOL bOn);
void WINAPI _export WGChangeGraphPos (PGRAPH_DEF pGrDesc, realtype  rX1,
    realtype  rY1, realtype rX2, realtype rY2);
void WINAPI _export WGGetGraphPos (PGRAPH_DEF pGrDesc, LPREAL lprX1,
    LPREAL lprY1, LPREAL lprX2,  LPREAL lpfY2);
void WINAPI _export WGRedrawGraph (PGRAPH_DEF pGrDesc, BOOL bRecalc);
HWND WINAPI _export WGGetGraphWindow (PGRAPH_DEF pGrDesc);
void WINAPI _export WGChangeGraphBackgnd (PGRAPH_DEF pGrDesc, COLORREF rgbColor);
COLORREF WINAPI _export WGGetGraphBackgnd (PGRAPH_DEF pGrDesc);
void WINAPI _export WGSelectGraph (PGRAPH_DEF pGrDesc);
PGRAPH_DEF  WINAPI _export WGGetSelectedGraph (PPAGE_DEF pPageDesc);
void WINAPI _export WGSetGraphBorder (PGRAPH_DEF pGrDesc, BOOL bOn,
    int nColor, int nWidth);
void WINAPI _export WGBlowupGraph (PGRAPH_DEF pGrDesc, BOOL bDir);
BOOL WINAPI _export WGEditGraphDlg (PPAGE_DEF pPageDesc);

/*---- Plotting Area ----*/
void WINAPI _export WGGetPlotPos (PGRAPH_DEF pGrDesc, LPREAL lprX1,     
					  LPREAL lprY1, LPREAL lprX2, LPREAL lprY2);
void WINAPI _export WGChangePlotPos (PGRAPH_DEF pGrDesc, realtype  rX1,
    realtype  rY1, realtype  rX2, realtype  rY2);

void WINAPI _export WGChangePlotBackgnd (PGRAPH_DEF pGrDesc,
    COLORREF rgbColor);
COLORREF WINAPI _export WGGetPlotBackgnd (PGRAPH_DEF pGrDesc);

BOOL WINAPI _export WGStartZoom (HWND hwndGraph, HGOBJ hAxisX, 
    HGOBJ hAxisY, UINT uMouseMessage, BOOL bUpdate);
BOOL WINAPI _export WGGetZoom (LPREAL lprLeft, LPREAL lprTop, 
    LPREAL lprRight, LPREAL lprBottom);

/*---- Object -----*/
HGOBJ WINAPI _export WGGetSelObject (PGRAPH_DEF pGrDesc,
    UINT FAR *lpSelPoint, LPINT lpSelGroup);

void   WINAPI _export WGSelObject (PGRAPH_DEF pGrDesc, HGOBJ hObj);
void   WINAPI _export WGRedrawObject (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bRecalc);
BOOL WINAPI _export WGGetObjectCoord (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lpX1, LPREAL lpY1, LPREAL lpX2, LPREAL lpY2);
BOOL WINAPI _export WGGetObjectPos (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lpX1, LPREAL lpY1, LPREAL lpX2, LPREAL lpY2);
BOOL WINAPI _export WGGetObjectCoordNorm (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lprX1, LPREAL lprY1, LPREAL lprX2, LPREAL lprY2);
BOOL WINAPI _export WGGetObjectPosNorm (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lprX1, LPREAL lprY1, LPREAL lprX2, LPREAL lprY2);
BOOL WINAPI _export WGChangeObjectCoord (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, BOOL bRedraw);

BOOL WINAPI _export WGChangeObjectCoordNorm (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, BOOL bRedraw);

HGOBJ WINAPI _export WGDuplicateObject (PGRAPH_DEF pGrDesc, HGOBJ hObj);
void WINAPI _export WGObjUpdate (PGRAPH_DEF pGrDesc, HGOBJ hObj, HGOBJ hObjDup);
void WINAPI _export WGDeleteObject (PGRAPH_DEF pGrDesc, HGOBJ hObj);

int  WINAPI _export WGGetObjectType (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL   WINAPI _export WGChangeLineColor  (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewColor, int n);
BOOL   WINAPI _export WGChangeLineColorRGB  (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    COLORREF rgbNewColor, int n);

int WINAPI _export WGGetObjSize (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int CALLBACK _export WGGetObjTypeSize (int nObjType);
int WINAPI _export WGGetLineColor (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
COLORREF WINAPI _export WGGetLineColorRGB (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
COLORREF WINAPI _export WGGetAreaColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int n);
BOOL WINAPI _export WGChangeAreaColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    COLORREF rgbColor, int n);
BOOL WINAPI _export WGChangeLineWidth (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewWidth, int n);
int WINAPI _export WGGetLineWidth (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeLineStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewStyle, int n);
int WINAPI _export WGGetLineStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);

BOOL WINAPI _export WGToggleSpline (PGRAPH_DEF pGrDesc, HGOBJ hObj, BOOL bOn);
BOOL WINAPI _export WGGetFillFlag (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGGetSplineFlag (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeObjFill (PGRAPH_DEF pGrDesc, HGOBJ hObj, BOOL bOn);
BOOL WINAPI _export WGChangeMarkerColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nColor);
int WINAPI _export WGGetMarkerColor (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeMarkerType (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nMarkerShape, int nMarkerSize, int nMarkerStyle);
BOOL WINAPI _export WGGetMarkerType (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPINT lpMarkerShape, LPINT lpMarkerStyle, LPINT lpMarkerSize);
void WINAPI _export WGShowObject (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bShow);
     
/*---- Axes ------*/
BOOL WINAPI _export WGChangeAxisRange (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    realtype rMin, realtype rMax, BOOL bUpdate);
BOOL WINAPI _export WGChangeAxisIntercept (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    realtype rInt, BOOL bUpdate);
BOOL WINAPI _export WGChangeAxisScale (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    int nScaleType, BOOL bUpdate);
void WINAPI _export WGSetTickSize (PPAGE_DEF pPgDesc, int nMajorSize,
    int nMinorSize);
BOOL WINAPI _export WGChangeAxisTicks (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    realtype rTickSpace, int nSmallTicks, int nTickPos);
BOOL WINAPI _export WGChangeGrid (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    int nGridType, int nNewStyle, int nNewWidth, int nNewColor);
BOOL WINAPI _export WGGetAxisTicks (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    LPREAL  lpTickSpace, LPINT  lpSmallTicks, LPINT lpTickPos);
BOOL WINAPI _export WGGetAxisRange (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    LPREAL lprMin, LPREAL lprMax, LPREAL lprInt);
int WINAPI _export WGGetAxisScale (PGRAPH_DEF pGrDesc, HGOBJ hAx);
int WINAPI _export WGGetAxisDir (PGRAPH_DEF pGrDesc, HGOBJ hAx);
BOOL WINAPI _export WGToggleGrid (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    int nGridType, BOOL bOn);
BOOL WINAPI _export WGGetGrid (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    BOOL FAR *lpbGridMajor, BOOL FAR *lpbGridMinor,  
    LINEDESC FAR * FAR *ldGridMajor, LINEDESC FAR * FAR *ldGridMinor);
void WINAPI _export WGToggleGridsOrder (BOOL bGridsBelow);

/*---- Bars ----*/

BOOL WINAPI _export WGGetBarWidth (PGRAPH_DEF pGrDesc, 
    HGOBJ hObj, LPREAL lprWidth);
BOOL  WINAPI _export WGChangeBarWidth (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    realtype rWidth);
BOOL  WINAPI _export WGChangeHatchStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nHatchStyle, int n);
int WINAPI _export WGGetHatchStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL  WINAPI _export WGChangeBarJust (PGRAPH_DEF pGrDesc, HGOBJ hObj, int nPos);
int WINAPI _export WGGetBarJust (PGRAPH_DEF pGrDesc, HGOBJ hObj);


int WINAPI _export WGGetPlotType (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGChangePlotType (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewType);

/*---text----*/
BOOL  WINAPI _export WGChangeTextColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nColor);
int WINAPI _export WGGetTextColor (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeFont (PGRAPH_DEF pGrDesc, HGOBJ hObj,
   LPCSTR lpFaceName, int nSize, int nOrientation, int nWeight,
   BOOL bItalic, BOOL bUnderline);

LPSTR WINAPI _export WGGetFontName (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetFontSize (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetFontWeight (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGGetFontItal (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGGetFontUnder (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetFontOrient (PGRAPH_DEF pGrDesc, HGOBJ hObj);
LPSTR WINAPI _export WGGetString (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL  WINAPI _export WGChangeString (PGRAPH_DEF pGrDesc, HGOBJ hObj,
       LPCSTR lpNewString, int n);
void WINAPI _export WGGetTextSizeNorm (PGRAPH_DEF pGrDesc, 
    HDC hdc, int nDir, LPCSTR lpString, int nNumChar, 
    LPREAL lprWidth, LPREAL lprHeight);

/*----arrows----*/
BOOL WINAPI _export WGChangeArrow (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nLength, int nWidth);
BOOL WINAPI _export WGChangeArrowFill (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bFill);
BOOL WINAPI _export WGChangeArrowPos (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nPos);
int WINAPI _export WGGetArrowWidth (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetArrowLength (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGGetArrowFill (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetArrowPos (PGRAPH_DEF pGrDesc, HGOBJ hObj);

/*-----Labels------*/
int WINAPI _export WGGetLastLabelFlag (PGRAPH_DEF pGrDesc, HGOBJ hObj);
LPSTR WINAPI _export WGGetLastLabelText (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetLabelsPos (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGChangeLabelsPos (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewPos);
int  WINAPI _export WGGetLabelsFormat (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGChangeLabelsFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int nFormat);
int  WINAPI _export WGGetLabelsPrec (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL  WINAPI _export WGChangeLabelsPrec (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nPrec);
BOOL  WINAPI _export WGChangeLastLabel (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nLast, LPSTR lpNewText);

/*----Pie Chart----*/
BOOL WINAPI _export WGGetPieExpl (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int n, LPREAL lpExpl);

BOOL  WINAPI _export WGChangePieExpl (PGRAPH_DEF pGrDesc, HGOBJ hObj,
         realtype rExplode, int n);
BOOL  WINAPI _export WGChangePieTextPos (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nPos);
BOOL WINAPI _export WGChangePieValue (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
    realtype rNewVal, int n);
BOOL WINAPI _export WGGetPieValue (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
    LPREAL lprVal, int n);

int WINAPI _export WGGetPieTextPos (PGRAPH_DEF pGrDesc, HGOBJ hObj);

LINEDESC FAR * WINAPI _export WGGetLineDesc (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int n);

/*---- Mouse ----*/
BOOL WINAPI _export WGGetMousePos (PGRAPH_DEF pGrDesc, HGOBJ hAxisX,
    HGOBJ hAxisY, LPREAL lprX, LPREAL lprY);
void WINAPI _export WGGetMousePosNorm (PGRAPH_DEF pGrDesc,
    LPREAL lprX, LPREAL lprY);
void WINAPI _export WGShowMouseCoord (HWND hwnd, int Type,
    BOOL bStartStop);
void WINAPI WGGraphMouseEvent (HWND hwnd, UINT message,
    POINT ptMouse);

/*************************************************************************
 * MISCELLANEOUS FUNCTIONS
 *************************************************************************/
HGLOBAL WINAPI _export WGCopyMem (HGLOBAL hMem);
void WINAPI _export WGSetOKCursor (HWND hDlg);

BOOL WINAPI _export WGPrinterSetup (HWND hwnd);
void WINAPI _export WGSetPrintOptions (BOOL bGraphBk, BOOL bPlotBk,
 BOOL bBorder, BOOL bKeepAspect, int nPrintStyle, realtype rX, realtype rY);
BOOL WINAPI _export WGPrintOptionsDlg (void);
void _cdecl FAR WGOKMsgBox (PSTR pCaption, PSTR pFormat, ...);
void WINAPI _export WGEnableErrorMessages (BOOL bFlag);
int WINAPI _export WGGetLastError (void);

BOOL WINAPI _export WGMenuCheck (PPAGE_DEF  pPageDesc, int item, int pos);
void WINAPI WGStart(void);
void WINAPI WGCleanup (BOOL bFreeData);
void WINAPI WGEditObject (HWND hwnd);
void WINAPI WGGraphKeyEvent (HWND hwnd, UINT message, WPARAM nVKey, LPARAM dwKeyData);

int   WINAPI _export DefEditObject (PGRAPH_DEF pGrDesc);
HGOBJ WINAPI _export ObjFind (HWND hwnd);
void WINAPI _export WGShowData (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export WGGetVersion (LPINT lpSec);
LPSTR WINAPI _export WGGetDate (void);

//NEW


// New Rev. 3.0

/***************************************************************************/
// Bitmap file types 

#define BM_BMP     1    // Device Dependent bitmap
#define BM_DIB     2    // Device Independent bitmap

// Bitmap copy parameters // 
#define BM_WINDOW  1
#define BM_CLIENT  2
/***************************************************************************/

/* Shifted Hatch Styles for use with Rev 3.0 WGRectangle routines*/
// Windows HatchStyle >> 8 + 1
#define RHS_SOLIDFILL        0x000       
#define RHS_HORIZONTAL       0x100       /* ----- */
#define RHS_VERTICAL         0x200       /* ||||| */
#define RHS_FDIAGONAL        0x300      /* \\\\\ */
#define RHS_BDIAGONAL        0x400       /* ///// */
#define RHS_CROSS            0x500       /* +++++ */
#define RHS_DIAGCROSS        0x600       /* xxxxx */

#define ZOOM_SIMPLE   1 // Original Mode
#define ZOOM_XY_PAIRS 2
#define ZOOM_X_NO_Y   3
#define ZOOM_Y_NO_X   4
#define ZOOM_1X_MULTIPLE_Y   5
#define ZOOM_1Y_MULTIPLE_X   6

#define GROUP_ALL_Y     0
#define GROUP_ONE_Y     1
#define GROUP_ALL_Y_STACKED  2

/**************************************************************************/
#define ORIENT_PORTRAIT		1		// 3.0 UPGRADE
#define	ORIENT_LANDSCAPE	2		// Used with Get/SetPrintOrient

// staircase style
#define NO_STEP    0				// 3.0 UPGRADE
#define STEP_START 1				// Used with WGLinePlotEx
#define STEP_END   2
#define STEP_NO_RISE_LINE 3

#define LG_NONE		0				// 3.0 UPGRADE
#define LG_LINE		1				// Used with WGFlexLegend
//#define LG_LINEMARK	2
#define LG_BAR		2
#define LG_3DBAR	3
#define LG_X		4
#define LG_UPTRIANGLE	5
#define LG_DOWNTRIANGLE	6
#define LG_BOX		7
#define LG_PLUS		8
#define LG_ASTERISK	9
#define LG_DIAMOND	10
#define LG_CIRCLE	11
#define LG_DOT		12
#define LG_BITMAP	13
#define LG_METAFILE	14
		   
#define LGS_FILLED     0 
#define LGS_EMPTY      1
#define LGS_CDOT       2

#define LGS_SOLID	0 
#define LGS_DASH	1
#define LGS_DOT		2
#define LGS_DASHDOT	3 
#define LGS_DASHDOTDOT	4

#define MAXLEGEND	32

#define TYPE_NONE	0		// 3.0 UPGRADE [DMB]
#define LEG_FLEX	1		// 3.0 UPGRADE [DMB]
#define GEN_TEXT	2		// 3.0 UPGRADE [DMB] - text created with WGText
#define GEN_TEXTN	3		// 3.0 UPGRADE [DMB] - text created with WGTextNorm

/**************************************************************************/

// ***** NEW UPGRADE FUNCTIONS Rev. 3.0 *****
void WINAPI _export WGSetPrintOrient (int nOrient);
int WINAPI _export WGGetPrintOrient (void);

// Misc.c
void WINAPI _export WGToggleOKCursor (BOOL bOn);
UINT WINAPI _export WGGetNearestRGBColor (COLORREF rgbColor);

//  Text.c
HGOBJ WINAPI _export WGMultiText (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
    HGOBJ hAxisY, LPSTR lpString, realtype rX, realtype rY,
    UINT wAlign, int nOrientation);

HGOBJ WINAPI _export WGMultiTextNorm (PGRAPH_DEF pGrDesc, HDC hdc,
    LPSTR lpString, realtype  rX, realtype  rY,          
    UINT wAlign, int nOrientation);

/**************************************************************************/

// Added to GrPrim.C
void WINAPI _export WGToggleGridsLine(BOOL bGridsBelow);

HGOBJ WINAPI _export WGPolyline (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxisX,
		HGOBJ hAxisY, LPREAL lprX, LPREAL lprY, int nNumPoints,
        int   nBorderColor,      
        int   nBorderWidth);      

HGOBJ WINAPI _export WGPolylineNorm (PGRAPH_DEF pGrDesc, HDC hdc,
		LPREAL lprX, LPREAL lprY, int  nNumPoints, 
		int nBorderColor, int nBorderWidth);

// Found in XCursor.c
BOOL WINAPI _export WGStartXCursor (HWND hwndGraph, HGOBJ hAxisX, 
    HGOBJ hAxisY, UINT uMouseMessage, int mode, BOOL bUpdate);
BOOL WINAPI _export WGGetXCursor (LPREAL lprLeft, LPREAL lprTop, 
    LPREAL lprRight, LPREAL lprBottom);
BOOL WINAPI _export WGSetXCursorParams (int nLineStyle, int nSize);
BOOL WINAPI _export WGGetXCursorParams (LPINT nLineStyle, LPINT nSize);

// Added in ObjMove.c
BOOL WINAPI _export WGStartObjMove (HWND hwndGraph, HGOBJ hAxisX, 
    HGOBJ hAxisY, UINT uMouseMessage, int mode, BOOL bUpdate);
BOOL WINAPI _export WGGetObjMove (LPREAL lprLeft, LPREAL lprTop, 
    LPREAL lprRight, LPREAL lprBottom);

// Added to Zoom.c
BOOL WINAPI _export WGStartSuperZoom (HWND hwndGraph, 
    HGOBJ *hAxisX, HGOBJ *hAxisY, 
	int nNumAxisX, int nNumAxisY,
	int nZoomAxisMode,
	int nZoomRoundMode,
    UINT uMouseMessage, BOOL bUpdate);

// Added to Dataset.c
BOOL WINAPI _export WGGetMinMaxYGroup (HDATA hDataSet, int nGroupNum, int nGroupMode, LPREAL lpYMin, LPREAL lpYMax);
HDATA WINAPI _export WGCreateEvenGridDataSetPtr (LPSTR lpDataName, HPREAL hpZ,
    realtype rStartX, realtype rStartY, 
    realtype rIncX, realtype rIncY, 
	LONG lNumX, LONG lNumY);
HDATA WINAPI _export WGDefineEvenGridDataSetPtr 
      (LPSTR lpDataName,
       HPREAL hpX, HPREAL hpY,
	   LONG lNumX, LONG lNumY);
BOOL WINAPI _export WGSetDataSetRegularGrid (HDATA hDataSet, 
										  LONG lNumX, LONG lNumY);
BOOL WINAPI _export WGGetContourMinMaxXYZ (HDATA hDataSet, 
										  LPREAL lpXMin, LPREAL lpXMax,
										  LPREAL lpYMin, LPREAL lpYMax,
										  LPREAL lpZMin, LPREAL lpZMax);
BOOL WINAPI _export WGGetNearestPointPlotObjs (
	PGRAPH_DEF pGrDesc, HGOBJ *hPlotObj,int nNumPlotObj,
	realtype rX, realtype rY, int nMode, LPREAL lpX, LPREAL lpY, 
	HDATA FAR *lphData, UINT FAR *lpNum);   
BOOL WINAPI _export WGGetNearestPointNormalized (PGRAPH_DEF pGrDesc, realtype rX, 
	realtype rY, int nMode, LPREAL lpX, LPREAL lpY, 
	HDATA FAR *lphData, UINT FAR *lpNum);   

// Added to Labels.c
HGOBJ WINAPI _export WGLabelAxisDate (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
    int nLabelPos, int nDateFormat, int nBaseUnit, struct tm *tStartDate,
	LPSTR szDateFormat,
	int nLast, LPSTR lpTextLast);
BOOL  WINAPI _export WGChangeDateFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int nDateFormat);
BOOL  WINAPI _export WGSetTimeFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int nTimeFormat);
BOOL  WINAPI _export WGChangeDateFormatString (PGRAPH_DEF pGrDesc,
    HGOBJ hObj,	LPSTR szDateFormat);
BOOL  WINAPI _export WGChangeDateBaseUnits (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int nBaseUnit);
BOOL  WINAPI _export WGChangeDateStartDate (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, struct tm *tStartDate);
int  WINAPI _export WGGetDateFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hObj);
int  WINAPI _export WGGetTimeFormat (PGRAPH_DEF pGrDesc,
    HGOBJ hObj);
BOOL  WINAPI _export WGGetDateFormatString (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, LPSTR szDateFormat);
int  WINAPI _export WGGetDateBaseUnits (PGRAPH_DEF pGrDesc,
    HGOBJ hObj);
BOOL  WINAPI _export WGGetDateStartDate (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, struct tm *tStartDate);
// Added to Axes.c
BOOL WINAPI _export WGRoundAxis3 (PGRAPH_DEF pGrDesc, HGOBJ hAx,
	int nRoundMode,
    LPREAL lprMin, LPREAL lprMax, LPREAL lprTickSpace, BOOL bUpdate);
BOOL WINAPI _export WGAxes (PGRAPH_DEF pGrDesc, HDC hdc, 
	realtype xMin, realtype yMin, realtype xMax, realtype yMax,
    int nRoundTypeX, int nRoundTypeY, int nInterceptFlag, PHGOBJ lphAxX, PHGOBJ lphAxY,
	PHGOBJ lphLabX, PHGOBJ lphLabY);
BOOL WINAPI _export WGGetDataSetsRange( HDATA *hDataSets,int nNumDataSets,
	LPREAL rMinX, LPREAL rMinY, LPREAL rMaxX, LPREAL rMaxY);
BOOL WINAPI _export WGGetGraphPlotObjRange(PGRAPH_DEF pGrDesc, 
    LPREAL rXMin, LPREAL rYMin, LPREAL rXMax, LPREAL rYMax);
BOOL WINAPI _export WGAutoAxesDataSets(PGRAPH_DEF pGrDesc, HDC hdc, 
    HDATA *hDataSets,int nNumDataSets,
    int nRoundType, int nInterceptFlag, 
	PHGOBJ lphAxX, PHGOBJ lphAxY,
	PHGOBJ lphLabX, PHGOBJ lphLabY);
BOOL WINAPI _export WGAutoOneAxisDataSets (PGRAPH_DEF pGrDesc, HDC hdc, 
	HDATA *hDataSet, int nNumDataSets,
    int nRoundTypeX, int nRoundTypeY, int nInterceptFlag, int nAxis,
	realtype rMin, realtype rMax,
	PHGOBJ lphAxX, PHGOBJ lphLabX, 
	PHGOBJ lphAxY, PHGOBJ lphLabY); 
BOOL WINAPI _export WGReAutoOneAxisDataSets (PGRAPH_DEF pGrDesc, 
 	HDATA *hDataSet, int nNumDataSets,
   int nRoundTypeX, int nRoundTypeY, int nInterceptFlag, int nAxis,
	realtype rMin, realtype rMax,
	HGOBJ hAxisX, HGOBJ hAxisY);
BOOL WINAPI _export WGReAxes (PGRAPH_DEF pGrDesc, 
	realtype xMin, realtype yMin, realtype xMax, realtype yMax,
    int nRoundTypeX, int nRoundTypeY, int nInterceptFlag, 
	HGOBJ hAxisX, HGOBJ hAxisY);
BOOL WINAPI _export WGReAutoAxes (PGRAPH_DEF pGrDesc, HDATA hDataSet,
    int nRoundType, int nInterceptFlag, HGOBJ hAxisX, HGOBJ hAxisY);
BOOL WINAPI _export WGReAutoAxesDataSets (PGRAPH_DEF pGrDesc, 
     HDATA *hDataSets,int nNumDataSets,
   int nRoundType, int nInterceptFlag, HGOBJ hAxisX, HGOBJ hAxisY);
BOOL WINAPI _export WGChangeLabelsIntercept (PGRAPH_DEF pGrDesc, HGOBJ hAx,
    realtype rInt, BOOL bUpdate);
void  WINAPI _export WGSaveAxesState(PGRAPH_DEF pGrDesc);
void  WINAPI _export WGRestoreAxesState (PGRAPH_DEF pGrDesc);
BOOL WINAPI _export WGGetAxisIntercepts (PGRAPH_DEF pGrDesc, HGOBJ hAx,
     LPREAL lprAxisInt, LPREAL lprLabelsInt);
void  WINAPI _export WGSetAxisIntercepts (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAx,
     realtype rAxisInt, realtype rLabelsInt);
BOOL WINAPI _export WGAutoAxesGroupData (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
    int nGroupMode, int nRoundType, int nInterceptFlag, PHGOBJ lphAxX, PHGOBJ lphAxY,
	PHGOBJ lphLabX, PHGOBJ lphLabY);
BOOL WINAPI _export WGReAutoAxesGroupData (PGRAPH_DEF pGrDesc, HDATA hDataSet,
    int nGroupMode, int nRoundType, int nInterceptFlag, HGOBJ hAxisX, HGOBJ hAxisY);
BOOL WINAPI _export WGAutoAxesContourData (PGRAPH_DEF pGrDesc, HDC hdc, 
	HDATA hDataSet,   int nRoundType, int nInterceptFlag, PHGOBJ lphAxX, PHGOBJ lphAxY,
	PHGOBJ lphLabX, PHGOBJ lphLabY);
BOOL WINAPI _export WGReAutoAxesContourData (PGRAPH_DEF pGrDesc,  
	HDATA hDataSet,    int nRoundType, int nInterceptFlag, 	HGOBJ hAxisX, HGOBJ hAxisY);
void  WINAPI _export WGGetAxisPhysicalScale (PGRAPH_DEF pGrDesc,  
     HGOBJ hAx,  LPREAL rMinX, LPREAL rMinY, LPREAL rMaxX, LPREAL rMaxY);
void WINAPI _export WGGetTickSize (PPAGE_DEF pPgDesc, LPINT nMajorSize,
	LPINT nMinorSize);
void WINAPI _export WGSetGraphTickSize (PGRAPH_DEF pGrDesc, int nMajorSize,
	int nMinorSize);
void WINAPI _export WGGetGraphTickSize (PGRAPH_DEF pGrDesc, LPINT nMajorSize,
	LPINT nMinorSize);

// Added to GUISup.c
BOOL WINAPI _export WGChangeTextAlign (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 UINT wAlign);
UINT WINAPI _export WGGetTextAlign (PGRAPH_DEF pGrDesc, HGOBJ hObj);
int WINAPI _export  PosToAlign(int xPos, int yPos);
BOOL WINAPI _export WGGetOffsets (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPREAL lpXOff, LPREAL lpYOff);
BOOL WINAPI _export WGChangeOffsets (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    realtype rXOff, realtype rYOff);

BOOL WINAPI _export WGGetBaselineFlag (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGGetOutlineFlag (PGRAPH_DEF pGrDesc, HGOBJ hObj);

BOOL WINAPI _export WGToggleBaseline (PGRAPH_DEF pGrDesc, HGOBJ hObj, BOOL bOn);
BOOL WINAPI _export WGToggleOutline (PGRAPH_DEF pGrDesc, HGOBJ hObj, BOOL bOn);
BOOL WINAPI _export WGSetMultiColors (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 BOOL bOn, COLORREF FAR *lpRGBColors);
COLORREF WINAPI _export WGGetSingleColor (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										  int n);
BOOL WINAPI _export WGChangeSingleColor (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 COLORREF rgbNewColor, int n);

HGOBJ WINAPI _export WGLinePlotEx (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, BOOL bFill, int nStep);
int WINAPI _export WGGetLineStep(PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeLineStep(PGRAPH_DEF pGrDesc, HGOBJ hObj, int nStep);

BOOL WINAPI _export WGChangeMarkerSkip(PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nMarkerStart, int nMarkerSkip);
BOOL WINAPI _export WGGetMarkerSkip (PGRAPH_DEF pGrDesc, HGOBJ hObj,
									 LPINT nMarkerStart, LPINT nMarkerSkip);
BOOL WINAPI _export WGLogicalUnitsToDevicePixels (PGRAPH_DEF pGrDesc,
				int    nLx, int nLy,
				LPINT lpnDx, LPINT lpnDy);
BOOL WINAPI _export WGDevicePixelsToLogicalUnits(PGRAPH_DEF pGrDesc,
				int nDx, int nDy,
				LPINT lpnLx, LPINT lpnLy);
BOOL WINAPI _export WGLogicalUnitsToPhysicalUnits (PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				int    nLx, int nLy,
				LPREAL lprPx, LPREAL lprPy);
BOOL WINAPI _export WGPhysicalUnitsToLogicalUnits(PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				realtype rPx, realtype rPy,
				LPINT lpLx, LPINT lpLy);
BOOL WINAPI _export WGDevicePixelsToPhysicalUnits (PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				int    nDx, int nDy,
				LPREAL lprPx, LPREAL lprPy);
BOOL WINAPI _export WGPhysicalUnitsToDevicePixels(PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				realtype rPx, realtype rPy,
				LPINT lpDx, LPINT lpDy);
BOOL WINAPI _export WGNormalizedUnitsToPhysicalUnits (PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				realtype  rNx, realtype rNy,
				LPREAL lprPx, LPREAL lprPy);
BOOL WINAPI _export WGPhysicalUnitsToNormalizedUnits(PGRAPH_DEF pGrDesc,
				HGOBJ hAxisX, HGOBJ hAxisY, 
				realtype rPX, realtype rPY,
				LPREAL lpnNx, LPREAL lpnNy);
BOOL WINAPI _export WGNormalizedUnitsToLogicalUnits (PGRAPH_DEF pGrDesc,
				realtype  rNx, realtype rNy,
				LPINT lpnLx, LPINT lpnLy);
BOOL WINAPI _export WGLogicalUnitsToNormalizedUnits(PGRAPH_DEF pGrDesc,
				int nLX, int nLY,
				LPREAL lprNx, LPREAL lprNy);
BOOL WINAPI _export WGNormalizedUnitsToDevicePixels(PGRAPH_DEF pGrDesc,
				realtype  rNx, realtype rNy,
				LPINT lpnDx, LPINT lpnDy);
BOOL WINAPI _export WGDevicePixelsToNormalizedUnits(PGRAPH_DEF pGrDesc,
				int nDX, int nDY,
				LPREAL lprNx, LPREAL lprNy);
BOOL WINAPI _export WGChangeMarkerDrop (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bMarkerDrop);
BOOL WINAPI _export WGGetMarkerDrop (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeBarBorder(PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bMarkerBorder);
BOOL WINAPI _export WGGetBarBorder (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeLegendBorder (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    BOOL bBorder);
BOOL WINAPI _export WGGetLegendBorder (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeLegendBackgroundColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nColor);
int WINAPI _export WGGetLegendBackgroundColor (PGRAPH_DEF pGrDesc, HGOBJ hObj);
PGRAPH_DEF WINAPI _export WGGetGraphInPage (PPAGE_DEF pPageDesc,
								  int nGraphNum);
int WINAPI _export WGGetGraphObject (PGRAPH_DEF pGrDesc, int nObjectType,
								  int nObjectNum, LPINT lpnObjectSubType);

// Added to GrObj.c
HGOBJ WINAPI _export WGScatterPlotEx (PGRAPH_DEF pGrDesc, HDC hdc, 
	HDATA hDataSet,	int nMarkerShape, LPCSTR lpName, int nMarkerSize,
    BOOL bDrop);
LPSTR WINAPI _export WGGetMarkerName (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGChangeMarkerName (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    LPCSTR lpName);

// Added to Clip.c
#ifndef HDIB
#define HDIB HANDLE
#endif

HBITMAP WINAPI _export WGGetPageBitmapHandle(PPAGE_DEF pPageDesc,int nCopyArea);
HDIB WINAPI _export WGGetPageDIBHandle(PPAGE_DEF pPageDesc, int nCopyArea);
HDIB WINAPI _export WGGetGraphDIBHandle(PGRAPH_DEF pGraphDesc, int nCopyArea);
HBITMAP WINAPI _export WGGetGraphBitmapHandle(PGRAPH_DEF pGraphDesc,int nCopyArea);
void WINAPI _export WGFreeDIB(HDIB hDib);
void WINAPI _export WGFreeBitmap(HBITMAP hBitmap);
BOOL WINAPI _export WGSavePageDIB (PPAGE_DEF pPageDesc, 
    int nCopyArea, LPSTR lpFileName);
BOOL WINAPI _export WGSaveGraphDIB (PGRAPH_DEF pGraphDesc, 
     int nCopyArea, LPSTR lpFileName);

// Added to GRSup.c
void WINAPI _export WGSetMouseEventAction(PGRAPH_DEF pGrDesc, int nMouseEvent, int nAction, void * lpfnUserProc);
int WINAPI _export WGGetMouseEventAction(PGRAPH_DEF pGrDesc, int nMouseEvent);


// Added to QCWinit.c
void WINAPI  WGProcessMouseEventAction(HWND hwnd, int nEvent, int nAction, UINT message, POINT ptMouse);
void WINAPI  WGProcessMouseEvent(HWND hwnd, UINT message, POINT ptMouse);
BOOL WINAPI WGPreAddGraphObject  (PGRAPH_DEF pGrDesc, HDC hdc)  ;
BOOL WINAPI WGPostAddGraphObject  (PGRAPH_DEF pGrDesc, HDC hdc)  ;

// Added to Support.c
BOOL WINAPI _export WGBadValueCheck (realtype * rNewValue);

// Added to Legend.c
HGOBJ  WINAPI _export WGFlexLegend (PGRAPH_DEF pGrDesc, HDC hdc,
        realtype  rX1, realtype rY1, realtype  rX2, realtype rY2,
        int nBorderColor, int nBorderWidth, 
		int nBackColor, int nLayout, 
		UINT nNumObjects, 	COLORREF *lpTextColor, 
		LPINT lpSymbolShape, COLORREF *lpSymbolColor,   
		LPINT	lpSymbolSize, LPINT lpSymbolStyle,
		LPSTR lpStr);

COLORREF WINAPI _export WGGetFLTextColor (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeFLTextColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    COLORREF rgbNewColor, int n);

int WINAPI _export WGGetFLSymShape (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeFLSymShape (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewShape, int n);
COLORREF WINAPI _export WGGetFLSymColor (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeFLSymColor (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    COLORREF rgbNewColor, int n);
int WINAPI _export WGGetFLSymSize(PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeFLSymSize (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewSize, int n);
int WINAPI _export WGGetFLSymStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj, int n);
BOOL WINAPI _export WGChangeFLSymStyle (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    int nNewStyle, int n);

// Added to Group.c
HGOBJ WINAPI _export WGGroupLines (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,
  BOOL bFill, LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);
HGOBJ WINAPI _export WGWaterfallPlot (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet,			
	realtype rXOff, realtype rYOff, BOOL bFill, BOOL bBaseline, BOOL bOutline,
	LPINT pLineStyle, LPINT pLineWidth, LPINT pLineColor);

HGOBJ WINAPI _export WGContourPlot (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet,
    LPREAL prContourValues,
    COLORREF *pRgbContourColor,   
	LPINT pLineStyle,         // line styles
	LPINT pLineWidth,         // line width, in pixels
	int nNumContours,
	int nBitmapGranularity,
	LPBOOL pLineFlags,       
	LPBOOL pLabelFlags,
	int   nLabelXJust,
	int   nLabelYJust,
	int   nLabelPrec,
	BOOL   bLabelContourColor,
    int   nGraphType); 
BOOL WINAPI _export WGDeletePlotBitmap (PGRAPH_DEF pGrDesc,  HGOBJ hPlotObj);
HGOBJ WINAPI _export WGOpenHighLowClose (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, 
	int nOpenMarkerShape, int nOpenMarkerColor, int nOpenMarkerSize, int nOpenMarkerStyle,
	int nCloseMarkerShape, int nCloseMarkerColor, int nCloseMarkerSize, int nCloseMarkerStyle);
HGOBJ WINAPI _export WGStockOpenHighLowClose (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, realtype rWidth);

#ifndef MAXBMNAMELEN				// UPGRADE = conditional test for #define
	#define  MAXBMNAMELEN  80
#endif



/**************************************************************************/
typedef struct  
{
   int     nOrigMarkerSize;    // marker size in points at the time of creation or
   int     nMarkerSize;        // size of marker in points
   int       nMarkerLogSize;     // size of marker in logical units
   long      nMarkerColor;       // Marker color (Scatter plot)
   int     nMarkerShape;
   int       nMarkerStyle;       // MKS_FULL, MKS_CDOT, etc. Also bar border flag

   BOOL      cDrop;              // For scatter plot - drop down flag
	char      szBmpName[MAXBMNAMELEN];  // name of the bitmap	// UPGRADE8 [DMB] - for WGScatterPlotEx
	char      szMetaName[MAXBMNAMELEN]; // name of the metafile // UPGRADE8 [DMB] - for WGScatterPlotEx vv
    HGOBJ     hImage;             // handle to related image (bitmap, metafile) object 
	    
}  SCATTER_DESC;
typedef SCATTER_DESC far *PSCAT_DESC;

PSCAT_DESC WINAPI _export WGCreateScatterSymbol (PGRAPH_DEF pGrDesc, HDC hdc, 
    int nMarkerColor, int nMarkerShape, int nMarkerStyle, int nMarkerSize,
	BOOL bDrop, LPCSTR lpName);


//**** BOX & WHISKER CONSTANTS
//Box/or Column Type
#define	BW_NONE    0
#define	BW_PERCNT  1
#define	BW_MINMAX  2
#define	BW_CONST   3  
#define	BW_STDDEV  4
#define	BW_STDERR  5
#define	BW_NONOUT  6
#define BW_COLUMN  7

// Midpoint type
#define	BW_MEAN    0
#define	BW_MEDIAN  1


#define BW_MIDP 0
#define BW_OH   1
#define BW_OL   2
#define BW_UBV  3
#define BW_LBV  4
#define BW_EH   5
#define BW_EL   6
#define BW_WHHIGH 7
#define BW_WHLOW  8
#define BW_NELEM  9 //Number of calc vals in array
 

#define BW_BOX 10
#define BW_WHISKER 11
#define BW_OUTLIER 12
#define BW_EXTREME 13


HGOBJ WINAPI _export WGBoxWhisker (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet, 
	int nMidPointType, 
	PSCAT_DESC pMidPtMarkDesc,
	int nBoxType, int nBoxSize,
	realtype rBoxCoef, realtype rBoxConst,
	realtype rBoxPerMin, realtype rBoxPerMax, 
	int nBoxOutlineColor, BOOL bBoxFill, 
	COLORREF rgbHighColor, COLORREF rgbLowColor,
	int nWhiskerType, int nWhiskerSize, realtype rWhiskerCoef,
	realtype rWhiskerPerMin, realtype rWhiskerPerMax, 
	int nWhiskerColor, int nWhiskerStyle, int nWhiskerWidth, 
	BOOL bOutlier, PSCAT_DESC pOutMarkDesc,
	BOOL bExtreme, PSCAT_DESC pExtMarkDesc,
	realtype rOutlierCoef);


HGOBJ WINAPI _export WGCandlestick (PGRAPH_DEF pGrDesc, HDC hdc,
    HDATA hDataSet, 
	realtype rWidth, COLORREF rgbBarColor, int nBorderColor);


BOOL WINAPI _export WGChangeGroupReal(PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 int nParam, int nIndex,
										 realtype rValue);
BOOL WINAPI _export WGChangeGroupInt(PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 int nParam, int nIndex,
										 int nValue);
BOOL WINAPI _export WGChangeGroupSymbol(PGRAPH_DEF pGrDesc, HGOBJ hObj, 									 int nParam,
										 PSCAT_DESC pMarker);
BOOL WINAPI _export WGGetGroupReal(PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 int nParam, int nIndex,
										 LPREAL rValue);
BOOL WINAPI _export WGGetGroupInt(PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 int nParam, int nIndex, LPINT nValue);


//  Added ObjSup
void WINAPI _export WGSetGraphBitBltMode(PGRAPH_DEF pGrDesc, BOOL bBltMode);
BOOL WINAPI _export WGGetGraphBitBltMode(PGRAPH_DEF pGrDesc);
int WINAPI _export WGGetObjUserID (PGRAPH_DEF pGrDesc, HGOBJ hObj);
BOOL WINAPI _export WGSetObjUserID (PGRAPH_DEF pGrDesc, HGOBJ hObj, int nUserID);
HGOBJ WINAPI _export WGGetUserIDObj (PGRAPH_DEF pGrDesc, int nUserID);



#if 0

realtype WINAPI _export WGMedian (HPREAL dataset, int nGroupSize, realtype *rHigh, realtype *rLow);
realtype WINAPI _export WGMean (HPREAL dataset, int nGroupSize);
realtype WINAPI _export WGStdDev (HPREAL datary, realtype mean, int numrow);
BOOL WINAPI _export WGChangeOutlierCoef (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 realtype rOutlierCoef);
BOOL WINAPI _export WGChangeMidpointType (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 int nMidPointType);
BOOL WINAPI _export WGChangeBoxCoef (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
									 realtype rBoxCoef);
BOOL WINAPI _export WGChangeBoxConst (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
										 realtype rBoxConst);
BOOL WINAPI _export WGChangeBoxMinMax (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
									 realtype rBoxPerMin,
									 realtype rBoxPerMax);
BOOL WINAPI _export WGChangeOutlier (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
								BOOL bOutlier, PSCAT_DESC pOutMarkDesc);
BOOL WINAPI _export WGChangeExtreme (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
								BOOL bExtreme, PSCAT_DESC pExtMarkDesc);
BOOL WINAPI _export WGChangeMidpoint (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
								PSCAT_DESC pMidPtMarkDesc);
BOOL WINAPI _export WGChangeWhiskerType (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
									 int nWhiskerType);
BOOL WINAPI _export WGChangeWhiskerSize (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
									 int nWhiskerSize);
BOOL WINAPI _export WGChangeWhiskerCoef (PGRAPH_DEF pGrDesc, HGOBJ hObj, 
									 realtype rWhiskerCoef);
BOOL WINAPI _export WGChangeWhiskerMinMax (PGRAPH_DEF pGrDesc, HGOBJ hObj,  
									 realtype rWhiskerPerMin,
									 realtype rWhiskerPerMax);
#endif

//
/************************************************************************/

LRESULT CALLBACK WGUserPageProc (HWND hwnd, UINT message,
    WPARAM wParam, LPARAM lParam);

/****************************************************************************/

#ifdef __cplusplus
}
class QCBasePage
{
public:
    virtual void BuildPage (PPAGE_DEF) = 0; // pure virtual function initializing page
};

class QCBaseGraph
{
public:
	virtual void BuildGraph (PGRAPH_DEF, HDC) = 0; // pure virtual function initializing graphs
};
#endif
/**************************************************************************/

#pragma pack(pop)

#endif


