object frmXPEdit: TfrmXPEdit
  Left = 361
  Top = 240
  Width = 575
  Height = 399
  Caption = 'frmXPEdit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimpleLabel3: TLMDSimpleLabel
    Left = 24
    Top = 22
    Width = 59
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDEdit'
    Options = []
  end
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 24
    Top = 71
    Width = 89
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDMaskEdit'
    Options = []
  end
  object LMDSimpleLabel8: TLMDSimpleLabel
    Left = 24
    Top = 120
    Width = 100
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDBrowseEdit'
    Options = []
  end
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 221
    Top = 22
    Width = 88
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDColorEdit'
    Options = []
  end
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 221
    Top = 71
    Width = 109
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDFileOpenEdit'
    Options = []
  end
  object LMDSimpleLabel10: TLMDSimpleLabel
    Left = 221
    Top = 122
    Width = 108
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDFileSaveEdit'
    Options = []
  end
  object TLMDMemo: TLMDSimpleLabel
    Left = 224
    Top = 174
    Width = 70
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDMemo'
    Options = []
  end
  object LMDSimpleLabel9: TLMDSimpleLabel
    Left = 21
    Top = 171
    Width = 89
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDTrackBar'
    Options = []
  end
  object LMDSimpleLabel11: TLMDSimpleLabel
    Left = 21
    Top = 246
    Width = 90
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDScrollBox'
    Options = []
  end
  object LMDSimpleLabel12: TLMDSimpleLabel
    Left = 229
    Top = 310
    Width = 106
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDButtonPanel'
    Options = []
  end
  object LMDEdit1: TLMDEdit
    Left = 25
    Top = 37
    Width = 100
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    Flat = True
    TabOrder = 0
    CustomButtons = <>
    PasswordChar = #0
  end
  object LMDMaskEdit1: TLMDMaskEdit
    Left = 25
    Top = 87
    Width = 100
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 1
    CurrencySettings.SystemDefaults = cmSystem
    CurrencySettings.PositiveFormatStr = '1,1 ¤'
    CurrencySettings.NegativeFormatStr = '-1,1 ¤'
    CurrencySettings.Symbol = '€'
    CustomButtons = <>
    MaskType = meDate
    DateTime = 37418
  end
  object LMDBrowseEdit1: TLMDBrowseEdit
    Left = 26
    Top = 136
    Width = 152
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 3
    MinimizeName = True
  end
  object LMDColorEdit1: TLMDColorEdit
    Left = 223
    Top = 37
    Width = 119
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 5
    Options = []
    SelectedColor = clRed
  end
  object LMDFileOpenEdit1: TLMDFileOpenEdit
    Left = 223
    Top = 87
    Width = 183
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 7
    MinimizeName = True
  end
  object LMDFileSaveEdit1: TLMDFileSaveEdit
    Left = 222
    Top = 137
    Width = 185
    Height = 21
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 2
    MinimizeName = True
  end
  object LMDCheckBox1: TLMDCheckBox
    Left = 392
    Top = 33
    Width = 155
    Height = 32
    Caption = 'Enable Flat Mode'#13#10'(no effect in Themed Mode)'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    Flat = True
    TabOrder = 4
    OnChange = LMDCheckBox1Change
  end
  object LMDMemo1: TLMDMemo
    Left = 223
    Top = 189
    Width = 123
    Height = 80
    Cursor = crIBeam
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    Caret.ImageIndex = 0
    Caret.ListIndex = 0
    TabOrder = 6
    ScrollBars = skVertical
    Text = 
      'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test' +
      #13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'te' +
      'st'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10'test'#13#10 +
      'test'#13#10
    HorizScrollBar.Back.Style = sfBrush
    HorizScrollBar.Back.Brush.Color = clBlue
    HorizScrollBar.Bevel.Mode = bmStandard
    VertScrollBar.Back.Style = sfBrush
    VertScrollBar.Back.Brush.Color = clBlue
    VertScrollBar.Bevel.Mode = bmStandard
  end
  object LMDTrackBar1: TLMDTrackBar
    Left = 21
    Top = 185
    Width = 164
    Height = 35
    CtlXP = True
    TabOrder = 8
    TabStop = True
    Position = 0
  end
  object LMDScrollBox1: TLMDScrollBox
    Left = 21
    Top = 263
    Width = 191
    Height = 90
    TabOrder = 9
    object Button1: TButton
      Left = 124
      Top = 111
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
    end
  end
  object LMDButtonPanel1: TLMDButtonPanel
    Left = 229
    Top = 328
    Width = 80
    Height = 20
    UseDockManager = False
    Buttons = <
      item
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Index = 0
        DisplayName = 'TLMDSpecialButton'
      end
      item
        Caption = '2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Index = 1
        DisplayName = 'TLMDSpecialButton'
      end
      item
        Caption = '3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Index = 2
        DisplayName = 'TLMDSpecialButton'
      end
      item
        Caption = '4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Index = 3
        DisplayName = 'TLMDSpecialButton'
      end>
    Bevel.Mode = bmCustom
    TabOrder = 10
  end
end
