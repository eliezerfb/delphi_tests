unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Generics.Collections, Vcl.StdCtrls;

type
  TCity = record
    State: String;
    Country: String;
    Name: String;
  end;

  TfmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    CitiesList: TDictionary<String, TCity>;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.Button1Click(Sender: TObject);
var City: TCity;
begin
  City.State := 'SC';
  City.Country := 'Brazil';
  City.Name := 'Concórdia';
  CitiesList.Add(City.Name, City);

  City.State := 'SC';
  City.Country := 'Brazil';
  City.Name := 'Chapecó';
  CitiesList.Add(City.Name, City);

  City.State := 'SC';
  City.Country := 'Brazil';
  City.Name := 'Arabutã';
  CitiesList.Add(City.Name, City);
end;

procedure TfmMain.Button2Click(Sender: TObject);
var City: TCity;
begin
  if CitiesList.TryGetValue('Concórdia', City) then
    Memo1.Lines.Add(City.Name+' - '+City.State+' - '+City.Country)
  else
    Memo1.Lines.Add('City not found.')
end;

procedure TfmMain.Button3Click(Sender: TObject);
var City: TCity;
begin
  CitiesList.Remove('Arabutã');
  if not CitiesList.TryGetValue('Arabutã', City) then
    Memo1.Lines.Add('Removed');
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  CitiesList := TDictionary<String, TCity>.Create;
end;

end.
