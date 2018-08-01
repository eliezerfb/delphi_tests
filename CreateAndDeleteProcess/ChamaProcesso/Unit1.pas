unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TlHelp32;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


Procedure FinalizaProcesso(ProcessID: integer);
var
  SnapShot : THandle;
  pe       : TProcessEntry32;
  codigo   : string;
  processo : dword;
  C        : integer;
begin
    try
      TerminateProcess(OpenProcess($0001,false,ProcessID),0); // $0001 = Process_Terminate.
      codigo := '';
      processo := 0;
    except
      MessageDLG('Falha ao encerrar o processo!',mtInformation,[mbOK],0);
    end;
end;


function WinExecProcess(FileName: String; Visibility: integer): integer;
var
   zAppName: array[0..512] of char;
   zCurDir: array[0..255] of char;
   WorkDir: String;
   StartupInfo: TStartupInfo;
   ProcessInfo: TProcessInformation;
   Res: UINT;
begin
     StrPCopy(zAppName, FileName);
     GetDir(0, WorkDir);
     StrPCopy(zCurDir, WorkDir);
     FillChar(StartupInfo, Sizeof(StartupInfo), #0);
     StartupInfo.cb := Sizeof(StartupInfo);
     StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
     StartupInfo.wShowWindow := Visibility;

     if not (CreateProcess(nil,
       zAppName,             { pointer to command line string }
       nil,                  { pointer to process security attributes}
       nil,                  { pointer to thread security attributes }
       false,                { handle inheritance flag }
       CREATE_NEW_CONSOLE or { creation flags }
       NORMAL_PRIORITY_CLASS,
       nil,                  { pointer to new environment block }
       nil,                  { pointer to current directory name }
       StartupInfo,          { pointer to STARTUPINFO }
       ProcessInfo)) then     { pointer to PROCESS_INF }
       Result := -1
     else
     begin
          GetExitCodeProcess(ProcessInfo.hProcess, Res);
          {Added v2.4.4 (JS)}
          CloseHandle(ProcessInfo.hProcess);
          CloseHandle(ProcessInfo.hThread);
          Result := ProcessInfo.dwProcessId;
     end;
end;

procedure ExecNewProcess(ProgramName : String; Wait: Boolean);
var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  CreateOK : Boolean;
begin
    { fill with known state }
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcessW(nil, pChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);
    { check to see if successful }
  if CreateOK then
    begin
        //may or may not be needed. Usually wait for child processes
      if Wait then
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    end
  else
    begin
      ShowMessage('Unable to run '+ProgramName);
     end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
begin

  button1.Caption:=intToStr(WinExecProcess('Project1.exe', SW_SHOWNORMAL));

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;

begin

  button2.Caption:=intToStr(WinExecProcess('Project1.exe', SW_SHOWNORMAL));

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FinalizaProcesso(strToInt(Button1.Caption));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FinalizaProcesso(strToInt(Button2.Caption));
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to 100 do
    Memo1.Lines.add(intToStr(WinExecProcess('Project1.exe',SW_HIDE)));
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Memo1.Lines.Count - 1 do
    FinalizaProcesso(StrToInt(Memo1.Lines[i]));
end;

end.
