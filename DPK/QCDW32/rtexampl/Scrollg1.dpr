program Scrollg1;

uses
  Forms,
  Scrollgu in 'SCROLLGU.PAS' {ScrollG1Form},
  Scrollgx in 'SCROLLGX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TScrollG1Form, ScrollG1Form);
  Application.Run;
end.
