unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, ICSLanguages, Vcl.StdCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.AppEvnts,
  System.ImageList, Vcl.ImgList,
  PngImageList, XML.XMLIntf,
  uForm, uClasses, Vcl.ToolWin;

type
  TfrmMain = class(TfrmForm)
    ActionListMain: TActionList;
    PopupMenu1: TPopupMenu;
    ActionHostAdd: TAction;
    ActionHostEdit: TAction;
    ActionHostDelete: TAction;
    ActionClose: TAction;
    ItemAdd: TMenuItem;
    ItemEdit: TMenuItem;
    ItemDelete: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    PngImageListApp: TPngImageList;
    PngImageListMain: TPngImageList;
    N2: TMenuItem;
    ActionOpen: TAction;
    N3: TMenuItem;
    ItemGroupEditMemo: TMenuItem;
    ItemConnect: TMenuItem;
    ListViewMain: TListView;
    ActionSetGroupView: TAction;
    ICSLanguagesGroups: TICSLanguages;
    ActionMoveToNewGroup: TAction;
    PngImageListGroups: TPngImageList;
    ActionMoveToFavorites: TAction;
    ActionDeleteEmptyGroups: TAction;
    ActionStayOnTop: TAction;
    ActionHostClone: TAction;
    ActionCloneHost1: TMenuItem;
    N5: TMenuItem;
    ActionSetActive: TAction;
    ActionSetInactive: TAction;
    ActionGroupCollapseAll: TAction;
    ActionGroupExpandAll: TAction;
    ActionHostSelectAll: TAction;
    ItemSelectAll: TMenuItem;
    ICSLanguagesMessages: TICSLanguages;
    ActionGroupEditMemo: TAction;
    MainMenu1: TMainMenu;
    ItemMainFile: TMenuItem;
    ItemMainEdit: TMenuItem;
    ItemClose: TMenuItem;
    N1: TMenuItem;
    ItemHostAdd: TMenuItem;
    ItemHostEdit: TMenuItem;
    ActionCloneHost2: TMenuItem;
    ItemHostDelete: TMenuItem;
    N7: TMenuItem;
    ItemHostSelectAll: TMenuItem;
    ItemMainGroupEditMemo: TMenuItem;
    ItemGroupExpantAll: TMenuItem;
    ItemGroupCollapseAll: TMenuItem;
    ItemGroupDeleteEmpty: TMenuItem;
    ItemMainView: TMenuItem;
    N9: TMenuItem;
    ItemMainRun: TMenuItem;
    ActionSetGroupView1: TMenuItem;
    ActionStayOnTop1: TMenuItem;
    ItemMainMoveTo: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N10: TMenuItem;
    ItemMainSetActive: TMenuItem;
    ItemMainSetInactive: TMenuItem;
    ItemMoveTo: TMenuItem;
    TrayIcon1: TTrayIcon;
    PopupMenuTray: TPopupMenu;
    ItemTrayClose: TMenuItem;
    ImageList1: TImageList;
    ActionGroupEdit: TAction;
    ItemGroupEdit: TMenuItem;
    N8: TMenuItem;
    ItemMainGroupEdit: TMenuItem;
    ActionProperties: TAction;
    N11: TMenuItem;
    ItemAbout: TMenuItem;
    ActionAbout: TAction;
    ItemProperties: TMenuItem;
    N12: TMenuItem;
    ItemTrayProperties: TMenuItem;
    ItemTrayAbout: TMenuItem;
    TimerGlobalPause: TTimer;
    ActionExecutePing: TAction;
    ItemMainTools: TMenuItem;
    ItemMainPing: TMenuItem;
    ItemExecutePing: TMenuItem;
    ActionExecuteTracert: TAction;
    ItemMainTracert: TMenuItem;
    ItemNetworkTools: TMenuItem;
    ItemExecuteTracert: TMenuItem;
    ActionHostRename: TAction;
    ItemRename: TMenuItem;
    ItemMainRename: TMenuItem;
    N13: TMenuItem;
    TimerUpdate: TTimer;
    ActionDataManager: TAction;
    ItemSoftManager: TMenuItem;
    ItemTrySoftManager: TMenuItem;
    N14: TMenuItem;
    ItemActivate: TMenuItem;
    ItemDeactivate: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    StatusBar1: TStatusBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ActionExportImport: TAction;
    ItemExportImport: TMenuItem;
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionHostEditExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1ModalBegin(Sender: TObject);
    procedure ApplicationEvents1ModalEnd(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ActionHostDeleteUpdate(Sender: TObject);
    procedure ActionGroupEditUpdate(Sender: TObject);
    procedure ActionGroupDeleteUpdate(Sender: TObject);
    procedure ActionHostDeleteExecute(Sender: TObject);
    procedure ActionSetGroupViewExecute(Sender: TObject);
    procedure ActionSetGroupViewUpdate(Sender: TObject);
    procedure ActionHostAddExecute(Sender: TObject);
    procedure ActionMoveToFavoritesExecute(Sender: TObject);
    procedure ActionMoveToNewGroupExecute(Sender: TObject);
    procedure ActionDeleteEmptyGroupsExecute(Sender: TObject);
    procedure ActionMoveToNewGroupUpdate(Sender: TObject);
    procedure ActionStayOnTopExecute(Sender: TObject);
    procedure ActionStayOnTopUpdate(Sender: TObject);
    procedure ActionHostCloneExecute(Sender: TObject);
    procedure ListViewMainItemChecked(Sender: TObject; Item: TListItem);
    procedure ActionSetActiveExecute(Sender: TObject);
    procedure ActionSetInactiveExecute(Sender: TObject);
    procedure ActionSetActiveUpdate(Sender: TObject);
    procedure ActionSetInactiveUpdate(Sender: TObject);
    procedure ActionHostCloneUpdate(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionGroupCollapseAllExecute(Sender: TObject);
    procedure ActionGroupExpandAllExecute(Sender: TObject);
    procedure ActionGroupCollapseAllUpdate(Sender: TObject);
    procedure ActionHostSelectAllUpdate(Sender: TObject);
    procedure ActionHostSelectAllExecute(Sender: TObject);
    procedure ActionHostSelectNoneUpdate(Sender: TObject);
    procedure ListViewMainDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionGroupEditMemoExecute(Sender: TObject);
    procedure CreateGroupMenu(Sender: TObject);
    procedure OnItemGroupClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ItemMainEditClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ActionGroupEditExecute(Sender: TObject);
    procedure ListViewMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionPropertiesExecute(Sender: TObject);
    procedure TimerGlobalPauseTimer(Sender: TObject);
    procedure ActionExecutePingExecute(Sender: TObject);
    procedure ActionExecuteTracertExecute(Sender: TObject);
    procedure ActionAddFirstUpdate(Sender: TObject);
    procedure ListViewMainEdited(Sender: TObject; Item: TListItem;
      var S: string);
    procedure ActionHostRenameExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerUpdateTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ActionDataManagerExecute(Sender: TObject);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionExportImportExecute(Sender: TObject);
  private
    FModalCounter: Integer;
    FListViewWndProc: TWndMethod;
    procedure ListViewWndProc(var Message: TMessage);
    procedure OnWMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure OnWMEndSession(var Msg: TWMEndSession); message WM_ENDSESSION;
    procedure OnMessageSetActive(var Msg: TMessage); message AR_MESSAGE_SETACTIVE;
    procedure OnMessageSetState(var Msg: TMessage); message AR_MESSAGE_SETSTATE;
    procedure OnRecreateList(var Msg: TMessage); message AR_MESSAGE_UPDATE_LIST;
    procedure OnRecreateUserInterface(var Msg: TMessage); message AR_MESSAGE_RECREATE_USER_INTERFACE;
    procedure OnMessageClose(var Msg: TMessage); message AR_MESSAGE_CLOSE;
    procedure RecreateUserInterface;
    function GetNewGroupName: String;
    procedure InitializeHostNode(iNode: IXMLNode; GroupID: Integer; iSourceNode: IXMLNode; MultiEdit: Boolean);
    procedure CreateHostItem(iNode: IXMLNode);
    procedure CreateGroupItem(iNode: IXMLNode);
    procedure ApplyHostParams(aHost: TListItem);
    procedure ApplyGroupParams(aGroup: TListGroup; iNode: IXMLNode);
    procedure ApplyProperties;
    procedure SaveBounds;
    procedure NormalizeGroups;
    procedure SaveGroupProperties;
    function XMLCreateGroup(GroupName: String; GroupID: Integer; EditData: Boolean): Boolean;
    function XMLCreateHost(GroupID: Integer; const iSourceNode: IXMLNode = nil): Boolean;
    procedure SelectedMoveToGroup(GroupID: Integer);
    procedure OnClickMoveToExistedExecute(Sender: TObject);
    function EditHostNode(XMLNode: IXMLNode; MultiEdit: Boolean): Boolean;
    function GetGroupXMLNode(GroupID: Integer): IXMLNode;
    function EditGroupNode(XMLNode: IXMLNode): Boolean;
    procedure ApplyPropertiesOnShow;
    function GetGroupIndex(GroupID: Integer): Integer;
    function GetFocusedGroupIndex: Integer;
    function GetFirstGroupItem(GroupID: Integer): TListItem;
    procedure NetworkToolExecute(NetworkTool: TARNetworkTool);
    function GetCheckedCount: Integer;
    procedure DeleteListItemData(LI: TListItem);
  public
    procedure OnExit;
  end;

var
  frmMain: TfrmMain;
  ShuttingDown: Boolean = False;

implementation

{$R *.dfm}

uses
  ShellAPI, XML.XMLDoc, uCommonTools, uVCLTools, uEditHost, uEditGroup, uEditGroupMemo, uProps,
  uPWD, uNetworkTools, uDataManager, uXMLTools,
  Vcl.Themes, Vcl.Styles, uExportImport, uInfo;

procedure TfrmMain.ActionHostSelectAllExecute(Sender: TObject);
begin
  inherited;
  ListViewMain.SelectAll;
end;

procedure TfrmMain.ActionHostSelectAllUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.Items.Count > 0) and (ListViewMain.Items.Count > ListViewMain.SelCount);
end;

procedure TfrmMain.ActionHostSelectNoneUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 0);
end;

procedure TfrmMain.ActionSetActiveExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  if ListViewMain.SelCount > 1 then begin
    GlobalSleepPause := 1000;
    TimerGlobalPause.Enabled := True;
  end;
  for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected and Assigned(ListViewMain.Items[I].Data) then TARObject(ListViewMain.Items[I].Data).Active := True;
end;

procedure TfrmMain.ActionSetActiveUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 1) or ((ListViewMain.SelCount = 1) and (not TARObject(ListViewMain.Selected.Data).Active));
end;

procedure TfrmMain.ActionSetGroupViewExecute(Sender: TObject);
begin
  inherited;
  ListViewMain.Items.BeginUpdate;
  try
    ListViewMain.GroupView := not ListViewMain.GroupView;
    xmlSetItemBoolean(FXML.DocumentElement.ChildNodes[ND_PROPERTIES], ND_PARAM_GROUPVIEW, ListViewMain.GroupView);
  finally
    ListViewMain.Items.EndUpdate;
  end;
end;

procedure TfrmMain.ActionSetGroupViewUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Checked := ListViewMain.GroupView;
end;

procedure TfrmMain.ActionSetInactiveExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected and Assigned(ListViewMain.Items[I].Data) then TARObject(ListViewMain.Items[I].Data).Active := False;
end;

procedure TfrmMain.ActionSetInactiveUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 1) or ((ListViewMain.SelCount = 1) and (TARObject(ListViewMain.Selected.Data).Active));
end;

procedure TfrmMain.ActionDataManagerExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(frmDataManager) then frmDataManager := TfrmDataManager.Create(Application);
  if not frmDataManager.Visible then frmDataManager.Show else frmDataManager.BringToFront;
end;

procedure TfrmMain.ActionStayOnTopExecute(Sender: TObject);
begin
  if FormStyle = fsStayOnTop then FormStyle := fsNormal else FormStyle := fsStayOnTop;
  xmlSetItemBoolean(FXML.DocumentElement.ChildNodes[ND_PROPERTIES], ND_PARAM_STAYONTOP, (FormStyle = fsStayOnTop));
end;

procedure TfrmMain.ActionStayOnTopUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Checked := (FormStyle = fsStayOnTop);
end;

function TfrmMain.GetGroupIndex(GroupID: Integer): Integer;
 var I: Integer;
begin
  Result := -1;
  for I := 0 to ListViewMain.Groups.Count - 1 do if ListViewMain.Groups[I].GroupID = GroupID then begin
    Result := ListViewMain.Groups[I].Index;
    Break;
  end;
end;

function TfrmMain.GetFocusedGroupIndex: Integer;
 var I: Integer;
begin
  Result := -1;
  for I := 0 to ListViewMain.Groups.Count - 1 do if lgsFocused in ListViewMain.Groups[I].State then begin
    Result := ListViewMain.Groups[I].Index;
    Break;
  end;
end;

function TfrmMain.GetCheckedCount: Integer;
 var I: Integer;
begin
  Result := 0;
  for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Checked then Inc(Result);
end;

function TfrmMain.GetFirstGroupItem(GroupID: Integer): TListItem;
 var I: Integer;
begin
  Result := nil;
  for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].GroupID = GroupID then begin
    Result := ListViewMain.Items[I];
    Break;
  end;
end;

function TfrmMain.GetGroupXMLNode(GroupID: Integer): IXMLNode;
 var
   I: Integer;
   iNode: IXMLNode;
begin
  Result := nil;
  iNode := FXML.DocumentElement.ChildNodes[ND_GROUPS];
  for I := 0 to iNode.ChildNodes.Count - 1 do if iNode.ChildNodes[I].Attributes[ND_PARAM_ID] = IntToStr(GroupID) then begin
    Result := iNode.ChildNodes[I];
    Break;
  end;
end;

procedure TfrmMain.ActionGroupEditUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := Assigned(ListViewMain.Selected);
end;

procedure TfrmMain.ActionGroupEditExecute(Sender: TObject);
 var
   GroupID: Integer;
   iNode: IXMLNode;
begin
  inherited;
  GroupID := ListViewMain.Selected.GroupID;
  iNode := GetGroupXMLNode(GroupID);
  if EditGroupNode(iNode) then ApplyGroupParams(ListViewMain.Groups[GetGroupIndex(GroupID)], iNode);
end;

procedure TfrmMain.ActionGroupEditMemoExecute(Sender: TObject);
 var
   I, GID: Integer;
   bFound: Boolean;
begin
  inherited;
  if Assigned(ListViewMain.Selected) then begin
    GID := ListViewMain.Selected.GroupID;
    bFound := False;
    for I := 0 to Screen.FormCount - 1 do begin
      bFound := ((Screen.Forms[I] is TfrmEditGroupMemo) and ((Screen.Forms[I] as TfrmEditGroupMemo).GroupID = GID));
      if bFound then begin
        (Screen.Forms[I] as TfrmEditGroupMemo).BringToFront;
        Break;
      end;
    end;
    if not bFound then with TfrmEditGroupMemo.Create(Application) do begin
      XMLNode := GetGroupXMLNode(GID);
      GroupID := GID;
      Show;
    end;
  end;
end;

function TfrmMain.GetNewGroupName: String;

   function _Exists(Title: String): Boolean;
    var I: Integer;
   begin
     Result := False;
     for I := 0 to ListViewMain.Groups.Count - 1 do begin
       Result := (UpperCase(ListViewMain.Groups[I].Header) = UpperCase(Title));
       if Result then Break;
     end;
   end;

 var I: Integer;
begin
  I := 0;
  repeat
    Result := ICSLanguages1.CurrentStrings[15];
    if I > 0 then Result := Result + ' (' + IntToStr(I) + ')';
    Inc(I);
  until not _Exists(Result);
end;

procedure TfrmMain.ActionHostCloneExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ListViewMain.Selected) then XMLCreateHost(ListViewMain.Selected.GroupID, TARObject(ListViewMain.Selected.Data).XMLNode);
end;

procedure TfrmMain.ActionHostCloneUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount = 1);
end;

procedure TfrmMain.ActionAboutExecute(Sender: TObject);
begin
  inherited;
  with TfrmInfo.Create(Application) do try
    ShowModal;
  finally
    Release;
  end;
end;

procedure TfrmMain.ActionAddFirstUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Visible := (ListViewMain.Items.Count = 0);
end;

procedure TfrmMain.ActionCloseExecute(Sender: TObject);
begin
  inherited;
  ShuttingDown := True;
  Close;
end;

procedure TfrmMain.ActionGroupCollapseAllExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  ListViewMain.Items.BeginUpdate;
  try
    for I := 0 to ListViewMain.Groups.Count - 1 do ListViewMain.Groups[I].State := ListViewMain.Groups[I].State + [lgsCollapsed]
  finally
    ListViewMain.Items.EndUpdate;
  end;
end;

procedure TfrmMain.ActionGroupCollapseAllUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := ListViewMain.GroupView and (ListViewMain.Groups.Count > 0);
end;

procedure TfrmMain.ActionOpenExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  if ListViewMain.SelCount = 1 then TARObject(ListViewMain.Selected.Data).Run else for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected then TARObject(ListViewMain.Items[I].Data).Run;
end;

procedure TfrmMain.ActionHostAddExecute(Sender: TObject);
 var GroupID, Idx: Integer;
begin
  inherited;
  if Assigned(ListViewMain.Selected) then GroupID := ListViewMain.Selected.GroupID else GroupID := APP_ARGROUP_ID_GENERAL;
  if XMLCreateHost(GroupID) then begin
    Idx := GetGroupIndex(GroupID);
    if Idx in [0..ListViewMain.Groups.Count - 1] then ListViewMain.Groups[Idx].State := ListViewMain.Groups[Idx].State - [lgsCollapsed];
  end;
end;

procedure TfrmMain.DeleteListItemData(LI: TListItem);
begin
  if Assigned(LI.Data) then begin
    TARObject(LI.Data).Active := False;
    TARObject(LI.Data).XMLNode.ParentNode.ChildNodes.Remove(TARObject(LI.Data).XMLNode);
    ARObjectList.DeleteARObject(TARObject(LI.Data));
  end;
end;

procedure TfrmMain.ActionHostDeleteExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  if MessageBox(Handle, PChar(ICSLanguagesMessages.CurrentStrings[APP_ARSERVICE_MESSAGE_ID_DELETE_HOSTS]), PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = ID_YES then begin
    for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected then DeleteListItemData(ListViewMain.Items[I]);
    ListViewMain.DeleteSelected;
  end;
end;

procedure TfrmMain.ActionHostDeleteUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 0);
end;

procedure TfrmMain.CreateGroupMenu(Sender: TObject);
 var
   I: Integer;
   MI :TMenuItem;
   SelectedGroupID: Integer;
begin
  inherited;
  if Assigned(ListViewMain.Selected) then SelectedGroupID := ListViewMain.Selected.GroupID else SelectedGroupID := -1;
  for I := (Sender as TMenuItem).Count - 1 downto 0 do if (Sender as TMenuItem).Items[I].HelpContext = 1 then (Sender as TMenuItem).Delete(I);
  for I := 0 to ListViewMain.Groups.Count - 1 do if ListViewMain.Groups[I].GroupID <> APP_ARGROUP_ID_FAVORITES then begin
    MI := TMenuItem.Create(Self);
    MI.OnClick := OnClickMoveToExistedExecute;
    MI.Caption := ListViewMain.Groups[I].Header;
    MI.ImageIndex := ListViewMain.Groups[I].TitleImage;
    MI.Tag := ListViewMain.Groups[I].GroupID;
    MI.Enabled := (ListViewMain.Groups[I].GroupID <> SelectedGroupID);
    MI.HelpContext := 1;
    (Sender as TMenuItem).Add(MI);
  end;
end;

procedure TfrmMain.ActionDeleteEmptyGroupsExecute(Sender: TObject);
 var
   I, J: Integer;
   ItemsFound: Boolean;
begin
  inherited;
  if MessageBox(Handle, PChar(ICSLanguagesMessages.CurrentStrings[APP_ARSERVICE_MESSAGE_ID_DELETE_GROUPS]), PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = ID_YES then begin
    ListViewMain.Items.BeginUpdate;
    try
      for I := ListViewMain.Groups.Count - 1 downto 0 do if ListViewMain.Groups[I].GroupID < APP_ARGROUP_ID_FIRSTRESERVED then begin
        ItemsFound := False;
        for J := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Groups[I].GroupID = ListViewMain.Items[J].GroupID then begin
          ItemsFound := True;
          Break;
        end;
        if not ItemsFound then begin
          ListViewMain.Groups.Delete(I);
          FXML.DocumentElement.ChildNodes[ND_GROUPS].ChildNodes.Delete(I);
        end;
      end;
    finally
      ListViewMain.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.NetworkToolExecute(NetworkTool: TARNetworkTool);
 var I: Integer;
begin
  for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected then begin
    frmNetworkTools := TfrmNetworkTools.Create(Application);
    frmNetworkTools.XMLNode := TARObject(ListViewMain.Items[I].Data).XMLNode;
    frmNetworkTools.NetworkTool := NetworkTool;
    frmNetworkTools.Show;
  end;
end;

procedure TfrmMain.ActionExecutePingExecute(Sender: TObject);
begin
  inherited;
  NetworkToolExecute(ntPing);
end;

procedure TfrmMain.ActionExecuteTracertExecute(Sender: TObject);
begin
  inherited;
  NetworkToolExecute(ntTracert);
end;

procedure TfrmMain.ActionExportImportExecute(Sender: TObject);
// var I: Integer;
begin
  inherited;

//  for I := 0 to FXML.DocumentElement.ChildNodes[ND_HOSTS].ChildNodes.Count - 1 do if not FXML.DocumentElement.ChildNodes[ND_HOSTS].ChildNodes[I].HasAttribute(ND_PARAM_ID) then FXML.DocumentElement.ChildNodes[ND_HOSTS].ChildNodes[I].Attributes[ND_PARAM_ID] := icsGenerateGUIDString; Exit;

  with TfrmExportImport.Create(Application) do try
    if ShowModal = mrOk then ;
  finally
    Release;
  end;
end;

procedure TfrmMain.ActionGroupExpandAllExecute(Sender: TObject);
 var I: Integer;
begin
  inherited;
  ListViewMain.Items.BeginUpdate;
  try
    for I := 0 to ListViewMain.Groups.Count - 1 do ListViewMain.Groups[I].State := ListViewMain.Groups[I].State - [lgsCollapsed]
  finally
    ListViewMain.Items.EndUpdate;
  end;
end;

procedure TfrmMain.ActionGroupDeleteUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 0);
end;

procedure TfrmMain.ActionHostEditExecute(Sender: TObject);
 var
   I, J: Integer;
   iNode: IXMLNode;
   S, NodeName: String;
begin
  inherited;
  if ListViewMain.SelCount = 1 then begin
    iNode := TARObject(ListViewMain.Selected.Data).XMLNode;
    if EditHostNode(iNode, False) then ApplyHostParams(ListViewMain.Selected);
  end else begin
    iNode := FXML.DocumentElement.ChildNodes[ND_HOSTS].AddChild(ND_ITEM);
    try
      InitializeHostNode(iNode, -1, nil, True);
      if EditHostNode(iNode, True) then begin
        for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected then begin
          for J := 0 to iNode.ChildNodes.Count - 1 do begin
            NodeName := iNode.ChildNodes[J].NodeName;
            S := xmlGetItemString(iNode.ChildNodes[NodeName], ND_PARAM_VALUE);
            if (S <> '') and
//               ((S <> '0') or ((NodeName <> ND_ITEM))) and
               ((S <> IntToStr(Ord(cbGrayed))) or ((NodeName <> ND_SENDRECEIVE)
                                               and (NodeName <> ND_RUNASADMIN)
                                               and (NodeName <> ND_CHECK_MODIFIED)
               )) then xmlSetItemString(TARObject(ListViewMain.Items[I].Data).XMLNode.ChildNodes[NodeName], ND_PARAM_VALUE, S);
          end;
          ApplyHostParams(ListViewMain.Items[I]);
        end;
      end;
    finally
      FXML.DocumentElement.ChildNodes[ND_HOSTS].ChildNodes.Remove(iNode);
    end;
  end;
end;

procedure TfrmMain.ActionHostRenameExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ListViewMain.Selected) then ListViewMain.Selected.EditCaption;
end;

procedure TfrmMain.SelectedMoveToGroup(GroupID: Integer);
 var I: Integer;
begin
  inherited;
  ListViewMain.Items.BeginUpdate;
  try
    for I := 0 to ListViewMain.Items.Count - 1 do if ListViewMain.Items[I].Selected then begin
      ListViewMain.Items[I].GroupID := GroupID;
      xmlSetItemInteger(TARObject(ListViewMain.Items[I].Data).XMLNode, ND_PARAM_GROUP_ID, ListViewMain.Items[I].GroupID);
    end;
  finally
    ListViewMain.Items.EndUpdate;
  end;
end;

procedure TfrmMain.TimerGlobalPauseTimer(Sender: TObject);
begin
  inherited;
  GlobalSleepPause := 0;
  TimerGlobalPause.Enabled := False;
end;

procedure TfrmMain.TimerUpdateTimer(Sender: TObject);
begin
  inherited;
  if FXML.Modified and (FModalCounter <= 0) then SaveXMLToFile(FXML, GetMainXMLFileName, ARMasterPassword);
  StatusBar1.Panels[0].Text := 'G: ' + ListViewMain.Groups.Count.ToString;
  StatusBar1.Panels[1].Text := 'O: ' + ListViewMain.Items.Count.ToString;
  StatusBar1.Panels[2].Text := 'A: ' + GetCheckedCount.ToString;
  StatusBar1.Panels[3].Text := 'S: ' + ListViewMain.SelCount.ToString;
end;

procedure TfrmMain.TrayIcon1Click(Sender: TObject);
begin
  inherited;
  if FModalCounter <= 0 then begin
    Application.Restore;
    WindowState := wsNormal;
    Visible := True;
    icsBringToTop(Application.Handle);
  end;
end;

procedure TfrmMain.OnWMEndSession(var Msg: TWMEndSession);
begin
  ShuttingDown := Msg.EndSession;
  inherited;
end;

procedure TfrmMain.OnWMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  ShuttingDown := True;
  inherited;
end;

procedure TfrmMain.OnClickMoveToExistedExecute(Sender: TObject);
begin
  inherited;
  SelectedMoveToGroup((Sender as TComponent).Tag);
end;

procedure TfrmMain.OnExit;
begin
  if Assigned(frmDataManager) then frmDataManager.Close;
  SaveGroupProperties;
  SaveBounds;
  if FXML.Modified then SaveXMLToFile(FXML, GetMainXMLFileName, ARMasterPassword);
end;

procedure TfrmMain.ActionMoveToFavoritesExecute(Sender: TObject);
begin
  inherited;
  SelectedMoveToGroup(APP_ARGROUP_ID_FAVORITES);
end;

procedure TfrmMain.ActionMoveToNewGroupExecute(Sender: TObject);
 var GroupID: Integer;
begin
  inherited;
  GroupID := ListViewMain.Groups.NextGroupID;
  if XMLCreateGroup(GetNewGroupName, GroupID, True) then SelectedMoveToGroup(GroupID);
end;

procedure TfrmMain.ActionMoveToNewGroupUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (ListViewMain.SelCount > 0) and (ListViewMain.Groups.NextGroupID < APP_ARGROUP_ID_FIRSTRESERVED);
end;

procedure TfrmMain.ActionPropertiesExecute(Sender: TObject);
begin
  inherited;
  frmProps := TfrmProps.Create(Application);
  try
    if frmProps.ShowModal = mrOK then ApplyProperties;
  finally
    frmProps.Release;
  end;
end;

procedure TfrmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
 var
   F: TextFile;
   FName, Msg: String;
begin
  inherited;
  FName := GetLogFileName;
  Msg := FormatDateTime('dd.mm.yyyy - ss.nn.hh', Now) + ' - ' + Sender.ClassName + ': ' + E.Message;
  AssignFile(F, FName);
  if FileExists(FName) then Append(F) else Rewrite(F);
  Writeln(F, Msg);
  CloseFile(F);
  MessageBox(Handle, PChar(Msg), PChar(Application.Title), MB_OK + MB_ICONERROR);
end;

procedure TfrmMain.ApplicationEvents1ModalBegin(Sender: TObject);
begin
  inherited;
  Inc(FModalCounter);
  if FModalCounter > 0 then begin
    TrayIcon1.PopupMenu := nil;
    FormStyle := fsNormal;
  end;
end;

procedure TfrmMain.ApplicationEvents1ModalEnd(Sender: TObject);
begin
  inherited;
  Dec(FModalCounter);
  if FModalCounter <= 0 then begin
    TrayIcon1.PopupMenu := PopupMenuTray;
    if xmlGetItemBoolean(FXML.DocumentElement.ChildNodes[ND_PROPERTIES], ND_PARAM_STAYONTOP) then FormStyle := fsStayOnTop;
  end;
end;

procedure TfrmMain.ListViewMainDblClick(Sender: TObject);
 var
   HitTests: THitTests;
   P: TPoint;
begin
  inherited;
  if GetCursorPos(P) then begin
    P := ListViewMain.ScreenToClient(P);
    HitTests := ListViewMain.GetHitTestInfoAt(P.X, P.Y);
    if ActionOpen.Enabled and ((htOnIcon in HitTests) or (htOnItem in HitTests) or (htOnLabel in HitTests)) then ActionOpen.Execute;
  end;
end;

procedure TfrmMain.ListViewMainEdited(Sender: TObject; Item: TListItem;
  var S: string);
begin
  inherited;
  xmlSetItemString(TARObject(Item.Data).XMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, S);
end;

procedure TfrmMain.ListViewMainItemChecked(Sender: TObject; Item: TListItem);
begin
  inherited;
  if Assigned(Item.Data) then TARObject(Item.Data).Active := Item.Checked;
end;

procedure TfrmMain.ListViewMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
 var
   Idx: Integer;
   Item: TListItem;
begin
  inherited;
  if (Shift = []) and not ListViewMain.IsEditing then case Key of
    VK_RETURN: if Assigned(ListViewMain.Selected) then begin
      Idx := GetGroupIndex(ListViewMain.Selected.GroupID);
      if (lgsFocused in ListViewMain.Groups[Idx].State) and ActionGroupEdit.Enabled then ActionGroupEdit.Execute else if ActionHostEdit.Enabled then ActionHostEdit.Execute;
    end;
    VK_LEFT, VK_RIGHT: begin
      if Assigned(ListViewMain.Selected) then Idx := GetGroupIndex(ListViewMain.Selected.GroupID) else Idx := GetFocusedGroupIndex;
      if Idx >= 0 then begin
        if Assigned(ListViewMain.ItemFocused) then Item := ListViewMain.ItemFocused else Item := ListViewMain.Selected;
        case Key of
          VK_LEFT: ListViewMain.Groups[Idx].State := ListViewMain.Groups[Idx].State + [lgsCollapsed];
          VK_RIGHT: ListViewMain.Groups[Idx].State := ListViewMain.Groups[Idx].State - [lgsCollapsed];
        end;
        if not Assigned(Item) then Item := GetFirstGroupItem(ListViewMain.Groups[Idx].GroupID);
        if Assigned(Item) then begin
          Item.Selected := True;
          Item.Focused := True;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ListViewWndProc(var Message: TMessage);
begin
  ShowScrollBar(ListViewMain.Handle, SB_HORZ, False);
  ShowScrollBar(ListViewMain.Handle, SB_VERT, True);
  FListViewWndProc(Message);
end;

procedure TfrmMain.NormalizeGroups;
 var
   I: Integer;
   argGeneralExists, argFavoritesExists: Boolean;
begin
  argGeneralExists := False;
  argFavoritesExists := False;
  for I := 0 to ListViewMain.Groups.Count - 1 do begin
    if not argGeneralExists then argGeneralExists := (ListViewMain.Groups[I].GroupID = APP_ARGROUP_ID_GENERAL);
    if not argFavoritesExists then argFavoritesExists := (ListViewMain.Groups[I].GroupID = APP_ARGROUP_ID_FAVORITES);
  end;
  if not argGeneralExists then XMLCreateGroup(ICSLanguagesGroups.CurrentStrings[MaxInt - APP_ARGROUP_ID_GENERAL], APP_ARGROUP_ID_GENERAL, False);
  if not argFavoritesExists then XMLCreateGroup(ICSLanguagesGroups.CurrentStrings[MaxInt - APP_ARGROUP_ID_FAVORITES], APP_ARGROUP_ID_FAVORITES, False);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := ShuttingDown;
  if CanClose then OnExit else Hide;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  PMemFile^.MainHandle := Handle;
  FListViewWndProc := ListViewMain.WindowProc;
  ListViewMain.WindowProc := ListViewWndProc;
  FModalCounter := 0;
  PngImageListApp.GetIcon(0, Application.Icon);
  ApplyProperties;
  RecreateUserInterface;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ListViewMain.WindowProc := FListViewWndProc;
  FListViewWndProc := nil;
  inherited;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  inherited;
  SaveBounds;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  ApplyPropertiesOnShow;
end;

procedure TfrmMain.ApplyHostParams(aHost: TListItem);
 const
   IMAGE_PROTOCOL_IDX_FIRST = 35;
   IMAGE_PROTOCOL_ERROR = 4;
 var
   iNode, iProtocolNode: IXMLNode;
begin
  iNode := TARObject(aHost.Data).XMLNode;
  aHost.Caption := xmlGetItemString(iNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);

  if TARObject(aHost.Data).Modified and not TARObject(aHost.Data).CheckModified then TARObject(aHost.Data).Modified := False;

  iProtocolNode := TARObject(aHost.Data).XMLProtocolNode;
  if Assigned(iProtocolNode) then begin
    aHost.SubItems[0] := icsB64Decode(xmlGetItemString(iProtocolNode.ChildNodes[ND_SHORTNAME], ND_PARAM_VALUE));
    aHost.SubItemImages[0] := IMAGE_PROTOCOL_IDX_FIRST + xmlGetItemInteger(iProtocolNode.ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE);
  end else begin
    aHost.SubItems[0] := xmlGetItemString(iNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
    aHost.SubItemImages[0] := IMAGE_PROTOCOL_ERROR;
  end;

  TARObject(aHost.Data).Active := xmlGetItemBoolean(iNode, ND_PARAM_ACTIVE);
  if TARObject(aHost.Data).Active then TARObject(aHost.Data).StartCheckState;
end;

procedure TfrmMain.ApplyProperties;
 var iNode: IXMLNode;
begin
  iNode := FXML.DocumentElement.ChildNodes[ND_PROPERTIES];
  if xmlGetItemBoolean(iNode, ND_PARAM_STAYONTOP) then FormStyle := fsStayOnTop else FormStyle := fsNormal;
  ListViewMain.GroupView := xmlGetItemBoolean(iNode, ND_PARAM_GROUPVIEW, True);
  Visible := not xmlGetItemBoolean(iNode, ND_PARAM_START_MINIMIZED);
//  TStyleManager.TrySetStyle(TStyleManager.StyleNames[MinX([xmlGetItemInteger(iNode, ND_PARAM_STYLE_ID), High(TStyleManager.StyleNames)])]);
end;

procedure TfrmMain.ApplyPropertiesOnShow;
 var iNode: IXMLNode;
begin
  iNode := FXML.DocumentElement.ChildNodes[ND_PROPERTIES];
  SetBounds(xmlGetItemInteger(iNode, ND_PARAM_LEFT, Left), xmlGetItemInteger(iNode, ND_PARAM_TOP, Top), xmlGetItemInteger(iNode, ND_PARAM_WIDTH, Width), xmlGetItemInteger(iNode, ND_PARAM_HEIGHT, Height));
end;

procedure TfrmMain.SaveBounds;
 var iNode: IXMLNode;
begin
  iNode := FXML.DocumentElement.ChildNodes[ND_PROPERTIES];
  xmlSetItemInteger(iNode, ND_PARAM_WIDTH, Width);
  xmlSetItemInteger(iNode, ND_PARAM_HEIGHT, Height);
  xmlSetItemInteger(iNode, ND_PARAM_LEFT, Left);
  xmlSetItemInteger(iNode, ND_PARAM_TOP, Top);
end;

procedure TfrmMain.CreateHostItem(iNode: IXMLNode);
 var Item: TListItem;
begin
  Item := ListViewMain.Items.Add;
  Item.ImageIndex := 0;
  Item.SubItems.Add('0');
  Item.GroupID := xmlGetItemInteger(iNode, ND_PARAM_GROUP_ID);
  Item.Data := Pointer(TARObject.Create(iNode));
  ARObjectList.Add(TARObject(Item.Data));
  ApplyHostParams(Item);
end;

procedure TfrmMain.ApplyGroupParams(aGroup: TListGroup; iNode: IXMLNode);
 var Idx: Integer;
begin
  if xmlGetItemString(iNode.ChildNodes[ND_NAME], ND_PARAM_VALUE) <> '' then begin
    ListViewMain.Items.BeginUpdate;
    try
      aGroup.Header := xmlGetItemString(iNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);
      Idx := xmlGetItemInteger(iNode, ND_PARAM_ICONID);
      if Idx < PngImageListGroups.Count then aGroup.TitleImage := Idx else aGroup.TitleImage := MaxInt - APP_ARGROUP_ID_NORMAL;
      if xmlGetItemBoolean(iNode, ND_PARAM_COLLAPSED) then aGroup.State := aGroup.State + [lgsCollapsed];
    finally
      ListViewMain.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.CreateGroupItem(iNode: IXMLNode);
 var aGroup: TListGroup;
begin
  aGroup := ListViewMain.Groups.Add;
  aGroup.GroupID := xmlGetItemInteger(iNode, ND_PARAM_ID);
  aGroup.State := aGroup.State + [lgsCollapsible];
  ApplyGroupParams(aGroup, iNode);
end;

procedure TfrmMain.RecreateUserInterface;
 var
   I: Integer;
   iNode: IXMLNode;
begin
  ListViewMain.Items.BeginUpdate;
  try
    ListViewMain.Groups.Clear;
    iNode := FXML.DocumentElement.ChildNodes[ND_GROUPS];
    for I := 0 to iNode.ChildNodes.Count - 1 do CreateGroupItem(iNode.ChildNodes[I]);
    NormalizeGroups;
    for I := 0 to ListViewMain.Items.Count - 1 do if Assigned(ListViewMain.Items[I].Data) then TARObject(ListViewMain.Items[I].Data).TerminateCheckStateThread;
    ListViewMain.Clear;
    iNode := FXML.DocumentElement.ChildNodes[ND_HOSTS];
    for I := 0 to iNode.ChildNodes.Count - 1 do CreateHostItem(iNode.ChildNodes[I]);
  finally
    ListViewMain.Items.EndUpdate;
  end;
  if ListViewMain.Items.Count = 0 then begin
    InitializeDB;
    ActionDataManager.Execute;
  end;
end;

procedure TfrmMain.SaveGroupProperties;
 var
   I: Integer;
   iNode: IXMLNode;
begin
  for I := 0 to ListViewMain.Groups.Count - 1 do begin
    iNode := GetGroupXMLNode(ListViewMain.Groups[I].GroupID);
    xmlSetItemBoolean(iNode, ND_PARAM_COLLAPSED, (lgsCollapsed in ListViewMain.Groups[I].State));
  end;
end;

function TfrmMain.XMLCreateGroup(GroupName: String; GroupID: Integer; EditData: Boolean): Boolean;
 var iNode: IXMLNode;
begin
  inherited;
  iNode := FXML.DocumentElement.ChildNodes[ND_GROUPS].AddChild(ND_ITEM);
  iNode.Attributes[ND_PARAM_ID] := IntToStr(GroupID);
  iNode.Attributes[ND_PARAM_COLLAPSED] := '0';
  if GroupID = APP_ARGROUP_ID_FAVORITES then iNode.Attributes[ND_PARAM_ICONID] := IntToStr(MaxInt - APP_ARGROUP_ID_FAVORITES)
    else if GroupID = APP_ARGROUP_ID_GENERAL then iNode.Attributes[ND_PARAM_ICONID] := IntToStr(MaxInt - APP_ARGROUP_ID_GENERAL)
    else iNode.Attributes[ND_PARAM_ICONID] := IntToStr(MaxInt - APP_ARGROUP_ID_NORMAL);
  iNode.AddChild(ND_NAME).Attributes[ND_PARAM_VALUE] := GroupName;
  Result := not EditData or EditGroupNode(iNode);
  if Result then CreateGroupItem(iNode) else iNode.ParentNode.ChildNodes.Remove(iNode);
end;

procedure TfrmMain.InitializeHostNode(iNode: IXMLNode; GroupID: Integer; iSourceNode: IXMLNode; MultiEdit: Boolean);
begin
  iNode.Attributes[ND_PARAM_ID] := icsGenerateGUIDString;
  if GroupID >= 0 then begin
    iNode.Attributes[ND_PARAM_GROUP_ID] := IntToStr(GroupID);
    iNode.Attributes[ND_PARAM_ACTIVE] := '0';
  end;
  if Assigned(iSourceNode) then begin
    iNode.AddChild(ND_PROTOCOL_ID).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_PROTOCOL_ID], ND_PARAM_VALUE);
    iNode.AddChild(ND_SOFT_ID).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_SOFT_ID], ND_PARAM_VALUE);
    iNode.AddChild(ND_NAME).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);
    iNode.AddChild(ND_HOST).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_HOST], ND_PARAM_VALUE);
    iNode.AddChild(ND_RESOURCES).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_RESOURCES], ND_PARAM_VALUE);
    iNode.AddChild(ND_PORT).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
    iNode.AddChild(ND_INTERVAL).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE);
    iNode.AddChild(ND_ERRORINTERVAL).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE);
    iNode.AddChild(ND_TIMEOUT).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_TIMEOUT], ND_PARAM_VALUE);
    iNode.AddChild(ND_USERNAME).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
    iNode.AddChild(ND_PASSWORD).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
    iNode.AddChild(ND_DOMAIN).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_DOMAIN], ND_PARAM_VALUE);
    iNode.AddChild(ND_CHECK_MODIFIED).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_CHECK_MODIFIED], ND_PARAM_VALUE);
    iNode.AddChild(ND_SENDRECEIVE).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_SENDRECEIVE], ND_PARAM_VALUE);
    iNode.AddChild(ND_SENDSTRING).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_SENDSTRING], ND_PARAM_VALUE);
    iNode.AddChild(ND_RECEIVESTRING).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_RECEIVESTRING], ND_PARAM_VALUE);
    iNode.AddChild(ND_SHOW_WINDOW).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_SHOW_WINDOW], ND_PARAM_VALUE);
    iNode.AddChild(ND_RUNASADMIN).Attributes[ND_PARAM_VALUE] := xmlGetItemString(iSourceNode.ChildNodes[ND_RUNASADMIN], ND_PARAM_VALUE);
  end else begin
    iNode.AddChild(ND_PROTOCOL_ID).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_SOFT_ID).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_NAME).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_HOST).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_RESOURCES).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_PORT).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_SENDSTRING).Attributes[ND_PARAM_VALUE] := '';
    iNode.AddChild(ND_RECEIVESTRING).Attributes[ND_PARAM_VALUE] := '';
    if MultiEdit then begin
      iNode.AddChild(ND_INTERVAL).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_ERRORINTERVAL).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_TIMEOUT).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_USERNAME).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_PASSWORD).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_DOMAIN).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_CHECK_MODIFIED).Attributes[ND_PARAM_VALUE] := IntToStr(Ord(cbGrayed));
      iNode.AddChild(ND_SENDRECEIVE).Attributes[ND_PARAM_VALUE] := IntToStr(Ord(cbGrayed));
      iNode.AddChild(ND_RUNASADMIN).Attributes[ND_PARAM_VALUE] := IntToStr(Ord(cbGrayed));
      iNode.AddChild(ND_SHOW_WINDOW).Attributes[ND_PARAM_VALUE] := '-1';
    end else begin
      iNode.AddChild(ND_INTERVAL).Attributes[ND_PARAM_VALUE] := xmlGetItemString(FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_INTERVAL], ND_PARAM_VALUE);
      iNode.AddChild(ND_ERRORINTERVAL).Attributes[ND_PARAM_VALUE] := xmlGetItemString(FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE);
      iNode.AddChild(ND_TIMEOUT).Attributes[ND_PARAM_VALUE] := '2';
      iNode.AddChild(ND_USERNAME).Attributes[ND_PARAM_VALUE] := xmlGetItemString(FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
      iNode.AddChild(ND_PASSWORD).Attributes[ND_PARAM_VALUE] := xmlGetItemString(FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
      iNode.AddChild(ND_DOMAIN).Attributes[ND_PARAM_VALUE] := xmlGetItemString(FXML.DocumentElement.ChildNodes[ND_PROPERTIES].ChildNodes[ND_DOMAIN], ND_PARAM_VALUE);
      iNode.AddChild(ND_CHECK_MODIFIED).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_SENDRECEIVE).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_RUNASADMIN).Attributes[ND_PARAM_VALUE] := '';
      iNode.AddChild(ND_SHOW_WINDOW).Attributes[ND_PARAM_VALUE] := '';
    end;
  end;
end;

procedure TfrmMain.ItemMainEditClick(Sender: TObject);
begin
  inherited;
  OnItemGroupClick(ItemMainMoveTo);
end;

procedure TfrmMain.OnItemGroupClick(Sender: TObject);
 var MI: TMenuItem;
begin
  inherited;
  (Sender as TMenuItem).Enabled := (ListViewMain.SelCount > 0);
  (Sender as TMenuItem).Clear;
  if (Sender as TMenuItem).Enabled then begin
    MI := TMenuItem.Create(Self);
    MI.Action := ActionMoveToNewGroup;
    (Sender as TMenuItem).Add(MI);
    MI := TMenuItem.Create(Self);
    MI.Action := ActionMoveToFavorites;
    MI.ImageIndex := ListViewMain.Groups[GetGroupIndex(APP_ARGROUP_ID_FAVORITES)].TitleImage;
    (Sender as TMenuItem).Add(MI);
    MI := TMenuItem.Create(Self);
    MI.Caption := '-';
    (Sender as TMenuItem).Add(MI);
  end;
end;

procedure TfrmMain.OnMessageClose(var Msg: TMessage);
begin
  ActionClose.Execute;
end;

procedure TfrmMain.OnMessageSetActive(var Msg: TMessage);
 var Item: TListItem;
begin
  inherited;
  Item := ListViewMain.FindData(0, Pointer(Msg.WParam), True, False);
  if Assigned(Item) and (Item.StateIndex <> Msg.LParam) then Item.StateIndex := Msg.LParam;
end;

procedure TfrmMain.OnMessageSetState(var Msg: TMessage);
 var Item: TListItem;
begin
  inherited;
  Item := ListViewMain.FindData(0, Pointer(Msg.WParam), True, False);
  if Assigned(Item) then Item.ImageIndex := Msg.LParam;
end;

procedure TfrmMain.OnRecreateList(var Msg: TMessage);
 var I: Integer;
begin
  for I := 0 to ListViewMain.Items.Count -1 do ApplyHostParams(ListViewMain.Items[I]);
end;

procedure TfrmMain.OnRecreateUserInterface(var Msg: TMessage);
begin
  RecreateUserInterface;
  if Assigned(frmDataManager) then SendMessage(frmDataManager.Handle, AR_MESSAGE_RECREATE_USER_INTERFACE, 0, 0);
end;

procedure TfrmMain.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  OnItemGroupClick(ItemMoveTo);
end;

function TfrmMain.XMLCreateHost(GroupID: Integer; const iSourceNode: IXMLNode = nil): Boolean;
 var iNode: IXMLNode;
begin
  inherited;
  iNode := FXML.DocumentElement.ChildNodes[ND_HOSTS].AddChild(ND_ITEM);
  InitializeHostNode(iNode, GroupID, iSourceNode, False);
  Result := EditHostNode(iNode, False);
  if Result then CreateHostItem(iNode) else FXML.DocumentElement.ChildNodes[ND_HOSTS].ChildNodes.Remove(iNode);
end;

function TfrmMain.EditGroupNode(XMLNode: IXMLNode): Boolean;
begin
  Result := False;
  if Assigned(XMLNode) then begin
    frmEditGroup := TfrmEditGroup.Create(Application);
    try
      frmEditGroup.XMLNode := XMLNode;
      frmEditGroup.ImageList := PngImageListGroups;
      frmEditGroup.FillControls;
      Result := (frmEditGroup.ShowModal = mrOk);
      if Result then frmEditGroup.ApplyXML;
    finally
      frmEditGroup.Release;
    end;
  end;
end;

function TfrmMain.EditHostNode(XMLNode: IXMLNode; MultiEdit: Boolean): Boolean;
begin
  Result := False;
  if Assigned(XMLNode) then begin
    frmEditHost := TfrmEditHost.Create(Application);
    try
      frmEditHost.XMLNode := XMLNode;
      frmEditHost.FillControls(MultiEdit);
      Result := (frmEditHost.ShowModal = mrOk);
      if Result then frmEditHost.ApplyXML;
    finally
      frmEditHost.Release;
    end;
  end;
end;

end.
