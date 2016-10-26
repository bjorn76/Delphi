/******************************************************************/
/*                                                                */
/*     Copyright (C) QUINN-CURTIS, Inc, 1994, 1998                */
/*                                                                */
/******************************************************************/
/*                                                                */
/*   Filename :   RTSTR.H                                         */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/*                                                                */
/*   Description: Text string definitions                         */  
/*                                                                */
/******************************************************************/

#define  ERR_RT       100       // first code for RT Tools errors
#define  ERR_DDE      100       // first code for DDE errors

#define  ERCRT_CONT     0
#define  ERCRT_TERM     1
#define  ERCRT_SERIOUS  2
#define  ERCRT_CRITICAL 3
#define  ERCRT_INFO     4
#define  ERCRT_DDE      5

#define  ERRRT_START   90

#define  ERR_DDE_ADVACKTIMEOUT         ERR_DDE 
#define  ERR_DDE_BUSY                  ERR_DDE + 1
#define  ERR_DDE_DATAACKTIMEOUT        ERR_DDE + 2
#define  ERR_DDE_DLL_NOT_INITIALIZED   ERR_DDE + 3
#define  ERR_DDE_DLL_USAGE             ERR_DDE + 4
#define  ERR_DDE_EXECACKTIMEOUT        ERR_DDE + 5
#define  ERR_DDE_INVALIDPARAMETER      ERR_DDE + 6
#define  ERR_DDE_LOW_MEMORY            ERR_DDE + 7
#define  ERR_DDE_MEMORY_ERROR          ERR_DDE + 8
#define  ERR_DDE_NOTPROCESSED          ERR_DDE + 9
#define  ERR_DDE_NO_CONV_ESTABLISHED   ERR_DDE + 10
#define  ERR_DDE_POKEACKTIMEOUT        ERR_DDE + 11
#define  ERR_DDE_POSTMSG_FAILED        ERR_DDE + 12
#define  ERR_DDE_REENTRANCY            ERR_DDE + 13
#define  ERR_DDE_SERVER_DIED           ERR_DDE + 14
#define  ERR_DDE_SYS_ERROR             ERR_DDE + 15
#define  ERR_DDE_UNADVACKTIMEOUT       ERR_DDE + 16
#define  ERR_DDE_UNFOUND_QUEUE_ID      ERR_DDE + 17

#define  ERR_DDE_TOOMANY_CONV          ERR_DDE + 18
#define  ERR_DDE_TOOMANY_ITEMS         ERR_DDE + 19

#define  ERR_DDE_LAST                  ERR_DDE + 19


#define  ERR_ENDRTINFO      132
#define  RTERR_TIMERS ERR_ENDRTINFO + 1
#define  RTERR_NOHIST ERR_ENDRTINFO + 2
#define  RTERR_BADRANGE ERR_ENDRTINFO + 3
#define  RTERR_SMALLW   ERR_ENDRTINFO + 4

#define  ERR_ENDRTWARNING  148
#define  RTERR_VERSION   ERR_ENDRTWARNING + 1

#define  RTS_TAG    48
#define  RTS_UNITS RTS_TAG + 1
#define  RTS_SETP  RTS_TAG + 2
#define  RTS_ALM   RTS_TAG + 3
#define  RTS_DESC  RTS_TAG + 4
#define  RTS_VALUE RTS_TAG + 5

#define  RTS_HR    RTS_TAG + 6
#define  RTS_MIN   RTS_TAG + 7
#define  RTS_SEC   RTS_TAG + 8

