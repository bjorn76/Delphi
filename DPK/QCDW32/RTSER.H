/**************************************************************************/
/*                                                                        */
/*     Copyright (c) QUINN-CURTIS, Inc., 1998                             */
/*                                                                        */
/**************************************************************************/
/**                                                                       */
/**   Filename :   rtser.h                                                */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/**   Product  :   RT Tools for Windows                                   */
/**                                                                       */
/**   Description: graph serialization definitions                        */
/**                                                                       */
/**************************************************************************/

#ifndef  _RTSERH
#define  _RTSERH        1

#include <qcser.h>

#pragma pack(push, 8)

//////////////////////////////////////////////////////////////////////////////////

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;
	HDATA    hData;

	BOOL     bFlags [5];
	int      nUpdateSec;
	int      nDir;
	int      nNumLines;
}
OBJ_SAVE_ALMLIN;

//////////////////////////////////////////////////////////////////////////////////
typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

	HDATA    hData;

	BOOL     bFlags [NALMLINES];

	int      nNumLines;
    int      nWidth;
	HGOBJ    hAxis;
	int      nDir;
	int      nPos;
	int      nMarkSize;
	char     szNames [MAX_ALMNAME * NALMLINES];
}
OBJ_SAVE_ALMMARKS;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

    HGOBJ    hAxis;
    int    nUpdateSec;
    BOOL     fGridMajor;         // flag indicating if grid is enabled for Major ticks
    BOOL     fGridMinor;         // flag indicating if grid is enabled for minor ticks
    SAVE_LD  ldMajor;
    SAVE_LD  ldMinor;
}
OBJ_SAVE_DYNGRID;

typedef struct
{
	int    wSize;                 // this structure size
	int    nType;                 // object type
	int    nSubType;              // object subtype 
    int      nUserID;
    HDATA   hData;
    realtype rSampleInt;
    float   rRelResetInt;
    int   nDir;
    int   nStep;
    int   nNumChans;
    int   nChan;                  // channel number for scr. bars
    realtype rWidth;            
    COLORREF rgbBarColor;
    COLORREF rgbBorderColor;
    int      nSweepLineColor;
    realtype  rBarOffset;
	realtype  rBarWidth;
    realtype rCenterPoint;
	realtype rRelBarWidth;
}
OBJ_SAVE_SCROLL;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

    HDATA   hData;
    int   nNumChans;
    int   nChan;
	int   nNumPoints;
}
OBJ_SAVE_XYPLOT;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

    HDATA   hData;
	realtype rCenterPoint;
	int nDir; 
    realtype rFirst;
	realtype rLast; 
	realtype rBarWidth;
	int nNumChans;
    int       nLineStyle;
	int       nLineWidth;
	int       nStep;

}
OBJ_SAVE_DYNBARS;


typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

    HDATA hData;
    SAVE_TD td;
    int   nChan;
    realtype rX1;
    realtype rY1;
    realtype rX2;
    realtype rY2;
    int nBorderColor;
    int nBorderWidth;
    int nBackColor;

    int nLayout;
    int nChar;
    int nPrec;
    HGOBJ hDynObj;
    int n3D;
    int nNumChans;
    char szNormName[MAX_ALMNAME + 2];
    UINT wAlign;

} OBJ_SAVE_DTEXT;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

	HDATA    hData;        
    SAVE_TD td;
    int      nBinChanNum;   
    realtype rX;            
    realtype rY;         
    int      nBorderColor;  
    int      nBorderWidth;  
    int      nBackColor;   
    int      nNumMes;       
    MES_DESC  mesDesc[MAX_MESNUM]; // message descriptors

} OBJ_SAVE_MESSAGE;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

    HDATA hData;
    SAVE_TD td;
	int nValWidth;
	int nPrec;
    int nNumRows; 
	int nNumColumns; 
	int nNumChans;
	
	int nFontSize;
	int rgbBackAlmColor;
	int rgbLowAlmColor;
	BOOL lpFlags[8]; 
	int n3D;
} OBJ_SAVE_ANNUNC;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;
	SAVE_TD  td;        

     HDATA   hData;
     int       nChan;         // channel # in the data set, if -1 - all channels
     SAVE_LD   ld;
     realtype  rMin;          
     realtype  rMax;          
     realtype  rXCenter;     
     realtype  rYCenter;      
     realtype  rDiam;        
     int       nStartAngle;   
     int       nEndAngle;
     int       nNeedleType; 
     LPINT     lpNeedleColor;
     realtype  rTickRelSize;  
     realtype  rTickSpace; 
	 int nSmallTicks; 
	 int nTickPos;
     int       nLabelPos;
     int       nLabelPrec;   
     BOOL      bText;       
     int       nValPrec;    
     BOOL      bArc;
     BOOL      bUnits;
     BOOL      bAlarms;
     realtype  rAlmRelThick;  
     LPINT   lpAlmColor;
	 int nNumChans;
// border parameters    
	realtype  rXBorderCenter;      // relative coordinates of the center
    realtype  rYBorderCenter;
    realtype  rXBorderWidth;
    realtype  rYBorderHeight;      // ignored for circle
    COLORREF  rgbBackColor;  // meter background color   
    int     nBorderType;
//    int     nBorderColor;
//    int     nBorderWidth;

   SAVE_LD  ldBorder;            // line descriptor for border
   COLORREF  rgbMeterBackColor;   // background color   
   int      cMeterBorderType;   // 0 - no border, 1 - Circle, 2 - Square, 3 - Rd Square

   realtype rArcRelThick;
   realtype rCenterPoint;

} OBJ_SAVE_METER;

typedef struct
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;

	TEXTDESC  tdesc;        
    HWND      hwndParent;  
    HWND      hwndCtl;      
    realtype  rX1;         
    realtype  rY1;
    realtype  rX2;
    realtype  rY2;
    COLORREF  rgbBkColor;  
    BOOL      bTextLeft;    
          
    int     nRButNum;     
    int     nDir;         
    int     nSel;         
                          
    int      cStyle;      
    int      cLook;       
                            
    PRB_DEF   lpRButDesc;   
                         
    realtype  rMin;         
    realtype  rRange;    
	realtype  rDiam;
    int       nScrollMin;
    int       nScrollMax;
    int       nPageStep;    // page increment  
    int       nPos;
    int       nControlType;
	char      szText[DYNTITLELEN];

} OBJ_SAVE_CHCONT;


typedef struct         
{
	int     wSize;                 // this structure size
	int     nType;                 // object type
	int     nSubType;              // object subtype 
    int      nUserID;
  
    int    cNumChannels;            // from 1 up to 32
    char    szTitle [DYNTITLELEN]; // unique title of the data set  2
    int     nHistSize;            // number of samples in history buffer (real values)
    char    szUnits [DYNUNITSLEN]; // engineering units
    int     nXY;                   // set to 1 if data used by XY plot 
    int     hDataSet;
	// Current Alarm States
    BOOL    cAlmMask;
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
	BOOL      bCheckChAlarms;
    char      szTag[DYN_MAXVAL][TAGLEN]; // channel tags
	BOOL      bCheckAlarms;
    int     bNANCheck;

}
OBJ_SAVE_DYNDATASET;

typedef struct                     /* Labels */
{
    int    wSize;                  // this structure size
    int    nType;                  // object type
    int    nSubType;
    int      nUserID;
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
    realtype  rStartNum;          // starting value, always in seconds for time formats
    int      nStartHour;         // starting time for first tick
    int      nStartMin;
    int      nStartSec;

}
OBJ_SAVE_DYNLABELS;
////////////////////////////////////////////////////////////////////////
#pragma pack(pop)

#endif

