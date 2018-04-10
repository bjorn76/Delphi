object frm2lines: Tfrm2lines
  Left = 493
  Top = 410
  BorderStyle = bsDialog
  Caption = 'Input'
  ClientHeight = 106
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Number'
  end
  object Edit1: TEdit
    Left = 56
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Recipient 1'
  end
  object Edit2: TEdit
    Left = 56
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '467'
  end
  object BtnOK: TButton
    Left = 56
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = BtnOKClick
  end
  object BtnCancel: TButton
    Left = 136
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = BtnCancelClick
  end
end
