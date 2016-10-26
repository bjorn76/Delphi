program Metademo;

uses
  Forms,
  Metademu in 'METADEMU.PAS' {MetaDemoForm},
  Metademx in 'METADEMX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TMetaDemoForm, MetaDemoForm);
  Application.Run;
end.
