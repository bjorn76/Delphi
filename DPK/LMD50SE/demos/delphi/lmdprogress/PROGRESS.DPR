program Progress;

uses
  Forms,
  Lmddepr0 in 'LMDDEPR0.PAS' {frmprg};

{$R *.RES}

begin
  Application.CreateForm(Tfrmprg, frmprg);
  Application.Run;
end.
