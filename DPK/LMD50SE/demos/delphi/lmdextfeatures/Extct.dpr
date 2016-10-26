program Extct;

uses
  Forms,
  Lmddeex0 in 'LMDDEEX0.PAS' {frmextct};

{$R *.RES}

begin
  Application.Title := 'Extented Features Example';
  Application.CreateForm(Tfrmextct, frmextct);
  Application.Run;
end.
