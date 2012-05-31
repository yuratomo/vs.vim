@echo off
if "%vs_comp%" == "build" goto wdk
if "%vs_ver%"  == "8"     goto vs8
if "%vs_ver%"  == "9"     goto vs9
if "%vs_ver%"  == "10"    goto vs10
if "%vs_ver%"  == "11"    goto vs11
if "%vs_ver%"  == "12"    goto vs12
goto :EOF

REM ================ SETTING ==================

:wdk
set pwd=%cd%
call "%wdk_dir%\bin\setenv.bat" %wdk_dir% %wdk_cond% %wdk_cpu% %wdk_os%
%pwd:~0,2%
cd %pwd%
goto build

:vs8
call "%VS80COMNTOOLS%vsvars32.bat"
goto build

:vs9
call "%VS90COMNTOOLS%vsvars32.bat"
goto build

:vs10
call "%VS100COMNTOOLS%vsvars32.bat"
goto build

:vs11
call "%VS110COMNTOOLS%vsvars32.bat"
goto build

:vs12
call "%VS120COMNTOOLS%vsvars32.bat"
goto build

REM ================ BUILD ==================
:build
%vs_comp% %1 %2 %3 %4 %5 %6 %7 %8 %9 2>&1

