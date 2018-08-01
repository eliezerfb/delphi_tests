unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, ComCtrls, msxmldom, XMLDoc;

type
  TForm1 = class(TForm)
    XMLDocument1: TXMLDocument;
    TreeView1: TTreeView;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure AdicionaNo(NoXML: IXMLNode; Pai : TTreeNode);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function copyPos(Texto,Inicio,Fim:string):string;
var PosInicio,Tam:integer;
begin
  PosInicio:=pos(Inicio,Texto)+Length(Inicio);
  Tam:=pos(fim,Texto)-PosInicio;
  result:=copy(Texto,PosInicio,Tam);
end;

function deletePos(Texto,Inicio,Fim:string):string;
var PosInicio,Tam:integer;
begin
  PosInicio:=pos(Inicio,Texto);
  Tam:=pos(fim,Texto)+Length(Fim)-1;
  delete(Texto,PosInicio,Tam);
  result:=Texto;
end;

function deletePosV2(Texto,Inicio,Fim:string):string;
var PosInicio,Tam:integer;
begin
  PosInicio:=pos(Inicio,Texto);
  Tam:=(pos(fim,Texto)+Length(Fim))-pos(Inicio,Texto);
  delete(Texto,PosInicio,Tam);
  result:=Texto;
end;

//http://www.edesoft.com.br/artigos/142-xnl-no-radstudio-xe2
procedure TForm1.AdicionaNo(NoXML: IXMLNode; Pai : TTreeNode);
var
SubNoXML : IXMLNode;
Filho : TTreeNode;
i : integer;
begin
  Filho := TreeView1.Items.AddChild(Pai, NoXML.NodeName);
  for i := 0 to NoXML.AttributeNodes.Count-1 do
    Filho.Text := Filho.Text + ' ' +NoXML.AttributeNodes.Get(i).NodeName + '=' +
        QuotedStr(NoXML.AttributeNodes.Get(i).Text);

  if NoXML.HasChildNodes then
    for i := 0 to NoXML.ChildNodes.Count - 1 do
    begin
      case NoXML.ChildNodes[i].NodeType of
        ntText : TreeView1.Items.AddChild(Filho, NoXML.Text);
      else
        SubNoXML := NoXML.ChildNodes[i];
      AdicionaNo(SubNoXML, Filho);
    end;
  end
end;

procedure TForm1.Button1Click(Sender: TObject);
var xml,aux:string;  posAux:integer;

procedure ExcluiCNPJIE(tag:string);
begin
  aux:=CopyPos(XML,'<'+tag+'>','</'+tag+'>');
  if trim(aux)<>'' then
  begin
    aux:=deletePosV2(aux,'<CNPJ>','</CNPJ>');
    aux:=deletePosV2(aux,'<IE>','</IE>');
    aux:=deletePosV2(aux,'<CPF>','</CPF>');
    posAux:=Pos('<'+tag+'>',XML);
    XML:=DeletePosV2(XML,'<'+tag+'>','</'+tag+'>');
    Insert('<'+tag+'>'+aux+'</'+tag+'>',XML,posAux);
  end;
end;


begin
  TreeView1.Items.Clear;
  XMLDocument1.XML.Clear;
  XMLDocument1.LoadFromFile('CTe1-protCTe.xml');
  XML:=XMLDocument1.XML.Text;
  XML:=DeletePosV2(XML,'<?xml','<ide>');
  XML:='<CTe><infCte><ide>'+XML;
  XML:=DeletePosV2(XML,'<Signature','</Signature>');
  XML:=DeletePosV2(XML,'<protCTe','</protCTe>');
  XML:=DeletePosV2(XML,'<cteProc>','</cteProc>');
  XML:=DeletePosV2(XML,'</cteProc>','</cteProc>');

  /// CAMPOS QUE NÃO PODEM SER CORRIGIDOS VIA CARTA DE CORREÇÃO
  ///  MANUAL DO CT-E Anexo VII – Campos Impedidos de Alteração por Carta de Correção

  XML:=DeletePosV2(XML,'<cUF>','</cUF>');
  XML:=DeletePosV2(XML,'<cCT>','</cCT>');
  XML:=DeletePosV2(XML,'<mod>','</mod>');
  XML:=DeletePosV2(XML,'<serie>','</serie>');
  XML:=DeletePosV2(XML,'<nCT>','</nCT>');
  XML:=DeletePosV2(XML,'<tpEmis>','</tpEmis>');
  XML:=DeletePosV2(XML,'<cDV>','</cDV>');
  XML:=DeletePosV2(XML,'<tpAmb>','</tpAmb>');
  XML:=DeletePosV2(XML,'<dhEmi>','</dhEmi>');
  XML:=DeletePosV2(XML,'<modal>','</modal>');
  XML:=DeletePosV2(XML,'<toma>','</toma>');

//  ExcluiCNPJIE('emit');
  XML:=DeletePosV2(XML,'<emit>','</emit>');
  ExcluiCNPJIE('toma04');
  ExcluiCNPJIE('rem');
  ExcluiCNPJIE('dest');


  XML:=DeletePosV2(XML,'<vTPrest>','</vTPrest>');
  XML:=DeletePosV2(XML,'<ICMS>','</ICMS>');

  XML:=DeletePosV2(XML,'<verProc>','</verProc>');
  XML:=DeletePosV2(XML,'<verProc>','</verProc>');

  XMLDocument1.XML.Text:=XML;



  XMLDocument1.Active:=true;
  AdicionaNo(XMLDocument1.DocumentElement, nil);



end;

procedure TForm1.Button2Click(Sender: TObject);
var Pai,Campo:string;
begin
  if TreeView1.Selected<>nil then
  begin
    if TreeView1.Selected.Parent<>nil then
      campo:=TreeView1.Selected.Parent.Text;
    if TreeView1.Selected.Parent.Parent<>nil then
      Pai:=TreeView1.Selected.Parent.Parent.Text;

    if Campo<>'' then
      ShowMessage('Pai: '+Pai+' - Campo: '+Campo);
  end;

end;

end.
