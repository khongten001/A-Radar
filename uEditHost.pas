unit uEditHost;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, Vcl.StdCtrls, Vcl.ExtCtrls,
  XMLIntf, SynEditPrint, SynEditOptionsDialog, SynURIOpener, SynEdit,
  Vcl.ComCtrls, SynEditHighlighter, SynHighlighterURI, SynEditMiscClasses,
  SynEditSearch,
  uClasses, Vcl.Buttons, PngSpeedButton, ICSSpinLabeledEdit, PngBitBtn,
  System.ImageList, Vcl.ImgList, PngImageList, ICSBrowseFolder, Vcl.Menus,
  Vcl.Imaging.pngimage;

type
  TfrmEditHost = class(TfrmForm)
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    PageControlMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    leErrorInterval: TICSSpinLabeledEdit;
    leTimeout: TICSSpinLabeledEdit;
    leInterval: TICSSpinLabeledEdit;
    lePort: TICSSpinLabeledEdit;
    leHost: TLabeledEdit;
    leName: TLabeledEdit;
    SynURIOpener1: TSynURIOpener;
    SynURISyn1: TSynURISyn;
    ImageLogo: TImage;
    SynEditMemo: TSynEdit;
    leUsername: TLabeledEdit;
    lePassword: TLabeledEdit;
    ICSLanguagesOpenWith: TICSLanguages;
    sbShowPWD: TPngSpeedButton;
    ICSLanguagesProtocols: TICSLanguages;
    leResources: TLabeledEdit;
    btnDefaultPort: TPngBitBtn;
    ICSLanguagesResult: TICSLanguages;
    btnParse: TPngBitBtn;
    cbProtocol: TComboBoxEx;
    LabelProtocol: TLabel;
    cbActive: TCheckBox;
    leDomain: TLabeledEdit;
    TabSheet3: TTabSheet;
    SynEditParamFile1: TSynEdit;
    PngImageListLocations: TPngImageList;
    PngImageListSoftware: TPngImageList;
    btnBrowse: TPngBitBtn;
    ICSBrowseFolder1: TICSBrowseFolder;
    ICSLanguagesShowWindow: TICSLanguages;
    btnCredentials: TPngBitBtn;
    PopupMenuCredentials: TPopupMenu;
    PngImageListCredentials: TPngImageList;
    PngImageListAlerts: TPngImageList;
    TabSheet4: TTabSheet;
    cbSendReceive: TCheckBox;
    leSendString: TLabeledEdit;
    leReceiveString: TLabeledEdit;
    cbCheckModified: TCheckBox;
    cbUseAlerts: TCheckBox;
    cbAlerts: TComboBoxEx;
    PngImageListTabs: TPngImageList;
    Label1: TLabel;
    Label2: TLabel;
    cbRunAsAdmin: TCheckBox;
    cbSoftware: TComboBoxEx;
    cbShowWindow: TComboBox;
    btnCheckConnection: TPngBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbServiceChange(Sender: TObject);
    procedure sbShowPWDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbShowPWDMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDefaultPortClick(Sender: TObject);
    procedure btnCheckConnectionClick(Sender: TObject);
    procedure btnParseClick(Sender: TObject);
    procedure cbProtocolClick(Sender: TObject);
    procedure leHostChange(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure cbRunAsAdminClick(Sender: TObject);
    procedure btnCredentialsClick(Sender: TObject);
    procedure PopupMenuCredentialsPopup(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FXMLNode: IXMLNode;
    FMultiEdit: Boolean;
    FCurrentObjectLocation: TARObjectLocation;
    procedure OnAppSetLanguageMsg(var Msg: TMessage); message ICS_SETLANGUAGE_MSG;
    procedure SetControlEnables;
    procedure DoParseData;
    procedure OnPopupMenuCredentials(Sender: TObject);
  public
    procedure FillControls(MultiEdit: Boolean);
    procedure ApplyXML;
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
  end;

var
  frmEditHost: TfrmEditHost;

implementation

{$R *.dfm}

uses
  WinINet, uCommonTools, uVCLTools, IdURI, uXMLTools, uRegistry, uRegDlg, uWinSocket;

{ TfrmEditHost }

procedure TfrmEditHost.DoParseData;
 var
   URI: TIdURI;
   S: String;
begin
  leHost.Text := Trim(leHost.Text);
  case TARObjectLocation(xmlGetItemInteger(IXMLNode(cbProtocol.ItemsEx[cbProtocol.ItemIndex].Data).ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE)) of
    olNetwork: begin
      if Pos('//', leHost.Text) > 0 then begin
        URI := TIdURI.Create(leHost.Text);
        try
          leHost.Text := URI.Host;
          leResources.Text :=  URI.Path + URI.Params;
          if URI.Port <> '' then lePort.Text := URI.Port;
          leUsername.Text := URI.Username;
          lePassword.Text := URI.Password;
        finally
          URI.Free;
        end;
      end else begin
        if Pos(':', leHost.Text) > 1 then begin
          lePort.Text := IntToStr(StrToIntDef(icsExtractWord(2, leHost.Text, ':'), 0));
          leHost.Text := icsExtractWord(1, leHost.Text, ':');
        end;
      end;
    end;
    olLocalOrShared: if Pos('\', leHost.Text) > 0 then begin
      leResources.Text := Copy(leHost.Text, Pos('\', leHost.Text) + 1, Length(leHost.Text));
      leHost.Text := Copy(leHost.Text, 1, Pos('\', leHost.Text));
    end;
    olRegistry: begin
      if Pos('\', leHost.Text) > 0 then begin
        S := leHost.Text;
        leHost.Text := icsExtractWord(1, leHost.Text, '\');
        leResources.Text := Copy(S, Length(leHost.Text) + 2, Length(S));
      end;
    end;
  end;
end;

procedure TfrmEditHost.btnParseClick(Sender: TObject);
begin
  inherited;
  DoParseData;
end;

procedure TfrmEditHost.btnBrowseClick(Sender: TObject);
 var
   RKD: TRegistryKeyData;
   bOk: Boolean;
begin
  inherited;
  bOk := False;
  case FCurrentObjectLocation of
    olLocalOrShared: begin
      ICSBrowseFolder1.Directory := icsExpandString(BuildFullPath(leHost.Text, leResources.Text));
      bOk := ICSBrowseFolder1.Execute(Handle);
      if bOk then leHost.Text := ICSBrowseFolder1.Directory;
    end;
    olRegistry: begin
      bOk := SelectRegistryKey(Self, RKD, BuildFullPath(leHost.Text, leResources.Text));
      if bOk then leHost.Text := RKD.FullPath;
    end;
  end;
  if bOk then DoParseData;
end;

procedure TfrmEditHost.btnCheckConnectionClick(Sender: TObject);
 var
   Result: Integer;
   ReceivedString: String;
   Flags: DWORD;
begin
  inherited;
  Result := AR_CONNECT_FAIL;
  Screen.Cursor := crHourGlass;
  try
    ReceivedString := leReceiveString.Text;
    Result := ConnectTimeOut(leHost.Text, StrToIntDef(lePort.Text, 0), StrToIntDef(leTimeout.Text, 0) * 1000, cbSendReceive.Checked, leSendString.Text, ReceivedString);
    leReceiveString.Text := ReceivedString;
  finally
    if Result = AR_CONNECT_SUCCESS then Flags := MB_ICONINFORMATION else if Result = AR_CONNECT_TIMEOUT then FLags := MB_ICONEXCLAMATION else Flags := MB_ICONERROR;
    Screen.Cursor := crDefault;
    MessageBox(Handle, PChar(ICSLAnguagesResult.CurrentStrings[Result + 2]), PChar(Application.Title), MB_OK or Flags);
  end;
end;

procedure TfrmEditHost.btnCredentialsClick(Sender: TObject);
 var P: TPoint;
begin
  inherited;
  P.X := 0;
  P.Y := btnCredentials.Height;
  P := btnCredentials.ClientToScreen(P);
  PopupMenuCredentials.Popup(P.X, P.Y);
end;

procedure TfrmEditHost.btnDefaultPortClick(Sender: TObject);
begin
  inherited;
  if cbProtocol.ItemIndex >= 0 then lePort.Text := xmlGetItemString(IXMLNode(cbProtocol.ItemsEx[cbProtocol.ItemIndex].Data).ChildNodes[ND_PORT], ND_PARAM_VALUE);
end;

procedure TfrmEditHost.cbProtocolClick(Sender: TObject);
 var
   I, J, Idx: Integer;
   iSoftwareNode: IXMLNode;
   bFound: Boolean;
   ProtocolId: String;
   Ico: TIcon;
begin
  inherited;
  cbSoftware.Items.Clear;
  PngImageListSoftware.Clear;
  Ico := TIcon.Create;
  try
    if cbProtocol.ItemIndex >= 0 then begin
      ProtocolId := xmlGetItemString(IXMLNode(cbProtocol.ItemsEx[cbProtocol.ItemIndex].Data), ND_PARAM_ID);
      FCurrentObjectLocation := TARObjectLocation(xmlGetItemInteger(IXMLNode(cbProtocol.ItemsEx[cbProtocol.ItemIndex].Data).ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE));
      iSoftwareNode := FXML.DocumentElement.ChildNodes[ND_SOFTWARE];
      for I := 0 to iSoftwareNode.ChildNodes.Count - 1 do begin
        for J := 0 to iSoftwareNode.ChildNodes[I].ChildNodes[ND_PROTOCOLS].ChildNodes.Count - 1 do begin
          bFound := xmlGetItemString(iSoftwareNode.ChildNodes[I].ChildNodes[ND_PROTOCOLS].ChildNodes[J], ND_PARAM_VALUE) = ProtocolId;
          if bFound then begin
            Ico.Handle := icsGetIconHandleFromFileName(icsB64Decode(xmlGetItemString(iSoftwareNode.ChildNodes[I].ChildNodes[ND_PATH], ND_PARAM_VALUE)));
            if Ico.Handle <> 0 then Idx := PngImageListSoftware.AddIcon(Ico) else Idx := -1;
            cbSoftware.ItemsEx.AddItem(icsB64Decode(xmlGetItemString(iSoftwareNode.ChildNodes[I].ChildNodes[ND_NAME], ND_PARAM_VALUE)), Idx, Idx, Idx, 0, Pointer(iSoftwareNode.ChildNodes[I]));
            Break;
          end;
        end;
      end;
      for I := 0 to cbSoftware.ItemsEx.Count - 1 do if xmlGetItemString(IXMLNode(cbSoftware.ItemsEx[I].Data), ND_PARAM_ID) = xmlGetItemString(FXMLNode.ChildNodes[ND_SOFT_ID], ND_PARAM_VALUE) then begin
        cbSoftware.ItemIndex := I;
        Break;
      end;
      if (cbSoftware.ItemIndex < 0) and (cbSoftware.ItemsEx.Count > 0) then begin
        cbSoftware.ItemIndex := 0;
        cbSoftware.OnChange(Self);
      end;
    end;
  finally
    Ico.Free;
    SetControlEnables;
  end;
end;

procedure TfrmEditHost.cbRunAsAdminClick(Sender: TObject);
begin
  inherited;
  SetControlEnables;
end;

procedure TfrmEditHost.cbServiceChange(Sender: TObject);
begin
  inherited;
  SetControlEnables;
  PageControlMain.ActivePageIndex := 0;
end;

procedure TfrmEditHost.FillControls(MultiEdit: Boolean);
 var
   I, Idx: Integer;
   iNode: IXMLNode;
begin
  FMultiEdit := MultiEdit;
  cbActive.Checked := xmlGetItemBoolean(FXMLNode, ND_PARAM_ACTIVE);

  cbRunAsAdmin.AllowGrayed := FMultiEdit;
  cbSendReceive.AllowGrayed := FMultiEdit;
  cbCheckModified.AllowGrayed := FMultiEdit;
  cbUseAlerts.AllowGrayed := FMultiEdit;

  leName.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);
  leHost.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_HOST], ND_PARAM_VALUE);
  leResources.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_RESOURCES], ND_PARAM_VALUE);
  lePort.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
  leInterval.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE);
  leErrorInterval.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE);
  leTimeout.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE);
  leUsername.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
  lePassword.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
  leDomain.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_DOMAIN], ND_PARAM_VALUE);
  cbUseAlerts.State := TCheckBoxState(xmlGetItemInteger(FXMLNode.ChildNodes[ND_ALERTS], ND_PARAM_VALUE));
  cbCheckModified.State := TCheckBoxState(xmlGetItemInteger(FXMLNode.ChildNodes[ND_CHECK_MODIFIED], ND_PARAM_VALUE));
  cbSendReceive.State := TCheckBoxState(xmlGetItemInteger(FXMLNode.ChildNodes[ND_SENDRECEIVE], ND_PARAM_VALUE));
  leSendString.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_SENDSTRING], ND_PARAM_VALUE));
  leReceiveString.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_RECEIVESTRING], ND_PARAM_VALUE));
  cbShowWindow.ItemIndex := xmlGetItemInteger(FXMLNode.ChildNodes[ND_SHOW_WINDOW], ND_PARAM_VALUE);
  cbRunAsAdmin.State := TCheckBoxState(xmlGetItemInteger(FXMLNode.ChildNodes[ND_RUNASADMIN], ND_PARAM_VALUE));

  SynEditParamFile1.Lines.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_PARAMSTRINGS1], ND_PARAM_VALUE));
  SynEditMemo.Lines.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE));

  cbProtocol.Items.Clear;
  iNode := FXML.DocumentElement.ChildNodes[ND_PROTOCOLS];
  for I := 0 to iNode.ChildNodes.Count - 1 do begin
    Idx := xmlGetItemInteger(iNode.ChildNodes[I].ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE);
    cbProtocol.ItemsEx.AddItem(GetDisplayProtocolName(iNode.ChildNodes[I]), Idx, Idx, Idx, 0, Pointer(iNode.ChildNodes[I]));
  end;
  if not MultiEdit then begin
    for I := 0 to cbProtocol.ItemsEx.Count - 1 do if xmlGetItemString(IXMLNode(cbProtocol.ItemsEx[I].Data), ND_PARAM_ID) = xmlGetItemString(FXMLNode.ChildNodes[ND_PROTOCOL_ID], ND_PARAM_VALUE) then begin
      cbProtocol.ItemIndex := I;
      Break
    end;
    if (cbProtocol.ItemIndex >= 0) and Assigned(cbProtocol.OnClick) then cbProtocol.OnClick(Self);
  end;

  cbAlerts.Clear;
  iNode := FXML.DocumentElement.ChildNodes[ND_ALERTS];
  for I := 0 to iNode.ChildNodes.Count - 1 do begin
    Idx := 0;//xmlGetItemInteger(iNode.ChildNodes[I].ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE);
    cbAlerts.ItemsEx.AddItem(icsB64Decode(xmlGetItemString(iNode.ChildNodes[I].ChildNodes[ND_NAME], ND_PARAM_VALUE)), Idx, Idx, Idx, 0, Pointer(iNode.ChildNodes[I]));
  end;
  if not MultiEdit then begin
    for I := 0 to cbAlerts.ItemsEx.Count - 1 do if xmlGetItemString(IXMLNode(cbAlerts.ItemsEx[I].Data), ND_PARAM_ID) = xmlGetItemString(FXMLNode.ChildNodes[ND_ALERT_ID], ND_PARAM_VALUE) then begin
      cbAlerts.ItemIndex := I;
      Break
    end;
    if (cbAlerts.ItemIndex >= 0) and Assigned(cbAlerts.OnClick) then cbAlerts.OnClick(Self);
  end;

end;

procedure TfrmEditHost.ApplyXML;
begin
  if cbActive.Enabled then xmlSetItemBoolean(FXMLNode, ND_PARAM_ACTIVE, cbActive.Checked);

  xmlSetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, leName.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_HOST], ND_PARAM_VALUE, leHost.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_RESOURCES], ND_PARAM_VALUE, leResources.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE, lePort.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE, leInterval.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE, leErrorInterval.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE, leTimeout.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE, leUsername.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE, lePassword.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_DOMAIN], ND_PARAM_VALUE, leDomain.Text);
  xmlSetItemInteger(FXMLNode.ChildNodes[ND_ALERTS], ND_PARAM_VALUE, Ord(cbUseAlerts.State));
  xmlSetItemInteger(FXMLNode.ChildNodes[ND_CHECK_MODIFIED], ND_PARAM_VALUE, Ord(cbCheckModified.State));
  xmlSetItemInteger(FXMLNode.ChildNodes[ND_SENDRECEIVE], ND_PARAM_VALUE, Ord(cbSendReceive.State));
  xmlSetItemString(FXMLNode.ChildNodes[ND_SENDSTRING], ND_PARAM_VALUE, icsB64Encode(leSendString.Text));
  xmlSetItemString(FXMLNode.ChildNodes[ND_RECEIVESTRING], ND_PARAM_VALUE, icsB64Encode(leReceiveString.Text));
  xmlSetItemInteger(FXMLNode.ChildNodes[ND_RUNASADMIN], ND_PARAM_VALUE, Ord(cbRunAsAdmin.State));

  xmlSetItemString(FXMLNode.ChildNodes[ND_PARAMSTRINGS1], ND_PARAM_VALUE, icsB64Encode(SynEditParamFile1.Lines.Text));
  xmlSetItemString(FXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE, icsB64Encode(SynEditMemo.Lines.Text));

  if cbShowWindow.ItemIndex >= 0 then xmlSetItemInteger(FXMLNode.ChildNodes[ND_SHOW_WINDOW], ND_PARAM_VALUE, cbShowWindow.ItemIndex);

  if cbProtocol.ItemIndex >= 0 then xmlSetItemString(FXMLNode.ChildNodes[ND_PROTOCOL_ID], ND_PARAM_VALUE, xmlGetItemString(IXMLNode(cbProtocol.ItemsEx[cbProtocol.ItemIndex].Data), ND_PARAM_ID));
  if cbSoftware.ItemIndex >= 0 then xmlSetItemString(FXMLNode.ChildNodes[ND_SOFT_ID], ND_PARAM_VALUE, xmlGetItemString(IXMLNode(cbSoftware.ItemsEx[cbSoftware.ItemIndex].Data), ND_PARAM_ID));
  if cbAlerts.ItemIndex >= 0 then xmlSetItemString(FXMLNode.ChildNodes[ND_ALERT_ID], ND_PARAM_VALUE, xmlGetItemString(IXMLNode(cbAlerts.ItemsEx[cbAlerts.ItemIndex].Data), ND_PARAM_ID));
end;

procedure TfrmEditHost.SetControlEnables;
begin
  lePort.Enabled := FMultiEdit or (FCurrentObjectLocation in [olNetwork]);
  btnDefaultPort.Enabled := not FMultiEdit and (FCurrentObjectLocation in [olNetwork]);
  cbSendReceive.Enabled := FMultiEdit or (FCurrentObjectLocation in [olNetwork]);
  leSendString.Enabled := FMultiEdit or (cbSendReceive.Enabled and cbSendReceive.Checked);
  leReceiveString.Enabled := FMultiEdit or (cbSendReceive.Enabled and cbSendReceive.Checked);
  btnCheckConnection.Enabled := not FMultiEdit and (FCurrentObjectLocation in [olNetwork]);
  cbCheckModified.Enabled := FMultiEdit or (FCurrentObjectLocation in [olLocalOrShared, olRegistry]);
  btnBrowse.Enabled := FMultiEdit or (FCurrentObjectLocation in [olLocalOrShared, olRegistry]);
  cbAlerts.Enabled := cbUseAlerts.Checked;
end;

procedure TfrmEditHost.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  xmlSetItemInteger(FXML.DocumentElement.ChildNodes[ND_SOFTWARE], ND_PARAM_LAST_PAGE_IDX, PageControlMain.TabIndex);
end;

procedure TfrmEditHost.FormCreate(Sender: TObject);
begin
  inherited;
  PageControlMain.ActivePageIndex := xmlGetItemInteger(FXML.DocumentElement.ChildNodes[ND_SOFTWARE], ND_PARAM_LAST_PAGE_IDX);
  FMultiEdit := False;
end;

procedure TfrmEditHost.FormShow(Sender: TObject);
begin
  inherited;
  SetControlEnables;
end;

procedure TfrmEditHost.leHostChange(Sender: TObject);
begin
  inherited;
  btnParse.Enabled := (leResources.Text = '');
end;

procedure TfrmEditHost.OnAppSetLanguageMsg(var Msg: TMessage);
begin
  inherited;
  cbShowWindow.Items.Clear;
  cbShowWindow.Items.AddStrings(ICSLanguagesShowWindow.CurrentStrings);
end;

procedure TfrmEditHost.OnPopupMenuCredentials(Sender: TObject);
 var iNode: IXMLNode;
begin
  iNode := FXML.DocumentElement.ChildNodes[ND_CREDENTIALS];
  leUsername.Text := xmlGetItemString(iNode.ChildNodes[(Sender as TComponent).Tag].ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
  lePassword.Text := xmlGetItemString(iNode.ChildNodes[(Sender as TComponent).Tag].ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
  leDomain.Text := xmlGetItemString(iNode.ChildNodes[(Sender as TComponent).Tag].ChildNodes[ND_DOMAIN], ND_PARAM_VALUE);
end;

procedure TfrmEditHost.PageControlMainChange(Sender: TObject);
begin
  inherited;
  if Visible then case PageControlMain.ActivePageIndex of
    2: SynEditParamFile1.SetFocus;
    3: SynEditMemo.SetFocus;
  end;
end;

procedure TfrmEditHost.PopupMenuCredentialsPopup(Sender: TObject);
 var
   iNode: IXMLNode;
   I: Integer;
   MI: TMenuItem;
begin
  inherited;
  iNode := FXML.DocumentElement.ChildNodes[ND_CREDENTIALS];
  PopupMenuCredentials.Items.Clear;
  if iNode.ChildNodes.Count = 0 then begin
    MI := TMenuItem.Create(Self);
    MI.Enabled := False;
    MI.Caption := ICSLanguages1.CurrentStrings[34];
    MI.ImageIndex := 0;
    PopupMenuCredentials.Items.Add(MI);
  end else for I := 0 to iNode.ChildNodes.Count - 1 do begin
    MI := TMenuItem.Create(Self);
    MI.Tag := I;
    MI.Caption := icsB64Decode(xmlGetItemString(iNode.ChildNodes[I].ChildNodes[ND_NAME], ND_PARAM_VALUE));
    MI.ImageIndex := 0;
    MI.OnClick := OnPopupMenuCredentials;
    PopupMenuCredentials.Items.Add(MI);
  end;
end;

procedure TfrmEditHost.sbShowPWDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lePassword.PasswordChar := #0;
end;

procedure TfrmEditHost.sbShowPWDMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lePassword.PasswordChar := '*';
end;

end.
