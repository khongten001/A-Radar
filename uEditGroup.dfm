inherited frmEditGroup: TfrmEditGroup
  BorderStyle = bsDialog
  ClientHeight = 90
  ClientWidth = 505
  Position = poScreenCenter
  ExplicitWidth = 511
  ExplicitHeight = 119
  PixelsPerInch = 96
  TextHeight = 13
  object ImageLogo: TImage [0]
    Left = 16
    Top = 16
    Width = 33
    Height = 33
    AutoSize = True
  end
  object Label1: TLabel [1]
    Tag = 4
    Left = 111
    Top = 56
    Width = 6
    Height = 13
    Alignment = taRightJustify
    Caption = '*'
  end
  object btnCancel: TButton [2]
    Tag = 2
    Left = 419
    Top = 51
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 3
  end
  object PngBitBtnIcon: TPngBitBtn [3]
    Tag = 5
    Left = 120
    Top = 51
    Width = 73
    Height = 25
    TabOrder = 1
    OnClick = PngBitBtnIconClick
  end
  object leName: TLabeledEdit [4]
    Tag = 3
    Left = 120
    Top = 16
    Width = 374
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object btnOk: TButton [5]
    Tag = 1
    Left = 331
    Top = 51
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'A-Radar Group'
          'Ok'
          'Cancel'
          'Name:'
          'Icon:'
          'Select')
        LocaleName = 'English'
      end>
  end
end
