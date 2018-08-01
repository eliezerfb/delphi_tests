unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TForm1 = class(TForm)
    memoRequest: TMemo;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button2Click(Sender: TObject);
var
URL: string;
EnvStr:tStringList;
begin
  IdHTTP1.ReadTimeout:= 50000;

  URL := 'https://www.rdstation.com.br/api/1.3/conversions';
  EnvStr:=TStringList.Create;

  EnvStr.Text := '{'+
        '"token_rdstation": "",'+ //Obrigatório - Token Publico de autenticação
        '"identificador": "assinante",'+ //Obrigatório
        '"email": "eliezerfb@gmail.com",'+ //Obrigatório
        '"nome": "ELIÉZER",'+ //(responsável)
        '"empresa": "OCTANTIS TECNOLOGIA LTDA",'+ // (nome fantasia)
        '"telefone": "49-9-84020730",'+
        '"datainicio": "01/10/2015",'+
        '"datafim": "30/10/2016",'+
        '"produto": "XPTO"'+ //Obrigatório
        '}';

  IdHTTP1.Request.Clear;
  IdHTTP1.Request.CustomHeaders.Clear;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.CharSet := 'utf-8';
  IdHTTP1.Request.CustomHeaders.AddValue('token_rdstation','');

  IdHTTP1.Response.ContentType := 'application/json';
  IdHTTP1.Response.CharSet := 'UTF-8';

  try
    memoRequest.Text:=IdHTTP1.Post(URL, EnvStr);
  except
    on E:EIdHTTPProtocolException do
      ShowMessage(e.ErrorMessage);
  end;
end;

end.
