object frmXPStd: TfrmXPStd
  Left = 365
  Top = 415
  Width = 550
  Height = 440
  Caption = 'frmXPStd'
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
    Left = 14
    Top = 4
    Width = 110
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDSpeedButton'
    Options = []
  end
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 119
    Top = 61
    Width = 265
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Caption = '(Ex)Style: ubsWinXP, ubsWinXPCombo, ubsWinXPTool'
    Options = []
  end
  object LMDSpeedButton5: TLMDSpeedButton
    Left = 17
    Top = 25
    Width = 37
    Height = 30
    ImageList = LMDXPDemo.LMDImageList1
    ImageIndex = 1
    ListIndex = 1
    NumGlyphs = 3
    Style = ubsWinXP
  end
  object LMDSpeedButton6: TLMDSpeedButton
    Left = 60
    Top = 25
    Width = 31
    Height = 30
    ButtonLayout.Arrow = True
    ButtonLayout.ArrowPosition = apLeftText
    ImageIndex = 3
    ListIndex = 1
    NumGlyphs = 3
    DropDownMenu = PopupMenu1
    Style = ubsWinXPCombo
  end
  object LMDSpeedButton7: TLMDSpeedButton
    Left = 100
    Top = 25
    Width = 37
    Height = 30
    ImageList = LMDXPDemo.LMDImageList1
    ImageIndex = 4
    ListIndex = 1
    NumGlyphs = 3
    Style = ubsWinXPTool
  end
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 14
    Top = 220
    Width = 94
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDCheckBox'
    Options = []
  end
  object LMDProgress1: TLMDProgress
    Left = 16
    Top = 129
    Width = 75
    Height = 20
    Bevel.StyleOuter = bvLowered
    Bevel.Mode = bmCustom
    CtlXP = True
    Position = 50
    UserValue = 50
  end
  object LMDSimpleLabel5: TLMDSimpleLabel
    Left = 14
    Top = 91
    Width = 86
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDProgress'
    Options = []
  end
  object LMDSimpleLabel6: TLMDSimpleLabel
    Left = 13
    Top = 108
    Width = 422
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Caption = 
      '(1) CtlXP=True (2) CtlXP=false, Bevel.Mode=bmWindows (3)  CtlXP=' +
      'false, Style=pgXPBar'
    Options = []
  end
  object LMDProgress2: TLMDProgress
    Left = 106
    Top = 129
    Width = 67
    Height = 20
    Bevel.StyleOuter = bvLowered
    Bevel.Mode = bmWindows
    Position = 50
    UserValue = 50
  end
  object LMDProgress3: TLMDProgress
    Left = 195
    Top = 129
    Width = 75
    Height = 20
    Bevel.StyleOuter = bvLowered
    Bevel.Mode = bmCustom
    Style = pgXPBar
    Position = 50
    UserValue = 50
  end
  object LMDSimpleLabel7: TLMDSimpleLabel
    Left = 14
    Top = 163
    Width = 87
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDScrollbar'
    Options = []
  end
  object LMDSimpleLabel8: TLMDSimpleLabel
    Left = 249
    Top = 4
    Width = 74
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDButton'
    Options = []
  end
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 211
    Top = 220
    Width = 107
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TLMDRadioButton'
    Options = []
  end
  object LMDSimpleLabel9: TLMDSimpleLabel
    Left = 423
    Top = 286
    Width = 116
    Height = 54
    MultiLine = True
    Caption = 
      'For groupboxes set Bevel.Mode to bmWindows to achieve Themes loo' +
      'k.'
    Options = []
  end
  object LMDLabel1: TLMDLabel
    Left = 381
    Top = 150
    Width = 158
    Height = 82
    Bevel.StyleInner = bvLowered
    Bevel.Mode = bmCustom
    Color = 14811135
    MultiLine = True
    Options = []
    ParentColor = False
    Transparent = False
    Caption = 
      'Many of the LMD-Tools controls support a CtlXP property, by whic' +
      'h Themes support can be switched off even if LMDApplication.UseX' +
      'PThemes is set to true.'
  end
  object LMDRadioGroup1: TLMDRadioGroup
    Left = 18
    Top = 281
    Width = 185
    Height = 104
    Bevel.Mode = bmWindows
    Bevel.StandardStyle = lsFrameInset
    BtnAlignment.Alignment = agCenterLeft
    Caption = 'LMDRadioGroup1'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = [fsBold]
    CaptionParentFont = False
    Items.Strings = (
      'Test 1'
      'Test 2'
      'Test 3'
      'Test 4')
    TabOrder = 0
  end
  object LMDCheckGroup1: TLMDCheckGroup
    Left = 225
    Top = 281
    Width = 185
    Height = 103
    Bevel.Mode = bmWindows
    Bevel.StandardStyle = lsFrameInset
    BtnAlignment.Alignment = agCenterLeft
    Caption = 'LMDCheckGroup1'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = [fsBold]
    CaptionParentFont = False
    Items.Strings = (
      'Test 1'
      'Test 2'
      'Test 3'
      'Test 4')
    TabOrder = 1
    Value = -1
  end
  object LMDScrollBar1: TLMDScrollBar
    Left = 19
    Top = 186
    Width = 100
    Height = 16
    Bevel.Mode = bmStandard
    ThumbBevel.StyleOuter = bvRaised
    ThumbBevel.Mode = bmCustom
    Back.Style = sfBrushBitmap
    TabOrder = 2
  end
  object LMDButton1: TLMDButton
    Left = 251
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 3
    Visible = True
    ImageList = LMDXPDemo.LMDImageList1
    ListIndex = 1
    NumGlyphs = 3
  end
  object LMDButton2: TLMDButton
    Left = 339
    Top = 25
    Width = 75
    Height = 25
    TabOrder = 4
    Visible = True
    ButtonLayout.Arrow = True
    ButtonLayout.ArrowPosition = apLeftText
    ListIndex = 1
    NumGlyphs = 3
    ExtStyle = ubsWinXPCombo
    DropDownMenu = PopupMenu1
  end
  object LMDButton3: TLMDButton
    Left = 424
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 5
    Visible = True
    ImageList = LMDXPDemo.LMDImageList1
    ListIndex = 1
    NumGlyphs = 3
    ExtStyle = ubsWinXPTool
  end
  object LMDCheckBox1: TLMDCheckBox
    Left = 17
    Top = 240
    Width = 105
    Height = 17
    Caption = 'LMDCheckBox1'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    TabOrder = 6
  end
  object LMDRadioButton1: TLMDRadioButton
    Left = 213
    Top = 238
    Width = 105
    Height = 17
    Caption = 'LMDRadioButton1'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    Checked = False
    TabOrder = 7
  end
  object PopupMenu1: TPopupMenu
    Left = 181
    Top = 5
    object rt1: TMenuItem
      Caption = 'Test'
    end
    object uzrt1: TMenuItem
      Caption = 'Test'
    end
    object zrt1: TMenuItem
      Caption = 'Test'
    end
    object z1: TMenuItem
      Caption = 'Test'
    end
  end
end
