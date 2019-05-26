inherited frmCMDWrapper: TfrmCMDWrapper
  ClientHeight = 551
  ClientWidth = 784
  KeyPreview = True
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 13
  object MemoLog: TMemo [0]
    Left = 8
    Top = 8
    Width = 768
    Height = 504
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    OEMConvert = True
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
  object btnClose: TPngBitBtn [1]
    Left = 701
    Top = 518
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 1
    OnClick = btnCloseClick
  end
  inherited ICSLanguages1: TICSLanguages
    Languages = <
      item
        Strings.Strings = (
          'CMD Wrapper'
          'Close')
        LocaleName = 'English'
      end>
  end
  object DosCommand: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewChar = DosCommandNewChar
    OnTerminated = DosCommandTerminated
    Left = 8
    Top = 40
  end
end
