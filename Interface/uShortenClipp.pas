unit uShortenClipp;

interface

uses uIShorten;


type TShortenClipp = class(TInterfacedObject, IShorten)
  public
    function Shorten(LongURL: String): String;

end;

implementation

{ ShortenClipp }

function TShortenClipp.Shorten(LongURL: String): String;
begin
  result:='short_clipp';
end;

end.
