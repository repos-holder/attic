@echo off
cls
title Amiga Music Preservation grabber v0.3
color 0E
echo       888          888                                         
echo       888          888                                         
echo       888          888                                         
echo   .d88888 888  888 888  888 88888888  .d8888b 888d888 888  888 
echo  d88" 888 888  888 888 .88P    d88P  d88P"    888P"   888  888 
echo  888  888 888  888 888888K    d88P   888      888     888  888 
echo  Y88b 888 Y88b 888 888 "88b  d88P    Y88b.    888     Y88b 888 
echo   "Y88888  "Y88888 888  888 88888888  "Y8888P 888      "Y88888 
echo                                                            888 
echo                                                       Y8b d88P 
echo                 ..o0O proudly presents O0o..           "Y88P"  
echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo  บ          Amiga Music Preservation grabber v0.3            บ
echo  บ                Go to http://amp.dascene.net               บ
echo  ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน
echo  บ Info: This is a grabber that downloads modules from Amiga บ
echo  บ Music Preservation (that is currently hugest amiga music  บ
echo  บ scene archive) all together per one musician. They don't  บ
echo  บ provide this by themselves cause they want to save their  บ
echo  บ traffic, but they spend too much of our time. So i've     บ
echo  บ done this, but keep it private please! Thanks.            บ
echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo Hello, friend! I'll rip and download everything, than unpack and rename modules, than pack them again as zipes.
echo.
goto dq
:error
echo.
echo No such drive, or read-only drive, or can't get access!
echo.
goto dq
:make
md %driveletter%:\AMPGRABBED 2>nul
if errorlevel 1 goto error
goto eecho
:rdandmake
rd %driveletter%:\AMPGRABBED /q 2>nul
md %driveletter%:\AMPGRABBED 2>nul
if errorlevel 1 goto error
goto eecho
:dq
set driveletter=NUL
set /p driveletter="I'll install into AMPGRABBED directory... on what drive? [c for example]: "
if %driveletter%==NUL goto dq
del %driveletter%:\AMPGRABBED\* /q 2>nul 
if errorlevel 1 goto make
if errorlevel 0 goto rdandmake
:eecho
echo.
goto dlist
:dlist
rd %driveletter%:\AMPGRABBED /q 2>nul
set id=NUL
set /p id="Now feed me with musician's id from Amiga Music Preservation site: "
if %id%==NUL goto dlist
md %driveletter%:\AMPGRABBED 2>nul
%myfiles%\ampg-ripper %driveletter% %id%
if not exist %driveletter%:\AMPGRABBED\dlist goto dlist
echo.
echo.
echo Downloading...
%myfiles%\ampg-download -q -t 500 -i%driveletter%:\AMPGRABBED\dlist -P%driveletter%:/AMPGRABBED 2>nul
del %driveletter%:\AMPGRABBED\dlist 2>nul
echo Extracting...
%myfiles%\ampg-extract -d %driveletter%:\AMPGRABBED\* 2>nul
echo Renaming...
for /f "tokens=1* delims=." %%i in ('"for %%b in (%driveletter%:\AMPGRABBED\*.*) do @echo %%~nb%%~xb"') do ren %driveletter%:\AMPGRABBED\"%%i.%%j" "%%j.%%i" 2>nul
copy %myfiles%\ampg-lowext.exe %driveletter%:\AMPGRABBED >nul
cd /d %driveletter%:\AMPGRABBED >nul
ampg-lowext >nul
chcp 866 >nul
del %driveletter%:\AMPGRABBED\ampg-lowext.exe 2>nul
echo RePacking...
for %%x in (%driveletter%:\AMPGRABBED\*.*) do (%myfiles%\ampg-pack -qj "%driveletter%:\AMPGRABBED\%%~nx%%~xx.zip" "%driveletter%:\AMPGRABBED\%%~nx%%~xx" 2>nul
del "%driveletter%:\AMPGRABBED\%%~nx%%~xx" 2>nul
)
echo.
echo Done successfully. Have a nice day!
echo.
pause