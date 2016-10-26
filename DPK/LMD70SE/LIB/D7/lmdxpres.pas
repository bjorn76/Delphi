{$IFNDEF CLR}
unit LMDXPRes;
{$ENDIF}

{
  ##############################################################################
  # Author:             LMD Innovative (RM)
  # Created:            2002
  # Description:        Include in your application to integrate XP Styles
  #                     for standard controls
  # State: release
  # Comments:
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

implementation
uses
  lmdclass;

{$R lmdxp.res}

initialization
  LMDApplication.XPManifestAvailable:=True;

end.
