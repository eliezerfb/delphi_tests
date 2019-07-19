unit uIShorten;

interface

type
  IShorten = interface
    function Shorten(LongURL: String): String;
  end;

  IFactoryMethod = interface
    function ShortURL(Token: String): IShorten;
  end;

implementation

end.
