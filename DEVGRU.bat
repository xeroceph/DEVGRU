REM https://github.com/xeroceph/DEVGRU
REM v0.2
REM GNU General Public License v3.0

@setlocal enableextensions enabledelayedexpansion
@echo off
set ipaddr=8.8.8.8
set oldstate=neither

REM log that the script has initialized
echo DEVGRU initialized.
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo [INFO] DEVGRU initialized >> DEVGRU_log.txt

REM wait four minutes for any IP applications to start up
timeout 240

REM begin loop to check if IP is reachable
:loop
set state=up
ping -n 1 %ipaddr% >nul: 2>nul:
if not %errorlevel%==0 set state=down
if not %state%==%oldstate% (
    echo.Link is %state%
    set oldstate=%state%
    echo ---------------------- >> DEVGRU_log.txt
    date /t >> DEVGRU_log.txt
    time /t >> DEVGRU_log.txt
    echo [WARNING] Link is %state% >> DEVGRU_log.txt
)
if %state%==down goto :endloop
timeout 300
goto :loop

:endloop
REM if network traffic was latent, we want to set the failsafe_count flag
REM and try one more time before rebooting
if %failsafe_count%==1 goto :initreboot
echo Network connectivity issues detected...
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo [WARNING] First occurence of network failure, setting failsafe flag >> DEVGRU_log.txt
set failsafe_count=1
timeout 300
goto :loop

REM begin reboot process
:initreboot
echo Network connectivity issues continuing. Rebooting momentarily to restore connectivity...
timeout 15
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo [WARNING] Second occurence of network failure - rebooting now... >> DEVGRU_log.txt
shutdown -r -f
