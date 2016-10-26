program Scada;

uses
  Forms,
  Scadau in 'SCADAU.PAS' {ScadaForm},
  Scadax in 'SCADAX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TScadaForm, ScadaForm);
  Application.Run;
end.
