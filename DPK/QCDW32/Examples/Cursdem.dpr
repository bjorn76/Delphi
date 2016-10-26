program Cursdem;

uses
  Forms,
  Cursdemu in 'CURSDEMU.PAS' {CursorForm},
  cursdemx in 'CURSDEMX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TCursorForm, CursorForm);
  Application.Run;
end.
