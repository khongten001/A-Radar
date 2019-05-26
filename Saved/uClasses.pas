unit uClasses;

interface

uses
  Windows, Messages, Classes, SysUtils, Vcl.ComCtrls, WinSock,
  XML.XMLIntf;

const
  APP_CLSID = '{DEB2B07E-46E6-4F35-92FB-21739786925A}';
  APP_NAME = 'A-Radar';

const
  ND_ROOT                                               = 'aradar';
  ND_PROPERTIES                                         = 'properties';
  ND_GROUPS                                             = 'groups';
  ND_GROUP                                              = 'group';
  ND_HOSTS                                              = 'hosts';
  ND_HOST                                               = 'host';
  ND_RESOURCES                                          = 'resources';
  ND_NAME                                               = 'name';
  ND_PORT                                               = 'port';
  ND_INTERVAL                                           = 'interval';
  ND_ERRORINTERVAL                                      = 'errorInterval';
  ND_TIMEOUT                                            = 'timeout';
  ND_SERVICE                                            = 'service';
  ND_PROTOCOL                                           = 'protocol';
  ND_MEMO                                               = 'memo';
  ND_USERNAME                                           = 'username';
  ND_PASSWORD                                           = 'password';
  ND_ADMIN                                              = 'admin';
  ND_MAXIMIZED                                          = 'maximized';
  ND_PUBLIC                                             = 'public';
  ND_WIDTH                                              = 'width';
  ND_HEIGHT                                             = 'height';
  ND_OPENWITH                                           = 'openWith';
  ND_SENDRECEIVE                                        = 'sendReceive';
  ND_SENDSTRING                                         = 'sendString';
  ND_RECEIVESTRING                                      = 'receiveString';
  ND_RUNASADMIN                                         = 'runAsAdmin';

  ND_RDP_FULLSCREEN                                     = 'fullScreen';

  ND_PARAM_VALUE                                        = 'value';
  ND_PARAM_ID                                           = 'id';
  ND_PARAM_GROUPID                                      = 'groupId';
  ND_PARAM_TITLE                                        = 'title';
  ND_PARAM_STAYONTOP                                    = 'stayOnTop';
  ND_PARAM_COLOR                                        = 'color';
  ND_PARAM_COLLAPSED                                    = 'collapsed';
  ND_PARAM_ACTIVE                                       = 'active';
  ND_PARAM_GROUPVIEW                                    = 'groupView';
  ND_PARAM_ICONID                                       = 'iconID';
  ND_PARAM_LEFT                                         = 'x';
  ND_PARAM_TOP                                          = 'y';
  ND_PARAM_WIDTH                                        = 'w';
  ND_PARAM_HEIGHT                                       = 'h';
  ND_PARAM_START_MINIMIZED                              = 'startMinimized';
  ND_PARAM_STYLE_ID                                     = 'styleID';

  ND_EXT_SOFT                                           = 'externalSoftware';
  ND_EXT_SOFT_MSTSC                                     = 'esMSTSC';
  ND_EXT_SOFT_EXPLORER                                  = 'esExplorer';
  ND_EXT_SOFT_TIGHTVNC                                  = 'esTightVNC';
  ND_EXT_SOFT_FILEZILLA                                 = 'esFileZilla';
  ND_EXT_SOFT_WINSCP                                    = 'esWinSCP';
  ND_EXT_SOFT_BROWSER                                   = 'esBrowser';
  ND_EXT_SOFT_BROWSER_PARAMS                            = 'esBrowserParams';
  ND_EXT_SOFT_ULTRAVNC                                  = 'esUltraVNC';
  ND_EXT_SOFT_TOTALCOMMANDER                            = 'esTotalCommander';
  ND_EXT_SOFT_TOTALCOMMANDER_PARAMS                     = 'esTotalCommanderParams';

const
  REG_AUTORUN_KEY                                       = 'Software\Microsoft\Windows\CurrentVersion\Run';

const
  APP_ARGROUP_ID_FAVORITES                              = MaxInt;
  APP_ARGROUP_ID_GENERAL                                = MaxInt - 1;
  APP_ARGROUP_ID_NORMAL                                 = MaxInt - 2;

  APP_ARGROUP_ID_FIRSTRESERVED                          = APP_ARGROUP_ID_NORMAL;

const
  APP_ARSERVICE_MESSAGE_ID_DELETE_HOSTS                 = 0;
  APP_ARSERVICE_MESSAGE_ID_DELETE_GROUPS                = 1;

type
  TARIndexHelper = class
  private
    FIndex: Integer;
  public
    constructor Create(Data: Integer);
    property Index: Integer read FIndex write FIndex;
  end;

  TARObject = class;

  TARObjectList = class(TList)
  private
    function GetARObject(Index: Integer): TARObject;
    procedure SetARObject(Index: Integer; const Value: TARObject);
  public
    destructor Destroy; override;
    procedure Clear; override;
    function Add(Item: TARObject): Integer;
  public
    procedure Delete(Index: Integer);
    procedure DeleteARObject(Item: TARObject);
    property ARObjects[Index: Integer]: TARObject read GetARObject write SetARObject; default;
  end;

  TARConnectionThread = class(TThread)
  private
    FOwner: TARObject;
    FCounter: Integer;
    FInterval: Integer;
    FErrorInterval: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(Owner: TARObject);
    procedure StartConnect;
    property Owner: TARObject write FOwner;
  end;

  TARState = (aroInactive, aroOffline, aroConnecting, aroOnline);

  TARObject = class
  private
    FConnectionThread: TARConnectionThread;
    FState: TARState;
    FActive: Boolean;
    FXMLNode: IXMLNode;
    procedure SetState(const Value: TARState);
    procedure SetActive(const Value: Boolean);
    procedure DoActive;
    procedure TerminateConnectionThread;
  public
    constructor Create(XMLNode: IXMLNode);
    destructor Destroy; override;
    function DoConnect: Boolean;
    procedure StartConnect;
    procedure Run;
    property State: TARState read FState;
    property Active: Boolean read FActive write SetActive;
    property XMLNode: IXMLNode read FXMLNode;
  end;

  TARRunThread = class(TThread)
  private
    FOwner: TARObject;
  protected
    procedure Execute; override;
  public
    constructor Create(Owner: TARObject);
  end;

  TMemFile = packed record
    MainHandle: HWND;
  end;

  TARService = (sUnknow, sRemoteDesktop, sFileManagement, sWebLink);

  TARProtocol = (pUnknow, pRDP, pVNC, pFTP, pSFTP, pWebDAV, pHTTP, pHTTPS, pTelNet, pSSH);
  TARProtocolSet = set of TARProtocol;

//  TAROpenWith = (owUnknow, owDefault, owMSRDP, owExplorer, owExternal);
  TAROpenWith = (owUnknow, owDefault, owMSRDP, owTightVNC, owFileZilla, owWinSCP, owExplorer, owBrowser, owUltraVNC, owTotalCommander);
  TAROpenWithSet = set of TAROpenWith;

  TARNetworkTool = (ntPing, ntTracert);

  TCommandLineRecord = record
    CMD: String;
    Params: String;
  end;

type
  TARPortDB = array[Low(TARProtocol)..High(TARProtocol)] of Word;

const
  AR_PORT_DB: TARPortDB = (0, 3389, 5900, 21, 22, 443, 80, 443, 23, 22);

type
  TARProtocolDB = array[Low(TARService)..High(TARService)] of TARProtocolSet;

const
  AR_PROTOCOL_DB: TARProtocolDB = (
         [pUnknow],
         [pRDP, pVNC],
         [pFTP, pSFTP, pWebDAV],
         [pHTTP, pHTTPS]
                                );
type
  TAROpenWithDB = array[Low(TARProtocol)..High(TARProtocol)] of TAROpenWithSet;

const
  AR_OPENWITH_DB: TAROpenWithDB = (
         [owUnknow],
         [owMSRDP],
         [owTightVNC, owUltraVNC],
         [owExplorer, owFileZilla, owWinSCP, owTotalCommander],
         [owFileZilla, owWinSCP],
         [owDefault, owWinSCP],
         [owDefault, owBrowser],
         [owDefault, owBrowser],
         [],
         []
                                );

//  AR_MESSAGE_WORK = WM_USER + $07;
  AR_MESSAGE_SETACTIVE = WM_USER + $08;
  AR_MESSAGE_SETSTATE = WM_USER + $09;

type
  TMessageWork = (mwResize);

const
  AR_CONNECT_SUCCESS = 1;
  AR_CONNECT_FAIL = 0;
  AR_CONNECT_TIMEOUT = -1;
  AR_CONNECT_SENDRECEIVE_FAIL = -2;

var
  WSAD: TWSAData;
  PMemFile: ^TMemFile;
  FXML: IXMLDocument = nil;
  GlobalSleepPause: DWORD = 1000;
  ARMasterPassword: String = APP_CLSID;
  ARObjectList: TARObjectList;

function SaveXMLToFile: Boolean;
function GetExternalCommandLine(OW: TAROpenWith): TCommandLineRecord;
function CreateOrOpenSharedFile: Boolean;
procedure CloseSharedFile;
function GetXMLFileName: String;
function GetLogFileName: String;
function GetAutoStart: Boolean;
procedure SetAutoStart(AutoStart: Boolean);
function ConnectTimeOut(InHost: String; InPort: Integer; msTimeout: Integer; SendReceive: Boolean; ToSend: String; var ToReceive: String): Integer;

function GetItemString(XMLNode: IXMLNode; Param: String; Default: String = ''): String;
procedure SetItemString(XMLNode: IXMLNode; Param: String; const Value: String);
function GetItemBoolean(XMLNode: IXMLNode; Param: String; Default: Boolean = False): Boolean;
procedure SetItemBoolean(XMLNode: IXMLNode; Param: String; Value: Boolean);
function GetItemInteger(XMLNode: IXMLNode; Param: String; Default: Integer = 0): Integer;
procedure SetItemInteger(XMLNode: IXMLNode; Param: String; Value: Integer);
function GetItemDateTime(XMLNode: IXMLNode; Param: String; Default: TDateTime): TDateTime;
procedure SetItemDateTime(XMLNode: IXMLNode; Param: String; Value: TDateTime);
procedure XMLNodeCopyAttributes(SourceXMLNode, DestXMLNode: IXMLNode);

implementation

uses
  WinINet, ActiveX, uCommonTools, ShellAPI, uRegLite;

{ TARIndexHelper }

constructor TARIndexHelper.Create(Data: Integer);
begin
  FIndex := Data;
end;

{ --- }

function SaveXMLToFile: Boolean;
 var MS: TMemoryStream;
begin
//  Result := False;
  MS := TMemoryStream.Create;
  try
    FXML.SaveToStream(MS);  FXML.SaveToFile(GetXMLFileName + '.xml');
    Result := icsCryptDecryptStream(MS, ARMasterPassword, True);
    if Result then MS.SaveToFile(GetXMLFileName);
  finally
    MS.Free;
  end;
end;

function GetExternalCommandLine(OW: TAROpenWith): TCommandLineRecord;

 function _GetPropertiesCommandLine: TCommandLineRecord;
  var
    iNode: IXMLNode;
    Buffer: array[0..MAX_PATH - 1] of Char;
 begin
   Result.CMD := '';
   Result.Params := '';
   iNode := FXML.DocumentElement.ChildNodes[ND_PROPERTIES];
   case OW of
     owMSRDP: begin
       Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_MSTSC], ND_PARAM_VALUE));
       if Result.CMD = '' then begin
         GetSystemDirectory(Buffer, MAX_PATH);
         Result.CMD := IncludeTrailingPathDelimiter(String(Buffer)) + 'mstsc.exe';
       end;
     end;
     owTightVNC: Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_TIGHTVNC], ND_PARAM_VALUE));
     owFileZilla: Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_FILEZILLA], ND_PARAM_VALUE));
     owWinSCP: Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_WINSCP], ND_PARAM_VALUE));
     owExplorer: begin
       Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_EXPLORER], ND_PARAM_VALUE));
       if Result.CMD = '' then begin
         GetWindowsDirectory(Buffer, MAX_PATH);
         Result.CMD := IncludeTrailingPathDelimiter(String(Buffer)) + 'explorer.exe';
       end;
     end;
     owBrowser: begin
       Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_BROWSER], ND_PARAM_VALUE));
       Result.Params := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_BROWSER_PARAMS], ND_PARAM_VALUE));
     end;
     owUltraVNC: Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_ULTRAVNC], ND_PARAM_VALUE));
     owTotalCommander: begin
       Result.CMD := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_TOTALCOMMANDER], ND_PARAM_VALUE));
       Result.Params := icsB64Decode(GetItemString(iNode.ChildNodes[ND_EXT_SOFT_TOTALCOMMANDER_PARAMS], ND_PARAM_VALUE));
     end;
   end;
 end;

 function _GetDefaultInstallCommandLine: TCommandLineRecord;

   function _GetEXEFileName: String;
   begin
     case OW of
       owTightVNC: Result := 'TightVNC\tvnviewer.exe';
       owFileZilla: Result := 'FileZilla FTP Client\filezilla.exe';
       owWinSCP: Result := 'WinSCP\WinSCP.exe';
       owUltraVNC: Result := 'uvnc bvba\UltraVNC\vncviewer.exe';
       owTotalCommander: Result := 'TotalCMD\totalcmd.exe';
       else Result := '';
     end;
   end;

  const
    ENV_VAR_PROGRAM_FILES_X86 = 'ProgramFiles(x86)';
    ENV_VAR_PROGRAM_FILES = 'ProgramFiles';
 begin
   Result.CMD := IncludeTrailingPathDelimiter(GetEnvironmentVariable(ENV_VAR_PROGRAM_FILES)) + _GetEXEFileName;
   if not FileExists(Result.CMD) then Result.CMD := IncludeTrailingPathDelimiter(GetEnvironmentVariable(ENV_VAR_PROGRAM_FILES_X86)) + _GetEXEFileName;
   if not FileExists(Result.CMD) then Result.CMD := '';
   Result.Params := '';
 end;

begin
  Result := _GetPropertiesCommandLine;
  if Result.CMD = '' then Result := _GetDefaultInstallCommandLine;
end;


var
  MemFileHandle: THandle = 0;

function CreateOrOpenSharedFile: Boolean;
 var Init: Boolean;
begin
  MemFileHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TMemFile), APP_CLSID);
  Result := (MemFileHandle <> 0);
  if Result then begin
    Init := (GetLastError <> ERROR_ALREADY_EXISTS);
    PMemFile := MapViewOfFile(MemFileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    Result := (PMemFile <> nil);
    if Result and Init then FillChar(PMemFile^, SizeOf(TMemFile), 0);
  end;
end;

procedure CloseSharedFile;
begin
  if Assigned(PMemFile) then UnmapViewOfFile(PMemFile);
  if MemFileHandle <> 0 then CloseHandle(MemFileHandle);
end;

function GetXMLFileName: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + ChangeFileExt(ExtractFileName(ParamStr(0)), '.dat');
end;

function GetLogFileName: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + ChangeFileExt(ExtractFileName(ParamStr(0)), '.log');
end;

function GetAutoStart: Boolean;
begin
  Result := (UpperCase(icsGetReplacedString(RegGetString(HKEY_CURRENT_USER, REG_AUTORUN_KEY, APP_NAME), '"', '')) = UpperCase(ParamStr(0)));
end;

procedure SetAutoStart(AutoStart: Boolean);
begin
  if AutoStart then RegSetString(HKEY_CURRENT_USER, REG_AUTORUN_KEY, APP_NAME, '"' + ParamStr(0) + '"') else RegDelValue(HKEY_CURRENT_USER, REG_AUTORUN_KEY, APP_NAME);
end;

function ConnectTimeOut(InHost: String; InPort: Integer; msTimeout: Integer; SendReceive: Boolean; ToSend: String; var ToReceive: String): Integer;
 const
   BUFFER_LENGTH = 8192;
   SLEEP_PAUSE = 100;
 var
   Sock: TSocket;
   Timeout: TTimeVal;
   Addr: TSockAddrIn;
   setW, setE: TFDSet;
   Block, iRecv: LongInt;
   HostEnt: PHostEnt;
   InAddr: TInAddr;
   Buffer: array[0..BUFFER_LENGTH - 1] of AnsiChar;
   Received: String;
begin
  Result := AR_CONNECT_FAIL;
  Sock := socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
  if Sock <> INVALID_SOCKET then try
    Addr.sin_family := AF_INET;
    if icsGetStringWithoutChars(InHost, '.') = icsExtractDigits(InHost) then Addr.sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(InHost))) else begin
      HostEnt := gethostbyname(PAnsiChar(AnsiString(InHost)));
      FillChar(InAddr, SizeOf(InAddr), 0);
      if HostEnt <> nil then with InAddr, HostEnt^ do begin
        S_un_b.s_b1 := h_addr^[0];
        S_un_b.s_b2 := h_addr^[1];
        S_un_b.s_b3 := h_addr^[2];
        S_un_b.s_b4 := h_addr^[3];
      end;
      Addr.sin_addr := InAddr;
    end;
    Addr.sin_port := htons(InPort);
    Block := 1;
    if ioctlsocket(Sock, FIONBIO, Block) = 0 then try
      connect(Sock, Addr, SizeOf(Addr));
      if WSAGetLastError = WSAEWOULDBLOCK then begin
        FD_ZERO(setW);
        FD_SET(Sock, setW);
        FD_ZERO(setE);
        FD_SET(Sock, setE);
        Timeout.tv_sec := msTimeout div 1000;
        Timeout.tv_usec := (msTimeout mod 1000) * 1000;
        select(0, nil, @setW, @setE, @Timeout);
        if FD_ISSET(Sock, setW) then Result := AR_CONNECT_SUCCESS else if FD_ISSET(Sock, setE) then Result := AR_CONNECT_FAIL else Result := AR_CONNECT_TIMEOUT;
        if (Result = 1) and SendReceive then begin
          if ToSend <> '' then begin
            Sleep(SLEEP_PAUSE);
            send(Sock, ToSend[1], Length(ToSend), 0);
          end;
          Received := '';
          repeat
            ZeroMemory(@Buffer, SizeOf(Buffer));
            Sleep(SLEEP_PAUSE);
            iRecv := recv(Sock, Buffer[0], SizeOf(Buffer), 0);
            if (iRecv > 0) and (iRecv <> INVALID_SOCKET) then Received := Received + Trim(String(Buffer));
          until ((iRecv <= 0) or (iRecv = INVALID_SOCKET));
          if Trim(Received) <> Trim(ToReceive) then Result := AR_CONNECT_SENDRECEIVE_FAIL;
          ToReceive := Received;
        end;
      end;
    finally
      Block := 0;
      ioctlsocket(Sock, FIONBIO, Block);
    end;
  finally
    shutdown(Sock, SD_BOTH);
    closesocket(Sock);
  end;
end;

{ TARObject }

procedure TARObject.StartConnect;
begin
  if Assigned(FConnectionThread) then FConnectionThread.StartConnect;
end;

procedure TARObject.TerminateConnectionThread;
begin
  if Assigned(FConnectionThread) then begin
    FConnectionThread.Owner := nil;
    FConnectionThread.Terminate;
    FConnectionThread := nil;
  end;
end;

constructor TARObject.Create(XMLNode: IXMLNode);
begin
  FXMLNode := XMLNode;
  Factive := False;
end;

destructor TARObject.Destroy;
begin
  TerminateConnectionThread;
  inherited;
end;

procedure TARObject.DoActive;
begin
  SendMessage(PMemFile^.MainHandle, AR_MESSAGE_SETACTIVE, Integer(Self), Integer(FActive));
  if FActive and not Assigned(FConnectionThread) then begin
    FConnectionThread := TARConnectionThread.Create(Self);
  end else begin
    TerminateConnectionThread;
    SetState(aroInactive);
  end;
end;

function TARObject.DoConnect: Boolean;
 var
   Host, SendString, ReceiveString: String;
   Port: Word;
   Timeout: Integer;
   SendReceive: Boolean;
begin
  Result := False;
  if FState = aroConnecting then begin
    repeat
      Sleep(100);
    until (FState <> aroConnecting);
    Result := (FState = aroOnline);
  end else begin
    SetState(aroConnecting);
    try
      Host := GetItemString(FXMLNode.ChildNodes[ND_HOST], ND_PARAM_VALUE);
      Port := GetItemInteger(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
      Timeout := GetItemInteger(FXMLNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE);
      if Timeout <= 0 then begin
        SetItemInteger(FXMLNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE, 2);
        Timeout := GetItemInteger(FXMLNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE);
      end;
      if GlobalSleepPause > 0 then Sleep(Random(GlobalSleepPause));
      SendString := '';
      ReceiveString := '';
      SendReceive := GetItemBoolean(FXMLNode.ChildNodes[ND_SENDRECEIVE], ND_PARAM_VALUE);
      if SendReceive then begin
        SendString := icsB64Decode(GetItemString(FXMLNode.ChildNodes[ND_SENDSTRING], ND_PARAM_VALUE));
        ReceiveString := icsB64Decode(GetItemString(FXMLNode.ChildNodes[ND_RECEIVESTRING], ND_PARAM_VALUE));
      end;
      Result := (ConnectTimeOut(Host, Port, Timeout * 1000, SendReceive, SendString, ReceiveString) = AR_CONNECT_SUCCESS);
    finally
      if FActive then begin
        if Result then SetState(aroOnline) else SetState(aroOffline);
      end else SetState(aroInactive);
    end;
  end;
end;

procedure TARObject.Run;
begin
  TARRunThread.Create(Self);
end;

procedure TARObject.SetActive(const Value: Boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    SetItemBoolean(FXMLNode, ND_PARAM_ACTIVE, FActive);
    DoActive;
  end;
end;

procedure TARObject.SetState(const Value: TARState);
begin
  if FState <> Value then begin
    FState := Value;
    SendMessage(PMemFile^.MainHandle, AR_MESSAGE_SETSTATE, Integer(Self), Ord(FState));
  end;
end;

{ TARConnectionThread }

procedure TARConnectionThread.StartConnect;
begin
  FCounter := MaxInt - 1;
end;

constructor TARConnectionThread.Create(Owner: TARObject);
begin
  inherited Create;
  FreeOnTerminate := True;
  FOwner := Owner;
  FInterval := 0;
  FErrorInterval := 0;
  StartConnect;
end;

procedure TARConnectionThread.Execute;
 const
   THREAD_SLEEP_PAUSE = 100;
   THREAD_SEC_ITEMS = 1000 div THREAD_SLEEP_PAUSE;
 var
   CounterSecs: Integer;
begin
  inherited;
  CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
  try
    while not Terminated do begin

      FInterval := GetItemInteger(FOwner.XMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE);
      FErrorInterval := GetItemInteger(FOwner.XMLNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE);

      Inc(FCounter);
      if ((FOwner.State = aroOnline) and (FCounter >= FInterval)) or ((FOwner.State <> aroOnline) and (FCounter >= FErrorInterval)) then begin
        FOwner.DoConnect;
        FCounter := 0;
      end;

      CounterSecs := 0;
      while not Terminated and (CounterSecs < THREAD_SEC_ITEMS) do begin
        Sleep(THREAD_SLEEP_PAUSE);
        Inc(CounterSecs);
      end;

    end;
  finally
    CoUninitialize;
  end;
end;

{ --- }

function GetItemString(XMLNode: IXMLNode; Param: String; Default: String = ''): String;
begin
  if XMLNode.HasAttribute(Param) then Result := XMLNode.Attributes[Param] else Result := Default;
end;

procedure SetItemString(XMLNode: IXMLNode; Param: String; const Value: String);
begin
  XMLNode.Attributes[Param] := Value;
end;

function GetItemBoolean(XMLNode: IXMLNode; Param: String; Default: Boolean = False): Boolean;
begin
  if XMLNode.HasAttribute(Param) then Result := Boolean(StrToIntDef(XMLNode.Attributes[Param], Integer(Default))) else Result := Default;
end;

procedure SetItemBoolean(XMLNode: IXMLNode; Param: String; Value: Boolean);
begin
  XMLNode.Attributes[Param] := IntToStr(Integer(Value));
end;

function GetItemInteger(XMLNode: IXMLNode; Param: String; Default: Integer = 0): Integer;
begin
  if XMLNode.HasAttribute(Param) then Result := Integer(StrToIntDef(XMLNode.Attributes[Param], Default)) else Result := Default;
end;

procedure SetItemInteger(XMLNode: IXMLNode; Param: String; Value: Integer);
begin
  XMLNode.Attributes[Param] := IntToStr(Value);
end;

function GetItemDateTime(XMLNode: IXMLNode; Param: String; Default: TDateTime): TDateTime;
begin
  if XMLNode.HasAttribute(Param) then Result := StrToDateTimeDef(XMLNode.Attributes[Param], Default) else Result := Default;
end;

procedure SetItemDateTime(XMLNode: IXMLNode; Param: String; Value: TDateTime);
begin
  XMLNode.Attributes[Param] := DateTimeToStr(Value);
end;

procedure XMLNodeCopyAttributes(SourceXMLNode, DestXMLNode: IXMLNode);
 var I: Integer;
begin
  if Assigned(SourceXMLNode) and Assigned(DestXMLNode) then for I := 0 to SourceXMLNode.AttributeNodes.Count - 1 do begin
    if SourceXMLNode.AttributeNodes[I].Text <> '' then DestXMLNode.AttributeNodes[SourceXMLNode.AttributeNodes[I].NodeName].Text := SourceXMLNode.AttributeNodes[I].Text;
  end;
end;

type
  PDATA_BLOB = ^DATA_BLOB;
  _CRYPTOAPI_BLOB = record
    cbData: DWORD;
    pbData: LPBYTE;
  end;
  DATA_BLOB = _CRYPTOAPI_BLOB;

  PCRYPTPROTECT_PROMPTSTRUCT = ^CRYPTPROTECT_PROMPTSTRUCT;
  _CRYPTPROTECT_PROMPTSTRUCT = record
    cbSize: DWORD;
    dwPromptFlags: DWORD;
    hwndApp: HWND;
    szPrompt: LPCWSTR;
  end;
  CRYPTPROTECT_PROMPTSTRUCT = _CRYPTPROTECT_PROMPTSTRUCT;

const
  CRYPTPROTECT_UI_FORBIDDEN = $1;

function CryptProtectData(pDataIn: PDATA_BLOB; szDataDescr: PChar; pOptionalEntropy: PDATA_BLOB; pvReserved: Pointer; pPromptStruct: PCRYPTPROTECT_PROMPTSTRUCT; dwFlags: DWORD; pDataOut: PDATA_BLOB): BOOL; stdcall; external 'crypt32.dll' name 'CryptProtectData';
//function CryptUnprotectData(pDataIn: PDATA_BLOB; ppszDataDescr: PPChar; pOptionalEntropy: PDATA_BLOB; pvReserved: Pointer; pPromptStruct: PCRYPTPROTECT_PROMPTSTRUCT; dwFlags: DWORD; pDataOut: PDATA_BLOB): BOOL; stdcall; external 'crypt32.dll' name 'CryptUnprotectData';

function BlobDataToHexStr(P: PByte; I: Integer): String;
 var HexStr: String;
begin
  HexStr := '';
  while (I > 0) do begin
    Dec(I);
    HexStr := HexStr + IntToHex(P^, 2);
    Inc(P);
  end;
  Result := HexStr;
end;

function CryptRDPPassword(Pwd: String): String;
 var DataIn, DataOut: DATA_BLOB;
begin
  Result := '';
  if Pwd <> '' then begin
    DataIn.cbData := Length(Pwd) * SizeOf(Char);
    DataIn.pbData := Pointer(String(Pwd));
    DataOut.cbData := 0;
    DataOut.pbData := nil;
    if CryptProtectData(@DataIn, 'psw', nil, nil, nil, CRYPTPROTECT_UI_FORBIDDEN, @DataOut) then Result := BlobDataToHexStr(DataOut.pbData, DataOut.cbData);
  end;
end;

function CreateMSRDPCommandFile(iNode: IXMLNode): String;
 var SL: TStringList;
begin
  Result := icsGetTempFileName('.tmp');
  SL := TStringList.Create;
  try
    SL.Add('administrative session:i:' + GetItemString(iNode.ChildNodes[ND_ADMIN], ND_PARAM_VALUE));
    SL.Add('allow desktop composition:i:0');
    SL.Add('allow font smoothing:i:0');
//    SL.Add('alternate full address:s:');
    SL.Add('alternate shell:s:');
    SL.Add('audiocapturemode:i:0');
    SL.Add('audiomode:i:0');
    SL.Add('audioqualitymode:i:0');
    SL.Add('authentication level:i:0');
    SL.Add('autoreconnect max retries:i:20');
    SL.Add('autoreconnection enabled:i:1');
    SL.Add('bitmapcachepersistenable:i:1');
    SL.Add('bitmapcachesize:i:1500');
    SL.Add('compression:i:1');
    SL.Add('connect to console:i:' + GetItemString(iNode.ChildNodes[ND_ADMIN], ND_PARAM_VALUE));
    SL.Add('connection type:i:2');
    SL.Add('desktop size id:i:3');
    SL.Add('desktopwidth:i:' + GetItemString(iNode.ChildNodes[ND_WIDTH], ND_PARAM_VALUE));
    SL.Add('desktopheight:i:' + GetItemString(iNode.ChildNodes[ND_HEIGHT], ND_PARAM_VALUE));
    SL.Add('devicestoredirect:s:*'); //*
    SL.Add('disable ctrl+alt+del:i:1');
    SL.Add('disable full window drag:i:0');
    SL.Add('disable menu anims:i:1');
    SL.Add('disable themes:i:0');
    SL.Add('disable wallpaper:i:1');
    SL.Add('disableconnectionsharing:i:0');
    SL.Add('disableremoteappcapscheck:i:0');
    SL.Add('disableprinterredirection:i:0');
    SL.Add('disableclipboardredirection:i:0');
    SL.Add('displayconnectionbar:i:1');
    SL.Add('domain:s:');
    SL.Add('drivestoredirect:s:*'); //*
    SL.Add('enablecredsspsupport:i:1');
    SL.Add('enablesuperpan:i:0');
    SL.Add('full address:s:' + GetItemString(iNode.ChildNodes[ND_HOST], ND_PARAM_VALUE) + ':' + GetItemString(iNode.ChildNodes[ND_PORT], ND_PARAM_VALUE));
    SL.Add('gatewaycredentialssource:i:4');
    SL.Add('gatewayhostname:s:');
    SL.Add('gatewayprofileusagemethod:i:0');
    SL.Add('gatewayusagemethod:i:4');
    SL.Add('keyboardhook:i:2');
    SL.Add('loadbalanceinfo:s:');
    SL.Add('negotiate security layer:i:1');
    SL.Add('password 51:b:' + CryptRDPPassword(GetItemString(iNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE)));
    SL.Add('pinconnectionbar:i:1');
    SL.Add('prompt for credentials:i:0');
    SL.Add('prompt for credentials on client:i:0');
    SL.Add('promptcredentialonce:i:1');
    SL.Add('public mode:i:' + GetItemString(iNode.ChildNodes[ND_PUBLIC], ND_PARAM_VALUE));
    SL.Add('redirectclipboard:i:1');
    SL.Add('redirectcomports:i:0');
    SL.Add('redirectdirectx:i:1');
    SL.Add('redirectdrives:i:0');
    SL.Add('redirectposdevices:i:0');
    SL.Add('redirectprinters:i:0');
    SL.Add('redirectsmartcards:i:0');
    SL.Add('remoteapplicationcmdline:s:');
    SL.Add('remoteapplicationfile:s:');
    SL.Add('remoteapplicationexpandcmdline:i:1');
    SL.Add('remoteapplicationexpandworkingdir:i:1');
    SL.Add('remoteapplicationicon:s:');
    SL.Add('remoteapplicationmode:i:0');
    SL.Add('remoteapplicationname:s:');
    SL.Add('remoteapplicationprogram:s:');
    SL.Add('screen mode id:i:1'); // + IntToStr(GetItemInteger(iNode.ChildNodes[ND_FULLSCREEN], ND_PARAM_VALUE) + 1));
    SL.Add('server port:i:');
    SL.Add('session bpp:i:32');
    SL.Add('shell working directory:s:');
    SL.Add('smart sizing:i:1');
    SL.Add('span monitors:i:1');
    SL.Add('superpanaccelerationfactor:i:1');
    SL.Add('usbdevicestoredirect:s:'); //*
    SL.Add('use multimon:i:0');
    SL.Add('username:s:' + GetItemString(iNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE));
    SL.Add('videoplaybackmode:i:1');
    SL.Add('winposstr:s:');

    SL.SaveToFile(Result);
  finally
    SL.Free;
  end;
end;

function CreateTightVNCCommandFile(iNode: IXMLNode): String;
 var SL: TStringList;
begin
  Result := icsGetTempFileName('.tmp');
  SL := TStringList.Create;
  try
    SL.Add('[connection]');
    SL.Add('host=' + GetItemString(iNode.ChildNodes[ND_HOST], ND_PARAM_VALUE));
    SL.Add('port=' + GetItemString(iNode.ChildNodes[ND_PORT], ND_PARAM_VALUE));
//    SL.Add('password=' + GetItemString(iNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE));
    SL.Add('[options]');
    SL.Add('use_encoding_1=1');
    SL.Add('copyrect=1');
    SL.Add('viewonly=0');
    SL.Add('fullscreen=0');
    SL.Add('8bit=0');
    SL.Add('shared=1');
    SL.Add('belldeiconify=0');
    SL.Add('disableclipboard=0');
    SL.Add('swapmouse=0');
    SL.Add('fitwindow=0');
    SL.Add('cursorshape=1');
    SL.Add('noremotecursor=0');
    SL.Add('preferred_encoding=7');
    SL.Add('compresslevel=-1');
    SL.Add('quality=6');
    SL.Add('localcursor=1');
    SL.Add('scale_den=1');
    SL.Add('scale_num=1');
    SL.Add('local_cursor_shape=1');

    SL.SaveToFile(Result);
  finally
    SL.Free;
  end;
end;

{ TARRunThread }

constructor TARRunThread.Create(Owner: TARObject);
begin
  inherited Create;
  FreeOnTerminate := True;
  FOwner := Owner;
end;

procedure TARRunThread.Execute;
 var
   ARService: TARService;
   ARProtocol: TARProtocol;
   AROpenWith: TAROpenWith;
   CommandLine: TCommandLineRecord;
   Host, Resources, Port, Username, Password, ParamsFileName: String;
   ShowCmd, StartMaximized: Integer;
   RunAsAdmin: Boolean;
begin
  inherited;
  CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
  if Assigned(FOwner) then try

    if FOwner.DoConnect then begin
      ARService := TARService(GetItemInteger(FOwner.XMLNode.ChildNodes[ND_SERVICE], ND_PARAM_VALUE));
      ARProtocol := TARProtocol(GetItemInteger(FOwner.XMLNode.ChildNodes[ND_PROTOCOL], ND_PARAM_VALUE));
      AROpenWith := TAROpenWith(GetItemInteger(FOwner.XMLNode.ChildNodes[ND_OPENWITH], ND_PARAM_VALUE));
      Host := GetItemString(FOwner.XMLNode.ChildNodes[ND_HOST], ND_PARAM_VALUE);
      Resources := GetItemString(FOwner.XMLNode.ChildNodes[ND_RESOURCES], ND_PARAM_VALUE);
      Port := GetItemString(FOwner.XMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
      Username := GetItemString(FOwner.XMLNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
      Password := GetItemString(FOwner.XMLNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
      StartMaximized := GetItemInteger(FOwner.XMLNode.ChildNodes[ND_MAXIMIZED], ND_PARAM_VALUE);
      RunAsAdmin := GetItemBoolean(FOwner.XMLNode.ChildNodes[ND_RUNASADMIN], ND_PARAM_VALUE);

      CommandLine := GetExternalCommandLine(AROpenWith);
      if CommandLine.Params <> '' then CommandLine.Params := CommandLine.Params + ' ';
      if Boolean(StartMaximized) then ShowCmd := SW_SHOWMAXIMIZED else ShowCmd := SW_SHOW;
      ParamsFileName := '';

      case ARService of
        sRemoteDesktop: begin
          case ARProtocol of
            pRDP: begin
              ParamsFileName := CreateMSRDPCommandFile(FOwner.XMLNode);
              CommandLine.Params := ParamsFileName;
            end;
            pVNC: case AROpenWith of
              owTightVNC: begin
                ParamsFileName := '-optionsfile="' + CreateTightVNCCommandFile(FOwner.XMLNode) + '"';
                CommandLine.Params := ParamsFileName;
                if Password <> '' then CommandLine.Params := CommandLine.Params + ' -password=' + Password;
              end;
              owUltraVNC: begin
                CommandLine.Params := Host + ':' + Port;
                if Password <> '' then CommandLine.Params := CommandLine.Params + ' -password ' + Password;
              end;
            end;
          end;
        end;
        sFileManagement: begin
          case ARProtocol of
            pFTP: case AROpenWith of
              owTotalCommander: CommandLine.Params := CommandLine.Params + ' /O /R=ftp://';
              else CommandLine.Params := 'ftp://';
            end;
            pSFTP: CommandLine.Params := 'sftp://';
            pWebDAV: CommandLine.Params := 'https://';
          end;
          if Username <> '' then CommandLine.Params := CommandLine.Params + Username + ':' + Password + '@';
          CommandLine.Params := CommandLine.Params + Host;
          if Port <> '' then CommandLine.Params := CommandLine.Params + ':' + Port;
          CommandLine.Params := CommandLine.Params + Resources;
        end;
        sWebLink: begin
          case ARProtocol of
            pHTTP: CommandLine.Params := CommandLine.Params + 'http://';
            pHTTPS: CommandLine.Params := CommandLine.Params + 'https://';
          end;
          CommandLine.Params := CommandLine.Params + Host;
          if Port <> '' then CommandLine.Params := CommandLine.Params + ':' + Port;
          CommandLine.Params := CommandLine.Params + Resources;
        end;
      end;

//          MessageBox(0, PChar(CommandLine.CMD + ' ' + CommandLine.Params), '', MB_OK); Exit;

      if ARService <> sUnknow then begin
        if CommandLine.CMD = '' then begin
          ShellExecute(GetDesktopWindow, 'open', PChar(CommandLine.Params), '', '', ShowCmd);
        end else begin
          icsStartProcessEx(CommandLine.CMD, CommandLine.Params, ExtractFilePath(CommandLine.CMD), ShowCmd, True, False, RunAsAdmin);
          if FileExists(ParamsFileName) then DeleteFile(ParamsFileName);
        end;
      end;

    end;

  finally
    CoUnInitialize;
  end;
end;

{ TARObjectList }

function TARObjectList.Add(Item: TARObject): Integer;
begin
  Result := inherited Add(Pointer(Item));
end;

procedure TARObjectList.Clear;
 var I: Integer;
begin
  for I := 0 to Count - 1 do ARObjects[I].Free;
  inherited Clear;
end;

procedure TARObjectList.Delete(Index: Integer);
begin
  ARObjects[Index].Free;
  inherited Delete(Index);
end;

procedure TARObjectList.DeleteARObject(Item: TARObject);
 var I: Integer;
begin
  for I := 0 to Count - 1 do if ARObjects[I] = Item then begin
    Delete(I);
    Break;
  end;
end;

destructor TARObjectList.Destroy;
begin
  Clear;
  inherited;
end;

function TARObjectList.GetARObject(Index: Integer): TARObject;
begin
  Result := TARObject(Items[Index]);
end;

procedure TARObjectList.SetARObject(Index: Integer; const Value: TARObject);
begin
  ARObjects[Index].Free;
  Items[Index] := Pointer(Value);
end;

initialization

  WSAStartup($0101, WSAD);
  ARObjectList :=  TARObjectList.Create;

finalization

  ARObjectList.Free;
  WSACleanUp;

end.
