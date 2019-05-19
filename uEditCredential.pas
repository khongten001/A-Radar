unit uEditCredential;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, XML.XMLIntf,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, PngSpeedButton, PngBitBtn,
  Vcl.Imaging.pngimage;

type
  TfrmEditCredential = class(TfrmForm)
    sbShowPWD: TPngSpeedButton;
    leUsername: TLabeledEdit;
    lePassword: TLabeledEdit;
    leDomain: TLabeledEdit;
    leName: TLabeledEdit;
    Bevel1: TBevel;
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    Image1: TImage;
    procedure sbShowPWDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbShowPWDMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    FCredentialXMLNode: IXMLNode;
    procedure FillControls;
  public
    procedure ApplyXML;
    property CredentialXMLNode: IXMLNode read FCredentialXMLNode write FCredentialXMLNode;
  end;

var
  frmEditCredential: TfrmEditCredential;

implementation

{$R *.dfm}

uses
  uClasses, uCommonTools, uXMLTools;

procedure TfrmEditCredential.ApplyXML;
begin
  xmlSetItemString(CredentialXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(CredentialXMLNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE, leUsername.Text);
  xmlSetItemString(CredentialXMLNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE, lePassword.Text);
  xmlSetItemString(CredentialXMLNode.ChildNodes[ND_DOMAIN], ND_PARAM_VALUE, leDomain.Text);
end;

procedure TfrmEditCredential.FillControls;
begin
  leName.Text := icsB64Decode(xmlGetItemString(CredentialXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  leUsername.Text := xmlGetItemString(CredentialXMLNode.ChildNodes[ND_USERNAME], ND_PARAM_VALUE);
  lePassword.Text := xmlGetItemString(CredentialXMLNode.ChildNodes[ND_PASSWORD], ND_PARAM_VALUE);
  leDomain.Text := xmlGetItemString(CredentialXMLNode.ChildNodes[ND_DOMAIN], ND_PARAM_VALUE);
end;

procedure TfrmEditCredential.FormShow(Sender: TObject);
begin
  inherited;
  FillControls;
end;

procedure TfrmEditCredential.sbShowPWDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lePassword.PasswordChar := #0;
end;

procedure TfrmEditCredential.sbShowPWDMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lePassword.PasswordChar := '*';
end;

end.
