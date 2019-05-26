[Setup]
AppName=A-Radar
AppId=DEB2B07E-46E6-4F35-92FB-21739786925A
AppVerName=A-Radar
AppPublisher=Chensky IT-Services
AppPublisherURL=http://www.chensky.de/
AppVersion=4.3
AppCopyright=Copyright (C) 1992 - 2019 Chensky IT-Services.

DefaultDirName={pf}\A-Radar
DefaultGroupName=A-Radar
UninstallDisplayIcon={app}\aradar.exe
UninstallDisplayName=A-Radar
OutputDir=D:\cryptoDira.com\0\A70F4593F-A711-4C1F-BEAF-FD480A8193A3
OutputBaseFilename=arsetup
ShowLanguageDialog=no
Compression=lzma/ultra
SolidCompression=yes
DisableProgramGroupPage=yes
DisableReadyPage=yes

VersionInfoVersion=1.1
VersionInfoCompany=Chensky IT-Services
VersionInfoCopyright=Copyright (C) 1992 - 2019 Chensky IT-Services.
VersionInfoDescription=A-Radar
VersionInfoProductName=A-Radar
VersionInfoProductVersion=1.1
VersionInfoTextVersion=1.1

MinVersion=5.0
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=P:\Programs\ATools\atools.bmp

[Messages]
BeveledLabel=  Chensky IT-Services

[Files]
Source: "D:\cryptoDira.com\0\A70F4593F-A711-4C1F-BEAF-FD480A8193A3\aradar.exe"; DestDir: "{app}";

[Icons]
Name: "{group}\A-Radar"; Filename: "{app}\aradar.exe"; WorkingDir: "{app}"

[Run]
Filename: "{app}\aradar.exe"; Description: "A-Radar"; WorkingDir: "{app}"; Flags: postinstall nowait

[UninstallRun]
Filename: "{app}\aradar.exe"; Parameters: "-c"; WorkingDir: "{app}"; Flags: waituntilterminated
