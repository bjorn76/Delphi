object LMDfrmRegionFromBMPdlg: TLMDfrmRegionFromBMPdlg
  Left = 346
  Top = 198
  BorderStyle = bsDialog
  Caption = 'LMD Region from Bitmap Editor'
  ClientHeight = 441
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object TabbedNotebook1: TPageControl
    Left = 2
    Top = 1
    Width = 536
    Height = 435
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Image && Colors'
      object LoadButton: TLMDSpeedButton
        Left = 306
        Top = 383
        Width = 49
        Height = 22
        Hint = 'Load an image'
        Caption = '&Load'
        ParentShowHint = False
        ShowHint = True
        OnClick = LoadButtonClick
        ImageList = LMDImageList1
        ImageIndex = 2
        NumGlyphs = 2
        ButtonStyle = ubsExplorer
      end
      object DimLabel: TLMDSimpleLabel
        Left = 4
        Top = 383
        Width = 129
        Height = 15
        AutoSize = False
        Caption = 'Bitmap size:'
        Options = []
      end
      object LMDScrollBox1: TLMDScrollBox
        Left = 4
        Top = 12
        Width = 353
        Height = 369
        TabOrder = 0
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 349
          Height = 365
          Cursor = crHandPoint
          Hint = 'Left mouse btn -> select color'#13#10'Right mouse btn -> zoom'
          AutoSize = True
          ParentShowHint = False
          ShowHint = True
          OnMouseDown = Image1MouseDown
          OnMouseMove = Image1MouseMove
        end
      end
      object LMDSimplePanel1: TLMDSimplePanel
        Left = 359
        Top = 12
        Width = 165
        Height = 297
        CtlXP = False
        Bevel.Mode = bmStandard
        TabOrder = 1
        object LMDSimpleLabel1: TLMDSimpleLabel
          Left = 2
          Top = 8
          Width = 117
          Height = 15
          Caption = 'Colors to be transparent:'
          Options = []
        end
        object cc: TLMDSimpleLabel
          Left = 4
          Top = 277
          Width = 156
          Height = 15
          AutoSize = False
          Color = clBtnFace
          ParentColor = False
          Transparent = False
          Caption = 'cc'
          Options = []
        end
        object cl: TListBox
          Left = 1
          Top = 24
          Width = 161
          Height = 249
          Hint = 
            'Colors which will be excluded from the visible region'#13#10'Remove by' +
            ' pressing delete'
          ItemHeight = 16
          ParentShowHint = False
          ShowHint = True
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnKeyDown = clKeyDown
        end
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 360
        Top = 311
        Width = 165
        Height = 93
        CtlXP = False
        Bevel.Mode = bmStandard
        TabOrder = 2
        object zoom: TPaintBox
          Left = 81
          Top = 6
          Width = 80
          Height = 80
          Cursor = crHandPoint
          Hint = 'Left mouse btn -> select color'
          ParentShowHint = False
          ShowHint = True
          OnMouseDown = zoomMouseDown
          OnMouseMove = zoomMouseMove
        end
        object ViewLabel: TLMDSimpleLabel
          Left = 3
          Top = 18
          Width = 65
          Height = 15
          AutoSize = False
          Caption = 'ViewLabel'
          Options = []
        end
        object LMDSimpleLabel4: TLMDSimpleLabel
          Left = 3
          Top = 2
          Width = 32
          Height = 15
          Caption = 'Zoom:'
          Options = []
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Border && Build'
      object BuildButton: TLMDSpeedButton
        Left = 235
        Top = 143
        Width = 49
        Height = 22
        Hint = 'Build region and border bitmap'
        Caption = '&Build'
        ParentShowHint = False
        ShowHint = True
        OnClick = BuildButtonClick
        ImageList = LMDImageList1
        ImageIndex = 6
        NumGlyphs = 2
        ButtonStyle = ubsExplorer
      end
      object Progress: TLMDProgressFill
        Left = 8
        Top = 191
        Width = 509
        Height = 47
        Hint = 'Shows build progress'
        Bevel.StyleOuter = bvLowered
        Bevel.Mode = bmCustom
        FillObject.Style = sfGradient
        OptionsText = toPercent
        ParentShowHint = False
        ShowHint = True
        Visible = False
      end
      object LMDSimplePanel3: TLMDSimplePanel
        Left = 6
        Top = 17
        Width = 513
        Height = 98
        CtlXP = False
        Bevel.Mode = bmStandard
        TabOrder = 0
        object bsLabel: TLMDSimpleLabel
          Left = 7
          Top = 16
          Width = 59
          Height = 15
          Caption = 'BorderStyle:'
          Options = []
        end
        object LMDSimpleLabel3: TLMDSimpleLabel
          Left = 11
          Top = 43
          Width = 56
          Height = 15
          Caption = 'Colordepth:'
          Options = []
        end
        object cb: TLMDComboBox
          Left = 72
          Top = 8
          Width = 145
          Height = 21
          Hint = 'Select a border style'
          Flat = True
          ItemHeight = 13
          Items.Strings = (
            'None'
            'Single'
            'Raised'
            'Lowered'
            'Single-Raised'
            'Single-Lowered')
          ParentShowHint = False
          ShowHint = True
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbChange
        end
        object ccb: TLMDCheckBox
          Left = 71
          Top = 58
          Width = 97
          Height = 17
          CtlXP = False
          Caption = 'Compress image'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          TabOrder = 1
          OnChange = ccbChange
        end
        object colb: TLMDComboBox
          Left = 72
          Top = 34
          Width = 113
          Height = 21
          Flat = True
          ItemHeight = 13
          Items.Strings = (
            'spfDefault'
            'spfMono'
            'spf4bit'
            'spf8bit')
          Style = csDropDownList
          TabOrder = 2
          OnChange = colbChange
        end
        object cb2: TLMDComboBox
          Left = 72
          Top = 8
          Width = 145
          Height = 21
          Hint = 'Select a border style'
          Flat = True
          ItemHeight = 13
          Items.Strings = (
            'Win31'
            'Win40'
            'Simple')
          ParentShowHint = False
          ShowHint = True
          Style = csDropDownList
          TabOrder = 3
          Visible = False
          OnChange = cbChange
        end
      end
    end
  end
  object LMDButton1: TLMDButton
    Left = 545
    Top = 50
    Width = 75
    Height = 23
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = CancelButtonClick
    CtlXP = False
    ImageList = LMDImageList1
    NumGlyphs = 2
  end
  object OKButton: TLMDButton
    Left = 545
    Top = 23
    Width = 75
    Height = 23
    Caption = 'Ok'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = OKButtonClick
    CtlXP = False
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 11
    Top = 7
  end
  object openpic: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 52
    Top = 5
  end
  object LMDImageList1: TLMDImageList
    Left = 93
    Top = 9
    object TLMDImageListItem
      Description = 'LMD Glyphs'
      Width = 32
      Internal = {
        230A4C4D4420476C797068731000000020000000040000000007000000FA0400
        00F6040000400554424D7607000012760060280040E000401000400100788F04
        0060003002040000020080000000300080800073006000B000F004478000C0C0
        C00390FF0000003000FFFF0073006000B0913500F0FF00000000888008880012
        F77F00720056FF0011F800F0CF4004E0003188770012026C0200003244006288
        8877880008C424003100A07F887702DF88F8744002B37F8705D18888F44C05C1
        034005F303108006727700870801FFFF01200000038884F4408148046287F778
        0B0888003088887F7FF87F02D01084FF888001A2088887F800917F7E44080081
        887FCBC70020009100330010300A0001F1024008020000F007730B3F03410804
        884F444800827F777F00080800080B70777FC64800D0047088000801B20EE587
        E40E1387F80C21F8880B4C4603070033080A0002717F88800D83F0878F081109
        50F759008800138F0073006184F41501FFFFF7F777F880800005E08088888000
        87F7F7F7FF88871610000230904C0130777704108788887E442260788804A00C
        307F8824080FB007013088160387F880F44FFF0010F08787DE4811E00261F002
        C00420120400A000000DF377770D21800EEE835506100008877FFF0610110080
        00F0880E408700F08803C0044787E4008877014087FF771B50F80BFB0E131600
        06700A43FF7F80F42671FF070077FF05D07F88F00700700030C441080313A088
        8F740DF177888F0C3280E08888800501C0890DF20D4000088880088815B07F88
        870700887000504870770110777801410FBFB000001101D00F00777780FF4342
        780711F08788780A1107000002808888888700F1882A64888000E0F703E08700
        817F88001000D0000800807FF864A5880DF00220008807F08888031077017088
        700050870B5000E8778FFFF8F7770BFB001002F003B27802E0FFF0C43E120FFF
        0E0003000140070102C08888888704D2888000B08FB106030087008102108880
        00003188888777F800300160881C04000008007113E005008888088080880807
        507F870330F7F87F770FBF001002007F8814F0020080FFF0EC43514007038777
        F88807010E138713E28802B08888801D91A01D05408713F080B0880008888788
        04E009200871800DF218F588888704000250088088070404F00E0014E0080400
        FF14F001E378FFFF80FFFF0E0E10150015101D5088F0000E0A02B0800C070C00
        8000878871788777F7770C10061000007B010800601AD0080000900F07010040
        7FF7FFFF7F878008D2138700088716C2777F07000E110701878777F80E010F60
        0370C75D00D000608808FE006003E10CA1870E00883F0006E001607F0010A841
        0160801C06880E120F0080800E417F77F7F77F020091A302A088800922F888F7
        07010E11F039E178777F07000DF32BC088871AD188070F881510046215100081
        80000888800804E48888877778034370F0036004500FE0887F0D620888610508
        02101541787F80000010EC4000877700108711201421F078880012870CC28880
        FFEE03F0888887F803B09A6C01B28708067101207F0232000002F00040770200
        0E12808F135CF88887060087FF024003228001F0880010154300900EC4C23102
        00008078777888460C807FFF03E30EF08778880012A08614F3884A4087F88800
        080141088877780081026088109100FF88061277FFFF770000068880E4035288
        87870352739988001903B00030888803E822F10231878818000000028887002E
        26FFA004FF038144510083090F01C006F2071001D88702F3888788}
    end
  end
end
