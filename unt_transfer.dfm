object frm_transfer: Tfrm_transfer
  Left = 5
  Top = 634
  HorzScrollBar.Smooth = True
  HorzScrollBar.Style = ssHotTrack
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Style = ssHotTrack
  VertScrollBar.Tracking = True
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Data Transfer Window'
  ClientHeight = 73
  ClientWidth = 292
  Color = clBtnFace
  Constraints.MaxHeight = 100
  Constraints.MaxWidth = 300
  Constraints.MinHeight = 100
  Constraints.MinWidth = 300
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_overall: TLabel
    Left = 0
    Top = 43
    Width = 292
    Height = 13
    Align = alBottom
    Alignment = taCenter
    Caption = 'Overall Progress'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btn_cancel: TSpeedButton
    Left = 108
    Top = 12
    Width = 73
    Height = 22
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = btn_cancelClick
  end
  object pgb_overall: TAdvProgressBar
    Left = 0
    Top = 56
    Width = 292
    Height = 17
    Align = alBottom
    BorderColor = clBlack
    CompletionSmooth = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0Color = clRed
    Level0ColorTo = 14811105
    Level1ColorTo = clOlive
    Level2Color = clLime
    Level2ColorTo = clGreen
    Level3Color = clLime
    Level3ColorTo = 13290239
    Level1Perc = 60
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Steps = 20
    Version = '1.1.0.0'
  end
end
