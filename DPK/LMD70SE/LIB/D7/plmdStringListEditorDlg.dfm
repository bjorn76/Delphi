object LMDStringListEditorDlg: TLMDStringListEditorDlg
  Left = 356
  Top = 487
  Width = 381
  Height = 381
  BorderIcons = [biSystemMenu]
  Caption = 'StringList-Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 373
    Height = 37
    CtlXP = False
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
      Left = 50
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
      Left = 91
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
      Left = 131
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
      Left = 160
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
      Left = 189
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
      Left = 228
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
      Left = 257
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
      CtlXP = False
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
      end
    end
  end
  object lb: TLMDListBox
    Left = 46
    Top = 37
    Width = 327
    Height = 290
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
    TabOrder = 1
    OnClick = lbClick
    OnDblClick = lbDblClick
    AllowResize = False
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
        Width = 37
      end
      item
        ImageIndex = -1
        Text = 'Size (Lines)'
        Width = 73
      end
      item
        ImageIndex = -1
        Text = 'ID'
        Width = 39
      end
      item
        ImageIndex = -1
        Text = 'C.'
        Width = 22
      end
      item
        ImageIndex = -1
        Text = 'Description'
        Width = 151
      end>
    ItemHeight = 14
    Style = lbOwnerDrawFixed
  end
  object LMDSimplePanel3: TLMDSimplePanel
    Left = 0
    Top = 37
    Width = 46
    Height = 290
    CtlXP = False
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
      ImageList = LMDImageList1
      ImageIndex = 6
      NumGlyphs = 2
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
      Left = 6
      Top = 193
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
  object FileDialog: TOpenDialog
    DefaultExt = 'wvl'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 90
    Top = 126
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 62
    Top = 126
  end
  object fm: TLMDFMDrop
    Control = lb
    OnFMDragDrop = fmFMDragDrop
    Left = 62
    Top = 99
  end
  object pop: TPopupMenu
    OnPopup = PopupClick
    Left = 62
    Top = 71
    object Add1: TMenuItem
      Caption = '&Add'
      ShortCut = 16429
      OnClick = PopupClick
    end
    object Remove1: TMenuItem
      Caption = '&Remove'
      ShortCut = 16430
      OnClick = PopupClick
    end
    object Clear1: TMenuItem
      Caption = '&Clear'
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
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 90
    Top = 98
  end
  object LMDImageList1: TLMDImageList
    Left = 117
    Top = 70
    object TLMDImageListItem
      Description = 'Editor'
      Width = 32
      Internal = {
        2306456469746F7210000000200000000400000000120000002E0A00002A0A00
        00400541424D7612000012760060280040400200001000801E23010004006000
        30020400000200800000003000808000730060C11100B000F08000C0C0C00390
        FF0000003000FFFF0073E25C006000B000F0FF008800148FFF0010F800D40071
        0112FFFFFA1C00B1004201F000E800000C880005538F77778F051900000E8805
        F2FFF8F95200000B8808B70000078804320000048880880013F705F618011388
        7800000A88FF6059F8024213D000000888887700117F01300112000801133310
        777F177100E088870205000011880077771212778F8F777DE88F000005880965
        082106F30804770121084000330F044400E38877F8344E8FF800000188012144
        001188FFFF0A21778800171CF608F2883C16888F05F712050F1103178888F888
        8406F48706F00810F82C1000330010300A0006A187F88880330B208803088740
        00F806F0F87F7F0330000F030888887F877714C07F7F7F1C428F006288880085
        0619888880870700411178031087FF78778808027777780232FFFFF800826954
        800C5504810F0850FFF006008F0E20F70212840F0288884000F7082077888488
        48844888888887F87F87A0D004F18000C0888808888702C21C014F0430F48777
        7753647800808701E04448005000307702F1008080F00050888820FC8FF70333
        888FFF88110121008008A40AF001110541844422108800001088877710117788
        0B0312003308887FB59104D27F120F12010002008712000723744F04D288788F
        00000488000480088088800888888778F78F870551800018A000788800130D32
        88440701048F01000F00F0000082820C107F778777770C13840E80F4888888F7
        0040874E68881200488400A11AD00201000800D000307705C188880715843737
        4F0D00F40530781500120F88800FF80332F7780896887FF8880010744F882402
        788F011488020201A087E5912409010000300FB0120130220003C187F8240F00
        00032410D704240012107F1F3174120F0490003580800F08080710878761CD78
        001005508444407801D1005000E0888801001B748804E09031240F88841320F4
        88FFFFF7F713201207FF7F7F0C00130688000004D08088400004E08788037373
        240212E0780EBAFFF8888701D000353603800620F0090108001B02880C001141
        32180250788F8877780080888801F0008287F8000001880B212EFB031211087F
        887F1B70FF7F1202003604112001E203626C00020001F07F777F0480744F0050
        003078240F0160080F09F9FF808780331078F82410071011000862005000E088
        8833E0610D0700C002B0888FF888240D8000000406A033017702F05542870300
        4824028808D0F701208012010888888701F178897424030F4444099078772420
        880311005000307701408888B4E611F0FF3C11073287041088740C0E04F00300
        888801F200A288110488FFF800920FBFB029F000007F888729F0777740658012
        E133330887F88FFF00104801003324107F01F0821B1C207F888FFF841B108888
        8FFF003020108F02601AA1820A008500F0F008080C4077878778780C4184240B
        841F8044444001F007D200500BF50CC20A0080FFFFF4F000000086F487888887
        F777770070884844480290172077408478008100088880088824107F88877824
        044F48D0AC040001E07800408844488800127701408805000A1108872D66888F
        0080F80C0F02B08004F18800100AF084440080003087277877F803120BFB0010
        020004C18805E02403120112F1FF7F03B8B00C1003120101C05A107F88742000
        441820010088888F888016010E0FFF0FF7F08088887FF82410871850120C8899
        C90104777808601DF30FF002F016B0340180F02404F7770AE02C41FFF7025040
        0F05032380008816028777F8778824021C82FFFF4460A101F0011088880E3888
        8808FFCC0010FF21BD807F3910777788870B0E0610881000007101E003D10000
        1031AA888705E01020880FBF001002007F3F10FF0620806CC088EED26C0109A1
        5B6003120F1210120F8803C01301872400F0085920770CCE878787787E111100
        777807F00040FFF80080010000B088604088005000F00F00FFF080F0120077F8
        8787F7F81811FF80FF2400330087F88887F7780D208888800350B1F700318702
        F0008100000800710F100430480009004012010CF01202D7C9241A0BF0FF0010
        F023910080120F04B20050FFF80050888815D78C8F00F2880BFB12E007007FFF
        05F078FFFF120FA4A02404402082721871744877788809E27778008103910086
        807F2410F020FCF70878F0FF7FF7F87F07100C0006C026B00060003084446800
        4003701206085CF00008447F787F7878777F77913D24034F4835D1F8887802A1
        000803600030330200808023F218A18888872610240137373766008F0FE0F887
        88880E1093310030888801E087772A0123F0CCCF12000A707778870B80FD340C
        0A02C2055002F00422000000888006D2000804C10E507F120FFFFF7B720F1201
        5BF0360235204F05000030780F3600D00035808717000005F87F0887FF770010
        8F3B7011F032110AC00243120CF080800078808880447FF78787870D50240133
        0122D0F7FFFFB04A03520812048833888800000804A2777705E0034AD000369B
        0770780006F07F120F240B88021088740C09120000001007A071A3F804100702
        05D288FFF800830062800722F888F7120E03C09F110030030803D10910092006
        0B000000888000871C9000088706B24AC477030084444F328720B1880010120B
        000008100144770802777878781A1080F00F04444448888735D1774427780300
        80080000608888877F230188881D200112062095850110077001D0072400870D
        00120BFFF777884803CF48043ECC7888120F09D205E002C004A0881300007188
        875A0400D108882236080800817FFF78120400088748020E00031820B4217F3C
        427FFF6C02240F03B1004680887802908008878F0B00886E99870E110EE08800
        10081408204000E0888801B1009180800060F8440A6023F012012AF008D187F8
        8878022380888002108888102A87F887053180000888800800F0770EE07F6C00
        0B106000B0732400FF7F7787FF0B512B0488777777781A9D8888801AE0003008
        03C2884A71887424090000008812000000101137888777250780008800128777
        05005A020812000560111079958802D00030D906029077780050003077780000
        0488001200F8051031A1778F6920051088888402C000308702FC777778880012
        B1F20ED080120013118777804EF00161286003D2092088800111885500871203
        0005C08800407701F177F8800000BB0000779A080D000D110521842B03012103
        811DF0FFFF601115D1870051777DF878018118C0008400E300648408A100C010
        C100000488070010F0000887F78417F00030043024120817B02180403500000C
        880007FF80061088771B67788887008100467800000788073008096107307877
        00D1032100D18F380081888880002000A1120508B088881B0004F23C00800008
        4415880011877778000004888008FFFF800220870BF0F702F0CBAE0000418812
        F1000816F0770010083F000003887802E088001102EF00006388801B00000008
        08D117207F23F100001E88}
    end
  end
  object MainMenu1: TMainMenu
    Left = 89
    Top = 71
    object File1: TMenuItem
      Caption = '&File'
      object mnuLoad: TMenuItem
        Caption = '&Load SLL...'
        OnClick = fileactionClick
      end
      object mnuSave: TMenuItem
        Caption = '&Save SLL...'
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
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
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
  object ini: TLMDIniCtrl
    Target = itRegistry
    Left = 61
    Top = 169
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
    Left = 61
    Top = 200
  end
end
