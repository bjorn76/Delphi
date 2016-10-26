object LMDFrmDateTimeEditor: TLMDFrmDateTimeEditor
  Left = 245
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'DateTime Editor'
  ClientHeight = 188
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDButton1: TLMDButton
    Left = 3
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Current Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = LMDButton1Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDGroupBox1: TLMDGroupBox
    Left = 3
    Top = 13
    Width = 185
    Height = 108
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    Caption = 'Date'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clBlack
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    CaptionParentFont = False
    TabOrder = 1
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 25
      Top = 19
      Width = 24
      Height = 15
      Caption = 'Day:'
      Options = []
    end
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 25
      Top = 51
      Width = 35
      Height = 15
      Caption = 'Month:'
      Options = []
    end
    object LMDSimpleLabel3: TLMDSimpleLabel
      Left = 25
      Top = 83
      Width = 27
      Height = 15
      Caption = 'Year:'
      Options = []
    end
    object DayEdit: TLMDSpinEdit
      Left = 81
      Top = 14
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 0
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MinValue = 1
      MaxValue = 31
      Value = 1
      DateTime = 0
    end
    object MonthEdit: TLMDSpinEdit
      Left = 81
      Top = 46
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 1
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MinValue = 1
      MaxValue = 12
      Value = 1
      DateTime = 0
    end
    object YearEdit: TLMDSpinEdit
      Left = 81
      Top = 78
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 2
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MinValue = 1900
      MaxValue = 3000
      Value = 2000
      DateTime = 0
    end
  end
  object LMDGroupBox2: TLMDGroupBox
    Left = 193
    Top = 13
    Width = 185
    Height = 108
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    Caption = 'Time'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clBlack
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    CaptionParentFont = False
    TabOrder = 2
    object LMDSimpleLabel4: TLMDSimpleLabel
      Left = 31
      Top = 19
      Width = 28
      Height = 15
      Caption = 'Hour:'
      Options = []
    end
    object LMDSimpleLabel5: TLMDSimpleLabel
      Left = 31
      Top = 51
      Width = 37
      Height = 15
      Caption = 'Minute:'
      Options = []
    end
    object LMDSimpleLabel6: TLMDSimpleLabel
      Left = 31
      Top = 83
      Width = 42
      Height = 15
      Caption = 'Second:'
      Options = []
    end
    object HourEdit: TLMDSpinEdit
      Left = 87
      Top = 14
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 0
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 23
      DateTime = 0
    end
    object MinuteEdit: TLMDSpinEdit
      Left = 87
      Top = 46
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 1
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 59
      DateTime = 0
    end
    object SecondEdit: TLMDSpinEdit
      Left = 87
      Top = 78
      Width = 60
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 2
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 59
      DateTime = 0
    end
  end
  object LMDButton2: TLMDButton
    Left = 194
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Current Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = LMDButton2Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object Button1: TButton
    Left = 224
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 304
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 9
    Top = 158
  end
end
