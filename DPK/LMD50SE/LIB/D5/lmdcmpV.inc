{LMD-TOOLS V5.X - © 2001 by LMD Innovative}
{******************************************************************************}

{***************** LMD Tools or package ***************************************}
{$DEFINE LMD_TOOLS}

{***************** Windows NT3.51 compatibility *******************************}
{.$DEFINE WINNT351}
{to achive full NT 3.51 compatability activate compiler switch}


{***************** Compiler Informations **************************************}
{$IFDEF LMDDEBUG}
  {$HINTS ON; WARNINGS ON}
{$ELSE}
  {$HINTS OFF; WARNINGS OFF}
{$ENDIF}

{*************** Determine Delphi/CBuilder Version ****************************}

{$IFDEF VER100}
  {$DEFINE LMDCOMP3}
  {$DEFINE DELPHI3}
{$ENDIF}

{$IFDEF VER110}
  {$DEFINE LMDCOMP3}
  {$DEFINE CPPBUILDER}
  {$DEFINE CPPBUILDER3}
  {$ObjExportAll On}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE LMDCOMP4}
  {$DEFINE DELPHI4}
{$ENDIF}

{$IFDEF VER125}
  {$DEFINE LMDCOMP4}
  {$DEFINE CPPBUILDER}
  {$DEFINE CPPBUILDER4}
  {$ObjExportAll On}
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE NEW32C}
  {$DEFINE LMDCOMP4}
  {$DEFINE LMDCOMP5}
  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE CBUILDER5}
  {$ELSE}
    {$DEFINE DELPHI5}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE NEW32C}
  {$DEFINE LMDCOMP4}
  {$DEFINE LMDCOMP5}
  {$DEFINE LMDCOMP6}
  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE CBUILDER6}
  {$ELSE}
    {$DEFINE DELPHI6}
  {$ENDIF}
{$ENDIF}

