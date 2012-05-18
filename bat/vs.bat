@echo off

if "%vs_ver%" == "8"  goto vs8
if "%vs_ver%" == "9"  goto vs9
if "%vs_ver%" == "10" goto vs10
if "%vs_ver%" == "11" goto vs11
if "%vs_ver%" == "12" goto vs12
goto :EOF

:vs8
call "%VS80COMNTOOLS%vsvars32.bat"
goto comp

:vs9
call "%VS90COMNTOOLS%vsvars32.bat"
goto comp

:vs10
call "%VS100COMNTOOLS%vsvars32.bat"
goto comp

:vs11
call "%VS110COMNTOOLS%vsvars32.bat"
goto comp

:vs12
call "%VS120COMNTOOLS%vsvars32.bat"
goto comp

:comp
%vs_comp% %1 %2 %3 %4 %5 %6 %7 %8 %9

