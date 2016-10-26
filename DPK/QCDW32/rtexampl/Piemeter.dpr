program Piemeter;

uses
  Forms,
  Piemeteu in 'PIEMETEU.PAS' {PieMeterForm},
  Piemetex in 'PIEMETEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TPieMeterForm, PieMeterForm);
  Application.Run;
end.
