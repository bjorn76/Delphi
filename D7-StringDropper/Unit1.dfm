object Form1: TForm1
  Left = 414
  Top = 217
  Width = 196
  Height = 103
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 13
    Caption = 'Björn'
  end
  object Button1: TButton
    Left = 121
    Top = 40
    Width = 57
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DropTextSource1: TDropTextSource
    Dragtypes = [dtCopy]
    ImageIndex = 0
    ShowImage = False
    ImageHotSpotX = 16
    ImageHotSpotY = 16
    Left = 8
    Top = 24
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 24
    object AddLabel1: TMenuItem
      Caption = 'Add Label'
      OnClick = AddLabel1Click
    end
  end
end
