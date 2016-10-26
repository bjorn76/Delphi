program Demo3p1g;

uses
  Forms,
  Dem3p1gu in 'DEM3P1GU.PAS' {Demo3P1GForm},
  Dem3p1gx in 'DEM3P1GX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TDemo3P1GForm, Demo3P1GForm);
  Application.Run;
end.
