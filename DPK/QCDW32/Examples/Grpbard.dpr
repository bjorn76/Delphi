program Grpbard;

uses
  Forms,
  Grpbardu in 'GRPBARDU.PAS' {GrpBardForm},
  Grpbardx in 'GRPBARDX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TGrpBardForm, GrpBardForm);
  Application.Run;
end.
