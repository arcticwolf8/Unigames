@ECHO off

REM Begin start page
cls
echo:
echo:
echo:
echo:
echo:
echo:
echo:
echo:
COLOR C
ECHO Copyright (c) 2017 WolfByte Data, Inc. All rights reserved.
ECHO Unauthorized modification, duplication, or distribution punishable by law.
echo:
echo:
echo:
ECHO If you are not authorized to run this script, please exit immediately.
echo:
TIMEOUT /T 8 >nul 2>&1
echo:
REM End start page

REM Start Variables
SET uncpath=\\blaque-pos001\SharedBuild
SET build=1840.2_usa
COLOR 3
TITLE Installing latest build. Please wait...
REM End Variables

ECHO Killing Explorer windows...
taskkill /f /im explorer.exe  >nul 2>&1
echo:

ECHO Killing Game windows...
taskkill /f /im client.exe  >nul 2>&1
taskkill /f /im backserver_win.exe  >nul 2>&1

ECHO Freeing space...
rmdir "C:\#Tech\GT\Ultimate Solution" /S /Q  >nul 2>&1

ECHO Removing old shortcuts...
del "%userprofile%\Desktop\Launcher - Shortcut.lnk" /S /Q >nul 2>&1
del "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Launcher - Shortcut.lnk" /S /Q >nul 2>&1
echo:

ECHO Downloading Unigames build %build%...
copy %uncpath%\mobcas.win_%build%.7z %userprofile%\Desktop >nul 2>&1
echo:

ECHO Extracting Unigames build %build% to desktop...
%uncpath%\BuildUpdater\Dependencies\7za -y x %userprofile%\desktop\mobcas.win_%build%.7z -o%userprofile%\Desktop\mobcas.win_%build%\
echo:

ECHO Updating configuration file for NFC scanner compatibility...
del %userprofile%\Desktop\mobcas.win_%build%\build\BACKSERVER\config.ini.aes /S /Q >nul 2>&1
copy %uncpath%\#Tech\config.ini.aes "%userprofile%\Desktop\mobcas.win_%build%\build\BACKSERVER\config.ini.aes" >nul 2>&1

ECHO Removing compressed folder to free up space...
del %userprofile%\desktop\mobcas.win_%build%.7z /S /Q >nul 2>&1
echo:

ECHO Creating Desktop shortcut and Startup entry...
%uncpath%\BuildUpdater\Dependencies\nircmd shortcut "%userprofile%\Desktop\mobcas.win_%build%\build\Launcher.exe" "~$folder.desktop$" "Launcher" >nul 2>&1
%uncpath%\BuildUpdater\Dependencies\nircmd shortcut "%userprofile%\Desktop\mobcas.win_%build%\build\Launcher.exe" "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" "Launcher" >nul 2>&1
echo:

ECHO Done! Rebooting system...
shutdown /r /t 3 >nul 2>&1
