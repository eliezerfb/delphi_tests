unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.RegularExpressions, Vcl.StdCtrls,
  System.DateUtils;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
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
var
  regex: TRegEx;
  s: string;
  Arquivo: TStringList;
  t0: TDateTime;
begin
  Arquivo := TStringList.Create;

//  Arquivo.Text := '"comment": "Esquina Do Posto Ipiranga. Pen\última Casa Do Lado Esquerdo. Portão De Madeira Escrito \"Deus É Fiel\"",'+
//  		 '"first_name": "Gu\ri de \Uruguiana",'+
//			 '"last_name": "Guri\",';

  Arquivo.LoadFromFile('D:\Luci\RegexTest\JsonComBarra2.json');

  s := Arquivo.Text;
  t0 := MilliSecondsBetween(Now, 0);
  s := TRegEx.Replace(s, '(\\")', '"');
  s := TRegEx.Replace(s, '\\(?!")', '');
  Memo1.Lines.Add(FloatToStr(MilliSecondsBetween(Now, 0)-t0));

  s := Arquivo.Text;
  t0 := MilliSecondsBetween(Now, 0);
  s := StringReplace(s, '\"', '"', [rfReplaceAll]);
  s := StringReplace(s, '\\(?!")', '', [rfReplaceAll]);
  Memo1.Lines.Add(FloatToStr(MilliSecondsBetween(Now, 0)-t0));
end;

end.
