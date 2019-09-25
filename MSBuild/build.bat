REM ARQUIVO EM LOTE PARA GERAR BUILD DE TODOS OS PROJETOS
REM EXECUTAR ESTE .BAT PELO "RAD STUDIO COMMAND PROMPT"

set BUILD_PATH=D:\Dev\SW\build\

del *BuildOutput.log

C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\rsvars.bat

cd "D:\Dev\SW\source\"
msbuild /p:DCC_DebugInformation=2 "D:\Dev\SW\source\p_sw.dproj" /t:build /p:DCC_Define=SW;DCC_ExeOutput=%BUILD_PATH% -flp:logfile=D:\Dev\SW\Source\Build\SW_BuildOutput.log;verbosity=diagnostic

cd "D:\Dev\SW1\source\"
msbuild /p:DCC_DebugInformation=2 "D:\Dev\SW1\source\p_sw1.dproj" /t:build /p:DCC_Define=SW1;DCC_ExeOutput=%BUILD_PATH% -flp:logfile=D:\Dev\SW1\Source\Build\SW1_BuildOutput.log;verbosity=diagnostic
