unit uBitly;

interface

uses System.Classes, System.SysUtils, IdHTTP, IdSSLOPenSSL;

type
  TDataToShorten = record
    Title: String;
    LongURL: String;
  end;

  TBitly = class
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    function Shorten(DataToShorten: TDataToShorten): String;
    constructor Create;
  end;

implementation

{ TBitly }

const
  BITLY_ACCESS_TOKEN = '';
  URL_BITLINKS = 'https://api-ssl.bitly.com/v4/bitlinks';
  JSON = '{"domain": "bit.ly", "title": "%s", "long_url": "%s"}';

constructor TBitly.Create;
begin
  FIdHTTP := TIdHTTP.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHTTP.Request.Accept := 'application/json';

  FIdHTTP.Request.ContentType := 'application/json';
  FIdHTTP.Request.ContentEncoding := 'utf-8';
  FIdHTTP.Request.UserAgent := 'Mozilla/3.0 (compatible;Indy Library)';

  FIdHTTP.Request.BasicAuthentication := False;
  FIdHTTP.Request.CustomHeaders.FoldLines := False;
  FIdHTTP.Request.CustomHeaders.Add(
    Format('Authorization:Bearer %s', [BITLY_ACCESS_TOKEN])
  );
end;


function TBitly.Shorten(DataToShorten: TDataToShorten): String;
var
  JsonToSend: TStringStream;
begin
  Result := '';
  JsonToSend := TStringStream.Create(
    Format(JSON, [DataToShorten.Title, DataToShorten.LongURL])
  );

  try
    Result := FIdHTTP.Post(URL_BITLINKS, JsonToSend);
  finally
    FreeAndNil(JsonToSend);
  end;

end;

end.
