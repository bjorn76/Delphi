program Piechart;

uses
  Forms,
  Piecharu in 'PIECHARU.PAS' {PieChartForm},
  Piecharx in 'PIECHARX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TPieChartForm, PieChartForm);
  Application.Run;
end.
