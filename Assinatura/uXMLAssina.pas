unit uXMLAssina;

interface

Uses SysUtils, Messages, Classes, Graphics, Controls, Windows, Dialogs,
     DB, DBAccess, Uni, MemDS, MSXML2_TLB, CAPICOM_TLB, SysComerceUtil,
     SysClaPath, ComObj, Winapi.ActiveX;

function AssinaDocXml(const FileXml, Id: string; var FileOut: string) : Boolean;

implementation

function MontaFileXml(const FileXml,Id: string) : string;
var
  ArquivoXml : string;  
begin
  ArquivoXml := '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
                '<SignedInfo>' +
                '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>' +
                '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>' +
                '<Reference URI="#'+Id+'">' +
                '<Transforms>' +
                '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>' +
                '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>' +
                '</Transforms>' +
                '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>' +
                '<DigestValue></DigestValue>' +
                '</Reference>' +
                '</SignedInfo>' +
                '<SignatureValue></SignatureValue>' +
                '</Signature>';
  Result := StringReplace(FileXml,':CERTIFICADO', ArquivoXml, [rfReplaceAll]);
end;

function AssinaDocXml(const FileXml, Id: string; var FileOut: string) : Boolean;
var
  Store: IStore3;
  CertsLista, CertsSelecionado: ICertificates2;
  Cert: ICertificate2;
  lSigner: TSigner;
  lSignedData: TSignedData;

  fileXmlNew : string;
  FileXmlOut : TStringList;

  AXml, XmlAss: AnsiString;
  xmldoc: IXMLDOMDocument3;
  xmldsig: IXMLDigitalSignature;
  dsigKey: IXMLDSigKey;
  signedKey: IXMLDSigKey;
  PrivateKey: IPrivateKey;

  filenameIn, filenameOut, msg : string;

begin
  filenameIn := ClaPath.TempPath + 'teste_ENVIO.xml';
  filenameOut:= ClaPath.TempPath + 'teste_assinada.xml'; 

  fileXmlNew := MontaFileXml(FileXml, Id);
  AXml :=AnsiString(WideString(fileXmlNew));  
  
  Store := CoStore.Create;
  try
    Store.Open(CAPICOM_CURRENT_USER_STORE, 'Root', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);
  except
    On E: Exception do
    begin
      MsgErro(E.Message);
      Result := False;
      Exit;
    end;
  end;

  try
    CertsLista := Store.Certificates as ICertificates2;
    CertsSelecionado := CertsLista.Select
      ('Certificado(s) Digital(is) disponível(is)',
      'Selecione o Certificado Digital para uso no aplicativo', False);
  except
    On E: Exception do
    begin
      MsgAvisa('Operação cancelada pelo usuário!');
      Result := False;
      Exit;
    end;
  end;

  if not(CertsSelecionado.Count = 0) then
  begin
    Cert := IInterface(CertsSelecionado.Item[1]) as ICertificate2;

    lSigner := TSigner.Create(nil);
    lSigner.Certificate := Cert;

    lSignedData := TSignedData.Create(nil);
    lSignedData.Content := WideString(AXml);

    try
      msg := lSignedData.Sign(lSigner.DefaultInterface, false, CAPICOM_ENCODE_BINARY);
    except
      On E : Exception do
      begin
        MsgErro('Erro na autenticação do Certificado Digital!' + sLineBreak + e.Message);
        Result := False;
        Exit;
      end;
    end; 
    
    if (Now >= Cert.ValidFromDate) and (Cert.ValidToDate >= Now) then
    begin 
      try
        xmldoc := CoDOMDocument50.Create;
        xmldoc.async := False;
        xmldoc.validateOnParse := False;
        xmldoc.preserveWhiteSpace := True;
        if (not xmldoc.loadXML(WideString(AXml))) then
        begin
          MsgErro('Não foi possível carregar XML '+ sLineBreak + String(AXml));
        end;

        xmldoc.setProperty('SelectionNamespaces','xmlns:ds="http://www.w3.org/2000/09/xmldsig#"');
        xmldoc.save(filenameIn);
      
        xmldsig := CoMXDigitalSignature50.Create;
        xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');
        if (xmldsig.signature = nil) then
        begin
          MsgErro('É preciso carregar o template da assinatura antes de assinar.');
          Result := False;
          Exit;
        end;

        try
          OleCheck(IDispatch(cert.PrivateKey).QueryInterface(IPrivateKey, PrivateKey));
          xmldsig.store := Store;
        except
          on e: Exception do
          begin
            MsgErro('Erro na checagem da chave privada do Certificado. ->' + sLineBreak + e.Message);
            Result := False;
            Exit;
          end;
        end;

        try
          //dsigKey := xmldsig.createKeyFromNode(xmldsig.signature);
          dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType,
            PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
          if (dsigKey = nil) then
          begin
            MsgErro('Erro ao criar a chave do CSP da assinatura do documento.');
            Result := False;
            Exit;
          end;
        except
          on e: Exception do
          begin
            MsgErro('Erro ao criar a chave do CSP da assinatura do documento. ->' + sLineBreak + e.Message);
            Result := False;
            Exit;
          end;
        end;

        try
          signedKey := xmldsig.sign(dsigKey,NOKEYINFO);
          if (signedKey = nil) then
          begin
            MsgErro('Assinatura Falhou.');
            Result := False;
            Exit;
          end;
        except
          on e: Exception do
          begin
            MsgErro('Erro durante a assinatura ->' + sLineBreak + e.Message);
            Result := False;
            Exit;
          end;
        end;

        XmlAss := AnsiString(xmldoc.xml);

      finally
        dsigKey := nil;
        signedKey := nil;
        xmldoc := nil;
        xmldsig := nil;
      end; 
    end;
    FreeAndNil(Cert);
    FreeAndNil(lSignedData);
    FreeAndNil(lSigner);
  end;
  Store.Close;
  FileOut := String(XmlAss);

  FileXmlOut := TStringList.Create;
  FileXmlOut.Clear;
  FileXmlOut.Add(FileOut);
  FileXmlOut.SaveToFile(filenameOut);
  FileXmlOut.Free;

  Result := True;  
end;


end.

