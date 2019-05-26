program aradar;

{$R 'ar_resources.res' 'ar_resources.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  XML.XMLIntf,
  XML.XMLDoc,
  uCommonTools in 'P:\Repository\uCommonTools.pas',
  uMain in 'uMain.pas' {frmMain},
  uForm in 'P:\Repository\uForm.pas' {frmForm},
  uClasses in 'uClasses.pas',
  uEditGroup in 'uEditGroup.pas' {frmEditGroup},
  uEditGroupMemo in 'uEditGroupMemo.pas' {frmEditGroupMemo},
  uEditHost in 'uEditHost.pas' {frmEditHost},
  uProps in 'uProps.pas' {frmProps},
  uIconDlg in 'uIconDlg.pas' {frmIconDlg},
  uPWD in 'uPWD.pas' {frmPWD},
  uChangePWD in 'uChangePWD.pas' {frmChangeMasterPWD},
  uNetworkTools in 'uNetworkTools.pas' {frmNetworkTools},
  uDataManager in 'uDataManager.pas' {frmDataManager},
  uEditProtocol in 'uEditProtocol.pas' {frmEditProtocol},
  uEditSoft in 'uEditSoft.pas' {frmEditSoft},
  uXMLTools in 'P:\Repository\uXMLTools.pas',
  uExportImport in 'uExportImport.pas' {frmExportImport},
  uEditCredential in 'uEditCredential.pas' {frmEditCredential},
  uInfo in 'uInfo.pas' {frmInfo},
  uEditAlert in 'uEditAlert.pas' {frmEditAlert},
  uWinSocket in 'P:\Repository\uWinSocket.pas';

{$R *.res}

begin
  CreateOrOpenSharedFile;
  try
    if not IsWindow(PMemFile^.MainHandle) then begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'A-Radar';
  Application.ShowMainForm := False;

      FXML := NewXMLDocument;
      FXML.Options := [doNodeAutoCreate];
      FXML.ParseOptions := [poValidateOnParse];
      if LoadXMLFromFile(FXML, GetMainXMLFileName, True) then begin

  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

      end;

    end else begin
      if ParamStr(1) = APP_CMD_PARAM_CLOSE then PostMessage(PMemFile^.MainHandle, AR_MESSAGE_CLOSE, 0, 0);
    end;
  finally
    CloseSharedFile;
  end;
end.
