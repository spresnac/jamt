unit unt_dmmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,ImgList, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3,
  IdMessage, IdCustomTransparentProxy, IdSocks, IdCoder, IdCoder3to4,
  IdCoderMIME, IdMessageCoder, IdMessageCoderMIME, IdCoder00E, IdCoderUUE,
  IdCoderQuotedPrintable, IdCoderXXE;

type Tdm_main = class(TDataModule)
    mm_main: TMainMenu;
    Programm1: TMenuItem;
    N1: TMenuItem;
    Info1: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    GetList1: TMenuItem;
    Settings1: TMenuItem;
    Language1: TMenuItem;
    Accounts1: TMenuItem;
    il_16: TImageList;
    General1: TMenuItem;
    pum_maillist: TPopupMenu;
    QuickView1: TMenuItem;
    N2: TMenuItem;
    Delete1: TMenuItem;
    pum_accountlist: TPopupMenu;
    Liste1: TMenuItem;
    N4: TMenuItem;
    Verwaltung1: TMenuItem;
    pop3_indy: TIdPOP3;
    mail_message: TIdMessage;
    IdSocksInfo1: TIdSocksInfo;
    N5: TMenuItem;
    Filter1: TMenuItem;
    IdDecoderUUE1: TIdDecoderUUE;
    IdDecoderMIME1: TIdDecoderMIME;
    IdDecoderQuotedPrintable1: TIdDecoderQuotedPrintable;
    IdDecoderXXE1: TIdDecoderXXE;
    procedure Info1Click(Sender: TObject);
    procedure GetList1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure Language1Click(Sender: TObject);
    procedure Accounts1Click(Sender: TObject);
    procedure pop3_indyWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure pop3_indyWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure General1Click(Sender: TObject);
    procedure pum_maillistPopup(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure QuickView1Click(Sender: TObject);
    procedure pop3_indyConnected(Sender: TObject);
    procedure pop3_indyDisconnected(Sender: TObject);
    procedure pum_accountlistPopup(Sender: TObject);
    procedure Liste1Click(Sender: TObject);
    procedure Verwaltung1Click(Sender: TObject);
    procedure Filter1Click(Sender: TObject);
  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
    m_iCurrentMsg: Integer;
    m_bGetList: boolean;

  end;

var
  dm_main: Tdm_main;

implementation

uses unt_info, unt_main, unt_mail, unt_globals, unt_options, unt_transfer,
  unt_filter;

{$R *.DFM}

procedure Tdm_main.Info1Click(Sender: TObject);
begin
    frm_info.ShowModal;
end;

procedure Tdm_main.GetList1Click(Sender: TObject);
begin
    frm_main.btn_getlistClick(self);
end;

procedure Tdm_main.Exit1Click(Sender: TObject);
begin
     // Exit the programm
     // When Programm still connected, disconnect
     if (dm_main.pop3_indy.Connected) then
        dm_main.pop3_indy.Disconnect;
     Application.Terminate;
end;
procedure Tdm_main.DataModuleCreate(Sender: TObject);
begin
     // Translate full
     cls_globals.changeLanguage;

     // Set the Firewall
     cls_globals.setFirewall;

     // Setzen des Flags auf Startposition
     dm_main.pop3_indy.Tag := -9;
end;

procedure Tdm_main.Language1Click(Sender: TObject);
begin
     // Set Tab
     frm_options.PageControl1.ActivePage := frm_options.tab_language;

     // Open Options Menu
     frm_options.ShowModal;
end;

procedure Tdm_main.Accounts1Click(Sender: TObject);
begin
     // Set Tab
     frm_options.PageControl1.ActivePage := frm_options.tab_accounts;

     // Open Options Menu
     frm_options.ShowModal;
end;

procedure Tdm_main.pop3_indyWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin

     if (cls_globals.m_HeaderOnly) then
        exit

     else begin

          frm_transfer.pgb_overall.Tag          := cls_globals.m_iMessageBytes;
//          frm_transfer.pgb_overall.Min          := 0;
          frm_transfer.pgb_overall.Position     := 0;

          Application.ProcessMessages;

     end;
end;

procedure Tdm_main.pop3_indyWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
var
    iTemp: Integer;
    sTemp: String;
    dTemp: Double;
begin

    // if geting only header, do not show progress
    if (cls_globals.m_HeaderOnly) then
        Exit;


    // Show Progress
    frm_transfer.lbl_overall.Caption  := cls_globals.translate( 'busy' );

    if frm_transfer.pgb_overall.Tag = 0 then
        dTemp                         := 0
    else
        dTemp                         := (100 / frm_transfer.pgb_overall.Tag) * AWorkCount;
    sTemp                             := FloatToStrF(dTemp,ffFixed,18,0);
    iTemp                             := StrToInt(sTemp);

    frm_transfer.pgb_overall.Position := iTemp;
    Application.ProcessMessages;

end;

procedure Tdm_main.General1Click(Sender: TObject);
begin
     // Set Tab
     frm_options.PageControl1.ActivePage := frm_options.tab_firewall;

     // Open Options Menu
     frm_options.ShowModal;
end;

procedure Tdm_main.pum_maillistPopup(Sender: TObject);
begin
     // On popping up, translate the menue
     Delete1.Caption                   := cls_globals.translate('Delete');

     // Check for en or disableing
     if (frm_main.lv_main.SelCount <= 0) then
    begin
         Delete1.Enabled    := false;
         QuickView1.Enabled := false;
    end
    else begin
         Delete1.Enabled    := true;
         QuickView1.Enabled := true;
    end;
end;

procedure Tdm_main.Delete1Click(Sender: TObject);
begin
     if not (frm_main.lv_main.Selected.Checked) then
        frm_main.lv_main.Selected.Checked := true;
     frm_main.btn_deletemailsClick(self);
end;

procedure Tdm_main.QuickView1Click(Sender: TObject);
begin
     frm_main.lv_mainDblClick(self);
end;

procedure Tdm_main.pop3_indyConnected(Sender: TObject);
begin

     frm_main.sb_main.Panels[0].Text   := cls_globals.translate('Connected');
     Application.ProcessMessages;

end;

procedure Tdm_main.pop3_indyDisconnected(Sender: TObject);
begin
    // Show Disconnection
    frm_main.sb_main.Panels[0].Text   := cls_globals.translate('Disconnected');
    frm_main.sb_main.Panels[1].Text   := '';
    Application.ProcessMessages;

    // Enable TreeView
    frm_main.tv_main.Enabled          := true;
    frm_main.lv_main.Enabled          := true;
    Application.ProcessMessages;

     // Re-Enable Buttons
    frm_main.btn_getlist.Enabled := true;
    frm_main.lv_main.Enabled     := true;
    frm_main.tv_main.Enabled     := true;
    Application.ProcessMessages;
end;

procedure Tdm_main.pum_accountlistPopup(Sender: TObject);
begin
    // Translate all Pop-up Entries
    Liste1.Caption                   := cls_globals.translate('GetList');
    Verwaltung1.Caption              := cls_globals.translate('Accounts');

    // Check, if a Account is selected
    if (frm_main.tv_main.Selected.Index < 0) then
    begin
         Liste1.Enabled                 := False;
         Verwaltung1.Enabled            := True;
    end
    else begin
         Liste1.Enabled                 := True;
         Verwaltung1.Enabled            := True;
    end;
end;

procedure Tdm_main.Liste1Click(Sender: TObject);
begin
     GetList1Click(Self);
end;

procedure Tdm_main.Verwaltung1Click(Sender: TObject);
begin
     Accounts1Click(Self);
end;

procedure Tdm_main.Filter1Click(Sender: TObject);
begin
    frmFilter.ShowModal;
end;

end.
