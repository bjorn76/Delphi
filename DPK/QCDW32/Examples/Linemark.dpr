program Linemark;

uses
  Forms,
  Linemaru in 'LINEMARU.PAS' {LineMarkForm},
  Linemarx in 'LINEMARX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TLineMarkForm, LineMarkForm);
  Application.Run;
end.
