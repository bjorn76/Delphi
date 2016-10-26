program shapedem;

uses
  Forms,
  LMDDESP0 in 'LMDDESP0.PAS' {frmshape};

{$R *.RES}

begin
  Application.Title := 'LMD Shape Controls';
  Application.CreateForm(Tfrmshape, frmshape);
  Application.Run;
end.
