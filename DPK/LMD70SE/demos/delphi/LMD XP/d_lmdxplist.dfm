object frmXPList: TfrmXPList
  Left = 402
  Top = 295
  Width = 534
  Height = 450
  Caption = 'frmXPList'
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
    Left = 25
    Top = 16
    Width = 95
    Height = 15
    Caption = 'TLMDImageListBox'
    Options = []
  end
  object LMDSimpleLabel4: TLMDSimpleLabel
    Left = 21
    Top = 154
    Width = 66
    Height = 15
    Caption = 'TLMDListBox'
    Options = []
  end
  object LMDSimpleLabel8: TLMDSimpleLabel
    Left = 15
    Top = 296
    Width = 165
    Height = 12
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -8
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    Caption = '(TLMDListBox does not support Flat-Mode)'
    Options = []
  end
  object LMDSimpleLabel2: TLMDSimpleLabel
    Left = 194
    Top = 17
    Width = 244
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Caption = 'Derived from TComboBox'
    Options = []
  end
  object LMDSimpleLabel10: TLMDSimpleLabel
    Left = 198
    Top = 51
    Width = 83
    Height = 15
    Caption = 'TLMDComboBox'
    Options = []
  end
  object LMDSimpleLabel11: TLMDSimpleLabel
    Left = 198
    Top = 100
    Width = 112
    Height = 15
    Caption = 'TLMDImageComboBox'
    Options = []
  end
  object LMDSimpleLabel12: TLMDSimpleLabel
    Left = 198
    Top = 151
    Width = 107
    Height = 15
    Caption = 'TLMDColorComboBox'
    Options = []
  end
  object LMDSimpleLabel13: TLMDSimpleLabel
    Left = 198
    Top = 203
    Width = 104
    Height = 15
    Caption = 'TLMDFontComboBox'
    Options = []
  end
  object LMDSimpleLabel14: TLMDSimpleLabel
    Left = 198
    Top = 253
    Width = 124
    Height = 15
    Caption = 'TLMDFontSizeComboBox'
    Options = []
  end
  object LMDSimpleLabel15: TLMDSimpleLabel
    Left = 198
    Top = 301
    Width = 113
    Height = 15
    Caption = 'TLMDPrinterComboBox'
    Options = []
  end
  object LMDSimpleLabel16: TLMDSimpleLabel
    Left = 198
    Top = 347
    Width = 108
    Height = 15
    Caption = 'TLMDDriveComboBox'
    Options = []
  end
  object LMDCheckBox1: TLMDCheckBox
    Left = 32
    Top = 328
    Width = 124
    Height = 47
    Caption = 'Enable Flat Mode'#13#10'(no effect in Themed Mode)'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    Flat = True
    TabOrder = 0
    OnChange = LMDCheckBox1Change
  end
  object LMDImageListBox1: TLMDImageListBox
    Left = 25
    Top = 33
    Width = 121
    Height = 100
    ItemHeight = 20
    TabOrder = 1
    Options = [lboImageListOrder, lboCheckImageNr, lboCalcHeight]
    ItemIndex = -1
    ImageList = LMDXPDemo.LMDImageList1
    Layout.Alignment = agTopLeft
    ImagesOnly = True
  end
  object LMDListBox1: TLMDListBox
    Left = 21
    Top = 170
    Width = 127
    Height = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 2
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    HeaderHeight = 17
    HeaderSections = <
      item
        ImageIndex = -1
        Text = 'Column1'
        Width = 63
      end
      item
        ImageIndex = -1
        Text = 'Column2'
        Width = 62
      end>
    Items.Strings = (
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2'
      'col1;col2')
    ColumnOptions = []
  end
  object LMDComboBox1: TLMDComboBox
    Left = 198
    Top = 69
    Width = 145
    Height = 21
    ItemHeight = 13
    Items.Strings = (
      'test 1'
      'test 2'
      'test 3'
      'test 4'
      'test 5'
      'test 6'
      'test 7'
      'test 8'
      'test 9'
      'test 10'
      'test 11'
      'test 12'
      'test 13'
      'test 14')
    TabOrder = 3
    Text = 'LMDComboBox1'
  end
  object LMDImageComboBox1: TLMDImageComboBox
    Left = 198
    Top = 117
    Width = 145
    Height = 22
    Options = [lboImageListOrder, lboCalcHeight]
    ImageList = LMDXPDemo.LMDImageList1
    Layout.Alignment = agTopLeft
    ImagesOnly = True
    ItemIndex = -1
    ItemHeight = 16
    TabOrder = 4
  end
  object LMDColorComboBox1: TLMDColorComboBox
    Left = 198
    Top = 168
    Width = 145
    Height = 21
    DlgOptions = []
    DlgHelpContext = 0
    TabOrder = 5
  end
  object LMDFontComboBox1: TLMDFontComboBox
    Left = 198
    Top = 220
    Width = 145
    Height = 21
    ExampleText = 'Abc'
    MRUList = True
    TabOrder = 6
  end
  object LMDFontSizeComboBox1: TLMDFontSizeComboBox
    Left = 198
    Top = 270
    Width = 145
    Height = 21
    FontCombo = LMDFontComboBox1
    TabOrder = 7
  end
  object LMDPrinterComboBox1: TLMDPrinterComboBox
    Left = 198
    Top = 318
    Width = 145
    Height = 21
    Options = []
    TabOrder = 8
  end
  object LMDDriveComboBox1: TLMDDriveComboBox
    Left = 198
    Top = 363
    Width = 145
    Height = 19
    TabOrder = 9
  end
end
