program ThreadsAndGUIDEMO;

uses
  Forms,
  MainU in 'MainU.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
