unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  XmlFile : TXMLDocument;
  MainNode, Attr, Table, Row: IXMLNode;
  i, k : Integer;
  XMLPath : string;
begin
  XMLPath := '2018.10.30.xls';
  XmlFile :=  TXMLDocument.Create(Application);
  try
    try
      XmlFile.LoadFromFile(XMLPath);
      XmlFile.Active := True;
      MainNode := XmlFile.DocumentElement;

      Memo1.Lines.Add(intToStr(MainNode.ChildNodes.Count));
      for I := 0 to MainNode.ChildNodes.Count - 1 do
      begin
        Attr := MainNode.ChildNodes[i].AttributeNodes.FindNode('Name');
        if attr <> nil then
        begin
          if Attr.Text = 'RESUMO DA FATURA' then
          begin
            Table := MainNode.ChildNodes[i].ChildNodes.FindNode('Table');
            if Table <> nil then
            begin
                for k := 0 to Table.ChildNodes.Count - 1 do
                begin
                  Row := Table.ChildNodes[k];
                  if Row.ChildNodes.Count > 0 then
                  begin
                      if Row.ChildNodes[0].ChildNodes[0].Text = 'Número' then
                          Memo1.Lines.Add(Row.ChildNodes[1].ChildNodes[0].Text);
                      if Row.ChildNodes[0].ChildNodes[0].Text = 'Emissão' then
                          Memo1.Lines.Add(Row.ChildNodes[1].ChildNodes[0].Text);
                      if Row.ChildNodes[0].ChildNodes[0].Text = 'Vencimento' then
                          Memo1.Lines.Add(Row.ChildNodes[1].ChildNodes[0].Text);
                      if Row.ChildNodes[0].ChildNodes[0].Text = 'Valor' then
                          Memo1.Lines.Add(Row.ChildNodes[1].ChildNodes[0].Text);
                  end;
                end;
            end;

          end else if Attr.Text = 'PASSAGENS PEDÁGIO' then
          begin
            Table := MainNode.ChildNodes[i].ChildNodes.FindNode('Table');
            if Table <> nil then
            begin
                for k := 0 to Table.ChildNodes.Count - 1 do
                begin
                  Row := Table.ChildNodes[k];
                  if Row.ChildNodes.Count > 0 then
                  begin
                      Memo1.Lines.Add(Row.ChildNodes[0].ChildNodes[0].Text);
                      Memo1.Lines.Add(Row.ChildNodes[5].ChildNodes[0].Text);
                      Memo1.Lines.Add(Row.ChildNodes[6].ChildNodes[0].Text);
                      Memo1.Lines.Add(Row.ChildNodes[7].ChildNodes[0].Text);
                      Memo1.Lines.Add(Row.ChildNodes[8].ChildNodes[0].Text);
                      Memo1.Lines.Add(Row.ChildNodes[9].ChildNodes[0].Text);
                      Memo1.Lines.Add('-------------------------------------');
                  end;
                end;
            end;
          end;

        end;
      end;

    except  on E : Exception do
        showMessage(E.Message);
    end;
    finally
      FreeAndNil(XmlFile);
    end;

end;

end.
