object LMDSmallBarEditorDlg: TLMDSmallBarEditorDlg
  Left = 200
  Top = 294
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TLMDSmallBar - Editor'
  ClientHeight = 225
  ClientWidth = 362
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
    Left = 6
    Top = 88
    Width = 349
    Height = 8
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 14
    Top = 104
    Width = 43
    Height = 13
    Caption = 'BarColor:'
  end
  object Label2: TLabel
    Left = 14
    Top = 135
    Width = 47
    Height = 13
    Caption = 'BarCount:'
  end
  object Label3: TLabel
    Left = 14
    Top = 164
    Width = 42
    Height = 13
    Caption = 'HSpace:'
  end
  object Label4: TLabel
    Left = 14
    Top = 195
    Width = 41
    Height = 13
    Caption = 'VSpace:'
  end
  object test: TLMDProgress
    Left = 12
    Top = 28
    Width = 335
    Height = 37
    Hint = 'Displays the current settings.'
    Bevel.StyleOuter = bvLowered
    Bevel.Mode = bmCustom
    OptionsText = toPercent
    Position = 50
    UserValue = 50
  end
  object dlgb: TLMDDockSpeedButton
    Left = 239
    Top = 104
    Width = 21
    Height = 21
    ParentFont = False
    OnClick = dlgbClick
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
  object cmbb: TLMDColorComboBox
    Left = 64
    Top = 104
    Width = 174
    Height = 21
    Hint = 'Specifies the color of the bar.'
    DlgOptions = []
    DlgHelpContext = 0
    TabOrder = 0
    OnChange = cmbbChange
  end
  object spinc: TLMDSpinEdit
    Left = 64
    Top = 135
    Width = 46
    Height = 21
    Hint = 'Defines the count of bar items being displayed.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 1
    OnChange = spincChange
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    Value = 4
    DateTime = 0
  end
  object spinh: TLMDSpinEdit
    Left = 64
    Top = 164
    Width = 46
    Height = 21
    Hint = 
      'Specifies the space between the'#13#10'bevel and the bar items in hori' +
      'zontal'#13#10'direction.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 2
    OnChange = spincChange
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    DateTime = 0
  end
  object spinv: TLMDSpinEdit
    Left = 64
    Top = 195
    Width = 46
    Height = 21
    Hint = 
      'Specifies the space between the'#13#10'bevel and the bar items in vert' +
      'ical'#13#10'direction.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 3
    OnChange = spincChange
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    DateTime = 0
  end
  object chk: TCheckBox
    Left = 152
    Top = 136
    Width = 63
    Height = 17
    Hint = 'Specifies wheter the size of the'#13#10'smallbar is set automatically.'
    Caption = 'Autosize'
    TabOrder = 4
    OnClick = chkClick
  end
  object ok: TButton
    Left = 278
    Top = 103
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object Button1: TButton
    Left = 278
    Top = 130
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object reset: TButton
    Left = 278
    Top = 166
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 7
    OnClick = resetClick
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 308
    Top = 15
  end
end
