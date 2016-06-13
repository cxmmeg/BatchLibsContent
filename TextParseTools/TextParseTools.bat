@echo off

REM �������
setlocal ENABLEDELAYEDEXPANSION
cd /d "%~dp0"
REM debug�������Ϊ0�Ļ�����������ʱ����ͣ
set debug=0
title �ı��������߿� F_Ms 20151125

:-----����������ʼ���-----:

:-----���������������-----:
:-----�ӳ���ʼ���-----:
goto end

REM call:ChooseOneLine "�ļ�" ��ʼ�� ���� [���� | /f "�ļ�"](�������ݱ���д�뵽�ļ�)
:��һ���ļ���ָ��ĳһ��.�������ݸ�ֵ��������д�뵽�ļ�
:ChooseOneLine
	REM ��ʼ���ӳ����������
	for %%Y in (subroutine chooseOneLine_Skip chooseOneLine_LineNumber chooseOneLine_Dijia) do if defined %%Y set %%Y=
	set subroutine=ChooseOneLine
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~4"=="" (
		call:ShowErrorMessage [����4]���������淽��ѡ��
		exit/b 1
	)
	if /i "%~4"=="/f" if "%~5"=="" (
		call:ShowErrorMessage [����5]%~5,ָ��������д���ļ�·��Ϊ��
		exit/b 1
	) else if exist "%~5" (
		call:ShowErrorMessage [����5]%~5,ָ��������д���ļ��Ѵ���
		exit/b 1
	)
	if "%~3"=="" (
		call:ShowErrorMessage [����]ָ������Ϊ��
		exit/b 1
	) else if %~3 lss 1 (
		call:ShowErrorMessage [����3]%~3,ָ������ֵС��1
		exit/b 1
	)
	if "%~2"=="" (
		call:ShowErrorMessage [����2]��ʼ��Ϊ��
		exit/b 1
	) else if %~3 gtr 1 if /i not "%~4"=="/f" (
		call:ShowErrorMessage [����2]%~3,����ȡ��������һ��ʱֻ�ܽ������ݴ洢���ļ�
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]ָ����ȡ��Դ�ļ�Ϊ��
		exit/b 1
	) else if not exist "%~1" (
		call:ShowErrorMessage [����1]%~1,ָ����ȡ��Դ�ļ�������
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	set /a chooseOneLine_Skip=%~2-1
	if "%chooseOneLine_Skip%"=="0" (set chooseOneLine_Skip=) else set chooseOneLine_Skip=skip=%chooseOneLine_Skip%
	set chooseOneLine_LineNumber=%~3
	for /f "usebackq %chooseOneLine_Skip% delims=" %%Y in ("%~1") do (
		if "%~3"=="1" (
			if /i "%~4"=="/f" (
				echo=%%Y>"%~5"
				exit/b 0
			) else (
				set %~4=%%Y
				exit/b 0
			)
		) else (
			echo=%%Y>>"%~5"
			set /a chooseOneLine_Dijia+=1
			if "!chooseOneLine_Dijia!"=="%~3" exit/b 0
		)
	)
exit/b 0

REM call:ReplaceVariableContent ������ �滻���� ���滻���� �滻����2 ���滻����2 ... ...
:�滻��������
:ReplaceVariableContent
	REM ��ʼ���ӳ����������
	for %%X in (subroutine) do if defined %%X set %%X=
	set subroutine=ReplaceVariableContent
	
	:ReplaceVariableContent2
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~2"=="" (
		call:ShowErrorMessage [����2]�滻����Ϊ��
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]������Ϊ��
		exit/b 1
	) else  if not defined %1 (
		call:ShowErrorMessage [����1]%1����������
		exit/b 1
	)
	REM �ӳ���������ʼ
	set %1="!%1:%~2=%~3!"
	if not "%~4"=="" (
		shift/2
		shift/2
		goto ReplaceVariableContent2
	)
exit/b 0

REM call:ChooseFromVariable Դ������ �Կո�ָ���ĳ��ֵ �������ֵ���� [/nocheck](�����м��ֵ�Ƿ����)
:�ӱ�����Ѱ���Կո�ָ��ĵ�ĳ����ֵ
:ChooseFromVariable
	REM ��ʼ���ӳ����������
	for %%w in (subroutine ChooseFromVariable_DiJia ChooseFromVariable_Temp) do if defined %%w set %%w=
	set subroutine=ChooseFromVariable
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~3"=="" (
		call:ShowErrorMessage [����3]�������ֵ����Ϊ��
		exit/b 1
	)
	if "%~2"=="" (
		call:ShowErrorMessage [����2]��ĳ��ֵָ��Ϊ��
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]%~1������Ϊ��
		exit/b 1
	) else if not defined %~1 (
		call:ShowErrorMessage [����1]����δ����ֵ
		exit/b 1
	)
	
	if /i "%~4"=="/nocheck" goto ChooseFromVariable2
	call:Count 0 !%~1!
	if %~2 gtr %errorlevel% (
		call:ShowErrorMessage [����]%~2ָ��ֵ������
	)
	:ChooseFromVariable2
	
	REM �ӳ���������ʼ
	set ChooseFromVariable_Temp=!%~1:"=!
	for %%w in (%ChooseFromVariable_Temp%) do (
		set /a ChooseFromVariable_DiJia+=1
		if "!ChooseFromVariable_DiJia!"=="%~2" set %~3=%%w
	)
exit/b 0

REM call:EraseSpace "�ļ�1" "�ļ�2" ...
:ȥ���ļ���������հ׿���
:EraseSpace
	REM ��ʼ���ӳ����������
	for %%x in (subroutine) do if defined %%x set %%x=
	set subroutine=EraseSpace
	
	:EraseSpace2
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~1"=="" (
		call:ShowErrorMessage [����1]�ļ�ָ��Ϊ��
		exit/b 1
	) else if not exist "%~1" (
		call:ShowErrorMessage [����1]%~1�ļ�������
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	strrpc /s:"%~1" /c "	"
	strrpc /s:"%~1" /c "  "
	strrpc /s:"%~1" /c "  "
	strrpc /s:"%~1" /c /e "jikljiomijj89wjr98m34u3n8q9rcu32498rxmu89@#$"
	
	if not "%~2"=="" (
		shift/1
		goto EraseSpace2
	)
	
exit/b 0

REM call:GetKeyWordLineNumberInFile "�ļ�" [/i(�����ִ�Сд)] [/t(ֻ����λ�����׵�)] "�ؼ���" "���ֶ��ѡȡ�ڼ���" "ʹ���ƫ��ֵ"
:���ݹؼ��ִ��ļ����������з����к�
:GetKeyWordLineNumberInFile
	REM ��ʼ���ӳ����������
	for %%Z in (subroutine GetKeyWordLineNumberInFile_I GetKeyWordLineNumberInFile_T GetKeyWordLineNumberInFile_DiJia GetKeyWordLineNumberInFile_PianYiResult) do if defined %%Z set %%Z=
	set subroutine=GetKeyWordLineNumberInFile
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~2"=="" (
		call:ShowErrorMessage [����2]�ؼ���Ϊ��
		exit/b 1
	) else (
		if /i "%~2"=="/i" (
			set GetKeyWordLineNumberInFile_I=i
			shift/2
		)
		if /i "%~3"=="/t" (
			set GetKeyWordLineNumberInFile_T=b
			shift/2
		)
	)
	if not "%~3"=="" (
		call:CompareSize %~3 lss 1
		if "!errorlevel!"=="0" (
			call:ShowErrorMessage [����3]%~3ָ��ѡȡ�ڼ�����ֵС��1
			exit/b 1
		)
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]�����ļ�Ϊ��
		exit/b 1
	) else if not exist "%~1" (
		call:ShowErrorMessage [����1]%~1�����ļ�������
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	for /f "delims=:" %%Z in ('findstr /%GetKeyWordLineNumberInFile_I%%GetKeyWordLineNumberInFile_T%nlc:"%~2" "%~1"') do (
		if "%~3"=="" (
			exit/b %%Z
		) else (
			set /a GetKeyWordLineNumberInFile_DiJia+=1
			if "!GetKeyWordLineNumberInFile_DiJia!"=="%~3" (
				if "%~4"=="" (exit/b %%Z) else (
					set /a GetKeyWordLineNumberInFile_PianYiResult=%%Z+%~4
					if !GetKeyWordLineNumberInFile_PianYiResult! leq 0 exit/b 0
					exit/b !GetKeyWordLineNumberInFile_PianYiResult!
				)
			)
		)
	)
	if not "%errorlevel%"=="0" (
		call:ShowErrorMessage [����]δ�ܴ��ļ�"%~1"���ҵ�"%~2"
		exit/b 0
	)
call:ShowErrorMessage [���]����ѡȡ�����е�%~3��δ���ҵ����,��δ�ܴ��ļ�"%~1"���ҵ�"%~2"
exit/b 0

REM ��ʾ����
REM call:ShowErrorMessage ��������
:ShowErrorMessage
if defined subroutine echo=	#���ִ���,�ӳ���:%subroutine%,������%*
if not defined subroutine echo=	#���ִ���,������%*
if "%debug%"=="0" pause
goto :eof

REM call:CompareSize �Ƚ��� �Ƚϱ��ʽ(��if����ͬ) ���Ƚ���
:�Ƚϴ�С
:CompareSize
	REM ��ʼ���ӳ����������
	for %%z in (subroutine) do if defined %%z set %%z=
	set subroutine=CompareSize
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~3"=="" (
		call:ShowErrorMessage [����3]�ޱ��Ƚ���
		exit/b 1
	)
	if "%~2"=="" (
		call:ShowErrorMessage [����2]�ޱȽϱ��ʽ
		exit/b 1
	) else if /i not "%~2"=="equ" if /i not "%~2"=="neq" if /i not "%~2"=="lss" if /i not "%~2"=="leq" if /i not "%~2"=="gtr" if /i not "%~2"=="geq" (
		call:ShowErrorMessage [����2]%~2���ʽ����
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]�ޱȽ���
		exit/b 1
	)
	
	REM �ӳ���������ʼ
if %~1 %~2 %~3 (exit/b 0) else exit/b 1

REM call:Convert2OK_Name ��ת��������1 [��ת��������2] [��ת��������3] ...
:�������ļ����ı���ת��Ϊ�Ϲ���ļ���
:Convert2OK_Name
	REM ��ʼ���ӳ����������
	for %%z in (subroutine) do if defined %%v set %%v=
	set subroutine=Convert2OK_Name
	
	:Convert2OK_Name2
	if "%~1"=="" (
		call:ShowErrorMessage [����1]��ת������Ϊ��
		exit/b 1
	)
	if not defined %~1 (
		call:ShowErrorMessage [����1]%~1:��ת������δ����ֵ
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	if not "!%~1!"=="!%~1::=!" set %~1=!%~1::=��!
	if not "!%~1!"=="!%~1:?=!" set %~1=!%~1:?=��!
	if not "!%~1!"=="!%~1:/=!" set %~1=!%~1:/= !
	if not "!%~1!"=="!%~1:\=!" set %~1=!%~1:\= !
	if not "!%~1!"=="!%~1:/*!" set %~1=!%~1:/*=!
	if not "!%~1!"=="!%~1:**=!" for /f "tokens=1-26 delims=*" %%A in ("!%~1!") do (
		set %~1=%%Ax%%Bx%%Cx%%Dx%%Ex%%Fx%%Gx%%Hx%%Ix%%Jx%%Kx%%Lx%%Mx%%Nx%%Ox%%Px%%Qx%%Rx%%Sx%%Tx%%Ux%%Vx%%Wx%%Xx%%Yx%%Z
		set %~1=!%~1:xxxxxxxxxxxx=!
		set %~1=!%~1:xxxxxx=!
		set %~1=!%~1:xxxx=!
		set %~1=!%~1:xx=!
	)
	
	set %~1=!%~1:"=!
	
	if not "%~2"=="" (
		shift/1
		goto Convert2OK_Name2
	)
exit/b 0


REM call:LitterConvert [ aA | Aa ] Ҫת���ı���
:��ĸ��Сдת��
:LitterConvert
	REM ��ʼ���ӳ����������
	for %%z in (subroutine) do if defined %%v set %%v=
	set subroutine=LitterConvert
	
	if "%~1"=="" (
		call:ShowErrorMessage [����1]ת������δ��д:aA^(ת��Ϊ��д^)��Aa^(ת��ΪСд^)
		exit/b 1
	) else if not "%~1"=="aA" if not "%~1"=="Aa" (
		call:ShowErrorMessage [����1]%~1��������������aA^(ת��Ϊ��д^)��Aa^(ת��ΪСд^)
		exit/b 1
	)
	:LitterConvert2
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~2"=="" (
		call:ShowErrorMessage [����2]�������Ϊ��
		exit/b 1
	) else if not defined %~2 (
		call:ShowErrorMessage [����2]%~2�������δ����ֵ
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	if "%~1"=="aA" for %%a in ("a=A","b=B","c=C","d=D","e=E","f=F","g=G","h=H","i=I","j=J","k=K","l=L","m=M","n=N","o=O","p=P","q=Q","r=R","s=S","t=T","u=U","v=V","w=W","x=X","y=Y","z=Z") do set %~2=!%~2:%%~a!
	if "%~1"=="Aa" for %%a in ("A=a","B=b","C=c","D=d","E=e","F=f","G=g","H=h","I=i","J=j","K=k","L=l","M=m","N=n","O=o","P=p","Q=q","R=r","S=s","T=t","U=u","V=v","W=w","X=x","Y=y","Z=z") do set %~2=!%~2:%%~a!
	if not "%~3"=="" (
		shift/2
		goto LitterConvert2
	)
exit/b 0

REM call:FindKeywordsCountInFile �ļ� �ؼ��� [ƫ��ֵ]
:���ļ��в��Һ���ָ���ؼ��ֵ��е�����
:FindKeywordsCountInFile
	REM ��ʼ���ӳ����������
	for %%z in (subroutine FindKeywordsCountInFileTemp) do if defined %%v set %%v=
	set subroutine=FindKeywordsCountInFile
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~2"=="" (
		call:ShowErrorMessage [����2]���Ҽ����ؼ���δ��д
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]ָ���ļ�Ϊ��
		exit/b 1
	) else if not exist "%~1" (
		call:ShowErrorMessage [����1]"%~1"ָ���ļ�������
		exit/b 1
	)

	REM �ӳ���������ʼ
	REM find /c "%~2" "%~1"
	for /f "tokens=2,3 delims=:" %%- in ('find /c "%~2" "%~1"') do (
		if "%%."=="" (set FindKeywordsCountInFileTemp=%%-) else set FindKeywordsCountInFileTemp=%%.
	)
	
	if "%FindKeywordsCountInFileTemp: =%"=="0" exit/b 0
	if not "%~3"=="" set /a FindKeywordsCountInFileTemp+=%~3
	if %FindKeywordsCountInFileTemp% leq 0 exit/b 0
	
exit/b %FindKeywordsCountInFileTemp%

REM call:Count ƫ��ֵ ��һ �ڶ� ���� ..
:����
:Count
	REM ��ʼ���ӳ����������
	for %%W in (subroutine Count_DiJia) do if defined %%W set %%W=
	set subroutine=Count
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~2"=="" (
		call:ShowErrorMessage [����2]����ֵΪ��
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]ƫ��ֵΪ��
	)
	
	REM �ӳ���������ʼ
	:Count2
	set /a Count_DiJia+=1
	if "%~3"=="" (
		set /a Count_DiJia+=%~1
		exit/b !Count_DiJia!
	) else (
		shift/2
		goto Count2
	)
exit/b 0

REM call:Content2Variable ������ ������ ��ֵ����1 ��ֵ����2 ��ֵ����3 ...
:���ݸ�ֵ������
:Content2Variable
	REM ��ʼ���ӳ����������
	for %%Y in (subroutine %~1 Content2Variable_Content) do if defined %%Y set %%Y=
	set subroutine=Content2Variable
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~4"=="" (
		call:ShowErrorMessage [����3,*]��ֵ����Ϊ��
		exit/b 1
	)
	if "%~3"=="" (
		call:ShowErrorMessage [����2]������Ϊ��
		exit/b 1
	)
	if "%~1"=="" (
		call:ShowErrorMessage [����1]����������Ϊ��
		exit/b 1
	)
	
	REM �ӳ���������ʼ
	:Content2Variable2
	set Content2Variable_Content=!Content2Variable_Content! %3
	if not "%~4"=="" (
		shift /3
		goto Content2Variable2
	)
	call:Count 0 %Content2Variable_Content%
	if not "%~2"=="%errorlevel%" (
		call:ShowErrorMessage [����]�������븳ֵ����������ͬ
		exit/b 1
	)
	for /l %%V in (1,1,%~2) do (
		set Content2Variable_Content_Choose=
		call:ChooseFromVariable Content2Variable_Content %%V Content2Variable_Content_Choose /nocheck
		set %~1%%V=!Content2Variable_Content_Choose!
	)
exit/b 0


REM call:UnicodeConvert �����ո�ֵ������ ת��ֵ1 ת��ֵ2 ת��ֵ3 ...
:Unicodeת��
:UnicodeConvert
	REM ��ʼ���ӳ����������
	for %%y in (subroutine Unicode_Result %~1) do if defined %%y set %%y=
	set UnicodeTMPFile=TMP\Unicode.TMP
	set subroutine=UnicodeConvert
	
	REM ����ӳ���ʹ�û���������ȷ���
	if "%~1"=="" (
		call:ShowErrorMessage [����1]���ո�ֵ������Ϊ��
		exit/b 1
	)
	:UnicodeConvert2
	if exist "%UnicodeTMPFile%" del /f /q "%UnicodeTMPFile%"
	if "%~2"=="" (
		call:ShowErrorMessage [����2]��ת��ֵΪ��
		exit/b 1
	)
	REM �ӳ���������ʼ
	call:Unicode%~2 2>"%UnicodeTMPFile%"
	for %%y in ("%UnicodeTMPFile%") do if "%%~zy"=="0" (
		set %~1=!%~1!%Unicode_Result%
	) else (
		set %~1=!%~1!%~2
	)
	:UnicodeConvert3
	if not "%~3"=="" (
		shift/2
		goto UnicodeConvert2
	)
exit/b 0

:Unicodenbsp
set Unicode_Result= 
exit/b
:Unicode��
set Unicode_Result=65281
exit/b
:Unicode65281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65509
exit/b
:Unicode65509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8230
exit/b
:Unicode8230
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65288
exit/b
:Unicode65288
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65289
exit/b
:Unicode65289
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8212
exit/b
:Unicode8212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12289
exit/b
:Unicode12289
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12305
exit/b
:Unicode12305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12304
exit/b
:Unicode12304
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65306
exit/b
:Unicode65306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65307
exit/b
:Unicode65307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8220
exit/b
:Unicode8220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8216
exit/b
:Unicode8216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8221
exit/b
:Unicode8221
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=8217
exit/b
:Unicode8217
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12299
exit/b
:Unicode12299
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12298
exit/b
:Unicode12298
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=12290
exit/b
:Unicode12290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=65292
exit/b
:Unicode65292
set Unicode_Result=��
exit/b
:Unicode21834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21834
exit/b
:Unicode38463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38463
exit/b
:Unicode22467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22467
exit/b
:Unicode25384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25384
exit/b
:Unicode21710
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21710
exit/b
:Unicode21769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21769
exit/b
:Unicode21696
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21696
exit/b
:Unicode30353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30353
exit/b
:Unicode30284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30284
exit/b
:Unicode34108
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34108
exit/b
:Unicode30702
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30702
exit/b
:Unicode33406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33406
exit/b
:Unicode30861
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30861
exit/b
:Unicode29233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29233
exit/b
:Unicode38552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38552
exit/b
:Unicode38797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38797
exit/b
:Unicode27688
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27688
exit/b
:Unicode23433
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23433
exit/b
:Unicode20474
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20474
exit/b
:Unicode25353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25353
exit/b
:Unicode26263
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26263
exit/b
:Unicode23736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23736
exit/b
:Unicode33018
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33018
exit/b
:Unicode26696
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26696
exit/b
:Unicode32942
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32942
exit/b
:Unicode26114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26114
exit/b
:Unicode30414
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30414
exit/b
:Unicode20985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20985
exit/b
:Unicode25942
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25942
exit/b
:Unicode29100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29100
exit/b
:Unicode32753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32753
exit/b
:Unicode34948
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34948
exit/b
:Unicode20658
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20658
exit/b
:Unicode22885
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22885
exit/b
:Unicode25034
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25034
exit/b
:Unicode28595
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28595
exit/b
:Unicode33453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33453
exit/b
:Unicode25420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25420
exit/b
:Unicode25170
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25170
exit/b
:Unicode21485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21485
exit/b
:Unicode21543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21543
exit/b
:Unicode31494
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31494
exit/b
:Unicode20843
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20843
exit/b
:Unicode30116
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30116
exit/b
:Unicode24052
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24052
exit/b
:Unicode25300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25300
exit/b
:Unicode36299
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36299
exit/b
:Unicode38774
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38774
exit/b
:Unicode25226
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25226
exit/b
:Unicode32793
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32793
exit/b
:Unicode22365
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22365
exit/b
:Unicode38712
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38712
exit/b
:Unicode32610
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32610
exit/b
:Unicode29240
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29240
exit/b
:Unicode30333
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30333
exit/b
:Unicode26575
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26575
exit/b
:Unicode30334
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30334
exit/b
:Unicode25670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25670
exit/b
:Unicode20336
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20336
exit/b
:Unicode36133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36133
exit/b
:Unicode25308
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25308
exit/b
:Unicode31255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31255
exit/b
:Unicode26001
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26001
exit/b
:Unicode29677
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29677
exit/b
:Unicode25644
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25644
exit/b
:Unicode25203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25203
exit/b
:Unicode33324
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33324
exit/b
:Unicode39041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39041
exit/b
:Unicode26495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26495
exit/b
:Unicode29256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29256
exit/b
:Unicode25198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25198
exit/b
:Unicode25292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25292
exit/b
:Unicode20276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20276
exit/b
:Unicode29923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29923
exit/b
:Unicode21322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21322
exit/b
:Unicode21150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21150
exit/b
:Unicode32458
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32458
exit/b
:Unicode37030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37030
exit/b
:Unicode24110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24110
exit/b
:Unicode26758
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26758
exit/b
:Unicode27036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27036
exit/b
:Unicode33152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33152
exit/b
:Unicode32465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32465
exit/b
:Unicode26834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26834
exit/b
:Unicode30917
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30917
exit/b
:Unicode34444
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34444
exit/b
:Unicode38225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38225
exit/b
:Unicode20621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20621
exit/b
:Unicode35876
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35876
exit/b
:Unicode33502
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33502
exit/b
:Unicode32990
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32990
exit/b
:Unicode21253
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21253
exit/b
:Unicode35090
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35090
exit/b
:Unicode21093
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21093
exit/b
:Unicode34180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34180
exit/b
:Unicode38649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38649
exit/b
:Unicode20445
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20445
exit/b
:Unicode22561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22561
exit/b
:Unicode39281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39281
exit/b
:Unicode23453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23453
exit/b
:Unicode25265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25265
exit/b
:Unicode25253
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25253
exit/b
:Unicode26292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26292
exit/b
:Unicode35961
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35961
exit/b
:Unicode40077
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40077
exit/b
:Unicode29190
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29190
exit/b
:Unicode26479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26479
exit/b
:Unicode30865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30865
exit/b
:Unicode24754
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24754
exit/b
:Unicode21329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21329
exit/b
:Unicode21271
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21271
exit/b
:Unicode36744
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36744
exit/b
:Unicode32972
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32972
exit/b
:Unicode36125
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36125
exit/b
:Unicode38049
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38049
exit/b
:Unicode20493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20493
exit/b
:Unicode29384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29384
exit/b
:Unicode22791
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22791
exit/b
:Unicode24811
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24811
exit/b
:Unicode28953
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28953
exit/b
:Unicode34987
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34987
exit/b
:Unicode22868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22868
exit/b
:Unicode33519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33519
exit/b
:Unicode26412
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26412
exit/b
:Unicode31528
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31528
exit/b
:Unicode23849
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23849
exit/b
:Unicode32503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32503
exit/b
:Unicode29997
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29997
exit/b
:Unicode27893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27893
exit/b
:Unicode36454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36454
exit/b
:Unicode36856
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36856
exit/b
:Unicode36924
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36924
exit/b
:Unicode40763
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40763
exit/b
:Unicode27604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27604
exit/b
:Unicode37145
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37145
exit/b
:Unicode31508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31508
exit/b
:Unicode24444
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24444
exit/b
:Unicode30887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30887
exit/b
:Unicode34006
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34006
exit/b
:Unicode34109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34109
exit/b
:Unicode27605
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27605
exit/b
:Unicode27609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27609
exit/b
:Unicode27606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27606
exit/b
:Unicode24065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24065
exit/b
:Unicode24199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24199
exit/b
:Unicode30201
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30201
exit/b
:Unicode38381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38381
exit/b
:Unicode25949
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25949
exit/b
:Unicode24330
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24330
exit/b
:Unicode24517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24517
exit/b
:Unicode36767
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36767
exit/b
:Unicode22721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22721
exit/b
:Unicode33218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33218
exit/b
:Unicode36991
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36991
exit/b
:Unicode38491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38491
exit/b
:Unicode38829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38829
exit/b
:Unicode36793
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36793
exit/b
:Unicode32534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32534
exit/b
:Unicode36140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36140
exit/b
:Unicode25153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25153
exit/b
:Unicode20415
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20415
exit/b
:Unicode21464
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21464
exit/b
:Unicode21342
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21342
exit/b
:Unicode36776
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36776
exit/b
:Unicode36777
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36777
exit/b
:Unicode36779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36779
exit/b
:Unicode36941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36941
exit/b
:Unicode26631
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26631
exit/b
:Unicode24426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24426
exit/b
:Unicode33176
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33176
exit/b
:Unicode34920
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34920
exit/b
:Unicode40150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40150
exit/b
:Unicode24971
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24971
exit/b
:Unicode21035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21035
exit/b
:Unicode30250
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30250
exit/b
:Unicode24428
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24428
exit/b
:Unicode25996
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25996
exit/b
:Unicode28626
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28626
exit/b
:Unicode28392
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28392
exit/b
:Unicode23486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23486
exit/b
:Unicode25672
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25672
exit/b
:Unicode20853
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20853
exit/b
:Unicode20912
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20912
exit/b
:Unicode26564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26564
exit/b
:Unicode19993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19993
exit/b
:Unicode31177
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31177
exit/b
:Unicode39292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39292
exit/b
:Unicode28851
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28851
exit/b
:Unicode30149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30149
exit/b
:Unicode24182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24182
exit/b
:Unicode29627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29627
exit/b
:Unicode33760
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33760
exit/b
:Unicode25773
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25773
exit/b
:Unicode25320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25320
exit/b
:Unicode38069
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38069
exit/b
:Unicode27874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27874
exit/b
:Unicode21338
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21338
exit/b
:Unicode21187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21187
exit/b
:Unicode25615
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25615
exit/b
:Unicode38082
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38082
exit/b
:Unicode31636
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31636
exit/b
:Unicode20271
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20271
exit/b
:Unicode24091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24091
exit/b
:Unicode33334
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33334
exit/b
:Unicode33046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33046
exit/b
:Unicode33162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33162
exit/b
:Unicode28196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28196
exit/b
:Unicode27850
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27850
exit/b
:Unicode39539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39539
exit/b
:Unicode25429
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25429
exit/b
:Unicode21340
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21340
exit/b
:Unicode21754
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21754
exit/b
:Unicode34917
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34917
exit/b
:Unicode22496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22496
exit/b
:Unicode19981
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19981
exit/b
:Unicode24067
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24067
exit/b
:Unicode27493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27493
exit/b
:Unicode31807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31807
exit/b
:Unicode37096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37096
exit/b
:Unicode24598
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24598
exit/b
:Unicode25830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25830
exit/b
:Unicode29468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29468
exit/b
:Unicode35009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35009
exit/b
:Unicode26448
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26448
exit/b
:Unicode25165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25165
exit/b
:Unicode36130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36130
exit/b
:Unicode30572
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30572
exit/b
:Unicode36393
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36393
exit/b
:Unicode37319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37319
exit/b
:Unicode24425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24425
exit/b
:Unicode33756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33756
exit/b
:Unicode34081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34081
exit/b
:Unicode39184
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39184
exit/b
:Unicode21442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21442
exit/b
:Unicode34453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34453
exit/b
:Unicode27531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27531
exit/b
:Unicode24813
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24813
exit/b
:Unicode24808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24808
exit/b
:Unicode28799
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28799
exit/b
:Unicode33485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33485
exit/b
:Unicode33329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33329
exit/b
:Unicode20179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20179
exit/b
:Unicode27815
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27815
exit/b
:Unicode34255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34255
exit/b
:Unicode25805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25805
exit/b
:Unicode31961
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31961
exit/b
:Unicode27133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27133
exit/b
:Unicode26361
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26361
exit/b
:Unicode33609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33609
exit/b
:Unicode21397
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21397
exit/b
:Unicode31574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31574
exit/b
:Unicode20391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20391
exit/b
:Unicode20876
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20876
exit/b
:Unicode27979
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27979
exit/b
:Unicode23618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23618
exit/b
:Unicode36461
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36461
exit/b
:Unicode25554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25554
exit/b
:Unicode21449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21449
exit/b
:Unicode33580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33580
exit/b
:Unicode33590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33590
exit/b
:Unicode26597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26597
exit/b
:Unicode30900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30900
exit/b
:Unicode25661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25661
exit/b
:Unicode23519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23519
exit/b
:Unicode23700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23700
exit/b
:Unicode24046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24046
exit/b
:Unicode35815
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35815
exit/b
:Unicode25286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25286
exit/b
:Unicode26612
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26612
exit/b
:Unicode35962
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35962
exit/b
:Unicode25600
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25600
exit/b
:Unicode25530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25530
exit/b
:Unicode34633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34633
exit/b
:Unicode39307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39307
exit/b
:Unicode35863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35863
exit/b
:Unicode32544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32544
exit/b
:Unicode38130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38130
exit/b
:Unicode20135
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20135
exit/b
:Unicode38416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38416
exit/b
:Unicode39076
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39076
exit/b
:Unicode26124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26124
exit/b
:Unicode29462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29462
exit/b
:Unicode22330
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22330
exit/b
:Unicode23581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23581
exit/b
:Unicode24120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24120
exit/b
:Unicode38271
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38271
exit/b
:Unicode20607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20607
exit/b
:Unicode32928
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32928
exit/b
:Unicode21378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21378
exit/b
:Unicode25950
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25950
exit/b
:Unicode30021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30021
exit/b
:Unicode21809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21809
exit/b
:Unicode20513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20513
exit/b
:Unicode36229
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36229
exit/b
:Unicode25220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25220
exit/b
:Unicode38046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38046
exit/b
:Unicode26397
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26397
exit/b
:Unicode22066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22066
exit/b
:Unicode28526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28526
exit/b
:Unicode24034
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24034
exit/b
:Unicode21557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21557
exit/b
:Unicode28818
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28818
exit/b
:Unicode36710
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36710
exit/b
:Unicode25199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25199
exit/b
:Unicode25764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25764
exit/b
:Unicode25507
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25507
exit/b
:Unicode24443
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24443
exit/b
:Unicode28552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28552
exit/b
:Unicode37108
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37108
exit/b
:Unicode33251
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33251
exit/b
:Unicode36784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36784
exit/b
:Unicode23576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23576
exit/b
:Unicode26216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26216
exit/b
:Unicode24561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24561
exit/b
:Unicode27785
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27785
exit/b
:Unicode38472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38472
exit/b
:Unicode36225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36225
exit/b
:Unicode34924
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34924
exit/b
:Unicode25745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25745
exit/b
:Unicode31216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31216
exit/b
:Unicode22478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22478
exit/b
:Unicode27225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27225
exit/b
:Unicode25104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25104
exit/b
:Unicode21576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21576
exit/b
:Unicode20056
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20056
exit/b
:Unicode31243
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31243
exit/b
:Unicode24809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24809
exit/b
:Unicode28548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28548
exit/b
:Unicode35802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35802
exit/b
:Unicode25215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25215
exit/b
:Unicode36894
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36894
exit/b
:Unicode39563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39563
exit/b
:Unicode31204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31204
exit/b
:Unicode21507
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21507
exit/b
:Unicode30196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30196
exit/b
:Unicode25345
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25345
exit/b
:Unicode21273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21273
exit/b
:Unicode27744
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27744
exit/b
:Unicode36831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36831
exit/b
:Unicode24347
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24347
exit/b
:Unicode39536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39536
exit/b
:Unicode32827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32827
exit/b
:Unicode40831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40831
exit/b
:Unicode20360
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20360
exit/b
:Unicode23610
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23610
exit/b
:Unicode36196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36196
exit/b
:Unicode32709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32709
exit/b
:Unicode26021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26021
exit/b
:Unicode28861
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28861
exit/b
:Unicode20805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20805
exit/b
:Unicode20914
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20914
exit/b
:Unicode34411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34411
exit/b
:Unicode23815
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23815
exit/b
:Unicode23456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23456
exit/b
:Unicode25277
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25277
exit/b
:Unicode37228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37228
exit/b
:Unicode30068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30068
exit/b
:Unicode36364
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36364
exit/b
:Unicode31264
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31264
exit/b
:Unicode24833
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24833
exit/b
:Unicode31609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31609
exit/b
:Unicode20167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20167
exit/b
:Unicode32504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32504
exit/b
:Unicode30597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30597
exit/b
:Unicode19985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19985
exit/b
:Unicode33261
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33261
exit/b
:Unicode21021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21021
exit/b
:Unicode20986
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20986
exit/b
:Unicode27249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27249
exit/b
:Unicode21416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21416
exit/b
:Unicode36487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36487
exit/b
:Unicode38148
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38148
exit/b
:Unicode38607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38607
exit/b
:Unicode28353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28353
exit/b
:Unicode38500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38500
exit/b
:Unicode26970
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26970
exit/b
:Unicode30784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30784
exit/b
:Unicode20648
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20648
exit/b
:Unicode30679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30679
exit/b
:Unicode25616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25616
exit/b
:Unicode35302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35302
exit/b
:Unicode22788
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22788
exit/b
:Unicode25571
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25571
exit/b
:Unicode24029
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24029
exit/b
:Unicode31359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31359
exit/b
:Unicode26941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26941
exit/b
:Unicode20256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20256
exit/b
:Unicode33337
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33337
exit/b
:Unicode21912
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21912
exit/b
:Unicode20018
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20018
exit/b
:Unicode30126
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30126
exit/b
:Unicode31383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31383
exit/b
:Unicode24162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24162
exit/b
:Unicode24202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24202
exit/b
:Unicode38383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38383
exit/b
:Unicode21019
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21019
exit/b
:Unicode21561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21561
exit/b
:Unicode28810
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28810
exit/b
:Unicode25462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25462
exit/b
:Unicode38180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38180
exit/b
:Unicode22402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22402
exit/b
:Unicode26149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26149
exit/b
:Unicode26943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26943
exit/b
:Unicode37255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37255
exit/b
:Unicode21767
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21767
exit/b
:Unicode28147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28147
exit/b
:Unicode32431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32431
exit/b
:Unicode34850
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34850
exit/b
:Unicode25139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25139
exit/b
:Unicode32496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32496
exit/b
:Unicode30133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30133
exit/b
:Unicode33576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33576
exit/b
:Unicode30913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30913
exit/b
:Unicode38604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38604
exit/b
:Unicode36766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36766
exit/b
:Unicode24904
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24904
exit/b
:Unicode29943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29943
exit/b
:Unicode35789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35789
exit/b
:Unicode27492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27492
exit/b
:Unicode21050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21050
exit/b
:Unicode36176
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36176
exit/b
:Unicode27425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27425
exit/b
:Unicode32874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32874
exit/b
:Unicode33905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33905
exit/b
:Unicode22257
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22257
exit/b
:Unicode21254
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21254
exit/b
:Unicode20174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20174
exit/b
:Unicode19995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19995
exit/b
:Unicode20945
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20945
exit/b
:Unicode31895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31895
exit/b
:Unicode37259
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37259
exit/b
:Unicode31751
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31751
exit/b
:Unicode20419
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20419
exit/b
:Unicode36479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36479
exit/b
:Unicode31713
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31713
exit/b
:Unicode31388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31388
exit/b
:Unicode25703
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25703
exit/b
:Unicode23828
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23828
exit/b
:Unicode20652
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20652
exit/b
:Unicode33030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33030
exit/b
:Unicode30209
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30209
exit/b
:Unicode31929
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31929
exit/b
:Unicode28140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28140
exit/b
:Unicode32736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32736
exit/b
:Unicode26449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26449
exit/b
:Unicode23384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23384
exit/b
:Unicode23544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23544
exit/b
:Unicode30923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30923
exit/b
:Unicode25774
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25774
exit/b
:Unicode25619
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25619
exit/b
:Unicode25514
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25514
exit/b
:Unicode25387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25387
exit/b
:Unicode38169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38169
exit/b
:Unicode25645
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25645
exit/b
:Unicode36798
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36798
exit/b
:Unicode31572
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31572
exit/b
:Unicode30249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30249
exit/b
:Unicode25171
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25171
exit/b
:Unicode22823
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22823
exit/b
:Unicode21574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21574
exit/b
:Unicode27513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27513
exit/b
:Unicode20643
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20643
exit/b
:Unicode25140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25140
exit/b
:Unicode24102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24102
exit/b
:Unicode27526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27526
exit/b
:Unicode20195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20195
exit/b
:Unicode36151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36151
exit/b
:Unicode34955
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34955
exit/b
:Unicode24453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24453
exit/b
:Unicode36910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36910
exit/b
:Unicode24608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24608
exit/b
:Unicode32829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32829
exit/b
:Unicode25285
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25285
exit/b
:Unicode20025
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20025
exit/b
:Unicode21333
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21333
exit/b
:Unicode37112
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37112
exit/b
:Unicode25528
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25528
exit/b
:Unicode32966
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32966
exit/b
:Unicode26086
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26086
exit/b
:Unicode27694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27694
exit/b
:Unicode20294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20294
exit/b
:Unicode24814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24814
exit/b
:Unicode28129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28129
exit/b
:Unicode35806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35806
exit/b
:Unicode24377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24377
exit/b
:Unicode34507
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34507
exit/b
:Unicode24403
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24403
exit/b
:Unicode25377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25377
exit/b
:Unicode20826
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20826
exit/b
:Unicode33633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33633
exit/b
:Unicode26723
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26723
exit/b
:Unicode20992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20992
exit/b
:Unicode25443
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25443
exit/b
:Unicode36424
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36424
exit/b
:Unicode20498
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20498
exit/b
:Unicode23707
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23707
exit/b
:Unicode31095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31095
exit/b
:Unicode23548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23548
exit/b
:Unicode21040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21040
exit/b
:Unicode31291
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31291
exit/b
:Unicode24764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24764
exit/b
:Unicode36947
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36947
exit/b
:Unicode30423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30423
exit/b
:Unicode24503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24503
exit/b
:Unicode24471
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24471
exit/b
:Unicode30340
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30340
exit/b
:Unicode36460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36460
exit/b
:Unicode28783
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28783
exit/b
:Unicode30331
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30331
exit/b
:Unicode31561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31561
exit/b
:Unicode30634
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30634
exit/b
:Unicode20979
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20979
exit/b
:Unicode37011
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37011
exit/b
:Unicode22564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22564
exit/b
:Unicode20302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20302
exit/b
:Unicode28404
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28404
exit/b
:Unicode36842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36842
exit/b
:Unicode25932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25932
exit/b
:Unicode31515
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31515
exit/b
:Unicode29380
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29380
exit/b
:Unicode28068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28068
exit/b
:Unicode32735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32735
exit/b
:Unicode23265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23265
exit/b
:Unicode25269
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25269
exit/b
:Unicode24213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24213
exit/b
:Unicode22320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22320
exit/b
:Unicode33922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33922
exit/b
:Unicode31532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31532
exit/b
:Unicode24093
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24093
exit/b
:Unicode24351
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24351
exit/b
:Unicode36882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36882
exit/b
:Unicode32532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32532
exit/b
:Unicode39072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39072
exit/b
:Unicode25474
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25474
exit/b
:Unicode28359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28359
exit/b
:Unicode30872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30872
exit/b
:Unicode28857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28857
exit/b
:Unicode20856
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20856
exit/b
:Unicode38747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38747
exit/b
:Unicode22443
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22443
exit/b
:Unicode30005
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30005
exit/b
:Unicode20291
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20291
exit/b
:Unicode30008
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30008
exit/b
:Unicode24215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24215
exit/b
:Unicode24806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24806
exit/b
:Unicode22880
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22880
exit/b
:Unicode28096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28096
exit/b
:Unicode27583
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27583
exit/b
:Unicode30857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30857
exit/b
:Unicode21500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21500
exit/b
:Unicode38613
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38613
exit/b
:Unicode20939
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20939
exit/b
:Unicode20993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20993
exit/b
:Unicode25481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25481
exit/b
:Unicode21514
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21514
exit/b
:Unicode38035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38035
exit/b
:Unicode35843
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35843
exit/b
:Unicode36300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36300
exit/b
:Unicode29241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29241
exit/b
:Unicode30879
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30879
exit/b
:Unicode34678
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34678
exit/b
:Unicode36845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36845
exit/b
:Unicode35853
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35853
exit/b
:Unicode21472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21472
exit/b
:Unicode19969
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19969
exit/b
:Unicode30447
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30447
exit/b
:Unicode21486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21486
exit/b
:Unicode38025
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38025
exit/b
:Unicode39030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39030
exit/b
:Unicode40718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40718
exit/b
:Unicode38189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38189
exit/b
:Unicode23450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23450
exit/b
:Unicode35746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35746
exit/b
:Unicode20002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20002
exit/b
:Unicode19996
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19996
exit/b
:Unicode20908
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20908
exit/b
:Unicode33891
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33891
exit/b
:Unicode25026
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25026
exit/b
:Unicode21160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21160
exit/b
:Unicode26635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26635
exit/b
:Unicode20375
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20375
exit/b
:Unicode24683
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24683
exit/b
:Unicode20923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20923
exit/b
:Unicode27934
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27934
exit/b
:Unicode20828
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20828
exit/b
:Unicode25238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25238
exit/b
:Unicode26007
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26007
exit/b
:Unicode38497
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38497
exit/b
:Unicode35910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35910
exit/b
:Unicode36887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36887
exit/b
:Unicode30168
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30168
exit/b
:Unicode37117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37117
exit/b
:Unicode30563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30563
exit/b
:Unicode27602
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27602
exit/b
:Unicode29322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29322
exit/b
:Unicode29420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29420
exit/b
:Unicode35835
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35835
exit/b
:Unicode22581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22581
exit/b
:Unicode30585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30585
exit/b
:Unicode36172
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36172
exit/b
:Unicode26460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26460
exit/b
:Unicode38208
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38208
exit/b
:Unicode32922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32922
exit/b
:Unicode24230
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24230
exit/b
:Unicode28193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28193
exit/b
:Unicode22930
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22930
exit/b
:Unicode31471
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31471
exit/b
:Unicode30701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30701
exit/b
:Unicode38203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38203
exit/b
:Unicode27573
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27573
exit/b
:Unicode26029
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26029
exit/b
:Unicode32526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32526
exit/b
:Unicode22534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22534
exit/b
:Unicode20817
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20817
exit/b
:Unicode38431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38431
exit/b
:Unicode23545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23545
exit/b
:Unicode22697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22697
exit/b
:Unicode21544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21544
exit/b
:Unicode36466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36466
exit/b
:Unicode25958
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25958
exit/b
:Unicode39039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39039
exit/b
:Unicode22244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22244
exit/b
:Unicode38045
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38045
exit/b
:Unicode30462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30462
exit/b
:Unicode36929
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36929
exit/b
:Unicode25479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25479
exit/b
:Unicode21702
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21702
exit/b
:Unicode22810
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22810
exit/b
:Unicode22842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22842
exit/b
:Unicode22427
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22427
exit/b
:Unicode36530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36530
exit/b
:Unicode26421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26421
exit/b
:Unicode36346
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36346
exit/b
:Unicode33333
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33333
exit/b
:Unicode21057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21057
exit/b
:Unicode24816
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24816
exit/b
:Unicode22549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22549
exit/b
:Unicode34558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34558
exit/b
:Unicode23784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23784
exit/b
:Unicode40517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40517
exit/b
:Unicode20420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20420
exit/b
:Unicode39069
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39069
exit/b
:Unicode35769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35769
exit/b
:Unicode23077
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23077
exit/b
:Unicode24694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24694
exit/b
:Unicode21380
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21380
exit/b
:Unicode25212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25212
exit/b
:Unicode36943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36943
exit/b
:Unicode37122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37122
exit/b
:Unicode39295
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39295
exit/b
:Unicode24681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24681
exit/b
:Unicode32780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32780
exit/b
:Unicode20799
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20799
exit/b
:Unicode32819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32819
exit/b
:Unicode23572
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23572
exit/b
:Unicode39285
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39285
exit/b
:Unicode27953
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27953
exit/b
:Unicode20108
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20108
exit/b
:Unicode36144
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36144
exit/b
:Unicode21457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21457
exit/b
:Unicode32602
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32602
exit/b
:Unicode31567
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31567
exit/b
:Unicode20240
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20240
exit/b
:Unicode20047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20047
exit/b
:Unicode38400
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38400
exit/b
:Unicode27861
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27861
exit/b
:Unicode29648
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29648
exit/b
:Unicode34281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34281
exit/b
:Unicode24070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24070
exit/b
:Unicode30058
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30058
exit/b
:Unicode32763
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32763
exit/b
:Unicode27146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27146
exit/b
:Unicode30718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30718
exit/b
:Unicode38034
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38034
exit/b
:Unicode32321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32321
exit/b
:Unicode20961
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20961
exit/b
:Unicode28902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28902
exit/b
:Unicode21453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21453
exit/b
:Unicode36820
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36820
exit/b
:Unicode33539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33539
exit/b
:Unicode36137
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36137
exit/b
:Unicode29359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29359
exit/b
:Unicode39277
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39277
exit/b
:Unicode27867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27867
exit/b
:Unicode22346
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22346
exit/b
:Unicode33459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33459
exit/b
:Unicode26041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26041
exit/b
:Unicode32938
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32938
exit/b
:Unicode25151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25151
exit/b
:Unicode38450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38450
exit/b
:Unicode22952
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22952
exit/b
:Unicode20223
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20223
exit/b
:Unicode35775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35775
exit/b
:Unicode32442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32442
exit/b
:Unicode25918
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25918
exit/b
:Unicode33778
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33778
exit/b
:Unicode38750
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38750
exit/b
:Unicode21857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21857
exit/b
:Unicode39134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39134
exit/b
:Unicode32933
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32933
exit/b
:Unicode21290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21290
exit/b
:Unicode35837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35837
exit/b
:Unicode21536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21536
exit/b
:Unicode32954
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32954
exit/b
:Unicode24223
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24223
exit/b
:Unicode27832
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27832
exit/b
:Unicode36153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36153
exit/b
:Unicode33452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33452
exit/b
:Unicode37210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37210
exit/b
:Unicode21545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21545
exit/b
:Unicode27675
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27675
exit/b
:Unicode20998
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20998
exit/b
:Unicode32439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32439
exit/b
:Unicode22367
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22367
exit/b
:Unicode28954
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28954
exit/b
:Unicode27774
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27774
exit/b
:Unicode31881
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31881
exit/b
:Unicode22859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22859
exit/b
:Unicode20221
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20221
exit/b
:Unicode24575
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24575
exit/b
:Unicode24868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24868
exit/b
:Unicode31914
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31914
exit/b
:Unicode20016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20016
exit/b
:Unicode23553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23553
exit/b
:Unicode26539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26539
exit/b
:Unicode34562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34562
exit/b
:Unicode23792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23792
exit/b
:Unicode38155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38155
exit/b
:Unicode39118
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39118
exit/b
:Unicode30127
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30127
exit/b
:Unicode28925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28925
exit/b
:Unicode36898
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36898
exit/b
:Unicode20911
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20911
exit/b
:Unicode32541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32541
exit/b
:Unicode35773
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35773
exit/b
:Unicode22857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22857
exit/b
:Unicode20964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20964
exit/b
:Unicode20315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20315
exit/b
:Unicode21542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21542
exit/b
:Unicode22827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22827
exit/b
:Unicode25975
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25975
exit/b
:Unicode32932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32932
exit/b
:Unicode23413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23413
exit/b
:Unicode25206
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25206
exit/b
:Unicode25282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25282
exit/b
:Unicode36752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36752
exit/b
:Unicode24133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24133
exit/b
:Unicode27679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27679
exit/b
:Unicode31526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31526
exit/b
:Unicode20239
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20239
exit/b
:Unicode20440
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20440
exit/b
:Unicode26381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26381
exit/b
:Unicode28014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28014
exit/b
:Unicode28074
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28074
exit/b
:Unicode31119
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31119
exit/b
:Unicode34993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34993
exit/b
:Unicode24343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24343
exit/b
:Unicode29995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29995
exit/b
:Unicode25242
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25242
exit/b
:Unicode36741
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36741
exit/b
:Unicode20463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20463
exit/b
:Unicode37340
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37340
exit/b
:Unicode26023
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26023
exit/b
:Unicode33071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33071
exit/b
:Unicode33105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33105
exit/b
:Unicode24220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24220
exit/b
:Unicode33104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33104
exit/b
:Unicode36212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36212
exit/b
:Unicode21103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21103
exit/b
:Unicode35206
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35206
exit/b
:Unicode36171
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36171
exit/b
:Unicode22797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22797
exit/b
:Unicode20613
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20613
exit/b
:Unicode20184
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20184
exit/b
:Unicode38428
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38428
exit/b
:Unicode29238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29238
exit/b
:Unicode33145
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33145
exit/b
:Unicode36127
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36127
exit/b
:Unicode23500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23500
exit/b
:Unicode35747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35747
exit/b
:Unicode38468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38468
exit/b
:Unicode22919
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22919
exit/b
:Unicode32538
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32538
exit/b
:Unicode21648
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21648
exit/b
:Unicode22134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22134
exit/b
:Unicode22030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22030
exit/b
:Unicode35813
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35813
exit/b
:Unicode25913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25913
exit/b
:Unicode27010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27010
exit/b
:Unicode38041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38041
exit/b
:Unicode30422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30422
exit/b
:Unicode28297
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28297
exit/b
:Unicode24178
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24178
exit/b
:Unicode29976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29976
exit/b
:Unicode26438
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26438
exit/b
:Unicode26577
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26577
exit/b
:Unicode31487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31487
exit/b
:Unicode32925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32925
exit/b
:Unicode36214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36214
exit/b
:Unicode24863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24863
exit/b
:Unicode31174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31174
exit/b
:Unicode25954
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25954
exit/b
:Unicode36195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36195
exit/b
:Unicode20872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20872
exit/b
:Unicode21018
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21018
exit/b
:Unicode38050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38050
exit/b
:Unicode32568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32568
exit/b
:Unicode32923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32923
exit/b
:Unicode32434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32434
exit/b
:Unicode23703
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23703
exit/b
:Unicode28207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28207
exit/b
:Unicode26464
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26464
exit/b
:Unicode31705
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31705
exit/b
:Unicode30347
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30347
exit/b
:Unicode39640
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39640
exit/b
:Unicode33167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33167
exit/b
:Unicode32660
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32660
exit/b
:Unicode31957
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31957
exit/b
:Unicode25630
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25630
exit/b
:Unicode38224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38224
exit/b
:Unicode31295
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31295
exit/b
:Unicode21578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21578
exit/b
:Unicode21733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21733
exit/b
:Unicode27468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27468
exit/b
:Unicode25601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25601
exit/b
:Unicode25096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25096
exit/b
:Unicode40509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40509
exit/b
:Unicode33011
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33011
exit/b
:Unicode30105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30105
exit/b
:Unicode21106
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21106
exit/b
:Unicode38761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38761
exit/b
:Unicode33883
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33883
exit/b
:Unicode26684
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26684
exit/b
:Unicode34532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34532
exit/b
:Unicode38401
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38401
exit/b
:Unicode38548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38548
exit/b
:Unicode38124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38124
exit/b
:Unicode20010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20010
exit/b
:Unicode21508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21508
exit/b
:Unicode32473
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32473
exit/b
:Unicode26681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26681
exit/b
:Unicode36319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36319
exit/b
:Unicode32789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32789
exit/b
:Unicode26356
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26356
exit/b
:Unicode24218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24218
exit/b
:Unicode32697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32697
exit/b
:Unicode22466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22466
exit/b
:Unicode32831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32831
exit/b
:Unicode26775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26775
exit/b
:Unicode24037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24037
exit/b
:Unicode25915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25915
exit/b
:Unicode21151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21151
exit/b
:Unicode24685
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24685
exit/b
:Unicode40858
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40858
exit/b
:Unicode20379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20379
exit/b
:Unicode36524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36524
exit/b
:Unicode20844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20844
exit/b
:Unicode23467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23467
exit/b
:Unicode24339
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24339
exit/b
:Unicode24041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24041
exit/b
:Unicode27742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27742
exit/b
:Unicode25329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25329
exit/b
:Unicode36129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36129
exit/b
:Unicode20849
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20849
exit/b
:Unicode38057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38057
exit/b
:Unicode21246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21246
exit/b
:Unicode27807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27807
exit/b
:Unicode33503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33503
exit/b
:Unicode29399
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29399
exit/b
:Unicode22434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22434
exit/b
:Unicode26500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26500
exit/b
:Unicode36141
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36141
exit/b
:Unicode22815
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22815
exit/b
:Unicode36764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36764
exit/b
:Unicode33735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33735
exit/b
:Unicode21653
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21653
exit/b
:Unicode31629
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31629
exit/b
:Unicode20272
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20272
exit/b
:Unicode27837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27837
exit/b
:Unicode23396
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23396
exit/b
:Unicode22993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22993
exit/b
:Unicode40723
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40723
exit/b
:Unicode21476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21476
exit/b
:Unicode34506
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34506
exit/b
:Unicode39592
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39592
exit/b
:Unicode35895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35895
exit/b
:Unicode32929
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32929
exit/b
:Unicode25925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25925
exit/b
:Unicode39038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39038
exit/b
:Unicode22266
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22266
exit/b
:Unicode38599
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38599
exit/b
:Unicode21038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21038
exit/b
:Unicode29916
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29916
exit/b
:Unicode21072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21072
exit/b
:Unicode23521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23521
exit/b
:Unicode25346
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25346
exit/b
:Unicode35074
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35074
exit/b
:Unicode20054
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20054
exit/b
:Unicode25296
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25296
exit/b
:Unicode24618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24618
exit/b
:Unicode26874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26874
exit/b
:Unicode20851
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20851
exit/b
:Unicode23448
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23448
exit/b
:Unicode20896
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20896
exit/b
:Unicode35266
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35266
exit/b
:Unicode31649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31649
exit/b
:Unicode39302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39302
exit/b
:Unicode32592
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32592
exit/b
:Unicode24815
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24815
exit/b
:Unicode28748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28748
exit/b
:Unicode36143
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36143
exit/b
:Unicode20809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20809
exit/b
:Unicode24191
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24191
exit/b
:Unicode36891
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36891
exit/b
:Unicode29808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29808
exit/b
:Unicode35268
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35268
exit/b
:Unicode22317
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22317
exit/b
:Unicode30789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30789
exit/b
:Unicode24402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24402
exit/b
:Unicode40863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40863
exit/b
:Unicode38394
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38394
exit/b
:Unicode36712
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36712
exit/b
:Unicode39740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39740
exit/b
:Unicode35809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35809
exit/b
:Unicode30328
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30328
exit/b
:Unicode26690
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26690
exit/b
:Unicode26588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26588
exit/b
:Unicode36330
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36330
exit/b
:Unicode36149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36149
exit/b
:Unicode21053
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21053
exit/b
:Unicode36746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36746
exit/b
:Unicode28378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28378
exit/b
:Unicode26829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26829
exit/b
:Unicode38149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38149
exit/b
:Unicode37101
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37101
exit/b
:Unicode22269
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22269
exit/b
:Unicode26524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26524
exit/b
:Unicode35065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35065
exit/b
:Unicode36807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36807
exit/b
:Unicode21704
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21704
exit/b
:Unicode39608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39608
exit/b
:Unicode23401
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23401
exit/b
:Unicode28023
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28023
exit/b
:Unicode27686
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27686
exit/b
:Unicode20133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20133
exit/b
:Unicode23475
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23475
exit/b
:Unicode39559
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39559
exit/b
:Unicode37219
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37219
exit/b
:Unicode25000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25000
exit/b
:Unicode37039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37039
exit/b
:Unicode38889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38889
exit/b
:Unicode21547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21547
exit/b
:Unicode28085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28085
exit/b
:Unicode23506
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23506
exit/b
:Unicode20989
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20989
exit/b
:Unicode21898
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21898
exit/b
:Unicode32597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32597
exit/b
:Unicode32752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32752
exit/b
:Unicode25788
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25788
exit/b
:Unicode25421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25421
exit/b
:Unicode26097
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26097
exit/b
:Unicode25022
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25022
exit/b
:Unicode24717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24717
exit/b
:Unicode28938
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28938
exit/b
:Unicode27735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27735
exit/b
:Unicode27721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27721
exit/b
:Unicode22831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22831
exit/b
:Unicode26477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26477
exit/b
:Unicode33322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33322
exit/b
:Unicode22741
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22741
exit/b
:Unicode22158
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22158
exit/b
:Unicode35946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35946
exit/b
:Unicode27627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27627
exit/b
:Unicode37085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37085
exit/b
:Unicode22909
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22909
exit/b
:Unicode32791
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32791
exit/b
:Unicode21495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21495
exit/b
:Unicode28009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28009
exit/b
:Unicode21621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21621
exit/b
:Unicode21917
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21917
exit/b
:Unicode33655
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33655
exit/b
:Unicode33743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33743
exit/b
:Unicode26680
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26680
exit/b
:Unicode31166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31166
exit/b
:Unicode21644
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21644
exit/b
:Unicode20309
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20309
exit/b
:Unicode21512
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21512
exit/b
:Unicode30418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30418
exit/b
:Unicode35977
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35977
exit/b
:Unicode38402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38402
exit/b
:Unicode27827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27827
exit/b
:Unicode28088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28088
exit/b
:Unicode36203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36203
exit/b
:Unicode35088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35088
exit/b
:Unicode40548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40548
exit/b
:Unicode36154
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36154
exit/b
:Unicode22079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22079
exit/b
:Unicode40657
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40657
exit/b
:Unicode30165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30165
exit/b
:Unicode24456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24456
exit/b
:Unicode29408
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29408
exit/b
:Unicode24680
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24680
exit/b
:Unicode21756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21756
exit/b
:Unicode20136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20136
exit/b
:Unicode27178
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27178
exit/b
:Unicode34913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34913
exit/b
:Unicode24658
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24658
exit/b
:Unicode36720
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36720
exit/b
:Unicode21700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21700
exit/b
:Unicode28888
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28888
exit/b
:Unicode34425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34425
exit/b
:Unicode40511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40511
exit/b
:Unicode27946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27946
exit/b
:Unicode23439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23439
exit/b
:Unicode24344
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24344
exit/b
:Unicode32418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32418
exit/b
:Unicode21897
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21897
exit/b
:Unicode20399
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20399
exit/b
:Unicode29492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29492
exit/b
:Unicode21564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21564
exit/b
:Unicode21402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21402
exit/b
:Unicode20505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20505
exit/b
:Unicode21518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21518
exit/b
:Unicode21628
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21628
exit/b
:Unicode20046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20046
exit/b
:Unicode24573
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24573
exit/b
:Unicode29786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29786
exit/b
:Unicode22774
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22774
exit/b
:Unicode33899
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33899
exit/b
:Unicode32993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32993
exit/b
:Unicode34676
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34676
exit/b
:Unicode29392
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29392
exit/b
:Unicode31946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31946
exit/b
:Unicode28246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28246
exit/b
:Unicode24359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24359
exit/b
:Unicode34382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34382
exit/b
:Unicode21804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21804
exit/b
:Unicode25252
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25252
exit/b
:Unicode20114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20114
exit/b
:Unicode27818
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27818
exit/b
:Unicode25143
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25143
exit/b
:Unicode33457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33457
exit/b
:Unicode21719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21719
exit/b
:Unicode21326
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21326
exit/b
:Unicode29502
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29502
exit/b
:Unicode28369
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28369
exit/b
:Unicode30011
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30011
exit/b
:Unicode21010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21010
exit/b
:Unicode21270
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21270
exit/b
:Unicode35805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35805
exit/b
:Unicode27088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27088
exit/b
:Unicode24458
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24458
exit/b
:Unicode24576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24576
exit/b
:Unicode28142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28142
exit/b
:Unicode22351
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22351
exit/b
:Unicode27426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27426
exit/b
:Unicode29615
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29615
exit/b
:Unicode26707
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26707
exit/b
:Unicode36824
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36824
exit/b
:Unicode32531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32531
exit/b
:Unicode25442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25442
exit/b
:Unicode24739
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24739
exit/b
:Unicode21796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21796
exit/b
:Unicode30186
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30186
exit/b
:Unicode35938
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35938
exit/b
:Unicode28949
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28949
exit/b
:Unicode28067
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28067
exit/b
:Unicode23462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23462
exit/b
:Unicode24187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24187
exit/b
:Unicode33618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33618
exit/b
:Unicode24908
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24908
exit/b
:Unicode40644
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40644
exit/b
:Unicode30970
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30970
exit/b
:Unicode34647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34647
exit/b
:Unicode31783
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31783
exit/b
:Unicode30343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30343
exit/b
:Unicode20976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20976
exit/b
:Unicode24822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24822
exit/b
:Unicode29004
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29004
exit/b
:Unicode26179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26179
exit/b
:Unicode24140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24140
exit/b
:Unicode24653
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24653
exit/b
:Unicode35854
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35854
exit/b
:Unicode28784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28784
exit/b
:Unicode25381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25381
exit/b
:Unicode36745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36745
exit/b
:Unicode24509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24509
exit/b
:Unicode24674
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24674
exit/b
:Unicode34516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34516
exit/b
:Unicode22238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22238
exit/b
:Unicode27585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27585
exit/b
:Unicode24724
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24724
exit/b
:Unicode24935
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24935
exit/b
:Unicode21321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21321
exit/b
:Unicode24800
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24800
exit/b
:Unicode26214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26214
exit/b
:Unicode36159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36159
exit/b
:Unicode31229
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31229
exit/b
:Unicode20250
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20250
exit/b
:Unicode28905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28905
exit/b
:Unicode27719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27719
exit/b
:Unicode35763
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35763
exit/b
:Unicode35826
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35826
exit/b
:Unicode32472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32472
exit/b
:Unicode33636
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33636
exit/b
:Unicode26127
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26127
exit/b
:Unicode23130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23130
exit/b
:Unicode39746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39746
exit/b
:Unicode27985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27985
exit/b
:Unicode28151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28151
exit/b
:Unicode35905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35905
exit/b
:Unicode27963
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27963
exit/b
:Unicode20249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20249
exit/b
:Unicode28779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28779
exit/b
:Unicode33719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33719
exit/b
:Unicode25110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25110
exit/b
:Unicode24785
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24785
exit/b
:Unicode38669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38669
exit/b
:Unicode36135
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36135
exit/b
:Unicode31096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31096
exit/b
:Unicode20987
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20987
exit/b
:Unicode22334
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22334
exit/b
:Unicode22522
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22522
exit/b
:Unicode26426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26426
exit/b
:Unicode30072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30072
exit/b
:Unicode31293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31293
exit/b
:Unicode31215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31215
exit/b
:Unicode31637
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31637
exit/b
:Unicode32908
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32908
exit/b
:Unicode39269
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39269
exit/b
:Unicode36857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36857
exit/b
:Unicode28608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28608
exit/b
:Unicode35749
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35749
exit/b
:Unicode40481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40481
exit/b
:Unicode23020
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23020
exit/b
:Unicode32489
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32489
exit/b
:Unicode32521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32521
exit/b
:Unicode21513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21513
exit/b
:Unicode26497
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26497
exit/b
:Unicode26840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26840
exit/b
:Unicode36753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36753
exit/b
:Unicode31821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31821
exit/b
:Unicode38598
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38598
exit/b
:Unicode21450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21450
exit/b
:Unicode24613
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24613
exit/b
:Unicode30142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30142
exit/b
:Unicode27762
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27762
exit/b
:Unicode21363
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21363
exit/b
:Unicode23241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23241
exit/b
:Unicode32423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32423
exit/b
:Unicode25380
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25380
exit/b
:Unicode20960
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20960
exit/b
:Unicode33034
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33034
exit/b
:Unicode24049
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24049
exit/b
:Unicode34015
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34015
exit/b
:Unicode25216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25216
exit/b
:Unicode20864
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20864
exit/b
:Unicode23395
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23395
exit/b
:Unicode20238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20238
exit/b
:Unicode31085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31085
exit/b
:Unicode21058
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21058
exit/b
:Unicode24760
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24760
exit/b
:Unicode27982
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27982
exit/b
:Unicode23492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23492
exit/b
:Unicode23490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23490
exit/b
:Unicode35745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35745
exit/b
:Unicode35760
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35760
exit/b
:Unicode26082
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26082
exit/b
:Unicode24524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24524
exit/b
:Unicode38469
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38469
exit/b
:Unicode22931
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22931
exit/b
:Unicode32487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32487
exit/b
:Unicode32426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32426
exit/b
:Unicode22025
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22025
exit/b
:Unicode26551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26551
exit/b
:Unicode22841
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22841
exit/b
:Unicode20339
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20339
exit/b
:Unicode23478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23478
exit/b
:Unicode21152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21152
exit/b
:Unicode33626
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33626
exit/b
:Unicode39050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39050
exit/b
:Unicode36158
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36158
exit/b
:Unicode30002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30002
exit/b
:Unicode38078
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38078
exit/b
:Unicode20551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20551
exit/b
:Unicode31292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31292
exit/b
:Unicode20215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20215
exit/b
:Unicode26550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26550
exit/b
:Unicode39550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39550
exit/b
:Unicode23233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23233
exit/b
:Unicode27516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27516
exit/b
:Unicode30417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30417
exit/b
:Unicode22362
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22362
exit/b
:Unicode23574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23574
exit/b
:Unicode31546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31546
exit/b
:Unicode38388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38388
exit/b
:Unicode29006
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29006
exit/b
:Unicode20860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20860
exit/b
:Unicode32937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32937
exit/b
:Unicode33392
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33392
exit/b
:Unicode22904
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22904
exit/b
:Unicode32516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32516
exit/b
:Unicode33575
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33575
exit/b
:Unicode26816
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26816
exit/b
:Unicode26604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26604
exit/b
:Unicode30897
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30897
exit/b
:Unicode30839
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30839
exit/b
:Unicode25315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25315
exit/b
:Unicode25441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25441
exit/b
:Unicode31616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31616
exit/b
:Unicode20461
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20461
exit/b
:Unicode21098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21098
exit/b
:Unicode20943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20943
exit/b
:Unicode33616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33616
exit/b
:Unicode27099
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27099
exit/b
:Unicode37492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37492
exit/b
:Unicode36341
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36341
exit/b
:Unicode36145
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36145
exit/b
:Unicode35265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35265
exit/b
:Unicode38190
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38190
exit/b
:Unicode31661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31661
exit/b
:Unicode20214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20214
exit/b
:Unicode20581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20581
exit/b
:Unicode33328
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33328
exit/b
:Unicode21073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21073
exit/b
:Unicode39279
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39279
exit/b
:Unicode28176
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28176
exit/b
:Unicode28293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28293
exit/b
:Unicode28071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28071
exit/b
:Unicode24314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24314
exit/b
:Unicode20725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20725
exit/b
:Unicode23004
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23004
exit/b
:Unicode23558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23558
exit/b
:Unicode27974
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27974
exit/b
:Unicode27743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27743
exit/b
:Unicode30086
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30086
exit/b
:Unicode33931
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33931
exit/b
:Unicode26728
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26728
exit/b
:Unicode22870
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22870
exit/b
:Unicode35762
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35762
exit/b
:Unicode21280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21280
exit/b
:Unicode37233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37233
exit/b
:Unicode38477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38477
exit/b
:Unicode34121
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34121
exit/b
:Unicode26898
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26898
exit/b
:Unicode30977
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30977
exit/b
:Unicode28966
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28966
exit/b
:Unicode33014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33014
exit/b
:Unicode20132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20132
exit/b
:Unicode37066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37066
exit/b
:Unicode27975
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27975
exit/b
:Unicode39556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39556
exit/b
:Unicode23047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23047
exit/b
:Unicode22204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22204
exit/b
:Unicode25605
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25605
exit/b
:Unicode38128
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38128
exit/b
:Unicode30699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30699
exit/b
:Unicode20389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20389
exit/b
:Unicode33050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33050
exit/b
:Unicode29409
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29409
exit/b
:Unicode35282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35282
exit/b
:Unicode39290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39290
exit/b
:Unicode32564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32564
exit/b
:Unicode32478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32478
exit/b
:Unicode21119
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21119
exit/b
:Unicode25945
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25945
exit/b
:Unicode37237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37237
exit/b
:Unicode36735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36735
exit/b
:Unicode36739
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36739
exit/b
:Unicode21483
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21483
exit/b
:Unicode31382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31382
exit/b
:Unicode25581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25581
exit/b
:Unicode25509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25509
exit/b
:Unicode30342
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30342
exit/b
:Unicode31224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31224
exit/b
:Unicode34903
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34903
exit/b
:Unicode38454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38454
exit/b
:Unicode25130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25130
exit/b
:Unicode21163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21163
exit/b
:Unicode33410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33410
exit/b
:Unicode26708
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26708
exit/b
:Unicode26480
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26480
exit/b
:Unicode25463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25463
exit/b
:Unicode30571
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30571
exit/b
:Unicode31469
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31469
exit/b
:Unicode27905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27905
exit/b
:Unicode32467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32467
exit/b
:Unicode35299
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35299
exit/b
:Unicode22992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22992
exit/b
:Unicode25106
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25106
exit/b
:Unicode34249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34249
exit/b
:Unicode33445
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33445
exit/b
:Unicode30028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30028
exit/b
:Unicode20511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20511
exit/b
:Unicode20171
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20171
exit/b
:Unicode30117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30117
exit/b
:Unicode35819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35819
exit/b
:Unicode23626
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23626
exit/b
:Unicode24062
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24062
exit/b
:Unicode31563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31563
exit/b
:Unicode26020
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26020
exit/b
:Unicode37329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37329
exit/b
:Unicode20170
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20170
exit/b
:Unicode27941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27941
exit/b
:Unicode35167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35167
exit/b
:Unicode32039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32039
exit/b
:Unicode38182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38182
exit/b
:Unicode20165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20165
exit/b
:Unicode35880
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35880
exit/b
:Unicode36827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36827
exit/b
:Unicode38771
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38771
exit/b
:Unicode26187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26187
exit/b
:Unicode31105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31105
exit/b
:Unicode36817
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36817
exit/b
:Unicode28908
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28908
exit/b
:Unicode28024
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28024
exit/b
:Unicode23613
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23613
exit/b
:Unicode21170
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21170
exit/b
:Unicode33606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33606
exit/b
:Unicode20834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20834
exit/b
:Unicode33550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33550
exit/b
:Unicode30555
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30555
exit/b
:Unicode26230
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26230
exit/b
:Unicode40120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40120
exit/b
:Unicode20140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20140
exit/b
:Unicode24778
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24778
exit/b
:Unicode31934
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31934
exit/b
:Unicode31923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31923
exit/b
:Unicode32463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32463
exit/b
:Unicode20117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20117
exit/b
:Unicode35686
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35686
exit/b
:Unicode26223
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26223
exit/b
:Unicode39048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39048
exit/b
:Unicode38745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38745
exit/b
:Unicode22659
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22659
exit/b
:Unicode25964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25964
exit/b
:Unicode38236
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38236
exit/b
:Unicode24452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24452
exit/b
:Unicode30153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30153
exit/b
:Unicode38742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38742
exit/b
:Unicode31455
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31455
exit/b
:Unicode31454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31454
exit/b
:Unicode20928
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20928
exit/b
:Unicode28847
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28847
exit/b
:Unicode31384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31384
exit/b
:Unicode25578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25578
exit/b
:Unicode31350
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31350
exit/b
:Unicode32416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32416
exit/b
:Unicode29590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29590
exit/b
:Unicode38893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38893
exit/b
:Unicode20037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20037
exit/b
:Unicode28792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28792
exit/b
:Unicode20061
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20061
exit/b
:Unicode37202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37202
exit/b
:Unicode21417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21417
exit/b
:Unicode25937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25937
exit/b
:Unicode26087
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26087
exit/b
:Unicode33276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33276
exit/b
:Unicode33285
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33285
exit/b
:Unicode21646
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21646
exit/b
:Unicode23601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23601
exit/b
:Unicode30106
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30106
exit/b
:Unicode38816
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38816
exit/b
:Unicode25304
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25304
exit/b
:Unicode29401
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29401
exit/b
:Unicode30141
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30141
exit/b
:Unicode23621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23621
exit/b
:Unicode39545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39545
exit/b
:Unicode33738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33738
exit/b
:Unicode23616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23616
exit/b
:Unicode21632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21632
exit/b
:Unicode30697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30697
exit/b
:Unicode20030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20030
exit/b
:Unicode27822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27822
exit/b
:Unicode32858
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32858
exit/b
:Unicode25298
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25298
exit/b
:Unicode25454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25454
exit/b
:Unicode24040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24040
exit/b
:Unicode20855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20855
exit/b
:Unicode36317
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36317
exit/b
:Unicode36382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36382
exit/b
:Unicode38191
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38191
exit/b
:Unicode20465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20465
exit/b
:Unicode21477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21477
exit/b
:Unicode24807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24807
exit/b
:Unicode28844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28844
exit/b
:Unicode21095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21095
exit/b
:Unicode25424
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25424
exit/b
:Unicode40515
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40515
exit/b
:Unicode23071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23071
exit/b
:Unicode20518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20518
exit/b
:Unicode30519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30519
exit/b
:Unicode21367
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21367
exit/b
:Unicode32482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32482
exit/b
:Unicode25733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25733
exit/b
:Unicode25899
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25899
exit/b
:Unicode25225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25225
exit/b
:Unicode25496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25496
exit/b
:Unicode20500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20500
exit/b
:Unicode29237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29237
exit/b
:Unicode35273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35273
exit/b
:Unicode20915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20915
exit/b
:Unicode35776
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35776
exit/b
:Unicode32477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32477
exit/b
:Unicode22343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22343
exit/b
:Unicode33740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33740
exit/b
:Unicode38055
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38055
exit/b
:Unicode20891
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20891
exit/b
:Unicode21531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21531
exit/b
:Unicode23803
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23803
exit/b
:Unicode20426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20426
exit/b
:Unicode31459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31459
exit/b
:Unicode27994
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27994
exit/b
:Unicode37089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37089
exit/b
:Unicode39567
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39567
exit/b
:Unicode21888
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21888
exit/b
:Unicode21654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21654
exit/b
:Unicode21345
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21345
exit/b
:Unicode21679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21679
exit/b
:Unicode24320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24320
exit/b
:Unicode25577
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25577
exit/b
:Unicode26999
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26999
exit/b
:Unicode20975
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20975
exit/b
:Unicode24936
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24936
exit/b
:Unicode21002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21002
exit/b
:Unicode22570
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22570
exit/b
:Unicode21208
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21208
exit/b
:Unicode22350
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22350
exit/b
:Unicode30733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30733
exit/b
:Unicode30475
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30475
exit/b
:Unicode24247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24247
exit/b
:Unicode24951
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24951
exit/b
:Unicode31968
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31968
exit/b
:Unicode25179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25179
exit/b
:Unicode25239
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25239
exit/b
:Unicode20130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20130
exit/b
:Unicode28821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28821
exit/b
:Unicode32771
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32771
exit/b
:Unicode25335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25335
exit/b
:Unicode28900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28900
exit/b
:Unicode38752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38752
exit/b
:Unicode22391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22391
exit/b
:Unicode33499
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33499
exit/b
:Unicode26607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26607
exit/b
:Unicode26869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26869
exit/b
:Unicode30933
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30933
exit/b
:Unicode39063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39063
exit/b
:Unicode31185
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31185
exit/b
:Unicode22771
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22771
exit/b
:Unicode21683
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21683
exit/b
:Unicode21487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21487
exit/b
:Unicode28212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28212
exit/b
:Unicode20811
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20811
exit/b
:Unicode21051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21051
exit/b
:Unicode23458
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23458
exit/b
:Unicode35838
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35838
exit/b
:Unicode32943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32943
exit/b
:Unicode21827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21827
exit/b
:Unicode22438
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22438
exit/b
:Unicode24691
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24691
exit/b
:Unicode22353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22353
exit/b
:Unicode21549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21549
exit/b
:Unicode31354
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31354
exit/b
:Unicode24656
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24656
exit/b
:Unicode23380
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23380
exit/b
:Unicode25511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25511
exit/b
:Unicode25248
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25248
exit/b
:Unicode21475
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21475
exit/b
:Unicode25187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25187
exit/b
:Unicode23495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23495
exit/b
:Unicode26543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26543
exit/b
:Unicode21741
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21741
exit/b
:Unicode31391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31391
exit/b
:Unicode33510
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33510
exit/b
:Unicode37239
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37239
exit/b
:Unicode24211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24211
exit/b
:Unicode35044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35044
exit/b
:Unicode22840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22840
exit/b
:Unicode22446
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22446
exit/b
:Unicode25358
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25358
exit/b
:Unicode36328
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36328
exit/b
:Unicode33007
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33007
exit/b
:Unicode22359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22359
exit/b
:Unicode31607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31607
exit/b
:Unicode20393
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20393
exit/b
:Unicode24555
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24555
exit/b
:Unicode23485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23485
exit/b
:Unicode27454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27454
exit/b
:Unicode21281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21281
exit/b
:Unicode31568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31568
exit/b
:Unicode29378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29378
exit/b
:Unicode26694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26694
exit/b
:Unicode30719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30719
exit/b
:Unicode30518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30518
exit/b
:Unicode26103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26103
exit/b
:Unicode20917
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20917
exit/b
:Unicode20111
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20111
exit/b
:Unicode30420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30420
exit/b
:Unicode23743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23743
exit/b
:Unicode31397
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31397
exit/b
:Unicode33909
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33909
exit/b
:Unicode22862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22862
exit/b
:Unicode39745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39745
exit/b
:Unicode20608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20608
exit/b
:Unicode39304
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39304
exit/b
:Unicode24871
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24871
exit/b
:Unicode28291
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28291
exit/b
:Unicode22372
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22372
exit/b
:Unicode26118
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26118
exit/b
:Unicode25414
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25414
exit/b
:Unicode22256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22256
exit/b
:Unicode25324
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25324
exit/b
:Unicode25193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25193
exit/b
:Unicode24275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24275
exit/b
:Unicode38420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38420
exit/b
:Unicode22403
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22403
exit/b
:Unicode25289
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25289
exit/b
:Unicode21895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21895
exit/b
:Unicode34593
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34593
exit/b
:Unicode33098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33098
exit/b
:Unicode36771
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36771
exit/b
:Unicode21862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21862
exit/b
:Unicode33713
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33713
exit/b
:Unicode26469
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26469
exit/b
:Unicode36182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36182
exit/b
:Unicode34013
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34013
exit/b
:Unicode23146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23146
exit/b
:Unicode26639
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26639
exit/b
:Unicode25318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25318
exit/b
:Unicode31726
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31726
exit/b
:Unicode38417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38417
exit/b
:Unicode20848
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20848
exit/b
:Unicode28572
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28572
exit/b
:Unicode35888
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35888
exit/b
:Unicode25597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25597
exit/b
:Unicode35272
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35272
exit/b
:Unicode25042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25042
exit/b
:Unicode32518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32518
exit/b
:Unicode28866
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28866
exit/b
:Unicode28389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28389
exit/b
:Unicode29701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29701
exit/b
:Unicode27028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27028
exit/b
:Unicode29436
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29436
exit/b
:Unicode24266
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24266
exit/b
:Unicode37070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37070
exit/b
:Unicode26391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26391
exit/b
:Unicode28010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28010
exit/b
:Unicode25438
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25438
exit/b
:Unicode21171
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21171
exit/b
:Unicode29282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29282
exit/b
:Unicode32769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32769
exit/b
:Unicode20332
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20332
exit/b
:Unicode23013
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23013
exit/b
:Unicode37226
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37226
exit/b
:Unicode28889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28889
exit/b
:Unicode28061
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28061
exit/b
:Unicode21202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21202
exit/b
:Unicode20048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20048
exit/b
:Unicode38647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38647
exit/b
:Unicode38253
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38253
exit/b
:Unicode34174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34174
exit/b
:Unicode30922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30922
exit/b
:Unicode32047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32047
exit/b
:Unicode20769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20769
exit/b
:Unicode22418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22418
exit/b
:Unicode25794
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25794
exit/b
:Unicode32907
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32907
exit/b
:Unicode31867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31867
exit/b
:Unicode27882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27882
exit/b
:Unicode26865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26865
exit/b
:Unicode26974
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26974
exit/b
:Unicode20919
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20919
exit/b
:Unicode21400
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21400
exit/b
:Unicode26792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26792
exit/b
:Unicode29313
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29313
exit/b
:Unicode40654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40654
exit/b
:Unicode31729
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31729
exit/b
:Unicode29432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29432
exit/b
:Unicode31163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31163
exit/b
:Unicode28435
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28435
exit/b
:Unicode29702
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29702
exit/b
:Unicode26446
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26446
exit/b
:Unicode37324
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37324
exit/b
:Unicode40100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40100
exit/b
:Unicode31036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31036
exit/b
:Unicode33673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33673
exit/b
:Unicode33620
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33620
exit/b
:Unicode21519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21519
exit/b
:Unicode26647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26647
exit/b
:Unicode20029
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20029
exit/b
:Unicode21385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21385
exit/b
:Unicode21169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21169
exit/b
:Unicode30782
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30782
exit/b
:Unicode21382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21382
exit/b
:Unicode21033
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21033
exit/b
:Unicode20616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20616
exit/b
:Unicode20363
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20363
exit/b
:Unicode20432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20432
exit/b
:Unicode30178
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30178
exit/b
:Unicode31435
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31435
exit/b
:Unicode31890
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31890
exit/b
:Unicode27813
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27813
exit/b
:Unicode38582
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38582
exit/b
:Unicode21147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21147
exit/b
:Unicode29827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29827
exit/b
:Unicode21737
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21737
exit/b
:Unicode20457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20457
exit/b
:Unicode32852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32852
exit/b
:Unicode33714
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33714
exit/b
:Unicode36830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36830
exit/b
:Unicode38256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38256
exit/b
:Unicode24265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24265
exit/b
:Unicode24604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24604
exit/b
:Unicode28063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28063
exit/b
:Unicode24088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24088
exit/b
:Unicode25947
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25947
exit/b
:Unicode33080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33080
exit/b
:Unicode38142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38142
exit/b
:Unicode24651
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24651
exit/b
:Unicode28860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28860
exit/b
:Unicode32451
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32451
exit/b
:Unicode31918
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31918
exit/b
:Unicode20937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20937
exit/b
:Unicode26753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26753
exit/b
:Unicode31921
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31921
exit/b
:Unicode33391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33391
exit/b
:Unicode20004
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20004
exit/b
:Unicode36742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36742
exit/b
:Unicode37327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37327
exit/b
:Unicode26238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26238
exit/b
:Unicode20142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20142
exit/b
:Unicode35845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35845
exit/b
:Unicode25769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25769
exit/b
:Unicode32842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32842
exit/b
:Unicode20698
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20698
exit/b
:Unicode30103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30103
exit/b
:Unicode29134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29134
exit/b
:Unicode23525
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23525
exit/b
:Unicode36797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36797
exit/b
:Unicode28518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28518
exit/b
:Unicode20102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20102
exit/b
:Unicode25730
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25730
exit/b
:Unicode38243
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38243
exit/b
:Unicode24278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24278
exit/b
:Unicode26009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26009
exit/b
:Unicode21015
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21015
exit/b
:Unicode35010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35010
exit/b
:Unicode28872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28872
exit/b
:Unicode21155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21155
exit/b
:Unicode29454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29454
exit/b
:Unicode29747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29747
exit/b
:Unicode26519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26519
exit/b
:Unicode30967
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30967
exit/b
:Unicode38678
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38678
exit/b
:Unicode20020
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20020
exit/b
:Unicode37051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37051
exit/b
:Unicode40158
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40158
exit/b
:Unicode28107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28107
exit/b
:Unicode20955
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20955
exit/b
:Unicode36161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36161
exit/b
:Unicode21533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21533
exit/b
:Unicode25294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25294
exit/b
:Unicode29618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29618
exit/b
:Unicode33777
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33777
exit/b
:Unicode38646
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38646
exit/b
:Unicode40836
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40836
exit/b
:Unicode38083
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38083
exit/b
:Unicode20278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20278
exit/b
:Unicode32666
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32666
exit/b
:Unicode20940
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20940
exit/b
:Unicode28789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28789
exit/b
:Unicode38517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38517
exit/b
:Unicode23725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23725
exit/b
:Unicode39046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39046
exit/b
:Unicode21478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21478
exit/b
:Unicode20196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20196
exit/b
:Unicode28316
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28316
exit/b
:Unicode29705
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29705
exit/b
:Unicode27060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27060
exit/b
:Unicode30827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30827
exit/b
:Unicode39311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39311
exit/b
:Unicode30041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30041
exit/b
:Unicode21016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21016
exit/b
:Unicode30244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30244
exit/b
:Unicode27969
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27969
exit/b
:Unicode26611
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26611
exit/b
:Unicode20845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20845
exit/b
:Unicode40857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40857
exit/b
:Unicode32843
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32843
exit/b
:Unicode21657
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21657
exit/b
:Unicode31548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31548
exit/b
:Unicode31423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31423
exit/b
:Unicode38534
set Unicode_Result=¡
exit/b
:Unicode¡
set Unicode_Result=38534
exit/b
:Unicode22404
set Unicode_Result=¢
exit/b
:Unicode¢
set Unicode_Result=22404
exit/b
:Unicode25314
set Unicode_Result=£
exit/b
:Unicode£
set Unicode_Result=25314
exit/b
:Unicode38471
set Unicode_Result=¤
exit/b
:Unicode¤
set Unicode_Result=38471
exit/b
:Unicode27004
set Unicode_Result=¥
exit/b
:Unicode¥
set Unicode_Result=27004
exit/b
:Unicode23044
set Unicode_Result=¦
exit/b
:Unicode¦
set Unicode_Result=23044
exit/b
:Unicode25602
set Unicode_Result=§
exit/b
:Unicode§
set Unicode_Result=25602
exit/b
:Unicode31699
set Unicode_Result=¨
exit/b
:Unicode¨
set Unicode_Result=31699
exit/b
:Unicode28431
set Unicode_Result=©
exit/b
:Unicode©
set Unicode_Result=28431
exit/b
:Unicode38475
set Unicode_Result=ª
exit/b
:Unicodeª
set Unicode_Result=38475
exit/b
:Unicode33446
set Unicode_Result=«
exit/b
:Unicode«
set Unicode_Result=33446
exit/b
:Unicode21346
set Unicode_Result=¬
exit/b
:Unicode¬
set Unicode_Result=21346
exit/b
:Unicode39045
set Unicode_Result=­
exit/b
:Unicode­
set Unicode_Result=39045
exit/b
:Unicode24208
set Unicode_Result=®
exit/b
:Unicode®
set Unicode_Result=24208
exit/b
:Unicode28809
set Unicode_Result=¯
exit/b
:Unicode¯
set Unicode_Result=28809
exit/b
:Unicode25523
set Unicode_Result=°
exit/b
:Unicode°
set Unicode_Result=25523
exit/b
:Unicode21348
set Unicode_Result=±
exit/b
:Unicode±
set Unicode_Result=21348
exit/b
:Unicode34383
set Unicode_Result=²
exit/b
:Unicode²
set Unicode_Result=34383
exit/b
:Unicode40065
set Unicode_Result=³
exit/b
:Unicode³
set Unicode_Result=40065
exit/b
:Unicode40595
set Unicode_Result=´
exit/b
:Unicode´
set Unicode_Result=40595
exit/b
:Unicode30860
set Unicode_Result=µ
exit/b
:Unicodeµ
set Unicode_Result=30860
exit/b
:Unicode38706
set Unicode_Result=¶
exit/b
:Unicode¶
set Unicode_Result=38706
exit/b
:Unicode36335
set Unicode_Result=·
exit/b
:Unicode·
set Unicode_Result=36335
exit/b
:Unicode36162
set Unicode_Result=¸
exit/b
:Unicode¸
set Unicode_Result=36162
exit/b
:Unicode40575
set Unicode_Result=¹
exit/b
:Unicode¹
set Unicode_Result=40575
exit/b
:Unicode28510
set Unicode_Result=º
exit/b
:Unicodeº
set Unicode_Result=28510
exit/b
:Unicode31108
set Unicode_Result=»
exit/b
:Unicode»
set Unicode_Result=31108
exit/b
:Unicode24405
set Unicode_Result=¼
exit/b
:Unicode¼
set Unicode_Result=24405
exit/b
:Unicode38470
set Unicode_Result=½
exit/b
:Unicode½
set Unicode_Result=38470
exit/b
:Unicode25134
set Unicode_Result=¾
exit/b
:Unicode¾
set Unicode_Result=25134
exit/b
:Unicode39540
set Unicode_Result=¿
exit/b
:Unicode¿
set Unicode_Result=39540
exit/b
:Unicode21525
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21525
exit/b
:Unicode38109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38109
exit/b
:Unicode20387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20387
exit/b
:Unicode26053
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26053
exit/b
:Unicode23653
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23653
exit/b
:Unicode23649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23649
exit/b
:Unicode32533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32533
exit/b
:Unicode34385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34385
exit/b
:Unicode27695
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27695
exit/b
:Unicode24459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24459
exit/b
:Unicode29575
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29575
exit/b
:Unicode28388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28388
exit/b
:Unicode32511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32511
exit/b
:Unicode23782
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23782
exit/b
:Unicode25371
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25371
exit/b
:Unicode23402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23402
exit/b
:Unicode28390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28390
exit/b
:Unicode21365
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21365
exit/b
:Unicode20081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20081
exit/b
:Unicode25504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25504
exit/b
:Unicode30053
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30053
exit/b
:Unicode25249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25249
exit/b
:Unicode36718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36718
exit/b
:Unicode20262
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20262
exit/b
:Unicode20177
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20177
exit/b
:Unicode27814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27814
exit/b
:Unicode32438
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32438
exit/b
:Unicode35770
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35770
exit/b
:Unicode33821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33821
exit/b
:Unicode34746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34746
exit/b
:Unicode32599
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32599
exit/b
:Unicode36923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36923
exit/b
:Unicode38179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38179
exit/b
:Unicode31657
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31657
exit/b
:Unicode39585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39585
exit/b
:Unicode35064
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35064
exit/b
:Unicode33853
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33853
exit/b
:Unicode27931
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27931
exit/b
:Unicode39558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39558
exit/b
:Unicode32476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32476
exit/b
:Unicode22920
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22920
exit/b
:Unicode40635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40635
exit/b
:Unicode29595
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29595
exit/b
:Unicode30721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30721
exit/b
:Unicode34434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34434
exit/b
:Unicode39532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39532
exit/b
:Unicode39554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39554
exit/b
:Unicode22043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22043
exit/b
:Unicode21527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21527
exit/b
:Unicode22475
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22475
exit/b
:Unicode20080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20080
exit/b
:Unicode40614
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40614
exit/b
:Unicode21334
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21334
exit/b
:Unicode36808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36808
exit/b
:Unicode33033
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33033
exit/b
:Unicode30610
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30610
exit/b
:Unicode39314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39314
exit/b
:Unicode34542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34542
exit/b
:Unicode28385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28385
exit/b
:Unicode34067
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34067
exit/b
:Unicode26364
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26364
exit/b
:Unicode24930
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24930
exit/b
:Unicode28459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28459
exit/b
:Unicode35881
set Unicode_Result=á
exit/b
:Unicodeá
set Unicode_Result=35881
exit/b
:Unicode33426
set Unicode_Result=â
exit/b
:Unicodeâ
set Unicode_Result=33426
exit/b
:Unicode33579
set Unicode_Result=ã
exit/b
:Unicodeã
set Unicode_Result=33579
exit/b
:Unicode30450
set Unicode_Result=ä
exit/b
:Unicodeä
set Unicode_Result=30450
exit/b
:Unicode27667
set Unicode_Result=å
exit/b
:Unicodeå
set Unicode_Result=27667
exit/b
:Unicode24537
set Unicode_Result=æ
exit/b
:Unicodeæ
set Unicode_Result=24537
exit/b
:Unicode33725
set Unicode_Result=ç
exit/b
:Unicodeç
set Unicode_Result=33725
exit/b
:Unicode29483
set Unicode_Result=è
exit/b
:Unicodeè
set Unicode_Result=29483
exit/b
:Unicode33541
set Unicode_Result=é
exit/b
:Unicodeé
set Unicode_Result=33541
exit/b
:Unicode38170
set Unicode_Result=ê
exit/b
:Unicodeê
set Unicode_Result=38170
exit/b
:Unicode27611
set Unicode_Result=ë
exit/b
:Unicodeë
set Unicode_Result=27611
exit/b
:Unicode30683
set Unicode_Result=ì
exit/b
:Unicodeì
set Unicode_Result=30683
exit/b
:Unicode38086
set Unicode_Result=í
exit/b
:Unicodeí
set Unicode_Result=38086
exit/b
:Unicode21359
set Unicode_Result=î
exit/b
:Unicodeî
set Unicode_Result=21359
exit/b
:Unicode33538
set Unicode_Result=ï
exit/b
:Unicodeï
set Unicode_Result=33538
exit/b
:Unicode20882
set Unicode_Result=ð
exit/b
:Unicodeð
set Unicode_Result=20882
exit/b
:Unicode24125
set Unicode_Result=ñ
exit/b
:Unicodeñ
set Unicode_Result=24125
exit/b
:Unicode35980
set Unicode_Result=ò
exit/b
:Unicodeò
set Unicode_Result=35980
exit/b
:Unicode36152
set Unicode_Result=ó
exit/b
:Unicodeó
set Unicode_Result=36152
exit/b
:Unicode20040
set Unicode_Result=ô
exit/b
:Unicodeô
set Unicode_Result=20040
exit/b
:Unicode29611
set Unicode_Result=õ
exit/b
:Unicodeõ
set Unicode_Result=29611
exit/b
:Unicode26522
set Unicode_Result=ö
exit/b
:Unicodeö
set Unicode_Result=26522
exit/b
:Unicode26757
set Unicode_Result=÷
exit/b
:Unicode÷
set Unicode_Result=26757
exit/b
:Unicode37238
set Unicode_Result=ø
exit/b
:Unicodeø
set Unicode_Result=37238
exit/b
:Unicode38665
set Unicode_Result=ù
exit/b
:Unicodeù
set Unicode_Result=38665
exit/b
:Unicode29028
set Unicode_Result=ú
exit/b
:Unicodeú
set Unicode_Result=29028
exit/b
:Unicode27809
set Unicode_Result=û
exit/b
:Unicodeû
set Unicode_Result=27809
exit/b
:Unicode30473
set Unicode_Result=ü
exit/b
:Unicodeü
set Unicode_Result=30473
exit/b
:Unicode23186
set Unicode_Result=ý
exit/b
:Unicodeý
set Unicode_Result=23186
exit/b
:Unicode38209
set Unicode_Result=þ
exit/b
:Unicodeþ
set Unicode_Result=38209
exit/b
:Unicode27599
set Unicode_Result=ÿ
exit/b
:Unicodeÿ
set Unicode_Result=27599
exit/b
:Unicode32654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32654
exit/b
:Unicode26151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26151
exit/b
:Unicode23504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23504
exit/b
:Unicode22969
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22969
exit/b
:Unicode23194
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23194
exit/b
:Unicode38376
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38376
exit/b
:Unicode38391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38391
exit/b
:Unicode20204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20204
exit/b
:Unicode33804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33804
exit/b
:Unicode33945
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33945
exit/b
:Unicode27308
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27308
exit/b
:Unicode30431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30431
exit/b
:Unicode38192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38192
exit/b
:Unicode29467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29467
exit/b
:Unicode26790
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26790
exit/b
:Unicode23391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23391
exit/b
:Unicode30511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30511
exit/b
:Unicode37274
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37274
exit/b
:Unicode38753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38753
exit/b
:Unicode31964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31964
exit/b
:Unicode36855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36855
exit/b
:Unicode35868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35868
exit/b
:Unicode24357
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24357
exit/b
:Unicode31859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31859
exit/b
:Unicode31192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31192
exit/b
:Unicode35269
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35269
exit/b
:Unicode27852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27852
exit/b
:Unicode34588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34588
exit/b
:Unicode23494
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23494
exit/b
:Unicode24130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24130
exit/b
:Unicode26825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26825
exit/b
:Unicode30496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30496
exit/b
:Unicode32501
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32501
exit/b
:Unicode20885
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20885
exit/b
:Unicode20813
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20813
exit/b
:Unicode21193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21193
exit/b
:Unicode23081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23081
exit/b
:Unicode32517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32517
exit/b
:Unicode38754
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38754
exit/b
:Unicode33495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33495
exit/b
:Unicode25551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25551
exit/b
:Unicode30596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30596
exit/b
:Unicode34256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34256
exit/b
:Unicode31186
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31186
exit/b
:Unicode28218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28218
exit/b
:Unicode24217
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24217
exit/b
:Unicode22937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22937
exit/b
:Unicode34065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34065
exit/b
:Unicode28781
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28781
exit/b
:Unicode27665
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27665
exit/b
:Unicode25279
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25279
exit/b
:Unicode30399
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30399
exit/b
:Unicode25935
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25935
exit/b
:Unicode24751
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24751
exit/b
:Unicode38397
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38397
exit/b
:Unicode26126
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26126
exit/b
:Unicode34719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34719
exit/b
:Unicode40483
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40483
exit/b
:Unicode38125
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38125
exit/b
:Unicode21517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21517
exit/b
:Unicode21629
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21629
exit/b
:Unicode35884
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35884
exit/b
:Unicode25720
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25720
exit/b
:Unicode25721
set Unicode_Result=ġ
exit/b
:Unicodeġ
set Unicode_Result=25721
exit/b
:Unicode34321
set Unicode_Result=Ģ
exit/b
:UnicodeĢ
set Unicode_Result=34321
exit/b
:Unicode27169
set Unicode_Result=ģ
exit/b
:Unicodeģ
set Unicode_Result=27169
exit/b
:Unicode33180
set Unicode_Result=Ĥ
exit/b
:UnicodeĤ
set Unicode_Result=33180
exit/b
:Unicode30952
set Unicode_Result=ĥ
exit/b
:Unicodeĥ
set Unicode_Result=30952
exit/b
:Unicode25705
set Unicode_Result=Ħ
exit/b
:UnicodeĦ
set Unicode_Result=25705
exit/b
:Unicode39764
set Unicode_Result=ħ
exit/b
:Unicodeħ
set Unicode_Result=39764
exit/b
:Unicode25273
set Unicode_Result=Ĩ
exit/b
:UnicodeĨ
set Unicode_Result=25273
exit/b
:Unicode26411
set Unicode_Result=ĩ
exit/b
:Unicodeĩ
set Unicode_Result=26411
exit/b
:Unicode33707
set Unicode_Result=Ī
exit/b
:UnicodeĪ
set Unicode_Result=33707
exit/b
:Unicode22696
set Unicode_Result=ī
exit/b
:Unicodeī
set Unicode_Result=22696
exit/b
:Unicode40664
set Unicode_Result=Ĭ
exit/b
:UnicodeĬ
set Unicode_Result=40664
exit/b
:Unicode27819
set Unicode_Result=ĭ
exit/b
:Unicodeĭ
set Unicode_Result=27819
exit/b
:Unicode28448
set Unicode_Result=Į
exit/b
:UnicodeĮ
set Unicode_Result=28448
exit/b
:Unicode23518
set Unicode_Result=į
exit/b
:Unicodeį
set Unicode_Result=23518
exit/b
:Unicode38476
set Unicode_Result=İ
exit/b
:Unicodeİ
set Unicode_Result=38476
exit/b
:Unicode35851
set Unicode_Result=ı
exit/b
:Unicodeı
set Unicode_Result=35851
exit/b
:Unicode29279
set Unicode_Result=Ĳ
exit/b
:UnicodeĲ
set Unicode_Result=29279
exit/b
:Unicode26576
set Unicode_Result=ĳ
exit/b
:Unicodeĳ
set Unicode_Result=26576
exit/b
:Unicode25287
set Unicode_Result=Ĵ
exit/b
:UnicodeĴ
set Unicode_Result=25287
exit/b
:Unicode29281
set Unicode_Result=ĵ
exit/b
:Unicodeĵ
set Unicode_Result=29281
exit/b
:Unicode20137
set Unicode_Result=Ķ
exit/b
:UnicodeĶ
set Unicode_Result=20137
exit/b
:Unicode22982
set Unicode_Result=ķ
exit/b
:Unicodeķ
set Unicode_Result=22982
exit/b
:Unicode27597
set Unicode_Result=ĸ
exit/b
:Unicodeĸ
set Unicode_Result=27597
exit/b
:Unicode22675
set Unicode_Result=Ĺ
exit/b
:UnicodeĹ
set Unicode_Result=22675
exit/b
:Unicode26286
set Unicode_Result=ĺ
exit/b
:Unicodeĺ
set Unicode_Result=26286
exit/b
:Unicode24149
set Unicode_Result=Ļ
exit/b
:UnicodeĻ
set Unicode_Result=24149
exit/b
:Unicode21215
set Unicode_Result=ļ
exit/b
:Unicodeļ
set Unicode_Result=21215
exit/b
:Unicode24917
set Unicode_Result=Ľ
exit/b
:UnicodeĽ
set Unicode_Result=24917
exit/b
:Unicode26408
set Unicode_Result=ľ
exit/b
:Unicodeľ
set Unicode_Result=26408
exit/b
:Unicode30446
set Unicode_Result=Ŀ
exit/b
:UnicodeĿ
set Unicode_Result=30446
exit/b
:Unicode30566
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30566
exit/b
:Unicode29287
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29287
exit/b
:Unicode31302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31302
exit/b
:Unicode25343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25343
exit/b
:Unicode21738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21738
exit/b
:Unicode21584
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21584
exit/b
:Unicode38048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38048
exit/b
:Unicode37027
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37027
exit/b
:Unicode23068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23068
exit/b
:Unicode32435
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32435
exit/b
:Unicode27670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27670
exit/b
:Unicode20035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20035
exit/b
:Unicode22902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22902
exit/b
:Unicode32784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32784
exit/b
:Unicode22856
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22856
exit/b
:Unicode21335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21335
exit/b
:Unicode30007
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30007
exit/b
:Unicode38590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38590
exit/b
:Unicode22218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22218
exit/b
:Unicode25376
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25376
exit/b
:Unicode33041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33041
exit/b
:Unicode24700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24700
exit/b
:Unicode38393
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38393
exit/b
:Unicode28118
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28118
exit/b
:Unicode21602
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21602
exit/b
:Unicode39297
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39297
exit/b
:Unicode20869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20869
exit/b
:Unicode23273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23273
exit/b
:Unicode33021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33021
exit/b
:Unicode22958
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22958
exit/b
:Unicode38675
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38675
exit/b
:Unicode20522
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20522
exit/b
:Unicode27877
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27877
exit/b
:Unicode23612
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23612
exit/b
:Unicode25311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25311
exit/b
:Unicode20320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20320
exit/b
:Unicode21311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21311
exit/b
:Unicode33147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33147
exit/b
:Unicode36870
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36870
exit/b
:Unicode28346
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28346
exit/b
:Unicode34091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34091
exit/b
:Unicode25288
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25288
exit/b
:Unicode24180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24180
exit/b
:Unicode30910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30910
exit/b
:Unicode25781
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25781
exit/b
:Unicode25467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25467
exit/b
:Unicode24565
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24565
exit/b
:Unicode23064
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23064
exit/b
:Unicode37247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37247
exit/b
:Unicode40479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40479
exit/b
:Unicode23615
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23615
exit/b
:Unicode25423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25423
exit/b
:Unicode32834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32834
exit/b
:Unicode23421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23421
exit/b
:Unicode21870
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21870
exit/b
:Unicode38218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38218
exit/b
:Unicode38221
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38221
exit/b
:Unicode28037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28037
exit/b
:Unicode24744
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24744
exit/b
:Unicode26592
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26592
exit/b
:Unicode29406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29406
exit/b
:Unicode20957
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20957
exit/b
:Unicode23425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23425
exit/b
:Unicode25319
set Unicode_Result=š
exit/b
:Unicodeš
set Unicode_Result=25319
exit/b
:Unicode27870
set Unicode_Result=Ţ
exit/b
:UnicodeŢ
set Unicode_Result=27870
exit/b
:Unicode29275
set Unicode_Result=ţ
exit/b
:Unicodeţ
set Unicode_Result=29275
exit/b
:Unicode25197
set Unicode_Result=Ť
exit/b
:UnicodeŤ
set Unicode_Result=25197
exit/b
:Unicode38062
set Unicode_Result=ť
exit/b
:Unicodeť
set Unicode_Result=38062
exit/b
:Unicode32445
set Unicode_Result=Ŧ
exit/b
:UnicodeŦ
set Unicode_Result=32445
exit/b
:Unicode33043
set Unicode_Result=ŧ
exit/b
:Unicodeŧ
set Unicode_Result=33043
exit/b
:Unicode27987
set Unicode_Result=Ũ
exit/b
:UnicodeŨ
set Unicode_Result=27987
exit/b
:Unicode20892
set Unicode_Result=ũ
exit/b
:Unicodeũ
set Unicode_Result=20892
exit/b
:Unicode24324
set Unicode_Result=Ū
exit/b
:UnicodeŪ
set Unicode_Result=24324
exit/b
:Unicode22900
set Unicode_Result=ū
exit/b
:Unicodeū
set Unicode_Result=22900
exit/b
:Unicode21162
set Unicode_Result=Ŭ
exit/b
:UnicodeŬ
set Unicode_Result=21162
exit/b
:Unicode24594
set Unicode_Result=ŭ
exit/b
:Unicodeŭ
set Unicode_Result=24594
exit/b
:Unicode22899
set Unicode_Result=Ů
exit/b
:UnicodeŮ
set Unicode_Result=22899
exit/b
:Unicode26262
set Unicode_Result=ů
exit/b
:Unicodeů
set Unicode_Result=26262
exit/b
:Unicode34384
set Unicode_Result=Ű
exit/b
:UnicodeŰ
set Unicode_Result=34384
exit/b
:Unicode30111
set Unicode_Result=ű
exit/b
:Unicodeű
set Unicode_Result=30111
exit/b
:Unicode25386
set Unicode_Result=Ų
exit/b
:UnicodeŲ
set Unicode_Result=25386
exit/b
:Unicode25062
set Unicode_Result=ų
exit/b
:Unicodeų
set Unicode_Result=25062
exit/b
:Unicode31983
set Unicode_Result=Ŵ
exit/b
:UnicodeŴ
set Unicode_Result=31983
exit/b
:Unicode35834
set Unicode_Result=ŵ
exit/b
:Unicodeŵ
set Unicode_Result=35834
exit/b
:Unicode21734
set Unicode_Result=Ŷ
exit/b
:UnicodeŶ
set Unicode_Result=21734
exit/b
:Unicode27431
set Unicode_Result=ŷ
exit/b
:Unicodeŷ
set Unicode_Result=27431
exit/b
:Unicode40485
set Unicode_Result=Ÿ
exit/b
:UnicodeŸ
set Unicode_Result=40485
exit/b
:Unicode27572
set Unicode_Result=Ź
exit/b
:UnicodeŹ
set Unicode_Result=27572
exit/b
:Unicode34261
set Unicode_Result=ź
exit/b
:Unicodeź
set Unicode_Result=34261
exit/b
:Unicode21589
set Unicode_Result=Ż
exit/b
:UnicodeŻ
set Unicode_Result=21589
exit/b
:Unicode20598
set Unicode_Result=ż
exit/b
:Unicodeż
set Unicode_Result=20598
exit/b
:Unicode27812
set Unicode_Result=Ž
exit/b
:UnicodeŽ
set Unicode_Result=27812
exit/b
:Unicode21866
set Unicode_Result=ž
exit/b
:Unicodež
set Unicode_Result=21866
exit/b
:Unicode36276
set Unicode_Result=ſ
exit/b
:Unicodeſ
set Unicode_Result=36276
exit/b
:Unicode29228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29228
exit/b
:Unicode24085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24085
exit/b
:Unicode24597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24597
exit/b
:Unicode29750
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29750
exit/b
:Unicode25293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25293
exit/b
:Unicode25490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25490
exit/b
:Unicode29260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29260
exit/b
:Unicode24472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24472
exit/b
:Unicode28227
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28227
exit/b
:Unicode27966
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27966
exit/b
:Unicode25856
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25856
exit/b
:Unicode28504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28504
exit/b
:Unicode30424
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30424
exit/b
:Unicode30928
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30928
exit/b
:Unicode30460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30460
exit/b
:Unicode30036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30036
exit/b
:Unicode21028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21028
exit/b
:Unicode21467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21467
exit/b
:Unicode20051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20051
exit/b
:Unicode24222
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24222
exit/b
:Unicode26049
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26049
exit/b
:Unicode32810
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32810
exit/b
:Unicode32982
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32982
exit/b
:Unicode25243
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25243
exit/b
:Unicode21638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21638
exit/b
:Unicode21032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21032
exit/b
:Unicode28846
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28846
exit/b
:Unicode34957
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34957
exit/b
:Unicode36305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36305
exit/b
:Unicode27873
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27873
exit/b
:Unicode21624
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21624
exit/b
:Unicode32986
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32986
exit/b
:Unicode22521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22521
exit/b
:Unicode35060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35060
exit/b
:Unicode36180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36180
exit/b
:Unicode38506
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38506
exit/b
:Unicode37197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37197
exit/b
:Unicode20329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20329
exit/b
:Unicode27803
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27803
exit/b
:Unicode21943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21943
exit/b
:Unicode30406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30406
exit/b
:Unicode30768
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30768
exit/b
:Unicode25256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25256
exit/b
:Unicode28921
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28921
exit/b
:Unicode28558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28558
exit/b
:Unicode24429
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24429
exit/b
:Unicode34028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34028
exit/b
:Unicode26842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26842
exit/b
:Unicode30844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30844
exit/b
:Unicode31735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31735
exit/b
:Unicode33192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33192
exit/b
:Unicode26379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26379
exit/b
:Unicode40527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40527
exit/b
:Unicode25447
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25447
exit/b
:Unicode30896
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30896
exit/b
:Unicode22383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22383
exit/b
:Unicode30738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30738
exit/b
:Unicode38713
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38713
exit/b
:Unicode25209
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25209
exit/b
:Unicode25259
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25259
exit/b
:Unicode21128
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21128
exit/b
:Unicode29749
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29749
exit/b
:Unicode27607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27607
exit/b
:Unicode21860
set Unicode_Result=ơ
exit/b
:Unicodeơ
set Unicode_Result=21860
exit/b
:Unicode33086
set Unicode_Result=Ƣ
exit/b
:UnicodeƢ
set Unicode_Result=33086
exit/b
:Unicode30130
set Unicode_Result=ƣ
exit/b
:Unicodeƣ
set Unicode_Result=30130
exit/b
:Unicode30382
set Unicode_Result=Ƥ
exit/b
:UnicodeƤ
set Unicode_Result=30382
exit/b
:Unicode21305
set Unicode_Result=ƥ
exit/b
:Unicodeƥ
set Unicode_Result=21305
exit/b
:Unicode30174
set Unicode_Result=Ʀ
exit/b
:UnicodeƦ
set Unicode_Result=30174
exit/b
:Unicode20731
set Unicode_Result=Ƨ
exit/b
:UnicodeƧ
set Unicode_Result=20731
exit/b
:Unicode23617
set Unicode_Result=ƨ
exit/b
:Unicodeƨ
set Unicode_Result=23617
exit/b
:Unicode35692
set Unicode_Result=Ʃ
exit/b
:UnicodeƩ
set Unicode_Result=35692
exit/b
:Unicode31687
set Unicode_Result=ƪ
exit/b
:Unicodeƪ
set Unicode_Result=31687
exit/b
:Unicode20559
set Unicode_Result=ƫ
exit/b
:Unicodeƫ
set Unicode_Result=20559
exit/b
:Unicode29255
set Unicode_Result=Ƭ
exit/b
:UnicodeƬ
set Unicode_Result=29255
exit/b
:Unicode39575
set Unicode_Result=ƭ
exit/b
:Unicodeƭ
set Unicode_Result=39575
exit/b
:Unicode39128
set Unicode_Result=Ʈ
exit/b
:UnicodeƮ
set Unicode_Result=39128
exit/b
:Unicode28418
set Unicode_Result=Ư
exit/b
:UnicodeƯ
set Unicode_Result=28418
exit/b
:Unicode29922
set Unicode_Result=ư
exit/b
:Unicodeư
set Unicode_Result=29922
exit/b
:Unicode31080
set Unicode_Result=Ʊ
exit/b
:UnicodeƱ
set Unicode_Result=31080
exit/b
:Unicode25735
set Unicode_Result=Ʋ
exit/b
:UnicodeƲ
set Unicode_Result=25735
exit/b
:Unicode30629
set Unicode_Result=Ƴ
exit/b
:UnicodeƳ
set Unicode_Result=30629
exit/b
:Unicode25340
set Unicode_Result=ƴ
exit/b
:Unicodeƴ
set Unicode_Result=25340
exit/b
:Unicode39057
set Unicode_Result=Ƶ
exit/b
:UnicodeƵ
set Unicode_Result=39057
exit/b
:Unicode36139
set Unicode_Result=ƶ
exit/b
:Unicodeƶ
set Unicode_Result=36139
exit/b
:Unicode21697
set Unicode_Result=Ʒ
exit/b
:UnicodeƷ
set Unicode_Result=21697
exit/b
:Unicode32856
set Unicode_Result=Ƹ
exit/b
:UnicodeƸ
set Unicode_Result=32856
exit/b
:Unicode20050
set Unicode_Result=ƹ
exit/b
:Unicodeƹ
set Unicode_Result=20050
exit/b
:Unicode22378
set Unicode_Result=ƺ
exit/b
:Unicodeƺ
set Unicode_Result=22378
exit/b
:Unicode33529
set Unicode_Result=ƻ
exit/b
:Unicodeƻ
set Unicode_Result=33529
exit/b
:Unicode33805
set Unicode_Result=Ƽ
exit/b
:UnicodeƼ
set Unicode_Result=33805
exit/b
:Unicode24179
set Unicode_Result=ƽ
exit/b
:Unicodeƽ
set Unicode_Result=24179
exit/b
:Unicode20973
set Unicode_Result=ƾ
exit/b
:Unicodeƾ
set Unicode_Result=20973
exit/b
:Unicode29942
set Unicode_Result=ƿ
exit/b
:Unicodeƿ
set Unicode_Result=29942
exit/b
:Unicode35780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35780
exit/b
:Unicode23631
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23631
exit/b
:Unicode22369
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22369
exit/b
:Unicode27900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27900
exit/b
:Unicode39047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39047
exit/b
:Unicode23110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23110
exit/b
:Unicode30772
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30772
exit/b
:Unicode39748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39748
exit/b
:Unicode36843
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36843
exit/b
:Unicode31893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31893
exit/b
:Unicode21078
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21078
exit/b
:Unicode25169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25169
exit/b
:Unicode38138
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38138
exit/b
:Unicode20166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20166
exit/b
:Unicode33670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33670
exit/b
:Unicode33889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33889
exit/b
:Unicode33769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33769
exit/b
:Unicode33970
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33970
exit/b
:Unicode22484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22484
exit/b
:Unicode26420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26420
exit/b
:Unicode22275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22275
exit/b
:Unicode26222
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26222
exit/b
:Unicode28006
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28006
exit/b
:Unicode35889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35889
exit/b
:Unicode26333
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26333
exit/b
:Unicode28689
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28689
exit/b
:Unicode26399
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26399
exit/b
:Unicode27450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27450
exit/b
:Unicode26646
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26646
exit/b
:Unicode25114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25114
exit/b
:Unicode22971
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22971
exit/b
:Unicode19971
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19971
exit/b
:Unicode20932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20932
exit/b
:Unicode28422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28422
exit/b
:Unicode26578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26578
exit/b
:Unicode27791
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27791
exit/b
:Unicode20854
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20854
exit/b
:Unicode26827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26827
exit/b
:Unicode22855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22855
exit/b
:Unicode27495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27495
exit/b
:Unicode30054
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30054
exit/b
:Unicode23822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23822
exit/b
:Unicode33040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33040
exit/b
:Unicode40784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40784
exit/b
:Unicode26071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26071
exit/b
:Unicode31048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31048
exit/b
:Unicode31041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31041
exit/b
:Unicode39569
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39569
exit/b
:Unicode36215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36215
exit/b
:Unicode23682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23682
exit/b
:Unicode20062
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20062
exit/b
:Unicode20225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20225
exit/b
:Unicode21551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21551
exit/b
:Unicode22865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22865
exit/b
:Unicode30732
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30732
exit/b
:Unicode22120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22120
exit/b
:Unicode27668
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27668
exit/b
:Unicode36804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36804
exit/b
:Unicode24323
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24323
exit/b
:Unicode27773
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27773
exit/b
:Unicode27875
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27875
exit/b
:Unicode35755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35755
exit/b
:Unicode25488
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25488
exit/b
:Unicode24688
set Unicode_Result=ǡ
exit/b
:Unicodeǡ
set Unicode_Result=24688
exit/b
:Unicode27965
set Unicode_Result=Ǣ
exit/b
:UnicodeǢ
set Unicode_Result=27965
exit/b
:Unicode29301
set Unicode_Result=ǣ
exit/b
:Unicodeǣ
set Unicode_Result=29301
exit/b
:Unicode25190
set Unicode_Result=Ǥ
exit/b
:UnicodeǤ
set Unicode_Result=25190
exit/b
:Unicode38030
set Unicode_Result=ǥ
exit/b
:Unicodeǥ
set Unicode_Result=38030
exit/b
:Unicode38085
set Unicode_Result=Ǧ
exit/b
:UnicodeǦ
set Unicode_Result=38085
exit/b
:Unicode21315
set Unicode_Result=ǧ
exit/b
:Unicodeǧ
set Unicode_Result=21315
exit/b
:Unicode36801
set Unicode_Result=Ǩ
exit/b
:UnicodeǨ
set Unicode_Result=36801
exit/b
:Unicode31614
set Unicode_Result=ǩ
exit/b
:Unicodeǩ
set Unicode_Result=31614
exit/b
:Unicode20191
set Unicode_Result=Ǫ
exit/b
:UnicodeǪ
set Unicode_Result=20191
exit/b
:Unicode35878
set Unicode_Result=ǫ
exit/b
:Unicodeǫ
set Unicode_Result=35878
exit/b
:Unicode20094
set Unicode_Result=Ǭ
exit/b
:UnicodeǬ
set Unicode_Result=20094
exit/b
:Unicode40660
set Unicode_Result=ǭ
exit/b
:Unicodeǭ
set Unicode_Result=40660
exit/b
:Unicode38065
set Unicode_Result=Ǯ
exit/b
:UnicodeǮ
set Unicode_Result=38065
exit/b
:Unicode38067
set Unicode_Result=ǯ
exit/b
:Unicodeǯ
set Unicode_Result=38067
exit/b
:Unicode21069
set Unicode_Result=ǰ
exit/b
:Unicodeǰ
set Unicode_Result=21069
exit/b
:Unicode28508
set Unicode_Result=Ǳ
exit/b
:UnicodeǱ
set Unicode_Result=28508
exit/b
:Unicode36963
set Unicode_Result=ǲ
exit/b
:Unicodeǲ
set Unicode_Result=36963
exit/b
:Unicode27973
set Unicode_Result=ǳ
exit/b
:Unicodeǳ
set Unicode_Result=27973
exit/b
:Unicode35892
set Unicode_Result=Ǵ
exit/b
:UnicodeǴ
set Unicode_Result=35892
exit/b
:Unicode22545
set Unicode_Result=ǵ
exit/b
:Unicodeǵ
set Unicode_Result=22545
exit/b
:Unicode23884
set Unicode_Result=Ƕ
exit/b
:UnicodeǶ
set Unicode_Result=23884
exit/b
:Unicode27424
set Unicode_Result=Ƿ
exit/b
:UnicodeǷ
set Unicode_Result=27424
exit/b
:Unicode27465
set Unicode_Result=Ǹ
exit/b
:UnicodeǸ
set Unicode_Result=27465
exit/b
:Unicode26538
set Unicode_Result=ǹ
exit/b
:Unicodeǹ
set Unicode_Result=26538
exit/b
:Unicode21595
set Unicode_Result=Ǻ
exit/b
:UnicodeǺ
set Unicode_Result=21595
exit/b
:Unicode33108
set Unicode_Result=ǻ
exit/b
:Unicodeǻ
set Unicode_Result=33108
exit/b
:Unicode32652
set Unicode_Result=Ǽ
exit/b
:UnicodeǼ
set Unicode_Result=32652
exit/b
:Unicode22681
set Unicode_Result=ǽ
exit/b
:Unicodeǽ
set Unicode_Result=22681
exit/b
:Unicode34103
set Unicode_Result=Ǿ
exit/b
:UnicodeǾ
set Unicode_Result=34103
exit/b
:Unicode24378
set Unicode_Result=ǿ
exit/b
:Unicodeǿ
set Unicode_Result=24378
exit/b
:Unicode25250
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25250
exit/b
:Unicode27207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27207
exit/b
:Unicode38201
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38201
exit/b
:Unicode25970
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25970
exit/b
:Unicode24708
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24708
exit/b
:Unicode26725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26725
exit/b
:Unicode30631
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30631
exit/b
:Unicode20052
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20052
exit/b
:Unicode20392
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20392
exit/b
:Unicode24039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24039
exit/b
:Unicode38808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38808
exit/b
:Unicode25772
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25772
exit/b
:Unicode32728
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32728
exit/b
:Unicode23789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23789
exit/b
:Unicode20431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20431
exit/b
:Unicode31373
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31373
exit/b
:Unicode20999
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20999
exit/b
:Unicode33540
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33540
exit/b
:Unicode19988
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19988
exit/b
:Unicode24623
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24623
exit/b
:Unicode31363
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31363
exit/b
:Unicode38054
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38054
exit/b
:Unicode20405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20405
exit/b
:Unicode20146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20146
exit/b
:Unicode31206
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31206
exit/b
:Unicode29748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29748
exit/b
:Unicode21220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21220
exit/b
:Unicode33465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33465
exit/b
:Unicode25810
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25810
exit/b
:Unicode31165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31165
exit/b
:Unicode23517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23517
exit/b
:Unicode27777
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27777
exit/b
:Unicode38738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38738
exit/b
:Unicode36731
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36731
exit/b
:Unicode27682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27682
exit/b
:Unicode20542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20542
exit/b
:Unicode21375
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21375
exit/b
:Unicode28165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28165
exit/b
:Unicode25806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25806
exit/b
:Unicode26228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26228
exit/b
:Unicode27696
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27696
exit/b
:Unicode24773
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24773
exit/b
:Unicode39031
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39031
exit/b
:Unicode35831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35831
exit/b
:Unicode24198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24198
exit/b
:Unicode29756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29756
exit/b
:Unicode31351
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31351
exit/b
:Unicode31179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31179
exit/b
:Unicode19992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19992
exit/b
:Unicode37041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37041
exit/b
:Unicode29699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29699
exit/b
:Unicode27714
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27714
exit/b
:Unicode22234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22234
exit/b
:Unicode37195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37195
exit/b
:Unicode27845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27845
exit/b
:Unicode36235
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36235
exit/b
:Unicode21306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21306
exit/b
:Unicode34502
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34502
exit/b
:Unicode26354
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26354
exit/b
:Unicode36527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36527
exit/b
:Unicode23624
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23624
exit/b
:Unicode39537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39537
exit/b
:Unicode28192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28192
exit/b
:Unicode21462
set Unicode_Result=ȡ
exit/b
:Unicodeȡ
set Unicode_Result=21462
exit/b
:Unicode23094
set Unicode_Result=Ȣ
exit/b
:UnicodeȢ
set Unicode_Result=23094
exit/b
:Unicode40843
set Unicode_Result=ȣ
exit/b
:Unicodeȣ
set Unicode_Result=40843
exit/b
:Unicode36259
set Unicode_Result=Ȥ
exit/b
:UnicodeȤ
set Unicode_Result=36259
exit/b
:Unicode21435
set Unicode_Result=ȥ
exit/b
:Unicodeȥ
set Unicode_Result=21435
exit/b
:Unicode22280
set Unicode_Result=Ȧ
exit/b
:UnicodeȦ
set Unicode_Result=22280
exit/b
:Unicode39079
set Unicode_Result=ȧ
exit/b
:Unicodeȧ
set Unicode_Result=39079
exit/b
:Unicode26435
set Unicode_Result=Ȩ
exit/b
:UnicodeȨ
set Unicode_Result=26435
exit/b
:Unicode37275
set Unicode_Result=ȩ
exit/b
:Unicodeȩ
set Unicode_Result=37275
exit/b
:Unicode27849
set Unicode_Result=Ȫ
exit/b
:UnicodeȪ
set Unicode_Result=27849
exit/b
:Unicode20840
set Unicode_Result=ȫ
exit/b
:Unicodeȫ
set Unicode_Result=20840
exit/b
:Unicode30154
set Unicode_Result=Ȭ
exit/b
:UnicodeȬ
set Unicode_Result=30154
exit/b
:Unicode25331
set Unicode_Result=ȭ
exit/b
:Unicodeȭ
set Unicode_Result=25331
exit/b
:Unicode29356
set Unicode_Result=Ȯ
exit/b
:UnicodeȮ
set Unicode_Result=29356
exit/b
:Unicode21048
set Unicode_Result=ȯ
exit/b
:Unicodeȯ
set Unicode_Result=21048
exit/b
:Unicode21149
set Unicode_Result=Ȱ
exit/b
:UnicodeȰ
set Unicode_Result=21149
exit/b
:Unicode32570
set Unicode_Result=ȱ
exit/b
:Unicodeȱ
set Unicode_Result=32570
exit/b
:Unicode28820
set Unicode_Result=Ȳ
exit/b
:UnicodeȲ
set Unicode_Result=28820
exit/b
:Unicode30264
set Unicode_Result=ȳ
exit/b
:Unicodeȳ
set Unicode_Result=30264
exit/b
:Unicode21364
set Unicode_Result=ȴ
exit/b
:Unicodeȴ
set Unicode_Result=21364
exit/b
:Unicode40522
set Unicode_Result=ȵ
exit/b
:Unicodeȵ
set Unicode_Result=40522
exit/b
:Unicode27063
set Unicode_Result=ȶ
exit/b
:Unicodeȶ
set Unicode_Result=27063
exit/b
:Unicode30830
set Unicode_Result=ȷ
exit/b
:Unicodeȷ
set Unicode_Result=30830
exit/b
:Unicode38592
set Unicode_Result=ȸ
exit/b
:Unicodeȸ
set Unicode_Result=38592
exit/b
:Unicode35033
set Unicode_Result=ȹ
exit/b
:Unicodeȹ
set Unicode_Result=35033
exit/b
:Unicode32676
set Unicode_Result=Ⱥ
exit/b
:UnicodeȺ
set Unicode_Result=32676
exit/b
:Unicode28982
set Unicode_Result=Ȼ
exit/b
:UnicodeȻ
set Unicode_Result=28982
exit/b
:Unicode29123
set Unicode_Result=ȼ
exit/b
:Unicodeȼ
set Unicode_Result=29123
exit/b
:Unicode20873
set Unicode_Result=Ƚ
exit/b
:UnicodeȽ
set Unicode_Result=20873
exit/b
:Unicode26579
set Unicode_Result=Ⱦ
exit/b
:UnicodeȾ
set Unicode_Result=26579
exit/b
:Unicode29924
set Unicode_Result=ȿ
exit/b
:Unicodeȿ
set Unicode_Result=29924
exit/b
:Unicode22756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22756
exit/b
:Unicode25880
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25880
exit/b
:Unicode22199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22199
exit/b
:Unicode35753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35753
exit/b
:Unicode39286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39286
exit/b
:Unicode25200
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25200
exit/b
:Unicode32469
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32469
exit/b
:Unicode24825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24825
exit/b
:Unicode28909
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28909
exit/b
:Unicode22764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22764
exit/b
:Unicode20161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20161
exit/b
:Unicode20154
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20154
exit/b
:Unicode24525
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24525
exit/b
:Unicode38887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38887
exit/b
:Unicode20219
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20219
exit/b
:Unicode35748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35748
exit/b
:Unicode20995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20995
exit/b
:Unicode22922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22922
exit/b
:Unicode32427
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32427
exit/b
:Unicode25172
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25172
exit/b
:Unicode20173
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20173
exit/b
:Unicode26085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26085
exit/b
:Unicode25102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25102
exit/b
:Unicode33592
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33592
exit/b
:Unicode33993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33993
exit/b
:Unicode33635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33635
exit/b
:Unicode34701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34701
exit/b
:Unicode29076
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29076
exit/b
:Unicode28342
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28342
exit/b
:Unicode23481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23481
exit/b
:Unicode32466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32466
exit/b
:Unicode20887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20887
exit/b
:Unicode25545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25545
exit/b
:Unicode26580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26580
exit/b
:Unicode32905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32905
exit/b
:Unicode33593
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33593
exit/b
:Unicode34837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34837
exit/b
:Unicode20754
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20754
exit/b
:Unicode23418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23418
exit/b
:Unicode22914
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22914
exit/b
:Unicode36785
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36785
exit/b
:Unicode20083
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20083
exit/b
:Unicode27741
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27741
exit/b
:Unicode20837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20837
exit/b
:Unicode35109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35109
exit/b
:Unicode36719
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36719
exit/b
:Unicode38446
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38446
exit/b
:Unicode34122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34122
exit/b
:Unicode29790
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29790
exit/b
:Unicode38160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38160
exit/b
:Unicode38384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38384
exit/b
:Unicode28070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28070
exit/b
:Unicode33509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33509
exit/b
:Unicode24369
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24369
exit/b
:Unicode25746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25746
exit/b
:Unicode27922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27922
exit/b
:Unicode33832
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33832
exit/b
:Unicode33134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33134
exit/b
:Unicode40131
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40131
exit/b
:Unicode22622
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22622
exit/b
:Unicode36187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36187
exit/b
:Unicode19977
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19977
exit/b
:Unicode21441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21441
exit/b
:Unicode20254
set Unicode_Result=ɡ
exit/b
:Unicodeɡ
set Unicode_Result=20254
exit/b
:Unicode25955
set Unicode_Result=ɢ
exit/b
:Unicodeɢ
set Unicode_Result=25955
exit/b
:Unicode26705
set Unicode_Result=ɣ
exit/b
:Unicodeɣ
set Unicode_Result=26705
exit/b
:Unicode21971
set Unicode_Result=ɤ
exit/b
:Unicodeɤ
set Unicode_Result=21971
exit/b
:Unicode20007
set Unicode_Result=ɥ
exit/b
:Unicodeɥ
set Unicode_Result=20007
exit/b
:Unicode25620
set Unicode_Result=ɦ
exit/b
:Unicodeɦ
set Unicode_Result=25620
exit/b
:Unicode39578
set Unicode_Result=ɧ
exit/b
:Unicodeɧ
set Unicode_Result=39578
exit/b
:Unicode25195
set Unicode_Result=ɨ
exit/b
:Unicodeɨ
set Unicode_Result=25195
exit/b
:Unicode23234
set Unicode_Result=ɩ
exit/b
:Unicodeɩ
set Unicode_Result=23234
exit/b
:Unicode29791
set Unicode_Result=ɪ
exit/b
:Unicodeɪ
set Unicode_Result=29791
exit/b
:Unicode33394
set Unicode_Result=ɫ
exit/b
:Unicodeɫ
set Unicode_Result=33394
exit/b
:Unicode28073
set Unicode_Result=ɬ
exit/b
:Unicodeɬ
set Unicode_Result=28073
exit/b
:Unicode26862
set Unicode_Result=ɭ
exit/b
:Unicodeɭ
set Unicode_Result=26862
exit/b
:Unicode20711
set Unicode_Result=ɮ
exit/b
:Unicodeɮ
set Unicode_Result=20711
exit/b
:Unicode33678
set Unicode_Result=ɯ
exit/b
:Unicodeɯ
set Unicode_Result=33678
exit/b
:Unicode30722
set Unicode_Result=ɰ
exit/b
:Unicodeɰ
set Unicode_Result=30722
exit/b
:Unicode26432
set Unicode_Result=ɱ
exit/b
:Unicodeɱ
set Unicode_Result=26432
exit/b
:Unicode21049
set Unicode_Result=ɲ
exit/b
:Unicodeɲ
set Unicode_Result=21049
exit/b
:Unicode27801
set Unicode_Result=ɳ
exit/b
:Unicodeɳ
set Unicode_Result=27801
exit/b
:Unicode32433
set Unicode_Result=ɴ
exit/b
:Unicodeɴ
set Unicode_Result=32433
exit/b
:Unicode20667
set Unicode_Result=ɵ
exit/b
:Unicodeɵ
set Unicode_Result=20667
exit/b
:Unicode21861
set Unicode_Result=ɶ
exit/b
:Unicodeɶ
set Unicode_Result=21861
exit/b
:Unicode29022
set Unicode_Result=ɷ
exit/b
:Unicodeɷ
set Unicode_Result=29022
exit/b
:Unicode31579
set Unicode_Result=ɸ
exit/b
:Unicodeɸ
set Unicode_Result=31579
exit/b
:Unicode26194
set Unicode_Result=ɹ
exit/b
:Unicodeɹ
set Unicode_Result=26194
exit/b
:Unicode29642
set Unicode_Result=ɺ
exit/b
:Unicodeɺ
set Unicode_Result=29642
exit/b
:Unicode33515
set Unicode_Result=ɻ
exit/b
:Unicodeɻ
set Unicode_Result=33515
exit/b
:Unicode26441
set Unicode_Result=ɼ
exit/b
:Unicodeɼ
set Unicode_Result=26441
exit/b
:Unicode23665
set Unicode_Result=ɽ
exit/b
:Unicodeɽ
set Unicode_Result=23665
exit/b
:Unicode21024
set Unicode_Result=ɾ
exit/b
:Unicodeɾ
set Unicode_Result=21024
exit/b
:Unicode29053
set Unicode_Result=ɿ
exit/b
:Unicodeɿ
set Unicode_Result=29053
exit/b
:Unicode34923
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34923
exit/b
:Unicode38378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38378
exit/b
:Unicode38485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38485
exit/b
:Unicode25797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25797
exit/b
:Unicode36193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36193
exit/b
:Unicode33203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33203
exit/b
:Unicode21892
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21892
exit/b
:Unicode27733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27733
exit/b
:Unicode25159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25159
exit/b
:Unicode32558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32558
exit/b
:Unicode22674
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22674
exit/b
:Unicode20260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20260
exit/b
:Unicode21830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21830
exit/b
:Unicode36175
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36175
exit/b
:Unicode26188
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26188
exit/b
:Unicode19978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19978
exit/b
:Unicode23578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23578
exit/b
:Unicode35059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35059
exit/b
:Unicode26786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26786
exit/b
:Unicode25422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25422
exit/b
:Unicode31245
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31245
exit/b
:Unicode28903
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28903
exit/b
:Unicode33421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33421
exit/b
:Unicode21242
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21242
exit/b
:Unicode38902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38902
exit/b
:Unicode23569
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23569
exit/b
:Unicode21736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21736
exit/b
:Unicode37045
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37045
exit/b
:Unicode32461
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32461
exit/b
:Unicode22882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22882
exit/b
:Unicode36170
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36170
exit/b
:Unicode34503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34503
exit/b
:Unicode33292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33292
exit/b
:Unicode33293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33293
exit/b
:Unicode36198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36198
exit/b
:Unicode25668
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25668
exit/b
:Unicode23556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23556
exit/b
:Unicode24913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24913
exit/b
:Unicode28041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28041
exit/b
:Unicode31038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31038
exit/b
:Unicode35774
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35774
exit/b
:Unicode30775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30775
exit/b
:Unicode30003
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30003
exit/b
:Unicode21627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21627
exit/b
:Unicode20280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20280
exit/b
:Unicode36523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36523
exit/b
:Unicode28145
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28145
exit/b
:Unicode23072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23072
exit/b
:Unicode32453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32453
exit/b
:Unicode31070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31070
exit/b
:Unicode27784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27784
exit/b
:Unicode23457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23457
exit/b
:Unicode23158
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23158
exit/b
:Unicode29978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29978
exit/b
:Unicode32958
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32958
exit/b
:Unicode24910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24910
exit/b
:Unicode28183
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28183
exit/b
:Unicode22768
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22768
exit/b
:Unicode29983
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29983
exit/b
:Unicode29989
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29989
exit/b
:Unicode29298
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29298
exit/b
:Unicode21319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21319
exit/b
:Unicode32499
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32499
exit/b
:Unicode30465
set Unicode_Result=ʡ
exit/b
:Unicodeʡ
set Unicode_Result=30465
exit/b
:Unicode30427
set Unicode_Result=ʢ
exit/b
:Unicodeʢ
set Unicode_Result=30427
exit/b
:Unicode21097
set Unicode_Result=ʣ
exit/b
:Unicodeʣ
set Unicode_Result=21097
exit/b
:Unicode32988
set Unicode_Result=ʤ
exit/b
:Unicodeʤ
set Unicode_Result=32988
exit/b
:Unicode22307
set Unicode_Result=ʥ
exit/b
:Unicodeʥ
set Unicode_Result=22307
exit/b
:Unicode24072
set Unicode_Result=ʦ
exit/b
:Unicodeʦ
set Unicode_Result=24072
exit/b
:Unicode22833
set Unicode_Result=ʧ
exit/b
:Unicodeʧ
set Unicode_Result=22833
exit/b
:Unicode29422
set Unicode_Result=ʨ
exit/b
:Unicodeʨ
set Unicode_Result=29422
exit/b
:Unicode26045
set Unicode_Result=ʩ
exit/b
:Unicodeʩ
set Unicode_Result=26045
exit/b
:Unicode28287
set Unicode_Result=ʪ
exit/b
:Unicodeʪ
set Unicode_Result=28287
exit/b
:Unicode35799
set Unicode_Result=ʫ
exit/b
:Unicodeʫ
set Unicode_Result=35799
exit/b
:Unicode23608
set Unicode_Result=ʬ
exit/b
:Unicodeʬ
set Unicode_Result=23608
exit/b
:Unicode34417
set Unicode_Result=ʭ
exit/b
:Unicodeʭ
set Unicode_Result=34417
exit/b
:Unicode21313
set Unicode_Result=ʮ
exit/b
:Unicodeʮ
set Unicode_Result=21313
exit/b
:Unicode30707
set Unicode_Result=ʯ
exit/b
:Unicodeʯ
set Unicode_Result=30707
exit/b
:Unicode25342
set Unicode_Result=ʰ
exit/b
:Unicodeʰ
set Unicode_Result=25342
exit/b
:Unicode26102
set Unicode_Result=ʱ
exit/b
:Unicodeʱ
set Unicode_Result=26102
exit/b
:Unicode20160
set Unicode_Result=ʲ
exit/b
:Unicodeʲ
set Unicode_Result=20160
exit/b
:Unicode39135
set Unicode_Result=ʳ
exit/b
:Unicodeʳ
set Unicode_Result=39135
exit/b
:Unicode34432
set Unicode_Result=ʴ
exit/b
:Unicodeʴ
set Unicode_Result=34432
exit/b
:Unicode23454
set Unicode_Result=ʵ
exit/b
:Unicodeʵ
set Unicode_Result=23454
exit/b
:Unicode35782
set Unicode_Result=ʶ
exit/b
:Unicodeʶ
set Unicode_Result=35782
exit/b
:Unicode21490
set Unicode_Result=ʷ
exit/b
:Unicodeʷ
set Unicode_Result=21490
exit/b
:Unicode30690
set Unicode_Result=ʸ
exit/b
:Unicodeʸ
set Unicode_Result=30690
exit/b
:Unicode20351
set Unicode_Result=ʹ
exit/b
:Unicodeʹ
set Unicode_Result=20351
exit/b
:Unicode23630
set Unicode_Result=ʺ
exit/b
:Unicodeʺ
set Unicode_Result=23630
exit/b
:Unicode39542
set Unicode_Result=ʻ
exit/b
:Unicodeʻ
set Unicode_Result=39542
exit/b
:Unicode22987
set Unicode_Result=ʼ
exit/b
:Unicodeʼ
set Unicode_Result=22987
exit/b
:Unicode24335
set Unicode_Result=ʽ
exit/b
:Unicodeʽ
set Unicode_Result=24335
exit/b
:Unicode31034
set Unicode_Result=ʾ
exit/b
:Unicodeʾ
set Unicode_Result=31034
exit/b
:Unicode22763
set Unicode_Result=ʿ
exit/b
:Unicodeʿ
set Unicode_Result=22763
exit/b
:Unicode19990
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19990
exit/b
:Unicode26623
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26623
exit/b
:Unicode20107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20107
exit/b
:Unicode25325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25325
exit/b
:Unicode35475
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35475
exit/b
:Unicode36893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36893
exit/b
:Unicode21183
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21183
exit/b
:Unicode26159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26159
exit/b
:Unicode21980
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21980
exit/b
:Unicode22124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22124
exit/b
:Unicode36866
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36866
exit/b
:Unicode20181
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20181
exit/b
:Unicode20365
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20365
exit/b
:Unicode37322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37322
exit/b
:Unicode39280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39280
exit/b
:Unicode27663
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27663
exit/b
:Unicode24066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24066
exit/b
:Unicode24643
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24643
exit/b
:Unicode23460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23460
exit/b
:Unicode35270
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35270
exit/b
:Unicode35797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35797
exit/b
:Unicode25910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25910
exit/b
:Unicode25163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25163
exit/b
:Unicode39318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39318
exit/b
:Unicode23432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23432
exit/b
:Unicode23551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23551
exit/b
:Unicode25480
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25480
exit/b
:Unicode21806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21806
exit/b
:Unicode21463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21463
exit/b
:Unicode30246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30246
exit/b
:Unicode20861
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20861
exit/b
:Unicode34092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34092
exit/b
:Unicode26530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26530
exit/b
:Unicode26803
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26803
exit/b
:Unicode27530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27530
exit/b
:Unicode25234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25234
exit/b
:Unicode36755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36755
exit/b
:Unicode21460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21460
exit/b
:Unicode33298
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33298
exit/b
:Unicode28113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28113
exit/b
:Unicode30095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30095
exit/b
:Unicode20070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20070
exit/b
:Unicode36174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36174
exit/b
:Unicode23408
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23408
exit/b
:Unicode29087
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29087
exit/b
:Unicode34223
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34223
exit/b
:Unicode26257
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26257
exit/b
:Unicode26329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26329
exit/b
:Unicode32626
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32626
exit/b
:Unicode34560
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34560
exit/b
:Unicode40653
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40653
exit/b
:Unicode40736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40736
exit/b
:Unicode23646
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23646
exit/b
:Unicode26415
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26415
exit/b
:Unicode36848
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36848
exit/b
:Unicode26641
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26641
exit/b
:Unicode26463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26463
exit/b
:Unicode25101
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25101
exit/b
:Unicode31446
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31446
exit/b
:Unicode22661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22661
exit/b
:Unicode24246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24246
exit/b
:Unicode25968
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25968
exit/b
:Unicode28465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28465
exit/b
:Unicode24661
set Unicode_Result=ˡ
exit/b
:Unicodeˡ
set Unicode_Result=24661
exit/b
:Unicode21047
set Unicode_Result=ˢ
exit/b
:Unicodeˢ
set Unicode_Result=21047
exit/b
:Unicode32781
set Unicode_Result=ˣ
exit/b
:Unicodeˣ
set Unicode_Result=32781
exit/b
:Unicode25684
set Unicode_Result=ˤ
exit/b
:Unicodeˤ
set Unicode_Result=25684
exit/b
:Unicode34928
set Unicode_Result=˥
exit/b
:Unicode˥
set Unicode_Result=34928
exit/b
:Unicode29993
set Unicode_Result=˦
exit/b
:Unicode˦
set Unicode_Result=29993
exit/b
:Unicode24069
set Unicode_Result=˧
exit/b
:Unicode˧
set Unicode_Result=24069
exit/b
:Unicode26643
set Unicode_Result=˨
exit/b
:Unicode˨
set Unicode_Result=26643
exit/b
:Unicode25332
set Unicode_Result=˩
exit/b
:Unicode˩
set Unicode_Result=25332
exit/b
:Unicode38684
set Unicode_Result=˪
exit/b
:Unicode˪
set Unicode_Result=38684
exit/b
:Unicode21452
set Unicode_Result=˫
exit/b
:Unicode˫
set Unicode_Result=21452
exit/b
:Unicode29245
set Unicode_Result=ˬ
exit/b
:Unicodeˬ
set Unicode_Result=29245
exit/b
:Unicode35841
set Unicode_Result=˭
exit/b
:Unicode˭
set Unicode_Result=35841
exit/b
:Unicode27700
set Unicode_Result=ˮ
exit/b
:Unicodeˮ
set Unicode_Result=27700
exit/b
:Unicode30561
set Unicode_Result=˯
exit/b
:Unicode˯
set Unicode_Result=30561
exit/b
:Unicode31246
set Unicode_Result=˰
exit/b
:Unicode˰
set Unicode_Result=31246
exit/b
:Unicode21550
set Unicode_Result=˱
exit/b
:Unicode˱
set Unicode_Result=21550
exit/b
:Unicode30636
set Unicode_Result=˲
exit/b
:Unicode˲
set Unicode_Result=30636
exit/b
:Unicode39034
set Unicode_Result=˳
exit/b
:Unicode˳
set Unicode_Result=39034
exit/b
:Unicode33308
set Unicode_Result=˴
exit/b
:Unicode˴
set Unicode_Result=33308
exit/b
:Unicode35828
set Unicode_Result=˵
exit/b
:Unicode˵
set Unicode_Result=35828
exit/b
:Unicode30805
set Unicode_Result=˶
exit/b
:Unicode˶
set Unicode_Result=30805
exit/b
:Unicode26388
set Unicode_Result=˷
exit/b
:Unicode˷
set Unicode_Result=26388
exit/b
:Unicode28865
set Unicode_Result=˸
exit/b
:Unicode˸
set Unicode_Result=28865
exit/b
:Unicode26031
set Unicode_Result=˹
exit/b
:Unicode˹
set Unicode_Result=26031
exit/b
:Unicode25749
set Unicode_Result=˺
exit/b
:Unicode˺
set Unicode_Result=25749
exit/b
:Unicode22070
set Unicode_Result=˻
exit/b
:Unicode˻
set Unicode_Result=22070
exit/b
:Unicode24605
set Unicode_Result=˼
exit/b
:Unicode˼
set Unicode_Result=24605
exit/b
:Unicode31169
set Unicode_Result=˽
exit/b
:Unicode˽
set Unicode_Result=31169
exit/b
:Unicode21496
set Unicode_Result=˾
exit/b
:Unicode˾
set Unicode_Result=21496
exit/b
:Unicode19997
set Unicode_Result=˿
exit/b
:Unicode˿
set Unicode_Result=19997
exit/b
:Unicode27515
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27515
exit/b
:Unicode32902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32902
exit/b
:Unicode23546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23546
exit/b
:Unicode21987
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21987
exit/b
:Unicode22235
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22235
exit/b
:Unicode20282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20282
exit/b
:Unicode20284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20284
exit/b
:Unicode39282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39282
exit/b
:Unicode24051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24051
exit/b
:Unicode26494
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26494
exit/b
:Unicode32824
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32824
exit/b
:Unicode24578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24578
exit/b
:Unicode39042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39042
exit/b
:Unicode36865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36865
exit/b
:Unicode23435
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23435
exit/b
:Unicode35772
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35772
exit/b
:Unicode35829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35829
exit/b
:Unicode25628
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25628
exit/b
:Unicode33368
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33368
exit/b
:Unicode25822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25822
exit/b
:Unicode22013
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22013
exit/b
:Unicode33487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33487
exit/b
:Unicode37221
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37221
exit/b
:Unicode20439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20439
exit/b
:Unicode32032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32032
exit/b
:Unicode36895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36895
exit/b
:Unicode31903
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31903
exit/b
:Unicode20723
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20723
exit/b
:Unicode22609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22609
exit/b
:Unicode28335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28335
exit/b
:Unicode23487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23487
exit/b
:Unicode35785
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35785
exit/b
:Unicode32899
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32899
exit/b
:Unicode37240
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37240
exit/b
:Unicode33948
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33948
exit/b
:Unicode31639
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31639
exit/b
:Unicode34429
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34429
exit/b
:Unicode38539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38539
exit/b
:Unicode38543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38543
exit/b
:Unicode32485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32485
exit/b
:Unicode39635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39635
exit/b
:Unicode30862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30862
exit/b
:Unicode23681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23681
exit/b
:Unicode31319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31319
exit/b
:Unicode36930
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36930
exit/b
:Unicode38567
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38567
exit/b
:Unicode31071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31071
exit/b
:Unicode23385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23385
exit/b
:Unicode25439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25439
exit/b
:Unicode31499
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31499
exit/b
:Unicode34001
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34001
exit/b
:Unicode26797
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26797
exit/b
:Unicode21766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21766
exit/b
:Unicode32553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32553
exit/b
:Unicode29712
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29712
exit/b
:Unicode32034
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32034
exit/b
:Unicode38145
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38145
exit/b
:Unicode25152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25152
exit/b
:Unicode22604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22604
exit/b
:Unicode20182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20182
exit/b
:Unicode23427
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23427
exit/b
:Unicode22905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22905
exit/b
:Unicode22612
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22612
exit/b
:Unicode29549
set Unicode_Result=̡
exit/b
:Unicode̡
set Unicode_Result=29549
exit/b
:Unicode25374
set Unicode_Result=̢
exit/b
:Unicode̢
set Unicode_Result=25374
exit/b
:Unicode36427
set Unicode_Result=̣
exit/b
:Unicodẹ
set Unicode_Result=36427
exit/b
:Unicode36367
set Unicode_Result=̤
exit/b
:Unicode̤
set Unicode_Result=36367
exit/b
:Unicode32974
set Unicode_Result=̥
exit/b
:Unicode̥
set Unicode_Result=32974
exit/b
:Unicode33492
set Unicode_Result=̦
exit/b
:Unicode̦
set Unicode_Result=33492
exit/b
:Unicode25260
set Unicode_Result=̧
exit/b
:Unicodȩ
set Unicode_Result=25260
exit/b
:Unicode21488
set Unicode_Result=̨
exit/b
:Unicodę
set Unicode_Result=21488
exit/b
:Unicode27888
set Unicode_Result=̩
exit/b
:Unicode̩
set Unicode_Result=27888
exit/b
:Unicode37214
set Unicode_Result=̪
exit/b
:Unicode̪
set Unicode_Result=37214
exit/b
:Unicode22826
set Unicode_Result=̫
exit/b
:Unicode̫
set Unicode_Result=22826
exit/b
:Unicode24577
set Unicode_Result=̬
exit/b
:Unicode̬
set Unicode_Result=24577
exit/b
:Unicode27760
set Unicode_Result=̭
exit/b
:Unicodḙ
set Unicode_Result=27760
exit/b
:Unicode22349
set Unicode_Result=̮
exit/b
:Unicode̮
set Unicode_Result=22349
exit/b
:Unicode25674
set Unicode_Result=̯
exit/b
:Unicode̯
set Unicode_Result=25674
exit/b
:Unicode36138
set Unicode_Result=̰
exit/b
:Unicodḛ
set Unicode_Result=36138
exit/b
:Unicode30251
set Unicode_Result=̱
exit/b
:Unicode̱
set Unicode_Result=30251
exit/b
:Unicode28393
set Unicode_Result=̲
exit/b
:Unicode̲
set Unicode_Result=28393
exit/b
:Unicode22363
set Unicode_Result=̳
exit/b
:Unicode̳
set Unicode_Result=22363
exit/b
:Unicode27264
set Unicode_Result=̴
exit/b
:Unicode̴
set Unicode_Result=27264
exit/b
:Unicode30192
set Unicode_Result=̵
exit/b
:Unicode̵
set Unicode_Result=30192
exit/b
:Unicode28525
set Unicode_Result=̶
exit/b
:Unicode̶
set Unicode_Result=28525
exit/b
:Unicode35885
set Unicode_Result=̷
exit/b
:Unicode̷
set Unicode_Result=35885
exit/b
:Unicode35848
set Unicode_Result≠
exit/b
:Unicode̸
set Unicode_Result=35848
exit/b
:Unicode22374
set Unicode_Result=̹
exit/b
:Unicode̹
set Unicode_Result=22374
exit/b
:Unicode27631
set Unicode_Result=̺
exit/b
:Unicode̺
set Unicode_Result=27631
exit/b
:Unicode34962
set Unicode_Result=̻
exit/b
:Unicode̻
set Unicode_Result=34962
exit/b
:Unicode30899
set Unicode_Result=̼
exit/b
:Unicode̼
set Unicode_Result=30899
exit/b
:Unicode25506
set Unicode_Result=̽
exit/b
:Unicode̽
set Unicode_Result=25506
exit/b
:Unicode21497
set Unicode_Result=̾
exit/b
:Unicode̾
set Unicode_Result=21497
exit/b
:Unicode28845
set Unicode_Result=̿
exit/b
:Unicode̿
set Unicode_Result=28845
exit/b
:Unicode27748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27748
exit/b
:Unicode22616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22616
exit/b
:Unicode25642
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25642
exit/b
:Unicode22530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22530
exit/b
:Unicode26848
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26848
exit/b
:Unicode33179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33179
exit/b
:Unicode21776
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21776
exit/b
:Unicode31958
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31958
exit/b
:Unicode20504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20504
exit/b
:Unicode36538
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36538
exit/b
:Unicode28108
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28108
exit/b
:Unicode36255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36255
exit/b
:Unicode28907
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28907
exit/b
:Unicode25487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25487
exit/b
:Unicode28059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28059
exit/b
:Unicode28372
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28372
exit/b
:Unicode32486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32486
exit/b
:Unicode33796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33796
exit/b
:Unicode26691
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26691
exit/b
:Unicode36867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36867
exit/b
:Unicode28120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28120
exit/b
:Unicode38518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38518
exit/b
:Unicode35752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35752
exit/b
:Unicode22871
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22871
exit/b
:Unicode29305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29305
exit/b
:Unicode34276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34276
exit/b
:Unicode33150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33150
exit/b
:Unicode30140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30140
exit/b
:Unicode35466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35466
exit/b
:Unicode26799
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26799
exit/b
:Unicode21076
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21076
exit/b
:Unicode36386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36386
exit/b
:Unicode38161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38161
exit/b
:Unicode25552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25552
exit/b
:Unicode39064
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39064
exit/b
:Unicode36420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36420
exit/b
:Unicode21884
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21884
exit/b
:Unicode20307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20307
exit/b
:Unicode26367
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26367
exit/b
:Unicode22159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22159
exit/b
:Unicode24789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24789
exit/b
:Unicode28053
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28053
exit/b
:Unicode21059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21059
exit/b
:Unicode23625
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23625
exit/b
:Unicode22825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22825
exit/b
:Unicode28155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28155
exit/b
:Unicode22635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22635
exit/b
:Unicode30000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30000
exit/b
:Unicode29980
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29980
exit/b
:Unicode24684
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24684
exit/b
:Unicode33300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33300
exit/b
:Unicode33094
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33094
exit/b
:Unicode25361
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25361
exit/b
:Unicode26465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26465
exit/b
:Unicode36834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36834
exit/b
:Unicode30522
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30522
exit/b
:Unicode36339
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36339
exit/b
:Unicode36148
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36148
exit/b
:Unicode38081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38081
exit/b
:Unicode24086
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24086
exit/b
:Unicode21381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21381
exit/b
:Unicode21548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21548
exit/b
:Unicode28867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28867
exit/b
:Unicode27712
set Unicode_Result=͡
exit/b
:Unicode͡
set Unicode_Result=27712
exit/b
:Unicode24311
set Unicode_Result=͢
exit/b
:Unicode͢
set Unicode_Result=24311
exit/b
:Unicode20572
set Unicode_Result=ͣ
exit/b
:Unicodeͣ
set Unicode_Result=20572
exit/b
:Unicode20141
set Unicode_Result=ͤ
exit/b
:Unicodeͤ
set Unicode_Result=20141
exit/b
:Unicode24237
set Unicode_Result=ͥ
exit/b
:Unicodeͥ
set Unicode_Result=24237
exit/b
:Unicode25402
set Unicode_Result=ͦ
exit/b
:Unicodeͦ
set Unicode_Result=25402
exit/b
:Unicode33351
set Unicode_Result=ͧ
exit/b
:Unicodeͧ
set Unicode_Result=33351
exit/b
:Unicode36890
set Unicode_Result=ͨ
exit/b
:Unicodeͨ
set Unicode_Result=36890
exit/b
:Unicode26704
set Unicode_Result=ͩ
exit/b
:Unicodeͩ
set Unicode_Result=26704
exit/b
:Unicode37230
set Unicode_Result=ͪ
exit/b
:Unicodeͪ
set Unicode_Result=37230
exit/b
:Unicode30643
set Unicode_Result=ͫ
exit/b
:Unicodeͫ
set Unicode_Result=30643
exit/b
:Unicode21516
set Unicode_Result=ͬ
exit/b
:Unicodeͬ
set Unicode_Result=21516
exit/b
:Unicode38108
set Unicode_Result=ͭ
exit/b
:Unicodeͭ
set Unicode_Result=38108
exit/b
:Unicode24420
set Unicode_Result=ͮ
exit/b
:Unicodeͮ
set Unicode_Result=24420
exit/b
:Unicode31461
set Unicode_Result=ͯ
exit/b
:Unicodeͯ
set Unicode_Result=31461
exit/b
:Unicode26742
set Unicode_Result=Ͱ
exit/b
:UnicodeͰ
set Unicode_Result=26742
exit/b
:Unicode25413
set Unicode_Result=ͱ
exit/b
:Unicodeͱ
set Unicode_Result=25413
exit/b
:Unicode31570
set Unicode_Result=Ͳ
exit/b
:UnicodeͲ
set Unicode_Result=31570
exit/b
:Unicode32479
set Unicode_Result=ͳ
exit/b
:Unicodeͳ
set Unicode_Result=32479
exit/b
:Unicode30171
set Unicode_Result=ʹ
exit/b
:Unicodeʹ
set Unicode_Result=30171
exit/b
:Unicode20599
set Unicode_Result=͵
exit/b
:Unicode͵
set Unicode_Result=20599
exit/b
:Unicode25237
set Unicode_Result=Ͷ
exit/b
:UnicodeͶ
set Unicode_Result=25237
exit/b
:Unicode22836
set Unicode_Result=ͷ
exit/b
:Unicodeͷ
set Unicode_Result=22836
exit/b
:Unicode36879
set Unicode_Result=͸
exit/b
:Unicode͸
set Unicode_Result=36879
exit/b
:Unicode20984
set Unicode_Result=͹
exit/b
:Unicode͹
set Unicode_Result=20984
exit/b
:Unicode31171
set Unicode_Result=ͺ
exit/b
:Unicodeͺ
set Unicode_Result=31171
exit/b
:Unicode31361
set Unicode_Result=ͻ
exit/b
:Unicodeͻ
set Unicode_Result=31361
exit/b
:Unicode22270
set Unicode_Result=ͼ
exit/b
:Unicodeͼ
set Unicode_Result=22270
exit/b
:Unicode24466
set Unicode_Result=ͽ
exit/b
:Unicodeͽ
set Unicode_Result=24466
exit/b
:Unicode36884
set Unicode_Result=;
exit/b
:Unicode;
set Unicode_Result=36884
exit/b
:Unicode28034
set Unicode_Result=Ϳ
exit/b
:UnicodeͿ
set Unicode_Result=28034
exit/b
:Unicode23648
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23648
exit/b
:Unicode22303
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22303
exit/b
:Unicode21520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21520
exit/b
:Unicode20820
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20820
exit/b
:Unicode28237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28237
exit/b
:Unicode22242
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22242
exit/b
:Unicode25512
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25512
exit/b
:Unicode39059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39059
exit/b
:Unicode33151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33151
exit/b
:Unicode34581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34581
exit/b
:Unicode35114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35114
exit/b
:Unicode36864
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36864
exit/b
:Unicode21534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21534
exit/b
:Unicode23663
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23663
exit/b
:Unicode33216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33216
exit/b
:Unicode25302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25302
exit/b
:Unicode25176
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25176
exit/b
:Unicode33073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33073
exit/b
:Unicode40501
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40501
exit/b
:Unicode38464
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38464
exit/b
:Unicode39534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39534
exit/b
:Unicode39548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39548
exit/b
:Unicode26925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26925
exit/b
:Unicode22949
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22949
exit/b
:Unicode25299
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25299
exit/b
:Unicode21822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21822
exit/b
:Unicode25366
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25366
exit/b
:Unicode21703
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21703
exit/b
:Unicode34521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34521
exit/b
:Unicode27964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27964
exit/b
:Unicode23043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23043
exit/b
:Unicode29926
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29926
exit/b
:Unicode34972
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34972
exit/b
:Unicode27498
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27498
exit/b
:Unicode22806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22806
exit/b
:Unicode35916
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35916
exit/b
:Unicode24367
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24367
exit/b
:Unicode28286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28286
exit/b
:Unicode29609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29609
exit/b
:Unicode39037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39037
exit/b
:Unicode20024
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20024
exit/b
:Unicode28919
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28919
exit/b
:Unicode23436
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23436
exit/b
:Unicode30871
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30871
exit/b
:Unicode25405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25405
exit/b
:Unicode26202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26202
exit/b
:Unicode30358
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30358
exit/b
:Unicode24779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24779
exit/b
:Unicode23451
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23451
exit/b
:Unicode23113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23113
exit/b
:Unicode19975
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19975
exit/b
:Unicode33109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33109
exit/b
:Unicode27754
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27754
exit/b
:Unicode29579
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29579
exit/b
:Unicode20129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20129
exit/b
:Unicode26505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26505
exit/b
:Unicode32593
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32593
exit/b
:Unicode24448
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24448
exit/b
:Unicode26106
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26106
exit/b
:Unicode26395
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26395
exit/b
:Unicode24536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24536
exit/b
:Unicode22916
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22916
exit/b
:Unicode23041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23041
exit/b
:Unicode24013
set Unicode_Result=Ρ
exit/b
:UnicodeΡ
set Unicode_Result=24013
exit/b
:Unicode24494
set Unicode_Result=΢
exit/b
:Unicode΢
set Unicode_Result=24494
exit/b
:Unicode21361
set Unicode_Result=Σ
exit/b
:UnicodeΣ
set Unicode_Result=21361
exit/b
:Unicode38886
set Unicode_Result=Τ
exit/b
:UnicodeΤ
set Unicode_Result=38886
exit/b
:Unicode36829
set Unicode_Result=Υ
exit/b
:UnicodeΥ
set Unicode_Result=36829
exit/b
:Unicode26693
set Unicode_Result=Φ
exit/b
:UnicodeΦ
set Unicode_Result=26693
exit/b
:Unicode22260
set Unicode_Result=Χ
exit/b
:UnicodeΧ
set Unicode_Result=22260
exit/b
:Unicode21807
set Unicode_Result=Ψ
exit/b
:UnicodeΨ
set Unicode_Result=21807
exit/b
:Unicode24799
set Unicode_Result=Ω
exit/b
:UnicodeΩ
set Unicode_Result=24799
exit/b
:Unicode20026
set Unicode_Result=Ϊ
exit/b
:UnicodeΪ
set Unicode_Result=20026
exit/b
:Unicode28493
set Unicode_Result=Ϋ
exit/b
:UnicodeΫ
set Unicode_Result=28493
exit/b
:Unicode32500
set Unicode_Result=ά
exit/b
:Unicodeά
set Unicode_Result=32500
exit/b
:Unicode33479
set Unicode_Result=έ
exit/b
:Unicodeέ
set Unicode_Result=33479
exit/b
:Unicode33806
set Unicode_Result=ή
exit/b
:Unicodeή
set Unicode_Result=33806
exit/b
:Unicode22996
set Unicode_Result=ί
exit/b
:Unicodeί
set Unicode_Result=22996
exit/b
:Unicode20255
set Unicode_Result=ΰ
exit/b
:Unicodeΰ
set Unicode_Result=20255
exit/b
:Unicode20266
set Unicode_Result=α
exit/b
:Unicodeα
set Unicode_Result=20266
exit/b
:Unicode23614
set Unicode_Result=β
exit/b
:Unicodeβ
set Unicode_Result=23614
exit/b
:Unicode32428
set Unicode_Result=γ
exit/b
:Unicodeγ
set Unicode_Result=32428
exit/b
:Unicode26410
set Unicode_Result=δ
exit/b
:Unicodeδ
set Unicode_Result=26410
exit/b
:Unicode34074
set Unicode_Result=ε
exit/b
:Unicodeε
set Unicode_Result=34074
exit/b
:Unicode21619
set Unicode_Result=ζ
exit/b
:Unicodeζ
set Unicode_Result=21619
exit/b
:Unicode30031
set Unicode_Result=η
exit/b
:Unicodeη
set Unicode_Result=30031
exit/b
:Unicode32963
set Unicode_Result=θ
exit/b
:Unicodeθ
set Unicode_Result=32963
exit/b
:Unicode21890
set Unicode_Result=ι
exit/b
:Unicodeι
set Unicode_Result=21890
exit/b
:Unicode39759
set Unicode_Result=κ
exit/b
:Unicodeκ
set Unicode_Result=39759
exit/b
:Unicode20301
set Unicode_Result=λ
exit/b
:Unicodeλ
set Unicode_Result=20301
exit/b
:Unicode28205
set Unicode_Result=μ
exit/b
:Unicodeμ
set Unicode_Result=28205
exit/b
:Unicode35859
set Unicode_Result=ν
exit/b
:Unicodeν
set Unicode_Result=35859
exit/b
:Unicode23561
set Unicode_Result=ξ
exit/b
:Unicodeξ
set Unicode_Result=23561
exit/b
:Unicode24944
set Unicode_Result=ο
exit/b
:Unicodeο
set Unicode_Result=24944
exit/b
:Unicode21355
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21355
exit/b
:Unicode30239
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30239
exit/b
:Unicode28201
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28201
exit/b
:Unicode34442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34442
exit/b
:Unicode25991
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25991
exit/b
:Unicode38395
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38395
exit/b
:Unicode32441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32441
exit/b
:Unicode21563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21563
exit/b
:Unicode31283
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31283
exit/b
:Unicode32010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32010
exit/b
:Unicode38382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38382
exit/b
:Unicode21985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21985
exit/b
:Unicode32705
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32705
exit/b
:Unicode29934
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29934
exit/b
:Unicode25373
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25373
exit/b
:Unicode34583
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34583
exit/b
:Unicode28065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28065
exit/b
:Unicode31389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31389
exit/b
:Unicode25105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25105
exit/b
:Unicode26017
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26017
exit/b
:Unicode21351
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21351
exit/b
:Unicode25569
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25569
exit/b
:Unicode27779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27779
exit/b
:Unicode24043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24043
exit/b
:Unicode21596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21596
exit/b
:Unicode38056
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38056
exit/b
:Unicode20044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20044
exit/b
:Unicode27745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27745
exit/b
:Unicode35820
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35820
exit/b
:Unicode23627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23627
exit/b
:Unicode26080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26080
exit/b
:Unicode33436
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33436
exit/b
:Unicode26791
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26791
exit/b
:Unicode21566
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21566
exit/b
:Unicode21556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21556
exit/b
:Unicode27595
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27595
exit/b
:Unicode27494
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27494
exit/b
:Unicode20116
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20116
exit/b
:Unicode25410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25410
exit/b
:Unicode21320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21320
exit/b
:Unicode33310
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33310
exit/b
:Unicode20237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20237
exit/b
:Unicode20398
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20398
exit/b
:Unicode22366
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22366
exit/b
:Unicode25098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25098
exit/b
:Unicode38654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38654
exit/b
:Unicode26212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26212
exit/b
:Unicode29289
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29289
exit/b
:Unicode21247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21247
exit/b
:Unicode21153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21153
exit/b
:Unicode24735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24735
exit/b
:Unicode35823
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35823
exit/b
:Unicode26132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26132
exit/b
:Unicode29081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29081
exit/b
:Unicode26512
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26512
exit/b
:Unicode35199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35199
exit/b
:Unicode30802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30802
exit/b
:Unicode30717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30717
exit/b
:Unicode26224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26224
exit/b
:Unicode22075
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22075
exit/b
:Unicode21560
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21560
exit/b
:Unicode38177
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38177
exit/b
:Unicode29306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29306
exit/b
:Unicode31232
set Unicode_Result=ϡ
exit/b
:Unicodeϡ
set Unicode_Result=31232
exit/b
:Unicode24687
set Unicode_Result=Ϣ
exit/b
:UnicodeϢ
set Unicode_Result=24687
exit/b
:Unicode24076
set Unicode_Result=ϣ
exit/b
:Unicodeϣ
set Unicode_Result=24076
exit/b
:Unicode24713
set Unicode_Result=Ϥ
exit/b
:UnicodeϤ
set Unicode_Result=24713
exit/b
:Unicode33181
set Unicode_Result=ϥ
exit/b
:Unicodeϥ
set Unicode_Result=33181
exit/b
:Unicode22805
set Unicode_Result=Ϧ
exit/b
:UnicodeϦ
set Unicode_Result=22805
exit/b
:Unicode24796
set Unicode_Result=ϧ
exit/b
:Unicodeϧ
set Unicode_Result=24796
exit/b
:Unicode29060
set Unicode_Result=Ϩ
exit/b
:UnicodeϨ
set Unicode_Result=29060
exit/b
:Unicode28911
set Unicode_Result=ϩ
exit/b
:Unicodeϩ
set Unicode_Result=28911
exit/b
:Unicode28330
set Unicode_Result=Ϫ
exit/b
:UnicodeϪ
set Unicode_Result=28330
exit/b
:Unicode27728
set Unicode_Result=ϫ
exit/b
:Unicodeϫ
set Unicode_Result=27728
exit/b
:Unicode29312
set Unicode_Result=Ϭ
exit/b
:UnicodeϬ
set Unicode_Result=29312
exit/b
:Unicode27268
set Unicode_Result=ϭ
exit/b
:Unicodeϭ
set Unicode_Result=27268
exit/b
:Unicode34989
set Unicode_Result=Ϯ
exit/b
:UnicodeϮ
set Unicode_Result=34989
exit/b
:Unicode24109
set Unicode_Result=ϯ
exit/b
:Unicodeϯ
set Unicode_Result=24109
exit/b
:Unicode20064
set Unicode_Result=ϰ
exit/b
:Unicodeϰ
set Unicode_Result=20064
exit/b
:Unicode23219
set Unicode_Result=ϱ
exit/b
:Unicodeϱ
set Unicode_Result=23219
exit/b
:Unicode21916
set Unicode_Result=ϲ
exit/b
:Unicodeϲ
set Unicode_Result=21916
exit/b
:Unicode38115
set Unicode_Result=ϳ
exit/b
:Unicodeϳ
set Unicode_Result=38115
exit/b
:Unicode27927
set Unicode_Result=ϴ
exit/b
:Unicodeϴ
set Unicode_Result=27927
exit/b
:Unicode31995
set Unicode_Result=ϵ
exit/b
:Unicodeϵ
set Unicode_Result=31995
exit/b
:Unicode38553
set Unicode_Result=϶
exit/b
:Unicode϶
set Unicode_Result=38553
exit/b
:Unicode25103
set Unicode_Result=Ϸ
exit/b
:UnicodeϷ
set Unicode_Result=25103
exit/b
:Unicode32454
set Unicode_Result=ϸ
exit/b
:Unicodeϸ
set Unicode_Result=32454
exit/b
:Unicode30606
set Unicode_Result=Ϲ
exit/b
:UnicodeϹ
set Unicode_Result=30606
exit/b
:Unicode34430
set Unicode_Result=Ϻ
exit/b
:UnicodeϺ
set Unicode_Result=34430
exit/b
:Unicode21283
set Unicode_Result=ϻ
exit/b
:Unicodeϻ
set Unicode_Result=21283
exit/b
:Unicode38686
set Unicode_Result=ϼ
exit/b
:Unicodeϼ
set Unicode_Result=38686
exit/b
:Unicode36758
set Unicode_Result=Ͻ
exit/b
:UnicodeϽ
set Unicode_Result=36758
exit/b
:Unicode26247
set Unicode_Result=Ͼ
exit/b
:UnicodeϾ
set Unicode_Result=26247
exit/b
:Unicode23777
set Unicode_Result=Ͽ
exit/b
:UnicodeϿ
set Unicode_Result=23777
exit/b
:Unicode20384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20384
exit/b
:Unicode29421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29421
exit/b
:Unicode19979
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19979
exit/b
:Unicode21414
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21414
exit/b
:Unicode22799
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22799
exit/b
:Unicode21523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21523
exit/b
:Unicode25472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25472
exit/b
:Unicode38184
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38184
exit/b
:Unicode20808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20808
exit/b
:Unicode20185
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20185
exit/b
:Unicode40092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40092
exit/b
:Unicode32420
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32420
exit/b
:Unicode21688
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21688
exit/b
:Unicode36132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36132
exit/b
:Unicode34900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34900
exit/b
:Unicode33335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33335
exit/b
:Unicode38386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38386
exit/b
:Unicode28046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28046
exit/b
:Unicode24358
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24358
exit/b
:Unicode23244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23244
exit/b
:Unicode26174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26174
exit/b
:Unicode38505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38505
exit/b
:Unicode29616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29616
exit/b
:Unicode29486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29486
exit/b
:Unicode21439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21439
exit/b
:Unicode33146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33146
exit/b
:Unicode39301
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39301
exit/b
:Unicode32673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32673
exit/b
:Unicode23466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23466
exit/b
:Unicode38519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38519
exit/b
:Unicode38480
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38480
exit/b
:Unicode32447
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32447
exit/b
:Unicode30456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30456
exit/b
:Unicode21410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21410
exit/b
:Unicode38262
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38262
exit/b
:Unicode39321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39321
exit/b
:Unicode31665
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31665
exit/b
:Unicode35140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35140
exit/b
:Unicode28248
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28248
exit/b
:Unicode20065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20065
exit/b
:Unicode32724
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32724
exit/b
:Unicode31077
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31077
exit/b
:Unicode35814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35814
exit/b
:Unicode24819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24819
exit/b
:Unicode21709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21709
exit/b
:Unicode20139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20139
exit/b
:Unicode39033
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39033
exit/b
:Unicode24055
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24055
exit/b
:Unicode27233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27233
exit/b
:Unicode20687
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20687
exit/b
:Unicode21521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21521
exit/b
:Unicode35937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35937
exit/b
:Unicode33831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33831
exit/b
:Unicode30813
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30813
exit/b
:Unicode38660
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38660
exit/b
:Unicode21066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21066
exit/b
:Unicode21742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21742
exit/b
:Unicode22179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22179
exit/b
:Unicode38144
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38144
exit/b
:Unicode28040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28040
exit/b
:Unicode23477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23477
exit/b
:Unicode28102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28102
exit/b
:Unicode26195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26195
exit/b
:Unicode23567
set Unicode_Result=С
exit/b
:UnicodeС
set Unicode_Result=23567
exit/b
:Unicode23389
set Unicode_Result=Т
exit/b
:UnicodeТ
set Unicode_Result=23389
exit/b
:Unicode26657
set Unicode_Result=У
exit/b
:UnicodeУ
set Unicode_Result=26657
exit/b
:Unicode32918
set Unicode_Result=Ф
exit/b
:UnicodeФ
set Unicode_Result=32918
exit/b
:Unicode21880
set Unicode_Result=Х
exit/b
:UnicodeХ
set Unicode_Result=21880
exit/b
:Unicode31505
set Unicode_Result=Ц
exit/b
:UnicodeЦ
set Unicode_Result=31505
exit/b
:Unicode25928
set Unicode_Result=Ч
exit/b
:UnicodeЧ
set Unicode_Result=25928
exit/b
:Unicode26964
set Unicode_Result=Ш
exit/b
:UnicodeШ
set Unicode_Result=26964
exit/b
:Unicode20123
set Unicode_Result=Щ
exit/b
:UnicodeЩ
set Unicode_Result=20123
exit/b
:Unicode27463
set Unicode_Result=Ъ
exit/b
:UnicodeЪ
set Unicode_Result=27463
exit/b
:Unicode34638
set Unicode_Result=Ы
exit/b
:UnicodeЫ
set Unicode_Result=34638
exit/b
:Unicode38795
set Unicode_Result=Ь
exit/b
:UnicodeЬ
set Unicode_Result=38795
exit/b
:Unicode21327
set Unicode_Result=Э
exit/b
:UnicodeЭ
set Unicode_Result=21327
exit/b
:Unicode25375
set Unicode_Result=Ю
exit/b
:UnicodeЮ
set Unicode_Result=25375
exit/b
:Unicode25658
set Unicode_Result=Я
exit/b
:UnicodeЯ
set Unicode_Result=25658
exit/b
:Unicode37034
set Unicode_Result=а
exit/b
:Unicodeа
set Unicode_Result=37034
exit/b
:Unicode26012
set Unicode_Result=б
exit/b
:Unicodeб
set Unicode_Result=26012
exit/b
:Unicode32961
set Unicode_Result=в
exit/b
:Unicodeв
set Unicode_Result=32961
exit/b
:Unicode35856
set Unicode_Result=г
exit/b
:Unicodeг
set Unicode_Result=35856
exit/b
:Unicode20889
set Unicode_Result=д
exit/b
:Unicodeд
set Unicode_Result=20889
exit/b
:Unicode26800
set Unicode_Result=е
exit/b
:Unicodeе
set Unicode_Result=26800
exit/b
:Unicode21368
set Unicode_Result=ж
exit/b
:Unicodeж
set Unicode_Result=21368
exit/b
:Unicode34809
set Unicode_Result=з
exit/b
:Unicodeз
set Unicode_Result=34809
exit/b
:Unicode25032
set Unicode_Result=и
exit/b
:Unicodeи
set Unicode_Result=25032
exit/b
:Unicode27844
set Unicode_Result=й
exit/b
:Unicodeй
set Unicode_Result=27844
exit/b
:Unicode27899
set Unicode_Result=к
exit/b
:Unicodeк
set Unicode_Result=27899
exit/b
:Unicode35874
set Unicode_Result=л
exit/b
:Unicodeл
set Unicode_Result=35874
exit/b
:Unicode23633
set Unicode_Result=м
exit/b
:Unicodeм
set Unicode_Result=23633
exit/b
:Unicode34218
set Unicode_Result=н
exit/b
:Unicodeн
set Unicode_Result=34218
exit/b
:Unicode33455
set Unicode_Result=о
exit/b
:Unicodeо
set Unicode_Result=33455
exit/b
:Unicode38156
set Unicode_Result=п
exit/b
:Unicodeп
set Unicode_Result=38156
exit/b
:Unicode27427
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27427
exit/b
:Unicode36763
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36763
exit/b
:Unicode26032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26032
exit/b
:Unicode24571
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24571
exit/b
:Unicode24515
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24515
exit/b
:Unicode20449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20449
exit/b
:Unicode34885
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34885
exit/b
:Unicode26143
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26143
exit/b
:Unicode33125
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33125
exit/b
:Unicode29481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29481
exit/b
:Unicode24826
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24826
exit/b
:Unicode20852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20852
exit/b
:Unicode21009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21009
exit/b
:Unicode22411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22411
exit/b
:Unicode24418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24418
exit/b
:Unicode37026
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37026
exit/b
:Unicode34892
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34892
exit/b
:Unicode37266
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37266
exit/b
:Unicode24184
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24184
exit/b
:Unicode26447
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26447
exit/b
:Unicode24615
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24615
exit/b
:Unicode22995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22995
exit/b
:Unicode20804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20804
exit/b
:Unicode20982
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20982
exit/b
:Unicode33016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33016
exit/b
:Unicode21256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21256
exit/b
:Unicode27769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27769
exit/b
:Unicode38596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38596
exit/b
:Unicode29066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29066
exit/b
:Unicode20241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20241
exit/b
:Unicode20462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20462
exit/b
:Unicode32670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32670
exit/b
:Unicode26429
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26429
exit/b
:Unicode21957
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21957
exit/b
:Unicode38152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38152
exit/b
:Unicode31168
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31168
exit/b
:Unicode34966
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34966
exit/b
:Unicode32483
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32483
exit/b
:Unicode22687
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22687
exit/b
:Unicode25100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25100
exit/b
:Unicode38656
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38656
exit/b
:Unicode34394
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34394
exit/b
:Unicode22040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22040
exit/b
:Unicode39035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39035
exit/b
:Unicode24464
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24464
exit/b
:Unicode35768
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35768
exit/b
:Unicode33988
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33988
exit/b
:Unicode37207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37207
exit/b
:Unicode21465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21465
exit/b
:Unicode26093
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26093
exit/b
:Unicode24207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24207
exit/b
:Unicode30044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30044
exit/b
:Unicode24676
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24676
exit/b
:Unicode32110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32110
exit/b
:Unicode23167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23167
exit/b
:Unicode32490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32490
exit/b
:Unicode32493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32493
exit/b
:Unicode36713
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36713
exit/b
:Unicode21927
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21927
exit/b
:Unicode23459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23459
exit/b
:Unicode24748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24748
exit/b
:Unicode26059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26059
exit/b
:Unicode29572
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29572
exit/b
:Unicode36873
set Unicode_Result=ѡ
exit/b
:Unicodeѡ
set Unicode_Result=36873
exit/b
:Unicode30307
set Unicode_Result=Ѣ
exit/b
:UnicodeѢ
set Unicode_Result=30307
exit/b
:Unicode30505
set Unicode_Result=ѣ
exit/b
:Unicodeѣ
set Unicode_Result=30505
exit/b
:Unicode32474
set Unicode_Result=Ѥ
exit/b
:UnicodeѤ
set Unicode_Result=32474
exit/b
:Unicode38772
set Unicode_Result=ѥ
exit/b
:Unicodeѥ
set Unicode_Result=38772
exit/b
:Unicode34203
set Unicode_Result=Ѧ
exit/b
:UnicodeѦ
set Unicode_Result=34203
exit/b
:Unicode23398
set Unicode_Result=ѧ
exit/b
:Unicodeѧ
set Unicode_Result=23398
exit/b
:Unicode31348
set Unicode_Result=Ѩ
exit/b
:UnicodeѨ
set Unicode_Result=31348
exit/b
:Unicode38634
set Unicode_Result=ѩ
exit/b
:Unicodeѩ
set Unicode_Result=38634
exit/b
:Unicode34880
set Unicode_Result=Ѫ
exit/b
:UnicodeѪ
set Unicode_Result=34880
exit/b
:Unicode21195
set Unicode_Result=ѫ
exit/b
:Unicodeѫ
set Unicode_Result=21195
exit/b
:Unicode29071
set Unicode_Result=Ѭ
exit/b
:UnicodeѬ
set Unicode_Result=29071
exit/b
:Unicode24490
set Unicode_Result=ѭ
exit/b
:Unicodeѭ
set Unicode_Result=24490
exit/b
:Unicode26092
set Unicode_Result=Ѯ
exit/b
:UnicodeѮ
set Unicode_Result=26092
exit/b
:Unicode35810
set Unicode_Result=ѯ
exit/b
:Unicodeѯ
set Unicode_Result=35810
exit/b
:Unicode23547
set Unicode_Result=Ѱ
exit/b
:UnicodeѰ
set Unicode_Result=23547
exit/b
:Unicode39535
set Unicode_Result=ѱ
exit/b
:Unicodeѱ
set Unicode_Result=39535
exit/b
:Unicode24033
set Unicode_Result=Ѳ
exit/b
:UnicodeѲ
set Unicode_Result=24033
exit/b
:Unicode27529
set Unicode_Result=ѳ
exit/b
:Unicodeѳ
set Unicode_Result=27529
exit/b
:Unicode27739
set Unicode_Result=Ѵ
exit/b
:UnicodeѴ
set Unicode_Result=27739
exit/b
:Unicode35757
set Unicode_Result=ѵ
exit/b
:Unicodeѵ
set Unicode_Result=35757
exit/b
:Unicode35759
set Unicode_Result=Ѷ
exit/b
:UnicodeѶ
set Unicode_Result=35759
exit/b
:Unicode36874
set Unicode_Result=ѷ
exit/b
:Unicodeѷ
set Unicode_Result=36874
exit/b
:Unicode36805
set Unicode_Result=Ѹ
exit/b
:UnicodeѸ
set Unicode_Result=36805
exit/b
:Unicode21387
set Unicode_Result=ѹ
exit/b
:Unicodeѹ
set Unicode_Result=21387
exit/b
:Unicode25276
set Unicode_Result=Ѻ
exit/b
:UnicodeѺ
set Unicode_Result=25276
exit/b
:Unicode40486
set Unicode_Result=ѻ
exit/b
:Unicodeѻ
set Unicode_Result=40486
exit/b
:Unicode40493
set Unicode_Result=Ѽ
exit/b
:UnicodeѼ
set Unicode_Result=40493
exit/b
:Unicode21568
set Unicode_Result=ѽ
exit/b
:Unicodeѽ
set Unicode_Result=21568
exit/b
:Unicode20011
set Unicode_Result=Ѿ
exit/b
:UnicodeѾ
set Unicode_Result=20011
exit/b
:Unicode33469
set Unicode_Result=ѿ
exit/b
:Unicodeѿ
set Unicode_Result=33469
exit/b
:Unicode29273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29273
exit/b
:Unicode34460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34460
exit/b
:Unicode23830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23830
exit/b
:Unicode34905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34905
exit/b
:Unicode28079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28079
exit/b
:Unicode38597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38597
exit/b
:Unicode21713
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21713
exit/b
:Unicode20122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20122
exit/b
:Unicode35766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35766
exit/b
:Unicode28937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28937
exit/b
:Unicode21693
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21693
exit/b
:Unicode38409
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38409
exit/b
:Unicode28895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28895
exit/b
:Unicode28153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28153
exit/b
:Unicode30416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30416
exit/b
:Unicode20005
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20005
exit/b
:Unicode30740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30740
exit/b
:Unicode34578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34578
exit/b
:Unicode23721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23721
exit/b
:Unicode24310
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24310
exit/b
:Unicode35328
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35328
exit/b
:Unicode39068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39068
exit/b
:Unicode38414
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38414
exit/b
:Unicode28814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28814
exit/b
:Unicode27839
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27839
exit/b
:Unicode22852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22852
exit/b
:Unicode25513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25513
exit/b
:Unicode30524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30524
exit/b
:Unicode34893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34893
exit/b
:Unicode28436
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28436
exit/b
:Unicode33395
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33395
exit/b
:Unicode22576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22576
exit/b
:Unicode29141
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29141
exit/b
:Unicode21388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21388
exit/b
:Unicode30746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30746
exit/b
:Unicode38593
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38593
exit/b
:Unicode21761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21761
exit/b
:Unicode24422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24422
exit/b
:Unicode28976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28976
exit/b
:Unicode23476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23476
exit/b
:Unicode35866
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35866
exit/b
:Unicode39564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39564
exit/b
:Unicode27523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27523
exit/b
:Unicode22830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22830
exit/b
:Unicode40495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40495
exit/b
:Unicode31207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31207
exit/b
:Unicode26472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26472
exit/b
:Unicode25196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25196
exit/b
:Unicode20335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20335
exit/b
:Unicode30113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30113
exit/b
:Unicode32650
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32650
exit/b
:Unicode27915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27915
exit/b
:Unicode38451
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38451
exit/b
:Unicode27687
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27687
exit/b
:Unicode20208
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20208
exit/b
:Unicode30162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30162
exit/b
:Unicode20859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20859
exit/b
:Unicode26679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26679
exit/b
:Unicode28478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28478
exit/b
:Unicode36992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36992
exit/b
:Unicode33136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33136
exit/b
:Unicode22934
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22934
exit/b
:Unicode29814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29814
exit/b
:Unicode25671
set Unicode_Result=ҡ
exit/b
:Unicodeҡ
set Unicode_Result=25671
exit/b
:Unicode23591
set Unicode_Result=Ң
exit/b
:UnicodeҢ
set Unicode_Result=23591
exit/b
:Unicode36965
set Unicode_Result=ң
exit/b
:Unicodeң
set Unicode_Result=36965
exit/b
:Unicode31377
set Unicode_Result=Ҥ
exit/b
:UnicodeҤ
set Unicode_Result=31377
exit/b
:Unicode35875
set Unicode_Result=ҥ
exit/b
:Unicodeҥ
set Unicode_Result=35875
exit/b
:Unicode23002
set Unicode_Result=Ҧ
exit/b
:UnicodeҦ
set Unicode_Result=23002
exit/b
:Unicode21676
set Unicode_Result=ҧ
exit/b
:Unicodeҧ
set Unicode_Result=21676
exit/b
:Unicode33280
set Unicode_Result=Ҩ
exit/b
:UnicodeҨ
set Unicode_Result=33280
exit/b
:Unicode33647
set Unicode_Result=ҩ
exit/b
:Unicodeҩ
set Unicode_Result=33647
exit/b
:Unicode35201
set Unicode_Result=Ҫ
exit/b
:UnicodeҪ
set Unicode_Result=35201
exit/b
:Unicode32768
set Unicode_Result=ҫ
exit/b
:Unicodeҫ
set Unicode_Result=32768
exit/b
:Unicode26928
set Unicode_Result=Ҭ
exit/b
:UnicodeҬ
set Unicode_Result=26928
exit/b
:Unicode22094
set Unicode_Result=ҭ
exit/b
:Unicodeҭ
set Unicode_Result=22094
exit/b
:Unicode32822
set Unicode_Result=Ү
exit/b
:UnicodeҮ
set Unicode_Result=32822
exit/b
:Unicode29239
set Unicode_Result=ү
exit/b
:Unicodeү
set Unicode_Result=29239
exit/b
:Unicode37326
set Unicode_Result=Ұ
exit/b
:UnicodeҰ
set Unicode_Result=37326
exit/b
:Unicode20918
set Unicode_Result=ұ
exit/b
:Unicodeұ
set Unicode_Result=20918
exit/b
:Unicode20063
set Unicode_Result=Ҳ
exit/b
:UnicodeҲ
set Unicode_Result=20063
exit/b
:Unicode39029
set Unicode_Result=ҳ
exit/b
:Unicodeҳ
set Unicode_Result=39029
exit/b
:Unicode25494
set Unicode_Result=Ҵ
exit/b
:UnicodeҴ
set Unicode_Result=25494
exit/b
:Unicode19994
set Unicode_Result=ҵ
exit/b
:Unicodeҵ
set Unicode_Result=19994
exit/b
:Unicode21494
set Unicode_Result=Ҷ
exit/b
:UnicodeҶ
set Unicode_Result=21494
exit/b
:Unicode26355
set Unicode_Result=ҷ
exit/b
:Unicodeҷ
set Unicode_Result=26355
exit/b
:Unicode33099
set Unicode_Result=Ҹ
exit/b
:UnicodeҸ
set Unicode_Result=33099
exit/b
:Unicode22812
set Unicode_Result=ҹ
exit/b
:Unicodeҹ
set Unicode_Result=22812
exit/b
:Unicode28082
set Unicode_Result=Һ
exit/b
:UnicodeҺ
set Unicode_Result=28082
exit/b
:Unicode19968
set Unicode_Result=һ
exit/b
:Unicodeһ
set Unicode_Result=19968
exit/b
:Unicode22777
set Unicode_Result=Ҽ
exit/b
:UnicodeҼ
set Unicode_Result=22777
exit/b
:Unicode21307
set Unicode_Result=ҽ
exit/b
:Unicodeҽ
set Unicode_Result=21307
exit/b
:Unicode25558
set Unicode_Result=Ҿ
exit/b
:UnicodeҾ
set Unicode_Result=25558
exit/b
:Unicode38129
set Unicode_Result=ҿ
exit/b
:Unicodeҿ
set Unicode_Result=38129
exit/b
:Unicode20381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20381
exit/b
:Unicode20234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20234
exit/b
:Unicode34915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34915
exit/b
:Unicode39056
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39056
exit/b
:Unicode22839
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22839
exit/b
:Unicode36951
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36951
exit/b
:Unicode31227
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31227
exit/b
:Unicode20202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20202
exit/b
:Unicode33008
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33008
exit/b
:Unicode30097
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30097
exit/b
:Unicode27778
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27778
exit/b
:Unicode23452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23452
exit/b
:Unicode23016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23016
exit/b
:Unicode24413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24413
exit/b
:Unicode26885
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26885
exit/b
:Unicode34433
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34433
exit/b
:Unicode20506
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20506
exit/b
:Unicode24050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24050
exit/b
:Unicode20057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20057
exit/b
:Unicode30691
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30691
exit/b
:Unicode20197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20197
exit/b
:Unicode33402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33402
exit/b
:Unicode25233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25233
exit/b
:Unicode26131
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26131
exit/b
:Unicode37009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37009
exit/b
:Unicode23673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23673
exit/b
:Unicode20159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20159
exit/b
:Unicode24441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24441
exit/b
:Unicode33222
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33222
exit/b
:Unicode36920
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36920
exit/b
:Unicode32900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32900
exit/b
:Unicode30123
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30123
exit/b
:Unicode20134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20134
exit/b
:Unicode35028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35028
exit/b
:Unicode24847
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24847
exit/b
:Unicode27589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27589
exit/b
:Unicode24518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24518
exit/b
:Unicode20041
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20041
exit/b
:Unicode30410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30410
exit/b
:Unicode28322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28322
exit/b
:Unicode35811
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35811
exit/b
:Unicode35758
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35758
exit/b
:Unicode35850
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35850
exit/b
:Unicode35793
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35793
exit/b
:Unicode24322
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24322
exit/b
:Unicode32764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32764
exit/b
:Unicode32716
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32716
exit/b
:Unicode32462
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32462
exit/b
:Unicode33589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33589
exit/b
:Unicode33643
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33643
exit/b
:Unicode22240
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22240
exit/b
:Unicode27575
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27575
exit/b
:Unicode38899
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38899
exit/b
:Unicode38452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38452
exit/b
:Unicode23035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23035
exit/b
:Unicode21535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21535
exit/b
:Unicode38134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38134
exit/b
:Unicode28139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28139
exit/b
:Unicode23493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23493
exit/b
:Unicode39278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39278
exit/b
:Unicode23609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23609
exit/b
:Unicode24341
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24341
exit/b
:Unicode38544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38544
exit/b
:Unicode21360
set Unicode_Result=ӡ
exit/b
:Unicodeӡ
set Unicode_Result=21360
exit/b
:Unicode33521
set Unicode_Result=Ӣ
exit/b
:UnicodeӢ
set Unicode_Result=33521
exit/b
:Unicode27185
set Unicode_Result=ӣ
exit/b
:Unicodeӣ
set Unicode_Result=27185
exit/b
:Unicode23156
set Unicode_Result=Ӥ
exit/b
:UnicodeӤ
set Unicode_Result=23156
exit/b
:Unicode40560
set Unicode_Result=ӥ
exit/b
:Unicodeӥ
set Unicode_Result=40560
exit/b
:Unicode24212
set Unicode_Result=Ӧ
exit/b
:UnicodeӦ
set Unicode_Result=24212
exit/b
:Unicode32552
set Unicode_Result=ӧ
exit/b
:Unicodeӧ
set Unicode_Result=32552
exit/b
:Unicode33721
set Unicode_Result=Ө
exit/b
:UnicodeӨ
set Unicode_Result=33721
exit/b
:Unicode33828
set Unicode_Result=ө
exit/b
:Unicodeө
set Unicode_Result=33828
exit/b
:Unicode33829
set Unicode_Result=Ӫ
exit/b
:UnicodeӪ
set Unicode_Result=33829
exit/b
:Unicode33639
set Unicode_Result=ӫ
exit/b
:Unicodeӫ
set Unicode_Result=33639
exit/b
:Unicode34631
set Unicode_Result=Ӭ
exit/b
:UnicodeӬ
set Unicode_Result=34631
exit/b
:Unicode36814
set Unicode_Result=ӭ
exit/b
:Unicodeӭ
set Unicode_Result=36814
exit/b
:Unicode36194
set Unicode_Result=Ӯ
exit/b
:UnicodeӮ
set Unicode_Result=36194
exit/b
:Unicode30408
set Unicode_Result=ӯ
exit/b
:Unicodeӯ
set Unicode_Result=30408
exit/b
:Unicode24433
set Unicode_Result=Ӱ
exit/b
:UnicodeӰ
set Unicode_Result=24433
exit/b
:Unicode39062
set Unicode_Result=ӱ
exit/b
:Unicodeӱ
set Unicode_Result=39062
exit/b
:Unicode30828
set Unicode_Result=Ӳ
exit/b
:UnicodeӲ
set Unicode_Result=30828
exit/b
:Unicode26144
set Unicode_Result=ӳ
exit/b
:Unicodeӳ
set Unicode_Result=26144
exit/b
:Unicode21727
set Unicode_Result=Ӵ
exit/b
:UnicodeӴ
set Unicode_Result=21727
exit/b
:Unicode25317
set Unicode_Result=ӵ
exit/b
:Unicodeӵ
set Unicode_Result=25317
exit/b
:Unicode20323
set Unicode_Result=Ӷ
exit/b
:UnicodeӶ
set Unicode_Result=20323
exit/b
:Unicode33219
set Unicode_Result=ӷ
exit/b
:Unicodeӷ
set Unicode_Result=33219
exit/b
:Unicode30152
set Unicode_Result=Ӹ
exit/b
:UnicodeӸ
set Unicode_Result=30152
exit/b
:Unicode24248
set Unicode_Result=ӹ
exit/b
:Unicodeӹ
set Unicode_Result=24248
exit/b
:Unicode38605
set Unicode_Result=Ӻ
exit/b
:UnicodeӺ
set Unicode_Result=38605
exit/b
:Unicode36362
set Unicode_Result=ӻ
exit/b
:Unicodeӻ
set Unicode_Result=36362
exit/b
:Unicode34553
set Unicode_Result=Ӽ
exit/b
:UnicodeӼ
set Unicode_Result=34553
exit/b
:Unicode21647
set Unicode_Result=ӽ
exit/b
:Unicodeӽ
set Unicode_Result=21647
exit/b
:Unicode27891
set Unicode_Result=Ӿ
exit/b
:UnicodeӾ
set Unicode_Result=27891
exit/b
:Unicode28044
set Unicode_Result=ӿ
exit/b
:Unicodeӿ
set Unicode_Result=28044
exit/b
:Unicode27704
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27704
exit/b
:Unicode24703
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24703
exit/b
:Unicode21191
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21191
exit/b
:Unicode29992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29992
exit/b
:Unicode24189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24189
exit/b
:Unicode20248
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20248
exit/b
:Unicode24736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24736
exit/b
:Unicode24551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24551
exit/b
:Unicode23588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23588
exit/b
:Unicode30001
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30001
exit/b
:Unicode37038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37038
exit/b
:Unicode38080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38080
exit/b
:Unicode29369
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29369
exit/b
:Unicode27833
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27833
exit/b
:Unicode28216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28216
exit/b
:Unicode37193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37193
exit/b
:Unicode26377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26377
exit/b
:Unicode21451
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21451
exit/b
:Unicode21491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21491
exit/b
:Unicode20305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20305
exit/b
:Unicode37321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37321
exit/b
:Unicode35825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35825
exit/b
:Unicode21448
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21448
exit/b
:Unicode24188
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24188
exit/b
:Unicode36802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36802
exit/b
:Unicode28132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28132
exit/b
:Unicode20110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20110
exit/b
:Unicode30402
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30402
exit/b
:Unicode27014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27014
exit/b
:Unicode34398
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34398
exit/b
:Unicode24858
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24858
exit/b
:Unicode33286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33286
exit/b
:Unicode20313
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20313
exit/b
:Unicode20446
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20446
exit/b
:Unicode36926
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36926
exit/b
:Unicode40060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40060
exit/b
:Unicode24841
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24841
exit/b
:Unicode28189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28189
exit/b
:Unicode28180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28180
exit/b
:Unicode38533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38533
exit/b
:Unicode20104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20104
exit/b
:Unicode23089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23089
exit/b
:Unicode38632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38632
exit/b
:Unicode19982
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19982
exit/b
:Unicode23679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23679
exit/b
:Unicode31161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31161
exit/b
:Unicode23431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23431
exit/b
:Unicode35821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35821
exit/b
:Unicode32701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32701
exit/b
:Unicode29577
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29577
exit/b
:Unicode22495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22495
exit/b
:Unicode33419
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33419
exit/b
:Unicode37057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37057
exit/b
:Unicode21505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21505
exit/b
:Unicode36935
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36935
exit/b
:Unicode21947
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21947
exit/b
:Unicode23786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23786
exit/b
:Unicode24481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24481
exit/b
:Unicode24840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24840
exit/b
:Unicode27442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27442
exit/b
:Unicode29425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29425
exit/b
:Unicode32946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32946
exit/b
:Unicode35465
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35465
exit/b
:Unicode28020
set Unicode_Result=ԡ
exit/b
:Unicodeԡ
set Unicode_Result=28020
exit/b
:Unicode23507
set Unicode_Result=Ԣ
exit/b
:UnicodeԢ
set Unicode_Result=23507
exit/b
:Unicode35029
set Unicode_Result=ԣ
exit/b
:Unicodeԣ
set Unicode_Result=35029
exit/b
:Unicode39044
set Unicode_Result=Ԥ
exit/b
:UnicodeԤ
set Unicode_Result=39044
exit/b
:Unicode35947
set Unicode_Result=ԥ
exit/b
:Unicodeԥ
set Unicode_Result=35947
exit/b
:Unicode39533
set Unicode_Result=Ԧ
exit/b
:UnicodeԦ
set Unicode_Result=39533
exit/b
:Unicode40499
set Unicode_Result=ԧ
exit/b
:Unicodeԧ
set Unicode_Result=40499
exit/b
:Unicode28170
set Unicode_Result=Ԩ
exit/b
:UnicodeԨ
set Unicode_Result=28170
exit/b
:Unicode20900
set Unicode_Result=ԩ
exit/b
:Unicodeԩ
set Unicode_Result=20900
exit/b
:Unicode20803
set Unicode_Result=Ԫ
exit/b
:UnicodeԪ
set Unicode_Result=20803
exit/b
:Unicode22435
set Unicode_Result=ԫ
exit/b
:Unicodeԫ
set Unicode_Result=22435
exit/b
:Unicode34945
set Unicode_Result=Ԭ
exit/b
:UnicodeԬ
set Unicode_Result=34945
exit/b
:Unicode21407
set Unicode_Result=ԭ
exit/b
:Unicodeԭ
set Unicode_Result=21407
exit/b
:Unicode25588
set Unicode_Result=Ԯ
exit/b
:UnicodeԮ
set Unicode_Result=25588
exit/b
:Unicode36757
set Unicode_Result=ԯ
exit/b
:Unicodeԯ
set Unicode_Result=36757
exit/b
:Unicode22253
set Unicode_Result=԰
exit/b
:Unicode԰
set Unicode_Result=22253
exit/b
:Unicode21592
set Unicode_Result=Ա
exit/b
:UnicodeԱ
set Unicode_Result=21592
exit/b
:Unicode22278
set Unicode_Result=Բ
exit/b
:UnicodeԲ
set Unicode_Result=22278
exit/b
:Unicode29503
set Unicode_Result=Գ
exit/b
:UnicodeԳ
set Unicode_Result=29503
exit/b
:Unicode28304
set Unicode_Result=Դ
exit/b
:UnicodeԴ
set Unicode_Result=28304
exit/b
:Unicode32536
set Unicode_Result=Ե
exit/b
:UnicodeԵ
set Unicode_Result=32536
exit/b
:Unicode36828
set Unicode_Result=Զ
exit/b
:UnicodeԶ
set Unicode_Result=36828
exit/b
:Unicode33489
set Unicode_Result=Է
exit/b
:UnicodeԷ
set Unicode_Result=33489
exit/b
:Unicode24895
set Unicode_Result=Ը
exit/b
:UnicodeԸ
set Unicode_Result=24895
exit/b
:Unicode24616
set Unicode_Result=Թ
exit/b
:UnicodeԹ
set Unicode_Result=24616
exit/b
:Unicode38498
set Unicode_Result=Ժ
exit/b
:UnicodeԺ
set Unicode_Result=38498
exit/b
:Unicode26352
set Unicode_Result=Ի
exit/b
:UnicodeԻ
set Unicode_Result=26352
exit/b
:Unicode32422
set Unicode_Result=Լ
exit/b
:UnicodeԼ
set Unicode_Result=32422
exit/b
:Unicode36234
set Unicode_Result=Խ
exit/b
:UnicodeԽ
set Unicode_Result=36234
exit/b
:Unicode36291
set Unicode_Result=Ծ
exit/b
:UnicodeԾ
set Unicode_Result=36291
exit/b
:Unicode38053
set Unicode_Result=Կ
exit/b
:UnicodeԿ
set Unicode_Result=38053
exit/b
:Unicode23731
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23731
exit/b
:Unicode31908
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31908
exit/b
:Unicode26376
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26376
exit/b
:Unicode24742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24742
exit/b
:Unicode38405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38405
exit/b
:Unicode32792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32792
exit/b
:Unicode20113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20113
exit/b
:Unicode37095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37095
exit/b
:Unicode21248
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21248
exit/b
:Unicode38504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38504
exit/b
:Unicode20801
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20801
exit/b
:Unicode36816
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36816
exit/b
:Unicode34164
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34164
exit/b
:Unicode37213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37213
exit/b
:Unicode26197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26197
exit/b
:Unicode38901
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38901
exit/b
:Unicode23381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23381
exit/b
:Unicode21277
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21277
exit/b
:Unicode30776
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30776
exit/b
:Unicode26434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26434
exit/b
:Unicode26685
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26685
exit/b
:Unicode21705
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21705
exit/b
:Unicode28798
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28798
exit/b
:Unicode23472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23472
exit/b
:Unicode36733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36733
exit/b
:Unicode20877
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20877
exit/b
:Unicode22312
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22312
exit/b
:Unicode21681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21681
exit/b
:Unicode25874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25874
exit/b
:Unicode26242
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26242
exit/b
:Unicode36190
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36190
exit/b
:Unicode36163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36163
exit/b
:Unicode33039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33039
exit/b
:Unicode33900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33900
exit/b
:Unicode36973
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36973
exit/b
:Unicode31967
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31967
exit/b
:Unicode20991
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20991
exit/b
:Unicode34299
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34299
exit/b
:Unicode26531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26531
exit/b
:Unicode26089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26089
exit/b
:Unicode28577
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28577
exit/b
:Unicode34468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34468
exit/b
:Unicode36481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36481
exit/b
:Unicode22122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22122
exit/b
:Unicode36896
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36896
exit/b
:Unicode30338
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30338
exit/b
:Unicode28790
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28790
exit/b
:Unicode29157
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29157
exit/b
:Unicode36131
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36131
exit/b
:Unicode25321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25321
exit/b
:Unicode21017
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21017
exit/b
:Unicode27901
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27901
exit/b
:Unicode36156
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36156
exit/b
:Unicode24590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24590
exit/b
:Unicode22686
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22686
exit/b
:Unicode24974
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24974
exit/b
:Unicode26366
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26366
exit/b
:Unicode36192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36192
exit/b
:Unicode25166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25166
exit/b
:Unicode21939
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21939
exit/b
:Unicode28195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28195
exit/b
:Unicode26413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26413
exit/b
:Unicode36711
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36711
exit/b
:Unicode38113
set Unicode_Result=ա
exit/b
:Unicodeա
set Unicode_Result=38113
exit/b
:Unicode38392
set Unicode_Result=բ
exit/b
:Unicodeբ
set Unicode_Result=38392
exit/b
:Unicode30504
set Unicode_Result=գ
exit/b
:Unicodeգ
set Unicode_Result=30504
exit/b
:Unicode26629
set Unicode_Result=դ
exit/b
:Unicodeդ
set Unicode_Result=26629
exit/b
:Unicode27048
set Unicode_Result=ե
exit/b
:Unicodeե
set Unicode_Result=27048
exit/b
:Unicode21643
set Unicode_Result=զ
exit/b
:Unicodeզ
set Unicode_Result=21643
exit/b
:Unicode20045
set Unicode_Result=է
exit/b
:Unicodeէ
set Unicode_Result=20045
exit/b
:Unicode28856
set Unicode_Result=ը
exit/b
:Unicodeը
set Unicode_Result=28856
exit/b
:Unicode35784
set Unicode_Result=թ
exit/b
:Unicodeթ
set Unicode_Result=35784
exit/b
:Unicode25688
set Unicode_Result=ժ
exit/b
:Unicodeժ
set Unicode_Result=25688
exit/b
:Unicode25995
set Unicode_Result=ի
exit/b
:Unicodeի
set Unicode_Result=25995
exit/b
:Unicode23429
set Unicode_Result=լ
exit/b
:Unicodeլ
set Unicode_Result=23429
exit/b
:Unicode31364
set Unicode_Result=խ
exit/b
:Unicodeխ
set Unicode_Result=31364
exit/b
:Unicode20538
set Unicode_Result=ծ
exit/b
:Unicodeծ
set Unicode_Result=20538
exit/b
:Unicode23528
set Unicode_Result=կ
exit/b
:Unicodeկ
set Unicode_Result=23528
exit/b
:Unicode30651
set Unicode_Result=հ
exit/b
:Unicodeհ
set Unicode_Result=30651
exit/b
:Unicode27617
set Unicode_Result=ձ
exit/b
:Unicodeձ
set Unicode_Result=27617
exit/b
:Unicode35449
set Unicode_Result=ղ
exit/b
:Unicodeղ
set Unicode_Result=35449
exit/b
:Unicode31896
set Unicode_Result=ճ
exit/b
:Unicodeճ
set Unicode_Result=31896
exit/b
:Unicode27838
set Unicode_Result=մ
exit/b
:Unicodeմ
set Unicode_Result=27838
exit/b
:Unicode30415
set Unicode_Result=յ
exit/b
:Unicodeյ
set Unicode_Result=30415
exit/b
:Unicode26025
set Unicode_Result=ն
exit/b
:Unicodeն
set Unicode_Result=26025
exit/b
:Unicode36759
set Unicode_Result=շ
exit/b
:Unicodeշ
set Unicode_Result=36759
exit/b
:Unicode23853
set Unicode_Result=ո
exit/b
:Unicodeո
set Unicode_Result=23853
exit/b
:Unicode23637
set Unicode_Result=չ
exit/b
:Unicodeչ
set Unicode_Result=23637
exit/b
:Unicode34360
set Unicode_Result=պ
exit/b
:Unicodeպ
set Unicode_Result=34360
exit/b
:Unicode26632
set Unicode_Result=ջ
exit/b
:Unicodeջ
set Unicode_Result=26632
exit/b
:Unicode21344
set Unicode_Result=ռ
exit/b
:Unicodeռ
set Unicode_Result=21344
exit/b
:Unicode25112
set Unicode_Result=ս
exit/b
:Unicodeս
set Unicode_Result=25112
exit/b
:Unicode31449
set Unicode_Result=վ
exit/b
:Unicodeվ
set Unicode_Result=31449
exit/b
:Unicode28251
set Unicode_Result=տ
exit/b
:Unicodeտ
set Unicode_Result=28251
exit/b
:Unicode32509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32509
exit/b
:Unicode27167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27167
exit/b
:Unicode31456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31456
exit/b
:Unicode24432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24432
exit/b
:Unicode28467
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28467
exit/b
:Unicode24352
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24352
exit/b
:Unicode25484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25484
exit/b
:Unicode28072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28072
exit/b
:Unicode26454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26454
exit/b
:Unicode19976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=19976
exit/b
:Unicode24080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24080
exit/b
:Unicode36134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36134
exit/b
:Unicode20183
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20183
exit/b
:Unicode32960
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32960
exit/b
:Unicode30260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30260
exit/b
:Unicode38556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38556
exit/b
:Unicode25307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25307
exit/b
:Unicode26157
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26157
exit/b
:Unicode25214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25214
exit/b
:Unicode27836
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27836
exit/b
:Unicode36213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36213
exit/b
:Unicode29031
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29031
exit/b
:Unicode32617
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32617
exit/b
:Unicode20806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20806
exit/b
:Unicode32903
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32903
exit/b
:Unicode21484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21484
exit/b
:Unicode36974
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36974
exit/b
:Unicode25240
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25240
exit/b
:Unicode21746
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21746
exit/b
:Unicode34544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34544
exit/b
:Unicode36761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36761
exit/b
:Unicode32773
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32773
exit/b
:Unicode38167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38167
exit/b
:Unicode34071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34071
exit/b
:Unicode36825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36825
exit/b
:Unicode27993
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27993
exit/b
:Unicode29645
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29645
exit/b
:Unicode26015
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26015
exit/b
:Unicode30495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30495
exit/b
:Unicode29956
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29956
exit/b
:Unicode30759
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30759
exit/b
:Unicode33275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33275
exit/b
:Unicode36126
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36126
exit/b
:Unicode38024
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38024
exit/b
:Unicode20390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20390
exit/b
:Unicode26517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26517
exit/b
:Unicode30137
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30137
exit/b
:Unicode35786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35786
exit/b
:Unicode38663
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38663
exit/b
:Unicode25391
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25391
exit/b
:Unicode38215
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38215
exit/b
:Unicode38453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38453
exit/b
:Unicode33976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33976
exit/b
:Unicode25379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25379
exit/b
:Unicode30529
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30529
exit/b
:Unicode24449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24449
exit/b
:Unicode29424
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29424
exit/b
:Unicode20105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20105
exit/b
:Unicode24596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24596
exit/b
:Unicode25972
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25972
exit/b
:Unicode25327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25327
exit/b
:Unicode27491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27491
exit/b
:Unicode25919
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25919
exit/b
:Unicode24103
set Unicode_Result=֡
exit/b
:Unicode֡
set Unicode_Result=24103
exit/b
:Unicode30151
set Unicode_Result=֢
exit/b
:Unicode֢
set Unicode_Result=30151
exit/b
:Unicode37073
set Unicode_Result=֣
exit/b
:Unicode֣
set Unicode_Result=37073
exit/b
:Unicode35777
set Unicode_Result=֤
exit/b
:Unicode֤
set Unicode_Result=35777
exit/b
:Unicode33437
set Unicode_Result=֥
exit/b
:Unicode֥
set Unicode_Result=33437
exit/b
:Unicode26525
set Unicode_Result=֦
exit/b
:Unicode֦
set Unicode_Result=26525
exit/b
:Unicode25903
set Unicode_Result=֧
exit/b
:Unicode֧
set Unicode_Result=25903
exit/b
:Unicode21553
set Unicode_Result=֨
exit/b
:Unicode֨
set Unicode_Result=21553
exit/b
:Unicode34584
set Unicode_Result=֩
exit/b
:Unicode֩
set Unicode_Result=34584
exit/b
:Unicode30693
set Unicode_Result=֪
exit/b
:Unicode֪
set Unicode_Result=30693
exit/b
:Unicode32930
set Unicode_Result=֫
exit/b
:Unicode֫
set Unicode_Result=32930
exit/b
:Unicode33026
set Unicode_Result=֬
exit/b
:Unicode֬
set Unicode_Result=33026
exit/b
:Unicode27713
set Unicode_Result=֭
exit/b
:Unicode֭
set Unicode_Result=27713
exit/b
:Unicode20043
set Unicode_Result=֮
exit/b
:Unicode֮
set Unicode_Result=20043
exit/b
:Unicode32455
set Unicode_Result=֯
exit/b
:Unicode֯
set Unicode_Result=32455
exit/b
:Unicode32844
set Unicode_Result=ְ
exit/b
:Unicodeְ
set Unicode_Result=32844
exit/b
:Unicode30452
set Unicode_Result=ֱ
exit/b
:Unicodeֱ
set Unicode_Result=30452
exit/b
:Unicode26893
set Unicode_Result=ֲ
exit/b
:Unicodeֲ
set Unicode_Result=26893
exit/b
:Unicode27542
set Unicode_Result=ֳ
exit/b
:Unicodeֳ
set Unicode_Result=27542
exit/b
:Unicode25191
set Unicode_Result=ִ
exit/b
:Unicodeִ
set Unicode_Result=25191
exit/b
:Unicode20540
set Unicode_Result=ֵ
exit/b
:Unicodeֵ
set Unicode_Result=20540
exit/b
:Unicode20356
set Unicode_Result=ֶ
exit/b
:Unicodeֶ
set Unicode_Result=20356
exit/b
:Unicode22336
set Unicode_Result=ַ
exit/b
:Unicodeַ
set Unicode_Result=22336
exit/b
:Unicode25351
set Unicode_Result=ָ
exit/b
:Unicodeָ
set Unicode_Result=25351
exit/b
:Unicode27490
set Unicode_Result=ֹ
exit/b
:Unicodeֹ
set Unicode_Result=27490
exit/b
:Unicode36286
set Unicode_Result=ֺ
exit/b
:Unicodeֺ
set Unicode_Result=36286
exit/b
:Unicode21482
set Unicode_Result=ֻ
exit/b
:Unicodeֻ
set Unicode_Result=21482
exit/b
:Unicode26088
set Unicode_Result=ּ
exit/b
:Unicodeּ
set Unicode_Result=26088
exit/b
:Unicode32440
set Unicode_Result=ֽ
exit/b
:Unicodeֽ
set Unicode_Result=32440
exit/b
:Unicode24535
set Unicode_Result=־
exit/b
:Unicode־
set Unicode_Result=24535
exit/b
:Unicode25370
set Unicode_Result=ֿ
exit/b
:Unicodeֿ
set Unicode_Result=25370
exit/b
:Unicode25527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25527
exit/b
:Unicode33267
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33267
exit/b
:Unicode33268
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33268
exit/b
:Unicode32622
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32622
exit/b
:Unicode24092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24092
exit/b
:Unicode23769
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23769
exit/b
:Unicode21046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21046
exit/b
:Unicode26234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26234
exit/b
:Unicode31209
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31209
exit/b
:Unicode31258
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31258
exit/b
:Unicode36136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36136
exit/b
:Unicode28825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28825
exit/b
:Unicode30164
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30164
exit/b
:Unicode28382
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28382
exit/b
:Unicode27835
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27835
exit/b
:Unicode31378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31378
exit/b
:Unicode20013
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20013
exit/b
:Unicode30405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30405
exit/b
:Unicode24544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24544
exit/b
:Unicode38047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38047
exit/b
:Unicode34935
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34935
exit/b
:Unicode32456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32456
exit/b
:Unicode31181
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31181
exit/b
:Unicode32959
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32959
exit/b
:Unicode37325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37325
exit/b
:Unicode20210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20210
exit/b
:Unicode20247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20247
exit/b
:Unicode33311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33311
exit/b
:Unicode21608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21608
exit/b
:Unicode24030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24030
exit/b
:Unicode27954
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27954
exit/b
:Unicode35788
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35788
exit/b
:Unicode31909
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31909
exit/b
:Unicode36724
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36724
exit/b
:Unicode32920
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32920
exit/b
:Unicode24090
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24090
exit/b
:Unicode21650
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21650
exit/b
:Unicode30385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30385
exit/b
:Unicode23449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23449
exit/b
:Unicode26172
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26172
exit/b
:Unicode39588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39588
exit/b
:Unicode29664
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29664
exit/b
:Unicode26666
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26666
exit/b
:Unicode34523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34523
exit/b
:Unicode26417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26417
exit/b
:Unicode29482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29482
exit/b
:Unicode35832
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35832
exit/b
:Unicode35803
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35803
exit/b
:Unicode36880
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36880
exit/b
:Unicode31481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31481
exit/b
:Unicode28891
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28891
exit/b
:Unicode29038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29038
exit/b
:Unicode25284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25284
exit/b
:Unicode30633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30633
exit/b
:Unicode22065
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22065
exit/b
:Unicode20027
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20027
exit/b
:Unicode33879
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33879
exit/b
:Unicode26609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26609
exit/b
:Unicode21161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21161
exit/b
:Unicode34496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34496
exit/b
:Unicode36142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36142
exit/b
:Unicode38136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38136
exit/b
:Unicode31569
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31569
exit/b
:Unicode20303
set Unicode_Result=ס
exit/b
:Unicodeס
set Unicode_Result=20303
exit/b
:Unicode27880
set Unicode_Result=ע
exit/b
:Unicodeע
set Unicode_Result=27880
exit/b
:Unicode31069
set Unicode_Result=ף
exit/b
:Unicodeף
set Unicode_Result=31069
exit/b
:Unicode39547
set Unicode_Result=פ
exit/b
:Unicodeפ
set Unicode_Result=39547
exit/b
:Unicode25235
set Unicode_Result=ץ
exit/b
:Unicodeץ
set Unicode_Result=25235
exit/b
:Unicode29226
set Unicode_Result=צ
exit/b
:Unicodeצ
set Unicode_Result=29226
exit/b
:Unicode25341
set Unicode_Result=ק
exit/b
:Unicodeק
set Unicode_Result=25341
exit/b
:Unicode19987
set Unicode_Result=ר
exit/b
:Unicodeר
set Unicode_Result=19987
exit/b
:Unicode30742
set Unicode_Result=ש
exit/b
:Unicodeש
set Unicode_Result=30742
exit/b
:Unicode36716
set Unicode_Result=ת
exit/b
:Unicodeת
set Unicode_Result=36716
exit/b
:Unicode25776
set Unicode_Result=׫
exit/b
:Unicode׫
set Unicode_Result=25776
exit/b
:Unicode36186
set Unicode_Result=׬
exit/b
:Unicode׬
set Unicode_Result=36186
exit/b
:Unicode31686
set Unicode_Result=׭
exit/b
:Unicode׭
set Unicode_Result=31686
exit/b
:Unicode26729
set Unicode_Result=׮
exit/b
:Unicode׮
set Unicode_Result=26729
exit/b
:Unicode24196
set Unicode_Result=ׯ
exit/b
:Unicodeׯ
set Unicode_Result=24196
exit/b
:Unicode35013
set Unicode_Result=װ
exit/b
:Unicodeװ
set Unicode_Result=35013
exit/b
:Unicode22918
set Unicode_Result=ױ
exit/b
:Unicodeױ
set Unicode_Result=22918
exit/b
:Unicode25758
set Unicode_Result=ײ
exit/b
:Unicodeײ
set Unicode_Result=25758
exit/b
:Unicode22766
set Unicode_Result=׳
exit/b
:Unicode׳
set Unicode_Result=22766
exit/b
:Unicode29366
set Unicode_Result=״
exit/b
:Unicode״
set Unicode_Result=29366
exit/b
:Unicode26894
set Unicode_Result=׵
exit/b
:Unicode׵
set Unicode_Result=26894
exit/b
:Unicode38181
set Unicode_Result=׶
exit/b
:Unicode׶
set Unicode_Result=38181
exit/b
:Unicode36861
set Unicode_Result=׷
exit/b
:Unicode׷
set Unicode_Result=36861
exit/b
:Unicode36184
set Unicode_Result=׸
exit/b
:Unicode׸
set Unicode_Result=36184
exit/b
:Unicode22368
set Unicode_Result=׹
exit/b
:Unicode׹
set Unicode_Result=22368
exit/b
:Unicode32512
set Unicode_Result=׺
exit/b
:Unicode׺
set Unicode_Result=32512
exit/b
:Unicode35846
set Unicode_Result=׻
exit/b
:Unicode׻
set Unicode_Result=35846
exit/b
:Unicode20934
set Unicode_Result=׼
exit/b
:Unicode׼
set Unicode_Result=20934
exit/b
:Unicode25417
set Unicode_Result=׽
exit/b
:Unicode׽
set Unicode_Result=25417
exit/b
:Unicode25305
set Unicode_Result=׾
exit/b
:Unicode׾
set Unicode_Result=25305
exit/b
:Unicode21331
set Unicode_Result=׿
exit/b
:Unicode׿
set Unicode_Result=21331
exit/b
:Unicode26700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26700
exit/b
:Unicode29730
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29730
exit/b
:Unicode33537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33537
exit/b
:Unicode37196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37196
exit/b
:Unicode21828
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21828
exit/b
:Unicode30528
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30528
exit/b
:Unicode28796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28796
exit/b
:Unicode27978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27978
exit/b
:Unicode20857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20857
exit/b
:Unicode21672
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21672
exit/b
:Unicode36164
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36164
exit/b
:Unicode23039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23039
exit/b
:Unicode28363
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28363
exit/b
:Unicode28100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28100
exit/b
:Unicode23388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23388
exit/b
:Unicode32043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32043
exit/b
:Unicode20180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20180
exit/b
:Unicode31869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31869
exit/b
:Unicode28371
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28371
exit/b
:Unicode23376
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23376
exit/b
:Unicode33258
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33258
exit/b
:Unicode28173
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28173
exit/b
:Unicode23383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23383
exit/b
:Unicode39683
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39683
exit/b
:Unicode26837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26837
exit/b
:Unicode36394
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36394
exit/b
:Unicode23447
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23447
exit/b
:Unicode32508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32508
exit/b
:Unicode24635
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24635
exit/b
:Unicode32437
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32437
exit/b
:Unicode37049
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37049
exit/b
:Unicode36208
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36208
exit/b
:Unicode22863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22863
exit/b
:Unicode25549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25549
exit/b
:Unicode31199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31199
exit/b
:Unicode36275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36275
exit/b
:Unicode21330
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21330
exit/b
:Unicode26063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26063
exit/b
:Unicode31062
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31062
exit/b
:Unicode35781
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35781
exit/b
:Unicode38459
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38459
exit/b
:Unicode32452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32452
exit/b
:Unicode38075
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38075
exit/b
:Unicode32386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32386
exit/b
:Unicode22068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22068
exit/b
:Unicode37257
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37257
exit/b
:Unicode26368
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26368
exit/b
:Unicode32618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32618
exit/b
:Unicode23562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23562
exit/b
:Unicode20120
set Unicode_Result=ب
exit/b
:Unicodeب
set Unicode_Result=20120
exit/b
:Unicode19998
set Unicode_Result=ة
exit/b
:Unicodeة
set Unicode_Result=19998
exit/b
:Unicode39730
set Unicode_Result=ت
exit/b
:Unicodeت
set Unicode_Result=39730
exit/b
:Unicode23404
set Unicode_Result=ث
exit/b
:Unicodeث
set Unicode_Result=23404
exit/b
:Unicode22121
set Unicode_Result=ج
exit/b
:Unicodeج
set Unicode_Result=22121
exit/b
:Unicode20008
set Unicode_Result=ح
exit/b
:Unicodeح
set Unicode_Result=20008
exit/b
:Unicode31162
set Unicode_Result=خ
exit/b
:Unicodeخ
set Unicode_Result=31162
exit/b
:Unicode20031
set Unicode_Result=د
exit/b
:Unicodeد
set Unicode_Result=20031
exit/b
:Unicode21269
set Unicode_Result=ذ
exit/b
:Unicodeذ
set Unicode_Result=21269
exit/b
:Unicode20039
set Unicode_Result=ر
exit/b
:Unicodeر
set Unicode_Result=20039
exit/b
:Unicode22829
set Unicode_Result=ز
exit/b
:Unicodeز
set Unicode_Result=22829
exit/b
:Unicode29243
set Unicode_Result=س
exit/b
:Unicodeس
set Unicode_Result=29243
exit/b
:Unicode21358
set Unicode_Result=ش
exit/b
:Unicodeش
set Unicode_Result=21358
exit/b
:Unicode27664
set Unicode_Result=ص
exit/b
:Unicodeص
set Unicode_Result=27664
exit/b
:Unicode22239
set Unicode_Result=ض
exit/b
:Unicodeض
set Unicode_Result=22239
exit/b
:Unicode32996
set Unicode_Result=ط
exit/b
:Unicodeط
set Unicode_Result=32996
exit/b
:Unicode39319
set Unicode_Result=ظ
exit/b
:Unicodeظ
set Unicode_Result=39319
exit/b
:Unicode27603
set Unicode_Result=ع
exit/b
:Unicodeع
set Unicode_Result=27603
exit/b
:Unicode30590
set Unicode_Result=غ
exit/b
:Unicodeغ
set Unicode_Result=30590
exit/b
:Unicode40727
set Unicode_Result=ػ
exit/b
:Unicodeػ
set Unicode_Result=40727
exit/b
:Unicode20022
set Unicode_Result=ؼ
exit/b
:Unicodeؼ
set Unicode_Result=20022
exit/b
:Unicode20127
set Unicode_Result=ؽ
exit/b
:Unicodeؽ
set Unicode_Result=20127
exit/b
:Unicode40720
set Unicode_Result=ؾ
exit/b
:Unicodeؾ
set Unicode_Result=40720
exit/b
:Unicode20060
set Unicode_Result=ؿ
exit/b
:Unicodeؿ
set Unicode_Result=20060
exit/b
:Unicode20073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20073
exit/b
:Unicode20115
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20115
exit/b
:Unicode33416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33416
exit/b
:Unicode23387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23387
exit/b
:Unicode21868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21868
exit/b
:Unicode22031
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22031
exit/b
:Unicode20164
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20164
exit/b
:Unicode21389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21389
exit/b
:Unicode21405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21405
exit/b
:Unicode21411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21411
exit/b
:Unicode21413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21413
exit/b
:Unicode21422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21422
exit/b
:Unicode38757
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38757
exit/b
:Unicode36189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36189
exit/b
:Unicode21274
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21274
exit/b
:Unicode21493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21493
exit/b
:Unicode21286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21286
exit/b
:Unicode21294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21294
exit/b
:Unicode21310
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21310
exit/b
:Unicode36188
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36188
exit/b
:Unicode21350
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21350
exit/b
:Unicode21347
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21347
exit/b
:Unicode20994
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20994
exit/b
:Unicode21000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21000
exit/b
:Unicode21006
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21006
exit/b
:Unicode21037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21037
exit/b
:Unicode21043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21043
exit/b
:Unicode21055
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21055
exit/b
:Unicode21056
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21056
exit/b
:Unicode21068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21068
exit/b
:Unicode21086
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21086
exit/b
:Unicode21089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21089
exit/b
:Unicode21084
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21084
exit/b
:Unicode33967
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33967
exit/b
:Unicode21117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21117
exit/b
:Unicode21122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21122
exit/b
:Unicode21121
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21121
exit/b
:Unicode21136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21136
exit/b
:Unicode21139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21139
exit/b
:Unicode20866
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20866
exit/b
:Unicode32596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32596
exit/b
:Unicode20155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20155
exit/b
:Unicode20163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20163
exit/b
:Unicode20169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20169
exit/b
:Unicode20162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20162
exit/b
:Unicode20200
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20200
exit/b
:Unicode20193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20193
exit/b
:Unicode20203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20203
exit/b
:Unicode20190
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20190
exit/b
:Unicode20251
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20251
exit/b
:Unicode20211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20211
exit/b
:Unicode20258
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20258
exit/b
:Unicode20324
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20324
exit/b
:Unicode20213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20213
exit/b
:Unicode20261
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20261
exit/b
:Unicode20263
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20263
exit/b
:Unicode20233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20233
exit/b
:Unicode20267
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20267
exit/b
:Unicode20318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20318
exit/b
:Unicode20327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20327
exit/b
:Unicode25912
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25912
exit/b
:Unicode20314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20314
exit/b
:Unicode20317
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20317
exit/b
:Unicode20319
set Unicode_Result=١
exit/b
:Unicode١
set Unicode_Result=20319
exit/b
:Unicode20311
set Unicode_Result=٢
exit/b
:Unicode٢
set Unicode_Result=20311
exit/b
:Unicode20274
set Unicode_Result=٣
exit/b
:Unicode٣
set Unicode_Result=20274
exit/b
:Unicode20285
set Unicode_Result=٤
exit/b
:Unicode٤
set Unicode_Result=20285
exit/b
:Unicode20342
set Unicode_Result=٥
exit/b
:Unicode٥
set Unicode_Result=20342
exit/b
:Unicode20340
set Unicode_Result=٦
exit/b
:Unicode٦
set Unicode_Result=20340
exit/b
:Unicode20369
set Unicode_Result=٧
exit/b
:Unicode٧
set Unicode_Result=20369
exit/b
:Unicode20361
set Unicode_Result=٨
exit/b
:Unicode٨
set Unicode_Result=20361
exit/b
:Unicode20355
set Unicode_Result=٩
exit/b
:Unicode٩
set Unicode_Result=20355
exit/b
:Unicode20367
set Unicode_Result=٪
exit/b
:Unicode٪
set Unicode_Result=20367
exit/b
:Unicode20350
set Unicode_Result=٫
exit/b
:Unicode٫
set Unicode_Result=20350
exit/b
:Unicode20347
set Unicode_Result=٬
exit/b
:Unicode٬
set Unicode_Result=20347
exit/b
:Unicode20394
set Unicode_Result=٭
exit/b
:Unicode٭
set Unicode_Result=20394
exit/b
:Unicode20348
set Unicode_Result=ٮ
exit/b
:Unicodeٮ
set Unicode_Result=20348
exit/b
:Unicode20396
set Unicode_Result=ٯ
exit/b
:Unicodeٯ
set Unicode_Result=20396
exit/b
:Unicode20372
set Unicode_Result=ٰ
exit/b
:Unicodeٰ
set Unicode_Result=20372
exit/b
:Unicode20454
set Unicode_Result=ٱ
exit/b
:Unicodeٱ
set Unicode_Result=20454
exit/b
:Unicode20456
set Unicode_Result=ٲ
exit/b
:Unicodeٲ
set Unicode_Result=20456
exit/b
:Unicode20458
set Unicode_Result=ٳ
exit/b
:Unicodeٳ
set Unicode_Result=20458
exit/b
:Unicode20421
set Unicode_Result=ٴ
exit/b
:Unicodeٴ
set Unicode_Result=20421
exit/b
:Unicode20442
set Unicode_Result=ٵ
exit/b
:Unicodeٵ
set Unicode_Result=20442
exit/b
:Unicode20451
set Unicode_Result=ٶ
exit/b
:Unicodeٶ
set Unicode_Result=20451
exit/b
:Unicode20444
set Unicode_Result=ٷ
exit/b
:Unicodeٷ
set Unicode_Result=20444
exit/b
:Unicode20433
set Unicode_Result=ٸ
exit/b
:Unicodeٸ
set Unicode_Result=20433
exit/b
:Unicode20447
set Unicode_Result=ٹ
exit/b
:Unicodeٹ
set Unicode_Result=20447
exit/b
:Unicode20472
set Unicode_Result=ٺ
exit/b
:Unicodeٺ
set Unicode_Result=20472
exit/b
:Unicode20521
set Unicode_Result=ٻ
exit/b
:Unicodeٻ
set Unicode_Result=20521
exit/b
:Unicode20556
set Unicode_Result=ټ
exit/b
:Unicodeټ
set Unicode_Result=20556
exit/b
:Unicode20467
set Unicode_Result=ٽ
exit/b
:Unicodeٽ
set Unicode_Result=20467
exit/b
:Unicode20524
set Unicode_Result=پ
exit/b
:Unicodeپ
set Unicode_Result=20524
exit/b
:Unicode20495
set Unicode_Result=ٿ
exit/b
:Unicodeٿ
set Unicode_Result=20495
exit/b
:Unicode20526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20526
exit/b
:Unicode20525
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20525
exit/b
:Unicode20478
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20478
exit/b
:Unicode20508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20508
exit/b
:Unicode20492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20492
exit/b
:Unicode20517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20517
exit/b
:Unicode20520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20520
exit/b
:Unicode20606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20606
exit/b
:Unicode20547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20547
exit/b
:Unicode20565
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20565
exit/b
:Unicode20552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20552
exit/b
:Unicode20558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20558
exit/b
:Unicode20588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20588
exit/b
:Unicode20603
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20603
exit/b
:Unicode20645
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20645
exit/b
:Unicode20647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20647
exit/b
:Unicode20649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20649
exit/b
:Unicode20666
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20666
exit/b
:Unicode20694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20694
exit/b
:Unicode20742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20742
exit/b
:Unicode20717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20717
exit/b
:Unicode20716
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20716
exit/b
:Unicode20710
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20710
exit/b
:Unicode20718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20718
exit/b
:Unicode20743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20743
exit/b
:Unicode20747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20747
exit/b
:Unicode20189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20189
exit/b
:Unicode27709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27709
exit/b
:Unicode20312
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20312
exit/b
:Unicode20325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20325
exit/b
:Unicode20430
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20430
exit/b
:Unicode40864
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40864
exit/b
:Unicode27718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27718
exit/b
:Unicode31860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31860
exit/b
:Unicode20846
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20846
exit/b
:Unicode24061
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24061
exit/b
:Unicode40649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40649
exit/b
:Unicode39320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39320
exit/b
:Unicode20865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20865
exit/b
:Unicode22804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22804
exit/b
:Unicode21241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21241
exit/b
:Unicode21261
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21261
exit/b
:Unicode35335
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35335
exit/b
:Unicode21264
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21264
exit/b
:Unicode20971
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20971
exit/b
:Unicode22809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22809
exit/b
:Unicode20821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20821
exit/b
:Unicode20128
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20128
exit/b
:Unicode20822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20822
exit/b
:Unicode20147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20147
exit/b
:Unicode34926
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34926
exit/b
:Unicode34980
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34980
exit/b
:Unicode20149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20149
exit/b
:Unicode33044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33044
exit/b
:Unicode35026
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35026
exit/b
:Unicode31104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31104
exit/b
:Unicode23348
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23348
exit/b
:Unicode34819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34819
exit/b
:Unicode32696
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32696
exit/b
:Unicode20907
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20907
exit/b
:Unicode20913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20913
exit/b
:Unicode20925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20925
exit/b
:Unicode20924
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20924
exit/b
:Unicode20935
set Unicode_Result=ڡ
exit/b
:Unicodeڡ
set Unicode_Result=20935
exit/b
:Unicode20886
set Unicode_Result=ڢ
exit/b
:Unicodeڢ
set Unicode_Result=20886
exit/b
:Unicode20898
set Unicode_Result=ڣ
exit/b
:Unicodeڣ
set Unicode_Result=20898
exit/b
:Unicode20901
set Unicode_Result=ڤ
exit/b
:Unicodeڤ
set Unicode_Result=20901
exit/b
:Unicode35744
set Unicode_Result=ڥ
exit/b
:Unicodeڥ
set Unicode_Result=35744
exit/b
:Unicode35750
set Unicode_Result=ڦ
exit/b
:Unicodeڦ
set Unicode_Result=35750
exit/b
:Unicode35751
set Unicode_Result=ڧ
exit/b
:Unicodeڧ
set Unicode_Result=35751
exit/b
:Unicode35754
set Unicode_Result=ڨ
exit/b
:Unicodeڨ
set Unicode_Result=35754
exit/b
:Unicode35764
set Unicode_Result=ک
exit/b
:Unicodeک
set Unicode_Result=35764
exit/b
:Unicode35765
set Unicode_Result=ڪ
exit/b
:Unicodeڪ
set Unicode_Result=35765
exit/b
:Unicode35767
set Unicode_Result=ګ
exit/b
:Unicodeګ
set Unicode_Result=35767
exit/b
:Unicode35778
set Unicode_Result=ڬ
exit/b
:Unicodeڬ
set Unicode_Result=35778
exit/b
:Unicode35779
set Unicode_Result=ڭ
exit/b
:Unicodeڭ
set Unicode_Result=35779
exit/b
:Unicode35787
set Unicode_Result=ڮ
exit/b
:Unicodeڮ
set Unicode_Result=35787
exit/b
:Unicode35791
set Unicode_Result=گ
exit/b
:Unicodeگ
set Unicode_Result=35791
exit/b
:Unicode35790
set Unicode_Result=ڰ
exit/b
:Unicodeڰ
set Unicode_Result=35790
exit/b
:Unicode35794
set Unicode_Result=ڱ
exit/b
:Unicodeڱ
set Unicode_Result=35794
exit/b
:Unicode35795
set Unicode_Result=ڲ
exit/b
:Unicodeڲ
set Unicode_Result=35795
exit/b
:Unicode35796
set Unicode_Result=ڳ
exit/b
:Unicodeڳ
set Unicode_Result=35796
exit/b
:Unicode35798
set Unicode_Result=ڴ
exit/b
:Unicodeڴ
set Unicode_Result=35798
exit/b
:Unicode35800
set Unicode_Result=ڵ
exit/b
:Unicodeڵ
set Unicode_Result=35800
exit/b
:Unicode35801
set Unicode_Result=ڶ
exit/b
:Unicodeڶ
set Unicode_Result=35801
exit/b
:Unicode35804
set Unicode_Result=ڷ
exit/b
:Unicodeڷ
set Unicode_Result=35804
exit/b
:Unicode35807
set Unicode_Result=ڸ
exit/b
:Unicodeڸ
set Unicode_Result=35807
exit/b
:Unicode35808
set Unicode_Result=ڹ
exit/b
:Unicodeڹ
set Unicode_Result=35808
exit/b
:Unicode35812
set Unicode_Result=ں
exit/b
:Unicodeں
set Unicode_Result=35812
exit/b
:Unicode35816
set Unicode_Result=ڻ
exit/b
:Unicodeڻ
set Unicode_Result=35816
exit/b
:Unicode35817
set Unicode_Result=ڼ
exit/b
:Unicodeڼ
set Unicode_Result=35817
exit/b
:Unicode35822
set Unicode_Result=ڽ
exit/b
:Unicodeڽ
set Unicode_Result=35822
exit/b
:Unicode35824
set Unicode_Result=ھ
exit/b
:Unicodeھ
set Unicode_Result=35824
exit/b
:Unicode35827
set Unicode_Result=ڿ
exit/b
:Unicodeڿ
set Unicode_Result=35827
exit/b
:Unicode35830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35830
exit/b
:Unicode35833
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35833
exit/b
:Unicode35836
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35836
exit/b
:Unicode35839
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35839
exit/b
:Unicode35840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35840
exit/b
:Unicode35842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35842
exit/b
:Unicode35844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35844
exit/b
:Unicode35847
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35847
exit/b
:Unicode35852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35852
exit/b
:Unicode35855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35855
exit/b
:Unicode35857
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35857
exit/b
:Unicode35858
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35858
exit/b
:Unicode35860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35860
exit/b
:Unicode35861
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35861
exit/b
:Unicode35862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35862
exit/b
:Unicode35865
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35865
exit/b
:Unicode35867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35867
exit/b
:Unicode35864
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35864
exit/b
:Unicode35869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35869
exit/b
:Unicode35871
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35871
exit/b
:Unicode35872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35872
exit/b
:Unicode35873
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35873
exit/b
:Unicode35877
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35877
exit/b
:Unicode35879
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35879
exit/b
:Unicode35882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35882
exit/b
:Unicode35883
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35883
exit/b
:Unicode35886
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35886
exit/b
:Unicode35887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35887
exit/b
:Unicode35890
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35890
exit/b
:Unicode35891
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35891
exit/b
:Unicode35893
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35893
exit/b
:Unicode35894
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35894
exit/b
:Unicode21353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21353
exit/b
:Unicode21370
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21370
exit/b
:Unicode38429
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38429
exit/b
:Unicode38434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38434
exit/b
:Unicode38433
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38433
exit/b
:Unicode38449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38449
exit/b
:Unicode38442
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38442
exit/b
:Unicode38461
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38461
exit/b
:Unicode38460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38460
exit/b
:Unicode38466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38466
exit/b
:Unicode38473
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38473
exit/b
:Unicode38484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38484
exit/b
:Unicode38495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38495
exit/b
:Unicode38503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38503
exit/b
:Unicode38508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38508
exit/b
:Unicode38514
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38514
exit/b
:Unicode38516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38516
exit/b
:Unicode38536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38536
exit/b
:Unicode38541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38541
exit/b
:Unicode38551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38551
exit/b
:Unicode38576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38576
exit/b
:Unicode37015
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37015
exit/b
:Unicode37019
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37019
exit/b
:Unicode37021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37021
exit/b
:Unicode37017
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37017
exit/b
:Unicode37036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37036
exit/b
:Unicode37025
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37025
exit/b
:Unicode37044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37044
exit/b
:Unicode37043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37043
exit/b
:Unicode37046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37046
exit/b
:Unicode37050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37050
exit/b
:Unicode37048
set Unicode_Result=ۡ
exit/b
:Unicodeۡ
set Unicode_Result=37048
exit/b
:Unicode37040
set Unicode_Result=ۢ
exit/b
:Unicodeۢ
set Unicode_Result=37040
exit/b
:Unicode37071
set Unicode_Result=ۣ
exit/b
:Unicodeۣ
set Unicode_Result=37071
exit/b
:Unicode37061
set Unicode_Result=ۤ
exit/b
:Unicodeۤ
set Unicode_Result=37061
exit/b
:Unicode37054
set Unicode_Result=ۥ
exit/b
:Unicodeۥ
set Unicode_Result=37054
exit/b
:Unicode37072
set Unicode_Result=ۦ
exit/b
:Unicodeۦ
set Unicode_Result=37072
exit/b
:Unicode37060
set Unicode_Result=ۧ
exit/b
:Unicodeۧ
set Unicode_Result=37060
exit/b
:Unicode37063
set Unicode_Result=ۨ
exit/b
:Unicodeۨ
set Unicode_Result=37063
exit/b
:Unicode37075
set Unicode_Result=۩
exit/b
:Unicode۩
set Unicode_Result=37075
exit/b
:Unicode37094
set Unicode_Result=۪
exit/b
:Unicode۪
set Unicode_Result=37094
exit/b
:Unicode37090
set Unicode_Result=۫
exit/b
:Unicode۫
set Unicode_Result=37090
exit/b
:Unicode37084
set Unicode_Result=۬
exit/b
:Unicode۬
set Unicode_Result=37084
exit/b
:Unicode37079
set Unicode_Result=ۭ
exit/b
:Unicodeۭ
set Unicode_Result=37079
exit/b
:Unicode37083
set Unicode_Result=ۮ
exit/b
:Unicodeۮ
set Unicode_Result=37083
exit/b
:Unicode37099
set Unicode_Result=ۯ
exit/b
:Unicodeۯ
set Unicode_Result=37099
exit/b
:Unicode37103
set Unicode_Result=۰
exit/b
:Unicode۰
set Unicode_Result=37103
exit/b
:Unicode37118
set Unicode_Result=۱
exit/b
:Unicode۱
set Unicode_Result=37118
exit/b
:Unicode37124
set Unicode_Result=۲
exit/b
:Unicode۲
set Unicode_Result=37124
exit/b
:Unicode37154
set Unicode_Result=۳
exit/b
:Unicode۳
set Unicode_Result=37154
exit/b
:Unicode37150
set Unicode_Result=۴
exit/b
:Unicode۴
set Unicode_Result=37150
exit/b
:Unicode37155
set Unicode_Result=۵
exit/b
:Unicode۵
set Unicode_Result=37155
exit/b
:Unicode37169
set Unicode_Result=۶
exit/b
:Unicode۶
set Unicode_Result=37169
exit/b
:Unicode37167
set Unicode_Result=۷
exit/b
:Unicode۷
set Unicode_Result=37167
exit/b
:Unicode37177
set Unicode_Result=۸
exit/b
:Unicode۸
set Unicode_Result=37177
exit/b
:Unicode37187
set Unicode_Result=۹
exit/b
:Unicode۹
set Unicode_Result=37187
exit/b
:Unicode37190
set Unicode_Result=ۺ
exit/b
:Unicodeۺ
set Unicode_Result=37190
exit/b
:Unicode21005
set Unicode_Result=ۻ
exit/b
:Unicodeۻ
set Unicode_Result=21005
exit/b
:Unicode22850
set Unicode_Result=ۼ
exit/b
:Unicodeۼ
set Unicode_Result=22850
exit/b
:Unicode21154
set Unicode_Result=۽
exit/b
:Unicode۽
set Unicode_Result=21154
exit/b
:Unicode21164
set Unicode_Result=۾
exit/b
:Unicode۾
set Unicode_Result=21164
exit/b
:Unicode21165
set Unicode_Result=ۿ
exit/b
:Unicodeۿ
set Unicode_Result=21165
exit/b
:Unicode21182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21182
exit/b
:Unicode21759
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21759
exit/b
:Unicode21200
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21200
exit/b
:Unicode21206
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21206
exit/b
:Unicode21232
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21232
exit/b
:Unicode21471
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21471
exit/b
:Unicode29166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29166
exit/b
:Unicode30669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30669
exit/b
:Unicode24308
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24308
exit/b
:Unicode20981
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20981
exit/b
:Unicode20988
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20988
exit/b
:Unicode39727
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39727
exit/b
:Unicode21430
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21430
exit/b
:Unicode24321
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24321
exit/b
:Unicode30042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30042
exit/b
:Unicode24047
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24047
exit/b
:Unicode22348
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22348
exit/b
:Unicode22441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22441
exit/b
:Unicode22433
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22433
exit/b
:Unicode22654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22654
exit/b
:Unicode22716
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22716
exit/b
:Unicode22725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22725
exit/b
:Unicode22737
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22737
exit/b
:Unicode22313
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22313
exit/b
:Unicode22316
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22316
exit/b
:Unicode22314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22314
exit/b
:Unicode22323
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22323
exit/b
:Unicode22329
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22329
exit/b
:Unicode22318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22318
exit/b
:Unicode22319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22319
exit/b
:Unicode22364
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22364
exit/b
:Unicode22331
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22331
exit/b
:Unicode22338
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22338
exit/b
:Unicode22377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22377
exit/b
:Unicode22405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22405
exit/b
:Unicode22379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22379
exit/b
:Unicode22406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22406
exit/b
:Unicode22396
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22396
exit/b
:Unicode22395
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22395
exit/b
:Unicode22376
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22376
exit/b
:Unicode22381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22381
exit/b
:Unicode22390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22390
exit/b
:Unicode22387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22387
exit/b
:Unicode22445
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22445
exit/b
:Unicode22436
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22436
exit/b
:Unicode22412
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22412
exit/b
:Unicode22450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22450
exit/b
:Unicode22479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22479
exit/b
:Unicode22439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22439
exit/b
:Unicode22452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22452
exit/b
:Unicode22419
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22419
exit/b
:Unicode22432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22432
exit/b
:Unicode22485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22485
exit/b
:Unicode22488
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22488
exit/b
:Unicode22490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22490
exit/b
:Unicode22489
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22489
exit/b
:Unicode22482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22482
exit/b
:Unicode22456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22456
exit/b
:Unicode22516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22516
exit/b
:Unicode22511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22511
exit/b
:Unicode22520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22520
exit/b
:Unicode22500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22500
exit/b
:Unicode22493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22493
exit/b
:Unicode22539
set Unicode_Result=ܡ
exit/b
:Unicodeܡ
set Unicode_Result=22539
exit/b
:Unicode22541
set Unicode_Result=ܢ
exit/b
:Unicodeܢ
set Unicode_Result=22541
exit/b
:Unicode22525
set Unicode_Result=ܣ
exit/b
:Unicodeܣ
set Unicode_Result=22525
exit/b
:Unicode22509
set Unicode_Result=ܤ
exit/b
:Unicodeܤ
set Unicode_Result=22509
exit/b
:Unicode22528
set Unicode_Result=ܥ
exit/b
:Unicodeܥ
set Unicode_Result=22528
exit/b
:Unicode22558
set Unicode_Result=ܦ
exit/b
:Unicodeܦ
set Unicode_Result=22558
exit/b
:Unicode22553
set Unicode_Result=ܧ
exit/b
:Unicodeܧ
set Unicode_Result=22553
exit/b
:Unicode22596
set Unicode_Result=ܨ
exit/b
:Unicodeܨ
set Unicode_Result=22596
exit/b
:Unicode22560
set Unicode_Result=ܩ
exit/b
:Unicodeܩ
set Unicode_Result=22560
exit/b
:Unicode22629
set Unicode_Result=ܪ
exit/b
:Unicodeܪ
set Unicode_Result=22629
exit/b
:Unicode22636
set Unicode_Result=ܫ
exit/b
:Unicodeܫ
set Unicode_Result=22636
exit/b
:Unicode22657
set Unicode_Result=ܬ
exit/b
:Unicodeܬ
set Unicode_Result=22657
exit/b
:Unicode22665
set Unicode_Result=ܭ
exit/b
:Unicodeܭ
set Unicode_Result=22665
exit/b
:Unicode22682
set Unicode_Result=ܮ
exit/b
:Unicodeܮ
set Unicode_Result=22682
exit/b
:Unicode22656
set Unicode_Result=ܯ
exit/b
:Unicodeܯ
set Unicode_Result=22656
exit/b
:Unicode39336
set Unicode_Result=ܰ
exit/b
:Unicodeܰ
set Unicode_Result=39336
exit/b
:Unicode40729
set Unicode_Result=ܱ
exit/b
:Unicodeܱ
set Unicode_Result=40729
exit/b
:Unicode25087
set Unicode_Result=ܲ
exit/b
:Unicodeܲ
set Unicode_Result=25087
exit/b
:Unicode33401
set Unicode_Result=ܳ
exit/b
:Unicodeܳ
set Unicode_Result=33401
exit/b
:Unicode33405
set Unicode_Result=ܴ
exit/b
:Unicodeܴ
set Unicode_Result=33405
exit/b
:Unicode33407
set Unicode_Result=ܵ
exit/b
:Unicodeܵ
set Unicode_Result=33407
exit/b
:Unicode33423
set Unicode_Result=ܶ
exit/b
:Unicodeܶ
set Unicode_Result=33423
exit/b
:Unicode33418
set Unicode_Result=ܷ
exit/b
:Unicodeܷ
set Unicode_Result=33418
exit/b
:Unicode33448
set Unicode_Result=ܸ
exit/b
:Unicodeܸ
set Unicode_Result=33448
exit/b
:Unicode33412
set Unicode_Result=ܹ
exit/b
:Unicodeܹ
set Unicode_Result=33412
exit/b
:Unicode33422
set Unicode_Result=ܺ
exit/b
:Unicodeܺ
set Unicode_Result=33422
exit/b
:Unicode33425
set Unicode_Result=ܻ
exit/b
:Unicodeܻ
set Unicode_Result=33425
exit/b
:Unicode33431
set Unicode_Result=ܼ
exit/b
:Unicodeܼ
set Unicode_Result=33431
exit/b
:Unicode33433
set Unicode_Result=ܽ
exit/b
:Unicodeܽ
set Unicode_Result=33433
exit/b
:Unicode33451
set Unicode_Result=ܾ
exit/b
:Unicodeܾ
set Unicode_Result=33451
exit/b
:Unicode33464
set Unicode_Result=ܿ
exit/b
:Unicodeܿ
set Unicode_Result=33464
exit/b
:Unicode33470
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33470
exit/b
:Unicode33456
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33456
exit/b
:Unicode33480
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33480
exit/b
:Unicode33482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33482
exit/b
:Unicode33507
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33507
exit/b
:Unicode33432
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33432
exit/b
:Unicode33463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33463
exit/b
:Unicode33454
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33454
exit/b
:Unicode33483
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33483
exit/b
:Unicode33484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33484
exit/b
:Unicode33473
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33473
exit/b
:Unicode33449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33449
exit/b
:Unicode33460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33460
exit/b
:Unicode33441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33441
exit/b
:Unicode33450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33450
exit/b
:Unicode33439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33439
exit/b
:Unicode33476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33476
exit/b
:Unicode33486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33486
exit/b
:Unicode33444
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33444
exit/b
:Unicode33505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33505
exit/b
:Unicode33545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33545
exit/b
:Unicode33527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33527
exit/b
:Unicode33508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33508
exit/b
:Unicode33551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33551
exit/b
:Unicode33543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33543
exit/b
:Unicode33500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33500
exit/b
:Unicode33524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33524
exit/b
:Unicode33490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33490
exit/b
:Unicode33496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33496
exit/b
:Unicode33548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33548
exit/b
:Unicode33531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33531
exit/b
:Unicode33491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33491
exit/b
:Unicode33553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33553
exit/b
:Unicode33562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33562
exit/b
:Unicode33542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33542
exit/b
:Unicode33556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33556
exit/b
:Unicode33557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33557
exit/b
:Unicode33504
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33504
exit/b
:Unicode33493
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33493
exit/b
:Unicode33564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33564
exit/b
:Unicode33617
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33617
exit/b
:Unicode33627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33627
exit/b
:Unicode33628
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33628
exit/b
:Unicode33544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33544
exit/b
:Unicode33682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33682
exit/b
:Unicode33596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33596
exit/b
:Unicode33588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33588
exit/b
:Unicode33585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33585
exit/b
:Unicode33691
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33691
exit/b
:Unicode33630
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33630
exit/b
:Unicode33583
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33583
exit/b
:Unicode33615
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33615
exit/b
:Unicode33607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33607
exit/b
:Unicode33603
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33603
exit/b
:Unicode33631
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33631
exit/b
:Unicode33600
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33600
exit/b
:Unicode33559
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33559
exit/b
:Unicode33632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33632
exit/b
:Unicode33581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33581
exit/b
:Unicode33594
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33594
exit/b
:Unicode33587
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33587
exit/b
:Unicode33638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33638
exit/b
:Unicode33637
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33637
exit/b
:Unicode33640
set Unicode_Result=ݡ
exit/b
:Unicodeݡ
set Unicode_Result=33640
exit/b
:Unicode33563
set Unicode_Result=ݢ
exit/b
:Unicodeݢ
set Unicode_Result=33563
exit/b
:Unicode33641
set Unicode_Result=ݣ
exit/b
:Unicodeݣ
set Unicode_Result=33641
exit/b
:Unicode33644
set Unicode_Result=ݤ
exit/b
:Unicodeݤ
set Unicode_Result=33644
exit/b
:Unicode33642
set Unicode_Result=ݥ
exit/b
:Unicodeݥ
set Unicode_Result=33642
exit/b
:Unicode33645
set Unicode_Result=ݦ
exit/b
:Unicodeݦ
set Unicode_Result=33645
exit/b
:Unicode33646
set Unicode_Result=ݧ
exit/b
:Unicodeݧ
set Unicode_Result=33646
exit/b
:Unicode33712
set Unicode_Result=ݨ
exit/b
:Unicodeݨ
set Unicode_Result=33712
exit/b
:Unicode33656
set Unicode_Result=ݩ
exit/b
:Unicodeݩ
set Unicode_Result=33656
exit/b
:Unicode33715
set Unicode_Result=ݪ
exit/b
:Unicodeݪ
set Unicode_Result=33715
exit/b
:Unicode33716
set Unicode_Result=ݫ
exit/b
:Unicodeݫ
set Unicode_Result=33716
exit/b
:Unicode33696
set Unicode_Result=ݬ
exit/b
:Unicodeݬ
set Unicode_Result=33696
exit/b
:Unicode33706
set Unicode_Result=ݭ
exit/b
:Unicodeݭ
set Unicode_Result=33706
exit/b
:Unicode33683
set Unicode_Result=ݮ
exit/b
:Unicodeݮ
set Unicode_Result=33683
exit/b
:Unicode33692
set Unicode_Result=ݯ
exit/b
:Unicodeݯ
set Unicode_Result=33692
exit/b
:Unicode33669
set Unicode_Result=ݰ
exit/b
:Unicodeݰ
set Unicode_Result=33669
exit/b
:Unicode33660
set Unicode_Result=ݱ
exit/b
:Unicodeݱ
set Unicode_Result=33660
exit/b
:Unicode33718
set Unicode_Result=ݲ
exit/b
:Unicodeݲ
set Unicode_Result=33718
exit/b
:Unicode33705
set Unicode_Result=ݳ
exit/b
:Unicodeݳ
set Unicode_Result=33705
exit/b
:Unicode33661
set Unicode_Result=ݴ
exit/b
:Unicodeݴ
set Unicode_Result=33661
exit/b
:Unicode33720
set Unicode_Result=ݵ
exit/b
:Unicodeݵ
set Unicode_Result=33720
exit/b
:Unicode33659
set Unicode_Result=ݶ
exit/b
:Unicodeݶ
set Unicode_Result=33659
exit/b
:Unicode33688
set Unicode_Result=ݷ
exit/b
:Unicodeݷ
set Unicode_Result=33688
exit/b
:Unicode33694
set Unicode_Result=ݸ
exit/b
:Unicodeݸ
set Unicode_Result=33694
exit/b
:Unicode33704
set Unicode_Result=ݹ
exit/b
:Unicodeݹ
set Unicode_Result=33704
exit/b
:Unicode33722
set Unicode_Result=ݺ
exit/b
:Unicodeݺ
set Unicode_Result=33722
exit/b
:Unicode33724
set Unicode_Result=ݻ
exit/b
:Unicodeݻ
set Unicode_Result=33724
exit/b
:Unicode33729
set Unicode_Result=ݼ
exit/b
:Unicodeݼ
set Unicode_Result=33729
exit/b
:Unicode33793
set Unicode_Result=ݽ
exit/b
:Unicodeݽ
set Unicode_Result=33793
exit/b
:Unicode33765
set Unicode_Result=ݾ
exit/b
:Unicodeݾ
set Unicode_Result=33765
exit/b
:Unicode33752
set Unicode_Result=ݿ
exit/b
:Unicodeݿ
set Unicode_Result=33752
exit/b
:Unicode22535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22535
exit/b
:Unicode33816
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33816
exit/b
:Unicode33803
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33803
exit/b
:Unicode33757
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33757
exit/b
:Unicode33789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33789
exit/b
:Unicode33750
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33750
exit/b
:Unicode33820
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33820
exit/b
:Unicode33848
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33848
exit/b
:Unicode33809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33809
exit/b
:Unicode33798
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33798
exit/b
:Unicode33748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33748
exit/b
:Unicode33759
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33759
exit/b
:Unicode33807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33807
exit/b
:Unicode33795
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33795
exit/b
:Unicode33784
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33784
exit/b
:Unicode33785
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33785
exit/b
:Unicode33770
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33770
exit/b
:Unicode33733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33733
exit/b
:Unicode33728
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33728
exit/b
:Unicode33830
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33830
exit/b
:Unicode33776
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33776
exit/b
:Unicode33761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33761
exit/b
:Unicode33884
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33884
exit/b
:Unicode33873
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33873
exit/b
:Unicode33882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33882
exit/b
:Unicode33881
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33881
exit/b
:Unicode33907
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33907
exit/b
:Unicode33927
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33927
exit/b
:Unicode33928
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33928
exit/b
:Unicode33914
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33914
exit/b
:Unicode33929
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33929
exit/b
:Unicode33912
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33912
exit/b
:Unicode33852
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33852
exit/b
:Unicode33862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33862
exit/b
:Unicode33897
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33897
exit/b
:Unicode33910
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33910
exit/b
:Unicode33932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33932
exit/b
:Unicode33934
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33934
exit/b
:Unicode33841
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33841
exit/b
:Unicode33901
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33901
exit/b
:Unicode33985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33985
exit/b
:Unicode33997
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33997
exit/b
:Unicode34000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34000
exit/b
:Unicode34022
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34022
exit/b
:Unicode33981
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33981
exit/b
:Unicode34003
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34003
exit/b
:Unicode33994
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33994
exit/b
:Unicode33983
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33983
exit/b
:Unicode33978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33978
exit/b
:Unicode34016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34016
exit/b
:Unicode33953
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33953
exit/b
:Unicode33977
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33977
exit/b
:Unicode33972
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33972
exit/b
:Unicode33943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33943
exit/b
:Unicode34021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34021
exit/b
:Unicode34019
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34019
exit/b
:Unicode34060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34060
exit/b
:Unicode29965
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29965
exit/b
:Unicode34104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34104
exit/b
:Unicode34032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34032
exit/b
:Unicode34105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34105
exit/b
:Unicode34079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34079
exit/b
:Unicode34106
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34106
exit/b
:Unicode34134
set Unicode_Result=ޡ
exit/b
:Unicodeޡ
set Unicode_Result=34134
exit/b
:Unicode34107
set Unicode_Result=ޢ
exit/b
:Unicodeޢ
set Unicode_Result=34107
exit/b
:Unicode34047
set Unicode_Result=ޣ
exit/b
:Unicodeޣ
set Unicode_Result=34047
exit/b
:Unicode34044
set Unicode_Result=ޤ
exit/b
:Unicodeޤ
set Unicode_Result=34044
exit/b
:Unicode34137
set Unicode_Result=ޥ
exit/b
:Unicodeޥ
set Unicode_Result=34137
exit/b
:Unicode34120
set Unicode_Result=ަ
exit/b
:Unicodeަ
set Unicode_Result=34120
exit/b
:Unicode34152
set Unicode_Result=ާ
exit/b
:Unicodeާ
set Unicode_Result=34152
exit/b
:Unicode34148
set Unicode_Result=ި
exit/b
:Unicodeި
set Unicode_Result=34148
exit/b
:Unicode34142
set Unicode_Result=ީ
exit/b
:Unicodeީ
set Unicode_Result=34142
exit/b
:Unicode34170
set Unicode_Result=ު
exit/b
:Unicodeު
set Unicode_Result=34170
exit/b
:Unicode30626
set Unicode_Result=ޫ
exit/b
:Unicodeޫ
set Unicode_Result=30626
exit/b
:Unicode34115
set Unicode_Result=ެ
exit/b
:Unicodeެ
set Unicode_Result=34115
exit/b
:Unicode34162
set Unicode_Result=ޭ
exit/b
:Unicodeޭ
set Unicode_Result=34162
exit/b
:Unicode34171
set Unicode_Result=ޮ
exit/b
:Unicodeޮ
set Unicode_Result=34171
exit/b
:Unicode34212
set Unicode_Result=ޯ
exit/b
:Unicodeޯ
set Unicode_Result=34212
exit/b
:Unicode34216
set Unicode_Result=ް
exit/b
:Unicodeް
set Unicode_Result=34216
exit/b
:Unicode34183
set Unicode_Result=ޱ
exit/b
:Unicodeޱ
set Unicode_Result=34183
exit/b
:Unicode34191
set Unicode_Result=޲
exit/b
:Unicode޲
set Unicode_Result=34191
exit/b
:Unicode34169
set Unicode_Result=޳
exit/b
:Unicode޳
set Unicode_Result=34169
exit/b
:Unicode34222
set Unicode_Result=޴
exit/b
:Unicode޴
set Unicode_Result=34222
exit/b
:Unicode34204
set Unicode_Result=޵
exit/b
:Unicode޵
set Unicode_Result=34204
exit/b
:Unicode34181
set Unicode_Result=޶
exit/b
:Unicode޶
set Unicode_Result=34181
exit/b
:Unicode34233
set Unicode_Result=޷
exit/b
:Unicode޷
set Unicode_Result=34233
exit/b
:Unicode34231
set Unicode_Result=޸
exit/b
:Unicode޸
set Unicode_Result=34231
exit/b
:Unicode34224
set Unicode_Result=޹
exit/b
:Unicode޹
set Unicode_Result=34224
exit/b
:Unicode34259
set Unicode_Result=޺
exit/b
:Unicode޺
set Unicode_Result=34259
exit/b
:Unicode34241
set Unicode_Result=޻
exit/b
:Unicode޻
set Unicode_Result=34241
exit/b
:Unicode34268
set Unicode_Result=޼
exit/b
:Unicode޼
set Unicode_Result=34268
exit/b
:Unicode34303
set Unicode_Result=޽
exit/b
:Unicode޽
set Unicode_Result=34303
exit/b
:Unicode34343
set Unicode_Result=޾
exit/b
:Unicode޾
set Unicode_Result=34343
exit/b
:Unicode34309
set Unicode_Result=޿
exit/b
:Unicode޿
set Unicode_Result=34309
exit/b
:Unicode34345
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34345
exit/b
:Unicode34326
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34326
exit/b
:Unicode34364
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34364
exit/b
:Unicode24318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24318
exit/b
:Unicode24328
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24328
exit/b
:Unicode22844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22844
exit/b
:Unicode22849
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22849
exit/b
:Unicode32823
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32823
exit/b
:Unicode22869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22869
exit/b
:Unicode22874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22874
exit/b
:Unicode22872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22872
exit/b
:Unicode21263
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21263
exit/b
:Unicode23586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23586
exit/b
:Unicode23589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23589
exit/b
:Unicode23596
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23596
exit/b
:Unicode23604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23604
exit/b
:Unicode25164
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25164
exit/b
:Unicode25194
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25194
exit/b
:Unicode25247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25247
exit/b
:Unicode25275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25275
exit/b
:Unicode25290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25290
exit/b
:Unicode25306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25306
exit/b
:Unicode25303
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25303
exit/b
:Unicode25326
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25326
exit/b
:Unicode25378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25378
exit/b
:Unicode25334
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25334
exit/b
:Unicode25401
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25401
exit/b
:Unicode25419
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25419
exit/b
:Unicode25411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25411
exit/b
:Unicode25517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25517
exit/b
:Unicode25590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25590
exit/b
:Unicode25457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25457
exit/b
:Unicode25466
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25466
exit/b
:Unicode25486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25486
exit/b
:Unicode25524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25524
exit/b
:Unicode25453
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25453
exit/b
:Unicode25516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25516
exit/b
:Unicode25482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25482
exit/b
:Unicode25449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25449
exit/b
:Unicode25518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25518
exit/b
:Unicode25532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25532
exit/b
:Unicode25586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25586
exit/b
:Unicode25592
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25592
exit/b
:Unicode25568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25568
exit/b
:Unicode25599
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25599
exit/b
:Unicode25540
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25540
exit/b
:Unicode25566
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25566
exit/b
:Unicode25550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25550
exit/b
:Unicode25682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25682
exit/b
:Unicode25542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25542
exit/b
:Unicode25534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25534
exit/b
:Unicode25669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25669
exit/b
:Unicode25665
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25665
exit/b
:Unicode25611
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25611
exit/b
:Unicode25627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25627
exit/b
:Unicode25632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25632
exit/b
:Unicode25612
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25612
exit/b
:Unicode25638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25638
exit/b
:Unicode25633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25633
exit/b
:Unicode25694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25694
exit/b
:Unicode25732
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25732
exit/b
:Unicode25709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25709
exit/b
:Unicode25750
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25750
exit/b
:Unicode25722
set Unicode_Result=ߡ
exit/b
:Unicodeߡ
set Unicode_Result=25722
exit/b
:Unicode25783
set Unicode_Result=ߢ
exit/b
:Unicodeߢ
set Unicode_Result=25783
exit/b
:Unicode25784
set Unicode_Result=ߣ
exit/b
:Unicodeߣ
set Unicode_Result=25784
exit/b
:Unicode25753
set Unicode_Result=ߤ
exit/b
:Unicodeߤ
set Unicode_Result=25753
exit/b
:Unicode25786
set Unicode_Result=ߥ
exit/b
:Unicodeߥ
set Unicode_Result=25786
exit/b
:Unicode25792
set Unicode_Result=ߦ
exit/b
:Unicodeߦ
set Unicode_Result=25792
exit/b
:Unicode25808
set Unicode_Result=ߧ
exit/b
:Unicodeߧ
set Unicode_Result=25808
exit/b
:Unicode25815
set Unicode_Result=ߨ
exit/b
:Unicodeߨ
set Unicode_Result=25815
exit/b
:Unicode25828
set Unicode_Result=ߩ
exit/b
:Unicodeߩ
set Unicode_Result=25828
exit/b
:Unicode25826
set Unicode_Result=ߪ
exit/b
:Unicodeߪ
set Unicode_Result=25826
exit/b
:Unicode25865
set Unicode_Result=߫
exit/b
:Unicode߫
set Unicode_Result=25865
exit/b
:Unicode25893
set Unicode_Result=߬
exit/b
:Unicode߬
set Unicode_Result=25893
exit/b
:Unicode25902
set Unicode_Result=߭
exit/b
:Unicode߭
set Unicode_Result=25902
exit/b
:Unicode24331
set Unicode_Result=߮
exit/b
:Unicode߮
set Unicode_Result=24331
exit/b
:Unicode24530
set Unicode_Result=߯
exit/b
:Unicode߯
set Unicode_Result=24530
exit/b
:Unicode29977
set Unicode_Result=߰
exit/b
:Unicode߰
set Unicode_Result=29977
exit/b
:Unicode24337
set Unicode_Result=߱
exit/b
:Unicode߱
set Unicode_Result=24337
exit/b
:Unicode21343
set Unicode_Result=߲
exit/b
:Unicode߲
set Unicode_Result=21343
exit/b
:Unicode21489
set Unicode_Result=߳
exit/b
:Unicode߳
set Unicode_Result=21489
exit/b
:Unicode21501
set Unicode_Result=ߴ
exit/b
:Unicodeߴ
set Unicode_Result=21501
exit/b
:Unicode21481
set Unicode_Result=ߵ
exit/b
:Unicodeߵ
set Unicode_Result=21481
exit/b
:Unicode21480
set Unicode_Result=߶
exit/b
:Unicode߶
set Unicode_Result=21480
exit/b
:Unicode21499
set Unicode_Result=߷
exit/b
:Unicode߷
set Unicode_Result=21499
exit/b
:Unicode21522
set Unicode_Result=߸
exit/b
:Unicode߸
set Unicode_Result=21522
exit/b
:Unicode21526
set Unicode_Result=߹
exit/b
:Unicode߹
set Unicode_Result=21526
exit/b
:Unicode21510
set Unicode_Result=ߺ
exit/b
:Unicodeߺ
set Unicode_Result=21510
exit/b
:Unicode21579
set Unicode_Result=߻
exit/b
:Unicode߻
set Unicode_Result=21579
exit/b
:Unicode21586
set Unicode_Result=߼
exit/b
:Unicode߼
set Unicode_Result=21586
exit/b
:Unicode21587
set Unicode_Result=߽
exit/b
:Unicode߽
set Unicode_Result=21587
exit/b
:Unicode21588
set Unicode_Result=߾
exit/b
:Unicode߾
set Unicode_Result=21588
exit/b
:Unicode21590
set Unicode_Result=߿
exit/b
:Unicode߿
set Unicode_Result=21590
exit/b
:Unicode21571
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21571
exit/b
:Unicode21537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21537
exit/b
:Unicode21591
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21591
exit/b
:Unicode21593
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21593
exit/b
:Unicode21539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21539
exit/b
:Unicode21554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21554
exit/b
:Unicode21634
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21634
exit/b
:Unicode21652
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21652
exit/b
:Unicode21623
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21623
exit/b
:Unicode21617
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21617
exit/b
:Unicode21604
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21604
exit/b
:Unicode21658
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21658
exit/b
:Unicode21659
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21659
exit/b
:Unicode21636
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21636
exit/b
:Unicode21622
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21622
exit/b
:Unicode21606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21606
exit/b
:Unicode21661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21661
exit/b
:Unicode21712
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21712
exit/b
:Unicode21677
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21677
exit/b
:Unicode21698
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21698
exit/b
:Unicode21684
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21684
exit/b
:Unicode21714
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21714
exit/b
:Unicode21671
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21671
exit/b
:Unicode21670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21670
exit/b
:Unicode21715
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21715
exit/b
:Unicode21716
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21716
exit/b
:Unicode21618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21618
exit/b
:Unicode21667
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21667
exit/b
:Unicode21717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21717
exit/b
:Unicode21691
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21691
exit/b
:Unicode21695
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21695
exit/b
:Unicode21708
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21708
exit/b
:Unicode21721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21721
exit/b
:Unicode21722
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21722
exit/b
:Unicode21724
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21724
exit/b
:Unicode21673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21673
exit/b
:Unicode21674
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21674
exit/b
:Unicode21668
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21668
exit/b
:Unicode21725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21725
exit/b
:Unicode21711
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21711
exit/b
:Unicode21726
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21726
exit/b
:Unicode21787
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21787
exit/b
:Unicode21735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21735
exit/b
:Unicode21792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21792
exit/b
:Unicode21757
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21757
exit/b
:Unicode21780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21780
exit/b
:Unicode21747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21747
exit/b
:Unicode21794
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21794
exit/b
:Unicode21795
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21795
exit/b
:Unicode21775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21775
exit/b
:Unicode21777
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21777
exit/b
:Unicode21799
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21799
exit/b
:Unicode21802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21802
exit/b
:Unicode21863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21863
exit/b
:Unicode21903
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21903
exit/b
:Unicode21941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21941
exit/b
:Unicode21833
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21833
exit/b
:Unicode21869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21869
exit/b
:Unicode21825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21825
exit/b
:Unicode21845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21845
exit/b
:Unicode21823
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21823
exit/b
:Unicode21840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21840
exit/b
:Unicode21820
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21820
exit/b
:Unicode21815
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21815
exit/b
:Unicode21846
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21846
exit/b
:Unicode21877
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21877
exit/b
:Unicode21878
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21878
exit/b
:Unicode21879
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21879
exit/b
:Unicode21811
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21811
exit/b
:Unicode21808
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21808
exit/b
:Unicode21852
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21852
exit/b
:Unicode21899
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21899
exit/b
:Unicode21970
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21970
exit/b
:Unicode21891
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21891
exit/b
:Unicode21937
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21937
exit/b
:Unicode21945
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21945
exit/b
:Unicode21896
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21896
exit/b
:Unicode21889
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21889
exit/b
:Unicode21919
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21919
exit/b
:Unicode21886
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21886
exit/b
:Unicode21974
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21974
exit/b
:Unicode21905
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21905
exit/b
:Unicode21883
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21883
exit/b
:Unicode21983
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21983
exit/b
:Unicode21949
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21949
exit/b
:Unicode21950
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21950
exit/b
:Unicode21908
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21908
exit/b
:Unicode21913
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21913
exit/b
:Unicode21994
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21994
exit/b
:Unicode22007
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22007
exit/b
:Unicode21961
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21961
exit/b
:Unicode22047
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22047
exit/b
:Unicode21969
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21969
exit/b
:Unicode21995
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21995
exit/b
:Unicode21996
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21996
exit/b
:Unicode21972
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21972
exit/b
:Unicode21990
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21990
exit/b
:Unicode21981
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21981
exit/b
:Unicode21956
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21956
exit/b
:Unicode21999
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21999
exit/b
:Unicode21989
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21989
exit/b
:Unicode22002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22002
exit/b
:Unicode22003
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22003
exit/b
:Unicode21964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21964
exit/b
:Unicode21965
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21965
exit/b
:Unicode21992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21992
exit/b
:Unicode22005
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22005
exit/b
:Unicode21988
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21988
exit/b
:Unicode36756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36756
exit/b
:Unicode22046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22046
exit/b
:Unicode22024
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22024
exit/b
:Unicode22028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22028
exit/b
:Unicode22017
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22017
exit/b
:Unicode22052
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22052
exit/b
:Unicode22051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22051
exit/b
:Unicode22014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22014
exit/b
:Unicode22016
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22016
exit/b
:Unicode22055
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22055
exit/b
:Unicode22061
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22061
exit/b
:Unicode22104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22104
exit/b
:Unicode22073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22073
exit/b
:Unicode22103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22103
exit/b
:Unicode22060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22060
exit/b
:Unicode22093
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22093
exit/b
:Unicode22114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22114
exit/b
:Unicode22105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22105
exit/b
:Unicode22108
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22108
exit/b
:Unicode22092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22092
exit/b
:Unicode22100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22100
exit/b
:Unicode22150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22150
exit/b
:Unicode22116
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22116
exit/b
:Unicode22129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22129
exit/b
:Unicode22123
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22123
exit/b
:Unicode22139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22139
exit/b
:Unicode22140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22140
exit/b
:Unicode22149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22149
exit/b
:Unicode22163
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22163
exit/b
:Unicode22191
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22191
exit/b
:Unicode22228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22228
exit/b
:Unicode22231
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22231
exit/b
:Unicode22237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22237
exit/b
:Unicode22241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22241
exit/b
:Unicode22261
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22261
exit/b
:Unicode22251
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22251
exit/b
:Unicode22265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22265
exit/b
:Unicode22271
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22271
exit/b
:Unicode22276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22276
exit/b
:Unicode22282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22282
exit/b
:Unicode22281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22281
exit/b
:Unicode22300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22300
exit/b
:Unicode24079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24079
exit/b
:Unicode24089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24089
exit/b
:Unicode24084
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24084
exit/b
:Unicode24081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24081
exit/b
:Unicode24113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24113
exit/b
:Unicode24123
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24123
exit/b
:Unicode24124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24124
exit/b
:Unicode24119
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24119
exit/b
:Unicode24132
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24132
exit/b
:Unicode24148
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24148
exit/b
:Unicode24155
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24155
exit/b
:Unicode24158
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24158
exit/b
:Unicode24161
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24161
exit/b
:Unicode23692
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23692
exit/b
:Unicode23674
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23674
exit/b
:Unicode23693
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23693
exit/b
:Unicode23696
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23696
exit/b
:Unicode23702
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23702
exit/b
:Unicode23688
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23688
exit/b
:Unicode23704
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23704
exit/b
:Unicode23705
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23705
exit/b
:Unicode23697
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23697
exit/b
:Unicode23706
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23706
exit/b
:Unicode23708
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23708
exit/b
:Unicode23733
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23733
exit/b
:Unicode23714
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23714
exit/b
:Unicode23741
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23741
exit/b
:Unicode23724
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23724
exit/b
:Unicode23723
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23723
exit/b
:Unicode23729
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23729
exit/b
:Unicode23715
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23715
exit/b
:Unicode23745
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23745
exit/b
:Unicode23735
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23735
exit/b
:Unicode23748
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23748
exit/b
:Unicode23762
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23762
exit/b
:Unicode23780
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23780
exit/b
:Unicode23755
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23755
exit/b
:Unicode23781
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23781
exit/b
:Unicode23810
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23810
exit/b
:Unicode23811
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23811
exit/b
:Unicode23847
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23847
exit/b
:Unicode23846
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23846
exit/b
:Unicode23854
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23854
exit/b
:Unicode23844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23844
exit/b
:Unicode23838
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23838
exit/b
:Unicode23814
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23814
exit/b
:Unicode23835
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23835
exit/b
:Unicode23896
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23896
exit/b
:Unicode23870
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23870
exit/b
:Unicode23860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23860
exit/b
:Unicode23869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23869
exit/b
:Unicode23916
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23916
exit/b
:Unicode23899
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23899
exit/b
:Unicode23919
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23919
exit/b
:Unicode23901
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23901
exit/b
:Unicode23915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23915
exit/b
:Unicode23883
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23883
exit/b
:Unicode23882
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23882
exit/b
:Unicode23913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23913
exit/b
:Unicode23924
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23924
exit/b
:Unicode23938
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23938
exit/b
:Unicode23961
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23961
exit/b
:Unicode23965
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23965
exit/b
:Unicode35955
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35955
exit/b
:Unicode23991
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23991
exit/b
:Unicode24005
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24005
exit/b
:Unicode24435
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24435
exit/b
:Unicode24439
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24439
exit/b
:Unicode24450
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24450
exit/b
:Unicode24455
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24455
exit/b
:Unicode24457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24457
exit/b
:Unicode24460
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24460
exit/b
:Unicode24469
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24469
exit/b
:Unicode24473
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24473
exit/b
:Unicode24476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24476
exit/b
:Unicode24488
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24488
exit/b
:Unicode29423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29423
exit/b
:Unicode29417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29417
exit/b
:Unicode29426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29426
exit/b
:Unicode29428
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29428
exit/b
:Unicode29431
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29431
exit/b
:Unicode29441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29441
exit/b
:Unicode29427
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29427
exit/b
:Unicode29443
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29443
exit/b
:Unicode29434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29434
exit/b
:Unicode29435
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29435
exit/b
:Unicode29463
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29463
exit/b
:Unicode29459
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29459
exit/b
:Unicode29473
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29473
exit/b
:Unicode29450
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29450
exit/b
:Unicode29470
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29470
exit/b
:Unicode29469
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29469
exit/b
:Unicode29461
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29461
exit/b
:Unicode29474
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29474
exit/b
:Unicode29497
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29497
exit/b
:Unicode29477
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29477
exit/b
:Unicode29484
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29484
exit/b
:Unicode29496
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29496
exit/b
:Unicode29489
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29489
exit/b
:Unicode29520
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29520
exit/b
:Unicode29517
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29517
exit/b
:Unicode29527
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29527
exit/b
:Unicode29536
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29536
exit/b
:Unicode29548
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29548
exit/b
:Unicode29551
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29551
exit/b
:Unicode29566
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29566
exit/b
:Unicode33307
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=33307
exit/b
:Unicode22821
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22821
exit/b
:Unicode39143
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39143
exit/b
:Unicode22820
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22820
exit/b
:Unicode22786
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22786
exit/b
:Unicode39267
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39267
exit/b
:Unicode39271
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39271
exit/b
:Unicode39272
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39272
exit/b
:Unicode39273
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39273
exit/b
:Unicode39274
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39274
exit/b
:Unicode39275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39275
exit/b
:Unicode39276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39276
exit/b
:Unicode39284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39284
exit/b
:Unicode39287
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39287
exit/b
:Unicode39293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39293
exit/b
:Unicode39296
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39296
exit/b
:Unicode39300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39300
exit/b
:Unicode39303
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39303
exit/b
:Unicode39306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39306
exit/b
:Unicode39309
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39309
exit/b
:Unicode39312
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39312
exit/b
:Unicode39313
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39313
exit/b
:Unicode39315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39315
exit/b
:Unicode39316
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39316
exit/b
:Unicode39317
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39317
exit/b
:Unicode24192
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24192
exit/b
:Unicode24209
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24209
exit/b
:Unicode24203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24203
exit/b
:Unicode24214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24214
exit/b
:Unicode24229
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24229
exit/b
:Unicode24224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24224
exit/b
:Unicode24249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24249
exit/b
:Unicode24245
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24245
exit/b
:Unicode24254
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24254
exit/b
:Unicode24243
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24243
exit/b
:Unicode36179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36179
exit/b
:Unicode24274
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24274
exit/b
:Unicode24273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24273
exit/b
:Unicode24283
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24283
exit/b
:Unicode24296
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24296
exit/b
:Unicode24298
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24298
exit/b
:Unicode33210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33210
exit/b
:Unicode24516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24516
exit/b
:Unicode24521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24521
exit/b
:Unicode24534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24534
exit/b
:Unicode24527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24527
exit/b
:Unicode24579
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24579
exit/b
:Unicode24558
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24558
exit/b
:Unicode24580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24580
exit/b
:Unicode24545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24545
exit/b
:Unicode24548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24548
exit/b
:Unicode24574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24574
exit/b
:Unicode24581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24581
exit/b
:Unicode24582
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24582
exit/b
:Unicode24554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24554
exit/b
:Unicode24557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24557
exit/b
:Unicode24568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24568
exit/b
:Unicode24601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24601
exit/b
:Unicode24629
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24629
exit/b
:Unicode24614
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24614
exit/b
:Unicode24603
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24603
exit/b
:Unicode24591
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24591
exit/b
:Unicode24589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24589
exit/b
:Unicode24617
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24617
exit/b
:Unicode24619
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24619
exit/b
:Unicode24586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24586
exit/b
:Unicode24639
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24639
exit/b
:Unicode24609
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24609
exit/b
:Unicode24696
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24696
exit/b
:Unicode24697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24697
exit/b
:Unicode24699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24699
exit/b
:Unicode24698
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24698
exit/b
:Unicode24642
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24642
exit/b
:Unicode24682
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24682
exit/b
:Unicode24701
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24701
exit/b
:Unicode24726
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24726
exit/b
:Unicode24730
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24730
exit/b
:Unicode24749
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24749
exit/b
:Unicode24733
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24733
exit/b
:Unicode24707
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24707
exit/b
:Unicode24722
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24722
exit/b
:Unicode24716
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24716
exit/b
:Unicode24731
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24731
exit/b
:Unicode24812
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24812
exit/b
:Unicode24763
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24763
exit/b
:Unicode24753
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24753
exit/b
:Unicode24797
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24797
exit/b
:Unicode24792
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24792
exit/b
:Unicode24774
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24774
exit/b
:Unicode24794
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24794
exit/b
:Unicode24756
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24756
exit/b
:Unicode24864
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24864
exit/b
:Unicode24870
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24870
exit/b
:Unicode24853
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24853
exit/b
:Unicode24867
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24867
exit/b
:Unicode24820
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24820
exit/b
:Unicode24832
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24832
exit/b
:Unicode24846
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24846
exit/b
:Unicode24875
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24875
exit/b
:Unicode24906
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24906
exit/b
:Unicode24949
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24949
exit/b
:Unicode25004
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25004
exit/b
:Unicode24980
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24980
exit/b
:Unicode24999
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24999
exit/b
:Unicode25015
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25015
exit/b
:Unicode25044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25044
exit/b
:Unicode25077
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25077
exit/b
:Unicode24541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24541
exit/b
:Unicode38579
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38579
exit/b
:Unicode38377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38377
exit/b
:Unicode38379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38379
exit/b
:Unicode38385
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38385
exit/b
:Unicode38387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38387
exit/b
:Unicode38389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38389
exit/b
:Unicode38390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38390
exit/b
:Unicode38396
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38396
exit/b
:Unicode38398
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38398
exit/b
:Unicode38403
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38403
exit/b
:Unicode38404
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38404
exit/b
:Unicode38406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38406
exit/b
:Unicode38408
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38408
exit/b
:Unicode38410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38410
exit/b
:Unicode38411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38411
exit/b
:Unicode38412
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38412
exit/b
:Unicode38413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38413
exit/b
:Unicode38415
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38415
exit/b
:Unicode38418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38418
exit/b
:Unicode38421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38421
exit/b
:Unicode38422
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38422
exit/b
:Unicode38423
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38423
exit/b
:Unicode38425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38425
exit/b
:Unicode38426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38426
exit/b
:Unicode20012
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=20012
exit/b
:Unicode29247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29247
exit/b
:Unicode25109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25109
exit/b
:Unicode27701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27701
exit/b
:Unicode27732
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27732
exit/b
:Unicode27740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27740
exit/b
:Unicode27722
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27722
exit/b
:Unicode27811
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27811
exit/b
:Unicode27781
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27781
exit/b
:Unicode27792
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27792
exit/b
:Unicode27796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27796
exit/b
:Unicode27788
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27788
exit/b
:Unicode27752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27752
exit/b
:Unicode27753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27753
exit/b
:Unicode27764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27764
exit/b
:Unicode27766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27766
exit/b
:Unicode27782
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27782
exit/b
:Unicode27817
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27817
exit/b
:Unicode27856
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27856
exit/b
:Unicode27860
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27860
exit/b
:Unicode27821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27821
exit/b
:Unicode27895
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27895
exit/b
:Unicode27896
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27896
exit/b
:Unicode27889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27889
exit/b
:Unicode27863
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27863
exit/b
:Unicode27826
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27826
exit/b
:Unicode27872
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27872
exit/b
:Unicode27862
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27862
exit/b
:Unicode27898
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27898
exit/b
:Unicode27883
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27883
exit/b
:Unicode27886
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27886
exit/b
:Unicode27825
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27825
exit/b
:Unicode27859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27859
exit/b
:Unicode27887
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27887
exit/b
:Unicode27902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27902
exit/b
:Unicode27961
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27961
exit/b
:Unicode27943
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27943
exit/b
:Unicode27916
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27916
exit/b
:Unicode27971
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27971
exit/b
:Unicode27976
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27976
exit/b
:Unicode27911
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27911
exit/b
:Unicode27908
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27908
exit/b
:Unicode27929
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27929
exit/b
:Unicode27918
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27918
exit/b
:Unicode27947
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27947
exit/b
:Unicode27981
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27981
exit/b
:Unicode27950
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27950
exit/b
:Unicode27957
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27957
exit/b
:Unicode27930
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27930
exit/b
:Unicode27983
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27983
exit/b
:Unicode27986
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27986
exit/b
:Unicode27988
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27988
exit/b
:Unicode27955
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27955
exit/b
:Unicode28049
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28049
exit/b
:Unicode28015
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28015
exit/b
:Unicode28062
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28062
exit/b
:Unicode28064
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28064
exit/b
:Unicode27998
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27998
exit/b
:Unicode28051
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28051
exit/b
:Unicode28052
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28052
exit/b
:Unicode27996
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27996
exit/b
:Unicode28000
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28000
exit/b
:Unicode28028
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28028
exit/b
:Unicode28003
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28003
exit/b
:Unicode28186
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28186
exit/b
:Unicode28103
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28103
exit/b
:Unicode28101
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28101
exit/b
:Unicode28126
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28126
exit/b
:Unicode28174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28174
exit/b
:Unicode28095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28095
exit/b
:Unicode28128
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28128
exit/b
:Unicode28177
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28177
exit/b
:Unicode28134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28134
exit/b
:Unicode28125
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28125
exit/b
:Unicode28121
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28121
exit/b
:Unicode28182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28182
exit/b
:Unicode28075
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28075
exit/b
:Unicode28172
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28172
exit/b
:Unicode28078
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28078
exit/b
:Unicode28203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28203
exit/b
:Unicode28270
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28270
exit/b
:Unicode28238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28238
exit/b
:Unicode28267
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28267
exit/b
:Unicode28338
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28338
exit/b
:Unicode28255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28255
exit/b
:Unicode28294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28294
exit/b
:Unicode28243
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28243
exit/b
:Unicode28244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28244
exit/b
:Unicode28210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28210
exit/b
:Unicode28197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28197
exit/b
:Unicode28228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28228
exit/b
:Unicode28383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28383
exit/b
:Unicode28337
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28337
exit/b
:Unicode28312
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28312
exit/b
:Unicode28384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28384
exit/b
:Unicode28461
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28461
exit/b
:Unicode28386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28386
exit/b
:Unicode28325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28325
exit/b
:Unicode28327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28327
exit/b
:Unicode28349
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28349
exit/b
:Unicode28347
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28347
exit/b
:Unicode28343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28343
exit/b
:Unicode28375
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28375
exit/b
:Unicode28340
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28340
exit/b
:Unicode28367
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28367
exit/b
:Unicode28303
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28303
exit/b
:Unicode28354
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28354
exit/b
:Unicode28319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28319
exit/b
:Unicode28514
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28514
exit/b
:Unicode28486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28486
exit/b
:Unicode28487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28487
exit/b
:Unicode28452
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28452
exit/b
:Unicode28437
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28437
exit/b
:Unicode28409
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28409
exit/b
:Unicode28463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28463
exit/b
:Unicode28470
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28470
exit/b
:Unicode28491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28491
exit/b
:Unicode28532
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28532
exit/b
:Unicode28458
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28458
exit/b
:Unicode28425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28425
exit/b
:Unicode28457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28457
exit/b
:Unicode28553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28553
exit/b
:Unicode28557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28557
exit/b
:Unicode28556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28556
exit/b
:Unicode28536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28536
exit/b
:Unicode28530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28530
exit/b
:Unicode28540
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28540
exit/b
:Unicode28538
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28538
exit/b
:Unicode28625
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28625
exit/b
:Unicode28617
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28617
exit/b
:Unicode28583
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28583
exit/b
:Unicode28601
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28601
exit/b
:Unicode28598
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28598
exit/b
:Unicode28610
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28610
exit/b
:Unicode28641
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28641
exit/b
:Unicode28654
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28654
exit/b
:Unicode28638
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28638
exit/b
:Unicode28640
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28640
exit/b
:Unicode28655
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28655
exit/b
:Unicode28698
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28698
exit/b
:Unicode28707
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28707
exit/b
:Unicode28699
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28699
exit/b
:Unicode28729
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28729
exit/b
:Unicode28725
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28725
exit/b
:Unicode28751
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28751
exit/b
:Unicode28766
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28766
exit/b
:Unicode23424
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23424
exit/b
:Unicode23428
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23428
exit/b
:Unicode23445
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23445
exit/b
:Unicode23443
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23443
exit/b
:Unicode23461
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23461
exit/b
:Unicode23480
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23480
exit/b
:Unicode29999
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29999
exit/b
:Unicode39582
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39582
exit/b
:Unicode25652
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25652
exit/b
:Unicode23524
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23524
exit/b
:Unicode23534
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23534
exit/b
:Unicode35120
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=35120
exit/b
:Unicode23536
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23536
exit/b
:Unicode36423
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36423
exit/b
:Unicode35591
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35591
exit/b
:Unicode36790
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36790
exit/b
:Unicode36819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36819
exit/b
:Unicode36821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36821
exit/b
:Unicode36837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36837
exit/b
:Unicode36846
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36846
exit/b
:Unicode36836
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36836
exit/b
:Unicode36841
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36841
exit/b
:Unicode36838
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36838
exit/b
:Unicode36851
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36851
exit/b
:Unicode36840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36840
exit/b
:Unicode36869
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36869
exit/b
:Unicode36868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36868
exit/b
:Unicode36875
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36875
exit/b
:Unicode36902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36902
exit/b
:Unicode36881
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36881
exit/b
:Unicode36877
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36877
exit/b
:Unicode36886
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36886
exit/b
:Unicode36897
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36897
exit/b
:Unicode36917
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36917
exit/b
:Unicode36918
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36918
exit/b
:Unicode36909
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36909
exit/b
:Unicode36911
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36911
exit/b
:Unicode36932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36932
exit/b
:Unicode36945
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36945
exit/b
:Unicode36946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36946
exit/b
:Unicode36944
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36944
exit/b
:Unicode36968
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36968
exit/b
:Unicode36952
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36952
exit/b
:Unicode36962
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36962
exit/b
:Unicode36955
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36955
exit/b
:Unicode26297
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26297
exit/b
:Unicode36980
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36980
exit/b
:Unicode36989
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36989
exit/b
:Unicode36994
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36994
exit/b
:Unicode37000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37000
exit/b
:Unicode36995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36995
exit/b
:Unicode37003
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37003
exit/b
:Unicode24400
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24400
exit/b
:Unicode24407
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24407
exit/b
:Unicode24406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24406
exit/b
:Unicode24408
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24408
exit/b
:Unicode23611
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23611
exit/b
:Unicode21675
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=21675
exit/b
:Unicode23632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23632
exit/b
:Unicode23641
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23641
exit/b
:Unicode23409
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23409
exit/b
:Unicode23651
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23651
exit/b
:Unicode23654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23654
exit/b
:Unicode32700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32700
exit/b
:Unicode24362
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24362
exit/b
:Unicode24361
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24361
exit/b
:Unicode24365
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24365
exit/b
:Unicode33396
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33396
exit/b
:Unicode24380
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24380
exit/b
:Unicode39739
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39739
exit/b
:Unicode23662
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23662
exit/b
:Unicode22913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22913
exit/b
:Unicode22915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22915
exit/b
:Unicode22925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22925
exit/b
:Unicode22953
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22953
exit/b
:Unicode22954
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22954
exit/b
:Unicode22947
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22947
exit/b
:Unicode22935
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22935
exit/b
:Unicode22986
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22986
exit/b
:Unicode22955
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22955
exit/b
:Unicode22942
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22942
exit/b
:Unicode22948
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22948
exit/b
:Unicode22994
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22994
exit/b
:Unicode22962
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22962
exit/b
:Unicode22959
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22959
exit/b
:Unicode22999
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22999
exit/b
:Unicode22974
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=22974
exit/b
:Unicode23045
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23045
exit/b
:Unicode23046
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23046
exit/b
:Unicode23005
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23005
exit/b
:Unicode23048
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23048
exit/b
:Unicode23011
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23011
exit/b
:Unicode23000
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23000
exit/b
:Unicode23033
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23033
exit/b
:Unicode23052
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23052
exit/b
:Unicode23049
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23049
exit/b
:Unicode23090
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23090
exit/b
:Unicode23092
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23092
exit/b
:Unicode23057
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23057
exit/b
:Unicode23075
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23075
exit/b
:Unicode23059
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23059
exit/b
:Unicode23104
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23104
exit/b
:Unicode23143
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23143
exit/b
:Unicode23114
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23114
exit/b
:Unicode23125
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23125
exit/b
:Unicode23100
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23100
exit/b
:Unicode23138
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23138
exit/b
:Unicode23157
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=23157
exit/b
:Unicode33004
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33004
exit/b
:Unicode23210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23210
exit/b
:Unicode23195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23195
exit/b
:Unicode23159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23159
exit/b
:Unicode23162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23162
exit/b
:Unicode23230
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23230
exit/b
:Unicode23275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23275
exit/b
:Unicode23218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23218
exit/b
:Unicode23250
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23250
exit/b
:Unicode23252
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23252
exit/b
:Unicode23224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23224
exit/b
:Unicode23264
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23264
exit/b
:Unicode23267
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23267
exit/b
:Unicode23281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23281
exit/b
:Unicode23254
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23254
exit/b
:Unicode23270
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23270
exit/b
:Unicode23256
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23256
exit/b
:Unicode23260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23260
exit/b
:Unicode23305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23305
exit/b
:Unicode23319
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23319
exit/b
:Unicode23318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23318
exit/b
:Unicode23346
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23346
exit/b
:Unicode23351
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23351
exit/b
:Unicode23360
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23360
exit/b
:Unicode23573
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23573
exit/b
:Unicode23580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23580
exit/b
:Unicode23386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23386
exit/b
:Unicode23397
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23397
exit/b
:Unicode23411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23411
exit/b
:Unicode23377
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23377
exit/b
:Unicode23379
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23379
exit/b
:Unicode23394
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23394
exit/b
:Unicode39541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39541
exit/b
:Unicode39543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39543
exit/b
:Unicode39544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39544
exit/b
:Unicode39546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39546
exit/b
:Unicode39551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39551
exit/b
:Unicode39549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39549
exit/b
:Unicode39552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39552
exit/b
:Unicode39553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39553
exit/b
:Unicode39557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39557
exit/b
:Unicode39560
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39560
exit/b
:Unicode39562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39562
exit/b
:Unicode39568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39568
exit/b
:Unicode39570
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39570
exit/b
:Unicode39571
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39571
exit/b
:Unicode39574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39574
exit/b
:Unicode39576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39576
exit/b
:Unicode39579
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39579
exit/b
:Unicode39580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39580
exit/b
:Unicode39581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39581
exit/b
:Unicode39583
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39583
exit/b
:Unicode39584
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39584
exit/b
:Unicode39586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39586
exit/b
:Unicode39587
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39587
exit/b
:Unicode39589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39589
exit/b
:Unicode39591
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39591
exit/b
:Unicode32415
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32415
exit/b
:Unicode32417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32417
exit/b
:Unicode32419
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32419
exit/b
:Unicode32421
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32421
exit/b
:Unicode32424
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32424
exit/b
:Unicode32425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32425
exit/b
:Unicode32429
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32429
exit/b
:Unicode32432
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32432
exit/b
:Unicode32446
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32446
exit/b
:Unicode32448
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32448
exit/b
:Unicode32449
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32449
exit/b
:Unicode32450
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32450
exit/b
:Unicode32457
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32457
exit/b
:Unicode32459
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32459
exit/b
:Unicode32460
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32460
exit/b
:Unicode32464
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32464
exit/b
:Unicode32468
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32468
exit/b
:Unicode32471
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32471
exit/b
:Unicode32475
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32475
exit/b
:Unicode32480
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32480
exit/b
:Unicode32481
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32481
exit/b
:Unicode32488
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32488
exit/b
:Unicode32491
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32491
exit/b
:Unicode32494
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32494
exit/b
:Unicode32495
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32495
exit/b
:Unicode32497
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32497
exit/b
:Unicode32498
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32498
exit/b
:Unicode32525
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32525
exit/b
:Unicode32502
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32502
exit/b
:Unicode32506
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32506
exit/b
:Unicode32507
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32507
exit/b
:Unicode32510
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32510
exit/b
:Unicode32513
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32513
exit/b
:Unicode32514
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32514
exit/b
:Unicode32515
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32515
exit/b
:Unicode32519
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32519
exit/b
:Unicode32520
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32520
exit/b
:Unicode32523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32523
exit/b
:Unicode32524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32524
exit/b
:Unicode32527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32527
exit/b
:Unicode32529
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32529
exit/b
:Unicode32530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32530
exit/b
:Unicode32535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32535
exit/b
:Unicode32537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32537
exit/b
:Unicode32540
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32540
exit/b
:Unicode32539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32539
exit/b
:Unicode32543
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32543
exit/b
:Unicode32545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32545
exit/b
:Unicode32546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32546
exit/b
:Unicode32547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32547
exit/b
:Unicode32548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32548
exit/b
:Unicode32549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32549
exit/b
:Unicode32550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32550
exit/b
:Unicode32551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32551
exit/b
:Unicode32554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32554
exit/b
:Unicode32555
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32555
exit/b
:Unicode32556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32556
exit/b
:Unicode32557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32557
exit/b
:Unicode32559
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32559
exit/b
:Unicode32560
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32560
exit/b
:Unicode32561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32561
exit/b
:Unicode32562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32562
exit/b
:Unicode32563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32563
exit/b
:Unicode32565
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32565
exit/b
:Unicode24186
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24186
exit/b
:Unicode30079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30079
exit/b
:Unicode24027
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24027
exit/b
:Unicode30014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30014
exit/b
:Unicode37013
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37013
exit/b
:Unicode29582
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29582
exit/b
:Unicode29585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29585
exit/b
:Unicode29614
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29614
exit/b
:Unicode29602
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29602
exit/b
:Unicode29599
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29599
exit/b
:Unicode29647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29647
exit/b
:Unicode29634
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29634
exit/b
:Unicode29649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29649
exit/b
:Unicode29623
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29623
exit/b
:Unicode29619
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29619
exit/b
:Unicode29632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29632
exit/b
:Unicode29641
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29641
exit/b
:Unicode29640
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29640
exit/b
:Unicode29669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29669
exit/b
:Unicode29657
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29657
exit/b
:Unicode39036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39036
exit/b
:Unicode29706
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29706
exit/b
:Unicode29673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29673
exit/b
:Unicode29671
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29671
exit/b
:Unicode29662
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29662
exit/b
:Unicode29626
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29626
exit/b
:Unicode29682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29682
exit/b
:Unicode29711
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29711
exit/b
:Unicode29738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29738
exit/b
:Unicode29787
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29787
exit/b
:Unicode29734
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29734
exit/b
:Unicode29733
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29733
exit/b
:Unicode29736
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29736
exit/b
:Unicode29744
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29744
exit/b
:Unicode29742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29742
exit/b
:Unicode29740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29740
exit/b
:Unicode29723
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29723
exit/b
:Unicode29722
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29722
exit/b
:Unicode29761
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29761
exit/b
:Unicode29788
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29788
exit/b
:Unicode29783
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29783
exit/b
:Unicode29781
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29781
exit/b
:Unicode29785
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29785
exit/b
:Unicode29815
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29815
exit/b
:Unicode29805
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29805
exit/b
:Unicode29822
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29822
exit/b
:Unicode29852
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29852
exit/b
:Unicode29838
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29838
exit/b
:Unicode29824
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29824
exit/b
:Unicode29825
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29825
exit/b
:Unicode29831
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29831
exit/b
:Unicode29835
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29835
exit/b
:Unicode29854
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29854
exit/b
:Unicode29864
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29864
exit/b
:Unicode29865
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29865
exit/b
:Unicode29840
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29840
exit/b
:Unicode29863
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29863
exit/b
:Unicode29906
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29906
exit/b
:Unicode29882
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29882
exit/b
:Unicode38890
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38890
exit/b
:Unicode38891
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38891
exit/b
:Unicode38892
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38892
exit/b
:Unicode26444
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26444
exit/b
:Unicode26451
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26451
exit/b
:Unicode26462
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26462
exit/b
:Unicode26440
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26440
exit/b
:Unicode26473
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26473
exit/b
:Unicode26533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26533
exit/b
:Unicode26503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26503
exit/b
:Unicode26474
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26474
exit/b
:Unicode26483
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26483
exit/b
:Unicode26520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26520
exit/b
:Unicode26535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26535
exit/b
:Unicode26485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26485
exit/b
:Unicode26536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26536
exit/b
:Unicode26526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26526
exit/b
:Unicode26541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26541
exit/b
:Unicode26507
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26507
exit/b
:Unicode26487
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26487
exit/b
:Unicode26492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26492
exit/b
:Unicode26608
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26608
exit/b
:Unicode26633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26633
exit/b
:Unicode26584
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26584
exit/b
:Unicode26634
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26634
exit/b
:Unicode26601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26601
exit/b
:Unicode26544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26544
exit/b
:Unicode26636
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26636
exit/b
:Unicode26585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26585
exit/b
:Unicode26549
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26549
exit/b
:Unicode26586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26586
exit/b
:Unicode26547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26547
exit/b
:Unicode26589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26589
exit/b
:Unicode26624
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26624
exit/b
:Unicode26563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26563
exit/b
:Unicode26552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26552
exit/b
:Unicode26594
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26594
exit/b
:Unicode26638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26638
exit/b
:Unicode26561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26561
exit/b
:Unicode26621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26621
exit/b
:Unicode26674
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26674
exit/b
:Unicode26675
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26675
exit/b
:Unicode26720
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26720
exit/b
:Unicode26721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26721
exit/b
:Unicode26702
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26702
exit/b
:Unicode26722
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26722
exit/b
:Unicode26692
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26692
exit/b
:Unicode26724
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26724
exit/b
:Unicode26755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26755
exit/b
:Unicode26653
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26653
exit/b
:Unicode26709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26709
exit/b
:Unicode26726
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26726
exit/b
:Unicode26689
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26689
exit/b
:Unicode26727
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26727
exit/b
:Unicode26688
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26688
exit/b
:Unicode26686
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26686
exit/b
:Unicode26698
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26698
exit/b
:Unicode26697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26697
exit/b
:Unicode26665
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26665
exit/b
:Unicode26805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26805
exit/b
:Unicode26767
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26767
exit/b
:Unicode26740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26740
exit/b
:Unicode26743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26743
exit/b
:Unicode26771
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26771
exit/b
:Unicode26731
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26731
exit/b
:Unicode26818
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26818
exit/b
:Unicode26990
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26990
exit/b
:Unicode26876
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26876
exit/b
:Unicode26911
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26911
exit/b
:Unicode26912
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26912
exit/b
:Unicode26873
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26873
exit/b
:Unicode26916
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26916
exit/b
:Unicode26864
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26864
exit/b
:Unicode26891
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26891
exit/b
:Unicode26881
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26881
exit/b
:Unicode26967
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26967
exit/b
:Unicode26851
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26851
exit/b
:Unicode26896
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26896
exit/b
:Unicode26993
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26993
exit/b
:Unicode26937
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26937
exit/b
:Unicode26976
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26976
exit/b
:Unicode26946
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26946
exit/b
:Unicode26973
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26973
exit/b
:Unicode27012
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27012
exit/b
:Unicode26987
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26987
exit/b
:Unicode27008
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27008
exit/b
:Unicode27032
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27032
exit/b
:Unicode27000
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27000
exit/b
:Unicode26932
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26932
exit/b
:Unicode27084
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27084
exit/b
:Unicode27015
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27015
exit/b
:Unicode27016
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27016
exit/b
:Unicode27086
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27086
exit/b
:Unicode27017
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27017
exit/b
:Unicode26982
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26982
exit/b
:Unicode26979
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26979
exit/b
:Unicode27001
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27001
exit/b
:Unicode27035
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27035
exit/b
:Unicode27047
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27047
exit/b
:Unicode27067
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27067
exit/b
:Unicode27051
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27051
exit/b
:Unicode27053
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27053
exit/b
:Unicode27092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27092
exit/b
:Unicode27057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27057
exit/b
:Unicode27073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27073
exit/b
:Unicode27082
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27082
exit/b
:Unicode27103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27103
exit/b
:Unicode27029
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27029
exit/b
:Unicode27104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27104
exit/b
:Unicode27021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27021
exit/b
:Unicode27135
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27135
exit/b
:Unicode27183
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27183
exit/b
:Unicode27117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27117
exit/b
:Unicode27159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27159
exit/b
:Unicode27160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27160
exit/b
:Unicode27237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27237
exit/b
:Unicode27122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27122
exit/b
:Unicode27204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27204
exit/b
:Unicode27198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27198
exit/b
:Unicode27296
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27296
exit/b
:Unicode27216
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27216
exit/b
:Unicode27227
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27227
exit/b
:Unicode27189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27189
exit/b
:Unicode27278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27278
exit/b
:Unicode27257
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27257
exit/b
:Unicode27197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27197
exit/b
:Unicode27176
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27176
exit/b
:Unicode27224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27224
exit/b
:Unicode27260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27260
exit/b
:Unicode27281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27281
exit/b
:Unicode27280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27280
exit/b
:Unicode27305
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27305
exit/b
:Unicode27287
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27287
exit/b
:Unicode27307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27307
exit/b
:Unicode29495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29495
exit/b
:Unicode29522
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29522
exit/b
:Unicode27521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27521
exit/b
:Unicode27522
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27522
exit/b
:Unicode27527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27527
exit/b
:Unicode27524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27524
exit/b
:Unicode27538
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27538
exit/b
:Unicode27539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27539
exit/b
:Unicode27533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27533
exit/b
:Unicode27546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27546
exit/b
:Unicode27547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27547
exit/b
:Unicode27553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27553
exit/b
:Unicode27562
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=27562
exit/b
:Unicode36715
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36715
exit/b
:Unicode36717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36717
exit/b
:Unicode36721
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36721
exit/b
:Unicode36722
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36722
exit/b
:Unicode36723
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36723
exit/b
:Unicode36725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36725
exit/b
:Unicode36726
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36726
exit/b
:Unicode36728
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36728
exit/b
:Unicode36727
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36727
exit/b
:Unicode36729
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36729
exit/b
:Unicode36730
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36730
exit/b
:Unicode36732
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36732
exit/b
:Unicode36734
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36734
exit/b
:Unicode36737
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36737
exit/b
:Unicode36738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36738
exit/b
:Unicode36740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36740
exit/b
:Unicode36743
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36743
exit/b
:Unicode36747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36747
exit/b
:Unicode36749
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36749
exit/b
:Unicode36750
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36750
exit/b
:Unicode36751
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36751
exit/b
:Unicode36760
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36760
exit/b
:Unicode36762
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36762
exit/b
:Unicode36558
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=36558
exit/b
:Unicode25099
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25099
exit/b
:Unicode25111
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25111
exit/b
:Unicode25115
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25115
exit/b
:Unicode25119
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25119
exit/b
:Unicode25122
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25122
exit/b
:Unicode25121
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25121
exit/b
:Unicode25125
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25125
exit/b
:Unicode25124
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25124
exit/b
:Unicode25132
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25132
exit/b
:Unicode33255
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=33255
exit/b
:Unicode29935
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29935
exit/b
:Unicode29940
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29940
exit/b
:Unicode29951
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29951
exit/b
:Unicode29967
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29967
exit/b
:Unicode29969
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29969
exit/b
:Unicode29971
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29971
exit/b
:Unicode25908
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25908
exit/b
:Unicode26094
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26094
exit/b
:Unicode26095
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26095
exit/b
:Unicode26096
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26096
exit/b
:Unicode26122
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26122
exit/b
:Unicode26137
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26137
exit/b
:Unicode26482
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26482
exit/b
:Unicode26115
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26115
exit/b
:Unicode26133
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26133
exit/b
:Unicode26112
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26112
exit/b
:Unicode28805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28805
exit/b
:Unicode26359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26359
exit/b
:Unicode26141
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26141
exit/b
:Unicode26269
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26269
exit/b
:Unicode26302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26302
exit/b
:Unicode26331
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26331
exit/b
:Unicode26332
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26332
exit/b
:Unicode26342
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26342
exit/b
:Unicode26345
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26345
exit/b
:Unicode36146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36146
exit/b
:Unicode36147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36147
exit/b
:Unicode36150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36150
exit/b
:Unicode36155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36155
exit/b
:Unicode36157
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36157
exit/b
:Unicode36160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36160
exit/b
:Unicode36165
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36165
exit/b
:Unicode36166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36166
exit/b
:Unicode36168
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36168
exit/b
:Unicode36169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36169
exit/b
:Unicode36167
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36167
exit/b
:Unicode36173
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36173
exit/b
:Unicode36181
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36181
exit/b
:Unicode36185
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36185
exit/b
:Unicode35271
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35271
exit/b
:Unicode35274
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35274
exit/b
:Unicode35275
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35275
exit/b
:Unicode35276
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35276
exit/b
:Unicode35278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35278
exit/b
:Unicode35279
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35279
exit/b
:Unicode35280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35280
exit/b
:Unicode35281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35281
exit/b
:Unicode29294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29294
exit/b
:Unicode29343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29343
exit/b
:Unicode29277
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29277
exit/b
:Unicode29286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29286
exit/b
:Unicode29295
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29295
exit/b
:Unicode29310
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29310
exit/b
:Unicode29311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29311
exit/b
:Unicode29316
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29316
exit/b
:Unicode29323
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29323
exit/b
:Unicode29325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29325
exit/b
:Unicode29327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29327
exit/b
:Unicode29330
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29330
exit/b
:Unicode25352
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25352
exit/b
:Unicode25394
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25394
exit/b
:Unicode25520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25520
exit/b
:Unicode25663
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25663
exit/b
:Unicode25816
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25816
exit/b
:Unicode32772
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32772
exit/b
:Unicode27626
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27626
exit/b
:Unicode27635
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27635
exit/b
:Unicode27645
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27645
exit/b
:Unicode27637
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27637
exit/b
:Unicode27641
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27641
exit/b
:Unicode27653
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27653
exit/b
:Unicode27655
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27655
exit/b
:Unicode27654
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27654
exit/b
:Unicode27661
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27661
exit/b
:Unicode27669
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27669
exit/b
:Unicode27672
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27672
exit/b
:Unicode27673
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27673
exit/b
:Unicode27674
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27674
exit/b
:Unicode27681
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27681
exit/b
:Unicode27689
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27689
exit/b
:Unicode27684
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27684
exit/b
:Unicode27690
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27690
exit/b
:Unicode27698
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27698
exit/b
:Unicode25909
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25909
exit/b
:Unicode25941
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25941
exit/b
:Unicode25963
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25963
exit/b
:Unicode29261
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29261
exit/b
:Unicode29266
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29266
exit/b
:Unicode29270
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29270
exit/b
:Unicode29232
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29232
exit/b
:Unicode34402
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34402
exit/b
:Unicode21014
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=21014
exit/b
:Unicode32927
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32927
exit/b
:Unicode32924
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32924
exit/b
:Unicode32915
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32915
exit/b
:Unicode32956
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32956
exit/b
:Unicode26378
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26378
exit/b
:Unicode32957
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32957
exit/b
:Unicode32945
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32945
exit/b
:Unicode32939
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32939
exit/b
:Unicode32941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32941
exit/b
:Unicode32948
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32948
exit/b
:Unicode32951
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32951
exit/b
:Unicode32999
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32999
exit/b
:Unicode33000
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33000
exit/b
:Unicode33001
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33001
exit/b
:Unicode33002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33002
exit/b
:Unicode32987
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32987
exit/b
:Unicode32962
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32962
exit/b
:Unicode32964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32964
exit/b
:Unicode32985
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32985
exit/b
:Unicode32973
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32973
exit/b
:Unicode32983
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32983
exit/b
:Unicode26384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26384
exit/b
:Unicode32989
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32989
exit/b
:Unicode33003
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33003
exit/b
:Unicode33009
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33009
exit/b
:Unicode33012
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33012
exit/b
:Unicode33005
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33005
exit/b
:Unicode33037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33037
exit/b
:Unicode33038
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33038
exit/b
:Unicode33010
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33010
exit/b
:Unicode33020
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33020
exit/b
:Unicode26389
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26389
exit/b
:Unicode33042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33042
exit/b
:Unicode35930
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35930
exit/b
:Unicode33078
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33078
exit/b
:Unicode33054
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33054
exit/b
:Unicode33068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33068
exit/b
:Unicode33048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33048
exit/b
:Unicode33074
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33074
exit/b
:Unicode33096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33096
exit/b
:Unicode33100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33100
exit/b
:Unicode33107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33107
exit/b
:Unicode33140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33140
exit/b
:Unicode33113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33113
exit/b
:Unicode33114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33114
exit/b
:Unicode33137
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33137
exit/b
:Unicode33120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33120
exit/b
:Unicode33129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33129
exit/b
:Unicode33148
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33148
exit/b
:Unicode33149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33149
exit/b
:Unicode33133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33133
exit/b
:Unicode33127
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33127
exit/b
:Unicode22605
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=22605
exit/b
:Unicode23221
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23221
exit/b
:Unicode33160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33160
exit/b
:Unicode33154
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33154
exit/b
:Unicode33169
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33169
exit/b
:Unicode28373
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28373
exit/b
:Unicode33187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33187
exit/b
:Unicode33194
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33194
exit/b
:Unicode33228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33228
exit/b
:Unicode26406
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26406
exit/b
:Unicode33226
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33226
exit/b
:Unicode33211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33211
exit/b
:Unicode33217
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=33217
exit/b
:Unicode33190
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=33190
exit/b
:Unicode27428
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27428
exit/b
:Unicode27447
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27447
exit/b
:Unicode27449
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27449
exit/b
:Unicode27459
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27459
exit/b
:Unicode27462
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27462
exit/b
:Unicode27481
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27481
exit/b
:Unicode39121
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39121
exit/b
:Unicode39122
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39122
exit/b
:Unicode39123
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39123
exit/b
:Unicode39125
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39125
exit/b
:Unicode39129
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39129
exit/b
:Unicode39130
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39130
exit/b
:Unicode27571
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27571
exit/b
:Unicode24384
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24384
exit/b
:Unicode27586
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27586
exit/b
:Unicode35315
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=35315
exit/b
:Unicode26000
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26000
exit/b
:Unicode40785
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40785
exit/b
:Unicode26003
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26003
exit/b
:Unicode26044
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26044
exit/b
:Unicode26054
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26054
exit/b
:Unicode26052
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26052
exit/b
:Unicode26051
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26051
exit/b
:Unicode26060
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26060
exit/b
:Unicode26062
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26062
exit/b
:Unicode26066
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26066
exit/b
:Unicode26070
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26070
exit/b
:Unicode28800
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28800
exit/b
:Unicode28828
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28828
exit/b
:Unicode28822
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28822
exit/b
:Unicode28829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28829
exit/b
:Unicode28859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28859
exit/b
:Unicode28864
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28864
exit/b
:Unicode28855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28855
exit/b
:Unicode28843
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28843
exit/b
:Unicode28849
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28849
exit/b
:Unicode28904
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28904
exit/b
:Unicode28874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28874
exit/b
:Unicode28944
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28944
exit/b
:Unicode28947
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28947
exit/b
:Unicode28950
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28950
exit/b
:Unicode28975
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28975
exit/b
:Unicode28977
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28977
exit/b
:Unicode29043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29043
exit/b
:Unicode29020
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29020
exit/b
:Unicode29032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29032
exit/b
:Unicode28997
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28997
exit/b
:Unicode29042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29042
exit/b
:Unicode29002
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29002
exit/b
:Unicode29048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29048
exit/b
:Unicode29050
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29050
exit/b
:Unicode29080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29080
exit/b
:Unicode29107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29107
exit/b
:Unicode29109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29109
exit/b
:Unicode29096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29096
exit/b
:Unicode29088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29088
exit/b
:Unicode29152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29152
exit/b
:Unicode29140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29140
exit/b
:Unicode29159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29159
exit/b
:Unicode29177
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29177
exit/b
:Unicode29213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29213
exit/b
:Unicode29224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29224
exit/b
:Unicode28780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28780
exit/b
:Unicode28952
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=28952
exit/b
:Unicode29030
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29030
exit/b
:Unicode29113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=29113
exit/b
:Unicode25150
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25150
exit/b
:Unicode25149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25149
exit/b
:Unicode25155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25155
exit/b
:Unicode25160
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25160
exit/b
:Unicode25161
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25161
exit/b
:Unicode31035
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31035
exit/b
:Unicode31040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31040
exit/b
:Unicode31046
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31046
exit/b
:Unicode31049
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31049
exit/b
:Unicode31067
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31067
exit/b
:Unicode31068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31068
exit/b
:Unicode31059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31059
exit/b
:Unicode31066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31066
exit/b
:Unicode31074
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31074
exit/b
:Unicode31063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31063
exit/b
:Unicode31072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31072
exit/b
:Unicode31087
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31087
exit/b
:Unicode31079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31079
exit/b
:Unicode31098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31098
exit/b
:Unicode31109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31109
exit/b
:Unicode31114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31114
exit/b
:Unicode31130
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31130
exit/b
:Unicode31143
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31143
exit/b
:Unicode31155
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31155
exit/b
:Unicode24529
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24529
exit/b
:Unicode24528
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=24528
exit/b
:Unicode24636
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24636
exit/b
:Unicode24669
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24669
exit/b
:Unicode24666
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24666
exit/b
:Unicode24679
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24679
exit/b
:Unicode24641
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24641
exit/b
:Unicode24665
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24665
exit/b
:Unicode24675
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24675
exit/b
:Unicode24747
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24747
exit/b
:Unicode24838
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24838
exit/b
:Unicode24845
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24845
exit/b
:Unicode24925
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24925
exit/b
:Unicode25001
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25001
exit/b
:Unicode24989
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=24989
exit/b
:Unicode25035
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25035
exit/b
:Unicode25041
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25041
exit/b
:Unicode25094
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=25094
exit/b
:Unicode32896
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32896
exit/b
:Unicode32895
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32895
exit/b
:Unicode27795
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27795
exit/b
:Unicode27894
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=27894
exit/b
:Unicode28156
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=28156
exit/b
:Unicode30710
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30710
exit/b
:Unicode30712
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30712
exit/b
:Unicode30720
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30720
exit/b
:Unicode30729
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30729
exit/b
:Unicode30743
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30743
exit/b
:Unicode30744
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30744
exit/b
:Unicode30737
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30737
exit/b
:Unicode26027
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=26027
exit/b
:Unicode30765
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30765
exit/b
:Unicode30748
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30748
exit/b
:Unicode30749
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30749
exit/b
:Unicode30777
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30777
exit/b
:Unicode30778
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30778
exit/b
:Unicode30779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30779
exit/b
:Unicode30751
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30751
exit/b
:Unicode30780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30780
exit/b
:Unicode30757
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30757
exit/b
:Unicode30764
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30764
exit/b
:Unicode30755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30755
exit/b
:Unicode30761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30761
exit/b
:Unicode30798
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30798
exit/b
:Unicode30829
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30829
exit/b
:Unicode30806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30806
exit/b
:Unicode30807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30807
exit/b
:Unicode30758
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30758
exit/b
:Unicode30800
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30800
exit/b
:Unicode30791
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30791
exit/b
:Unicode30796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30796
exit/b
:Unicode30826
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30826
exit/b
:Unicode30875
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30875
exit/b
:Unicode30867
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30867
exit/b
:Unicode30874
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30874
exit/b
:Unicode30855
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30855
exit/b
:Unicode30876
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30876
exit/b
:Unicode30881
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30881
exit/b
:Unicode30883
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30883
exit/b
:Unicode30898
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30898
exit/b
:Unicode30905
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30905
exit/b
:Unicode30885
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30885
exit/b
:Unicode30932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30932
exit/b
:Unicode30937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30937
exit/b
:Unicode30921
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30921
exit/b
:Unicode30956
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30956
exit/b
:Unicode30962
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30962
exit/b
:Unicode30981
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30981
exit/b
:Unicode30964
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30964
exit/b
:Unicode30995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30995
exit/b
:Unicode31012
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31012
exit/b
:Unicode31006
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31006
exit/b
:Unicode31028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31028
exit/b
:Unicode40859
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40859
exit/b
:Unicode40697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40697
exit/b
:Unicode40699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40699
exit/b
:Unicode40700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40700
exit/b
:Unicode30449
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30449
exit/b
:Unicode30468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30468
exit/b
:Unicode30477
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30477
exit/b
:Unicode30457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30457
exit/b
:Unicode30471
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30471
exit/b
:Unicode30472
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30472
exit/b
:Unicode30490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30490
exit/b
:Unicode30498
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30498
exit/b
:Unicode30489
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30489
exit/b
:Unicode30509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30509
exit/b
:Unicode30502
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30502
exit/b
:Unicode30517
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30517
exit/b
:Unicode30520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30520
exit/b
:Unicode30544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30544
exit/b
:Unicode30545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30545
exit/b
:Unicode30535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30535
exit/b
:Unicode30531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30531
exit/b
:Unicode30554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30554
exit/b
:Unicode30568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30568
exit/b
:Unicode30562
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30562
exit/b
:Unicode30565
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30565
exit/b
:Unicode30591
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30591
exit/b
:Unicode30605
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30605
exit/b
:Unicode30589
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30589
exit/b
:Unicode30592
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30592
exit/b
:Unicode30604
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30604
exit/b
:Unicode30609
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30609
exit/b
:Unicode30623
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30623
exit/b
:Unicode30624
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30624
exit/b
:Unicode30640
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30640
exit/b
:Unicode30645
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30645
exit/b
:Unicode30653
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30653
exit/b
:Unicode30010
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30010
exit/b
:Unicode30016
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30016
exit/b
:Unicode30030
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30030
exit/b
:Unicode30027
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30027
exit/b
:Unicode30024
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30024
exit/b
:Unicode30043
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30043
exit/b
:Unicode30066
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30066
exit/b
:Unicode30073
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30073
exit/b
:Unicode30083
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30083
exit/b
:Unicode32600
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32600
exit/b
:Unicode32609
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32609
exit/b
:Unicode32607
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32607
exit/b
:Unicode35400
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=35400
exit/b
:Unicode32616
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32616
exit/b
:Unicode32628
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32628
exit/b
:Unicode32625
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32625
exit/b
:Unicode32633
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32633
exit/b
:Unicode32641
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32641
exit/b
:Unicode32638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32638
exit/b
:Unicode30413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30413
exit/b
:Unicode30437
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30437
exit/b
:Unicode34866
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34866
exit/b
:Unicode38021
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38021
exit/b
:Unicode38022
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38022
exit/b
:Unicode38023
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38023
exit/b
:Unicode38027
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38027
exit/b
:Unicode38026
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38026
exit/b
:Unicode38028
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38028
exit/b
:Unicode38029
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38029
exit/b
:Unicode38031
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38031
exit/b
:Unicode38032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38032
exit/b
:Unicode38036
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38036
exit/b
:Unicode38039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38039
exit/b
:Unicode38037
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38037
exit/b
:Unicode38042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38042
exit/b
:Unicode38043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38043
exit/b
:Unicode38044
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38044
exit/b
:Unicode38051
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38051
exit/b
:Unicode38052
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38052
exit/b
:Unicode38059
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38059
exit/b
:Unicode38058
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38058
exit/b
:Unicode38061
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38061
exit/b
:Unicode38060
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38060
exit/b
:Unicode38063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38063
exit/b
:Unicode38064
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38064
exit/b
:Unicode38066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38066
exit/b
:Unicode38068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38068
exit/b
:Unicode38070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38070
exit/b
:Unicode38071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38071
exit/b
:Unicode38072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38072
exit/b
:Unicode38073
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38073
exit/b
:Unicode38074
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38074
exit/b
:Unicode38076
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38076
exit/b
:Unicode38077
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38077
exit/b
:Unicode38079
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38079
exit/b
:Unicode38084
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38084
exit/b
:Unicode38088
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38088
exit/b
:Unicode38089
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38089
exit/b
:Unicode38090
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38090
exit/b
:Unicode38091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38091
exit/b
:Unicode38092
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38092
exit/b
:Unicode38093
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38093
exit/b
:Unicode38094
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38094
exit/b
:Unicode38096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38096
exit/b
:Unicode38097
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38097
exit/b
:Unicode38098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38098
exit/b
:Unicode38101
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38101
exit/b
:Unicode38102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38102
exit/b
:Unicode38103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38103
exit/b
:Unicode38105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38105
exit/b
:Unicode38104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38104
exit/b
:Unicode38107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38107
exit/b
:Unicode38110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38110
exit/b
:Unicode38111
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38111
exit/b
:Unicode38112
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38112
exit/b
:Unicode38114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38114
exit/b
:Unicode38116
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38116
exit/b
:Unicode38117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38117
exit/b
:Unicode38119
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38119
exit/b
:Unicode38120
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38120
exit/b
:Unicode38122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38122
exit/b
:Unicode38121
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38121
exit/b
:Unicode38123
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38123
exit/b
:Unicode38126
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38126
exit/b
:Unicode38127
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38127
exit/b
:Unicode38131
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38131
exit/b
:Unicode38132
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38132
exit/b
:Unicode38133
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38133
exit/b
:Unicode38135
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38135
exit/b
:Unicode38137
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38137
exit/b
:Unicode38140
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38140
exit/b
:Unicode38141
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38141
exit/b
:Unicode38143
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38143
exit/b
:Unicode38147
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38147
exit/b
:Unicode38146
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38146
exit/b
:Unicode38150
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38150
exit/b
:Unicode38151
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38151
exit/b
:Unicode38153
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38153
exit/b
:Unicode38154
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38154
exit/b
:Unicode38157
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38157
exit/b
:Unicode38158
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38158
exit/b
:Unicode38159
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38159
exit/b
:Unicode38162
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38162
exit/b
:Unicode38163
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38163
exit/b
:Unicode38164
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38164
exit/b
:Unicode38165
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38165
exit/b
:Unicode38166
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38166
exit/b
:Unicode38168
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38168
exit/b
:Unicode38171
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38171
exit/b
:Unicode38173
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38173
exit/b
:Unicode38174
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38174
exit/b
:Unicode38175
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=38175
exit/b
:Unicode38178
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38178
exit/b
:Unicode38186
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38186
exit/b
:Unicode38187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38187
exit/b
:Unicode38185
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38185
exit/b
:Unicode38188
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38188
exit/b
:Unicode38193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38193
exit/b
:Unicode38194
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38194
exit/b
:Unicode38196
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38196
exit/b
:Unicode38198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38198
exit/b
:Unicode38199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38199
exit/b
:Unicode38200
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38200
exit/b
:Unicode38204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38204
exit/b
:Unicode38206
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38206
exit/b
:Unicode38207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38207
exit/b
:Unicode38210
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38210
exit/b
:Unicode38197
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38197
exit/b
:Unicode38212
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38212
exit/b
:Unicode38213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38213
exit/b
:Unicode38214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38214
exit/b
:Unicode38217
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38217
exit/b
:Unicode38220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38220
exit/b
:Unicode38222
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38222
exit/b
:Unicode38223
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38223
exit/b
:Unicode38226
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38226
exit/b
:Unicode38227
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38227
exit/b
:Unicode38228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38228
exit/b
:Unicode38230
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38230
exit/b
:Unicode38231
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38231
exit/b
:Unicode38232
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38232
exit/b
:Unicode38233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38233
exit/b
:Unicode38235
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38235
exit/b
:Unicode38238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38238
exit/b
:Unicode38239
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38239
exit/b
:Unicode38237
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38237
exit/b
:Unicode38241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38241
exit/b
:Unicode38242
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38242
exit/b
:Unicode38244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38244
exit/b
:Unicode38245
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38245
exit/b
:Unicode38246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38246
exit/b
:Unicode38247
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38247
exit/b
:Unicode38248
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38248
exit/b
:Unicode38249
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38249
exit/b
:Unicode38250
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38250
exit/b
:Unicode38251
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38251
exit/b
:Unicode38252
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38252
exit/b
:Unicode38255
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38255
exit/b
:Unicode38257
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38257
exit/b
:Unicode38258
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38258
exit/b
:Unicode38259
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38259
exit/b
:Unicode38202
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38202
exit/b
:Unicode30695
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30695
exit/b
:Unicode30700
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30700
exit/b
:Unicode38601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38601
exit/b
:Unicode31189
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31189
exit/b
:Unicode31213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31213
exit/b
:Unicode31203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31203
exit/b
:Unicode31211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31211
exit/b
:Unicode31238
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31238
exit/b
:Unicode23879
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=23879
exit/b
:Unicode31235
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31235
exit/b
:Unicode31234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31234
exit/b
:Unicode31262
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31262
exit/b
:Unicode31252
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31252
exit/b
:Unicode31289
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31289
exit/b
:Unicode31287
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31287
exit/b
:Unicode31313
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31313
exit/b
:Unicode40655
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40655
exit/b
:Unicode39333
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39333
exit/b
:Unicode31344
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31344
exit/b
:Unicode30344
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30344
exit/b
:Unicode30350
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30350
exit/b
:Unicode30355
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30355
exit/b
:Unicode30361
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30361
exit/b
:Unicode30372
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30372
exit/b
:Unicode29918
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29918
exit/b
:Unicode29920
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29920
exit/b
:Unicode29996
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=29996
exit/b
:Unicode40480
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40480
exit/b
:Unicode40482
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40482
exit/b
:Unicode40488
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40488
exit/b
:Unicode40489
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40489
exit/b
:Unicode40490
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40490
exit/b
:Unicode40491
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40491
exit/b
:Unicode40492
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40492
exit/b
:Unicode40498
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40498
exit/b
:Unicode40497
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40497
exit/b
:Unicode40502
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40502
exit/b
:Unicode40504
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40504
exit/b
:Unicode40503
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40503
exit/b
:Unicode40505
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40505
exit/b
:Unicode40506
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40506
exit/b
:Unicode40510
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40510
exit/b
:Unicode40513
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40513
exit/b
:Unicode40514
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=40514
exit/b
:Unicode40516
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40516
exit/b
:Unicode40518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40518
exit/b
:Unicode40519
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40519
exit/b
:Unicode40520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40520
exit/b
:Unicode40521
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40521
exit/b
:Unicode40523
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40523
exit/b
:Unicode40524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40524
exit/b
:Unicode40526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40526
exit/b
:Unicode40529
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40529
exit/b
:Unicode40533
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40533
exit/b
:Unicode40535
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40535
exit/b
:Unicode40538
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40538
exit/b
:Unicode40539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40539
exit/b
:Unicode40540
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40540
exit/b
:Unicode40542
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40542
exit/b
:Unicode40547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40547
exit/b
:Unicode40550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40550
exit/b
:Unicode40551
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40551
exit/b
:Unicode40552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40552
exit/b
:Unicode40553
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40553
exit/b
:Unicode40554
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40554
exit/b
:Unicode40555
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40555
exit/b
:Unicode40556
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40556
exit/b
:Unicode40561
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40561
exit/b
:Unicode40557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40557
exit/b
:Unicode40563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40563
exit/b
:Unicode30098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30098
exit/b
:Unicode30100
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30100
exit/b
:Unicode30102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30102
exit/b
:Unicode30112
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30112
exit/b
:Unicode30109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30109
exit/b
:Unicode30124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30124
exit/b
:Unicode30115
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30115
exit/b
:Unicode30131
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30131
exit/b
:Unicode30132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30132
exit/b
:Unicode30136
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30136
exit/b
:Unicode30148
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30148
exit/b
:Unicode30129
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30129
exit/b
:Unicode30128
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30128
exit/b
:Unicode30147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30147
exit/b
:Unicode30146
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30146
exit/b
:Unicode30166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30166
exit/b
:Unicode30157
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30157
exit/b
:Unicode30179
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30179
exit/b
:Unicode30184
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30184
exit/b
:Unicode30182
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30182
exit/b
:Unicode30180
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30180
exit/b
:Unicode30187
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30187
exit/b
:Unicode30183
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30183
exit/b
:Unicode30211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30211
exit/b
:Unicode30193
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30193
exit/b
:Unicode30204
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30204
exit/b
:Unicode30207
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30207
exit/b
:Unicode30224
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30224
exit/b
:Unicode30208
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30208
exit/b
:Unicode30213
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30213
exit/b
:Unicode30220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30220
exit/b
:Unicode30231
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30231
exit/b
:Unicode30218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30218
exit/b
:Unicode30245
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30245
exit/b
:Unicode30232
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30232
exit/b
:Unicode30229
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30229
exit/b
:Unicode30233
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30233
exit/b
:Unicode30235
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30235
exit/b
:Unicode30268
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30268
exit/b
:Unicode30242
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30242
exit/b
:Unicode30240
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30240
exit/b
:Unicode30272
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30272
exit/b
:Unicode30253
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30253
exit/b
:Unicode30256
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30256
exit/b
:Unicode30271
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30271
exit/b
:Unicode30261
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30261
exit/b
:Unicode30275
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30275
exit/b
:Unicode30270
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30270
exit/b
:Unicode30259
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30259
exit/b
:Unicode30285
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30285
exit/b
:Unicode30302
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30302
exit/b
:Unicode30292
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30292
exit/b
:Unicode30300
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30300
exit/b
:Unicode30294
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30294
exit/b
:Unicode30315
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30315
exit/b
:Unicode30319
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=30319
exit/b
:Unicode32714
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32714
exit/b
:Unicode31462
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31462
exit/b
:Unicode31352
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31352
exit/b
:Unicode31353
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31353
exit/b
:Unicode31360
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31360
exit/b
:Unicode31366
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31366
exit/b
:Unicode31368
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31368
exit/b
:Unicode31381
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31381
exit/b
:Unicode31398
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31398
exit/b
:Unicode31392
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31392
exit/b
:Unicode31404
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31404
exit/b
:Unicode31400
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=31400
exit/b
:Unicode31405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31405
exit/b
:Unicode31411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31411
exit/b
:Unicode34916
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34916
exit/b
:Unicode34921
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34921
exit/b
:Unicode34930
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34930
exit/b
:Unicode34941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34941
exit/b
:Unicode34943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34943
exit/b
:Unicode34946
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34946
exit/b
:Unicode34978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34978
exit/b
:Unicode35014
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35014
exit/b
:Unicode34999
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34999
exit/b
:Unicode35004
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35004
exit/b
:Unicode35017
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35017
exit/b
:Unicode35042
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35042
exit/b
:Unicode35022
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35022
exit/b
:Unicode35043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35043
exit/b
:Unicode35045
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35045
exit/b
:Unicode35057
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35057
exit/b
:Unicode35098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35098
exit/b
:Unicode35068
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35068
exit/b
:Unicode35048
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35048
exit/b
:Unicode35070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35070
exit/b
:Unicode35056
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35056
exit/b
:Unicode35105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35105
exit/b
:Unicode35097
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35097
exit/b
:Unicode35091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35091
exit/b
:Unicode35099
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35099
exit/b
:Unicode35082
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35082
exit/b
:Unicode35124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35124
exit/b
:Unicode35115
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35115
exit/b
:Unicode35126
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35126
exit/b
:Unicode35137
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35137
exit/b
:Unicode35174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35174
exit/b
:Unicode35195
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35195
exit/b
:Unicode30091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30091
exit/b
:Unicode32997
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32997
exit/b
:Unicode30386
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30386
exit/b
:Unicode30388
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30388
exit/b
:Unicode30684
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30684
exit/b
:Unicode32786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32786
exit/b
:Unicode32788
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32788
exit/b
:Unicode32790
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32790
exit/b
:Unicode32796
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32796
exit/b
:Unicode32800
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32800
exit/b
:Unicode32802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32802
exit/b
:Unicode32805
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32805
exit/b
:Unicode32806
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32806
exit/b
:Unicode32807
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32807
exit/b
:Unicode32809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32809
exit/b
:Unicode32808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32808
exit/b
:Unicode32817
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32817
exit/b
:Unicode32779
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32779
exit/b
:Unicode32821
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32821
exit/b
:Unicode32835
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32835
exit/b
:Unicode32838
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32838
exit/b
:Unicode32845
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32845
exit/b
:Unicode32850
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32850
exit/b
:Unicode32873
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32873
exit/b
:Unicode32881
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32881
exit/b
:Unicode35203
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35203
exit/b
:Unicode39032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39032
exit/b
:Unicode39040
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39040
exit/b
:Unicode39043
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39043
exit/b
:Unicode39049
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39049
exit/b
:Unicode39052
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39052
exit/b
:Unicode39053
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39053
exit/b
:Unicode39055
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39055
exit/b
:Unicode39060
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39060
exit/b
:Unicode39066
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39066
exit/b
:Unicode39067
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39067
exit/b
:Unicode39070
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39070
exit/b
:Unicode39071
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39071
exit/b
:Unicode39073
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39073
exit/b
:Unicode39074
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39074
exit/b
:Unicode39077
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39077
exit/b
:Unicode39078
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=39078
exit/b
:Unicode34381
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34381
exit/b
:Unicode34388
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34388
exit/b
:Unicode34412
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34412
exit/b
:Unicode34414
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34414
exit/b
:Unicode34431
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34431
exit/b
:Unicode34426
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34426
exit/b
:Unicode34428
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34428
exit/b
:Unicode34427
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34427
exit/b
:Unicode34472
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34472
exit/b
:Unicode34445
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34445
exit/b
:Unicode34443
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34443
exit/b
:Unicode34476
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34476
exit/b
:Unicode34461
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34461
exit/b
:Unicode34471
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34471
exit/b
:Unicode34467
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34467
exit/b
:Unicode34474
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34474
exit/b
:Unicode34451
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34451
exit/b
:Unicode34473
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34473
exit/b
:Unicode34486
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34486
exit/b
:Unicode34500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34500
exit/b
:Unicode34485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34485
exit/b
:Unicode34510
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34510
exit/b
:Unicode34480
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34480
exit/b
:Unicode34490
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34490
exit/b
:Unicode34481
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34481
exit/b
:Unicode34479
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34479
exit/b
:Unicode34505
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34505
exit/b
:Unicode34511
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34511
exit/b
:Unicode34484
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34484
exit/b
:Unicode34537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34537
exit/b
:Unicode34545
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34545
exit/b
:Unicode34546
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34546
exit/b
:Unicode34541
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34541
exit/b
:Unicode34547
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34547
exit/b
:Unicode34512
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34512
exit/b
:Unicode34579
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34579
exit/b
:Unicode34526
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34526
exit/b
:Unicode34548
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34548
exit/b
:Unicode34527
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34527
exit/b
:Unicode34520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34520
exit/b
:Unicode34513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34513
exit/b
:Unicode34563
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34563
exit/b
:Unicode34567
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34567
exit/b
:Unicode34552
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34552
exit/b
:Unicode34568
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34568
exit/b
:Unicode34570
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34570
exit/b
:Unicode34573
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34573
exit/b
:Unicode34569
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34569
exit/b
:Unicode34595
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34595
exit/b
:Unicode34619
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34619
exit/b
:Unicode34590
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34590
exit/b
:Unicode34597
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34597
exit/b
:Unicode34606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34606
exit/b
:Unicode34586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34586
exit/b
:Unicode34699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34699
exit/b
:Unicode34643
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34643
exit/b
:Unicode34659
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34659
exit/b
:Unicode34684
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34684
exit/b
:Unicode34660
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34660
exit/b
:Unicode34649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34649
exit/b
:Unicode34661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34661
exit/b
:Unicode34707
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34707
exit/b
:Unicode34735
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34735
exit/b
:Unicode34728
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34728
exit/b
:Unicode34770
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34770
exit/b
:Unicode34758
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34758
exit/b
:Unicode34696
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34696
exit/b
:Unicode34693
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34693
exit/b
:Unicode34733
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34733
exit/b
:Unicode34711
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34711
exit/b
:Unicode34691
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34691
exit/b
:Unicode34731
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34731
exit/b
:Unicode34789
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34789
exit/b
:Unicode34732
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34732
exit/b
:Unicode34741
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34741
exit/b
:Unicode34739
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34739
exit/b
:Unicode34763
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34763
exit/b
:Unicode34771
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34771
exit/b
:Unicode34749
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34749
exit/b
:Unicode34769
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34769
exit/b
:Unicode34752
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34752
exit/b
:Unicode34762
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34762
exit/b
:Unicode34779
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34779
exit/b
:Unicode34794
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34794
exit/b
:Unicode34784
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34784
exit/b
:Unicode34798
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34798
exit/b
:Unicode34838
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34838
exit/b
:Unicode34835
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34835
exit/b
:Unicode34814
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34814
exit/b
:Unicode34826
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34826
exit/b
:Unicode34843
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34843
exit/b
:Unicode34849
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34849
exit/b
:Unicode34873
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34873
exit/b
:Unicode34876
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=34876
exit/b
:Unicode32566
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32566
exit/b
:Unicode32578
set Unicode_Result=�
exit/b
:Unicode�
set Unicode_Result=32578
exit/b
:Unicode32580
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32580
exit/b
:Unicode32581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32581
exit/b
:Unicode33296
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33296
exit/b
:Unicode31482
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31482
exit/b
:Unicode31485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31485
exit/b
:Unicode31496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31496
exit/b
:Unicode31491
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31491
exit/b
:Unicode31492
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31492
exit/b
:Unicode31509
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31509
exit/b
:Unicode31498
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31498
exit/b
:Unicode31531
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31531
exit/b
:Unicode31503
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31503
exit/b
:Unicode31559
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31559
exit/b
:Unicode31544
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31544
exit/b
:Unicode31530
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31530
exit/b
:Unicode31513
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31513
exit/b
:Unicode31534
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31534
exit/b
:Unicode31537
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31537
exit/b
:Unicode31520
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31520
exit/b
:Unicode31525
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31525
exit/b
:Unicode31524
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31524
exit/b
:Unicode31539
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31539
exit/b
:Unicode31550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31550
exit/b
:Unicode31518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31518
exit/b
:Unicode31576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31576
exit/b
:Unicode31578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31578
exit/b
:Unicode31557
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31557
exit/b
:Unicode31605
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31605
exit/b
:Unicode31564
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31564
exit/b
:Unicode31581
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31581
exit/b
:Unicode31584
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31584
exit/b
:Unicode31598
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31598
exit/b
:Unicode31611
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31611
exit/b
:Unicode31586
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31586
exit/b
:Unicode31602
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31602
exit/b
:Unicode31601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31601
exit/b
:Unicode31632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31632
exit/b
:Unicode31654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31654
exit/b
:Unicode31655
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31655
exit/b
:Unicode31672
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31672
exit/b
:Unicode31660
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31660
exit/b
:Unicode31645
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31645
exit/b
:Unicode31656
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31656
exit/b
:Unicode31621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31621
exit/b
:Unicode31658
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31658
exit/b
:Unicode31644
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31644
exit/b
:Unicode31650
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31650
exit/b
:Unicode31659
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31659
exit/b
:Unicode31668
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31668
exit/b
:Unicode31697
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31697
exit/b
:Unicode31681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31681
exit/b
:Unicode31692
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31692
exit/b
:Unicode31709
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31709
exit/b
:Unicode31706
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31706
exit/b
:Unicode31717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31717
exit/b
:Unicode31718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31718
exit/b
:Unicode31722
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31722
exit/b
:Unicode31756
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31756
exit/b
:Unicode31742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31742
exit/b
:Unicode31740
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31740
exit/b
:Unicode31759
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31759
exit/b
:Unicode31766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31766
exit/b
:Unicode31755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31755
exit/b
:Unicode31775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31775
exit/b
:Unicode31786
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31786
exit/b
:Unicode31782
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31782
exit/b
:Unicode31800
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31800
exit/b
:Unicode31809
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31809
exit/b
:Unicode31808
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31808
exit/b
:Unicode33278
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33278
exit/b
:Unicode33281
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33281
exit/b
:Unicode33282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33282
exit/b
:Unicode33284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33284
exit/b
:Unicode33260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33260
exit/b
:Unicode34884
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34884
exit/b
:Unicode33313
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33313
exit/b
:Unicode33314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33314
exit/b
:Unicode33315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33315
exit/b
:Unicode33325
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33325
exit/b
:Unicode33327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33327
exit/b
:Unicode33320
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33320
exit/b
:Unicode33323
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33323
exit/b
:Unicode33336
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33336
exit/b
:Unicode33339
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33339
exit/b
:Unicode33331
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33331
exit/b
:Unicode33332
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33332
exit/b
:Unicode33342
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33342
exit/b
:Unicode33348
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33348
exit/b
:Unicode33353
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33353
exit/b
:Unicode33355
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33355
exit/b
:Unicode33359
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33359
exit/b
:Unicode33370
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33370
exit/b
:Unicode33375
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33375
exit/b
:Unicode33384
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33384
exit/b
:Unicode34942
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34942
exit/b
:Unicode34949
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34949
exit/b
:Unicode34952
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=34952
exit/b
:Unicode35032
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35032
exit/b
:Unicode35039
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35039
exit/b
:Unicode35166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35166
exit/b
:Unicode32669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32669
exit/b
:Unicode32671
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32671
exit/b
:Unicode32679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32679
exit/b
:Unicode32687
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32687
exit/b
:Unicode32688
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32688
exit/b
:Unicode32690
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32690
exit/b
:Unicode31868
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31868
exit/b
:Unicode25929
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=25929
exit/b
:Unicode31889
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31889
exit/b
:Unicode31901
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31901
exit/b
:Unicode31900
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31900
exit/b
:Unicode31902
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31902
exit/b
:Unicode31906
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31906
exit/b
:Unicode31922
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31922
exit/b
:Unicode31932
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31932
exit/b
:Unicode31933
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31933
exit/b
:Unicode31937
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31937
exit/b
:Unicode31943
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31943
exit/b
:Unicode31948
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31948
exit/b
:Unicode31949
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31949
exit/b
:Unicode31944
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31944
exit/b
:Unicode31941
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31941
exit/b
:Unicode31959
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31959
exit/b
:Unicode31976
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31976
exit/b
:Unicode33390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=33390
exit/b
:Unicode26280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26280
exit/b
:Unicode32703
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32703
exit/b
:Unicode32718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32718
exit/b
:Unicode32725
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32725
exit/b
:Unicode32741
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32741
exit/b
:Unicode32737
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32737
exit/b
:Unicode32742
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32742
exit/b
:Unicode32745
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32745
exit/b
:Unicode32750
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32750
exit/b
:Unicode32755
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32755
exit/b
:Unicode31992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31992
exit/b
:Unicode32119
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32119
exit/b
:Unicode32166
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32166
exit/b
:Unicode32174
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32174
exit/b
:Unicode32327
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32327
exit/b
:Unicode32411
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32411
exit/b
:Unicode40632
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40632
exit/b
:Unicode40628
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40628
exit/b
:Unicode36211
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36211
exit/b
:Unicode36228
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36228
exit/b
:Unicode36244
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36244
exit/b
:Unicode36241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36241
exit/b
:Unicode36273
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36273
exit/b
:Unicode36199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36199
exit/b
:Unicode36205
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36205
exit/b
:Unicode35911
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35911
exit/b
:Unicode35913
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35913
exit/b
:Unicode37194
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37194
exit/b
:Unicode37200
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37200
exit/b
:Unicode37198
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37198
exit/b
:Unicode37199
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37199
exit/b
:Unicode37220
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37220
exit/b
:Unicode37218
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37218
exit/b
:Unicode37217
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37217
exit/b
:Unicode37232
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37232
exit/b
:Unicode37225
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37225
exit/b
:Unicode37231
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37231
exit/b
:Unicode37245
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37245
exit/b
:Unicode37246
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37246
exit/b
:Unicode37234
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37234
exit/b
:Unicode37236
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37236
exit/b
:Unicode37241
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37241
exit/b
:Unicode37260
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37260
exit/b
:Unicode37253
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37253
exit/b
:Unicode37264
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37264
exit/b
:Unicode37261
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37261
exit/b
:Unicode37265
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37265
exit/b
:Unicode37282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37282
exit/b
:Unicode37283
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37283
exit/b
:Unicode37290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37290
exit/b
:Unicode37293
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37293
exit/b
:Unicode37294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37294
exit/b
:Unicode37295
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37295
exit/b
:Unicode37301
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37301
exit/b
:Unicode37300
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37300
exit/b
:Unicode37306
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37306
exit/b
:Unicode35925
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35925
exit/b
:Unicode40574
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40574
exit/b
:Unicode36280
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36280
exit/b
:Unicode36331
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36331
exit/b
:Unicode36357
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36357
exit/b
:Unicode36441
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36441
exit/b
:Unicode36457
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36457
exit/b
:Unicode36277
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36277
exit/b
:Unicode36287
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36287
exit/b
:Unicode36284
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36284
exit/b
:Unicode36282
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36282
exit/b
:Unicode36292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36292
exit/b
:Unicode36310
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36310
exit/b
:Unicode36311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36311
exit/b
:Unicode36314
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36314
exit/b
:Unicode36318
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36318
exit/b
:Unicode36302
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36302
exit/b
:Unicode36303
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36303
exit/b
:Unicode36315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36315
exit/b
:Unicode36294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36294
exit/b
:Unicode36332
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36332
exit/b
:Unicode36343
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36343
exit/b
:Unicode36344
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36344
exit/b
:Unicode36323
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36323
exit/b
:Unicode36345
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36345
exit/b
:Unicode36347
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36347
exit/b
:Unicode36324
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36324
exit/b
:Unicode36361
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36361
exit/b
:Unicode36349
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36349
exit/b
:Unicode36372
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36372
exit/b
:Unicode36381
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36381
exit/b
:Unicode36383
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36383
exit/b
:Unicode36396
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36396
exit/b
:Unicode36398
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36398
exit/b
:Unicode36387
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36387
exit/b
:Unicode36399
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36399
exit/b
:Unicode36410
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36410
exit/b
:Unicode36416
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36416
exit/b
:Unicode36409
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36409
exit/b
:Unicode36405
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36405
exit/b
:Unicode36413
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36413
exit/b
:Unicode36401
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36401
exit/b
:Unicode36425
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36425
exit/b
:Unicode36417
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36417
exit/b
:Unicode36418
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36418
exit/b
:Unicode36433
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36433
exit/b
:Unicode36434
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36434
exit/b
:Unicode36426
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36426
exit/b
:Unicode36464
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36464
exit/b
:Unicode36470
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36470
exit/b
:Unicode36476
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36476
exit/b
:Unicode36463
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36463
exit/b
:Unicode36468
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36468
exit/b
:Unicode36485
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36485
exit/b
:Unicode36495
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36495
exit/b
:Unicode36500
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36500
exit/b
:Unicode36496
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36496
exit/b
:Unicode36508
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36508
exit/b
:Unicode36510
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=36510
exit/b
:Unicode35960
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35960
exit/b
:Unicode35970
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35970
exit/b
:Unicode35978
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35978
exit/b
:Unicode35973
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35973
exit/b
:Unicode35992
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35992
exit/b
:Unicode35988
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35988
exit/b
:Unicode26011
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=26011
exit/b
:Unicode35286
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35286
exit/b
:Unicode35294
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35294
exit/b
:Unicode35290
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35290
exit/b
:Unicode35292
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35292
exit/b
:Unicode35301
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35301
exit/b
:Unicode35307
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35307
exit/b
:Unicode35311
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35311
exit/b
:Unicode35390
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35390
exit/b
:Unicode35622
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=35622
exit/b
:Unicode38739
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38739
exit/b
:Unicode38633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38633
exit/b
:Unicode38643
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38643
exit/b
:Unicode38639
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38639
exit/b
:Unicode38662
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38662
exit/b
:Unicode38657
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38657
exit/b
:Unicode38664
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38664
exit/b
:Unicode38671
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38671
exit/b
:Unicode38670
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38670
exit/b
:Unicode38698
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38698
exit/b
:Unicode38701
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38701
exit/b
:Unicode38704
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38704
exit/b
:Unicode38718
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38718
exit/b
:Unicode40832
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40832
exit/b
:Unicode40835
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40835
exit/b
:Unicode40837
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40837
exit/b
:Unicode40838
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40838
exit/b
:Unicode40839
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40839
exit/b
:Unicode40840
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40840
exit/b
:Unicode40841
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40841
exit/b
:Unicode40842
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40842
exit/b
:Unicode40844
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40844
exit/b
:Unicode40702
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40702
exit/b
:Unicode40715
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40715
exit/b
:Unicode40717
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40717
exit/b
:Unicode38585
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38585
exit/b
:Unicode38588
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38588
exit/b
:Unicode38589
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38589
exit/b
:Unicode38606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38606
exit/b
:Unicode38610
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38610
exit/b
:Unicode30655
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=30655
exit/b
:Unicode38624
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38624
exit/b
:Unicode37518
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37518
exit/b
:Unicode37550
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37550
exit/b
:Unicode37576
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37576
exit/b
:Unicode37694
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37694
exit/b
:Unicode37738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37738
exit/b
:Unicode37834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37834
exit/b
:Unicode37775
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37775
exit/b
:Unicode37950
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37950
exit/b
:Unicode37995
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37995
exit/b
:Unicode40063
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40063
exit/b
:Unicode40066
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40066
exit/b
:Unicode40069
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40069
exit/b
:Unicode40070
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40070
exit/b
:Unicode40071
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40071
exit/b
:Unicode40072
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40072
exit/b
:Unicode31267
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=31267
exit/b
:Unicode40075
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40075
exit/b
:Unicode40078
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40078
exit/b
:Unicode40080
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40080
exit/b
:Unicode40081
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40081
exit/b
:Unicode40082
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40082
exit/b
:Unicode40084
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40084
exit/b
:Unicode40085
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40085
exit/b
:Unicode40090
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40090
exit/b
:Unicode40091
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40091
exit/b
:Unicode40094
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40094
exit/b
:Unicode40095
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40095
exit/b
:Unicode40096
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40096
exit/b
:Unicode40097
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40097
exit/b
:Unicode40098
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40098
exit/b
:Unicode40099
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40099
exit/b
:Unicode40101
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40101
exit/b
:Unicode40102
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40102
exit/b
:Unicode40103
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40103
exit/b
:Unicode40104
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40104
exit/b
:Unicode40105
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40105
exit/b
:Unicode40107
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40107
exit/b
:Unicode40109
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40109
exit/b
:Unicode40110
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40110
exit/b
:Unicode40112
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40112
exit/b
:Unicode40113
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40113
exit/b
:Unicode40114
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40114
exit/b
:Unicode40115
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40115
exit/b
:Unicode40116
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40116
exit/b
:Unicode40117
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40117
exit/b
:Unicode40118
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40118
exit/b
:Unicode40119
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40119
exit/b
:Unicode40122
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40122
exit/b
:Unicode40123
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40123
exit/b
:Unicode40124
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40124
exit/b
:Unicode40125
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40125
exit/b
:Unicode40132
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40132
exit/b
:Unicode40133
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40133
exit/b
:Unicode40134
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40134
exit/b
:Unicode40135
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40135
exit/b
:Unicode40138
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40138
exit/b
:Unicode40139
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40139
exit/b
:Unicode40140
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40140
exit/b
:Unicode40141
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40141
exit/b
:Unicode40142
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40142
exit/b
:Unicode40143
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40143
exit/b
:Unicode40144
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40144
exit/b
:Unicode40147
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40147
exit/b
:Unicode40148
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40148
exit/b
:Unicode40149
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40149
exit/b
:Unicode40151
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40151
exit/b
:Unicode40152
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40152
exit/b
:Unicode40153
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40153
exit/b
:Unicode40156
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40156
exit/b
:Unicode40157
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40157
exit/b
:Unicode40159
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40159
exit/b
:Unicode40162
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40162
exit/b
:Unicode38780
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38780
exit/b
:Unicode38789
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38789
exit/b
:Unicode38801
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38801
exit/b
:Unicode38802
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38802
exit/b
:Unicode38804
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38804
exit/b
:Unicode38831
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38831
exit/b
:Unicode38827
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38827
exit/b
:Unicode38819
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38819
exit/b
:Unicode38834
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38834
exit/b
:Unicode38836
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=38836
exit/b
:Unicode39601
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39601
exit/b
:Unicode39600
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39600
exit/b
:Unicode39607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39607
exit/b
:Unicode40536
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40536
exit/b
:Unicode39606
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39606
exit/b
:Unicode39610
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39610
exit/b
:Unicode39612
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39612
exit/b
:Unicode39617
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39617
exit/b
:Unicode39616
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39616
exit/b
:Unicode39621
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39621
exit/b
:Unicode39618
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39618
exit/b
:Unicode39627
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39627
exit/b
:Unicode39628
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39628
exit/b
:Unicode39633
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39633
exit/b
:Unicode39749
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39749
exit/b
:Unicode39747
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39747
exit/b
:Unicode39751
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39751
exit/b
:Unicode39753
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39753
exit/b
:Unicode39752
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39752
exit/b
:Unicode39757
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39757
exit/b
:Unicode39761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39761
exit/b
:Unicode39144
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39144
exit/b
:Unicode39181
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39181
exit/b
:Unicode39214
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39214
exit/b
:Unicode39253
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39253
exit/b
:Unicode39252
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39252
exit/b
:Unicode39647
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39647
exit/b
:Unicode39649
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39649
exit/b
:Unicode39654
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39654
exit/b
:Unicode39663
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39663
exit/b
:Unicode39659
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39659
exit/b
:Unicode39675
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39675
exit/b
:Unicode39661
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39661
exit/b
:Unicode39673
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39673
exit/b
:Unicode39688
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39688
exit/b
:Unicode39695
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39695
exit/b
:Unicode39699
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39699
exit/b
:Unicode39711
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39711
exit/b
:Unicode39715
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=39715
exit/b
:Unicode40637
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40637
exit/b
:Unicode40638
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40638
exit/b
:Unicode32315
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=32315
exit/b
:Unicode40578
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40578
exit/b
:Unicode40583
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40583
exit/b
:Unicode40584
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40584
exit/b
:Unicode40587
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40587
exit/b
:Unicode40594
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40594
exit/b
:Unicode37846
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=37846
exit/b
:Unicode40605
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40605
exit/b
:Unicode40607
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40607
exit/b
:Unicode40667
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40667
exit/b
:Unicode40668
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40668
exit/b
:Unicode40669
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40669
exit/b
:Unicode40672
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40672
exit/b
:Unicode40671
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40671
exit/b
:Unicode40674
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40674
exit/b
:Unicode40681
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40681
exit/b
:Unicode40679
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40679
exit/b
:Unicode40677
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40677
exit/b
:Unicode40682
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40682
exit/b
:Unicode40687
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40687
exit/b
:Unicode40738
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40738
exit/b
:Unicode40748
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40748
exit/b
:Unicode40751
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40751
exit/b
:Unicode40761
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40761
exit/b
:Unicode40759
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40759
exit/b
:Unicode40765
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40765
exit/b
:Unicode40766
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=40766
exit/b
:Unicode4077222
set Unicode_Result=��
exit/b
:Unicode��
set Unicode_Result=4077222
exit/b

:-----�ӳ���������-----:
:end
