program jamt;

uses
  Forms,
  unt_main in 'unt_main.pas' {frm_main},
  unt_dmmain in 'unt_dmmain.pas' {dm_main: TDataModule},
  unt_info in 'unt_info.pas' {frm_info},
  unt_globals in 'unt_globals.pas',
  unt_mail in 'unt_mail.pas' {frm_mail},
  unt_options in 'unt_options.pas' {frm_options},
  unt_transfer in 'unt_transfer.pas' {frm_transfer},
  unt_splash in 'unt_splash.pas' {frm_splash},
  unt_filter in 'unt_filter.pas' {frmFilter};

{$R *.RES}

begin

  frm_splash      := Tfrm_splash.Create(Application);
  frm_splash.Show;
  frm_splash.Update;

  Application.Initialize;
  Application.Title := 'Just another eMail Tool';

  Application.CreateForm(Tfrm_main, frm_main);
  Application.CreateForm(Tdm_main, dm_main);
  Application.CreateForm(Tfrm_info, frm_info);
  Application.CreateForm(Tfrm_mail, frm_mail);
  Application.CreateForm(Tfrm_options, frm_options);
  Application.CreateForm(Tfrm_transfer, frm_transfer);
  Application.CreateForm(TfrmFilter, frmFilter);

  frm_splash.Hide;
  frm_splash.Free;
  Application.Run;
end.
