{LMD-TOOLS V5.X - © 2001 by LMD Innovative}
{******************************************************************************}

{ Specifies various compiler settings }
{ Which parts of LMD-Tools should be installed? These compiler switches help you
  to turn off installation of complete component groups. You may finetune these
  settings by changing registration source files manually.
}
{$DEFINE LMDDEFAULTCP}     {default components, do not deactivate! -> lmdregst.pas}
{$DEFINE LMDCONTAINERCP}   {LMD-Tools Container Controls, lmdregcont.pas}
{$DEFINE LMDEDITCP}        {Edit-/Listbox controls -> lmdregec.pas}
{$DEFINE LMDEXTENDEDCP}    {extended components -> lmdregex.pas}
{$DEFINE LMDDIALOGCP}      {extended components -> lmdregdg.pas}
{$DEFINE LMDFORM}          {components concerning with forms}
{$DEFINE LMDSYSTEMCP}      {extended components -> lmdregsy.pas}
{$DEFINE LMDMMCP}          {multimedia components -> lmdregmm.pas}
{$DEFINE LMDDBCP}          {datansensitive components -> lmdregdb.pas}
{$DEFINE LMDDBEDCP}        {datansensitive components -> lmdregdbed.pas}
{$DEFINE LMDSHELLCP}       {datansensitive components -> lmdregshell.pas}
{$DEFINE LMDCUSTOMEDITORS} {custom property editors (e.g. TBrush) -> lmdreged.pas}

//old controls
{$DEFINE LMDV3CP}          {obsolete LMD V3.x components}



{Specifies descriptions for components in Delphi IDE}
{------------------------------------------------------------------------------}
const
  CTRL_CONTAINER:String='LMD Cont';
  CTRL_DATABASE:String='LMD DB';
  CTRL_DATABASE_EDIT:String='LMD DB Edit';
  CTRL_DIALOG:String='LMD Dlg';
  CTRL_EXTENDED:String='LMD Ext';
  CTRL_MULTIMEDIA:String='LMD MM';
  CTRL_STANDARD:String='LMD Std';
  CTRL_EDIT:String='LMD Edit';
  CTRL_SYSTEM:String='LMD Sys';
  CTRL_FORM:String='LMD Form';
  CTRL_SHELL:String='LMD Shell';
  CTRL_V3COMP:String='LMD 3.X';



