unit uIconDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uForm, ICSLanguages, StdCtrls, ComCtrls,
  ButtonGroup, CategoryButtons, ExtCtrls, System.ImageList, Vcl.ImgList,
  PngImageList;

type
  TfrmIconDlg = class(TfrmForm)
    btnCancel: TButton;
    ButtonGroup1: TButtonGroup;
    procedure FormShow(Sender: TObject);
    procedure ButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGroup1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FIconIndex: Integer;
    FPngImageList: TPngImageList;
    procedure FillIconList;
  public
    property IconIndex: Integer read FIconIndex write FIconIndex;
  end;

function GetIconIndex(ImageList: TPngImageList; CurrentIndex: Integer = 0): Integer;

implementation

{$R *.dfm}

uses
  ShellAPI, GraphUtil, uCommonTools;

function GetIconIndex(ImageList: TPngImageList; CurrentIndex: Integer = 0): Integer;
begin
  Result := -1;
  with TfrmIconDlg.Create(Application) do try
    IconIndex := CurrentIndex;
    if Assigned(ImageList) then FPngImageList := ImageList;
    if ShowModal = mrOk then Result := IconIndex;
  finally
    Release;
  end;
end;

procedure TfrmIconDlg.ButtonGroup1ButtonClicked(Sender: TObject;
  Index: Integer);
begin
  inherited;
  FIconIndex := Index;
  ModalResult := mrOk;
end;

procedure TfrmIconDlg.ButtonGroup1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in [13, 32] then ButtonGroup1ButtonClicked(Sender, ButtonGroup1.ItemIndex);
end;

procedure TfrmIconDlg.FillIconList;
 var
   I: Integer;
   Btn: TGrpButtonItem;
begin
  ButtonGroup1.Items.BeginUpdate;
  try
    ButtonGroup1.Items.Clear;
    ButtonGroup1.Images := FPngImageList;
    for I := 0 to FPngImageList.Count - 1 do begin
      Btn := ButtonGroup1.Items.Add;
      Btn.ImageIndex := I;
    end;
  finally
    ButtonGroup1.Items.EndUpdate;
    if FIconIndex < ButtonGroup1.Items.Count then begin
      ButtonGroup1.ItemIndex := FIconIndex;
      ButtonGroup1.ScrollIntoView(FIconIndex);
    end;
  end;
end;

procedure TfrmIconDlg.FormCreate(Sender: TObject);
begin
  inherited;
  with ButtonGroup1 do SetBounds(Left, Top, ButtonWidth * 10 + GetSystemMetrics(SM_CYHSCROLL), Height);
  ClientWidth := ButtonGroup1.Left * 2 + ButtonGroup1.Width;
  ButtonGroup1.Anchors := [akLeft,akTop,akRight,akBottom];
end;

procedure TfrmIconDlg.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  try
    FillIconList;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
