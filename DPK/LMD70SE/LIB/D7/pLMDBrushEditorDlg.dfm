object LMDBrushEditorDlg: TLMDBrushEditorDlg
  Left = 581
  Top = 369
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TBrush-Editor'
  ClientHeight = 162
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 76
    Width = 288
    Height = 8
    Shape = bsBottomLine
  end
  object Label5: TLabel
    Left = 12
    Top = 102
    Width = 27
    Height = 13
    Caption = 'Color:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 11
    Top = 127
    Width = 26
    Height = 13
    Caption = 'Style:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object LMDDrawEdge1: TLMDDrawEdge
    Left = 6
    Top = 91
    Width = 212
    Height = 66
  end
  object test: TShape
    Left = 69
    Top = 10
    Width = 147
    Height = 58
  end
  object dlgl: TLMDDockSpeedButton
    Left = 176
    Top = 98
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
    Control = cmbc
    GlyphKind = gkColor
  end
  object cmbc: TLMDColorComboBox
    Left = 45
    Top = 98
    Width = 130
    Height = 21
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = cmbcChange
  end
  object cmb: TComboBox
    Left = 45
    Top = 124
    Width = 130
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnChange = cmbChange
    Items.Strings = (
      'bsSolid'
      'bsClear'
      'bsHorizontal'
      'bsVertical'
      'bsFDiagonal'
      'bsBDiagonal'
      'bsCross'
      'bsDiagCross')
  end
  object btnOK: TLMDButton
    Left = 224
    Top = 96
    Width = 70
    Height = 22
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
    CtlXP = False
  end
  object btnCancel: TLMDButton
    Left = 224
    Top = 120
    Width = 70
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
    CtlXP = False
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 272
    Top = 21
  end
end
