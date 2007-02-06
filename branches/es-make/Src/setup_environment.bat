@echo off
%SystemRoot%\system32\reg query HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel60 | %SystemRoot%\system32\find "REG_SZ" > keys.txt
for /f "tokens=1,2*" %%a in (keys.txt) do set %%a="%%c"
del keys.txt
