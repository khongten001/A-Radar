inherited frmProtEdit: TfrmProtEdit
  BorderStyle = bsDialog
  ClientHeight = 107
  ClientWidth = 482
  Position = poOwnerFormCenter
  ExplicitWidth = 488
  ExplicitHeight = 136
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage [0]
    Left = 8
    Top = 8
    Width = 32
    Height = 32
  end
  object btnCancel: TButton [1]
    Tag = 2
    Left = 398
    Top = 75
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 4
  end
  object leName: TLabeledEdit [2]
    Tag = 3
    Left = 112
    Top = 16
    Width = 361
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object leScheme: TLabeledEdit [3]
    Tag = 5
    Left = 317
    Top = 43
    Width = 156
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object btnOk: TButton [4]
    Tag = 1
    Left = 317
    Top = 75
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object lePort: TLabeledEdit [5]
    Tag = 4
    Left = 112
    Top = 43
    Width = 65
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 1
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'Protocol/Service/Role'
          'Ok'
          'Cancel'
          'Name:'
          'Default Port:'
          'Scheme (incl. ://):')
        LocaleName = 'English'
      end>
  end
end
