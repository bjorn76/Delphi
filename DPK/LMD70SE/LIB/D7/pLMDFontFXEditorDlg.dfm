object LMDFxEditorDlg: TLMDFxEditorDlg
  Left = 295
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 320
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 5
    Top = 176
    Width = 431
    Height = 8
    Shape = bsBottomLine
  end
  object test: TLMDLabel
    Left = 3
    Top = 1
    Width = 446
    Height = 164
    Hint = 'Displays the current settings.'
    Bevel.Mode = bmCustom
    Alignment = agCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Options = []
    ParentFont = False
    Caption = 'Test-Label'
  end
  object Label2: TLabel
    Left = 5
    Top = 171
    Width = 330
    Height = 10
    Caption = 
      'Test-Label does not display font-settings of the actual control.' +
      ' It demonstrates Effects only.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -8
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object nb: TPageControl
    Left = 6
    Top = 192
    Width = 344
    Height = 125
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Styles'
      object Label1: TLabel
        Left = 11
        Top = 13
        Width = 26
        Height = 13
        Caption = 'Style:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 11
        Top = 41
        Width = 55
        Height = 13
        Caption = 'LightDepth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object rt: TLabel
        Left = 11
        Top = 69
        Width = 30
        Height = 13
        Caption = 'Angle:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 130
        Top = 41
        Width = 71
        Height = 13
        Caption = 'ShadowDepth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 130
        Top = 69
        Width = 39
        Height = 13
        Caption = 'Tracing:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object cmb: TComboBox
        Left = 70
        Top = 8
        Width = 185
        Height = 21
        Hint = 'Defines the 3D-effect.'
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbChange
        Items.Strings = (
          'tdNone'
          'tdSunken'
          'tdRaised'
          'tdSunkenShadow'
          'tdRaisedShadow'
          'tdPColorSunken'
          'tdPColorRaised'
          'tdShadow'
          'tdOutline'
          'tdExtrude'
          'tdExtrudeEnh')
      end
      object lidepth: TLMDSpinEdit
        Left = 70
        Top = 35
        Width = 48
        Height = 21
        Hint = 'Specifies the Depth of the light-effect'#13#10'if using a 3D-effect.'
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 1
        OnChange = edchange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        Value = 1
        DateTime = 0
      end
      object anglev: TLMDSpinEdit
        Left = 70
        Top = 64
        Width = 48
        Height = 21
        Hint = 'Specifies the rotating-angle'#13#10'between 0 and 360 degree.'
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 2
        OnChange = edchange
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
        MaxValue = 360
        Value = 1
        DateTime = 0
      end
      object shDepth: TLMDSpinEdit
        Left = 206
        Top = 36
        Width = 48
        Height = 21
        Hint = 'Specifies the Depth of the shadow-effect'#13#10'if using a 3D-effect.'
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 3
        OnChange = edchange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        Value = 1
        DateTime = 0
      end
      object trac: TLMDSpinEdit
        Left = 206
        Top = 64
        Width = 48
        Height = 21
        Hint = 'Specifies the extra space between the characters.'
        Bevel.Mode = bmWindows
        Caret.BlinkRate = 530
        CtlXP = False
        TabOrder = 4
        OnChange = edchange
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        AutoSelect = True
        ParentFont = False
        CustomButtons = <>
        SpinBtnDiag = False
        MinValue = -20
        Value = 1
        DateTime = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Colors'
      object Label5: TLabel
        Left = 8
        Top = 24
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
      object Label6: TLabel
        Left = 8
        Top = 48
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
      object cmbL: TLMDColorComboBox
        Left = 84
        Top = 20
        Width = 138
        Height = 21
        Hint = 'Defines the light-color used for'#13#10'3D-effects.'
        DlgOptions = []
        DlgHelpContext = 0
        Options = [coDefaultColors, coSystemColors, coAllowAnyColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = cmbc
      end
      object cmbs: TLMDColorComboBox
        Left = 84
        Top = 44
        Width = 138
        Height = 21
        Hint = 'Defines the shadow-color used for'#13#10'3D-effects.'
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
        OnChange = cmbc
      end
      object dlgl: TLMDDockButton
        Left = 223
        Top = 20
        Width = 22
        Height = 21
        TabOrder = 1
        OnClick = dlgsClick
        CtlXP = False
        Glyph.Data = {
          0E030000424D0E0300000000000036000000280000000D0000000E0000000100
          200000000000D802000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000000
          0000000000000000000000000000000000000080800000808000008080000080
          80000080800000808000008080000000000000FFFF00C0C0C00000FFFF00C0C0
          C00000FFFF000000000000000000008080000080800000808000008080000080
          800000000000C0C0C00000000000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
          C00000000000008080000080800000808000008080000080800000000000FFFF
          000000000000C0C0C00000000000C0C0C00000FFFF0000000000008080000080
          8000008080000080800000000000C0C0C00000000000C0C0C000000000000000
          FF0000000000C0C0C00000FFFF00000000000080800000000000000000000000
          000000FFFF00C0C0C00000FFFF00C0C0C00000000000C0C0C00000FFFF00C0C0
          C000000000000000000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
          C00000FFFF00C0C0C00000000000C0C0C00000FFFF000000000000000000C0C0
          C000C0C0C00000000000C0C0C000C0C0C00000FFFF00C0C0C00000000000C0C0
          C00000000000C0C0C000000000000000000000FFFF0000000000800080000000
          0000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C00000FFFF000000
          000000000000C0C0C000C0C0C00000000000C0C0C00000000000FF00FF000000
          000000FFFF00C0C0C00000FFFF0000000000008080000080800000000000C0C0
          C00000FFFF00C0C0C000C0C0C00000000000C0C0C000C0C0C00000FFFF000000
          000000808000008080000080800000808000000000000000000000FFFF00C0C0
          C00000FFFF00C0C0C00000000000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000000000000080
          800000808000008080000080800000808000}
        Control = cmbL
        GlyphKind = gkColor
      end
      object dlgs: TLMDDockButton
        Left = 223
        Top = 44
        Width = 22
        Height = 21
        TabOrder = 3
        OnClick = dlgsClick
        CtlXP = False
        Glyph.Data = {
          0E030000424D0E0300000000000036000000280000000D0000000E0000000100
          200000000000D802000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000000
          0000000000000000000000000000000000000080800000808000008080000080
          80000080800000808000008080000000000000FFFF00C0C0C00000FFFF00C0C0
          C00000FFFF000000000000000000008080000080800000808000008080000080
          800000000000C0C0C00000000000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
          C00000000000008080000080800000808000008080000080800000000000FFFF
          000000000000C0C0C00000000000C0C0C00000FFFF0000000000008080000080
          8000008080000080800000000000C0C0C00000000000C0C0C000000000000000
          FF0000000000C0C0C00000FFFF00000000000080800000000000000000000000
          000000FFFF00C0C0C00000FFFF00C0C0C00000000000C0C0C00000FFFF00C0C0
          C000000000000000000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
          C00000FFFF00C0C0C00000000000C0C0C00000FFFF000000000000000000C0C0
          C000C0C0C00000000000C0C0C000C0C0C00000FFFF00C0C0C00000000000C0C0
          C00000000000C0C0C000000000000000000000FFFF0000000000800080000000
          0000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C00000FFFF000000
          000000000000C0C0C000C0C0C00000000000C0C0C00000000000FF00FF000000
          000000FFFF00C0C0C00000FFFF0000000000008080000080800000000000C0C0
          C00000FFFF00C0C0C000C0C0C00000000000C0C0C000C0C0C00000FFFF000000
          000000808000008080000080800000808000000000000000000000FFFF00C0C0
          C00000FFFF00C0C0C00000000000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000000000000080
          800000808000008080000080800000808000}
        Control = cmbs
        GlyphKind = gkColor
      end
    end
  end
  object ok: TLMDButton
    Left = 357
    Top = 216
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    CtlXP = False
  end
  object Button1: TLMDButton
    Left = 357
    Top = 244
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    CtlXP = False
  end
  object reset: TLMDButton
    Left = 357
    Top = 280
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 3
    OnClick = resetClick
    CtlXP = False
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 375
    Top = 108
  end
end
