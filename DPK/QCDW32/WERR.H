/************************************************************************/
/*                                                                      */
/*     Copyright (C) QUINN-CURTIS, 1992 - 1998                          */
/*                                                             	        */
/************************************************************************/
/**		                                                                */
/**   Filename :   WERR.H                                               */
/**   Author   :   QC                                                   */
/**   Revision :   3.0                                                  */
/**   Date     :   August 15, 1998                                      */
/**                                                                     */   
/************************************************************************/

#include "strings.h"

#ifdef __cplusplus
extern  "C" {
#endif

int WINAPI _export ErrHdlr (int nErrCode, int fPar, LPCSTR szParam);

// ERROR SEVERITY

#define    ERS_INFO           0
#define    ERS_WARNING        1
#define    ERS_SEVERE         2
#define    ERS_TERMINAL       3

// ERROR HANDLER RETURN CODES

#define    ERH_CONTINUE    0
#define    ERH_EXIT        1

// ERROR MESSAGE PARAMETER FLAG VALUES:

#define  ERP_NONE       0     // no parameter
#define  ERP_FRONT      1     // parameter in the beginning
#define  ERP_END        2     // parameter in the back

/**************************************************************************/
/* Macros to start and end gui support routines				  */
/**************************************************************************/

#define _PrimStart_ POBJ_HEAD pObjDesc;\
    if (pGrDesc == NULL) return 0; \
	pObjDesc = GetObjDesc (pGrDesc, hObj, NULL);\
    if (pObjDesc != NULL)\
    {\
        switch (pObjDesc->nType)\
        {\

#define _PrimEnd_ default:\
            { \
			   ReportIllFunc ((POBJ_HEAD)pObjDesc);\
			}\
        }\
    }\
    else\
         ErrHdlr (ERR_BAD_OBJ_HANDLE, ERP_NONE, NULL);\

                   // error checking macro - bad object
#define _BadObjErr   char szBuf[13]; \
            LoadString (_hInst, IDS_OT + pObjDesc->header.nType,\
                (LPSTR) szBuf, 12);\
            ErrHdlr (ERR_ILLEGAL_FUNC_OBJ, ERP_END, szBuf);\
            bRet = FALSE;\

#ifdef __cplusplus
}
#endif
/**************************************************************************/
