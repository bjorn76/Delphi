object LMDSimpleBevelEditorDlg: TLMDSimpleBevelEditorDlg
  Left = 37
  Top = 129
  BorderStyle = bsDialog
  Caption = 'TLMDSimpleBevel-Editor'
  ClientHeight = 322
  ClientWidth = 394
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
    Width = 385
    Height = 8
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 4
    Top = 170
    Width = 296
    Height = 146
  end
  object Label1: TLabel
    Left = 18
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
    Left = 18
    Top = 216
    Width = 53
    Height = 13
    Caption = 'LightColor: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 18
    Top = 294
    Width = 31
    Height = 13
    Caption = 'Width:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object test: TLMDShapeControl
    Left = 87
    Top = 26
    Width = 198
    Height = 101
    Hint = 'Displays the current settings.'
    Bevel.Width = 1
    Brush.Color = clBtnFace
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Shadow.Style = hssNone
    Shape = stEllipse
  end
  object Label2: TLabel
    Left = 18
    Top = 241
    Width = 69
    Height = 13
    Caption = 'ShadowColor: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 18
    Top = 266
    Width = 63
    Height = 13
    Caption = 'NormalColor: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object cmbstyle: TComboBox
    Left = 95
    Top = 182
    Width = 157
    Height = 21
    Hint = 'Specifies the style for the bevel.'
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
      'sbNormal'
      'sbInset'
      'sbOffset')
  end
  object spind: TLMDSpinEdit
    Left = 95
    Top = 288
    Width = 47
    Height = 21
    Hint = 'Define the width of the bevel.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 1
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
  object cmbL: TLMDColorComboBox
    Left = 95
    Top = 210
    Width = 157
    Height = 21
    Hint = 'Defines the LightColor for 3D-effects.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = cmbSChange
  end
  object dlgl: TButton
    Left = 252
    Top = 210
    Width = 34
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = dlglClick
  end
  object cmbs: TLMDColorComboBox
    Left = 94
    Top = 235
    Width = 157
    Height = 21
    Hint = 'Defines the ShadowColor for 3D-effects.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coCustomColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = cmbSChange
  end
  object dlgs: TButton
    Left = 252
    Top = 235
    Width = 34
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = dlglClick
  end
  object cmbn: TLMDColorComboBox
    Left = 95
    Top = 260
    Width = 157
    Height = 21
    Hint = 'Defines the NormalColor while not using 3D-effects.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coCustomColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnChange = cmbSChange
  end
  object dlgn: TButton
    Left = 252
    Top = 260
    Width = 34
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = dlglClick
  end
  object ok: TButton
    Left = 309
    Top = 170
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object Button1: TButton
    Left = 309
    Top = 198
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object reset: TButton
    Left = 309
    Top = 235
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 10
    OnClick = resetClick
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 353
    Top = 24
  end
end
