unit uEditGroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, Vcl.StdCtrls, Vcl.ExtCtrls,
  XMLIntf, System.ImageList, Vcl.ImgList, PngImageList, Vcl.Buttons, Vcl.Imaging.pngimage,
  PngBitBtn;

type
  TfrmEditGroup = class(TfrmForm)
    btnOk: TButton;
    btnCancel: TButton;
    leName: TLabeledEdit;
    ImageLogo: TImage;
    Label1: TLabel;
    PngBitBtnIcon: TPngBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure PngBitBtnIconClick(Sender: TObject);
  private
    FXMLNode: IXMLNode;
    FImageList: TPngImageList;
    procedure SetButtonIcon;
  public
    procedure FillControls;
    procedure ApplyXML;
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
    property ImageList: TPngImageList read FImageList write FImageList;
  end;

var
  frmEditGroup: TfrmEditGroup;

implementation

{$R *.dfm}

uses
  System.NetEncoding, uVCLTools, uClasses, uIconDlg, uXMLTools;

{ TfrmEditGroup }

procedure TfrmEditGroup.SetButtonIcon;
 var MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    FImageList.PngImages.Items[PngBitBtnIcon.HelpContext].PngImage.SaveToStream(MS);
    MS.Position := 0;
    PngBitBtnIcon.PngImage.LoadFromStream(MS);
    PngBitBtnIcon.Invalidate;
  finally
    MS.Free;
  end;
end;

procedure TfrmEditGroup.FillControls;
 var Idx: Integer;
begin
  leName.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE);
  Idx := xmlGetItemInteger(FXMLNode, ND_PARAM_ICONID);
  if Idx < FImageList.Count then PngBitBtnIcon.HelpContext := Idx else PngBitBtnIcon.HelpContext := MaxInt - APP_ARGROUP_ID_NORMAL;
  SetButtonIcon;
end;

procedure TfrmEditGroup.ApplyXML;
begin
  xmlSetItemString(FXMLNode.ChildNodes[ND_NAME], ND_PARAM_VALUE, leName.Text);
  xmlSetItemInteger(FXMLNode, ND_PARAM_ICONID, PngBitBtnIcon.HelpContext);
end;

procedure TfrmEditGroup.FormCreate(Sender: TObject);
begin
  inherited;
  ImageLogo.Picture.Icon.Assign(Application.Icon);
end;

procedure TfrmEditGroup.PngBitBtnIconClick(Sender: TObject);
 var Idx: Integer;
begin
  inherited;
  Idx := GetIconIndex(FImageList, xmlGetItemInteger(FXMLNode, ND_PARAM_ICONID));
  if Idx >= 0 then begin
    PngBitBtnIcon.HelpContext := Idx;
    SetButtonIcon;
  end;
end;

end.
