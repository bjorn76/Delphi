object LMDLEDEditorDlg: TLMDLEDEditorDlg
  Left = 350
  Top = 328
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'LED-Editor'
  ClientHeight = 326
  ClientWidth = 508
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
    Top = 185
    Width = 497
    Height = 8
    Shape = bsBottomLine
  end
  object test: TLMDLEDLabel
    Left = 9
    Top = 7
    Width = 153
    Height = 28
    Hint = 'Shows the current settings.'
    AutoSize = True
    Bevel.Mode = bmCustom
    LED.Horzsize = 9
    LED.Vertsize = 7
    Caption = 'TEST-LED'
  end
  object Label3: TLabel
    Left = 26
    Top = 214
    Width = 45
    Height = 13
    Caption = '&HorzSize:'
    FocusControl = edhs
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 26
    Top = 242
    Width = 42
    Height = 13
    Caption = '&VertSize:'
    FocusControl = edvs
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 26
    Top = 268
    Width = 52
    Height = 13
    Caption = '&Thickness:'
    FocusControl = edt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 166
    Top = 214
    Width = 57
    Height = 13
    Caption = '&ActiveColor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 166
    Top = 268
    Width = 55
    Height = 13
    Caption = '&Pred. Color:'
    FocusControl = pred
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 166
    Top = 242
    Width = 66
    Height = 13
    Caption = '&InActiveColor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 239
    Top = 285
    Width = 114
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -8
    Font.Name = 'Small Fonts'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'Predefined Color-Settings for Active-/InActiveColor'#13#10'don'#39't appea' +
      'r in the Combobox.'
    Options = []
  end
  object bt1: TLMDDockSpeedButton
    Left = 372
    Top = 207
    Width = 24
    Height = 21
    ParentFont = False
    OnClick = btn
    CtlXP = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    FontFX.Tracing = 1
    Control = cmbb
  end
  object bt2: TLMDDockSpeedButton
    Left = 372
    Top = 235
    Width = 24
    Height = 21
    ParentFont = False
    OnClick = btn
    CtlXP = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    FontFX.Tracing = 1
    Control = cmbL
  end
  object edhs: TLMDSpinEdit
    Left = 85
    Top = 208
    Width = 48
    Height = 21
    Hint = 'Defines the horizontal size of the LED-letters.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 0
    OnChange = edchange
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 3
    AutoSelect = True
    ParentFont = False
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 255
    Value = 1
    DateTime = 0
  end
  object edvs: TLMDSpinEdit
    Left = 85
    Top = 235
    Width = 48
    Height = 21
    Hint = 'Defines the vertical size of the LED-letters.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 1
    OnChange = edchange
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 3
    AutoSelect = True
    ParentFont = False
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 255
    Value = 1
    DateTime = 0
  end
  object edt: TLMDSpinEdit
    Left = 85
    Top = 262
    Width = 48
    Height = 21
    Hint = 'Defines the thickness of the LED-letters.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 2
    OnChange = edchange
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 2
    AutoSelect = True
    ParentFont = False
    CustomButtons = <>
    SpinBtnDiag = False
    Value = 1
    DateTime = 0
  end
  object chk: TCheckBox
    Left = 26
    Top = 294
    Width = 104
    Height = 20
    Hint = 
      'If DisabledDigits is set to true and'#13#10'Enabled to false, the LED ' +
      'will be '#13#10'displayed with the InactiveColor.'
    Caption = ' &DisabledDigits'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = chkClick
  end
  object cmbb: TLMDColorComboBox
    Left = 239
    Top = 207
    Width = 132
    Height = 21
    Hint = 'Defines the color for active LED-letters.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = cmbc
  end
  object cmbL: TLMDColorComboBox
    Left = 239
    Top = 235
    Width = 132
    Height = 21
    Hint = 'Defines the color for inactive LED-letters.'
    DlgOptions = []
    DlgHelpContext = 0
    Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnChange = cmbc
  end
  object pred: TComboBox
    Left = 239
    Top = 262
    Width = 132
    Height = 21
    Hint = 'Defines the color for both '#13#10'active and inactive LED-letters.'
    Style = csDropDownList
    DropDownCount = 4
    ItemHeight = 13
    TabOrder = 6
    OnChange = predChange
  end
  object ok: TButton
    Left = 420
    Top = 204
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object Button1: TButton
    Left = 420
    Top = 231
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object reset: TButton
    Left = 420
    Top = 268
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 9
    OnClick = resetClick
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 452
    Top = 21
  end
end
