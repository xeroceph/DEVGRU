@setlocal enableextensions enabledelayedexpansion
@echo off
set ipaddr=8.8.8.8
set oldstate=neither

REM log that the script has initialized
echo DEVGRU initialized.
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo DEVGRU initialized >> DEVGRU_log.txt

REM wait four minutes for any IP applications to connect
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
set failsafe_count=1
timeout 300
goto :loop

REM begin reboot process
:initreboot
echo Rebooting in two minutes to restore connectivity...
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo Rebooting in two minutes to restore connectivity... >> DEVGRU_log.txt
timeout 180
echo ---------------------- >> DEVGRU_log.txt
date /t >> DEVGRU_log.txt
time /t >> DEVGRU_log.txt
echo Rebooting now... >> DEVGRU_log.txt
shutdown -r -f
