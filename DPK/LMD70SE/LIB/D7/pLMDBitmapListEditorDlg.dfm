object LMDBitmapListEditorDlg: TLMDBitmapListEditorDlg
  Left = 824
  Top = 254
  Width = 450
  Height = 361
  ActiveControl = lb
  BorderIcons = [biSystemMenu]
  Caption = 'BitmapList-Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 442
    Height = 37
    Align = alTop
    Bevel.BorderSides = [fsBottom, fsTop]
    Bevel.Mode = bmEdge
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object btnLoad: TLMDSpeedButton
      Left = 51
      Top = 6
      Width = 41
      Height = 26
      Hint = 'Load List'
      OnClick = fileactionClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      NumGlyphs = 2
      ButtonStyle = ubsFlat
      DropDownCombo = True
    end
    object btnSave: TLMDSpeedButton
      Left = 92
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Save List'
      ParentFont = False
      OnClick = fileactionClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 1
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
    end
    object btnCut: TLMDSpeedButton
      Left = 132
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Cut'
      ParentFont = False
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 10
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
    end
    object btnCopy: TLMDSpeedButton
      Left = 161
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Copy'
      ParentFont = False
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 9
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
    end
    object btnPaste: TLMDSpeedButton
      Left = 190
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Paste'
      ParentFont = False
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 12
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
    end
    object singleselect: TLMDSpeedButton
      Left = 229
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Toggle SingleSelect Mode'
      ParentFont = False
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 16
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
      GroupIndex = 1
      Pressed = True
    end
    object multisel: TLMDSpeedButton
      Left = 258
      Top = 6
      Width = 29
      Height = 26
      Hint = 'Toggle MultiSelect Mode'
      ParentFont = False
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      EnterColor = clNavy
      EnterColorChange = True
      ImageList = LMDImageList1
      ImageIndex = 17
      NumGlyphs = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ButtonStyle = ubsFlat
      GroupIndex = 1
    end
    object LMDSimplePanel4: TLMDSimplePanel
      Left = 2
      Top = 2
      Width = 44
      Height = 33
      Align = alLeft
      Bevel.BorderSides = [fsRight]
      Bevel.Mode = bmEdge
      TabOrder = 0
      object LMDButton1: TLMDButton
        Left = 0
        Top = 1
        Width = 40
        Height = 14
        Caption = 'OK'
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 0
        CtlXP = False
        ButtonStyle = ubsWin40
      end
      object LMDButton2: TLMDButton
        Left = 0
        Top = 15
        Width = 40
        Height = 14
        Cancel = True
        Caption = 'Cancel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 1
        OnClick = fileactionClick
        CtlXP = False
        ButtonStyle = ubsWin40
      end
    end
  end
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 46
    Top = 37
    Width = 396
    Height = 270
    Align = alClient
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsNone
    TabOrder = 1
    object lb: TLMDListBox
      Left = 0
      Top = 0
      Width = 396
      Height = 270
      Align = alClient
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentShowHint = False
      PopupMenu = pop
      ShowHint = True
      TabOrder = 0
      OnClick = lbClick
      OnDblClick = lbDblClick
      AllowResize = False
      Bevel.BorderSides = [fsBottom, fsRight]
      Bevel.Mode = bmStandard
      Bevel.StandardStyle = lsNone
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'MS Sans Serif'
      HeaderFont.Style = []
      HeaderHeight = 20
      HeaderSections = <
        item
          ImageIndex = -1
          Text = 'Nr.'
          Width = 42
        end
        item
          ImageIndex = -1
          Text = 'ID'
          Width = 41
        end
        item
          ImageIndex = -1
          Text = 'C.'
          Width = 23
        end
        item
          ImageIndex = -1
          Text = 'Col.'
          Width = 32
        end
        item
          ImageIndex = -1
          Text = 'Description'
          Width = 80
        end
        item
          ImageIndex = -1
          Text = 'Bitmap'
          Width = 173
        end>
      ItemHeight = 40
      Style = lbOwnerDrawFixed
      OnDrawItem = lbDrawItem
    end
  end
  object LMDSimplePanel3: TLMDSimplePanel
    Left = 0
    Top = 37
    Width = 46
    Height = 270
    Align = alLeft
    Bevel.BorderSides = [fsRight]
    Bevel.Mode = bmEdge
    TabOrder = 2
    object add: TLMDSpeedButton
      Left = 7
      Top = 20
      Width = 29
      Height = 26
      Hint = 'Add item'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 3
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
    object addfast: TLMDSpeedButton
      Left = 7
      Top = 46
      Width = 29
      Height = 26
      Hint = 'Add one or multiple items'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 15
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
    object remove: TLMDSpeedButton
      Left = 7
      Top = 72
      Width = 29
      Height = 26
      Hint = 'Remove Item'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 4
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
    object clear: TLMDSpeedButton
      Left = 7
      Top = 98
      Width = 29
      Height = 26
      Hint = 'Clear List'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 5
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
    object up: TLMDSpeedButton
      Left = 7
      Top = 132
      Width = 29
      Height = 26
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageIndex = 6
      NumGlyphs = 2
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
        800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
        000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000000000
        000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000000000
        000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000000000
        000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000000000
        000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000000000
        0000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C0008000000080000000800000008000000080000000800000008000
        00008000000080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00080000000800000008000000080000000800000008000
        000080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000800000008000
        0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000800000008000000080000000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
      ButtonStyle = ubsFlat
    end
    object Down: TLMDSpeedButton
      Left = 7
      Top = 158
      Width = 29
      Height = 26
      Hint = 'Move item down'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 7
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
    object btnProp: TLMDSpeedButton
      Left = 7
      Top = 192
      Width = 29
      Height = 26
      Hint = 'Properties'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 8
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
  end
  object MainMenu1: TMainMenu
    Left = 130
    Top = 60
    object File1: TMenuItem
      Caption = '&File'
      object mnuLoad: TMenuItem
        Caption = '&Load BML...'
        OnClick = fileactionClick
      end
      object mnuSave: TMenuItem
        Caption = '&Save BML...'
        OnClick = fileactionClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = '&Quit'
        OnClick = fileactionClick
      end
      object quit2: TMenuItem
        Caption = 'Quit and &Cancel'
        OnClick = fileactionClick
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object mnuCut: TMenuItem
        Caption = '&Cut'
        ShortCut = 16472
        OnClick = PopupClick
      end
      object mnuCopy: TMenuItem
        Caption = '&Copy'
        ShortCut = 16451
        OnClick = PopupClick
      end
      object mnuPaste: TMenuItem
        Caption = '&Paste'
        ShortCut = 16470
        OnClick = PopupClick
      end
      object mnuDelete: TMenuItem
        Caption = '&Delete'
        ShortCut = 16430
        OnClick = PopupClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Up2: TMenuItem
        Caption = '&Up'
        ShortCut = 16469
        OnClick = PopupClick
      end
      object down2: TMenuItem
        Caption = '&Down'
        ShortCut = 16452
        OnClick = PopupClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mnuSelectAll: TMenuItem
        Caption = 'Select &All'
        ShortCut = 16449
        OnClick = PopupClick
      end
      object ClearAll1: TMenuItem
        Caption = 'Clear All'
        OnClick = PopupClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Properties1: TMenuItem
        Caption = '&Properties'
        OnClick = PopupClick
      end
      object Saveasbitmap1: TMenuItem
        Caption = '&Save as bitmap'
        OnClick = Saveasbitmap1Click
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      object mnuAddFromFile: TMenuItem
        Caption = '&Add Items from BML...'
        OnClick = fileactionClick
      end
      object comp: TMenuItem
        Caption = 'Compressed &Status'
        object checkall: TMenuItem
          Caption = 'Check all'
          OnClick = PopupClick
        end
        object UnCheckAll: TMenuItem
          Caption = 'UnCheckAll'
          OnClick = PopupClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object mnuMulti: TMenuItem
        Caption = '&MultiLine Mode'
        OnClick = PopupClick
      end
    end
  end
  object LMDImageList1: TLMDImageList
    Left = 159
    Top = 62
    object TLMDImageListItem
      Width = 32
      Internal = {
        2110000000200000000400000000120000002E0A00002A0A0000400541424D76
        12000012760060280040400200001000801E2301000400600030020400000200
        800000003000808000730060C11100B000F08000C0C0C00390FF0000003000FF
        FF0073E25C006000B000F0FF008800148FFF0010F800D400710112FFFFFA1C00
        B1004201F000E800000C880005538F77778F051900000E8805F2FFF8F9520000
        0B8808B70000078804320000048880880013F705F6180113887800000A88FF60
        59F8024213D000000888887700117F01300112000801133310777F177100E088
        870205000011880077771212778F8F777DE88F000005880965082106F3080477
        0121084000330F044400E38877F8344E8FF800000188012144001188FFFF0A21
        778800171CF608F2883C16888F05F712050F1103178888F8888406F48706F008
        10F82C1000330010300A0006A187F88880330B20880308874000F806F0F87F7F
        0330000F030888887F877714C07F7F7F1C428F00628888008506198888808707
        00411178031087FF78778808027777780232FFFFF800826954800C5504810F08
        50FFF006008F0E20F70212840F0288884000F708207788848848844888888887
        F87F87A0D004F18000C0888808888702C21C014F0430F4877777536478008087
        01E04448005000307702F1008080F00050888820FC8FF70333888FFF88110121
        008008A40AF0011105418444221088000010888777101177880B031200330888
        7FB59104D27F120F12010002008712000723744F04D288788F00000488000480
        088088800888888778F78F870551800018A000788800130D3288440701048F01
        000F00F0000082820C107F778777770C13840E80F4888888F70040874E688812
        00488400A11AD00201000800D000307705C1888807158437374F0D00F4053078
        1500120F88800FF80332F7780896887FF8880010744F882402788F0114880202
        01A087E5912409010000300FB0120130220003C187F8240F0000032410D70424
        0012107F1F3174120F0490003580800F08080710878761CD7800100550844440
        7801D1005000E0888801001B748804E09031240F88841320F488FFFFF7F71320
        1207FF7F7F0C00130688000004D08088400004E08788037373240212E0780EBA
        FFF8888701D000353603800620F0090108001B02880C00114132180250788F88
        77780080888801F0008287F8000001880B212EFB031211087F887F1B70FF7F12
        02003604112001E203626C00020001F07F777F0480744F0050003078240F0160
        080F09F9FF808780331078F82410071011000862005000E0888833E0610D0700
        C002B0888FF888240D8000000406A033017702F055428703004824028808D0F7
        01208012010888888701F178897424030F444409907877242088031100500030
        7701408888B4E611F0FF3C11073287041088740C0E04F00300888801F200A288
        110488FFF800920FBFB029F000007F888729F0777740658012E133330887F88F
        FF00104801003324107F01F0821B1C207F888FFF841B1088888FFF003020108F
        02601AA1820A008500F0F008080C4077878778780C4184240B841F8044444001
        F007D200500BF50CC20A0080FFFFF4F000000086F487888887F7777700708848
        44480290172077408478008100088880088824107F88877824044F48D0AC0400
        01E07800408844488800127701408805000A1108872D66888F0080F80C0F02B0
        8004F18800100AF084440080003087277877F803120BFB0010020004C18805E0
        2403120112F1FF7F03B8B00C1003120101C05A107F8874200044182001008888
        8F888016010E0FFF0FF7F08088887FF82410871850120C8899C9010477780860
        1DF30FF002F016B0340180F02404F7770AE02C41FFF70250400F050323800088
        16028777F8778824021C82FFFF4460A101F0011088880E38888808FFCC0010FF
        21BD807F3910777788870B0E0610881000007101E003D100001031AA888705E0
        1020880FBF001002007F3F10FF0620806CC088EED26C0109A15B6003120F1210
        120F8803C01301872400F0085920770CCE878787787E111100777807F00040FF
        F80080010000B088604088005000F00F00FFF080F0120077F88787F7F81811FF
        80FF2400330087F88887F7780D208888800350B1F700318702F0008100000800
        710F100430480009004012010CF01202D7C9241A0BF0FF0010F023910080120F
        04B20050FFF80050888815D78C8F00F2880BFB12E007007FFF05F078FFFF120F
        A4A02404402082721871744877788809E27778008103910086807F2410F020FC
        F70878F0FF7FF7F87F07100C0006C026B000600030844468004003701206085C
        F00008447F787F7878777F77913D24034F4835D1F8887802A100080360003033
        0200808023F218A18888872610240137373766008F0FE0F88788880E10933100
        30888801E087772A0123F0CCCF12000A707778870B80FD340C0A02C2055002F0
        0422000000888006D2000804C10E507F120FFFFF7B720F12015BF0360235204F
        05000030780F3600D00035808717000005F87F0887FF7700108F3B7011F03211
        0AC00243120CF080800078808880447FF78787870D502401330122D0F7FFFFB0
        4A03520812048833888800000804A2777705E0034AD000369B0770780006F07F
        120F240B88021088740C09120000001007A071A3F80410070205D288FFF80083
        0062800722F888F7120E03C09F110030030803D109100920060B000000888000
        871C9000088706B24AC477030084444F328720B1880010120B00000810014477
        0802777878781A1080F00F04444448888735D177442778030080080000608888
        877F230188881D200112062095850110077001D0072400870D00120BFFF77788
        4803CF48043ECC7888120F09D205E002C004A0881300007188875A0400D10888
        2236080800817FFF78120400088748020E00031820B4217F3C427FFF6C02240F
        03B1004680887802908008878F0B00886E99870E110EE0880010081408204000
        E0888801B1009180800060F8440A6023F012012AF008D187F888780223808880
        02108888102A87F887053180000888800800F0770EE07F6C000B106000B07324
        00FF7F7787FF0B512B0488777777781A9D8888801AE000300803C2884A718874
        2409000000881200000010113788877725078000880012877705005A02081200
        0560111079958802D00030D9060290777800500030777800000488001200F805
        1031A1778F6920051088888402C000308702FC777778880012B1F20ED0801200
        13118777804EF00161286003D20920888001118855008712030005C088004077
        01F177F8800000BB0000779A080D000D110521842B03012103811DF0FFFF6011
        15D1870051777DF878018118C0008400E300648408A100C010C1000004880700
        10F0000887F78417F00030043024120817B02180403500000C880007FF800610
        88771B6778888700810046780000078807300809610730787700D1032100D18F
        380081888880002000A1120508B088881B0004F23C0080000844158800118777
        78000004888008FFFF800220870BF0F702F0CBAE0000418812F1000816F07700
        10083F000003887802E088001102EF00006388801B0000000808D117207F23F1
        00001E88}
    end
  end
  object pop: TPopupMenu
    OnPopup = PopupClick
    Left = 100
    Top = 60
    object Add1: TMenuItem
      Caption = '&Add'
      ShortCut = 16429
      OnClick = PopupClick
    end
    object Remove1: TMenuItem
      Caption = '&Delete'
      ShortCut = 16430
      OnClick = PopupClick
    end
    object Clear1: TMenuItem
      Caption = '&Clear All'
      OnClick = PopupClick
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = PopupClick
    end
    object Up1: TMenuItem
      Caption = '&Up'
      ShortCut = 16469
      OnClick = PopupClick
    end
    object Down1: TMenuItem
      Caption = '&Down'
      ShortCut = 16452
      OnClick = PopupClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object prop: TMenuItem
      Caption = '&Properties'
      OnClick = PopupClick
    end
  end
  object fm: TLMDFMDrop
    Control = lb
    OnFMDragDrop = fmFMDragDrop
    Left = 100
    Top = 88
  end
  object FileDialog: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 128
    Top = 116
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 100
    Top = 116
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 128
    Top = 88
  end
  object SavePictureDialog: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 158
    Top = 93
  end
  object ini: TLMDIniCtrl
    Target = itRegistry
    Left = 55
    Top = 181
  end
  object mru: TLMDMRUList
    Button = btnLoad
    MaxLength = 48
    MenuItem = mnuSave
    Options = [moShowAccel, moSubIfEmpty, moSubClearOption]
    IniLink = ini
    IniUse = ioUseLink
    Section = 'PathList'
    OnClick = mruClick
    Left = 55
    Top = 212
  end
end
