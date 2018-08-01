object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mesas'
  ClientHeight = 596
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 420
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 8
    Top = 44
    Width = 533
    Height = 365
    AllowDelete = False
    AllowInsert = False
    ColCount = 6
    DataSource = DataSource1
    PanelHeight = 73
    PanelWidth = 86
    TabOrder = 0
    RowCount = 5
    OnPaintPanel = DBCtrlGrid1PaintPanel
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 86
      Height = 56
      Align = alClient
      Center = True
      ExplicitTop = 8
      ExplicitHeight = 73
    end
    object DBText1: TDBText
      Left = 0
      Top = 56
      Width = 86
      Height = 17
      Align = alBottom
      Alignment = taCenter
      DataField = 'Valor'
      DataSource = DataSource1
      ExplicitLeft = 17
      ExplicitWidth = 65
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 435
    Width = 457
    Height = 130
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Abrir'
    TabOrder = 2
    OnClick = Button1Click
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 640
    Top = 168
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 56
    object ClientDataSet1ID: TIntegerField
      FieldName = 'ID'
    end
    object ClientDataSet1Mesa: TStringField
      FieldName = 'Mesa'
      Size = 3
    end
    object ClientDataSet1Valor: TIntegerField
      FieldName = 'Valor'
      DisplayFormat = 'R$ #,#.00'
    end
    object ClientDataSet1Ativa: TStringField
      FieldName = 'Ativa'
      Size = 1
    end
  end
end
