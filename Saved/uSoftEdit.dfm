inherited frmSoftEdit: TfrmSoftEdit
  BorderStyle = bsDialog
  ClientHeight = 489
  ClientWidth = 625
  Position = poOwnerFormCenter
  ExplicitWidth = 631
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 13
  object ImageIcon: TImage [0]
    Left = 8
    Top = 8
    Width = 32
    Height = 32
  end
  object btnOk: TButton [1]
    Tag = 1
    Left = 452
    Top = 456
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object lePath: TLabeledEdit [2]
    Tag = 4
    Left = 168
    Top = 43
    Width = 418
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 1
    OnChange = lePathChange
  end
  object leParams: TLabeledEdit [3]
    Tag = 5
    Left = 168
    Top = 70
    Width = 449
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object leName: TLabeledEdit [4]
    Tag = 3
    Left = 168
    Top = 16
    Width = 449
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = '*'
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object btnSoftBrowse: TPngBitBtn [5]
    Left = 592
    Top = 43
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btnSoftBrowseClick
  end
  object PageControl1: TPageControl [6]
    Left = 8
    Top = 105
    Width = 609
    Height = 337
    ActivePage = TabSheet2
    TabOrder = 6
    object TabSheet1: TTabSheet
      Tag = 6
      Caption = 'TabSheet1'
      object lvProtocols: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 595
        Height = 303
        Align = alClient
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            AutoSize = True
          end
          item
            Width = 0
          end>
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      Tag = 7
      Caption = 'TabSheet2'
      ImageIndex = 1
      object SynEditDefaultParams: TSynEdit
        Left = 0
        Top = 0
        Width = 601
        Height = 309
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.ShowCollapsedLine = True
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        UseCodeFolding = False
        BorderStyle = bsNone
        Gutter.AutoSize = True
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.ShowLineNumbers = True
        FontSmoothing = fsmNone
      end
    end
  end
  object btnCancel: TButton [7]
    Tag = 2
    Left = 542
    Top = 456
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 5
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'Application'
          'Ok'
          'Cancel'
          'Display Name:'
          'Filename:'
          'Parameter Mask:'
          'Supported Protocols'
          'Default parameter File')
        LocaleName = 'English'
      end>
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executible|*.exe|All|*.*'
    Left = 520
    Top = 40
  end
end
