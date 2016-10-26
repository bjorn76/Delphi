program Stackdem;

uses
  Forms,
  Stackdeu in 'STACKDEU.PAS' {StackDemoFrm},
  Stackdex in 'STACKDEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TStackDemoFrm, StackDemoFrm);
  Application.Run;
end.
