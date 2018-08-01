(*Pequeno exemplo do uso de um DBCtrlGrid para um sistema de controle de
comandas*)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, DBClient, ExtCtrls, DBCGrids, Mask, Grids,
  DBGrids;

type
  TForm1 = class(TForm)
    DBCtrlGrid1: TDBCtrlGrid;
    DataSource1: TDataSource;
    Memo1: TMemo;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1ID: TIntegerField;
    ClientDataSet1Mesa: TStringField;
    ClientDataSet1Valor: TIntegerField;
    ClientDataSet1Ativa: TStringField;
    DBText1: TDBText;
    Label1: TLabel;
    Image1: TImage;
    procedure DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ClientDataSet1.CreateDataSet;

  ClientDataSet1.DisableControls;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 10;
  ClientDataSet1Ativa.AsString := 'S';
  ClientDataSet1ID.AsInteger := 1;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 0;
  ClientDataSet1Ativa.AsString := 'N';
  ClientDataSet1ID.AsInteger := 2;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 15;
  ClientDataSet1Ativa.AsString := 'S';
  ClientDataSet1ID.AsInteger := 3;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 14;
  ClientDataSet1Ativa.AsString := 'S';
  ClientDataSet1ID.AsInteger := 4;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 0;
  ClientDataSet1Ativa.AsString := 'N';
  ClientDataSet1ID.AsInteger := 5;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 0;
  ClientDataSet1Ativa.AsString := 'N';
  ClientDataSet1ID.AsInteger := 6;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 0;
  ClientDataSet1Ativa.AsString := 'N';
  ClientDataSet1ID.AsInteger := 7;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 100;
  ClientDataSet1Ativa.AsString := 'S';
  ClientDataSet1ID.AsInteger := 8;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1Valor.AsCurrency := 60;
  ClientDataSet1Ativa.AsString := 'S';
  ClientDataSet1ID.AsInteger := 9;
  ClientDataSet1.Post;

  ClientDataSet1.EnableControls;

  ClientDataSet1.Last;

end;

procedure TForm1.DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
var i:integer;
begin
  if not ClientDataSet1.IsEmpty then
  begin
    memo1.Lines.Add(
        ' index1 = '+intToStr(Index)+
        ' ID = '+ClientDataSet1.FieldByName('id').AsString+' '+
        ' Index2 ='+intToStr(DBCtrlGrid.PanelIndex)+' '+
        ClientDataSet1.FieldByName('Ativa').AsString
    );
    if ClientDataSet1.FieldByName('Ativa').AsString = 'S' then
    begin
      DBText1.Font.Color   := clGreen;
      Image1.Picture.LoadFromFile('green.bmp');
    end
    else
    begin
      DBText1.Font.Color   := clRed;
      Image1.Picture.LoadFromFile('red.bmp');
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBCtrlGrid1.Color := clWhite;
end;

end.
