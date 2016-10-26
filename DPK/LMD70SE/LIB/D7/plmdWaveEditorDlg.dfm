object LMDWaveEditorDlg: TLMDWaveEditorDlg
  Left = 314
  Top = 196
  ActiveControl = FileList
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 235
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 336
    Top = 6
    Width = 3
    Height = 13
    Transparent = True
  end
  object Label2: TLabel
    Left = 337
    Top = 26
    Width = 23
    Height = 13
    Caption = 'Size:'
    Transparent = True
  end
  object Label3: TLabel
    Left = 461
    Top = 41
    Width = 19
    Height = 13
    Caption = 'Ch.:'
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 335
    Top = 21
    Width = 229
    Height = 5
    Shape = bsTopLine
  end
  object format: TLabel
    Left = 443
    Top = 6
    Width = 3
    Height = 13
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object size: TLabel
    Left = 367
    Top = 26
    Width = 68
    Height = 13
    AutoSize = False
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object bits: TLabel
    Left = 493
    Top = 26
    Width = 68
    Height = 13
    AutoSize = False
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label23: TLabel
    Left = 461
    Top = 26
    Width = 15
    Height = 13
    Caption = 'Bit:'
    Transparent = True
  end
  object Channels: TLabel
    Left = 493
    Top = 41
    Width = 68
    Height = 13
    AutoSize = False
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel
    Left = 337
    Top = 41
    Width = 18
    Height = 13
    Caption = 'SR:'
    Transparent = True
  end
  object samplerate: TLabel
    Left = 367
    Top = 41
    Width = 68
    Height = 13
    AutoSize = False
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 5
    Top = 188
    Width = 32
    Height = 13
    Caption = 'Label4'
    Transparent = True
  end
  object Label5: TLabel
    Left = 6
    Top = 6
    Width = 3
    Height = 13
    Transparent = True
  end
  object Label6: TLabel
    Left = 45
    Top = 6
    Width = 283
    Height = 13
    AutoSize = False
    Caption = 'D:\work\lmdvcl\LMDCore70'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Load: TButton
    Left = 337
    Top = 62
    Width = 55
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = LoadClick
  end
  object Save: TButton
    Left = 395
    Top = 62
    Width = 55
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = SaveClick
  end
  object Clear: TButton
    Left = 511
    Top = 62
    Width = 55
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ClearClick
  end
  object dirbox: TDirectoryListBox
    Left = 5
    Top = 42
    Width = 169
    Height = 137
    DirLabel = Label6
    FileList = FileList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 2
  end
  object DriveComboBox1: TDriveComboBox
    Left = 5
    Top = 20
    Width = 169
    Height = 19
    DirList = dirbox
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object FileList: TFileListBox
    Left = 177
    Top = 20
    Width = 152
    Height = 160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    Mask = '*.wav'
    ParentFont = False
    TabOrder = 1
    OnChange = FileListChange
    OnDblClick = FileListDblClick
  end
  object Play: TButton
    Left = 453
    Top = 62
    Width = 55
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = PlayClick
  end
  object PlayWave: TBitBtn
    Left = 407
    Top = 128
    Width = 80
    Height = 25
    Cancel = True
    Caption = 'PlayWave'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Visible = False
    OnClick = FileListDblClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333FFF3333F333333300033339333333337773F33733333330008033
      933333333737F7F37333333307078733333933337337373F3337333077088803
      33933337F37F337F3373333077088803393333F7337FF37F3733300777008803
      9333377F33773F7F733307088808087333337F7F337F7F7F3FFF070777080873
      99997F7F337F7F7F77770808880808733333737F337F737F3F33300888008803
      93333773F377337F73F333308807880339333337F37F337F373F333088077803
      339333373F73F37333733333087777333339333373F7F7F33F37333330807033
      933333333737F73373F333333300033339333333337773333733}
    Margin = 2
    NumGlyphs = 2
    Style = bsNew
    Spacing = -1
  end
  object cmb: TComboBox
    Left = 44
    Top = 184
    Width = 281
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    Sorted = True
    TabOrder = 8
    OnChange = cmbChange
  end
  object add: TButton
    Left = 44
    Top = 209
    Width = 74
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = addClick
  end
  object remove: TButton
    Left = 120
    Top = 209
    Width = 74
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = removeClick
  end
  object clearlist: TButton
    Left = 196
    Top = 209
    Width = 74
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = removeClick
  end
  object Lock: TCheckBox
    Left = 275
    Top = 212
    Width = 49
    Height = 13
    Caption = '&Lock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object ok: TButton
    Left = 436
    Top = 208
    Width = 65
    Height = 22
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 13
  end
  object Button2: TButton
    Left = 504
    Top = 208
    Width = 65
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 14
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'wav'
    FileName = '*.wav'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 285
    Top = 154
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 532
    Top = 130
  end
end
