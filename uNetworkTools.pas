unit uNetworkTools;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, Vcl.StdCtrls, DosCommand, XMLIntf, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList,
  uClasses, System.ImageList, Vcl.ImgList, PngImageList, Vcl.Buttons,
  PngBitBtn, Vcl.ComCtrls;

type
  TfrmNetworkTools = class(TfrmForm)
    MemoLog: TMemo;
    DosCommandPing: TDosCommand;
    leHost: TLabeledEdit;
    btnStart: TPngBitBtn;
    btnStop: TPngBitBtn;
    btnClose: TPngBitBtn;
    cbContinuously: TCheckBox;
    ActionList1: TActionList;
    ActionClose: TAction;
    ActionStart: TAction;
    ActionStop: TAction;
    TimerStatus: TTimer;
    cbTools: TComboBoxEx;
    Label1: TLabel;
    PngImageList1: TPngImageList;
    PngImageListTool: TPngImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionStartUpdate(Sender: TObject);
    procedure ActionStopUpdate(Sender: TObject);
    procedure ActionStopExecute(Sender: TObject);
    procedure ActionStartExecute(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DosCommandPingNewChar(ASender: TObject; ANewChar: Char);
    procedure cbToolsChange(Sender: TObject);
  private
    FXMLNode: IXMLNode;
    FNetworkTool: TARNetworkTool;
    procedure InitializePing;
    procedure SetControlEnables;
  public
    property XMLNode: IXMLNode read FXMLNode write FXMLNode;
    property NetworkTool: TARNetworkTool read FNetworkTool write FNetworkTool;
  end;

var
  frmNetworkTools: TfrmNetworkTools;

implementation

{$R *.dfm}

uses
  uXMLTools;

procedure TfrmNetworkTools.ActionCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmNetworkTools.ActionStartExecute(Sender: TObject);
begin
  inherited;
  InitializePing;
  DosCommandPing.Execute;
  TimerStatus.Enabled := True;
end;

procedure TfrmNetworkTools.ActionStartUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (leHost.Text <> '') and not DosCommandPing.IsRunning;
end;

procedure TfrmNetworkTools.ActionStopExecute(Sender: TObject);
begin
  inherited;
  TimerStatus.Enabled := False;
  if DosCommandPing.IsRunning then DosCommandPing.Stop;
end;

procedure TfrmNetworkTools.ActionStopUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := DosCommandPing.IsRunning;
end;

procedure TfrmNetworkTools.cbToolsChange(Sender: TObject);
begin
  inherited;
  DosCommandPing.Stop;
  if cbTools.ItemIndex >= 0 then SetControlEnables;
end;

procedure TfrmNetworkTools.DosCommandPingNewChar(ASender: TObject; ANewChar: Char);
begin
  inherited;
  if ANewChar <> #10 then MemoLog.Lines.Text := MemoLog.Lines.Text + ANewChar;
end;

procedure TfrmNetworkTools.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DosCommandPing.IsRunning then DosCommandPing.Stop;
  Action := caFree;
end;

procedure TfrmNetworkTools.FormCreate(Sender: TObject);
begin
  inherited;
  FXMLNode := nil;
  FNetworkTool := ntPing;
end;

procedure TfrmNetworkTools.FormShow(Sender: TObject);
begin
  inherited;
  leHost.Text := xmlGetItemString(FXMLNode.ChildNodes[ND_HOST], ND_PARAM_VALUE);
  cbTools.ItemIndex := Ord(FNetworkTool);
  SetControlEnables;
  UpdateActions;
  if ActionStart.Enabled then ActionStart.Execute;
end;

procedure TfrmNetworkTools.InitializePing;
 var CMD: String;
begin
  MemoLog.Lines.Clear;
  case TARNetworkTool(cbTools.ItemIndex) of
    ntPing: begin
      CMD := 'ping ';
      if cbContinuously.Checked then CMD := CMD + '-t ';
      CMD := CMD + leHost.Text;
    end;
    ntTracert: CMD := 'tracert ' + leHost.Text;
  end;
  DosCommandPing.CommandLine := CMD;
  MemoLog.Lines.Add(ICSLanguages1.CurrentStrings[7] + ' ' + CMD);
end;

procedure TfrmNetworkTools.SetControlEnables;
begin
  cbContinuously.Enabled := (TARNetworkTool(cbTools.ItemIndex) in [ntPing]);
end;

procedure TfrmNetworkTools.TimerStatusTimer(Sender: TObject);
begin
  inherited;
  if DosCommandPing.EndStatus <> esStill_Active then ActionStop.Execute;
end;

end.
