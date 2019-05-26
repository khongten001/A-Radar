unit uNotifyChange;

interface

uses
  Windows, SysUtils, Classes;

type
  TNotifyType = (ntLocalOrSharedFolder, ntRegistryKey);

  TNotifyThread = class(TThread)
  private
    FNotifyHandle: THandle;
    FEvent: THandle;
    FLastError: DWORD;
    FCurrentKey: HKEY;
    FNotifyType: TNotifyType;
    FObjectName: String;
    procedure OnChanged;
  protected
    procedure Execute; override;
  public
    constructor Create(const NotifyType: TNotifyType; const ObjectName: String);
    property LastError: DWORD read FLastError;
  end;

implementation

uses
  uRegistry;

const
  FILE_NOTIFY_FLAGS = FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_DIR_NAME or FILE_NOTIFY_CHANGE_SIZE or FILE_NOTIFY_CHANGE_LAST_WRITE or FILE_NOTIFY_CHANGE_CREATION;
  REG_NOTIFY_FLAGS = REG_NOTIFY_CHANGE_NAME	or REG_NOTIFY_CHANGE_ATTRIBUTES or REG_NOTIFY_CHANGE_LAST_SET	or REG_NOTIFY_CHANGE_SECURITY;

constructor TNotifyThread.Create(const NotifyType: TNotifyType; const ObjectName: String);
begin
  inherited Create;
  FNotifyHandle := INVALID_HANDLE_VALUE;
  FLastError := ERROR_SUCCESS;
  FCurrentKey := 0;
  FNotifyType := NotifyType;
  FObjectName := ObjectName;
end;

procedure TNotifyThread.Execute;
 var
   RKD: TRegistryKeyData;
   Handles: array [0..1] of THandle;
begin
  FEvent := CreateEvent(nil, True, False, nil);
  if FEvent <> 0 then case FNotifyType of
    ntLocalOrSharedFolder: FNotifyHandle := FindFirstChangeNotification(PChar(FObjectName), True, FILE_NOTIFY_FLAGS);
    ntRegistryKey: begin
      RKD := GetRegistryKeyData(FObjectName);
      if RegOpenKeyEx(RKD.RootKey, PChar(RKD.SubKey), 0, KEY_NOTIFY, FCurrentKey) = ERROR_SUCCESS then FNotifyHandle := RegNotifyChangeKeyValue(FCurrentKey, True, REG_NOTIFY_FLAGS, FEvent, True);
    end;
  end;
  if FNotifyHandle = INVALID_HANDLE_VALUE then FLastError := GetLastError else begin

    while not Terminated and (FNotifyHandle <> INVALID_HANDLE_VALUE) do begin
      case FNotifyType of
        ntLocalOrSharedFolder: begin
          Handles[0] := FNotifyHandle;
          Handles[1] := FEvent;
          case WaitForMultipleObjects(2, PWOHandleArray(@Handles), False, INFINITE) of
            WAIT_OBJECT_0: if not Terminated then begin
              OnChanged;
              if not FindNextChangeNotification(FNotifyHandle) then FLastError := GetLastError;
            end;
            WAIT_OBJECT_0 + 1: ;
            WAIT_FAILED: FLastError := GetLastError;
          end;
        end;
        ntRegistryKey: case WaitForSingleObject(FEvent, INFINITE) of
          WAIT_OBJECT_0: if not Terminated then begin
            OnChanged;
            FNotifyHandle := RegNotifyChangeKeyValue(FCurrentKey, True, REG_NOTIFY_FLAGS, FEvent, True);
          end;
          WAIT_FAILED: FLastError := GetLastError;
        end;
      end;
    end;

    if FNotifyHandle <> INVALID_HANDLE_VALUE then case FNotifyType of
      ntLocalOrSharedFolder: FindCloseChangeNotification(FNotifyHandle);
      ntRegistryKey: if FCurrentKey <> 0 then RegCloseKey(FCurrentKey);
    end;

    if FEvent <> 0 then begin
      CloseHandle(FEvent);
      FEvent := 0;
    end;

  end;
end;

procedure TNotifyThread.OnChanged;
begin
  if FEvent <> 0 then SetEvent(FEvent);
end;

end.

