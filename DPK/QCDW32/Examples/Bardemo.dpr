program Bardemo;

uses
  Forms,
  Bardemou in 'BARDEMOU.PAS' {BarDemoForm},
  Bardemox in 'BARDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TBarDemoForm, BarDemoForm);
  Application.Run;
end.
