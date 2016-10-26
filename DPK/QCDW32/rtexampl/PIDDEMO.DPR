program Piddemo;

uses
  Forms,
  Piddemou in 'PIDDEMOU.PAS' {PIDForm},
  Piddemox in 'PIDDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TPIDForm, PIDForm);
  Application.Run;
end.
