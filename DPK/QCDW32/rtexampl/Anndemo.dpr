program Anndemo;

uses
  Forms,
  Anndemou in 'ANNDEMOU.PAS' {Form1},
  Anndemox in 'ANNDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TAnnDemoForm, AnnDemoForm);
  Application.Run;
end.
