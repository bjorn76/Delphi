object LMDFormGraphicLabelEditor: TLMDFormGraphicLabelEditor
  Left = 371
  Top = 157
  BorderStyle = bsDialog
  Caption = 'GraphicLabel'
  ClientHeight = 351
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  object LMDGraphicLabel: TLMDGraphicLabel
    Left = 0
    Top = 0
    Width = 473
    Height = 185
    Bevel.Mode = bmCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Caption = 'LMDGraphicLabel'
  end
  object LMDSPCarryAll: TLMDSimplePanel
    Left = 0
    Top = 190
    Width = 475
    Height = 161
    CtlXP = False
    Align = alBottom
    Bevel.StyleInner = bvRaised
    Bevel.Mode = bmCustom
    TabOrder = 0
    object TabbedNotebookProperties: TPageControl
      Left = 1
      Top = 1
      Width = 364
      Height = 159
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Form'
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 3
          Height = 13
        end
        object LMDSimpleLabel12: TLMDSimpleLabel
          Left = 8
          Top = 32
          Width = 49
          Height = 15
          Caption = 'Transform'
          Options = []
        end
        object LMDSimpleLabel13: TLMDSimpleLabel
          Left = 8
          Top = 64
          Width = 32
          Height = 15
          Caption = 'Factor'
          Options = []
        end
        object ComboBoxTransform: TComboBox
          Left = 89
          Top = 27
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBoxTransformChange
          Items.Strings = (
            'tmWave'
            'tmNone'
            'tmHalfcircle'
            'tmArrow'
            'tmSpeaker'
            'tmInvSpeaker'
            'tmFly'
            'tmChair'
            'tmStairs'
            'tmInvStairs'
            'tmBuckled'
            'tmEnterprise'
            'tmLNoseUp'
            'tmLNoseDown'
            'tmRNoseUp'
            'tmRNoseDown'
            'tmCube'
            'tmHalfmoon')
        end
        object LMDSpinEditFactor: TLMDSpinEdit
          Left = 88
          Top = 59
          Width = 73
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 1
          OnChange = LMDSpinEditFactorChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          MaxValue = 10000
          DateTime = 0
        end
        object ButtonFillObjectDialog: TLMDButton
          Left = 272
          Top = 96
          Width = 75
          Height = 23
          Caption = 'FillObject >>'
          TabOrder = 2
          OnClick = Button1Click
          CtlXP = False
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'FontFX'
        object LMDSimpleLabel7: TLMDSimpleLabel
          Left = 8
          Top = 16
          Width = 25
          Height = 15
          Caption = 'Style'
          Options = []
        end
        object LMDSimpleLabel8: TLMDSimpleLabel
          Left = 8
          Top = 48
          Width = 52
          Height = 15
          Caption = 'Lightdepth'
          Options = []
        end
        object LMDSimpleLabel9: TLMDSimpleLabel
          Left = 160
          Top = 48
          Width = 68
          Height = 15
          Caption = 'Shadowdepth'
          Options = []
        end
        object LMDSimpleLabel10: TLMDSimpleLabel
          Left = 8
          Top = 80
          Width = 29
          Height = 15
          Caption = 'Angle'
          Options = []
        end
        object LMDSimpleLabel11: TLMDSimpleLabel
          Left = 8
          Top = 112
          Width = 38
          Height = 15
          Caption = 'Tracing'
          Options = []
        end
        object LMDSimpleLabel14: TLMDSimpleLabel
          Left = 163
          Top = 80
          Width = 49
          Height = 15
          Caption = 'LightColor'
          Options = []
        end
        object LMDSimpleLabel15: TLMDSimpleLabel
          Left = 164
          Top = 109
          Width = 65
          Height = 15
          Caption = 'ShadowColor'
          Options = []
        end
        object LMDSpinEditAngle: TLMDSpinEdit
          Left = 80
          Top = 72
          Width = 65
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 0
          OnChange = LMDSpinEditAngleChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          MaxValue = 360
          DateTime = 0
        end
        object LMDSpinEditLightDepth: TLMDSpinEdit
          Left = 80
          Top = 40
          Width = 65
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 1
          OnChange = LMDSpinEditLightDepthChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          DateTime = 0
        end
        object LMDSpinEditShadowDepth: TLMDSpinEdit
          Left = 280
          Top = 40
          Width = 65
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 2
          OnChange = LMDSpinEditShadowDepthChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          DateTime = 0
        end
        object LMDSpinEditTracing: TLMDSpinEdit
          Left = 80
          Top = 104
          Width = 65
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 3
          OnChange = LMDSpinEditTracingChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          DateTime = 0
        end
        object ComboBoxStyle: TComboBox
          Left = 80
          Top = 8
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          OnChange = ComboBoxStyleChange
          Items.Strings = (
            'tdNone'
            'tdSunken'
            'tdRaised'
            'tdSunkenShadow'
            'tdRaisedShadow'
            'tdPColorSunken'
            'tdPColorRaised'
            'tdShadow')
        end
        object LMDLightColorComboBox: TLMDColorComboBox
          Left = 248
          Top = 72
          Width = 97
          Height = 21
          DlgOptions = []
          DlgHelpContext = 0
          TabOrder = 5
          OnChange = LMDLightColorComboBoxChange
        end
        object LMDShadowColorComboBox: TLMDColorComboBox
          Left = 248
          Top = 104
          Width = 97
          Height = 21
          DlgOptions = []
          DlgHelpContext = 0
          TabOrder = 6
          OnChange = LMDShadowColorComboBoxChange
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Font'
        object LMDSimpleLabel4: TLMDSimpleLabel
          Left = 8
          Top = 24
          Width = 23
          Height = 15
          Caption = 'Font'
          Options = []
        end
        object LMDSimpleLabel5: TLMDSimpleLabel
          Left = 8
          Top = 56
          Width = 26
          Height = 15
          Caption = 'Color'
          Options = []
        end
        object LMDSimpleLabel6: TLMDSimpleLabel
          Left = 8
          Top = 88
          Width = 41
          Height = 15
          Caption = 'Fontsize'
          Options = []
        end
        object LMDFontComboBox: TLMDFontComboBox
          Left = 80
          Top = 16
          Width = 145
          Height = 21
          ExampleText = 'Abc'
          FastMode = True
          Options = [foScreenFonts, foTrueTypeOnly, foDisplaySymbol]
          TabOrder = 0
          OnChange = LMDFontComboBoxChange
        end
        object LMDColorComboBox: TLMDColorComboBox
          Left = 80
          Top = 48
          Width = 143
          Height = 21
          DlgOptions = []
          DlgHelpContext = 0
          Options = [coDefaultColors, coCustomColors, coAllowAnyColor]
          TabOrder = 1
          OnChange = LMDColorComboBoxChange
        end
        object LMDFontSizeComboBox: TLMDFontSizeComboBox
          Left = 80
          Top = 80
          Width = 57
          Height = 21
          FontCombo = LMDFontComboBox
          TabOrder = 2
          OnChange = LMDFontSizeComboBoxChange
        end
        object ButtonFontDialog: TLMDButton
          Left = 272
          Top = 96
          Width = 75
          Height = 23
          Caption = 'Font >>'
          TabOrder = 3
          OnClick = Button1Click
          CtlXP = False
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Attributes'
        object LMDSimpleLabel1: TLMDSimpleLabel
          Left = 8
          Top = 80
          Width = 35
          Height = 15
          Caption = 'Toggle'
          Options = []
        end
        object LMDSimpleLabel2: TLMDSimpleLabel
          Left = 8
          Top = 16
          Width = 58
          Height = 15
          Caption = 'Perspective'
          Options = []
        end
        object LMDSimpleLabel3: TLMDSimpleLabel
          Left = 8
          Top = 48
          Width = 85
          Height = 15
          Caption = 'Perspectivedepth'
          Options = []
        end
        object LMDSpinEditToggle: TLMDSpinEdit
          Left = 144
          Top = 72
          Width = 73
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 0
          OnChange = LMDSpinEditToggleChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          DateTime = 0
        end
        object LMDSpinEditPerspectiveDepth: TLMDSpinEdit
          Left = 144
          Top = 40
          Width = 73
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          CtlXP = False
          TabOrder = 1
          OnChange = LMDSpinEditPerspectiveDepthChange
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          DateTime = 0
        end
        object ComboBoxPerspective: TComboBox
          Left = 144
          Top = 8
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = ComboBoxPerspectiveChange
          Items.Strings = (
            'None'
            'Bird'
            'Frog')
        end
        object CheckBoxEqualLetters: TLMDCheckBox
          Left = 232
          Top = 8
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'EqualLetters'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          TabOrder = 3
          OnClick = CheckBoxEqualLettersClick
        end
        object CheckBoxAutoToggle: TLMDCheckBox
          Left = 232
          Top = 40
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'AutoToggled'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          TabOrder = 4
          OnClick = CheckBoxAutoToggleClick
        end
        object CheckBoxToggled: TLMDCheckBox
          Left = 232
          Top = 72
          Width = 105
          Height = 17
          CtlXP = False
          Caption = 'Toggled'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          TabOrder = 5
          OnClick = CheckBoxToggledClick
        end
      end
    end
    object LMDSPCarryControls: TLMDSimplePanel
      Left = 365
      Top = 1
      Width = 109
      Height = 159
      CtlXP = False
      Align = alRight
      Bevel.Mode = bmCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object LMDButton1: TLMDButton
        Left = 16
        Top = 8
        Width = 75
        Height = 23
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        CtlXP = False
      end
      object LMDButton2: TLMDButton
        Left = 16
        Top = 40
        Width = 75
        Height = 23
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
        CtlXP = False
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 8
    Top = 8
  end
  object LMDFormStyler: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 40
    Top = 8
  end
end
