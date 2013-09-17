unit unt_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdvPicture;

type
  Tfrm_info = class(TForm)
    lbl_email: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    lbl_linktohomepage: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btn_info_close: TBitBtn;
    lbl_sourceforgelink: TLabel;
    AdvPicture1: TAdvPicture;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    AdvPicture2: TAdvPicture;
    Label11: TLabel;
    procedure lbl_emailClick(Sender: TObject);
    procedure lbl_linktohomepageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_info_closeClick(Sender: TObject);
    procedure lbl_sourceforgelinkClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    
  end;

var
  frm_info: Tfrm_info;

implementation

uses unt_main, unt_dmmain, unt_globals;

{$R *.DFM}

procedure Tfrm_info.lbl_emailClick(Sender: TObject);
begin
    cls_globals.labellink(self,'mailto:sascha@techcrawler.de');
end;

procedure Tfrm_info.lbl_linktohomepageClick(Sender: TObject);
begin
    cls_globals.labellink(self,'http://www.techcrawler.de/jamt');
end;

procedure Tfrm_info.FormShow(Sender: TObject);
begin
     // Translate
        btn_info_close.Caption := cls_globals.translate( 'Ok' );

     // Show Version
        if (Trim(AppComment) = '') then
            Label1.Caption    := 'Version '+AppVersion
        else
            Label1.Caption    := 'Version '+AppVersion + ' ('+AppComment+')';

     // Exit this function
        exit;

end;

procedure Tfrm_info.btn_info_closeClick(Sender: TObject);
begin
     frm_info.Close;
end;

procedure Tfrm_info.lbl_sourceforgelinkClick(Sender: TObject);
begin
    cls_globals.labellink(self,'http://sourceforge.net/projects/jamt/');
end;

procedure Tfrm_info.Label6Click(Sender: TObject);
begin
    cls_globals.labellink(self,'http://www.amazon.de/exec/obidos/registry/2RIB846BT4F7D/028-5390020-6643716');
end;

procedure Tfrm_info.Label3Click(Sender: TObject);
begin
    cls_globals.labellink(self,'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=payments%40techcrawler%2ede&no_shipping=0&no_note=1&tax=0&currency_code=EUR&lc=DE&bn=PP%2dDonationsBF&charset=UTF%2d8');
end;

end.
