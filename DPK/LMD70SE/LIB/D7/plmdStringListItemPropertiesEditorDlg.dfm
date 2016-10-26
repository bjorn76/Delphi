object LMDfrmsiprop: TLMDfrmsiprop
  Left = 285
  Top = 174
  Width = 446
  Height = 383
  BorderIcons = [biSystemMenu]
  Caption = 'StringListItem - Properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 104
    Top = 80
    Width = 33
    Height = 15
    Caption = 'Lines: '
    Options = []
  end
  object l: TLMDSimpleLabel
    Left = 144
    Top = 80
    Width = 64
    Height = 12
    Alignment = agTopRight
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Options = []
  end
  object btnfile: TLMDSpeedButton
    Left = 2
    Top = 70
    Width = 41
    Height = 22
    Caption = '&File'
    ButtonLayout.OffsetX = 5
    ButtonLayout.Arrow = True
    CtlXP = False
    EnterColor = clNavy
    EnterColorChange = True
    DropDownMenu = mfile
  end
  object btnEdit: TLMDSpeedButton
    Left = 43
    Top = 70
    Width = 41
    Height = 22
    Caption = '&Edit'
    ButtonLayout.OffsetX = 5
    ButtonLayout.Arrow = True
    CtlXP = False
    EnterColor = clNavy
    EnterColorChange = True
    DropDownMenu = editmenu
  end
  object Button1: TButton
    Left = 360
    Top = 7
    Width = 72
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 360
    Top = 32
    Width = 72
    Height = 22
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Editor: TMemo
    Left = 0
    Top = 103
    Width = 438
    Height = 246
    Anchors = [akLeft, akTop, akRight, akBottom]
    HideSelection = False
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
    OnChange = EditorChange
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 2
    Top = 4
    Width = 351
    Height = 61
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    TabOrder = 2
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 12
      Top = 13
      Width = 34
      Height = 15
      Caption = 'Index: '
      Options = []
    end
    object Index: TLMDSimpleLabel
      Left = 67
      Top = 12
      Width = 7
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Options = []
    end
    object LMDSimpleLabel3: TLMDSimpleLabel
      Left = 221
      Top = 36
      Width = 29
      Height = 15
      Caption = 'Ident:'
      Options = []
    end
    object LMDSimpleLabel5: TLMDSimpleLabel
      Left = 221
      Top = 13
      Width = 89
      Height = 15
      Caption = 'External StringList:'
      Options = []
    end
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 12
      Top = 35
      Width = 36
      Height = 15
      Caption = 'Descr.:'
      Options = []
    end
    object ed: TLMDSpinEdit
      Left = 262
      Top = 33
      Width = 79
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 1
      MaxLength = 5
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 65535
      DateTime = 0
    end
    object desc: TEdit
      Left = 52
      Top = 32
      Width = 147
      Height = 21
      TabOrder = 2
    end
    object compress: TCheckBox
      Left = 122
      Top = 13
      Width = 76
      Height = 13
      Caption = 'Compre&ssed'
      TabOrder = 0
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 383
    Top = 216
  end
  object editmenu: TPopupMenu
    OnPopup = editmenuPopup
    Left = 353
    Top = 211
    object Cut1: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 16472
      OnClick = editclick
    end
    object Copy1: TMenuItem
      Tag = 1
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = editclick
    end
    object Paste1: TMenuItem
      Tag = 2
      Caption = '&Paste'
      ShortCut = 16470
      OnClick = editclick
    end
    object Delete1: TMenuItem
      Tag = 3
      Caption = '&Delete'
      ShortCut = 16430
      OnClick = editclick
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = editclick
    end
    object Selectall1: TMenuItem
      Tag = 4
      Caption = 'Select &all'
      ShortCut = 16449
      OnClick = editclick
    end
  end
  object mfile: TPopupMenu
    Left = 392
    Top = 192
    object Open2: TMenuItem
      Caption = '&Open'
      OnClick = fileclick
    end
    object Open1: TMenuItem
      Tag = 1
      Caption = '&Save'
      OnClick = fileclick
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofNoReadOnlyReturn]
    Left = 289
    Top = 207
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 318
    Top = 207
  end
end
