object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'fmMain'
  ClientHeight = 290
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 37
    Top = 25
    Width = 193
    Height = 25
    Caption = 'Incluir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 37
    Top = 56
    Width = 193
    Height = 25
    Caption = 'Localizar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 250
    Top = 25
    Width = 280
    Height = 254
    TabOrder = 2
  end
  object Button3: TButton
    Left = 37
    Top = 90
    Width = 193
    Height = 25
    Caption = 'Remover'
    TabOrder = 3
    OnClick = Button3Click
  end
end
