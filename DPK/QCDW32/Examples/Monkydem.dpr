program Monkydem;

uses
  Forms,
  Monkeydu in 'MONKEYDU.PAS' {MonkeyForm},
  Monkeydx in 'MONKEYDX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TMonkeyForm, MonkeyForm);
  Application.Run;
end.
