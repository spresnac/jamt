unit unt_options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, StdCtrls,inifiles, Mask, ImgList, jpeg;

type
  Tfrm_options = class(TForm)
    PageControl1: TPageControl;
    tab_language: TTabSheet;
    pnl_buttons: TPanel;
    btn_close: TSpeedButton;
    lbl_select: TLabel;
    cmb_language: TComboBox;
    tab_accounts: TTabSheet;
    lbl_Name: TLabel;
    lbl_Server: TLabel;
    lbl_UserID: TLabel;
    lbl_Password: TLabel;
    edt_name: TEdit;
    edt_server: TEdit;
    edt_userid: TEdit;
    edt_password: TEdit;
    btn_newaccount: TSpeedButton;
    btn_apply: TSpeedButton;
    lv_accounts: TListView;
    btn_deleteaccount: TSpeedButton;
    btn_editaccount: TSpeedButton;
    tab_firewall: TTabSheet;
    cb_firewall: TCheckBox;
    lbl_firewalladress: TLabel;
    edt_firewall: TEdit;
    lbl_sockstype: TLabel;
    cmb_firewalltype: TComboBox;
    edt_firewallport: TMaskEdit;
    lbl_firewallport: TLabel;
    cb_authentication: TCheckBox;
    lbl_fusername: TLabel;
    lbl_fpassword: TLabel;
    edt_fusername: TEdit;
    edt_fpassword: TEdit;
    btn_cancel: TSpeedButton;
    lbl_serverport: TLabel;
    edt_port: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_accountsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btn_newaccountClick(Sender: TObject);
    procedure btn_applyClick(Sender: TObject);
    procedure btn_deleteaccountClick(Sender: TObject);
    procedure btn_editaccountClick(Sender: TObject);
    procedure cb_firewallClick(Sender: TObject);
    procedure cb_authenticationClick(Sender: TObject);
    procedure img_languageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tab_accountsShow(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_options: Tfrm_options;

implementation

uses unt_globals, unt_dmmain;

{$R *.DFM}

procedure Tfrm_options.btn_closeClick(Sender: TObject);
var
   sSOCKSTyp:string;
begin
    if not (Trim(frm_options.cmb_language.Text) = '') then
    begin
        if (frm_options.cmb_language.Text <> cls_globals.m_ConfigFile.ReadString('language','lang','english.lng')) then
        begin

            // Save Language Settings
            cls_globals.m_ConfigFile.WriteString('language','lang',frm_options.cmb_language.Text);

            // Set new Language File
            cls_globals.m_LangFile.Destroy;
            cls_globals.m_LangFile   := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lang\' + (cls_globals.m_ConfigFile.ReadString('language','lang','english.lng')));

            // Translate to new language
            cls_globals.changeLanguage;
        end;
    end;

    // Set FireWall Settings
    if            (cmb_firewalltype.Text = 'NoSOCKS') or (cmb_firewalltype.Text = '')  then sSOCKSTyp := 'svNoSocks'
    else if       (cmb_firewalltype.Text = 'SOCKS 4')  then sSOCKSTyp := 'svSocks4'
    else if       (cmb_firewalltype.Text = 'SOCKS 4a') then sSOCKSTyp := 'svSocks4A'
    else if       (cmb_firewalltype.Text = 'SOCKS 5')  then sSOCKSTyp := 'svSocks5';

    if (edt_firewallport.Text = '') then edt_firewallport.text := '0';

    cls_globals.writeFirewall2file( cb_firewall.Checked,
                                    edt_firewall.Text,
                                    StrToInt(edt_firewallport.Text),
                                    sSOCKSTyp,
                                    cb_authentication.Checked,
                                    edt_fusername.Text,
                                    edt_fpassword.Text);

     // Close the Options Dialog
     frm_options.Close;
     Application.ProcessMessages;
end;

procedure Tfrm_options.FormShow(Sender: TObject);
var
   srcRec:TSearchRec;
   iZaehler:Integer;
begin
    // Translate whole Form
    frm_options.Caption                      := cls_globals.translate('Options');
    frm_options.tab_language.Caption         := cls_globals.translate('Language');
    frm_options.tab_accounts.Caption         := cls_globals.translate('Accounts');
    frm_options.btn_close.Caption            := cls_globals.translate('Ok');
    frm_options.lbl_select.Caption           := cls_globals.translate('SelectLang');

    // Set Labels
    frm_options.lbl_Server.Caption           := cls_globals.translate( 'POP3-Server' );
    frm_options.lbl_serverport.Caption       := cls_globals.translate( 'Port' );
    frm_options.lbl_UserID.Caption           := cls_globals.translate( 'UserID' );
    frm_options.lbl_Password.Caption         := cls_globals.translate( 'Password' );
    cb_firewall.Caption                      := cls_globals.translate( 'UseFirewall' );
    lbl_firewalladress.caption               := cls_globals.translate( 'FirewallAdress' );
    lbl_sockstype.caption                    := cls_globals.translate( 'SOCKSType' );
    lbl_firewallport.caption                 := cls_globals.translate( 'FirewallPort' );
    cb_authentication.Caption                := cls_globals.translate( 'AuthentNeed' );
    lbl_fusername.Caption                    := cls_globals.translate( 'UserID' );
    lbl_fpassword.Caption                    := cls_globals.translate( 'Password' );

    // Set Buttons
    frm_options.btn_newaccount.Caption       := cls_globals.translate( 'NewAccount' );
    frm_options.btn_apply.Caption            := cls_globals.translate( 'Apply' );
    frm_options.btn_cancel.Caption           := cls_globals.translate( 'Cancel' );
    frm_options.btn_deleteaccount.Caption    := cls_globals.translate( 'DelAccount' );
    frm_options.btn_editaccount.Caption      := cls_globals.translate( 'EditAccount' );

    // Insert Items into Combo-Box
    FindFirst(ExtractFilePath(Application.ExeName)+'lang/*.lng',faAnyFile,srcRec);
    frm_options.cmb_language.Items.Clear;
    frm_options.cmb_language.Items.Append(srcRec.Name);

    while (FindNext(srcRec) = 0) do
        frm_options.cmb_language.Items.Append(srcRec.Name);

    FindClose(srcRec);

    // Set Combo to actual Language
    cmb_language.ItemIndex := cmb_language.Items.IndexOf(cls_globals.m_ConfigFile.ReadString('language','lang','NONE'));

    // Set Accounts ListView
    frm_options.lv_accounts.Items.Clear;
    for iZaehler := 1 to Length(cls_globals.m_lAccounts) do
    begin
         frm_options.lv_accounts.Items.Add;
         frm_options.lv_accounts.Items[iZaehler-1].Caption := cls_globals.m_lAccounts[iZaehler-1];
    end;

    // Set Firewall Tab
    if (cls_globals.m_ConfigFile.ReadBool('firewall','usefirewall',false)) then
        cb_firewall.checked := true
    else
        cb_firewall.checked := false;

    edt_firewall.Text        := cls_globals.m_ConfigFile.ReadString     ('firewall','firewalladress','');
    edt_firewallport.Text    := IntToStr(cls_globals.m_ConfigFile.ReadInteger    ('firewall','firewallport',0));

    if            (cls_globals.m_ConfigFile.ReadString('firewall','firewalltype','svNoSocks') = 'svNoSocks') then cmb_firewalltype.ItemIndex := cmb_firewalltype.Items.IndexOf('NoSOCKS')
    else if       (cls_globals.m_ConfigFile.ReadString('firewall','firewalltype','svNoSocks') = 'svSocks4') then cmb_firewalltype.ItemIndex := cmb_firewalltype.Items.IndexOf('SOCKS 4')
    else if       (cls_globals.m_ConfigFile.ReadString('firewall','firewalltype','svNoSocks') = 'svSocks4A') then cmb_firewalltype.ItemIndex := cmb_firewalltype.Items.IndexOf('SOCKS 4a')
    else if       (cls_globals.m_ConfigFile.ReadString('firewall','firewalltype','svNoSocks') = 'svSocks5') then cmb_firewalltype.ItemIndex := cmb_firewalltype.Items.IndexOf('SOCKS 5');


    if (cls_globals.m_ConfigFile.ReadBool('firewall','authneed',false)) then
        cb_authentication.checked := true;

    edt_fusername.Text := cls_globals.m_ConfigFile.ReadString     ('firewall','fusername','');
    edt_fpassword.Text := cls_globals.m_ConfigFile.ReadString     ('firewall','fpassword','');
end;

procedure Tfrm_options.lv_accountsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
    // Set edit Field

    if frm_options.lv_accounts.SelCount > 0 then
    begin
        frm_options.edt_name.Text     := cls_globals.m_lAccounts[frm_options.lv_accounts.Selected.Index];
        frm_options.edt_server.Text   := cls_globals.m_lServer[frm_options.lv_accounts.Selected.Index];
        frm_options.edt_userid.Text   := cls_globals.m_lUserID[frm_options.lv_accounts.Selected.Index];
        if cls_globals.m_lpwc[frm_options.lv_accounts.Selected.Index] = 0 then
            frm_options.edt_password.Text := cls_globals.m_lPasswort[frm_options.lv_accounts.Selected.Index]
        else
            frm_options.edt_password.Text := cls_globals.decryptText(self,cls_globals.m_lPasswort[frm_options.lv_accounts.Selected.Index]);
        frm_options.edt_port.Text     := IntToStr(cls_globals.m_lPort[frm_options.lv_accounts.Selected.Index]);

        btn_editaccount.Enabled       := true;
        btn_deleteaccount.enabled     := true;
    end
    else begin
        frm_options.edt_name.Text     := '';
        frm_options.edt_server.Text   := '';
        frm_options.edt_userid.Text   := '';
        frm_options.edt_password.Text := '';
        frm_options.edt_port.Text     := '';

        btn_editaccount.Enabled       := false;
        btn_deleteaccount.enabled     := false;
     end;
end;

procedure Tfrm_options.btn_newaccountClick(Sender: TObject);
begin
//    // Check for Account Limit
//    if Length(cls_globals.m_lAccounts) > 98 then
//    begin
//        MessageDlg(cls_globals.translate('MaxAccountWarning'), mtError, [mbCancel], 0);
//        exit;
//    end;

    // Empty Fiels
    edt_name.Text         := '';
    edt_server.Text       := '';
    edt_port.Text         := '110';
    edt_userid.Text       := '';
    edt_password.Text     := '';

    // Enable Edit Fields
    edt_name.Enabled      := true;
    edt_server.Enabled    := true;
    edt_port.Enabled      := true;
    edt_userid.Enabled    := true;
    edt_password.Enabled  := true;

    // Show Buttons
    btn_newaccount.Visible    := false;
    btn_apply.Visible         := true;
    btn_cancel.Visible        := true;
    btn_close.Visible         := false;
    btn_deleteaccount.Visible := false;
    btn_editaccount.Visible   := false;

    // Focus
    frm_options.edt_name.SetFocus;
end;

procedure Tfrm_options.btn_applyClick(Sender: TObject);
var
   iCurrMaxAccount:Integer;
begin
    // Check entrys
    if trim(frm_options.edt_name.Text) = '' then
    begin
         MessageDlg(cls_globals.translate('EnterAccountName'), mtWarning, [mbOK], 0);
         frm_options.edt_name.SetFocus;
         exit;
    end;

    if trim(frm_options.edt_server.Text) = '' then
    begin
         MessageDlg(cls_globals.translate('EnterAccountServer'), mtWarning, [mbOK], 0);
         frm_options.edt_server.SetFocus;
         exit;
    end;

    if trim(frm_options.edt_port.Text) = '' then
    begin
         MessageDlg(cls_globals.translate('EnterAccountPort'), mtWarning, [mbOK], 0);
         frm_options.edt_port.SetFocus;
         exit;
    end;

    if trim(frm_options.edt_userid.Text) = '' then
    begin
         MessageDlg(cls_globals.translate('EnterAccountUserid'), mtWarning, [mbOK], 0);
         frm_options.edt_userid.SetFocus;
         exit;
    end;

    if trim(frm_options.edt_password.Text) = '' then
    begin
         MessageDlg(cls_globals.translate('EnterAccountPw'), mtWarning, [mbOK], 0);
         frm_options.edt_password.SetFocus;
         exit;
    end;

    if (btn_apply.Tag = 0) then
    begin
        // Apply new account
        iCurrMaxAccount := cls_globals.m_AccountFile.ReadInteger('general','accounts',0);

        // Write Account Details
         cls_globals.m_AccountFile.WriteString( IntToStr(iCurrMaxAccount+1),'Name',trim(frm_options.edt_name.Text) );
         cls_globals.m_AccountFile.WriteString( IntToStr(iCurrMaxAccount+1),'Server',trim(frm_options.edt_server.Text) );
         cls_globals.m_AccountFile.WriteInteger(  IntToStr(iCurrMaxAccount+1),'Port',StrToInt(edt_port.Text));
         cls_globals.m_AccountFile.WriteString( IntToStr(iCurrMaxAccount+1),'UserID',trim(frm_options.edt_userid.Text) );
         cls_globals.m_AccountFile.WriteString( IntToStr(iCurrMaxAccount+1),'Password',cls_globals.cryptText(self,trim(frm_options.edt_password.Text)) );
         cls_globals.m_AccountFile.WriteInteger( IntToStr(iCurrMaxAccount+1),'pwc',1 );

        // Write new Account Size
         cls_globals.m_AccountFile.WriteString( 'general' ,'accounts', IntToStr(iCurrMaxAccount+1) );
    end
    else if btn_apply.Tag = 1 then
    begin
        // Edit a current account
        cls_globals.m_AccountFile.WriteString( IntToStr(lv_accounts.Selected.Index+1),'Name',trim(frm_options.edt_name.Text) );
        cls_globals.m_AccountFile.WriteString( IntToStr(lv_accounts.Selected.Index+1),'Server',trim(frm_options.edt_server.Text) );
        cls_globals.m_AccountFile.WriteInteger( IntToStr(lv_accounts.Selected.Index+1),'Port',StrToInt(edt_port.Text));
        cls_globals.m_AccountFile.WriteString( IntToStr(lv_accounts.Selected.Index+1),'UserID',trim(frm_options.edt_userid.Text) );
        cls_globals.m_AccountFile.WriteString( IntToStr(lv_accounts.Selected.Index+1),'Password',cls_globals.cryptText(self,trim(frm_options.edt_password.Text)) );
        cls_globals.m_AccountFile.WriteInteger( IntToStr(lv_accounts.Selected.Index+1),'pwc',1 );

        // Reset Flag
        btn_apply.Tag := 0;
     end;

    // Enable Edit Fields
    edt_name.Enabled      := false;
    edt_server.Enabled    := false;
    edt_port.Enabled      := false;
    edt_userid.Enabled    := false;
    edt_password.Enabled  := false;


    // Show Buttons
    btn_newaccount.Visible    := true;
    btn_apply.Visible         := false;
    btn_cancel.Visible        := false;
    btn_close.Visible         := true;
    btn_deleteaccount.Visible := true;
    btn_editaccount.Visible   := true;

    // Hide Form Options
    frm_options.btn_closeClick(self);

    // Show Accounts
    cls_globals.readAccounts;
    cls_globals.showAccounts;
end;

procedure Tfrm_options.btn_deleteaccountClick(Sender: TObject);
var
   iCurrMaxAccount,iCurrAccount,iTempPWC,iTempPort: Integer;
   sTempName,sTempServer,sTempUserid,sTempPassword:String;
begin
    // Delete the selcted account

    if frm_options.lv_accounts.SelCount > 0 then
    begin
        // Read actual Accounts
        iCurrMaxAccount := cls_globals.m_AccountFile.ReadInteger('general','accounts',0);

        // Delete the selected one
        cls_globals.m_AccountFile.EraseSection(IntToStr(frm_options.lv_accounts.Selected.Index+1));

        // Check for later Accounts and rename them
        if (iCurrMaxAccount > frm_options.lv_accounts.Selected.Index+1) then
        begin
            for iCurrAccount := frm_options.lv_accounts.Selected.Index+2 to iCurrMaxAccount do
            begin
                sTempName     := cls_globals.m_AccountFile.ReadString(IntToStr(iCurrAccount),'Name','ERR');
                sTempServer   := cls_globals.m_AccountFile.ReadString(IntToStr(iCurrAccount),'Server','ERR');
                sTempUserid   := cls_globals.m_AccountFile.ReadString(IntToStr(iCurrAccount),'Userid','ERR');
                sTempPassword := cls_globals.m_AccountFile.ReadString(IntToStr(iCurrAccount),'Password','ERR');
                iTempPort     := cls_globals.m_AccountFile.ReadInteger(IntToStr(iCurrAccount),'Port',0);
                iTempPWC      := cls_globals.m_AccountFile.ReadInteger(IntToStr(iCurrAccount),'pwc',0);

                cls_globals.m_AccountFile.EraseSection(IntToStr(iCurrAccount));

                cls_globals.m_AccountFile.WriteString(IntToStr(iCurrAccount-1),'Name',sTempName);
                cls_globals.m_AccountFile.WriteString(IntToStr(iCurrAccount-1),'Server',sTempServer);
                cls_globals.m_AccountFile.WriteString(IntToStr(iCurrAccount-1),'Userid',sTempUserid);
                cls_globals.m_AccountFile.WriteString(IntToStr(iCurrAccount-1),'Password',sTempPassword);
                cls_globals.m_AccountFile.WriteInteger(IntToStr(iCurrAccount-1),'Port',iTempPort);
                cls_globals.m_AccountFile.WriteInteger(IntToStr(iCurrAccount-1),'pwc',iTempPWC);
            end;
        end;

        // Set Accounts
        cls_globals.m_AccountFile.WriteString('general','accounts',IntToStr(iCurrMaxAccount-1));

    end;

    // Hide Form Options
    frm_options.btn_closeClick(self);
    Application.ProcessMessages;

    // Show Accounts
    cls_globals.readAccounts;
    cls_globals.showAccounts;
    Application.ProcessMessages;
end;

procedure Tfrm_options.btn_editaccountClick(Sender: TObject);
begin
    // Edit the current Account
    if ( lv_accounts.SelCount < 1 ) then
        exit;

    // Set Buttons
    btn_newaccount.Visible    := false;
    btn_editaccount.Visible   := false;
    btn_deleteaccount.Visible := false;
    btn_close.Visible         := false;
    btn_apply.Visible         := true;
    btn_cancel.Visible        := true;

    // Set Edit Fields
    edt_name.Enabled          := true;
    edt_server.Enabled        := true;
    edt_port.Enabled          := true;
    edt_userid.Enabled        := true;
    edt_password.Enabled      := true;

    // Set Flag
    btn_apply.Tag             := 1;

    // Focus first Field
    frm_options.edt_name.SetFocus;
end;

procedure Tfrm_options.cb_firewallClick(Sender: TObject);
begin
     if (cb_firewall.Checked) then
     begin

          lbl_firewalladress.Enabled  := true;
          lbl_sockstype.Enabled       := true;
          lbl_firewallport.Enabled    := true;
          edt_firewallport.Enabled    := true;
          edt_firewall.Enabled        := true;
          cmb_firewalltype.Enabled    := true;

          cb_authentication.Enabled   := true;

          if (cb_authentication.Checked) then
          begin

               lbl_fusername.Enabled       := true;
               lbl_fpassword.Enabled       := true;
               edt_fusername.Enabled       := true;
               edt_fpassword.Enabled       := true;

          end;

     end
     else begin

          lbl_firewalladress.Enabled  := false;
          lbl_sockstype.Enabled       := false;
          lbl_firewallport.Enabled    := false;
          edt_firewallport.Enabled    := false;
          edt_firewall.Enabled        := false;
          cmb_firewalltype.Enabled    := false;

          cb_authentication.Enabled   := false;
          lbl_fusername.Enabled       := false;
          lbl_fpassword.Enabled       := false;
          edt_fusername.Enabled       := false;
          edt_fpassword.Enabled       := false;

     end;
end;

procedure Tfrm_options.cb_authenticationClick(Sender: TObject);
begin

     if (cb_authentication.Checked) then
     begin

          lbl_fusername.Enabled       := true;
          lbl_fpassword.Enabled       := true;
          edt_fusername.Enabled       := true;
          edt_fpassword.Enabled       := true;

     end
     else begin

          lbl_fusername.Enabled       := false;
          lbl_fpassword.Enabled       := false;
          edt_fusername.Enabled       := false;
          edt_fpassword.Enabled       := false;

     end;

end;

procedure Tfrm_options.img_languageClick(Sender: TObject);
begin
     cmb_language.DroppedDown := true;
end;

procedure Tfrm_options.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    // Check, if something is open
    if edt_name.Enabled then
    begin
        // Enable Edit Fields
        edt_name.Enabled      := false;
        edt_server.Enabled    := false;
        edt_port.Enabled      := false;
        edt_userid.Enabled    := false;
        edt_password.Enabled  := false;

        // Show Buttons
        btn_newaccount.Visible    := true;
        btn_apply.Visible         := false;
        btn_cancel.Visible        := false;
        btn_close.Visible         := true;
        btn_deleteaccount.Visible := true;
        btn_editaccount.Visible   := true;
    end;
end;

procedure Tfrm_options.tab_accountsShow(Sender: TObject);
begin
    // Empty Fiels
    edt_name.Text         := '';
    edt_server.Text       := '';
    edt_port.Text         := '';
    edt_userid.Text       := '';
    edt_password.Text     := '';

    // Select nothing
    lv_accounts.Selected  := nil;
end;

procedure Tfrm_options.btn_cancelClick(Sender: TObject);
begin
    // Enable Edit Fields
    edt_name.Enabled      := false;
    edt_server.Enabled    := false;
    edt_port.Enabled      := false;
    edt_userid.Enabled    := false;
    edt_password.Enabled  := false;

    // Show Buttons
    btn_newaccount.Visible    := true;
    btn_apply.Visible         := false;
    btn_cancel.Visible        := false;
    btn_close.Visible         := true;
    btn_deleteaccount.Visible := true;
    btn_editaccount.Visible   := true;

    // Select no entry in list
    lv_accounts.Selected      := nil;

    // Empty Fiels
    edt_name.Text         := '';
    edt_server.Text       := '';
    edt_port.Text         := '';
    edt_userid.Text       := '';
    edt_password.Text     := '';

end;

procedure Tfrm_options.SpeedButton1Click(Sender: TObject);
var
    iOldPosition, iNewPosition, iZaehler: integer;
begin
    if (lv_accounts.SelCount > 0) and (lv_accounts.Selected.Index > 1) then
    begin
        iOldPosition    := lv_accounts.Selected.Index+1;
        iNewPosition    := iOldPosition-1;

        cls_globals.swapAccounts(iOldPosition,iNewPosition);

        // Show new Account List
        cls_globals.readAccounts;
        frm_options.lv_accounts.Items.Clear;
        for iZaehler := 1 to Length(cls_globals.m_lAccounts) do
        begin
             frm_options.lv_accounts.Items.Add;
             frm_options.lv_accounts.Items[iZaehler-1].Caption := cls_globals.m_lAccounts[iZaehler-1];
        end;

        // Show Accounts
        cls_globals.showAccounts;
        Application.ProcessMessages;
    end;
end;

procedure Tfrm_options.SpeedButton2Click(Sender: TObject);
var
    iOldPosition, iNewPosition, iZaehler: integer;
begin
    if (lv_accounts.SelCount > 0) and (lv_accounts.Selected.Index < lv_accounts.Items.Count-1) then
    begin
        iOldPosition    := lv_accounts.Selected.Index+1;
        iNewPosition    := iOldPosition+1;

        cls_globals.swapAccounts(iOldPosition,iNewPosition);

        // Show new Account List
        cls_globals.readAccounts;
        frm_options.lv_accounts.Items.Clear;
        for iZaehler := 1 to Length(cls_globals.m_lAccounts) do
        begin
             frm_options.lv_accounts.Items.Add;
             frm_options.lv_accounts.Items[iZaehler-1].Caption := cls_globals.m_lAccounts[iZaehler-1];
        end;

        // Show Accounts
        cls_globals.showAccounts;
        Application.ProcessMessages;
    end;

end;

end.
