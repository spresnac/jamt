object frmFilter: TfrmFilter
  Left = 560
  Top = 186
  BorderStyle = bsToolWindow
  Caption = 'Filter-Einstellungen'
  ClientHeight = 298
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 683
    Height = 298
    ActivePage = TabSheet1
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Blacklist'
      object btnBLDeleteFilter: TSpeedButton
        Left = 652
        Top = 4
        Width = 20
        Height = 22
        Hint = 'Filter l'#246'schen'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
          555557777F777555F55500000000555055557777777755F75555005500055055
          555577F5777F57555555005550055555555577FF577F5FF55555500550050055
          5555577FF77577FF555555005050110555555577F757777FF555555505099910
          555555FF75777777FF555005550999910555577F5F77777775F5500505509990
          3055577F75F77777575F55005055090B030555775755777575755555555550B0
          B03055555F555757575755550555550B0B335555755555757555555555555550
          BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
          50BB555555555555575F555555555555550B5555555555555575}
        NumGlyphs = 2
        OnClick = btnBLDeleteFilterClick
      end
      object btnBLEditFilter: TSpeedButton
        Left = 608
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Filter '#228'ndern'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
          07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
          0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        OnClick = btnBLEditFilterClick
      end
      object btnBLNewFilter: TSpeedButton
        Left = 584
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Neuer Filter'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        OnClick = btnBLNewFilterClick
      end
      object Bevel1: TBevel
        Left = 2
        Top = 28
        Width = 671
        Height = 4
        Shape = bsTopLine
      end
      object lvBlacklist: TListView
        Left = 0
        Top = 32
        Width = 675
        Height = 238
        Align = alBottom
        Checkboxes = True
        Columns = <
          item
            Caption = 'Aktiv'
          end
          item
            Caption = 'Konto'
            Width = 120
          end
          item
            Caption = 'Bedingung'
            Width = 480
          end>
        HideSelection = False
        IconOptions.Arrangement = iaLeft
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvBlacklistClick
      end
      object cmbBLFilterType: TComboBox
        Left = 120
        Top = 4
        Width = 117
        Height = 21
        Style = csDropDownList
        DropDownCount = 3
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'Betreff'
          'Absender')
      end
      object cmbBLFilterCase: TComboBox
        Left = 240
        Top = 4
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 3
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'enth'#228'lt'
          'beginnt mit'
          'endet mit')
      end
      object edtBLFilterText: TEdit
        Left = 344
        Top = 4
        Width = 229
        Height = 21
        TabOrder = 3
      end
      object cmbBLFilterAccount: TComboBox
        Left = 0
        Top = 4
        Width = 117
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Whitelist'
      ImageIndex = 1
      object btnWLNewFilter: TSpeedButton
        Left = 584
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Neuer Filter'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        OnClick = btnWLNewFilterClick
      end
      object btnWLEditFilter: TSpeedButton
        Left = 608
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Filter '#228'ndern'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
          07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
          0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        OnClick = btnWLEditFilterClick
      end
      object btnWLDeleteFilter: TSpeedButton
        Left = 650
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Filter l'#246'schen'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
          555557777F777555F55500000000555055557777777755F75555005500055055
          555577F5777F57555555005550055555555577FF577F5FF55555500550050055
          5555577FF77577FF555555005050110555555577F757777FF555555505099910
          555555FF75777777FF555005550999910555577F5F77777775F5500505509990
          3055577F75F77777575F55005055090B030555775755777575755555555550B0
          B03055555F555757575755550555550B0B335555755555757555555555555550
          BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
          50BB555555555555575F555555555555550B5555555555555575}
        NumGlyphs = 2
        OnClick = btnWLDeleteFilterClick
      end
      object cmbWLFilterAccount: TComboBox
        Left = 0
        Top = 4
        Width = 117
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object cmbWLFilterType: TComboBox
        Left = 120
        Top = 4
        Width = 117
        Height = 21
        Style = csDropDownList
        DropDownCount = 3
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'Betreff'
          'Absender')
      end
      object cmbWLFilterCase: TComboBox
        Left = 240
        Top = 4
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 3
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'enth'#228'lt'
          'beginnt mit'
          'endet mit')
      end
      object edtWLFilterText: TEdit
        Left = 344
        Top = 4
        Width = 229
        Height = 21
        TabOrder = 3
      end
      object lvWhitelist: TListView
        Left = 0
        Top = 32
        Width = 675
        Height = 238
        Align = alBottom
        Checkboxes = True
        Columns = <
          item
            Caption = 'Aktiv'
          end
          item
            Caption = 'Konto'
            Width = 120
          end
          item
            Caption = 'Bedingung'
            Width = 480
          end>
        HideSelection = False
        IconOptions.Arrangement = iaLeft
        ReadOnly = True
        RowSelect = True
        TabOrder = 4
        ViewStyle = vsReport
        OnClick = lvWhitelistClick
      end
    end
  end
end
