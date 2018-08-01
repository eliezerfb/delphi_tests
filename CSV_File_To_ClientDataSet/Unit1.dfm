object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 226
  ClientWidth = 447
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
  object DBGrid1: TDBGrid
    Left = 4
    Top = 4
    Width = 435
    Height = 181
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 283
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Carrega'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 364
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Salva'
    TabOrder = 2
    OnClick = Button2Click
  end
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSBeforePost
    Left = 216
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = CDS
    Left = 268
    Top = 156
  end
end
