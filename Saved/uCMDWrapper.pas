unit uCMDWrapper;

interface

uses
  Winapi.Windows, uForm, DosCommand, Vcl.StdCtrls, Vcl.Buttons, PngBitBtn,
  Vcl.Controls, System.Classes, ICSLanguages, Forms;

type
  TfrmCMDWrapper = class(TfrmForm)
    MemoLog: TMemo;
    DosCommand: TDosCommand;
    btnClose: TPngBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DosCommandNewChar(ASender: TObject; ANewChar: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure DosCommandTerminated(Sender: TObject);
  private
    FCMD: String;
  public
    property CMD: String read FCMD write FCMD;
  end;

var
  frmCMDWrapper: TfrmCMDWrapper;

implementation

{$R *.dfm}

uses
  uCommonTools;

procedure TfrmCMDWrapper.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCMDWrapper.DosCommandNewChar(ASender: TObject; ANewChar: Char);
begin
  inherited;
  if ANewChar <> #10 then MemoLog.Lines.Text := MemoLog.Lines.Text + ANewChar;
end;

procedure TfrmCMDWrapper.DosCommandTerminated(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCMDWrapper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DosCommand.IsRunning then DosCommand.Stop;
  Action := caFree;
end;

procedure TfrmCMDWrapper.FormCreate(Sender: TObject);
begin
  inherited;
  FCMD := nil;
  MemoLog.Lines.Clear;
end;

procedure TfrmCMDWrapper.FormShow(Sender: TObject);
begin
  inherited;
  MemoLog.Lines.Add('>>' + CMD);
  DosCommand.CommandLine := FCMD;
  DosCommand.Execute;
end;

end.
