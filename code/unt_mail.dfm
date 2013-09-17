object frm_mail: Tfrm_mail
  Left = 367
  Top = 179
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'QuickView'
  ClientHeight = 503
  ClientWidth = 662
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 530
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_attachmentnote: TLabel
    Left = 0
    Top = 477
    Width = 662
    Height = 26
    Cursor = crHandPoint
    Align = alBottom
    Alignment = taCenter
    Caption = 
      'Note: You will find downloaded Attachment in the subfolder '#39'atta' +
      'ch'#39' of your'#13#10'applications root folder.Click here to open this fo' +
      'lder...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lbl_attachmentnoteDblClick
    ExplicitWidth = 350
  end
  object lbl_attachlist: TLabel
    Left = 0
    Top = 383
    Width = 662
    Height = 13
    Align = alBottom
    Caption = 'Attachment-List'
    ExplicitWidth = 73
  end
  object Bevel1: TBevel
    Left = 0
    Top = 86
    Width = 662
    Height = 4
    Align = alTop
    Shape = bsTopLine
    ExplicitTop = 98
  end
  object Bevel2: TBevel
    Left = 0
    Top = 379
    Width = 662
    Height = 4
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 386
  end
  object Bevel3: TBevel
    Left = 0
    Top = 469
    Width = 662
    Height = 8
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 476
  end
  object lv_attachment: TListView
    Left = 0
    Top = 396
    Width = 662
    Height = 73
    Align = alBottom
    BorderStyle = bsNone
    BorderWidth = 2
    Columns = <
      item
        Caption = 'ID'
        Width = 30
      end
      item
        Caption = 'Attachment'
        Width = 450
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    SmallImages = dm_main.il_16
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lv_attachmentDblClick
  end
  object pnl_header: TPanel
    Left = 0
    Top = 0
    Width = 662
    Height = 86
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    object pnl_labels: TPanel
      Left = 1
      Top = 1
      Width = 61
      Height = 84
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object lbl_subject: TLabel
        Left = 0
        Top = 68
        Width = 61
        Height = 17
        Align = alTop
        AutoSize = False
        Caption = 'Subject'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_date: TLabel
        Left = 0
        Top = 51
        Width = 61
        Height = 17
        Align = alTop
        AutoSize = False
        Caption = 'Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_cc: TLabel
        Left = 0
        Top = 34
        Width = 61
        Height = 17
        Align = alTop
        AutoSize = False
        Caption = 'CC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_to: TLabel
        Left = 0
        Top = 17
        Width = 61
        Height = 17
        Align = alTop
        AutoSize = False
        Caption = 'To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_from: TLabel
        Left = 0
        Top = 0
        Width = 61
        Height = 17
        Align = alTop
        AutoSize = False
        Caption = 'From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnl_fields: TPanel
      Left = 62
      Top = 1
      Width = 599
      Height = 84
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lbl_mail_from: TLabel
        Left = 0
        Top = 0
        Width = 599
        Height = 17
        Align = alTop
        AutoSize = False
        ExplicitWidth = 601
      end
      object lbl_mail_to: TLabel
        Left = 0
        Top = 17
        Width = 599
        Height = 17
        Align = alTop
        AutoSize = False
        ExplicitWidth = 601
      end
      object lbl_mail_cc: TLabel
        Left = 0
        Top = 34
        Width = 599
        Height = 17
        Align = alTop
        AutoSize = False
        ExplicitWidth = 601
      end
      object lbl_mail_date: TLabel
        Left = 0
        Top = 51
        Width = 599
        Height = 17
        Align = alTop
        AutoSize = False
        ExplicitWidth = 601
      end
      object lbl_mail_subject: TUniHTMLabel
        Left = 0
        Top = 68
        Width = 599
        Height = 17
        Align = alTop
        AnchorHint = False
        AutoSizing = False
        AutoSizeType = asVertical
        Ellipsis = False
        HintShowFull = False
        Hover = False
        HoverColor = clNone
        HoverFontColor = clNone
        HTMLHint = False
        ShadowColor = clGray
        ShadowOffset = 2
        URLColor = clBlue
        VAlignment = tvaTop
        Version = '1.0.0.0'
        ExplicitTop = 66
        ExplicitWidth = 597
      end
    end
  end
  object pcMail: TPageControl
    Left = 0
    Top = 90
    Width = 662
    Height = 289
    ActivePage = tsHTML
    Align = alClient
    TabOrder = 2
    object tsText: TTabSheet
      Caption = 'Normal'
      object mmo_body: TMemo
        Left = 0
        Top = 0
        Width = 654
        Height = 261
        Cursor = crIBeam
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsHTML: TTabSheet
      Caption = 'HTML'
      ImageIndex = 1
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 654
        Height = 261
        Align = alClient
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        ExplicitLeft = 132
        ExplicitTop = 32
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C00000098430000FA1A00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620A000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object pd_mail: TPrintDialog
    Left = 612
    Top = 16
  end
end
