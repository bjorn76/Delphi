object frmxp2: Tfrmxp2
  Left = 437
  Top = 481
  Width = 658
  Height = 451
  Caption = 'frmxp2'
  Color = 14811135
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 8
    Top = 19
    Width = 94
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'How To...'
    Options = []
  end
  object LMDSimpleLabel3: TLMDSimpleLabel
    Left = 8
    Top = 61
    Width = 573
    Height = 36
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'LMD-Tools provides to different kinds of Theme-Support. On the o' +
      'ne hand, XP Theme Support for all LMD-Tools controls (which supp' +
      'ort the look natively) can be switched on/off using the  global'
    Options = []
  end
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 192
    Top = 102
    Width = 219
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    Caption = 'LMDApplication.UseXPThemes'
    Options = []
  end
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 8
    Top = 134
    Width = 573
    Height = 53
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'variable. Check out the helpfile for more information about the ' +
      'global LMDApplication object and its features. On the other hand' +
      ' most LMD controls supporting Themes contain a CtlXP property, b' +
      'y which XP look can be switched off even if UseXPThemes is enabl' +
      'ed.'
    Options = []
  end
  object LMDSimpleLabel5: TLMDSimpleLabel
    Left = 8
    Top = 194
    Width = 40
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    Caption = 'Note:'
    Options = []
  end
  object LMDSimpleLabel6: TLMDSimpleLabel
    Left = 8
    Top = 213
    Width = 573
    Height = 33
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'If LMDApplication.UseXPThemes is set to false, Themes support is' +
      ' switched off for all controls, even if CtlXP is enabled.'
    Options = []
  end
  object LMDSimpleLabel7: TLMDSimpleLabel
    Left = 8
    Top = 261
    Width = 573
    Height = 70
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'Since Version 6.1 we simplified support for XP Themes look for a' +
      'll other Delphi controls (which are derived from standard Window' +
      's controls, like most of the VCL controls like TEdit, TTreeView ' +
      'etc.). Instead creating a Manifest file for your application, yo' +
      'u need only to include LMDXPRes unit in the uses clause of ONE o' +
      'f your project files. In addition you can then specify by the '
    Options = []
  end
  object LMDSimpleLabel8: TLMDSimpleLabel
    Left = 170
    Top = 337
    Width = 281
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    Caption = 'LMDApplication.UseXPThemesLMDOnly'
    Options = []
  end
  object LMDSimpleLabel9: TLMDSimpleLabel
    Left = 8
    Top = 364
    Width = 573
    Height = 34
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'whether switching off LMDApplication.UseXPThemes affects all con' +
      'trols or LMD-Tools components only.'
    Options = []
  end
end
