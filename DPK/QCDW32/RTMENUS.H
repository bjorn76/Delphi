/******************************************************************/
/*                                                                */
/*     Copyright (C) QUINN-CURTIS, Inc, 1994, 1998                */
/*                                                                */
/******************************************************************/
/*                                                                */
/*   Filename :   RTMENUS.H                                       */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/*                                                                */
/******************************************************************/

#include <menus.h>

#define  ID_PID_HR      1701
#define  ID_PID_LR      1702
#define  ID_PID_TAG     1703
#define  ID_PID_GAIN    1704
#define  ID_PID_INTG    1705
#define  ID_PID_DERV    1706
#define  ID_PID_BIAS    1707
#define  ID_PID_SETP    1708
#define  ID_PID_HLIM    1709
#define  ID_PID_LLIM    1710
#define  ID_PID_RLIM	1712
#define  ID_PID_OUT	    1713
#define  ID_PID_OUTLAB  1714
#define  ID_PID_AM	    1715
#define  ID_PID_FILT	1716

// CONSTANTS FOR THE ALARM LINE DIALOG BOX
#define ID_ALMLN_STP_ON     1750
#define ID_ALMLN_HI_ON      1751
#define ID_ALMLN_LO_ON      1752
#define ID_ALMLN_HH_ON      1753
#define ID_ALMLN_LL_ON      1754
#define ID_ALMLN_STP_LATTR  1755
#define ID_ALMLN_HI_LATTR   1756
#define ID_ALMLN_LO_LATTR   1757
#define ID_ALMLN_HH_LATTR   1758
#define ID_ALMLN_LL_LATTR   1759
#define ID_ALM_SETLIMITS    1760
#define IDC_COMBOBOX1	501
#define IDC_COMBOBOX2	502
#define ID_ALMLN_REFRESH	1761

// CONSTANTS FOR THE ALARM LIMITS  DIALOG BOX
#define ID_ALM_SETPT        1762
#define ID_ALM_HI_VAL       1763
#define ID_ALM_LO_VAL       1764
#define ID_ALM_HH_VAL       1765
#define ID_ALM_LL_VAL       1766
#define ID_ALM_RATE         1767
#define ID_ALM_DEV          1768
#define ID_ALM_FAIL         1769
#define ID_ALM_HYST         1770
#define ID_ALM_HYSDEV       1771
#define ID_ALM_NORM_STR     1772
#define ID_ALM_HI_STR       1773
#define ID_ALM_LO_STR       1774
#define ID_ALM_HH_STR       1775
#define ID_ALM_LL_STR       1776
#define ID_ALM_RATE_STR     1777
#define ID_ALM_DEV_STR      1778
#define ID_ALM_FAIL_STR     1779
#define ID_ALM_HI_ENABLE	1780
#define ID_ALM_LO_ENABLE	1781
#define ID_ALM_HH_ENABLE	1782
#define ID_ALM_LL_ENABLE	1783
#define ID_ALM_RATE_ENABLE	1784
#define ID_ALM_DEV_ENABLE	1785
#define ID_ALM_FAIL_ENABLE	1786
#define ID_ALM_ALL_ENABLE	1787
#define ID_ALM_DATASET_NAME 1788

// CONSTANTS FOR THE ALARM MARK DIALOG BOX
#define ID_ALMMK_BELOW	    1790
#define ID_ALMMK_ABOVE	    1791
#define ID_ALMMK_LWIDTH	    1792
#define ID_ALMMK_STP_ON	    1793
#define ID_ALMMK_HI_ON	    1794
#define ID_ALMMK_LO_ON	    1795
#define ID_ALMMK_HH_ON	    1796
#define ID_ALMMK_LL_ON	    1797
#define ID_ALMMK_STP_STR	1798
#define ID_ALMMK_HI_STR	    1799
#define ID_ALMMK_LO_STR	    1800
#define ID_ALMMK_HH_STR	    1801
#define ID_ALMMK_LL_STR	    1802
#define ID_ALMMK_STP_LATTR	1803
#define ID_ALMMK_HI_LATTR	1804
#define ID_ALMMK_LO_LATTR	1805
#define ID_ALMMK_HH_LATTR	1806
#define ID_ALMMK_LL_LATTR	1807

#define ID_ALMTXT_BORDER	1810
#define ID_ALMTXT_HEIGHT	1811
#define ID_ALMTXT_WIDTH		1812
#define ID_ALMTXT_TOP		1813
#define ID_ALMTXT_LEFT		1814
#define ID_ALMTEXT			1815
#define ID_ALMTXT_NORM_COL	1817
#define ID_ALMTXT_HI_COL 	1818
#define ID_ALMTXT_LO_COL 	1819
#define ID_ALMTXT_HH_COL 	1820
#define ID_ALMTXT_LL_COL 	1821
#define ID_ALMTXT_RATE_COL	1822
#define ID_ALMTXT_DEV_COL	1823
#define ID_ALMTXT_FAIL_COL	1824

// CONSTANTS FOR SCROLLING LINES
#define ID_LIST_TAGNAME		1831
#define ID_BUTTON_NOSTEP	1832
#define ID_BUTTON_STEPSTART	1833
#define ID_BUTTON_STEPEND	1834
#define IDC_GROUPBOX1	501
#define ID_RELRESET			1836
#define ID_SAMPLEINT		1837
#define ID_RELRESET_TEXT	1838
#define ID_SAMPLEINT_TEXT	1839

// CONSTANT FOR SCROLL BAR
#define ID_BORDER_ATTR		1840

// CONSTANTS FOR DYNAMIC BARS
#define ID_DBAR_WIDTH	1846

// CONSTANTS FOR DYNAMIC TEXT
#define ID_DTXT_PREC		1850
#define ID_DTXT_COL_LST		1851

// CONSTANTS FOR MESSAGE TEXT
#define ID_MSG_COL0			1860
#define ID_MSG_COL1			1861
#define ID_MSG_COL2			1862
#define ID_MSG_COL3			1863
#define ID_MSG_COL4			1864
#define ID_MSG_COL5			1865
#define ID_MSG_COL6			1866
#define ID_MSG_COL7			1867
#define ID_MSG_0			1868
#define ID_MSG_1			1869
#define ID_MSG_2			1870
#define ID_MSG_3			1871
#define ID_MSG_4			1872
#define ID_MSG_5			1873
#define ID_MSG_6			1874
#define ID_MSG_7			1875

#define	ID_METER_RNG_FROM	 1885
#define	ID_METER_RNG_TO      1886
#define	ID_METER_DIAM        1887
#define	ID_METER_CENTER      1888
#define	ID_METER_ARC_FROM    1889
#define	ID_METER_ARC_TO      1890
#define	ID_METER_CX          1891
#define	ID_METER_CY          1892
#define	ID_METER_TIC_STEP    1893
#define	ID_METER_TIC_MINOR   1894
#define	ID_METER_TIC_POS_IN  1895
#define	ID_METER_TIC_POS_OUT 1896
#define	ID_METER_TIC_POS_MID 1897
#define  ID_METER_TIC_REL_LEN 1898
#define	ID_METER_LAB_IN      1899
#define	ID_METER_LAB_OUT     1900
#define	ID_METER_LAB_PREC    1901
#define	ID_METER_DYN_PREC    1902
#define	ID_METER_BACKGROUND  1904
#define	ID_METER_CENTERTEXT  1905
#define	ID_METER_BORDER 	 1906
#define	ID_METER_BORDER_ATTR 1907
#define	ID_METER_TAG 			1908
#define	ID_METER_NEEDLE_COL  1909
#define	ID_METER_BORDER_BKD_COL 1910
#define	ID_METER_ARC_BKD_COL 1911
#define	ID_METER_ARC_BKD_COL_TEXT 1912
// TIME AXIS
#define ID_TAXIS_START_HR     1950
#define ID_TAXIS_START_MIN    1951
#define ID_TAXIS_START_SEC    1952
#define ID_TAXIS_RANGE        1953
#define ID_TAXIS_UNITS        1954
#define ID_TAXIS_START_TEXT   1955





















