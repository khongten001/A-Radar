inherited frmEditGroupMemo: TfrmEditGroupMemo
  ClientHeight = 367
  ClientWidth = 566
  KeyPreview = True
  OnClose = FormClose
  ExplicitWidth = 582
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 13
  object SynEditMemo: TSynEdit [0]
    Left = 0
    Top = 0
    Width = 566
    Height = 367
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
    Highlighter = SynURISyn1
    SearchEngine = SynEditSearch1
    FontSmoothing = fsmNone
  end
  object SynEditOptionsDialog1: TSynEditOptionsDialog
    UseExtendedStrings = True
    Left = 12
    Top = 38
  end
  object SynURIOpener1: TSynURIOpener
    Editor = SynEditMemo
    URIHighlighter = SynURISyn1
    Left = 12
    Top = 70
  end
  object SynEditPrint1: TSynEditPrint
    Copies = 1
    Header.DefaultFont.Charset = DEFAULT_CHARSET
    Header.DefaultFont.Color = clBlack
    Header.DefaultFont.Height = -13
    Header.DefaultFont.Name = 'Arial'
    Header.DefaultFont.Style = []
    Footer.DefaultFont.Charset = DEFAULT_CHARSET
    Footer.DefaultFont.Color = clBlack
    Footer.DefaultFont.Height = -13
    Footer.DefaultFont.Name = 'Arial'
    Footer.DefaultFont.Style = []
    Margins.Left = 25.000000000000000000
    Margins.Right = 15.000000000000000000
    Margins.Top = 25.000000000000000000
    Margins.Bottom = 25.000000000000000000
    Margins.Header = 15.000000000000000000
    Margins.Footer = 15.000000000000000000
    Margins.LeftHFTextIndent = 2.000000000000000000
    Margins.RightHFTextIndent = 2.000000000000000000
    Margins.HFInternalMargin = 0.500000000000000000
    Margins.MirrorMargins = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Highlighter = SynURISyn1
    TabWidth = 8
    Color = clWhite
    Left = 12
    Top = 102
  end
  object SynEditSearch1: TSynEditSearch
    Left = 12
    Top = 134
  end
  object SynURISyn1: TSynURISyn
    Options.AutoDetectEnabled = True
    Options.AutoDetectLineLimit = 0
    Options.Visible = True
    Left = 44
    Top = 70
  end
end
