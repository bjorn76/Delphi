object LMDFrmDateTimePropertyEditor: TLMDFrmDateTimePropertyEditor
  Left = 273
  Top = 205
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'DateTimeFormat Property Editor'
  ClientHeight = 227
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 8
    Top = 24
    Width = 78
    Height = 15
    Caption = 'Default settings:'
    Options = []
  end
  object LMDListBox1: TLMDListBox
    Left = 291
    Top = 0
    Width = 196
    Height = 227
    Align = alRight
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 0
    Bevel.Mode = bmCustom
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    HeaderHeight = 17
    HeaderSections = <
      item
        ImageIndex = -1
        Text = 'Description'
        Width = 101
      end
      item
        ImageIndex = -1
        Text = 'Code to insert'
        Width = 76
      end>
    ItemHeight = 16
    Items.Strings = (
      'Day;dd'
      'Month;mm'
      'Year;yy'
      'Day of week;dddd'
      'Monthname;mmmm'
      'Year with thousands;yyyy'
      'Hour;hh'
      'Minutes;mm'
      'Seconds;ss'
      'Delimiter;every other symbol')
  end
  object Button1: TButton
    Left = 8
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 89
    Top = 192
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 88
    Width = 273
    Height = 89
    Caption = 'DateTimeFormat'
    TabOrder = 3
    object LMDSimpleLabel1: TLMDSimpleLabel
      Left = 8
      Top = 49
      Width = 96
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Caption = 'Current settings:'
      Options = []
    end
    object LMDInformationLabel1: TLMDInformationLabel
      Left = 8
      Top = 64
      Width = 124
      Height = 15
      Info = itCurrentDateTime
      Bevel.Mode = bmCustom
      DateTimeFormat = 'dd/mm/yy'
      Transparent = False
    end
    object Edit1: TEdit
      Left = 8
      Top = 24
      Width = 257
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 40
    Width = 273
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'Custom'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Custom'
      '21.11.98'
      '11/21/98'
      '23:20'
      '23:20:12'
      '31.10.1998'
      'Thursday, 14.05.1998'
      'Thursday, 14.05.1998 15:01')
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 95
    Top = 9
  end
end
