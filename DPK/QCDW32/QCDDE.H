/******************************************************************/
/*                                                                */
/*     Copyright (C) QUINN-CURTIS, Inc, 1994, 1998                */
/*                                                                */
/******************************************************************/
/**                                                               */
/**   Filename :   qcdde.h                                        */
/**   Author   :   QC                                                    */
/**   Revision :   3.0                                                   */
/**   Date     :   August 15, 1998                                       */
/**   Product  :   Windows Real Time Tools                        */
/**                                                               */
/**   Description:  Prototypes for DDE functions                  */
/**                                                               */
/******************************************************************/

#ifdef __cplusplus
extern  "C" {
#endif
                 
#ifndef _QCDDEH
#define _QCDDEH
                 
#ifndef _INC_DDEML
#include <ddeml.h>
#endif

/**************************************************************************/
/* DDE definitions */

DWORD WINAPI _export WRInitDde (void);
void WINAPI _export WRSetDdeProc (FARPROC UserDdeProc);
HCONV WINAPI _export WRConnectDDE (HDATA hData, LPSTR lpServName, 
    LPSTR lpService, LPSTR lpTopic, LPSTR lpItem, BOOL bAuto);

/***************************************************************************/

#endif

#ifdef __cplusplus
}
#endif
/**************************************************************************/
