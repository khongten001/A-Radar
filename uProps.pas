unit uProps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, Vcl.StdCtrls, Vcl.ComCtrls,
  XMLIntf, Vcl.ExtCtrls, Vcl.Buttons, PngBitBtn, PngSpeedButton,
  ICSSpinLabeledEdit;

type
  TfrmProps = class(TfrmForm)
    btnOk: TPngBitBtn;
    btnCancel: TPngBitBtn;
    cbAutoStart: TCheckBox;
    cbStartMinimized: TCheckBox;
    btnSetMasterPWD: TPngBitBtn;
    ICSLanguagesMsg: TICSLanguages;
    GroupBox1: TGroupBox;
    leInterval: TICSSpinLabeledEdit;
    leErrorInterval: TICSSpinLabeledEdit;
    ImageLogo: TImage;
    procedure cbAutoStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSetMasterPWDClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPropertiesXMLNode: IXMLNode;
    procedure SetControlEnables;
    procedure SetControlValues;
    procedure ApplyProperties;
  end;

var
  frmProps: TfrmProps;

implementation

{$R *.dfm}

uses
  uCommonTools, uClasses, uChangePWD, Vcl.Themes, Vcl.Styles, uXMLTools, uPWD;

{ TfrmProps }

procedure TfrmProps.btnOkClick(Sender: TObject);
begin
  inherited;
  ApplyProperties;
end;

procedure TfrmProps.btnSetMasterPWDClick(Sender: TObject);
 var S: String;
begin
  inherited;
  S := InputNewMasterPassword(Self, ARMasterPassword, APP_CLSID);
  if (S <> '') and SaveXMLToFile(FXML, GetMainXMLFileName, S) then begin
    ARMasterPassword := S;
    MessageBox(Handle, PChar(ICSLanguagesMsg.CurrentStrings[0]), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
  end;
end;

procedure TfrmProps.cbAutoStartClick(Sender: TObject);
begin
  inherited;
  SetControlEnables;
end;

procedure TfrmProps.FormCreate(Sender: TObject);
begin
  inherited;
  FPropertiesXMLNode := FXML.DocumentElement.ChildNodes[ND_PROPERTIES];
  ImageLogo.Picture.Icon.Assign(Application.Icon);
end;

procedure TfrmProps.FormShow(Sender: TObject);
begin
  inherited;
  SetControlValues;
  SetControlEnables;
end;

procedure TfrmProps.SetControlEnables;
begin
end;

procedure TfrmProps.SetControlValues;
begin
  cbAutoStart.Checked := GetAutoStart;
  cbStartMinimized.Checked := xmlGetItemBoolean(FPropertiesXMLNode, ND_PARAM_START_MINIMIZED);
  leInterval.Text := xmlGetItemString(FPropertiesXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE);
  leErrorInterval.Text := xmlGetItemString(FPropertiesXMLNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE);
end;

procedure TfrmProps.ApplyProperties;
begin
  SetAutoStart(cbAutoStart.Checked);
  xmlSetItemBoolean(FPropertiesXMLNode, ND_PARAM_START_MINIMIZED, cbStartMinimized.Checked);
  xmlSetItemString(FPropertiesXMLNode.ChildNodes[ND_INTERVAL], ND_PARAM_VALUE, leInterval.Text);
  xmlSetItemString(FPropertiesXMLNode.ChildNodes[ND_ERRORINTERVAL], ND_PARAM_VALUE, leErrorInterval.Text);
end;

end.
