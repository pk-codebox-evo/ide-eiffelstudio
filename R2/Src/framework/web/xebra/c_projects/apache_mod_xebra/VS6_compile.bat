cl.exe /Od /I "C:\apache_src\srclib\apr-util\include" /I "C:\apache_src\srclib\apr\include" /I "C:\apache_src\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_WINDLL" /FD /EHsc /MT /W3 /c mod_xebra.c
link.exe /OUT:"mod_xebra.so" /DLL /DYNAMICBASE /NXCOMPAT /MANIFEST /MANIFESTFILE:"mod_xebra.so.intermediate.manifest"  /SUBSYSTEM:WINDOWS ws2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib "C:\apache_src\debug\libhttpd.lib" "C:\apache_src\srclib\apr\debug\libapr-1.lib" "C:\apache_src\srclib\apr-util\debug\libaprutil-1.lib" "mod_xebra.obj"