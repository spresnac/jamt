object frm_main: Tfrm_main
  Left = 277
  Top = 160
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  ClientHeight = 363
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = dm_main.mm_main
  OldCreateOrder = False
  Position = poDesktopCenter
  PrintScale = poNone
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 160
    Top = 30
    Height = 313
    ResizeStyle = rsUpdate
    ExplicitLeft = 80
    ExplicitHeight = 413
  end
  object sb_main: TStatusBar
    Left = 0
    Top = 343
    Width = 949
    Height = 20
    Panels = <
      item
        Width = 175
      end
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object lv_main: TListView
    Left = 163
    Top = 30
    Width = 786
    Height = 313
    Cursor = crHandPoint
    Align = alClient
    BorderStyle = bsNone
    BorderWidth = 1
    Checkboxes = True
    Columns = <
      item
        ImageIndex = 29
        Width = 40
      end
      item
        Caption = '!'
        Width = 20
      end
      item
        Caption = 'Datum'
        Width = 160
      end
      item
        Alignment = taRightJustify
        Caption = 'Groesse'
        Width = 70
      end
      item
        Caption = 'Von'
        Width = 180
      end
      item
        Caption = 'Betreff'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    HotTrackStyles = [htUnderlineCold, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    PopupMenu = dm_main.pum_maillist
    ShowWorkAreas = True
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = lv_mainClick
    OnDblClick = lv_mainDblClick
  end
  object tv_main: TTreeView
    Left = 0
    Top = 30
    Width = 160
    Height = 313
    Cursor = crHandPoint
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    Indent = 19
    ParentFont = False
    PopupMenu = dm_main.pum_accountlist
    ReadOnly = True
    RowSelect = True
    ShowRoot = False
    TabOrder = 2
    OnClick = tv_mainClick
    OnDblClick = tv_mainDblClick
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 949
    Height = 30
    Align = alTop
    TabOrder = 3
    object tb_main: TToolBar
      Left = 80
      Top = 2
      Width = 798
      Height = 22
      AutoSize = True
      ButtonWidth = 75
      Caption = 'tb_main'
      Images = dm_main.il_16
      List = True
      ShowCaptions = True
      TabOrder = 0
      object btn_getlist: TToolButton
        Left = 0
        Top = 0
        Caption = 'Get List'
        ImageIndex = 4
        MenuItem = dm_main.GetList1
        OnClick = btn_getlistClick
      end
      object btn_deletemails: TToolButton
        Left = 75
        Top = 0
        Caption = 'Delete'
        ImageIndex = 1
        OnClick = btn_deletemailsClick
      end
      object btn_markall: TToolButton
        Left = 150
        Top = 0
        Caption = 'Mark All'
        Enabled = False
        ImageIndex = 13
        OnClick = btn_markallClick
      end
      object ToolButton10: TToolButton
        Left = 225
        Top = 0
        Width = 16
        Caption = 'ToolButton10'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object ToolButton1: TToolButton
        Left = 241
        Top = 0
        Caption = 'Filter'
        ImageIndex = 16
        MenuItem = dm_main.Filter1
      end
      object btn_firewall: TToolButton
        Left = 316
        Top = 0
        Caption = 'Firewall'
        ImageIndex = 3
        MenuItem = dm_main.General1
      end
      object btn_accounts: TToolButton
        Left = 391
        Top = 0
        Caption = 'Accounts'
        ImageIndex = 8
        MenuItem = dm_main.Accounts1
      end
      object btn_language: TToolButton
        Left = 466
        Top = 0
        Caption = 'Language'
        ImageIndex = 6
        MenuItem = dm_main.Language1
      end
      object ToolButton11: TToolButton
        Left = 541
        Top = 0
        Width = 16
        Caption = 'ToolButton11'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object ToolButton12: TToolButton
        Left = 557
        Top = 0
        Caption = 'Info'
        ImageIndex = 5
        MenuItem = dm_main.Info1
      end
    end
  end
end
