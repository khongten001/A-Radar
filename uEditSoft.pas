unit uEditSoft;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Types,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, PngBitBtn, XMLIntf, System.ImageList,
  Vcl.ImgList, PngImageList, Vcl.Menus, Vcl.ComCtrls, SynEdit,
  SynURIOpener, SynEditHighlighter, SynHighlighterURI;

type
  TfrmEditSoft = class(TfrmForm)
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    btnSoftBrowse: TPngBitBtn;
    lePath: TLabeledEdit;
    leParams: TLabeledEdit;
    leName: TLabeledEdit;
    ImageIcon: TImage;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lvProtocols: TListView;
    SynEditDefaultParams1: TSynEdit;
    TabSheetMemo: TTabSheet;
    SynEditMemo: TSynEdit;
    SynURISyn1: TSynURISyn;
    SynURIOpener1: TSynURIOpener;
    PngImageListLocations: TPngImageList;
    procedure FormShow(Sender: TObject);
    procedure btnSoftBrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lePathChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
  private
    FSoftXMLNode: IXMLNode;
    FProtocolsXMLNode: IXMLNode;
    procedure FillControls;
    procedure SetImageIcon;
  public
    procedure ApplyXML;
    property SoftXMLNode: IXMLNode read FSoftXMLNode write FSoftXMLNode;
//    property ProtocolsXMLNode: IXMLNode read FProtocolsXMLNode write FProtocolsXMLNode;
  end;

var
  frmEditSoft: TfrmEditSoft;

implementation

{$R *.dfm}

uses
  ShlObj, uCommonTools, uClasses, uRegLite, uRegistry, uXMLTools, ShellAPI;

{ TfrmSoftEdit }

procedure TfrmEditSoft.ApplyXML;
 var
   I: Integer;
   iNode: IXMLNode;
begin
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_PATH], ND_PARAM_VALUE, icsB64Encode(lePath.Text));
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_PARAMS], ND_PARAM_VALUE, icsB64Encode(leParams.Text));
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE, icsB64Encode(SynEditMemo.Text));

  FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes.Clear;
  for I := 0 to lvProtocols.Items.Count - 1 do if lvProtocols.Items[I].Checked then begin
    iNode := FSoftXMLNode.ChildNodes[ND_PROTOCOLS].AddChild(ND_ITEM);
    xmlSetItemString(iNode, ND_PARAM_VALUE, lvProtocols.Items[I].SubItems[0]);
  end;

  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_PARAMSTRINGS1], ND_PARAM_VALUE, icsB64Encode(SynEditDefaultParams1.Lines.Text));
end;

procedure TfrmEditSoft.btnSoftBrowseClick(Sender: TObject);
begin
  inherited;
  OpenDialog1.InitialDir := lePath.Text;
  if not FileExists(OpenDialog1.InitialDir) and not DirectoryExists(OpenDialog1.InitialDir) then OpenDialog1.InitialDir := icsGetSpecialFolderLocation(Handle, CSIDL_PROGRAM_FILES);
  if OpenDialog1.Execute(Self.Handle) then lePath.Text := OpenDialog1.FileName;
end;

procedure TfrmEditSoft.SetImageIcon;
 var FName: String;
begin
  FName := lePath.Text;
  if not FileExists(FName) then FName := icsGetLongPathName(FName);
  if FileExists(FName) then ImageIcon.Picture.Icon.Handle := icsGetIconHandleFromFileName(FName, False);
end;

procedure TfrmEditSoft.FillControls;
 var
   I, J, SubIdx: Integer;
   iNode: IXMLNode;
   LI: TListItem;
begin
  leName.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  lePath.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PATH], ND_PARAM_VALUE));
  SetImageIcon;
  leParams.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PARAMS], ND_PARAM_VALUE));
  SynEditMemo.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE));

  lvProtocols.Items.BeginUpdate;
  try
    lvProtocols.Items.Clear;
    for I := 0 to FProtocolsXMLNode.ChildNodes.Count - 1 do begin
      iNode := FProtocolsXMLNode.ChildNodes[I];
      LI := lvProtocols.Items.Add;
      LI.Caption := GetDisplayProtocolName(iNode);
      LI.ImageIndex := xmlGetItemInteger(iNode.ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE);
      SubIdx := LI.SubItems.Add(xmlGetItemString(iNode, ND_PARAM_ID));

      for J := 0 to FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes.Count - 1 do if xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes[J], ND_PARAM_VALUE) = LI.SubItems[SubIdx] then begin
        LI.Checked := True;
        Break;
      end;

    end;
  finally
    lvProtocols.Items.EndUpdate;
  end;

  SynEditDefaultParams1.Lines.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PARAMSTRINGS1], ND_PARAM_VALUE));
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmEditSoft.FormClose(Sender: TObject; var Action: TCloseAction);
 var iNode: IXMLNode;
begin
  inherited;
  iNode := FXML.DocumentElement.ChildNodes[ND_SOFTWARE];
  xmlSetItemInteger(iNode, ND_PARAM_LEFT, Left);
  xmlSetItemInteger(iNode, ND_PARAM_TOP, Top);
  xmlSetItemInteger(iNode, ND_PARAM_WIDTH, Width);
  xmlSetItemInteger(iNode, ND_PARAM_HEIGHT, Height);
end;

procedure TfrmEditSoft.FormCreate(Sender: TObject);
begin
  inherited;
  FProtocolsXMLNode := FXML.DocumentElement.ChildNodes[ND_PROTOCOLS];
end;

procedure TfrmEditSoft.FormShow(Sender: TObject);
 var iNode: IXMLNode;
begin
  inherited;
  iNode := FXML.DocumentElement.ChildNodes[ND_SOFTWARE];
  SetBounds(xmlGetItemInteger(iNode, ND_PARAM_LEFT, Left), xmlGetItemInteger(iNode, ND_PARAM_TOP, Top), xmlGetItemInteger(iNode, ND_PARAM_WIDTH, Width), xmlGetItemInteger(iNode, ND_PARAM_HEIGHT, Height));
  FillControls;
end;

procedure TfrmEditSoft.lePathChange(Sender: TObject);
begin
  inherited;
  SetImageIcon;
end;

procedure TfrmEditSoft.PageControl1Change(Sender: TObject);
begin
  inherited;
  if Visible then case PageControl1.ActivePageIndex of
    1: SynEditDefaultParams1.SetFocus;
    2: SynEditMemo.SetFocus;
  end;
end;

end.
