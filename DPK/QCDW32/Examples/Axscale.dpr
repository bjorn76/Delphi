program Axscale;

uses
  Forms,
  Axscaleu in 'AXSCALEU.PAS' {AxScaleForm},
  Axscalex in 'AXSCALEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TAxScaleForm, AxScaleForm);
  Application.Run;
end.
