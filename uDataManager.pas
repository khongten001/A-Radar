unit uDataManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, PngImageList, System.Actions,
  Vcl.ActnList, ICSLanguages, Vcl.StdCtrls, Vcl.Buttons, PngBitBtn, XMLIntf,
  Vcl.Menus, PngSpeedButton,
  uClasses;

type
  TfrmDataManager = class(TfrmForm)
    ActionList1: TActionList;
    PngImageListActions: TPngImageList;
    ActionClose: TAction;
    PngImageListItems: TPngImageList;
    PopupMenuItems: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    btnClose: TPngBitBtn;
    tcDataManager: TTabControl;
    LV: TListView;
    PngBitBtn5: TPngBitBtn;
    PngBitBtn6: TPngBitBtn;
    PngBitBtn7: TPngBitBtn;
    ActionItemAdd: TAction;
    ActionItemEdit: TAction;
    ActionItemDelete: TAction;
    ICSLanguagesTabs: TICSLanguages;
    PngImageListDefaults: TPngImageList;
    PngImageListLocations: TPngImageList;
    PngImageListCredentials: TPngImageList;
    ActionSelectAll: TAction;
    procedure ActionCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LVDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionItemDeleteExecute(Sender: TObject);
    procedure ActionItemAddExecute(Sender: TObject);
    procedure ActionItemEditExecute(Sender: TObject);
    procedure tcDataManagerChange(Sender: TObject);
    procedure ActionItemEditUpdate(Sender: TObject);
    procedure ActionItemDeleteUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionSelectAllExecute(Sender: TObject);
  private
    FXMLNodeData: IXMLNode;
    FXMLNodeProperties: IXMLNode;
    FARDataType: TARDataType;
    procedure OnAppSetLanguageMsg(var Msg: TMessage); message ICS_SETLANGUAGE_MSG;
    procedure OnRecreateUserInterface(var Msg: TMessage); message AR_MESSAGE_RECREATE_USER_INTERFACE;
    function EditSoftNode(iNode: IXMLNode): Integer;
    function EditProtNode(iNode: IXMLNode): Integer;
    procedure FillControls;
    procedure ApplyItemParams(LI: TListItem);
    function EditCredentialNode(iNode: IXMLNode): Integer;
    procedure AddNewListItem(iNode: IXMLNode);
  public
  end;

var
  frmDataManager: TfrmDataManager = nil;

implementation

{$R *.dfm}

uses
  uCommonTools, uRegLite, uRegistry, uEditSoft, uEditProtocol, uXMLTools,
  uEditCredential;

procedure TfrmDataManager.AddNewListItem(iNode: IXMLNode);
 var LI: TListItem;
begin
  LI := LV.Items.Add;
  LI.Data := Pointer(iNode);
  LI.ImageIndex := PngImageListItems.AddIcon(Application.Icon);
  ApplyItemParams(LI);
end;

procedure TfrmDataManager.ActionItemAddExecute(Sender: TObject);
 var
   iNode: IXMLNode;
   B: Boolean;
begin
  inherited;
  iNode := FXMLNodeData.AddChild(ND_ITEM);
  if Assigned(iNode) then begin
    xmlSetItemString(iNode, ND_PARAM_ID, icsGenerateGUIDString);
    B := False;
    case FARDataType of
      dtProtocols: B := (EditProtNode(iNode) = mrOk);
      dtSoftware: B := (EditSoftNode(iNode) = mrOk);
      dtCredentials: B := (EditCredentialNode(iNode) = mrOk);
    end;
    if B then AddNewListItem(iNode) else FXMLNodeData.ChildNodes.Remove(iNode);
  end;
end;

procedure TfrmDataManager.ActionItemDeleteExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  if MessageBox(Handle, PChar(ICSLanguages1.CurrentStrings[5]), PChar(Application.Title), MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IdYes then for I := LV.Items.Count - 1 downto 0 do if LV.Items[I].Selected then begin
    IXMLNode(LV.Items[I].Data).ParentNode.ChildNodes.Remove(IXMLNode(LV.Items[I].Data));
    LV.Items.Delete(I);
  end;
end;

procedure TfrmDataManager.ActionItemDeleteUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (LV.SelCount > 0);
end;

procedure TfrmDataManager.ActionItemEditExecute(Sender: TObject);
 var B: Boolean;
begin
  inherited;
  if Assigned(LV.Selected) then begin
    B := False;
    case FARDataType of
      dtProtocols:  B := (EditProtNode(IXMLNode(LV.Selected.Data)) = mrOk);
      dtSoftware: B := (EditSoftNode(IXMLNode(LV.Selected.Data)) = mrOk);
      dtCredentials: B := (EditCredentialNode(IXMLNode(LV.Selected.Data)) = mrOk);
    end;
    if B then ApplyItemParams(LV.Selected);
  end;
end;

procedure TfrmDataManager.ActionItemEditUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (LV.SelCount = 1);
end;

procedure TfrmDataManager.ActionSelectAllExecute(Sender: TObject);
begin
  inherited;
  LV.SelectAll;
end;

procedure TfrmDataManager.ActionCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDataManager.ApplyItemParams(LI: TListItem);
 var Ico: TIcon;
begin
  Ico := TIcon.Create;
  try
    case FARDataType of
      dtProtocols: begin
        LI.Caption := GetDisplayProtocolName(IXMLNode(LI.Data));
        PngImageListLocations.GetIcon(xmlGetItemInteger(IXMLNode(LI.Data).ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE), Ico);
      end;
      dtSoftware: begin
        LI.Caption := icsB64Decode(xmlGetItemString(IXMLNode(LI.Data).ChildNodes[ND_NAME], ND_PARAM_VALUE));
        Ico.Handle := icsGetIconHandleFromFileName(icsB64Decode(xmlGetItemString(IXMLNode(LI.Data).ChildNodes[ND_PATH], ND_PARAM_VALUE)));
      end;
      dtCredentials: begin
        LI.Caption := icsB64Decode(xmlGetItemString(IXMLNode(LI.Data).ChildNodes[ND_NAME], ND_PARAM_VALUE));
        PngImageListCredentials.GetIcon(0, Ico);
      end;
    end;
    if Ico.Handle = 0 then PngImageListDefaults.GetIcon(Ord(FARDataType), Ico);
    PngImageListItems.ReplaceIcon(LI.ImageIndex, Ico);
  finally
    Ico.Free;
  end;

  PostMessage(PMemFile^.MainHandle, AR_MESSAGE_UPDATE_LIST, 0, 0);
end;

function TfrmDataManager.EditSoftNode(iNode: IXMLNode): Integer;
begin
  frmEditSoft := TfrmEditSoft.Create(Self);
  try
    frmEditSoft.SoftXMLNode := iNode;
    Result := frmEditSoft.ShowModal;
    if Result = mrOk then frmEditSoft.ApplyXML;
  finally
    frmEditSoft.Release;
  end;
end;

function TfrmDataManager.EditProtNode(iNode: IXMLNode): Integer;
begin
  frmEditProtocol := TfrmEditProtocol.Create(Self);
  try
    frmEditProtocol.XMLNode := iNode;
    Result := frmEditProtocol.ShowModal;
    if Result = mrOk then frmEditProtocol.ApplyXML;
  finally
    frmEditProtocol.Release;
  end;
end;

function TfrmDataManager.EditCredentialNode(iNode: IXMLNode): Integer;
begin
  frmEditCredential := TfrmEditCredential.Create(Self);
  try
    frmEditCredential.CredentialXMLNode := iNode;
    Result := frmEditCredential.ShowModal;
    if Result = mrOk then frmEditCredential.ApplyXML;
  finally
    frmEditCredential.Release;
  end;
end;

procedure TfrmDataManager.FillControls;
 var I: Integer;
begin
  case FARDataType of
    dtProtocols: FXMLNodeData := FXML.DocumentElement.ChildNodes[ND_PROTOCOLS];
    dtSoftware: FXMLNodeData := FXML.DocumentElement.ChildNodes[ND_SOFTWARE];
    dtCredentials: FXMLNodeData := FXML.DocumentElement.ChildNodes[ND_CREDENTIALS];
    dtAlerts: FXMLNodeData := FXML.DocumentElement.ChildNodes[ND_ALERTS];
  end;

  LV.Items.BeginUpdate;
  try
    LV.Items.Clear;
    PngImageListItems.Clear;
    for I := 0 to FXMLNodeData.ChildNodes.Count - 1 do AddNewListItem(FXMLNodeData.ChildNodes[I]);
  finally
    LV.Items.EndUpdate;
  end;
end;

procedure TfrmDataManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  xmlSetItemInteger(FXMLNodeProperties, ND_PARAM_LEFT, Left);
  xmlSetItemInteger(FXMLNodeProperties, ND_PARAM_TOP, Top);
  xmlSetItemInteger(FXMLNodeProperties, ND_PARAM_WIDTH, Width);
  xmlSetItemInteger(FXMLNodeProperties, ND_PARAM_HEIGHT, Height);
  xmlSetItemInteger(FXMLNodeProperties, ND_PARAM_LAST_PAGE_IDX, tcDataManager.TabIndex);
end;

procedure TfrmDataManager.FormCreate(Sender: TObject);
begin
  inherited;
  FXMLNodeProperties := FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_DATA_MANAGER];
end;

procedure TfrmDataManager.FormDestroy(Sender: TObject);
begin
  inherited;
  frmDataManager := nil;
end;

procedure TfrmDataManager.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  ;
end;

procedure TfrmDataManager.FormShow(Sender: TObject);
begin
  inherited;
  SetBounds(xmlGetItemInteger(FXMLNodeProperties, ND_PARAM_LEFT, Left), xmlGetItemInteger(FXMLNodeProperties, ND_PARAM_TOP, Top), xmlGetItemInteger(FXMLNodeProperties, ND_PARAM_WIDTH, Width), xmlGetItemInteger(FXMLNodeProperties, ND_PARAM_HEIGHT, Height));
  tcDataManager.TabIndex := xmlGetItemInteger(FXMLNodeProperties, ND_PARAM_LAST_PAGE_IDX);
  tcDataManagerChange(Self);
  tcDataManager.OnChange := tcDataManagerChange;
end;

procedure TfrmDataManager.LVDblClick(Sender: TObject);
begin
  inherited;
  if ActionItemEdit.Enabled then ActionItemEdit.Execute;
end;

procedure TfrmDataManager.LVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (Shift = []) and ActionItemEdit.Enabled then ActionItemEdit.Execute;
end;

procedure TfrmDataManager.OnAppSetLanguageMsg(var Msg: TMessage);
begin
  inherited;
  tcDataManager.Tabs.Assign(ICSLanguagesTabs.CurrentStrings);
end;

procedure TfrmDataManager.OnRecreateUserInterface(var Msg: TMessage);
begin
  tcDataManagerChange(Self);
end;

procedure TfrmDataManager.tcDataManagerChange(Sender: TObject);
begin
  inherited;
  FARDataType := TARDataType(tcDataManager.TabIndex);
  FillControls;
end;

end.
