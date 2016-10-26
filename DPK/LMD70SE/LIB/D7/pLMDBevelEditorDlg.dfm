object LMDBevelEditorDlg: TLMDBevelEditorDlg
  Left = 324
  Top = 176
  BorderStyle = bsDialog
  Caption = 'Bevel-Editor'
  ClientHeight = 387
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 5
    Top = 148
    Width = 469
    Height = 7
    Shape = bsBottomLine
  end
  object test: TLMDPanelFill
    Left = 54
    Top = 10
    Width = 361
    Height = 126
    Bevel.Mode = bmCustom
    Caption = 'Test-Bevel'
    TabOrder = 0
  end
  object nb: TPageControl
    Left = 6
    Top = 161
    Width = 379
    Height = 222
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Standard'
      object Label10: TLabel
        Left = 54
        Top = 62
        Width = 69
        Height = 13
        Caption = 'StandardStyle:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 56
        Top = 127
        Width = 58
        Height = 13
        Caption = 'BorderColor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 56
        Top = 152
        Width = 86
        Height = 13
        Caption = 'BorderInnerWidth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object bt1_3: TLMDDockSpeedButton
        Left = 292
        Top = 120
        Width = 23
        Height = 21
        ParentFont = False
        OnClick = bt1Click
        CtlXP = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        FontFX.Tracing = 1
        Control = cmbb3
        GlyphKind = gkColor
      end
      object cmbStandard: TComboBox
        Left = 153
        Top = 58
        Width = 138
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnChange = cmbStandardChange
        Items.Strings = (
          'lsNone'
          'lsSingle'
          'lsLowered'
          'lsRaised'
          'lsRaisedspb'
          'lsLoweredspb'
          'lsRaisedExt'
          'lsLoweredExt'
          'lsFrameInset'
          'lsFrameOffset'
          'lsWindowBorde'
          'lsSingleRaised'
          'lsSingleLowered'
          'lsDoubleRaised'
          'lsDoubleLowered')
      end
      object cmbb3: TLMDColorComboBox
        Left = 153
        Top = 120
        Width = 138
        Height = 21
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cmbbChange
      end
      object edbiw3: TLMDSpinEdit
        Left = 153
        Top = 147
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 2
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object rbStandard: TLMDRadioButton
        Left = 8
        Top = 9
        Width = 73
        Height = 17
        CtlXP = False
        Caption = 'Standard'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        Flat = True
        TabOrder = 3
        OnClick = rbclick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Custom'
      object Label1: TLabel
        Left = 8
        Top = 36
        Width = 50
        Height = 13
        Caption = 'StyleInner:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 200
        Top = 36
        Width = 52
        Height = 13
        Caption = 'StyleOuter:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object bt3: TLMDDockSpeedButton
        Left = 270
        Top = 160
        Width = 23
        Height = 21
        ParentFont = False
        OnClick = bt1Click
        CtlXP = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        FontFX.Tracing = 1
        Control = cmbs
        GlyphKind = gkColor
      end
      object bt2: TLMDDockSpeedButton
        Left = 270
        Top = 136
        Width = 23
        Height = 21
        ParentFont = False
        OnClick = bt1Click
        CtlXP = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        FontFX.Tracing = 1
        Control = cmbL
        GlyphKind = gkColor
      end
      object bt1: TLMDDockSpeedButton
        Left = 270
        Top = 112
        Width = 23
        Height = 21
        ParentFont = False
        OnClick = bt1Click
        CtlXP = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        FontFX.Tracing = 1
        Control = cmbb
        GlyphKind = gkColor
      end
      object Label6: TLabel
        Left = 64
        Top = 165
        Width = 66
        Height = 13
        Caption = 'ShadowColor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 64
        Top = 141
        Width = 50
        Height = 13
        Caption = 'LightColor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 64
        Top = 119
        Width = 58
        Height = 13
        Caption = 'BorderColor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 8
        Top = 88
        Width = 86
        Height = 13
        Caption = 'BorderInnerWidth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 200
        Top = 88
        Width = 62
        Height = 13
        Caption = 'BorderWidth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 8
        Top = 63
        Width = 55
        Height = 13
        Caption = 'WidthInner:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 200
        Top = 63
        Width = 57
        Height = 13
        Caption = 'WidthOuter:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object cmb: TComboBox
        Left = 75
        Top = 32
        Width = 100
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnChange = cmbChange
        Items.Strings = (
          'bvNone'
          'bvLowered'
          'bvRaised'
          'bvFrameLowered'
          'bvFrameRaised'
          'bvNormal'
          'bvShadow')
      end
      object cmb1: TComboBox
        Left = 267
        Top = 32
        Width = 100
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        OnChange = cmb1Change
        Items.Strings = (
          'bvNone'
          'bvLowered'
          'bvRaised'
          'bvFrameLowered'
          'bvFrameRaised'
          'bvNormal'
          'bvShadow')
      end
      object cmbs: TLMDColorComboBox
        Left = 131
        Top = 160
        Width = 138
        Height = 21
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = cmbbChange
      end
      object cmbb: TLMDColorComboBox
        Left = 131
        Top = 112
        Width = 138
        Height = 21
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = cmbbChange
      end
      object cmbL: TLMDColorComboBox
        Left = 131
        Top = 136
        Width = 138
        Height = 21
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = cmbbChange
      end
      object edbiw: TLMDSpinEdit
        Left = 127
        Top = 84
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 5
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object edbw: TLMDSpinEdit
        Left = 319
        Top = 84
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 6
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object edwi: TLMDSpinEdit
        Left = 127
        Top = 58
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 7
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object edwo: TLMDSpinEdit
        Left = 319
        Top = 58
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 8
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object rbCustom: TLMDRadioButton
        Left = 8
        Top = 8
        Width = 65
        Height = 17
        CtlXP = False
        Caption = 'Custom'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        Flat = True
        TabOrder = 9
        OnClick = rbclick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Edged'
      object Label11: TLabel
        Left = 8
        Top = 143
        Width = 58
        Height = 13
        Caption = 'BorderColor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 8
        Top = 168
        Width = 86
        Height = 13
        Caption = 'BorderInnerWidth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object bt1_2: TLMDDockSpeedButton
        Left = 259
        Top = 136
        Width = 23
        Height = 21
        ParentFont = False
        OnClick = bt1Click
        CtlXP = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        FontFX.Tracing = 1
        Control = cmbb2
        GlyphKind = gkColor
      end
      object Label15: TLabel
        Left = 8
        Top = 55
        Width = 51
        Height = 13
        Caption = 'EdgeStyle:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object LMDGroupBox1: TLMDGroupBox
        Left = 120
        Top = 16
        Width = 241
        Height = 113
        CtlXP = False
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsFrameInset
        Caption = 'BorderSides'
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clBlack
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = []
        CaptionParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object cbLeft: TLMDCheckBox
          Left = 16
          Top = 16
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Left Line'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Flat = True
          TabOrder = 0
          OnChange = cbLeftClick
        end
        object cbTop: TLMDCheckBox
          Left = 16
          Top = 40
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Top Line'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Flat = True
          TabOrder = 1
          OnChange = cbTopClick
        end
        object cbRight: TLMDCheckBox
          Left = 16
          Top = 64
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Right Line'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Flat = True
          TabOrder = 2
          OnChange = cbRightClick
        end
        object cbBottom: TLMDCheckBox
          Left = 16
          Top = 88
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Bottom Line'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Flat = True
          TabOrder = 3
          OnChange = cbBottomClick
        end
      end
      object cmbb2: TLMDColorComboBox
        Left = 120
        Top = 136
        Width = 138
        Height = 21
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cmbbChange
      end
      object edbiw2: TLMDSpinEdit
        Left = 120
        Top = 164
        Width = 48
        Height = 21
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 2
        OnChange = edbiwChange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MaxValue = 255
        DateTime = 0
      end
      object cmbEdge: TComboBox
        Left = 7
        Top = 72
        Width = 106
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
        OnChange = cmbEdgeChange
        Items.Strings = (
          'etRaisedInner'
          'etRaisedOuter'
          'etSunkenInner'
          'etSunkenOuter'
          'etBump'
          'etEtched'
          'etRaised'
          'etSunken')
      end
      object rbEdge: TLMDRadioButton
        Left = 8
        Top = 8
        Width = 65
        Height = 17
        CtlXP = False
        Caption = 'Edged'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        Flat = True
        TabOrder = 4
        OnClick = rbclick
      end
    end
    object tb4: TTabSheet
      Caption = 'Windows'
      OnEnter = tb4Enter
      object rbWindow: TLMDRadioButton
        Left = 8
        Top = 8
        Width = 76
        Height = 17
        CtlXP = False
        Caption = 'Windows'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        Flat = True
        TabOrder = 0
        OnClick = rbclick
      end
      object st: TStaticText
        Left = 3
        Top = 173
        Width = 222
        Height = 18
        Caption = 'Supported by TWinControl descendants only.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object ok: TLMDButton
    Left = 392
    Top = 184
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    CtlXP = False
  end
  object Button1: TLMDButton
    Left = 392
    Top = 212
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    CtlXP = False
  end
  object reset: TLMDButton
    Left = 392
    Top = 248
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 4
    OnClick = resetClick
    CtlXP = False
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 435
    Top = 22
  end
end
