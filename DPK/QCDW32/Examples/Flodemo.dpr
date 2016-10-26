program Flodemo;

uses
  Forms,
  Flodemou in 'FLODEMOU.PAS' {FloDemoForm},
  Flodemox in 'FLODEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TFloDemoForm, FloDemoForm);
  Application.Run;
end.
