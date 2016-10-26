object LMDCaptionEditorDlg: TLMDCaptionEditorDlg
  Left = 299
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TLMDCaption-Editor'
  ClientHeight = 308
  ClientWidth = 364
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
  object Bevel2: TBevel
    Left = 7
    Top = 191
    Width = 261
    Height = 107
  end
  object Label1: TLabel
    Left = 17
    Top = 230
    Width = 49
    Height = 13
    Caption = 'Alignment:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object test: TLMDShapeControl
    Left = 11
    Top = 9
    Width = 339
    Height = 173
    Bevel.Width = 1
    Bevel.Style = sbInset
    Brush.Color = clBtnFace
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Shadow.Style = hssNone
    Transparent = False
  end
  object Label2: TLabel
    Left = 17
    Top = 255
    Width = 39
    Height = 13
    Caption = '&Caption:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object cmb: TComboBox
    Left = 73
    Top = 226
    Width = 185
    Height = 21
    Hint = 'Aligns your text in the object it is embedded in.'
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbChange
    Items.Strings = (
      'agTopLeft'
      'agTopCenter'
      'agTopRight'
      'agCenterLeft'
      'agCenter'
      'agCenterRight'
      'agBottomLeft'
      'agBottomCenter'
      'agBottomRight')
  end
  object cap: TEdit
    Left = 73
    Top = 252
    Width = 185
    Height = 21
    TabOrder = 1
    OnChange = capChange
  end
  object ok: TLMDButton
    Left = 279
    Top = 192
    Width = 77
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object Button1: TLMDButton
    Left = 279
    Top = 220
    Width = 77
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object reset: TLMDButton
    Left = 279
    Top = 256
    Width = 77
    Height = 24
    Caption = 'Reset'
    TabOrder = 4
    OnClick = resetClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object chk: TLMDCheckBox
    Left = 16
    Top = 275
    Width = 65
    Height = 17
    Hint = 'Specifies whether WordWrap is used.'
    CtlXP = False
    Caption = 'MultiLine'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    Flat = True
    TabOrder = 5
    OnClick = chkClick
  end
  object btnf: TLMDButton
    Left = 15
    Top = 196
    Width = 66
    Height = 23
    Hint = 'Changes the Font.'
    Caption = 'Font >>'
    TabOrder = 6
    OnClick = btncClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object btnffx: TLMDButton
    Left = 87
    Top = 196
    Width = 66
    Height = 23
    Hint = 'Changes rotation, 3D-effect etc.'
    Caption = 'FontFX >>'
    TabOrder = 7
    OnClick = btncClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 301
    Top = 285
  end
end
