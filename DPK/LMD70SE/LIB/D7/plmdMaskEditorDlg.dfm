object LMDfrmMaskEditDlg: TLMDfrmMaskEditDlg
  Left = 216
  Top = 168
  Width = 402
  Height = 361
  Caption = 'LMD Mask property editor'
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
  object LMDBackPanel1: TLMDBackPanel
    Left = 0
    Top = 0
    Width = 394
    Height = 327
    Align = alClient
    Bevel.Mode = bmCustom
    TabOrder = 0
    object MaskListBox: TLMDListBox
      Left = 8
      Top = 56
      Width = 257
      Height = 265
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 0
      OnClick = MaskListBoxClick
      Delimiter = '|'
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'MS Sans Serif'
      HeaderFont.Style = []
      HeaderHeight = 17
      HeaderSections = <
        item
          ImageIndex = -1
          Text = 'Mask'
          Width = 100
        end
        item
          ImageIndex = -1
          Text = 'Description'
          Width = 150
        end>
      ItemHeight = 16
      Items.Strings = (
        '\(888\)\ 888-8888| phone'
        '888\-888\-8888| phone'
        '\(88888\)8888888| phone'
        '88888\ 8888888| phone'
        '88888\-8888888| phone'
        '88888\-8888| US zip code'
        '99999| German zip code')
      CtlXP = False
    end
    object LMDButton1: TLMDButton
      Left = 296
      Top = 264
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object LMDButton2: TLMDButton
      Left = 296
      Top = 296
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object MaskEdit: TLMDEdit
      Left = 8
      Top = 32
      Width = 257
      Height = 21
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 3
      CustomButtons = <>
      PasswordChar = #0
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 352
    Top = 8
  end
end
