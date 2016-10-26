/************************************************************************/
/*                                                                      */
/*     Copyright (C) QUINN-CURTIS, Inc., 1992 - 1998                    */
/*                                                                      */
/************************************************************************/
/**                                                                     */
/**   Filename :   support.h                                            */
/**   Author   :   QC                                                   */
/**   Revision :   3.0                                                  */
/**   Date     :   August 15, 1998                                      */
/**                                                                     */
/**   Description:  Prototypes for support routines                     */
/**                                                                     */
/**   Revisions  : 1.5 7/13/94 - Support of Real-Time Tools             */
/**                                                                     */
/************************************************************************/

#ifndef  _SUPPH
#define  _SUPPH        1
#pragma pack(push, 8)



#include "polysurf.h"
#include "time.h"

#ifdef __cplusplus
extern  "C" {
#endif

#ifdef WIN32
    #define  GMF    GPTR
#else
    #define  GMF    GHND
#endif


#define MAXINT  32000
#define MAXREAD 32768L
#define MAXPOLY 1025
#define POLYLINE_BLOCKSIZE 200

#define MAXWEXT     13000        // Max Window Extent in logical coords

#define VER_MAJOR   1            // version number
#define VER_MINOR   0

#define GRAPHSIGN   0x13579BDF
#define PAGESIGN    0x2468ACE1

#define  STYLE_POPUP  WS_POPUP | WS_CAPTION | WS_SYSMENU \
		 | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_THICKFRAME | WS_CLIPCHILDREN

#define STYLE_CHILD WS_CHILD | WS_CLIPSIBLINGS | WS_VISIBLE | WS_CLIPCHILDREN

#define  OBJ_DUP       (HGOBJ) 32001 // handle for duplicate object

#define XLEN(y)       (int)(y*(float)pGrDesc->cyVExt/(float)pGrDesc->cxVExt) 
#define YLEN(y)      y// (int) (y*(float)pGrDesc->cxVExt/(float)pGrDesc->cyVExt) 

// offsets to private data of page and graph windows

#define  GWL_DESC       0       // offset to graph desc. pointer
#define  GWL_TOPDESC    4       // offset to topdesc pointer


// offsets to private data of graph windows
#define  GWL_PARENTDESC 8       // offset to parent's descriptor pointer
#define  GWL_TABFLAG   12       // offset to data table owned window flag
#define  GWW_GRAPHEXTRA 16      // # of extra bytes

// offsets to private user data of page windows
#define  GWL_PUSER      16      // can use these 4 bytes
#define  GWW_PAGEEXTRA  20      // # of extra bytes

// offsets to private data of DATA table windows

#define  GWL_CXCHAR    0      
#define  GWL_CYCHAR    4       
#define  GWL_VSCRPOS   8   // offset to current position of scroll bar thumb
#define  GWL_VSCRMAX  12 
#define  GWL_HSCRPOS  16  
#define  GWL_HSCRMAX  20 
#define  GWL_CXVAL    24
#define  GWL_HWEDIT   28 
#define  GWL_JLAST    32
#define  GWL_ILAST    36  
#define  GWL_TABEXTRA  GWL_ILAST +4

/************************************************************************/
/* data table window messages */ 

#define TM_ENTERED	   (WM_USER+1)
#define TM_ESCAPE	   (WM_USER+2)
#define TM_UP	       (WM_USER+3)
#define TM_DOWN	       (WM_USER+4)
#define TM_TAB	       (WM_USER+5)
#define TM_KEY	       (WM_USER+6)
#define TM_LEFT	       (WM_USER+7)
#define TM_RIGHT       (WM_USER+8)

/************************************************************************/

#define  LARGETICK   4
#define  SMALLTICK   2          // Tick sizes in screen pixels
#define  DEPTH_CONST 1/4

#define  BR_LIM       0.01   // raised border size limit relative to screen width
#define  BORDER_RATIO 0.01   // Relative border width of raised rectangles

#define  MK_DEFAULT_SIZE  6  // default size of markers in points

/***************************************************************************/
/* line options */

#define LN_NOFILL   0
#define LN_FILL     11

/***********************************************************************/
// label types

#define  LB_NUMERIC   0
#define  LB_STRING    1
#define  LB_MONTH     2
#define  LB_DAYOFWK   3

/************************************************************************/
/* selectors on / off   */

#define GS_OFF  0
#define GS_ON   1
#define GS_MOVE 2

/************************************************************************/
// MISC

#define  COM_REDRAW    3
#define  COM_TABLE     4
#define  COM_LINETOBAR 5
#define  COM_BARTOLINE 6
#define  COM_SPLINE    7

#define  DLG_DISABLE   (0L)
#define  DLG_DOWN_ENABLE   (0x80000000L)
#define  DLG_RIGHT_ENABLE  (0x8000)
#define  DLG_ENABLE        (0x8000)

#define  MAXSIZE       8

#define  GO_SUBT_NOTEXT 0             
#define  GO_SUBT_TEXT   1             
#define  GO_SUBT_AXLAB  2             
#define  GO_SUBT_GTITLE 3         

#define  BB_COPYPLOTAREA  0
#define  BB_COPYGRAPHAREA 1   

// legend types

#define LG_CHART  0
#define LG_GROUP  1
#define LG_DYN    2                // dynamic legends code

#define DYN_TRACE_NOALARM 0
#define DYN_TRACE_ALARM   1

/***************************************************************************/
/* dialog box extension flags: */

#define DEX_NONE   0
#define DEX_RIGHT  1
#define DEX_DOWN   2
#define DEX_BOTH   3

#define GO_SUBT_AUTO       9
#define GO_SUBT_MAN       10

/***************************************************************************/
// UPGRADE ADDITIONS - copies from #defines found elsewhere below
#ifndef MAXGROUPLEN							  // conditional test for #define
	#define MAXGROUPLEN  32	//DMB
#endif
#ifndef MAXBMNAMELEN						  // conditional test for #define
	#define  MAXBMNAMELEN  80
#endif
/***************************************************************************/
/************************************************************************/
/* Dynamic objects (RT Tools)                                           */
/************************************************************************/
typedef struct                     // common header
{
   int   nType;                  // object type
   int   nSubType;               // object subtype 
   HGOBJ  (_cdecl FAR *lpfnObj) (LPVOID, HDC); // function drawing the object
   RECT    rcBoundary;             // object limits in device coordinates
   HGOBJ  hObj1;                   // handles of associated objects (axes) 
   HGOBJ  hObj2;
   LINEDESC ld;
   HGOBJ  (_cdecl FAR *lpfnDynObj) (LPVOID, LPVOID); // update func.
   DWORD   dwLastUpdate;           // seconds count for last update
   int    wUpdatePer;             // update period in seconds
   BOOL    fInverse;
   BOOL    fShow;                  // if = 0, hide object 
   BOOL    bCompoundObj;
   int    nUserID;
}
DYNOBJ_HEAD;
typedef DYNOBJ_HEAD far *PDYNOBJ_HEAD;

typedef HGOBJ (CALLBACK *RESTDYNOBJ) (HFILE, PGRAPH_DEF, HDC, int, int);
typedef BOOL  (CALLBACK *SAVDYNOBJ) (HFILE, PGRAPH_DEF, PDYNOBJ_HEAD);

typedef struct  
{
    LOGFONT lFont;           // font descriptor
    long   nColor;          // text color code
    int   nFontNum;
    int   nSizeInd;        // index to size table for given font. If -1,
                             // the table is not used, size taken from nPointSize
    int   nOrigPointSize;  // font size in points at the time of creation or
                             // user change (not affected by resizing)
    int   nPointSize;      // font size in points
    int   nSizeDev;
    BOOL    fResize;
    LPSTR   lpText;          // pointer to text string
    int   MaxLen;
 //   int    bFontType;
 //   char    cReserved[3];

	int		nType;			// UPGRADE7 [DMB] - "parent" structure type:
							//  LEG_FLEX for Flex Legend, GEN_TEXT for WGText/Norm

	COLORREF rgbColor;		// UPGRADE7 [DMB] - used for text strings in Flex 
							//  Legend (WGFlexLegend)

    realtype  rX;           // UPGRADE16 [DMB] -  text coordinates in eng. 
    realtype  rY;			//  or logical units - used for WGText/Norm

	int		nNumLines;		// UPGRADE17 [DMB] - temp. holder for return from dialog

} TEXTDESC;

/**************************************************************************/

#define DATANAMELEN 32

typedef struct                  // XY data set descriptor
{
    LONG    lNumPoints;
    HGLOBAL hX;                    // memory handles
    HGLOBAL hY;
    HPREAL  hpX;                   // pointers to arrays
    HPREAL  hpY;
    LPINT   lpMask;                // mask for bad data points 
    int    cGroupSize;
    int    cUseCounter;
    char    szDataName[DATANAMELEN];  // unique name of the data set
	polysurfacetype *psf;
	int     nRGNumX;
	int     nRGNumY;
	BOOL    nRGFlag;
	int     hDataSet;

//    char    reserved;
}
XYDATA_DEF;  

/***************************************************************************/
// Screen and printer global descriptor
typedef struct
{
    int     cxScreen;        // Screen width
    int     cyScreen;        // Screen height
    int     nScLogPixelsX;   // Screen pixels per logical inch
    int     nScLogPixelsY;

    int     cxPage;          // size of printer page in printer pixels
    int     cyPage;
    int     cxLogPixels;     // # of printer pixels per logical inch
    int     cyLogPixels;
    int   nScaleFactorX;
    int   nScaleFactorY;
    POINT   ptMouse;         // Position of mouse pointer in device coord.
    BOOL    bPrinterAvail;
    HINSTANCE  hWCTDllInst;     // instance handle of the WCT DLL
    long    nColors;         // Number of screen colors
    int     xOrgPage;        // for print preview - page origin
    int     yOrgPage;
	BOOL    bGraphModePrint;  // 0 = Page print, 1 = graph print
 //   char    res[1];
}
DEV_DEF;

/***************************************************************************/
/* This structure contains values specific to application ******************/
/***************************************************************************/
typedef struct
{
    HWND    hwTop;                // Top (user application) window handle
    BOOL    bInit;
    HGLOBAL hPgMem [MAX_PAGES + 1]; // array of handles to chart pages
    XYDATA_DEF far *pxyDesc [MAX_DATASETS];
    BOOL    bMFC;
    int     res1 [256];

    TEXTDESC ct;                  // current text parameters
    HRGN    hClipRgn;             // handle to "open" clipping region
    UINT    nNumPages;            // number of chart pages
	HINSTANCE  hInst;             // Global application instance handle 
    BOOL    bErrRep;              // Error Reporting Flag
    BOOL    bTerm;                // Termination Flag
    void (CALLBACK *lpfnDynRescale)(PGRAPH_DEF, LPVOID, int);

    FARPROC lpGraphProc;          // graph window class procedure
    HCURSOR hChartCur;
    int    verMajor;             // major version number  
    int    verMinor;
    BOOL    bGridsBelow;          // if TRUE, grid lines are below objects
                                  // by default, they are on top. 
    BOOL    cRTSemaphore;         // if not 0, RT graphics is not updated 
    int    res2;

        // printing parameters
    BOOL    bFrame;          // if set, print frame around picture
	BOOL    bGraphBackgnd;   // if set, print graph window background
    BOOL    bPlotBackgnd;    // if set, print plotting area background
    BOOL    bPropWidth;      // if set, line width is proportional, otherwise in pixels
    BOOL    bPropText;       // if set, printed text size is proportional, otherwise in points
    int   nPrintStyle;     // can be PRT_FULL, PRT_PROP, PRT_EXACT
    BOOL    bKeepAspect;     // if TRUE, maintain aspect ratio
    float   fLeft;           // printer hdc normalized coordinates of the left upper corner
    float   fTop;

	int     cLenReal;            // number of bytes in REALTYPE (4 or 8)   
	BOOL    bInitPrintParam;
	BOOL    bBadValueFlag;       // Set to TRUE if bad values allowed
    realtype  rMaxPosNumber;
    realtype  rMinNegNumber;
    realtype  rBadValueNumber;
    int      nObjCounter;
	BOOL     bSerializeFlag;
	BOOL     bCompoundFlag;

    RESTDYNOBJ RestoreDynObject;
    SAVDYNOBJ SaveDynObject;

	DEV_DEF * pDevDesc;
	LPVOID  lpRTTop;             // pointer to WRT extension 
}
TOP_DEF;
/**************************************************************************/

typedef struct                     /* Axis */
{
   OBJ_HEAD  header;
   realtype  rxMin;               // scaling values
   realtype  rxMax;
   realtype  ryMin;     
   realtype  ryMax;
   realtype  rxInt;               // intercepts
   realtype  ryInt;
   realtype  rTickSpace;         // distance between ticks in eng. units
   realtype  rLMin;              // limits for logarithmic scale  
   realtype  rLMax;
   realtype  rFirstTick;         // value of the first tick number
   int     nScaleType;         // ST_LINEAR or ST_LOG
   int     nPerpScaleType;     // Scale type for perpendicular axis 
   int     nDir;               // can be OR_VERT or OR_HORZ
   int     nMajTicks;          // number of major ticks
   int     nSmallTicks;        // number of minor ticks between 2 major ticks
   int     nTickPos;           // position of the ticks relative to axis
   BOOL      fGridMajor;         // flag indicating if grid is enabled for Major ticks
   BOOL      fGridMinor;         // flag indicating if grid is enabled for minor ticks
   LINEDESC  ldMajor;            // grid line descriptors
   LINEDESC  ldMinor;
   BOOL      fAuto;              // Automatic axis flag
   BOOL      bRedraw;            // Redraw flag
   LPVOID    pLabDesc;           // pointer to related labels object
   int      cTimeUnits;         // time units, for real-time graphics
   BOOL      cDynGrids;          // 1 if has dynamic grids attached
   char      reserved [8];  
}
OBJ_AX;

#define TEXT_LEN    128
/**************************************************************************/

typedef struct         
{
    OBJ_HEAD  header;
    TEXTDESC  tdesc;              // text descriptor, must follow header !
    BOOL      fRedraw;            // redraw flag
    int       x;                  // logical coordinates of text
    int       y;
    int       xstart; 
    int       ystart;
    float     relX;               // Text coordinates relative
    float     relY;               // to graph window
    realtype  rX;                 // coordinates in eng. units.
    realtype  rY;

    UINT      wAlign;
    HGOBJ     hd;                 // handle to related object 
    int     nOrientation;
    int     nPos;               // flag of relative position  
    SIZE      sizeString;
    char      szText[TEXT_LEN];  // Text String  
 //   char      reserved [5];  

	BOOL	bMultiLines;		  // UPGRADE17 [DMB]
	int		nNumLines;			  // UPGRADE17 [DMB]

}
OBJ_TEXT;

/**************************************************************************/

typedef struct                     /* Labels */
{
    OBJ_HEAD  header;
    TEXTDESC  tdesc;              // text descriptor, must follow header !
    int     nLabelPos;          // position of labels relative to axis
    int     nDir;               // can be OR_VERT or OR_HORZ
    int     nLast;              // last label flag
    int     nType;              // numeric, string, date
    HGLOBAL   hStr;               // handle to array of strings
    LPSTR     lpStr;              // pointer to array of strings
    int      nFormat;            // NF_SCIENTIFIC, NF_DECIMAL, etc.  
    int      cPrec;              /* # of digits after . Also, # of first entry
                                     for month or day of week labels */
    BOOL      fPrecMan;           /* if on, precision is set manually. Also,
									 if on - show only 3 characters
                                     for month or day of week labels */
    int       nStringExt;         // Largest label string length
    int       nStringExt2;        // for scientific notation, length of exponent.
    int      bFirstTick;         // # of tick where first month is displayed
    char      szTextLast[40];     // Text String  for last label

    BOOL      cSavedString;       // for string labels only, set to 1 if a copy of
                                  // the string was made      
    int      wSize;              // total string size
	struct tm tStartDate;
	int       nBaseUnit;
	int       nDateFormat;
	char      szDateFormatString[64];
	int       nTimeFormat;
 //   char      reserved [6];  
}
OBJ_LABELS;

/**************************************************************************/

typedef struct                   /* Lines, bars, etc. */
{
    OBJ_HEAD  header;
    realtype  rxMin;               // scaling values
	realtype  rxMax;
	realtype  ryMin;               // scaling values
	realtype  ryMax;
    realtype  rxLMin;               // scaling values
	realtype  rxLMax;
	realtype  ryLMin;               // scaling values
	realtype  ryLMax;
	realtype  rRelBarWidth;       // width relative to plot area
								  // scatter plot parameters
	int     nOrigMarkerSize;    // marker size in points at the time of creation or
	int     nMarkerSize;        // size of marker in points
	int       nMarkerLogSize;     // size of marker in logical units
	long     nMarkerColor;       // Marks' color (Scatter plot)
	int     nMarkerShape;
    int       nMarkerStyle;       // MKS_FULL, MKS_CDOT, etc. Also bar border flag
	int       nLineMarkerSkip;    // line marker skip factor
	int       nLineMarkerStart;    // start index for first marker in line marker plot
	HDATA     hDataSet;           // handle for data set descriptor
    int     nDataWidth;         // number of characters in a data field
    int     nDataPrec;          /* data precision for data table,
                                     clipboard export */
    XYDATA_DEF FAR *pxyDesc;      // data set descriptor
    HGLOBAL   hMemLogData;        /* memory handle to array of actual
									 points (logical coords) */
    HGLOBAL   hMemLogData2;       /* memory handle to array of calculated
                                     points (logical coords) */
    int       yInt;               // Logical y corresponding to intercept
    BOOL      bJustify;           // bar relative position
    BOOL      bReserved;          // bar relative position
    BOOL      bUpdateAxes;
    UINT      wSelPoint;          // sequential number of selected point

    UINT      wNumPointsPrev;     // number of points previously displayed
 //   char      resDyn [6];  
	//UPGRADE-52098 [LAB] ----V moved to the "common" section
	char      szBmpName[MAXBMNAMELEN];  // name of the bitmap	// UPGRADE8 [DMB] - for WGScatterPlotEx
	char      szMetaName[MAXBMNAMELEN]; // name of the metafile // UPGRADE8 [DMB] - for WGScatterPlotEx vv
	//UPGRADE-52098 [LAB] ----^

/*------------------------------------------------------------------------*/
    BOOL      cFill;              // FLAG FOR FILLING AREA UNDER LINE
    int       nNumSplinePoints;  
	realtype  rBarWidth;          // bar width in phys units
    COLORREF  rgbBarColor;        // for Bargraph
    int      cHatchStyle;        // bar brush hatch style
    BOOL      cSpline;            // FLAG FOR cubic spline interpolation
    BOOL      cDrop;              // For scatter plot - drop down flag
    int       nStep;              // NO_STEP, STEP_END, or STEP_START  //UPGRADE2 [DMB] - for WGLinePlotEx
    HGOBJ     hImage;             // handle to related image (bitmap, metafile) object 
	BOOL	  bMulti;			  // flag to indicate use of multiple colors in simple plot objects	 // UPGRADE56 [DMB]
    COLORREF  *pRGBColors;        // UPGRADE56 [DMB]
	
/*------------------------------------------------------------------------*/
/* Dynamic area								  */ 
/*------------------------------------------------------------------------*/
    int       xyPrev;             // previous value
//    char      reserved [16];  
}
OBJ_PLOT;

/**************************************************************************/
#ifndef MAXGROUPLEN
	#define MAXGROUPLEN  32
#endif

typedef struct                   /* Group objects */
{
    OBJ_HEAD  header;
    realtype  rxMin;               // scaling values
    realtype  rxMax;
	realtype  ryMin;      
    realtype  ryMax;
    realtype  rxLMin;               // scaling values
	realtype  rxLMax;
	realtype  ryLMin;               // scaling values
	realtype  ryLMax;
    realtype  rRelBarWidth;       // bar width relative to plot area
	int     nOrigMarkerSize;    // marker size in points at the time of creation or
    int     nMarkerSize;        // size of marker in points
    int       nMarkerLogSize;     // size of marker in logical units
    long     nMarkerColor;       // Marks' color (Scatter plot)
    int     nMarkerShape;
    int       nMarkerStyle;      // MKS_FULL, MKS_CDOT, etc. Also bar border flag
	int       nLineMarkerSkip;    // line marker skip factor
	int       nLineMarkerStart;    // start index for first marker in line marker plot
    HDATA     hDataSet;          // handle for data set descriptors
    int     nDataWidth;        // number of characters in a data field
    int     nDataPrec;         /* data precision for data table,
                                    clipboard export */
    XYDATA_DEF FAR *pxyDesc;     // data set descriptor
    HGLOBAL   hMemLogX;      // memory handle to array of X (logic. coords)
                // up to this place must be identical with OBJ_CURVE

    HGLOBAL   hMemLogY; // memory handle to array of Y (logic. coords)
    int       yInt;               // Logical y corresponding to intercept
    BOOL      bJustify;
    BOOL      bReserved;
    BOOL      bUpdateAxes;

    UINT      wSelPoint;          // sequential number of selected point

	realtype  rBarWidth;          // bar width in phys units
    UINT      wNumPointsPrev;     // number of points previously displayed
 //   char      resDyn [6];  
	//UPGRADE-52098 [LAB] ----V added to the "common" section
	char      szBmpName[MAXBMNAMELEN];  // name of the bitmap	// UPGRADE8 [DMB] - for WGScatterPlotEx
	char      szMetaName[MAXBMNAMELEN]; // name of the metafile // UPGRADE8 [DMB] - for WGScatterPlotEx vv
	//UPGRADE-52098 [LAB] ----^
/*------------------------------------------------------------------------*/
    int      bGroupType;
    int       cyZero;           // Y in logical units for 0.0

	realtype  rXOff;			// UPGRADE4 [DMB] - Waterfall plot
	realtype  rYOff;			// UPGRADE4 [DMB] 
	BOOL	  bBaseline;		// UPGRADE4 [DMB]
	BOOL	  bOutline;			// UPGRADE4 [DMB]  
    BOOL      bFill;

	BOOL	  bMulti;			  // flag to indicate use of multiple colors in group plot objects	 // UPGRADE56 [DMB]
    COLORREF  *pRGBColors;        // UPGRADE20 [DMB]

    LINEDESC  ld[MAXGROUPLEN];    // descriptors for lines or bar borders
    COLORREF  rgbBarColor[MAXGROUPLEN]; 
    COLORREF  rgbTempColor; // used to pass value back for BW chart color dialogs
    realtype  rContourValues[MAXGROUPLEN]; 
	BOOL      bContourLineFlags[MAXGROUPLEN];
	BOOL      bContourLabelFlags[MAXGROUPLEN];
    int       nNumContours;
	BOOL      bLabelContourColor;
    int       nLabelXAlignment, nLabelYAlignment;
	int       nBitmapGranularity;
	int       nLabelPrec;
	BOOL      bFirstContourUpdate;
    int      nLabelAlignment;
	polysurfacetype *psf;
    HBITMAP hContourBM;
	int       nOrigBMWidth, nOrigBMHeight;
    TEXTDESC  TextDesc;           // pointer to related labels object
    int      cHatchStyle[MAXGROUPLEN];
    int     nSelGroup;          // selected group number  
 //   char      reserved [20];  

	//UPGRADE-51198 [LAB] ----V
	int     nOpenOrigMarkerSize;    // marker size in points at the time of creation or
	int     nOpenMarkerSize;        // size of marker in points
    int       nOpenMarkerLogSize;     // size of marker in logical units
    long      nOpenMarkerColor;       // Marks' color (Scatter plot)
    int     nOpenMarkerShape;
    int       nOpenMarkerStyle;      // MKS_FULL, MKS_CDOT, etc. Also bar border flag

    
	/*--------ADDITIONS FOR BOX & WHISKER PLOT---------------------*/
	int     nMidPointType;
	int     nBoxType;
	int     nWhiskerType;
	int     nWhiskerSize;
	int     nWhiskerLogSize;

	int     nBoxOutlineColor;
	int     nBoxSize;
	int     nBoxLogSize;
	
	SCATTER_DESC pMidPtMarkDesc; 
	SCATTER_DESC pOutMarkDesc;    
	SCATTER_DESC pExtMarkDesc;
    
	BOOL      cOutlier;
	BOOL      cExtreme;
	BOOL      cBoxFill;

	realtype  nMidPointCoef;
	realtype  rBoxCoef;
	realtype  rBoxPerMin;
	realtype  rBoxPerMax;
	realtype  rBoxConst;

	realtype  rWhiskerCoef;
	realtype  rWhiskerPerMin;
	realtype  rWhiskerPerMax;
	realtype  rOutlierCoef;

    int nWhiskerColor;
	int nWhiskerStyle; 
	int nWhiskerWidth;

	LPREAL lpBWY; //Calculated values
	//UPGRADE-51198 [LAB] ----^

}
OBJ_GROUP;

/**************************************************************************/

#define MAXPIE          32

/*********************************************************************/

typedef struct                   /* Pie slice descriptor */
{
    realtype  rVal;         // value
    COLORREF  rgbPieColor;
    LINEDESC  ld;           // border
    BOOL      fExplode;     // explode flag
    float     rExplodeRel;  // relative distance of exploded slice from center
    char      szTitle[LG_MAXLEN];
    int      cHatchStyle;
    BOOL      cBorder;
 //   char      Reserved[2];

} PIE_DESC;

/**************************************************************************/
typedef struct                   /* Legend descriptor */
{
    HGOBJ hObj;
    char  szLegend[LG_MAXLEN];

}   LEGEND_DESC;

/**************************************************************************/
typedef struct                   /* Legend object */
{
    OBJ_HEAD  header;
    TEXTDESC  tdesc;               // font for legends
    int     nNumObjects;         // number of objects
    int     nMaxChar;            // Max legend length (characters)   
    int     nLongest;            // Number of the longest legend
    long      nBackColor;
    int       cxMaxExt;            // width of the widest field
    int       cyChar;              // screen character height
    int       cxWidth;             // width of one legend field
    int     nLayout;             // OR_VERT or OR_HORZ
    int     nLegType;            // LG_CHART or LG_GROUP
    BOOL      bBorder;             // legend rectangle border flag
    LPSTR     pLegends;
 //   char      reserved [7];
    BOOL      cNoSym;              // if 1, do not draw symbols

// Up to here must be same as DYNOBJ_LEGEND

	//COLORREF  rgbBackColor;			// UPGRADE7 [DMB]
	int		  nMarkerLogSize[MAXLEGEND]; // debbie fix

	COLORREF  pLegTextColor[MAXLEGEND]; // UPGRADE7 [DMB]
	int		  pLegSymShape[MAXLEGEND];  // UPGRADE7 [DMB]
	COLORREF  pLegSymColor[MAXLEGEND];  // UPGRADE7 [DMB]

	int		  pLegSymSize[MAXLEGEND];
	int		  pLegSymStyle[MAXLEGEND];
	BOOL	  bFlex;				// UPGRADE7 [DMB]
	BOOL	  bSym;					// UPGRADE7 [DMB]
	int		  nSelSym;				// UPGRADE7 [DMB] - index of selected symbol  

 	LEGEND_DESC  ldesc[2];     

}
OBJ_LEGEND;

/**************************************************************************/
typedef struct                   /* Pie chart object */
{
    OBJ_HEAD  header;
    TEXTDESC  tdesc;               // font for numbers 
    float     rRelX;               // scaling values
    float     rRelY;      
    float     rRelDiam;            // diameter relative to plot area
    HGLOBAL   hMemData;            // HGOBJ to real data array
    int     nNumPoints;
    int     nNumType;            // type of number display   
    int     nNumPos;             // number position - inside or out
    int     nSel;                // last selected slice
    LPREAL    lpData;              // pointer to data array 
 //   char      reserved [6];
    PIE_DESC  pdesc[3];     
}
OBJ_PIECHART;

/**************************************************************************/
typedef struct                   /* straight line object */
{
    OBJ_HEAD  header;
    BOOL      fRedraw;           // redraw flag
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    RECT      rc;               // ideal bounding rectangle    
//    char      reserved [2];
}
OBJ_LINE;

typedef struct                   /* arrow object */
{
    OBJ_HEAD  header;
    BOOL      fRedraw;           // redraw flag
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    RECT      rc;               // ideal bounding rectangle    
    int     nArrowLength;     // arrow length and width in points
    int     nArrowWidth;
    int       nArrowLogLength;  // arrow length and width in logical units
    int       nArrowLogWidth;

    BOOL      bFill;            // if TRUE, arrow is filled
    BOOL      fStart;           // if TRUE, arrow at line beginning
    BOOL      fEnd;             // if TRUE, arrow at line end
//    char      reserved [2];
}
OBJ_ARROW;

typedef struct                   /* rectangle object */
{
    OBJ_HEAD  header;
    BOOL      fRedraw;          // redraw flag
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    COLORREF  rgbBackColor;        
    BOOL      cFill;              // FLAG FOR FILLING BACKGROUND
	int      cHatchStyle;
    int      c3D;                // 3D code
 //   char      reserved [8];
}
OBJ_RECT;

typedef struct                   /* arc and pie object */
{
    OBJ_HEAD  header;
    BOOL      fRedraw;          // redraw flag
    int       x1;
    int       y1;
    int       x2;
    int       y2;      
    int       x3;
    int       y3;
    int       x4;
    int       y4;
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    realtype  rX3;
    realtype  rY3;
    realtype  rX4;
    realtype  rY4;

    COLORREF  rgbBackColor;        
    BOOL      cFill;               // FLAG FOR FILLING BACKGROUND
	int      cHatchStyle;

 //   char      reserved [9];
}
OBJ_ARC;

typedef struct                   /* polygon object */
{
    OBJ_HEAD  header;
    BOOL      fRedraw;             // redraw flag
    int       nNumPoints;          // polygon size
    LPPOINT   lpLogData;           // array of points
	LPREAL    prX;                 // pointers to data
	LPREAL    prY;

	COLORREF  rgbBackColor;        
	BOOL      cFill;               // FLAG FOR FILLING BACKGROUND
	int      cHatchStyle;
    BOOL      cRestored;           // POLYGON restored from file - free data on exit 
	char      reserved [8];
}
OBJ_POLYGON;


typedef struct                   /* bitmap object */
{
	OBJ_HEAD  header;
	BOOL      fRedraw;          // redraw flag
	realtype  rX1;
	realtype  rY1;
	realtype  rX2;
	realtype  rY2;
	int       nMode;
	char      szName[MAXBMNAMELEN];  // name of the bitmap
	char      reserved [9];
}
OBJ_BMP;

typedef struct                   /* metafile object */
{
	OBJ_HEAD  header;
	BOOL      fRedraw;          // redraw flag
	realtype  rX1;
	realtype  rY1;
	realtype  rX2;
	realtype  rY2;
	int     nMode;
	char      szName[MAXBMNAMELEN];  // name of the metafile
//	char      res1;
	POBJ_META pDescMeta;
	HMETAFILE    hmf;                    // metafile handle
	EXT_MFHEADER ExtHeader;              // EXTENDED HEADER
	char      reserved [8];
}
OBJ_MFILE;


typedef struct                   /* data cursor object */
{
	OBJ_HEAD  header;
	BOOL      fRedraw;          // redraw flag
	realtype  rX1;              // cursor position
	realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    RECT      rc;               // ideal bounding rectangle    

    realtype  rX;
    realtype  rY;  

    realtype  rRangeX;
    realtype  rRangeY;

    int     nOrigSize;
    int     nSize;  
	OBJ_AX    FAR* pXAxDesc;
    OBJ_AX    FAR* pYAxDesc;
}
OBJ_DCURSOR;

#if 0
/************************************************************************/
/* Dynamic objects (RT Tools)                                           */
/************************************************************************/
typedef struct                     // common header
{
   int   nType;                  // object type
   int   nSubType;               // object subtype 
   HGOBJ  (_cdecl FAR *lpfnObj) (LPVOID, HDC); // function drawing the object
   RECT    rcBoundary;             // object limits in device coordinates
   HGOBJ  hObj1;                   // handles of associated objects (axes) 
   HGOBJ  hObj2;
   LINEDESC ld;
   HGOBJ  (_cdecl FAR *lpfnDynObj) (LPVOID, LPVOID); // update func.
   DWORD   dwLastUpdate;           // seconds count for last update
   int    wUpdatePer;             // update period in seconds
   BOOL    fInverse;
   BOOL    fShow;                  // if = 0, hide object 
   BOOL    bCompoundObj;
   int    nUserID;
}
DYNOBJ_HEAD;
typedef DYNOBJ_HEAD far *PDYNOBJ_HEAD;
#endif

/**************************************************************************/
/* DYNAMIC OBJECTS DESCRIPTORS ********************************************/
/**************************************************************************/

typedef struct                   
{
	DYNOBJ_HEAD header;
	OBJ_AX  FAR *pAxDesc;         // pointer to related axis descriptor
    int     nUpdatePer;           // update period, in seconds
}
DYNOBJ_GRIDS;

/**************************************************************************/
/* alarm display structure ************************************************/
/**************************************************************************/
typedef struct                     // dynamic element descriptor
{
    char      szAlarmName [MAX_ALMNAME]; // alarm name
    BOOL      bOn;                 // display flag
    int       cyAl;                // logical coordinate
    LINEDESC  ld;                  // line descriptor
}
ALARM_DISP;

/**************************************************************************/

typedef struct                   
{
	DYNOBJ_HEAD header;
    realtype  rxMin;              // scaling values
    realtype  rxMax;
    realtype  ryMin;              // scaling values
    realtype  ryMax;
    realtype  rXRange;            // range of X
    realtype  rYRange;            // range of Y
    int       nDir;               // direction - left, right, up, or down
    OBJ_AX FAR *pXAxDesc;         // pointers to descriptors of associated axes 
    OBJ_AX FAR *pYAxDesc;

/* Up to here must be like plot object */
/*__________________________________________________________________________*/
    PDYNDATA  lpDataDesc;       // data descriptor
	ALARM_DISP alDesc [NALMLINES];  /* alarm descriptors - Setp, High, Low, 
									 	  HighHigh, LowLow */
}
DYNOBJ_ALARMLINES;
/**************************************************************************/    
typedef struct                   
{
	DYNOBJ_HEAD header;
    realtype  rxMin;              // scaling values
    realtype  rxMax;
    realtype  ryMin;              // scaling values
    realtype  ryMax;
    realtype  rXRange;            // range of X
    realtype  rYRange;            // range of Y
    int       nDir;               // direction - left, right, up, or down
    OBJ_AX FAR *pXAxDesc;         // pointers to descriptors of associated axes 
    OBJ_AX FAR *pYAxDesc;

/* Up to here must be like plot object */
/*__________________________________________________________________________*/
    DYNDATA_DEF FAR *lpDataDesc;       // data descriptor
    ALARM_DISP alDesc [NALMLINES];     /* alarm descriptors - High, Low, Setp,
                                          HighHigh, LowLow */
    int     nOrigMarkSize;      // mark size in points
    int     nMarkSize;          // mark size in points (changes when graph resized)
    int       nLogMarkSize;       // mark size in logical units
    TEXTDESC  tdesc;              // text descriptor
    int     nPos;               // position relative to axis
    OBJ_AX FAR *pAxDesc;
}
DYNOBJ_ALARMMARKS;
/**************************************************************************/    
typedef struct                     /* Labels */
{
    DYNOBJ_HEAD  header;
    TEXTDESC  tdesc;              // text descriptor, must follow header !
    int     nLabelPos;          // position of labels relative to axis
    int     nDir;               // can be OR_VERT or OR_HORZ
    int     nLast;              // last label flag
	int     nStyle;             //
    HGLOBAL   hStr;               // handle to array of strings
    LPSTR     lpStr;              // pointer to array of strings
    int      nFormat;            // DLB_NUMERIC, DLB_HMS, etc.
    int      cPrec;              /* # of digits after. */
    BOOL      fPrecMan;           /* if on, precision is set manually. Also,
                                     if on - show only 3 characters
                                     for month or day of week labels */
    int       nStringExt;         // Largest label string length
    int       nStringExt2;        // for scientific notation, length of exponent.
    int      bFirstTick;         // # of tick where first month is displayed
    char      szTextLast[40];     // Text String  for last label
    OBJ_AX FAR *pAxDesc;
    realtype  rStartNum;          // starting value, always in seconds for time formats
                                  // When time format is used, this is the # of seconds
    realtype  rHistStartNum;      // Used in history mode instead of rStartNum
    realtype  rNewHistStart;  
    int      bStartHour;         // starting time for first tick
    int      bStartMin;
    int      bStartSec;
    BOOL      bFreeze;
    char      reserved4 [4];  
}
DYNOBJ_LABELS;

/**************************************************************************/

typedef struct
{
    DYNOBJ_HEAD header;
    realtype  rxMin;              // scaling values
    realtype  rxMax;
    realtype  ryMin;              // scaling values
    realtype  ryMax;
    realtype  rXRange;            // range of X
    realtype  rYRange;            // range of Y
    int       nDir;               // direction - left, right, up, or down

    OBJ_AX FAR *pXAxDesc;         // pointers to descriptors of associated axes 
    OBJ_AX FAR *pYAxDesc;

/*__________________________________________________________________________*/

    DYNOBJ_LABELS FAR *pLabDesc1;   // time labels that automatically update
    DYNOBJ_LABELS FAR *pLabDesc2;   // at the time of scroll reset.
    DYNOBJ_LABELS FAR *pLabDesc3;

    int     nTraces;            // number of traces
    int     nStep;              // NO_STEP, STEP_END, or STEP_START 
    BOOL      bX;                 // if TRUE, use x values instead of time
    realtype     rRelBarWidth;       // relative bar width. For logic - rel. height
    int       nGraphSubType;      // 1 = bar 2 line
 	int       nLogHighAlarm;
	int		  nLogLowAlarm;
    int		  nTraceColorAlarmMode;
   int       xyBarWidth;         // for scr. bars - bar width in log. units, for sweep - # to restore
    int       xyBarStart;
    HGOBJ     hDynText;           // handle to attached dynamic text object,
                                  // or NULL
    DYNDATA_DEF FAR *lpDataDesc;  // pointer to data descriptor
	BOOL      bReinit;            // if TRUE, reinitialize object (bar) 
	BOOL      bBitBltFlag;
	/*__________________________________________________________________________*/
    LINEDESC  ld[DYN_MAXVAL];     // trace line descriptors
    realtype  rCenterPoint;       // Y of bar center point
   DYNDATA_DEF FAR *lpSaveDataDesc;  // pointer to saved data descriptor
    realtype  rSampleInt;         // sample interval (in units of X)
	float     rRelResetInt;       // relative reset interval for scrolling - 0 - 1.0
	float     rAbsResetInt;       // absolute reset interval(time) for scrolling
	int       nMaxDispPts;        // max. number of points displayed
	int       nNumResetInt;       // number of displayed intervals before reset  
	int       nResetCount;        // reset counter;
	int       nFromBase;          // index to first element after reset
	int       nIndexLast;         // index to last set of coordinates in
								  // logical circular buffer 
    int       nIndexPrev;
	int       nSelectedChan;      // selected trace 
    UINT      wRealTo;            // index to real values buffer
    BOOL      bReset;             // TRUE after first screen reset  
    BOOL      bHistFull;          // TRUE after data array is first filled  
    HGLOBAL   hLogDep;            /* memory handle to array of actual
                                     Y points (logical coords) */
    HGLOBAL   hLogPts;            // memory handle to array of points to plot actual
    HPPOINT   lpPlot;             // array of points
    HGLOBAL   hRealData;          // memory handle for historical data array
    HPFLOAT   hpRealData;         // pointer to historical data array  
    HPINT     lpLogDep;           // array of logical coordinates
    HGLOBAL   hLogInd;            // memory handle to X for XY plot
    HPINT     lpLogInd;           // array of logical coordinates of X

    COLORREF  rgbBarColor;
    int       nLogHeight;         // height of logical trace
    UINT      wFirst;
    int       nSavResetCount;     // save for hist. - restore

    BOOL      bResetFlag;
    DYNOBJ_ALARMLINES * pAlarmLinesDesc; 
    realtype  rBarOffset;
	realtype  rBarWidth;
	int       nSweepRestore;
    int       nLogInterBarOffset;
	int       nRTScatterSym[DYN_MAXVAL];      // RT Scatter symbol
	int       nRTScatterSize[DYN_MAXVAL];      // RT Scatter symbol
	int       nRTScatterOrigSize[DYN_MAXVAL];
	int       nRTScatterStyle[DYN_MAXVAL];      // RT Scatter symbol
 	BOOL      bSkipPoint[DYN_MAXVAL];      // skip point flags
    BOOL      bBorder;  
    BOOL      bFreeze;            // if this flag is TRUE, stop updates (hist. data)  
                                  // portion of plotting area  
    char      reserved [6];  
}
DYNOBJ_SCROLL;

/************************************************************************************/
/* This structure must be identical to DYNOBJ_SCROLL up to rRelBarWidth               */
/************************************************************************************/
typedef struct
{
    DYNOBJ_HEAD header;
    realtype  rxMin;              // scaling values
    realtype  rxMax;
    realtype  ryMin;              // scaling values
    realtype  ryMax;
    realtype  rXRange;            // range of X
    realtype  rYRange;            // range of Y
    int       nDir;               // direction - left, right, up, or down

    OBJ_AX FAR *pXAxDesc;         // pointers to descriptors of associated axes 
    OBJ_AX FAR *pYAxDesc;
    
/*__________________________________________________________________________*/

    DYNOBJ_LABELS FAR *pLabDesc1;
    DYNOBJ_LABELS FAR *pLabDesc2;
    DYNOBJ_LABELS FAR *pLabDesc3;

    int     nTraces;            // number of traces
    int     nStep;              // NO_STEP, STEP_END, or STEP_START 
    BOOL      bX;                 // if TRUE, use x values instead of time
    realtype  rRelBarWidth;       // relative bar width. 
    int       nGraphSubType;      // 1 = bar 2 line
	int       nLogHighAlarm;
	int		  nLogLowAlarm;
    int		  nTraceColorAlarmMode;
    int       xyBarWidth;         // bar parameters in logical units
    int       xyBarStart;
    HGOBJ     hDynText;           // handle to attached dynamic text object,
								  // or NULL
	DYNDATA_DEF FAR *lpDataDesc;  // pointer to data descriptor
    BOOL      bReinit;            // if TRUE, reinitialize object      
	BOOL      bBitBltFlag;
    LINEDESC  lpLd[DYN_MAXVAL];          // pointer to line descriptors
    realtype  rCenterPoint;       // Y of bar center point
/*__________________________________________________________________________*/

    DYNOBJ_ALARMMARKS * pAlarmMarksDesc; 
	BOOL      bBarBorder;
	realtype  rFirst;   	      // X for the first bar
	realtype  rLast;              // X for the last bar
    int       nLogPos    [DYN_MAXVAL];  // independent variable (pos)
    int       nLogDepCurr[DYN_MAXVAL];  // current logical values
    int       nLogDepPrev[DYN_MAXVAL];  // previous logical values
    COLORREF  rgbBarColor[DYN_MAXVAL];  // bar colors
	char      cHatchStyle[DYN_MAXVAL];  // hatch styles
    int     nSelectedChan;            // selected channel
    int       nLineStyle;
	int       nLineWidth;
 	realtype  rBarWidth;          // bar width in phys units
   char      reserved [16];  
}
DYNOBJ_BAR;

/****************************************************************************************/
typedef struct                 // compound annunciator object  
{
	DYNOBJ_HEAD header;
    PDYNDATA    lpDataDesc;     // data descriptor
// Rev 3.0 adds 
	int nFontSize;
	int nNumRows;
    int nNumColumns;
	int nValWidth;
	int nPrec;
	int nTraces;
	int n3D;
	COLORREF rgbLowAlmColor;                            
// 
	COLORREF rgbBackAlmColor;   // Rectangle background color when in alarm: NOW High Alarm
    COLORREF rgbColor[DYN_MAXVAL];  // Rectangle background normal colors
    int nChanColor[DYN_MAXVAL];  // Rectangle background normal colors
    HGOBJ hTitle;              // handle to title text
    HGOBJ hRect [DYN_MAXVAL];  // handles to rectangle objects
    HGOBJ hTags [DYN_MAXVAL];  // handles to text objects for tag names
    HGOBJ hVal  [DYN_MAXVAL];  // handles to dynamic text objects for values
    HGOBJ hUnits[DYN_MAXVAL];  // handles to text objects for units
    HGOBJ hAlm  [DYN_MAXVAL];  // handles to alarm text objects
	BOOL lpFlags[8];
    BOOL  bFirst;  
}
DYNOBJ_ANNUNC;

/****************************************************************************************/
#define   METER_MAXN    5          // Max. number of needles

typedef struct                     // meter needle descriptor
{
    int   nCurAng;
    int   nPrevAng;
    float   rCurSin;             // current sine and cosine
    float   rCurCos;            
    float   rPrevSin;
    float   rPrevCos;
    int     cxFrontLength;
    int     cxBackLength;
    long    rgbColor;              // needle color
    long   nColor;
}
NEEDLE;

typedef struct                   
{
	DYNOBJ_HEAD header;
    TEXTDESC  tdesc;            // text descriptor
    BOOL      fRedraw;          // redraw flag
    int       x1;               // arc coordinates
    int       y1;
    int       x2;
    int       y2;      
    int       x3;
    int       y3;
    int       x4;
    int       y4;
    int       xCenter;
    int       yCenter;
    int       cxRadius;
    int       cxTick;           // tick length

    float     rX1;              // arc relative coordinates   - ??? 
    float     rY1;
    float     rX2;
    float     rY2;
    float     rX3;
    float     rY3;
    float     rX4;
    float     rY4;
    float     rXCenter;
    float     rYCenter;  
    float     rXRadius;
    float     rYRadius;  

    int     nStartAngle;      // limiting angles in degrees
    int     nEndAngle;  
    int     nHighAlmAngle;    // alarm limit angles
    int     nLowAlmAngle;
    int     nHighHighAlmAngle;    // alarm limit angles
    int     nLowLowAlmAngle;

// Added for BMC Software - Set starting points of alarm arcs (not minscale and maxscale).
	int     nStopHighAlmArcValue;
	int	  nStartLowAlmArcValue;
	realtype  rStopHighAlmArcValue;
	realtype  rStartLowAlmArcValue;
// End of add for BMC software

    float     rTickRelSize;      // size of major tick marks relative to diameter
    float     rAngleRatio;

    realtype  rMinVal;           // scaling values
    realtype  rMaxVal;
    realtype  rCenterPoint;      // for arc and pie meters - center value
    realtype  rTickSpace;        // distance between major ticks in EU
    int       nDigitHeight;  
    int     nSmallTicks;       // # of minor ticks between major ones
    int     nTickPos;          // relative position (outside, inside, middle)
    int     nLabelPos;         // labels relative position (outside, inside)
    PDYNDATA  lpDataDesc;          // data descriptor
    HBITMAP   hBitmap;             // handle to meter bitmap 
    NEEDLE    Needle[METER_MAXN];  // needle descriptors
    long     nAlmColor [6];       // alarm arc colors  
    int       cxAlmArcWidth;
    LINEDESC  ldBorder;            // line descriptor for border
    COLORREF  rgbMeterBackColor;   // background color   
	realtype  rXBorderCenter;      // remeber meter border position
    realtype  rYBorderCenter;
    realtype  rXBorderWidth;
    realtype  rYBorderHeight;      // ignored for circle
	realtype rAlmRelThick;  // New
    int       cxNeedleMaxWidth;
    int       cxNeedleLineWidth;  // needle or arc width
    int      cChan;              // channel #
    int      cText;
    int      cLabelPrec;         /* # of digits after . for labels */
    int      cValPrec;           /* # of digits after . for dynamic text */
    int      cNeedleType;
    int      cMeterBorderType;   // 0 - no border, 1 - Circle, 2 - Square, 3 - Rd Square
    int      cArc;               // 0 - no arc
    int      cUnits;             // 0 - no units text
    int      cAlarms;            // 0 - no alarms      
    int      cCircle;            /* if 1, meter is full circle */
    int      cDir;               /* if rMaxVal > rMinVal, it is 1, othervise -1 */
	int      nTraces; // New
}
DYNOBJ_METER;

/**************************************************************************/
typedef struct                   /* Dynamic Text object */
{
    DYNOBJ_HEAD  header;
    TEXTDESC  tdesc;               // font for text
    int     nNumObjects;         // number of objects
    int     nDataWidth;          // Max text length (characters)
    int     nDataPrec;           /* data precision */ 
    long     nBackColor;          // background color, -1 - transparent
    int       cxMaxExt;
    int       cyChar;              // screen character height
    int       cxWidth;             // width of one text field
    int     nLayout;             // OR_VERT or OR_HORZ
    int     nUpdateFlag;         // forces update
    BOOL      bBorder;             // legend rectangle border flag
    int      c3D;                 // 3D code Moved from below as part of FIX 7/15/96
    PDYNOBJ_HEAD pDynObj;          // dynamic object descriptor    
    PDYNDATA  lpDataDesc;          // data descriptor

    UINT      wAlign;
    char      cColor[DYN_MAXVAL];
    int     nChan;               // channel #, if -1 - all channels 
    int      cXAuto;              // if not 0, object boundaries are  
    int      cYAuto;              // calculated automatically 
    int     nSelectedChan;       // selected channel
    int       cxBorder;            // border width   
    int       cyBorder;            
    char      reserved [5];
}
DYNOBJ_TEXT;
/*******************************************************************/
typedef struct      // message descriptor
{
    int   cxExt;
    long nColor;   
    char  szMes[MAX_MESLEN]; 
}
MES_DESC;
/**************************************************************************/
typedef struct                     /* Message Text object */
{
    DYNOBJ_HEAD  header;
    TEXTDESC  tdesc;               // font for text
    int     nNumObjects;         // number of objects
    int     nDataWidth;          // Max text length (characters)
    int     nDataPrec;           /* data precision */ 
    long     nBackColor;          // background color, -1 - transparent
    int       cxMaxExt;
    int       cyChar;              // screen character height
    int       cxWidth;             // width of one text field
    int     nLayout;             // OR_VERT or OR_HORZ
    int     nUpdateFlag;         // forces update
    BOOL      bBorder;             // legend rectangle border flag
    int      c3D;                 // 3D code Added FIX 7/15/96
    PDYNOBJ_HEAD pDynObj;          // dynamic object descriptor    
    PDYNDATA  lpDataDesc;          // data descriptor
    int     nBinChanNum;         // binary channel #  
    realtype rX;                 // New
	realtype rY;                 // New
    int     nNumMes;             // number of messages     
    int     nCurMes;             // current active message #     
    int     nPrevMes;            // previous active message #     
    MES_DESC  mesDesc[MAX_MESNUM]; // message descriptors
}
DYNOBJ_MESSAGE;

/**************************************************************************/
typedef struct                   
{
    HWND    hwndRBut;          // radio button window handle
    HBRUSH  hBrush;  
    COLORREF  rgbBkColor;      // control background color
    char    szText[TAGLEN];  // button text  
}
RBUTTON_DEF;
typedef RBUTTON_DEF far *PRB_DEF;

typedef struct                   
{
	DYNOBJ_HEAD header;
    TEXTDESC  tdesc;        // font for legends
    HWND      hwndParent;   // control parent's (graph) window handle
    HWND      hwndCtl;      // control window handle (if not a group)
    realtype  rX1;          // bounding rectangle, graph normalized coordinates
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    COLORREF  rgbBkColor;   // control background color
    BOOL      bTextLeft;    // if TRUE, text positioned at the left of radio button or CB
          
    int     nRButNum;     // number of buttons in a group
    int     nDir;         // button orientation in a group - OR_VERT or OR_HORZ
    int     nSel;         // selected button number, or state flag for 
                            // single buttons (0 - up, or non checked)
	int      nControlType;   // Specific Control Type
    int      cStyle;       // logic type - BC_STYLE_PUSH, BC_STYLE_ONOFF, BC_STYLE_XOR
    int      cLook;        // appearance - BC_LOOK_LOW, BC_LOOK_HIGH, BC_LOOK_RADIO, 
                            // BC_LOOK_CHECK 
    PRB_DEF   lpRButDesc;   // pointer to array of XOR button descriptors
    HBRUSH    hBrush;  

                          // scrolling bar parameters
    realtype  rMin;         // minimal value in eng. units
    realtype  rRange;       // range in eng. units
    int       nScrollMin;
    int       nScrollMax;
    int       nPageStep;    // page increment  
    int       nPos;
	realtype  rDiam;
	char      szText[DYNTITLELEN];
    int (CALLBACK *lpfnControlHandler) (PGRAPH_DEF, HGOBJ, int, int); // callback function 
//    char      reserved [4];
}
DYNOBJ_CONTROL;

/***********************************************************************/
typedef struct
{
    PDYNDATA    lpOrig;
    PDYNDATA    lpCopy;
} PDD;

/***********************************************************************/
/* Function prototypes *************************************************/
/***********************************************************************/
#if 0
typedef HGOBJ CALLBACK  (*RESTDYNOBJ) (HFILE, PGRAPH_DEF, HDC, int, int);
typedef BOOL CALLBACK (*SAVDYNOBJ) (HFILE, PGRAPH_DEF, PDYNOBJ_HEAD);
#endif


// Window procedures 

LRESULT CALLBACK  _export PageProc  (HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK  _export GraphProc (HWND hwnd, UINT message, WPARAM wParam,
														   LPARAM lParam);
LRESULT CALLBACK  _export DataTableProc (HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK  _export EditProc (HWND, UINT, WPARAM, LPARAM);

/****************************************************************************/
// Mapping, coordinates, sizes	
/****************************************************************************/
void  InstallCoords (HDC hdc, DWORD mmode, int cxVExt,
	int cyVExt, int cxWExt, int cyWExt);
void  WINAPI _export MapGraph (PGRAPH_DEF pGrDesc, HDC hdc);

BOOL  LogToEng (PGRAPH_DEF pGrDesc, HGOBJ hAxisX, HGOBJ hAxisY,
     POINT pt, LPREAL lpX, LPREAL lpY);
BOOL   EngToLog (PGRAPH_DEF pGrDesc, HGOBJ hAxisX, HGOBJ hAxisY,
         realtype rX, realtype rY, LPINT lpX, LPINT lpY);
void  LineWidth (LINEDESC FAR *pLd, HDC hdc, int nWidth);
void  WINAPI _export WGExactPixel (HDC hdc, LPINT pcx, LPINT pcy);
int WINAPI _export OddPixel (HDC hdc, LPINT pcx, LPINT pHalf,
    int nDir);
int  WGOnePixel (PGRAPH_DEF pGrDesc, HDC hdc);
void WINAPI _export GetAbsPix (PGRAPH_DEF pGrDesc, LPINT lpcxPix, LPINT lpcyPix);
void WINAPI _export LegItemCoords (PGRAPH_DEF pGrDesc,
    OBJ_LEGEND  FAR *pLegDesc, int num, UINT wAlign, LPINT lpX, LPINT lpY);
void  WINAPI _export CalcLegendSize (PGRAPH_DEF pGrDesc, HDC hdc,
    OBJ_LEGEND  FAR *pLegDesc);

void CalcLineLog (PGRAPH_DEF pGrDesc, OBJ_LINE FAR *pObjDesc);
void SetRectPrim (PGRAPH_DEF pGrDesc, OBJ_LINE FAR *pObjDesc,
    HGOBJ hAxisX, HGOBJ hAxisY, realtype rX1, realtype rY1, realtype rX2,
    realtype rY2);
void CalcAxTitle (PGRAPH_DEF pGrDesc, OBJ_TEXT FAR *pTitleDesc);
BOOL WINAPI _export IsInsideRect (LPRECT lpRect, POINT Pt, PGRAPH_DEF pGrDesc);

/***************************************************************/
/* GDI SUPPORT								                   */
/***************************************************************/

HBRUSH WINAPI _export CreateBarBrush (HDC hdc, int nHatchStyle,
    COLORREF rgbBarColor);

HBRUSH WINAPI _export SelectSolidBrush (PGRAPH_DEF pGrDesc, HDC hdc,
    COLORREF rgbColor);

HPEN  WINAPI _export SelectPenIndirect (PGRAPH_DEF pGrDesc, HDC hdc,
    LPLOGPEN lpLogPen);

void WINAPI _export CleanGDI (HDC hdc);
void CleanPrinter (void);
void CleanFonts (void);

void WINAPI _export SetLine (LINEDESC FAR *pLd, HDC hdc,
    int nColor, int nStyle, int nWidth);
void FAR InitDlgColors (HWND hDlg, LPSTR szBuf);
COLORREF WINAPI _export CreateLighterColor (COLORREF rgbColor);

// void  GetFonts (HWND hwnd);
void  GetFonts (void);
void  UpdateFonts (void);
int  SetFont (LPLOGFONT lpLogFont, LPCSTR szFaceName);
void ClipPlot (PGRAPH_DEF pGrDesc, HDC hdc);
void UnclipPlot (PGRAPH_DEF pGrDesc, HDC hdc);

/**************************************************************************/
HWND  CreateChild (LPCSTR szClassName, PGRAPH_DEF pGraphDesc,
    HINSTANCE hInst);
HWND  CreatePageWindow (PPAGE_DEF pPageDesc,
    LPCSTR szClassName,
    HWND hwParent, HMENU hMenu, LPCSTR szCaption, DWORD dwWinStyle,
    int nPosStyle, int x, int y, int cx, int cy);  
PGRAPH_DEF WINAPI _export InitGraph (TOP_DEF FAR *lpTop,
    PPAGE_DEF pPageDesc, realtype rX1,
	realtype  rY1, realtype  rX2, realtype  rY2, int nColor,
    int  nBorderColor, int  nBorderWidth, void FAR *lpfnGraph);

PPAGE_DEF  WINAPI _export InitPage (LPCSTR lpName, HWND hwParent,
    LPSTR lpTitle, LPCSTR lpMenu, int nColor,
    int nSizeMode, DWORD dwWinStyle, int nPosStyle,
    int x, int y, int cx, int cy, 
    void FAR *lpfnPage);

/**************************************************************************/
// DATA 
/**************************************************************************/
void WINAPI _export DestroyCalcData (OBJ_PLOT  FAR *pObjDesc);
void DisconnectDataSet (PGRAPH_DEF pGrDesc, OBJ_PLOT *pObjDesc);
void ConnectDataSet (PGRAPH_DEF pGrDesc, OBJ_PLOT *pObjDesc, HDATA hDataSet);
HGLOBAL SplineInterp (PGRAPH_DEF pGrDesc,
	HPPOINT lpP, OBJ_PLOT FAR *pObjDesc);
BOOL  CompDataSetSize (HDATA hDataSet, LONG lNum);
void WINAPI _export FreeAllDataSets (BOOL bFreeData);
int  ConvertXY (PGRAPH_DEF pGrDesc, OBJ_PLOT  FAR *pObjDesc, 
	HPREAL rx, HPREAL ry, HPPOINT hpPoints, UINT nLen);
void DataChanged (OBJ_PLOT  FAR *pObjDesc);
HDATA WINAPI _export DefineAnyDataSet (LPSTR lpDataName,
    HGLOBAL  hIndep, HGLOBAL hDep, LONG lNumPoints, int nGroupSize,
    HPREAL hpX, HPREAL hpY);
int WINAPI _export GetPrec (realtype rNum);
void GetDataSize (HDATA hDataSet, LONG *pNumPoints, int *pGroupSize);
BOOL GetNearestPoint (HDATA hDataSet, realtype rX, realtype rY, int nMode, 
    LPREAL lpX, LPREAL lpY, LPREAL lpMinDist, UINT *lpNum);
BOOL IsDataPointGood (XYDATA_DEF *pxyDesc, UINT n);

/**************************************************************************/
/* GRAPH & PAGE SUPPORT */
/**************************************************************************/
void KillGraph (PPAGE_DEF pPageDesc, HGRAPH hGr);
void KillAllGraphs (void);
void WINAPI _export ExitApplication (void);
void WINAPI _export KillGraphPage (HGRAPH hPage);

PGRAPH_DEF WINAPI _export GetGrDescNum (PPAGE_DEF pPageDesc, int num);
PGRAPH_DEF WINAPI _export GetGrDescPtr (HGRAPH hGr);
PPAGE_DEF  WINAPI _export GetPgDescPtr (HGRAPH hPg);
void  UpdateAllGraphs (PPAGE_DEF  pPageDesc);
void  UpdateGraphSize (PGRAPH_DEF pGrDescNew,
    PGRAPH_DEF pGrDescPrev);
void WINAPI _export ShowGraphSelectors (PPAGE_DEF  pPageDesc, HDC hdc,
    int nAction);
void  SelectButton (PPAGE_DEF  pPageDesc);
BOOL  SaveAsDlg (HWND hwnd, LPSTR lpName, LPCSTR lpExt,
    LPCSTR lpTitle);
void WINAPI _export HighlightGraph (PPAGE_DEF  pPageDesc, HGRAPH hGraph);
void WINAPI _export ResizePage (HWND hwnd, int cxNewVExt, int cyNewVExt);
PPAGE_DEF WINAPI _export RestorePage (LPSTR lpFileName, HWND hwParent, LPSTR lpMenu);

/**************************************************************************/
/* OBJECT SUPPORT */
/**************************************************************************/
BOOL _cdecl DrawAxis (PGRAPH_DEF pGrDesc, HDC hdc);
HGOBJ _cdecl GroupPlot (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet);
HGOBJ _cdecl DrawLabels (PGRAPH_DEF pGrDesc, HDC hdc, HGOBJ hAxis,
	int nLabelPos, OBJ_LABELS FAR *pObjDesc);

OBJ_LABELS FAR * WINAPI _export StartLabs (PGRAPH_DEF pGrDesc, HDC hdc,
    HGOBJ hAxis, int nLabelPos, int nFirstTick, HGOBJ FAR *pObj);

HGOBJ _cdecl Plot (PGRAPH_DEF pGrDesc, HDC hdc, HDATA hDataSet);
HGOBJ _cdecl Text (PGRAPH_DEF pGrDesc, HDC hdc, LPSTR lpString,
		  int x, int y, UINT wAlign, int nOrientation);
void _cdecl DrawPies (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawLegends (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl StraightLine (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl Arrow (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawRectangle (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawEllipse (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawArc (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawPie (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl DrawPolygon (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl Bitmap (PGRAPH_DEF pGrDesc, HDC hdc);
void _cdecl Metafile (PGRAPH_DEF pGrDesc, HDC hdc);
BOOL _cdecl SameBrush(HDC hdc, COLORREF rgbColor);

OBJ_LEGEND  FAR * WINAPI _export InitLeg (PGRAPH_DEF pGrDesc, HDC hdc,
    HGOBJ hObj, realtype  rX1, realtype  rY1, realtype  rX2, realtype  rY2,
    UINT nNumObjects, int  nBorderColor, int  nBorderWidth, int nTextColor,  
	int  nBackColor, int nLayout, LPSTR lpLegends, BOOL bSymbols);

// UPGRADE7 [DMB] ----------v
void _cdecl DrawFlexLegends (PGRAPH_DEF pGrDesc, HDC hdc);

void DrawMark2 (PGRAPH_DEF pGrDesc, HDC hdc, LPLOGPEN lPen,
	LPPOINT lpPoint, int nMarkerShape, int nMarkerStyle, int half1, int half2);

OBJ_LEGEND  FAR * WINAPI _export InitFlexLeg (PGRAPH_DEF pGrDesc, HDC hdc,
    HGOBJ hObj, realtype  rX1, realtype  rY1, realtype  rX2, realtype  rY2,
    UINT nNumObjects, int  nBorderColor, int  nBorderWidth, //int nTextColor,  
	int nBackColor, int nLayout, COLORREF *lpTextColors,
	LPINT lpShapes, COLORREF *lpSymColors, PINT lpSymSizes, LPINT lpSymStyles, 
	LPSTR lpLegends, BOOL bSymbols);

HGOBJ WINAPI _export FlexLegend (PGRAPH_DEF pGrDesc, HDC hdc,
     realtype  rX1,           
     realtype  rY1,         
	 realtype  rX2,           
     realtype  rY2,           
	 
 	 UINT	nNumObjects,

     int       nBorderColor,  
     int       nBorderWidth,   
     int	   nBackColor,     
     int       nLayout, 

	 COLORREF *lpTextColor, 
	 LPINT	   lpSymShape,
	 COLORREF *lpSymColor,
	 LPINT	   lpSymSize,
	 LPINT	   lpSymStyle,

     LPSTR     lpStr,         
     HGOBJ     hObj);

// UPGRADE8 [DMB]
void _cdecl MyBitmap (PGRAPH_DEF pGrDesc, HDC hdc, OBJ_BMP *pTempObjDesc);
void _cdecl MyMetafile (PGRAPH_DEF pGrDesc, HDC hdc, OBJ_MFILE *pTempObjDesc);

// UPGRADE17 [DMB] ----------v
void TextBounds2 (PGRAPH_DEF pGrDesc, HDC hdc, OBJ_TEXT  FAR *pTextDesc);

POBJ_HEAD  StartObj(PGRAPH_DEF pGrDesc, int nType,
    int nSubType);
void WINAPI _export UpdateAxisStyle (PGRAPH_DEF pGrDesc, HGLOBAL hAxMem,
   OBJ_AX  FAR *pAxDesc);
int WINAPI _export ConnectAxLine (PGRAPH_DEF pGrDesc, OBJ_PLOT FAR *pCurveDesc);
HFONT WINAPI _export ConfigureText(PGRAPH_DEF pGrDesc, HDC hdc, LOGFONT FAR *plf,
    COLORREF rgbColor);
void TextBounds (PGRAPH_DEF pGrDesc, HDC hdc, OBJ_TEXT  FAR *pTextDesc);
void  WINAPI _export ConnectAxes (PGRAPH_DEF pGrDesc);
int WINAPI _export PointsToLogSize (PGRAPH_DEF pGrDesc, HDC hdc, int nPoints);
int WINAPI _export PointsToLogSize2 (PGRAPH_DEF pGrDesc, HDC hdc, int nPoints);
void WINAPI _export RoundAxis (int nRoundType, int nLen, LPREAL amin,
    LPREAL amax, LPREAL rTickSpace, int nAxDir);
void  RedrawAxes  (PGRAPH_DEF pGrDesc, HDC hdc);
void  DisableAxes (PGRAPH_DEF pGrDesc);
void  RedrawGrids (PGRAPH_DEF pGrDesc, HDC hdc);
POBJ_HEAD WINAPI _export GetObjDesc (PGRAPH_DEF pGrDesc, HGOBJ hObj,
    HGLOBAL FAR *lphMem);
HGOBJ WINAPI _export GetObjHandle (PGRAPH_DEF pGrDesc, POBJ_HEAD pObjDesc);
void WINAPI _export ObjectInterpreter (PGRAPH_DEF pGrDesc, HDC hdc);
HGOBJ  SearchObject (HWND hwnd, PGRAPH_DEF pGrDesc);
void ForceAllAxBaseUpdate (PGRAPH_DEF pGrDesc);
void WINAPI _export ForceLinesUpdate (PGRAPH_DEF pGrDesc, int nObj);
void WINAPI _export HighlightObj (PGRAPH_DEF pGrDesc);
LINEDESC FAR * WINAPI _export GetLineDesc (PGRAPH_DEF pGrDesc,
    HGOBJ hObj, int n);
void WINAPI _export UpdateColorBar (HWND hDlg, COLORREF rgbColor, 
	int nHatchStyle);

COLORREF WINAPI _export BarScroll (HWND hDlg, HWND hwndCtrl, int code, int pos,
    COLORREF rgbColor, int nHatchStyle);

void WINAPI _export WGVBLabelPie (PGRAPH_DEF pGrDesc, HGOBJ hPie,
	LPSTR lpLabels);
HGOBJ WINAPI _export InitPieChart (PGRAPH_DEF pGrDesc, HDC hdc,
	HGLOBAL hData, LPREAL lpData, int nNumPoints, int nPieStyle,
	int nNumType, int nNumPos, realtype rDiam, realtype rXCenter,
	realtype rYCenter, COLORREF FAR *lpRgbPieColor,
	LPINT lpBorderColor, LPINT lpHatchStyle, LPREAL lprExplodeRel);
void WINAPI _export DrawRectFrame (HDC hdc, LPRECT lpRect);

/**************************************************************************/
/* DRAWING */
/**************************************************************************/
void DrawBorder (PGRAPH_DEF pGrDesc, HDC hdc);
//void DrawMark (PGRAPH_DEF pGrDesc, HDC hdc, LPLOGPEN lPen, LPPOINT lpPoint,
//	OBJ_PLOT FAR *pObjDesc, int half1, int half2);
void Bar (HDC hdc, LPRECT prcBar, int nDir, HBRUSH hBrush, HBRUSH hBrush3D,
	int cxLogPixel, int nDepth);
// RQ Rev 3.0 Added support prototype
void Bar2 (HDC hdc, LPRECT prcBar, HBRUSH hBrush,  HBRUSH hHatchBrush, int nHatchStyle);
// End
int BarParams (HDC hdc, OBJ_PLOT FAR *pObjDesc,
	PGRAPH_DEF pGrDesc, LPINT pxyStart, LPINT pHalf);
void  DrawScatter (PGRAPH_DEF pGrDesc, HDC hdc, HPPOINT hpP,
	OBJ_PLOT FAR *pObjDesc);
void CleanOldPosition (PGRAPH_DEF pGrDesc, POBJ_HEAD pObjDesc);
void WINAPI _export RaisedRect (PGRAPH_DEF pGrDesc, HDC hdc, LPRECT prc, 
    COLORREF rgbColor, int n3D);
void WINAPI _export LowRect (PGRAPH_DEF pGrDesc, HDC hdc, LPRECT prc, 
    COLORREF rgbColor, int n3D);
void WINAPI _export Rect3DBorder (PGRAPH_DEF pGrDesc, HDC hdc, LPRECT prc,
	int nWidthPix,  int nBorderColor);

// UPGRADE8 [DMB] ----------v
void DrawBitmap (PGRAPH_DEF pGrDesc, HDC hdc, realtype rX1,
    realtype rY1, realtype rX2, realtype rY2, int nMode, LPCSTR lpName,
	HGOBJ hImage);

void DrawMetafile (PGRAPH_DEF pGrDesc, HDC hdc,
    realtype rX1, realtype rY1, realtype rX2, realtype rY2, 
	LPCSTR lpName,	HGOBJ hImage);
// UPGRADE8 [DMB] ----------^

/***********************************************************************/
/* Printing                                                            */
/***********************************************************************/
HDC WINAPI _export CreatePrinterDC (BOOL fInfo);
void ParsePrintInfo (LPSTR szPrintInfo,
   BOOL fAppendDriverExt, LPSTR szDriver, LPSTR szDevice, LPSTR szPort);
void PrinterCleanup (void);
void WINAPI _export SetupDefPrinter (void);
HGLOBAL WINAPI _export QCCopyGraph (PGRAPH_DEF pGrDesc, PDD * *lpP);
void WINAPI _export QCDestroyTempGraph (HGLOBAL hGrMem, PDD *lpPairs);

/***********************************************************************/
/* MISCELLANEOUS                                                       */
/***********************************************************************/

void WINAPI  _export InitDll (TOP_DEF FAR *lpTop);
BOOL WINAPI  _export InitTop (TOP_DEF FAR *lpTop,
		LPVOID lpPageProc, LPVOID lpGraphProc, UINT gwStyle);

void WINAPI _export ScaleLog (LPREAL prMin, LPREAL prMax);
int  StackedY (OBJ_GROUP FAR *pObjDesc, HPINT lpDep,
    int GroupNum, UINT i);

BOOL  IsCharDig (int ch);
// DWORD  lread (int fh, VOID far *pv, DWORD ul);
realtype GetBufNumber (LPSTR lpStr, LPINT lpLen);
void WINAPI _export RestoreSize (PGRAPH_DEF pGrDesc);
void WINAPI _export Cleanup (TOP_DEF FAR *lpTop, BOOL bFreeData);
DEV_DEF FAR * WINAPI _export GetDevDesc (void);
int  DisplayDialogBox (DLGPROC lpDlgProc,
	LPCSTR lpDlgName, HWND hwnd);
int WINAPI _export DisplayDialogBoxParam (DLGPROC lpDlgProc, 
	LPCSTR lpDlgName, HWND hwnd, DWORD dwInitParam);
void ShowPlotData (HGLOBAL hObjMem);
BOOL IsDataWindowActive (void);
void AddExt (LPSTR lpName, LPSTR lpExt);
LPSTR WINAPI _export FirstDig (LPSTR lpStr);
LPSTR WINAPI _export FirstNotDig (LPSTR lpStr);
realtype WINAPI _export CheckReal (LPSTR lpBuf, int len);
void WINAPI _export InitHatchStyles (HWND hDlg, int nHatchStyle);
HBRUSH WINAPI _export BarCtlColor (HWND hDlg, HDC hdc, HWND hwndCtrl, UINT id,
    COLORREF rgbColor, int nHatchStyle, HBRUSH FAR *pBrush);
BOOL WINAPI _export SplitString (LPSTR lpStr, int n);

void WINAPI _export Delay (int nMsec, BOOL bPeek);
void CALLBACK EditObject (PGRAPH_DEF pGrDesc);
LPSTR WINAPI _export ftoa (realtype rVal, int nPrec, int nFormat);
void Shrink (LPSTR cptr, int num);
void GetCurDir (LPSTR lpDest);
void WINAPI _export SetRemoteRecalc (FARPROC lpfnRecalc);
void WINAPI _export SetRemoteSaveRestDynObj (SAVDYNOBJ lpfnSave, RESTDYNOBJ lpfnRest);
void   ClearMessages (HWND hwnd);                                
double qcCos (double rX);
double qcSin (double rX, double rCos);
void WINAPI _export ReportIllFunc (POBJ_HEAD pObjDesc);
void NormalizeRect (LPRECT prc);
void WINAPI _export InvalidatePlot (PGRAPH_DEF pGrDesc, HDC hdc);
HGLOBAL WINAPI _export QCRealloc (HGLOBAL hMem, DWORD nOldSize, DWORD nNewSize, 
    LPSTR * pMem);

void WINAPI _export SetFormPage (HWND hwndForm);
void WINAPI _export SetpGCO (PGRAPH_DEF pGrDesc, LPVOID  pGCO);
LPVOID WINAPI _export GetpGCO (PGRAPH_DEF pGrDesc);

/**************************************************************************/
LPVOID  TempGetObjProc (POBJ_HEAD pObjDesc);
LONG WINAPI _export CusButtonWinFn (HWND hwnd, UINT wMessage,
	UINT wParam, LONG lParam);

// Rev 3.0
// Added to GUISUP.h
void WINAPI _export FreeGraphBitmap (PGRAPH_DEF pGrDesc);
HDC WINAPI _export CreateGraphBitmapDC (PGRAPH_DEF pGrDesc, HDC hdc);
HBITMAP WINAPI _export CreateGraphBitmap (PGRAPH_DEF pGrDesc, HDC hdc);
void WINAPI _export StartGraphBitmap(PGRAPH_DEF pGrDesc, HDC hdc);
BOOL WINAPI _export CopyBitmapToGraph(PGRAPH_DEF pGrDesc, HDC hdc, int nCopyArea);

// Added to Drawsup.c
void WINAPI _export  CalcScatterHalfSizes(PGRAPH_DEF pGrDesc, HDC hdc, int nShape, 
		int nPenWidth, int size, int * phalf1, int * phalf2);
// Prototype changed from Rev 2.5
void WINAPI _export DrawMark (PGRAPH_DEF pGrDesc, HDC hdc, LPLOGPEN lPen,
	LPPOINT lpPoint, int nMarkerShape, int nMarkerStyle, int half1, int half2);
void GetPerpNormalIntercept(PGRAPH_DEF pGrDesc, HGOBJ hAx,  LPREAL lprAxisInt);
void SetPerpNormalIntercept(PGRAPH_DEF pGrDesc, HGOBJ hAx,  LPREAL lprAxisInt);

//UPGRADE-52098 [LAB] ---V
BOOL CalcBoxWhiskerStats(OBJ_GROUP *pObjDesc, BOOL bRecalc);
//UPGRADE-52098 [LAB] ---^

// Added to Dialog1.c
realtype  WINAPI _export BarRelWidth (OBJ_PLOT *pBarDesc);
int StackedY2 (OBJ_GROUP *pObjDesc, HPINT lpDep,
    int GroupNum, UINT i);


// typed function pointer types for save/restore

#ifdef STRICT
#undef STRICT
#endif

#ifdef __cplusplus
}
#endif
/**************************************************************************/
#pragma pack(pop)

#endif

