@echo off
cd /d "%~dp0"
setlocal ENABLEDELAYEDEXPANSION

call:DefinedNoNumberString a0
echo=a0	%errorlevel%

pause

goto end

:-----------�ӳ���ʼ-------

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

:-----------�ӳ������-----------:
:end