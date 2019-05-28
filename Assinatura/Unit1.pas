unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrBase, ACBrDFe, ACBrNFe, ACBrDFeSSL;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
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
  SSL         : TDFeSSL;
  AXml        : AnsiString;
  XML, XMLAssinado : string;
  XMLFile: TStringList;
begin
  XMLFile := TStringList.Create;
  XMLFile.LoadFromFile('\\servidorcompu\Lixo\Eliezer\49-env-lote.xml');

  XML := Memo2.Lines.Text;
  SSL := TDFeSSL.Create;
  try
    SSL.SSLCryptLib   := cryCapicom;
    SSL.SSLXmlSignLib := xsLibXml2;
    SSL.SSLHttpLib    := httpWinHttp;
    SSL.SelecionarCertificado;
//    XMLAssinado       := SSL.Assinar(xml, 'xmlNfpse', 'xmlNfpse');
    XMLAssinado       := SSL.Assinar(XMLFile.Text, 'xmlNfpse', 'xmlNfpse');
  finally
    SSL.free;
  end;
  Memo1.Lines.Text := XMLAssinado;
end;

end.
