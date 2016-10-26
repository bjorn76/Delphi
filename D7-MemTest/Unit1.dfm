object Form1: TForm1
  Left = 445
  Top = 225
  Width = 525
  Height = 269
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 154
    Top = 184
    Width = 33
    Height = 13
    Caption = 'Used%'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 212
    Width = 509
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 509
    Height = 212
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'View'
      object Bevel1: TBevel
        Left = 59
        Top = 33
        Width = 438
        Height = 96
      end
      object lblMemoryLoaded: TLabel
        Left = 88
        Top = 168
        Width = 83
        Height = 13
        Caption = 'lblMemoryLoaded'
      end
      object lblMemPageFree: TLabel
        Left = 379
        Top = 49
        Width = 79
        Height = 13
        Caption = 'lblMemPageFree'
      end
      object lblMemPageTotal: TLabel
        Left = 291
        Top = 49
        Width = 82
        Height = 13
        Caption = 'lblMemPageTotal'
      end
      object lblMemPagePercentUsed: TLabel
        Left = 152
        Top = 48
        Width = 33
        Height = 13
        Caption = 'Used%'
      end
      object lblMemPageUsed: TLabel
        Left = 187
        Top = 49
        Width = 83
        Height = 13
        Caption = 'lblMemPageUsed'
      end
      object pbMemPagePercentUsed: TLMDProgress
        Left = 67
        Top = 41
        Width = 75
        Height = 20
        Bevel.StyleOuter = bvLowered
        Bevel.Mode = bmCustom
      end
      object pbMemPhysPercentUsed: TLMDProgress
        Left = 67
        Top = 73
        Width = 75
        Height = 20
        Bevel.StyleOuter = bvLowered
        Bevel.Mode = bmCustom
      end
      object lblMemPhysFree: TLabel
        Left = 379
        Top = 81
        Width = 77
        Height = 13
        Caption = 'lblMemPhysFree'
      end
      object lblMemPhysTotal: TLabel
        Left = 291
        Top = 81
        Width = 80
        Height = 13
        Caption = 'lblMemPhysTotal'
      end
      object lblMemPhysUsed: TLabel
        Left = 187
        Top = 81
        Width = 81
        Height = 13
        Caption = 'lblMemPhysUsed'
      end
      object lblMemPhysPercentUsed: TLabel
        Left = 152
        Top = 80
        Width = 33
        Height = 13
        Caption = 'Used%'
      end
      object lblMemVirtFree: TLabel
        Left = 72
        Top = 145
        Width = 69
        Height = 13
        Caption = 'lblMemVirtFree'
      end
      object lblMemVirtTotal: TLabel
        Left = 232
        Top = 145
        Width = 72
        Height = 13
        Caption = 'lblMemVirtTotal'
      end
      object lblMemVirtExtended: TLabel
        Left = 416
        Top = 145
        Width = 93
        Height = 13
        Caption = 'lblMemVirtExtended'
      end
      object BtnUpdateSysinfo: TButton
        Left = 232
        Top = 160
        Width = 129
        Height = 25
        Caption = 'BtnUpdateSysinfo'
        TabOrder = 0
        Visible = False
        OnClick = BtnUpdateSysinfoClick
      end
      object StaticText1: TStaticText
        Left = 0
        Top = 41
        Width = 52
        Height = 17
        Caption = 'MemPage'
        TabOrder = 1
      end
      object StaticText2: TStaticText
        Left = 379
        Top = 9
        Width = 25
        Height = 17
        Caption = 'Free'
        TabOrder = 2
      end
      object StaticText3: TStaticText
        Left = 322
        Top = 145
        Width = 90
        Height = 17
        Caption = 'MemVirtExtended:'
        TabOrder = 3
      end
      object StaticText4: TStaticText
        Left = 69
        Top = 9
        Width = 91
        Height = 17
        Caption = 'Per Cent (%) used:'
        TabOrder = 4
      end
      object StaticText5: TStaticText
        Left = 187
        Top = 9
        Width = 29
        Height = 17
        Caption = 'Used'
        TabOrder = 5
      end
      object cbAutoUpdateSysInfo: TLMDCheckBox
        Left = 392
        Top = 168
        Width = 105
        Height = 17
        Caption = 'cbAutoUpdateSysInfo'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        TabOrder = 6
        Visible = False
        Checked = True
        State = cbChecked
      end
      object StaticText6: TStaticText
        Left = 0
        Top = 81
        Width = 50
        Height = 17
        Caption = 'MemPhys'
        TabOrder = 7
      end
      object StaticText7: TStaticText
        Left = 0
        Top = 145
        Width = 66
        Height = 17
        Caption = 'MemVirtFree:'
        TabOrder = 8
      end
      object cbUseMB: TCheckBox
        Left = 64
        Top = 104
        Width = 121
        Height = 17
        Caption = 'Scale to Mega Byte'
        TabOrder = 9
      end
      object StaticText10: TStaticText
        Left = 293
        Top = 9
        Width = 28
        Height = 17
        Caption = 'Total'
        TabOrder = 10
      end
      object StaticText11: TStaticText
        Left = 2
        Top = 169
        Width = 83
        Height = 17
        Caption = 'Memory Loaded:'
        TabOrder = 11
      end
      object StaticText12: TStaticText
        Left = 160
        Top = 145
        Width = 69
        Height = 17
        Caption = 'MemVirtTotal:'
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      object MemoMemPageLog: TMemo
        Left = 0
        Top = 41
        Width = 501
        Height = 143
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 501
        Height = 41
        Align = alTop
        TabOrder = 1
        object LMDSpinEdit1: TLMDSpinEdit
          Left = 120
          Top = 10
          Width = 81
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          TabOrder = 0
          OnChange = LMDSpinEdit1Change
          AutoSelect = True
          CustomButtons = <>
          SpinBtnDiag = False
          Suffix = 's'
          MinValue = 1
          MaxValue = 3600
          Value = 3600
          DateTime = 0.000000000000000000
        end
        object btnManualLog: TButton
          Left = 216
          Top = 8
          Width = 81
          Height = 25
          Caption = 'Manual Log'
          TabOrder = 1
          OnClick = TimerLogTimer
        end
        object cbLogMempage: TLMDCheckBox
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = 'Auto Log every'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          TabOrder = 2
          Checked = True
          State = cbChecked
        end
        object btnClearLog: TButton
          Left = 312
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Clear Log'
          TabOrder = 3
          OnClick = btnClearLogClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Alloc'
      ImageIndex = 2
      object Label2: TLabel
        Left = 192
        Top = 61
        Width = 111
        Height = 20
        Caption = 'Alloc counter:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIndex: TLabel
        Left = 304
        Top = 61
        Width = 17
        Height = 20
        Caption = '-1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 72
        Top = 32
        Width = 369
        Height = 137
      end
      object Button1: TButton
        Left = 104
        Top = 56
        Width = 73
        Height = 25
        Caption = 'GetMem'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 336
        Top = 56
        Width = 75
        Height = 25
        Caption = 'FreeMem'
        TabOrder = 1
        OnClick = Button2Click
      end
      object btnGetMem2: TButton
        Left = 104
        Top = 112
        Width = 73
        Height = 25
        Caption = 'GetMem2'
        TabOrder = 2
        OnClick = btnGetMem2Click
      end
      object Button3: TButton
        Left = 336
        Top = 112
        Width = 73
        Height = 25
        Caption = 'FreeMem2'
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Heap Status'
      ImageIndex = 4
      object Memo1: TMemo
        Left = 0
        Top = 41
        Width = 501
        Height = 143
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 501
        Height = 41
        Align = alTop
        TabOrder = 1
        object lblHeader: TCheckBox
          Left = 16
          Top = 16
          Width = 57
          Height = 17
          Caption = 'Header'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = lblHeaderClick
        end
        object btnGetHeapStatus: TButton
          Left = 104
          Top = 8
          Width = 113
          Height = 25
          Caption = 'GetHeapStatus'
          TabOrder = 1
          OnClick = btnGetHeapStatusClick
        end
      end
    end
  end
  object LMDSysInfo1: TLMDSysInfo
    Left = 368
  end
  object TimerLblupdate: TTimer
    OnTimer = TimerLblupdateTimer
    Left = 292
    Top = 1
  end
  object TimerLog: TTimer
    Interval = 3600000
    OnTimer = TimerLogTimer
    Left = 328
  end
end
