unit uChangePWD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uForm, ICSLanguages, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmChangeMasterPWD = class(TfrmForm)
    Bevel1: TBevel;
    btnOk: TButton;
    btnCancel: TButton;
    leOldPWD: TLabeledEdit;
    leNewPWD1: TLabeledEdit;
    leNewPWD2: TLabeledEdit;
    Image1: TImage;
    procedure leNewPWD1Change(Sender: TObject);
  private
    procedure SetControlEnables;
  public
    { Public declarations }
  end;

function InputNewMasterPassword(OwnerForm: TForm; OldPWD, DefaultPWD: String): String;

implementation

{$R *.dfm}

function InputNewMasterPassword(OwnerForm: TForm; OldPWD, DefaultPWD: String): String;
 var
   frmChangeMasterPWD: TfrmChangeMasterPWD;
   CheckPWD: String;
begin
  Result := '';
  if Assigned(OwnerForm) then begin
    frmChangeMasterPWD := TfrmChangeMasterPWD.Create(OwnerForm);
    try
      if frmChangeMasterPWD.ShowModal = mrOk then begin
        if frmChangeMasterPWD.leOldPWD.Text = '' then CheckPWD := DefaultPWD else CheckPWD := frmChangeMasterPWD.leOldPWD.Text;
        if CheckPWD = OldPWD then begin
          if frmChangeMasterPWD.leNewPWD1.Text = '' then Result := DefaultPWD else Result := frmChangeMasterPWD.leNewPWD1.Text;
        end;
      end;
    finally
      frmChangeMasterPWD.Release;
    end;
  end;
end;

{ TfrmChangeMasterPWD }

procedure TfrmChangeMasterPWD.leNewPWD1Change(Sender: TObject);
begin
  inherited;
  SetControlEnables;
end;

procedure TfrmChangeMasterPWD.SetControlEnables;
begin
  btnOk.Enabled := (leNewPWD1.Text = leNewPWD2.Text);
end;

end.
