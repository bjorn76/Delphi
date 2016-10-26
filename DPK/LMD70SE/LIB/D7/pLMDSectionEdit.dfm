object LMDSectionEditorDlg: TLMDSectionEditorDlg
  Left = 525
  Top = 378
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Section-Editor'
  ClientHeight = 237
  ClientWidth = 343
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 6
    Top = 98
    Width = 329
    Height = 7
    Shape = bsTopLine
  end
  object lb: TLMDListBox
    Left = 6
    Top = 6
    Width = 329
    Height = 75
    Bevel.StyleOuter = bvLowered
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridLines = glVertical
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    TabOrder = 0
    OnHeaderSized = sized
  end
  object lb1: TLMDListBox
    Left = 6
    Top = 111
    Width = 240
    Height = 120
    AllowResize = False
    Bevel.StyleOuter = bvLowered
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridLines = glVertical
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    HeaderSections = <
      item
        AllowClick = False
        ImageIndex = -1
        Text = 'Name'
        Width = 90
      end
      item
        AllowClick = False
        ImageIndex = -1
        Text = 'Width (in Pixel)'
        Width = 150
      end>
    TabOrder = 3

  end
  object ok: TButton
    Left = 257
    Top = 111
    Width = 76
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cancel: TButton
    Left = 257
    Top = 138
    Width = 76
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
end
