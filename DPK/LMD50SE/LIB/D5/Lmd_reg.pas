unit Lmd_reg;

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description: LMD Tools registration unit
  # State: release
  # Comments: Use lmdctabs.inc to turn on/off component tabs
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

{$I lmdcmps.inc}
{$I lmdctabs.inc}

procedure Register;

implementation

uses
  {$IFDEF LMDDEFAULTCP} lmdregst, {$ENDIF}
  {$IFDEF LMDEDITCP} lmdregec, {$ENDIF}
  {$IFDEF LMDEXTENDEDCP} lmdregex, {$ENDIF}
  {$IFDEF LMDDIALOGCP} lmdregdg, {$ENDIF}
  {$IFDEF LMDSYSTEMCP} lmdregsy, {$ENDIF}
  {$IFDEF LMDMMCP} lmdregmm, {$ENDIF}
  {$IFDEF LMDFORM} lmdregform, {$ENDIF}
  {$IFDEF LMDCONTAINERCP} lmdregcont, {$ENDIF}
  {$IFDEF LMDSHELLCP} lmdregshell, {$ENDIF}

  {$IFNDEF LMDTOOLS_SPECIALEDITION}

    {$IFDEF LMDDBCP} lmdregdb, {$ENDIF}
    {$IFDEF LMDDBEDCP} lmdregdbed, {$ENDIF}
    {$IFNDEF LMDCOMP3} LMDRegOS, {$ENDIF}

    {$IFDEF LMDV3CP} lmdregv3, {$ENDIF}
    {$IFDEF LMDCUSTOMEDITORS} lmdreged, {$ENDIF}

  {$ENDIF}

  lmdreg_property_editors,
  {$IFDEF LMDCOMP6} DesignIDE {$ELSE} DsgnIntf {$ENDIF};

{------------------------------------------------------------------------------}
procedure Register;
begin
  {$IFDEF LMDDEFAULTCP} lmdregst.Register; {$ENDIF}
  {$IFDEF LMDCONTAINERCP} lmdregcont.Register; {$ENDIF}
  {$IFDEF LMDEXTENDEDCP} lmdregex.Register; {$ENDIF}
  {$IFDEF LMDEDITCP} lmdregec.Register; {$ENDIF}
  {$IFDEF LMDFORM} lmdregform.Register; {$ENDIF}
  {$IFDEF LMDDIALOGCP} lmdregdg.Register; {$ENDIF}
  {$IFDEF LMDSYSTEMCP} lmdregsy.Register; {$ENDIF}
  {$IFDEF LMDMMCP} lmdregmm.Register; {$ENDIF}
  {$IFDEF LMDSHELLCP} lmdregshell.Register; {$ENDIF}  

  {$IFNDEF LMDTOOLS_SPECIALEDITION}

    {$IFDEF LMDDBCP} lmdregdb.Register; {$ENDIF}
    {$IFDEF LMDDBEDCP} lmdregdbed.Register; {$ENDIF}

  {$ENDIF}

  lmdreg_property_editors.Register;

  {$IFNDEF LMDTOOLS_SPECIALEDITION}

    {$IFDEF LMDCUSTOMEDITORS} lmdreged.Register; {$ENDIF}
    {$IFDEF LMDV3CP} lmdregv3.Register; {$ENDIF}
    {$IFNDEF LMDCOMP3} lmdregos.Register; {$ENDIF}

  {$ENDIF}

end ;

end.
