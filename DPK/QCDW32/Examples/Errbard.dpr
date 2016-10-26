program Errbard;

uses
  Forms,
  Errbardu in 'ERRBARDU.PAS' {ErrBarForm},
  Errbardx in 'ERRBARDX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TErrBarForm, ErrBarForm);
  Application.Run;
end.
