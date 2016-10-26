program Hlcdemo;

uses
  Forms,
  Hlcdemou in 'HLCDEMOU.PAS' {HLCForm},
  Hlcdemox in 'HLCDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(THLCForm, HLCForm);
  Application.Run;
end.
