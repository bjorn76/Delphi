/******************************************************************/
/*                                                                */
/*   Copyright (C) QUINN-CURTIS, 1992 - 1998                      */
/*                                                                */
/******************************************************************/
/*                                                                */
/*   Filename :   STRINGS.H                                       */
/**   Author   :   QC                                             */
/**   Revision :   3.0                                            */
/**   Date     :   August 15, 1998                                */
/*                                                                */
/*   Description: Text string definitions                         */  
/*                                                                */
/*   Revisions:   1.5. Definitions added for Real-Time Tools      */
/*                                                                */
/******************************************************************/

#define  NOERR             0   
#define  ERR_PRNOTSEL      1   
#define  ERR_CLIP          2   
#define  ERR_NOLOG         3   
#define  ERR_NOFONT        4
#define  ERR_NOCLIPDATA    5
#define  ERR_NODLLINIT     6
#define  ERR_FILEOPEN      7
#define  ERR_LOGNEG        8
#define  ERR_ILLEGAL_META  9   

#define  ERC_CONT         11
#define  ERC_TERM         12

#define  ERC_SERIOUS      13  
#define  ERC_CRITICAL     14
#define  ERC_INFO         15

#define  ERR_ENDINFO      16

#define  ERR_NOBITMAP        ERR_ENDINFO   
#define  ERR_NOBRUSH         ERR_ENDINFO + 1  
#define  ERR_NOPEN           ERR_ENDINFO + 2  
#define  ERR_PRINTER         ERR_ENDINFO + 3   
#define  ERR_PRT_OUTOFDISK   ERR_ENDINFO + 4   
#define  ERR_PRT_OUTOFMEM    ERR_ENDINFO + 5   
#define  ERR_FILEREAD        ERR_ENDINFO + 7   
#define  ERR_FILEWRITE       ERR_ENDINFO + 8   
#define  ERR_NOMEMBITMAP     ERR_ENDINFO + 10   
#define  ERR_WRONGDATASET    ERR_ENDINFO + 11   
#define  ERR_ILLEGAL_FUNC_OBJ ERR_ENDINFO + 13   
#define  ERR_ILLEGAL_PARAM   ERR_ENDINFO + 14   
#define  ERR_FFT_LENGTH      ERR_ENDINFO + 15   
#define  ERR_GRBUILD         ERR_ENDINFO + 16   

#define  ERR_ENDWARNING  48

#define  ERR_GENERR          ERR_ENDWARNING       
#define  ERR_NOLOCMEM        ERR_ENDWARNING +  1
#define  ERR_WIN_CREATE      ERR_ENDWARNING +  2
#define  ERR_TOO_MANY_PAGES  ERR_ENDWARNING +  3
#define  ERR_TOO_MANY_GRAPHS ERR_ENDWARNING +  4
#define  ERR_NOGLOBMEM       ERR_ENDWARNING +  5
#define  ERR_NOAXES          ERR_ENDWARNING +  6
#define  ERR_BAD_DATA_HANDLE ERR_ENDWARNING +  7   
#define  ERR_BAD_OBJ_HANDLE  ERR_ENDWARNING +  8   
#define  ERR_DATA_TOOBIG     ERR_ENDWARNING +  9   
#define  ERR_DATA_WRONGSIZE  ERR_ENDWARNING + 10   
#define  ERR_TOO_MANY_DATASETS ERR_ENDWARNING + 11   

#define  ERR_ENDSEVERE       64

#define  ERR_WIN_REG         ERR_ENDSEVERE      
#define  ERR_BAD_GRAPH_HANDLE ERR_ENDSEVERE  + 1 
#define  ERR_VERSION         ERR_ENDSEVERE   + 2
#define  ERR_PLOTINIT        ERR_ENDSEVERE   + 3
#define  ERR_SCALE           ERR_ENDSEVERE   + 4
#define  ERR_REALTYPE        ERR_ENDSEVERE   + 5
#define  ERR_BUILDPAGE       ERR_ENDSEVERE   + 6
#define  ERR_EX_ACCESS       ERR_ENDSEVERE   + 7
#define  ERR_EX_BOUNDS       ERR_ENDSEVERE   + 8
#define  ERR_EX_DIVZERO      ERR_ENDSEVERE   + 9

#define  ERR_WCT_LAST       99  // last possible error for Windows Charting tools

#define  IDS_SUN             80
#define  IDS_MON             81
#define  IDS_TUE             82
#define  IDS_WED             83
#define  IDS_THU             84
#define  IDS_FRI             85
#define  IDS_SAT             86

#define  IDS_JAN             96
#define  IDS_FEB             97
#define  IDS_MAR             98
#define  IDS_APR             99
#define  IDS_MAY            100
#define  IDS_JUN            101   
#define  IDS_JUL            102 
#define  IDS_AUG            103 
#define  IDS_SEP            104 
#define  IDS_OCT            105 
#define  IDS_NOV            106 
#define  IDS_DEC            107 

#define  IDS_BLACK          112
#define  IDS_BLUE           113
#define  IDS_GREEN          114
#define  IDS_CYAN           115
#define  IDS_RED            116
#define  IDS_MAGENTA        117
#define  IDS_BROWN          118
#define  IDS_LIGHTGRAY      119
#define  IDS_GRAY           120
#define  IDS_LIGHTBLUE      121
#define  IDS_LIGHTGREEN     122
#define  IDS_LIGHTCYAN      123
#define  IDS_LIGHTRED       124
#define  IDS_LIGHTMAGENTA   125
#define  IDS_YELLOW         126
#define  IDS_WHITE          127
#define  IDS_PALEBLUE       128
#define  IDS_PALEGREEN      129
#define  IDS_MEDGRAY        130
#define  IDS_OFFWHITE       131
#define  IDS_OFFWHITE       131
#define  IDS_TRANSP         132

#define  IDS_WMFFILTER      144
#define  IDS_EMFFILTER      145

#define	 IDS_GT_SL			150		// UPGRADE3 [DMB]
#define	 IDS_GT_GL			151
#define  IDS_GT_WATERFALL	152		// UPGRADE4 [DMB]

#define  IDS_LT_LINE        160
#define  IDS_LT_LINESYM     161
#define  IDS_LT_SCAT        162
#define  IDS_LT_VBAR        163
#define  IDS_LT_HBAR        164
#define  IDS_LT_V3DBAR      165
#define  IDS_LT_H3DBAR      166

#define  IDS_GT_GB          167
#define  IDS_GT_DB          168
#define  IDS_GT_SB          169

#define  IDS_AX_VERT        170
#define  IDS_AX_RIGHT       171
#define  IDS_AX_LEFT        172
#define  IDS_AX_ABOVE       173
#define  IDS_AX_BELOW       174

#define  IDS_ST_NONE        176
#define  IDS_ST_X           177
#define  IDS_ST_UPT         178
#define  IDS_ST_DT          179
#define  IDS_ST_BOX         180
#define  IDS_ST_PLUS        181
#define  IDS_ST_AST         182
#define  IDS_ST_DIAM        183
#define  IDS_ST_CIR         184
#define  IDS_ST_DOT         185
#define  IDS_ST_BAR          186
#define  IDS_ST_FILLEDLINE   187
#define IDS_ST_BITMAP       190
#define IDS_ST_METAFILE     191

#define  IDS_LAB_RIGHT      270
#define  IDS_LAB_LEFT       271
#define  IDS_LAB_RIGHTPLOT  272
#define  IDS_LAB_LEFTPLOT   273


#define  IDS_OT             192
#define  IDS_OT_CURVE       IDS_OT + GO_PLOT   
#define  IDS_OT_GROUP       IDS_OT + GO_GROUP  
#define  IDS_OT_LEGEND      IDS_OT + GO_LEGEND 
#define  IDS_OT_LINE        IDS_OT + GO_LINE   
#define  IDS_OT_ARROW       IDS_OT + GO_ARROW  

#define  IDS_OT_AXIS        IDS_OT + GO_AX    
#define  IDS_OT_LABELS      IDS_OT + GO_LABELS
#define  IDS_OT_TEXT        IDS_OT + GO_TEXT  
#define  IDS_OT_ARC         IDS_OT + GO_ARC   
#define  IDS_OT_RECT        IDS_OT + GO_RECT    
#define  IDS_OT_PIECHART    IDS_OT + GO_PIECHART
#define  IDS_OT_METAFILE    IDS_OT + GO_METAFILE
#define  IDS_OT_ELLIPSE     IDS_OT + GO_ELLIPSE 
#define  IDS_OT_BITMAP      IDS_OT + GO_BITMAP  
#define  IDS_OT_POLYGON     IDS_OT + GO_POLYGON 
#define  IDS_OT_PIE         IDS_OT + GO_PIE
                                      
#define  IDS_OT_DYN         224

#define  IDS_OT_ALARMLINES  IDS_OT_DYN + GOD_ALARMLINES - GO_DYN
#define  IDS_OT_ALARMMARKS  IDS_OT_DYN + GOD_ALARMMARKS - GO_DYN
#define  IDS_OT_DYNGRID     IDS_OT_DYN + GOD_DYNGRID - GO_DYN   
#define  IDS_OT_SCROLL      IDS_OT_DYN + GOD_SCROLL  - GO_DYN   
#define  IDS_OT_XYPLOT      IDS_OT_DYN + GOD_XYPLOT  - GO_DYN   
#define  IDS_OT_DYNLABELS   IDS_OT_DYN + GOD_LABELS  - GO_DYN    
#define  IDS_OT_DYNBARS     IDS_OT_DYN + GOD_BARS    - GO_DYN    
#define  IDS_OT_DYNTEXT     IDS_OT_DYN + GOD_TEXT    - GO_DYN    
#define  IDS_OT_MESSAGE     IDS_OT_DYN + GOD_MESSAGE - GO_DYN   
#define  IDS_OT_GOD_ANNUNC  IDS_OT_DYN + GOD_ANNUNC  - GO_DYN
#define  IDS_OT_GOD_METER   IDS_OT_DYN + GOD_METER   - GO_DYN


// UPGRADE7 [DMB] - 
#define	 IDS_LG_NONE		257
#define	 IDS_LG_LINE		258
//#define	 IDS_LG_LINEMARK	259
#define	 IDS_LG_BAR			259
#define	 IDS_LG_3DBAR		260

/*************************************************************************/
                                    
