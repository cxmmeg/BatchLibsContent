goto end

REM ȷ�ϣ�
REM 20160502
REM call:queRen ["��ʾ����"] ["ȷ�ϰ���"] ["ȡ������"]
REM ����ֵ��0-�û�ȷ�ϣ�1-�û�ȡ��
:queRen
set queRen_tips=ȷ��?
set queRen_yes=Y
set queRen_no=

if not "%~1"=="" set queRen_tips=%~1
if not "%~2"=="" set queRen_yes=%~2
if not "%~3"=="" set queRen_no=%~3
set queRen_tips=%queRen_tips% [��:%queRen_yes%
if defined queRen_no (
	set queRen_tips=%queRen_tips%/��:%queRen_no%]
) else (
	set queRen_tips=%queRen_tips%]
)

:queRen2
set queRen_user=
set /p queRen_user=%queRen_tips%:
if defined queRen_user (
	
	if /i "%queRen_user%"=="%queRen_yes%" exit/b 0
	if defined queRen_no if /i not "%queRen_user%"=="%queRen_no%" goto queRen2
	
) else (
	if defined queRen_no goto queRen2
)
exit/b 1

:end