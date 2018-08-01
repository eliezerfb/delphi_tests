unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, DBClient, Provider;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    CDS: TClientDataSet;
    DataSource1: TDataSource;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
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
  csv: TextFile;
  Rec: string;
  Fields: TStringList;
  LineNo: Integer;
  i: Integer;
begin
  Fields := TStringList.Create;
  try
    Fields.StrictDelimiter := True;
    Fields.Delimiter := ';';

    AssignFile(csv, 'D:\client_saved.csv');
    try
      Reset(csv);

      LineNo := 0;
      while not Eof(csv) do begin
        Inc(LineNo);
        Readln(csv, Rec);

        Fields.DelimitedText := Rec;
        CDS.Append;

        for i := 0 to Fields.Count - 1 do
          try
            CDS.Fields[i].Value := Fields[i];   // Variant conversion will raise
                                 // exception where conversion from string fails
          except
            on E:EDatabaseError do begin
              CDS.Cancel;        // Failed, discard the record

              // log the error instead of showing a message
              ShowMessage(Format('Cannot set field "%s" at line %d' + sLineBreak +
                  'Error: %s', [CDS.Fields[i].FieldName, LineNo, E.Message]));
              Break;             // Continue with next record
            end;
          end;

        if CDS.State = dsInsert then // It's not dsInsert if we Cancelled the Insert
          try
            CDS.Post;
          except
            on E:EDatabaseError do begin
              // log error instead of showing
              ShowMessage(Format('Cannot post line %d' + sLineBreak + 'Error: %s',
                  [LineNo, E.Message]));
              CDS.Cancel;
            end;
          end;

      end;
    finally
      CloseFile(csv);
    end;
  finally
    Fields.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
//  Stream: TFileStream;
  i: Integer;
//  OutLine: string;
  sTemp: string;
  csv_file:tStringList;
begin
  try
    csv_file:=tStringList.Create;
    CDS.First;
    while not CDS.Eof do
    begin
      sTemp:='';
      for i := 0 to CDS.FieldCount - 1 do
        sTemp := sTemp+trim(CDS.Fields[i].AsString)+';';
      SetLength(sTemp, Length(sTemp) - 1);
      csv_file.Add(sTemp);
      CDS.Next;
    end;
    csv_file.SaveToFile('d:\client_saved.csv');

  finally
    csv_file.Free;
  end;

end;

procedure TForm1.CDSBeforePost(DataSet: TDataSet);
begin
  // Superficial posting error
  if CDS.FieldByName('LAST_NAME').AsString = '' then
    raise EDatabaseError.Create('LAST_NAME cannot be empty');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CDS.FieldDefs.Add('LAST_NAME', ftString, 20);
  CDS.FieldDefs.Add('FIRST_NAME', ftString, 20);
  CDS.FieldDefs.Add('ACCT_NBR', ftInteger);
  CDS.FieldDefs.Add('ADDRESS_1', ftString, 30);
  CDS.FieldDefs.Add('CITY', ftString, 15);
  CDS.FieldDefs.Add('STATE', ftString, 2);
  CDS.FieldDefs.Add('ZIP', ftString, 5);
  CDS.FieldDefs.Add('TELEPHONE', ftString, 12);
 // CDS.FieldDefs.Add('DATE_OPEN', ftDate);
  CDS.CreateDataSet;
end;

end.
