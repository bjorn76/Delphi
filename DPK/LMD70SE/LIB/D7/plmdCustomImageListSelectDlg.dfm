object LMDCustImgListSelectDlg: TLMDCustImgListSelectDlg
  Left = 226
  Top = 147
  BorderStyle = bsDialog
  Caption = 'Select Image...'
  ClientHeight = 335
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 230
    Top = 10
    Width = 46
    Height = 14
    Caption = '&ListIndex:'
  end
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 229
    Top = 32
    Width = 260
    Height = 298
    CtlXP = False
    Bevel.BorderInnerWidth = 4
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsRaisedspb
    TabOrder = 0
    object lb: TLMDListBox
      Left = 6
      Top = 6
      Width = 248
      Height = 286
      Align = alClient
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnDblClick = lbDblClick
      AllowResize = False
      Bevel.StyleOuter = bvLowered
      Bevel.Mode = bmCustom
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Arial'
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
          Text = 'ID'
          Width = 39
        end
        item
          ImageIndex = -1
          Text = 'Bitmap'
          Width = 284
        end>
      ItemHeight = 40
      Style = lbOwnerDrawFixed
      OnDrawItem = lbDrawItem
    end
  end
  object cmb: TComboBox
    Left = 290
    Top = 5
    Width = 198
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 1
    OnChange = cmbChange
  end
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 4
    Top = 31
    Width = 220
    Height = 298
    CtlXP = False
    Bevel.BorderInnerWidth = 4
    Bevel.Mode = bmStandard
    Bevel.StandardStyle = lsRaisedspb
    TabOrder = 2
    object ln: TLMDListBox
      Left = 6
      Top = 6
      Width = 208
      Height = 286
      Align = alClient
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = lnClick
      AllowResize = False
      Bevel.StyleOuter = bvLowered
      Bevel.Mode = bmCustom
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Arial'
      HeaderFont.Style = []
      HeaderHeight = 20
      HeaderSections = <
        item
          ImageIndex = -1
          Text = 'T'
          Width = 18
        end
        item
          ImageIndex = -1
          Text = 'N'
          Width = 28
        end
        item
          ImageIndex = -1
          Text = 'Name of ImageList'
          Width = 161
        end>
      ItemHeight = 16
      Items.Strings = (
        '')
    end
  end
  object btnOk: TLMDButton
    Left = 8
    Top = 3
    Width = 60
    Height = 24
    Caption = 'OK'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object btnCancel: TLMDButton
    Left = 72
    Top = 3
    Width = 60
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object Button2: TLMDButton
    Left = 144
    Top = 3
    Width = 60
    Height = 24
    Caption = 'Clear'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button2Click
    CtlXP = False
    ButtonStyle = ubsWin40
  end
  object LMDFormStyler1: TLMDFormStyler
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 444
    Top = 53
  end
end
