(*
  Exemplo de consumo de uma API que espera e retorna um json.
  A autenticação é via token que deve ser enviado no cabeçalho da requisição.
*)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, ExtCtrls, uLkJSON, IdIntercept, IdLogBase, IdLogDebug;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    IdLogDebug1: TIdLogDebug;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure IdLogDebug1Send(ASender: TIdConnectionIntercept;
      var ABuffer: TBytes);
    procedure IdLogDebug1Receive(ASender: TIdConnectionIntercept;
      var ABuffer: TBytes);
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
var sResponse,url, json:string; JsonToSend:TStringStream;
    js : TlkJSONobject;
    ws: TlkJSONstring;
    token, HeaderStr: string;
begin
    Memo1.Lines.Clear;

    IdLogDebug1.Active := CheckBox1.Checked;

    token := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    HeaderStr := 'token '+token;

    json := ('{"placa": "'+LabeledEdit1.Text+'", '+
             '"data_hora": "'+LabeledEdit2.Text+' '+LabeledEdit3.Text+'"}'
    );
    JsonToSend := TStringStream.Create(Utf8Encode(Json));

    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.CharSet := 'utf-8';
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHttp1.Request.CustomHeaders.AddValue('Authorization', HeaderStr);

    try
        url := 'https://glatesat.herokuapp.com/api_odometro/';


        sResponse := IdHTTP1.Post(url, JsonToSend);

        Memo1.Lines.Add('=====CONTENT=====');
        Memo1.Lines.Add(sResponse);
        Memo1.Lines.Add('=================');

        js := TlkJSON.ParseText(sResponse) as TlkJSONobject;
    //    ws := js.Field['placa'] as TlkJSONstring;
        LabeledEdit4.Text := js.getString('placa');

    //    ws := js.Field['odometro'] as TlkJSONstring;
        LabeledEdit5.Text := FloatToStr(js.getDouble('odometro'));

    except
        on E: Exception do
        begin
            ShowMessage('Error on request: '#13#10 + e.Message);
            Memo1.Lines.Add(e.Message);
        end;
    end;

end;

procedure TForm1.IdLogDebug1Receive(ASender: TIdConnectionIntercept;
  var ABuffer: TBytes);
begin
  Memo1.Lines.Add('Receive <<<<<<<<');
  Memo1.Lines.Add(TEncoding.UTF8.GetString(ABuffer));
  Memo1.Lines.Add('');
end;

procedure TForm1.IdLogDebug1Send(ASender: TIdConnectionIntercept;
  var ABuffer: TBytes);
begin
  Memo1.Lines.Add('Send >>>>>>>');
  Memo1.Lines.Add(TEncoding.UTF8.GetString(ABuffer));
  Memo1.Lines.Add('');
end;

end.

