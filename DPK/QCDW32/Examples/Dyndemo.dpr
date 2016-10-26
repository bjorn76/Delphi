program Dyndemo;

uses
  Forms,
  Dyndemou in 'DYNDEMOU.PAS' {DynDemoForm},
  Dyndemox in 'DYNDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TDynDemoForm, DynDemoForm);
  Application.Run;
end.
