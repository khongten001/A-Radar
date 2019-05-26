unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uCommonTools;

var
  ST: TStream;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ST.Size := 0;
  Memo1.Lines.SaveToStream(ST);
  if icsCryptDecryptStream(ST, 'xxx', True) then begin
    Memo1.Lines.Clear;
    Caption := 'Ok';
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if icsCryptDecryptStream(ST, 'xxx', False) then begin
    Memo1.Lines.LoadFromStream(ST);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ST := TStringStream.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ST.Free;
end;

end.

