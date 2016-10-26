program Fetalmon;

uses
  Forms,
  Fetalmou in 'FETALMOU.PAS' {FMForm},
  Fetalmox in 'FETALMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TFMForm, FMForm);
  Application.Run;
end.
