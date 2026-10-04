@echo off
:: تحقق من تشغيل كمسؤول
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo طلب صلاحيات المسؤول...
    powershell start -verb runas "%~f0"
    exit /b
)

echo منع موقع emeditor...

set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"

:: تحقق إذا كانت الأسطر موجودة بالفعل، لتجنب التكرار
findstr /C:"emeditor.com" "%HOSTS_FILE%" >nul
if %errorlevel%==0 (
    echo [تمت الإضافة من قبل أو موجود بالفعل]
) else (
    >>"%HOSTS_FILE%" echo.
    >>"%HOSTS_FILE%" echo localhost www.emeditor.com
    >>"%HOSTS_FILE%" echo localhost emeditor.com
    >>"%HOSTS_FILE%" echo localhost 104.21.23.188
    >>"%HOSTS_FILE%" echo www.emeditor.com localhost
    >>"%HOSTS_FILE%" echo emeditor.com localhost
    >>"%HOSTS_FILE%" echo 104.21.23.188 localhost
    echo [✓] تم الحظر بنجاح
)

pause
