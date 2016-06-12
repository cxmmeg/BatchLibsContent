@echo off
setlocal ENABLEDELAYEDEXPANSION

set project=ProjectTest
set version=20150101
set updateUrl=http://imfms.vicp.net

call:UpdateProjectVersion %project% %version% %updateUrl% "%~0"

echo=over&pause





goto end

:-----------�ӳ���ʼ-----------:

REM call:UpdateProjectVersion ��Ŀ���� ��ǰ�汾 ���µ�ַ ��ĿԴ�ļ�����·��("%~0")
:������Ŀ�汾 20151106
:UpdateProjectVersion

REM ����ӳ���ʹ�û���������ȷ���
if "%~4"=="" (
	echo=	#[���� %0:����4]��ĿԴ�ļ�����·��Ϊ��
	exit/b 1
) else if "%~3"=="" (
	echo=	#[���� %0:����3]���µ�ַΪ��
	exit/b 1
) else if "%~2"=="" (
	echo=	#[���� %0:����2]��ǰ�汾Ϊ��
	exit/b 1
) else if "%~1"=="" (
	echo=	#[���� %0:����1]��Ŀ����Ϊ��
	exit/b 1
)

REM ��ʼ���ӳ����������
for %%I in (updateVersionName updateVersionPath updateNewVersion updateNewVersionName updateVersionOldVersionPath) do if defined %%I set %%I=
set updateVersionName=%~1.Version
set updateVersionPath=%temp%\%updateVersionName%%random%%ranom%%random%

REM �ӳ���ʼ����
echo=#���ڼ�������Ŀ: %~1	��ǰ�汾: %~2
call:DownloadNetFile %~3/%updateVersionName% "%updateVersionPath%"
if not "%errorlevel%"=="0" (
	echo=	#����ʧ��,�޷����ӵ�������,���������
	exit/b
)
for /f "usebackq tokens=1,2 delims= " %%I in ("%updateVersionPath%") do (
	if %~2 lss %%I (
		echo=#��⵽��Ŀ�°汾 %%I ���ڳ��Ը�����Ŀ...
		set updateNewVersion=%%I
		set updateNewVersionName=%%~J
		call:DownloadNetFile %~3/%%~J "%~dp0\%%~J"
		if "!errorlevel!"=="0" (
			set updateNewVersionPath=%~dp0%%~J
			echo=#��Ŀ %~1 �°汾 %%I ���سɹ�
			goto  UpdateProjectVersion2
		) else (
			echo=	#����ʧ��,�޷��ӷ��������ظ����ļ�,���Ժ�����
			if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"
			exit/b 1
		)
	) else (
		if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"
		echo=#�������°汾,��л���Ĺ�ע
		exit/b 1
	)
)
:UpdateProjectVersion2
if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"

REM �˴�Ϊ�°汾���سɹ���Ҫ���Ķ���
REM 	%1	��Ŀ����
REM 	%2	�ɰ汾
REM 	"%~4"	��Ŀ�ɰ汾Դ�ļ�����·��
REM 	%updateNewVersion%	���º��ļ��汾
REM 	%updateNewVersionPath%	���º�汾�ļ�·��


REM ɾ���ɰ汾�����°汾
echo=	#�������°汾��Ŀ %1 %updateNewVersion%
ping -n 3 127.1>nul 2>nul
set updateVersionOldVersionPath=%~4
if /i "%updateVersionOldVersionPath:~-4%"==".exe" taskkill /f /im "%~nx4">nul 2>nul
(
	copy "%~4" "%~4_updatebak">nul 2>nul
	del /f /q "%~4"
	copy "%updateNewVersionPath%" "%~4">nul 2>nul
	if "!errorlevel!"=="0" (
		start "" "%~4"
		del /f /q "%~4_updatebak"
		del /f /q "%updateNewVersionPath%"
		exit
	) else (
		copy "%~4_updatebak" "%~4">nul 2>nul
		echo=#���°汾ʧ�ܣ������ֶ����°汾��Ŀ %updateNewVersionPath%
		del /f /q "%~4_updatebak"
		pause
		explorer /select,"%updateNewVersionPath%"
		exit
	)
)
exit/b 0

REM call:DownloadNetFile ��ַ ·�����ļ���
:���������ļ� 20151105
:DownloadNetFile
REM ����ӳ���ʹ�ù�����ȷ���
if "%~2"=="" (
	echo=	#[Error %0:����2]�ļ�·��Ϊ��
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
echo=Set xPost = CreateObject("Microsoft.XMLHTTP") >"%downloadNetFileTempPath%"
echo=xPost.Open "GET",%downloadNetFileUrl%,0 >>"%downloadNetFileTempPath%"
echo=xPost.Send() >>"%downloadNetFileTempPath%"
echo=Set sGet = CreateObject("ADODB.Stream") >>"%downloadNetFileTempPath%"
echo=sGet.Mode = 3 >>"%downloadNetFileTempPath%"
echo=sGet.Type = 1 >>"%downloadNetFileTempPath%"
echo=sGet.Open() >>"%downloadNetFileTempPath%"
echo=sGet.Write(xPost.responseBody) >>"%downloadNetFileTempPath%"
echo=sGet.SaveToFile "%downloadNetFileFilePath%",2 >>"%downloadNetFileTempPath%"

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