# DEVGRU
Windows batch script to monitor Internet connectivity

## Description
This script checks Internet connectivity periodically (default is 5 minute intervals) and will conduct a reboot of the machine if connectivity is lost. Can be used to trigger an unattended reboot of a machine that loses connectivity. A default wait time of four minutes during startup allows for any additional Windows services to start before normal operation begins.

## Usage
Add `DEVGRU.bat` to your Windows machine; update the IP address to check for connectivity accordingly (default is Google - `8.8.8.8`). Add a shortcut link to the file in your Windows Startup folder to kick off the script automatically when Windows boots.

## Changelog
* **v0.2** - Added failsafe flag to reduce number of restarts if there's a minor instance of network latency.