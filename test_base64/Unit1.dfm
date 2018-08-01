object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 134
  ClientWidth = 120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Decoder'
    TabOrder = 0
    OnClick = Button1Click
  end
  object IdDecoderMIME1: TIdDecoderMIME
    FillChar = '='
    Left = 48
    Top = 68
  end
end
