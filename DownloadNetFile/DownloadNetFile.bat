@echo off
cd /d "%~dp0"

call:DownloadNetFile http://imfms.vicp.net/BFS_FileSearch.Version asdf.ini
pause

goto end

:-----------�ӳ���ʼ-----------:

REM call:DownloadNetFile ��ַ ·�����ļ���
REM ���������ļ� �汾��20160114
:DownloadNetFile
REM ����ӳ���ʹ�ù�����ȷ���
if "%~2"=="" (
	echo=	#[Error %0:����2]�ļ�·�����ļ���Ϊ��
	exit/b 1
) else if "%~1"=="" (
	echo=	#[Error %0:����1]��ַΪ��
	exit/b 1
)

REM ��ʼ���ӳ����������
for %%- in (downloadNetFileTempPath downloadNetFileUrl downloadNetFileCachePath) do if defined %%- set %%-=
set downloadNetFileTempPath=%temp%\downloadNetFileTempPath%random%%random%%random%.vbs
set downloadNetFileUrl="%~1"
set downloadNetFileUrl="%downloadNetFileUrl:"=%"
set downloadNetFileFilePath=%~2

REM ���ɶ����ű�
(
	echo=Set xPost = CreateObject^("Microsoft.XMLHTTP"^)
	echo=xPost.Open "GET",%downloadNetFileUrl%,0
	echo=xPost.Send^(^)
	echo=Set sGet = CreateObject^("ADODB.Stream"^)
	echo=sGet.Mode = 3
	echo=sGet.Type = 1
	echo=sGet.Open^(^)
	echo=sGet.Write^(xPost.responseBody^)
	echo=sGet.SaveToFile "%downloadNetFileFilePath%",2
)>"%downloadNetFileTempPath%"

REM ɾ��IE�����������ݵĻ���
for /f "tokens=3,* skip=2" %%- in ('reg query "hkcu\software\microsoft\windows\currentversion\explorer\shell folders" /v cache') do if "%%~."=="" (set downloadNetFileCachePath=%%-) else set downloadNetFileCachePath=%%- %%.
for /r "%downloadNetFileCachePath%" %%- in ("%~n1*") do if exist "%%~-" del /f /q "%%~-"

REM ���нű�
cscript //b "%downloadNetFileTempPath%"

REM ɾ����ʱ�ļ�
if exist "%downloadNetFIleTempPath%" del /f /q "%downloadNetFIleTempPath%"

REM �жϽű����н��
if exist "%downloadNetFileFilePath%" (exit/b 0) else exit/b 1

:-----------�ӳ������-----------:
:end