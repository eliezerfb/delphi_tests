unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uIShorten, uShortenFactory, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    ShortenFactory: IFactoryMethod;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(ShortenFactory.ShortURL('').Shorten('URL'));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowMessage(ShortenFactory.ShortURL('Token').Shorten('URL'));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ShortenFactory := TShortenFactory.Create();
end;

end.
