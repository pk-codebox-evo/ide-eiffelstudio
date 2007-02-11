@echo off

rem common definitions
set find_bin=%SYSTEMROOT%\system32\find

rem
rem ATTENTION
rem 
rem win2000 needs reg.exe from the support_tools on the win2k cd to be installed!
rem or get it from here:
rem		http://www.dynawell.com/reskit/microsoft/win2000/reg.zip
rem

rem checking for reg.exe
reg > tmp
%FIND_BIN% /C "Microsoft" tmp
if %ERRORLEVEL%==1 goto reg_error
del tmp

rem
rem get env-vars from registry
rem
reg query HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel60 | %FIND_BIN% "REG_SZ" > keys.txt
for /f "tokens=1,2*" %%a in (keys.txt) do set %%b=%%c
del keys.txt

rem command switch
if .%1. == .check_setup. goto check_setup
if .%1. == .build_dev. goto build_dev
if .%1. == .build_delivery. goto build_delivery
if .%1. == .clean. goto clean

:usage
echo EiffelStudio source tree:
echo		The following targets are available:
echo        check_setup		- Check if everything is correctly setup
echo        build_dev		- Setup an environment for development
echo        build_delivery	- Build a delivery from the source tree
echo        clean			- Clean up the tree
goto end
	
:check_setup
geant check_setup
goto end

:build_dev
geant build_dev
goto end

:build_delivery
geant build_delivery
goto end

:clean
geant clean
goto end

:reg_error
del tmp
echo ===============================================================================
echo Reg.exe is not installed. Install it from the Windows 2000 Support Tools (from the Install CD), or download it from here: http://www.dynawell.com/reskit/microsoft/win2000/reg.zip 
echo ===============================================================================

:end
set find_bin=
echo Makefile.bat completed
