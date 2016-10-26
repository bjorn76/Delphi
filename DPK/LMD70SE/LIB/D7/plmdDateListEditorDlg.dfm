object LMDDateListEditorDlg: TLMDDateListEditorDlg
  Left = 191
  Top = 67
  ActiveControl = DList
  BorderStyle = bsSingle
  Caption = 'LMD DateListPropertyEditor'
  ClientHeight = 265
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object DList: TLMDListBox
    Left = 8
    Top = 8
    Width = 289
    Height = 225
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    TabOrder = 0
    OnClick = DListClick
    HeaderFont.Charset = ANSI_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Arial'
    HeaderFont.Style = []
    HeaderHeight = 17
    HeaderSections = <
      item
        ImageIndex = -1
        Text = 'Date'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Time'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Description'
        Width = 150
      end>
    ItemHeight = 16
    Sorted = True
    Section = 'Date;Time;Description'
    CtlXP = False
  end
  object OkBtn: TLMDButton
    Left = 320
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = OkBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object CancelBtn: TLMDButton
    Left = 320
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object AddBtn: TLMDButton
    Left = 320
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 3
    OnClick = AddBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object DelBtn: TLMDButton
    Left = 320
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = DelBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object UpBtn: TLMDButton
    Left = 320
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Up'
    TabOrder = 5
    OnClick = UpBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object DnButn: TLMDButton
    Left = 320
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Down'
    TabOrder = 6
    OnClick = DnButnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object DateEdit: TDateTimePicker
    Left = 8
    Top = 240
    Width = 65
    Height = 22
    CalAlignment = dtaLeft
    Date = 36063.5503334375
    Time = 36063.5503334375
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 7
    OnChange = DateEditChange
  end
  object TimeEdit: TDateTimePicker
    Left = 72
    Top = 240
    Width = 65
    Height = 22
    CalAlignment = dtaLeft
    Date = 36063.5504139931
    Time = 36063.5504139931
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 8
    OnChange = TimeEditChange
  end
  object Des: TLMDEdit
    Left = 136
    Top = 240
    Width = 153
    Height = 21
    Bevel.Mode = bmWindows
    Caret.BlinkRate = 530
    CtlXP = False
    TabOrder = 9
    OnTextChangedAt = DesTextChangedAt
    CustomButtons = <>
    PasswordChar = #0
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 304
    Top = 8
  end
end
