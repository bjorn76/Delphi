program Nmeter;

uses
  Forms,
  Nmeteru in 'NMETERU.PAS' {nMeterForm},
  Nmeterx in 'NMETERX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TnMeterForm, nMeterForm);
  Application.Run;
end.
