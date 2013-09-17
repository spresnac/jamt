unit unt_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ShellApi, inifiles, ToolWin,WinInet, IdMessage;

type
  Tfrm_main = class(TForm)
    Splitter1: TSplitter;
    sb_main: TStatusBar;
    lv_main: TListView;
    tv_main: TTreeView;
    ControlBar1: TControlBar;
    tb_main: TToolBar;
    btn_firewall: TToolButton;
    btn_accounts: TToolButton;
    btn_language: TToolButton;
    btn_getlist: TToolButton;
    btn_deletemails: TToolButton;
    btn_markall: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_getlistClick(Sender: TObject);
    procedure btn_infoClick(Sender: TObject);
    procedure tv_mainClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_mainClick(Sender: TObject);
    procedure lv_mainDblClick(Sender: TObject);
    procedure tv_mainDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure showHelp(Sender:TObject);
    procedure btn_deletemailsClick(Sender: TObject);
    procedure btn_firewallClick(Sender: TObject);
    procedure btn_accountsClick(Sender: TObject);
    procedure btn_languageClick(Sender: TObject);
    procedure btn_markallClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_main: Tfrm_main;
  iColumnToSort: Integer;
  iNoRes:integer;

const

     AppName:    string = 'JaMT - Just another E-Mail Tool';
     AppVersion: string = '1.4.5';
     AppComment: string = 'Unicode Testversion';

implementation

uses unt_dmmain, unt_globals, unt_info, unt_mail, unt_transfer, IdPOP3,
  unt_filter;

{$R *.DFM}

procedure Tfrm_main.showHelp(Sender:TObject);
begin

    sb_main.Panels.Items[2].Text := GetLongHint(Application.Hint);

end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
    // On Startup of Form, show Appliaction Name and Version in Form Caption
    if (AppComment = '') then
         frm_main.Caption     := AppName + ' v' + AppVersion + ' - (c) 2009 by Sascha Presnac'
    else
         frm_main.Caption     := AppName + ' v' + AppVersion + ' - ' + AppComment + ' - (c) 2009 by Sascha Presnac';

    // Check for Test-Version
    if AppComment <> '' then
        if MessageBox(0, 'Dies ist eine Entwicklungsversion, die durchaus Fehler enthalten kann.'+#13+#10+'Ich (der Autor) distanziere mich von jedem Schaden an Ihrem Rechner!'+#13+#10'Wollen Sie JaMT trotzdem starten?',PChar(frm_main.Caption), MB_ICONINFORMATION or MB_YESNO) = IDNO then
            Application.Terminate;

    // Initiate Randomizer
    Randomize;

    // Create the Tools Class
    cls_globals := TGlobals.Create;

    // Prüfen auf Ordner
    if not (DirectoryExists(ExtractFilePath(Application.ExeName) + 'attach')) then
        CreateDir(ExtractFilePath(Application.ExeName) + 'attach');
    if not (DirectoryExists(ExtractFilePath(Application.ExeName) + 'conf')) then
        CreateDir(ExtractFilePath(Application.ExeName) + 'conf');
    if not (DirectoryExists(ExtractFilePath(Application.ExeName) + 'lang')) then
        CreateDir(ExtractFilePath(Application.ExeName) + 'lang');

    // Create a IniFile Stream and read the jamt.conf
    cls_globals.m_ConfigFile   := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'conf/jamt.conf');

    // Read Language Settings
    cls_globals.m_LangFile     := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lang\' + (cls_globals.m_ConfigFile.ReadString('language','lang','english.lng')));

    // Read Account Settings
    cls_globals.m_AccountFile  := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'conf/accounts.conf');

    // Read Filter Settings
    cls_globals.m_FilterFile  := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'conf/filter.conf');

    // Set Help to Statusbar
    Application.OnHint         := showHelp;

    // Setting Status Panel
    frm_main.sb_main.Panels[0].Text   := cls_globals.translate( 'Disconnected');

    // Read Accounts
    cls_globals.readAccounts;

    // Show the Accounts
    cls_globals.showAccounts;

end;

procedure Tfrm_main.btn_getlistClick(Sender: TObject);
var
   iZaehler: Integer;
   iMessages: integer;
   iMsgSize:integer;
   sAccountName: string;
   iMailBoxSize: integer;
   tmpdate,tmpfrom,tmpsubject,tmptext: string;
   checkcounter: integer;
begin
    checkcounter := 0;
    if (frm_main.tv_main.Selected.Index <> dm_main.pop3_indy.Tag) then
    begin

        if (dm_main.pop3_indy.Connected) then
            dm_main.pop3_indy.Disconnect;

        dm_main.pop3_indy.Host          := cls_globals.m_lServer[frm_main.tv_main.Selected.Index];
        dm_main.pop3_indy.Username        := cls_globals.m_lUserID[frm_main.tv_main.Selected.Index];

        if not (cls_globals.m_lPort[frm_main.tv_main.Selected.Index] <= 0) then
            dm_main.pop3_indy.Port      := cls_globals.m_lPort[frm_main.tv_main.Selected.Index]
        else
            dm_main.pop3_indy.Port      := 110;

        if (cls_globals.m_lpwc[frm_main.tv_main.Selected.Index] = 0) then
            dm_main.pop3_indy.Password      := cls_globals.m_lPasswort[frm_main.tv_main.Selected.Index]
        else
            dm_main.pop3_indy.Password      := cls_globals.decryptText(self,cls_globals.m_lPasswort[frm_main.tv_main.Selected.Index]);

        sAccountName                    := cls_globals.m_lAccounts[frm_main.tv_main.Selected.Index];
        frm_main.tv_main.Selected.Text  := sAccountName;

    end;

     // Set the Buttons
    frm_main.btn_getList.Enabled      := false;
    frm_main.btn_deletemails.Enabled  := false;
    frm_main.btn_markall.Enabled      := false;
    dm_main.GetList1.Enabled          := false;

     // Disable the TreeView
    frm_main.tv_main.Enabled := false;
    frm_main.lv_main.Enabled := false;

     // Check either connection is nessesary or not
    if not (dm_main.pop3_indy.Connected) then
    begin
        // Setting Transfer Window
        frm_transfer.show;
        Application.ProcessMessages;
        frm_transfer.pgb_overall.Position   := 0;
        frm_transfer.lbl_overall.Caption    := cls_globals.translate( 'WaitForConnect');
        Application.ProcessMessages;

        // Connect to Mail-Server and store Account-Number
        try
            dm_main.pop3_indy.Connect;
            dm_main.pop3_indy.Tag        := frm_main.tv_main.Selected.Index;
        except
            frm_main.sb_main.Panels[0].Text   := cls_globals.translate( 'error');
            frm_transfer.hide;
            MessageDlg( cls_globals.translate('authfailed1')+#13+#10+
                        cls_globals.translate('authfailed2')+#13+#10+
                        cls_globals.translate('authfailed3')+#13+#10
                        , mtError, [mbOK], 0);

            // Reenable controls (Bugfix 1.4.3)
            frm_main.btn_getList.Enabled      := true;
            frm_main.btn_deletemails.Enabled  := false;
            frm_main.btn_markall.Enabled      := false;
            dm_main.GetList1.Enabled          := true;
            frm_main.tv_main.Enabled          := true;
            frm_main.lv_main.Enabled          := false;

            // And out...
            exit;

        end;
    end;

     // Delete old List
    frm_main.lv_main.Items.Clear;

     // Get the Mail List
    dm_main.m_iCurrentMsg   := 0;
    iMessages               := dm_main.pop3_indy.CheckMessages;
    iMailBoxSize            := dm_main.pop3_indy.RetrieveMailBoxSize;
    cls_globals.m_NumberMsg := iMessages;

    if ( iMessages > 0) then
    begin

        // Get Summary
        sb_main.Panels.Items[1].Text := IntToStr(iMessages) + ' ' + cls_globals.translate('MoS2') + ' ('+FloatToStrF(iMailBoxSize/1024,ffFixed,18,2)+' kB)';

         // Get the List
        frm_transfer.pgb_overall.Tag     := iMessages;

         // Show Panel
        if not (frm_transfer.Showing) then
        begin

            frm_transfer.show;
            Application.ProcessMessages;
            frm_transfer.pgb_overall.Position := 0;

        end;

        frm_transfer.lbl_overall.Caption  := cls_globals.translate('conngetlist');
        Application.ProcessMessages;

        for iZaehler := 1 to iMessages do
        begin
            // Remember current MsgID
            dm_main.m_iCurrentMsg := iZaehler;

            // Get eMail Summary
            cls_globals.m_HeaderOnly := true;

            try
              iMsgSize    := dm_main.pop3_indy.RetrieveMsgSize(iZaehler);
            except
              iMsgSize    := 0;
            end;

            dm_main.mail_message.Clear;
            dm_main.pop3_indy.RetrieveHeader(iZaehler,dm_main.mail_message);

            cls_globals.m_HeaderOnly := False;

            frm_main.lv_main.Items.Insert(0);
            frm_main.lv_main.Items[0].ImageIndex := 9;

            if (dm_main.mail_message.Priority = mpNormal ) then
                frm_main.lv_main.Items[0].SubItems.Add('')

            else if (dm_main.mail_message.Priority = mpHigh ) or (dm_main.mail_message.Priority = mpHighest) then
                frm_main.lv_main.Items[0].SubItems.Add('!')

            else
                frm_main.lv_main.Items[0].SubItems.Add('V');

            frm_main.lv_main.Items[0].SubItems.Add(FormatDateTime('ddd dd.mm.yyyy hh:mm', dm_main.mail_message.Date));
            frm_main.lv_main.Items[0].SubItems.Add(FloatToStrF( (iMsgSize/1024) ,ffFixed,18,2)+'kB');

            tmptext := dm_main.mail_message.From.Text;
//            if StrLower(PChar(dm_main.mail_message.CharSet))='utf-8' then
//            begin
//                tmptext := cls_globals.decodeString(tmptext);
//            end;
            frm_main.lv_main.Items[0].SubItems.Add(tmptext);

            tmptext := dm_main.mail_message.Subject;
            if StrLower(PChar(dm_main.mail_message.CharSet))='utf-8' then
            begin
                tmptext := cls_globals.decodeString(tmptext);
            end;
            frm_main.lv_main.Items[0].SubItems.Add(tmptext);

             // Show Panel
             Application.ProcessMessages;
             frm_transfer.pgb_overall.Position := StrToInt(FloatToStrF((100 / iMessages)*iZaehler,ffFixed,18,0));
             Application.ProcessMessages;
             frm_transfer.lbl_overall.Caption  := IntToStr(iZaehler) + ' / ' + IntToStr(iMessages);
             Application.ProcessMessages;

             // Prüfen, ob Mail SPAM ist
             // -> prüft die Wortlisten ab
             // Temorärvariablen waren nötig, da seltsamerweise bei einem selektierten Eintrag
             // alle Zeichen nur noch 'lower' waren.
             tmpdate    := FormatDateTime('ddd dd.mm.yyyy hh:mm', dm_main.mail_message.Date);
             tmpfrom    := dm_main.mail_message.From.Text;
             tmpsubject := dm_main.mail_message.Subject;

             // Blacklist
             if (frmFilter.isOnList(0,cls_globals.m_iLastSelectedAccount,tmpdate,tmpfrom,tmpsubject)) then
             begin
                frm_main.lv_main.Items[0].Checked := true;
                Inc(checkcounter);
             end;

             // Whitelist
             if (frmFilter.isOnList(1,cls_globals.m_iLastSelectedAccount,tmpdate,tmpfrom,tmpsubject)) then
             begin
                frm_main.lv_main.Items[0].Checked := false;
                Dec(checkcounter);
             end;

             // Empty Message Part
             dm_main.mail_message.Clear;

         end;

         frm_main.btn_deletemails.Enabled := true;
         frm_main.btn_markall.Enabled     := true;
         if (checkcounter > 0) then
            frm_main.btn_deletemails.Enabled := true
         else
            frm_main.btn_deletemails.Enabled := false;

     end
     else begin

          btn_deletemails.Enabled           := false;
          frm_main.btn_markall.Enabled      := false;

          lv_main.Items.Insert(0);
          lv_main.Items[0].SubItems.Add('');
          lv_main.Items[0].SubItems.Add('');
          lv_main.Items[0].SubItems.Add('');
          lv_main.Items[0].SubItems.Add( cls_globals.translate('nonew') );

     end;

     Application.ProcessMessages;

     // Set the Buttons
    frm_main.btn_getList.Enabled     := true;
    dm_main.GetList1.Enabled         := true;

     // Clear the Panels
    Application.ProcessMessages;
    frm_transfer.Hide;
    Application.ProcessMessages;

     // Set Window
    if ( iMessages > 0) then
         lv_main.Enabled := true
    else
         lv_main.Enabled := false;

    tv_main.Enabled := true;
end;

procedure Tfrm_main.btn_infoClick(Sender: TObject);
begin
     // Show the Info-Dialog
     // Do same as on Menu-Click
     dm_main.Info1Click(self);
end;

procedure Tfrm_main.tv_mainClick(Sender: TObject);
begin
     // When User is clicking on a Item, enable the Buttons
    if (frm_main.tv_main.Selected.Index > -1) then
    begin
         frm_main.btn_getList.Enabled  := true;
         dm_main.GetList1.Enabled      := true;
    end;

     // Clear the List
    if (frm_main.tv_main.Selected.Index <> cls_globals.m_iLastSelectedAccount) then
    begin
        // Disconnect from Server
        if (dm_main.pop3_indy.Connected) then
            dm_main.pop3_indy.Disconnect;

        // Set GUI
        cls_globals.m_iLastSelectedAccount := frm_main.tv_main.Selected.Index;
        frm_main.lv_main.Items.Clear;
        frm_main.btn_deletemails.Enabled   := False;
        sb_main.Panels.Items[1].Text       := '';
    end;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
     // Disable the Buttons
    frm_main.btn_getList.Enabled       := false;
    dm_main.GetList1.Enabled           := false;
    frm_main.btn_deletemails.Enabled   := false;
    frm_main.btn_markall.Enabled       := false;
end;

procedure Tfrm_main.lv_mainClick(Sender: TObject);
var
   iCounter: integer;
begin
     // When User klicks on a Listelement
     // free the 'Delete' Button
    for iCounter := 1 to cls_globals.m_NumberMsg do
    begin
         if (frm_main.lv_main.Items[iCounter-1].Checked) then
         begin
              frm_main.btn_deletemails.Enabled := True;
              Exit;
         end;
    end;
    frm_main.btn_deletemails.Enabled := false;

end;

procedure Tfrm_main.lv_mainDblClick(Sender: TObject);
begin
     // When a entry is double-clicked, show it on a new Form
    if (frm_main.lv_main.Selected <> nil) then
    begin

         // hide Form
         frm_mail.hide;

         // Set the Buttons
         frm_main.btn_getList.Enabled     := false;
         frm_main.btn_deletemails.Enabled := false;
         dm_main.GetList1.Enabled         := false;

         // Setting Transfer Window
         frm_transfer.show;
         frm_transfer.pgb_overall.Tag      := cls_globals.m_NumberMsg;
         frm_transfer.pgb_overall.Position := 0;
         frm_transfer.lbl_overall.Caption  := cls_globals.translate( 'recmail' );
         Application.ProcessMessages;

         // Retrieve selected Message
         dm_main.mail_message.Clear;
         dm_main.mail_message.MessageParts.Clear;
         Application.ProcessMessages;

         try
             cls_globals.m_iMessageBytes := dm_main.pop3_indy.RetrieveMsgSize(cls_globals.m_NumberMsg - (frm_main.lv_main.Selected.Index));
         except
             cls_globals.m_iMessageBytes := 0;
         end;

         dm_main.pop3_indy.Retrieve(cls_globals.m_NumberMsg - (frm_main.lv_main.Selected.Index),dm_main.mail_message);
         frm_transfer.lbl_overall.Caption  := '';
         Application.ProcessMessages;

         // Hide transfer Window
         frm_transfer.hide;

         // Call show Mail Method
         cls_globals.showMail;
    end;
end;

procedure Tfrm_main.tv_mainDblClick(Sender: TObject);
begin
     // Double-clikcing on TreeView raises a "GetList"
    if (frm_main.tv_main.Selected <> nil) then
        frm_main.btn_getlistClick(self);

end;

procedure Tfrm_main.Button1Click(Sender: TObject);
begin
     frm_mail.show;
end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // Save Window Size
    cls_globals.saveWindowPosition(self,frm_main.WindowState,frm_main.Top,frm_main.Left,frm_main.Height,frm_main.Width);

end;

procedure Tfrm_main.btn_deletemailsClick(Sender: TObject);
var
   iResult      : Integer;
   iCounter     : Integer;
   bWasChecked  : boolean;
begin
     // When clicking on the delte button, warn user with
     // a dialog box if he really want to kill all selected
     // emails in the list.
     // After confirming with yes, kill´em´all
    iResult := MessageDlg( cls_globals.translate('DelWarn1') +#13+#10+
                           cls_globals.translate('DelWarn2'),
                           mtConfirmation, [mbYes, mbNo], 0);

    if (iResult = IDNO) then
        exit          // User has said "No", exit this procedure

    else begin
        // User said "Yes", beginn to kill all selected eMails
        frm_transfer.show;
        frm_transfer.pgb_overall.Position := 0;
        frm_transfer.lbl_overall.Caption  := cls_globals.translate( 'WaitForConnect');
        Application.ProcessMessages;

        bWasChecked                        := false;
        frm_transfer.pgb_overall.Tag       := cls_globals.m_NumberMsg;

        for iCounter := 1 to cls_globals.m_NumberMsg do
        begin
            if (frm_main.lv_main.Items[iCounter-1].Checked) then
            begin
                 frm_transfer.lbl_overall.Caption  := cls_globals.translate('Killing') + ' ' + IntToStr(cls_globals.m_NumberMsg - (iCounter-1));
                 dm_main.pop3_indy.Delete(cls_globals.m_NumberMsg - (iCounter-1));
                 bWasChecked := true;
                 Application.ProcessMessages;
            end;
        end;

        dm_main.pop3_indy.Disconnect;
        Application.ProcessMessages;

        // Hide Transfer Window
        frm_transfer.Hide;

        // Wait a while for server to process command
        // Do not set this 0, for this could list mails,
        // that are really deleted
        // min time ist 450, best ist 750
        // Maybe, you could make an option for this, for
        // modem users do not have this problem, but DSL users
        // Maybe, Modem users can change this to 0, i have never
        // tried it ...
        sleep(750);
        Application.ProcessMessages;

        // Show New List
        if (bWasChecked) then
          frm_main.btn_getlistClick(self)

    end;
end;

procedure Tfrm_main.btn_firewallClick(Sender: TObject);
begin
    dm_main.General1Click(self);
end;

procedure Tfrm_main.btn_accountsClick(Sender: TObject);
begin
    dm_main.Accounts1Click(self);    
end;

procedure Tfrm_main.btn_languageClick(Sender: TObject);
begin
    dm_main.Language1Click(self);
end;

procedure Tfrm_main.btn_markallClick(Sender: TObject);
var
    tmpcounter: integer;
begin
    // Mark all Mails for deletion
    for tmpcounter := 0 to frm_main.lv_main.Items.Count-1 do
    begin
        frm_main.lv_main.Items[tmpcounter].Checked := true;
        Application.ProcessMessages;
    end;
    frm_main.btn_deletemails.Enabled := true;
end;

procedure Tfrm_main.FormPaint(Sender: TObject);
begin
    if iNoRes < 1 then
    begin
        iNoRes := 1;
        cls_globals.loadWindowPosition(self);
    end;
end;

end.
