unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TForm1 = class(TForm)
    MemoResponse: TMemo;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uBitly;

procedure TForm1.Button3Click(Sender: TObject);
var
  Bitly: TBitly;
  ToShorten: TDataToShorten;
begin
  Bitly := TBitly.Create;

  ToShorten.Title := 'News';
  ToShorten.LongURL := 'https://news.google.com/?hl=pt-BR&gl=BR&ceid=BR:pt-419';
  MemoResponse.Lines.Add(Bitly.Shorten(ToShorten));

  ToShorten.Title := 'Site Compufour';
  ToShorten.LongURL := 'https://www.compufour.com.br/';
  MemoResponse.Lines.Add(Bitly.Shorten(ToShorten));

  FreeAndNil(Bitly);

end;

end.
