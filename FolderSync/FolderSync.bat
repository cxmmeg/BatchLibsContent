@echo off
setlocal ENABLEDELAYEDEXPANSION


call:FolderSync D:\user\desktop\test1\ D:\user\desktop\test2\

pause

goto end
:----------�ӳ���ʼ----------:

REM call:FolderSync Դ�ļ��� �����ļ���
:�ļ���ͬ�� 20151109
:FolderSync
REM ����ӳ���ʹ�ù�����ȷ���
if "%~2"=="" (
	echo=	#[Error %0:����2]�����ļ���·��Ϊ��
	exit/b 1
) else if not exist "%~2\" (
	echo=	#[Error %0:����2]�����ļ��в�����
	exit/b 1
)
if "%~1"=="" (
	echo=	#[Error %0:����1]Դ�ļ���Ϊ��
	exit/b 1
) else if not exist "%~1\" (
	echo=	#[Error %0:����1]Դ�ļ��в�����
	exit/b 1
)

REM ��ʼ���ӳ����������
for %%- in (folderSync_Temp foderSyncTemp2) do if defined %%- set %%-=

for /r "%~1\" %%- in (*) do if exist "%%~-" (
	if exist "%~2\%%~nx-" (
		for /f "delims=" %%. in ("%~1\%%~nx-") do (
			set folderSync_Temp=%%~t.
			set folderSync_Temp=!folderSync_Temp: =!
			set folderSync_Temp=!folderSync_Temp:/=!
			set folderSync_Temp=!folderSync_Temp::=!
		)
		for /f "delims=" %%. in ("%~2\%%~nx-") do (
			set folderSync_Temp2=%%~t.
			set folderSync_Temp2=!folderSync_Temp2: =!
			set folderSync_Temp2=!folderSync_Temp2:/=!
			set folderSync_Temp2=!folderSync_Temp2::=!
		)
		if not "!folderSync_Temp!"=="!folderSync_Temp2!" (
			copy "%%~-" "%~2\">nul 2>nul
			echo=%~2\%%~nx-
		)
	) else (
		copy "%%~-" "%~2\">nul 2>nul
		echo=%~2\%%~nx-
	)
)
exit/b 0

:----------�ӳ������----------:
:end