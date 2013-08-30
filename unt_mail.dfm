object frm_mail: Tfrm_mail
  Left = 367
  Top = 179
  Width = 670
  Height = 537
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'QuickView'
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
    Top = 484
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
  end
  object lbl_attachlist: TLabel
    Left = 0
    Top = 390
    Width = 662
    Height = 13
    Align = alBottom
    Caption = 'Attachment-List'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 98
    Width = 662
    Height = 4
    Align = alTop
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 0
    Top = 386
    Width = 662
    Height = 4
    Align = alBottom
    Shape = bsBottomLine
  end
  object Bevel3: TBevel
    Left = 0
    Top = 476
    Width = 662
    Height = 8
    Align = alBottom
    Shape = bsBottomLine
  end
  object lv_attachment: TListView
    Left = 0
    Top = 403
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
    Height = 98
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnl_labels: TPanel
      Left = 0
      Top = 0
      Width = 61
      Height = 98
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
      Left = 61
      Top = 0
      Width = 601
      Height = 98
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lbl_mail_from: TLabel
        Left = 0
        Top = 0
        Width = 601
        Height = 17
        Align = alTop
        AutoSize = False
      end
      object lbl_mail_to: TLabel
        Left = 0
        Top = 17
        Width = 601
        Height = 17
        Align = alTop
        AutoSize = False
      end
      object lbl_mail_cc: TLabel
        Left = 0
        Top = 34
        Width = 601
        Height = 17
        Align = alTop
        AutoSize = False
      end
      object lbl_mail_date: TLabel
        Left = 0
        Top = 51
        Width = 601
        Height = 17
        Align = alTop
        AutoSize = False
      end
      object lbl_mail_subject: TLabel
        Left = 0
        Top = 68
        Width = 601
        Height = 17
        Align = alTop
        AutoSize = False
      end
    end
  end
  object mmo_body: TMemo
    Left = 24
    Top = 142
    Width = 205
    Height = 107
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object pd_mail: TPrintDialog
    Left = 632
    Top = 176
  end
end
