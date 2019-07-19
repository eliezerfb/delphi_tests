object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 82
  ClientWidth = 246
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
    Left = 25
    Top = 29
    Width = 75
    Height = 25
    Caption = 'Clipp'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 125
    Top = 29
    Width = 75
    Height = 25
    Caption = 'Bitly'
    TabOrder = 1
    OnClick = Button2Click
  end
end
