unit unt_splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfrm_splash = class(TForm)
    img_splash: TImage;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_splash: Tfrm_splash;

implementation

{$R *.DFM}

end.
