@echo off
setlocal ENABLEDELAYEDEXPANSION

call:pathFind t result
echo=%errorlevel%:%result%

goto end

REM ��PathĿ¼�в����ҵ��ĵ�һ��ָ�������ִ�г���(pathext��չ��)��ȫ·��
REM call:pathFind [/Q(����ģʽ)] "���ҳ�����" "ȫ·��������ձ���"
REM errorlevel: 0 - �ҵ�, 1 - δ�ҵ�, 2 - ��������
REM 20160507
:pathFind
REM ʹ�ò����ж�
set pathFindQuit=
if /i "%~1"=="/q" (
	set pathFindQuit=yes
	shift/1
)
if "%~2"=="" (
	if not defined pathFindQuit (
		echo=	#����:pathFind:δָ��ȫ·��������ձ���
		pause
	)
	exit/b 2
)
if "%~1"=="" (
	if not defined pathFindQuit (
		echo=	#����:pathFind:δָ�����ҳ�����
		pause
	)
	exit/b 2
)
set pathFind_appName=%~1
for %%a in (/,\,:) do if not "%pathFind_appName%"=="!pathFind_appName:%%a=!" exit/b 1

REM ��ʼ������
set %~2=
if defined pathext (set pathFind_pathextTemp=%pathext%) else set pathFind_pathextTemp=.EXE;.BAT;.CMD;.VBS
if not defined path exit/b 1

REM ���ָ��������������չ�����ж�
if not "%~x1"=="" set "pathFind_pathextTemp=%~x1"

REM ����pathĿ¼
for /f "delims==" %%a in ('set pathFind_parsePath 2^>nul') do set %%a=
set pathFind_parsePath_count=0
set pathFind_pathTemp=
set pathFind_pathTemp=%path%

:pathFind_parsePath2
set /a pathFind_parsePath_count+=1
for /f "tokens=1,* delims=;" %%a in ("%pathFind_pathTemp%") do (
	set "pathFind_parsePath%pathFind_parsePath_count%=%%~a"
	if not "%%~b"=="" (
		set pathFind_pathTemp=
		set "pathFind_pathTemp=%%~b"
		goto pathFind_parsePath2
	)
)

REM ��ʼ����
for /l %%a in (1,1,%pathFind_parsePath_count%) do (
	for %%b in (%pathFind_pathextTemp%) do (
		if exist "!pathFind_parsePath%%a!\%~n1%%~b" (
			set "%~2=!pathFind_parsePath%%a!\%~n1%%~b"
			exit/b 0
		)
	)
)
exit/b 1

:end
echo=end
pause
















