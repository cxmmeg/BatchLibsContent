@echo off
setlocal enabledelayedexpansion
REM ���ܣ���������ַ�
REM �汾��20160106
REM ���ߣ�F_Ms | ���䣺imf_ms@yeah.net | ���ͣ�f-ms.cn
if "%~1"=="/?" goto help
if not "%~2"=="" (
	call:DefinedNoNumberString "%~2"
	if "!errorlevel!"=="1" set randomnum=%~2
)
if not defined randomnum set randomnum=8
if "%~1"=="" (
	call:word
	call:word2
	call:number
	goto redo
)
set temprandom=%~1
if /i "%temprandom:~0,2%"=="d:" (
	for /l %%i in (0,1,8192) do if "!temprandom:~%%i,1!"=="" (
		set /a widenum=%%i-2
		goto randomtemptemp
	)
) else goto randomchoose
:randomtemptemp
set diy=!temprandom:~2,%widenum%!
goto redo
:randomchoose
set randomChooseTemp=%~1
if not "%randomChooseTemp%"=="%randomChooseTemp:a=%" call:word
if not "%randomChooseTemp%"=="%randomChooseTemp:B=%" call:word2
if not "%randomChooseTemp%"=="%randomChooseTemp:0=%" call:number
if not "%randomChooseTemp%"=="%randomChooseTemp:@=%" call:fuhao
:redo
set randomku=%word%%word2%%number%%fuhao%%diy%
if "%randomku%"=="" goto help
set /a randomwide=%random%%%%widenum%
set /a randomdijia+=1
for %%i in (!randomwide!) do set /p=!randomku:~%%i,1!<nul
if %randomdijia% lss %randomnum% goto redo
echo=
endlocal

goto end
:word
set word=abcdefghijklmnopqrstuvwxyz
set /a widenum=widenum+26
goto :eof

:word2
set word2=ABCDEFGHIJKLMNOPQRSTUVWXYZ
set /a widenum=widenum+26
goto :eof

:number
set number=1234567890
set /a widenum=widenum+10
goto :eof

:fuhao
set fuhao=`~@#$()_+-[]{};',.
set /a widenum=widenum+18
goto :eof

REM �жϱ������Ƿ��з������ַ� call:DefinedNoNumberString ���ж��ַ�
REM	����ֵ0�����з������ַ�������ֵ1�����޷������ַ�������ֵ2�������Ϊ��
REM �汾��20151231
:DefinedNoNumberString
REM �ж��ӳ�������������
if "%~1"=="" exit/b 2

REM ��ʼ���ӳ����������
for %%B in (DefinedNoNumberString) do set %%B=
set DefinedNoNumberString=%~1

REM �ӳ���ʼ����
for /l %%B in (0,1,9) do (
	set DefinedNoNumberString=!DefinedNoNumberString:%%B=!
	if not defined DefinedNoNumberString exit/b 1
)
exit/b 0

:help

echo=Example��
echo=
echo=    random            Zigwad8B
echo=    random 0          69193404
echo=    random a 30       jeyymzhjkubuerqwqobhbcjehjiibj
echo=    random aB 15      MOsdXARUdqJmjtW
echo=    random 0aB@ 25    ,qg~_YdgN)FC_}SEQp)Q[0Wi5
echo=    random d:F_Ms 20  MFMs_MsMsFsF_sFMMsFM
echo=
echo=           0 = 1234567890
echo=           a = abcdefghijklmnopqrstuvwxyz
echo=           B = ABCDEFGHIJKLMNOPQRSTUVWXYZ
echo=           @ = `~@#$()_+-[]{};',.
echo=         d:* = *
echo=
echo=                                         F_Ms

:end

