program Lmdstart;

uses
  Forms,
  Starter0 in 'STARTER0.PAS' {frmjumpdemo};

{$R *.RES}

begin
  Application.Title := 'SimpleLabel';
  Application.CreateForm(Tfrmjumpdemo, frmjumpdemo);
  Application.Run;
end.
