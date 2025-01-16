@echo off
:: ======================================================================================================
:: Script Name   : YoutubeRunner
:: Version       : 1.0
:: Author        : TheSpeed!O
:: Date Created  : 15.01.2025
:: Last Updated  : 16.01.2025
:: Description   : A batch script that displays ASCII art, gathers system information,
::                 and launches a browser with a custom configuration for speed and less memory usage.
:: ======================================================================================================
:: UTF-8 encoding
chcp 65001 > nul
cls
color 01
mode con: cols=150 lines=40

:: current date and time
for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set month=%%a
    set day=%%b
    set year=%%c
)

for /f "tokens=1-2 delims=: " %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
)

if 1%hour% LSS 10 set hour=0%hour%
if 1%minute% LSS 10 set minute=0%minute%

set /a hour12=%hour%
if %hour12% geq 12 (
    set ampm=PM
    if %hour12% gtr 12 set /a hour12=%hour12%-12
) else (
    set ampm=AM
    if %hour12% lss 10 set hour12=0%hour12%
)
:: Memory
for /f "tokens=2 delims==" %%i in ('wmic OS get TotalVisibleMemorySize /Value') do set totalmem=%%i
for /f "tokens=2 delims==" %%i in ('wmic OS get FreePhysicalMemory /Value') do set freemem=%%i
:: VMİC error handling
for /f "tokens=2 delims==" %%i in ('wmic OS get TotalVisibleMemorySize /Value') do (
    if not defined totalmem set totalmem=Unknown
    set totalmem=%%i
)

set /a totalmem=%totalmem% / 1024
set /a freemem=%freemem% / 1024

::additional system information
setlocal enabledelayedexpansion
for /f "tokens=2 delims==" %%i in ('wmic ComputerSystem get Model /Value') do set model=%%i
for /f "tokens=2 delims==" %%i in ('wmic ComputerSystem get Manufacturer /Value') do set manufacturer=%%i
endlocal
:: whitespace
set manufacturer=%manufacturer:~0,-1%
set model=%model:~0,-1%

::IP address
for /f "tokens=14" %%i in ('ipconfig ^| findstr /R /C:"IPv4 Address"') do set ipaddress=%%i



:: ASCII art and system information
cls
color 01
echo.
echo.                              ███████████████████████████████████████████████████████████████████████████████████████████████████
echo.                              █░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░███░░░░░░█░░░░░░░░░░░░░░█
echo.                              █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀░░░░█░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
echo.                              █░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░▄▀▄▀░░█░░▄▀░░█░░▄▀░░░░░░▄▀░░█
echo.                              █░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░█████████░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░█░░▄▀░░██░░▄▀░░█
echo.                              █░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░█░░▄▀░░██░░▄▀░░█
echo.                              █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░█░░▄▀░░██░░▄▀░░█
echo.                              █░░░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░█░░▄▀░░██░░▄▀░░█
echo.                              █████████░░▄▀░░█░░▄▀░░█████████░░▄▀░░█████████░░▄▀░░█████████░░▄▀░░██░░▄▀░░████████░░▄▀░░██░░▄▀░░█
echo.                              █░░░░░░░░░░▄▀░░█░░▄▀░░█████████░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░█░░░░░░█░░▄▀░░██░░▄▀░░█
echo.                              █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀░░░░█░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
echo.                              █░░░░░░░░░░░░░░█░░░░░░█████████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░███░░░░░░░█░░░░░░░░░░░░░░█
echo.                              ██████████████████████████████████████████████████████████████████████████████████████████████████
echo.
echo.                                                     ╱╱  Exclusive Version - Exemplar Uniquement  ╱╱
echo.                                                ╱Enter For Faster Starts, You can change seconds in bat╱
echo.                                            ╱ ──────────────────────────────────────────────────────────────── ╱
echo.                                        =================%day%-%month%-%year% %hour12%:%minute% %ampm%=================     
echo.                                          ╱----------------------------------------------------------------------╱
echo.                                               ╱ ------------------------------------------------------╱
echo.                                                     ================= SYSTEM INFO =================
echo.                                                ------------------------------------------------------
echo.                                                         ╱Current User: %username%
echo.                                                         ╱Computer Name: %computername%
echo.                                                         ╱Processor: %PROCESSOR_IDENTIFIER%
echo.                                                         ╱Operating System: %OS%
echo.                                                         ╱IP Address: %ipaddress%
echo.                                                         ╱Total Memory: %totalmem% MB
echo.                                                         ╱Free Memory: %freemem% MB
echo.                                                         ╱Manufacturer: %manufacturer%
echo.                                                         ╱Model: %model%
echo.                                                ------------------------------------------------------
echo.                                                          ╱     Bella ciao, bella ciao!    ╱
timeout /t 5 > nul
cls
color 3F
echo.                                               ████████████████████████████████████████████████████████████████████
echo.                                               ███                 █████████████████████████████                ███
echo.                                               ███           ██████ Preparing to Launch Browser ██████          ███
echo.                                               ████████████████████████████████████████████████████████████████████    
timeout /t 1 > nul
cls
color F0
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "TranslateEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "TaskManagerEndProcessEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "UserFeedbackAllowed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "SpellCheckServiceEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "SpellcheckEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MediaRouterCastAllowAllIPs" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "AllowDinosaurEasterEgg" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultGeolocationSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultCookiesSetting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultFileHandlingGuardSetting" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultFileSystemReadGuardSetting" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultFileSystemWriteGuardSetting" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultImagesSetting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultPopupsSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSensorsSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSerialGuardSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultWebBluetoothGuardSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultWebUsbGuardSetting" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "EnableMediaRouter" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ShowCastIconInToolbar" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "CloudPrintProxyEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "PrintRasterizationMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "PrintingEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultPluginsSetting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "SafeBrowsingProtectionLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "SafeBrowsingExtendedReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "HomepageIsNewTabPage" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "HomepageLocation" /t REG_SZ /d "google.com" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "NewTabPageLocation" /t REG_SZ /d "google.com" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome\Recommended" /v "MetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome\Recommended" /v "DeviceMetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Policies\Google\Chrome\Recommended" /v "MetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Policies\Google\Chrome\Recommended" /v "DeviceMetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DeviceMetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Policies\Google\Chrome" /v "DeviceMetricsReportingEnabled" /t REG_DWORD /d "0" /f
:: Set Chrome paths
set chromePath="C:\Program Files\Google\Chrome\Application\chrome.exe"
set chromePath64="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

:: Check if Chrome is installed
if exist %chromePath% (
    :: Start Chrome with 6 optimized flags
    start "" %chromePath% --disable-gpu --no-sandbox --disable-software-rasterizer --disable-cache --disable-webgl --disable-sync https://www.youtube.com/?app=desktop&hl=en
) else if exist %chromePath64% (
    :: Start Chrome with 6 optimized flags for 64-bit installation
    start "" %chromePath64% --disable-gpu --no-sandbox --disable-software-rasterizer --disable-cache --disable-webgl --disable-sync https://www.youtube.com/?app=desktop&hl=en
) else (
    echo Google Chrome is not installed.
    timeout /t 3 > nul
)
