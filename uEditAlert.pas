unit uEditAlert;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Vcl.StdCtrls,
  Vcl.ExtCtrls, XML.XMLIntf, Vcl.Imaging.pngimage, Vcl.Buttons, PngBitBtn,
  ICSSpinLabeledEdit;

type
  TfrmEditAlert = class(TfrmForm)
    GroupBox1: TGroupBox;
    cbScreenMessage: TCheckBox;
    cbEMail: TCheckBox;
    cbSMS: TCheckBox;
    cbGoodAlert: TCheckBox;
    leRepeatInterval: TICSSpinLabeledEdit;
    Bevel1: TBevel;
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    Image1: TImage;
    leNegativeTriggerCount: TICSSpinLabeledEdit;
    leName: TLabeledEdit;
    procedure FormShow(Sender: TObject);
  private
    FAlertXMLNode: IXMLNode;
    procedure FillControls;
  public
    procedure ApplyXML;
    property AlertXMLNode: IXMLNode read FAlertXMLNode write FAlertXMLNode;
  end;

var
  frmEditAlert: TfrmEditAlert;

implementation

{$R *.dfm}

uses
  uCommonTools, uXMLTools, uClasses;

{ TfrmEditAlert }

procedure TfrmEditAlert.ApplyXML;
begin
  xmlSetItemString(FAlertXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(FAlertXMLNode.ChildNodes[ND_SILENT_COUNT], ND_PARAM_VALUE, leNegativeTriggerCount.Text);
  xmlSetItemBoolean(FAlertXMLNode.ChildNodes[ND_SCREEN_MSG], ND_PARAM_VALUE, cbScreenMessage.Checked);
  xmlSetItemBoolean(FAlertXMLNode.ChildNodes[ND_SEND_MAIL], ND_PARAM_VALUE,cbEMail.Checked);
  xmlSetItemBoolean(FAlertXMLNode.ChildNodes[ND_SEND_SMS], ND_PARAM_VALUE, cbSMS.Checked);
  xmlSetItemString(FAlertXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE, leRepeatInterval.Text);
  xmlSetItemBoolean(FAlertXMLNode.ChildNodes[ND_GOOD_ALERT], ND_PARAM_VALUE, cbGoodAlert.Checked);
end;

procedure TfrmEditAlert.FillControls;
begin
  leName.Text := icsB64Decode(xmlGetItemString(FAlertXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  leNegativeTriggerCount.Text := xmlGetItemString(FAlertXMLNode.ChildNodes[ND_SILENT_COUNT], ND_PARAM_VALUE, '0');
  cbScreenMessage.Checked := xmlGetItemBoolean(FAlertXMLNode.ChildNodes[ND_SCREEN_MSG], ND_PARAM_VALUE);
  cbEMail.Checked := xmlGetItemBoolean(FAlertXMLNode.ChildNodes[ND_SEND_MAIL], ND_PARAM_VALUE);
  cbSMS.Checked := xmlGetItemBoolean(FAlertXMLNode.ChildNodes[ND_SEND_SMS], ND_PARAM_VALUE);
  leRepeatInterval.Text := xmlGetItemString(FAlertXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE, '0');
  cbGoodAlert.Checked := xmlGetItemBoolean(FAlertXMLNode.ChildNodes[ND_GOOD_ALERT], ND_PARAM_VALUE);
end;

procedure TfrmEditAlert.FormShow(Sender: TObject);
begin
  inherited;
  FillControls;
end;

end.
