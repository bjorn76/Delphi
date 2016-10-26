object LMDWaveListEditorDlg: TLMDWaveListEditorDlg
  Left = 257
  Top = 274
  Width = 384
  Height = 383
  ActiveControl = lb
  BorderIcons = [biSystemMenu]
  Caption = 'WaveList-Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lb: TLMDListBox
    Left = 46
    Top = 37
    Width = 330
    Height = 292
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
    Bevel.StyleOuter = bvLowered
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
        Text = 'Size'
        Width = 57
      end
      item
        ImageIndex = -1
        Text = 'ID'
        Width = 39
      end
      item
        ImageIndex = -1
        Text = 'C.'
        Width = 19
      end
      item
        ImageIndex = -1
        Text = 'Description'
        Width = 181
      end>
    ItemHeight = 14
    Style = lbOwnerDrawFixed
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 376
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
    TabOrder = 1
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
  object LMDSimplePanel3: TLMDSimplePanel
    Left = 0
    Top = 37
    Width = 46
    Height = 292
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
      Left = 7
      Top = 191
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
    object play: TLMDSpeedButton
      Left = 6
      Top = 246
      Width = 29
      Height = 26
      Hint = 'Properties'
      OnClick = PopupClick
      ButtonLayout.AlignText2Glyph = taBottom
      ButtonLayout.Spacing = 0
      ImageList = LMDImageList1
      ImageIndex = 18
      NumGlyphs = 2
      ButtonStyle = ubsFlat
    end
  end
  object FileDialog: TOpenDialog
    DefaultExt = 'wvl'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 51
    Top = 120
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 79
    Top = 64
  end
  object fm: TLMDFMDrop
    OnFMDragDrop = fmFMDragDrop
    Left = 79
    Top = 120
  end
  object pop: TPopupMenu
    OnPopup = PopupClick
    Left = 79
    Top = 92
    object Play1: TMenuItem
      Caption = '&Play'
      OnClick = PopupClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
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
    Left = 51
    Top = 92
  end
  object LMDImageList1: TLMDImageList
    Left = 51
    Top = 64
    object TLMDImageListItem
      Description = 'Editor'
      Width = 32
      Internal = {
        2306456469746F721000000020000000040000000013000000970A0000930A00
        00400541424D7613000012760060280040600200001000801E23010004006000
        30020400000200800000003000808000730060C11100B000F08000C0C0C00390
        FF0000003000FFFF0073E25C006000B000F0FF008800148FFF0010F800D40071
        0112FFFFFA1C00B1004201F000E800000C880005538F77778F051900000E8805
        F2FFF8F95200000B8808B70000078804320000048880880013F705F618011388
        7800000A88FF6059F80000058814D000000888887700117F0470011200080113
        3310777F187100E088870205000011880077771312778F8F777DE88F00000588
        0A65092106F308047701210840003310044400E38877F8344E8FF80000018801
        2144001188FFFF0A21778800171DF608F2883C17888F05F713050F1103178888
        F8888406F48706F0081006018B0402198800330010300B0001A187F88880330C
        20880310000887F807F0F87F7F0330000F030888887F053087777F7F7F1E428F
        006288880085050A8880870720880078031087FF78778809027777780232FFFF
        F8B4AA0082800D5504810F0950FFF006008F0F20F7021284100288200088F708
        207788848848844888888887F87F50688704F18000C0888808888702C21D014F
        0430F4877729B2777800808701E04448005000307702F1008080F0005088107E
        888FF70333888FFF88110121008008A40AF0011105418411A444880000108887
        77101102018F01B2888800830B0385AC13003308887F05D27F130F1301000200
        8713000823744FB800042378042300D3006680088088800888888778F720C58F
        870551800000788800130E3288440701048F010004140F00F000000D107F7787
        77770D13840F80F48812738888F7004087881300488400A11BD00201000800D0
        003040AC7705C188880737374F0E00F40530781600130F888020440FF80332F7
        78887FF8880010744F882602788FB74C011488020201A0872609010000328403
        52888801D001000FB0B23A1301302400017187F8260F0000032610260013107F
        213174E08C130F0490003580800F0808081087877800100550844439F2407801
        D1005000E0888801001B71013104E0260F88841420F4062488FFFFF7F7142013
        07FF7F7F0B31000003A08088C183430004E08788037373260213E078FFF88887
        01D00035AE903903800620F0090108001C02880C0011180250788F88774C9178
        0080888801F0008287F800000388844F01C288877F008110970BFB031311087F
        887F1D70FF7F1302003904122001E232B00300020001F07F7703417404147826
        0F0520080FFF8027E58780361078F82610081012000962005000E0888836E007
        00C0843502B0888FF888260D8000000406A036017702F0870300556848260288
        08D0F70120801301081EF001F17826030F4444974B0990787726208803110050
        0030770140888812F0FF3F1107324FC287041088740C0E04F00300054001F100
        A28888FFF800948450824400A3870711880FBFB02CF000007F88872CF0772032
        778013E133330887F88FFF00104C01003326107FC10D01F01E207F888FFF841D
        1088888FFF003022108F0260C1051CA1008500F0F008080D4077878778780631
        84260B0DC08444444001F008D4880CF50DC20CF080FFFFF4F000004200F48788
        8887F7777700708848444802E27F20427778008100088880088826107F888778
        26044F685648040001E07800408844488800127701408805000A110816A08788
        8F0080F80C0F02B08004F188001077F8888444F0A70080003011E00312888884
        4416038705020BFB0010030005C178B88806E02603130113F1FF7F030D100313
        0101C05F107F8874E10022000421010088888F88010E0FFF0FF7F08088882E99
        7FF826108719B0130C08004003C1777809601FF30FF002F0C92C17B0370180F0
        2604F7770BE0FFF7025040100503238000411C8817028777F877882602FFFF44
        65A101F00110888882210F38888808FFCC0010FF807F3C10777788870B0EBD39
        0610881000007101E003D1000010888705E0102001708444261362AB87091126
        00BFBFBF03007F4310FF07208072C08872010AA1B189606003130F13104F8888
        02C0130F8F88872600F0085E200667778787877885111300777807800040FFF8
        0080010000B0C080041200F00F00FFF080F0130077F88787F7F8FF302380FF26
        00360087F88887F7780E208888800350003163EF8702F0008100000800711010
        04804C0009004013010DF01302261ACF930BF02580FFF025910090130F04B200
        50FFF80050888816D700F284010050844444480070888777777888880BFB14E0
        91F008007FFF06F078FFFF130FADA0260444201A71744877784E44880AE27778
        008103910086807F2610F0F7087FF0FF7F0783F7F87F88840CF02E4128B00761
        88888444400370130640040861F00008447F787F7878777F7726034F4889D138
        D1F8887802A100080393310200B08025F288888728108A1926013737376B008F
        10E0F88788880F100030888801E0331F87772C0125F0CCCF13000A707778870B
        800C0A02C2055002F0C84904220000028884440BF18888877704F0888007D200
        0805C1A3DB0F507F130FFFFF0F130160F0390238204F0600003078103600D090
        2F003580871800007F0887FF7700108F3E7013001A0106D1A000025284130BF0
        8080808880447FF78787878838B087772601360124D0F7FFFF03520813048F33
        888800004A36080492777705E0034ED00007707E0006F07F130F260B889B7102
        1088740C09130000001007A0F80410070205D288FFF800830428888444488800
        11877778880015800822F888F7E7C4130E04C00030030804D10A100A20070B00
        0000888000871E90000855888707B2770300841A038706E5130B000008110144
        777710047878781B1080F00F04444448888738D17778013A8888888008008800
        11877F250101004C068801100756147001C0072600870E00130BFFF777884C03
        CF4C047888FE0F130F23D31300048000301400006088888777F8270401270192
        00500846088808080070887FFF7813040008874C020F0003C7881A20BE217F7F
        FF7202260F03B1004680887802908008874DC18F0C0088870F110FE08800100B
        D0006088888444400082CFC201B10091808000600B6025F013012CF008D187F8
        8878022380208188800210888887F887053180000888800800F05083770FE07F
        72000B00B0732600FF7F7787FF0B512D0400548877777778888880FF00120803
        C2884E718874E88A26090000008811E0000010888777270584488800128704E0
        889EFE001280000072024006005F020813000681303003D00030E50602A07765
        4A7800500030777800000488001300F80510778F6F2077027088443584005188
        888702FC7777788800120FD08013008800F0F95A390203D002E038D409208880
        02728713030001F100407705C177001EF8800000BB0000088887770E11043019
        0004D18829A488870222881EF0FFFF651116D1870051777805028877539C7800
        0003888403D3888705F102820BF4888700000588080011F000087BC28719F000
        30053026120819B023801400000011880007FF800691775B3D78063C78000007
        880730080A610730787700D103E100D100818812E0B38404F288130508B08888
        1C0004F23F008000088800118777415C78000004888008FFFF800220870BF0F7
        02F00000518813F10008BAE132B0770010093F000003887802E088001102EF00
        0063888000000808D1B00018207F25F100002E88}
    end
  end
  object MainMenu1: TMainMenu
    Left = 107
    Top = 64
    object File1: TMenuItem
      Caption = '&File'
      object mnuLoad: TMenuItem
        Caption = '&Load WVL...'
        OnClick = fileactionClick
      end
      object mnuSave: TMenuItem
        Caption = '&Save WVL...'
        OnClick = fileactionClick
      end
      object MenuItem1: TMenuItem
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
  object ini: TLMDIniCtrl
    Target = itRegistry
    Left = 55
    Top = 181
  end
end
