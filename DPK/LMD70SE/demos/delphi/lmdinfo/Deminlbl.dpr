program Deminlbl;

uses
  Forms,
  Frminfo5 in 'FRMINFO5.PAS' {lmdinfoForm};

{$R *.RES}

begin
  Application.CreateForm(TlmdinfoForm, lmdinfoForm);
  Application.Run;
end.
