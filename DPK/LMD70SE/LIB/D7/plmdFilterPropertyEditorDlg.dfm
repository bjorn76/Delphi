object LMDFilterPropsDlg: TLMDFilterPropsDlg
  Left = 368
  Top = 247
  ActiveControl = FilterGrid
  BorderStyle = bsDialog
  Caption = 'Filter Editor'
  ClientHeight = 342
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 465
    Height = 289
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 175
    Top = 308
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 255
    Top = 308
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object FilterGrid: TStringGrid
    Left = 16
    Top = 16
    Width = 450
    Height = 273
    BorderStyle = bsNone
    ColCount = 2
    DefaultColWidth = 216
    FixedCols = 0
    RowCount = 100
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 392
    Top = 304
  end
end
