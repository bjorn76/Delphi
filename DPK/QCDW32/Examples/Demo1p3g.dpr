program Demo1p3g;

uses
  Forms,
  Dem1p3gu in 'DEM1P3GU.PAS' {Demo1P3GForm},
  Dem1p3gx in 'DEM1P3GX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TDemo1P3GForm, Demo1P3GForm);
  Application.Run;
end.
