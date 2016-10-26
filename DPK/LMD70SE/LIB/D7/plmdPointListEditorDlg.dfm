object frmTLMDPointListEditor: TfrmTLMDPointListEditor
  Left = 199
  Top = 117
  BorderStyle = bsDialog
  Caption = 'LMD PointList Editor'
  ClientHeight = 265
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object plb: TLMDListBox
    Left = 8
    Top = 8
    Width = 129
    Height = 217
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    TabOrder = 0
    HeaderFont.Charset = ANSI_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Arial'
    HeaderFont.Style = []
    HeaderHeight = 17
    HeaderSections = <
      item
        ImageIndex = -1
        Text = 'X'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Y'
        Width = 60
      end>
    ItemHeight = 16
    CtlXP = False
    OnSelect = plbClick
  end
  object XVal: TLMDSpinEdit
    Left = 8
    Top = 232
    Width = 60
    Height = 22
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 1
    OnChange = XValExit
    OnExit = XValExit
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 1000
    DateTime = 0
  end
  object YVal: TLMDSpinEdit
    Left = 76
    Top = 232
    Width = 60
    Height = 22
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 2
    OnChange = YValExit
    OnExit = YValExit
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 1000
    DateTime = 0
  end
  object LMDButton1: TLMDButton
    Left = 152
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 3
    OnClick = LMDButton1Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton2: TLMDButton
    Left = 152
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = LMDButton2Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton3: TLMDButton
    Left = 152
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 5
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton4: TLMDButton
    Left = 152
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton5: TLMDButton
    Left = 152
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Up'
    TabOrder = 7
    OnClick = LMDButton5Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton6: TLMDButton
    Left = 152
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Down'
    TabOrder = 8
    OnClick = LMDButton6Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 152
    Top = 8
  end
end
