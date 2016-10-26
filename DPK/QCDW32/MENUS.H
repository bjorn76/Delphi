/******************************************************************/
/*                                                                */
/*     Copyright (C) QUINN-CURTIS, Inc. 1992- 1998                */
/*                                                                */
/******************************************************************/
/*                                                                */
/*   Filename :   MENUS.H                                         */
/*   Author   :   QC                                              */
/*   Revision :   3.0                                             */
/*   Date     :   August 15, 1998                                 */
/*                                                                */
/******************************************************************/

#define  IDM_FILEPOS	0
#define  IDM_EDITPOS	1
#define  IDM_GRAPHPOS	2
#define  IDM_OPTIONSPOS	3
#define  IDM_SELECTORS	900
#define  IDM_SELECTORS_MAX	IDM_SELECTORS + MAX_GRAPHS - 1
#define  IDOK	    1
#define  IDCANCEL	2
#define  IDABORT	3
#define  IDRETRY	4
#define  IDIGNORE	5
#define  IDYES	    6
#define  IDNO	    7
#define  IDM_START	10
#define  IDM_NEW	11
#define  IDM_OPEN	12
#define  IDM_SAVE	13
#define  IDM_SAVEAS	14
#define  IDM_SAVEASMETA	15
#define  IDM_EXIT	16
#define  IDM_CREATE	17
#define  IDM_LOAD	18
#define  IDM_UNDO	20
#define  IDM_CUT	21
#define  IDM_COPY	22
#define  IDM_PASTE	23
#define  IDM_CLEAR	24
#define  IDM_FORMAT	30
#define  IDM_HELP	40
#define  IDM_ABOUT	41
#define  ID_ENTER	42
#define  IDM_COPYGRAPH	50
#define  IDM_COPYPAGE	51
#define  IDM_REPLACE	52
#define  IDM_SHOWSEL	60
#define  IDM_HIGHSEL	61
#define  IDM_PARGRAPH	70
#define  IDM_BLOWSEL	71
#define  IDM_SELGRAPH	72
#define  IDM_BLACK	300
#define  IDM_BLUE	301
#define  IDM_GREEN	302
#define  IDM_CYAN	303
#define  IDM_RED	304
#define  IDM_MAGENTA	305
#define  IDM_BROWN	    306
#define  IDM_LIGHTGRAY	307
#define  IDM_GRAY	    308
#define  IDM_LIGHTBLUE	309
#define  IDM_LIGHTGREEN	310
#define  IDM_LIGHTCYAN	311
#define  IDM_LIGHTRED	312
#define  IDM_LIGHTMAGENTA	313
#define  IDM_YELLOW	    314
#define  IDM_WHITE	    315
#define  IDM_MM_TEXT	340
#define  IDM_MM_LOMETRIC	341
#define  IDM_MM_HIMETRIC	342
#define  IDM_MM_LOENGLISH	343
#define  IDM_MM_HIENGLISH	344
#define  IDM_MM_TWIPS	    345
#define  IDM_MM_ISOTROPIC	346
#define  IDM_MM_ANISOTROPIC	347
#define  IDM_PRINT_PAGE	    400
#define  IDM_PRINT_GRAPH	401
#define  IDM_PSET	        402
#define  IDM_PRINT_PARAM	403
#define IDM_SERIALIZE_LOAD  404
#define IDM_SERIALIZE_SAVE  405
#define ID_ZOOM_BACK        406
#define ID_ZOOM_TOP         407

#define  ID_PRINT_BORDER	410
#define  ID_PRINT_GRAPHBACKGND	412
#define  ID_PRINT_PLOTBACKGND	413
#define  ID_PRINT_FULL    414
#define  ID_PRINT_PROP    415
#define  ID_PRINT_EXACT   416
#define  ID_PRINT_X       417
#define  ID_PRINT_Y       418
#define  ID_PRINT_XYTEXT  419
#define  ID_PRINT_ASPECT  420
#define  ID_LINEPAR	    500
#define  ID_FILENAME	600
#define  ID_PRINTERBOX	1020
#define  ID_SETUP	    1021
#define  ID_POS_BELOW	1040
#define  ID_POS_ABOVE	1041
#define  ID_POS_MIDDLE	1042
#define  ID_POS_ABOVEPLOT 1043
#define  ID_POS_BELOWPLOT 1044
#define  ID_COLOR	    1050
#define  ID_THICKNESS	1051
#define  ID_COLORLAB    1052
#define  ID_AXIS_AUTO	1056
#define  ID_AXIS_FIXED	1057
#define  ID_AXIS_GRIDS	1058
#define  ID_AXIS_NSMTICKS	1059
#define  ID_AXIS_STEP	1060
#define  ID_GRIDSMAJ	1061
#define  ID_GRIDSMIN	1062
#define  ID_AXIS_LOG	1063
#define  ID_GRIDMAJDET	1065
#define  ID_GRIDMINDET	1066
#define  ID_AXIS_FROM	1067
#define  ID_AXIS_TO 	1068
#define  ID_AXIS_INTERCEPT	1069
#define  ID_LINE_STYLE	1070
#define  ID_FILLAREA	1071
#define  ID_DATA	    1072
#define  ID_SPLINE	    1073
#define  ID_3D	        1074
#define  ID_MARKER_SHAPE	1080
#define  ID_MARKER_STYLE	1081
#define  ID_WORD_TYPE	1082
#define  ID_MARKER_SIZE	1083
#define  ID_LINE_TYPE	1084
#define  ID_MARKER_STYLE_FULL	1085
#define  ID_MARKER_STYLE_EMPTY	1086
#define  ID_MARKER_STYLE_DOT	1087
#define  ID_MARKER_DROP	1088
#define  ID_DEF_AREA	1089
#define  ID_COLOR_AREA	1090
#define  ID_TEXT_FONT	1100
#define  ID_TEXT_SIZE	1101
#define  ID_TEXT_EDIT	1102
#define  ID_TEXT_PARAM	1103
#define  ID_TEXT_BOLD	1104
#define  ID_TEXT_ITALICS	1105
#define  ID_TEXTLAB	        1106
#define  ID_TEXT_UNDERLINE	1107
#define  ID_ARROW_WIDTH	    1151
#define  ID_ARROW_LENGTH	1152
#define  ID_ARROW_START	    1154
#define  ID_ARROW_END	    1155
#define  ID_LABEL_NUMERIC	1202
#define  ID_LABEL_STRING	1203
#define  ID_LABEL_PREC	    1205
#define  ID_LABEL_PRECON	1206
#define  ID_LABEL_FORMDEC	1207
#define  ID_LABEL_FORMSCI	1208
#define  ID_LABEL_FORMENG	1209
#define ID_LABEL_FORMTIME   1210
#define ID_LABEL_FORMDATE   1211

#define IDC_TIMEFORMAT                  1005
#define IDC_TIMETIMEBASE                1006

#define  ID_LABEL_LASTON	1212
#define  ID_LABEL_LASTOFF	1213
#define  ID_LABEL_LASTMAN	1214
#define  ID_LABEL_MANTEXT	1220
#define  ID_LABEL_TNUM  	1215
#define  ID_LABEL_HHMMSS	1216
#define  ID_LABEL_HHMM  	1217
#define  ID_LABEL_MMSS  	1218
#define  ID_LABEL_PRECLAB  	1219

#define  ID_RED_SCROLL	    1250
#define  ID_GREEN_SCROLL	1251
#define  ID_BLUE_SCROLL	1252
#define  ID_RED_TEXT	1253
#define  ID_GREEN_TEXT	1254
#define  ID_BLUE_TEXT	1255
#define  ID_HATCH	    1260
#define  ID_BARWIDTH	1300
#define  ID_BARBORDER	1301
#define  ID_BAROFFSET	1302
#define  ID_LEGWIDTH	1350
#define  ID_LEGHEIGHT	1351
#define  ID_LEGLEFT	    1352
#define  ID_LEGTOP	    1353
#define  ID_LEGTEXT	    1354
#define  ID_LEGBORDER   1355



#define  ID_PIEX        1380
#define  ID_PIEY        1381
#define  ID_PIEDIAM     1382
#define  ID_PIESLICE    1383
#define  ID_PIEDET      1384
#define  ID_PIEVAL      1385
#define  ID_PIELABEL    1386
#define  ID_PIEEXPL     1387 

#define  ID_GRAPHBKGND	1500
#define  ID_GRAPHBORDER	1501
#define  ID_GRAPHWIDTH	1502
#define  ID_GRAPHHEIGHT	1503
#define  ID_GRAPHLEFT	1504
#define  ID_GRAPHTOP	1505
#define  ID_GRAPHCOLOR	1506
#define  ID_PLOTWIDTH	1510
#define  ID_PLOTHEIGHT	1511
#define  ID_PLOTLEFT	1512
#define  ID_PLOTTOP	    1513
#define  ID_PLOTCOLOR	1515
#define  ID_FORMATWIDTH	1550
#define  ID_FORMATPREC	1551
#define  ID_GRAPHPARAMS	1600
#define  ID_DATASETS	1601
#define  ID_LOADDATASET	1602
#define  ID_CREATEAXES	1603
#define  ID_CREATEVAXLEF 1604
#define  ID_CREATENUM   1606

// Rev 3.0 Additions
#define  ID_CONTOUR_LEVEL	1356
#define  ID_CONTOUR_NUMBER	1357
#define  ID_CONTOUR_TYPE	1358

#define IDC_DATEFORMAT                  1003
#define IDC_DATETIMEBASE                1004
#define IDC_STARTMONTH                  1005
#define IDC_STARTYEAR                   1006
#define IDC_STARTDAY                    1007

#define  ID_POS_LEFT	1359
#define  ID_POS_RIGHT	1360
#define  ID_POS_CENTER	1361

#define  ID_CONTOUR_DISPLAYCOARSE	1362
#define  ID_CONTOUR_DISPLAYFINE	1363

#define ID_CONTOUR_INSERTLABELS  1364

#define  ID_CONTOUR_FILLEDTYPE	1365
#define  ID_CONTOUR_LINETYPE	1366

#define  ID_STEP_START  1800	  // UPGRADE2 [DMB]
#define  ID_STEP_END	1801	  // UPGRADE2 [DMB]

#define  ID_MARKER_NAME	1810	  // UPGRADE8 [DMB]
#define  ID_MARKER_BROWSE 1811	  // UPGRADE8 [DMB]

#define  ID_WF_BASELINE 1820	  // UPGRADE4 [DMB]
#define  ID_WF_OUTLINE  1821	  // UPGRADE4 [DMB]
#define  ID_WF_OFFX		1822	  // UPGRADE4 [DMB]
#define  ID_WF_OFFY		1823	  // UPGRADE4 [DMB]
#define  ID_WF_OFFX_ST	1824	  // UPGRADE4 [DMB]
#define  ID_WF_OFFY_ST	1825	  // UPGRADE4 [DMB]

#define	 ID_RGB_COLOR	1830	  // UPGRADE56 [DMB]

#define	 ID_TEXT_XPOS	1840	  // UPGRADE16 [DMB]
#define	 ID_TEXT_YPOS	1841	  // UPGRADE16 [DMB]
#define	 ID_TEXT_XPOS_ST 1842	  // UPGRADE16 [DMB]
#define	 ID_TEXT_YPOS_ST 1843	  // UPGRADE16 [DMB]

#define  ID_USER	    2500

//UPGRADE-51198 [LAB] FOR GT_BOXWHISKER, CANDLESTICK ---V
#define IDC_MIDMARK                     2000
#define IDC_OUTMARK                     2001
#define IDC_EXTMARK                     2002
#define IDC_OUTON                       2003
#define IDC_EXTON                       2004
#define IDC_OUTCOEF                     2005
#define IDC_MEDIAN                      2006
#define IDC_MEAN                        2007
#define IDC_BOXTYPE                     2009
#define IDC_BOXSIZE                     2011
#define IDC_BOXCOEF                     2012
#define IDC_BOXCONST                    2013
#define IDC_EDIT4                       2014
#define IDC_BOXMIN                      2014
#define IDC_BOXMAX                      2015
#define IDC_UPCOL                       2016
#define IDC_LOWCOL                      2017
#define IDC_WHTYPE                      2018
#define IDC_WHCOEF                      2019
#define IDC_MIN                         2020
#define IDC_WHMIN                       2020
#define IDC_WHMAX                       2021
#define IDS_BW_NONE                     2035
#define IDS_BW_PERCNT                   2036
#define IDS_BW_MINMAX                   2037
#define IDS_BW_CONST                    2038
#define IDS_BW_STDDEV                   2039
#define IDS_BW_STDERR                   2040
#define IDS_BW_NONOUT                   2041
#define IDS_BW_COLUMN                   2042
#define IDC_OPENMARK                    2050
#define IDC_CLOSEMARK                   2051

//UPGRADE-51198 [LAB] FOR GT_BOXWHISKER, CANDLESTICK ---^
