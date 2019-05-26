unit uProtocolEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, PngBitBtn, XMLIntf, System.ImageList,
  Vcl.ImgList, PngImageList, Vcl.Menus;

type
  TfrmProtEdit = class(TfrmForm)
    btnOk: TButton;
    btnCancel: TButton;
    lePort: TLabeledEdit;
    leName: TLabeledEdit;
    Image1: TImage;
    leScheme: TLabeledEdit;
    procedure FormShow(Sender: TObject);
  private
    FXMLNode: IXMLNode;
    procedure FillControls;
  public
    procedure ApplyXML;
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
  end;

var
  frmProtEdit: TfrmProtEdit;

implementation

{$R *.dfm}

uses
  uCommonTools, uClasses, uXMLTools;

{ TfrmSoftEdit }

procedure TfrmProtEdit.ApplyXML;
begin
  xmlSetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, icsB64Encode(leName.Text));
  xmlSetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE, lePort.Text);
  xmlSetItemString(FXMLNode.ChildNodes[ND_SCHEME], ND_PARAM_VALUE, leScheme.Text);
end;

procedure TfrmProtEdit.FillControls;
begin
  leName.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE));
  lePort.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_PORT], ND_PARAM_VALUE);
  leScheme.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_SCHEME], ND_PARAM_VALUE);
end;

procedure TfrmProtEdit.FormShow(Sender: TObject);
begin
  inherited;
  FillControls;
end;

end.
