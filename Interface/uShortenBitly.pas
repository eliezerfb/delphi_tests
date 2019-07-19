unit uShortenBitly;

interface

uses uIShorten;


type TShortenBitly = class(TInterfacedObject, IShorten)
  private
    FToken: String;
  public
    function Shorten(LongURL: String): String;
    constructor Create(Token: String);
end;

implementation

{ ShortenBitly }

constructor TShortenBitly.Create(Token: String);
begin
  FToken := Token;
end;

function TShortenBitly.Shorten(LongURL: String): String;
begin
  result:=FToken+' - short_bitly';
end;

end.
