object LMDButtonFaceDlg: TLMDButtonFaceDlg
  Left = 553
  Top = 145
  Width = 398
  Height = 390
  BorderIcons = [biSystemMenu]
  Caption = 'ButtonFace-Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 306
    Top = 211
    Width = 65
    Height = 74
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Anchors = [akTop, akRight]
    Caption = #39'Clearing'#39' a state resets to first image of connected imagelist.'
    Options = []
  end
  object SelectBtn: TLMDButton
    Left = 304
    Top = 130
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Select Picture'
    TabOrder = 2
    OnClick = SelectBtnClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object OKButton: TLMDButton
    Left = 304
    Top = 4
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object CancelButton: TLMDButton
    Left = 304
    Top = 30
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object lb: TLMDListBox
    Left = 5
    Top = 4
    Width = 290
    Height = 348
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ShowHint = True
    TabOrder = 5
    OnDblClick = SelectBtnClick
    OnResize = lbResize
    Bevel.Mode = bmStandard
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clBlack
    HeaderFont.Height = -11
    HeaderFont.Name = 'Arial'
    HeaderFont.Style = []
    HeaderHeight = 21
    HeaderSections = <
      item
        ImageIndex = -1
        Text = 'State'
        Width = 109
      end
      item
        ImageIndex = -1
        Text = 'Picture'
        Width = 178
      end>
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    OnDrawItem = lbDrawItem
  end
  object nopicture: TLMDButton
    Left = 304
    Top = 156
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Clear Picture'
    TabOrder = 3
    OnClick = nopictureClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object ClearAll: TLMDButton
    Left = 304
    Top = 183
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Clear All'
    TabOrder = 4
    OnClick = ClearAllClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object sync: TLMDButton
    Left = 304
    Top = 304
    Width = 80
    Height = 22
    Hint = 
      'Synch bsUp/bsDown ListIndex with other button states.'#13#10'Use this ' +
      'feature if only bsUp/bsDown Images are available.'
    Anchors = [akTop, akRight]
    Caption = 'Sync Normal'
    TabOrder = 6
    OnClick = syncClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object synchot: TLMDButton
    Left = 304
    Top = 331
    Width = 80
    Height = 22
    Hint = 
      'Synch bsUp/bsDown/bsMouseOver ListIndex with other button states' +
      '.'#13#10'Use this feature if only bsUp/bsDown/bsMouseOver Images are a' +
      'vailable.'
    Anchors = [akTop, akRight]
    Caption = 'Sync Hot'
    TabOrder = 7
    OnClick = syncClick
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDButton1: TLMDButton
    Left = 304
    Top = 69
    Width = 80
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Reset'
    TabOrder = 8
    OnClick = LMDButton1Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDForm1: TLMDForm
    IniKey = 'LMDButtonFaceDlg'
    TrackMinHeight = 390
    TrackMinWidth = 398
    Left = 27
    Top = 38
  end
end
