@echo off
rem
rem	<description>
rem		description: "Entry point to the automatic build script, for use on windows machines"
rem		author: "bherlig, es-make Project Team, ETH Zurich"
rem	</description>
rem


rem common definitions
set find_bin=%SYSTEMROOT%\system32\find

rem checking for find.exe
%FIND_BIN% 2> NUL:
if not %ERRORLEVEL%==2 goto find_error

rem checking for geant
geant nonexistingtarget 2> NUL:
if not %ERRORLEVEL%==1 goto geant_error

rem **********************************************************************
rem ATTENTION
rem 
rem win2000 needs reg.exe from the support_tools on the win2k cd to be installed!
rem or get it from here:
rem		http://www.dynawell.com/reskit/microsoft/win2000/reg.zip
rem **********************************************************************

rem checking for reg.exe
reg > tmp
%FIND_BIN% /C "Microsoft" tmp > NUL:
if %ERRORLEVEL%==1 goto reg_error
del tmp

rem version switch
ver > tmp
%FIND_BIN% /C "2000" tmp > NUL:
if %ERRORLEVEL%==0 goto reg_val_win2k
goto reg_val_xp


:reg_val_xp
rem get env-vars from registry
del tmp
reg query HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel60 2> NUL: | %FIND_BIN% "REG_SZ" > keys.txt
for /f "tokens=1,2*" %%a in (keys.txt) do set %%a=%%c
del keys.txt
goto command_switch

:reg_val_win2k
del tmp
rem get env-vars from registry
reg query HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel60 | %FIND_BIN% "REG_SZ" > keys.txt
for /f "tokens=1,2*" %%a in (keys.txt) do set %%b=%%c
del keys.txt
goto command_switch

:command_switch
if .%1. == .check_setup. goto check_setup
if .%1. == .build_workbench. goto build_dev
if .%1. == .make_delivery. goto build_delivery
if .%1. == .clean. goto clean

:usage
geant help
goto end
	
:check_setup
geant check_setup
goto end

:build_dev
geant build_workbench
goto end

:build_delivery
geant make_delivery
goto end

:clean
geant clean
goto end

:find_error
echo ===============================================================================
echo find.exe not found, aborting ...
echo ===============================================================================
goto end

:geant_error
del tmp
echo ===============================================================================
echo geant not found, aborting ...
echo You can compile geant from precompiled c code, for example by calling
echo cl library\gobo\src\geant\geant.c
echo Just make sure that you add the binary to your path afterwards.
echo ===============================================================================
goto end

:reg_error
del tmp
echo ===============================================================================
echo Reg.exe is not installed. Install it from the Windows 2000 Support Tools (from the Install CD), or download it from here: http://www.dynawell.com/reskit/microsoft/win2000/reg.zip 
echo ===============================================================================
goto end

:end
set find_bin=
echo.

