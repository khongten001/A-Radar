unit uSoftEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Types,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, PngBitBtn, XMLIntf, System.ImageList,
  Vcl.ImgList, PngImageList, Vcl.Menus, Vcl.ComCtrls, SynEdit;

type
  TfrmSoftEdit = class(TfrmForm)
    btnOk: TButton;
    btnCancel: TButton;
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
    SynEditDefaultParams: TSynEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSoftBrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lePathChange(Sender: TObject);
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
  frmSoftEdit: TfrmSoftEdit;

implementation

{$R *.dfm}

uses
  ShlObj, uCommonTools, uClasses, uRegLite, uRegistry, uXMLTools;

{ TfrmSoftEdit }

procedure TfrmSoftEdit.ApplyXML;
 var
   I: Integer;
   iNode: IXMLNode;
begin
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_PATH], ND_PARAM_VALUE, icsB64Encode(lePath.Text));
  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_PARAMS], ND_PARAM_VALUE, icsB64Encode(leParams.Text));

  FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes.Clear;
  for I := 0 to lvProtocols.Items.Count - 1 do if lvProtocols.Items[I].Checked then begin
    iNode := FSoftXMLNode.ChildNodes[ND_PROTOCOLS].AddChild(ND_PROTOCOL);
    xmlSetItemString(iNode, ND_PARAM_VALUE, lvProtocols.Items[I].SubItems[0]);
  end;

  xmlSetItemString(FSoftXMLNode.ChildNodes[ND_DEFAULT_PARAMFILE1], ND_PARAM_VALUE, icsB64Encode(SynEditDefaultParams.Lines.Text));
end;

procedure TfrmSoftEdit.btnSoftBrowseClick(Sender: TObject);
begin
  inherited;
  if FileExists(lePath.Text) then OpenDialog1.InitialDir := ExtractFilePath(lePath.Text) else OpenDialog1.InitialDir := icsGetSpecialFolderLocation(Handle, CSIDL_PROGRAM_FILES);
  if OpenDialog1.Execute(Self.Handle) then lePath.Text := OpenDialog1.FileName;
end;

procedure TfrmSoftEdit.SetImageIcon;
 var FName: String;
begin
  FName := lePath.Text;
  if not FileExists(FName) then FName := icsGetLongPathName(FName);
  if FileExists(FName) then ImageIcon.Picture.Icon.Handle := icsGetIconHandleFromFileName(FName, False);
end;

procedure TfrmSoftEdit.FillControls;
 var
   I, J, SubIdx: Integer;
   iNode: IXMLNode;
   LI: TListItem;
begin
  leName.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  lePath.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PATH], ND_PARAM_VALUE));
  SetImageIcon;
  leParams.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PARAMS], ND_PARAM_VALUE));

  lvProtocols.Items.BeginUpdate;
  try
    lvProtocols.Items.Clear;
    for I := 0 to FProtocolsXMLNode.ChildNodes.Count - 1 do begin
      iNode := FProtocolsXMLNode.ChildNodes[I];
      LI := lvProtocols.Items.Add;
      LI.Caption := icsB64Decode(xmlGetItemString(iNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
      SubIdx := LI.SubItems.Add(xmlGetItemString(iNode, ND_PARAM_ID));

      for J := 0 to FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes.Count - 1 do if xmlGetItemString(FSoftXMLNode.ChildNodes[ND_PROTOCOLS].ChildNodes[J], ND_PARAM_VALUE) = LI.SubItems[SubIdx] then begin
        LI.Checked := True;
        Break;
      end;

    end;
  finally
    lvProtocols.Items.EndUpdate;
  end;

  SynEditDefaultParams.Lines.Text := icsB64Decode(xmlGetItemString(FSoftXMLNode.ChildNodes[ND_DEFAULT_PARAMFILE1], ND_PARAM_VALUE));
end;

procedure TfrmSoftEdit.FormCreate(Sender: TObject);
begin
  inherited;
  FProtocolsXMLNode := FXML.DocumentElement.ChildNodes[ND_PROTOCOLS];
end;

procedure TfrmSoftEdit.FormShow(Sender: TObject);
begin
  inherited;
  FillControls;
end;

procedure TfrmSoftEdit.lePathChange(Sender: TObject);
begin
  inherited;
  SetImageIcon;
end;

end.
