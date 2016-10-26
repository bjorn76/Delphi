object LMDFrmStringEditor: TLMDFrmStringEditor
  Left = 334
  Top = 228
  Width = 517
  Height = 338
  ActiveControl = StrList
  BorderIcons = []
  Caption = 'Stringlist Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TLMDStatusBar
    Left = 0
    Top = 284
    Width = 509
    Height = 20
    ControlGap = 3
    Panels = <>
    Bevel.Mode = bmCustom
    Align = alBottom
    object PosInfo: TLMDGlyphLabel
      Left = 0
      Top = 0
      Width = 120
      Height = 20
      Align = alLeft
      Alignment.Alignment = agCenter
      AutoSize = False
      Bevel.Mode = bmStandard
      Caption = '0:0'
    end
    object LMDInformationLabel1: TLMDInformationLabel
      Left = 169
      Top = 0
      Width = 51
      Height = 20
      Align = alLeft
      Info = itCapsLock
      Font3D.DisabledStyle = ds3d
      InsertTabs = 0
      UseStandardCaption = False
      Bevel.Mode = bmStandard
      DateTimeFormat = 'dd.MM.yy'
      Alignment = agCenter
      Caption = 'Caps:'
      Transparent = False
    end
    object LMDInformationLabel2: TLMDInformationLabel
      Left = 120
      Top = 0
      Width = 49
      Height = 20
      Align = alLeft
      Info = itNumLock
      Font3D.DisabledStyle = ds3d
      InsertTabs = 0
      UseStandardCaption = False
      Bevel.Mode = bmStandard
      DateTimeFormat = 'dd.MM.yy'
      Alignment = agCenter
      Caption = 'Num:'
      Transparent = False
    end
  end
  object StrList: TMemo
    Left = 0
    Top = 34
    Width = 509
    Height = 250
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    WantTabs = True
    WordWrap = False
    OnChange = StrListChange
    OnClick = StrListClick
    OnKeyDown = StrListKeyDown
    OnKeyPress = StrListKeyPress
    OnKeyUp = StrListKeyUp
  end
  object main: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 509
    Height = 34
    CtlXP = False
    Align = alTop
    Bevel.BorderSides = [fsBottom, fsTop]
    Bevel.Mode = bmEdge
    Bevel.StandardStyle = lsFrameInset
    TabOrder = 2
    object LMDButton1: TLMDButton
      Left = 3
      Top = 5
      Width = 49
      Height = 24
      Caption = 'OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = LMDButton1Click
      CtlXP = False
    end
    object btnCancel: TLMDButton
      Left = 57
      Top = 5
      Width = 49
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
      CtlXP = False
    end
    object LMDButton2: TLMDButton
      Left = 111
      Top = 5
      Width = 49
      Height = 24
      Caption = 'Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ModalResult = 6
      ParentFont = False
      TabOrder = 2
      CtlXP = False
    end
    object tools: TLMDSimplePanel
      Left = 165
      Top = 1
      Width = 342
      Height = 30
      CtlXP = False
      Anchors = []
      Bevel.BorderSides = [fsLeft]
      Bevel.Mode = bmEdge
      Bevel.StandardStyle = lsSingleRaised
      TabOrder = 3
      object OpenBtn: TLMDSpeedButton
        Left = 4
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Load from file'
        ParentShowHint = False
        ShowHint = True
        OnClick = OpenBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object SaveBtn: TLMDSpeedButton
        Left = 33
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Save to file'
        ParentShowHint = False
        ShowHint = True
        OnClick = SaveBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 1
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object CopyBtn: TLMDSpeedButton
        Left = 141
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Copy to clipboard'
        ParentShowHint = False
        ShowHint = True
        OnClick = CopyBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 2
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object PasteBtn: TLMDSpeedButton
        Left = 170
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Paste from Clipboard'
        ParentShowHint = False
        ShowHint = True
        OnClick = PasteBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 4
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object CutBtn: TLMDSpeedButton
        Left = 112
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Cut to clipboard'
        ParentShowHint = False
        ShowHint = True
        OnClick = CutBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 3
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object SelectBtn: TLMDSpeedButton
        Left = 204
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Select all'
        ParentShowHint = False
        ShowHint = True
        OnClick = SelectBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 9
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object PrintBtn: TLMDSpeedButton
        Left = 72
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Print'
        ParentShowHint = False
        ShowHint = True
        OnClick = PrintBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 5
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object SearchBtn: TLMDSpeedButton
        Left = 244
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Search for'
        ParentShowHint = False
        ShowHint = True
        OnClick = SearchBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 6
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
      object ReplaceBtn: TLMDSpeedButton
        Left = 273
        Top = 3
        Width = 29
        Height = 26
        Hint = 'Search & Replace'
        ParentShowHint = False
        ShowHint = True
        OnClick = ReplaceBtnClick
        CtlXP = True
        ImageList = LMDImageList2
        ImageIndex = 7
        NumGlyphs = 2
        ButtonStyle = ubsFlat
      end
    end
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 40
    Top = 40
  end
  object OpenDialog: TOpenDialog
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Left = 72
    Top = 40
  end
  object SaveDialog: TSaveDialog
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Left = 104
    Top = 40
  end
  object LMDForm1: TLMDForm
    IniKey = 'frmTLMDStringEditor'
    TrackMinHeight = 300
    TrackMinWidth = 470
    Left = 136
    Top = 40
  end
  object FindDialog: TFindDialog
    OnFind = FindDialogFind
    Left = 168
    Top = 40
  end
  object ReplaceDialog: TReplaceDialog
    OnFind = ReplaceDialogFind
    OnReplace = ReplaceDialogReplace
    Left = 200
    Top = 40
  end
  object PrintDialog: TPrintDialog
    Left = 232
    Top = 40
  end
  object LMDImageList2: TLMDImageList
    Left = 14
    Top = 41
    object Hallo: TLMDImageListItem
      Width = 32
      Internal = {
        21100000002000000004000000000A0000000607000002070000400541424D76
        0A000012760060280040400100001000801E2301000400600030020400000200
        800000003000808000730060C11100B000F08000C0C0C00390FF0000003000FF
        FF0073E25C006000B000F0FF008800148FFF0010F800D400710112FFFFFC1E00
        000A8801BE0410030800E20518FFFFF8888802080640042E01405582050017FF
        FFF555550BD000000888887700117F0210978C01120008011377012101500032
        072288884400D20320F88F2E58F888001144001107B00421778804020801F000
        F17F8880601F0010300050877777F88887777703120051004001200060C10000
        360BD25555544C4C0A42F777775FF5550033B04100103004F006C187F8888033
        061088030887F806002980F87F0A018408028888031006008488488448888806
        828887F87F8701E007B04F0B90F48777777800808746088001B088808001F000
        908787F880F00A01F0008774C7F708E000500160840E228FFF012100F0884448
        0061083004F00000885554C444C4445555555775FF55775F116A550B030A0033
        088808A2880F000A0F840780F40430F79301004087880A00488400A10BD087F8
        880737374F0D200599F4788888780D208700C00030080800C00030787F0A0809
        91FF8FF7F71601444803F01A0178881151884448010180000A054C4334444445
        555575577F55557FF522C00FB00A0130887F06C0880F60140F8884F00000F4D2
        301C0005E0770A08FF7F034103737314020FC078FFF8880000870888888BBB88
        00087F88888FFF887762807F160030E00000870AE0F700408078F7048888180D
        8088877887151002608800161E0254C4C334C4C43300105557F5577FF55577F5
        0BFB14137F887FFFA97200107F0A02001E04777F06010401801C010500888728
        0048A89814028801D0F714040F444406A0787714200A008777886182080A0100
        80787F8F0F14F00E108F7F7777770A10070088888F7088811888771300F8877F
        3231444888A02200127704408854CCC33344440A005557770A005F10440FBFB0
        041000007F8887041077778014F13333905C28008FFF00107F80FFFFF405F0F4
        099023E014008888104C48444805027F7778888814034F4805C000E078788804
        04D200088004D2777887800F000F000410877F3078777F0A010C00F088111118
        03002E3100701E0BCCCCC3008733CCC4C4457F55F70A00557F0BFB0010035002
        9175C588062014030A01770010FF240114030FC0F888FF28414009F318B88877
        780A702801FFFF442BA08800F013A0014088808048008018E2F7F70A0FFE8880
        888118817F8788870060F88778878888888444005000308777F8888810004CC3
        330A0044C57F577777F5F5557F0FBFF66C00100A0212E00620803CC011600887
        08A133608014011C0087F81B618887F71C00048080004000318704F014014444
        44400A0184830D007788800000100808270277787F778800F00030843A4B0607
        FF887028008177F88800300A02141AC41C00C30988C4CCC57F04E0F7FF140103
        E2887FFF011078FFFF80280A0EF00004FFFF4F4887F74C11780C20880008F1A8
        09E1240017411400373737360020F1F810F00F0E80F080808E920B10FFFFF70E
        603C100030880DE077F74520807834318806F081877FF7780470370044141313
        E02B101402333C4C458FC41401777F5530000260073001C107310A0EFFFFF41C
        0187F805A388F7FFFF7702D1080A0449320325C000077040000E00B4081B5088
        08D027000809017787777888806DB288888710407777F70E3100008881880010
        77778887F8F8304088881DE0003088888777F80841CCC33CC4333C0036C4C575
        F7755F777FF57502A0003080073208307F81400A0EF00F0444444806F0780810
        788888888008245E00880011877F1A1088077000C00714000C100A5001F0FFCC
        65001004F087F81520162100088800300FC188770101880A0043C41803508888
        87F8010009D0003000D077FFF70FF05CCC4121CC1E204C5557F5FF0700F7F502
        9108880808008136217FFF550028020028044C00FFFF0F01D187F8887809E190
        810810888002D18887F8870FF003730B00B0731400044FFF7F7787FF2B510F00
        0003227F77280002A000D000307A1B882CC0003101100A001100718887FF7704
        202BF04800F108F00C847888885432003220555732007777F75501A18000F596
        00610C3107E00A02080A00FF00105000FFFF01E2871DD402208850018002F287
        0A02800000BB00000888877777712096FF0610880F0380F002203C21F7080001
        D00030140946010210013015113A0084443C03042001505509D03C33C5555577
        7755753D6577750A020170003607000000100802E00D10777801000801D1E810
        010007D100B0800A0A888880000888001187777888BFC000118003F00D310320
        0B400000068814030A100000018855533CC4C4CC05CE55555557751120550A0E
        00005688280388880D230D610045551C00555C4C09F10A1014205555}
    end
  end
end
