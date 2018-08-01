object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 412
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 64
    Top = 8
    Width = 533
    Height = 373
    Indent = 19
    TabOrder = 0
  end
  object Button1: TButton
    Left = 64
    Top = 383
    Width = 75
    Height = 25
    Caption = 'In'#237'cio'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 522
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Teste'
    TabOrder = 2
    OnClick = Button2Click
  end
  object XMLDocument1: TXMLDocument
    Left = 16
    Top = 12
    DOMVendorDesc = 'MSXML'
  end
end
