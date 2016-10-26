object lmdfrmbiprop: Tlmdfrmbiprop
  Left = 267
  Top = 213
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'BitmapItem - Properties'
  ClientHeight = 208
  ClientWidth = 306
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
  object Button1: TButton
    Left = 229
    Top = 8
    Width = 72
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 229
    Top = 37
    Width = 72
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 6
    Top = 7
    Width = 215
    Height = 198
    CtlXP = False
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    TabOrder = 2
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 12
      Top = 12
      Width = 34
      Height = 15
      Caption = 'Index: '
      Options = []
    end
    object Index: TLMDSimpleLabel
      Left = 58
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
    object LMDSimpleLabel4: TLMDSimpleLabel
      Left = 12
      Top = 67
      Width = 75
      Height = 15
      Caption = 'Internal Bitmap:'
      Options = []
    end
    object img: TLMDNImage
      Left = 113
      Top = 70
      Width = 93
      Height = 48
      Bevel.Mode = bmCustom
      Style = sbKeepAspRatio
    end
    object Label4: TLabel
      Left = 12
      Top = 40
      Width = 42
      Height = 13
      Caption = 'PixelFmt:'
    end
    object dimLabel: TLMDSimpleLabel
      Left = 112
      Top = 120
      Width = 44
      Height = 15
      Caption = 'dimLabel'
      Options = []
    end
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 10
      Top = 144
      Width = 58
      Height = 15
      Caption = 'Description:'
      Options = []
    end
    object LMDSimpleLabel5: TLMDSimpleLabel
      Left = 11
      Top = 171
      Width = 55
      Height = 15
      Caption = 'External Id:'
      Options = []
    end
    object change: TButton
      Left = 25
      Top = 87
      Width = 53
      Height = 20
      Caption = '&Change'
      TabOrder = 2
      OnClick = changeClick
    end
    object compress: TCheckBox
      Left = 115
      Top = 14
      Width = 76
      Height = 13
      Caption = 'Compre&ssed'
      TabOrder = 0
    end
    object cmb: TComboBox
      Left = 115
      Top = 34
      Width = 75
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'spfDefault'
        'spfMono'
        'spf4bit'
        'spf8bit')
    end
    object desc: TEdit
      Left = 99
      Top = 139
      Width = 107
      Height = 21
      TabOrder = 3
    end
    object ed: TLMDSpinEdit
      Left = 99
      Top = 167
      Width = 108
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 4
      MaxLength = 5
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 65535
      DateTime = 0
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 250
    Top = 79
  end
end
