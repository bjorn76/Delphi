program Scbardem;

uses
  Forms,
  Scbardeu in 'SCBARDEU.PAS' {ScrollBarForm},
  Scbardex in 'SCBARDEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TScrollBarForm, ScrollBarForm);
  Application.Run;
end.
