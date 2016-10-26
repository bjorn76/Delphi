program Timeaxis;

uses
  Forms,
  Timeaxiu in 'TIMEAXIU.PAS' {TimeAxisForm},
  Timeaxix in 'TIMEAXIX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TTimeAxisForm, TimeAxisForm);
  Application.Run;
end.
