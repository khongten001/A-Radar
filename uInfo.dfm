inherited frmInfo: TfrmInfo
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 383
  ClientWidth = 418
  Position = poScreenCenter
  ExplicitWidth = 418
  ExplicitHeight = 383
  PixelsPerInch = 96
  TextHeight = 13
  object ICSFrame1: TICSFrame [0]
    Left = 0
    Top = 0
    Width = 418
    Height = 383
    Align = alClient
    Color = 16776176
    ParentColor = False
    ExplicitLeft = 112
    ExplicitTop = 334
    ExplicitWidth = 80
    ExplicitHeight = 40
  end
  object Label1: TLabel [1]
    Left = 16
    Top = 24
    Width = 387
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Caption = 'A-Radar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object lVersion: TLabel [2]
    Left = 16
    Top = 55
    Width = 387
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Connection Manager and Monitor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ImageLogo: TImage [3]
    Left = 16
    Top = 16
    Width = 49
    Height = 48
    AutoSize = True
  end
  object btnOk: TPngBitBtn [4]
    Tag = 1
    Left = 328
    Top = 344
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'btnOk'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object SynEditMemo: TSynEdit [5]
    Left = 16
    Top = 93
    Width = 387
    Height = 245
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    TabOrder = 1
    CodeFolding.CollapsedLineColor = clGrayText
    CodeFolding.FolderBarLinesColor = clGrayText
    CodeFolding.ShowCollapsedLine = True
    CodeFolding.IndentGuidesColor = clGray
    CodeFolding.IndentGuides = True
    UseCodeFolding = False
    Gutter.AutoSize = True
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    Gutter.Visible = False
    Gutter.Width = 0
    Highlighter = SynURISyn1
    Lines.Strings = (
      'Powered by Oleg Chensky'
      ''
      'www: https://www.chensky.de'
      'email: info@chensky.de'
      ''
      
        'Many different placeholders are implemented. You can use it for ' +
        'all commands and strings.'
      ''
      'Object palceholders:'
      ''
      '%SELF.HOST%'
      '%SELF.RESOURCES%'
      '%SELF.PATH%'
      '%SELF.URI%'
      '%SELF.PORT%'
      '%SELF.USERNAME%'
      '%SELF.FULL_USERNAME%'
      '%SELF.PASSWORD%'
      '%SELF.CRYPT_PASSWORD%'
      '%SELF.DOMAIN%'
      '%SELF.SCHEME%'
      ''
      '%SELF.USERDEF_STRING_#%'
      '%SELF.PARAMFILE_#%'
      ''
      'Application placeholders:'
      ''
      '%APP.PATH%'
      ''
      
        'System placeholders are all enveronment placeholders such as %US' +
        'ERNAME% and following:'
      ''
      '%SYSTEM.NOW%')
    ReadOnly = True
    ScrollBars = ssVertical
    WordWrap = True
    FontSmoothing = fsmNone
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'A-Radar Info'
          'Ok')
        LocaleName = 'English'
      end>
  end
  object SynURISyn1: TSynURISyn
    Options.AutoDetectEnabled = True
    Options.AutoDetectLineLimit = 0
    Options.Visible = True
    Left = 348
    Top = 274
  end
  object SynURIOpener1: TSynURIOpener
    Editor = SynEditMemo
    URIHighlighter = SynURISyn1
    Left = 316
    Top = 274
  end
end
