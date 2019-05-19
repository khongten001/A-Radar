unit uEditProtocol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, PngBitBtn, XMLIntf, System.ImageList,
  Vcl.ImgList, PngImageList, Vcl.Menus, Vcl.ComCtrls;

type
  TfrmEditProtocol = class(TfrmForm)
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    lePort: TLabeledEdit;
    leName: TLabeledEdit;
    Image1: TImage;
    leScheme: TLabeledEdit;
    leShortName: TLabeledEdit;
    cbLocations: TComboBoxEx;
    Label1: TLabel;
    ICSLanguagesLocations: TICSLanguages;
    PngImageListLocations: TPngImageList;
    PngImageListLogos: TPngImageList;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure cbLocationsClick(Sender: TObject);
  private
    FXMLNode: IXMLNode;
    procedure OnAppSetLanguageMsg(var Msg: TMessage); message ICS_SETLANGUAGE_MSG;
    procedure FillControls;
    procedure SetControlEnabled;
  public
    procedure ApplyXML;
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
  end;

var
  frmEditProtocol: TfrmEditProtocol;

implementation

{$R *.dfm}

uses
  uCommonTools, uClasses, uXMLTools;

{ TfrmSoftEdit }

procedure TfrmEditProtocol.ApplyXML;
begin
  xmlSetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(FXMLNode.ChildNodes[ND_SHORTNAME], ND_PARAM_VALUE, icsB64Encode(leShortName.Text));
  xmlSetItemInteger(FXMLNode.ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE, cbLocations.ItemIndex);
  xmlSetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE, lePort.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_SCHEME], ND_PARAM_VALUE, leScheme.Text);
end;

procedure TfrmEditProtocol.cbLocationsClick(Sender: TObject);
begin
  inherited;
  SetControlEnabled;
end;

procedure TfrmEditProtocol.FillControls;
begin
  leName.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  leShortName.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_SHORTNAME], ND_PARAM_VALUE));
  cbLocations.ItemIndex := xmlGetItemInteger(FXMLNode.ChildNodes[ND_LOCATION_ID], ND_PARAM_VALUE);
  lePort.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
  leScheme.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_SCHEME], ND_PARAM_VALUE);

  SetControlEnabled;
end;

procedure TfrmEditProtocol.FormShow(Sender: TObject);
begin
  inherited;
  FillControls;
end;

procedure TfrmEditProtocol.OnAppSetLanguageMsg(var Msg: TMessage);
 var I, Idx: Integer;
begin
  inherited;
  Idx := cbLocations.ItemIndex;
  cbLocations.Items.Clear;
  for I := 0 to ICSLanguagesLocations.CurrentStrings.Count - 1 do cbLocations.ItemsEx.AddItem(ICSLanguagesLocations.CurrentStrings[I], I, I, I, 0, nil);
  if Idx < cbLocations.Items.Count then cbLocations.ItemIndex := Idx;
end;

procedure TfrmEditProtocol.SetControlEnabled;
begin
  leScheme.Enabled := (TARObjectLocation(cbLocations.ItemIndex) in [olNetwork]);
  lePort.Enabled := (TARObjectLocation(cbLocations.ItemIndex) in [olNetwork]);

  PngImageListLogos.GetIcon(cbLocations.ItemIndex, Image1.Picture.Icon);
end;

end.
