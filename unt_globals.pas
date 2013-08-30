unit unt_globals;

interface

uses
    Forms,inifiles, sysutils,IdMessage,classes,comctrls,Windows,Controls,
    IdSocks,IdAttachment,IdText,ShellAPI;

type
    TGlobals     = class

    private

    public

          m_lAccounts                 : array of String;
          m_lServer                   : array of String;
          m_lPort                     : array of integer;
          m_lUserID                   : array of String;
          m_lPasswort                 : array of String;
          m_lpwc                      : array of integer;
          m_lDelete                   : array of String;

          m_LangFile                  : TIniFile;
          m_ConfigFile                : TIniFile;
          m_AccountFile               : TIniFile;
          m_tfMessages                : TextFile;

          m_HeaderOnly                : boolean;
          m_NumberMsg                 : integer;
          m_iLastSelectedAccount      : integer;
          m_iMessageBytes             : integer;

          function                    cryptText(Sender:TObject;sText:string):string;
          function                    decryptText(Sender:TObject;sText:string):string;

          function                    translate(sWord:String):String;
          procedure                   changeLanguage();
          procedure                   readAccounts();
          procedure                   showAccounts();
          procedure                   showMail();

          function                    writeFirewall2file( bUseFirewall:boolean;
                                                          sAdress:string;
                                                          iPort:integer;
                                                          sTyp:string;
                                                          bAuthNeed:boolean;
                                                          sUsername:string;
                                                          sPassword:string):integer;
          procedure                   setFirewall;

          function                    saveWindowPosition(Sender:TObject;WindowSize:TWindowState;top:integer;left:integer;height:integer;width:integer):integer;
          function                    loadWindowPosition(Sender:TObject):integer;

          function                    labellink(Sender: TObject; sLinkToNavigateTo: string): integer;

    end;

var
   cls_globals:TGlobals;

implementation

uses unt_info, unt_main, unt_mail, unt_dmmain;

function TGlobals.translate(sWord:String):String;
var
   sFoundWord:String;
begin
    // Translate a given Word to other Language as given in the lng.ini
    sFoundWord := m_LangFile.ReadString('general',sWord,'?****?');
    result     := sFoundWord;
end;

procedure TGlobals.changeLanguage();
begin
    // Changes Language of full Application

    // Set the Columns of the ListView
    frm_main.lv_main.Columns[1].Caption := '!';
    frm_main.lv_main.Columns[2].Caption := cls_globals.translate( 'Date');
    frm_main.lv_main.Columns[3].Caption := cls_globals.translate( 'Size');
    frm_main.lv_main.Columns[4].Caption := cls_globals.translate( 'From');
    frm_main.lv_main.Columns[5].Caption := cls_globals.translate( 'Subject');

    // Set Buttons
    frm_main.btn_getList.Caption                := cls_globals.translate( 'GetList' );
    frm_main.btn_deletemails.Caption            := cls_globals.translate( 'DeleteSelected' );
    frm_main.btn_markall.Caption                := cls_globals.translate( 'markall' );
    frm_main.btn_language.Caption               := cls_globals.translate( 'Language' );

    // Menue Bar
    dm_main.Programm1.Caption           := cls_globals.translate( 'Program' );
    dm_main.GetList1.Caption            := cls_globals.translate( 'GetList' );
    dm_main.Info1.Caption               := cls_globals.translate( 'Info' );
    dm_main.Settings1.Caption           := cls_globals.translate( 'Settings' );
    dm_main.Language1.Caption            := cls_globals.translate( 'Language' );
    dm_main.Accounts1.Caption           := cls_globals.translate( 'Accounts' );

    // Tool Tips
    frm_main.btn_getlist.Hint           := cls_globals.translate( 'hint_list' );
    frm_main.btn_deletemails.Hint       := cls_globals.translate( 'hint_delete' );
    frm_main.btn_language.Hint          := cls_globals.translate( 'hint_language' );
    frm_main.btn_accounts.Hint          := cls_globals.translate( 'hint_accounts' );
    frm_main.btn_firewall.Hint          := cls_globals.translate( 'hint_firewall' );
    frm_main.btn_markall.Hint           := cls_globals.translate( 'hint_markall' );

    dm_main.GetList1.Hint               := frm_main.btn_getlist.Hint;
    dm_main.Exit1.Hint                  := cls_globals.translate( 'hint_exit' );
    dm_main.General1.Hint               := frm_main.btn_firewall.Hint;
    dm_main.Accounts1.Hint              := frm_main.btn_accounts.Hint;
    dm_main.Language1.Hint               := frm_main.btn_language.Hint;
    dm_main.Info1.Hint                  := cls_globals.translate( 'hint_about' );
    dm_main.QuickView1.Hint             := cls_globals.translate( 'hint_quickview' );
    dm_main.Delete1.Hint                := frm_main.btn_deletemails.Hint;
    dm_main.Liste1.Hint                 := frm_main.btn_getlist.Hint;
    dm_main.Verwaltung1.Hint            := cls_globals.translate( 'hint_options' );
end;


procedure TGlobals.readAccounts();
var
   iNumberAccounts,iActualAccount:Integer;
begin
     iNumberAccounts := m_AccountFile.ReadInteger('general','accounts',0);

     SetLength(m_lAccounts,iNumberAccounts);
     SetLength(m_lServer,iNumberAccounts);
     SetLength(m_lPort,iNumberAccounts);
     SetLength(m_lUserID,iNumberAccounts);
     SetLength(m_lPasswort,iNumberAccounts);
     SetLength(m_lpwc,iNumberAccounts);
     SetLength(m_lDelete,iNumberAccounts);

     for iActualAccount := 1 to iNumberAccounts do
     begin
          m_lAccounts[iActualAccount-1] := m_AccountFile.ReadString(IntToStr(iActualAccount),'Name','ERR');
          m_lServer[iActualAccount-1]   := m_AccountFile.ReadString(IntToStr(iActualAccount),'Server','ERR');
          m_lPort[iActualAccount-1]     := m_AccountFile.ReadInteger(IntToStr(iActualAccount),'Port',-1);

          if (m_lPort[iActualAccount-1] = -1) then
          begin
                m_AccountFile.WriteInteger(IntToStr(iActualAccount),'Port',110);
          end;

          m_lUserID[iActualAccount-1]   := m_AccountFile.ReadString(IntToStr(iActualAccount),'UserID','ERR');
          m_lPasswort[iActualAccount-1] := m_AccountFile.ReadString(IntToStr(iActualAccount),'Password','ERR');
          m_lpwc[iActualAccount-1]      := m_AccountFile.ReadInteger(IntToStr(iActualAccount),'pwc',0);
          m_lDelete[iActualAccount-1]   := 'false';
     end;
end;

procedure TGlobals.showAccounts();
var
   iNumberAccounts,iActualAccount:Integer;
begin
    iNumberAccounts := m_AccountFile.ReadInteger('general','accounts',0);
    frm_main.tv_main.Items.Clear;

    // Show all read accounts
    for iActualAccount := 1 to iNumberAccounts do
    begin
         if not (m_lAccounts[iActualAccount-1] = 'ERR') then
         begin
              frm_main.tv_main.Items.Add( nil, m_lAccounts[iActualAccount-1]);
              frm_main.tv_main.Items[iActualAccount-1].ImageIndex    := 14;
              frm_main.tv_main.Items[iActualAccount-1].SelectedIndex :=  8;
         end;
    end;
end;

procedure TGlobals.showMail();
var
   iAttachCount:Integer;
   li_current: TListItem;
begin
    // Make all invisible
    frm_mail.mmo_body.Visible    := false;
    frm_mail.mmo_body.Align      := alNone;

    Sleep(100);
    Application.ProcessMessages;

    // Set Edit Fields
    frm_mail.lbl_mail_from.Caption          := '';
    frm_mail.lbl_mail_to.Caption            := '';
    frm_mail.lbl_mail_cc.Caption            := '';
    frm_mail.lbl_mail_date.Caption          := '';
    frm_mail.lbl_mail_subject.Caption       := '';
    frm_mail.mmo_Body.Clear;
    Application.ProcessMessages;

    frm_mail.lbl_mail_from.Caption          := dm_main.mail_message.From.Name + '<'+dm_main.mail_message.From.Address+'>';
    frm_mail.lbl_mail_to.Caption            := dm_main.mail_message.Recipients.EMailAddresses;
    frm_mail.lbl_mail_cc.Caption            := dm_main.mail_message.CCList.EMailAddresses;
    frm_mail.lbl_mail_date.Caption          := FormatDateTime('ddd dd.mm.yyyy hh:mm', dm_main.mail_message.Date);
    frm_mail.lbl_mail_subject.Caption       := dm_main.mail_message.Subject;
    Application.ProcessMessages;

    // Add Attachments
    frm_mail.lv_attachment.Items.Clear;

    for iAttachCount := 0 to Pred(dm_main.mail_message.MessageParts.Count) do
    begin
        if (dm_main.mail_message.MessageParts.Items[iAttachCount] is TIdAttachment) then
        begin //general attachment

            // Show in List
            li_current := frm_mail.lv_attachment.Items.Add;
            li_current.SubItems.Add(TIdAttachment(dm_main.mail_message.MessageParts.Items[iAttachCount]).Filename);

            // Save Attachment to File
            try
                TIdAttachment(dm_main.mail_message.MessageParts.Items[iAttachCount]).SaveToFile(ExtractFilePath( Application.ExeName) + 'attach\' + TIdAttachment(dm_main.mail_message.MessageParts.Items[iAttachCount]).Filename);
            except
                    // file exists
            end;
            li_current.ImageIndex  := 0;
        end
        else begin //body text
            frm_mail.mmo_body.Visible    := true;
            frm_mail.mmo_body.Align      := alClient;
            frm_mail.mmo_Body.Lines.AddStrings(TIdText(dm_main.mail_message.MessageParts.Items[iAttachCount]).Body);
        end;
    end;

    if (frm_mail.lv_attachment.Items.Count = 0) then
    begin
        frm_mail.lv_attachment.Visible      := false;
        frm_mail.lbl_attachmentnote.Visible := false;
        frm_mail.lbl_attachlist.Visible     := false;
        frm_mail.Bevel2.Visible             := false;

        if not dm_main.mail_message.IsBodyEmpty then
        begin
            frm_mail.mmo_body.Visible    := true;
            frm_mail.mmo_body.Align      := alClient;
            frm_mail.mmo_Body.Lines.AddStrings(dm_main.mail_message.Body);
        end;
    end
    else begin
        frm_mail.lv_attachment.Visible      := true;
        frm_mail.lbl_attachlist.Visible     := true;
        frm_mail.lbl_attachmentnote.Visible := true;
        frm_mail.Bevel2.Visible             := true;
    end;

    Application.ProcessMessages;

    // Show Mail-Form
    frm_mail.showModal;
    Application.ProcessMessages;
end;

function TGlobals.writeFirewall2file( bUseFirewall:boolean;
                                      sAdress:string;
                                      iPort:integer;
                                      sTyp:string;
                                      bAuthNeed:boolean;
                                      sUsername:string;
                                      sPassword:string):integer;
begin
     m_ConfigFile.WriteBool       ('firewall','usefirewall',bUseFirewall);
     m_ConfigFile.WriteString     ('firewall','firewalladress',sAdress);
     m_ConfigFile.WriteInteger    ('firewall','firewallport',iPort);
     m_ConfigFile.WriteString     ('firewall','firewalltype',sTyp);
     m_ConfigFile.WriteBool       ('firewall','authneed',bAuthNeed);
     m_ConfigFile.WriteString     ('firewall','fusername',sUsername);
     m_ConfigFile.WriteString     ('firewall','fpassword',sPassword);
     result := 0;
end;

procedure TGlobals.setFirewall;
var
   svSocksVersion:TSocksVersion;
   sSocksVersion:string;
begin
     if (m_ConfigFile.ReadBool('firewall','usefirewall',false)) then
     begin
          svSocksVersion := TSocksVersion(Create);
          sSocksVersion := m_ConfigFile.ReadString('firewall','firewalltype','svNoSocks');

          if            (sSocksVersion = 'svNoSocks') then svSocksVersion := svNoSocks
          else if       (sSocksVersion = 'svSocks4')  then svSocksVersion := svSocks4
          else if       (sSocksVersion = 'svSocks4A') then svSocksVersion := svSocks4A
          else if       (sSocksVersion = 'svSocks5')  then svSocksVersion := svSocks5;

          dm_main.IdSocksInfo1.Version             := svSocksVersion;
          dm_main.IdSocksInfo1.Host                := m_ConfigFile.ReadString('firewall','firewalladress','');
          dm_main.IdSocksInfo1.Port                := m_ConfigFile.ReadInteger('firewall','firewallport',0);

          if (m_ConfigFile.ReadBool('firewall','needauth',false)) then
             dm_main.IdSocksInfo1.Authentication   := saUsernamePassword
          else
             dm_main.IdSocksInfo1.Authentication   := saNoAuthentication;

          dm_main.IdSocksInfo1.Username              := m_ConfigFile.ReadString('firewall','fusername','');
          dm_main.IdSocksInfo1.Password            := m_ConfigFile.ReadString('firewall','fpassword','');
     end
     else begin
          dm_main.IdSocksInfo1.Version             := svNoSocks;
          dm_main.IdSocksInfo1.Authentication      := saNoAuthentication;
          dm_main.IdSocksInfo1.Host                := '';
          dm_main.IdSocksInfo1.Password            := '';
          dm_main.IdSocksInfo1.Port                := 0;
          dm_main.IdSocksInfo1.Username              := '';
     end;
end;

function TGlobals.cryptText(Sender:TObject;sText:string):string;
var
   iTextLength,iZaehler,iACIIPosition : integer;
   sCryptedText: string;
   cBuchstabe:char;
begin
     iTextLength     := Length(sText);
     iZaehler        := 0;

     while (iZaehler < iTextLength) do
     begin
          iZaehler      := iZaehler + 1;
          cBuchstabe    := sText[iZaehler];
          iACIIPosition := Ord(cBuchstabe);
          iACIIPosition := iACIIPosition + 132;
          cBuchstabe    := chr(iACIIPosition);
          sCryptedText  := sCryptedText + cBuchstabe;
     end;
     Result := sCryptedText;
end;

function TGlobals.decryptText(Sender:TObject;sText:string):string;
var
   iTextLength,iZaehler,iACIIPosition : integer;
   sCryptedText: string;
   cBuchstabe:char;
begin
     iTextLength     := Length(sText);
     iZaehler        := 0;

     while (iZaehler < iTextLength) do
     begin
          iZaehler      := iZaehler + 1;
          cBuchstabe    := sText[iZaehler];
          iACIIPosition := Ord(cBuchstabe);
          iACIIPosition := iACIIPosition - 132;
          cBuchstabe    := chr(iACIIPosition);
          sCryptedText  := sCryptedText + cBuchstabe;
     end;
     Result := sCryptedText;
end;

function TGlobals.saveWindowPosition(Sender:TObject;WindowSize:TWindowState;top:integer;left:integer;height:integer;width:integer):integer;
begin
    // Save Window State of Window in Main Config File
    m_ConfigFile.WriteInteger('windows','state',integer(WindowSize));
    m_ConfigFile.WriteInteger('windows','top',top);
    m_ConfigFile.WriteInteger('windows','left',left);
    m_ConfigFile.WriteInteger('windows','height',height);
    m_ConfigFile.WriteInteger('windows','width',width);

    // Return
    Result := 0;
end;

function TGlobals.loadWindowPosition(Sender:TObject):integer;
var
    iState: integer;
begin
    // Load the Window Size
    iState := m_ConfigFile.ReadInteger('windows','state',integer(wsNormal));
    case iState of
        0:  begin
                frm_main.WindowState := wsNormal;
            end;
        1:  begin
                frm_main.WindowState := wsMinimized;
            end;
        2:  begin
                frm_main.WindowState := wsMaximized;
            end;
    end;

    frm_main.Top    := m_ConfigFile.ReadInteger('windows','top',20);
    frm_main.Left   := m_ConfigFile.ReadInteger('windows','left',20);
    frm_main.Height := m_ConfigFile.ReadInteger('windows','height',540);
    frm_main.Width  := m_ConfigFile.ReadInteger('windows','width',960);
    Application.ProcessMessages;

    // Return
    Result := 0;
end;

// Funktion LabelLink
// Aufruf durch: iResult := labellink(self,sURLhierhin);
// URL kann eine http:// , mailto: oder file:// URL sein!
// Made by Sascha Presnac
function TGlobals.labellink(Sender: TObject; sLinkToNavigateTo: string): integer;
var
    iResultValue: integer;
begin
    // Ausfuehren der URL im dafuer eingetragenen Standartprogramm
    // Browser, eMailer usw.
    iResultValue    := ShellExecute(    Application.Handle,
                                        'open',
                                        PChar(sLinkToNavigateTo),
                                        nil,
                                        nil,
                                        SW_ShowNormal);

    // Rueckgabewert von ShellExecute an den Aufrufer zurueckgeben
    Result          := iResultValue;
end;

end.
