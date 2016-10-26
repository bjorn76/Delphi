object LMDFrmprop: TLMDFrmprop
  Left = 192
  Top = 318
  BorderStyle = bsDialog
  ClientHeight = 207
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object g2: TLMDGroupBox
    Left = 9
    Top = 8
    Width = 273
    Height = 161
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    Caption = 'BMP2IML, Import Options'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    TabOrder = 3
    object Count: TLMDSimpleLabel
      Left = 10
      Top = 26
      Width = 132
      Height = 15
      Caption = 'Number of items to convert:'
      Options = []
    end
    object rows: TComboBox
      Left = 145
      Top = 20
      Width = 64
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object mk: TLMDCheckBox
      Left = 8
      Top = 48
      Width = 105
      Height = 17
      CtlXP = False
      Caption = 'Masked'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Flat = True
      TabOrder = 1
    end
  end
  object Button1: TLMDButton
    Left = 144
    Top = 177
    Width = 65
    Height = 22
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    CtlXP = False
  end
  object Button2: TLMDButton
    Left = 216
    Top = 177
    Width = 65
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    CtlXP = False
  end
  object g1: TLMDGroupBox
    Left = 9
    Top = 9
    Width = 273
    Height = 161
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    Caption = 'Properties'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    TabOrder = 0
    object Label2: TLabel
      Left = 11
      Top = 23
      Width = 34
      Height = 13
      Caption = 'Descr.:'
    end
    object Width: TLabel
      Left = 12
      Top = 50
      Width = 31
      Height = 13
      Caption = 'Width:'
    end
    object Label3: TLabel
      Left = 12
      Top = 78
      Width = 38
      Height = 13
      Caption = 'AllocBy:'
    end
    object Label1: TLabel
      Left = 151
      Top = 52
      Width = 34
      Height = 13
      Caption = 'Height:'
    end
    object Label4: TLabel
      Left = 144
      Top = 79
      Width = 42
      Height = 13
      Caption = 'PixelFmt:'
    end
    object Maske: TLMDCheckBox
      Left = 16
      Top = 128
      Width = 105
      Height = 17
      CtlXP = False
      Caption = 'Masked'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Flat = True
      TabOrder = 6
    end
    object compress: TLMDCheckBox
      Left = 16
      Top = 110
      Width = 105
      Height = 17
      CtlXP = False
      Caption = 'Compre&ssed'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Flat = True
      TabOrder = 5
    end
    object ed3: TLMDSpinEdit
      Left = 66
      Top = 74
      Width = 65
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 3
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      DateTime = 0
    end
    object ed2: TLMDSpinEdit
      Left = 66
      Top = 46
      Width = 65
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 1
      MaxLength = 4
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 10000
      DateTime = 0
    end
    object desc: TEdit
      Left = 66
      Top = 18
      Width = 188
      Height = 21
      TabOrder = 0
      Text = 'desc'
    end
    object LMDButton1: TLMDButton
      Left = 155
      Top = 111
      Width = 102
      Height = 36
      Caption = 'Get Dimensions'#13#10'from &Bitmap'
      TabOrder = 7
      OnClick = LMDButton1Click
      CtlXP = False
    end
    object cmb: TComboBox
      Left = 191
      Top = 76
      Width = 64
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'spfDefault'
        'spfMono'
        'spf4bit'
        'spf8bit')
    end
    object ed1: TLMDSpinEdit
      Left = 191
      Top = 46
      Width = 65
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 2
      MaxLength = 4
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 10000
      DateTime = 0
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 15
    Top = 176
  end
end
