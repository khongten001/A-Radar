inherited frmIconDlg: TfrmIconDlg
  ActiveControl = ButtonGroup1
  BorderIcons = [biSystemMenu, biMaximize]
  ClientHeight = 374
  ClientWidth = 320
  Position = poScreenCenter
  ExplicitWidth = 336
  ExplicitHeight = 413
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancel: TButton [0]
    Tag = 1
    Left = 233
    Top = 338
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 335
  end
  object ButtonGroup1: TButtonGroup [1]
    Left = 16
    Top = 16
    Width = 130
    Height = 313
    BorderStyle = bsNone
    ButtonWidth = 26
    ButtonOptions = [gboGroupStyle]
    Items = <>
    TabOrder = 0
    OnButtonClicked = ButtonGroup1ButtonClicked
    OnKeyDown = ButtonGroup1KeyDown
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'Please select your Icon'
          'Close')
        LocaleName = 'English'
      end>
  end
end
