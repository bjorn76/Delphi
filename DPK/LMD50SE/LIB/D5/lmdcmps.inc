{LMD-TOOLS V5.X - © 2001 by LMD Innovative}
{******************************************************************************}
{$DEFINE LMDTOOLS50}

{***************** TLMDObjectStorage, activate ZLib support *******************}
{.$DEFINE ZLIB}    // Remove point to activate compression support

{***************** Include Symbol and Debug-Information? **********************}
{.$DEFINE LMDDEBUG}    {remove . if you need Debug-Information...}

{$IFDEF LMDDEBUG}
{$D+,L+,Y+}
{$ELSE}
{$D-,L-,Y-,O+}
{$ENDIF}

{*********************** Include Compiler Check *******************************}
{$I lmdcmpV.inc}

{************************ Internal settings ***********************************}

//these flags are needed internally for special debugging purposes
{.$DEFINE LMDDEBUGTRACE}
{.$DEFINE LMDDEBUGCODE}

//these flags are needed internally for creating special releases
{.$DEFINE TRIAL}
{$DEFINE LMDTOOLS_SPECIALEDITION}

//these flags are for testing purposes only
{$IFDEF DELPHI5}
  {.$DEFINE PROPINSP_ENH}
{$ENDIF}

{***************** These compiler settings shouldn't be changed ***************}
{$B-,X+,P+,R-,Q-,H+,W-,J-,A+,T-,S+,V-}

