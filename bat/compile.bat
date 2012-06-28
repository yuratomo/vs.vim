@echo off
if "%VS_COMP%" == "build" goto wdk
goto vs

REM ================ SETTING ==================

:wdk
set pwd=%cd%
call "%wdk_dir%\bin\setenv.bat" %WDK_DIR% %WDK_COND% %WDK_CPU% %WDK_OS%
%pwd:~0,2%
cd %pwd%
goto build

:vs
if "%VS_VER%"  == "8"   set BASEDIR=%VS80COMNTOOLS%
if "%VS_VER%"  == "9"   set BASEDIR=%VS90COMNTOOLS%
if "%VS_VER%"  == "10"  set BASEDIR=%VS100COMNTOOLS%
if "%VS_VER%"  == "11"  set BASEDIR=%VS110COMNTOOLS%
if "%VS_VER%"  == "12"  set BASEDIR=%VS120COMNTOOLS%
call "%BASEDIR%..\..\vcvarsall.bat" %VS_CPU%
goto build

REM ================ BUILD ==================
:build
%VS_COMP% %1 %2 %3 %4 %5 %6 %7 %8 %9 2>&1

