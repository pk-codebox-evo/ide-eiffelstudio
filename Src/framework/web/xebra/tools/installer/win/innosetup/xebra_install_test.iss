; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B312588D-4952-4273-941D-39CAEF12C25F}
AppName=Eiffel Xebra
AppVerName=Eiffel Xebra Pre-Release 0.2
AppPublisher=Eiffel Software
AppPublisherURL=http://dev.eiffel.com/Xebra
AppSupportURL=http://dev.eiffel.com/Xebra
AppUpdatesURL=http://dev.eiffel.com/Xebra
DefaultDirName={pf}\Eiffel Software\Xebra
DefaultGroupName=Eiffel Software
LicenseFile=C:\Users\fabioz\Desktop\gnu.txt
OutputDir=output
OutputBaseFilename=setup
Compression=lzma
SolidCompression=true
SetupLogging=true
AppVersion=0.0.2

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Files]
Source: C:\virtual_box_share\xebra_build\*; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\virtual_box_share\eiffel_src\framework\web\xebra\tools\installer\win\xebra_deployer\EIFGENs\xebra_deployer\F_code\xebra_deployer.exe; DestDir: {tmp}
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: {group}\{cm:ProgramOnTheWeb,Eiffel Xebra}; Filename: http://www.eiffel.com
Name: {group}\{cm:UninstallProgram,Eiffel Xebra}; Filename: {uninstallexe}
Name: {commondesktop}\Launch Xebra; Filename: {app}\bin\launch_xebra.bat; WorkingDir: {app}\bin

[Registry]
Root: HKLM; Subkey: Software\ISE\Eiffel65; ValueType: string; ValueName: XEBRA_DEV; Flags: uninsdeletevalue; Languages: ; ValueData: {app}
Root: HKLM; Subkey: Software\ISE\Eiffel65; ValueType: string; ValueName: XEBRA_LIBRARY; Flags: uninsdeletevalue; Languages: ; ValueData: {app}\library

[Run]
Filename: {tmp}\xebra_deployer.exe; Parameters: """{app}"""; WorkingDir: {app}\bin; Languages: 
