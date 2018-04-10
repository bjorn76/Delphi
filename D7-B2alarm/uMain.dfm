object frmMain: TfrmMain
  Left = 303
  Top = 122
  Width = 368
  Height = 457
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object sbtnBrowser: TSpeedButton
    Left = 184
    Top = 0
    Width = 65
    Height = 25
    Action = ActViewBrowser
    AllowAllUp = True
    GroupIndex = 1
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      010101010101FF00FF010101E73800E73800E73800E73800010101FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF00E0FD0CB8FC010101208B13208B13FB2340FB
      2340FB2340FB2340286B15E73800FF00FFFF00FFFF00FFFF00FFFF00FF00E0FD
      0101015FE81D5DCC41208B13208B13FB2340FB2340FB2340FB2340083316286B
      15FF00FFFF00FFFF00FFFF00FF1485CA0CB8FC0101015DCC415DCC41208B1308
      3316FB2340FB2340083316208B13208B13010101FF00FFFF00FFFF00FFFF00FF
      C8F3E10CB8FC010101208B13010101FB23401485CA00E0FD0CB8FC010101208B
      13083316FF00FFFF00FFFF00FFFF00FF1485CAC8F3E10CB8FC010101010101DC
      D3441485CAC8F3E10CB8FC010101208B13083316FF00FFFF00FFFF00FFFF00FF
      FFFFFF1485CAC8F3E100E0FD010101DCD3441485CA1485CAC8F3E10CB8FC0101
      01286B15FF00FFFF00FFFF00FFFF00FFFFFFFF3F6344C8F3E1C8F3E1010101DC
      D3441485CADCD3441485CAC8F3E10CB8FC286B15FF00FFFF00FFFF00FFFF00FF
      CDABBAFFFFFF286B15208B13DCD344DCD344DCD344DCD344286B151485CAC8F3
      E1010101FF00FFFF00FFFF00FFFF00FFFF00FF286B155FE81D208B13286B15DC
      D344DCD344DCD344208B13FB23401485CA0CB8FCFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFFFFFF5FE81D5DCC41208B13208B13286B15DCD344FB23400CB8
      FC00E0FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5DCC41C8F3E1C8
      F3E15FE81D5DCC41286B151485CA1485CAFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object Panel1: TPanel
    Left = 88
    Top = 40
    Width = 161
    Height = 81
    Caption = 'Panel1'
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 240
    Width = 297
    Height = 145
    Caption = 'Panel3'
    TabOrder = 2
    object gbLog: TGroupBox
      Left = 64
      Top = 16
      Width = 185
      Height = 105
      Caption = 'Log'
      TabOrder = 0
      object Memo1: TMemo
        Left = 12
        Top = 40
        Width = 165
        Height = 49
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object ReadIni: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'ReadIni'
    TabOrder = 3
    Visible = False
    OnClick = ReadIniClick
  end
  object WriteIni: TButton
    Left = 8
    Top = 192
    Width = 75
    Height = 25
    Caption = 'WriteIni'
    TabOrder = 4
    Visible = False
    OnClick = WriteIniClick
  end
  object Panel2: TPanel
    Left = 136
    Top = 96
    Width = 153
    Height = 113
    Caption = 'Panel2'
    TabOrder = 0
    Visible = False
    object gbBrowser: TGroupBox
      Left = 17
      Top = 17
      Width = 112
      Height = 72
      Caption = 'Browser'
      TabOrder = 0
      object WebBrowser1: TWebBrowser
        Left = 24
        Top = 25
        Width = 65
        Height = 32
        TabOrder = 0
        ControlData = {
          4C000000B80600004F0300000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 0
    Top = 0
    Width = 89
    Height = 25
    Action = actSendAlarm
    Caption = 'Send Alarm'
    TabOrder = 5
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCD
      ABBA508D51FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFE4C8E3FFFFFFCDABBACDABBA508D51FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFFFFFCDABBACD
      ABBA508D51763B40FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFCDABBACDABBAE4C8E3508D51FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE4C8E3E8FFCCDC
      D344D8BC1A803448FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFE8FFCCDCD344DCD344DCD344DCD344FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF46E2E1FF00FFFF00FFE8FFCCE8FFCCE8
      FFCCDCD344DCD344FF00FFFF00FFFF00FF46E2E1FF00FFFF00FFFF00FF18B6FC
      FF00FFFF00FF46E2E1FFFFFFFFFFFFE8FFCCDCD344DCD3448CA5CAFF00FFFF00
      FF18B6FCFF00FFFF00FF46E2E146E2E1FF00FF18B6FCFF00FFC8F3E1C8F3E1E8
      FFCCE4C8E3C8F3E1E4C8E32BBAFCFF00FFFF00FF36E2E1FF00FF36E2E1FF00FF
      FF00FF46E2E1FF00FF46E2E1FF00FFFF00FFFF00FF36E2E1FF00FFFF00FFFF00
      FFFF00FF36E2E1FF00FF36E2E1FF00FFFF00FF46E2E1FF00FF36E2E1FF00FFFF
      FFFFFF00FF36E2E1FF00FFFF00FFA8F6CCFF00FF36E2E1FF00FF36E2E1A8F6CC
      FF00FF36E2E1FF00FFB1B9FCFF00FFFF00FFFF00FF18B6FCFF00FF46E2E1FF00
      FFFF00FF36E2E1FF00FFFF00FF18B6FCFF00FF2BBAFCFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF2BBAFCFF00FF2BBAFC46E2E1FF00FFFF00FF2BBAFC
      FF00FFFF00FF2BBAFCFF00FFFF00FFFF00FFFF00FFFF00FF46E2E1FF00FFFF00
      FF18B6FCFF00FFFF00FFFF00FFFF00FF46E2E1FF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FF2BBAFCFF00FFFF00FFFF00FF}
  end
  object BitBtn2: TBitBtn
    Left = 88
    Top = 0
    Width = 89
    Height = 25
    Action = actReset
    Caption = 'Reset'
    TabOrder = 6
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF808080808080808080FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80808080808000000000
      0000000000808080808080808080808080FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF0000000080000080000080000080000080000080000080000000008080
      80808080FF00FFFF00FFFF00FFFF00FF00000000800000800000800000800000
      8000008000008000008000008000000000808080808080FF00FFFF00FF000000
      0080000080000080000080000080000080000080000080000080000080000080
      00000000808080FF00FFFF00FF008000008000008000008000008000C0C0C0FF
      FFFF008000008000008000008000008000008000808080FF00FFFF00FF008000
      008000008000008000C0C0C0FFFFFFFFFFFFFFFFFF0080000080000080000080
      00008000808080808080000000008000008000008000C0C0C0FFFFFFC0C0C0FF
      FFFFFFFFFF008000008000008000008000008000000000808080000000008000
      008000008000008000008000008000008000FFFFFFFFFFFF0080000080000080
      0000800000000080808000000000800000800000800000800000800000800000
      8000FFFFFFFFFFFF008000008000008000008000000000FF00FFFF00FF008000
      008000008000008000008000008000008000008000FFFFFFFFFFFF0080000080
      00008000808080FF00FFFF00FF00800000800000800000800000800000800000
      8000008000FFFFFFFFFFFF008000008000008000808080FF00FFFF00FF000000
      0080000080000080000080000080000080000080000080000080000080000080
      00000000FF00FFFF00FFFF00FFFF00FF00000000800000800000800000800000
      8000008000008000008000008000000000FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF000000008000008000008000008000008000008000008000000000FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000
      0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object BitBtn4: TBitBtn
    Left = 248
    Top = 0
    Width = 65
    Height = 25
    Action = actAbout
    Caption = 'About'
    TabOrder = 7
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFF00
      FFFF00FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00000000FFFF00FFFF00FFFF00FFFF000000FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF00
      FFFF00FFFF000000000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00000000FFFF00FFFF00FFFF000000000000808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFF00
      FFFF00FFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00000000FFFF00FFFF00FFFF000000000000808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF00
      FFFF00FFFF00FFFF000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      000000000000000000FFFFFFFFFFFF00FFFF00FFFF00FFFF00FFFF0000008080
      80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF00FFFF00FFFFFFFFFFFFFFFFFF
      FFFF00FFFF00FFFF00FFFF000000000000808080FFFFFFFFFFFFFFFFFFFFFFFF
      00FFFF00FFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF00FFFF00FFFF00000000FF
      FF808080FFFFFFFFFFFFFFFFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00000000
      FFFF00FFFF00FFFF00FFFF00000000FFFF808080FFFFFFFFFFFFFFFFFFFFFFFF
      00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF000000808080FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF00000000000000000000000000000000FFFF00FFFF00FFFF8080
      80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFF00
      FFFF00FFFF00FFFF000000808080FFFFFFFFFFFFFFFFFFFFFFFF}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 8
    Top = 64
    object actSendAlarm: TAction
      Caption = 'Send Alarm'
      ImageIndex = 0
      ShortCut = 16467
      OnExecute = actSendAlarmExecute
    end
    object actReset: TAction
      Caption = 'Reset'
      Hint = 'Ctrl+R'
      ImageIndex = 1
      ShortCut = 16466
      OnExecute = actResetExecute
    end
    object ActViewBrowser: TAction
      Caption = 'Browser'
      GroupIndex = 1
      ImageIndex = 2
      OnExecute = ActViewBrowserExecute
    end
    object actAbout: TAction
      Caption = 'About'
      ImageIndex = 3
      OnExecute = actAboutExecute
    end
  end
  object btBeeper1: TbtBeeper
    Left = 8
    Top = 128
  end
  object tmrAlarm: TTimer
    Enabled = False
    OnTimer = tmrAlarmTimer
    Left = 8
    Top = 96
  end
  object ImageList1: TImageList
    Left = 8
    Top = 32
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00C0C0C00080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00C0C0C0000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C00080000000FF00000000000000C0C0C000FF00FF0000008000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FF00FF0000000000FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C00080000000FFFF000000000000C0C0C000FFFFFF000000FF00C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00808080000000000000000000000000008080800000FF00000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000000000000080800000FFFF0000FF
      FF0000FFFF0000FFFF00C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FF
      FF00000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000080808000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00C0C0C000C0C0C0008080
      80000000000080808000C0C0C00080808000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C0000000000000000000000000000080800000FF
      FF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000008080
      800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000008080
      800000000000FFFF00000000000000000000FFFFFF00C0C0C000C0C0C000FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FFFF008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000808080000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000FFFFFF00C0C0C000C0C0C0008080
      8000C0C0C00080808000808080008080800080808000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000080
      800000FFFF0000FFFF00000000000000000000FFFF0000FFFF00000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000C0C0C000C0C0C000FFFFFF00C0C0C00080808000C0C0C000C0C0C0000000
      000000000000FFFFFF000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF0080808000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000FFFF0000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000FFFFFF00C0C0C00080808000C0C0C000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000080800000FFFF0000FFFF0000FFFF0000FFFF0000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00C0C0C0008080800000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000FFFF0000FFFF000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000CDABBA00508D510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000E4C8E300FFFFFF00CDABBA00CDABBA00508D5100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000008000000080000000800000008000000000
      0000808080008080800000000000000000000000000000000000010101000101
      01000000000001010100E7380000E7380000E7380000E7380000010101000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FFFFFF00CDABBA00CDABBA00508D5100763B4000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000000000008080800080808000000000000000000000E0FD000CB8FC000101
      0100208B1300208B1300FB234000FB234000FB234000FB234000286B1500E738
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000CDABBA00CDABBA00E4C8E300508D5100000000000000
      0000000000000000000000000000000000000000000000000000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000000000080808000000000000000000000E0FD00010101005FE8
      1D005DCC4100208B1300208B1300FB234000FB234000FB234000FB2340000833
      1600286B1500000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000E4C8E300E8FFCC00DCD34400D8BC1A0080344800000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      00000080000000800000C0C0C000FFFFFF000080000000800000008000000080
      000000800000008000008080800000000000000000001485CA000CB8FC000101
      01005DCC41005DCC4100208B130008331600FB234000FB23400008331600208B
      1300208B1300010101000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000E8FFCC00DCD34400DCD34400DCD34400DCD34400000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      000000800000C0C0C000FFFFFF00FFFFFF00FFFFFF0000800000008000000080
      0000008000000080000080808000808080000000000000000000C8F3E1000CB8
      FC0001010100208B130001010100FB2340001485CA0000E0FD000CB8FC000101
      0100208B1300083316000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000046E2E1000000
      000000000000E8FFCC00E8FFCC00E8FFCC00DCD34400DCD34400000000000000
      00000000000046E2E10000000000000000000000000000800000008000000080
      0000C0C0C000FFFFFF00C0C0C000FFFFFF00FFFFFF0000800000008000000080
      00000080000000800000000000008080800000000000000000001485CA00C8F3
      E1000CB8FC000101010001010100DCD344001485CA00C8F3E1000CB8FC000101
      0100208B1300083316000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000018B6FC00000000000000
      000046E2E100FFFFFF00FFFFFF00E8FFCC00DCD34400DCD344008CA5CA000000
      00000000000018B6FC0000000000000000000000000000800000008000000080
      000000800000008000000080000000800000FFFFFF00FFFFFF00008000000080
      0000008000000080000000000000808080000000000000000000FFFFFF001485
      CA00C8F3E10000E0FD0001010100DCD344001485CA001485CA00C8F3E1000CB8
      FC0001010100286B15000000000000000000FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF0046E2E10046E2E1000000000018B6
      FC0000000000C8F3E100C8F3E100E8FFCC00E4C8E300C8F3E100E4C8E3002BBA
      FC00000000000000000036E2E100000000000000000000800000008000000080
      000000800000008000000080000000800000FFFFFF00FFFFFF00008000000080
      0000008000000080000000000000000000000000000000000000FFFFFF003F63
      4400C8F3E100C8F3E10001010100DCD344001485CA00DCD344001485CA00C8F3
      E1000CB8FC00286B15000000000000000000FFFFFF00FFFFFF0000FFFF0000FF
      FF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF000000
      00000000000080808000FFFFFF00FFFFFF0036E2E100000000000000000046E2
      E1000000000046E2E10000000000000000000000000036E2E100000000000000
      0000000000000000000036E2E100000000000000000000800000008000000080
      00000080000000800000008000000080000000800000FFFFFF00FFFFFF000080
      0000008000000080000080808000000000000000000000000000CDABBA00FFFF
      FF00286B1500208B1300DCD34400DCD34400DCD34400DCD34400286B15001485
      CA00C8F3E100010101000000000000000000FFFFFF00FFFFFF0000FFFF0000FF
      FF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF000000
      000000FFFF0080808000FFFFFF00FFFFFF0036E2E100000000000000000046E2
      E1000000000036E2E10000000000FFFFFF000000000036E2E100000000000000
      0000A8F6CC000000000036E2E100000000000000000000800000008000000080
      00000080000000800000008000000080000000800000FFFFFF00FFFFFF000080
      000000800000008000008080800000000000000000000000000000000000286B
      15005FE81D00208B1300286B1500DCD34400DCD34400DCD34400208B1300FB23
      40001485CA000CB8FC000000000000000000FFFFFF00FFFFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF000000
      000000FFFF0080808000FFFFFF00FFFFFF0036E2E100A8F6CC000000000036E2
      E10000000000B1B9FC0000000000000000000000000018B6FC000000000046E2
      E100000000000000000036E2E100000000000000000000000000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000000000000000000000000000000000000000000000000000000
      0000FFFFFF005FE81D005DCC4100208B1300208B1300286B1500DCD34400FB23
      40000CB8FC0000E0FD000000000000000000FFFFFF00FFFFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0080808000FFFFFF00FFFFFF000000000018B6FC00000000002BBA
      FC00000000000000000000000000000000000000000000000000000000002BBA
      FC00000000002BBAFC0046E2E100000000000000000000000000000000000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005DCC4100C8F3E100C8F3E1005FE81D005DCC4100286B15001485
      CA001485CA00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000080808000FFFFFF00FFFFFF00000000002BBAFC00000000000000
      00002BBAFC00000000000000000000000000000000000000000046E2E1000000
      00000000000018B6FC0000000000000000000000000000000000000000000000
      0000008000000080000000800000008000000080000000800000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0080808000FFFFFF00FFFFFF00FFFFFF00000000000000000046E2E1000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002BBAFC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000FFFF0000FFFF0000FFFF0000FFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFC0010000FEFFFFFF80000000
      FEFF000100000000F45F000000010000E00F000000010000C007000080030000
      A00B00008003000080030000C007000000010000C007000080030000E00F0000
      80030000E00F000080030000F01F0000C0070000F01F0000E00F0001F83F0000
      EC6F81FFF83F0000FC7FC3FFFCFF0000FFFFFE3FFFFF0000FE7FF007FFFF0000
      F83FE003C81F0000F83FC001800F0000FC3F800180070000F83F800180030000
      F83F8000C0030000D83B0000C0030000B01B0000C0030000280D0001C0030000
      6BBD8001C00300006AB58001E00300002BAD8003F0030000AFE9C007F8070000
      B7DBE00FFFFF0000DFF7FC7FFFFF000000000000000000000000000000000000
      000000000000}
  end
end