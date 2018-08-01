unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    POP3: TIdPOP3;
    IdMessage1: TIdMessage;
    IO_OpenSSL: TIdSSLIOHandlerSocketOpenSSL;
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
Var
  lMsg: TIdMessage;
  i: Integer;
  iMsgs: Integer;
begin
//http://www.devmedia.com.br/forum/ler-receber-e-mail-com-indy/385697
  //Configurações
  with POP3 do begin
    IOHandler := IO_OpenSSL;
    AutoLogin := True;
    Host := 'pop.googlemail.com';
    Username := 'xxx@xxxxxxxx.com.br';
    UseTLS := utUseImplicitTLS;
    Password := 'dsf3d93d0';
    Port := 995;
  end;

  with IO_OpenSSL do begin
    Destination := 'pop.googlemail.com:995';
    Host := 'pop.googlemail.com';
    Port := 995;
    SSLOptions.Method := sslvSSLv23;
    SSLOptions.Mode := sslmClient;
  end;

  //Conectando
  if not POP3.Connected then
    POP3.Connect;

  //testa a conexão
  if not POP3.Connected then
  Begin
    ShowMessage('Conexão não realizada!');
    Exit;
  End;

  //Pega a qtd de msg que há na caixa de entrada
  iMsgs := POP3.CheckMessages;
end;

end.
