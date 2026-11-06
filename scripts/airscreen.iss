; AirScreen installer (Inno Setup 6)
; iscc /DCrtDir=<VS>\VC\Redist\MSVC\<ver>\x64\Microsoft.VC143.CRT scripts\airscreen.iss
#define MyAppName "AirScreen 简体中文版"
#ifndef MyAppVersion
  #define MyAppVersion "1.1.0-cn1"
#endif
#define MyAppPublisher "AirScreen"
#define MyAppURL "https://github.com/donerfolk/airscreen"
#define MyAppExeName "AirScreen.exe"
#ifndef BuildDir
  #define BuildDir "..\build\Release"
#endif
#ifndef CrtDir
  #error Pass /DCrtDir=<VS>\VC\Redist\MSVC\<ver>\x64\Microsoft.VC143.CRT
#endif

[Setup]
AppId={{C8D6A8B1-4E2A-4C7B-9A21-6F3E2D1B0C91}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases
VersionInfoVersion=1.1.0.0
DefaultDirName={autopf}\AirScreen-简体中文版
DefaultGroupName=AirScreen 简体中文版
OutputDir=..\out\installer
OutputBaseFilename=AirScreen-简体中文版-Setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
PrivilegesRequired=admin
WizardStyle=modern
LicenseFile=..\LICENSE
SetupIconFile=..\src\app\app.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
SetupLogging=yes
CloseApplications=yes

[Files]
; Include the executable and all runtime DLLs copied by CMake (FFmpeg/OpenSSL).
; This avoids missing transitive FFmpeg DLL dependencies in the installed app.
Source: "{#BuildDir}\AirScreen.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#BuildDir}\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#CrtDir}\msvcp140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#CrtDir}\vcruntime140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#CrtDir}\vcruntime140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\NOTICE"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\AirScreen"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\AirScreen"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加快捷方式："
Name: "firewall"; Description: "允许 AirScreen 通过 Windows 防火墙"; GroupDescription: "网络："

[Run]
Filename: "netsh"; Parameters: "advfirewall firewall delete rule name=""AirScreen"""; Flags: runhidden; Tasks: firewall
Filename: "netsh"; Parameters: "advfirewall firewall add rule name=""AirScreen"" dir=in action=allow program=""{app}\{#MyAppExeName}"" enable=yes profile=any"; Flags: runhidden; Tasks: firewall
Filename: "{app}\{#MyAppExeName}"; Description: "启动 AirScreen"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "taskkill"; Parameters: "/f /im {#MyAppExeName}"; Flags: runhidden; RunOnceId: "KillApp"
Filename: "netsh"; Parameters: "advfirewall firewall delete rule name=""AirScreen"""; Flags: runhidden; RunOnceId: "DelFirewall"
