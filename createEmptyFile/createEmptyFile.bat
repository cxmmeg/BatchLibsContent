REM �������ļ� 20160425
REM call:createEmptyFile "�ļ���"
REM ����ֵ��1 - �ļ�����ʧ�ܣ� 2 - ���ò������� 0 - �ɹ�
:createEmptyFile
REM �жϲ����Ƿ���ȷ
if "%~1"=="" (
	if defined debug (
		echo=#createEmptyFile:����Ϊ��
		pause
	)
	exit/b 2
)

REM ���ɿ��ļ�
(
	if a==b echo=�˴��������ɿ��ļ�
)>"%~1"

if exist "%~1" (
	exit/b 0
) else if defined debug (
	echo=#createEmptyFile:�ļ�����ʧ��
	pause
)
exit/b 1