unit uAdditionalParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm, ICSLanguages, Xml.XMLIntf,
  Vcl.ExtCtrls, SynEdit, System.ImageList, Vcl.ImgList, PngImageList,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, PngBitBtn;

type
  TfrmAdditionalParams = class(TfrmForm)
    SynEditParamFile1: TSynEdit;
    Panel1: TPanel;
    ActionList1: TActionList;
    ActionOk: TAction;
    ActionCancel: TAction;
    PngImageList1: TPngImageList;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Splitter1: TSplitter;
    SynEditDefaultParamFile1: TSynEdit;
    procedure FormShow(Sender: TObject);
    procedure ActionOkExecute(Sender: TObject);
    procedure ActionCancelExecute(Sender: TObject);
  private
    FXMLNode: IXMLNode;
  public
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
  end;

var
  frmAdditionalParams: TfrmAdditionalParams;

implementation

{$R *.dfm}

uses
  uCommonTools, uXMLTools, uClasses;

{ TfrmAdditionalParams }

procedure TfrmAdditionalParams.ActionCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAdditionalParams.ActionOkExecute(Sender: TObject);
begin
  inherited;
  xmlSetItemString(FXMLNode.ChildNodes[ND_PARAMFILE1], ND_PARAM_VALUE, icsB64Encode(SynEditParamFile1.Lines.Text));
  Close;
end;

procedure TfrmAdditionalParams.FormShow(Sender: TObject);
 var iSoftNode: IXMLNode;
begin
  inherited;
  SynEditParamFile1.Lines.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_PARAMFILE1], ND_PARAM_VALUE));
  iSoftNode := GetSoftNodeFromId(xmlGetItemString(FXMLNode.ChildNodes[ND_SOFT_ID], ND_PARAM_VALUE));
  SynEditDefaultParamFile1.Lines.Text := icsB64Decode(xmlGetItemString(iSoftNode.ChildNodes[ND_DEFAULT_PARAMFILE1], ND_PARAM_VALUE));
end;

end.
