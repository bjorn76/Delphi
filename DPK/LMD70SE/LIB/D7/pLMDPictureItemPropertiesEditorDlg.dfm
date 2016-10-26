object lmdfrmpiprop: Tlmdfrmpiprop
  Left = 649
  Top = 290
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'PictureItem - Properties'
  ClientHeight = 198
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
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
    Height = 186
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
      Top = 42
      Width = 76
      Height = 15
      Caption = 'Internal Picture:'
      Options = []
    end
    object LMDSimpleLabel5: TLMDSimpleLabel
      Left = 11
      Top = 159
      Width = 55
      Height = 15
      Caption = 'External Id:'
      Options = []
    end
    object dimLabel: TLMDSimpleLabel
      Left = 100
      Top = 106
      Width = 44
      Height = 15
      Caption = 'dimLabel'
      Options = []
    end
    object img: TImage
      Left = 101
      Top = 41
      Width = 105
      Height = 59
    end
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 10
      Top = 132
      Width = 58
      Height = 15
      Caption = 'Description:'
      Options = []
    end
    object ed: TLMDSpinEdit
      Left = 99
      Top = 155
      Width = 108
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 2
      MaxLength = 5
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 65535
      DateTime = 0
    end
    object change: TButton
      Left = 24
      Top = 65
      Width = 53
      Height = 20
      Caption = '&Change'
      TabOrder = 1
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
    object desc: TEdit
      Left = 99
      Top = 127
      Width = 107
      Height = 21
      TabOrder = 3
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
