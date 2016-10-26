object LMDHideNonVCfrm: TLMDHideNonVCfrm
  Left = 394
  Top = 187
  ActiveControl = cbList
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 296
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002040100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    088ECE0EC808000008FF7080000000000EECEC0EEC0880000F0FF08000000000
    0ECECE0ECEC080000F008080000000000EECEC0EECE088000F88808000000000
    0ECECE0ECECE08000F778080000000000EECEC0EECEC00000F77808000000000
    0ECECEC0CEC080000F7F8080000000000EECECE0ECE000000FF7808000000000
    000ECECECE0800000F7F808000000000B3B0ECECEC0000000FF780800000000F
    0B30CEC0008800000F7F8080000000F770000008880800000FF78080000000F7
    70888887780800000F7F808000000F7708777777780000000FF7808000000F77
    08877777808000080F7F808880000F777088777780800000F7F7F800880000F7
    77087777808880FF77777F88080000F777077777880000F7000077F80880000F
    7777777787880F703B30077F8080000F7777777077770F80B3B007F780800000
    FF77777087770F803B0700FF808000000077777087FF0F870070000F80800000
    00FFF00B0F000F800000000F80800000000000B300000F808000000F80800000
    0000003B08800F808000000FF0000000000003B3B08000F08000000F00000000
    00000B3B308000000000000000000000000000B3B08000000000000000000000
    0000303B30800000000000000000000000003000008000000000000000000000
    000003333000000000000000000000000000000000000000000000000000F000
    F01FF000701FF000701FF000301FF000301FF000701FF000701FF000F01FE000
    F01FE001F01FC000F01F8000F01F8000F01F0001F01F0001E0070001C0038000
    000380000001C0000001C0000001E0000001F0000041F80001C1FC0307C1FF81
    07C3FF0187C7FE01CFCFFE01FFFFFE01FC31FE01FDB6FF03FD86FF87FDB1}
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cbList: TListBox
    Left = 0
    Top = 20
    Width = 237
    Height = 276
    Align = alClient
    ExtendedSelect = False
    ItemHeight = 13
    MultiSelect = True
    PopupMenu = popMenu
    Sorted = True
    TabOrder = 0
    OnKeyUp = cbListKeyUp
    OnMouseUp = cbListMouseDown
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 237
    Top = 20
    Width = 79
    Height = 276
    CtlXP = False
    Align = alRight
    Bevel.Mode = bmCustom
    TabOrder = 1
    object CloseButton: TLMDButton
      Left = 4
      Top = 8
      Width = 72
      Height = 24
      Cancel = True
      Caption = '&Close'
      TabOrder = 0
      OnClick = CloseButtonClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object btHide: TLMDButton
      Left = 4
      Top = 40
      Width = 72
      Height = 24
      Caption = '&Hide'
      TabOrder = 1
      OnClick = btHideClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object btShow: TLMDButton
      Left = 4
      Top = 64
      Width = 72
      Height = 24
      Caption = '&Show'
      TabOrder = 2
      OnClick = btshowClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object btshowall: TLMDButton
      Left = 4
      Top = 120
      Width = 72
      Height = 24
      Caption = 'Show All'
      TabOrder = 3
      OnClick = btshowClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object btHideAll: TLMDButton
      Left = 4
      Top = 96
      Width = 72
      Height = 24
      Caption = 'Hide All'
      TabOrder = 4
      OnClick = btHideClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
    object btDelete: TLMDButton
      Left = 4
      Top = 152
      Width = 72
      Height = 24
      Caption = '&Delete'
      TabOrder = 5
      OnClick = btDeleteClick
      CtlXP = False
      ButtonStyle = ubsWin40
    end
  end
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 316
    Height = 20
    CtlXP = False
    Align = alTop
    Bevel.Mode = bmCustom
    TabOrder = 2
    object lbl: TLabel
      Left = 2
      Top = 4
      Width = 112
      Height = 13
      Caption = '&Nonvisual Components:'
      FocusControl = cbList
    end
    object d: TLabel
      Left = 155
      Top = 4
      Width = 79
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Transparent = True
    end
  end
  object popMenu: TPopupMenu
    OnPopup = popMenuPopup
    Left = 150
    Top = 243
  end
  object fs: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 118
    Top = 243
  end
end
