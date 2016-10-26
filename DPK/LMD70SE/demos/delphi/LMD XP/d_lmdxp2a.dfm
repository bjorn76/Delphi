object frmxp2a: Tfrmxp2a
  Left = 654
  Top = 469
  Width = 569
  Height = 454
  Caption = 'frmxp2a'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDTechnicalLine1: TLMDTechnicalLine
    Left = 305
    Top = 358
    Width = 121
    Height = 45
    Bevel.Mode = bmCustom
    LineEndingsign = leClosedArrowRight
    SignPlaces = spStart
    LineStartSign = leClosedArrowLeft
    Arrowed = True
  end
  object LMDSimpleLabel3: TLMDSimpleLabel
    Left = 432
    Top = 372
    Width = 73
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'TTabControl'
    Options = []
  end
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 339
    Top = 267
    Width = 205
    Height = 80
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Caption = 
      'TPageControl (XP look not correctly supported in Delphi / CBuild' +
      'er 5 or 6). LMD-Tools 6 (Full Version) contains TLMDPageControl ' +
      'to fix this. TPageControl in higher versions of Delphi/CBuilder ' +
      'work correctly.'
    Options = []
  end
  object TabControl2: TTabControl
    Left = 15
    Top = 275
    Width = 289
    Height = 128
    TabOrder = 0
    Tabs.Strings = (
      'Tab 1'
      'Tab 2')
    TabIndex = 0
    object LMDRadioGroup2: TLMDRadioGroup
      Left = 30
      Top = 31
      Width = 144
      Height = 81
      Bevel.Mode = bmWindows
      Bevel.StandardStyle = lsFrameInset
      BtnAlignment.Alignment = agCenterLeft
      Caption = 'LMDRadioGroup1'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      FlatGlyphs = True
      Items.Strings = (
        'Nr1'
        'Nr2'
        'Nr3'
        'Nr4')
      ParentColor = True
      TabOrder = 0
      TabStop = True
      Transparent = True
    end
  end
  object LMDPageControl1: TPageControl
    Left = 15
    Top = 6
    Width = 465
    Height = 254
    ActivePage = LMDTabSheet1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object LMDTabSheet1: TTabSheet
      Caption = 'Examples for Transparency'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object LMDLImage1: TLMDLImage
        Left = 95
        Top = 2
        Width = 33
        Height = 38
        Bevel.Mode = bmCustom
        ForceTransparent = True
        ImageList = LMDXPDemo.LMDImageList1
        ImageIndex = 2
      end
      object LMDRadioButton4: TLMDRadioButton
        Left = 165
        Top = 49
        Width = 123
        Height = 23
        Caption = 'LMDRadioButton1'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        AutoSize = True
        Checked = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MurrayHill Bd BT'
        Font.Style = [fsBold]
        Font3D.LightDepth = 2
        Font3D.ShadowDepth = 2
        Font3D.Style = tdRaisedShadow
        ParentFont = False
        TabOrder = 0
        Transparent = True
      end
      object LMDRadioGroup3: TLMDRadioGroup
        Left = 13
        Top = 41
        Width = 130
        Height = 100
        Bevel.Mode = bmWindows
        Bevel.StandardStyle = lsFrameInset
        BtnAlignment.Alignment = agCenterLeft
        Caption = 'LMDRadioGroup1'
        CaptionFont.Charset = ANSI_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'Arial'
        CaptionFont.Style = []
        FlatGlyphs = True
        Items.Strings = (
          'Nr1'
          'Nr2'
          'Nr3'
          'Nr4')
        ParentColor = True
        TabOrder = 1
        TabStop = True
        Transparent = True
      end
      object LMDCheckBox1: TLMDCheckBox
        Left = 176
        Top = 17
        Width = 105
        Height = 24
        Caption = 'LMDCheckBox1'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        TabOrder = 2
        Transparent = True
      end
      object LMDCheckGroup1: TLMDCheckGroup
        Left = 160
        Top = 97
        Width = 145
        Height = 111
        Bevel.Mode = bmStandard
        Bevel.StandardStyle = lsFrameInset
        BtnAlignment.Alignment = agCenterLeft
        Caption = 'LMDCheckGroup1'
        CaptionFont.Charset = ANSI_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'Arial'
        CaptionFont.Style = []
        Items.Strings = (
          'Test 1'
          'Test 2'
          'Test 3')
        TabOrder = 4
        Transparent = True
        Value = -1
      end
      object LMDTrackBar1: TLMDTrackBar
        Left = 12
        Top = 163
        Width = 130
        Height = 35
        CtlXP = True
        TabOrder = 3
        TabStop = True
        Transparent = True
        Position = 0
      end
    end
    object LMDTabSheet2: TTabSheet
      Caption = 'Transparency even for nested controls'
      object lb: TLMDSimplePanel
        Left = 8
        Top = 13
        Width = 435
        Height = 206
        UseDockManager = False
        Bevel.Mode = bmWindows
        ParentColor = True
        TabOrder = 0
        Transparent = True
        object LMDSimplePanel2: TLMDSimplePanel
          Left = 21
          Top = 16
          Width = 169
          Height = 178
          UseDockManager = False
          Bevel.Mode = bmWindows
          ParentColor = True
          TabOrder = 0
          Transparent = True
          object LMDDockSpeedButton3: TLMDDockSpeedButton
            Left = 26
            Top = 12
            Width = 22
            Height = 22
          end
          object LMDSimpleLabel1: TLMDSimpleLabel
            Left = 5
            Top = 159
            Width = 129
            Height = 16
            Caption = 'Nested TLMDSimplePanels'
            Options = []
          end
          object LMDSimplePanel3: TLMDSimplePanel
            Left = 27
            Top = 67
            Width = 100
            Height = 85
            UseDockManager = False
            Bevel.Mode = bmWindows
            ParentColor = True
            TabOrder = 0
            Transparent = True
            object LMDDockSpeedButton4: TLMDDockSpeedButton
              Left = 26
              Top = 12
              Width = 22
              Height = 22
            end
            object LMDRadioButton3: TLMDRadioButton
              Left = 8
              Top = 52
              Width = 123
              Height = 23
              Caption = 'LMDRadioButton1'
              Alignment.Alignment = agTopLeft
              Alignment.Spacing = 4
              AutoSize = True
              Checked = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MurrayHill Bd BT'
              Font.Style = [fsBold]
              Font3D.LightDepth = 2
              Font3D.ShadowDepth = 2
              Font3D.Style = tdRaisedShadow
              ParentFont = False
              TabOrder = 0
              Transparent = True
            end
          end
          object LMDPanelFill1: TLMDPanelFill
            Left = 59
            Top = 10
            Width = 100
            Height = 40
            UseDockManager = False
            Bevel.Mode = bmCustom
            Caption = 'LMDPanelFill1'
            FillObject.Style = sfGradient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clSilver
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TransparentBorder = True
          end
        end
        object LMDRadioButton2: TLMDRadioButton
          Left = 22
          Top = 242
          Width = 123
          Height = 23
          Caption = 'LMDRadioButton1'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          AutoSize = True
          Checked = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MurrayHill Bd BT'
          Font.Style = [fsBold]
          Font3D.LightDepth = 2
          Font3D.ShadowDepth = 2
          Font3D.Style = tdRaisedShadow
          ParentFont = False
          TabOrder = 1
          Transparent = True
        end
        object LMDGroupBox1: TLMDGroupBox
          Left = 228
          Top = 31
          Width = 170
          Height = 146
          Bevel.Mode = bmWindows
          Bevel.StandardStyle = lsFrameInset
          Caption = 'LMDGroupBox1'
          CaptionFont.Charset = ANSI_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Arial'
          CaptionFont.Style = []
          TabOrder = 2
          Transparent = True
          object LMDGroupBox2: TLMDGroupBox
            Left = 19
            Top = 25
            Width = 139
            Height = 115
            Bevel.Mode = bmWindows
            Bevel.StandardStyle = lsFrameInset
            Caption = 'LMDGroupBox1'
            CaptionFont.Charset = ANSI_CHARSET
            CaptionFont.Color = clWindowText
            CaptionFont.Height = -11
            CaptionFont.Name = 'Arial Black'
            CaptionFont.Style = []
            CaptionParentFont = False
            TabOrder = 0
            Transparent = True
            object LMDGroupBox3: TLMDGroupBox
              Left = 25
              Top = 26
              Width = 96
              Height = 83
              Bevel.Mode = bmWindows
              Bevel.StandardStyle = lsFrameInset
              Caption = 'LMDGroupBox1'
              CaptionFont.Charset = ANSI_CHARSET
              CaptionFont.Color = clWindowText
              CaptionFont.Height = -13
              CaptionFont.Name = 'Arial Narrow'
              CaptionFont.Style = []
              CaptionParentFont = False
              TabOrder = 0
              Transparent = True
            end
          end
        end
      end
    end
  end
end
