object LMDFrmwiprop: TLMDFrmwiprop
  Left = 144
  Top = 323
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'WaveItem - Properties'
  ClientHeight = 199
  ClientWidth = 341
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
    Left = 266
    Top = 8
    Width = 72
    Height = 22
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 266
    Top = 33
    Width = 72
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 5
    Top = 6
    Width = 252
    Height = 187
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsFrameInset
    TabOrder = 2
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 11
      Top = 12
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
      Left = 61
      Top = 161
      Width = 29
      Height = 15
      Caption = 'Ident:'
      Options = []
    end
    object LMDSimpleLabel5: TLMDSimpleLabel
      Left = 12
      Top = 138
      Width = 75
      Height = 15
      Caption = 'External Wave:'
      Options = []
    end
    object Label1: TLabel
      Left = 11
      Top = 63
      Width = 70
      Height = 13
      Caption = 'Internal Wave:'
      Transparent = True
    end
    object Label2: TLabel
      Left = 12
      Top = 83
      Width = 23
      Height = 13
      Caption = 'Size:'
      Transparent = True
    end
    object Label3: TLabel
      Left = 136
      Top = 98
      Width = 19
      Height = 13
      Caption = 'Ch.:'
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 10
      Top = 78
      Width = 229
      Height = 5
      Shape = bsTopLine
    end
    object format: TLabel
      Left = 118
      Top = 63
      Width = 3
      Height = 13
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object size: TLabel
      Left = 42
      Top = 83
      Width = 68
      Height = 13
      AutoSize = False
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object bits: TLabel
      Left = 168
      Top = 83
      Width = 68
      Height = 13
      AutoSize = False
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label23: TLabel
      Left = 136
      Top = 83
      Width = 15
      Height = 13
      Caption = 'Bit:'
      Transparent = True
    end
    object Channels: TLabel
      Left = 168
      Top = 98
      Width = 68
      Height = 13
      AutoSize = False
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 12
      Top = 98
      Width = 18
      Height = 13
      Caption = 'SR:'
      Transparent = True
    end
    object samplerate: TLabel
      Left = 42
      Top = 98
      Width = 68
      Height = 13
      AutoSize = False
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object LMDSimpleLabel2: TLMDSimpleLabel
      Left = 97
      Top = 12
      Width = 36
      Height = 15
      Caption = 'Descr.:'
      Options = []
    end
    object ed: TLMDSpinEdit
      Left = 101
      Top = 157
      Width = 79
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 0
      MaxLength = 5
      AutoSelect = True
      CustomButtons = <>
      SpinBtnDiag = False
      MaxValue = 65535
      DateTime = 0
    end
    object change: TButton
      Left = 10
      Top = 37
      Width = 53
      Height = 20
      Caption = '&Change'
      TabOrder = 1
      OnClick = changeClick
    end
    object desc: TEdit
      Left = 137
      Top = 9
      Width = 105
      Height = 21
      TabOrder = 3
    end
    object compress: TCheckBox
      Left = 137
      Top = 39
      Width = 76
      Height = 13
      Caption = 'Compre&ssed'
      TabOrder = 2
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 295
    Top = 139
  end
  object c: TLMDWaveComp
    Left = 293
    Top = 102
  end
end
