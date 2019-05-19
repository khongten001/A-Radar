unit uEditGroupMemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, SynEditHighlighter, SynHighlighterURI,
  SynEditMiscClasses, SynEditSearch, SynEditPrint, SynURIOpener,
  SynEditOptionsDialog, SynEdit,
  XMLIntf;

type
  TfrmEditGroupMemo = class(TfrmForm)
    SynEditMemo: TSynEdit;
    SynEditOptionsDialog1: TSynEditOptionsDialog;
    SynURIOpener1: TSynURIOpener;
    SynEditPrint1: TSynEditPrint;
    SynEditSearch1: TSynEditSearch;
    SynURISyn1: TSynURISyn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FXMLNode: IXMLNode;
    FGroupID: Integer;
  public
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
    property GroupID: Integer read FGroupID write FGroupID;
  end;

var
  frmEditGroupMemo: TfrmEditGroupMemo;

implementation

{$R *.dfm}

uses
  uCommonTools, uClasses, uXMLTools;

procedure TfrmEditGroupMemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FXMLNode) then xmlSetItemString(FXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE, icsB64Encode(SynEditMemo.Lines.Text));
  xmlSetItemInteger(FXMLNode, ND_PARAM_WIDTH, Width);
  xmlSetItemInteger(FXMLNode, ND_PARAM_HEIGHT, Height);
  xmlSetItemInteger(FXMLNode, ND_PARAM_LEFT, Left);
  xmlSetItemInteger(FXMLNode, ND_PARAM_TOP, Top);
  Action := caFree;
end;

procedure TfrmEditGroupMemo.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(FXMLNode) then begin
    Caption := xmlGetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);
    SynEditMemo.Lines.Text := icsB64Decode(xmlGetItemString(FXMLNode.ChildNodes[ND_MEMO], ND_PARAM_VALUE));
  end;
  SetBounds(xmlGetItemInteger(FXMLNode, ND_PARAM_LEFT, Left), xmlGetItemInteger(FXMLNode, ND_PARAM_TOP, Top), xmlGetItemInteger(FXMLNode, ND_PARAM_WIDTH, Width), xmlGetItemInteger(FXMLNode, ND_PARAM_HEIGHT, Height));
end;

end.
