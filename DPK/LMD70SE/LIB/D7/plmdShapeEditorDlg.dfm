object LMDShapeEditorDlg: TLMDShapeEditorDlg
  Left = 337
  Top = 232
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'LMDShape-Editor'
  ClientHeight = 170
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 92
    Width = 295
    Height = 8
    Shape = bsBottomLine
  end
  object Label4: TLabel
    Left = 13
    Top = 113
    Width = 34
    Height = 13
    Caption = '&Shape:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object test: TLMDShapeControl
    Left = 65
    Top = 5
    Width = 141
    Height = 86
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
  end
  object pred: TComboBox
    Left = 64
    Top = 106
    Width = 139
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = predChange
    Items.Strings = (
      'stEllipse'
      'stRectangle'
      'stRoundRect'
      'stDirectUp'
      'stDirectRight'
      'stDirectDown'
      'stDirectLeft'
      'stDiamond'
      'stComb'
      'stOctagon'
      'stStar')
  end
  object btnOK: TButton
    Left = 229
    Top = 106
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
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 229
    Top = 131
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
    TabOrder = 2
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 259
    Top = 16
  end
end
