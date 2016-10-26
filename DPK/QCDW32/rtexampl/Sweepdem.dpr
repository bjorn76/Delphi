program Sweepdem;

uses
  Forms,
  Sweepdeu in 'SWEEPDEU.PAS' {SweepForm1},
  Sweepdex in 'SWEEPDEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TSweepForm1, SweepForm1);
  Application.Run;
end.
