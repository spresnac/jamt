unit unt_transfer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, AdvProgressBar;

type
  Tfrm_transfer = class(TForm)
    lbl_overall: TLabel;
    btn_cancel: TSpeedButton;
    pgb_overall: TAdvProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_transfer: Tfrm_transfer;

implementation

uses unt_globals, unt_dmmain;

{$R *.DFM}

procedure Tfrm_transfer.FormShow(Sender: TObject);
begin
     // Translate
     frm_transfer.btn_cancel.Caption := cls_globals.translate( 'Cancel' );

     // Exit this function
     Exit;

end;

procedure Tfrm_transfer.btn_cancelClick(Sender: TObject);
begin
     // Close open connections
     if (dm_main.pop3_indy.Connected) then
        dm_main.pop3_indy.Disconnect;

     // Hide window
     frm_transfer.Close;
end;

end.
