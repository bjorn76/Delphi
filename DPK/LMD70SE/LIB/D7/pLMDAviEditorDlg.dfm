object LMDFrmcavi: TLMDFrmcavi
  Left = 265
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 246
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LMDDrawEdge1: TLMDDrawEdge
    Left = 8
    Top = 40
    Width = 425
    Height = 9
    FrameSides = [fsTop]
  end
  object Ani: TAnimate
    Left = 9
    Top = 55
    Width = 272
    Height = 60
    Active = False
    Repetitions = 1
    StopFrame = 26
    Timers = True
    Transparent = False
  end
  object aviLoad: TLMDButton
    Left = 8
    Top = 8
    Width = 81
    Height = 22
    Caption = 'Load AVI'
    TabOrder = 1
    OnClick = aviLoadClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object aviPlay: TLMDButton
    Left = 96
    Top = 8
    Width = 81
    Height = 22
    Caption = 'Play'
    TabOrder = 2
    OnClick = aviPlayClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton1: TLMDButton
    Left = 264
    Top = 8
    Width = 81
    Height = 22
    Caption = 'Convert'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton2: TLMDButton
    Left = 352
    Top = 8
    Width = 81
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    Default = True
    ModalResult = 2
    TabOrder = 4
    OnClick = Button1Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object FileDialog: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 360
    Top = 58
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 392
    Top = 56
  end
end
