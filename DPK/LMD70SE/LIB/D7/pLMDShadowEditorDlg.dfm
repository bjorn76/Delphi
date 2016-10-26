object LMDShadowEditorDlg: TLMDShadowEditorDlg
  Left = 311
  Top = 151
  BorderStyle = bsDialog
  Caption = 'TLMDShadow-Editor'
  ClientHeight = 272
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 154
    Width = 358
    Height = 8
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 6
    Top = 169
    Width = 266
    Height = 97
  end
  object test: TLMDShapeControl
    Left = 31
    Top = 15
    Width = 190
    Height = 125
    Caption.Caption = 'Shadow-Testobject'
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clBlack
    Caption.Font.Height = -13
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    RoundPercent = 100
    Shape = stEllipse
    Mode = scmShapeFill
  end
  object Label1: TLabel
    Left = 19
    Top = 189
    Width = 29
    Height = 13
    Caption = 'Style: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 19
    Top = 215
    Width = 30
    Height = 13
    Caption = 'Color: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 19
    Top = 241
    Width = 32
    Height = 13
    Caption = 'Depth:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 240
    Top = 30
    Width = 89
    Height = 44
    Caption = 
      'Using white as shadow-color will not work if tracing style is se' +
      'lected.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object dlgl: TLMDDockSpeedButton
    Left = 227
    Top = 209
    Width = 22
    Height = 21
    ParentFont = False
    OnClick = dlglClick
    CtlXP = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    FontFX.Tracing = 1
    Control = cmbS
    GlyphKind = gkColor
  end
  object cmbstyle: TComboBox
    Left = 68
    Top = 182
    Width = 158
    Height = 21
    Hint = 'Specifies the stlye of shadow to be used.'
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnChange = cmbChange
    Items.Strings = (
      'hssNone'
      'hssSolid'
      'hssTracing')
  end
  object cmbS: TLMDColorComboBox
    Left = 68
    Top = 209
    Width = 158
    Height = 21
    Hint = 'Specifies the color of the shadow.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = cmbSChange
  end
  object spind: TLMDSpinEdit
    Left = 68
    Top = 235
    Width = 47
    Height = 21
    Hint = 'Specifies the Depth of the shadow.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 2
    OnChange = spindChange
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    AutoSelect = True
    ParentFont = False
    CustomButtons = <>
    SpinBtnDiag = False
    DateTime = 0
  end
  object ok: TButton
    Left = 283
    Top = 168
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 283
    Top = 195
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object reset: TButton
    Left = 283
    Top = 232
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 5
    OnClick = resetClick
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 284
    Top = 92
  end
end
