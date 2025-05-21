@echo off
setlocal enabledelayedexpansion

if "%1"=="" goto :help

if /i "%1"=="Cursor" (
    if /i "%2"=="ON" (
        call :cursor_on
        exit /b 0
    ) else if /i "%2"=="OFF" (
        call :cursor_off
        exit /b 0
    ) else (
        exit /b 1
    )
)

if /i "%1"=="decode64" (
    if "%2"=="" goto :help
    if "%3"=="" goto :help
    set "local=%2"
    set "base64=%3"
    call :decode_base64
    exit /b 0
)

goto :help

:help
echo.
echo Addon CLI - Utilitário para o terminal Windows
echo.
echo Uso:
echo   Addon.bat Cursor [ON^|OFF] - Ativa ou desativa o cursor do terminal
echo   Addon.bat decode64 LOCAL BASE64 - Decodifica uma string Base64 e grava no arquivo LOCAL
echo.
exit /b 0

:cursor_off
powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "$rawUI = (Get-Host).UI.RawUI; $rawUI.CursorSize = 0" >nul 2>&1
exit /b

:cursor_on
powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "$rawUI = (Get-Host).UI.RawUI; $rawUI.CursorSize = 25" >nul 2>&1
exit /b

:decode_base64
powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "[System.IO.File]::WriteAllText("$env:%local%", [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("...")), [System.Text.UTF8Encoding]::new($false))"
exit /b

