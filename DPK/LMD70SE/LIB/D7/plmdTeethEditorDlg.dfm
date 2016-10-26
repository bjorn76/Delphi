object LMDTeethEditorDlg: TLMDTeethEditorDlg
  Left = 118
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Teeth-Editor'
  ClientHeight = 343
  ClientWidth = 447
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 6
    Top = 219
    Width = 438
    Height = 8
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 4
    Top = 232
    Width = 347
    Height = 107
  end
  object test: TLMDShapeControl
    Left = 8
    Top = 8
    Width = 234
    Height = 207
    Hint = 'Displays the current settings.'
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -13
    Caption.Font.Name = 'System'
    Caption.Font.Style = []
    Mode = scmTeethFast
    Teeth.Height = 10
  end
  object Label1: TLabel
    Left = 16
    Top = 249
    Width = 45
    Height = 13
    Caption = 'Direction:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 16
    Top = 278
    Width = 31
    Height = 13
    Caption = 'Count:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 152
    Top = 279
    Width = 31
    Height = 13
    Caption = 'Width:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 254
    Top = 278
    Width = 34
    Height = 13
    Caption = 'Height:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 96
    Top = 304
    Width = 5
    Height = 16
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 212
    Top = 304
    Width = 5
    Height = 16
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 259
    Top = 13
    Width = 5
    Height = 16
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 273
    Top = 13
    Width = 150
    Height = 52
    Caption = 
      'SetPerCount decides either the "Count"-value or the "Width/Heigh' +
      't"-values will be used to draw the shape.'
    WordWrap = True
  end
  object Label9: TLabel
    Left = 259
    Top = 78
    Width = 5
    Height = 16
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 273
    Top = 78
    Width = 138
    Height = 26
    Caption = 'Offset decides whether the outer edges are drawn sharp.'
    WordWrap = True
  end
  object cmb: TComboBox
    Left = 75
    Top = 242
    Width = 167
    Height = 21
    Hint = 'Specifies the directions the'#13#10'teeth point to.'
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbChange
    Items.Strings = (
      'tdRight'
      'tdDown'
      'tdLeft'
      'tdUp')
  end
  object spinc: TLMDSpinEdit
    Left = 75
    Top = 274
    Width = 46
    Height = 21
    Hint = 'Specifies the count of teeth.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 1
    OnChange = spincChange
    MaxLength = 2
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    DateTime = 0
  end
  object spinW: TLMDSpinEdit
    Left = 194
    Top = 274
    Width = 47
    Height = 21
    Hint = 'Specifies the width of the teeth.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 2
    OnChange = spincChange
    MaxLength = 3
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 250
    DateTime = 0
  end
  object spinh: TLMDSpinEdit
    Left = 295
    Top = 274
    Width = 47
    Height = 21
    Hint = 'Specifies the height of the teeth.'
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 3
    OnChange = spincChange
    MaxLength = 3
    AutoSelect = True
    CustomButtons = <>
    SpinBtnDiag = False
    MaxValue = 250
    DateTime = 0
  end
  object chkc: TCheckBox
    Left = 18
    Top = 310
    Width = 77
    Height = 17
    Caption = 'SetPerCount'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = chkcClick
  end
  object chko: TCheckBox
    Left = 163
    Top = 310
    Width = 49
    Height = 17
    Caption = 'Offset'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = chkcClick
  end
  object ok: TButton
    Left = 360
    Top = 231
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object Button1: TButton
    Left = 360
    Top = 258
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object reset: TButton
    Left = 360
    Top = 295
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 8
    OnClick = resetClick
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 370
    Top = 157
  end
end
