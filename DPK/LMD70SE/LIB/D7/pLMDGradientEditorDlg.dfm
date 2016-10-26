object LMDGradientEditorDlg: TLMDGradientEditorDlg
  Left = 470
  Top = 156
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Gradient-Editor'
  ClientHeight = 308
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 165
    Width = 449
    Height = 8
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 6
    Top = 176
    Width = 359
    Height = 124
  end
  object Label3: TLabel
    Left = 16
    Top = 187
    Width = 55
    Height = 13
    Caption = '&ColorCount:'
    FocusControl = edbiw
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 16
    Top = 254
    Width = 27
    Height = 13
    Caption = 'Co&lor:'
    FocusControl = cmbb
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 16
    Top = 279
    Width = 46
    Height = 13
    Caption = '&EndColor:'
    FocusControl = cmbL
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 239
    Top = 258
    Width = 45
    Height = 13
    Caption = '&Direction:'
    FocusControl = direct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object test: TLMDFill
    Left = 60
    Top = 18
    Width = 331
    Height = 136
    Bevel.Mode = bmStandard
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    FillObject.Style = sfGradient
  end
  object bt1: TLMDDockSpeedButton
    Left = 202
    Top = 249
    Width = 23
    Height = 21
    OnClick = btn
    CtlXP = False
    Control = cmbb
    GlyphKind = gkColor
  end
  object bt2: TLMDDockSpeedButton
    Left = 202
    Top = 273
    Width = 23
    Height = 21
    OnClick = btn
    CtlXP = False
    Control = cmbL
    GlyphKind = gkColor
  end
  object ext_std: TLMDSpeedButton
    Left = 16
    Top = 208
    Width = 40
    Height = 20
    Caption = 'Ext >>'
    OnClick = ext_stdClick
    CtlXP = False
  end
  object LMDDrawEdge1: TLMDDrawEdge
    Left = 60
    Top = 225
    Width = 160
    Height = 5
    Filled = True
    FrameSides = [fsTop]
  end
  object addBtn: TLMDSpeedButton
    Left = 150
    Top = 232
    Width = 50
    Height = 20
    Caption = 'Add'
    Visible = False
    OnClick = addBtnClick
    CtlXP = False
  end
  object delBtn: TLMDSpeedButton
    Left = 150
    Top = 255
    Width = 50
    Height = 20
    Caption = 'Delete'
    Visible = False
    OnClick = delBtnClick
    CtlXP = False
  end
  object edbiw: TLMDSpinEdit
    Left = 84
    Top = 181
    Width = 48
    Height = 21
    Hint = 'Defines how many colors are to be used.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 0
    OnChange = edchange
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
    MaxValue = 236
    Value = 1
    DateTime = 0
  end
  object direct: TComboBox
    Left = 241
    Top = 273
    Width = 118
    Height = 21
    Hint = 'Specifies the direction of the gradient,'
    Style = csDropDownList
    DropDownCount = 4
    ItemHeight = 13
    TabOrder = 3
    OnChange = directChange
    Items.Strings = (
      'gsHorizontal'
      'gsVertical'
      'gsSquare'
      'gsElliptic'
      'gsTopLeft'
      'gsTopRight'
      'gsBottomLeft'
      'gsBottomRight'
      'gsTopLeftDiagonal'
      'gsTopRightDiagonal')
  end
  object cmbb: TLMDColorComboBox
    Left = 69
    Top = 249
    Width = 132
    Height = 21
    Hint = 'Specifies the beginning color.'
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
    OnChange = cmbc
  end
  object cmbL: TLMDColorComboBox
    Left = 69
    Top = 273
    Width = 132
    Height = 21
    Hint = 'Specifies the end color.'
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
    OnChange = cmbc
  end
  object clb: TLMDColorListBox
    Left = 17
    Top = 232
    Width = 112
    Height = 62
    CtlXP = False
    ItemHeight = 16
    TabOrder = 4
    Visible = False
    OnClick = clbClick
    DlgOptions = [cdFullOpen]
    DlgHelpContext = 0
    Options = [coCustomColors, coAllowAnyColor]
  end
  object ok: TLMDButton
    Left = 377
    Top = 184
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
    CtlXP = False
  end
  object cancel: TLMDButton
    Left = 377
    Top = 212
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
    CtlXP = False
  end
  object reset: TLMDButton
    Left = 377
    Top = 248
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 7
    OnClick = resetClick
    CtlXP = False
  end
  object chk: TLMDCheckBox
    Left = 240
    Top = 184
    Width = 105
    Height = 17
    Hint = 'If set, the palette will be realized.'
    CtlXP = False
    Caption = ' &PaletteRealize'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    Flat = True
    TabOrder = 8
    OnClick = chkClick
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 405
    Top = 43
  end
  object cd: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 144
    Top = 200
  end
end
