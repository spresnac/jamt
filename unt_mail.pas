unit unt_mail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ShellAPI, ComCtrls, ExtCtrls, ToolWin, Menus, Printers;

type
  Tfrm_mail = class(TForm)
    lv_attachment: TListView;
    lbl_attachmentnote: TLabel;
    lbl_attachlist: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    pnl_header: TPanel;
    pnl_labels: TPanel;
    lbl_subject: TLabel;
    lbl_date: TLabel;
    lbl_cc: TLabel;
    lbl_to: TLabel;
    lbl_from: TLabel;
    pnl_fields: TPanel;
    mmo_body: TMemo;
    pd_mail: TPrintDialog;
    lbl_mail_from: TLabel;
    lbl_mail_to: TLabel;
    lbl_mail_cc: TLabel;
    lbl_mail_date: TLabel;
    lbl_mail_subject: TLabel;
    procedure lv_attachmentDblClick(Sender: TObject);
    procedure lbl_attachmentnoteDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_mail: Tfrm_mail;

implementation

uses unt_globals, unt_main, unt_dmmain;

{$R *.DFM}

procedure Tfrm_mail.lv_attachmentDblClick(Sender: TObject);
var
   iOpenReturn:Integer;
begin
    // When clicking, select the Item and open with default Handler
    if (frm_mail.lv_attachment.Selected <> nil) then
    begin
         iOpenReturn :=  ShellExecute( Application.Handle,
                                       'open',
                                       PChar(ExtractFilePath(Application.ExeName) + 'attach\' + frm_mail.lv_attachment.Selected.SubItems.Strings[0]),
                                       nil,
                                       PChar(ExtractFilePath(Application.ExeName) + 'attach'),
                                       0);
         if (iOpenReturn < 33) then
         begin
              MessageDlg( 'Document could not be opened...'+#13+#10+
                          'Errorcode: ' + IntToStr(iOpenReturn),
                          mtError,
                          [mbOK],
                          0);
         end;
    end;
end;

procedure Tfrm_mail.lbl_attachmentnoteDblClick(Sender: TObject);
begin
    // Open Attachment Folder
    ShellExecute( Application.Handle,
                  'explore',
                  PChar(ExtractFilePath( Application.ExeName) + 'attach\'),
                  nil,
                  nil,
                  SW_ShowNormal);

end;

procedure Tfrm_mail.FormShow(Sender: TObject);
begin
    // Translate
    lbl_from.Caption              := cls_globals.translate( 'From' );
    lbl_to.Caption                := cls_globals.translate( 'To' );
    lbl_cc.Caption                := cls_globals.translate( 'CC' );
    lbl_date.Caption              := cls_globals.translate( 'Date' );
    lbl_subject.Caption           := cls_globals.translate( 'subject' );
    lbl_attachlist.Caption        := cls_globals.translate( 'attachlist' );
    lbl_attachmentnote.Caption    := cls_globals.translate( 'attachnote' );
end;

end.

