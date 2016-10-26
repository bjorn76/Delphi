/**************************************************************************/
/*                                                                        */
/*     Copyright (c) QUINN-CURTIS, Inc., 1998                             */
/*                                                                        */
/**************************************************************************/
/**                                                                       */
/**   Filename :   qcser.h                                                */
/**   Author   :   QC                                                     */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                         */
/**   Product  :   Charting Tools for Windows                             */
/**                                                                       */
/**   Description: graph serialization definitions                        */
/**                                                                       */
/**************************************************************************/

#ifndef  _QCSERH
#define  _QCSERH        1
#pragma pack(push, 8)

/////////////////////////////////////////////////////////////////////////////
// line descriptor

typedef struct
{
    int nStyle;
    int   nWidth;
    COLORREF rgbColor;
}
SAVE_LD;

typedef struct                   /* text descriptor */
{
    COLORREF rgbTextColor;
	int    nColor;
    int    nPointSize;
    int    nOrient;
    int    nWeight;
    BOOL     bItalic;
    BOOL     bUnderline;
    char     szFontName[LF_FACESIZE + 2];
}
SAVE_TD;

/**************************************************************************/
typedef struct
{
    UINT     wSize;                 // this structure size
    int     nType;                  // object type
} SAVE_HEAD;

/**************************************************************************/
typedef struct
{
    UINT      wSize;                 // this structure size
    int      nType;              // object type
    int      nSubType;           // object subtype 
	int     nUserID;
    HDATA     hData;
    int      wGroupType;
} GROUP_HEAD;

/**************************************************************************/
/* Graph descriptor */

typedef struct
{
    UINT     wSize;             // this structure size
    int    dwSign;
    COLORREF rgbWinBkColor;     // Graph window background color
    COLORREF rgbPlotBkColor;    // Plotting area background color
    int    nBorderWidth;
    int      nBorderColor;
	float    rX1;               // graph coordinates
	float    rY1;
	float    rX2;
	float    rY2;

	float    rX1Plot;           // plotting area coordinates
	float    rY1Plot;
	float    rX2Plot;
	float    rY2Plot;

    int    bRaised;           // 0 - flat, 1 - raised, 2 - low  
	int      nLTickSize; // Tick sizes
	int      nSTickSize;

} SAVE_GRAPH_DEF;

typedef struct
{
	UINT     wSize;             // this structure size
	int    dwSign;

    COLORREF rgbBackColor;
	char     szName[14];        // ASCII internal name of the page
//    LPSTR    pCaption;

    int      nSizeMode;
	int    dwWinStyle;
    int      nPosStyle;
    int      x; 
    int      y; 
    int      cx;
    int      cy;
	int      nLTickSize; // Tick sizes
	int      nSTickSize;

} SAVE_PAGE_DEF;

typedef struct
{
    UINT     wSize;             // this structure size
    int     nType;             // object type
	int     nUserID;

	realtype rxMin;             // plotting area scaling
	realtype ryMin;
	realtype rxMax;
	realtype ryMax;
	realtype rxInt;
	realtype ryInt;
    int      res;
	//upgrlab
    int nXScaleType;
	int nYScaleType;


} SAVE_PLOT;

/////////////////////////////////////////////////////////////////////////
// Reduced object descriptors for saving and restoring
/////////////////////////////////////////////////////////////////////////

typedef struct                       /* arc and pie object */
{
    UINT     wSize;                  // this structure size
    int     nType;                  // object type
	int     nUserID;
    SAVE_LD  ld;
    HGOBJ    hAxisX;
    HGOBJ    hAxisY;
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    realtype  rX3;
    realtype  rY3;
    realtype  rX4;
    realtype  rY4;
    int nBorderColor;
    int      nBorderWidth;
    int      bFill;
    COLORREF  rgbBackColor;        
    int      res;
}
OBJ_SAVE_ARC;

typedef struct                   /* arrow object */
{
    UINT    wSize;                 // this structure size
    int    nType;                 // object type
	int     nUserID;
    SAVE_LD ld;
    HGOBJ   hAxisX;
    HGOBJ   hAxisY;
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    int      nArrowWidth;
    int      nArrowLength;     // arrow length and width in points
    BOOL      bStart;           // if TRUE, arrow at line beginning
    BOOL      bEnd;             // if TRUE, arrow at line end
    BOOL      bFill;            // if TRUE, arrow is filled
    int      res;
}
OBJ_SAVE_ARROW;

typedef struct                      /* bargraph */
{
    UINT     wSize;                 // this structure size
    int     nType;                 // object type
    int     nSubType;              // object subtype 
	int     nUserID;
    HDATA    hData;
    SAVE_LD ld;	// debm

    realtype rWidth;
    int    nJustify;
    int    bBorder;
	COLORREF rgbBarColor;
	COLORREF rgbBorderColor;
	int    nHatchStyle;
    int     res;

	BOOL	  bMulti;				// debser
	long	  lNumPoints;
    COLORREF  *pRGBColors;        // debser
}

OBJ_SAVE_BAR;

typedef struct                      /* bitmap object */
{
    UINT    wSize;                  // this structure size
    int    nType;                  // object type
	int     nUserID;
    HGOBJ   hAxisX;
    HGOBJ   hAxisY;
	realtype  rX1;
	realtype  rY1;
	realtype  rX2;
	realtype  rY2;
    int      nMode;
	char      szName[MAXBMNAMELEN];  // name of the bitmap
    int      res;
}
OBJ_SAVE_BMP;

//////////////////////////////////////////////////////////////////////////
/**************************************************************************/
typedef struct                     /* Axis */
{
    UINT      wSize;              // this structure size
    int      nType;              // object type
	int     nUserID;
    int      nDir;               // can be OR_VERT or OR_HORZ
    SAVE_LD   ld;
    realtype  rTickSpace;         // distance between ticks in eng. units
    int      nSmallTicks;        // number of minor ticks between 2 major ticks
    int      nTickPos;           // position of the ticks relative to axis
    BOOL      fGridMajor;         // flag indicating if grid is enabled for Major ticks
    BOOL      fGridMinor;         // flag indicating if grid is enabled for minor ticks
    SAVE_LD   ldMajor;
    SAVE_LD   ldMinor;
    int      res;
}
OBJ_SAVE_AX;

typedef struct                   /* rectangle, ellipse object */
{
    UINT      wSize;              // this structure size
    int      nType;              // object type
	int     nUserID;
    SAVE_LD   ld;
    HGOBJ     hAxisX;
    HGOBJ     hAxisY;

    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    int       nBorderColor;
    int      nBorderWidth;
    COLORREF  rgbBackColor;        
    int      bFill;              // FLAG FOR FILLING BACKGROUND
    int      n3D;                // 3D code
    int      res;
}
OBJ_SAVE_RECT;

typedef struct                   /* error bars object */
{
    GROUP_HEAD gh;

    SAVE_LD   ld;
    int      nWidth;
    int      res;
}
OBJ_SAVE_ERRBAR;

typedef struct                   /* floating bars object */
{
    GROUP_HEAD gh;
    realtype  rWidth;
    int     nJustify;
    COLORREF  rgbBarColor;
    int     nHatchStyle;
    int       nBorderColor;
    int      res;
}
OBJ_SAVE_FLBAR;

typedef struct                   /* group bars object */
{
    GROUP_HEAD gh;

    realtype  rWidth;
    int     nJustify;
    int      nGroupSize;
    BOOL      bBorder;
    int      res;
}
OBJ_SAVE_GRBAR;

typedef struct                   /* HLC object */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
    int     nMarkerShape;
    int      nMarkerColor;
    int     nMarkerSize;
    int     nMarkerStyle;
    int     res;
	//UPGRADE-51198 [LAB] -------V
	int     nOpenMarkerShape;
    int      nOpenMarkerColor;
    int     nOpenMarkerSize;
    int     nOpenMarkerStyle;
	//UPGRADE-51198 [LAB] -------^
}
OBJ_SAVE_HLC;

typedef struct                   /* HLC object */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
    realtype rBarWidth;
    COLORREF rgbBarColor;
	BOOL	  bMulti;				// debser
	long	  lNumPoints;
    COLORREF  *pRGBColors;        // debser

}
OBJ_SAVE_STOCKOHLC;

typedef struct                   /* HLC object */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
    realtype rBarWidth;
     COLORREF rgbBarColor;
   int     nBorderColor;
	BOOL	  bMulti;			
	long	  lNumPoints;
    COLORREF  *pRGBColors;     
}
OBJ_SAVE_CANDLESTICK;

typedef struct                   /* HLC object */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
	long	  lNumPoints;

	BOOL bBoxFill; 
	BOOL bOutlier; 
	BOOL bExtreme; 
	int nMidPointType; 
	int nBoxType; 
	int nBoxSize;
	int nWhiskerColor;
	int nBoxOutlineColor;
	int nWhiskerStyle; 
	int nWhiskerWidth; 
	int nWhiskerType;
	int nWhiskerSize; 


	realtype rBoxCoef;
	realtype rBoxConst;
	realtype rBoxPerMin;
	realtype rBoxPerMax; 
	realtype rWhiskerCoef;
	realtype rWhiskerPerMin; 
	realtype rWhiskerPerMax;
	realtype rOutlierCoef;
	COLORREF rgbHighColor;
	COLORREF rgbLowColor;
	SCATTER_DESC pMidPtMarkDesc;
	SCATTER_DESC pOutMarkDesc;
	SCATTER_DESC pExtMarkDesc;
}
OBJ_SAVE_BOXWHISKER;


typedef struct                   /* HLC object */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
	TEXTDESC  td;
    int    nGroupSize;
    realtype  rContourValues[MAXGROUPLEN]; 
	BOOL      bContourLineFlags[MAXGROUPLEN];
	BOOL      bContourLabelFlags[MAXGROUPLEN];
    int       nNumContours;
	BOOL      bLabelContourColor;
    int       nLabelXAlignment, nLabelYAlignment;
	int       nBitmapGranularity;
	int       nLabelPrec;
	BOOL      bFirstContourUpdate;

}
OBJ_SAVE_CONTOUR;

typedef struct                   /* Waterfall */
{
    GROUP_HEAD gh;
    SAVE_LD  ld;
    int    nGroupSize;
    //int    res;
	realtype  rXOff;		
	realtype  rYOff;			
	BOOL	  bBaseline;		
	BOOL	  bOutline;			 

}
OBJ_SAVE_WATERFALL;

/**************************************************************************/

typedef struct                     /* Labels */
{
    UINT    wSize;                  // this structure size
    int    nType;                  // object type
	int     nUserID;
    int    nLabelType;
    SAVE_TD td;

    HGOBJ   hAxis;
    int    nLabelPos;
    int    nFormat;
    int   nPrec;
    int    nLast;
    int   nFirstTick;
    int   nFirstMonth;
    int    bShort;
    char    szTextLast[40];         // Text String  for last label
    int    wStrLen;                // for string labels
	struct tm tStartDate;
	int       nBaseUnit;
	int       nDateFormat;
	int       nTimeFormat;
	char      szDateFormatString[64];

//    int    res;
}
OBJ_SAVE_LABELS;

/**************************************************************************/
typedef struct                   /* Legend object */
{
    UINT    wSize;                 // this structure size
    int    nType;                 // object type
    int    nSubType;              // object subtype 
	int     nUserID;
    SAVE_TD td;
    HGOBJ   hObj;                  // for group or dynamic objects
    int   nNumObjects;           // number of objects
    float   rX1;
    float   rY1;
    float   rX2;
    float   rY2;
    int     nBorderColor;
    int    nBorderWidth; 
    int   rgbBackColor;
	BOOL   bBackTransparent;
    int    nLayout;
    int    bSymbols;
    int    bGroup;

    int    res;

	BOOL	  bFlex;				

	int		  nMarkerLogSize[MAXLEGEND]; // debser
	COLORREF  pLegTextColor[MAXLEGEND]; 
	int		  pLegSymShape[MAXLEGEND];  
	COLORREF  pLegSymColor[MAXLEGEND]; 
	int		  pLegSymSize[MAXLEGEND];
	int		  pLegSymStyle[MAXLEGEND];
  
}
OBJ_SAVE_LEGEND;

//////////////////////////////////////////////////////////////////////////
/**************************************************************************/
typedef struct                   /* straight line object */
{
    UINT      wSize;                 // this structure size
    int      nType;                  // object type
	int     nUserID;

    SAVE_LD   ld;
    HGOBJ     hAxisX;
    HGOBJ     hAxisY;
    realtype  rX1;
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    int      res;
}
OBJ_SAVE_LINE;

//////////////////////////////////////////////////////////////////////

typedef struct                   /* scatter and line marker plot object */
{
    UINT    wSize;                 // this structure size
    int    nType;                  // object type
    int    nSubType;               // object subtype 
	int     nUserID;
    HDATA   hData;
    SAVE_LD  ld;
    int     nMarkerShape;
	int      nMarkerColor;
	int     nMarkerSize;
    int     nMarkerStyle;
	int     nMarkerSkip;
	int     nMarkerStart;
    int     bDrop;

	char      szBmpName[MAXBMNAMELEN];  // debser
	char      szMetaName[MAXBMNAMELEN]; // debser

    HGOBJ     hImage;				// debser 

	BOOL	  bMulti;				// debser
	long	  lNumPoints;
    COLORREF  *pRGBColors;        // debser
}
OBJ_SAVE_SCAT;

typedef struct                   /* line plot object */
{
    UINT    wSize;                 // this structure size
    int    nType;                  // object type
    int    nSubType;               // object subtype 
	int     nUserID;
    HDATA   hData;

    SAVE_LD ld;
    int    bFill;
    int    bSpline;
    int    res;

	int	   nStep;		// debser

	BOOL	  bMulti;				// debser
	long	  lNumPoints;
    COLORREF  *pRGBColors;        // debser
}
OBJ_SAVE_LINEPLOT;

//////////////////////////////////////////////////////////////////////////
typedef struct                   /* metafile object */
{
    UINT    wSize;                 // this structure size
    int    nType;                 // object type
	int     nUserID;

    HGOBJ     hAxisX;
    HGOBJ     hAxisY;

	realtype  rX1;
	realtype  rY1;
	realtype  rX2;
	realtype  rY2;
	char      szName[MAXBMNAMELEN];  // name of the metafile
    int      res;
}
OBJ_SAVE_MFILE;
//////////////////////////////////////////////////////////////////////////////

typedef struct                     /* Pie chart object */
{
    UINT    wSize;                 // this structure size
    int    nType;                 // object type
    int    nSubType;              // object subtype 
	int     nUserID;
    SAVE_TD td;

    int    nNumPoints;
    int    nNumType;              // type of number display   
    int   nNumPos;               // number position - inside or out

    float   rRelDiam;              // diameter relative to plot area
    realtype rRelX;                // scaling values
    realtype rRelY;      
    int    res;
}
OBJ_SAVE_PIECHART;

typedef struct                   /* polygon object */
{
    UINT     wSize;                 // this structure size
    int     nType;                 // object type
	int     nUserID;
    SAVE_LD  ld;

    HGOBJ    hAxisX;
    HGOBJ    hAxisY;

    int      nNumPoints;          // polygon size
    int     bFill;
    COLORREF rgbBackColor;
    int     res;
}
OBJ_SAVE_POLYGON;

typedef struct                     /* data cursor */
{
    UINT    wSize;                 // this structure size
    int    nType;                 // object type
    int    nSubType;              // object subtype 
	int     nUserID;


    SAVE_LD ld;

	HGOBJ   hAxisX;
	HGOBJ   hAxisY; 
	realtype rX1;
    realtype rY1;
	int    nSize;
    int    res;
}
OBJ_SAVE_DCURS;

typedef struct                     /* stacked */
{
    GROUP_HEAD gh;

    int    nGroupSize;
    int    res;

//    , LPINT lpLineStyle, LPINT lpLineWidth, LPINT lpLineColor);
}
OBJ_SAVE_STACKED;

typedef struct         
{
    UINT      wSize;                 // this structure size
    int      nType;                 // object type
    int      nSubType;              // object subtype 
	int     nUserID;
    SAVE_TD   td;
    int      wLen;

    HGOBJ     hAxisX;
    HGOBJ     hAxisY;
    realtype  rX;
    realtype  rY;
    int      wAlign;
    int     nOrientation;

	BOOL	bMultiLines;			// debser
	int		nNumLines;				// debser

    int      res;
}
OBJ_SAVE_TEXT;

typedef struct         
{
	UINT     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
	int     nUserID;
    SAVE_TD  td;
    int     wLen;

    HGOBJ    hAxis;
    int     nTitlePos;
    int     res;
}
OBJ_SAVE_TITLE;


typedef struct         
{
	UINT     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
	int     nUserID;
  
	LONG    lNumPoints;
    HGLOBAL hX;                    // memory handles
    HGLOBAL hY;
    HPREAL  hpX;                   // pointers to arrays
    HPREAL  hpY;
    int    cGroupSize;
    char    szDataName[DATANAMELEN];  // unique name of the data set
	int     nRGNumX;
	int     nRGNumY;
	BOOL    nRGFlag;
    int     hDataSet;

}
OBJ_SAVE_XYDATASET;
////////////////////////////////////////////////////////
#pragma pack(pop)

#endif

