(*
  Exemplo captura de erro onde toda exceção do sistema entra em CatchError,
  podendo por exemplo, personalizar a mensagem de erro para tornar mais
  amigável para o usuário ou gravar em um log.
*)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CatchError(Sender: TObject; E: Exception);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CatchError(Sender: TObject; E: Exception);
var
  Msg: string;
begin
  Msg := 'Erro capturado:';
  Msg := Msg + #10 + E.message;
  Msg := Msg + #10 + 'Tela: ' + Screen.ActiveForm.name;
  Msg := Msg + #10 + 'Controle: ' + Screen.ActiveControl.name;
  ShowMessage(Msg);
end;

procedure TForm1.Button1Click(Sender: TObject);
var s:tStringList;
begin
  s.Add('');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnException := CatchError;
end;

end.
