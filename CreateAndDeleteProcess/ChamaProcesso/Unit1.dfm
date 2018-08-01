object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 276
  ClientWidth = 695
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
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Chama 1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 124
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Chama 2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Finaliza 1'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 124
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Finaliza 2'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Memo1: TMemo
    Left = 488
    Top = 18
    Width = 185
    Height = 227
    TabOrder = 4
  end
  object Button5: TButton
    Left = 376
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Gera Lote'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 376
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Finaliza Lote'
    TabOrder = 6
    OnClick = Button6Click
  end
end
