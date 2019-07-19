unit uShortenFactory;

interface

uses uIShorten, uShortenBitly, uShortenClipp;


type
  TShortenFactory = class(TInterfacedObject, IFactoryMethod)
    function ShortURL(Token: String): IShorten;
  end;


implementation

{ TShortenFactory }

function TShortenFactory.ShortURL(Token: String): IShorten;
begin
  if Token = '' then
    exit(TShortenClipp.Create());
  exit(TShortenBitly.Create())
end;

end.
