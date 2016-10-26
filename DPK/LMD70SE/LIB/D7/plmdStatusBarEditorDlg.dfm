object LMDStatusBarEditorDlg: TLMDStatusBarEditorDlg
  Left = 309
  Top = 254
  ActiveControl = ListBox
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'StatusBar Editor'
  ClientHeight = 185
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 8
    Top = 8
    Width = 112
    Height = 15
    Caption = 'Pre-Defined StatusBars'
    Options = []
  end
  object Button1: TButton
    Left = 16
    Top = 152
    Width = 105
    Height = 25
    Caption = 'Ok && Insert'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 152
    Top = 152
    Width = 105
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ListBox: TListBox
    Left = 16
    Top = 24
    Width = 241
    Height = 113
    ItemHeight = 13
    Items.Strings = (
      'Text (Hint), Caps, Num, Scroll, Time'
      'Text (Hint), Caps, Num, Scroll, DateTime'
      'Text (Hint) only'
      'Caps, Num, Scroll'
      'DateTime'
      'CurrentUser')
    TabOrder = 2
    OnDblClick = ListBoxDblClick
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 8
    Top = 8
  end
end
