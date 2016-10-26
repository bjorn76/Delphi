program Xyplot;

uses
  Forms,
  Xyplotx in 'XYPLOTX.PAS',
  Xyplotu in 'XYPLOTU.PAS' {XYPlotForm};

{$R *.RES}

begin
  Application.CreateForm(TXYPlotForm, XYPlotForm);
  Application.Run;
end.
