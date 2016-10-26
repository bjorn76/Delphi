object LMDFillEditorDlg: TLMDFillEditorDlg
  Left = 291
  Top = 111
  BorderStyle = bsDialog
  ClientHeight = 313
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 144
    Width = 428
    Height = 10
    Shape = bsBottomLine
  end
  object test: TLMDFill
    Left = 22
    Top = 10
    Width = 395
    Height = 132
    Hint = 'Displays the current settings.'
    Bevel.Mode = bmStandard
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
  end
  object nb: TPageControl
    Left = 6
    Top = 161
    Width = 344
    Height = 151
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Style'
      object Label2: TLabel
        Left = 11
        Top = 20
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
      object cmbStyle: TComboBox
        Left = 76
        Top = 15
        Width = 158
        Height = 21
        Hint = 'Specifies the style of filling.'
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbChange
        Items.Strings = (
          'sfNone'
          'sfBrushBitmap'
          'sfBrush'
          'sfBitmap'
          'sfBitmapList'
          'sfGradient')
      end
      object ck1: TLMDCheckBox
        Left = 8
        Top = 47
        Width = 305
        Height = 17
        CtlXP = False
        Caption = 'FillInner (e.g. if Bitmap covers not complete dest. area)'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Flat = True
        TabOrder = 1
        OnClick = ck1Click
      end
      object ck2: TLMDCheckBox
        Left = 8
        Top = 64
        Width = 305
        Height = 17
        CtlXP = False
        Caption = 'QuickDraw (don'#39't use palette ->bitmap drawing)'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Flat = True
        TabOrder = 2
      end
      object ck3: TLMDCheckBox
        Left = 8
        Top = 80
        Width = 289
        Height = 17
        CtlXP = False
        Caption = 'UseOffScreen (Gradient style uses offscreen bitmap)'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Flat = True
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Bitmap'
      object Label4: TLabel
        Left = 14
        Top = 90
        Width = 47
        Height = 13
        Caption = 'TileMode:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object iTest: TLMDNImage
        Left = 93
        Top = 10
        Width = 155
        Height = 68
        Bevel.Mode = bmStandard
        Style = sbKeepAspRatio
      end
      object cmbTile: TComboBox
        Left = 92
        Top = 83
        Width = 158
        Height = 21
        Hint = 
          'Specifies the style of clipping '#13#10'the bitmap into the destinatio' +
          'n.'
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbChange
        Items.Strings = (
          'tmNone'
          'tmCenter'
          'tmStretch'
          'tmTile')
      end
      object btnBitmap: TLMDButton
        Left = 16
        Top = 10
        Width = 62
        Height = 23
        Hint = 'Sets a bitmap for the "sfBitmap"'#13#10'and "sfBrushBitmap"-styles.'
        Caption = 'Bitmap >>'
        TabOrder = 1
        OnClick = Button1Click
        CtlXP = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Brush'
      object btest: TLMDFill
        Left = 93
        Top = 10
        Width = 180
        Height = 74
        Bevel.Mode = bmStandard
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfBrush
      end
      object info: TLMDSimpleLabel
        Left = 115
        Top = 37
        Width = 141
        Height = 25
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiLine = True
        ParentFont = False
        Visible = False
        Caption = 'TLMDShapeFill-object uses '#13#10'the brush of a parent control-'
        Options = []
      end
      object btnbrush: TLMDButton
        Left = 16
        Top = 10
        Width = 62
        Height = 23
        Hint = 'Specifies the brush for the'#13#10'"sfBrush"-style.'
        Caption = 'Brush >>'
        TabOrder = 0
        OnClick = Button1Click
        CtlXP = False
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Gradient'
      object gTest: TLMDFill
        Left = 93
        Top = 10
        Width = 180
        Height = 74
        Bevel.Mode = bmStandard
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
      end
      object btnGradient: TLMDButton
        Left = 15
        Top = 10
        Width = 62
        Height = 23
        Hint = 'Specifies a gradient for the'#13#10'"sfGradient"-style.'
        Caption = 'Gradient >>'
        TabOrder = 0
        OnClick = Button1Click
        CtlXP = False
      end
    end
  end
  object ok: TLMDButton
    Left = 356
    Top = 184
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    CtlXP = False
  end
  object Button1: TLMDButton
    Left = 356
    Top = 212
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    CtlXP = False
  end
  object reset: TLMDButton
    Left = 356
    Top = 248
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
    Left = 404
    Top = 145
  end
end
